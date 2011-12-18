unit HAYESSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,
  IniFiles,
  Registry,
  HAYESConstants,
  HAYESCaptions;

type

 //------------------------------------------------------------------------------
  TChannelSettings = record
      ProfilName:string;
      PhoneNumber:string;
      ComNumber:string;
      BaudRateIndex:Integer;
      //
      InactiveTimeout:Integer;
      IsWaitTone:Boolean;
      IsTone:Boolean;
      //
      Delay:Integer;
      TimeOuts:Integer;
      Retry:Integer;

    end;
//------------------------------------------------------------------------------
    TfnRefresfWindow = procedure(Index:Integer) of object;
    TOwnerModifySettingsSet = function(ChannelSettings:TChannelSettings;
                            ModifyProfType:TModifyProfType):Integer of object;
//------------------------------------------------------------------------------
  TfSettings = class(TForm)
    gbProfiles: TGroupBox;
    cbProfiles: TComboBox;
    btCreateProf: TButton;
    btDelProf: TButton;
    btChangeProf: TButton;
    tbCancel: TButton;
    btOk: TButton;
    gbExchangeSettings: TGroupBox;
    lbPortDelayBeforeSend: TLabel;
    lbPortDeleyWaitAnswer: TLabel;
    lbRetry: TLabel;
    edPortRetry: TEdit;
    edPortDeleyWaitAnswer: TEdit;
    gbConnectionSettings: TGroupBox;
    lbInactiveTimeout: TLabel;
    edInactiveTimeout: TEdit;
    edPortDelayBeforeSend: TEdit;
    cbWaitTone: TCheckBox;
    cbToneType: TCheckBox;
    gbPhoneNumber: TGroupBox;
    edPhoneNumber: TEdit;
    gbComPort: TGroupBox;
    cbComPort: TComboBox;
    lbPortName: TLabel;
    cbBaudRate: TComboBox;
    lbBaudRate: TLabel;
    procedure btChangeProfClick(Sender: TObject);
    procedure btCreateProfClick(Sender: TObject);
    procedure btDelProfClick(Sender: TObject);
    procedure cbProfilesSelect(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
     OwnerRefresfWindow: TfnRefresfWindow;
     OwnerModifySettingsSet: TOwnerModifySettingsSet;
     procedure FillSettingsOfWindow(var ChannelSettings:TChannelSettings);
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
     procedure RefreshWindowEx(Index:Integer);
     procedure SetProfileListLength(Length:Integer);

     function InternalGetProfilesCount(var Count:Integer):Integer;

  public

      m_fSettings: TfSettings;
      constructor create;

      property FLibSettings:TChannelSettings
        read m_LibSettings
        write SetSettings;

      procedure ShowWindow();

      function GetProfilesCount(var Count:Integer):Integer;
      function GetProfilesName(N:Integer; var ProfileName:PChar):Integer;
      function GetProfileByName(ProfileName:String;
                                var Settings:TChannelSettings):Integer;
      function RefreshProfilsArray():Integer;
      function OpenSettingsFile():Boolean;
      function ModifySettingsSet(ChannelSettings:TChannelSettings;
        ModifyProfType:TModifyProfType):Integer;
      function ModifySettingsFile(ChannelSettings:TChannelSettings;
        ModifyProfType:TModifyProfType):Integer;
      procedure CloseSettingsFile();

  end;



implementation

{$R *.dfm}
uses
HAYESAddProfileSettings;

function GetSerialPortNames(var List:TStringList): Integer;
var
  reg: TRegistry;
  l: TStringList;
  n: integer;
begin
  l := TStringList.Create;
  reg := TRegistry.Create;

  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey(REG_KEY_SERIALCOMM, false);
    reg.GetValueNames(l);
    for n := 0 to l.Count - 1 do
      List.Add(reg.ReadString(l[n]));

    Result := RET_OK;
  finally
    reg.Free;
    l.Free;
  end;
end;
//------------------------------------------------------------------------------
//                  TChanSettingsManager implementation;
//------------------------------------------------------------------------------
constructor TChanSettingsManager.create();
var
  pc:PChar;
  Res, i :Integer;
  PortList:TstringList;
begin

    try
        m_fSettings := TfSettings.Create(Application);

        m_fSettings.OwnerRefresfWindow := RefreshWindow;
        m_fSettings.OwnerModifySettingsSet := ModifySettingsSet;

        if GetDescription(Integer(TDescriptionID.DESC_PHONE_NUMBER), pc) = RET_OK then
          m_fSettings.gbPhoneNumber.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_COM_PORT), pc) = RET_OK then
          m_fSettings.gbComPort.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_LABEL_COM), pc) = RET_OK then
          m_fSettings.lbPortName.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_INACTIVE_TIMEOUT),
          pc) = RET_OK then
          m_fSettings.lbInactiveTimeout.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_CONNECT), pc) = RET_OK then
          m_fSettings.gbConnectionSettings.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_COM_BAUD_RATE), pc) = RET_OK then
          m_fSettings.lbBaudRate.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_WAIT_TONE), pc) = RET_OK then
          m_fSettings.cbWaitTone.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_TONE_CALL), pc) = RET_OK then
          m_fSettings.cbToneType.Caption := string(pc);

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

        for i := 0 to Integer(TBaudRateID.BRID_N) - 1  do
        begin
          if GetDescription(Integer(TDescriptionID.DESC_COM_BAUD_RATE_300) + i,
            pc) = RET_OK then
            m_fSettings.cbBaudRate.Items.Append(string(pc));
        end;

        PortList := TStringList.Create;

        GetSerialPortNames(PortList);
        m_fSettings.cbComPort.Items.AddStrings(PortList);
        m_LibSettings.ProfilName      := DEFVAL_PROFILE_NAME;
        m_LibSettings.PhoneNumber     := DEFVAL_PHONE_NUMBER;
        m_LibSettings.ComNumber       := DEFVAL_COM_NUMBER;
        m_LibSettings.BaudRateIndex   := DEFVAL_BAUD_RATE_INDEX;
      //
        m_LibSettings.InactiveTimeout := DEFVAL_INACTIVE_TIMEOUT;
        m_LibSettings.IsWaitTone      := DEFVAL_IS_WAIT_TONE;
        m_LibSettings.IsTone          := DEFVAL_IS_TONE;
      //
        m_LibSettings.Delay           := DEFVAL_DELAY_BEFORE;
	      m_LibSettings.TimeOuts        := DEFVAL_WAIT_ANSWER;
	      m_LibSettings.Retry           := DEFVAL_RETRY_COUNT;

        SetProfileListLength(1);

        m_Profils[0].ProfilName      := DEFVAL_PROFILE_NAME;
        m_Profils[0].PhoneNumber     := DEFVAL_PHONE_NUMBER;
        m_Profils[0].ComNumber       := DEFVAL_COM_NUMBER;
        m_Profils[0].BaudRateIndex   := DEFVAL_BAUD_RATE_INDEX;
      //
        m_Profils[0].InactiveTimeout := DEFVAL_INACTIVE_TIMEOUT;
        m_Profils[0].IsWaitTone      := DEFVAL_IS_WAIT_TONE;
        m_Profils[0].IsTone          := DEFVAL_IS_TONE;
      //
        m_Profils[0].Delay            := DEFVAL_DELAY_BEFORE;
	      m_Profils[0].TimeOuts         := DEFVAL_WAIT_ANSWER;
	      m_Profils[0].Retry            := DEFVAL_RETRY_COUNT;

        RefreshWindow(0);

    Except
         m_fSettings := Nil;
         m_IniFile := Nil;
    end;
