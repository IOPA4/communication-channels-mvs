object Form2: TForm2
  Left = 1347
  Top = 141
  BorderIcons = [biSystemMenu]
  ClientHeight = 415
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    407
    415)
  PixelsPerInch = 120
  TextHeight = 16
  object gbMainSettings: TGroupBox
    Left = 0
    Top = 0
    Width = 407
    Height = 87
    Anchors = [akLeft, akTop, akRight]
    Caption = 'TCP/IP'
    TabOrder = 0
    object lbIpAddr: TLabel
      Left = 24
      Top = 17
      Width = 60
      Height = 20
      Caption = 'IP '#1040#1076#1088#1077#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial Unicode MS'
      Font.Style = []
      ParentFont = False
    end
    object lbPort: TLabel
      Left = 24
      Top = 49
      Width = 34
      Height = 20
      Caption = #1055#1086#1088#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial Unicode MS'
      Font.Style = []
      ParentFont = False
    end
    object edPort: TEdit
      Left = 223
      Top = 48
      Width = 181
      Height = 24
      NumbersOnly = True
      TabOrder = 0
    end
    object edIP: TEdit
      Left = 223
      Top = 16
      Width = 181
      Height = 24
      TabOrder = 1
    end
  end
  object btOk: TButton
    Left = 300
    Top = 372
    Width = 107
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 1
  end
  object tbCancel: TButton
    Left = 188
    Top = 372
    Width = 107
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = tbCancelClick
  end
  object gbProfiles: TGroupBox
    Left = 9
    Top = 243
    Width = 398
    Height = 110
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1088#1086#1092#1080#1083#1080
    TabOrder = 3
    DesignSize = (
      398
      110)
    object cbProfiles: TComboBox
      Left = 211
      Top = 17
      Width = 184
      Height = 24
      TabOrder = 0
    end
    object btCreateProf: TButton
      Left = 64
      Top = 68
      Width = 107
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = #1057#1086#1079#1076#1072#1090#1100
      TabOrder = 1
      OnClick = btCreateProfClick
    end
    object btDelProf: TButton
      Left = 288
      Top = 67
      Width = 107
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
    end
    object btChangeProf: TButton
      Left = 176
      Top = 67
      Width = 107
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 3
      OnClick = btChangeProfClick
    end
  end
  object gbExchangeSettings: TGroupBox
    Left = 0
    Top = 93
    Width = 407
    Height = 143
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1073#1084#1077#1085#1072
    TabOrder = 4
    object lbPortDelayBeforeSend: TLabel
      Left = 20
      Top = 20
      Width = 130
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'lbPortDelayBeforeSend'
    end
    object lbPortDeleyWaitAnswer: TLabel
      Left = 20
      Top = 64
      Width = 37
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Label1'
    end
    object lbRetry: TLabel
      Left = 20
      Top = 107
      Width = 37
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Label1'
    end
    object edPortRetry: TEdit
      Left = 221
      Top = 93
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
      Left = 221
      Top = 55
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
      Left = 221
      Top = 16
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
