unit HAYESExchange;

interface
uses
  Windows,
  SysUtils,
  SyncObjs,
  ComPort,
  HAYESConstants,
  HAYESSettings;


//------------------------------------------------------------------------------
type

    TState = (
      STS_READING = 0,
      STS_0D_RECVED,
      STS_0A_RECVED
    );

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
      m_Buf:array[0..BUF_MAX_LEN] of Byte;
      m_LastBlockSize:Integer;
      m_csExchenge:TCriticalSection;
      //--
      function ModemAnswerCode(buf:PByte):TModemAnswer;
      function m_SendATCommand (Cmd:string; TimeOut:Integer;
        IsCheckStop:Boolean):TModemAnswer; Overload;
      function m_SendATCommand (Cmd:string; TimeOut:Integer):TModemAnswer; Overload;
      function m_SendATCommand (Cmd:string):TModemAnswer; Overload;
      //--

      function PurgeRX():Boolean;
      function WriteCOM(pBuf:PByte; Length:Integer; var Written:Integer):Boolean;
      function ReadCOM(pBuf:PByte; BytesToRead:Integer):Integer;
      //--
      function PingModem(): Boolean;
      function InitModem():Integer;
      //--
      function MakeATCommandForLowLayer(Command:string; buffer:PByteArray):Integer;
    public
        constructor Create;
        destructor Destroy;

        function InitObject(Settings:TChannelSettings):Integer;

        function Open(Settings:TChannelSettings):Integer;
        //function WriteBlock(pBlock:Pointer; BlockSize:Word):Integer;

        //function ReadBlock(pBlock:Pointer; var Count:Word; MaxBlockSize:Word):Integer;
        //function IsActive():Boolean;

    end;
//------------------------------------------------------------------------------

var
  ExchangeManager:TModemManager;
implementation
//------------------------------------------------------------------------------
constructor TModemManager.Create();
begin
    hPort := INVALID_HANDLE_VALUE;

    ComPortWorker := TComPortWorker.Create;

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
destructor TModemManager.Destroy();
begin
   ComPortWorker.Destroy;
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
function TModemManager.MakeATCommandForLowLayer(Command:string; buffer:PByteArray):Integer;
var
  tmp, i:Integer;
begin

     //ZeroMemory(@ch, sizeof(ch));

     tmp := Length(Command);
     for i := 0 to tmp - 1 do
     begin
        buffer[i] := Byte(AnsiChar(Command[i+1]));
     end;

     buffer[tmp] := $0D;
     Result := tmp + 1;
end;

//------------------------------------------------------------------------------
function TModemManager.m_SendATCommand (Cmd:string; TimeOut:Integer;
          IsCheckStop:Boolean):TModemAnswer;

var
  Written:Integer;
  CommandLen:Integer;
  buf: array [0..MAX_RESP_LENGTH - 1] of Byte;
  ATbuf:Array [1..100] of Byte;
  rd, r, Count: Integer;
  Tics:Cardinal;
  State: TState;
  MA:TModemAnswer;
begin

  Result := TModemAnswer.MAS_N;
  rd := 0;
  ZeroMemory(@ATbuf, sizeof(ATbuf));
  ZeroMemory(@buf, sizeof(buf));

  //пауза между АТ-командами
  //нужна для D-Link'а, иначе он перестает отвечать
  Sleep(10);
  ComPortWorker.PurgeRX();

  CommandLen := MakeATCommandForLowLayer(Cmd, @ATbuf);
  Assert(CommandLen > 0, 'm_SendATCommand: Некорректная AT - команда');

  if CommandLen > 0 then
  begin
      if (ComPortWorker.WriteCOM(@ATbuf, CommandLen) = RET_ERR) then
      begin
          Result := TModemAnswer.MAS_N;   //ошибка
          Exit;
      end;
      //цикл сбора пакета ответа от модема
      State := TState.STS_READING;

      Tics := GetTickCount(); //Кол- во "тиков". Нужно для отсчета времени
      repeat

          if (ComPortWorker.ReadCOM(@buf[rd], 1, Count) = RET_ERR) then
          begin
            Sleep(0);//Отказаться от этого кванта ЦП
			      continue;
          end;
           Sleep(10);
          if Count > 0 then
          begin
              case State of

                   TState.STS_READING:
                    begin
                      if buf[rd] = 13 then
                          State := TState.STS_0D_RECVED
                      else if buf[rd] <> 10 then
                         rd := rd + 1;
                    end;

                   TState.STS_0D_RECVED:
                   begin
                      if buf[rd] = 10 then
                      begin
                         buf[rd] := 0;
                         MA := ModemAnswerCode(@buf[0]);
                         if MA <> TModemAnswer.MAS_N then
                         begin
                            Result := MA;
                            Exit;//Есть ответ
                          end else
                          begin
                            ZeroMemory(@buf[0], rd);
                            rd := 0;
                            State := TState.STS_READING;
                          end;
                      end else
                          begin
                            ZeroMemory(@buf[0], rd);
                            rd := 0;
                            State := TState.STS_READING;
                          end;
                      end;
                  end;
          end;

           if rd >= MAX_RESP_LENGTH then
              Exit;//

       until ((GetTickCount() - Tics) > TimeOut);
  end;

