unit TagSearchCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, FileAttronTini, StdCtrls, StrUtils, Vcl.ImgList, ShellApi,
  Vcl.ExtCtrls, Vcl.Menus, clipBrd, kuDrag, System.ImageList;

type
  TTagSearch = class(TForm)
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    PPFFI: TPopupMenu;
    Open1: TMenuItem;
    SetthatDate1: TMenuItem;
    Copy1: TMenuItem;
    Copy2: TMenuItem;
    TS_LangWL: TListBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    FindItE: TEdit;
    AddToSearchFild: TComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    ListBox1: TListBox;
    Find: TButton;
    View2_ChB: TCheckBox;
    View1_ChB: TCheckBox;
    TreeView1: TTreeView;
    BTN_Explore: TButton;
    TreeView2: TTreeView;
    ListBox2: TListBox;
    TreeView3: TTreeView;
    RichEdit1: TRichEdit;
    GroupSelector: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure FormShow(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeView1Collapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure FindClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FindItEKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FindItEChange(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Copy1Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure View1_ChBClick(Sender: TObject);
    procedure View2_ChBClick(Sender: TObject);
    procedure AddToSearchFildKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetthatDate1Click(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox2DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    Procedure ToggleTreeViewCheckBoxes(Node:TTreeNode);

    Procedure ScanFTF;
    Procedure ScanForTag;
    Function GetAttrFileList(ChTree:TTreeView):TStrings;

    Procedure SetAllDown(Index:Integer;Node:TTreeNode);
    Function OnTreeCheck(Sender: TObject):Boolean;
    Procedure UpdateStatus(Text:String;CCheck:Boolean = False);
  public
    { Public declarations }
    Procedure ScanFF(Dest:TTreeView; Dir_:String; Index:Integer = 0);

    procedure NextLevel(Sender:TObject; ParentNode: TTreeNode);
  end;

var
  TagSearch: TTagSearch;

implementation

uses LanguageOperator, MainCode, ConfCode, FsP, LookMenuCode, AttrMenuCode,
     FM_Spec;

{$R *.dfm}

procedure TTagSearch.AddToSearchFildKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);

  Procedure AdToField;
  var
    _Str,WhtC:String;
  begin
    _Str:=Trim(FindItE.Text);
    WhtC:=Trim(AddToSearchFild.Text);
    if WhtC='' then exit;

    if (_Str<>'') and (_Str[length(_Str)]<>',') then
      _Str:=_Str+',';
    FindItE.Text:=_Str+WhtC;
    AddToSearchFild.Text:='';
  end;

begin
  if ord(Key)=(Vk_ESCAPE) then
  begin
    if Shift = [ssShift] then
      FindItE.Text:='';
    AddToSearchFild.Text:='';
    exit;
  end;
  if ord(Key)=(Vk_Return) then
  begin
    if Shift = [ssCtrl] then
    begin
      AddToSearchFild.DroppedDown := False;
      Find.Click;
      exit;
    end;
    AdToField;
    exit;
  end;
end;

procedure TTagSearch.Copy1Click(Sender: TObject);
var
  St:String;
begin
  if (Sender as TMenuItem).tag=0 then
    St:=ListBox1.Items[ListBox1.ItemIndex]
  else
    St:=ExtractFilePath(ListBox1.Items[ListBox1.ItemIndex]);
  Clipboard.AsText:=St;
  if Clipboard.AsText=St then
    Updatestatus(St,True);
end;

procedure TTagSearch.FindItEChange(Sender: TObject);
begin
  Find.Enabled:=(Trim(FindItE.Text)<>'') and (TreeView1.Items[0].StateIndex>1);
end;

procedure TTagSearch.FindItEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=Vk_Escape) and (Shift = []) then
  begin
    FindItE.Clear;
    exit;
  end;
  if (Key=Vk_Return) and (Shift = []) then
  begin
    Find.Click;
    Exit;
  end;
end;

procedure TTagSearch.FormCreate(Sender: TObject);
begin
  ReadLang(Self,Data+'Lang\','Lang',Language);
  UpdateStatus(TS_LangWL.Items[5]);
  tagSearch.Width:=457;

  PageControl1.ActivePage:=TabSheet1;
end;

procedure TTagSearch.FormShow(Sender: TObject);
begin
  ScanFF(TreeView1,WDIR);
  ScanFF(TreeView2,WDIR);
  ScanFF(TreeView3,WDIR);
end;

function TTagSearch.GetAttrFileList(ChTree: TTreeView): TStrings;
var
  I,LCount:integer;
  node,TN: TTreeNode;
  path: string;

  TempL,TempL2:Tstrings;
begin
  TempL:=TStringList.Create;
  UpdateStatus(TS_LangWL.Items[0]+'...');
  // Формируем список папок для поиска
  for I := 0 to ChTree.items.Count-1 do
  begin
    TN := ChTree.Items.Item[I];
    if TN.StateIndex > 1  then
    begin
      path := '';
      Node:=TN;
      repeat
        path := node.Text + '\' + path;
        node := node.Parent;
      until node = nil;
      TempL.Add(path);
    end;
  end;

  if TempL.Count=0 then exit;  // аль пусто, exit;

  I:=0;
  if TempL.Count>1 then
  repeat
    inc(I);
    if ContainsText(TempL[I],TempL[I-1]) then //фильтруем повторные.
    begin
      TempL.Delete(I-1);
      dec(I);
    end;
  until I>=TempL.Count-1;

  UpdateStatus(TS_LangWL.Items[1]+'...');
  // Начинаем искать файлы атрибутов

  TempL2:=TStringList.Create;
  I:=0;
  LCount:=TempL.Count;
  repeat
    RecurseSearch(ChTree.Hint+TempL[I],'ImagesAttributes.INI',TempL2);
    inc(I);
  until LCount=I;
  TempL.Free;
  Result := TempL2;
end;

procedure TTagSearch.ListBox1Click(Sender: TObject);
begin
  if (ListBox1.Items.Count=0)
  or (ListBox1.ItemIndex=-1)
  then exit;

  UpdateStatus(ListBox1.Items[ListBox1.ItemIndex]);

  if View1_ChB.Checked then
    LookMenu.ShowAndLoad(Self,(Sender as TListBox));

  if View2_ChB.Checked then
    AttrMenu.ShowAndRead(self,ListBox1);
end;

procedure TTagSearch.ListBox1DblClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PwideChar(ListBox1.Hint+ListBox1.Items[ListBox1.ItemIndex]),nil,nil,SW_ShowNormal);
end;

procedure TTagSearch.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
const W = 16;
      H = 16;
var
  Bitmap : TBitmap;
  BMPRect: TRect;
  St_T:string;
begin
  with (Control as TListBox).Canvas do
  begin
    FillRect(Rect);

    //Font.Color := RGB(0,128,128);
    Font.Size := 8;
    Brush.Style := bsClear;
    //Brush.Color := clWhite;             // RGB(150,150,150);
    SetBkMode(ListBox1.canvas.Handle, TRANSPARENT);

    if false then
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
    //(control as TListBox).canvas.

    //Font.Size := 9;

    St_T:=GCName(ExtractDir(ExtractFilePath(Listbox1.Items[index])));
    Font.Size := 8;
    TextOut(Rect.Left+3, Rect.Top, St_T+' | '+ExtractFileOName(Listbox1.Items[index]));     //W
  end;
end;

procedure TTagSearch.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
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

procedure TTagSearch.ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  i: Integer;
  FileList: TStrings;
begin  
  if (ListBox1.SelCount=0) or (not _kuDragCan) or (ListBox1.Items.Count < 1) then exit;
  
  FileList := TStringList.Create;
  FileList.Capacity := 1;
  if (ListBox1.SelCount<>0) then
  for i := 0 to ListBox1.Items.Count - 1
  do if ListBox1.Selected[i] then begin
    FileList.Add(ExtractfileName(ListBox1.Items[i]));
    kuDragDo(Self, ExtractfileDir(ListBox1.Items[i]), FileList, Shift, X, Y);
    break;
  end;

  FileList.Free;
end;

procedure TTagSearch.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbRight) and (ListBox1.Items.Count>0) then
    begin
      PopOnList (x,y,PPFFI,ListBox1);
    end;
