unit ComPort;

interface

uses
   WinTypes,
   SysUtils,
   HAYESConstants,
   HAYESSettings;

type
    TComPortWorker = class
      private
            hPort: THandle;
            buf: array[1..100] of byte;
            function ClrDTR():Integer;
            function SetDTR():Integer;

            function GetCOMStatus(var Flags:DWord):Integer;
            function GetCOMProp(var Cp:COMMPROP):Integer;


      public

          constructor Create;
          destructor Destroy;

          function OpenCOM(Settings:TChannelSettings):Integer;
          function CloseCOM():Integer;
          function GetStateCOM():Boolean;
          function PurgeRX():Integer;
          function WriteCOM(pBlock:PByteArray; BlockSize:Word):Integer;
          function ReadCOM(pBlock:PByteArray; BlockSize:Integer;
                           var Readed:Integer):Integer;
          function SetHWFlowControl(IsHWFC:Boolean):Integer;
          function ResetDTR():Integer;
    end;

var
  ComPortWorker:TComPortWorker;

implementation

constructor TComPortWorker.Create;
begin

    hPort := INVALID_HANDLE_VALUE;
    ZeroMemory(@buf, Sizeof(buf));

end;

destructor TComPortWorker.Destroy;
begin

end;

//------------------------------------------------------------------------------
function TComPortWorker.OpenCOM(Settings:TChannelSettings):Integer;
var
  s:string;
  ct:TCOMMTIMEOUTS;
	dcb:TDCB;
  tmp:Integer;

begin

  //TO DO проверка порта на корректность
  s := string(Copy(Settings.ComNumber, 4, Length(Settings.ComNumber) - 3));
  tmp := StrToInt(s);

  if (tmp < 10) then
  begin
		s := 'COM' +  IntToStr(tmp);
  end else
  	s := '\\\\.\\COM' +  IntToStr(tmp);

    if (hPort <> INVALID_HANDLE_VALUE) then
        CloseCOM();

  hPort := CreateFile(PWideChar(s), GENERIC_READ or GENERIC_WRITE, 0, Nil, OPEN_EXISTING,
		0, 0);

  if (hPort = INVALID_HANDLE_VALUE) then
  begin
    Result := RET_ERR;
    Exit;
  end;

  if (GetCommState(hPort, dcb) = False) then
  begin
    Result := RET_ERR;
    Exit;
  end;

  dcb.BaudRate := cardinal(BaudRate[Settings.BaudRateIndex]);

  //TODO

  dcb.ByteSize := 8;
  dcb.StopBits := ONESTOPBIT;
  dcb.Flags := dcb.Flags or $10;

  dcb.DCBlength := SizeOf(dcb);
  if (SetCommState(hPort, &dcb) = False) then
  begin
    Result := RET_ERR;
    Exit;
  end;

  	//Тайм-аут чтения - 150 мс
  ct.ReadTotalTimeoutMultiplier := MAXDWORD;
	ct.ReadIntervalTimeout := MAXDWORD;
	ct.ReadTotalTimeoutConstant := 150;

	//Тайм-аут записи не используется
	ct.WriteTotalTimeoutMultiplier := 0;
  ct.WriteTotalTimeoutConstant := 0;

  if (SetCommTimeouts(hPort, &ct) = False) then
  begin
    Result := RET_ERR;
    Exit;
  end;


	//if (SetCommMask(hPort, EV_CTS or EV_DSR or EV_RLSD) = False) then
	//begin
   // Result := RET_ERR;
   // Exit;
  //end;

	if (SetupComm(hPort, 1024, 1024) = False) then
	begin
    Result := RET_ERR;
    Exit;
  end;

  Result := RET_OK;
end;

//------------------------------------------------------------------------------
function TComPortWorker.CloseCOM():Integer;
begin

	if (CloseHandle(hPort) = False) then
  begin
      Result:=RET_ERR;
      Exit;
  end;
	hPort := INVALID_HANDLE_VALUE;

end;

//------------------------------------------------------------------------------
function TComPortWorker.GetStateCOM():Boolean;
begin
  Result := False;

  if hPort = INVALID_HANDLE_VALUE then
    Result := False
  else
    Result := True;
end;

//------------------------------------------------------------------------------
function TComPortWorker.WriteCOM(pBlock:PByteArray; BlockSize:Word):Integer;
var
	Written, w: DWord;

  i : integer;
