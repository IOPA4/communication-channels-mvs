object fNewProfile: TfNewProfile
  Left = 0
  Top = 0
  Caption = 'fAddProfile'
  ClientHeight = 425
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    415
    425)
  PixelsPerInch = 120
  TextHeight = 16
  object gbSettingsNewProfile: TGroupBox
    Left = 1
    Top = 55
    Width = 412
    Height = 328
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Settings of new Profile'
    TabOrder = 1
    DesignSize = (
      412
      328)
    object gbConnectionSettings: TGroupBox
      Left = 2
      Top = 139
      Width = 404
      Height = 87
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Connection Settings'
      TabOrder = 2
      object lbInactiveTimeout: TLabel
        Left = 4
        Top = 16
        Width = 156
        Height = 16
        Caption = 'Break Connection Time Out'
      end
      object edInactiveTimeout: TEdit
        Left = 221
        Top = 16
        Width = 180
        Height = 24
        NumbersOnly = True
        TabOrder = 0
      end
      object cbWaitTone: TCheckBox
        Left = 4
        Top = 38
        Width = 179
        Height = 18
        Caption = 'Wait Tone'
        TabOrder = 1
      end
      object cbToneType: TCheckBox
        Left = 4
        Top = 61
        Width = 238
        Height = 22
        Caption = 'Tone type of call'
        TabOrder = 2
      end
    end
    object gbPhoneNumber: TGroupBox
      Left = 2
      Top = 15
      Width = 406
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Phone Number'
      TabOrder = 0
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
      Top = 66
      Width = 405
      Height = 71
      Anchors = [akLeft, akTop, akRight]
      Caption = 'COM-port'
      TabOrder = 1
      object lbPortName: TLabel
        Left = 5
        Top = 19
        Width = 55
        Height = 16
        Caption = 'COM-port'
      end
      object lbBaudRate: TLabel
        Left = 5
        Top = 43
        Width = 58
        Height = 16
        Caption = 'Baud Rate'
      end
      object edComPort: TEdit
        Left = 248
        Top = 13
        Width = 145
        Height = 24
        TabOrder = 0
      end
      object edBaudRate: TEdit
        Left = 248
        Top = 43
        Width = 145
        Height = 24
        TabOrder = 1
      end
    end
    object gbExchangeSettings: TGroupBox
      Left = 2
      Top = 227
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
  end
  object gbProfile: TGroupBox
    Left = 1
    Top = -1
    Width = 412
    Height = 54
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Profile'
    TabOrder = 0
    DesignSize = (
      412
      54)
    object lbProfileName: TLabel
      Left = 21
      Top = 21
      Width = 73
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Profile Name'
    end
    object edProfileName: TEdit
      Left = 229
      Top = 17
      Width = 178
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
  end
  object btCancel: TButton
    Left = 191
    Top = 384
    Width = 105
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btCancelClick
  end
  object btOk: TButton
    Left = 302
    Top = 384
    Width = 105
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 3
    OnClick = btOkClick
  end
end
