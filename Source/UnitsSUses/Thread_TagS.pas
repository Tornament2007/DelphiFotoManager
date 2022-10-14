unit Thread_TagS;

interface

uses
  FsP,
  System.Classes,SysUtils,Graphics,ExtCtrls;

  procedure TStartTL(Preor:TThreadPriority = TThreadPriority(3));
  procedure TStopTL;

type
  TTagScaner = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  SFTag: TTagScaner;

implementation

procedure TTagScaner.Execute;
var
  I,LCount:integer;
  path: string;

  TempL,TempL2:Tstrings;
  //delta
  Dtime:TTime;
begin
  Dtime:=Time;
  TempL:=TStringList.Create;

  with TagSearch do begin
  UpdateStatus(TS_LangWL.Items[0]+'...');
  // Формируем список папок для поиска
  for I := 0 to Treeview1.items.Count-1 do
  begin
    if (SFTag.Terminated) then begin
      TempL.Free;
      exit;///
    end;
    TN := Treeview1.Items.Item[I];
    if TN.StateIndex > 1  then
    begin
      path := '';
      Node:=TN;
      repeat
        if (SFTag.Terminated) then begin
          TempL.Free;
          exit;///
        end;
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
    if (SFTag.Terminated) then begin
      TempL.Free;
      exit;///
    end;
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
    if (SFTag.Terminated) then begin
      TempL.Free;
      TempL2.Free;
      exit;///
    end;
    RecurseSearch(TreeView1.Hint+TempL[I],'ImagesAttributes.INI',TempL2);
    inc(I);
  until LCount=I;
  TempL.Free;
  // Сканим файлы на наличие нужной нам информации
  UpdateStatus(TS_LangWL.Items[2]+'...');

  ListBox1.Clear;
  LCount:=TempL2.Count;
  for I := 0 to LCount-1 do begin
    if (SFTag.Terminated) then begin
      TempL2.Free;
      exit;///
    end;
    UpdateStatus(TS_LangWL.Items[4]+': '+IntToStr(I+1)+'/'+IntToStr(LCount));
    ScanForMAttr(TempL2[I],FindItE.Text,4,ListBox1);
  end;
  TempL2.Free;
  //MAinForm.ListBox1.Repaint;
  //MAinForm.Show;
  //Выводим информацию
  Panel1.Caption:=MainForm.LangWL.Items[33]+' '+IntToStr(ListBox1.Count);

  DTime:=DTime-Time;
  Panel2.Caption:=FormatDateTime('hh:mm:ss.zz',DTime);
  UpdateStatus(TS_LangWL.Items[3]+' - '+Panel2.Caption);
  end;
  //;

  FreeAndNil(SFTag);
end;

procedure TStartTL(Preor:TThreadPriority);
begin
  if Assigned(SFTag) then
    exit;
  SFTag:=TTagScaner.Create(true);
  SFTag.Priority:=Preor;
  SFTag.Resume;
end;

procedure TStopTL;
begin
  if Assigned(SFTag) then begin
    FreeAndNil(SFTag);
  end;
end;

end.
