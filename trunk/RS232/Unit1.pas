unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, IniFiles, OoMisc, AdPort, ScktComp;



type
  TFormProperties = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    cbPort: TComboBox;
    cbBaudRate: TComboBox;
    cbParity: TComboBox;
    cbByteSize: TComboBox;
    cbStopBits: TComboBox;
    cbFlow: TComboBox;
    edPortDelayBeforeSend: TEdit;
    CheckBox1: TCheckBox;
    GroupBox2: TGroupBox;
    cbChangeProf: TComboBox;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    edPortDeleyWaitAnswer: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edPortRetry: TEdit;
    ButtonOK: TButton;
    Button1: TButton;
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cbPortChange(Sender: TObject);
    procedure cbBaudRateChange(Sender: TObject);
    procedure cbByteSizeChange(Sender: TObject);
    procedure cbParityChange(Sender: TObject);
    procedure cbStopBitsChange(Sender: TObject);
    procedure cbFlowChange(Sender: TObject);
    procedure edPortDelayBeforeSendChange(Sender: TObject);
    procedure edPortDeleyWaitAnswerChange(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SerialPortTriggerAvail(CP: TObject; Count: Word);
    procedure cbChangeProfChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    procedure RefreshCOMport();
//    function GetString(Code:Integer):String;
    procedure DataChange();
  end;

var
  FormProperties: TFormProperties;
  pLangList:Pointer;
  IniFile:TIniFile;
  ApplicationPath:String;
  PortDelayBeforeSend:Integer;
  PortDeleyWaitAnswer:Integer;
  PortEhoDelete:Boolean;
  GetStr:AnsiString;
  BlockW  : array[0..8191] of Byte;
  BlockR  : array[0..8191] of Byte;
  BlockRPointer:Word;
  BlockTmp: array[0..8191] of Byte;
const
  NameDll = 'RS232';

implementation

{$R *.dfm}

function ProfileWrite(ProfileName:String):Boolean;
var
  i:Integer;
  Profile:String;
begin
Result:=False;
{for I := 1 to 10 do}
  if not IniFile.SectionExists('Profile_RS232_'+ProfileName) then
    begin
      Profile:='Profile_'+NameDll+'_'+ProfileName;
      IniFile.WriteString(Profile,'ProfileName',ProfileName);
      IniFile.WriteString(Profile,'PortName',FormProperties.cbPort.Text);
      IniFile.WriteString(Profile,'PortSpeed',FormProperties.cbBaudRate.Text);
      IniFile.WriteString(Profile,'PortDataBits',FormProperties.cbByteSize.Text);
      IniFile.WriteInteger(Profile,'PortParity',FormProperties.cbParity.ItemIndex);
      IniFile.WriteInteger(Profile,'PortStopBits',FormProperties.cbStopBits.ItemIndex);
      IniFile.WriteInteger(Profile,'PortFlow',FormProperties.cbFlow.ItemIndex);
      IniFile.WriteString(Profile,'PortDelayBeforeSend',FormProperties.edPortDelayBeforeSend.Text);
      IniFile.WriteString(Profile,'PortDeleyWaitAnswer',FormProperties.edPortDeleyWaitAnswer.Text);
      IniFile.WriteString(Profile,'PortRetry',FormProperties.edPortRetry.Text);
      IniFile.WriteBool(Profile,'PortEhoDelete',FormProperties.CheckBox1.Checked);
      Result:=True;
    end else begin
      Profile:='Profile_'+NameDll+'_'+ProfileName;
{      if IniFile.ReadString(Profile,'ProfileName','')<>ProfileName then
Continue;}
      IniFile.WriteString(Profile,'ProfileName',ProfileName);
      IniFile.WriteString(Profile,'PortName',FormProperties.cbPort.Text);
      IniFile.WriteString(Profile,'PortSpeed',FormProperties.cbBaudRate.Text);
      IniFile.WriteString(Profile,'PortDataBits',FormProperties.cbByteSize.Text);
      IniFile.WriteInteger(Profile,'PortParity',FormProperties.cbParity.ItemIndex);
      IniFile.WriteInteger(Profile,'PortStopBits',FormProperties.cbStopBits.ItemIndex);
      IniFile.WriteInteger(Profile,'PortFlow',FormProperties.cbFlow.ItemIndex);
      IniFile.WriteString(Profile,'PortDelayBeforeSend',FormProperties.edPortDelayBeforeSend.Text);
      IniFile.WriteString(Profile,'PortDeleyWaitAnswer',FormProperties.edPortDeleyWaitAnswer.Text);
      IniFile.WriteString(Profile,'PortRetry',FormProperties.edPortRetry.Text);
      IniFile.WriteBool(Profile,'PortEhoDelete',FormProperties.CheckBox1.Checked);
      Result:=True;
    end;
end;

function ProfileRead(ProfileName:String):Boolean;
var
  i,n:Integer;
  Profile,TmpStr:String;
begin
Result:=False;
Profile:='Profile_'+NameDll+'_'+ProfileName;
{for I := 1 to 10 do}
  if IniFile.SectionExists(Profile) then
    begin
{      Profile:='Profile_'+NameDll+'_N'+IntToStr(i);
      if IniFile.ReadString(Profile,'ProfileName','')<>ProfileName then
      Continue;    }

      TmpStr:=IniFile.ReadString(Profile,'PortName',FormProperties.cbPort.Text);
      for n := 0 to FormProperties.cbPort.Items.Count - 1 do
        if FormProperties.cbPort.Items[n]=TmpStr then FormProperties.cbPort.ItemIndex:=n;

      TmpStr:=IniFile.ReadString(Profile,'PortSpeed',FormProperties.cbBaudRate.Text);
      for n := 0 to FormProperties.cbBaudRate.Items.Count - 1 do
        if FormProperties.cbBaudRate.Items[n]=TmpStr then FormProperties.cbBaudRate.ItemIndex:=n;

      TmpStr:=IniFile.ReadString(Profile,'PortDataBits',FormProperties.cbBaudRate.Text);
      for n := 0 to FormProperties.cbBaudRate.Items.Count - 1 do
        if FormProperties.cbByteSize.Items[n]=TmpStr then FormProperties.cbByteSize.ItemIndex:=n;

      FormProperties.cbParity.ItemIndex:=IniFile.ReadInteger(Profile,'PortParity',FormProperties.cbParity.ItemIndex);
      FormProperties.cbStopBits.ItemIndex:=IniFile.ReadInteger(Profile,'PortStopBits',StrToInt(FormProperties.cbStopBits.Text));
      FormProperties.cbFlow.ItemIndex:=IniFile.ReadInteger(Profile,'PortFlow',FormProperties.cbFlow.ItemIndex);

      FormProperties.edPortDelayBeforeSend.Text:=IniFile.ReadString(Profile,'PortDelayBeforeSend',FormProperties.edPortDelayBeforeSend.Text);
      FormProperties.edPortDeleyWaitAnswer.Text:=IniFile.ReadString(Profile,'PortDeleyWaitAnswer',FormProperties.edPortDeleyWaitAnswer.Text);
      FormProperties.edPortRetry.Text:= IniFile.ReadString(Profile,'PortRetry',FormProperties.edPortRetry.Text);
      FormProperties.CheckBox1.Checked:=IniFile.ReadBool(Profile,'PortEhoDelete',FormProperties.CheckBox1.Checked);
      Result:=True;
    end;
end;

function ProfileDelete(ProfileName:String):Boolean;
var
  i:Integer;
  Profile:String;
begin
Result:=False;
{for I := 1 to 10 do}
  if IniFile.SectionExists('Profile_'+NameDll+'_'+ProfileName) then
    begin
      Profile:='Profile_'+NameDll+'_'+ProfileName;
      if IniFile.ValueExists(Profile,'ProfileName') then
        if IniFile.ReadString(Profile,'ProfileName','')=ProfileName then
          begin
            IniFile.EraseSection(Profile);
            Result:=True;;
          end;

    end;
end;

procedure ProfileField();
var
  i,P:Integer;
  Profile:String;
  Profiles:TStrings;
begin
  FormProperties.cbChangeProf.Clear;
  {  for I := 1 to 10 do}
  Profiles:=TStringList.Create;
IniFile.ReadSections(Profiles);
for i := 0 to Profiles.Count-1 do
      begin
        if Pos('Profile_RS232_',Profiles[i])=1 then
          begin;
            Profile:=Copy(Profiles[i],15,Length(Profiles[i]));
            FormProperties.cbChangeProf.Items.Add(Profile);
          end;
      end;
  FormProperties.cbChangeProf.ItemIndex:=0;
end;

procedure TFormProperties.RefreshCOMport();
var
  reg : TRegistry;
  ts : TStrings;
  i:Integer;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKey('hardware\devicemap\serialcomm', false);
  ts := TStringList.Create;
  reg.GetValueNames(ts);

  cbPort.Items.Clear;
  for i := 0 to ts.Count -1 do
  cbPort.Items.Add(reg.ReadString(ts.Strings[i]));
  if cbPort.Items.Count>=0 then cbPort.ItemIndex:=0;
  ts.Free;
  reg.CloseKey;
  reg.free;
end;

procedure TFormProperties.SerialPortTriggerAvail(CP: TObject; Count: Word);
var
  i:Integer;
begin
//FormProperties.SerialPort.GetBlock(BlockTmp,Count);
for i:= 0 to Count - 1 do
    begin
      BlockR[BlockRPointer]:=BlockTmp[i];
      BlockRPointer:=BlockRPointer+1;
    end;
end;

procedure TFormProperties.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TFormProperties.Button2Click(Sender: TObject);
begin
ProfileDelete(cbChangeProf.Text);
cbChangeProf.DeleteSelected;
cbChangeProf.ItemIndex:=0;
ProfileRead(cbChangeProf.Text);
end;

procedure TFormProperties.Button3Click(Sender: TObject);
begin
  RefreshCOMport;
end;

procedure TFormProperties.FormShow(Sender: TObject);
begin
  RefreshCOMport;
  ProfileField;
  ProfileRead(cbChangeProf.Text);
end;

procedure TFormProperties.ButtonOKClick(Sender: TObject);
begin
if cbChangeProf.Text<>'' then
  begin
{    i:=cbChangeProf.Items.Add(cbChangeProf.Text);   }
    cbChangeProf.ItemIndex:=cbChangeProf.Items.Add(cbChangeProf.Text);;
    ProfileWrite(cbChangeProf.Text);
    Close;
  end
  else
    Showmessage('Не введено имя профиля');
end;

procedure TFormProperties.CheckBox1Click(Sender: TObject);
begin
DataChange;
end;


procedure TFormProperties.cbBaudRateChange(Sender: TObject);
begin
DataChange;
end;

procedure TFormProperties.cbByteSizeChange(Sender: TObject);
begin
DataChange;
end;

procedure TFormProperties.cbChangeProfChange(Sender: TObject);
begin
ProfileRead(cbChangeProf.Text);
end;

procedure TFormProperties.cbFlowChange(Sender: TObject);
begin
DataChange;
end;

procedure TFormProperties.cbParityChange(Sender: TObject);
begin
DataChange;
end;

procedure TFormProperties.cbPortChange(Sender: TObject);
begin
DataChange;
end;

procedure TFormProperties.cbStopBitsChange(Sender: TObject);
begin
DataChange;
end;

procedure TFormProperties.DataChange();
begin
  if cbChangeProf.Text<>'' then ButtonOK.Enabled:=True;
end;

procedure TFormProperties.edPortDelayBeforeSendChange(Sender: TObject);
begin
DataChange;
end;

procedure TFormProperties.edPortDeleyWaitAnswerChange(Sender: TObject);
begin
DataChange;
end;

end.



