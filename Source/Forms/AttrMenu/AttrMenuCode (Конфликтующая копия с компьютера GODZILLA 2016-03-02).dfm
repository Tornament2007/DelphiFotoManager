object AttrMenu: TAttrMenu
  Left = 926
  Top = 214
  BorderStyle = bsToolWindow
  Caption = ' Attributes'
  ClientHeight = 393
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
  object GroupBox1: TGroupBox
    Left = 5
    Top = 0
    Width = 323
    Height = 44
    Caption = ' File Name '
    TabOrder = 0
    object LFileName: TLabel
      Left = 10
      Top = 19
      Width = 306
      Height = 13
      AutoSize = False
      Caption = 'Not Selected'
    end
  end
  object GroupBox2: TGroupBox
    Left = 5
    Top = 45
    Width = 323
    Height = 66
    Caption = ' Name S Theme '
    TabOrder = 1
    OnMouseUp = GroupBox1MouseUp
    object Lname: TLabel
      Left = 9
      Top = 19
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object LTheme: TLabel
      Left = 9
      Top = 42
      Width = 36
      Height = 13
      Caption = 'Theme:'
    end
    object AttrN: TEdit
      Left = 53
      Top = 16
      Width = 245
      Height = 21
      BevelOuter = bvSpace
      TabOrder = 0
      TextHint = 'Image Name'
      OnChange = AttrNChange
      OnKeyPress = AttrNKeyPress
      OnKeyUp = AttrNKeyUp
    end
    object AttrT: TEdit
      Left = 53
      Top = 40
      Width = 245
      Height = 21
      TabOrder = 1
      TextHint = 'Image Theme'
      OnChange = AttrNChange
      OnKeyPress = AttrNKeyPress
      OnKeyUp = AttrNKeyUp
    end
    object SAttrN: TPanel
      Left = 302
      Top = 16
      Width = 14
      Height = 21
      BevelInner = bvRaised
      Caption = 'S'
      TabOrder = 2
      OnClick = SAttrNClick
      OnMouseDown = SAttrNMouseDown
      OnMouseUp = SAttrNMouseUp
    end
    object SAttrT: TPanel
      Left = 302
      Top = 40
      Width = 14
      Height = 21
      BevelInner = bvRaised
      Caption = 'S'
      TabOrder = 3
      OnClick = SAttrNClick
      OnMouseDown = SAttrNMouseDown
      OnMouseUp = SAttrNMouseUp
    end
  end
  object GroupBox3: TGroupBox
    Left = 5
    Top = 110
    Width = 323
    Height = 70
    Caption = ' Description '
    TabOrder = 2
    OnMouseUp = GroupBox1MouseUp
    object AttrD: TMemo
      Left = 8
      Top = 16
      Width = 308
      Height = 45
      TabOrder = 0
      OnChange = AttrDChange
      OnKeyDown = AttrDKeyDown
    end
  end
  object GroupBox4: TGroupBox
    Left = 5
    Top = 180
    Width = 323
    Height = 66
    Caption = ' Tags'
    TabOrder = 3
    OnMouseUp = GroupBox1MouseUp
    object AttrTa: TComboBox
      Left = 10
      Top = 40
      Width = 220
      Height = 21
      AutoDropDown = True
      ParentShowHint = False
      ShowHint = False
      Sorted = True
      TabOrder = 1
      TextHint = 'Enter single tag to add'
      OnClick = AttrTaClick
      OnKeyPress = AttrTaKeyPress
      OnKeyUp = AttrTaKeyUp
    end
    object AttrX: TEdit
      Left = 9
      Top = 19
      Width = 307
      Height = 21
      TabOrder = 0
      TextHint = 'Image TAGs'
      OnChange = AttrXChange
      OnKeyPress = AttrNKeyPress
      OnKeyUp = AttrXKeyUp
    end
    object AddToX: TPanel
      Left = 231
      Top = 40
      Width = 85
      Height = 21
      Caption = 'Add >^'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = AddToXClick
    end
  end
  object GroupBox5: TGroupBox
    Left = 5
    Top = 247
    Width = 323
    Height = 103
    Caption = ' Other '
    TabOrder = 4
    OnMouseUp = GroupBox1MouseUp
    object AttrRSh2: TLabel
      Left = 11
      Top = 83
      Width = 35
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '"00"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LAuthor: TLabel
      Left = 9
      Top = 19
      Width = 37
      Height = 13
      Caption = 'Author:'
    end
    object LCamera: TLabel
      Left = 8
      Top = 43
      Width = 41
      Height = 13
      Caption = 'Camera:'
    end
    object LRating: TLabel
      Left = 10
      Top = 69
      Width = 35
      Height = 13
      Caption = 'Rating:'
    end
    object AttrRsh: TLabel
      Left = 10
      Top = 84
      Width = 35
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '"00"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object AttrR: TTrackBar
      Left = 48
      Top = 65
      Width = 252
      Height = 31
      Max = 100
      TabOrder = 2
      OnChange = AttrRChange
      OnKeyPress = AttrRKeyPress
      OnKeyUp = AttrRKeyUp
    end
    object AttrC: TComboBox
      Left = 53
      Top = 40
      Width = 245
      Height = 21
      TabOrder = 1
      TextHint = 'Used camera'
      OnChange = AttrAChange
      OnKeyPress = AttrAKeyPress
      OnKeyUp = AttrAKeyUp
    end
    object AttrA: TComboBox
      Left = 53
      Top = 16
      Width = 245
      Height = 21
      TabOrder = 0
      TextHint = 'Author of Photo'
      OnChange = AttrAChange
      OnKeyPress = AttrAKeyPress
      OnKeyUp = AttrAKeyUp
    end
    object SAttrR: TPanel
      Left = 302
      Top = 65
      Width = 14
      Height = 30
      BevelInner = bvRaised
      Caption = 'S'
      TabOrder = 3
      OnClick = SAttrRClick
      OnMouseDown = SAttrNMouseDown
      OnMouseUp = SAttrRMouseUp
    end
    object SAttrC: TPanel
      Left = 302
      Top = 38
      Width = 14
      Height = 21
      BevelInner = bvRaised
      Caption = 'S'
      TabOrder = 4
      OnClick = SAttrAClick
      OnMouseDown = SAttrNMouseDown
      OnMouseUp = SAttrAMouseUp
    end
    object SAttrA: TPanel
      Left = 302
      Top = 16
      Width = 14
      Height = 21
      BevelInner = bvRaised
      Caption = 'S'
      TabOrder = 5
      OnClick = SAttrAClick
      OnMouseDown = SAttrNMouseDown
      OnMouseUp = SAttrAMouseUp
    end
  end
  object SAttrD: TPanel
    Left = 277
    Top = 113
    Width = 44
    Height = 14
    BevelInner = bvRaised
    Caption = 'Save'
    TabOrder = 5
    OnClick = SAttrDClick
    OnMouseDown = SAttrNMouseDown
    OnMouseUp = SAttrDMouseUp
  end
  object CBListChanges: TCheckBox
    Left = 8
    Top = 371
    Width = 164
    Height = 17
    Caption = 'Auto Save Changes'
    Enabled = False
    TabOrder = 6
  end
  object AM_LangWL: TListBox
    Left = 334
    Top = 8
    Width = 243
    Height = 380
    ItemHeight = 13
    Items.Strings = (
      'Nothing to write'
      'Need to Write:'
      'Files!'
      'File'
      'of'
      'Writed!'
      'Not Writed!'
      'Files were writed!'
      'Information Writed successfully'
      'Information was not written'
      'Attributes:'
      '"Not Selected"'
      'File Name'
      'Files Selected'
      'Attributes of'
      'Files'
      'Can'#8217't read Attributes!!! ERROR!!! :(')
    TabOrder = 7
    Visible = False
  end
  object CheckBox1: TCheckBox
    AlignWithMargins = True
    Left = 8
    Top = 356
    Width = 315
    Height = 17
    Caption = 'Auto add new words to the "Fast Words"'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object SAttrX: TPanel
    Left = 277
    Top = 185
    Width = 44
    Height = 14
    BevelInner = bvRaised
    Caption = 'Save'
    TabOrder = 9
    OnClick = SAttrXClick
    OnMouseDown = SAttrNMouseDown
    OnMouseUp = SAttrNMouseUp
  end
end
