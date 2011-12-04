unit AddProfileSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask,
  EthernetConstants,
  EthernetSettings,
  EthernetCaptions,
  EthernetErrors;

type
  TfNewProfile = class(TForm)
    gbMainSettings: TGroupBox;
    lbIpAddr: TLabel;
    lbPort: TLabel;
    edPort: TEdit;
    gbExchangeSettings: TGroupBox;
    lbPortDelayBeforeSend: TLabel;
    lbPortDeleyWaitAnswer: TLabel;
    lbRetry: TLabel;
    edPortRetry: TEdit;
    edPortDeleyWaitAnswer: TEdit;
    edPortDelayBeforeSend: TEdit;
    gbProfile: TGroupBox;
    edProfileName: TEdit;
    lbProfileName: TLabel;
    btOk: TButton;
    btCancel: TButton;
    gbSettingsNewProfile: TGroupBox;
    edIP: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    OkButtonPressed:Boolean;
    { Public declarations }
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

          if GetDescription(Integer(TDescriptionID.DESC_TCPIP), pc) = RET_OK then
            m_NewProfile.gbMainSettings.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_IP_ADDRESS), pc) = RET_OK then
            m_NewProfile.lbIpAddr.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_TCP_PORT), pc) = RET_OK then
            m_NewProfile.lbPort.Caption := string(pc);

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

          m_NewProfile.edIP.Enabled := False;
          m_NewProfile.edIP.Text := ChannelSettings.IP;

          m_NewProfile.edPort.Enabled := False;
          m_NewProfile.edPort.Text := IntToStr(ChannelSettings.Port);

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
//              TfNewProfile
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
      Application.MessageBox(PWideChar(pcText), PWideChar(pcCap), mb_iconerror or MB_OK);
  end;
end;

//------------------------------------------------------------------------------
procedure TfNewProfile.FormShow(Sender: TObject);
begin
    OkButtonPressed := False;
end;

end.
