unit HAYESAddProfileSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  HAYESConstants,
  HAYESSettings,
  HAYESCaptions;

type
  TfNewProfile = class(TForm)
    gbProfile: TGroupBox;
    lbProfileName: TLabel;
    edProfileName: TEdit;
    gbSettingsNewProfile: TGroupBox;
    gbPhoneNumber: TGroupBox;
    edPhoneNumber: TEdit;
    gbComPort: TGroupBox;
    lbPortName: TLabel;
    lbBaudRate: TLabel;
    gbConnectionSettings: TGroupBox;
    lbInactiveTimeout: TLabel;
    edInactiveTimeout: TEdit;
    cbWaitTone: TCheckBox;
    cbToneType: TCheckBox;
    gbExchangeSettings: TGroupBox;
    lbPortDelayBeforeSend: TLabel;
    lbPortDeleyWaitAnswer: TLabel;
    lbRetry: TLabel;
    edPortRetry: TEdit;
    edPortDeleyWaitAnswer: TEdit;
    edPortDelayBeforeSend: TEdit;
    btCancel: TButton;
    btOk: TButton;
    edComPort: TEdit;
    edBaudRate: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
   OkButtonPressed:Boolean;
  end;
//------------------------------
//------------------------------
  TAddProfileWrapper = class
  private
    m_NewProfile:TfNewProfile;
  public

    constructor create(Owner:TForm);
    constructor createAddProfile(WindowType: TModifyProfType;
      ChannelSettings:TChannelSettings; Owner:TForm);
    function ShowSettingsWindow(var profileName:string):Boolean; Overload;
    function ShowSettingsWindow():Boolean; Overload;

  end;
//------------------------------
//------------------------------
var
  AddProfileWrapper:TAddProfileWrapper;

implementation
{$R *.dfm}

//------------------------------------------------------------------------------
//                    TAddProfileWrapper
//------------------------------------------------------------------------------
constructor TAddProfileWrapper.createAddProfile(WindowType: TModifyProfType;
      ChannelSettings:TChannelSettings; Owner:TForm);
    var
      pc:PChar;
      Res:Integer;
    begin
       try

          if m_NewProfile <> nil then
             m_NewProfile.Destroy;

          m_NewProfile := TfNewProfile.Create(Application);

          if WindowType = TModifyProfType.CREATE_PROFILE then
          begin
             if GetDescription(Integer(TDescriptionID.DESC_NEW_PROFILE), pc) = RET_OK then
              m_NewProfile.Caption := string(pc);
          end else if WindowType = TModifyProfType.CHANGE_PROFILE then
          begin
              if GetDescription(Integer(TDescriptionID.DESC_CONFIRM_MODIFY_PROF), pc) = RET_OK then
                m_NewProfile.Caption := string(pc);
          end else if WindowType = TModifyProfType.DELETE_PROFILE then
          begin
              if GetDescription(Integer(TDescriptionID.DESC_CONFIRM_DELETE_PROF), pc) = RET_OK then
                m_NewProfile.Caption := string(pc);
          end;

          if GetDescription(Integer(TDescriptionID.DESC_PROFILE), pc) = RET_OK then
            m_NewProfile.gbProfile.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_PROFILE_NAME), pc) = RET_OK then
            m_NewProfile.lbProfileName.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_SETTINGS_OF_NEW_PROF), pc) = RET_OK then
            m_NewProfile.gbSettingsNewProfile.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_PHONE_NUMBER), pc) = RET_OK then
           m_NewProfile.gbPhoneNumber.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_COM_PORT), pc) = RET_OK then
            m_NewProfile.gbComPort.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_LABEL_COM), pc) = RET_OK then
            m_NewProfile.lbPortName.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_INACTIVE_TIMEOUT),
            pc) = RET_OK then
               m_NewProfile.lbInactiveTimeout.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_CONNECT), pc) = RET_OK then
           m_NewProfile.gbConnectionSettings.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_COM_BAUD_RATE), pc) = RET_OK then
            m_NewProfile.lbBaudRate.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_WAIT_TONE), pc) = RET_OK then
            m_NewProfile.cbWaitTone.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_TONE_CALL), pc) = RET_OK then
            m_NewProfile.cbToneType.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_EXCHANGE_SETTINGS), pc) = RET_OK then
            m_NewProfile.gbExchangeSettings.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_DELAY_BEFORE_SEND), pc) = RET_OK then
            m_NewProfile.lbPortDelayBeforeSend.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_DELAY_WAIT_ANSWER), pc) = RET_OK then
            m_NewProfile.lbPortDeleyWaitAnswer.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_RETRY_COUNT), pc) = RET_OK then
            m_NewProfile.lbRetry.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_CANCEL_BUTTON), pc) = RET_OK then
            m_NewProfile.btCancel.Caption := string(pc);

          if WindowType = TModifyProfType.CREATE_PROFILE then
          begin
              if GetDescription(Integer(TDescriptionID.DESC_CREATE_PROFILE),
                pc) = RET_OK then
                 m_NewProfile.btOk.Caption := string(pc);
          end else if WindowType = TModifyProfType.CHANGE_PROFILE then
          begin
              if GetDescription(Integer(TDescriptionID.DESC_CHANGE_PROFILE),
                pc) = RET_OK then
                  m_NewProfile.btOk.Caption := string(pc);
          end else if WindowType = TModifyProfType.DELETE_PROFILE then
          begin
             if GetDescription(Integer(TDescriptionID.DESC_DELETE_PROFILE),
                pc) = RET_OK then
                  m_NewProfile.btOk.Caption := string(pc);
          end;


          if WindowType <> TModifyProfType.CREATE_PROFILE then
          begin
            m_NewProfile.edProfileName.Enabled := False;
            m_NewProfile.edProfileName.Text := ChannelSettings.ProfilName;
          end;


          m_NewProfile.edPhoneNumber.Enabled := False;
          m_NewProfile.edPhoneNumber.Text := ChannelSettings.PhoneNumber;

          m_NewProfile.edComPort.Enabled := False;
          m_NewProfile.edComPort.Text := ChannelSettings.ComNumber;

          m_NewProfile.edBaudRate.Enabled := False;
          m_NewProfile.edBaudRate.Text :=
            IntToStr(BaudRate[ChannelSettings.BaudRateIndex]);

          m_NewProfile.edInactiveTimeout.Enabled := False;
          m_NewProfile.edInactiveTimeout.Text :=
            IntToStr(ChannelSettings.InactiveTimeout);

          m_NewProfile.cbWaitTone.Enabled := False;
          m_NewProfile.cbWaitTone.Checked := ChannelSettings.IsWaitTone;

          m_NewProfile.cbToneType.Enabled := False;
          m_NewProfile.cbToneType.Checked := ChannelSettings.IsTone;

          m_NewProfile.edPortDelayBeforeSend.Enabled := False;
          m_NewProfile.edPortDelayBeforeSend.Text := IntToStr(ChannelSettings.Delay);

          m_NewProfile.edPortDeleyWaitAnswer.Enabled := False;
          m_NewProfile.edPortDeleyWaitAnswer.Text := IntToStr(ChannelSettings.TimeOuts);

          m_NewProfile.edPortRetry.Enabled := False;
          m_NewProfile.edPortRetry.Text := IntToStr(ChannelSettings.Retry);

       Except
          m_NewProfile := Nil;
      end;
    end;
