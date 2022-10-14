unit RenItWFMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TRenFilMenu = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    Procedure RenameOne(OldFName,NewFName:String);
    Procedure RenameMore(OldFName:Tstringlist;NewFName:String);
  public
    { Public declarations }
  end;

var
  RenFilMenu: TRenFilMenu;

implementation

{$R *.dfm}

procedure TRenFilMenu.Edit1Change(Sender: TObject);
begin
  Button1.Enabled:=Edit1.Text<>'';
end;

procedure TRenFilMenu.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(key)=vk_return then
    begin
      Button1.Click;
      exit;
    end;
  if Ord(key)=vk_escape then
    begin
      Button2.Click;
      exit;
    end;
  if (Key in ['\','/','|',':','?','<','>','*','"']) then
    Key:=#0;
end;

procedure TRenFilMenu.RenameMore(OldFName: Tstringlist; NewFName: String);

var
  I:Integer;
begin
  I:=-1;
  repeat
  //RenameFile(OldFName[i],OldFName);
  until true;
end;

procedure TRenFilMenu.RenameOne(OldFName, NewFName: String);
begin
  //RenameFile(OldFName,NewFName);
end;

end.
