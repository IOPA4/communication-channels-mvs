unit EthernetSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, IniFiles,
  EthernetConstants,
  EthernetErrors,
  EthernetCaptions;

type
  TfnRefresfWindow = procedure(Index:Integer)  of object;

  TChannelSettings = record
    ProfilName:string;
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
    procedure btChangeProfClick(Sender: TObject);
    procedure btDelProfClick(Sender: TObject);
    procedure cbProfilesSelect(Sender: TObject);
  private

    { Private declarations }
  public

  OwnerRefresfWindow: TfnRefresfWindow;

  procedure FillSettingsOfWindow(var ChannelSettings:TChannelSettings);
    { Public declarations }
  end;

//------------------------------------------------------------------------------
  TChanSettingsManager = class
  private

     m_LibSettings:TChannelSettings;
     m_Profils: array of TChannelSettings;
     m_ProfilsListSize:Integer;
     m_IniFile:TIniFile;

     procedure SetSettings(Settings:TChannelSettings);
     procedure RefreshWindow(Index:Integer);
     procedure SetProfileListLength(Length:Integer);

     function InternalGetProfilesCount(var Count:Integer):Integer;

  public

      m_fSettings: TForm2;
      constructor create;

      property FLibSettings:TChannelSettings
        read m_LibSettings
        write SetSettings;

      procedure ShowWindow();

      function ProfileWrite(ProfileName:String):Boolean;
      function GetProfilesCount(var Count:Integer):Integer;
      function GetProfilesName(N:Integer; var ProfileName:PChar):Integer;
      function RefreshProfilsArray():Integer;

//      function GetProfileByIndex(var ChannelSettings:TChannelSettings;
//        Index:Integer):Integer;
  end;


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

        m_fSettings.OwnerRefresfWindow := RefreshWindow;

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

        if GetDescription(Integer(TDescriptionID.DESC_CHANGE_PROFILE), pc) =
          RET_OK then
          m_fSettings.btChangeProf.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_DELETE_PROFILE), pc) =
          RET_OK then
          m_fSettings.btDelProf.Caption := string(pc);

        if FileExists(ExtractFilePath(Application.ExeName)+'Settings.ini') =
          True then
        begin
          m_IniFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+
            'Settings.ini');
        end else
          m_IniFile := Nil;

        m_LibSettings.IP := DEFVAL_IP_ADDRESS;
        m_LibSettings.Port := DEFVAL_TCP_PORT;
        m_LibSettings.Delay := DEFVAL_DELAY_BEFORE;
	      m_LibSettings.TimeOuts := DEFVAL_WAIT_ANSWER;
	      m_LibSettings.Retry := DEFVAL_RETRY_COUNT;

        SetProfileListLength(1);

        m_Profils[0].ProfilName := '000000';
        m_Profils[0].IP := DEFVAL_IP_ADDRESS;
        m_Profils[0].Port := DEFVAL_TCP_PORT;
        m_Profils[0].Delay := DEFVAL_DELAY_BEFORE;
	      m_Profils[0].TimeOuts := DEFVAL_WAIT_ANSWER;
	      m_Profils[0].Retry := DEFVAL_RETRY_COUNT;

        RefreshWindow(0);

    Except
         m_fSettings := Nil;
         m_IniFile := Nil;
    end;
end;

procedure TChanSettingsManager.RefreshWindow(Index:Integer);
begin
    Assert(Index < m_ProfilsListSize, 'Индекс больше размера m_Profils');

    m_fSettings.edIP.Text                   := m_Profils[Index].IP;
    m_fSettings.edPort.Text                 := IntToStr(m_Profils[Index].Port);
    m_fSettings.edPortDelayBeforeSend.Text  := IntToStr(m_Profils[Index].Delay);
    m_fSettings.edPortDeleyWaitAnswer.Text  := IntToStr(
      m_Profils[Index].TimeOuts);
    m_fSettings.edPortRetry.Text            := IntToStr(m_Profils[Index].Retry);

end;

procedure TChanSettingsManager.SetProfileListLength(Length:Integer);
begin
   m_ProfilsListSize := Length;
   SetLength(m_Profils, Length);
end;

//------------------------------------------------------------------------------
function TChanSettingsManager.GetProfilesCount(var Count:Integer):Integer;

begin

  Count := m_ProfilsListSize;
  Result := RET_OK;

end;

function TChanSettingsManager.InternalGetProfilesCount(var
  Count:Integer):Integer;
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
        if Pos(PROFNAME_PREFIX + NameDll + '_',Profiles[i])=1 then
           Count:=Count+1;
  end;
end;

function TChanSettingsManager.GetProfilesName(N:Integer; var
  ProfileName:PChar):Integer;
var
  i :Integer;
  Profiles, Names:TStrings;
begin
//N - это порядковый номер в списке

 if N >= m_ProfilsListSize then
   begin
     Result := RET_ERR;
   end else
   begin
     ProfileName := PChar(m_Profils[N].ProfilName);
     Result := RET_OK;
   end;

end;

