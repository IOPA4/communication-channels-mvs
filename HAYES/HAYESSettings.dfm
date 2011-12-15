object fSettings: TfSettings
  Left = 0
  Top = 0
  Caption = 'Settings'
  ClientHeight = 313
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    308
    313)
  PixelsPerInch = 96
  TextHeight = 12
  object gbProfiles: TGroupBox
    Left = 2
    Top = 224
    Width = 304
    Height = 55
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1088#1086#1092#1080#1083#1080
    TabOrder = 0
    DesignSize = (
      304
      55)
    object cbProfiles: TComboBox
      Left = 161
      Top = 8
      Width = 138
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
      Left = 60
      Top = 29
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
    end
    object btDelProf: TButton
      Left = 223
      Top = 29
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
    end
    object btChangeProf: TButton
      Left = 139
      Top = 29
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
    end
  end
  object tbCancel: TButton
    Left = 140
    Top = 283
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
    Left = 224
    Top = 283
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
    Left = 3
    Top = 155
    Width = 303
    Height = 72
    Anchors = [akLeft, akTop, akRight]
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1073#1084#1077#1085#1072
    TabOrder = 3
    object lbPortDelayBeforeSend: TLabel
      Left = 4
      Top = 12
      Width = 104
      Height = 12
      Caption = 'lbPortDelayBeforeSend'
    end
    object lbPortDeleyWaitAnswer: TLabel
      Left = 4
      Top = 32
      Width = 28
      Height = 12
      Caption = 'Label1'
    end
    object lbRetry: TLabel
      Left = 4
      Top = 53
      Width = 28
      Height = 12
      Caption = 'Label1'
    end
    object edPortRetry: TEdit
      Left = 164
      Top = 50
      Width = 137
      Height = 20
      NumbersOnly = True
      TabOrder = 0
      Text = '1'
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 165
      Top = 30
      Width = 137
      Height = 20
      NumbersOnly = True
      TabOrder = 1
      Text = '500'
    end
    object edPortDelayBeforeSend: TEdit
      Left = 164
      Top = 10
      Width = 137
      Height = 20
      NumbersOnly = True
      TabOrder = 2
      Text = '60'
    end
  end
  object gbConnectionSettings: TGroupBox
    Left = 3
    Top = 91
    Width = 303
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Connection Settings'
    TabOrder = 4
    object lbInactiveTimeout: TLabel
      Left = 3
      Top = 12
      Width = 125
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Break Connection Time Out'
    end
    object edInactiveTimeout: TEdit
      Left = 221
      Top = 12
      Width = 72
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      NumbersOnly = True
      TabOrder = 0
    end
    object cbWaitTone: TCheckBox
      Left = 3
      Top = 29
      Width = 196
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Wait Tone'
      TabOrder = 1
    end
    object cbToneType: TCheckBox
      Left = 3
      Top = 46
      Width = 202
      Height = 16
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Tone type of call'
      TabOrder = 2
    end
  end
  object gbPhoneNumber: TGroupBox
    Left = 2
    Top = 1
    Width = 304
    Height = 37
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Phone Number'
    TabOrder = 5
    DesignSize = (
      304
      37)
    object edPhoneNumber: TEdit
      Left = 2
      Top = 12
      Width = 293
      Height = 20
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
    Top = 35
    Width = 303
    Height = 54
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = 'COM-port'
    TabOrder = 6
    DesignSize = (
      303
      54)
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
      Left = 223
      Top = 10
      Width = 72
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
      Left = 223
      Top = 32
      Width = 72
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
