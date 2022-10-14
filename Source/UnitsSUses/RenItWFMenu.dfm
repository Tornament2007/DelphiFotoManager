object RenFilMenu: TRenFilMenu
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = ' Renaming Menu '
  ClientHeight = 136
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 337
    Height = 41
    Caption = ' Old File Name '
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 18
      Width = 54
      Height = 13
      Caption = '"File Name"'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 55
    Width = 337
    Height = 42
    Caption = ' New File Name '
    TabOrder = 1
    object Edit1: TEdit
      Left = 10
      Top = 16
      Width = 317
      Height = 21
      TabOrder = 0
      TextHint = 'Enter new file name'
      OnChange = Edit1Change
      OnKeyPress = Edit1KeyPress
    end
  end
  object Button1: TButton
    Left = 231
    Top = 103
    Width = 113
    Height = 25
    Caption = ' Rename!'
    ModalResult = 6
    TabOrder = 2
  end
  object Button2: TButton
    Left = 8
    Top = 103
    Width = 113
    Height = 25
    Caption = ' Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
