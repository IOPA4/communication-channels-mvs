unit HAYESConstants;

interface
  type

   TModifyProfType = (
      CREATE_PROFILE,            //'�������',
      CHANGE_PROFILE,            //'��������',
      DELETE_PROFILE             //'�������',
   );

   TBaudRateID = (

      BRID_300 = 0,     //'300'
      BRID_600,         //'600'
      BRID_1200,        //'1200'
      BRID_2400,        //'2400'
      BRID_4800,        //'4800'
      BRID_9600,        //'9600'
      //2
      BRID_14400,       //'14400'
      BRID_19200,       //'19200'
      BRID_38400,       //'38400'
      BRID_56000,       //'56000'
      BRID_57600,       //'57600'
      BRID_115200,      //'115200'
      BRID_128000,       //'128000'

      BRID_N
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

  BaudRate: array [0..Integer(TBaudRateID.BRID_N) - 1] of Integer = (
          300,         //'300'
          600,         //'600'
          1200,        //'1200'
          2400,        //'2400'
          4800,        //'4800'
          9600,        //'9600'
          //2
          14400,       //'14400'
          19200,       //'19200'
          38400,       //'38400'
          56000,       //'56000'
          57600,       //'57600'
          115200,      //'115200'
          128000       //'128000'
  );
implementation

end.
