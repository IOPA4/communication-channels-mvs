unit EthernetCaptions;

interface
uses
  SysUtils,
  Forms,
  IniFiles,
  EthernetErrors;

  function GetDescription(DescID:Integer; var pDesc:PChar):Integer;
  function InitDescriptionsArray(pLang:Pointer):Integer;
  Procedure OutSwapDescriptions();
type

  TDescriptionID = (
    DESC_TCPIP = 0,                 //'TCP/IP',
    DESC_IP_ADDRESS,                //'IP �����',
    DESC_TCP_PORT,                  //'����',
    DESC_PROFILS,                   //'�������'
    DESC_EXCHANGE_SETTINGS,         //'��������� ������',
    DESC_DELAY_BEFORE_SEND,         //'�������� ����� ���������',
    DESC_DELAY_WAIT_ANSWER,         //'����� �������� ������',
    DESC_RETRY_COUNT,               //'���-�� ������������',
    DESC_CREATE_PROFILE,            //'�������',
    DESC_CHANGE_PROFILE,            //'��������',
    DESC_DELETE_PROFILE,            //'�������',
    DESC_PROFILE_NAME,              //'�������� �������',
    DESC_NEW_PROFILE,               //'�������� �������',
    DESC_PROFILE,                   //'�������',
    DESC_SETTINGS_OF_NEW_PROF,      //'��������� ��� ����������',
    DESC_OK_BUTTON,                 //'Ok'
    DESC_CANCEL_BUTTON,             //'������'
    DESC_ERROR_WIN_CAP,             //'������...'
    DESC_ERR_PROF_NAME_EPTY,        //'������� �������� �������.'
    DESC_CONFIRM_MODIFY_PROF,       //'����������� ��������� �������'
    DESC_CONFIRM_DELETE_PROF,       //'����������� �������� �������'

    DESC_N
  );

var
  Descriptions: array [0..Integer(TDescriptionID.DESC_N) - 1] of String = (

    'TCP/IP',
    'IP �����',
    '����',
    '�������',
    '��������� ������',
    '�������� ����� ���������',
    '����� �������� ������',
    '���-�� ������������',
    '�������',
    '��������',
    '�������',
    '�������� �������',
    '�������� �������',
    '�������',
    '��������� ��� ����������',
    'Ok',
    '������',
    '������...',
    '������� �������� �������.',
    '����������� ��������� �������',
    '����������� �������� �������'
  );

implementation

//------------------------------------------------------------------------------
function GetDescription(DescID:Integer; var pDesc:PChar):Integer;
begin
     if DescID < Integer(TDescriptionID.DESC_N) then
     begin
        pDesc := PChar(Descriptions[DescID]);
        Result := RET_OK;
     end else
        Result := RET_ERR;
end;

//------------------------------------------------------------------------------
function InitDescriptionsArray(pLang:Pointer):Integer;
var
  IniFile:TIniFile;
  i:Integer;
  HexNum:string;
begin
  Result := RET_ERR;
//  IniFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+
//            'Ethernet_' + string(pLang) + ".lng");
   IniFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+
            'Ethernet_rus.lng');
   if (IniFile <> nil) then
   begin
    for i := 0 to Integer(TDescriptionID.DESC_N) - 1  do
    begin
      HexNum :=  '$'+Format('%.2x',[i]);
      Descriptions[i] := IniFile.ReadString('Captions', HexNum, HexNum);
    end;
      Result := RET_OK;
   end;
end;

//------------------------------------------------------------------------------

Procedure OutSwapDescriptions();
var
  IniFile:TIniFile;
  i:Integer;
  HexNum:string;
begin
    IniFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+
            'Ethernet_rus.lng');
   if (IniFile <> nil) then
   begin
    for i := 0 to Integer(TDescriptionID.DESC_N) - 1  do
    begin
      HexNum :=  '$'+Format('%.2x',[i]);
      IniFile.WriteString('Captions', HexNum, Descriptions[i]);
    end;
   end;

end;

end.
