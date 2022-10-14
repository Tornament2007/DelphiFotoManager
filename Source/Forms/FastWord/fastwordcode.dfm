object FastWord: TFastWord
  Tag = 1
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = ' "Fast Word" Editor'
  ClientHeight = 266
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Editor1: TPanel
    Left = 8
    Top = 8
    Width = 73
    Height = 25
    BevelInner = bvLowered
    BevelOuter = bvNone
    BevelWidth = 3
    BorderWidth = 1
    BorderStyle = bsSingle
    Caption = 'Tags'
    TabOrder = 1
    OnClick = Editor1Click
  end
  object Editor2: TPanel
    Left = 79
    Top = 8
    Width = 74
    Height = 25
    BevelInner = bvRaised
    BevelOuter = bvNone
    BevelWidth = 3
    BorderWidth = 1
    BorderStyle = bsSingle
    Caption = 'Camera'
    TabOrder = 2
    OnClick = Editor1Click
  end
  object Editor3: TPanel
    Left = 151
    Top = 8
    Width = 74
    Height = 25
    BevelInner = bvRaised
    BevelOuter = bvNone
    BevelWidth = 3
    BorderWidth = 1
    BorderStyle = bsSingle
    Caption = 'Author'
    TabOrder = 3
    OnClick = Editor1Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 89
    Width = 217
    Height = 169
    ItemHeight = 13
    TabOrder = 4
    OnClick = ListBox1Click
    OnDblClick = ListBox1DblClick
  end
  object Edit1: TEdit
    Left = 8
    Top = 38
    Width = 185
    Height = 21
    TabOrder = 0
    TextHint = 'Enter tags to be add'
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
    OnKeyUp = Edit1KeyUp
  end
  object DeB: TButton
    Left = 155
    Top = 61
    Width = 70
    Height = 25
    Caption = 'Delet'
    Enabled = False
    TabOrder = 5
    OnClick = DeBClick
  end
  object AdB: TButton
    Left = 8
    Top = 61
    Width = 70
    Height = 25
    Caption = 'Add'
    Enabled = False
    TabOrder = 6
    OnClick = AdBClick
  end
  object EdB: TButton
    Left = 84
    Top = 61
    Width = 65
    Height = 25
    Caption = 'Edit'
    Enabled = False
    TabOrder = 7
    OnClick = EdBClick
  end
  object LangWL: TListBox
    Left = 231
    Top = 8
    Width = 122
    Height = 250
    ItemHeight = 13
    Items.Strings = (
      'Enter'
      'to be add')
    TabOrder = 8
    Visible = False
  end
  object UpDown1: TUpDown
    Tag = 1
    Left = 195
    Top = 38
    Width = 26
    Height = 20
    Orientation = udHorizontal
    TabOrder = 9
    OnClick = UpDown1Click
  end
end
