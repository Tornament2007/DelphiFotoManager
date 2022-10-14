object DelFileMenu: TDelFileMenu
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = ' File deletion'
  ClientHeight = 184
  ClientWidth = 408
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
  object Button1: TButton
    Left = 304
    Top = 151
    Width = 96
    Height = 25
    Caption = 'Delet (Yes!)'
    Default = True
    ModalResult = 6
    TabOrder = 0
    OnClick = Button1Click
    OnKeyPress = Button1KeyPress
  end
  object Button2: TButton
    Left = 202
    Top = 151
    Width = 96
    Height = 25
    Caption = 'Exit (No!)'
    ModalResult = 7
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 151
    Width = 188
    Height = 25
    Caption = 'I don'#39't know!! (Run away)'
    ModalResult = 5
    TabOrder = 2
    OnClick = Button3Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 392
    Height = 137
    Caption = ' File:'
    TabOrder = 3
    object Label1: TLabel
      Left = 13
      Top = 19
      Width = 313
      Height = 13
      Caption = 
        'This file is lived for a long time, and served to you, all that ' +
        'time...'
    end
    object Label2: TLabel
      Left = 13
      Top = 38
      Width = 176
      Height = 13
      Caption = 'You had some good and bad times...'
    end
    object Label3: TLabel
      Left = 13
      Top = 57
      Width = 166
      Height = 13
      Caption = 'But you still together, still friends!!'
    end
    object Label4: TLabel
      Left = 13
      Top = 84
      Width = 168
      Height = 13
      Caption = 'And now YOU want to delete Him?!'
    end
    object Label5: TLabel
      Left = 13
      Top = 111
      Width = 271
      Height = 14
      Caption = 'Do YOU really want to KILL your best Friend !?!?!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
end
