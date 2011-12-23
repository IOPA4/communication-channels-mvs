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
    TModemState = (
      MS_UNKNOWN = 0,
      MS_CMD_MODE,
      MS_DATA_MODE);

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

      m_ChannelSettings:TChannelSettings;
      m_ModemContext:TModemContext;
      ModemState:TModemState;
      m_NoCarrierSM_state:Integer;
      ara:array [0..Integer(TModemAnswer.MAS_N) - 1] of TModAnsw;
      //--
      m_Buf:array[0..BUF_MAX_LEN] of Byte;
      m_ReadBuf:array[0..BUF_MAX_LEN] of Byte;
      m_LastBlockSize:Integer;
      m_ReadBufLastBlockSize:Integer;
      m_csExchange:TCriticalSection;
      //--
      function NoCarrierSM(c:Char):Boolean;
      function ModemAnswerCode(buf:PByte):TModemAnswer;
      function m_SendATCommand (Cmd:string; TimeOut:Integer;
        IsCheckStop:Boolean):TModemAnswer; Overload;
      function m_SendATCommand (Cmd:string; TimeOut:Integer):TModemAnswer; Overload;
      function m_SendATCommand (Cmd:string):TModemAnswer; Overload;
      function m_SendPlPlPl():Integer;

      //--

      //--
      function PingModem(): Boolean;
      function InitModem(Settings:TChannelSettings):Integer;
      //--
      function ProcessUserAddParams(Settings:TChannelSettings):Integer;
      function MakeATCommandForLowLayer(Command:string; buffer:PByteArray):Integer;
      function Call(Settings:TChannelSettings):Integer;

    public

        constructor Create;
        destructor Destroy;

        function Open(Settings:TChannelSettings):Integer;
        function Close():Integer;

        function WriteBlock(pBlock:Pointer; BlockSize:Word):Integer;
        function ReadBlock(pBlock:Pointer; var Count:Word; MaxBlockSize:Word):Integer;
        //function IsActive():Boolean;
    end;
//------------------------------------------------------------------------------

var
  ExchangeManager:TModemManager;
implementation
//------------------------------------------------------------------------------
constructor TModemManager.Create();
begin

    ZeroMemory(@m_Buf, Sizeof(m_Buf));
    ZeroMemory(@m_ReadBuf, Sizeof(m_ReadBuf));

    m_LastBlockSize := 0;
    m_ReadBufLastBlockSize := 0;

    ComPortWorker := TComPortWorker.Create;
    ModemState := TModemState.MS_UNKNOWN;
    m_csExchange := TCriticalSection.Create;
    m_NoCarrierSM_state := 0;

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
   m_csExchange.Destroy;
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

     if (AnsiPos(cCONNECT, string(ps)) <> 0) then
         Result := TModemAnswer.CONNECT;

end;

//------------------------------------------------------------------------------
function TModemManager.MakeATCommandForLowLayer(Command:string; buffer:PByteArray):Integer;
var
  tmp, i:Integer;
begin


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

    if (m_SendATCommand(AT, 500) = TModemAnswer.OK) then
    begin
      //кладем трубку
      if (m_SendATCommand(ATH0, MODEM_ANSWER_TIMEOUT * 3) = TModemAnswer.OK) then
      begin
        Result := True;
        Exit;
      end;
    end;

    Sleep(1020);
    m_SendATCommand(PlPlPl, 3100);

    //кладем трубку
    if (m_SendATCommand(AT, 500) = TModemAnswer.OK) then
    begin
        Result := True;
        Exit;
    end;

    //включаем ответ
    m_SendATCommand(ATQ0V1);

    if (m_SendATCommand(AT, 500) = TModemAnswer.OK) then
    begin
        Result := True;
        Exit;
    end;

end;

//------------------------------------------------------------------------------
function TModemManager.InitModem(Settings:TChannelSettings):Integer;
var
 	  ATplIFC02Accepted, ATslQ2Accepted: Boolean;
