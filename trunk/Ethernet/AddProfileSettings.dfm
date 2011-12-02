object fNewProfile: TfNewProfile
  Left = 0
  Top = 0
  Caption = 'New profile'
  ClientHeight = 264
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    293
    264)
  PixelsPerInch = 96
  TextHeight = 13
  object gbSettingsNewProfile: TGroupBox
    Left = 6
    Top = 50
    Width = 283
    Height = 177
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Settings of new Profile'
    TabOrder = 5
    ExplicitWidth = 307
  end
  object gbMainSettings: TGroupBox
    Left = 11
    Top = 66
    Width = 272
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = 'TCP/IP'
    TabOrder = 0
    ExplicitWidth = 296
    DesignSize = (
      272
      65)
    object lbIpAddr: TLabel
      Left = 18
      Top = 13
      Width = 54
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'IP Address'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial Unicode MS'
      Font.Style = []
      ParentFont = False
    end
    object lbPort: TLabel
      Left = 18
      Top = 37
      Width = 45
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'TCP Port'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial Unicode MS'
      Font.Style = []
      ParentFont = False
    end
    object edPort: TEdit
      Left = 118
      Top = 36
      Width = 136
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
      ExplicitLeft = 142
    end
    object edIP: TEdit
      Left = 118
      Top = 11
      Width = 136
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 1
    end
  end
  object gbExchangeSettings: TGroupBox
    Left = 11
    Top = 130
    Width = 271
    Height = 92
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Exchange settings'
    TabOrder = 1
    ExplicitWidth = 295
    DesignSize = (
      271
      92)
    object lbPortDelayBeforeSend: TLabel
      Left = 15
      Top = 18
      Width = 89
      Height = 13
      Caption = 'Delay Before Send'
    end
    object lbPortDeleyWaitAnswer: TLabel
      Left = 15
      Top = 41
      Width = 96
      Height = 13
      Caption = 'Answer waiting time'
    end
    object lbRetry: TLabel
      Left = 15
      Top = 65
      Width = 75
      Height = 13
      Caption = 'Count of Retry '
    end
    object edPortRetry: TEdit
      Left = 118
      Top = 65
      Width = 136
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      ExplicitLeft = 142
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 118
      Top = 38
      Width = 136
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
      ExplicitLeft = 142
    end
    object edPortDelayBeforeSend: TEdit
      Left = 118
      Top = 11
      Width = 136
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 2
      ExplicitLeft = 142
    end
  end
  object gbProfile: TGroupBox
    Left = 8
    Top = 8
    Width = 277
    Height = 43
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Profile'
    TabOrder = 2
    ExplicitWidth = 301
    DesignSize = (
      277
      43)
    object lbProfileName: TLabel
      Left = 16
      Top = 16
      Width = 60
      Height = 13
      Caption = 'Profile Name'
    end
    object edProfileName: TEdit
      Left = 138
      Top = 13
      Width = 136
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      ExplicitLeft = 162
    end
  end
  object btOk: TButton
    Left = 209
    Top = 232
    Width = 80
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 3
    ExplicitLeft = 233
    ExplicitTop = 270
  end
  object btCancel: TButton
    Left = 125
    Top = 232
    Width = 80
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 4
    ExplicitLeft = 149
    ExplicitTop = 270
  end
end