//------------------------------------------------------------------------------
procedure TChanSettingsManager.SetSettings(Settings: TChannelSettings);
begin
    m_LibSettings := Settings;
end;

//------------------------------------------------------------------------------
function GetProfileByIndex(var ChannelSettings:TChannelSettings;
  Index:Integer):Integer;
  var
    i :Integer;
    Profiles, Names:TStrings;
  begin

  end;
//------------------------------------------------------------------------------
function TChanSettingsManager.RefreshProfilsArray():Integer;
  var
    Res, i, Index:Integer;
    Lines:TStrings;
    Name, s:string;

   begin
    if m_IniFile = Nil then
    begin
       Result:= RET_ERR;
    end else
    begin

      Res := InternalGetProfilesCount(m_ProfilsListSize);
      Lines := TStringList.Create;

      m_IniFile.ReadSections(Lines);

      if (Res = RET_OK) and (m_ProfilsListSize > 0)  then
      begin

        Index := 0;
        SetProfileListLength(m_ProfilsListSize);
        ZeroMemory(m_Profils, SizeOf(m_Profils[0])*m_ProfilsListSize);

        for i := 0 to Lines.Count - 1 do
        begin

          if Pos(PROFNAME_PREFIX + NameDll + '_',Lines[i]) = 1 then
          begin

             Name := Copy(Lines[i], 18, Length(Lines[i]));
             if StrLen(PChar(Name)) > 0 then
             begin

               m_Profils[Index].ProfilName := Name;
               m_Profils[Index].IP := m_IniFile.ReadString(Lines[i],
                 KEYNAME_IP_ADDRESS, DEFVAL_IP_ADDRESS);
               m_Profils[Index].Port := m_IniFile.ReadInteger(Lines[i],
                 KEYNAME_TCP_PORT, DEFVAL_TCP_PORT);
               m_Profils[Index].Delay := m_IniFile.ReadInteger(Lines[i],
                 KEYNAME_DELAY_BEFORE, DEFVAL_DELAY_BEFORE);
               m_Profils[Index].TimeOuts := m_IniFile.ReadInteger(Lines[i],
                 KEYNAME_WAIT_ANSWER, DEFVAL_WAIT_ANSWER);
               m_Profils[Index].Retry := m_IniFile.ReadInteger(Lines[i],
                   KEYNAME_RETRY_COUNT, DEFVAL_RETRY_COUNT) ;
               Index := Index + 1;
             end;
          end;
        end;
      end;
    end;
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
  ProfileName := EMPTY_PROFILE_NAME;

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
procedure TForm2.FillSettingsOfWindow(var ChannelSettings:TChannelSettings);
begin
   ChannelSettings.ProfilName := cbProfiles.Items[cbProfiles.ItemIndex];
   ChannelSettings.IP := edIP.Text;
   ChannelSettings.Port := StrToInt(edPort.Text);
   ChannelSettings.Delay := StrToInt(edPortDelayBeforeSend.Text);
   ChannelSettings.TimeOuts := StrToInt(edPortDeleyWaitAnswer.Text);
   ChannelSettings.Retry := StrToInt(edPortRetry.Text);
end;

//------------------------------------------------------------------------------
procedure TForm2.btChangeProfClick(Sender: TObject);
var
  ChannelSettings:TChannelSettings;
  OkPressed:Boolean;
begin

   FillSettingsOfWindow(ChannelSettings);

   AddProfileWrapper := TAddProfileWrapper.createAddProfile(
      TAddProfWindow.CHANGE_PROFILE, ChannelSettings, Self);

   OkPressed := AddProfileWrapper.ShowSettingsWindow();
   AddProfileWrapper.Destroy;

end;

//------------------------------------------------------------------------------
procedure TForm2.btCreateProfClick(Sender: TObject);
var
  ChannelSettings:TChannelSettings;
  OkPressed:Boolean;
  ProfileName:string;
begin
   FillSettingsOfWindow(ChannelSettings);
   ChannelSettings.ProfilName := EMPTY_PROFILE_NAME;

   AddProfileWrapper := TAddProfileWrapper.createAddProfile(
     TAddProfWindow.CREATE_PROFILE, ChannelSettings, Self);

   OkPressed := AddProfileWrapper.ShowSettingsWindow(ProfileName);
   AddProfileWrapper.Destroy;

   //TO DO Append profile on Settings.ini

end;

procedure TForm2.btDelProfClick(Sender: TObject);
var
  ChannelSettings:TChannelSettings;
  OkPressed:Boolean;
begin

   FillSettingsOfWindow(ChannelSettings);

   AddProfileWrapper := TAddProfileWrapper.createAddProfile(
      TAddProfWindow.DELETE_PROFILE, ChannelSettings, Self);

   OkPressed := AddProfileWrapper.ShowSettingsWindow();
   AddProfileWrapper.Destroy;

end;

procedure TForm2.cbProfilesSelect(Sender: TObject);
begin
   OwnerRefresfWindow(cbProfiles.ItemIndex);
end;

procedure TForm2.tbCancelClick(Sender: TObject);
begin
   Close();
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
