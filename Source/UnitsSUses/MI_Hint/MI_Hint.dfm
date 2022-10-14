object MyHintWindow: TMyHintWindow
  Left = 0
  Top = 0
  Caption = 'MyHintWindow'
  ClientHeight = 243
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 33
    Height = 13
    Caption = 'Label1'
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 104
    Top = 80
  end
end
