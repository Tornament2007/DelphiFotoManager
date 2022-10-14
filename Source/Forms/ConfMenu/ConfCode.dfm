object ConfForm: TConfForm
  Left = 594
  Top = 290
  BorderStyle = bsDialog
  Caption = ' Configurations'
  ClientHeight = 407
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object CM_LangWL: TListBox
    Left = 402
    Top = 8
    Width = 225
    Height = 192
    ItemHeight = 13
    Items.Strings = (
      'Program not set'
      'Workin directory not set!'
      'working means directory with fotos (where Years folders)'
      'Default'
      'Lang file installed'
      'Lang file not installed'
      'Wrong file extension!'
      'Already installed!'
      
        'Select folder or create new one, for storage foto.  Folder shoul' +
        'd be empty.'
      'Set')
    TabOrder = 2
    Visible = False
  end
  object CBSeditAtr: TCheckBox
    Left = 8
    Top = 364
    Width = 367
    Height = 17
    Caption = 'Show "Attributs Edit" in  "File Menu"'
    TabOrder = 0
    OnClick = CBSeditAtrClick
  end
  object GroupBox1: TGroupBox
    Left = 262
    Top = 151
    Width = 116
    Height = 98
    Caption = ' Save Position of: '
    TabOrder = 1
    object Button1: TButton
      Left = 3
      Top = 14
      Width = 110
      Height = 25
      Caption = 'Main Menu'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 3
      Top = 41
      Width = 110
      Height = 25
      Caption = 'Config Menu'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 3
      Top = 68
      Width = 110
      Height = 25
      Caption = 'Attributes Menu'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 370
    Height = 65
    Caption = ' Main Photo Dir '
    TabOrder = 3
    object E_WDir: TEdit
      Left = 18
      Top = 15
      Width = 276
      Height = 21
      TabOrder = 0
      TextHint = 'Enter Path To The Foto Storage Dir'
      OnChange = E_WDirChange
      OnKeyPress = E_WDirKeyPress
      OnKeyUp = E_WDirKeyUp
    end
    object OpenWdir: TButton
      Left = 296
      Top = 37
      Width = 71
      Height = 22
      Caption = 'Open'
      TabOrder = 1
      OnClick = OpenWdirClick
    end
    object SaveWdir: TButton
      Left = 3
      Top = 37
      Width = 71
      Height = 22
      Caption = 'Save'
      Enabled = False
      TabOrder = 2
      OnClick = SaveWdirClick
    end
    object resetpath: TButton
      Left = 3
      Top = 15
      Width = 14
      Height = 21
      Caption = 'R'
      Enabled = False
      TabOrder = 3
      OnClick = resetpathClick
    end
    object Explore_BT: TButton
      Left = 296
      Top = 15
      Width = 71
      Height = 21
      Caption = 'Explorer...'
      TabOrder = 4
      OnClick = Explore_BTClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 79
    Width = 370
    Height = 66
    Caption = ' Language '
    TabOrder = 4
    object Label1: TLabel
      Left = 212
      Top = 17
      Width = 150
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '"..\Data\Lang\lang_xx.Lang"'
      OnDblClick = Label1DblClick
    end
    object Label2: TLabel
      Left = 7
      Top = 42
      Width = 107
      Height = 13
      Caption = 'Language Installation:'
    end
    object ComboBox1: TComboBox
      Left = 32
      Top = 14
      Width = 177
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      TextHint = 'Language'
      OnChange = ComboBox1Change
    end
    object RefreshList: TPanel
      Left = 7
      Top = 15
      Width = 19
      Height = 19
      Caption = 'RefreshList'
      ShowCaption = False
      TabOrder = 1
      object Image1: TImage
        Left = 1
        Top = 1
        Width = 17
        Height = 17
        Hint = 'Reload File List'
        Align = alClient
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000120000
          00120802000000D9AC19000000000467414D410000B18F0BFC61050000000970
          48597300000EC200000EC20115284A800000001A74455874536F667477617265
          005061696E742E4E45542076332E352E313030F472A1000002ED4944415478DA
          7D936B48536118C79F77C72DDBE674E6665EF036175D895A098112A925B12266
          4485094256667E4823BA1111099661E5879210FAD0CDFA60614A7D524C4B99A2
          8653A681B7D45AED7676DCE5B8F7BCE774242B4DE9CFC3FBE9F9BDCF1DD1340D
          BFF51ABF6BA53BBBBC3DD3B651F567E78FB5AA63C9F9B7B5D76089D01F4C6B59
          C7218C38104D61C7D1431E875E0D524CA4D289CC31D1A1F8CDFED19191739915
          BB371F98C36ABDCF2AA6AB19BF2BAE9759C10497FE4D58D473C91DD9AFD35858
          B6D637D14AA33CEB9917B697291D4E440420405121C5E997F3B796FD02D2AAD5
          C00B2000D325618FC823C7028EE7E44B378D141F12567E71470ECF884E86C4F4
          9ADCA67F42A5DD8D105F7B3D44EC821025783E52A57BCB91BC2526BEFD1BF010
          A55CFDF6C4D0D20CEB2CF76F3EBD821950EAC556C0CC7B38935D8E3694CB309E
          ABE764FAC5C2ED1717028F06EF5CF03D08E104E0F8F83E1A89D902CCB428B293
          72514655DC77661A21643EEBFE27CE9E8729D3A1B3D8C75314C89D01E2070183
          F7133AB4E5D45C274FD7EFAB39D804CB69EFDD8DAEF100B512110E7B6CCCEC98
          40BECB8A0BCBD0C271FF47D73D553BD91D1A47B8CD66CBCACA9AC38A06CEBDE2
          1A38B1600A4269481CF47614D916326B86D31C93AE9057B84079B8B2B2727E4B
          B49DA944092A272F108E899281042441216328F2755EB7E811654EE5550053BC
          E209A7EC5658ADD6792CDAACC3A35C823B20F306855904A1822F46B18DD23D3E
          DAA669D3910884082499DDFE4E7261D7BD828282DF58BF8EFB0A3AAB73760A7C
          BD087B656815E68BD57EB5D872047E90B9B8E87E2630A01C6E9CFABBCAAB0652
          E5433866D2E3EB03EC8708038C6D0A27F1529585251208F30683AD416E4232DE
          E15A7401D15DA9B1BDB434C0D1662A7C3D4161E050856229856C44FA1993513E
          569E7CFEF85593C9B408D3F4E992DB9DE21E7795D28D8D8DB76A6E18334C7575
          752CCB6A341A83C160341A73727296BFB73F6A6868D06AB5CDCDCD76BB5DAFD7
          9794942C1DE34FF920738AD2A69B2B0000000049454E44AE426082}
        OnDblClick = Image1DblClick
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
    object Panel1: TPanel
      Left = 125
      Top = 36
      Width = 220
      Height = 23
      Caption = '"Drag | Drop" Lang File Here'
      Color = clScrollBar
      ParentBackground = False
      TabOrder = 2
    end
    object LIA: TPanel
      Left = 348
      Top = 36
      Width = 16
      Height = 23
      Caption = 'C'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = LIAClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 255
    Width = 370
    Height = 59
    Caption = ' Photo thumbnails settings'
    TabOrder = 5
    object L_TN_S: TLabel
      Left = 7
      Top = 19
      Width = 23
      Height = 13
      Caption = 'Size:'
    end
    object L_TN_AS: TLabel
      Left = 327
      Top = 19
      Width = 33
      Height = 13
      Alignment = taCenter
      Caption = ': 80(3)'
    end
    object TrackBar1: TTrackBar
      Left = 44
      Top = 16
      Width = 283
      Height = 21
      Max = 167
      Min = 50
      Position = 80
      PositionToolTip = ptTop
      TabOrder = 0
      ThumbLength = 16
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar1Change
    end
    object InstPain: TCheckBox
      Left = 7
      Top = 36
      Width = 355
      Height = 17
      Caption = 'Instant paint while loading'
      TabOrder = 1
      OnClick = InstPainClick
    end
  end
  object ShowFotoCount: TCheckBox
    Left = 8
    Top = 385
    Width = 367
    Height = 17
    Caption = 'Show Foto count in folders (select day list)'
    TabOrder = 6
    OnClick = ShowFotoCountClick
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 314
    Width = 370
    Height = 44
    Caption = 'Other settings '
    TabOrder = 7
    object StartFromY: TLabel
      Left = 8
      Top = 18
      Width = 78
      Height = 13
      Caption = 'Start year from:'
    end
    object SEStartFromY: TSpinEdit
      Left = 96
      Top = 15
      Width = 65
      Height = 22
      MaxLength = 4
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 2010
      OnChange = SEStartFromYChange
    end
  end
  object ConfLog: TRichEdit
    Left = 8
    Top = 151
    Width = 251
    Height = 98
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    OnChange = ConfLogChange
  end
end
