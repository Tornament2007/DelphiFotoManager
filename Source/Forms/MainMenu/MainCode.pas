unit MainCode;

{

ЛистБокс онклик:
  При мульте:
    При загрузке тегов:
      Среднее значение, и если сходятся то зеленым текст...

 ***     Использовать для имени папок дней(и отображение) полное имя года
 ****    Скрывать ненужные атрибуты
 ***     Фильтр для дурно ввода *

 ****    добавить РЕНЕЙМ Ф2

 ***     переключить поиск по ИМЕНИ в главном, кроме ТЭГа
 ***     Shift след выдаёт следующий существующий.
 ****    Перекодить быстрый просмотр    !!!!!!

 ****    "Установить дату" в (М)Поиск по ТЭГам

  Бла бла бла...

        #############    GOD with me! #############

Еще что то важное; ...
04.02.14 10:14 AM
30.11.14 23:11 PM
}
interface

uses uShell, MenuItemHint,
     Windows, SysUtils, Controls, Menus, StdCtrls, Classes, Forms, iniFiles,
     DateUtils, ExtCtrls, Graphics, ShellApi, clipBrd, ComCtrls, FileAttronTini,
     StrUtils, pngimage, messages, Vcl.AppEvnts, kudrag, Vcl.ImgList,
  Vcl.CategoryButtons, System.ImageList;


