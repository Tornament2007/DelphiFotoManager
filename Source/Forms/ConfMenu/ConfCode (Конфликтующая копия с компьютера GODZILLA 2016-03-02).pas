unit ConfCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, iniFiles,ShellAPI, ExtCtrls, pngimage,
  DropFileClass, Vcl.ComCtrls, Vcl.Samples.Spin;

type
  TConfForm = class(TForm)
    CBSeditAtr: TCheckBox;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CM_LangWL: TListBox;
    GroupBox2: TGroupBox;
    E_WDir: TEdit;
    OpenWdir: TButton;
    SaveWdir: TButton;
    resetpath: TButton;
    GroupBox3: TGroupBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    RefreshList: TPanel;
    Image1: TImage;
    Panel1: TPanel;
    Label2: TLabel;
    LIA: TPanel;
    Explore_BT: TButton;
    GroupBox4: TGroupBox;
    TrackBar1: TTrackBar;
    L_TN_S: TLabel;
    L_TN_AS: TLabel;
    InstPain: TCheckBox;
    ShowFotoCount: TCheckBox;
    GroupBox5: TGroupBox;
    SEStartFromY: TSpinEdit;
    StartFromY: TLabel;
    ConfLog: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure E_WDirChange(Sender: TObject);
    procedure OpenWdirClick(Sender: TObject);
    procedure SaveWdirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure resetpathClick(Sender: TObject);
    procedure CBSeditAtrClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure E_WDirKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LIAClick(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure E_WDirKeyPress(Sender: TObject; var Key: Char);
    procedure Explore_BTClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure InstPainClick(Sender: TObject);
    procedure ShowFotoCountClick(Sender: TObject);
    procedure SEStartFromYChange(Sender: TObject);
    procedure ConfLogChange(Sender: TObject);

  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
    procedure FromDropFiles(Sender: TObject);
  public
    { Public declarations }
    procedure DoAllConfigsStuff;
    Procedure DoIfExist;
    procedure IWillSetit;
  end;

var
  ConfForm: TConfForm;
  DropLangPan:TDropFile;

implementation

uses MainCode,ProgSelectCode,LookMenuCode,AttrMenuCode, LanguageOperator, FsP,
     TagSearchCode;

{$R *.dfm}


procedure TConfForm.OpenWdirClick(Sender: TObject);
begin
  if directoryExists(E_Wdir.Text) then
    ShellExecute(handle,'open',PwideChar(E_Wdir.Text),nil,nil,SW_Normal);
end;

procedure TConfForm.LIAClick(Sender: TObject);
begin
  if sender.ClassName='TPanel' then
    LIA.Tag:=Ord(LIA.Tag=0);
  MainConfF.ReadBool('ConfForm','LangInstallAction',LIA.Tag=1);
  LIA.Caption:=Copy(MainForm.LangWL.Items[40],LIA.Tag+1,1);
  LIA.Hint:=MainForm.LangWL.Items[38+LIA.Tag];
end;

procedure TConfForm.resetpathClick(Sender: TObject);
begin
  E_Wdir.Text:=WDir;
  E_WdirChange(E_Wdir);
end;

procedure TConfForm.SaveWdirClick(Sender: TObject);
begin
  if (AnCa(E_Wdir.Text)=AnCa(WDir)) then exit;

  if Copy(E_Wdir.Text,Length(E_Wdir.Text),1)<>'\' then
    E_Wdir.Text:=E_Wdir.Text+'\';

  MainConfF.WriteString('Main','WorkingDirectory',E_Wdir.Text);
  WDir:=E_WDir.Text;

  if Not DirectoryExists(WDir) then exit;

  DoIfExist;
  exit;

  MainForm.FormToday;

  MainForm.FormYeaList;
  MainForm.FormMonList;
  MainForm.FormDayList;
end;

procedure TConfForm.SEStartFromYChange(Sender: TObject);
begin
  MainConfF.WriteInteger('FileGridOptions','StartFromY',SEStartFromY.Value);
end;

procedure TConfForm.ShowFotoCountClick(Sender: TObject);
begin
  if ShowFotoCount.Tag=1 then exit;
  MainConfF.WriteBool('FileGridOptions','ShowFotoCount',ShowFotoCount.Checked);
  MainForm.FormDayList;
end;

procedure TConfForm.TrackBar1Change(Sender: TObject);
begin
  L_TN_AS.Caption:=': '+IntToStr(TrackBar1.Position)+'('+
    IntTOstr(Trunc((MainForm.ScrollBox1.Width-20) / (TrackBar1.Position+7.5)))+')';
    if MainForm.CBLoadPrev.Checked then
    MainForm.DrawImages(True);
end;

procedure TConfForm.Button1Click(Sender: TObject);
begin
  MainConfF.WriteInteger('MainForm','Left',MainForm.Left);
  MainConfF.WriteInteger('MainForm','Top',MainForm.Top);
end;

procedure TConfForm.Button2Click(Sender: TObject);
begin
  MainConfF.WriteInteger('ConfForm','Left',ConfForm.Left);
  MainConfF.WriteInteger('ConfForm','Top',ConfForm.Top);
end;

procedure TConfForm.Button3Click(Sender: TObject);
begin
  MainConfF.WriteInteger('AttrMenu','Left',AttrMenu.Left);
  MainConfF.WriteInteger('AttrMenu','Top',AttrMenu.Top);
end;

procedure TConfForm.Explore_BTClick(Sender: TObject);
var
  SDir: string;
begin
  SDir:=BrowseFolder(PWideChar(CM_LangWL.Items[8]
          +#13+CM_LangWL.Items[9]+': "'+E_Wdir.Text+'"'),Handle);
  if DirectoryExists(SDir) and (SDir<>'') then
    E_Wdir.Text:=SDir;
end;

procedure TConfForm.CBSeditAtrClick(Sender: TObject);
begin
  MainConfF.WriteBool('FileGridOptions','ShowAtributesEdit',CBSeditAtr.Checked);
  MainForm.EditGroup1.Visible:=CBSeditAtr.Checked;

  MainForm.N4.Visible:=CBSeditAtr.Checked;
end;

procedure TConfForm.ComboBox1Change(Sender: TObject);
var
  TempReader:TiniFile;
  Str1:String;
begin
  if (ComboBox1.itemIndex<>0)
  and (not FIleExists(Data+'Lang\lang_'+ComboBox1.Text+'.'+LangFEXT)) then
  begin
    Image1DblClick(Image1);
    Exit;
  end;
  if ComboBox1.itemIndex=0 then
  begin
    if language<>'def' then
    begin
      MainConfF.WriteString('Main','Language','def');
      ShowMessage('The language will be changed on the next start!');
      language:='def';
    end;
  end
  else
  begin
    if language<>Copy(ComboBox1.Text,1,2) then
    begin
      MainConfF.WriteString('Main','Language',ComboBox1.Text);
        TempReader:=TiniFile.Create(Data+'Lang\lang_'+ComboBox1.Text+'.'+LangFEXT);
        Str1:=TempReader.ReadString('Info','Info1','NO INFO! ERROR!');
      TempReader.Free;
      ShowMessage(Str1);
      language:=Copy(ComboBox1.Text,1,2);
    end;
  end;

end;


procedure TConfForm.ConfLogChange(Sender: TObject);
begin
  ConfLog.ScrollBy(0,21);
  ConfLog.Repaint;
end;

procedure TConfForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := Application.Handle;
end;

procedure TConfForm.DoAllConfigsStuff;
begin
  MainConfF:=TiniFile.Create(Data+'Configs.Ini');

  if not FileExists(MainConfF.FileName) then
    begin
      MainConfF.WriteString ('Main','WorkingDirectory','');
      MainConfF.WriteString ('Main','Language','def');
      MainConfF.WriteBool   ('FileGridOptions','LinkDates',True);
      MainConfF.WriteBool   ('FileGridOptions','ShowAtributesEdit',True);
      MainConfF.WriteBool   ('FileGridOptions','FastPreView',True);
      MainConfF.WriteBool   ('FileGridOptions','ShowFotoCount',False);
      MainConfF.WriteInteger('FileGridOptions','StartFromY',2010);
      MainConfF.WriteBool   ('FileGridOptions','AutoCAE',False);
      MainConfF.WriteString ('EditorProg','Name','');
      MainConfF.WriteString ('EditorProg','PathTo','');
      MainConfF.WriteInteger('PreViewSets','Width',250);
      MainConfF.WriteInteger('PreViewSets','Height',240);
      MainConfF.WriteInteger('PreViewSets','Left',LookMenu.Left);
      MainConfF.WriteInteger('PreViewSets','Top',LookMenu.Top);
      MainConfF.WriteBool   ('PreViewConf','FastJPEG',True);
      MainConfF.WriteBool   ('FileGridOptions','LoadTags',True);
      MainConfF.WriteInteger('MainForm','Left',MainForm.Left);
      MainConfF.WriteInteger('MainForm','Top',MainForm.Top);
      MainConfF.WriteBool   ('ConfForm','LangInstallAction',False);
      MainConfF.WriteBool   ('ConfForm','PaintWhileLoad',False);
      MainConfF.WriteInteger('ConfForm','Left',ConfForm.Left);
      MainConfF.WriteInteger('ConfForm','Top',ConfForm.Top);
      MainConfF.WriteInteger('AttrMenu','Left',AttrMenu.Left);
      MainConfF.WriteInteger('AttrMenu','Top',AttrMenu.Top);
      MainConfF.WriteBool   ('AttrMenu','AutoSaveChanges',False);
      MainConfF.WriteBool   ('TagSearch','ViewOnSelect',True);
      MainConfF.WriteBool   ('TagSearch','ReadAttrOnSelect',True);
    end;



  E_WDir.Text:=MainConfF.ReadString('Main','WorkingDirectory','');
  E_WDirChange(E_WDir);

  LIA.Tag:=ORD(MainConfF.ReadBool('ConfForm','LangInstallAction',False));
    LIAClick(Self);
  if (AnCa(Language)<>'def') and (Length(Language)=2) then
    ComboBox1.Text:=Language;

  CBSeditAtr.Checked:=MainConfF.ReadBool('FileGridOptions','ShowAtributesEdit',True);
    CBSeditAtrClick(CBSeditAtr); //show or hide menus
  InstPain.Checked:= MainConfF.ReadBool('ConfForm','PaintWhileLoad',False);
  ShowFotoCount.Tag:=1;
  ShowFotoCount.Checked:=MainConfF.ReadBool('FileGridOptions','ShowFotoCount',False);
  ShowFotoCount.Tag:=0;
  SEStartFromY.Value:=MainConfF.ReadInteger('FileGridOptions','StartFromY',2010);
  SEStartFromY.MinValue:=2010;
  SEStartFromY.MaxValue:=StrToInt(FormatDateTime('yyyy',Date));
  //ComboBox1ContextPopup(ComboBox1,Mouse.CursorPos,true);


  MainForm.CBDateLink.Checked:=MainConfF.ReadBool('FileGridOptions','LinkDates',True);
  MainForm.CBFastPrev.Checked:=MainConfF.ReadBool('FileGridOptions','FastPreView',True);
  MainForm.CBLoadAttr.Checked:=MainConfF.ReadBool('FileGridOptions','LoadTags',True);
  MainForm.CameraAE  .Checked:=MainConfF.ReadBool('FileGridOptions','AutoCAE',False);
 // MainForm.CBLoadPrev.Checked:=MainConfF.ReadBool('FileGridOptions','FastPreView',True);

  AttrMenu.CBListChanges.Checked:=MainConfF.ReadBool('FileGridOptions','AutoSaveChanges',False);

  SelectProg.Edit1.Hint:=MainConfF.ReadString('EditorProg','PathTo','');
  SelectProg.Edit1.Text:=SelectProg.Edit1.Hint;
    SelectProg.Edit1Change(SelectProg.Edit1);
  SelectProg.Edit2.Hint:=MainConfF.ReadString('EditorProg','Name','');
  SelectProg.Edit2.Text:=SelectProg.Edit2.Hint;
    SelectProg.SaveA_btClick(SelectProg.Reset1);

  LookMenu.Height:=MainConfF.ReadInteger('PreViewSets','Height',240);
  LookMenu.Width:= MainConfF.ReadInteger('PreViewSets','Width',250);
  LookMenu.Left:=MainConfF.ReadInteger('PreViewSets','Left',25);
  LookMenu.Top:=MainConfF.ReadInteger('PreViewSets','Top',25);
  LookMenu.Tag:=1;
  LookMenu.FastJEPGLoading1.Checked:=MainConfF.ReadBool('PreViewConf','FastJPEG',True);

  AttrMenu.Left:=MainConfF.ReadInteger('AttrMenu','Left',AttrMenu.Left);
  AttrMenu.Top:= MainConfF.ReadInteger('AttrMenu','Top',AttrMenu.Top);

  TagSearch.View1_ChB.Checked:=MainConfF.ReadBool('TagSearch','ViewOnSelect',True);
  TagSearch.View2_ChB.Checked:=MainConfF.ReadBool('TagSearch','ReadAttrOnSelect',True);

  //  Self.Show;      //Last

  ConfForm.Left:=MainConfF.ReadInteger('ConfForm','Left',ConfForm.Left);
  ConfForm.Top:= MainConfF.ReadInteger('ConfForm','Top',ConfForm.Top);
  Self.Position:=poDesigned;
  //  Self.Hide;
end;

procedure TConfForm.DoIfExist;
begin
  MainForm.SetBtClick(self);

  MainForm.FormToday;

  MainForm.FormYeaList;
  MainForm.FormMonList;
  MainForm.FormDayList;
  MainForm.DTP1Change(MainForm.DTP1);
  MainForm.DTP2.Date:=MainForm.DTP1.Date;
  MainForm.ScanForFiles;
end;

procedure TConfForm.E_WDirChange(Sender: TObject);
begin
  ResetPath.Enabled:=(AnCa(E_Wdir.Text)<>AnCa(WDir)) and ((AnCa(E_Wdir.Text+'\')<>AnCa(WDir)));
  if directoryexists(E_Wdir.Text) then
    begin
      E_Wdir.Color:=ClWhite;
      OpenWdir.Enabled:=True;
      SaveWDir.Enabled:=ResetPath.Enabled;
    end
  else
    begin
      E_Wdir.Color:=ClRed;
      OpenWdir.Enabled:=False;
      SaveWDir.Enabled:=False;
    end;
  ///////
  MainForm.GroupBox1.Enabled:=OpenWdir.Enabled;
  MainForm.GroupBox2.Enabled:=OpenWdir.Enabled;
  MainForm.GroupBox3.Enabled:=OpenWdir.Enabled;
  MainForm.GridPanel.Enabled:=OpenWdir.Enabled;
  MainForm.DatInfAndSet.Enabled:=OpenWdir.Enabled;
end;

procedure TConfForm.E_WDirKeyPress(Sender: TObject; var Key: Char);
begin
  if Sender.ClassName='TEdit' then
    Key:=E_PathEdit(Sender as TEdit,Key);
end;

procedure TConfForm.E_WDirKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ord(Key)=(Vk_Return))
  or ((Shift = [ssCtrl]) and (Key=ord('S'))) then
  begin
    if SavewDir.Enabled then
      SavewDir.Click;
    exit;
  end;

  if ord(Key)=(Vk_ESCAPE) then
  begin
    if ResetPath.Enabled then
      ResetPath.Click;
    exit;
  end;
end;

procedure TConfForm.FormCreate(Sender: TObject);
begin
  Self.Width:=392;
  DropLangPan:=TDropFile.Create(Panel1);
  DropLangPan.OnDropFiles:=self.FromDropFiles;

  ReadLang(Self,Data+'Lang\','Lang',Language);
  Label1.Caption:='"..\Data\Lang\lang_xx.'+LangFEXT+'"';

  Image1DblClick(Image1);

  DoAllConfigsStuff; // DoAllConfigsStuff;  DoAllConfigsStuff;

  WDir:=E_WDir.Text;
  E_WdirChange(E_Wdir);

  if (Wdir='') then
  begin
    Self.Show;
    ShowMessage(CM_LangWL.Items[1]+#13+CM_LangWL.Items[2]);
    Explore_BT.Click;
  end;

  if DirectoryExists(E_WDIR.Text) then
    DoIfExist;

end;

procedure TConfForm.FormDestroy(Sender: TObject);
begin
  MainConfF.Destroy;
end;

procedure TConfForm.FromDropFiles(Sender: TObject);
Var
  Path,FName:String;
  I:Integer;
begin
  if DropLangPan.Files.Count>0 then
  begin
    i:=-1;
    repeat
      Inc(i);
      FName:=extractFileName(DropLangPan.Files[i]);
      if (AnCa(ExtractFilePath(Fname))=Data+'Lang\') then
      Begin
        MainForm.SetStatus1(FName+': '+CM_LangWL.Items[7],1500);
        next;
      end;
      if (AnCa(ExtractFileEXT(Fname))<>'.'+LangFEXT) then
      Begin
        MainForm.SetStatus1(FName+': '+CM_LangWL.Items[6],1500);
        next;
      end;
      if  (AnCa(Copy(Fname,1,5))='lang_')
      and (length(Fname)=5+2+1+Length(LangFEXT)) then
      Begin
        if CopyDir(DropLangPan.Files[i],Data+'Lang\'+Fname,LIA.Tag=1) then
        begin
          if fileExists(Data+'Lang\'+Fname) then
            MainForm.SetStatus1(CM_LangWL.Items[4]+' - '+Fname,2500)
          else
            MainForm.SetStatus1(FName+': NE '+CM_LangWL.Items[5],2500);
        end
        else
          MainForm.SetStatus1(FName+': NC '+CM_LangWL.Items[5],2500);
      End
      else
        MainForm.SetStatus1(FName+': BF '+CM_LangWL.Items[5],2500);
    until i+1>=DropLangPan.Files.Count;
  end;

end;

procedure TConfForm.Image1DblClick(Sender: TObject);
var
  SR: TSearchRec;
  FindRes: Integer;
begin
 ComboBox1.items.Clear;
  ComboBox1.items.add('EN ('+CM_LangWL.Items[3]+')');
  FindRes := FindFirst(Data+'Lang\lang_??.'+LangFEXT, faNormal, SR);
  while FindRes = 0 do
  begin
    ComboBox1.items.add(Copy(SR.Name,6,2));
    //ComboBox1.items.add(SR.Name+'!');
    FindRes := FindNext(SR);
  end;
  FindClose(SR);

  If language='def' then
    ComboBox1.itemindex:=0
  else
    ComboBox1.itemindex:=ComboBox1.Items.IndexOf(Language);
end;

procedure TConfForm.InstPainClick(Sender: TObject);
begin
  MainConfF.WriteBool('ConfForm','PaintWhileLoad',InstPain.Checked);
end;

procedure TConfForm.IWillSetit;
begin
//
end;

procedure TConfForm.Label1DblClick(Sender: TObject);
begin
  if ShellExecute(handle,'open',PwideChar(Data+'Lang\'),nil,nil,SW_Normal)=42 then
    MainForm.SetStatus1(MainForm.LangWL.Items[13]+': ".\Data\Lang\"',3000);
end;

end.