end;

//------------------------------------------------------------------------------
procedure TChanSettingsManager.RefreshWindow(Index:Integer);
var
i:Integer;
begin
    Assert(Index < m_ProfilsListSize, 'Индекс больше размера m_Profils');


          m_fSettings.edPhoneNumber.Text := m_Profils[Index].PhoneNumber;

          for i := 0 to m_fSettings.cbComPort.Items.Count - 1 do
            if (m_fSettings.cbComPort.Items[i] = m_Profils[Index].ComNumber) then
              m_fSettings.cbComPort.ItemIndex := i;

          m_fSettings.cbBaudRate.ItemIndex := m_Profils[Index].BaudRateIndex;

          m_fSettings.edInactiveTimeout.Text :=
            IntToStr(m_Profils[Index].InactiveTimeout);
          m_fSettings.cbWaitTone.Checked := m_Profils[Index].IsWaitTone;
          m_fSettings.cbToneType.Checked := m_Profils[Index].IsTone;
          m_fSettings.edPortDelayBeforeSend.Text := IntToStr(m_Profils[
            Index].Delay);
          m_fSettings.edPortDeleyWaitAnswer.Text := IntToStr(m_Profils[
            Index].TimeOuts);
          m_fSettings.edPortRetry.Text := IntToStr(m_Profils[Index].Retry);


