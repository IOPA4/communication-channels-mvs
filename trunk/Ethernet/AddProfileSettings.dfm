object fNewProfile: TfNewProfile
  Left = 0
  Top = 0
  Caption = 'New profile'
  ClientHeight = 302
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    426
    302)
  PixelsPerInch = 120
  TextHeight = 17
  object gbSettingsNewProfile: TGroupBox
    Left = 3
    Top = 51
    Width = 421
    Height = 204
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Settings of new Profile'
    TabOrder = 5
  end
  object gbMainSettings: TGroupBox
    Left = 8
    Top = 69
    Width = 409
    Height = 77
    Anchors = [akLeft, akTop, akRight]
    Caption = 'TCP/IP'
    TabOrder = 0
    DesignSize = (
      409
      77)
    object lbIpAddr: TLabel
      Left = 4
      Top = 15
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
      Left = 4
      Top = 42
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
      Left = 224
      Top = 41
      Width = 178
      Height = 25
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
    end
    object edIP: TEdit
      Left = 225
      Top = 14
      Width = 178
      Height = 25
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 1
    end
  end
  object gbExchangeSettings: TGroupBox
    Left = 9
    Top = 148
    Width = 408
    Height = 102
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Exchange settings'
    TabOrder = 1
    DesignSize = (
      408
      102)
    object lbPortDelayBeforeSend: TLabel
      Left = 4
      Top = 17
      Width = 112
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Delay Before Send'
    end
    object lbPortDeleyWaitAnswer: TLabel
      Left = 4
      Top = 44
      Width = 120
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Answer waiting time'
    end
    object lbRetry: TLabel
      Left = 4
      Top = 72
      Width = 96
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Count of Retry '
    end
    object edPortRetry: TEdit
      Left = 225
      Top = 69
      Width = 178
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 0
      ExplicitLeft = 215
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 225
      Top = 41
      Width = 178
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 1
      ExplicitLeft = 215
    end
    object edPortDelayBeforeSend: TEdit
      Left = 225
      Top = 14
      Width = 178
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 2
      ExplicitLeft = 215
    end
  end
  object gbProfile: TGroupBox
    Left = 3
    Top = -1
    Width = 421
    Height = 54
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Profile'
    TabOrder = 2
    DesignSize = (
      421
      54)
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
      Left = 238
      Top = 17
      Width = 178
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 0
      ExplicitLeft = 180
    end
  end
  object btOk: TButton
    Left = 316
    Top = 260
    Width = 105
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 3
    OnClick = btOkClick
    ExplicitLeft = 273
    ExplicitTop = 303
  end
  object btCancel: TButton
    Left = 206
    Top = 260
    Width = 105
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = btCancelClick
    ExplicitLeft = 163
    ExplicitTop = 303
  end
end
