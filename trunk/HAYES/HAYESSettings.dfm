object fSettings: TfSettings
  Left = 0
  Top = 0
  Caption = 'Settings'
  ClientHeight = 443
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    403
    443)
  PixelsPerInch = 96
  TextHeight = 12
  object gbProfiles: TGroupBox
    Left = 2
    Top = 319
    Width = 399
    Height = 61
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1088#1086#1092#1080#1083#1080
    TabOrder = 0
    DesignSize = (
      399
      61)
    object cbProfiles: TComboBox
      Left = 211
      Top = 12
      Width = 187
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style = csDropDownList
      TabOrder = 0
      OnSelect = cbProfilesSelect
    end
    object btCreateProf: TButton
      Left = 155
      Top = 35
      Width = 78
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akRight, akBottom]
      Caption = #1057#1086#1079#1076#1072#1090#1100
      TabOrder = 1
      OnClick = btCreateProfClick
      ExplicitTop = 29
    end
    object btDelProf: TButton
      Left = 318
      Top = 35
      Width = 80
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akRight, akBottom]
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = btDelProfClick
      ExplicitTop = 29
    end
    object btChangeProf: TButton
      Left = 234
      Top = 35
      Width = 80
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akRight, akBottom]
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 3
      OnClick = btChangeProfClick
      ExplicitTop = 29
    end
  end
  object tbCancel: TButton
    Left = 235
    Top = 413
    Width = 81
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
  end
  object btOk: TButton
    Left = 319
    Top = 413
    Width = 81
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 2
    OnClick = btOkClick
  end
  object gbExchangeSettings: TGroupBox
    Left = 2
    Top = 230
    Width = 405
    Height = 88
    Anchors = [akLeft, akTop, akRight]
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1073#1084#1077#1085#1072
    TabOrder = 3
    object lbPortDelayBeforeSend: TLabel
      Left = 6
      Top = 15
      Width = 104
      Height = 12
      Caption = 'lbPortDelayBeforeSend'
    end
    object lbPortDeleyWaitAnswer: TLabel
      Left = 6
      Top = 37
      Width = 28
      Height = 12
      Caption = 'Label1'
    end
    object lbRetry: TLabel
      Left = 7
      Top = 64
      Width = 28
      Height = 12
      Caption = 'Label1'
    end
    object edPortRetry: TEdit
      Left = 214
      Top = 61
      Width = 187
      Height = 23
      NumbersOnly = True
      TabOrder = 0
      Text = '1'
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 215
      Top = 34
      Width = 187
      Height = 23
      NumbersOnly = True
      TabOrder = 1
      Text = '500'
    end
    object edPortDelayBeforeSend: TEdit
      Left = 215
      Top = 7
      Width = 187
      Height = 23
      NumbersOnly = True
      TabOrder = 2
      Text = '60'
    end
  end
  object gbConnectionSettings: TGroupBox
    Left = 4
    Top = 104
    Width = 399
    Height = 127
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Connection Settings'
    TabOrder = 4
    object lbInactiveTimeout: TLabel
      Left = 3
      Top = 15
      Width = 125
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Break Connection Time Out'
    end
    object edInactiveTimeout: TEdit
      Left = 209
      Top = 12
      Width = 187
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      NumbersOnly = True
      TabOrder = 0
    end
    object cbWaitTone: TCheckBox
      Left = 2
      Top = 34
      Width = 203
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Wait Tone'
      TabOrder = 1
    end
    object cbToneType: TCheckBox
      Left = 2
      Top = 54
      Width = 204
      Height = 18
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Tone type of call'
      TabOrder = 2
    end
    object gbAddParams: TGroupBox
      Left = 3
      Top = 73
      Width = 392
      Height = 49
      Caption = 'Additional initialization parametrs'
      TabOrder = 3
      object edAddParams: TEdit
        Left = 2
        Top = 16
        Width = 386
        Height = 24
        TabOrder = 0
      end
    end
  end
  object gbPhoneNumber: TGroupBox
    Left = 2
    Top = 1
    Width = 399
    Height = 41
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Phone Number'
    TabOrder = 5
    DesignSize = (
      399
      41)
    object edPhoneNumber: TEdit
      Left = 3
      Top = 12
      Width = 391
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object gbComPort: TGroupBox
    Left = 2
    Top = 46
    Width = 401
    Height = 59
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = 'COM-port'
    TabOrder = 6
    DesignSize = (
      401
      59)
    object lbPortName: TLabel
      Left = 4
      Top = 14
      Width = 46
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'COM-port'
    end
    object lbBaudRate: TLabel
      Left = 4
      Top = 35
      Width = 45
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Baud Rate'
    end
    object cbComPort: TComboBox
      Left = 211
      Top = 10
      Width = 187
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
    object cbBaudRate: TComboBox
      Left = 211
      Top = 34
      Width = 187
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
  end
end