//------------------------------------------------------------------------------
  constructor TAddProfileWrapper.create(Owner:TForm);
    var
      pc:PChar;
      Res:Integer;
    begin
    if m_NewProfile <> Nil then
      m_NewProfile.Destroy;

    m_NewProfile := TfNewProfile.Create(Owner);

    end;


//------------------------------------------------------------------------------
    function TAddProfileWrapper.ShowSettingsWindow(var profileName:string):Boolean;
    begin
       if m_NewProfile <> Nil then
          m_NewProfile.ShowModal();

       Result := m_NewProfile.OkButtonPressed;
       if Result then
          profileName := m_NewProfile.edProfileName.Text;

       m_NewProfile.Destroy;
    end;
//------------------------------------------------------------------------------
    function TAddProfileWrapper.ShowSettingsWindow():Boolean;
    begin
       if m_NewProfile <> Nil then
          m_NewProfile.ShowModal();

       Result := m_NewProfile.OkButtonPressed;

       m_NewProfile.Destroy;
    end;

//------------------------------------------------------------------------------
procedure TfNewProfile.btCancelClick(Sender: TObject);
begin
    OkButtonPressed := False;
    Close;
end;

//------------------------------------------------------------------------------
procedure TfNewProfile.btOkClick(Sender: TObject);
var
  pcCap, pcText:PChar;
begin
  if StrLen(PWideChar(edProfileName.Text)) > 0 then
  begin
     OkButtonPressed := True;
     Close;
  end else
  begin
      GetDescription(Integer(TDescriptionID.DESC_ERROR_WIN_CAP), pcCap);
      GetDescription(Integer(TDescriptionID.DESC_ERR_PROF_NAME_EPTY), pcText);
      Application.MessageBox(PWideChar(pcText), PWideChar(pcCap), mb_iconerror
        or MB_OK);
  end;
end;

//------------------------------------------------------------------------------
procedure TfNewProfile.FormShow(Sender: TObject);
begin
   OkButtonPressed := False;
end;

end.
