object fNewProfile: TfNewProfile
  Left = 0
  Top = 0
  Caption = 'New profile'
  ClientHeight = 345
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    383
    345)
  PixelsPerInch = 120
  TextHeight = 17
  object gbSettingsNewProfile: TGroupBox
    Left = 8
    Top = 65
    Width = 370
    Height = 232
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Settings of new Profile'
    TabOrder = 5
  end
  object gbMainSettings: TGroupBox
    Left = 14
    Top = 86
    Width = 356
    Height = 85
    Anchors = [akLeft, akTop, akRight]
    Caption = 'TCP/IP'
    TabOrder = 0
    DesignSize = (
      356
      85)
    object lbIpAddr: TLabel
      Left = 24
      Top = 17
      Width = 72
      Height = 20
      Caption = 'IP Address'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial Unicode MS'
      Font.Style = []
      ParentFont = False
    end
    object lbPort: TLabel
      Left = 24
      Top = 48
      Width = 61
      Height = 20
      Caption = 'TCP Port'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial Unicode MS'
      Font.Style = []
      ParentFont = False
    end
    object edPort: TEdit
      Left = 154
      Top = 47
      Width = 178
      Height = 25
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
    end
    object edIP: TEdit
      Left = 154
      Top = 14
      Width = 178
      Height = 25
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 1
    end
  end
  object gbExchangeSettings: TGroupBox
    Left = 14
    Top = 170
    Width = 355
    Height = 120
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Exchange settings'
    TabOrder = 1
    DesignSize = (
      355
      120)
    object lbPortDelayBeforeSend: TLabel
      Left = 20
      Top = 24
      Width = 112
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Delay Before Send'
    end
    object lbPortDeleyWaitAnswer: TLabel
      Left = 20
      Top = 54
      Width = 120
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Answer waiting time'
    end
    object lbRetry: TLabel
      Left = 20
      Top = 85
      Width = 96
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Count of Retry '
    end
    object edPortRetry: TEdit
      Left = 154
      Top = 85
      Width = 178
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 154
      Top = 50
      Width = 178
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object edPortDelayBeforeSend: TEdit
      Left = 154
      Top = 14
      Width = 178
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
  end
  object gbProfile: TGroupBox
    Left = 10
    Top = 10
    Width = 363
    Height = 57
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Profile'
    TabOrder = 2
    DesignSize = (
      363
      57)
    object lbProfileName: TLabel
      Left = 21
      Top = 21
      Width = 75
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Profile Name'
    end
    object edProfileName: TEdit
      Left = 180
      Top = 17
      Width = 178
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
  end
  object btOk: TButton
    Left = 273
    Top = 303
    Width = 105
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 3
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 163
    Top = 303
    Width = 105
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = btCancelClick
  end
end
