unit Ethernet_exchange;

interface

uses
  uLog,
  SyncObjs,
  SysUtils,
  Windows,
  Winsock,
  EthernetSettings,
  EthernetConstants;

type

  TSocketLastError = record
    Text:string;
    Code:Integer;
  end;

  TClientSocketWorker = class
    private
      m_Socket: TSocket;
      m_ServerAddress:TSockAddr;
      m_WSAData:TWSAData;

      m_Active:Boolean;
      m_State: Boolean;
      m_Settings:TChannelSettings;

      m_Buf:array[0..BUF_MAX_LEN] of Byte;
      m_LastBlockSize:Integer;

      m_csExchenge:TCriticalSection;
      procedure TryClose();

    public

      constructor Create();
      destructor  Destroy;

      function SetServerParametrs(IPAdress:string; Port:Integer):Integer;
      function Open(Settings:TChannelSettings):Integer;
      function Close():Integer;

      function WriteBlock(pBlock:Pointer; BlockSize:Word):Integer;
      function ReadBlock(pBlock:Pointer; var Count:Word; MaxBlockSize:Word):Integer;
      function IsActive():Boolean;

  end;
var
  SocketWorker:TClientSocketWorker;
const
  RET_OK = 0;
  RET_ERR = $FF;

  TCP_PORT_MIN_VALUE = $1;
  TCP_PORT_MAX_VALUE =  $65535;

//------------------------------------------------------------------------------
implementation

//------------------------------------------------------------------------------
constructor TClientSocketWorker.Create();
begin

    WSAStartUp(MakeWord(2,0),m_WSAData);
    m_ServerAddress.sin_family := AF_INET;
    m_Socket := INVALID_SOCKET;
    m_LastBlockSize := 0;
    m_csExchenge := TCriticalSection.Create;
    m_State := False;

end;

//------------------------------------------------------------------------------
Destructor  TClientSocketWorker.Destroy;
Begin
  try

    if m_Socket <> INVALID_SOCKET then
    begin
      closesocket(m_Socket);
      m_Socket := INVALID_SOCKET;
    end;

    m_csExchenge.Destroy;
    WSACleanup();

  finally
      m_Active := False;
      m_State := False;
  end;
End;

//------------------------------------------------------------------------------
procedure TClientSocketWorker.TryClose();
Begin

	shutdown(m_Socket, SD_SEND);
	closesocket(m_Socket);
	m_Socket := INVALID_SOCKET;

end;

//------------------------------------------------------------------------------
function TClientSocketWorker.SetServerParametrs(IPAdress:string;
  Port:Integer):Integer;
  var
  InAddr:TInAddr;
Begin

   InAddr.S_addr := inet_addr(PAnsiChar(AnsiString(IPAdress)));
   m_ServerAddress.sa_family := AF_INET;
   m_ServerAddress.sin_addr := InAddr;
   m_ServerAddress.sin_port := htons(Port);
   Result := RET_OK;

End;

//------------------------------------------------------------------------------
function TClientSocketWorker.Open(Settings:TChannelSettings):Integer;
var
  Block:Integer;
Begin
try
   m_csExchenge.Enter;
    Result := RET_ERR;
    //sLog ('C:\MyProgram.log','Open Begin');

    if m_Socket <> INVALID_SOCKET then
      begin
       //ѕеред открытием нового,
       //старый нужно попытатьс€ закрыть
         closesocket(m_Socket);
         m_Socket := INVALID_SOCKET
      end;

    m_Settings := Settings;
    SetServerParametrs(Settings.IP, Settings.Port);
    m_Socket:=socket(AF_INET,SOCK_STREAM,IPPROTO_TCP);

    if m_Socket = INVALID_SOCKET then
    begin
      Result := RET_ERR;
    end else
    begin
      Block := 1;
      if (ioctlsocket(m_Socket, cardinal(FIONBIO), &Block) = 0)  then
        if connect(m_Socket, m_ServerAddress, sizeof(m_ServerAddress)) <> SOCKET_ERROR then
          Result := RET_OK;
    end;

finally
    //sLog ('C:\MyProgram.log','Open End');
    m_csExchenge.Leave;
end;
End;

//------------------------------------------------------------------------------
function TClientSocketWorker.Close():Integer;
var
  Block:Integer;
Begin
try
   m_csExchenge.Enter;
   //sLog ('C:\MyProgram.log','Close Begin');
   Result := RET_ERR;

   if m_Socket <> INVALID_SOCKET then
   begin
      Block:=0;
      ioctlsocket(m_Socket, FIONBIO, &Block);
      if closesocket(m_Socket) <> SOCKET_ERROR then
      begin
        m_Socket := INVALID_SOCKET;
        Result := RET_OK;
      end;
   end;

finally
  //sLog ('C:\MyProgram.log','Close End');
  m_csExchenge.Leave;
end;

End;

//------------------------------------------------------------------------------
function TClientSocketWorker.WriteBlock(pBlock:Pointer; BlockSize:Word):Integer;
var
  i, Res,  Count :Integer;
  ttt:Byte;
  rr:array of Byte;
  ppp:Pointer;
Begin
try
   m_csExchenge.Enter;
   Result := RET_ERR;

   ZeroMemory(@m_Buf[0], m_LastBlockSize);
   m_LastBlockSize := BlockSize;

   CopyMemory(@m_Buf[0], pBlock, BlockSize);

   if m_Socket <> INVALID_SOCKET then
   begin
      Res := send(m_Socket, m_Buf[0], BlockSize ,0);
      if Res = SOCKET_ERROR then
      begin
         Result := RET_ERR;
         Exit;
      end;
    end;

 finally
    m_csExchenge.Leave;
 end;
End;

//------------------------------------------------------------------------------
function TClientSocketWorker.ReadBlock(pBlock:Pointer; var Count:Word;
  MaxBlockSize:Word):Integer;
var
 FDSet:TFDSet;
 tv:TTimeVal;
 res:Integer;

Begin
   Result := RET_ERR;
try

  //ќбеспечение потокозащищенности
   m_csExchenge.Enter;

   FD_ZERO(FDSet);
   FD_SET(m_Socket, FDSet);
   tv.tv_sec := 0;
   tv.tv_usec := 10000;	//100 ms

   ZeroMemory(@m_Buf[0], m_LastBlockSize);

   res := select(0, Nil, @FDSet, Nil, @tv); //проверка возможности чтени€

   if (res = SOCKET_ERROR) then
   begin
    Result := RET_ERR;
    Exit;
   end;

	if (res = 1) then
  begin
    //sLog ('C:\MyProgram.log','ReadBlock recv Begin');
    res := recv(m_Socket, m_Buf, Count, 0); //ѕопытка чтение€
    //sLog ('C:\MyProgram.log','ReadBlock recv End');

    if (res <> SOCKET_ERROR) and (res > 0) then
    begin
      Result := RET_OK;
      CopyMemory(pBlock, @m_Buf[0], res);
      m_LastBlockSize := res;
    end else
          if (res = SOCKET_ERROR) then
          begin
            Result := RET_ERR;
            Count := 0;
        end else
        begin
             Result := RET_OK;
             Count := 0;
        end;
  end;

finally
  m_csExchenge.Leave;
end;

End;

//------------------------------------------------------------------------------
function TClientSocketWorker.IsActive():Boolean;
Begin
   Result := False;

   if m_Socket <> INVALID_SOCKET then
   begin
    Result := True;
   end;
End;
//------------------------------------------------------------------------------
end.
