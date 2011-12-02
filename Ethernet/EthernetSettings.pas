unit EthernetSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, IniFiles,
  EthernetErrors,
  EthernetCaptions;

type

  TChannelSettings = record
    IP:string;
    Port: Integer;
    //
    Delay:Integer;
	  TimeOuts:Integer;
	  Retry:Integer;

  end;

  TForm2 = class(TForm)
    gbMainSettings: TGroupBox;
    btOk: TButton;
    tbCancel: TButton;
    lbIpAddr: TLabel;
    lbPort: TLabel;
    edPort: TEdit;
    gbProfiles: TGroupBox;
    cbProfiles: TComboBox;
    gbExchangeSettings: TGroupBox;
    edPortRetry: TEdit;
    edPortDeleyWaitAnswer: TEdit;
    edPortDelayBeforeSend: TEdit;
    lbPortDelayBeforeSend: TLabel;
    lbPortDeleyWaitAnswer: TLabel;
    lbRetry: TLabel;
    btCreateProf: TButton;
    btDelProf: TButton;
    btChangeProf: TButton;
    edIP: TEdit;
    procedure tbCancelClick(Sender: TObject);
    procedure btCreateProfClick(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

//------------------------------------------------------------------------------
  TChanSettingsManager = class
  private

     m_LibSettings:TChannelSettings;
     m_IniFile:TIniFile;

     procedure SetSettings(Settings:TChannelSettings);

  public

      m_fSettings: TForm2;
      constructor create;

      property FLibSettings:TChannelSettings read m_LibSettings write SetSettings;

      function ProfileWrite(ProfileName:String):Boolean;
      procedure ShowWindow();
      function GetProfilesCount(var Count:Integer):Integer;
      function GetProfilesName(N:Integer; var ProfileName:PChar):Integer;

  end;

const
  NameDll = 'Ethernet';


implementation

{$R *.dfm}
uses
  AddProfileSettings;

constructor TChanSettingsManager.create();
var
  pc:PChar;
  Res:Integer;
begin

    try
        m_fSettings := TForm2.Create(Application);

        if GetDescription(Integer(TDescriptionID.DESC_TCPIP), pc) = RET_OK then
          m_fSettings.gbMainSettings.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_IP_ADDRESS), pc) = RET_OK then
          m_fSettings.lbIpAddr.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_TCP_PORT), pc) = RET_OK then
          m_fSettings.lbPort.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_PROFILS), pc) = RET_OK then
          m_fSettings.gbProfiles.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_EXCHANGE_SETTINGS), pc) = RET_OK then
          m_fSettings.gbExchangeSettings.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_DELAY_BEFORE_SEND), pc) = RET_OK then
          m_fSettings.lbPortDelayBeforeSend.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_DELAY_WAIT_ANSWER), pc) = RET_OK then
          m_fSettings.lbPortDeleyWaitAnswer.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_RETRY_COUNT), pc) = RET_OK then
          m_fSettings.lbRetry.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_CREATE_PROFILE), pc) = RET_OK then
          m_fSettings.btCreateProf.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_CHANGE_PROFILE), pc) = RET_OK then
          m_fSettings.btChangeProf.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_DELETE_PROFILE), pc) = RET_OK then
          m_fSettings.btDelProf.Caption := string(pc);

        if FileExists(ExtractFilePath(Application.ExeName)+'Settings.ini') = True then
        begin
          m_IniFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Settings.ini');
        end else
          m_IniFile := Nil;

        m_LibSettings.IP := '127.0.0.1';
        m_LibSettings.Port := 12345;
        m_LibSettings.Delay := 60;
	      m_LibSettings.TimeOuts := 1000;
	      m_LibSettings.Retry := 2;

        m_fSettings.edIP.Text :=  m_LibSettings.IP;
        m_fSettings.edPort.Text :=  IntToStr(m_LibSettings.Port);
        m_fSettings.edPortDelayBeforeSend.Text := IntToStr(m_LibSettings.Delay);
        m_fSettings.edPortDeleyWaitAnswer.Text := IntToStr(m_LibSettings.TimeOuts);
        m_fSettings.edPortRetry.Text := IntToStr(m_LibSettings.Retry);

    Except
         m_fSettings := Nil;
         m_IniFile := Nil;
    end;
end;


//------------------------------------------------------------------------------
function TChanSettingsManager.GetProfilesCount(var Count:Integer):Integer;
var
  i:Integer;
  Profiles:TStrings;
begin
  Result:= RET_OK;
  Count:=0;

  if m_IniFile = Nil then
  begin
     Result:= RET_ERR;
  end else
  begin

    Profiles:=TStringList.Create;
    m_IniFile.ReadSections(Profiles);
    for i := 0 to Profiles.Count-1 do
        if Pos('Profile_' + NameDll + '_',Profiles[i])=1 then
           Count:=Count+1;
  end;
end;

