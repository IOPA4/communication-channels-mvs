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

    AT            = 'AT\x0D';
	  ATH           = 'ATH\x0D';
	  ATH0          = 'ATH0\x0D';
    ATQ0          = 'ATQ0\x0D';
    ATV1          = 'ATV1\x0D';
    ATE0          = 'ATE0\x0D';
	  ATE1          = 'ATE1\x0D';
	  ATQ0V1        = 'ATQ0V1\x0D';
	  ATM0          = 'ATM0\x0D';
	  ATM1          = 'ATM1\x0D';
	  ATL           = 'ATL%d\x0D';
	  ATX3          = 'ATX3\x0D';
	  ATX4          = 'ATX4\x0D';
	  ATS           = 'ATS%d=%d\x0D';
	  ATslQ0        = 'AT\\Q0\x0D';
	  ATslQ2        = 'AT\\Q2\x0D';
	  ATplMR0       = 'AT+MR=0\x0D';
	  ATplER0       = 'AT+ER=0\x0D';
	  ATplDR0       = 'AT+DR=0\x0D';
	  ATplIPR       = 'AT+IPR=%d\x0D';
	  ATampD0       = 'AT&D0\x0D';
	  ATampD2       = 'AT&D2\x0D';
	  ATampC1       = 'AT&C1\x0D';
	  ATampS1       = 'AT&S1\x0D';
	  ATampF        = 'AT&F\x0D';
	  ATampK0       = 'AT&K0\x0D';
	  ATampK3       = 'AT&K3\x0D';
	  PlPlPl        = '+++';
	  ATplIFC00     = 'AT+IFC=0,0\x0D';
	  ATplIFC02     = 'AT+IFC=0,2\x0D';
	  ATcapSPBD_BL  = 'AT^SPBD=BL\x0D';
	  AT_CFUN       = 'AT+CFUN=%d\x0D';


    //Modem Answer
    cOK          = 'OK\x0D\x0A';
    cCONNECT     = 'CONNECT\x0D\x0A';
    cRING        = 'RING\x0D\x0A';
    cNO_CARRIER  = 'NO CARRIER\x0D\x0A';
    cERROR       = 'ERROR\x0D\x0A';
    cNO_DIALTONE = 'NO DIALTONE\x0D\x0A';
    cBUSY        = 'BUSY\x0D\x0A';
    cNO_ANSWER   = 'NO ANSWER\x0D\x0A';
    cCONNECT_t   = 'CONNECT\xFF\x0D\x0A';

    MODEM_ANSWER_TIMEOUT = 1000;

implementation

end.