begin

    ModemState := TModemState.MS_UNKNOWN;

    if PingModem = False then
    begin
       Result := RET_ERR;
       Exit;
    end;

    //кладем трубку
    m_SendATCommand(ATH0, MODEM_ANSWER_TIMEOUT * 3);

    //включаем эхо (оно тут не нужно, но пусконаладчики пугаются)
    m_SendATCommand(ATE1);

    //включаем динамик
    m_SendATCommand(ATM1);

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
        m_SendATCommand('ATS6=2');
      end;

    //ожидание ответа
    m_SendATCommand(string('ATS7=' + IntToStr(Round(Settings.TimeOuts/1000))));

    //отключение реакции на DTR
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

    m_SendATCommand(ATplIFC00); //V.250
    m_SendATCommand(ATslQ0); //Siemens MC35i

    if (ATplIFC02Accepted = True) or (ATslQ2Accepted = True) then
    begin    //пробуем включить аппаратное управление потоком
       //ComPortWorker.SetHWFlowControl(True);

       if (m_SendATCommand(AT, 500) <> TModemAnswer.OK) then
       begin
          ComPortWorker.PurgeRX();
          ComPortWorker.SetHWFlowControl(False);

          if (ATplIFC02Accepted) then
            m_SendATCommand(ATplIFC00); //V.250

        if (ATslQ2Accepted) then
            m_SendATCommand(ATslQ0); //Siemens MC35i
       end;
    end;

    ModemState := TModemState.MS_CMD_MODE;

end;

//------------------------------------------------------------------------------
function TModemManager.Call(Settings:TChannelSettings):Integer;
var

    ATDCommand: string;
    Iter:Integer;
    mr: TModemAnswer;

begin
    ATDCommand := 'ATD';

    if Settings.IsTone then
       ATDCommand := ATDCommand + 'T'
    else
       ATDCommand := ATDCommand + 'P';

    if (Settings.IsWaitTone) or (m_ModemContext.IsATX4Accepted = False) then
        ATDCommand := ATDCommand + 'W';
    Iter := 0;

    ATDCommand := ATDCommand + Settings.PhoneNumber;
    repeat
       m_SendATCommand(ATcapSPBD_BL);
       mr := m_SendATCommand(ATDCommand, Settings.TimeOuts + 15);

       case mr of
           TModemAnswer.CONNECT:
           begin
              //соединение с удаленным модемом удачно установленно
              ModemState := TModemState.MS_DATA_MODE;
              Sleep(100);
              Result:= RET_OK;
              Exit;
           end;

           TModemAnswer.OK:
           begin
              //В этом случае "OK" не подходит
              Result:= RET_ERR;
              Exit;
           end;

           TModemAnswer.BUSY:
           begin
           //занято, ждем секунду
              Sleep(1000);
           end;
       end;

       Iter:= Iter + 1;
    until Iter > Settings.Retry;
end;

//------------------------------------------------------------------------------
function TModemManager.ProcessUserAddParams(Settings:TChannelSettings):Integer;
var
  FirstIdx, Count, i, len:Integer;
  Comand:string;
begin

   len := Length(Settings.AddInitParams);
   if len = 0 then
   begin
     Result := RET_OK;
     Exit;
   end;

   FirstIdx := 1;
   Count := 0;

   for i := 1 to len do
   begin
      if (Char(Settings.AddInitParams[i]) = ',') then
      begin
         m_SendATCommand(Copy(Settings.AddInitParams, FirstIdx, Count));
         FirstIdx := FirstIdx + Count + 1;
         Count := 0;
      end else
         Count := Count + 1;
   end;

   if Count > 0 then
       m_SendATCommand(Copy(Settings.AddInitParams, FirstIdx, Count));

end;

//------------------------------------------------------------------------------
function TModemManager.m_SendPlPlPl():Integer;
var
    Written:Integer;
    CommandLen:Integer;
    buf: array [0..MAX_RESP_LENGTH - 1] of Byte;
    buffer:Array [0..2] of Byte;
    rd, r, Count: Integer;
    Tics:Cardinal;
    State: TState;
    MA:TModemAnswer;
begin

    Result := RET_ERR;
    rd := 0;

    for r := 0 to 2 do
        buffer[r] := Byte(Char('+'));

    //пауза между АТ-командами
    //нужна для D-Link'а, иначе он перестает отвечать

    ComPortWorker.PurgeRX();

    if (ComPortWorker.WriteCOM(@buffer, 3) = RET_ERR) then
    begin
        Result := RET_ERR;   //ошибка
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
                     if MA = TModemAnswer.OK then
                     begin
                         Result := RET_OK;
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


             if rd >= MAX_RESP_LENGTH then
                Exit;//
         end;
         until ((GetTickCount() - Tics) > 4000);
end;

