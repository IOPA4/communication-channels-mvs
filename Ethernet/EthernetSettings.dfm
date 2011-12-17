object Form2: TForm2
  Left = 1326
  Top = 138
  BorderIcons = [biSystemMenu]
  ClientHeight = 551
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    465
    551)
  PixelsPerInch = 120
  TextHeight = 16
  object gbProfiles: TGroupBox
    Left = 0
    Top = 224
    Width = 463
    Height = 87
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1088#1086#1092#1080#1083#1080
    TabOrder = 3
    DesignSize = (
      463
      87)
    object btDelProf: TButton
      Left = 359
      Top = 49
      Width = 100
      Height = 31
      Anchors = [akTop, akRight]
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 1
      OnClick = btDelProfClick
    end
    object btChangeProf: TButton
      Left = 253
      Top = 49
      Width = 100
      Height = 31
      Anchors = [akTop, akRight]
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = btChangeProfClick
    end
    object btCreateProf: TButton
      Left = 143
      Top = 49
      Width = 100
      Height = 31
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1079#1076#1072#1090#1100'...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btCreateProfClick
    end
    object cbProfiles: TComboBox
      Left = 208
      Top = 9
      Width = 251
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csDropDownList
      TabOrder = 3
      OnSelect = cbProfilesSelect
    end
  end
  object gbMainSettings: TGroupBox
    Left = 0
    Top = 0
    Width = 464
    Height = 93
    Anchors = [akLeft, akTop, akRight]
    Caption = 'TCP/IP'
    TabOrder = 0
    DesignSize = (
      464
      93)
    object lbIpAddr: TLabel
      Left = 7
      Top = 15
      Width = 59
      Height = 18
      Caption = 'IP '#1040#1076#1088#1077#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbPort: TLabel
      Left = 8
      Top = 55
      Width = 34
      Height = 18
      Caption = #1055#1086#1088#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edPort: TEdit
      Left = 208
      Top = 52
      Width = 249
      Height = 20
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
    end
    object edIP: TEdit
      Left = 208
      Top = 12
      Width = 249
      Height = 20
      Anchors = [akTop, akBottom]
      TabOrder = 1
    end
  end
  object btOk: TButton
    Left = 359
    Top = 507
    Width = 100
    Height = 30
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 1
    OnClick = btOkClick
  end
  object tbCancel: TButton
    Left = 253
    Top = 507
    Width = 100
    Height = 30
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    Visible = False
    OnClick = tbCancelClick
  end
  object gbExchangeSettings: TGroupBox
    Left = 0
    Top = 92
    Width = 463
    Height = 133
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akLeft, akTop, akRight]
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1073#1084#1077#1085#1072
    TabOrder = 4
    DesignSize = (
      463
      133)
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
      Top = 57
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
      Top = 96
      Width = 37
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Label1'
    end
    object edPortRetry: TEdit
      Left = 208
      Top = 92
      Width = 249
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
      Text = '1'
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 208
      Top = 52
      Width = 249
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 1
      Text = '500'
    end
    object edPortDelayBeforeSend: TEdit
      Left = 208
      Top = 12
      Width = 249
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 2
      Text = '60'
    end
  end
end