end;
//
//------------------------------------------------------------------------------
procedure TChanSettingsManager.RefreshWindowEx(Index:Integer);
var
i:Integer;
begin
    RefreshWindow(Index);

    m_fSettings.cbProfiles.Clear;
    for i := 0 to m_ProfilsListSize - 1 do
      m_fSettings.cbProfiles.Items.Add(m_Profils[i].ProfilName);
    m_fSettings.cbProfiles.ItemIndex := Index;

end;

//------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------
function TChanSettingsManager.OpenSettingsFile():Boolean;
begin
    //Assert(m_IniFile = Nil);

    if FileExists(ExtractFilePath(Application.ExeName) + SETTINGS_FILENAME) =
      True then
    begin
      m_IniFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+
       SETTINGS_FILENAME);
      Result := True;
    end else
    begin
      Result := False;
      m_IniFile := Nil;
    end;
end;

//------------------------------------------------------------------------------
procedure TChanSettingsManager.CloseSettingsFile();
begin
      if (m_IniFile <> Nil) then
      begin
        m_IniFile.Free;
        m_IniFile := Nil;
      end;
end;

//------------------------------------------------------------------------------
function TChanSettingsManager.InternalGetProfilesCount(var
  Count:Integer):Integer;
var
  i:Integer;
  Profiles:TStrings;
begin
  Result:= RET_OK;
  Count:=0;

  try

    if OpenSettingsFile() then
    begin

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
    finally
       CloseSettingsFile();
  end;

end;

//------------------------------------------------------------------------------
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
function TChanSettingsManager.RefreshProfilsArray():Integer;
  var
    Res, i, Index:Integer;
    Lines:TStrings;
    Name, s:string;

  begin
     try

     Res := InternalGetProfilesCount(m_ProfilsListSize);

     if OpenSettingsFile() then
      begin

      if m_IniFile = Nil then
      begin
         Result:= RET_ERR;
      end else
      begin


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

                 Name := Copy(Lines[i], 15, Length(Lines[i]));
                 if StrLen(PChar(Name)) > 0 then
                  begin

                   m_Profils[Index].ProfilName    := Name;
                   m_Profils[Index].PhoneNumber       := m_IniFile.ReadString(
                    Lines[i], KEYNAME_PHONE_NUMBER, DEFVAL_PHONE_NUMBER);
                   m_Profils[Index].ComNumber         := m_IniFile.ReadString(
                    Lines[i], KEYNAME_COM_NUMBER, DEFVAL_COM_NUMBER);
                   m_Profils[Index].BaudRateIndex     := m_IniFile.ReadInteger(
                    Lines[i], KEYNAME_BAUD_RATE_INDEX, DEFVAL_BAUD_RATE_INDEX);
                  //
                   m_Profils[Index].InactiveTimeout   := m_IniFile.ReadInteger(
                    Lines[i], KEYNAME_INACTIVE_TIMEOUT,
                    DEFVAL_INACTIVE_TIMEOUT);
                   m_Profils[Index].IsWaitTone        := m_IniFile.ReadBool(
                    Lines[i], KEYNAME_IS_WAIT_TONE, DEFVAL_IS_WAIT_TONE);
                   m_Profils[Index].IsTone            := m_IniFile.ReadBool(
                   Lines[i], KEYNAME_IS_TONE, DEFVAL_IS_WAIT_TONE);
                  //
                   m_Profils[Index].Delay         := m_IniFile.ReadInteger(
                    Lines[i], KEYNAME_DELAY_BEFORE, DEFVAL_DELAY_BEFORE);
                   m_Profils[Index].TimeOuts      := m_IniFile.ReadInteger(
                    Lines[i], KEYNAME_WAIT_ANSWER, DEFVAL_WAIT_ANSWER);
                   m_Profils[Index].Retry         := m_IniFile.ReadInteger(
                    Lines[i], KEYNAME_RETRY_COUNT, DEFVAL_RETRY_COUNT) ;

                   Index := Index + 1;
                  end;
              end;
            end;
          end;
        end;
      end;

      if m_ProfilsListSize = 0 then
      begin
        SetProfileListLength(1);

        m_Profils[0].ProfilName      := DEFVAL_PROFILE_NAME;
        m_Profils[0].PhoneNumber     := DEFVAL_PHONE_NUMBER;
        m_Profils[0].ComNumber       := DEFVAL_COM_NUMBER;
        m_Profils[0].BaudRateIndex   := DEFVAL_BAUD_RATE_INDEX;
      //
        m_Profils[0].InactiveTimeout := DEFVAL_INACTIVE_TIMEOUT;
        m_Profils[0].IsWaitTone      := DEFVAL_IS_WAIT_TONE;
        m_Profils[0].IsTone          := DEFVAL_IS_TONE;
      //
        m_Profils[0].Delay := DEFVAL_DELAY_BEFORE;
	      m_Profils[0].TimeOuts := DEFVAL_WAIT_ANSWER;
	      m_Profils[0].Retry := DEFVAL_RETRY_COUNT;

      end;
     finally
       CloseSettingsFile;
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
function TChanSettingsManager.ModifySettingsSet(
  ChannelSettings:TChannelSettings; ModifyProfType:TModifyProfType):Integer;
  var
  i:Integer;
  bRefreshed:Boolean;
  begin

    ModifySettingsFile(ChannelSettings, ModifyProfType);
    RefreshProfilsArray();
    bRefreshed := False;

    if m_ProfilsListSize > 0 then
    begin
      for i := 0 to m_ProfilsListSize - 1 do
      begin
        if CompareStr(ChannelSettings.ProfilName, m_Profils[i].ProfilName) = 0
        then
        begin
          RefreshWindowEx(i);
          bRefreshed := True;
          Break;
        end;

      end;

    end;

    if bRefreshed <> True then
      RefreshWindowEx(0);
  end;

