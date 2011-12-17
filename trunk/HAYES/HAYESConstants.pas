unit HAYESConstants;

interface
  type

   TModifyProfType = (
      CREATE_PROFILE,            //'Создать',
      CHANGE_PROFILE,            //'Изменить',
      DELETE_PROFILE             //'Удалить',
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
    //ответы модема

    TModemAnswer = (

    	OK = 0,
	    CONNECT,
	    RING,
	    NO_CARRIER,
	    ERROR,
	    NO_DIALTONE,
	    BUSY,
	    NO_ANSWER,
	    MAS_N
    );

const

  BUF_MAX_LEN = 8191;
  NameDll = 'HAYES';

//errors
  RET_OK = 0;
  RET_ERR = $FF;



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

  //путь реестра для получения информации о доступных COM-портах
  REG_KEY_SERIALCOMM = 'HARDWARE\DEVICEMAP\SERIALCOMM';

  //максимальный размер ответа от модема в символах
  MAX_RESP_LENGTH = 255;

  //AT commands list

    AT            = 'AT';
	  ATH           = 'ATH';
	  ATH0          = 'ATH0';
    ATQ0          = 'ATQ0';
    ATV1          = 'ATV1';
    ATE0          = 'ATE0';
	  ATE1          = 'ATE1';
	  ATQ0V1        = 'ATQ0V1';
	  ATM0          = 'ATM0';
	  ATM1          = 'ATM1';
	  ATL           = 'ATL%d';
	  ATX3          = 'ATX3';
	  ATX4          = 'ATX4';
	  ATS           = 'ATS';
	  ATslQ0        = 'AT\Q0';
	  ATslQ2        = 'AT\Q2';
	  ATplMR0       = 'AT+MR=0';
	  ATplER0       = 'AT+ER=0';
	  ATplDR0       = 'AT+DR=0';
	  ATplIPR       = 'AT+IPR=';
	  ATampD0       = 'AT&D0';
	  ATampD2       = 'AT&D2';
	  ATampC1       = 'AT&C1';
	  ATampS1       = 'AT&S1';
	  ATampF        = 'AT&F';
	  ATampK0       = 'AT&K0';
	  ATampK3       = 'AT&K3';
	  PlPlPl        = '+++';
	  ATplIFC00     = 'AT+IFC=0,0';
	  ATplIFC02     = 'AT+IFC=0,2';
	  ATcapSPBD_BL  = 'AT^SPBD=BL';
	  AT_CFUN       = 'AT+CFUN=';


    //Modem Answer
    cOK          = 'OK';
    cCONNECT     = 'CONNECT';
    cRING        = 'RING';
    cNO_CARRIER  = 'NO CARRIER';
    cERROR       = 'ERROR';
    cNO_DIALTONE = 'NO DIALTONE';
    cBUSY        = 'BUSY';
    cNO_ANSWER   = 'NO ANSWER';
    cCONNECT_t   = 'CONNECT';

    MODEM_ANSWER_TIMEOUT = 1000;

implementation

end.
