unit HAYESSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,
  IniFiles,
  HAYESConstants,
  HAYESCaptions;

type

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
  private
    { Private declarations }
  public
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
constructor TChanSettingsManager.create();
var
  pc:PChar;
  Res:Integer;
begin

    try
        m_fSettings := TfSettings.Create(Application);

        //m_fSettings.OwnerRefresfWindow := RefreshWindow;
        //m_fSettings.OwnerModifySettingsSet := ModifySettingsSet;

        if GetDescription(Integer(TDescriptionID.DESC_PHONE_NUMBER), pc) = RET_OK then
          m_fSettings.gbPhoneNumber.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_COM_PORT), pc) = RET_OK then
          m_fSettings.gbComPort.Caption := string(pc);

        if GetDescription(Integer(TDescriptionID.DESC_LABEL_COM), pc) = RET_OK then
          m_fSettings.lbPortName.Caption := string(pc);

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


        m_LibSettings.ProfilName      := DEFVAL_PROFILE_NAME;
        m_LibSettings.PhoneNumber     := DEFVAL_PHONE_NUMBER;
        m_LibSettings.ComNumber       := DEFVAL_COM_NUMBER;
        m_LibSettings.BaudRateIndex   := DEFVAL_BAUD_RATE_INDEX;
      //
        m_LibSettings.InactiveTimeout := DEFVAL_INACTIVE_TIMEOUT;
        m_LibSettings.IsWaitTone      := DEFVAL_IS_WAIT_TONE;
        m_LibSettings.IsTone          := DEFVAL_IS_TONE;
      //
        m_LibSettings.Delay := DEFVAL_DELAY_BEFORE;
	      m_LibSettings.TimeOuts := DEFVAL_WAIT_ANSWER;
	      m_LibSettings.Retry := DEFVAL_RETRY_COUNT;

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

//
//        RefreshWindow(0);

    Except
         m_fSettings := Nil;
         m_IniFile := Nil;
    end;
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
//N - ��� ���������� ����� � ������

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

                 Name := Copy(Lines[i], 18, Length(Lines[i]));
                 if StrLen(PChar(Name)) > 0 then
                  begin

                   m_Profils[Index].ProfilName    := Name;
                   m_Profils[0].PhoneNumber       := m_IniFile.ReadString(
                    Lines[i], KEYNAME_PHONE_NUMBER, DEFVAL_PHONE_NUMBER);
                   m_Profils[0].ComNumber         := m_IniFile.ReadString(
                    Lines[i], KEYNAME_COM_NUMBER, DEFVAL_COM_NUMBER);
                   m_Profils[0].BaudRateIndex     := m_IniFile.ReadInteger(
                    Lines[i], KEYNAME_BAUD_RATE_INDEX, DEFVAL_BAUD_RATE_INDEX);
                  //
                   m_Profils[0].InactiveTimeout   := m_IniFile.ReadInteger(
                    Lines[i], KEYNAME_INACTIVE_TIMEOUT,
                    DEFVAL_INACTIVE_TIMEOUT);
                   m_Profils[0].IsWaitTone        := m_IniFile.ReadBool(
                    Lines[i], KEYNAME_IS_WAIT_TONE, DEFVAL_IS_WAIT_TONE);
                   m_Profils[0].IsTone            := m_IniFile.ReadBool(
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

end.