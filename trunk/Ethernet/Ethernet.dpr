library Ethernet;

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
  Ethernet_exchange in 'Ethernet_exchange.pas',
  EthernetSettings in 'EthernetSettings.pas' {Form2},
  EthernetConstants in 'EthernetConstants.pas',
  EthernetCaptions in 'EthernetCaptions.pas',
  AddProfileSettings in 'AddProfileSettings.pas' {fNewProfile};

{$R *.res}
var
  SettingsManager:TChanSettingsManager;
  Temp:Integer;


function GetString(Code:Integer):String;
  begin
//    if TStringList(pLangList).Count <Code
//      then Result:=''
//    else Result:=TStringList(pLangList).Strings[Code-1];
  end;
function Channel_ShowWindow():Integer;
begin
 Result:=RET_ERR;
//  if pLangList=NIL then Exit;
 Result:=RET_OK;
 SettingsManager.ShowWindow;



end;

function Channel_SetSettings(ProfileName:String):Integer;
begin
  Result:=RET_OK;
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
//var
//  i,n:Integer;
//  TmpStr:String;
//  Flag:Boolean;
begin
  //Result:= SettingsManager.GetProfilesName(N, ProfileName);
//TO DO инициализация сокета, попытка соединения с срвером.

end;

function Channel_Close():Integer;
begin
  Result:=RET_OK;
//  if FormProperties.SerialPort.Open then FormProperties.SerialPort.Open:=False;
end;

function Channel_Write(pBlock:Pointer;Count:Word):Integer;
begin
  Result:=RET_ERR;
//  if FormProperties.SerialPort.Open=False then Exit;
//  Result:=RET_OK;
//  CopyMemory(@BlockW,pBlock,Count);
//  FormProperties.SerialPort.FlushOutBuffer;
//  FormProperties.SerialPort.FlushInBuffer;
//  ZeroMemory(@BlockR,8192);
//  BlockRPointer:=0;
//  FormProperties.SerialPort.PutBlock(BlockW,Count);
end;

function Channel_Read(pBlock:Pointer; var Count:Word):Integer;
begin
  Result:=RET_OK;
//  CopyMemory(pBlock,@BlockR,BlockRPointer);
//  ZeroMemory(@BlockR,BlockRPointer);
//  Count:=BlockRPointer;
//  BlockRPointer:=0;
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
  Result:=RET_OK;
  //pLangList:=pLang;
//  FormProperties.Caption:= GetString(13)+' ('+NameDll+')';
//  FormProperties.GroupBox1.Caption:=GetString(46);
//  FormProperties.Label1.Caption:=GetString(113);
//  FormProperties.Label2.Caption:=GetString(114);
//  FormProperties.Label3.Caption:=GetString(115);
//  FormProperties.Label4.Caption:=GetString(116);
//  FormProperties.Label5.Caption:=GetString(117);
//  FormProperties.Label6.Caption:=GetString(118);
//  FormProperties.Label7.Caption:=GetString(119);
//  FormProperties.Label8.Caption:=GetString(129);
//  FormProperties.CheckBox1.Caption:=GetString(120);
//  FormProperties.GroupBox2.Caption:=GetString(121);
//  FormProperties.Button1.Caption:=GetString(4);
//  FormProperties.Button2.Caption:=GetString(49);
//  FormProperties.ButtonOK.Caption:=GetString(3);
//
//  FormProperties.cbParity.Clear;
//  FormProperties.cbParity.Items.Add(GetString(21));
//  FormProperties.cbParity.Items.Add(GetString(123));
//  FormProperties.cbParity.Items.Add(GetString(124));
//  FormProperties.cbParity.Items.Add(GetString(125));
//  FormProperties.cbParity.Items.Add(GetString(126));
//  FormProperties.cbParity.ItemIndex:=0;
//
//  FormProperties.cbFlow.Clear;
//  FormProperties.cbFlow.Items.Add(GetString(21));
//  FormProperties.cbFlow.Items.Add(GetString(127));
//  FormProperties.cbFlow.Items.Add(GetString(128));
//  FormProperties.cbFlow.ItemIndex:=0;
end;

procedure DLLEntryPoint(Reason: DWORD);
begin
	case Reason of
		DLL_PROCESS_ATTACH:
    	begin

         SettingsManager := TChanSettingsManager.create();
         SettingsManager.RefreshProfilsArray();
//        pLangList:=NIL;
//        ZeroMemory(@BlockR,BlockRPointer);
//        BlockRPointer:=0;
     	end;
		DLL_PROCESS_DETACH:
    	begin
      SettingsManager.Destroy;
//        FormProperties.SerialPort.Open:=False;
//        IniFile.Free;
//        FormProperties.Free;
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
