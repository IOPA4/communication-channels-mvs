object Form2: TForm2
  Left = 1347
  Top = 141
  BorderIcons = [biSystemMenu]
  ClientHeight = 311
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    305
    311)
  PixelsPerInch = 96
  TextHeight = 12
  object gbMainSettings: TGroupBox
    Left = 0
    Top = 0
    Width = 305
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = 'TCP/IP'
    TabOrder = 0
    object lbIpAddr: TLabel
      Left = 18
      Top = 13
      Width = 44
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'IP '#1040#1076#1088#1077#1089
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
      Width = 25
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #1055#1086#1088#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial Unicode MS'
      Font.Style = []
      ParentFont = False
    end
    object edPort: TEdit
      Left = 167
      Top = 36
      Width = 136
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      NumbersOnly = True
      TabOrder = 0
    end
    object edIP: TEdit
      Left = 167
      Top = 12
      Width = 136
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 1
    end
  end
  object btOk: TButton
    Left = 225
    Top = 279
    Width = 80
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 1
    ExplicitTop = 257
  end
  object tbCancel: TButton
    Left = 141
    Top = 279
    Width = 80
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = tbCancelClick
    ExplicitTop = 257
  end
  object gbProfiles: TGroupBox
    Left = 7
    Top = 182
    Width = 298
    Height = 83
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1088#1086#1092#1080#1083#1080
    TabOrder = 3
    DesignSize = (
      298
      83)
    object cbProfiles: TComboBox
      Left = 158
      Top = 13
      Width = 138
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 0
    end
    object btCreateProf: TButton
      Left = 48
      Top = 51
      Width = 80
      Height = 22
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
      Left = 216
      Top = 50
      Width = 80
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akRight, akBottom]
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
    end
    object btChangeProf: TButton
      Left = 132
      Top = 50
      Width = 80
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akRight, akBottom]
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 3
    end
  end
  object gbExchangeSettings: TGroupBox
    Left = 0
    Top = 70
    Width = 305
    Height = 107
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1073#1084#1077#1085#1072
    TabOrder = 4
    object lbPortDelayBeforeSend: TLabel
      Left = 15
      Top = 15
      Width = 104
      Height = 12
      Caption = 'lbPortDelayBeforeSend'
    end
    object lbPortDeleyWaitAnswer: TLabel
      Left = 15
      Top = 48
      Width = 28
      Height = 12
      Caption = 'Label1'
    end
    object lbRetry: TLabel
      Left = 15
      Top = 80
      Width = 28
      Height = 12
      Caption = 'Label1'
    end
    object edPortRetry: TEdit
      Left = 166
      Top = 70
      Width = 136
      Height = 20
      NumbersOnly = True
      TabOrder = 0
      Text = '1'
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 166
      Top = 41
      Width = 136
      Height = 20
      NumbersOnly = True
      TabOrder = 1
      Text = '500'
    end
    object edPortDelayBeforeSend: TEdit
      Left = 166
      Top = 12
      Width = 136
      Height = 20
      NumbersOnly = True
      TabOrder = 2
      Text = '60'
    end
  end
end
