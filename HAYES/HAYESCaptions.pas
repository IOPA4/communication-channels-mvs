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
    DESC_COMMON_SETTINGS = 0,       //'Общие настройки',
    DESC_PHONE_NUMBER,              //Номер телефона'
    DESC_CONNECT,                   //'Соединение'
    DESC_COM_PORT,                  //'COM-порт'
    DESC_COM_NUM,                   //'Номер COM-порта'
    DESC_COM_BAUD_RATE,             //'Скорость'
    DESC_COM_BYTE_SIZE,             //'Биты данных'
    //1
    DESC_COM_PARITY,                //'Четность'
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
    DESC_WAIT_TONE,                 //'Ждать гудок перед набором номера'
    DESC_INACTIVE_TIMEOUT,          //'Разрывать при неактивности, с'
    DESC_TONE_CALL,                 //'Тональный набор',
    DESC_PROFILS,                   //'Профили'
    DESC_DELAY_BEFORE_SEND,         //'Задержка перед отправкой',
    DESC_DELAY_WAIT_ANSWER,         //'Время ожидания ответа',
    DESC_RETRY_COUNT,               //'Кол-во перезапросов',
    DESC_CREATE_PROFILE,            //'Создать',
    //4
    DESC_CHANGE_PROFILE,            //'Изменить',
    DESC_DELETE_PROFILE,            //'Удалить',
    DESC_PROFILE_NAME,              //'Название профиля',
    DESC_NEW_PROFILE,               //'Создание профиля',
    DESC_PROFILE,                   //'Профиль',
    DESC_SETTINGS_OF_NEW_PROF,      //'Установки для сохранения',
    DESC_OK_BUTTON,                 //'Ok'
    DESC_CANCEL_BUTTON,             //'Отмена'
    //5
    DESC_ERROR_WIN_CAP,             //'Ошибка...'
    DESC_ERR_PROF_NAME_EPTY,        //'Введите название профиля.'
    DESC_CONFIRM_MODIFY_PROF,       //'Подтвердите изменение профиля'
    DESC_CONFIRM_DELETE_PROF,       //'Подтвердите удаление профиля'
    DESC_LABEL_COM,                 //'Последовательный порт'
    DESC_EXCHANGE_SETTINGS,         //'Настройки обмена',

    //6
    DESC_MODEM_CONNECTION,         //'Модемное соединение'

    DESC_N
  );
  const
    Descriptions: array [0..Integer(TDescriptionID.DESC_N) - 1] of String = (
    //0
    'Общие настройки',
    'Номер телефона',
    'Соединение',
    'COM-порт',
    'Номер COM-порта',
    'Скорость',
    'Биты данных',
     //1
    'Четность',
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
    'Ждать гудок перед набором номера',
    'Разрывать при неактивности, с',
    'Тональный набор',
    'Профили',
    'Задержка перед отправкой',
    'Время ожидания ответа',
    'Кол-во перезапросов',
    'Создать',
    //4
    'Изменить',
    'Удалить',
    'Название профиля',
    'Создание профиля',
    'Профиль',
    'Установки для сохранения',
    'Ok',
    'Отмена',
    //5
    'Ошибка...',
    'Введите название профиля.',
    'Подтвердите изменение профиля',
    'Подтвердите удаление профиля',
    'Последовательный порт',
    'Настройки обмена',
    'Модемное соединение'
  );

  ErrorDescriptions: array [0..Integer(TErrorID.ERRORS_N) - 1] of String = (

    'Соединение не установлено',
    'Истек тайм-аут ожидания ответа модема',
    'Модем не поддерживает систему команд HAYES',
    'Неполный кабель или модем не поддерживает систему команд HAYES',
    'Не удалось соединиться с удаленным модемом',
    'Соединение разорвано',
    'Не задан номер телефона',
    'Соединение прервано пользователем',
    'Попытка создать второй диалог соединения',
    'Нельзя поменять настройки при установленном соединении',
    'Ошибка работы с реестром',
    'Некорректная строка дополнительных параметров',
    'Некорректные параметры настройки',
    'Не удалось переключить модем на заданную скорость',
    'Модем не найден',
    'Не удалось переключить модем в командный режим'
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