//------------------------------------------------------------------------------
function TChanSettingsManager.ModifySettingsFile(
  ChannelSettings:TChannelSettings; ModifyProfType:TModifyProfType):Integer;
  var
  ExternalProfileName:string;
  begin
    try

      if  OpenSettingsFile() then
      begin
         Result := RET_OK;
         ExternalProfileName := PROFNAME_PREFIX + NameDll + '_' +
                 ChannelSettings.ProfilName;

         case ModifyProfType of
           TModifyProfType.CREATE_PROFILE,
           TModifyProfType.CHANGE_PROFILE:
            begin

              m_IniFile.WriteString(ExternalProfileName, KEYNAME_PROFILE_NAME,
                ChannelSettings.ProfilName);
              m_IniFile.WriteString(ExternalProfileName, KEYNAME_PHONE_NUMBER,
                ChannelSettings.PhoneNumber);
              m_IniFile.WriteString(ExternalProfileName, KEYNAME_COM_NUMBER,
                ChannelSettings.ComNumber);
              m_IniFile.WriteString(ExternalProfileName, KEYNAME_COM_NUMBER,
                ChannelSettings.ComNumber);
              m_IniFile.WriteInteger(ExternalProfileName,
                KEYNAME_BAUD_RATE_INDEX, ChannelSettings.BaudRateIndex);
              //
              m_IniFile.WriteInteger(ExternalProfileName,
                KEYNAME_INACTIVE_TIMEOUT, ChannelSettings.InactiveTimeout);
              m_IniFile.WriteBool(ExternalProfileName, KEYNAME_IS_WAIT_TONE,
                ChannelSettings.IsWaitTone);
              m_IniFile.WriteBool(ExternalProfileName, KEYNAME_IS_TONE,
                ChannelSettings.IsTone);
              //
              m_IniFile.WriteInteger(ExternalProfileName, KEYNAME_DELAY_BEFORE,
                ChannelSettings.Delay);
              m_IniFile.WriteInteger(ExternalProfileName, KEYNAME_WAIT_ANSWER,
                ChannelSettings.TimeOuts);
              m_IniFile.WriteInteger(ExternalProfileName, KEYNAME_RETRY_COUNT,
                ChannelSettings.Retry);
            end;

           DELETE_PROFILE:
            begin
               if m_IniFile.SectionExists(ExternalProfileName) then
                  m_IniFile.EraseSection(ExternalProfileName);

            end;
         end;

      end else
        Result := RET_ERR;
    finally
      CloseSettingsFile();
    end;

  end;

