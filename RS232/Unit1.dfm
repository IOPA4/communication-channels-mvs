object FormProperties: TFormProperties
  Left = 1347
  Top = 141
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 402
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 305
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial Unicode MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 19
      Width = 132
      Height = 16
      AutoSize = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 8
      Top = 45
      Width = 132
      Height = 16
      AutoSize = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 8
      Top = 98
      Width = 132
      Height = 16
      AutoSize = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 8
      Top = 73
      Width = 132
      Height = 16
      AutoSize = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 7
      Top = 123
      Width = 133
      Height = 16
      AutoSize = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 24
      Top = 180
      Width = 132
      Height = 16
      AutoSize = False
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 3
      Top = 176
      Width = 160
      Height = 17
      AutoSize = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 8
      Top = 202
      Width = 160
      Height = 17
      AutoSize = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 17
      Top = 240
      Width = 160
      Height = 17
      AutoSize = False
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1074#1090#1086#1088#1099#1093' '#1079#1072#1087#1088#1086#1089#1086#1074
      Layout = tlCenter
    end
    object cbPort: TComboBox
      Left = 159
      Top = 17
      Width = 88
      Height = 23
      Style = csDropDownList
      Sorted = True
      TabOrder = 0
      OnChange = cbPortChange
    end
    object cbBaudRate: TComboBox
      Left = 159
      Top = 43
      Width = 88
      Height = 23
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 1
      Text = '9600'
      OnChange = cbBaudRateChange
      Items.Strings = (
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '38400'
        '57600'
        '115200')
    end
    object cbParity: TComboBox
      Left = 159
      Top = 96
      Width = 88
      Height = 23
      Style = csDropDownList
      TabOrder = 2
      OnChange = cbParityChange
      Items.Strings = (
        '')
    end
    object cbByteSize: TComboBox
      Left = 159
      Top = 70
      Width = 88
      Height = 23
      Style = csDropDownList
      ItemIndex = 4
      TabOrder = 3
      Text = '8'
      OnChange = cbByteSizeChange
      Items.Strings = (
        '4'
        '5'
        '6'
        '7'
        '8')
    end
    object cbStopBits: TComboBox
      Left = 159
      Top = 121
      Width = 88
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = '1'
      OnChange = cbStopBitsChange
      Items.Strings = (
        '1'
        '2')
    end
    object cbFlow: TComboBox
      Left = 159
      Top = 147
      Width = 88
      Height = 23
      Style = csDropDownList
      TabOrder = 5
      OnChange = cbFlowChange
    end
    object edPortDelayBeforeSend: TEdit
      Left = 182
      Top = 176
      Width = 43
      Height = 23
      TabOrder = 6
      Text = '60'
      OnChange = edPortDelayBeforeSendChange
    end
    object CheckBox1: TCheckBox
      Left = 9
      Top = 275
      Width = 192
      Height = 24
      TabOrder = 7
      OnClick = CheckBox1Click
    end
    object Button3: TButton
      Left = 248
      Top = 17
      Width = 17
      Height = 20
      Caption = '?'
      TabOrder = 8
      OnClick = Button3Click
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 183
      Top = 203
      Width = 42
      Height = 23
      TabOrder = 9
      Text = '500'
      OnChange = edPortDeleyWaitAnswerChange
    end
    object edPortRetry: TEdit
      Left = 183
      Top = 238
      Width = 42
      Height = 23
      TabOrder = 10
      Text = '1'
      OnChange = edPortDeleyWaitAnswerChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 313
    Width = 281
    Height = 81
    TabOrder = 1
    object cbChangeProf: TComboBox
      Left = 9
      Top = 18
      Width = 105
      Height = 21
      MaxLength = 17
      TabOrder = 0
      OnChange = cbChangeProfChange
    end
    object Button2: TButton
      Left = 203
      Top = 21
      Width = 75
      Height = 26
      TabOrder = 1
      OnClick = Button2Click
    end
    object ButtonOK: TButton
      Left = 97
      Top = 53
      Width = 80
      Height = 25
      TabOrder = 2
      OnClick = ButtonOKClick
    end
    object Button1: TButton
      Left = 201
      Top = 53
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 3
      OnClick = Button1Click
    end
  end
end
