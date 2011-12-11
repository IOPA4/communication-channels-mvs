unit HAYESExchange;

interface

uses
  Windows,
  SysUtils,
  HAYESSettings,
  HAYESConstants;
//------------------------------------------------------------------------------
type
    TModemContext = record
      IsATampC1Accepted: Boolean;
      IsATampS1Accepted: Boolean;
      IsATX4Accepted: Boolean
    end;
//------------------------------------------------------------------------------
    TModAnsw = record
      cs:string;
      offs:Byte;
      res:TModemAnswer;

    end;

//------------------------------------------------------------------------------
    TModemManager = class
    private
      //--
      hPort:THandle;
      m_ChannelSettings:TChannelSettings;
      m_ModemContext:TModemContext;
      ara:array [0..Integer(TModemAnswer.MAS_N) - 1] of TModAnsw;

      //--
      function ModemAnswerCode(buf:PByte):TModemAnswer;
      function m_SendATCommand (Cmd:PAnsiChar; TimeOut:Integer;
        IsCheckStop:Boolean):TModemAnswer; Overload;
      function m_SendATCommand (Cmd:PAnsiChar; TimeOut:Integer):TModemAnswer; Overload;
      function m_SendATCommand (Cmd:PAnsiChar):TModemAnswer; Overload;
      //--
      function PurgeRX():Boolean;
      function WriteCOM(pBuf:PByte; Length:Integer; var Written:Integer):Boolean;
      function ReadCOM(pBuf:PByte; BytesToRead:Integer):Integer;
      //--
      function PingModem(): Boolean;
      function InitModem():Integer;
      //--
    public
        constructor Create;
        destructor Destroy;

        function InitObject(Settings:TChannelSettings):Integer;
    end;
//------------------------------------------------------------------------------


implementation
//------------------------------------------------------------------------------
constructor TModemManager.Create();
begin
    hPort := INVALID_HANDLE_VALUE;

    ara[Integer(TModemAnswer.OK)].cs            := cOK;
    ara[Integer(TModemAnswer.OK)].res           := TModemAnswer.OK;

    ara[Integer(TModemAnswer.CONNECT)].cs       := cCONNECT;
    ara[Integer(TModemAnswer.CONNECT)].res      := TModemAnswer.CONNECT;

    ara[Integer(TModemAnswer.RING)].cs          := cRING;
    ara[Integer(TModemAnswer.RING)].res         := TModemAnswer.RING;

    ara[Integer(TModemAnswer.NO_CARRIER)].cs    := cNO_CARRIER;
    ara[Integer(TModemAnswer.NO_CARRIER)].res   := TModemAnswer.NO_CARRIER;

    ara[Integer(TModemAnswer.ERROR)].cs         := cERROR;
    ara[Integer(TModemAnswer.ERROR)].res        := TModemAnswer.ERROR;

    ara[Integer(TModemAnswer.NO_DIALTONE)].cs   := cNO_DIALTONE;
    ara[Integer(TModemAnswer.NO_DIALTONE)].res  := TModemAnswer.NO_DIALTONE;

    ara[Integer(TModemAnswer.BUSY)].cs          := cBUSY;
    ara[Integer(TModemAnswer.BUSY)].res         := TModemAnswer.BUSY;

    ara[Integer(TModemAnswer.NO_ANSWER)].cs     := cNO_ANSWER;
    ara[Integer(TModemAnswer.NO_ANSWER)].res    := TModemAnswer.NO_ANSWER;
end;

//------------------------------------------------------------------------------
function TModemManager.InitObject(Settings:TChannelSettings):Integer;
begin
 Result := RET_OK;
 m_ChannelSettings := Settings;
 try
   hPort := CreateFile(PWideChar(m_ChannelSettings.ComNumber), GENERIC_READ or
     GENERIC_WRITE, 0, nil,	OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or
     FILE_FLAG_OVERLAPPED,0);

   if hPort = INVALID_HANDLE_VALUE then
    Result :=  RET_ERR;
 except
   hPort := INVALID_HANDLE_VALUE;
   Result := RET_ERR;
 end;
end;

//------------------------------------------------------------------------------
function TModemManager.WriteCOM(pBuf:PByte; Length:Integer; var Written:Integer):Boolean;
var
 w:Integer;
 pW :Cardinal;
begin
   Written := 0;
   Result := False;
   pW := Cardinal(@w);
   repeat
       pBuf := pBuf + Written;
       if (WriteFile(hPort, pBuf, Length - Written, pW, Nil) = False)  then
        begin
          Result := False;
          Exit;
        end;

        Written := Written + w;

   until(Written < Length);
end;

//------------------------------------------------------------------------------
function TModemManager.ReadCOM(pBuf:PByte; BytesToRead:Integer):Integer;
var
  r:Integer;
  pR:Cardinal;
begin
    Result := RET_ERR;
    pR := Cardinal(@r);
    if (ReadFile(hPort, pBuf, BytesToRead, pR, Nil) = false) then
    begin
          Result := RET_ERR;
    end else
          Result := RET_OK;
end;

//------------------------------------------------------------------------------
destructor TModemManager.Destroy;
begin

end;

//------------------------------------------------------------------------------
function TModemManager.PurgeRX():Boolean ;
begin

   Assert(hPort <> INVALID_HANDLE_VALUE, 'Дескриптор COM порта не существует');
   Result := PurgeComm(hPort, PURGE_RXCLEAR);
end;

//------------------------------------------------------------------------------
function TModemManager.ModemAnswerCode(buf:PByte):TModemAnswer;
var
  i:Integer;
  ps:PAnsiChar;
