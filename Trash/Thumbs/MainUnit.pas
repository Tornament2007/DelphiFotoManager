unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, StdCtrls;

type
  TForm1 = class(TForm)
    procedure FormClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    sourse_map: TBitmap;
    jpeg_map: TJpegImage;

    procedure paint_thumbnail;

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.FormClick(Sender: TObject);
begin
  tag:=Tag+1;
  if tag>31 then tag:=1;

  jpeg_map.LoadFromFile('File ('+IntToStr(Tag)+').jpg');

  sourse_map.Width := jpeg_map.Width;
  sourse_map.Height := jpeg_map.Height;
  sourse_map.Assign(jpeg_map);
  paint_thumbnail;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  jpeg_map := TJpegImage.Create;
  sourse_map := TBitmap.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  sourse_map.Free;
  jpeg_map.Free;
end;

procedure TForm1.paint_thumbnail;
var
  map: TBitmap;
  x1, y1, x2, y2: Integer;
  fact1, fact2: Real;
begin
  map := TBitmap.Create;
  // ������� ��������� �����������
  x1 := sourse_map.Width;
  y1 := sourse_map.Height;
  //������� �������, � ������� ���������� �����������
  x2 := Self.ClientWidth;
  y2 := Self.ClientHeight;
  // ��������� ��������� ��������
  fact1 := x2 / x1;
  fact2 := y2 / y1;
  // ���� ���������� �����������, ����� �� ���� ��������� ������� ��������� �����������
  If fact2 < fact1 then
    fact1 := fact2;
  // � ������ ��� �����������
  Self.Canvas.Brush.Color := clGray;
  Self.Canvas.FillRect(Self.Canvas.ClipRect);
  // ���� �������� ������ �������� �������, �� ������� �
  If fact1 < 1.0 then
    begin
      map.Width := Round(x1 * fact1);
      map.Height := Round(y1 * fact1);
      map.Canvas.StretchDraw(map.Canvas.ClipRect, sourse_map);
    end
  else // ����� - ��������� �����, ����� ��� ���� (����� �� ���������)
    map.Assign(sourse_map);
  // ����������:
  Self.Canvas.Draw((Self.ClientWidth - map.Width) div 2,
      (Self.ClientHeight - map.Height) div 2, map);
  map.Free;
end;

end.
