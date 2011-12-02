unit AddProfileSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask,
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
  private
    { Private declarations }
  public
    OkButtonPressed:Boolean;
    { Public declarations }
  end;
//--------------------------------------------------------
  TAddProfileWrapper = class
  private
    m_NewProfile:TfNewProfile;
  public

    //constructor createAddProfile(ChannelSettings:TChannelSettings);
    constructor create(Owner:TForm);
    constructor createAddProfile(ChannelSettings:TChannelSettings; Owner:TForm);
    function ShowSettingsWindow():Boolean;

  end;
var
  AddProfileWrapper:TAddProfileWrapper;

implementation

{$R *.dfm}
    constructor TAddProfileWrapper.createAddProfile(ChannelSettings:TChannelSettings; Owner:TForm);
    var
      pc:PChar;
      Res:Integer;
    begin
       try


          if m_NewProfile <> nil then
             m_NewProfile.Destroy;

          m_NewProfile := TfNewProfile.Create(Application);

          if GetDescription(Integer(TDescriptionID.DESC_NEW_PROFILE), pc) = RET_OK then
            m_NewProfile.Caption := string(pc);

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

          if GetDescription(Integer(TDescriptionID.DESC_OK_BUTTON), pc) = RET_OK then
            m_NewProfile.btOk.Caption := string(pc);

          if GetDescription(Integer(TDescriptionID.DESC_CANCEL_BUTTON), pc) = RET_OK then
            m_NewProfile.btCancel.Caption := string(pc);

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

  constructor TAddProfileWrapper.create(Owner:TForm);
    var
      pc:PChar;
      Res:Integer;
    begin
    if m_NewProfile <> Nil then
      m_NewProfile.Destroy;

    m_NewProfile := TfNewProfile.Create(Owner);

    end;

    function TAddProfileWrapper.ShowSettingsWindow():Boolean;
    begin
       if m_NewProfile <> Nil then
          m_NewProfile.ShowModal();

       Result := m_NewProfile.OkButtonPressed;
    end;



procedure TfNewProfile.FormShow(Sender: TObject);
begin
    OkButtonPressed := False;
end;

end.
