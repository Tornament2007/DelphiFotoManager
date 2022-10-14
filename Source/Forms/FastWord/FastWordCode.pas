unit FastWordCode;
{
  При правке изменяется Регистр
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, iniFiles, LanguageOperator, Vcl.ComCtrls,
  TagSearchCode;

type
  TFastWord = class(TForm)
    Editor1: TPanel;
    Editor2: TPanel;
    Editor3: TPanel;
    ListBox1: TListBox;
    Edit1: TEdit;
    DeB: TButton;
    AdB: TButton;
    EdB: TButton;
    LangWL: TListBox;
    UpDown1: TUpDown;
    procedure Editor1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure AdBClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure DeBClick(Sender: TObject);
    procedure EdBClick(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    Procedure OpenConf;
    Procedure CloseConf;
  public
    { Public declarations }
    procedure LoadList(dest:Integer);
    procedure Write(Text:string);
    procedure Delete(Index, Count: Integer);
    procedure EditBegin;
    procedure EditEnd;
  end;

const
  Field: array[1..3] of string = ('Tags','Camera','Author');

var
  FastWord: TFastWord;
  FastWordIni:TiniFile;
  EditMode:Boolean;

implementation

uses MainCode,AttrMenuCode, FsP;

{$R *.dfm}



procedure TFastWord.EdBClick(Sender: TObject);
begin
  if EditMode then
    begin
      Edit1.Clear;
      EditEnd;
    end
  else
    begin
      Edit1.Text:=ListBox1.Items[ListBox1.ItemIndex];
      EditBegin;
    end;
end;

procedure TFastWord.Edit1Change(Sender: TObject);
var
  Adena:boolean;  // Если совпадает со списком то офф добафить.
  Tint:Integer;
  Ft:integer;
begin
  if sender.ClassName='TEdit' then
    UpDown1.Tag:=1;
  Adena:=False;
  Tint:=-1;
  Ft:=0;
  if Listbox1.Count>0 then
    repeat
      Inc(Tint);
      if (AnCa(Edit1.Text)=AnCa(Listbox1.items[Tint])) then
        Adena:=True;
    until (Adena) or (Tint+1>=Listbox1.Count);

  if Edit1.Text='' then
  begin
    ListBox1.Selected[ListBox1.ItemIndex]:=false;
    ListBox1.ItemIndex:=-1;
  end
  else
  for Tint:=0 to ListBox1.Count-1 do
  begin
    if pos(AnCa(Edit1.Text),AnCa(ListBox1.Items[Tint]))>0 then
    begin
      ListBox1.Selected[Tint]:=true;
      ListBox1.ItemIndex:=Tint;
      Inc(Ft);
      if UpDown1.Tag-Ft<=0 then Break;
    end;
    if (Tint=ListBox1.Count-1) then
    begin
      if (ft=0) then
      begin
        ListBox1.Selected[ListBox1.ItemIndex]:=false;
        ListBox1.ItemIndex:=-1;
      end
      else
        UpDown1.Tag:=UpDown1.Tag-1;
    end;
  end;
  UpDown1.Position:=ft;


  ListBox1Click(DeB);
  if (Edit1.Text='') or (Adena) then
    AdB.Enabled:=false
  else
    AdB.Enabled:=True;
end;

procedure TFastWord.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=',' then key:=#0;
  if ord(key)=VK_RETuRN then
  begin
    AdBClick(AdB);
    exit;
  end;
  if ord(key)=VK_ESCAPE then
  begin
    Self.Close;
    exit;
  end;

end;

procedure TFastWord.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {if (Shift = [ssCtrl]) then
  begin
    if (ord(Key)=ord('w')) or (ord(Key)=VK_RIGHT) then
      UpDown1Click(UpDown1,TUDBtnType(1));
    if (ord(Key)=ord('q')) or (ord(Key)=VK_LEFT) then
      UpDown1Click(UpDown1,TUDBtnType(2));
  end;}

  //VK_UP = vkUp; {38}
  //VK_RIGHT = vkRight; {39}

  //VK_LEFT = vkLeft; {37}
  //VK_DOWN = vkDown; {40}
end;

procedure TFastWord.EditBegin;
begin
  EditMode:=True;
  ListBox1.Enabled:=false;
  Editor1.Enabled:=false;
  Editor2.Enabled:=false;
  Editor3.Enabled:=false;
  DeB.Enabled:=false;
  AdB.Enabled:=false;
end;

procedure TFastWord.EditEnd;
begin
  EditMode:=False;
  ListBox1.Enabled:=True;
  Editor1.Enabled:=True;
  Editor2.Enabled:=True;
  Editor3.Enabled:=True;
  DeB.Enabled:=True;

  Edit1Change(Edit1);
  Listbox1click(Listbox1);
end;

procedure TFastWord.Editor1Click(Sender: TObject);
Var
  selI:Integer;
begin
  selI:=StrToInt(Copy((Sender as Tpanel).Name,7,1));
  if seli=1 then UpDown1.Max:=ListBox1.Count-1;

  if FastWord.Tag=selI then exit;

  // 1 - 3*1 = |-2 + 1| =   1 + 1                  2
  // 1 - 3*2 = |-5 + 2| =   3 + Ord (not(odd(1)))  3

  // 2 - 3*1 = |-1 + 1| =   0 + 1                  1
  // 2 - 3*2 = |-4 + 2| =   2 + Ord (not(odd(2)))  3

  // 3 - 3*1 = | 0 + 1| =   1 + 1                  2
  // 3 - 3*2 = |-3 + 2| =   1 + Ord (not(odd(3)))  1

  // ABS((I - 3*a)+a)+Ord(a=1)+Ord(not(odd(I)))
  // I = 1..3  |  a = 1..2

  (FindComponent('Editor'+IntTOStr(FastWord.Tag)) as Tpanel).BevelInner:=bvRaised;
  FastWord.Tag:=selI;
  (Sender as Tpanel).BevelInner:=bvLowered;

  Edit1.Clear;
  Edit1.TextHint:=
    LangWL.Items[0]+' '+AnCa((FindComponent('Editor'+IntTOStr(FastWord.Tag)) as Tpanel).Caption)+', '+LangWL.Items[1];
  LoadList(0);

end;

procedure TFastWord.FormCreate(Sender: TObject);
begin
  Self.Width:=240;
  ReadLang(Self,Data+'Lang\','Lang',Language);
  LoadList(0); //Load Tags in to list box
  LoadList(3); //Load Author and Camera Combobox'es
  EditMode:=False;
end;

procedure TFastWord.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex<>-1 then
    Begin
      DeB.Enabled:=True;
      EdB.Enabled:=True;
      if Sender.ClassName<>'TButton' then
        Edit1.Text:=ListBox1.Items[ListBox1.ItemIndex];
    End
  else
    begin
      DeB.Enabled:=False;
      EdB.Enabled:=False;
    end;
end;

procedure TFastWord.ListBox1DblClick(Sender: TObject);
begin
  Edit1.Text:=Listbox1.Items[Listbox1.itemindex];
end;

procedure TFastWord.LoadList(dest:Integer);
var
  i,num,Inum:Integer;
  TStr,ItNa:String;
begin
  OpenConf;
  repeat
    i:=0;
    if Dest=0 then
      begin
        num:=0;
        Inum:=FastWord.Tag;
        AttrMenu.AttrTa.Items.Clear;
        TagSearch.AddToSearchFild.Items.Clear;
        ListBox1.Items.Clear;
      end
    else
      begin
        num:=Dest+1-(Ord(Dest>2)*2);
        Inum:=num;
        case Num of
          0 : begin
                ListBox1.Items.Clear;
                AttrMenu.AttrTa.Items.Clear;
                TagSearch.AddToSearchFild.Items.Clear;
              end;
          1 : AttrMenu.AttrA.Items.Clear;
          2 : AttrMenu.AttrC.Items.Clear;
          3 : AttrMenu.AttrA.Items.Clear;
        end;
      end;
  repeat
    inc(i);
    ItNa:=Copy(Field[Inum],1,3);
    TStr:=FastWordIni.ReadString(Field[Inum],ItNa+IntToStr(I),'');
    if TStr<>'' then
      case Num of
        0 : begin
              ListBox1.Items.Add(TStr);
              AttrMenu.AttrTa.Items.Add(TStr);
              TagSearch.AddToSearchFild.Items.Add(TStr);
            end;
        1 : AttrMenu.AttrA.Items.Add(TStr);
        2 : AttrMenu.AttrC.Items.Add(TStr);
        3 : AttrMenu.AttrA.Items.Add(TStr);
      end;
  until FastWordIni.ReadString(Field[Inum],ItNa+IntToStr(I+1),'$!@*#^%$(#^&@')='$!@*#^%$(#^&@';
    dest:=dest+Ord(dest>2)
  until dest<>4;
  CloseConf;
end;

procedure TFastWord.OpenConf;
begin
  FastWordIni:= TiniFile.Create(Data+'FastWords.INI');
end;

procedure TFastWord.UpDown1Click(Sender: TObject; Button: TUDBtnType);
var
  Ti:Integer;
begin
  Ti:=UpDown1.Tag;
  if Button = btNext then
  begin
    Inc(Ti);
  end
  else
  begin
    dec(Ti);
  end;
  if Ti<1 then Ti:=1;
  UpDown1.Tag:=Ti;
  Edit1Change(Deb);
end;

procedure TFastWord.Write(Text: string);
var
  i:Integer;
  Finded:Boolean;
  ItNa:String;
begin
  OpenConf;
  Finded:=false;
  I:=0;
  ItNa:=Copy(Field[FastWord.Tag],1,3);
  if EditMode then
    FastWordIni.WriteString(Field[FastWord.Tag],ItNa+IntToStr(ListBox1.ItemIndex+1),Text)
  else
    repeat
      Inc(I);
      if (FastWordIni.ReadString(Field[FastWord.Tag],ItNa+IntToStr(I),'')='') then
        begin
          FastWordIni.WriteString(Field[FastWord.Tag],ItNa+IntToStr(I),Text);
          Finded:=True;
        end;
    until Finded;
  CloseConf;
end;

procedure TFastWord.AdBClick(Sender: TObject);
begin
  Write(Edit1.Text);
  if EditMode then
    begin
      ListBox1.Items[ListBox1.ItemIndex]:=Edit1.Text;
      EditEnd;
    end
  else
    begin
      ListBox1.Items.Add(Edit1.Text);
      AdB.Enabled:=False;
      Edit1.Clear;
      If FastWord.Visible then
        Edit1.SetFocus;

      LoadList(0);
    end;
  if tag>1 then
    LoadList(tag);
end;

Procedure TFastWord.CloseConf;
begin
  FastWordIni.Free;
end;

procedure TFastWord.DeBClick(Sender: TObject);
begin
  Delete(ListBox1.ItemIndex+1,ListBox1.Count);
  LoadList(0);
  if tag>1 then
    LoadList(tag);
end;

procedure TFastWord.Delete(Index, Count: Integer);
var
  ItNa,TText:String;
begin
  OpenConf;
  ItNa:=Copy(Field[FastWord.Tag],1,3);

  TText:=FastWordIni.ReadString(Field[FastWord.Tag],ItNa+IntToStr(count),'');
  FastWordIni.WriteString(Field[FastWord.Tag],ItNa+IntToStr(Index),TText);
  FastWordIni.DeleteKey(Field[FastWord.Tag],ItNa+IntToStr(count));

  CloseConf;
end;

end.