begin

   Result := TModemAnswer.MAS_N;
   ps := PAnsiChar(buf);
   for i := 0 to Integer(TModemAnswer.MAS_N) - 1 do
   begin
     if AnsiCompareText(String(ps), ara[i].cs) = 0 then
     begin
        Result := ara[i].res;
        Exit;
     end;
   end;

end;

//------------------------------------------------------------------------------
function TModemManager.m_SendATCommand (Cmd:PAnsiChar; TimeOut:Integer;
          IsCheckStop:Boolean):TModemAnswer;
type
  TState = (
    STS_READING = 0,
    STS_0D_RECVED,
    STS_0A_RECVED
  );
var
  Written:Integer;
  CommandLen:Integer;
  buf: array [0..MAX_RESP_LENGTH - 1] of Byte;
  rd, r: Integer;
  Tics:Cardinal;
  State: TState;
  MA:TModemAnswer;
begin

  Result := TModemAnswer.MAS_N;
  rd := 0;

  //пауза между АТ-командами
  //нужна для D-Link'а, иначе он перестает отвечать
  Sleep(10);
  PurgeRX();

  CommandLen := Integer(StrLen(Cmd));
  Assert(CommandLen > 0, 'm_SendATCommand: Некорректная AT - команда');

  if CommandLen > 0 then
  begin
      if ( WriteCOM(PByte(Cmd), CommandLen, Written) = False) then
      begin
          Result := TModemAnswer.MAS_N;   //ошибка
          Exit;
      end;
      //цикл сбора пакета ответа от модема
      State := TState.STS_READING;

      Tics := GetTickCount(); //Кол- во "тиков". Нужно для отсчета времени
      repeat

          if (ReadCOM(@buf[rd], 1) = RET_ERR) then
          begin
            Sleep(0);//Отказаться от этого кванта ЦП
			      continue;
          end;

          case State of

               TState.STS_READING:
                begin
                  if buf[rd] = $0D then
                    State := TState.STS_0D_RECVED;
                  rd := rd + 1;
                end;

               TState.STS_0D_RECVED:
               begin
                  if buf[rd] = $0A then
                  begin
                     State := TState.STS_0A_RECVED;
                     rd := rd + 1;
                  end else
                  begin
                    ZeroMemory(@buf[0], rd);
                    rd := 0;
                    State := TState.STS_READING;
                  end;
               end;

                TState.STS_0A_RECVED:
                begin
                  MA := ModemAnswerCode(@buf[0]);
                  if MA <> TModemAnswer.MAS_N then
                  begin
                    Result := MA
                  end else
                    begin
                      ZeroMemory(@buf[0], rd);
                      rd := 0;
                      State := TState.STS_READING;
                    end;
                end;
          end;
       until ((GetTickCount() - Tics < TimeOut) and (rd < MAX_RESP_LENGTH));
  end;


end;

//------------------------------------------------------------------------------
function TModemManager.m_SendATCommand (Cmd:PAnsiChar):TModemAnswer;
begin
    Result := m_SendATCommand (Cmd, MODEM_ANSWER_TIMEOUT, False);
end;

//------------------------------------------------------------------------------
function TModemManager.m_SendATCommand (Cmd:PAnsiChar; TimeOut:Integer):TModemAnswer;
begin
       Result := m_SendATCommand (Cmd, TimeOut, False);
end;
//------------------------------------------------------------------------------
function TModemManager.PingModem(): Boolean;
begin
  Result := False;
	if (m_SendATCommand(AT, 100) = TModemAnswer.OK) then
  begin
		//кладем трубку
		if (m_SendATCommand(ATH0, MODEM_ANSWER_TIMEOUT * 3) = TModemAnswer.OK) then
    begin
			Result := True;
      Exit;
    end;
  end;
  //TO DO ResetDTR();
	//возможно, модем игнорирует DTR
	m_SendATCommand(PlPlPl, 3100);

	//кладем трубку
	m_SendATCommand(ATH0, MODEM_ANSWER_TIMEOUT * 3);

	//включаем ответ
	m_SendATCommand(ATQ0);

	//ответ - текстом
	m_SendATCommand(ATV1);

	if (m_SendATCommand(AT, 500) = TModemAnswer.OK) then
  begin
			Result := True;
      Exit;
  end;

end;

//------------------------------------------------------------------------------
function TModemManager.InitModem():Integer;
begin

  if PingModem = False then
  begin
     Result := RET_ERR;
     Exit;
  end;

  m_SendATCommand(ATH0, MODEM_ANSWER_TIMEOUT * 3);
  //сбрасываем модем в заводские настройки
	m_SendATCommand(ATampF);

  //выключаем эхо
	m_SendATCommand(ATE0);

	//выключаем сообщения о скорости и т.п. при коннекте
	m_SendATCommand(ATplMR0);
	m_SendATCommand(ATplER0);
	m_SendATCommand(ATplDR0);


  //включаем динамик
  m_SendATCommand(ATM1);
//
  //ждать/не ждать гудка, определять "занято"
 if (m_ChannelSettings.IsWaitTone = True) then
  begin
    m_ModemContext.IsATX4Accepted := (m_SendATCommand(ATX4) = TModemAnswer.OK);
  end else
	begin
		m_SendATCommand(ATX3);
		//пауза перед слепым дозвоном 2 cек (recommended by V.250)
		//TODO: должно настраиваться
		m_SendATCommand('ATS6=2');
	end;

  //ожидание ответа
  //ATS           = 'ATS%d=%d\x0D';
  m_SendATCommand(PAnsiChar('ATS7=2' + IntToStr(m_ChannelSettings.TimeOuts)));

  //TO DO
  //класть трубку по DTR
//	if (!g_Settings.m_IsNonFullCable)
end;
//------------------------------------------------------------------------------
end.
