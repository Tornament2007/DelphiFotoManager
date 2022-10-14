unit LookMenuCode;

interface

uses
  //ImageRotator,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Jpeg, pngimage, Gifimg, Menus, ComCtrls, StdCtrls,
  LanguageOperator, strutils, GDIPAPI, GDIPOBJ, GDIPUTIL, Math;

type
  TLookMenu = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    StatusBar1: TStatusBar;
    LangWL: TListBox;
    GridPanel1: TGridPanel;
    Panel2: TPanel;
    Image3: TImage;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel10: TPanel;
    MainMenu1: TMainMenu;
    window1: TMenuItem;
    SavePositionandSize1: TMenuItem;
    Imageloadding1: TMenuItem;
    FastJEPGLoading1: TMenuItem;
    Image2: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    procedure SavePositionandSize1Click(Sender: TObject);
    procedure FastJEPGLoading1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RotateAndSave(filename: String; Angle:Integer);
    Procedure LoadImg(FileName:String);
    Procedure ShowAndLoad(Sender:TForm;Lister:TlistBox);
    procedure GetResJpg(JPGFile: string; Width, Height:Word);
    procedure ExtractThumb(Var TH_W,TH_H:Integer; const FileName: string;
      var OrigWidth, OrigHeight: Word; var Bitmap: TBitmap;NTN:Boolean = False);
  end;

var
  LookMenu: TLookMenu;

  LM_SLBox:TListBox;


implementation
uses MainCode,ConfCode, FsP, AttrMenuCode;
{$R *.dfm}

{ TLookMenu }
procedure TLookMenu.GetResJpg(JPGFile: string; Width, Height: Word);
const
  BufferSize = 50;
var
  Buffer: string;
  Index: integer;
  FileStream: TFileStream;
  //HorzRes, VertRes: Word;
  DP: Byte;
  Measure: string;
