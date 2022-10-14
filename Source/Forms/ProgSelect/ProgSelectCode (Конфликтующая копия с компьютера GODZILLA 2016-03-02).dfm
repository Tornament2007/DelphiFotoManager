object SelectProg: TSelectProg
  Left = 579
  Top = 290
  BorderStyle = bsToolWindow
  Caption = ' Program Selector'
  ClientHeight = 291
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 6
    Top = 111
    Width = 158
    Height = 105
    Caption = ' Drag S Drod Select '
    TabOrder = 0
    object Label2: TLabel
      Left = 6
      Top = 47
      Width = 148
      Height = 26
      Caption = 'Drag s Drop Link of the "Editor Prog" on upper panel '
      WordWrap = True
    end
    object Panel1: TPanel
      Left = 13
      Top = 15
      Width = 133
      Height = 28
      BevelKind = bkFlat
      BevelOuter = bvNone
      Caption = '"Drag S Drop" to Here'
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 6
    Top = 4
    Width = 308
    Height = 101
    Caption = ' Select by path '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 42
      Width = 293
      Height = 26
      Caption = 
        'Select by entering the path to the "Editor Prog".  Or Select it ' +
        'in explorer.'
      WordWrap = True
    end
    object Edit1: TEdit
      Left = 24
      Top = 16
      Width = 205
      Height = 21
      TabOrder = 0
      TextHint = 'Path to the Editor Program'
      OnChange = Edit1Change
      OnKeyPress = Edit1KeyPress
      OnKeyUp = Edit1KeyUp
    end
    object Button1: TButton
      Left = 230
      Top = 16
      Width = 74
      Height = 21
      Caption = 'Explorer...'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Reset1: TButton
      Left = 6
      Top = 16
      Width = 17
      Height = 21
      Caption = 'R'
      TabOrder = 2
      OnClick = Reset1Click
    end
    object SaveA_Bt: TButton
      Left = 217
      Top = 72
      Width = 87
      Height = 21
      Caption = 'Save all'
      TabOrder = 3
      OnClick = SaveA_BtClick
    end
    object Edit2: TEdit
      Left = 24
      Top = 72
      Width = 189
      Height = 21
      TabOrder = 4
      TextHint = 'Program Name ('#1060#1086#1090#1086#1046#1086#1087')'
      OnChange = Edit2Change
      OnKeyPress = Edit1KeyPress
    end
    object Reset2: TButton
      Left = 6
      Top = 72
      Width = 17
      Height = 21
      Caption = 'R'
      TabOrder = 5
      OnClick = Reset2Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 165
    Top = 111
    Width = 146
    Height = 105
    Caption = '- Info -'
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 15
      Width = 132
      Height = 39
      Caption = 'Selected program will be used to edit images in main image list.'
      WordWrap = True
    end
  end
  object LangWL: TListBox
    Left = 384
    Top = 8
    Width = 153
    Height = 250
    ItemHeight = 13
    Items.Strings = (
      'Edit with'
      'Set "Editor Program"'
      'No Name'
      'Program Selector: ERROR | Too many files'
      'Program Selector: ERROR | Not Executable File'
      'Program Selector'
      'Executable Files')
    TabOrder = 3
    Visible = False
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Executable Files|*.exe'
    Options = [ofEnableSizing, ofForceShowHidden]
    Left = 344
    Top = 16
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 344
    Top = 64
  end
end
