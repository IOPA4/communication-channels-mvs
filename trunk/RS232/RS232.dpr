library RS232;

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
  Dialogs,
  Windows,
  Forms,
  SysUtils,
  Classes,
  IniFiles,
  AdPort,
  Unit1 in 'Unit1.pas' {FormProperties};

var
  Profile:String;
const
  RET_OK = 0;
  RET_ERR = $FF;
{$R *.res}

function GetString(Code:Integer):String;
begin

  if TStringList(pLangList).Count <Code
    then Result:=''
    else Result:=TStringList(pLangList).Strings[Code-1];
end;

function Channel_ShowWindow():Integer;
begin
  Result:=RET_ERR;
  if pLangList=NIL then Exit;
  Result:=RET_OK;
  FormProperties.ShowModal;
end;

function Channel_SetSettings():Integer;
begin
  Result:=RET_OK;
end;

function Channel_GetSettings(var ChannelSettings: TChannelSettings):Integer;
begin
  Result:=RET_OK;
  ChannelSettings.Delay:=0;
  ChannelSettings.TimeOuts:=StrToInt(IniFile.ReadString(Profile,'PortDeleyWaitAnswer','0'));
  ChannelSettings.Retry:=StrToInt(IniFile.ReadString(Profile,'PortRetry','0'));
end;

function Channel_GetStatus():Integer;
begin
  Result:=RET_OK;
end;

function Channel_Open(ProfileName:PChar):Integer;
var
  i,n:Integer;
  TmpStr:String;
  Flag:Boolean;
begin
  Result:=RET_ERR;

  if FormProperties.SerialPort.Open=True then Exit;
  if IniFile.SectionExists('Profile_'+NameDll+'_'+ProfileName) then
    begin
      Profile:='Profile_'+NameDll+'_'+ProfileName;
{      if IniFile.ReadString(Profile,'ProfileName','')<>ProfileName then
Continue;}
      // настроим порт
      TmpStr:=IniFile.ReadString(Profile,'PortName','COM1');

        FormProperties.RefreshCOMport;
        Flag:=False;
        for n := 0 to FormProperties.cbPort.Items.Count-1 do
          if FormProperties.cbPort.Items[n]=TmpStr then Flag:=True;
        if Flag=False then Exit;

      Delete(TmpStr,1,3);
      FormProperties.SerialPort.ComNumber:=StrToInt(TmpStr);
      // настроим скорость
      TmpStr:=IniFile.ReadString(Profile,'PortSpeed','9600');
      FormProperties.SerialPort.Baud:=StrToInt(TmpStr);
      // настроим количество бит данных
      FormProperties.SerialPort.DataBits:=Word(StrToInt((IniFile.ReadString(Profile,'PortDataBits','8'))));
      // настроим четность
      Case IniFile.ReadInteger(Profile,'PortParity',0) of
      0:FormProperties.SerialPort.Parity:=pNone;
      1:FormProperties.SerialPort.Parity:=pOdd;
      2:FormProperties.SerialPort.Parity:=pEven;
      3:FormProperties.SerialPort.Parity:=pMark;
      4:FormProperties.SerialPort.Parity:=pSpace;
      End;
      // настроим количество стоповых бит
      FormProperties.SerialPort.StopBits:=Word(1+IniFile.ReadInteger(Profile,'PortStopBits',0));
      // настроим управление потоком
      {FormProperties.cbFlow.ItemIndex:=IniFile.ReadInteger(Profile,'PortFlow',0);}

      PortDelayBeforeSend:=StrToInt(IniFile.ReadString(Profile,'PortDelayBeforeSend','60'));
      PortDeleyWaitAnswer:=StrToInt(IniFile.ReadString(Profile,'PortDeleyWaitAnswer','500'));
      PortEhoDelete:=IniFile.ReadBool(Profile,'PortEhoDelete',False);
      Result:=RET_OK;
    end;
  if Result=RET_OK then FormProperties.SerialPort.Open:=True;
end;

function Channel_Close():Integer;
begin
  Result:=RET_OK;
  if FormProperties.SerialPort.Open then FormProperties.SerialPort.Open:=False;
end;

function Channel_Write(pBlock:Pointer;Count:Word):Integer;
begin
  Result:=RET_ERR;
  if FormProperties.SerialPort.Open=False then Exit;
  Result:=RET_OK;
  CopyMemory(@BlockW,pBlock,Count);
  FormProperties.SerialPort.FlushOutBuffer;
  FormProperties.SerialPort.FlushInBuffer;
  ZeroMemory(@BlockR,8192);
  BlockRPointer:=0;
  FormProperties.SerialPort.PutBlock(BlockW,Count);
