object Form2: TForm2
  Left = 1326
  Top = 138
  BorderIcons = [biSystemMenu]
  ClientHeight = 413
  ClientWidth = 349
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    349
    413)
  PixelsPerInch = 96
  TextHeight = 12
  object gbProfiles: TGroupBox
    Left = 0
    Top = 168
    Width = 347
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1088#1086#1092#1080#1083#1080
    TabOrder = 3
    DesignSize = (
      347
      65)
    object btDelProf: TButton
      Left = 269
      Top = 37
      Width = 75
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 1
      OnClick = btDelProfClick
    end
    object btChangeProf: TButton
      Left = 190
      Top = 37
      Width = 75
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = btChangeProfClick
    end
    object btCreateProf: TButton
      Left = 107
      Top = 37
      Width = 75
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1079#1076#1072#1090#1100'...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btCreateProfClick
    end
    object cbProfiles: TComboBox
      Left = 156
      Top = 7
      Width = 188
      Height = 20
      Style = csDropDownList
      TabOrder = 3
      OnSelect = cbProfilesSelect
    end
  end
  object gbMainSettings: TGroupBox
    Left = 0
    Top = 0
    Width = 348
    Height = 70
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = 'TCP/IP'
    TabOrder = 0
    DesignSize = (
      348
      70)
    object lbIpAddr: TLabel
      Left = 5
      Top = 11
      Width = 44
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'IP '#1040#1076#1088#1077#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbPort: TLabel
      Left = 6
      Top = 41
      Width = 25
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1086#1088#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edPort: TEdit
      Left = 156
      Top = 39
      Width = 187
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
    end
    object edIP: TEdit
      Left = 156
      Top = 9
      Width = 187
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akTop, akBottom]
      TabOrder = 1
    end
  end
  object btOk: TButton
    Left = 269
    Top = 380
    Width = 75
    Height = 23
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 1
    OnClick = btOkClick
  end
  object tbCancel: TButton
    Left = 190
    Top = 380
    Width = 75
    Height = 23
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    Visible = False
    OnClick = tbCancelClick
  end
  object gbExchangeSettings: TGroupBox
    Left = 0
    Top = 69
    Width = 347
    Height = 100
    Anchors = [akLeft, akTop, akRight]
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1073#1084#1077#1085#1072
    TabOrder = 4
    DesignSize = (
      347
      100)
    object lbPortDelayBeforeSend: TLabel
      Left = 4
      Top = 12
      Width = 104
      Height = 12
      Caption = 'lbPortDelayBeforeSend'
    end
    object lbPortDeleyWaitAnswer: TLabel
      Left = 4
      Top = 43
      Width = 28
      Height = 12
      Caption = 'Label1'
    end
    object lbRetry: TLabel
      Left = 4
      Top = 72
      Width = 28
      Height = 12
      Caption = 'Label1'
    end
    object edPortRetry: TEdit
      Left = 156
      Top = 69
      Width = 187
      Height = 20
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
      Text = '1'
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 156
      Top = 39
      Width = 187
      Height = 20
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 1
      Text = '500'
    end
    object edPortDelayBeforeSend: TEdit
      Left = 156
      Top = 9
      Width = 187
      Height = 20
      Anchors = [akTop, akRight]
      NumbersOnly = True
      TabOrder = 2
      Text = '60'
    end
  end
end
