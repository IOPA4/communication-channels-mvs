unit ComPort;

interface

uses
   WinTypes,
   SysUtils,
   HAYESConstants,
   HAYESSettings;


var
  hPort: THandle;

implementation

//------------------------------------------------------------------------------
function OpenCOM(Settings:TChannelSettings):Integer;
var
  s:string;
  ct:TCOMMTIMEOUTS;
	dcb:TDCB;
  tmp:Integer;

begin

  //TO DO проверка порта на корректность
  s := string(Copy(Settings.ComNumber, 3, StrLen(PAnsiChar(Settings.ComNumber))-3));
  tmp := StrToInt(s);

  if (tmp < 10) then
  begin
		s := 'COM' +  IntToStr(tmp);
  end else
  	s := '\\\\.\\COM' +  IntToStr(tmp);

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


	if (SetCommMask(hPort, EV_CTS or EV_DSR or EV_RLSD) = False) then
	begin
    Result := RET_ERR;
    Exit;
  end;

	if (SetupComm(hPort, 1024, 1024) = False) then
	begin
    Result := RET_ERR;
    Exit;
  end;
end;

//------------------------------------------------------------------------------
function CloseCOM():Integer;
begin

	if (CloseHandle(hPort) = False) then
  begin
      Result:=RET_ERR;
      Exit;
  end;
	hPort := INVALID_HANDLE_VALUE;

end;

//------------------------------------------------------------------------------
function GetStateCOM():Boolean;
begin
  Result := False;

  if hPort = INVALID_HANDLE_VALUE then
    Result := False
  else
    Result := True;
end;

//------------------------------------------------------------------------------
function WriteCOM(pBlock:PByteArray; BlockSize:Word):Integer;
var
	Written, w: DWord;
begin

	Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function WriteCOM');
	Written := 0;

 //	if (g_Settings.m_FlowControl == FLOW_HARDWARE)
	{
		UINT32 f;
		GetCOMStatus(&f);
		if (!(f & MS_CTS_ON))
		{
			Sleep(MODEM_ANSWER_TIMEOUT);
			GetCOMStatus(&f);
			if (!(f & MS_CTS_ON))
			{
				ThIdDPRINT(TEXT(__FUNCTION__) L" throw R_MODEM_NOT_RESP\r\n");
				throw MAKE_ERROR_CODE(R_MODEM_NOT_RESP);
			}
	 //	}
	//}

	repeat
		//ThIdDPRINT(TEXT(__FUNCTION__) L" WriteFile\r\n");

		if (WriteFile(hPort, pBlock[Written], BlockSize - Written, &w, Nil) = False) then
		begin
			//ThIdDPRINT(TEXT(__FUNCTION__) L" WriteFile fail\r\n");
			Result := RET_ERR;
      Exit;
		end;
    //ThIdDPRINT(TEXT(__FUNCTION__) L" WriteFile return\r\n");

		Written := Written + w;

  until Written < BlockSize;

  Result := RET_OK;
end;

//------------------------------------------------------------------------------
function ReadCOM(pBlock:PByteArray; BlockSize:Integer):Integer;
var
	r:Cardinal;
begin

	Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function ReadCOM');

  Result := RET_OK;

	if (ReadFile(hPort, pBlock, BlockSize, r, Nil) = False)  then
	begin
			//ThIdDPRINT(TEXT(__FUNCTION__) L" ReadFile fail\r\n");
			Result := RET_ERR;
      Exit;
	end;

end;

//------------------------------------------------------------------------------
function ClrDTR():Integer;
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
function SetDTR():Integer;
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
function PurgeRX():Integer;
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

function GetCOMStatus(var Flags:DWord):Integer;
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
function  GetCOMProp(var Cp:COMMPROP):Integer;
begin

  Assert(hPort <> INVALID_HANDLE_VALUE, 'Bad handle of com port in function GetCOMProp');

	if (GetCommProperties(hPort, Cp) = False) then
	begin
			//ThIdDPRINT(TEXT(__FUNCTION__) L"GetCOMStatus fail\r\n");
			Result := RET_ERR;
      Exit;
	end;

end;

end.