//------------------------------------------------------------------------------
function TModemManager.Open(Settings:TChannelSettings):Integer;
begin

  try

    m_csExchange.Enter;
    Result := RET_ERR;

    if ModemState = TModemState.MS_DATA_MODE then
    begin
       Close();
       if ModemState = TModemState.MS_UNKNOWN then
          begin
            Result := RET_ERR;
            Exit;

          end;

    end;

    if ComPortWorker.OpenCOM(Settings) = RET_OK then
    begin
       if InitModem(Settings) = RET_ERR then
       begin
            Result := RET_ERR;
            Exit;
       end;

       ProcessUserAddParams(Settings);
       if (Call(Settings) = RET_OK) then
          Result := RET_OK;

// отладка без модема
      //Result := RET_OK;
      //ModemState := TModemState.MS_DATA_MODE;

    end;

  finally
    m_csExchange.Leave;
  end;
end;

//------------------------------------------------------------------------------
function TModemManager.Close():Integer;
begin

    m_csExchange.Enter;

    try

      Result := RET_OK;
      Sleep(1000);
      m_SendPlPlPl();
      Sleep(2000);

      if m_SendATCommand(ATH0, 1000) <> TModemAnswer.OK then
      begin
        Result := RET_ERR;
        ModemState := TModemState.MS_UNKNOWN;
      end else
        ModemState := TModemState.MS_CMD_MODE;
          ModemState := TModemState.MS_CMD_MODE;

    finally
      ComPortWorker.CloseCOM();
      m_csExchange.Leave;
    end;
end;

//------------------------------------------------------------------------------
function TModemManager.WriteBlock(pBlock:Pointer; BlockSize:Word):Integer;
begin

    //модем должен находится в режиме передачи данных
    if (ModemState <> TModemState.MS_DATA_MODE) then
    begin
        Result := RET_ERR;
        Exit;
    end;

    try

        m_csExchange.Enter;
        Result := RET_ERR;

        ZeroMemory(@m_Buf[0], m_LastBlockSize);
        m_LastBlockSize := BlockSize;

        CopyMemory(@m_Buf[0], pBlock, BlockSize);

        if (ComPortWorker.WriteCOM(@m_Buf, BlockSize) = RET_ERR) then
        begin
            Result := RET_ERR;   //ошибка
            Exit;
        end;
        Result := RET_OK;

    finally

      m_csExchange.Leave;

    end;
end;

//------------------------------------------------------------------------------
function TModemManager.NoCarrierSM(c:Char):Boolean;
begin

	if (c = Char(cNO_CARRIER[m_NoCarrierSM_state + 1])) then
	begin
    m_NoCarrierSM_state := m_NoCarrierSM_state + 1;
		if (m_NoCarrierSM_state = StrLen(PAnsiChar(cNO_CARRIER))) then
		begin
			m_NoCarrierSM_state := 0;
			Result := true;
      Exit;
		end;
	end else
		m_NoCarrierSM_state := 0;

	Result := False;
end;

//------------------------------------------------------------------------------
function TModemManager.ReadBlock(pBlock:Pointer; var Count:Word;
                                 MaxBlockSize:Word):Integer;
var
  i, rdCount, rd:Integer;
begin

    rd := 0;
    try
        m_csExchange.Enter;

        ZeroMemory(@m_ReadBuf[0], m_ReadBufLastBlockSize);
        m_ReadBufLastBlockSize:= 0;

        for i := 0 to MaxBlockSize - 1 do
        begin

           ComPortWorker.ReadCOM(@m_Buf[rd], 1, rdCount);
           rd := rd + rdCount;

           if rdCount = 0 then
           begin

              if rd > 0  then
                 CopyMemory(pBlock, @m_Buf[0], rd);

             Result := RET_OK;
             Count := rd;
             Exit;
           end else
           begin
              if (NoCarrierSM(Char(m_Buf[rd])) = True) then
			          begin

                  ModemState := TModemState.MS_CMD_MODE;
                  ComPortWorker.PurgeRX();
                  Result := RET_ERR;
			          end;

                if rd = Count  then
                begin

                  CopyMemory(pBlock, @m_Buf[0], rd);

                  Result := RET_OK;
                  Count := rd;
                  Exit;
                end;
           end;





        end;

    Result := RET_OK;
    Count := rd;
    finally
        m_csExchange.Leave;
    end;
end;

//------------------------------------------------------------------------------
end.
