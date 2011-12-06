object FormProperties: TFormProperties
  Left = 1347
  Top = 141
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 526
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object GroupBox1: TGroupBox
    Left = 10
    Top = 9
    Width = 368
    Height = 399
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial Unicode MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 25
      Width = 173
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 10
      Top = 59
      Width = 173
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 10
      Top = 128
      Width = 173
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 10
      Top = 95
      Width = 173
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 9
      Top = 161
      Width = 174
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 31
      Top = 235
      Width = 173
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 4
      Top = 230
      Width = 209
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 10
      Top = 264
      Width = 210
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 22
      Top = 314
      Width = 209
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1074#1090#1086#1088#1099#1093' '#1079#1072#1087#1088#1086#1089#1086#1074
      Layout = tlCenter
    end
    object cbPort: TComboBox
      Left = 208
      Top = 22
      Width = 115
      Height = 28
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csDropDownList
      Sorted = True
      TabOrder = 0
      OnChange = cbPortChange
    end
    object cbBaudRate: TComboBox
      Left = 208
      Top = 56
      Width = 115
      Height = 28
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      Left = 208
      Top = 126
      Width = 115
      Height = 28
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csDropDownList
      TabOrder = 2
      OnChange = cbParityChange
      Items.Strings = (
        '')
    end
    object cbByteSize: TComboBox
      Left = 208
      Top = 92
      Width = 115
      Height = 28
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      Left = 208
      Top = 158
      Width = 115
      Height = 28
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      Left = 208
      Top = 192
      Width = 115
      Height = 28
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csDropDownList
      TabOrder = 5
      OnChange = cbFlowChange
    end
    object edPortDelayBeforeSend: TEdit
      Left = 238
      Top = 230
      Width = 56
      Height = 28
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 6
      Text = '60'
      OnChange = edPortDelayBeforeSendChange
    end
    object CheckBox1: TCheckBox
      Left = 12
      Top = 360
      Width = 251
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 7
      OnClick = CheckBox1Click
    end
    object Button3: TButton
      Left = 324
      Top = 22
      Width = 23
      Height = 26
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = '?'
      TabOrder = 8
      OnClick = Button3Click
    end
    object edPortDeleyWaitAnswer: TEdit
      Left = 239
      Top = 265
      Width = 55
      Height = 28
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 9
      Text = '500'
      OnChange = edPortDeleyWaitAnswerChange
    end
    object edPortRetry: TEdit
      Left = 239
      Top = 311
      Width = 55
      Height = 28
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 10
      Text = '1'
      OnChange = edPortDeleyWaitAnswerChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 10
    Top = 409
    Width = 368
    Height = 106
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 1
    object cbChangeProf: TComboBox
      Left = 12
      Top = 24
      Width = 137
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      MaxLength = 17
      TabOrder = 0
      OnChange = cbChangeProfChange
    end
    object Button2: TButton
      Left = 265
      Top = 27
      Width = 99
      Height = 34
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 1
      OnClick = Button2Click
    end
    object ButtonOK: TButton
      Left = 127
      Top = 69
      Width = 104
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 2
      OnClick = ButtonOKClick
    end
    object Button1: TButton
      Left = 263
      Top = 69
      Width = 98
      Height = 33
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 3
      OnClick = Button1Click
    end
  end
end