type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    Programm1: TMenuItem;
    Configuretions1: TMenuItem;
    Close1: TMenuItem;
    N1: TMenuItem;
    Hidetotray1: TMenuItem;
    Minimize1: TMenuItem;
    YPP: TPopupMenu;
    MPP: TPopupMenu;
    DPP: TPopupMenu;
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    Timer2: TTimer;
    TrayIcon1: TTrayIcon;
    TrayPop: TPopupMenu;
    Exit1: TMenuItem;
    N2: TMenuItem;
    Show1: TMenuItem;
    PPForFiles: TPopupMenu;
    GridPanel: TPanel;
    Edit1: TEdit;
    Find: TButton;
    DTP2: TDateTimePicker;
    PTotalList: TPanel;
    OpenShow1: TMenuItem;
    PPEdit2: TMenuItem;
    Copy1: TMenuItem;
    N3: TMenuItem;
    RenameFile1: TMenuItem;
    DeletFile1: TMenuItem;
    Renameto1: TMenuItem;
    N4: TMenuItem;
    EditTags1: TMenuItem;
    EditAuthor1: TMenuItem;
    EditGroup1: TMenuItem;
    EditDescription1: TMenuItem;
    EditTheme1: TMenuItem;
    N5: TMenuItem;
    PPFileName1: TMenuItem;
    CBFastPrev: TCheckBox;
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    CopNowBt: TButton;
    OpenNow: TButton;
    SetBt: TButton;
    EditName1: TMenuItem;
    Convertto1: TMenuItem;
    JPG1: TMenuItem;
    BMP1: TMenuItem;
    PNG1: TMenuItem;
    GA1: TMenuItem;
    RAW1: TMenuItem;
    Options1: TMenuItem;
    SetChangeEditorProgramm1: TMenuItem;
    OtherMenus1: TMenuItem;
    agSearch1: TMenuItem;
    ListBox1: TListBox;
    CBLoadAttr: TCheckBox;
    Info1: TMenuItem;
    Author1: TMenuItem;
    ShowChLo: TMenuItem;
    GroupBox2: TGroupBox;
    OpenSel: TButton;
    CopSelBt: TButton;
    LangWL: TListBox;
    FastWors1: TMenuItem;
    License1: TMenuItem;
    OpenProgFolder1: TMenuItem;
    N6: TMenuItem;
    GroupBox3: TGroupBox;
    OpenPhot: TButton;
    CA_But: TButton;
    Copy2: TMenuItem;
    Path1: TMenuItem;
    File1: TMenuItem;
    ScrollBox1: TScrollBox;
    CBLoadPrev: TCheckBox;
    CameraCMOptions: TPopupMenu;
    N7: TMenuItem;
    CCMO_AE: TMenuItem;
    CCMO_A3: TMenuItem;
    CCMO_A1: TMenuItem;
    CCMO_A4: TMenuItem;
    CCMO_A2: TMenuItem;
    RefrBut: TButton;
    Regular: TImageList;
    Ybt: TButton;
    YUpDo: TUpDown;
    Mbt: TButton;
    MUpDo: TUpDown;
    Dbt: TButton;
    DUpDo: TUpDown;
    DTP1: TDateTimePicker;
    Today_La: TLabel;
    CBDateLink: TCheckBox;
    Sel_la: TLabel;
    procedure Close1Click(Sender: TObject);
    procedure Minimize1Click(Sender: TObject);
    procedure OpenNowClick(Sender: TObject);
    procedure OpenSelClick(Sender: TObject);
    procedure CopSelBtClick(Sender: TObject);
    procedure CopNowBtClick(Sender: TObject);
    procedure OpenPhotClick(Sender: TObject);
    procedure DbtClick(Sender: TObject);
    procedure DTP1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Hidetotray1Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure MUpDoClick(Sender: TObject; Button: TUDBtnType);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBDateLinkClick(Sender: TObject);
    procedure DTP2Change(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PPForFilesPopup(Sender: TObject);
    procedure OpenShow1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure CBFastPrevClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure SetChangeEditorProgramm1Click(Sender: TObject);
    procedure SetBtClick(Sender: TObject);
    procedure SavePosition1Click(Sender: TObject);
    procedure PPEdit2Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Renameto1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure CBLoadAttrClick(Sender: TObject);
    procedure DeletFile1Click(Sender: TObject);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1Change(Sender: TObject);
    procedure FastWors1Click(Sender: TObject);
    procedure License1Click(Sender: TObject);
    procedure MbtClick(Sender: TObject);
    procedure YbtClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FindClick(Sender: TObject);
    procedure OpenProgFolder1Click(Sender: TObject);
    procedure agSearch1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PictureList1Click(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CA_ButClick(Sender: TObject);
    procedure Path1Click(Sender: TObject);
    procedure File1Click(Sender: TObject);
    //procedure CAc0Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ScrollBox1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure CBLoadPrevClick(Sender: TObject);
    procedure CopSelBtMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CopNowBtMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShowChLoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DPPPopup(Sender: TObject);
    procedure Author1Click(Sender: TObject);
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CCMO_A1Click(Sender: TObject);
    procedure CCMO_AEClick(Sender: TObject);
    procedure RefrButClick(Sender: TObject);

  published

  private
    { Private declarations }
    miHint : TMenuItemHint;
    fOldWndProc: TFarProc;
    procedure PopupListWndProc(var AMsg: TMessage);

    Procedure DDMCl(Sender: TObject);
    Procedure MMMCl(Sender: TObject);
    Procedure YYMCl(Sender: TObject);

    Procedure PCheck;

    procedure GIMU(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  public
    { public declarations }
    Function CorrectDay(IncDay,IncMon,IncYea:String): String;

    procedure isexsel;

    Procedure FillToday;
    Procedure FormToday;

    Procedure FormYeaList;
    Procedure FormMonList;
    Procedure FormDayList;

    Procedure SetStatus1(Text: String; StayTime: Integer = 2500; CCheck:Boolean = False);

    Function  ScanForFiles(DirIt:string = 'nul'; Camera:Boolean = False):Integer;

    Procedure DrawImages(Re:Boolean = False);

    function GetSettedDate(IncType:String):String;
  end;

const // Main
  AttrName: array[1..7] of string = ('Name', 'Theme', 'Rating', 'Tags',
    'Description', 'Author', 'Camera');
  //AttrWidth: array[1..8] of Byte = (135,101, 101, 110, 101, 150, 120, 110);
  AllSuEXT: array[1..13] of string = ('.bmp','.jpg','.jpe','.jfif','.jpeg',
    '.gif','.tif','.tiff','.tga','.png','.icon','.emf','.wmf');//Copy to AttrOnIni

var //Main Menu
  MainForm: TMainForm;
  Tod_Day,Tod_Mon,Tod_Yea,
  Sel_Day,Sel_Mon,Sel_Yea,
  Day_Path,Mon_Path,Yea_Path,
  SD_Path,SM_Path,SY_Path,
  SF_D_Path,SF_M_Path,SF_Y_Path:String;
  //isToday:Boolean;

var
  HereF,Data,Language,LangFEXT:string;

var //ConfigMenu & Configs
  WDir:String;
  MainConfF:TiniFile;


implementation

uses ConfCode,FsP, LookMenuCode, ProgSelectCode, AttrMenuCode, LanguageOperator,
     FastWordCode, LicenseCode, TagSearchCode, FM_Spec, ImageL_Index;

{$R *.dfm}

procedure TMainForm.agSearch1Click(Sender: TObject);
begin
    TagSearch.Show;
end;

procedure TMainForm.Author1Click(Sender: TObject);
begin
  if ShellExecute(Application.Handle, 'open', 'https://vk.com/id15827175',
  nil,nil,SW_SHOWNORMAL)=42 then
    SetStatus1(LangWL.Items[13]+': "https://vk.com/id15827175"',2000);
end;

procedure TMainForm.CopNowBtClick(Sender: TObject);
begin
  FormToday;
  Clipboard.AsText:=Day_Path;
  SetStatus1(Day_Path,1500,True);
end;

procedure TMainForm.CopNowBtMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then exit;
  Clipboard.AsText:=ExtractDir(Day_Path);
  SetStatus1(ExtractDir(Day_Path),1500,True);
end;

procedure TMainForm.CA_ButClick(Sender: TObject);

  Function getNextName(fName:String):String;      //;var lis:Tstrings
  var
    tNa:String;
    tN:Integer;
    OfName:String;
  Begin
    Result:='';
    OfName:=ExtractFileOName(fName);
    if AnCa(Copy(OfName,1,4))='pict' then
    begin
      tN:=StrToInt(Copy(OfName,5,4));
      Repeat
        Inc(tN);
        tNa:='000'+IntToStr(tN);
        tNa:=Copy(tNa,Length(tNa)-3,4);
        Result:=ExtractFilePath(fName)+'Pict'+tNa+ExtractFileExt(fName);
      Until (Not FileExists(Result));// and (pos(ExtractFileName(fName), lis.text) < 1));
      Exit;
    end
    else
    begin
      tN:=0;
      Repeat
        Inc(tN);
        Result:=ExtractFilePath(fName)+OfName+' ('+IntTOStr(tN)+')'
          +ExtractFileExt(fName);
      Until Not FileExists(Result);
    end;
  End;

Var
  twDir,fwDir:String;
  twList,twList2:Tstrings;

  I:Integer;
begin
  if (CA_But.ImageIndex<>1) then exit;

  if CCMO_AE.Tag>2 then //Selectad
    twDir:=SD_Path
  else
    twDir:=Day_Path;

  fwDir:=CA_But.Hint;

  //twList:=TStrings.Create;
  if Not DirectoryExists(fwDir) then
  begin
    SetStatus1('NTS!|'+fwDir);
    Exit;
  end;

  I:=ScanForFiles(fwDir,True);
  if I=0 then
  begin
    SetStatus1('Empty!');
    ScanForFiles;
    Exit;
  end;

  if Not DirectoryExists(twDir) then
    if not ForceDirectories(twDir) then
    begin
      SetStatus1(LangWL.Items[18]);
      exit;
    end;
  PCheck;

  twList:=ListBox1.Items;   // TEMP list of files
  if twList.Count>0 then
    for I := 0 to twList.Count-1 do
    begin
    //twList2 := Tstringlist.Create;
    //if FileExists(twDIr+ExtractFileName(twList[I])) then
        //twList.Add(getNextName(twDIr+ExtractFileName(twList[I]),twList2))
      //else
        //twList2.Add(getNextName(twDIr+ExtractFileName(twList[I]),twList2));
        //ConfForm.ConfLog.Lines.assign(twList2);
        //exit;

      if FileExists(twDIr+ExtractFileName(twList[I])) then
        CopyDir(twList[I],getNextName(twDIr+ExtractFileName(twList[I])),odd(CCMO_AE.Tag+1))
      else
        CopyDir(twList[I],twDIr+ExtractFileName(twList[I]),odd(CCMO_AE.Tag+1));
    end;

  ScanForFiles;
  ShellExecute(handle,'open',PwideChar(twDir),nil,nil,SW_SHOWNormal);
end;

procedure TMainForm.CopSelBtClick(Sender: TObject);
begin
  Clipboard.AsText:=SD_path;
  SetStatus1(SD_path,1500,True);
end;

procedure TMainForm.CopSelBtMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbRight then exit;
  Clipboard.AsText:=ExtractDir(SD_path);
  SetStatus1(ExtractDir(SD_path),1500,True);
end;

procedure TMainForm.SetBtClick(Sender: TObject);
begin
  FillToday;
  Ybt.Caption:=Tod_Yea;
  Mbt.Caption:=Tod_Mon;
  Dbt.Caption:=Tod_Day;
  if sender.ClassName<>'TButton' then
  begin
    Sel_Yea:=Tod_Yea;
    Sel_Mon:=Tod_Mon;
    Sel_Day:=Tod_Day;
  end;

  DTP1.Date:=Date;

  DTP1Change(DTP1);
    Sel_Yea:=Tod_Yea;
    Sel_Mon:=Tod_Mon;
    Sel_Day:=Tod_Day;
  PCheck;
end;

procedure TMainForm.CBDateLinkClick(Sender: TObject);
begin
  MainConfF.WriteBool('FileGridOptions','LinkDates',CBDateLink.Checked);
  if CBDateLink.Checked then
    begin
      DTP2.Date:=DTP1.Date;
      DTP2Change(DTP2);
    end;
end;

procedure TMainForm.CBFastPrevClick(Sender: TObject);
begin
  MainConfF.WriteBool('FileGridOptions','FastPreView',CBFastPrev.Checked);
end;

procedure TMainForm.CBLoadAttrClick(Sender: TObject);
begin
  MainConfF.WriteBool('FileGridOptions','LoadTags',CBLoadAttr.Checked);
end;

procedure TMainForm.CBLoadPrevClick(Sender: TObject);
begin
  ListBox1.Visible:=Not CBLoadPrev.Checked;
  ScrollBox1.Visible:=  CBLoadPrev.Checked;
  if CBLoadPrev.Checked then
  begin
    DrawImages;
    ListBox1Click(Self);
  end;
end;

procedure TMainForm.CCMO_A1Click(Sender: TObject);
begin
  CCMO_A1.Checked:=false;
  CCMO_A2.Checked:=false;
  CCMO_A3.Checked:=false;
  CCMO_A4.Checked:=false;

  if Sender.ToString='TMenuItem' then
  begin
    CCMO_AE.Tag:=(Sender As TMenuItem).Tag;
    MainConfF.WriteInteger('Camera','Action',(Sender As TMenuItem).Tag);
  end;
  (Findcomponent('CCMO_A'+IntToStr(CCMO_AE.Tag)) as TMenuItem).Checked:=true;

  CA_But.Caption:=(Findcomponent('CCMO_A'+IntToStr(CCMO_AE.Tag)) as TMenuItem).Caption;
  CA_But.ImageIndex:=Ord(DirectoryExists(OpenPhot.Hint+':\'));
end;

procedure TMainForm.CCMO_AEClick(Sender: TObject);
begin
  MainConfF.WriteBool('FileGridOptions','AutoCAE',CCMO_AE.Checked);
end;

procedure TMainForm.Close1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.Copy1Click(Sender: TObject);
var
  T_Str:String;
begin
  T_Str:=ListBox1.Items[ListBox1.ItemIndex];
  if CopyDir(T_Str,
          ExtractFilePath(T_Str)+ExtractFileOName(T_Str)+'_Copy'+ExtractFileEXT(T_Str), False)
  then
  begin
    SetStatus1(LangWL.Items[35]+' '+ExtractFileName(ListBox1.Items[ListBox1.ItemIndex]),3000);
    ScanForFiles;
  end;
end;

function TMainForm.CorrectDay(IncDay,IncMon,IncYea:String): String;
var
  daysin:integer;
  _Dstr:string;
begin
  Result:=IncDay+'.'+IncMon+'.'+IncYea;
  if (StrToInt(IncMon) in [1,3,5,7,8,10,12]) then daysin:=31;
  if (StrToInt(IncMon) in [4,6,9,11]) then daysin:=30;
  if (StrToInt(IncMon) = 2) then daysin:=28+Ord(IsLeapYear(StrToInt(IncYea)));
  if strtoint(IncDay)>daysIn then
    Result:=IntToStr(daysIn)+'.'+IncMon+'.'+IncYea;
end;

procedure TMainForm.DTP1Change(Sender: TObject);
Var
  JustDay,
  JustMonth,
  JustYear:String;
begin
  JustDay:= FormatDateTime('dd',DTP1.Date);
  JustMonth:= FormatDateTime('mm',DTP1.Date);
  JustYear:= FormatDateTime('yyyy',DTP1.Date);

  Dbt.Caption:=JustDay;
  Mbt.Caption:=JustMonth;
  Ybt.Caption:=JustYear;

  if JustYear<>Sel_Yea then
  begin
    Ybt.Caption:=JustYear;
    Sel_Yea:=JustYear;
  end
  else
  begin
    if JustMonth<>Sel_Mon then
    begin
      Mbt.Caption:=JustMonth;
      Sel_Mon:=JustMonth;
      if Sel_mon='02' then
        Sel_Day:=JustDay;
    end
    else
    if JustDay<>Sel_Day then
    begin
      Dbt.Caption:=JustDay;
      Sel_Day:=JustDay;
    end
    else
    begin
      exit;
    end;
  end;

  PCheck;

  if CBDateLink.Checked then
    begin
      DTP2.Date:=DTP1.Date;
      DTP2Change(DTP2);
    end;
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
  if Copy(Edit1.Text,1,1)=',' then Edit1.Text:=Copy(Edit1.Text,2,Length(Edit1.Text));

  IF Edit1.Text='FormLangFiles' then
  begin
    Edit1.Clear;
    WriteAllToFile(Self,Data+'Lang\','MainForm');
    WriteAllToFile(AttrMenu,Data+'Lang\','AttrMenu');
    WriteAllToFile(ConfForm,Data+'Lang\','ConfForm');
    WriteAllToFile(LookMenu,Data+'Lang\','LookMenu');
    WriteAllToFile(FastWord,Data+'Lang\','FastWord');
    WriteAllToFile(SelectProg,Data+'Lang\','SelectProg');
    WriteAllToFile(LicenseMenu,Data+'Lang\','LicenseMenu');
    WriteAllToFile(TagSearch,Data+'Lang\','TagSearch');
    SetStatus1('Done');
  end;
  IF Edit1.Text='LSM' then
  begin
    Edit1.Clear;
    Exit;
  end;
  IF (AnCa(Edit1.Text)='abra cadabra')
  or (AnCa(Edit1.Text)='abracadabra') then
  begin
    Edit1.Clear;
    SetStatus1('There is no Magic!');
  end;
  IF AnCa(Edit1.Text)='god' then
    SetStatus1('He loves YOU!');
end;

procedure TMainForm.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=Vk_Escape) and (Shift = []) then
  begin
    Edit1.Clear;
    ScanForFiles;
    if CBLoadPrev.Checked then
    begin
      DrawImages;
      ListBox1Click(Self);
    end;
    exit;
  end;
  if (Key=Vk_Return) and (Shift = []) then
  begin
    Find.Click;
    Exit;
  end;
end;

procedure TMainForm.Edit1KeyPress(Sender: TObject; var Key: Char);
var
  _Text:String;
begin
  _Text:=(Sender as Tedit).Text;
  if (key=',') and ((_Text='') or ((_Text<>'') and (_Text[Length(_Text)]=','))) then Key:=#0;
end;

procedure TMainForm.DTP2Change(Sender: TObject);
begin
  ScanForFiles;
  CBLoadPrevClick(CBLoadPrev);
end;

procedure TMainForm.DbtClick(Sender: TObject);
begin
  if DirectoryExists(SD_Path) then
  begin
    ShellExecute(handle,'open',PwideChar(SD_Path),nil,nil,SW_SHOWNormal);
    //Application.Minimize;
    end
  else
    SetStatus1(LangWL.Items[1]+' ;) ',1000);
end;

procedure TMainForm.DDMCl(Sender: TObject);
var
  _tStr:String;
begin
  _tStr:=GetIt((Sender as Tmenuitem).Caption);
  _tStr:=CorrectDay(_Tstr,FormatDateTime('mm',DTP1.Date),FormatDateTime('yyyy',DTP1.Date));

  DTP1.Date:=StrToDate(_tStr);
  DTP1Change(DTP1);
end;

procedure TMainForm.DeletFile1Click(Sender: TObject);
var
  FileName:String;
begin
  FileName:=ListBox1.Items[ListBox1.ItemIndex];

  if (sender as TmenuItem).Name='Copy1' then
    DelDir1(FileName)
  else
    DelDir1(FileName,True);
  ScanForFiles;
end;

procedure TMainForm.DPPPopup(Sender: TObject);
var
  SendL:String;
begin
  SendL:=Copy((Sender as TPopupMenu).Name,0,1);   //can be:M,D,Y
  case SendL[1] of
    'D': FormDayList;
    'M': FormMonList;
    'Y': FormYeaList;
  end;
end;

procedure TMainForm.DrawImages(Re:Boolean);
  procedure CreateGridAtPos(I,Step,W,TH_W,TH_H:Integer;FileN:String; Bim:TBitmap);
  var
    EPL,Poz,Line:Integer;
    iLeft,iTop:Integer;
  begin
    W:=W-16;
    EPL := Trunc(W / ((TH_W+Step*2) + Step/2));
    if EPL=0 then
      exit;
    Line := Trunc(I / EPL);
    Poz  := Trunc(I - (Line*EPL));

    //SetStatus1('Old: '+IntTOStr(step)+' New: '+IntTOStr(Trunc((W-EPL*TH_W)/(EPL*2))));
    iTop:=Trunc((W-EPL*TH_W)/(EPL*2));
    if iTop>step then
      step := iTop;

    iLeft := Step + (Poz*(TH_W)) + (Poz*Step*2) - (Ord(Poz=EPL)*Step);
    if step>5 then
      iTop  := 5 + (Line*(TH_H+27)) + (Line*3)
    else
      iTop  := Step + (Line*(TH_H+27)) + (Line*3);
    with TBevel.Create(ScrollBox1) do
    begin
      parent:=ScrollBox1;
      Name:='PrevB'+IntToStr(I);
      Left := iLeft;
      Top := iTop;
      Width := TH_W+3 ;
      Height := TH_H+3 ;
      BevelInner:=bvLowered;
      Shape := bsSpacer ;      // 0 - bsSpacer; 1 - bsFrame
      Hint := ExtractFileName(FileN) ;
      HelpType := htKeyword;
      ParentShowHint := False;
      ShowHint := True;
      OnMouseUp:=GIMU;
      //OnMouseDown:=GIMU;
      OnDblClick:=ListBox1DblClick;
      OnKeyUp:=ListBox1KeyUp;
    end;
    with TImage.Create(ScrollBox1) do
    begin
      parent:= ScrollBox1;
      Name := 'PrevI'+IntToStr(I) ;
      Left := 1 + iLeft ;
      Top  := 1 + iTop ;
      Width := TH_W ;
      Height := TH_H ;
      Center := True ;
      Stretch := True;
      ParentShowHint := False ;
      Proportional := True ;
      Hint := FileN ;
      ShowHint := False ;
      DoubleBuffered := True ;
      Picture.Bitmap.Assign(Bim);
      //Picture.Bitmap.LoadFromResourceName(HInstance,'IMG_ND_1');
      if ConfForm.InstPain.Checked then
        Invalidate;
      PopUpMenu := PPForFiles;
      OnMouseUp:=GIMU;
      //OnMouseDown:=GIMU;
      OnDblClick:=ListBox1DblClick;
      OnKeyUp:=ListBox1KeyUp;
    end;
    with Tlabel.Create(ScrollBox1) do
    begin
      parent:=ScrollBox1;
      Name := 'PrevN' + IntToStr(I) ;
      Left := 2 + iLeft;
      Top := 1 + TH_H + iTop;
      Width := TH_W-2;
      Height := 26;
      AutoSize := False ;
      WordWrap := True ;
      Caption := ExtractFileName(FileN) ;
      Hint := ExtractFileName(FileN) ;
      OnMouseUp:=GIMU;
      //OnMouseDown:=GIMU;
      OnDblClick:=ListBox1DblClick;
      OnKeyUp:=ListBox1KeyUp;
    end;
  end;

  procedure RePos(I,Step,W,TH_W,TH_H:Integer);
  var
    EPL,Poz,Line:Integer;
    iLeft,iTop:Integer;
    Bvl:TBevel;
    Img:TImage;
    Lbl:Tlabel;
  begin
    W:=W-16;
    //I:=Trunc(ScrollBox1.ComponentCount/3);
    EPL := Trunc(W / ((TH_W+Step*2) + Step/2));
    if EPL=0 then
      exit;
    iTop:=Trunc((W-EPL*TH_W)/(EPL*2));
    if iTop>step then
      step := iTop;
    //repeat
      //Dec(I);
      Line := Trunc(I / EPL);
      Poz  := Trunc(I - (Line*EPL));

      iLeft := Step + (Poz*(TH_W)) + (Poz*Step*2) - (Ord(Poz=EPL)*Step);
      if step>5 then
        iTop  := 5 + (Line*(TH_H+27)) + (Line*3)
      else
        iTop  := Step + (Line*(TH_H+27)) + (Line*3);

      Bvl:= (MainForm.ScrollBox1.FindComponent('PrevB'+IntToStr(I)) as TBevel);
      Img:= (MainForm.ScrollBox1.FindComponent('PrevI'+IntTOStr(I)) as TImage);
      Lbl:= (MainForm.ScrollBox1.FindComponent('PrevN'+IntTOStr(I)) as TLabel);
      if (Bvl=nil) or (Img=nil) or (Lbl=Nil) then
      begin
        SetStatus1('EERR'+IntTOStr(i));
        exit;
      end;
      Bvl.Top:=iTop;
      Bvl.Left:=iLeft;
      Bvl.Height:=TH_H+3;
      Bvl.Width:=TH_W+3;

      Img.Top:=1+iTop;
      Img.Left:=1+iLeft;
      Img.Height:=TH_H;
      Img.Width:=TH_W ;

      Lbl.Top:=1 + TH_H + iTop;
      Lbl.Left:=2 + iLeft;
      Lbl.Width:=TH_W-2;
  end;
Var

  FileN:String;
  TH_W,TH_H,i:integer;
  IWidth,IHeight:Word;
  Bim:TBitmap;
  img:TImage;
begin
  if (ListBox1.Items.Count=0)
  or (ListBox1.ItemIndex=-1)
  or (Dbt.ImageIndex<>ImageL.Ex)
  then exit;

  //(Re:Boolean = False)
  TH_W := ConfForm.TrackBar1.Position; //80
  TH_H := ConfForm.TrackBar1.Position;

  if (ScrollBox1.ComponentCount>0) and (Not Re) then
  begin
    repeat
      ScrollBox1.Components[ScrollBox1.ComponentCount-1].Free;
      //ShowMessage('ProjBox.ComponentCount: '+IntTostr(ProjBox.ComponentCount));
    until ScrollBox1.ComponentCount=0;
  end;

  I:=0;
  Bim:=Tbitmap.Create;
  repeat
    FileN:=ListBox1.items[I];
    if FileExists(FileN) then
    begin
      if Re then
        RePos(I,3,ScrollBox1.Width-4,TH_W,TH_H)
      else
      begin
        LookMenu.GetResJpg(FileN, IWidth, IHeight);
        LookMenu.ExtractThumb(TH_W,TH_H,FileN,IWidth,IHeight,Bim);
        CreateGridAtPos(I,3,ScrollBox1.Width-4,TH_W,TH_H,FileN,Bim);   //Width
      end
    end;
    Inc(I);
  until (I>=ListBox1.Count);
  Bim.Free;
  FreeMemory;
end;

procedure TMainForm.MMMCl(Sender: TObject);
var
  _tStr:String;
begin
  _tStr:=GetIt((Sender as Tmenuitem).Caption);
  _tStr:=CorrectDay(FormatDateTime('dd',DTP1.Date),_Tstr,FormatDateTime('yyyy',DTP1.Date));

  DTP1.Date:=StrToDate(_tStr);
  DTP1Change(DTP1);
end;

procedure TMainForm.YbtClick(Sender: TObject);
begin
  if DirectoryExists(SY_Path) then
  begin
    ShellExecute(handle,'open',PwideChar(SY_Path),nil,nil,SW_SHOWNormal);
    //Application.Minimize;
    end
  else
    SetStatus1(LangWL.Items[1]+' ;) ',1000);
end;

procedure TMainForm.YYMCl(Sender: TObject);
var
  _tStr:String;
begin
  _tStr:=GetIt((Sender as Tmenuitem).Caption);
  _tStr:=CorrectDay(FormatDateTime('dd',DTP1.Date),FormatDateTime('mm',DTP1.Date),_Tstr);

  DTP1.Date:=StrToDate(_tStr);
  DTP1Change(DTP1);
end;

procedure TMainForm.FastWors1Click(Sender: TObject);
begin
  FastWord.Show;
end;

procedure TMainForm.File1Click(Sender: TObject);
begin
  WinExplorer.FileToClipboard(ListBox1.Items[ListBox1.ItemIndex]);
  SetStatus1('"'+Clipboard.AsText+'" '+LangWL.Items[20]);
end;

procedure TMainForm.FillToday;
begin
  Tod_Day:=FormatDateTime('dd', Date);
  Tod_Mon:=FormatDateTime('mm', Date);
  Tod_Yea:=FormatDateTime('yyyy', Date);
  if Wdir[length(wdir)]<>'\' then
    Wdir:=Wdir+'\';
  Yea_Path:=Wdir+Tod_Yea+'\';
  Mon_Path:=Yea_Path+Tod_Mon+'\';
  Day_Path:=Mon_Path+Tod_Day+'.'+Tod_Mon+'.'+Copy(Tod_Yea,3,2)+'\';

  Today_La.Caption:=FormatDateTime('ddddd', Date)+' '+FormatDateTime('dddd', Date);


  if DirectoryExists(Day_Path) then
    OpenNow.Hint:=LangWL.Items[2]
  else
    OpenNow.Hint:=LangWL.Items[3];
end;

Procedure TMainForm.FormCreate(Sender: TObject);
var
  NewWndProc: TFarProc;
begin
  HereF:=ExtractFilePath(ParamStr(0));
  Data:= Pchar(HereF+'Data\');
  if not directoryexists(data) then Createdir('Data');
  LangFEXT:=RetLangEXT;

  MainConfF:=TiniFile.Create(Data+'Configs.Ini');
    Language:=MainConfF.ReadString('Main','Language','def');
    Self.Position:=poDesigned;
    MainForm.Left:=MainConfF.ReadInteger('MainForm','Left',MainForm.Left);
    MainForm.Top:= MainConfF.ReadInteger('MainForm','Top',MainForm.Top);
    MainForm.CCMO_AE.Tag:=MainConfF.ReadInteger('Camera','Action',1);
    if copy(Language,1,3)='EN (' then
      Language:='def';
  MainConfF.Free;
  ReadLang(Self,Data+'Lang\','Lang',Language); //Устанавливаем язык

  MainForm.Width:=391;   //Set Standart
  MainForm.Height:=555;  //Set Standart

  CCMO_A1Click(Self);

  Sel_la.Caption:=FormatDateTime('ddddd', DTP1.Date)+' '+FormatDateTime('dddd', DTP1.Date);

  miHint := TMenuItemHint.Create(self);

  NewWndProc := MakeObjectInstance(PopupListWndProc);   // для подсказок в дропах
  fOldWndProc := TFarProc(SetWindowLong(Menus.PopupList.Window, GWL_WNDPROC,
    integer(NewWndProc)));
{
//  private
    Var OldWindowProc: TWndMethod;
    procedure NewWindowProc(var Message: TMessage);
  OldWindowProc:= ScrollBox1.WindowProc;
  ScrollBox1.WindowProc:= NewWindowProc;

procedure TMainForm.NewWindowProc(var Message: TMessage);
begin
  OldWindowProc(Message);
  if Message.Msg = 277 then   //just vert croll
  begin
    //ScrollBox1.Update;
    //ScrollBox1.Repaint;
  end;
end; }


end;

procedure TMainForm.FormDayList;
Var
  ActDay,tI,IEnd:Integer;
  m: TMenuItem;
  MiName:String;
  TempPath,FINP:String;
begin
  IEnd:=Integer(DaysInMonth(StrtoDate('01.'+sel_Mon)));
  // 1 3 5 7 8 10 12 = 31
  // 4 6 9 11 = 30
  // 2 = {IsLeapYear(Year) > True = 29,False = 28}

  DPP.Items.Clear;
  ActDay:=0;
  tI:=0;
  with DPP do
    Repeat
      Inc(ActDay);
      Inc(tI);
      m:= TMenuItem.Create(nil);
      m.OnClick:= DDMCl;
      MiName:=IntToStr(ActDay);
      if Length(MiName)=1 then
        MiName:= '0'+IntToStr(ActDay);
      m.Caption:=MiName;
      TempPath:=Wdir+Sel_Yea+'\'+Sel_Mon+'\';
      FINP:=TempPath+MiName+'.'+Sel_Mon+'.'+Copy(Sel_Yea,3,2)+'\';

      if DirectoryExists(TempPath+IntToStr(ActDay)+'.'+Sel_Mon+'.'+Copy(Sel_Yea,3,2)+'\') then
        renamefile(TempPath+IntToStr(ActDay)+'.'+Sel_Mon+'.'+Copy(Sel_Yea,3,2)+'\',
                   FINP); //Day only
      if DirectoryExists(TempPath+MiName+'.'+FormatDateTime('m',StrToDate('1.'+Sel_Mon))+'.'+Copy(Sel_Yea,3,2)+'\') then
        renamefile(TempPath+MiName+'.'+FormatDateTime('m',StrToDate('1.'+Sel_Mon))+'.'+Copy(Sel_Yea,3,2)+'\',
                   FINP); //Month only
      if DirectoryExists(TempPath+MiName+'.'+Sel_Mon+'.'+Sel_Yea+'\') then
        renamefile(TempPath+MiName+'.'+Sel_Mon+'.'+Sel_Yea+'\',
                   FINP); //Year only

      if DirectoryExists(TempPath+IntToStr(ActDay)+'.'+FormatDateTime('m',StrToDate('1.'+Sel_Mon))+'.'+Copy(Sel_Yea,3,2)+'\') then
        renamefile(TempPath+IntToStr(ActDay)+'.'+FormatDateTime('m',StrToDate('1.'+Sel_Mon))+'.'+Copy(Sel_Yea,3,2)+'\',
                   FINP); //Day Month
      if DirectoryExists(TempPath+IntToStr(ActDay)+'.'+Sel_Mon+'.'+Sel_Yea+'\') then
        renamefile(TempPath+IntToStr(ActDay)+'.'+Sel_Mon+'.'+Sel_Yea+'\',
                   FINP); //Day Year
      if DirectoryExists(TempPath+MiName+'.'+FormatDateTime('m',StrToDate('1.'+Sel_Mon))+'.'+Sel_Yea+'\') then
        renamefile(TempPath+MiName+'.'+FormatDateTime('m',StrToDate('1.'+Sel_Mon))+'.'+Sel_Yea+'\',
                   FINP); //Month Year
      if DirectoryExists(TempPath+IntToStr(ActDay)+'.'+FormatDateTime('m',StrToDate('1.'+Sel_Mon))+'.'+Sel_Yea+'\') then
        renamefile(TempPath+IntToStr(ActDay)+'.'+FormatDateTime('m',StrToDate('1.'+Sel_Mon))+'.'+Sel_Yea+'\',
                   FINP); //Day Month Year

      //m.Caption:= m.Caption;
      if not DirectoryExists(FINP) then
        begin
          //m.Caption:= m.Caption;//+' '+LangWL.Items[1];
          m.ImageIndex:=ImageL.NEx;
          m.Hint:=LangWL.Items[1];
        end
      else
        begin
          //m.Caption:= m.Caption;//+' '+LangWL.Items[0];
          m.ImageIndex:=ImageL.Ex;
          if ConfForm.ShowFotoCount.Checked then
          begin
            m.Hint:='| '+IntToStr(ScanForFiles(FINP));
            m.Caption:=m.Caption+' '+m.Hint;
            m.Hint:=m.Hint+' |';
          end;
        end;
      m.Name:= 'DDm'+IntToStr(tI);
      Items.Add(m);
    Until ActDay>=IEnd;
  isexSel;
  if ConfForm.ShowFotoCount.Checked then
    ScanForFiles;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  NewWndProc: TFarProc;
begin
  NewWndProc := TFarProc(SetWindowLong(Menus.PopupList.Window, GWL_WNDPROC,
    integer(fOldWndProc)));
  FreeObjectInstance(NewWndProc);
end;

procedure TMainForm.FormMonList;
Var
  ActMon,tI:Integer;
  m: TMenuItem;
  MiName:string;
begin
  MPP.Items.Clear;
  ActMon:=0;
  tI:=0;

  with MPP do
    Repeat
      Inc(ActMon);
      Inc(tI);
      m:= TMenuItem.Create(nil);
      m.OnClick:= MMMCl;
      MiName:=IntToStr(ActMon);
      if Length(MiName)=1 then
        MiName:= '0'+IntToStr(ActMon);
      m.Caption:=MiName+' '+GetMonThNames(IntToStr(ActMon));
      if not DirectoryExists(Wdir+Sel_yea+'\'+IntToStr(ActMon)+'_'+GetMonThNames(IntToStr(ActMon))+'\') then
      renamefile(Wdir+Sel_yea+'\'+IntToStr(ActMon)+'_'+GetMonThNames(IntToStr(ActMon))+'\',
                   Wdir+Sel_yea+'\'+MiName+'\'); //Day Month
      if not DirectoryExists(Wdir+Sel_yea+'\'+MiName+'\') then
        begin
           //m.Caption:=m.Caption;//+' '+LangWL.Items[1];
           m.ImageIndex:=ImageL.NEx;
        end
      else
        begin
          //m.Caption:=m.Caption;//+' '+LangWL.Items[0];
          m.ImageIndex:=ImageL.Ex;
        end;

      m.Name:= 'MMm'+IntToStr(tI);
      Items.Add(m);
    Until ActMon>=12;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  FreeMemory;
  {if (LookMenu<>nil) and (LookMenu.Visible) then
    LookMenu.BringToFront;

  if (AttrMenu<>nil) and (AttrMenu.Visible) then
    AttrMenu.BringToFront;          }
end;

procedure TMainForm.FormYeaList;
Var
  ActYear,tI:Integer;
  m: TMenuItem;
begin
  YPP.Items.Clear;
  ActYear:=ConfForm.SEStartFromY.Value; //Def: Start from 2010
  ActYear:=ActYear -1;
  tI:=0;                //Start from 1
  with YPP do
  Repeat
    Inc(ActYear);
    Inc(tI);
    m:= TMenuItem.Create(nil);
    m.OnClick:= YYMCl;
    m.Caption:= IntToStr(ActYear);

    if not DirectoryExists(Wdir+IntToStr(ActYear)+'\') then
    begin
      m.Caption:= IntToStr(ActYear);//+' '+LangWL.Items[1];
      m.ImageIndex:=ImageL.NEx;
    end
    else
    begin
      m.Caption:= IntToStr(ActYear);//+' '+LangWL.Items[0];
      m.ImageIndex:=ImageL.Ex;
    end;

    m.Name:= 'YYm'+IntToStr(tI);
    Items.Add(m);
  Until ActYear>=StrToInt(Tod_Yea);
end;

procedure TMainForm.Path1Click(Sender: TObject);
begin
  Clipboard.AsText:=ListBox1.Items[ListBox1.ItemIndex];
  SetStatus1(ListBox1.Items[ListBox1.ItemIndex],1500,True);
end;

procedure TMainForm.FormToday;
begin
  OpenSel.Enabled:=False;
  FillToday;
  PCheck;
end;



function TMainForm.GetSettedDate(IncType: String): String;
var
  tS:string;
begin

  if IncType='D' then begin
      tS:=Wdir+Sel_Yea+'\'+IntToStr(StrToInt(Sel_Mon))+'\'+'\';
  end;
  if IncType='M' then begin

  end;
  if IncType='Y' then begin

  end;
end;

procedure TMainForm.GIMU(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  tTag,tI:Integer;  
begin
  if sender.ClassName='TImage' then
    tTag:=StrToInt(Copy((Sender as TImage).Name,6,3));
  if sender.ClassName='TBevel' then
    tTag:=StrToInt(Copy((Sender as TBevel).Name,6,3));
  if sender.ClassName='TLabel' then
    tTag:=StrToInt(Copy((Sender as TLabel).Name,6,3));

  if (Shift=[ssShift]) then
  begin
    if ScrollBox1.Tag>ListBox1.Items.Count-1 then ScrollBox1.Tag:=-1;
    if (ScrollBox1.Tag<>-1) and (ScrollBox1.Tag<>tTag) then begin
      if tTag>ScrollBox1.Tag then
        for tI := tTag Downto ScrollBox1.Tag do ListBox1.Selected[tI] := True 
      else
        for tI := tTag to ScrollBox1.Tag do ListBox1.Selected[tI] := True; 
      ListBox1.MultiSelect:=True;
      ListBox1Click(ListBox1);
      exit;          
    end;
  end else 
    
  if (Shift<>[ssCtrl]) and (Shift<>[ssShift]) then begin
    ListBox1.MultiSelect:=false;
    ScrollBox1.Tag:=tTag;
  end;
  
  ListBox1.MultiSelect:=True;
  ListBox1.ItemIndex:=tTag;
  ListBox1.Selected[tTag]:= not ListBox1.Selected[tTag];

  if ListBox1.SelCount=0 then
    ListBox1.Selected[tTag] := True;
  
  ListBox1Click(ListBox1);
end;

procedure TMainForm.Hidetotray1Click(Sender: TObject);
begin
  TrayIcon1.Visible:=true;
  MainForm.Hide;
end;

procedure TMainForm.Image1DblClick(Sender: TObject);
begin
  ScanForFiles;
  CBLoadPrevClick(CBLoadPrev);
end;

procedure TMainForm.isexsel;
begin
  OpenNow.Hint:=LangWL.Items[3-Ord(DirectoryExists(Day_Path))];
  if DirectoryExists(Day_Path) then
    OpenNow.ImageIndex:=ImageL.Folder_Open
  else
    OpenNow.ImageIndex:=ImageL.Folder_Create;

  OpenSel.Hint:=LangWL.Items[3-Ord(DirectoryExists(SD_Path)) ];
  if DirectoryExists(SD_Path) then
    OpenSel.ImageIndex:=ImageL.Folder_Open
  else
    OpenSel.ImageIndex:=ImageL.Folder_Create;

end;

procedure TMainForm.License1Click(Sender: TObject);
begin
  LicenseMenu.Show;
end;

procedure TMainForm.ListBox1Click(Sender: TObject);
var
  Ic,Sc,RN:Integer;
  selected:Boolean;
begin
  if (Not FileExists(listbox1.Items[listbox1.Itemindex])) then
  begin
    ScanForFiles; Exit;
  end;
  if (ListBox1.ItemIndex=-1)
  or (Dbt.ImageIndex<>ImageL.Ex)
  or (ListBox1.Items.Count=0)
  then exit;


  Ic:=ListBox1.Items.Count;
  Sc:=ListBox1.SelCount;
  RN:=-1;
  if CBLoadPrev.Checked then
  repeat
    inc(RN);
    if listbox1.Selected[RN] then
      (ScrollBox1.FindComponent('PrevB'+IntToStr(RN)) as TBevel).Shape:= bsFrame
    else                                      //TbevelStyle
      (ScrollBox1.FindComponent('PrevB'+IntToStr(RN)) as TBevel).Shape:= bsSpacer;
  until (RN>=IC-1);
  if sender = self then exit;

  if not (listbox1.Selected[listbox1.Itemindex]) then
  begin
    RN:=-1;
    selected:=False;
    repeat
      inc(RN);
      if listbox1.Selected[RN] then
      begin
        listbox1.ItemIndex:=RN;
        selected:=True;
      end;
    until (selected) or (RN>=IC-1);
  end;

  //FixConf(ListBox1.Items[ListBox1.ItemIndex],ListBox2);

  if CBFastPrev.Checked then
    LookMenu.ShowAndLoad(Self,(Sender as TListBox));

  if (CBLoadAttr.Checked) then
    AttrMenu.ShowAndRead(self,ListBox1);


  if listBox1.SelCount>1 then
    PTotalList.Caption:=
      LangWL.Items[33]+' '+IntToStr(listbox1.Count)+'|'+IntToStr(listBox1.SelCount)
  else
    PTotalList.Caption:=LangWL.Items[33]+' '+IntToStr(listbox1.Count);
end;

procedure TMainForm.ListBox1DblClick(Sender: TObject);
begin
  if (ListBox1.Items.Count<>0) and (ListBox1.ItemIndex<>-1) and (Dbt.ImageIndex=1) then
  begin
    OpenShow1Click(Sender);
  end;
end;

procedure TMainForm.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
const W = 16;
      H = 16;
var
  Bitmap : TBitmap;
  BMPRect: TRect;
  St_T,St_T2:string;
begin
  with (Control as TListBox).Canvas do
  begin
    FillRect(Rect);

    //Font.Color := RGB(0,128,128);
    Font.Size := 8;
    Brush.Style := bsClear;
    //Brush.Color := clWhite;             // RGB(150,150,150);
    SetBkMode(ListBox1.canvas.Handle, TRANSPARENT);

    if false then    //<<< false
    begin
      Bitmap := TBitmap.Create;
      Bitmap.LoadFromResourceName(HInstance, 'BM_Ex');
      if Bitmap <> NIL then
      begin
        BMPRect := Bounds(Rect.Left+1, Rect.Top+1,
                         (Rect.Bottom-Rect.Top-2), Rect.Bottom-Rect.Top-2);

        BrushCopy(BMPRect,Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height),
              Bitmap.Canvas.Pixels[0, 0]);
      end;
      //TextOut(Rect.Left+W+3, Rect.Top, IntToStr(Index) + '. ' + extractfilename(Listbox1.Items[index]));
      Bitmap.Free;
    end;
    //(control as TListBox).canvas.   // ForTests
    St_T:=ExtractFileName(Listbox1.Items[index]);
    //Font.Size := 8;
    TextOut(Rect.Left+3, Rect.Top, St_T);     //W
  end;
end;

procedure TMainForm.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ListBox1.ItemIndex=-1) then exit;
  if Key=VK_DELETE then
  begin
    if (Shift = [ssShift]) then
      DeletFile1Click(Copy1)
    else
      DeletFile1Click(DeletFile1);
    exit;
  end;
  if (Key=VK_F2) then
  begin
    if (Shift = [ssShift]) then
      Renameto1Click(Renameto1)
    else
      exit;
    exit;
  end;
  if (Key=vk_Return) then
  begin
    if (Shift = [ssShift]) then
      ppedit2Click(ppedit2)
    else
      openShow1Click(openShow1);
    exit;
  end;
  if (Key=$43)  then
    begin
      IF (Shift = [ssShift]) then Copy1Click(Copy1);
      IF (Shift = [ssCtrl]) then File1Click(File1);
      IF (Shift = [ssShift,ssCtrl]) then Path1Click(Path1);
      exit;
    end;
end;

procedure TMainForm.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _kuDragCan := False;
  if (Button =  mbLeft) then
  begin
    _kuDragCan := True;
    _kuDragPoint1.X := X;
    _kuDragPoint1.Y := Y;
  end;
end;

procedure TMainForm.ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  i: Integer;
  FileList: TStrings;
begin
  FileList := TStringList.Create;
  FileList.Capacity := ListBox1.SelCount;

  for i := 0 to ListBox1.Items.Count - 1
  do if ListBox1.Selected[i] then FileList.Add(ExtractfileName(ListBox1.Items[i]));

  kuDragDo(Self, SD_path, FileList, Shift, X, Y);

  FileList.Free;
end;

procedure TMainForm.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbRight) and (Dbt.ImageIndex=ImageL.Ex) then
    begin
      PopOnList(x,y,PPForFiles,ListBox1);
    end;
 { if PictureList1.Thumbnails.Count<1 then Exit;

  PictureList1.Selected[PictureList1.ItemIndex]:=False;
  PictureList1.ItemIndex:=ListBox1.ItemIndex;
  PictureList1.Selected[PictureList1.ItemIndex]:=True;    }
end;

procedure TMainForm.TrayIcon1Click(Sender: TObject);
begin
  TrayIcon1.Visible:=false;
  MainForm.Show;
end;

procedure TMainForm.MUpDoClick(Sender: TObject; Button: TUDBtnType);

 Function GetCount(tI:Integer;var TempPP:TpopUpMenu):Integer;
 begin
   if (button <> btNext) then
   begin
     if tI+1=TempPP.Items.Count then tI:=0 else tI:=tI+1
   end
   else
   begin
     if tI=0 then tI:=TempPP.Items.Count-1 else tI:=tI-1;
   end;
   Result:=tI;
 end;

var
  Ni,Ts2:Integer;
  Ts,SendL,PartOne:String;
  TempPP:TpopUpMenu;

begin
  SendL:=Copy((Sender as TUpDown).Name,0,1);   //can be:M,D,Y
  TempPP:=(FindComponent(SendL+'PP') as TpopUpMenu);
  PartOne:=(FindComponent(SendL+'bt') as TButton).Caption;

  Sel_la.Caption:=FormatDateTime('ddddd', DTP1.Date)+' '+FormatDateTime('dddd', DTP1.Date);

  case SendL[1] of
    'D': Begin
      DDMCL(TempPP.Items[GetCount(StrToInt(PartOne)-1,TempPP)]);
      exit;
    End;
    'M': Begin
      FormMonList;
      MMMCL(TempPP.Items[GetCount(StrToInt(PartOne)-1,TempPP)]);
      exit;
    End;
    'Y': Begin
      Ni:=TempPP.Items.IndexOf(TempPP.Items.Find(PartOne+Ts));//+PartTwo));
      YYMCL(TempPP.Items[GetCount(Ni,TempPP)]);
      exit;
    end;
  end;

  if TempPP.Items.Find(PartOne)=nil then
  begin
    SetStatus1('No item Found | '+PartOne+Ts+' |');
    exit;
  end;


end;

procedure TMainForm.MbtClick(Sender: TObject);
begin
  if DirectoryExists(SY_Path) then
  begin
    ShellExecute(handle,'open',PwideChar(SM_Path),nil,nil,SW_SHOWNormal);
    //Application.Minimize;
    end
  else
    SetStatus1(LangWL.Items[1]+' ;) ',1000);
end;

procedure TMainForm.Minimize1Click(Sender: TObject);
begin
  application.Minimize;
end;

procedure TMainForm.OpenNowClick(Sender: TObject);
begin
  FormToday;
  if OpenNow.Hint=LangWL.Items[3] then
  begin
    if ForceDirectories(Day_Path)
    then begin
      OpenNow.Hint:=LangWL.Items[2];
      Pcheck;
    end else
      SetStatus1(LangWL.Items[18],3500);
  end else begin
    ShellExecute(handle,'open',PwideChar(Day_Path),nil,nil,SW_SHOWNormal);
    //If minimizeAfter then Application.Minimize;
  end;
end;

procedure TMainForm.OpenPhotClick(Sender: TObject);
var
  Ca:Char;
  finded:Boolean;
begin
  if Not DirectoryExists(CA_But.Hint)
  then begin
    ConfForm.ConfLog.Lines.Add(LangWL.Items[15]);
    SetStatus1(LangWL.Items[16],3500);
    exit;
  end;

  ConfForm.ConfLog.Lines.Add(LangWL.Items[12]+' '+CA_But.Hint);
  ShellExecute(Handle,'open',Pwidechar(CA_But.Hint),nil,nil,SW_SHOWNormal);
  SetStatus1(LangWL.Items[13]+' '+CA_But.Hint,3500);
  exit;

  Timer1.Enabled:=False;
  finded:=False;
  if OpenPhot.ImageIndex=ImageL.Ex then
  begin
  OpenPhot.Hint:='';
    for Ca:= 'C' to 'Z' do begin
      if (GetDriveType(PChar(Ca+':\'))) = DRIVE_REMOVABLE then
      begin
        OpenPhot.Hint:=Ca;
        if DirectoryExists(Ca+':\DCIM')
        then begin
          ConfForm.ConfLog.Lines.Add(LangWL.Items[12]+' '+Ca+':\DCIM');

          if DirectoryExists(Ca+':\DCIM\100DSCIM')
          then begin
            ConfForm.ConfLog.Lines.Add(LangWL.Items[12]+' '+Ca+':\DCIM\100DSCIM');
            ShellExecute(Handle,'open',Pwidechar(Ca+':\DCIM\100DSCIM\'),nil,nil,SW_SHOWNormal);
            SetStatus1(LangWL.Items[13]+' '+Ca+':\DCIM\100DSCIM',3500);
            finded:=True;
          end;
          if DirectoryExists(Ca+':\DCIM\101MSDCF')
          then begin
            ConfForm.ConfLog.Lines.Add(LangWL.Items[12]+' '+Ca+':\DCIM\101MSDCF');
            ShellExecute(Handle,'open',Pwidechar(Ca+':\DCIM\101MSDCF\'),nil,nil,SW_SHOWNormal);
            SetStatus1(LangWL.Items[13]+' '+Ca+':\DCIM\101MSDCF',3500);
            finded:=True;
          end;

          if not finded
          then begin
            ConfForm.ConfLog.Lines.Add(LangWL.Items[14]+' '+Ca+':\DCIM\');
            ConfForm.ConfLog.Lines.Add(LangWL.Items[13]+' '+Ca+':\DCIM');
            ShellExecute(Handle,'open',Pwidechar(Ca+':\DCIM\'),nil,nil,SW_SHOWNormal);
            SetStatus1(LangWL.Items[13]+' '+Ca+':\DCIM',3500);
          end else
            break;
        end;
      end;
    end;
  if OpenPhot.Hint='' then ConfForm.ConfLog.Lines.Add(LangWL.Items[15]);
  end else begin
    SetStatus1(LangWL.Items[16],3500);
    OpenPhot.ImageIndex:=ImageL.NEx;
  end;
  Timer1.Enabled:=True;
end;

procedure TMainForm.OpenProgFolder1Click(Sender: TObject);
begin
  ShellExecute(handle,'open',PwideChar('Explorer'),PwideChar('/select,"'+ParamStr(0)+'"'),nil,SW_SHOWNORMAL);
end;

procedure TMainForm.OpenSelClick(Sender: TObject);
begin
  IF not DirectoryExists(SD_Path)
  then begin
    if ForceDirectories(SD_Path)
    then begin
      SetStatus1(LangWL.Items[17],3500);
      PCheck;
    end else
      SetStatus1(LangWL.Items[18],3500);
  end else begin
    ShellExecute(handle,'open',PwideChar(SD_Path),nil,nil,SW_SHOWNormal);
    //If minimizeAfter then Application.Minimize;
  end;
end;

procedure TMainForm.OpenShow1Click(Sender: TObject);
begin
  if ShellExecute(Handle,'open',PwideChar(ListBox1.Items[ListBox1.ItemIndex]),
       nil,nil,SW_ShowNormal)=42 then
    SetStatus1(LangWL.Items[13]+': "'+ExtractFileName(ListBox1.Items[ListBox1.ItemIndex])+'"',3000);
end;

procedure TMainForm.Options1Click(Sender: TObject);
begin
  ConfForm.Show;
end;

procedure TMainForm.PCheck;
begin
  Ybt.ImageIndex:=ImageL.NEx;
  Mbt.ImageIndex:=ImageL.NEx;
  Dbt.ImageIndex:=ImageL.NEx;
  DBt.Hint:='';
  MBt.Hint:='';
  YBt.Hint:='';
  OpenSel.Enabled:=
        ((sel_Day<>FormatDateTime('dd',Date))
      or (sel_Mon<>FormatDateTime('mm',Date))
      or (sel_Yea<>FormatDateTime('yyyy',Date)));

  SY_Path:=Wdir+Sel_Yea+'\';
  SM_Path:=SY_Path+Sel_Mon+'\';
  SD_Path:=SM_Path+Sel_Day+'.'+Sel_Mon+'.'+Copy(Sel_Yea,3,2)+'\';

  isExSel;

  if DirectoryExists(SY_Path) then begin
    Ybt.ImageIndex:=ImageL.Ex;
    if DirectoryExists(SM_Path) then begin
      Mbt.ImageIndex:=ImageL.Ex;
      if DirectoryExists(SD_Path) then begin
        Dbt.ImageIndex:=ImageL.Ex;
      end;
    end;
  end;
end;

procedure TMainForm.PictureList1Click(Sender: TObject);
begin
  {ListBox1.Selected[ListBox1.ItemIndex]:=False;
  ListBox1.ItemIndex:=PictureList1.ItemIndex;
  ListBox1.Selected[ListBox1.ItemIndex]:=True;
  ListBox1Click(ListBox1);        }
end;

procedure TMainForm.PopupListWndProc(var AMsg: TMessage);
var
  Msg: TWMMenuSelect;
  menuItem: TMenuItem;
begin
  AMsg.Result := CallWindowProc(fOldWndProc, Menus.PopupList.Window,
    AMsg.Msg, AMsg.WParam, AMsg.LParam);
  if AMsg.Msg = WM_MENUSELECT then begin
    menuItem := nil;
    Msg := TWMMenuSelect(AMsg);
    if (Msg.MenuFlag <> $FFFF) or (Msg.IDItem <> 0) then
      menuItem := dpp.FindItem(Msg.IDItem, fkCommand);
    miHint.DoActivateHint(menuItem);
  end;
end;

procedure TMainForm.PPEdit2Click(Sender: TObject);
begin
  if not FileExists(PPEdit2.Hint) then
    SetChangeEditorProgramm1Click(SetChangeEditorProgramm1)
  else begin
    ShellExecute(Handle,'open',PwideChar(PPEdit2.Hint),
      PWideChar('"'+ListBox1.Items[ListBox1.ItemIndex]+'"'),nil,SW_ShowNormal);
    setStatus1(LangWL.Items[19]+' "'+ExtractFileName(PPEdit2.Hint)+'"',3000);
  end;
end;

procedure TMainForm.PPForFilesPopup(Sender: TObject);
begin
  if Sender.ClassName='TImage' then begin
    ListBox1.ItemIndex:=(Sender as Timage).Tag;
  end;
  PPFileName1.Caption:='"'+ExtractFileName(ListBox1.items[ListBox1.ItemIndex])+'"';
end;

procedure TMainForm.RefrButClick(Sender: TObject);
begin
  ScanForFiles;
  CBLoadPrevClick(CBLoadPrev);
end;

procedure TMainForm.Renameto1Click(Sender: TObject);
var
  FileName:String;
  TempString:TStringList;
  attrN,attrT,CFName,FIndex:String;

begin
  FileName:=ListBox1.Items[ListBox1.ItemIndex];

  TempString:=TStringList.Create;
  TempString.Clear;
  TempString:=ReadConf(FileName,0);

  if TempString.Count<>0 then begin
    FIndex:=TempString[0];
    attrN:=TempString[1];
    attrT:=TempString[2];
    if attrN='' then attrN:=LangWL.Items[27];
    if attrT='' then attrT:=LangWL.Items[28];

    CFName:=ExtractDir(FileName,1)+'_'+attrN+'_'+attrT+ExtractFileEXT(FileName);
      //SetStatus1(CFName);
      //exit;
    if (FileName<>CFName) then begin
    // Rename Funcrion
      if RenameFile(FileName,ExtractFilePath(FileName)+CfNAme) then begin
        SetStatus1(LangWL.Items[29]+' "'+ExtractFileName(CfNAme)+'"',3000);
        ReAssignName(FIndex,ExtractFilePath(FileName)+CFName);
        ListBox1.Items[ListBox1.ItemIndex]:=
          ExtractFilePath(ListBox1.Items[ListBox1.ItemIndex])+'\'+CFName;
        if CbLoadAttr.Checked then begin
          AttrMenu.Caption:=LangWL.Items[20]+' "'+CFName+'"';
          AttrMenu.Hint:=ExtractFilePath(FileName)+CfNAme;
          AttrMenu.LFileName.Caption:='"'+CFName+'"';
        end;
      end else
        SetStatus1(LangWL.Items[30],3000);
    end
    else begin
      SetStatus1(LangWL.Items[31],3000);
    end;
  end;
  TempString.Free;

end;

procedure TMainForm.SavePosition1Click(Sender: TObject);
begin
  MainConfF.WriteInteger('MainMenu','Left',LookMenu.Left);
  MainConfF.WriteInteger('MainMenu','Top',LookMenu.Top);
end;

Function TMainForm.ScanForFiles(DirIt:string; Camera:Boolean):Integer;
var
  SR: TSearchRec;
  FindRes,I: Integer;
  SearchDir:String;
  FileEXT:String;

  JustDay,
  JustMonth,
  JustYear:String;
begin
  if DirIt<>'nul' then begin
    SearchDir:=dirIt;
  end else begin
    JustDay:= FormatDateTime('dd',DTP2.Date);
    JustMonth:= FormatDateTime('mm',DTP2.Date);
    JustYear:= FormatDateTime('yyyy',DTP2.Date);

    SF_Y_Path:=Wdir+JustYear+'\';
    SF_M_Path:=SF_Y_Path+JustMonth+'\';
    SF_D_Path:=SF_M_Path+JustDay+'.'+JustMonth+'.'+Copy(JustYear,3,2)+'\';

    SearchDir:=SF_D_Path;
  end;
  Result:=0;

  if (Not DirectoryExists(SearchDir)) then begin
    if DirIt<>'nul' then begin
      Exit(-1);
    end;
    ListBox1.Clear;
    ListBox1.Items.Add(LangWL.Items[32]+' "'+JustDay+'.'+JustMonth+'.'+Copy(JustYear,3,2)+'" '+LangWL.Items[1]);
    PTotalList.Caption:=LangWL.Items[33]+' '+LangWL.Items[34];
    Exit;
  end;

  if (DirIt='nul') or Camera then
    ListBox1.Clear;

  FindRes := FindFirst(SearchDir+'*.*', faNormal, SR);
  while FindRes = 0 do begin
    if (((SR.Attr and faDirectory) = faDirectory)
    and ((SR.Name = '.') or (SR.Name = '..'))) then
      FindRes := FindNext(SR);

    FileEXT:=AnCa(ExtractFileEXT(SR.Name));
    If MatchStr(FileEXT,AllSuEXT) then begin
      Result:=Result+1;
      if DirIt='nul' then
        ListBox1.Items.Add(SearchDir+SR.Name)
      else
        if Camera then
          ListBox1.Items.Add(SearchDir+SR.Name);
    end;
    FindRes := FindNext(SR);
  end;
  FindClose(SR);
  if DirIt<>'nul' then begin
    if Camera then
      exit
    else
      exit(result);
  end;
  PTotalList.Caption:=LangWL.Items[33]+' '+IntToStr(Result);
  PTotalList.Tag:=Result;
end;

procedure TMainForm.ScrollBox1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBox1.ScrollBy(0,ScrollBox1.VertScrollBar.Position+WheelDelta);
  if handled then ScrollBox1.Update; //это чтобы форсировать отрисовку
end;

procedure TMainForm.SetChangeEditorProgramm1Click(Sender: TObject);
begin
  SelectProg.Show;
end;

procedure TMainForm.SetStatus1(Text: String; StayTime: Integer = 2500; CCheck:Boolean = False);
begin
  Timer2.Enabled:=False;
  if CCheck and (Clipboard.AsText=Text) then
    Text:='"'+Clipboard.AsText+'" '+LangWL.Items[20];
  StatusBar1.Panels[0].Text:=Text;
  ConfForm.ConFLog.Lines.Add(Text);
  //MemoFix(ConfForm.ConFLog);
   StatusBar1.Repaint;
  //Sleep(StayTime); // if modular
  Timer2.Interval:=StayTime;
  Timer2.Enabled:=True;
end;

procedure TMainForm.ShowChLoClick(Sender: TObject);
begin
  if ShellExecute(Handle,'open',PwideChar('ChangeLOG.txt'),
       nil,nil,SW_ShowNormal)=42 then
    SetStatus1(LangWL.Items[13]+': "ChangeLOG.txt"',2000);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);

  function DirOfDirCount(TwDir:String):String;
  var
    SR: TSearchRec;
    FindRes,I,Lm,Co: Integer;
  begin
    if (Not DirectoryExists(TwDir)) then
      Exit('');
    Result:='';
    Lm:=-1;

    FindRes := FindFirst(TwDir+'*', faDirectory, SR);
    while FindRes = 0 do
    begin
      if (((SR.Attr and faDirectory) = faDirectory) and ((SR.Name = '.') or (SR.Name = '..')))
        then FindRes := FindNext(SR)
      else
      begin
        //SetStatus1(TwDir+SR.Name+'\ : '+IntToStr(ScanForFiles(TwDir+SR.Name+'\'))); //########
        Co:=ScanForFiles(TwDir+SR.Name+'\');
        ScanForFiles;
        if Co>0 then
        begin
          if Co>Lm then
          begin
            Lm:=Co;
            Result:=TwDir+SR.Name+'\';
          end
          else
            if (Result='') and (Co=0) then
              Result:=TwDir+SR.Name+'\';
        end;
        FindRes := FindNext(SR);
      end;
    end;
    FindClose(SR);
    if Result='' then
      Result:=TwDir;
  end;

var
  Ca:Char;
begin
  if DirectoryExists(CA_But.Hint) then exit;
  CA_But.Hint:='';
  OpenPhot.Hint:='';
    for Ca:= 'C' to 'Z' do begin
      if (GetDriveType(PChar(Ca+':\'))) = DRIVE_REMOVABLE then begin
        if DirectoryExists(Ca+':\DCIM') then begin
          if OpenPhot.ImageIndex=ImageL.NEx then
            SetStatus1(LangWL.Items[4],3000);
          OpenPhot.ImageIndex:=ImageL.Ex;
          OpenPhot.Caption:=LangWL.Items[2]+' '+Ca+':';
          OpenPhot.Hint:=Ca;
          CA_But.Hint:=DirOfDirCount(Ca+':\DCIM\');
          Break;
        end;
      end;
    end;
  if OpenPhot.Hint='' then begin
    if OpenPhot.ImageIndex<>ImageL.NEx then
    begin
      SetStatus1(LangWL.Items[5],3000);
      OpenPhot.Caption:=LangWL.Items[2];
    end;
    OpenPhot.ImageIndex:=ImageL.NEx;
  end;
  CCMO_A1Click(Self);

  if (CA_But.ImageIndex=1) and (CCMO_AE.Checked) then
    CA_But.Click;

 {0 - Тип накопителя не определен.
  1 - Корневой директорий не существует.
  DRIVE_REMOVABLE - Накопитель может удаляться с накопителя.
  DRIVE_FIXED - Фиксированный диск(не может быть удален).
  DRIVE_REMOTE - Удаленный накопитель(сетевой диск).
  DRIVE_CDROM - CD-ROM.
  DRIVE_RAMDISK - Накопитель является виртуальным RAM-диском.}
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled:=False;
  StatusBar1.Panels[0].Text:='Hello! ;)';
end;

procedure TMainForm.FindClick(Sender: TObject);
var
  FName_,FName2_:String;
  _i:Integer;
begin
  ScanForFiles;

  if (Trim(Edit1.Text)='')
  or (2>ListBox1.Count) then exit;

  for _i := ListBox1.Count-1 downto 0 do
  begin
    FName_:=ListBox1.Items[_i];
    FName2_:= ReadOneConf(FName_,4);

    If (Not TagM(FName2_,Edit1.Text)) then
      ListBox1.Items.Delete(_i);
  end;

  if ListBox1.Count=0 then
    ListBox1.Items.add(LangWL.Items[36]);

  if CBLoadPrev.Checked then
  begin
    DrawImages;
    ListBox1Click(Self);
  end;
end;

end.

