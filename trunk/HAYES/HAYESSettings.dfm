object fSettings: TfSettings
  Left = 0
  Top = 0
  Caption = 'Settings'
  ClientHeight = 417
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    410
    417)
  PixelsPerInch = 120
  TextHeight = 16
  object gbProfiles: TGroupBox
    Left = 2
    Top = 298
    Width = 406
    Height = 74
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1088#1086#1092#1080#1083#1080
    TabOrder = 0
    DesignSize = (
      406
      74)
    object cbProfiles: TComboBox
      Left = 215
      Top = 11
      Width = 184
      Height = 24
      Style = csDropDownList
      TabOrder = 0
      OnSelect = cbProfilesSelect
    end
    object btCreateProf: TButton
      Left = 80
      Top = 39
      Width = 104
      Height = 32
      Anchors = [akRight, akBottom]
      Caption = #1057#1086#1079#1076#1072#1090#1100
      TabOrder = 1
      OnClick = btCreateProfClick
    end
    object btDelProf: TButton
      Left = 297
      Top = 38
      Width = 107
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = btDelProfClick
    end
    object btChangeProf: TButton
      Left = 185
      Top = 38
      Width = 107
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 3
      OnClick = btChangeProfClick
    end
  end
  object tbCancel: TButton
    Left = 187
    Top = 377
    Width = 107
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
  end
  object btOk: TButton
    Left = 299
    Top = 377
    Width = 107
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 2
  end
  object gbExchangeSettings: TGroupBox
    Left = 4
    Top = 207
    Width = 404
    Height = 95
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1073#1084#1077#1085#1072
    TabOrder = 3
    object lbPortDelayBeforeSend: TLabel
      Left = 5
      Top = 16
      Width = 130
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'lbPortDelayBeforeSend'
    end
    object lbPortDeleyWaitAnswer: TLabel
      Left = 5
      Top = 43
      Width = 37
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Label1'
    end
    object lbRetry: TLabel
      Left = 5
      Top = 70
      Width = 37
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Label1'
    end
    object edPortRetry: TEdit
      Left = 219
      Top = 67
      Width = 182
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      NumbersOnly = True
      TabOrder = 0
      Text = '1'
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 220
      Top = 40
      Width = 182
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      NumbersOnly = True
      TabOrder = 1
      Text = '500'
    end
    object edPortDelayBeforeSend: TEdit
      Left = 219
      Top = 13
      Width = 182
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      NumbersOnly = True
      TabOrder = 2
      Text = '60'
    end
  end
  object gbConnectionSettings: TGroupBox
    Left = 4
    Top = 121
    Width = 404
    Height = 87
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Connection Settings'
    TabOrder = 4
    object lbInactiveTimeout: TLabel
      Left = 4
      Top = 16
      Width = 285
      Height = 16
      Caption = 'Break Connection Time Out'
    end
    object edInactiveTimeout: TEdit
      Left = 295
      Top = 16
      Width = 96
      Height = 24
      NumbersOnly = True
      TabOrder = 0
    end
    object cbWaitTone: TCheckBox
      Left = 4
      Top = 38
      Width = 261
      Height = 18
      Caption = 'Wait Tone'
      TabOrder = 1
    end
    object cbToneType: TCheckBox
      Left = 4
      Top = 61
      Width = 269
      Height = 22
      Caption = 'Tone type of call'
      TabOrder = 2
    end
  end
  object gbPhoneNumber: TGroupBox
    Left = 2
    Top = 1
    Width = 406
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Phone Number'
    TabOrder = 5
    DesignSize = (
      406
      49)
    object edPhoneNumber: TEdit
      Left = 3
      Top = 16
      Width = 390
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object gbComPort: TGroupBox
    Left = 2
    Top = 47
    Width = 405
    Height = 71
    Anchors = [akLeft, akTop, akRight]
    Caption = 'COM-port'
    TabOrder = 6
    DesignSize = (
      405
      71)
    object lbPortName: TLabel
      Left = 5
      Top = 19
      Width = 55
      Height = 16
      Caption = 'COM-port'
    end
    object lbBaudRate: TLabel
      Left = 5
      Top = 46
      Width = 58
      Height = 16
      Caption = 'Baud Rate'
    end
    object cbComPort: TComboBox
      Left = 297
      Top = 13
      Width = 96
      Height = 24
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
    object cbBaudRate: TComboBox
      Left = 297
      Top = 43
      Width = 96
      Height = 24
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
  end
end