//------------------------------------------------------------------------------
function TChanSettingsManager.GetProfileByName(ProfileName:String;
        var Settings:TChannelSettings):Integer;
var
  i:Integer;
begin

     if (RefreshProfilsArray() <> RET_OK) then
     begin
        Result := RET_ERR;
        Exit;
     end;

     Result := RET_ERR;
     for i := 0 to m_ProfilsListSize do
     begin
        if (ProfileName = m_Profils[i].ProfilName) then
        begin
          Settings := m_Profils[i];
          Result := RET_OK;
          Break;
        end;
     end;
end;
//------------------------------------------------------------------------------
//                    TfSettings implementation
//------------------------------------------------------------------------------
procedure TfSettings.FillSettingsOfWindow(var ChannelSettings:TChannelSettings);
  begin

   ChannelSettings.ProfilName     := cbProfiles.Items[cbProfiles.ItemIndex];
   ChannelSettings.PhoneNumber    := edPhoneNumber.Text;
   ChannelSettings.ComNumber      := cbComPort.Items[cbComPort.ItemIndex];
   ChannelSettings.BaudRateIndex  := cbBaudRate.ItemIndex;
   //
   ChannelSettings.InactiveTimeout := StrToInt(edInactiveTimeout.Text);
   ChannelSettings.IsWaitTone      := cbWaitTone.Checked;
   ChannelSettings.IsTone          := cbToneType.Checked;
   //
   ChannelSettings.Delay := StrToInt(edPortDelayBeforeSend.Text);
   ChannelSettings.TimeOuts := StrToInt(edPortDeleyWaitAnswer.Text);
   ChannelSettings.Retry := StrToInt(edPortRetry.Text);
  end;

//------------------------------------------------------------------------------
procedure TfSettings.btChangeProfClick(Sender: TObject);
var
 ChannelSettings:TChannelSettings;
 OkPressed:Boolean;
begin
  FillSettingsOfWindow(ChannelSettings);

   AddProfileWrapper := TAddProfileWrapper.createAddProfile(
      TModifyProfType.CHANGE_PROFILE, ChannelSettings, Self);

   OkPressed := AddProfileWrapper.ShowSettingsWindow();
   AddProfileWrapper.Destroy;

   if OkPressed then
    OwnerModifySettingsSet(ChannelSettings, TModifyProfType.CHANGE_PROFILE);
end;
//------------------------------------------------------------------------------
procedure TfSettings.btCreateProfClick(Sender: TObject);
   var
    ChannelSettings:TChannelSettings;
    OkPressed:Boolean;
    ProfileName:string;
 begin
   FillSettingsOfWindow(ChannelSettings);
   ChannelSettings.ProfilName := EMPTY_PROFILE_NAME;

   AddProfileWrapper := TAddProfileWrapper.createAddProfile(
     TModifyProfType.CREATE_PROFILE, ChannelSettings, Self);

   OkPressed := AddProfileWrapper.ShowSettingsWindow(
     ChannelSettings.ProfilName);

   AddProfileWrapper.Destroy;
   if OkPressed then
     OwnerModifySettingsSet(ChannelSettings, TModifyProfType.CREATE_PROFILE);
end;
//------------------------------------------------------------------------------
procedure TfSettings.btDelProfClick(Sender: TObject);
var
  ChannelSettings:TChannelSettings;
  OkPressed:Boolean;
begin
     FillSettingsOfWindow(ChannelSettings);

     AddProfileWrapper := TAddProfileWrapper.createAddProfile(
        TModifyProfType.DELETE_PROFILE, ChannelSettings, Self);

     OkPressed := AddProfileWrapper.ShowSettingsWindow();
     AddProfileWrapper.Destroy;
     if OkPressed then
       OwnerModifySettingsSet(ChannelSettings, TModifyProfType.DELETE_PROFILE);

end;
procedure TfSettings.btOkClick(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------
procedure TfSettings.cbProfilesSelect(Sender: TObject);
begin
    OwnerRefresfWindow(cbProfiles.ItemIndex);
end;
//------------------------------------------------------------------------------

end.