end;

//------------------------------------------------------------------------------
function TModemManager.m_SendATCommand (Cmd:string):TModemAnswer;
begin
    Result := m_SendATCommand (Cmd, MODEM_ANSWER_TIMEOUT, False);
end;

//------------------------------------------------------------------------------
function TModemManager.m_SendATCommand (Cmd:string; TimeOut:Integer):TModemAnswer;
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
  Sleep(1020);
	m_SendATCommand(PlPlPl, 3100);

	//кладем трубку
	if (m_SendATCommand(AT, 100) = TModemAnswer.OK) then
  begin
			Result := True;
      Exit;
  end;

	//включаем ответ
	m_SendATCommand(ATQ0V1);

	if (m_SendATCommand(AT, 100) = TModemAnswer.OK) then
  begin
			Result := True;
      Exit;
  end;

end;

//------------------------------------------------------------------------------
function TModemManager.InitModem():Integer;
var
 	ATplIFC02Accepted, ATslQ2Accepted: Boolean;
begin

  if PingModem = False then
  begin
     Result := RET_ERR;
     Exit;
  end;

  //кладем трубку
  m_SendATCommand(ATH0, MODEM_ANSWER_TIMEOUT * 3);

  //включаем эхо (оно тут не нужно, но пусконаладчики пугаются)
	m_SendATCommand(ATE1);
  //сбрасываем модем в заводские настройки
 //	m_SendATCommand(ATampF);

  //включаем динамик
  m_SendATCommand(ATM1);
//
  //ждать/не ждать гудка, определять "занято"
 if (m_ChannelSettings.IsWaitTone = True) then
  begin

    m_ModemContext.IsATX4Accepted := False;
    if m_SendATCommand(ATX4) = TModemAnswer.OK then
      m_ModemContext.IsATX4Accepted := True;

  end else
    begin
      m_SendATCommand(ATX3);
      //пауза перед слепым дозвоном 2 cек (recommended by V.250)
      //TODO: должно настраиваться
      m_SendATCommand('ATS6=2');
    end;

  //ожидание ответа
  //ATS           = 'ATS%d=%d\x0D';
  m_SendATCommand(string('ATS7=' + IntToStr(m_ChannelSettings.TimeOuts)));

  //класть трубку по DTR
  m_SendATCommand(ATampD2);
	m_SendATCommand(ATampD0);

  //RLSD стоит только при несущей
  if m_SendATCommand(ATampC1) = TModemAnswer.OK then
    m_ModemContext.IsATampC1Accepted := True
  else
    m_ModemContext.IsATampC1Accepted := False;

  //DSR пропадает при переходе в командный режим
  if m_SendATCommand(ATampS1) = TModemAnswer.OK then
    m_ModemContext.IsATampS1Accepted := True
  else
    m_ModemContext.IsATampS1Accepted := False;

 	//управление потоком
	ATplIFC02Accepted := False;
	ATslQ2Accepted    := False;

  if (m_SendATCommand(ATplIFC02) = TModemAnswer.OK) then //V.250
		ATplIFC02Accepted := True
	else if (m_SendATCommand(ATslQ2) = TModemAnswer.OK) then//Siemens MC35i
			ATslQ2Accepted := True;

  if (ATplIFC02Accepted = True) or (ATslQ2Accepted = True) then
  begin    //пробуем включить аппаратное управление потоком
     ComPortWorker.SetHWFlowControl(True);

     if (m_SendATCommand(AT, 100) <> TModemAnswer.OK) then
     begin
        ComPortWorker.PurgeRX();
        ComPortWorker.SetHWFlowControl(False);

        if (ATplIFC02Accepted) then
				  m_SendATCommand(ATplIFC00); //V.250

			if (ATslQ2Accepted) then
				  m_SendATCommand(ATslQ0); //Siemens MC35i
     end;


  end;

end;

//------------------------------------------------------------------------------
function TModemManager.Open(Settings:TChannelSettings):Integer;
begin
   if ComPortWorker.OpenCOM(Settings) = RET_OK then
   begin
       InitModem();
   end;

end;

end.
