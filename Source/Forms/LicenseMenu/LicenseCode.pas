unit LicenseCode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TLicenseMenu = class(TForm)
    GroupBox1: TGroupBox;
    RichEdit1: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LicenseMenu: TLicenseMenu;

implementation

uses LanguageOperator, MainCode;

{$R *.dfm}

procedure TLicenseMenu.FormCreate(Sender: TObject);
begin
  ReadLang(Self,Data+'Lang\','Lang',Language);
  Self.Caption:=Application.Title+' | '+Self.Caption;
end;

procedure TLicenseMenu.FormShow(Sender: TObject);
begin
  RichEdit1.SelLength:=0;
  RichEdit1.SelStart:=0;
end;

end.
