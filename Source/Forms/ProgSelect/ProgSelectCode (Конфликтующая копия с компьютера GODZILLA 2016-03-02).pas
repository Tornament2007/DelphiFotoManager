unit ProgSelectCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DropFileClass, LanguageOperator;

type
  TSelectProg = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    Reset1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    SaveA_Bt: TButton;
    Label3: TLabel;
    Edit2: TEdit;
    LangWL: TListBox;
    Reset2: TButton;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure SaveA_BtClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure Reset2Click(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    procedure FromDropFiles(Sender: TObject);
  public
    { Public declarations }
  end;

var
  SelectProg: TSelectProg;
  DropPan: TDropFile;

implementation

uses FsP,ConfCode,MainCode;

{$R *.dfm}

procedure TSelectProg.Button1Click(Sender: TObject);
begin
  if opendialog1.Execute() then
    begin
      Edit1.Text:=opendialog1.FileName;
    end;
end;

procedure TSelectProg.Reset1Click(Sender: TObject);
begin
  Edit1.Text:=Edit1.Hint;
end;

procedure TSelectProg.SaveA_BtClick(Sender: TObject);
begin
  If not fileExists(Edit1.Hint) then
    Edit1.Hint:='';
  if  (FileExists(Edit1.Text)) and (AnCa(extractFileEXT(Edit1.Text))='.exe')
  And (AnCa(Edit1.Text)<>AnCa(Edit1.Hint)) then
    Edit1.Hint:=Edit1.Text;

  if FileExists(Edit1.Hint) then
  begin
    if Edit2.Text='' then
      MainForm.PPEdit2.Caption:=LangWL.Items[0]+' "'+LangWL.Items[2]+'"'
    else
      MainForm.PPEdit2.Caption:=LangWL.Items[0]+' "'+Edit2.Text+'"';
  end
  else
  begin
    MainForm.PPEdit2.Caption:=LangWL.Items[1];
    Edit2.Text:='';
  end;
  Edit2.Hint:=Edit2.Text;
  MainForm.PPEdit2.Hint:=Edit1.Hint;

  if (Sender as Tbutton).Name<>'Button2' then
  begin
    MainConfF.WriteString('EditorProg','PathTo',Edit1.Hint);
    MainConfF.WriteString('EditorProg','Name',Edit2.Hint);
  end;

  SaveA_Bt.Enabled:=False;
end;

procedure TSelectProg.Reset2Click(Sender: TObject);
begin
  Edit2.Text:=Edit2.Hint;
end;

procedure TSelectProg.Edit1Change(Sender: TObject);
var
  tStr:String;
begin
  tStr:=AnCa(Edit1.Text);

  SaveA_Bt.Enabled:=((Edit2.Text<>'') and (Edit2.Hint=''))
    or ((Edit2.Text<>'') and (AnCa(Edit2.Hint)<>AnCa(Edit2.Text)))
    or ((FileExists(Edit1.Text)) and (extractFileEXT(AnCa(Edit1.Text))='.exe')
       and (AnCa(Edit1.Text)<>AnCa(Edit1.HINT)));

  Reset1.Enabled:=((FileExists(Edit1.hint)) and (AnCa(Edit1.hint)<>tStr));

  if  (FileExists(tStr))
  and (extractFileEXT(tStr)='.exe') then
    edit1.Color:=ClWhite
  else
    edit1.Color:=ClRed;
end;

procedure TSelectProg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Sender.ClassName='TEdit' then
    Key:=E_PathEdit(Sender as TEdit,Key);
end;

procedure TSelectProg.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ord(Key)=(Vk_Return) then
  begin
    if SaveA_Bt.Enabled then
      SaveA_Bt.Click;
    exit;
  end;
  if ord(Key)=(Vk_ESCAPE) then
  begin
    if  (FindComponent('Reset'+Copy((Sender as TButton).Name,6,1)) as Tbutton).Enabled then
      (FindComponent('Reset'+Copy((Sender as TButton).Name,6,1)) as Tbutton).Click;
    exit;
  end;
end;

procedure TSelectProg.Edit2Change(Sender: TObject);
begin
  SaveA_Bt.Enabled:=((Edit2.Text<>'') and (Edit2.Hint=''))
    or ((Edit2.Text<>'') and (AnCa(Edit2.Hint)<>AnCa(Edit2.Text)))
    or ((FileExists(Edit1.Text)) and (extractFileEXT(AnCa(Edit1.Text))='.exe')
       and (AnCa(Edit1.Text)<>AnCa(Edit1.HINT)));
  Reset2.Enabled:=(Edit2.hint<>'') and (AnCa(Edit2.hint)<>AnCa(Edit2.Text));
end;

procedure TSelectProg.FormCreate(Sender: TObject);
begin
  ReadLang(Self,Data+'Lang\','Lang',Language);

  DropPan:=TDropFile.Create(Panel1);
  DropPan.OnDropFiles:=self.FromDropFiles;
  OpenDialog1.Filter:=LangWL.Items[6]+'|*.exe|All files|*.*';
  SelectProg.Width:=327;
  SelectProg.Height:=245;
end;

procedure TSelectProg.FromDropFiles(Sender: TObject);
Var
  Lnk,Path:String;
  I:Integer;
begin
  if DropPan.Files.Count>1 then
    begin
      SelectProg.caption:=' '+LangWL.Items[3];
      Timer1.Enabled:=true;
      exit;
    end;
  Lnk:=AnCa(DropPan.Files[0]);
  if (Copy(Lnk,Length(Lnk)-2,3))<>'lnk' then Exit;

  Path:=NameFromLink(Lnk);
  if ExtractFileExt(Lnk)='.exe' then
    Path:=Lnk;
  if (AnCa(ExtractFileEXT(Path)))='.exe' then
    begin
      Edit1.Text:=Path;
    end
  else
    begin
      SelectProg.caption:=' '+LangWL.Items[4];
      Timer1.Enabled:=true;
    end;
end;

procedure TSelectProg.Timer1Timer(Sender: TObject);
begin
  SelectProg.caption:=' '+LangWL.Items[5];
  Timer1.Enabled:=False;
end;

end.
