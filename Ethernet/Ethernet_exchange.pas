unit Ethernet_exchange;

interface

uses
  //Для использования модуля ScktComp нужно добавить компонент
  //\\Embarcadero\RAD Studio\7.0\bin\dclsockets70.bpl
  ScktComp;

type

  TSocketLastError = record
    Text:string;
    Code:Integer;
  end;

  TClientSocketWorker = class
    private
      m_Client_Socket:TClientSocket;
      m_Active:Boolean;
      m_State: Boolean;

    public

      constructor Create(IPAdress:string; Port:Integer);

      Destructor  Destroy;
      //события
      ///возникает при установлении соединения. Т.е. сразу после установления
      ///соединения
      procedure OnConnect(Sender: TObject;  Socket: TCustomWinSocket);

      ///возникает при установлении соединения. Отличие от OnConnect в том,
      ///что соединение еще не установлено. Обычно такие промежуточные события
      ///используются для обновления статуса;
      procedure OnConnecting(Sender: TObject; Socket: TCustomWinSocket);

      ///Возникает при закрытии сокета.
      ///Причем, закрытия как из программы, так и со строноны удаленного
      ///компьютера (либо из-за сбоя);
      procedure OnDisconnect(Sender: TObject; Socket: TCustomWinSocket);

      ///Возникает при ошибке в работе сокета.
      ///Следует отметить, что это событие не поможет отловить ошибку в момент
      ///открытия сокета (Open).
      procedure OnError(Sender: TObject; Socket: TCustomWinSocket;
                        ErrorEvent: TErrorEvent; var ErrorCode: Integer);

      ///Возникает, когда удаленный компьютер послал Нам какие-либо данные.
      // При возникновении этого события возможна обработка данных;
      procedure OnRead(Sender: TObject; Socket: TCustomWinSocket);

      ///возникает, когда Нам разрешена запись данных в сокет
      procedure OnWrite(Sender: TObject; Socket: TCustomWinSocket);

      function SetServerParametrs(IPAdress:string; Port:Integer):Integer;

      procedure Open();
      procedure Close();

      function WriteBlock(pBlock:Pointer; BlockSize:Word):Integer;
      function ReadBlock(pBlock:Pointer; var Count:Word; MaxBlockSize:Word):Integer;
      function IsActive():Boolean;



  end;
var
  m_ClientSocket:TClientSocket;

const
  RET_OK = 0;
  RET_ERR = $FF;

  TCP_PORT_MIN_VALUE = $1;
  TCP_PORT_MAX_VALUE =  $65535;

//-----------------------------------------------------------------------------
implementation

constructor TClientSocketWorker.Create(IPAdress:string; Port:Integer);
begin
  try

    //m_Client_Socket.Create(Nil);
    if (Port >= TCP_PORT_MIN_VALUE) Or (Port < TCP_PORT_MAX_VALUE) then
    begin

      m_Client_Socket.OnConnect := OnConnect;
      m_Client_Socket.OnConnecting := OnConnecting;
      m_Client_Socket.OnDisconnect := OnDisconnect;
      m_Client_Socket.OnRead := OnRead;
      m_Client_Socket.OnWrite := OnWrite;
      m_Client_Socket.OnError := OnError;

      m_ClientSocket.Address := IPAdress;
      m_ClientSocket.Port := Port;
      m_State := True;

    end
    else
       m_State := True;

  except
    m_State := False;
  end;


end;

//-------------------------------------------------
Destructor  TClientSocketWorker.Destroy;
Begin
  try
      m_Client_Socket.Destroy;

  finally
      m_Active := False;
      m_State := False;
  end;
End;

//-------------------------------------------------
//события
///возникает при установлении соединения. Т.е. сразу после установления
///соединения
procedure TClientSocketWorker.OnConnect(Sender: TObject;  Socket: TCustomWinSocket);
begin

end;

//-------------------------------------------------
///возникает при установлении соединения. Отличие от OnConnect в том,
///что соединение еще не установлено. Обычно такие промежуточные события
///используются для обновления статуса;
procedure TClientSocketWorker.OnConnecting(Sender: TObject; Socket: TCustomWinSocket);
Begin

End;

///Возникает при закрытии сокета.
///Причем, закрытия как из программы, так и со строноны удаленного
///компьютера (либо из-за сбоя);
procedure TClientSocketWorker.OnDisconnect(Sender: TObject; Socket: TCustomWinSocket);
Begin

End;

///Возникает при ошибке в работе сокета.
///Следует отметить, что это событие не поможет отловить ошибку в момент
///открытия сокета (Open).
procedure TClientSocketWorker.OnError(Sender: TObject; Socket: TCustomWinSocket;
                  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
Begin

End;

///Возникает, когда удаленный компьютер послал Нам какие-либо данные.
// При возникновении этого события возможна обработка данных;
procedure TClientSocketWorker.OnRead(Sender: TObject; Socket: TCustomWinSocket);
Begin

End;

///возникает, когда нам разрешена запись данных в сокет
procedure TClientSocketWorker.OnWrite(Sender: TObject; Socket: TCustomWinSocket);
Begin

End;

function TClientSocketWorker.SetServerParametrs(IPAdress:string; Port:Integer):Integer;
Begin

End;

procedure TClientSocketWorker.Open();
Begin

End;

procedure TClientSocketWorker.Close();
Begin

End;

function TClientSocketWorker.WriteBlock(pBlock:Pointer; BlockSize:Word):Integer;
Begin

End;

function TClientSocketWorker.ReadBlock(pBlock:Pointer; var Count:Word; MaxBlockSize:Word):Integer;
Begin

End;

function TClientSocketWorker.IsActive():Boolean;
Begin

End;


//function CreateSocket(IPAdress:string; Port:Integer):Integer;
//begin
//  Result:= RET_OK;
//  if (Port < TCP_PORT_MIN_VALUE) Or (Port > TCP_PORT_MAX_VALUE) then
//    Result := RET_ERR
//  else
//  begin
//  if m_ClientSocket.Active then //Если соединение уже установлено
//    m_ClientSocket.Close;       //то оно закрывается
//
//    m_ClientSocket.Address := IPAdress;
//    m_ClientSocket.Port := Port;
//
//    m_ClientSocket.Open;
//
//
//  end;
//
//end;

end.
