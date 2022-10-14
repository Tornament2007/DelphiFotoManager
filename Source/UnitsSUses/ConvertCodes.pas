unit ConvertCodes;

interface

uses
  SysUtils, Graphics, JPEG;

procedure JPEGtoBMP(const FileName: TFileName; quality:Integer = 100);

implementation

procedure JPEGtoBMP(const FileName: TFileName; quality:Integer);
var
  jpeg: TJPEGImage;
  bmp:  TBitmap;
begin
  jpeg := TJPEGImage.Create;
  try
    jpeg.CompressionQuality := quality;
    jpeg.LoadFromFile(FileName);
    bmp := TBitmap.Create;
    try
      bmp.Assign(jpeg);
      bmp.SaveTofile(ChangeFileExt(FileName, '.bmp'));
    finally
      bmp.Free
    end;
  finally
    jpeg.Free
  end;
end;

end.
