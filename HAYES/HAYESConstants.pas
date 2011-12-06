unit HAYESConstants;

interface
  type

   TModifyProfType = (
      CREATE_PROFILE,            //'Создать',
      CHANGE_PROFILE,            //'Изменить',
      DELETE_PROFILE             //'Удалить',
   );

const
  NameDll = 'HAYES';

//errors
  RET_OK = 0;
  RET_ERR = $FF;

//settings

//settings
  EMPTY_PROFILE_NAME        = '';
  PROFNAME_PREFIX           = 'Profile_';
  SETTINGS_FILENAME         = 'Settings.ini';

  KEYNAME_PROFILE_NAME      = 'ProfileName';
  KEYNAME_PHONE_NUMBER      = 'PhoneNumber';
  KEYNAME_COM_NUMBER        = 'ComNumer';
  KEYNAME_BAUD_RATE_INDEX   = 'BaudRateIndex';
  KEYNAME_INACTIVE_TIMEOUT  = 'InactiveTimeout';
  KEYNAME_IS_WAIT_TONE      = 'IsWaitTone';
  KEYNAME_IS_TONE           = 'IsTone';
  KEYNAME_DELAY_BEFORE      = 'PortDelayBeforeSend';
  KEYNAME_WAIT_ANSWER       = 'PortDeleyWaitAnswer';
  KEYNAME_RETRY_COUNT       = 'PortRetry';

  DEFVAL_PROFILE_NAME      = '000000';
  DEFVAL_PHONE_NUMBER      = '000000';
  DEFVAL_COM_NUMBER        = '1';
  DEFVAL_BAUD_RATE_INDEX   = 0;
  DEFVAL_INACTIVE_TIMEOUT  = 0;
  DEFVAL_IS_WAIT_TONE      = False;
  DEFVAL_IS_TONE           = False;
  DEFVAL_DELAY_BEFORE      = 0;
  DEFVAL_WAIT_ANSWER       = 0;
  DEFVAL_RETRY_COUNT       = 0;


implementation

end.
