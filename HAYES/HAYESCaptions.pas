unit HAYESCaptions;

interface
 uses
  HAYESConstants;

  function GetDescription(DescID:Integer; var pDesc:PChar):Integer;
  function GetErrorDescription(ErrorID:Integer; var pDesc:PChar):Integer;

  type

   TErrorID = (
    ERR_DONT_ACTIVATED,
    ERR_MODEM_NOT_RESP,
    ERR_DONT_HAYES,
    ERR_BAD_CABLE_OR_DONT_HAYES,
    ERR_CANT_CONNECT,
    ERR_CONNECTION_BROKEN,
    ERR_NOT_PNONE_NUMBER,
    ERR_CONNECTION_BREAKED_BY_USER,
    ERR_SECOND_DIALOG,
    ERR_SETSETTTING_ON_CONNECT,
    ERR_REGISTRY,
    ERR_INC_SETTINGS_STR,
    ERR_INC_SETTINGS,
    ERR_CANT_APPLY_BAUD,
    ERR_MODEM_NOT_FOUND,
    ERR_CANT_ON_CMD_MODE,

    ERRORS_N
  );

    TDescriptionID = (
    //0
    DESC_COMMON_SETTINGS = 0,       //'����� ���������',
    DESC_PHONE_NUMBER,              //����� ��������'
    DESC_CONNECT,                   //'����������'
    DESC_COM_PORT,                  //'COM-����'
    DESC_COM_NUM,                   //'����� COM-�����'
    DESC_COM_BAUD_RATE,             //'��������'
    DESC_COM_BYTE_SIZE,             //'���� ������'
    //1
    DESC_COM_PARITY,                //'��������'
    DESC_COM_BAUD_RATE_300,         //'300'
    DESC_COM_BAUD_RATE_600,         //'600'
    DESC_COM_BAUD_RATE_1200,        //'1200'
    DESC_COM_BAUD_RATE_2400,        //'2400'
    DESC_COM_BAUD_RATE_4800,        //'4800'
    DESC_COM_BAUD_RATE_9600,        //'9600'
    //2
    DESC_COM_BAUD_RATE_14400,       //'14400'
    DESC_COM_BAUD_RATE_19200,       //'19200'
    DESC_COM_BAUD_RATE_38400,       //'38400'
    DESC_COM_BAUD_RATE_56000,       //'56000'
    DESC_COM_BAUD_RATE_57600,       //'57600'
    DESC_COM_BAUD_RATE_115200,      //'115200'
    DESC_COM_BAUD_RATE_128000,      //'128000'
    //3
    DESC_WAIT_TONE,                 //'����� ����� ����� ������� ������'
    DESC_INACTIVE_TIMEOUT,          //'��������� ��� ������������, �'
    DESC_TONE_CALL,                 //'��������� �����',
    DESC_PROFILS,                   //'�������'
    DESC_DELAY_BEFORE_SEND,         //'�������� ����� ���������',
    DESC_DELAY_WAIT_ANSWER,         //'����� �������� ������',
    DESC_RETRY_COUNT,               //'���-�� ������������',
    DESC_CREATE_PROFILE,            //'�������',
    //4
    DESC_CHANGE_PROFILE,            //'��������',
    DESC_DELETE_PROFILE,            //'�������',
    DESC_PROFILE_NAME,              //'�������� �������',
    DESC_NEW_PROFILE,               //'�������� �������',
    DESC_PROFILE,                   //'�������',
    DESC_SETTINGS_OF_NEW_PROF,      //'��������� ��� ����������',
    DESC_OK_BUTTON,                 //'Ok'
    DESC_CANCEL_BUTTON,             //'������'
    //5
    DESC_ERROR_WIN_CAP,             //'������...'
    DESC_ERR_PROF_NAME_EPTY,        //'������� �������� �������.'
    DESC_CONFIRM_MODIFY_PROF,       //'����������� ��������� �������'
    DESC_CONFIRM_DELETE_PROF,       //'����������� �������� �������'
    DESC_LABEL_COM,                 //'���������������� ����'
    DESC_EXCHANGE_SETTINGS,         //'��������� ������',

    //6
    DESC_MODEM_CONNECTION,         //'�������� ����������'

    DESC_N
  );
  const
    Descriptions: array [0..Integer(TDescriptionID.DESC_N) - 1] of String = (
    //0
    '����� ���������',
    '����� ��������',
    '����������',
    'COM-����',
    '����� COM-�����',
    '��������',
    '���� ������',
     //1
    '��������',
    '300',
    '600',
    '1200',
    '2400',
    '4800',
    '9600',
    //2
    '14400',
    '19200',
    '38400',
    '56000',
    '57600',
    '115200',
    '128000',
    //3
    '����� ����� ����� ������� ������',
    '��������� ��� ������������, �',
    '��������� �����',
    '�������',
    '�������� ����� ���������',
    '����� �������� ������',
    '���-�� ������������',
    '�������',
    //4
    '��������',
    '�������',
    '�������� �������',
    '�������� �������',
    '�������',
    '��������� ��� ����������',
    'Ok',
    '������',
    //5
    '������...',
    '������� �������� �������.',
    '����������� ��������� �������',
    '����������� �������� �������',
    '���������������� ����',
    '��������� ������',
    '�������� ����������'
  );

  ErrorDescriptions: array [0..Integer(TErrorID.ERRORS_N) - 1] of String = (

    '���������� �� �����������',
    '����� ����-��� �������� ������ ������',
    '����� �� ������������ ������� ������ HAYES',
    '�������� ������ ��� ����� �� ������������ ������� ������ HAYES',
    '�� ������� ����������� � ��������� �������',
    '���������� ���������',
    '�� ����� ����� ��������',
    '���������� �������� �������������',
    '������� ������� ������ ������ ����������',
    '������ �������� ��������� ��� ������������� ����������',
    '������ ������ � ��������',
    '������������ ������ �������������� ����������',
    '������������ ��������� ���������',
    '�� ������� ����������� ����� �� �������� ��������',
    '����� �� ������',
    '�� ������� ����������� ����� � ��������� �����'
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
function GetErrorDescription(ErrorID:Integer; var pDesc:PChar):Integer;
begin
    if ErrorID < Integer(TErrorID.ERRORS_N) then
     begin
        pDesc := PChar(ErrorDescriptions[ErrorID]);
        Result := RET_OK;
     end else
        Result := RET_ERR;
end;

end.
