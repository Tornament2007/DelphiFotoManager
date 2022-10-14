unit ProgSelectCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DropFileClass, LanguageOperator;

type
  TSelectProg = class(TForm)
    PS_Path: TEdit;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    LangWL: TListBox;
    GroupBox4: TGroupBox;
    PSC_Selector: TComboBox;
    PS_Name: TEdit;
    Panel1: TPanel;
    Label2: TLabel;
    PS_Add: TButton;
    PS_Del: TButton;
    Label3: TLabel;
    PS_Explore: TButton;
    SaveA_Bt: TButton;
    Reset1: TButton;
    Reset2: TButton;
    Bevel1: TBevel;
    procedure PS_PathKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PS_ExploreClick(Sender: TObject);
    procedure PS_PathChange(Sender: TObject);
    procedure SaveA_BtClick(Sender: TObject);
    procedure PS_NameChange(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure Reset2Click(Sender: TObject);
    procedure PS_PathKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

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

procedure TSelectProg.PS_ExploreClick(Sender: TObject);
begin
  if opendialog1.Execute() then
    begin
      PS_Path.Text:=opendialog1.FileName;
    end;
end;

procedure TSelectProg.Reset1Click(Sender: TObject);
begin
  PS_Path.Text:=PS_Path.Hint;
end;

procedure TSelectProg.SaveA_BtClick(Sender: TObject);
begin
  If not fileExists(PS_Path.Hint) then
    PS_Path.Hint:='';
  if  (FileExists(PS_Path.Text)) and (AnCa(extractFileEXT(PS_Path.Text))='.exe')
  And (AnCa(PS_Path.Text)<>AnCa(PS_Path.Hint)) then
    PS_Path.Hint:=PS_Path.Text;

  if FileExists(PS_Path.Hint) then
  begin
    if PS_Name.Text='' then
      MainForm.PPEdit2.Caption:=LangWL.Items[0]+' "'+LangWL.Items[2]+'"'
    else
      MainForm.PPEdit2.Caption:=LangWL.Items[0]+' "'+PS_Name.Text+'"';
  end
  else
  begin
    MainForm.PPEdit2.Caption:=LangWL.Items[1];
    PS_Name.Text:='';
  end;
  PS_Name.Hint:=PS_Name.Text;
  MainForm.PPEdit2.Hint:=PS_Path.Hint;

  if (Sender as Tbutton).Name<>'Button2' then
  begin
    MainConfF.WriteString('EditorProg','PathTo',PS_Path.Hint);
    MainConfF.WriteString('EditorProg','Name',PS_Name.Hint);
  end;

  SaveA_Bt.Enabled:=False;
end;

procedure TSelectProg.Reset2Click(Sender: TObject);
begin
  PS_Name.Text:=PS_Name.Hint;
end;

procedure TSelectProg.PS_PathChange(Sender: TObject);
var
  tStr:String;
begin
  tStr:=AnCa(PS_Path.Text);

  SaveA_Bt.Enabled:=((PS_Name.Text<>'') and (PS_Name.Hint=''))
    or ((PS_Name.Text<>'') and (AnCa(PS_Name.Hint)<>AnCa(PS_Name.Text)))
    or ((FileExists(PS_Path.Text)) and (extractFileEXT(AnCa(PS_Path.Text))='.exe')
       and (AnCa(PS_Path.Text)<>AnCa(PS_Path.HINT)));

  Reset1.Enabled:=((FileExists(PS_Path.hint)) and (AnCa(PS_Path.hint)<>tStr));

  if  (FileExists(tStr))
  and (extractFileEXT(tStr)='.exe') then
    PS_Path.Color:=ClWhite
  else
    PS_Path.Color:=ClRed;
end;

procedure TSelectProg.PS_PathKeyPress(Sender: TObject; var Key: Char);
begin
  if Sender.ClassName='TEdit' then
    Key:=E_PathEdit(Sender as TEdit,Key);
end;

procedure TSelectProg.PS_PathKeyUp(Sender: TObject; var Key: Word;
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

procedure TSelectProg.PS_NameChange(Sender: TObject);
begin
  SaveA_Bt.Enabled:=((PS_Name.Text<>'') and (PS_Name.Hint=''))
    or ((PS_Name.Text<>'') and (AnCa(PS_Name.Hint)<>AnCa(PS_Name.Text)))
    or ((FileExists(PS_Path.Text)) and (extractFileEXT(AnCa(PS_Path.Text))='.exe')
       and (AnCa(PS_Path.Text)<>AnCa(PS_Path.HINT)));
  Reset2.Enabled:=(PS_Name.hint<>'') and (AnCa(PS_Name.hint)<>AnCa(PS_Name.Text));
end;

procedure TSelectProg.FormCreate(Sender: TObject);
begin
  ReadLang(Self,Data+'Lang\','Lang',Language);

  DropPan:=TDropFile.Create(Panel1);
  DropPan.OnDropFiles:=self.FromDropFiles;
  OpenDialog1.Filter:=LangWL.Items[6]+'|*.exe|All files|*.*';
  SelectProg.Width:=398;
  SelectProg.Height:=253;
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
      PS_Path.Text:=Path;
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
