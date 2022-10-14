unit Thread_ImLo;

interface

uses
  System.Classes,SysUtils,Graphics,ExtCtrls;

  procedure TStartTL(Preor:TThreadPriority = TThreadPriority(3));
  procedure TStopTL;

type
  TImageLoaderT = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  LSDImg: TImageLoaderT;

implementation
uses MainCode,LookMenuCode,ConfCode;

procedure TImageLoaderT.Execute;
Var
  TH_W,TH_H,i:integer;
  IWidth,IHeight:Word;
  FileN:String;
  Bim:TBitmap;
  img:TImage;
begin
  //FreeAndNil(LSDImg);
  //exit;
  TH_W := ConfForm.TrackBar1.Position; //80
  TH_H := ConfForm.TrackBar1.Position;
  I:=0;
  Repeat
    Sleep(1000);

      With MainForm.ScrollBox1 do
        Img:= FindComponent('PrevI'+IntTOStr(I)) as TImage;
      if img<>nil then
        ConfForm.ConfLog.Lines.Add(Img.name+' Name')
      else
        ConfForm.ConfLog.Lines.Add('PrevI'+IntTOStr(I)+' NF');

    Inc(I);
    if I>MainForm.ListBox1.Items.Count then
      I:=0;
  Until (LSDImg.Terminated);
  ConfForm.ConfLog.Lines.Add('Kill me');
  FreeAndNil(LSDImg);
  exit;
  /////
  ///
  Bim:=Tbitmap.Create;
  Repeat
    While MainForm.ScrollBox1.ComponentCount<1 do
      sleep(100);
    I:=0;
    With MainForm.ScrollBox1 do
    repeat
    try
      Img:= FindComponent('PrevI'+IntTOStr(i)) as TImage;
      if Img=nil then break;
      FileN:=Img.Hint;
      if (img.Tag=0) and FileExists(FileN) then
      begin
        LookMenu.GetResJpg(FileN, IWidth, IHeight);
        LookMenu.ExtractThumb(TH_W,TH_H,FileN,IWidth,IHeight,Bim);
        IF IMG.Picture.Bitmap<>nil then
        Begin
          if Img=nil then break;
          Img.Picture.Bitmap.Assign(Bim);
          Img.Tag:=1;
          Synchronize(Img.Repaint);
        End;
      end
      else
        Sleep(100);
    except
      Sleep(100);
    end;
      Inc(I);
    until I>=MainForm.ListBox1.Items.Count;
    Sleep(100);
  Until (LSDImg.Terminated);

  Bim.Free;
  FreeAndNil(LSDImg);
end;

procedure TStartTL(Preor:TThreadPriority);
begin
  if Assigned(LSDImg) then
    exit;
  LSDImg:=TImageLoaderT.Create(true);
  LSDImg.Priority:=Preor;
  LSDImg.Resume;
end;

procedure TStopTL;
begin
  if Assigned(LSDImg) then
  begin
    MainForm.ScrollBox1.Tag:=1;
    FreeAndNil(LSDImg);
  end;
end;

end.