end;

function Channel_Read(pBlock:Pointer; var Count:Word):Integer;
begin
  Result:=RET_OK;
  CopyMemory(pBlock,@BlockR,BlockRPointer);
  ZeroMemory(@BlockR,BlockRPointer);
  Count:=BlockRPointer;
  BlockRPointer:=0;
end;

function Channel_GetProfilesCount(var Count:Integer):Integer;
var
  i:Integer;
  Profiles:TStrings;
begin
  Result:=RET_OK;
  Count:=0;
  Profiles:=TStringList.Create;
  IniFile.ReadSections(Profiles);
  for i := 0 to Profiles.Count-1 do
          if Pos('Profile_RS232_',Profiles[i])=1 then
            Count:=Count+1;
end;

function Channel_GetProfilesName(N:Integer; var ProfileName:PChar):Integer;
var
  i,Count:Integer;
  Profiles,Profiles1:TStrings;
begin
  Result:=RET_ERR;
  Profiles1:=TStringList.Create;
  Profiles:=TStringList.Create;
  IniFile.ReadSections(Profiles);
for i := 0 to Profiles.Count-1 do
        if Pos('Profile_RS232_',Profiles[i])=1 then
            Profiles1.Add(Copy(Profiles[i],15,Length(Profiles[i])));
ProfileName:=PChar(Profiles1[n-1]);
Result:=RET_OK;
{  Count:=0;
  for i := 1 to 10 do
    begin
      if IniFile.SectionExists('Profile_'+NameDll+'_N'+IntToStr(i)) then Count:=Count+1;
      if Count=N then
        begin
           if IniFile.ValueExists('Profile_'+NameDll+'_N'+IntToStr(i),'ProfileName') then
              begin
                ProfileName:=IniFile.ReadString('Profile_'+NameDll+'_N'+IntToStr(i),'ProfileName','');
                Result:=RET_OK;
        end;
        end;
    end;   }
end;

function Channel_ConnectDll(pLang:Pointer):Integer;
begin
  Result:=RET_OK;
  pLangList:=pLang;
  FormProperties.Caption:= GetString(13)+' ('+NameDll+')';
  FormProperties.GroupBox1.Caption:=GetString(46);
  FormProperties.Label1.Caption:=GetString(113);
  FormProperties.Label2.Caption:=GetString(114);
  FormProperties.Label3.Caption:=GetString(115);
  FormProperties.Label4.Caption:=GetString(116);
  FormProperties.Label5.Caption:=GetString(117);
  FormProperties.Label6.Caption:=GetString(118);
  FormProperties.Label7.Caption:=GetString(119);
  FormProperties.Label8.Caption:=GetString(129);
  FormProperties.CheckBox1.Caption:=GetString(120);
  FormProperties.GroupBox2.Caption:=GetString(121);
  FormProperties.Button1.Caption:=GetString(4);
  FormProperties.Button2.Caption:=GetString(49);
  FormProperties.ButtonOK.Caption:=GetString(3);

  FormProperties.cbParity.Clear;
  FormProperties.cbParity.Items.Add(GetString(21));
  FormProperties.cbParity.Items.Add(GetString(123));
  FormProperties.cbParity.Items.Add(GetString(124));
  FormProperties.cbParity.Items.Add(GetString(125));
  FormProperties.cbParity.Items.Add(GetString(126));
  FormProperties.cbParity.ItemIndex:=0;

  FormProperties.cbFlow.Clear;
  FormProperties.cbFlow.Items.Add(GetString(21));
  FormProperties.cbFlow.Items.Add(GetString(127));
  FormProperties.cbFlow.Items.Add(GetString(128));
  FormProperties.cbFlow.ItemIndex:=0;
end;

procedure DLLEntryPoint(Reason: DWORD);
begin
	case Reason of
		DLL_PROCESS_ATTACH:
    	begin
        ApplicationPath:=ExtractFilePath(Application.ExeName);
        IniFile:=TIniFile.Create(ApplicationPath+'Settings.ini');
        FormProperties:= TFormProperties.Create(Application);
        pLangList:=NIL;
        ZeroMemory(@BlockR,BlockRPointer);
        BlockRPointer:=0;
     	end;
		DLL_PROCESS_DETACH:
    	begin
        FormProperties.SerialPort.Open:=False;
        IniFile.Free;
        FormProperties.Free;
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
