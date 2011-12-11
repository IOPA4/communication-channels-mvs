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
    DESC_IP_ADDRESS,                //'IP адрес',
    DESC_TCP_PORT,                  //'Порт',
    DESC_PROFILS,                   //'Профили'
    DESC_EXCHANGE_SETTINGS,         //'Настройки обмена',
    DESC_DELAY_BEFORE_SEND,         //'Задержка перед отправкой',
    DESC_DELAY_WAIT_ANSWER,         //'Время ожидания ответа',
    DESC_RETRY_COUNT,               //'Кол-во перезапросов',
    DESC_CREATE_PROFILE,            //'Создать',
    DESC_CHANGE_PROFILE,            //'Изменить',
    DESC_DELETE_PROFILE,            //'Удалить',
    DESC_PROFILE_NAME,              //'Название профиля',
    DESC_NEW_PROFILE,               //'Создание профиля',
    DESC_PROFILE,                   //'Профиль',
    DESC_SETTINGS_OF_NEW_PROF,      //'Установки для сохранения',
    DESC_OK_BUTTON,                 //'Ok'
    DESC_CANCEL_BUTTON,             //'Отмена'
    DESC_ERROR_WIN_CAP,             //'Ошибка...'
    DESC_ERR_PROF_NAME_EPTY,        //'Введите название профиля.'
    DESC_CONFIRM_MODIFY_PROF,       //'Подтвердите изменение профиля'
    DESC_CONFIRM_DELETE_PROF,       //'Подтвердите удаление профиля'

    DESC_N
  );

var
  Descriptions: array [0..Integer(TDescriptionID.DESC_N) - 1] of String = (

    'TCP/IP',
    'IP адрес',
    'Порт',
    'Профили',
    'Настройки обмена',
    'Задержка перед отправкой',
    'Время ожидания ответа',
    'Кол-во перезапросов',
    'Создать',
    'Изменить',
    'Удалить',
    'Название профиля',
    'Создание профиля',
    'Профиль',
    'Установки для сохранения',
    'Ok',
    'Отмена',
    'Ошибка...',
    'Введите название профиля.',
    'Подтвердите изменение профиля',
    'Подтвердите удаление профиля'
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