begin
  FileStream := TFileStream.Create(JPGFile,
    fmOpenReadWrite);
  try
    SetLength(Buffer, BufferSize);
    FileStream.Read(buffer[1], BufferSize);
    Index := Pos('JFIF' + #$00, buffer);
    if Index > 0 then
    begin
      FileStream.Seek(Index + 6, soFromBeginning);
      FileStream.Read(DP, 1);
      case DP of
        1: Measure := 'DPI'; //Dots Per Inch
        2: Measure := 'DPC'; //Dots Per Cm.
      end;
      FileStream.Read(Width, 2); // x axis
      Width := Swap(Width);
      FileStream.Read(Height, 2); // y axis
      Height := Swap(Height);
    end;
    //SetStatus1('X '+IntTostr(Width)+' Y '+IntTostr(Height));
  finally
    FileStream.Free;
  end;
end;

procedure TLookMenu.ExtractThumb(Var TH_W,TH_H:Integer; const FileName: string;
  var OrigWidth,OrigHeight: Word; var Bitmap: TBitmap; NTN:Boolean = false);
var
  Jpeg: TJPEGImage;

  function UseInternalJpegCodec: Boolean;
   var
    Ext  : string;
    Scale: TJPEGScale;
   begin
    Result:=False;

    //  Проверяем расширение файла
    Ext:=ExtractFileExt(FileName);
    if not SameText(Ext, '.jpg') and not SameText(Ext, '.jpeg')
     then   Exit;

    //  Определяем, стоит ли загружать JPEG-файл с меньшим масштабом
    if (OrigWidth>8*TH_W) or (OrigHeight>8*TH_H)
     then   Scale:=jsEighth
     else   if (OrigWidth>4*TH_W) or (OrigHeight>4*TH_H)
             then   Scale:=jsQuarter
             else   if (OrigWidth>2*TH_W) or (OrigHeight>2*TH_H)
                     then   Scale:=jsHalf
                     else   Scale:=jsFullSize;

    //  Для дальнейшей работы разумно использовать только уменьшение при загрузке в 4 и 8 раз
    if Scale in [jsFullSize, jsHalf]
     then   Exit;

    //  Пробуем загрузить изображение внутренним декодером
    try
      Jpeg:=TJPEGImage.Create;
      Jpeg.Scale:=Scale;
      Jpeg.LoadFromFile(FileName);
      Result:=not Jpeg.Empty
     except
      FreeAndNil(Jpeg)
     end
   end;

var
  Image : TGPImage;
  Width ,
  Height: Integer;
  Temp  : TBitmap;
  Scale : Double;
begin
  Jpeg:=nil;
  Temp:=nil;
  Bitmap:=nil;

    Image:=TGPImage.Create(FileName);
    try
    OrigWidth:=Image.GetWidth;
      OrigHeight:=Image.GetHeight;

      //  Подсчет размеров превью
      if NTN then
        Scale:=1
      else
        Scale:=Max(OrigWidth/TH_W, OrigHeight/TH_H);
      Height:=Trunc(OrigHeight/Scale);
      Width:=Trunc(OrigWidth/Scale);

      //  Проверяем, можно ли (и имеет ли смысл) загрузить картинку внутренним кодеком
      if UseInternalJpegCodec and Not NTN
       then   try
                Temp:=TBitmap.Create;
                Temp.Assign(Jpeg);
                FreeAndNil(Image);
                Image:=TGPBitmap.Create(Temp.Handle, Temp.Palette)
               finally
                FreeAndNil(Jpeg)
               end;

      //  Создание конечного изображения
      Bitmap:=TBitmap.Create;
      Bitmap.PixelFormat:=pf24bit;
      Bitmap.SetSize(Width, Height);

      //  Масштабируем картинку с помощью GDI+
      with TGPGraphics.Create(Bitmap.Canvas.Handle) do
        try
          if NTN then
            SetInterpolationMode(InterpolationModeHighQualityBilinear)
          else
            SetInterpolationMode(InterpolationModeLowQuality);
            SetCompositingQuality(CompositingQualityHighSpeed);
            SetSmoothingMode(SmoothingModeHighSpeed);
            DrawImage(Image, MakeRect(0, 0, Width, Height), 0, 0, Image.GetWidth, Image.GetHeight, UnitPixel)
        finally
          Free;
        end
      finally
        FreeAndNil(Image);
        FreeAndNil(Temp)
      end
end;

procedure TLookMenu.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := Application.Handle;
end;

procedure TLookMenu.FastJEPGLoading1Click(Sender: TObject);
begin
  MainConfF.WriteBool('PreViewConf','FastJPEG',FastJEPGLoading1.Checked);
  invalidate;
end;

procedure TLookMenu.FormCreate(Sender: TObject);
begin
  ReadLang(Self,Data+'Lang\','Lang',Language);
end;

procedure TLookMenu.FormResize(Sender: TObject);
begin
  statusbar1.Panels[0].Width:=self.Width-statusbar1.Panels[1].Width-25;
  //statusbar1.Panels[0].Width:=self.Width-45;
end;

procedure TLookMenu.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  tv_i,tv_c,tv_act:Integer;
begin
  tv_c:=LM_SLBox.items.Count;
  tv_i:=LM_SLBox.itemIndex;

  if (Button = mbLeft) then
    tv_act:=1
  else
    tv_act:=-1;

  if (tv_c<2) or (tv_i+tv_act>=tv_c) then
    LM_SLBox.itemIndex:=0
  else
    if (tv_i+tv_act<0) then
      LM_SLBox.itemIndex:=tv_c-1
    else
      LM_SLBox.itemIndex:=tv_i+tv_act;

  LM_SLBox.MultiSelect:=false;
    LM_SLBox.itemIndex:=LM_SLBox.itemIndex;
  LM_SLBox.MultiSelect:=True;

  LoadImg(LM_SLBox.items[LM_SLBox.ItemIndex]);
  AttrMenu.ShowAndRead(Self,LM_SLBox);
end;

procedure TLookMenu.Image2Click(Sender: TObject);
begin
  RotateAndSave(Image1.Hint,90);
end;

procedure TLookMenu.Image3Click(Sender: TObject);
begin
  RotateAndSave(Image1.Hint,270);
end;

procedure TLookMenu.Image4Click(Sender: TObject);
begin
  Image1MouseUp(image1,mbright,[],0,0);
end;

procedure TLookMenu.Image5Click(Sender: TObject);
begin
  Image1MouseUp(image1,mbleft,[],0,0);
end;

procedure TLookMenu.LoadImg(FileName: String);

  procedure assignAsBMP(ImObj:TPersistent);
  var
    bmp2: TBitmap;
  begin
    try
      bmp2 := TBitmap.Create;
      bmp2.Assign(ImObj);
      Image1.Picture.Assign(bmp2);
    Finally
      bmp2.FreeImage;
      bmp2.Free;
    end;
  end;

var
  bmp: TBitmap;
  FileEXT:String;
  ImgH,ImgW, tv_Indx:Integer;

  bim:TBitmap;
  IWidth,IHeight:Word;
  LoW,LoH:Integer;
begin
  if (Image1.Hint=FileName) then Exit;
  Image1.Hint:=FileName;
  statusbar1.Panels[1].Text:=AnCa(ExtractFileExt(FileName),True);
  FileEXT:=AnCa(ExtractFileEXT(FILENAME));
  StatusBar1.Panels[0].Text:=LangWL.Items[0];

  if Not FileExists(FileName) then
  begin
    Image1.visible:=False;
    StatusBar1.Panels[0].Text:=LangWL.Items[3];
    exit;
  end;

  tv_Indx:=ansiIndexText(FileEXT ,[
  '.bmp','.jpeg','.jpg','.jpe','.jfif','.gif','.emf','.wmf','.tiff','.png','.icon'
  ]);
  if (tv_Indx>-1) then begin
    try
      LookMenu.GetResJpg(FileName, IWidth, IHeight);
      LoW:=IWidth;
      LoH:=IHeight;
      LookMenu.ExtractThumb(LoW,LoH,FileName,IWidth,IHeight,Bim,true);
      Image1.Picture.Bitmap.Assign(bim);
      FreeAndNil(bim);//.Free;
    Except
      on E: EInvalidGraphic do ShowMessage ('Ошибка загрузки');
      on E: EConvertError do ShowMessage ('Ошибка конвертирования');
      else ShowMessage ('Другая ошибка: ' + #13 + Exception(ExceptObject).Message);
      Image1.visible:=False;
      MainForm.SetStatus1(LangWL.Items[1],2000);
      StatusBar1.Panels[0].Text:=LangWL.Items[2];
      Image1.Hint:=LangWL.Items[4];
    end;
    Image1.visible:=True;
    StatusBar1.Panels[0].Text:=IntToStr(IHeight)+'x'+IntToStr(IWidth);
  end;
  //else         // load other format by costom method
  //exit;
  FreeMemory;
end;

procedure TLookMenu.RotateAndSave(filename: String; Angle:Integer);
const
  gGIf: TGUID = '{557CF402-1A04-11D3-9A73-0000F81EF32E}';
  gPNG: TGUID = '{557CF406-1A04-11D3-9A73-0000F81EF32E}';
  gPJG: TGUID = '{557CF401-1A04-11D3-9A73-0000F81EF32E}';
  gBMP: TGUID = '{557CF400-1A04-11D3-9A73-0000F81EF32E}';
  gTIF: TGUID = '{557CF405-1A04-11D3-9A73-0000F81EF32E}';
var
  tv_Indx:Integer;
  FileTGUID: TGUID;
  sImage: TGPImage;
begin
  tv_Indx:=ansiIndexText(AnCa(ExtractFileEXT(filename)) ,[
  '.bmp','.jpeg','.jpg','.jpe','.jfif','.gif','.emf','.wmf','.tiff','.png','.icon'
  ]);
  case tv_Indx of
    -1: begin exit; end;
    1,2,3,4: FileTGUID:= gPJG;
    5: FileTGUID:= gGIf;
    6,7,8: FileTGUID:= gTIF;
    9: FileTGUID:= gPNG;
    10: begin exit; end;
  end;
  if (tv_Indx<>-1) and (tv_Indx<>10)then begin
    sImage := TGPImage.Create(filename);
    if (angle=90) then
      sImage.RotateFlip(Rotate90FlipNone)
    else
      if (angle=270) then
        sImage.RotateFlip(Rotate270FlipNone)
      else begin
        sImage.Free;
        exit;
      end;

    image1.Picture.Bitmap.SetSize(sImage.GetWidth,sImage.GetHeight);
    with TGPGraphics.Create(image1.Canvas.Handle) do
    try
      SetInterpolationMode(InterpolationModeHighQualityBilinear);
      SetCompositingQuality(CompositingQualityHighQuality);
      DrawImage(sImage, MakeRect(0, 0, sImage.GetWidth, sImage.GetHeight), 0, 0, sImage.GetWidth, sImage.GetHeight, UnitPixel);
    finally
      Free;
    end;
    image1.Invalidate;

    sImage.Save(filename, FileTGUID,nil);
    sImage.Free;
  end;
end;

procedure TLookMenu.SavePositionandSize1Click(Sender: TObject);
begin
  MainConfF.WriteInteger('PreViewSets','Width',LookMenu.Width);
  MainConfF.WriteInteger('PreViewSets','Height',LookMenu.Height);
  MainConfF.WriteInteger('PreViewSets','Left',LookMenu.Left);
  MainConfF.WriteInteger('PreViewSets','Top',LookMenu.Top);
end;

procedure TLookMenu.ShowAndLoad(Sender: TForm; Lister: TlistBox);
begin
  LM_SLBox:=Lister;
  LoadImg(Lister.items[Lister.ItemIndex]);
  if not Visible then
  begin
    Show;
    BringToFront;
    Sender.BringToFront;
  end;
  If Lister.Visible then
    Lister.SetFocus;
end;

end.
