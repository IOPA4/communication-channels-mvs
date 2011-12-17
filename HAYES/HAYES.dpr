library HAYES;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Windows,
  Classes,
  Forms,
  HAYESCaptions in 'HAYESCaptions.pas',
  HAYESConstants in 'HAYESConstants.pas',
  HAYESExchange in 'HAYESExchange.pas',
  HAYESSettings in 'HAYESSettings.pas' {fSettings},
  HAYESAddProfileSettings in 'HAYESAddProfileSettings.pas' {fNewProfile},
  ComPort in 'ComPort.pas';

{$R *.res}
var
  SettingsManager:TChanSettingsManager;
  HasConected:Bool;  //Устанавливается True в Channel_ConnectDll

function Channel_ShowWindow():Integer;
begin
 Result:=RET_ERR;

 if HasConected = False then
    Exit;

 Result:=RET_OK;
 SettingsManager.ShowWindow;



end;

function Channel_SetSettings(ProfileName:String):Integer;
begin
  //Result:=RET_OK;
end;

function Channel_GetSettings(var ChannelSettings: TChannelSettings):Integer;
begin

  Result:=RET_OK;
  ChannelSettings := SettingsManager.FLibSettings;

end;

function Channel_GetStatus():Integer;
begin
  Result:=RET_OK;
end;



function Channel_Open(ProfileName:PChar):Integer;
var
  Settings:TChannelSettings;
  buf:Array [1..100] of Byte;
  ATbuf:Array [1..100] of Byte;
  Len:Integer;
begin
  try

    ZeroMemory(@buf, sizeof(buf));
    ZeroMemory(@ATbuf, sizeof(buf));


    if (SettingsManager.GetProfileByName(String('test'), Settings) <> RET_OK) then
    begin
      Result := RET_ERR;
      Exit;
    end;
    ExchangeManager.Open(Settings);
    //для отладки
//    if ComPortWorker.OpenCOM(Settings) = RET_OK then
//    begin
//      Len := MakeATCommandFoLowLayer(AT, @ATbuf);
//      ComPortWorker.WriteCOM(@ATbuf, Len);
//      ComPortWorker.ReadCOM(PByteArray(@buf), 100);
//    end;

  except
    //Result := RET_ERR;
  end;
end;

function Channel_Close():Integer;
begin

  try
    //Result := SocketWorker.Close();
  except
    //Result := RET_ERR;
  end;


end;

function Channel_Write(pBlock:Pointer;Count:Word):Integer;
begin

  try
    //Result := SocketWorker.WriteBlock(pBlock, Count);
  except
    //Result := RET_ERR;
  end;

end;

function Channel_Read(pBlock:Pointer; var Count:Word):Integer;
begin
  try

//    Result := SocketWorker.ReadBlock(pBlock, Count, 1024);

  except
    Result := RET_ERR;
  end;

end;

//
function Channel_GetProfilesCount(var Count:Integer):Integer;
begin

  Result := SettingsManager.GetProfilesCount(Count);
end;

function Channel_GetProfilesName(N:Integer; var ProfileName:PChar):Integer;
begin

  Result:= SettingsManager.GetProfilesName(N, ProfileName);

end;

function Channel_ConnectDll(pLang:Pointer):Integer;
begin

  Result:= InitDescriptionsArray(pLang);
  if (Result <> RET_OK) then
      Exit;
  HasConected := True;
  SettingsManager := TChanSettingsManager.create();
  Result := SettingsManager.RefreshProfilsArray();

  ExchangeManager := TModemManager.Create;
end;

procedure DLLEntryPoint(Reason: DWORD);
begin
	case Reason of
		DLL_PROCESS_ATTACH:
   	begin
      HasConected := False;
      ExchangeManager := TModemManager.Create();
      //OutSwapDescriptions();
   	end;

		DLL_PROCESS_DETACH:
   	begin
      if ExchangeManager <> Nil then
          ExchangeManager.Destroy;

      if SettingsManager <> Nil then
          SettingsManager.Destroy;
    end;
  end;
end;

exports
  Channel_ConnectDll,
  Channel_ShowWindow,
  Channel_SetSettings,
  Channel_GetSettings,
  Channel_GetStatus,
  Channel_Open,
  Channel_Close,
  Channel_Write,
  Channel_Read,
  Channel_GetProfilesCount,
  Channel_GetProfilesName;
begin

  DllProc := @DLLEntryPoint;
  DllEntryPoint(DLL_PROCESS_ATTACH);

end.