begin

	Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function WriteCOM');
	Written := 0;


	repeat
		//ThIdDPRINT(TEXT(__FUNCTION__) L" WriteFile\r\n");

		if (WriteFile(hPort, pBlock[Written] , BlockSize - Written, &w, Nil) = False) then
		begin
			//ThIdDPRINT(TEXT(__FUNCTION__) L" WriteFile fail\r\n");
			Result := RET_ERR;
      Exit;
		end;
    //ThIdDPRINT(TEXT(__FUNCTION__) L" WriteFile return\r\n");

		Written := Written + w;

  until Written <= BlockSize;

  Result := RET_OK;
end;

//------------------------------------------------------------------------------
function TComPortWorker.ReadCOM(pBlock:PByteArray; BlockSize:Integer;
                                 var Readed:Integer):Integer;
var
	r:Cardinal;

begin

	Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function ReadCOM');
  ZeroMemory(@buf, sizeof(buf));
  Result := RET_OK;

	if (ReadFile(hPort, buf, BlockSize, r, Nil) = False)  then
	begin
			//ThIdDPRINT(TEXT(__FUNCTION__) L" ReadFile fail\r\n");
			Result := RET_ERR;
      Readed := 0;
      Exit;
	end;

  CopyMemory(pBlock, @buf, r);
  Readed := r;



end;

//------------------------------------------------------------------------------
function TComPortWorker.ClrDTR():Integer;
begin

	Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function ClrDTR');

  Result := RET_OK;

	if (EscapeCommFunction(hPort, CLRDTR) = False) then
	begin
			//ThIdDPRINT(TEXT(__FUNCTION__) L" ClrDTR EscapeCommFunction fail\r\n");
			Result := RET_ERR;
      Exit;
	end;

end;

//------------------------------------------------------------------------------
function TComPortWorker.SetDTR():Integer;
begin

	Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function SetDTR');

  Result := RET_OK;

	if (EscapeCommFunction(hPort, SETDTR) = False) then
	begin
			//ThIdDPRINT(TEXT(__FUNCTION__) L"SetDTR EscapeCommFunction fail\r\n");
			Result := RET_ERR;
      Exit;
	end;

end;

//------------------------------------------------------------------------------
function TComPortWorker.PurgeRX():Integer;
begin
	Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function PurgeRX');

	if (PurgeComm(hPort, PURGE_RXCLEAR) = False) then
	begin
			//ThIdDPRINT(TEXT(__FUNCTION__) L"PurgeComm fail\r\n");
			Result := RET_ERR;
      Exit;
	end;

end;

//------------------------------------------------------------------------------

function TComPortWorker.GetCOMStatus(var Flags:DWord):Integer;
begin
  Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function GetCOMStatus');

	if (GetCommModemStatus(hPort, Flags) = False) then
	begin
			//ThIdDPRINT(TEXT(__FUNCTION__) L"GetCommModemStatus fail\r\n");
			Result := RET_ERR;
      Exit;
	end;

end;

//------------------------------------------------------------------------------
function  TComPortWorker.GetCOMProp(var Cp:COMMPROP):Integer;
begin

  Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function GetCOMProp');

	if (GetCommProperties(hPort, Cp) = False) then
	begin
			//ThIdDPRINT(TEXT(__FUNCTION__) L"GetCOMStatus fail\r\n");
			Result := RET_ERR;
      Exit;
	end;

end;

//------------------------------------------------------------------------------
function TComPortWorker.SetHWFlowControl(IsHWFC:Boolean):Integer;
var
	dcb:TDCB;
  tmp:Integer;
begin

  if (GetCommState(hPort, dcb) = False) then
  begin
    Result := RET_ERR;
    Exit;
  end;


  if IsHWFC = True then
  begin
   dcb.Flags := dcb.Flags or EV_CTS;
   dcb.Flags := dcb.Flags or RTS_CONTROL_HANDSHAKE;
  end else
    begin
     tmp := not EV_CTS;
     dcb.Flags := dcb.Flags and tmp;

     tmp := not RTS_CONTROL_HANDSHAKE;
     dcb.Flags := dcb.Flags and tmp;

     dcb.Flags := dcb.Flags or RTS_CONTROL_ENABLE;
    end;

  if (SetCommState(hPort, dcb) = False) then
  begin
    Result := RET_ERR;
    Exit;
  end;
end;

//------------------------------------------------------------------------------
function TComPortWorker.ResetDTR():Integer;
begin

  Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function ResetDTR');

	if (EscapeCommFunction(hPort, CLRDTR) = False) then
		  Result := RET_ERR;

	Sleep(100);

	if (EscapeCommFunction(hPort, SETDTR)  = False) then
		 Result := RET_ERR;

  Result := RET_OK;
end;

end.