function TChanSettingsManager.GetProfilesName(N:Integer; var ProfileName:PChar):Integer;
var
  i :Integer;
  Profiles, Names:TStrings;
begin
//N - это порядковый номер в файле

 Names:=TStringList.Create;
 Profiles:=TStringList.Create;

 m_IniFile.ReadSections(Profiles);

 for i := 0 to Profiles.Count-1 do
    if Pos('Profile_' + NameDll + '_',Profiles[i]) = 1 then
          Names.Add(Copy(Profiles[i], 18, Length(Profiles[i])));

 if N >= Names.Count then
   begin
     Result := RET_ERR;
   end else
   begin
     ProfileName:=PChar(Names[N]);
     Result := RET_OK;
   end;

end;

//------------------------------------------------------------------------------
procedure TChanSettingsManager.SetSettings(Settings: TChannelSettings);
begin
    m_LibSettings := Settings;
end;

//------------------------------------------------------------------------------
procedure TChanSettingsManager.ShowWindow();
var
ProfileName:String;
ProfileCount:Integer;
Res:Integer;
i:Integer;
pc:PChar;
begin
  ProfileName := '';

  if m_fSettings <> Nil then
  begin
    Res := GetProfilesCount(ProfileCount);
    if Res = RET_OK then
    begin
      for i := 0 to ProfileCount - 1 do
       begin
        Res := GetProfilesName(i, pc);
        if Res = RET_OK then
        begin
        if pc <> Nil then
          ProfileName := string(pc);
          m_fSettings.cbProfiles.Items.Add(ProfileName);
        end;
      end;
    end;
  end;
  m_fSettings.cbProfiles.ItemIndex := 0;
  m_fSettings.ShowModal;
end;

//------------------------------------------------------------------------------
procedure TForm2.btCreateProfClick(Sender: TObject);
var
  ChannelSettings:TChannelSettings;
  OkPressed:Boolean;
begin
   ChannelSettings.IP := edIP.Text;
   ChannelSettings.Port := StrToInt(edPort.Text);
   ChannelSettings.Delay := StrToInt(edPortDelayBeforeSend.Text);
   ChannelSettings.TimeOuts := StrToInt(edPortDeleyWaitAnswer.Text);
   ChannelSettings.Retry := StrToInt(edPortRetry.Text);

   //AddProfileWrapper.createAddProfile(ChannelSettings);

   AddProfileWrapper := TAddProfileWrapper.createAddProfile(ChannelSettings, Self);
   OkPressed := AddProfileWrapper.ShowWindow();
end;

procedure TForm2.tbCancelClick(Sender: TObject);
begin
   Close();
end;

//------------------------------------------------------------------------------
procedure InitSettings(Settings:TChannelSettings);
begin
    //SettingsManager.SetSettings(Settings);

end;

//------------------------------------------------------------------------------
function TChanSettingsManager.ProfileWrite(ProfileName:String):Boolean;
var
  i:Integer;
  Profile:String;
begin
Result:=False;
{for I := 1 to 10 do}
//  if not m_IniFile.SectionExists('Profile_RS232_'+ProfileName) then
//    begin
//      Profile:='Profile_'+NameDll+'_'+ProfileName;
//      m_IniFile.WriteString(Profile,'ProfileName',ProfileName);
//      m_IniFile.WriteString(Profile,'PortName',FormProperties.cbPort.Text);
//            Result:=True;
//    end else begin
//      Profile:='Profile_'+NameDll+'_'+ProfileName;
{      if IniFile.ReadString(Profile,'ProfileName','')<>ProfileName then
Continue;}
//      IniFile.WriteString(Profile,'ProfileName',ProfileName);
//      IniFile.WriteString(Profile,'PortName',FormProperties.cbPort.Text);
//      IniFile.WriteString(Profile,'PortSpeed',FormProperties.cbBaudRate.Text);
//      IniFile.WriteString(Profile,'PortDataBits',FormProperties.cbByteSize.Text);
//      IniFile.WriteInteger(Profile,'PortParity',FormProperties.cbParity.ItemIndex);
//      IniFile.WriteInteger(Profile,'PortStopBits',FormProperties.cbStopBits.ItemIndex);
//      IniFile.WriteInteger(Profile,'PortFlow',FormProperties.cbFlow.ItemIndex);
//      IniFile.WriteString(Profile,'PortDelayBeforeSend',FormProperties.edPortDelayBeforeSend.Text);
//      IniFile.WriteString(Profile,'PortDeleyWaitAnswer',FormProperties.edPortDeleyWaitAnswer.Text);
//      IniFile.WriteString(Profile,'PortRetry',FormProperties.edPortRetry.Text);
//      IniFile.WriteBool(Profile,'PortEhoDelete',FormProperties.CheckBox1.Checked);
//      Result:=True;
//    end;
end;
//------------------------------------------------------------------------------
end.