end;

procedure TTagSearch.ListBox2Click(Sender: TObject);
begin
  RichEdit1.Lines.Clear;
  if ListBox2.ItemIndex<>-1 then
    RichEdit1.Lines.Add(ListBox2.Items[ListBox2.ItemIndex]);
end;

procedure TTagSearch.ListBox2DrawItem(Control: TWinControl; Index: Integer;
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

    St_T:=Copy(Listbox2.Items[index],0,AnsiPos(':',Listbox2.Items[index])-1);
    case ListBox2.Tag of
      0:Begin St_T:= FormatDateTime('dd mmm yyyy',StrToDate(St_T));
        St_T[4]:=AnCa(St_T[4],True)[1]; End;
      1:Begin St_T:= FormatDateTime('mmm yyyy',StrToDate('01.'+St_T));
        St_T[1]:=AnCa(St_T[1],True)[1] End;
      2:St_T:= FormatDateTime('yyyy',StrToDate('01.01.'+St_T));
    end;
    St_T2:=Copy(Listbox2.Items[index],AnsiPos(':',Listbox2.Items[index])+2);
    St_T2:=Replace1to2(St_T2,',',' ');

    Font.Size := 8;
    TextOut(Rect.Left+3, Rect.Top, St_T+' | ');     //W
    Font.Color := RGB(100,200,0);
    TextOut(Rect.Left+5+Canvas.TextWidth(St_T+' | '), Rect.Top, St_T2);     //W
  end;
end;

procedure TTagSearch.NextLevel(Sender:TObject; ParentNode: TTreeNode);
  function DirectoryName(name: string): boolean;
  begin
    result := (name <> '.') and (name <> '..');
  end;
var
  sr, srChild: TSearchRec;
  node: TTreeNode;
  path: string;
begin
  node := ParentNode;
  path := '';
  repeat
    path := node.Text + '\' + path;
    node := node.Parent;
  until node = nil;

  path:=(Sender as TTreeview).Hint+path;
  if FindFirst(path + '*', faDirectory, sr) = 0 then begin
    repeat
      if (sr.Attr and faDirectory <> 0) and DirectoryName(sr.Name) then begin
        node := (Sender as TTreeview).Items.AddChild(ParentNode, sr.Name);    //self.Treeview1
        node.StateIndex:=Node.Parent.StateIndex;
        node.ImageIndex := 0;
        node.SelectedIndex := 1;
        node.HasChildren := false;
        if FindFirst(path + sr.Name + '\*.*', faDirectory, srChild) = 0 then begin
          repeat
            if (srChild.Attr and faDirectory <> 0) and DirectoryName(srChild.Name)
              then node.HasChildren := true;
          until (FindNext(srChild) <> 0) or node.HasChildren;
        end;
        FindClose(srChild);
      end;
    until FindNext(sr) <> 0;
  end else ParentNode.HasChildren := false;
  FindClose(sr);
end;

function TTagSearch.OnTreeCheck(Sender: TObject): Boolean;
var
  P:TPoint;
begin
  GetCursorPos(P);
  P := (Sender as TTreeView).ScreenToClient(P);
  Result:=(htOnStateIcon in (Sender as TTreeView).GetHitTestInfoAt(P.X,P.Y));
end;



procedure TTagSearch.ScanFTF;
var
  I,LCount:integer;

  TempL:Tstrings;
  //delta
  Dtime:TTime;
begin
  BTN_Explore.enabled:=false;
  BTN_Explore.Invalidate;
  TreeView1.Enabled:=false;

  Dtime:=Time;

  TempL:= TStringList.Create;
  TempL:= GetAttrFileList(TreeView1);

  // Сканим файлы на наличие нужной нам информации
  UpdateStatus(TS_LangWL.Items[2]+'...');

  ListBox1.Clear;
  LCount:=TempL.Count;
  for I := 0 to LCount-1 do begin
    UpdateStatus(Format(TS_LangWL.Items[4],[I+1,LCount]));
    ScanForMAttr(TempL[I],FindItE.Text,4,ListBox1);
  end;
  TempL.Free;
  //MAinForm.ListBox1.Repaint;
  //MAinForm.Show;
  //Выводим информацию
  Panel1.Caption:=MainForm.LangWL.Items[33]+' '+IntToStr(ListBox1.Count);

  DTime:=DTime-Time;
  Panel2.Caption:=FormatDateTime('hh:mm:ss.zz',DTime);
  UpdateStatus(TS_LangWL.Items[3]+' - '+Panel2.Caption);

  BTN_Explore.enabled:=True;
  TreeView1.Enabled:=True;
end;

procedure TTagSearch.FindClick(Sender: TObject);
begin
  case TButton(sender).Tag of
    0:Begin
      if (Trim(FindItE.Text)='') or (TreeView1.Items[0].StateIndex=1) then exit;
      ScanFTF;
    End;
    1:Begin
      if (TreeView2.Items[0].StateIndex=1) then exit;
      ListBox2.Tag:=GroupSelector.ItemIndex;
      ScanForTag;
    End;
  end;

end;

procedure TTagSearch.SetAllDown(Index: Integer; Node: TTreeNode);
var
 I:integer;
begin
  if (Node=Nil) or (Node.Count<1) then Exit;
  I:=-1;
  Repeat
    Inc(I);
    Node.Item[I].StateIndex:=Index;
    if (Node.Item[I].Count>0) then
      SetAllDown(Index,Node.Item[I]);
  Until (Node.Count-1 = I);
end;

procedure TTagSearch.SetthatDate1Click(Sender: TObject);
var
  ts:String;
begin
  ts:=ExtractDir(ExtractFilePath(ListBox1.Items[ListBox1.ItemIndex]));
  ts:=MainForm.CorrectDay(Copy(ts,1,2),Copy(ts,4,2),Copy(ts,7,2)); //(ts,1,2) as (ts,1,4)
  MainForm.DTP1.Date:=StrToDate(ts);
  MainForm.DTP1Change(MainForm.DTP1);
end;

procedure TTagSearch.ScanFF(Dest:TTreeView; Dir_:String; Index:Integer);
var
  ODir:String;
begin
  Dest.Items.Clear;
  if Dir_[length(Dir_)]<>'\' then
    Dir_:=Dir_+'\';
  ODir:=ExtractDir(dir_);
  Dest.Hint:=Copy(Dir_,1,Length(Dir_)-Length(ODir)-1);
  //ShowMessage('ODIR '+ODir+#13+'Hint '+TreeView1.Hint);
  Dest.Items.Add(nil,ODir);
  Dest.Items.Item[0].StateIndex:=1;
  Dest.Items.Item[0].HasChildren:=True;
end;

procedure TTagSearch.ScanForTag;
var
  LCount,I:Integer;
  TempL:Tstrings;
  //delta
  Dtime:TTime;
begin
  Find.enabled:=false;
  Find.Repaint;
  TreeView2.Enabled:=false;

  Dtime:=Time;

  TempL:= TStringList.Create;
  TempL:= GetAttrFileList(TreeView2);

  // redo

  // Сканим файлы на наличие нужной нам информации
  UpdateStatus(TS_LangWL.Items[2]+'...');

  ListBox2.Clear;
  LCount:=TempL.Count;
  for I := 0 to LCount-1 do begin
    UpdateStatus(Format(TS_LangWL.Items[4],[I+1,LCount]));
    ScanForAttrL(TempL[I],4,ListBox2,GroupSelector.ItemIndex+1);
  end;
  TempL.Free;
  //MAinForm.ListBox1.Repaint;
  //MAinForm.Show;
  //Выводим информацию
  Panel1.Caption:=MainForm.LangWL.Items[33]+' '+IntToStr(ListBox1.Count);

  // redo end

  DTime:=DTime-Time;

  UpdateStatus(TS_LangWL.Items[3]+' - '+FormatDateTime('hh:mm:ss.zz',DTime));

  Find.enabled:=True;
  TreeView2.Enabled:=True;
end;

procedure TTagSearch.ToggleTreeViewCheckBoxes(Node: TTreeNode);
var
 TeNode:TTreeNode;
 I:integer;
begin
  if Not Assigned(Node) then Exit;

  Node.StateIndex := ORD(ODD(Node.StateIndex))+1-ORD(Node.StateIndex=3);
  // Далее так-же используется для сравнения

  SetAllDown(Node.StateIndex,Node);
  TeNode:=node;
  if (TeNode.Parent = nil) then exit;
  repeat
    I:=0;
    TeNode:=TeNode.Parent;
    if (TeNode = nil) then break;
    repeat
      if TeNode.Item[I].StateIndex<>Node.StateIndex then
      begin
        TeNode.StateIndex:=3;
        break;
      end;
      Inc(I);
      if I=TeNode.Count then
      TeNode.StateIndex:=Node.StateIndex;
    until (I>=TeNode.Count);
  until TeNode = nil;
end;


procedure TTagSearch.TreeView1Click(Sender: TObject);
begin
  //Memo1.Lines.Add(IntToStr(TreeView1.Selected.Count)+'_'+TreeView1.Selected.Text);
  if OnTreeCheck(sender) then
    ToggleTreeViewCheckBoxes((Sender as TTreeView).Selected);

  if (sender=TreeView1) then begin
    Find.Enabled:=(Trim(FindItE.Text)<>'') and (TreeView1.Items[0].StateIndex>1);
  end;

  if (sender=TreeView2) then begin
    BTN_Explore.Enabled:= TreeView2.Items[0].StateIndex>1;
    If (TreeView2.Items[0].Expanded) then begin
      ListBox2.Width:=264;
      TreeView2.Height:=371;
    end else begin
      TreeView2.Height:=21;
      ListBox2.Width:=444;
    end;
  end;
end;

procedure TTagSearch.TreeView1Collapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
begin
  AllowCollapse:=Not OnTreeCheck(sender);
end;

procedure TTagSearch.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
  AllowExpansion:=Not OnTreeCheck(sender);

  If node.Count > 0 then exit;

  (Sender as TTreeView).Items.BeginUpdate;
  NextLevel(Sender,node);
  (Sender as TTreeView).Items.EndUpdate;
end;

procedure TTagSearch.TreeView1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_SPACE) and Assigned((Sender as TTreeView).Selected) and (Shift=[]) then
    ToggleTreeViewCheckBoxes((Sender as TTreeView).Selected);
end;

procedure TTagSearch.UpdateStatus(Text: String;CCheck:Boolean);
begin
  if CCheck and (Clipboard.AsText=Text) then
    Text:='"'+Clipboard.AsText+'" '+MainForm.LangWL.Items[20];
  Statusbar1.Panels.Items[0].Text:=Text;
  Statusbar1.Repaint;
end;

procedure TTagSearch.View1_ChBClick(Sender: TObject);
begin
  MainConfF.WriteBool('TagSearch','ViewOnSelect',View1_ChB.Checked);
end;

procedure TTagSearch.View2_ChBClick(Sender: TObject);
begin
  MainConfF.WriteBool('TagSearch','ReadAttrOnSelect',View2_ChB.Checked);
end;

End.

