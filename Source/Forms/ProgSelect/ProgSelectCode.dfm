object SelectProg: TSelectProg
  Left = 579
  Top = 290
  BorderStyle = bsToolWindow
  Caption = ' Program Selector'
  ClientHeight = 224
  ClientWidth = 587
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
  object LangWL: TListBox
    Left = 424
    Top = 8
    Width = 145
    Height = 201
    ItemHeight = 13
    Items.Strings = (
      'Edit with'
      'Set "Editor Program"'
      'No Name'
      'Program Selector: ERROR | Too many files'
      'Program Selector: ERROR | Not Executable File'
      'Program Selector'
      'Executable Files')
    TabOrder = 0
    Visible = False
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 8
    Width = 377
    Height = 209
    Caption = ' "Path" and "Name", of the Program'
    TabOrder = 1
    DesignSize = (
      377
      209)
    object Bevel1: TBevel
      Left = -2
      Top = 40
      Width = 383
      Height = 83
      Shape = bsFrame
    end
    object Label2: TLabel
      Left = 3
      Top = 94
      Width = 371
      Height = 26
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Drag s Drop Link of the "Editor Prog" on upper panel '
      WordWrap = True
    end
    object Label3: TLabel
      Left = 3
      Top = 151
      Width = 371
      Height = 29
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Selected program can be used to edit images in main image list.'
      WordWrap = True
    end
    object PSC_Selector: TComboBox
      Left = 4
      Top = 16
      Width = 346
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object PS_Path: TEdit
      Left = 42
      Top = 44
      Width = 258
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      TextHint = ' Path to the Editor Program'
      OnChange = PS_PathChange
      OnKeyPress = PS_PathKeyPress
      OnKeyUp = PS_PathKeyUp
    end
    object PS_Name: TEdit
      Left = 46
      Top = 125
      Width = 290
      Height = 21
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      TextHint = ' Showed Program Name'
      OnChange = PS_NameChange
      OnKeyPress = PS_PathKeyPress
    end
    object Panel1: TPanel
      Left = 4
      Top = 68
      Width = 369
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      BevelKind = bkFlat
      BevelOuter = bvNone
      Caption = '"Drag S Drop" to Here'
      TabOrder = 3
    end
    object PS_Add: TButton
      Left = 3
      Top = 43
      Width = 23
      Height = 23
      ImageAlignment = iaCenter
      ImageIndex = 229
      Images = MainForm.Regular
      TabOrder = 4
    end
    object PS_Del: TButton
      Left = 351
      Top = 15
      Width = 22
      Height = 23
      Anchors = [akTop, akRight]
      ImageAlignment = iaCenter
      ImageIndex = 227
      Images = MainForm.Regular
      TabOrder = 5
    end
    object PS_Explore: TButton
      Left = 300
      Top = 43
      Width = 74
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Explorer'
      ImageIndex = 228
      Images = MainForm.Regular
      TabOrder = 6
      OnClick = PS_ExploreClick
    end
    object SaveA_Bt: TButton
      Left = 143
      Top = 180
      Width = 87
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'Save all'
      ImageIndex = 10
      Images = MainForm.Regular
      TabOrder = 7
      OnClick = SaveA_BtClick
    end
    object Reset1: TButton
      Left = 25
      Top = 43
      Width = 17
      Height = 23
      Caption = 'R'
      TabOrder = 8
      OnClick = Reset1Click
    end
    object Reset2: TButton
      Left = 29
      Top = 125
      Width = 17
      Height = 21
      Caption = 'R'
      TabOrder = 9
      OnClick = Reset2Click
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Executable Files|*.exe'
    Options = [ofEnableSizing, ofForceShowHidden]
    Left = 456
    Top = 140
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 504
    Top = 140
  end
end
