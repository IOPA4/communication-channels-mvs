unit EthernetConstants;

interface
type

   TModifyProfType = (
      CREATE_PROFILE,            //'Создать',
      CHANGE_PROFILE,            //'Изменить',
      DELETE_PROFILE             //'Удалить',
   );

const
  NameDll = 'Ethernet';
  BUF_MAX_LEN = 8191;

//errors
  RET_OK = 0;
  RET_ERR = $FF;

//settings
  EMPTY_PROFILE_NAME    = '';
  PROFNAME_PREFIX       = 'Profile_';
  SETTINGS_FILENAME     = 'Settings.ini';

  KEYNAME_PROFILE_NAME  = 'ProfileName';
  KEYNAME_IP_ADDRESS    = 'PorIP';
  KEYNAME_TCP_PORT      = 'PorTCPPort';
  KEYNAME_DELAY_BEFORE  = 'PortDelayBeforeSend';
  KEYNAME_WAIT_ANSWER   = 'PortDeleyWaitAnswer';
  KEYNAME_RETRY_COUNT   = 'PortRetry';

  DEFVAL_PROFILE_NAME  = '000000';
  DEFVAL_IP_ADDRESS    = '0.0.0.0';
  DEFVAL_TCP_PORT      = 0;
  DEFVAL_DELAY_BEFORE  = 0;
  DEFVAL_WAIT_ANSWER   = 0;
  DEFVAL_RETRY_COUNT   = 0;

implementation

end.
