unit SDIMAIN;

interface

uses Windows, Classes, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, StdActns,
  ActnList, ToolWin, ScktComp;

type
  TSDIAppForm = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ToolBar1: TToolBar;
    ToolButton9: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    HelpAbout1: TAction;
    StatusBar: TStatusBar;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    dlgOpenFile: TOpenDialog;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure btConnectClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TfnChannelShowWindow = function :Integer;
  TfnChannelSetSettings = function :Integer;
  TfnChannelGetStatus = function :Integer;
  TfnChannelOpen = function (ProfileName:PChar):Integer;
  TfnChannelClose = function :Integer;
  TfnChannelWrite = function (pBlock:Pointer;Count:Word):Integer;
  TfnChannelRead = function (pBlock:Pointer; var Count:Word):Integer;
  TfnChannelGetProfilesCount = function (var Count:Integer):Integer;
  TfnChannelGetProfilesName = function(N:Integer; var ProfileName:PChar):Integer;
  TfnChannelConnectDll = function (pLang:Pointer):Integer;

var
  SDIAppForm: TSDIAppForm;
  hDll:THandle;

  fnChannelShowWindow :TfnChannelShowWindow;
  fnChannelSetSettings :TfnChannelSetSettings;
  fnChannelGetStatus :TfnChannelGetStatus;
  fnChannelOpen :TfnChannelOpen;
  fnChannelClose :TfnChannelClose;
  fnChannelWrite :TfnChannelWrite;
  fnChannelRead :TfnChannelRead;
  fnChannelGetProfilesCount :TfnChannelGetProfilesCount;
  fnChannelGetProfilesName :TfnChannelGetProfilesName;
  fnChannelConnectDll :TfnChannelConnectDll;

implementation

uses about;

{$R *.dfm}

procedure TSDIAppForm.FileNew1Execute(Sender: TObject);
begin
  { Do nothing }
end;

procedure TSDIAppForm.FileOpen1Execute(Sender: TObject);
var
Temp:Integer;
begin

  if (dlgOpenFile.Execute(SDIAppForm.Handle)) then
     hDll := LoadLibrary(PWideChar(dlgOpenFile.FileName));

     if hDll <> 0 then
     Begin
     //Получение адресов функций
        fnChannelShowWindow := getProcAddress(hDll, PWideChar(
           'Channel_ShowWindow'));
        fnChannelSetSettings := getProcAddress(hDll, PWideChar(
            'Channel_SetSettings'));
        fnChannelGetStatus := getProcAddress(hDll, PWideChar(
            'Channel_GetStatus'));
        fnChannelOpen := getProcAddress(hDll, PWideChar('Channel_Open'));
        fnChannelClose := getProcAddress(hDll, PWideChar('Channel_Close'));
        fnChannelWrite := getProcAddress(hDll, PWideChar('Channel_Write'));
        fnChannelRead := getProcAddress(hDll, PWideChar('Channel_Read'));
        fnChannelGetProfilesCount := getProcAddress(hDll, PWideChar(
          'Channel_GetProfilesCount'));
        fnChannelGetProfilesName := getProcAddress(hDll, PWideChar(
          'Channel_GetStatus'));
        fnChannelConnectDll := getProcAddress(hDll, PWideChar(
          'Channel_ConnectDll'));

        //--
        fnChannelConnectDll(PChar('rus'));
        fnChannelShowWindow();
        FreeLibrary(hDll);
     End;


end;

procedure TSDIAppForm.FileSave1Execute(Sender: TObject);
begin
  SaveDialog.Execute;
end;



procedure TSDIAppForm.btConnectClick(Sender: TObject);
var
r:Integer;
begin
    r:=fnChannelOpen(PChar('SSS'));
end;

procedure TSDIAppForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TSDIAppForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

end.
