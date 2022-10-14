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
    Left = 3
    Top = 1
    Width = 326
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
    Left = 3
    Top = 46
    Width = 326
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
      OnChange = Attr_Change
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
      OnChange = Attr_Change
      OnKeyPress = AttrNKeyPress
      OnKeyUp = AttrNKeyUp
    end
    object SAttrN: TButton
      Left = 300
      Top = 15
      Width = 23
      Height = 23
      ImageAlignment = iaCenter
      ImageIndex = 10
      Images = MainForm.Regular
      TabOrder = 2
      OnClick = SAttr_Click
      OnMouseUp = SAttrNMouseUp
    end
    object SAttrT: TButton
      Left = 300
      Top = 39
      Width = 23
      Height = 23
      ImageAlignment = iaCenter
      ImageIndex = 10
      Images = MainForm.Regular
      TabOrder = 3
      OnClick = SAttr_Click
      OnMouseUp = SAttrNMouseUp
    end
  end
  object GroupBox3: TGroupBox
    Left = 3
    Top = 111
    Width = 326
    Height = 70
    Caption = ' Description '
    TabOrder = 2
    OnMouseUp = GroupBox1MouseUp
    object AttrD: TMemo
      Left = 6
      Top = 14
      Width = 292
      Height = 49
      TabOrder = 0
      OnChange = Attr_Change
      OnKeyDown = AttrDKeyDown
    end
    object SAttrD: TButton
      Left = 300
      Top = 13
      Width = 23
      Height = 51
      ImageAlignment = iaCenter
      ImageIndex = 10
      Images = MainForm.Regular
      TabOrder = 1
      OnClick = SAttr_Click
      OnMouseUp = SAttrNMouseUp
    end
  end
  object GroupBox4: TGroupBox
    Left = 3
    Top = 181
    Width = 326
    Height = 66
    Caption = ' Tags'
    TabOrder = 3
    OnMouseUp = GroupBox1MouseUp
    object AddToX: TButton
      Left = 212
      Top = 38
      Width = 87
      Height = 23
      Caption = 'Add'
      ImageAlignment = iaRight
      ImageIndex = 88
      Images = MainForm.Regular
      TabOrder = 3
      OnClick = AddToXClick
    end
    object AttrTa: TComboBox
      Left = 9
      Top = 39
      Width = 205
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
      Width = 289
      Height = 21
      TabOrder = 0
      TextHint = 'Image TAGs'
      OnChange = Attr_Change
      OnKeyPress = AttrNKeyPress
      OnKeyUp = AttrXKeyUp
    end
    object SAttrX: TButton
      Left = 300
      Top = 18
      Width = 23
      Height = 43
      ImageAlignment = iaCenter
      ImageIndex = 10
      Images = MainForm.Regular
      TabOrder = 2
      OnClick = SAttr_Click
      OnMouseUp = SAttrNMouseUp
    end
  end
  object GroupBox5: TGroupBox
    Left = 3
    Top = 248
    Width = 326
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
    object SAttrA: TButton
      Left = 300
      Top = 15
      Width = 23
      Height = 23
      ImageAlignment = iaCenter
      ImageIndex = 10
      Images = MainForm.Regular
      TabOrder = 3
      OnClick = SAttr_Click
      OnMouseUp = SAttrNMouseUp
    end
    object SAttrC: TButton
      Left = 300
      Top = 39
      Width = 23
      Height = 23
      ImageAlignment = iaCenter
      ImageIndex = 10
      Images = MainForm.Regular
      TabOrder = 4
      OnClick = SAttr_Click
      OnMouseUp = SAttrNMouseUp
    end
    object AttrR: TTrackBar
      Left = 46
      Top = 65
      Width = 258
      Height = 31
      Max = 100
      TabOrder = 2
      OnChange = Attr_Change
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
      OnChange = Attr_Change
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
      OnChange = Attr_Change
      OnKeyPress = AttrAKeyPress
      OnKeyUp = AttrAKeyUp
    end
    object SAttrR: TButton
      Left = 300
      Top = 67
      Width = 23
      Height = 27
      ImageAlignment = iaCenter
      ImageIndex = 10
      Images = MainForm.Regular
      TabOrder = 5
      OnClick = SAttr_Click
      OnMouseUp = SAttrNMouseUp
    end
  end
  object CBListChanges: TCheckBox
    Left = 6
    Top = 372
    Width = 164
    Height = 17
    Caption = 'Auto Save Changes'
    Enabled = False
    TabOrder = 5
  end
  object AM_LangWL: TListBox
    Left = 334
    Top = 8
    Width = 243
    Height = 380
    ItemHeight = 13
    Items.Strings = (
      'Nothing to save'
      'Need to Write: %d Files!'
      '---'
      '---'
      '---'
      'File %d of %d Writed!'
      'File %d of %d not Writed!'
      '%d Files were writed!'
      'Information Writed successfully'
      'Information was not written'
      'Attributes:'
      '"Not Selected"'
      'File Name'
      'File Name | Files Selected %d'
      '---'
      'Attributes of %d Files'
      'Can'#8217't read Attributes !ERROR')
    TabOrder = 6
    Visible = False
  end
  object CheckBox1: TCheckBox
    AlignWithMargins = True
    Left = 6
    Top = 357
    Width = 315
    Height = 17
    Caption = 'Auto add new words to the "Fast Words"'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
end
