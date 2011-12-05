unit Ethernet_exchange;

interface

uses

  Windows,
  winsock;

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

    public

      constructor Create();
      destructor  Destroy;

      function SetServerParametrs(IPAdress:string; Port:Integer):Integer;
      function Open():Integer;
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

//-----------------------------------------------------------------------------
implementation

constructor TClientSocketWorker.Create();
begin

    WSAStartUp(MakeWord(2,0),m_WSAData);
    m_ServerAddress.sin_family := AF_INET;
    m_Socket := INVALID_SOCKET;

    m_State := False;

end;

//-------------------------------------------------
Destructor  TClientSocketWorker.Destroy;
Begin
  try

    if m_Socket <> INVALID_SOCKET then
    begin
      closesocket(m_Socket);
      m_Socket := INVALID_SOCKET;
    end;

    WSACleanup();

  finally
      m_Active := False;
      m_State := False;
  end;
End;

//-------------------------------------------------


function TClientSocketWorker.SetServerParametrs(IPAdress:string;
  Port:Integer):Integer;
  var
  InAddr:TInAddr;
Begin

   InAddr.S_addr := inet_addr(PAnsiChar(IPAdress));
   m_ServerAddress.sin_addr := InAddr;
   m_ServerAddress.sin_port := htons(Port);

End;

function TClientSocketWorker.Open():Integer;
Begin
    Result := RET_ERR;

    if m_Socket <> INVALID_SOCKET then
      begin
       //усли переменная содержит адрес сокета, то перед открытием нового,
       //старый нужно попытаться закрыть
         closesocket(m_Socket);
         m_Socket := INVALID_SOCKET
      end;

    m_Socket:=socket(AF_INET,SOCK_STREAM,0);

    if m_Socket = INVALID_SOCKET then
    begin
      Result := RET_ERR;
    end else
    begin
      if connect(m_Socket, m_ServerAddress, sizeof(m_ServerAddress)) = 0 then
        Result := RET_OK;
    end;
End;

 function TClientSocketWorker.Close():Integer;
Begin

   Result := RET_ERR;

   if m_Socket <> INVALID_SOCKET then
   begin
      if closesocket(m_Socket) <> SOCKET_ERROR then
      begin
        m_Socket := INVALID_SOCKET;
        Result := RET_OK;
      end;
   end;

End;

function TClientSocketWorker.WriteBlock(pBlock:Pointer; BlockSize:Word):Integer;
Begin

   Result := RET_ERR;

   if m_Socket <> INVALID_SOCKET then
   begin
     if send(m_Socket, pBlock, BlockSize ,0) <> SOCKET_ERROR then
        Result := RET_OK;
   end;

End;

function TClientSocketWorker.ReadBlock(pBlock:Pointer; var Count:Word;
  MaxBlockSize:Word):Integer;
Begin
   Result := RET_ERR;

   if m_Socket <> INVALID_SOCKET then
   begin
     Count := Recv(m_Socket, pBlock, MaxBlockSize,0);
   end;
End;

function TClientSocketWorker.IsActive():Boolean;
Begin
   Result := False;

   if m_Socket <> INVALID_SOCKET then
   begin
    Result := True;
   end;

End;

end.
