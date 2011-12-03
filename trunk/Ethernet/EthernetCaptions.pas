unit EthernetCaptions;

interface
uses
  EthernetErrors;

  function GetDescription(DescID:Integer; var pDesc:PChar):Integer;


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

const
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

function GetDescription(DescID:Integer; var pDesc:PChar):Integer;
begin
     if DescID < Integer(TDescriptionID.DESC_N) then
     begin
        pDesc := PChar(Descriptions[DescID]);
        Result := RET_OK;
     end else
        Result := RET_ERR;
end;

end.
