unit FsP;

interface

uses
  System.SysUtils, Winapi.ShellAPI, Winapi.Windows,Vcl.StdCtrls,System.Classes,
  Winapi.Messages,Vcl.Menus, Winapi.ShlObj, Winapi.Activex, System.Win.comobj,
  ClipBrd, Forms;

  function ExtractDir(Filename: string;Skip:integer = 0): string;
  // Extract last dir name from Filename

  Function Replace1to2 (IncS:String;n1,n2:Char;SLength:Integer = 0):string; overload;
  Function Replace1to2 (IncS:String;n1:Char;n2:String):string;overload;
  Function Replace1to2 (IncS,n1:String;n2:Char):string;overload;
  Function Replace1to2 (IncS,n1,n2:String):string;overload;
  // Меняет символы в строчке, с n1 на n2 в длину SLength.

  function AnCa(S:String;Upper:Boolean = false):string;
  // lower or upper(if=1) case

  function CopyDir(const fromDir, toDir: string;DoMoveNotCopy:Boolean = false): Boolean;
  // Копировать папку вызвав инструмент Винды.

  Function DelDir1(dir: string;ShowIt:Boolean = false): Boolean;
  // Удалить папку вызвав инструмент Винды.

  Function ExtractFileOName(F_Name:String):String;
  // Получить ТОЛЬКО имя файла без .EXT

  Function GetMonThNames(Month:String;length:integer = 4):String;
  // Получить имя месяца. Month: номер месяца, length: кол-во букв.

  Function GenChars (Num,SimbolCode:Integer):String;
  // Создаёт масив длинною "Num" символов "Simbol"

  Function DelSpecChars (IncS:String;n1:Char;SLength:Integer = 0):string;
  // Удалить все символы n1, в строке IncS, по символ № SLength .

  Procedure PopOnList (x,y:integer;PoPer:TPopupMenu;lister:Tlistbox);
  // Сбросить PoPer на lister в координатах x,y + имитируя клик

  Procedure MemoFix(DestOBJ:Tmemo);
  //Удалить долбаную пустую строку....

  Function CharforPath(Key:Char):Char;
  // filter that characters that can't be used for paths and filenames

  Function E_PathEdit(Sender:TEdit;Key:Char;NoSpaces:Boolean = false):Char; //TEdit
  // Whole function for PathEditor as TEdit

  function NameFromLink(const lnk: string): string;
  //

  Procedure RecurseSearch(SDir,Sname:string; Dest:TStrings);
  //

  function BrowseFolder(title: PChar; h: hwnd): String;
  // open menu for FOLDER select

  procedure FreeMemory;
  //Free memory

  procedure RaseTo(Obj: TForm;H,W:Integer);
  // Do collaps or expand, do move!

implementation

function ExtractDir(Filename: string; Skip:integer): string;
// Extract last dir name from Filename
Var
  I,I1:Integer;
  TempPath:String;
begin
  Try
  if Filename[Length(Filename)]<>'\' then
    Filename:=Filename+'\';
  I1:=0;
  I:=Length(Filename)+1;
  Repeat
    Dec(i);
    if (Filename[I]='\')  then begin
      if (Skip=0) then Begin
        if I1=0 then
          I1:=I
        else begin
          Result:=Copy(Filename,I+1,I1-I-1);
          Exit;
        end;
      End else
        Dec(Skip);
    end;
  Until (I<=0);
  Except
    Result:='error';
  End;
end;

Function Replace1to2 (IncS:String;n1,n2:Char;SLength:Integer = 0):string;overload;
// Меняет символы в строчке, с n1 по n2 в длину SLength.
var
  I:Integer;
begin
  if SLength=0 then SLength:=Length(Incs);
  I:=0;
  repeat
    inc(i);
    if Incs[i]=n1 then Incs[i]:=n2;
  until (i=SLength);
  Replace1to2:=Incs;
end;

Function Replace1to2 (IncS:String;n1:Char;n2:String):string;overload;
// Меняет символы в строчке, с n1 по n2 в длину SLength.
var
  Ii:Integer;
begin
  repeat
    Ii:=pos(n1,incS);
    if Ii>0 then
      Incs:=Copy(Incs,1,Ii-1)+n2+Copy(Incs,Ii+1,Length(IncS)-Ii);
  until Ii=0;
  Replace1to2:=Incs;
end;

Function Replace1to2 (IncS,n1:String;n2:Char):string;overload;
// Меняет символы в строчке, с n1 по n2 в длину SLength.
var
  Ii:Integer;
begin
  repeat
    Ii:=pos(n1,incS);
    if Ii>0 then
      Incs:=Copy(Incs,1,Ii-1)+n2+Copy(Incs,Ii+Length(n1),Length(IncS)-Ii);
  until Ii=0;
  Replace1to2:=Incs;
end;

Function Replace1to2 (IncS,n1,n2:String):string;overload;
// Меняет символы в строчке, с n1 по n2 в длину SLength.
var
  Ii:Integer;
begin
  repeat
    Ii:=pos(n1,incS);
    if Ii>0 then
      Incs:=Copy(Incs,1,Ii-1)+n2+Copy(Incs,Ii+Length(n1),Length(IncS)-Ii);
  until Ii=0;
  Replace1to2:=Incs;
end;

function AnCa(S:String;Upper:Boolean = false):string;
  // lower or upper case

begin
  if Upper then
    Result:=AnsiUpperCase(S)
  else
    Result:=AnsiLowerCase(S);
end;

function CopyDir(const fromDir, toDir: string;DoMoveNotCopy:Boolean = false): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    if DoMoveNotCopy then
      wFunc  := FO_Move
    else
      wFunc  := FO_COPY;
    fFlags := FOF_FILESONLY;
    pFrom  := PChar(fromDir + #0);
    pTo    := PChar(toDir)
  end;
  Result := (0 = ShFileOperation(fos));
end;

function DelDir1(dir: string;ShowIt:Boolean = false): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_DELETE;
    if ShowIt then
      fFlags := FOF_ALLOWUNDO
    else
      fFlags := FOF_ALLOWUNDO or FOF_SILENT or FOF_NOCONFIRMATION;

    pFrom  := PChar(dir + #0);
  end;
  Result := (0 = ShFileOperation(fos));
end;

Function ExtractFileOName(F_Name:String):String;
// Получить ТОЛЬКО имя файла без .EXT
var
  F_NameSExt:String;
begin
  F_NameSExt:=ExtractFileName(F_Name);
  result:=Copy(F_NameSExt,1,length(F_NameSExt)-Length(ExtractFileExt(F_NameSExt)));
end;

Function GetMonThNames(Month:String;length:integer):String;
// Получить имя месяца. Month: номер месяца, length: кол-во букв.
begin
  Result:=FormatDateTime(GenChars(Length,Ord('m')), StrToDate('01.'+Month+'.2010'))
end;

Function GenChars (Num,SimbolCode:Integer):String;
// Создаёт масив длинною "Num" символов "Simbol"
var
  tI:Integer;
begin
    tI:=0;
  repeat
    Inc(tI);
    if SimbolCode=0 then SimbolCode:=Random(25)+65;
    Result:=Result+Char(SimbolCode);
  until tI=Num;
end;

Function DelSpecChars (IncS:String;n1:Char;SLength:Integer):string;
// Удалить все символы n1, в строке IncS, по символ № SLength .
var
  I:Integer;
begin
  if SLength=0 then SLength:=Length(Incs);
  I:=0;
  repeat
    inc(i);
    if Incs[i]=n1 then Delete(Incs,i,1);
  until (i=SLength);
  DelSpecChars:=Incs;
end;


Procedure PopOnList (x,y:integer;PoPer:TPopupMenu;lister:Tlistbox);
// Сбросить PoPer на lister в координатах x,y + имитируя клик
var
   i : Integer;
   p : TPoint;
begin
  i := lister.ItemAtPos(Point(X, Y), true);
  if (i <> -1) then
    begin
      lister.Perform(WM_LBUTTONDOWN, 0, MakeLParam(Word(X), Word(Y)));
      lister.Perform(WM_LBUTTONUP, 0, MakeLParam(Word(X), Word(Y)));
      p := lister.ClientToScreen(Point(X, Y));
      PoPer.Popup(p.X+10, p.Y);
    end;
end;

Procedure MemoFix(DestOBJ:Tmemo);
//Удалить долбаную пустую строку....
var
  s:string;
begin
  s:=DestOBJ.Text;
  s:=DelSpecChars(S,#13,0);
  //delete(s,length(s)-1,2);
  DestOBJ.Text:=s;
end;

Function CharforPath(Key:Char):Char;
// filter that characters that can't be used for paths and filenames
begin
  Result:=Key;  // '\','/','|',':','?','<','>','*','"'
  if (Key in ['/','|',':','?','<','>','*','"']) then
    Result:=#0;
  //if (Key in [' ','&']) then Result:='_';
end;

Function E_PathEdit(Sender:TEdit;Key:Char;NoSpaces:Boolean):Char; //TEdit
// Whole function for PathEditor as TEdit
var
  TT:String;
begin
  Result:=Key;
  if Sender.Text<>'' then
    TT:=Sender.Text
  else
    TT:='\';

  if (Result=#8) and (tt[Length(tt)]='\') and (length(tt)=3) then
    begin
      Result:=#0;
      Sender.Clear;
      Exit;
    end;

  if (TT[Length(TT)]='\') and (Result='\')
    then Result:=#0;

  if (Result=':') and (Length(TT)<>1)
    then Result:=#0;

  //if not (Key in ['a'..'z','A'..'Z','0'..'9','\',#8,':','_','-','.'])
  if (Result in ['/','*','?','<','>','|'])
    then Result:=#0;

  if (tt='\') and (Result in ['A','a','B','b'])
    then Result:=#0;

  if (tt='\') and (Result in ['a'..'z','A'..'Z']) then
    begin
      Sender.Text:=AnsiUpperCASE(Result)+':\';
      Result:=#0;
      Sender.SelStart:=Length(Sender.Text);
      Exit;
    end;

  if NoSpaces and (Result in [' ','&']) then
    Result:='_';
end;

function NameFromLink(const lnk: string): string;
var   //ShlObj, Activex, comobj
//Winapi.ShlObj, Winapi.Activex, System.Win.comobj
  MyObject: IUnknown;
  MySLink: IShellLink;
  MyPFile: IPersistFile;
  c: PChar;
  pfd: _WIN32_FIND_DATAW;
begin
  Result := '';
  try
    MyObject := CreateComObject(CLSID_ShellLink);
    MySLink := MyObject as IShellLink;
    MyPFile := MyObject as IPersistFile;
    if MyPFile.Load(Pointer(WideString(lnk)), OF_READ) <> S_OK then
      exit;
    c := PChar(lnk);
    MySLink.GetPath(c, MAX_PATH, pfd, 0);
    if Pos(' (x86)', string(c))>0 then
      Result := Copy(string(c), 1, Pos(' (x86)', string(c)) - 1)+Copy(string(c), Pos(' (x86)', string(c)) + Length(' (x86)'), 255)
    else
      Result := string(c);
  except
  end;
end;

Procedure RecurseSearch(SDir,Sname:string; Dest:TStrings);
var
  SR: TSearchRec;
  FindRes: Integer;
begin
  if SDir[length(SDir)]='\' then SDir:=Copy(SDir,1,length(SDir)-1);

  FindRes := FindFirst(SDir+'\*.*', faAnyFile, SR);
  while FindRes = 0 do
  begin
    if ((SR.Attr and faDirectory) = faDirectory) and ((SR.Name <> '.') and (SR.Name <> '..')) then
      RecurseSearch(SDir+'\'+SR.Name,Sname,Dest);
    if (AnCa(SR.Name) = AnCa(Sname)) then
      Dest.Add(SDir+'\'+SR.Name);
    FindRes := FindNext(SR);
  end;
end;

function BrowseFolder(title: PChar; h: hwnd): String;
var
  lpItemID: PItemIDList;
  path: array[0..Max_path] of char; //выбранная папка
  BrowseInfo: TBrowseInfo; //настройки диалога
begin
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  SHGetSpecialFolderLocation(h,csidl_desktop,BrowseInfo.pidlRoot);
  with BrowseInfo do begin
    hwndOwner := h;
    lpszTitle := title;
    //не показываем некоторые системные папки: "Корзина", "Панель управления" и т.д
    ulFlags := BIF_RETURNONLYFSDIRS or BIF_STATUSTEXT or BIF_EDITBOX  or BIF_NEWDIALOGSTYLE;
  end;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  //папка, указанная юзером, существует?
  if lpItemId <> nil then begin
    SHGetPathFromIDList(lpItemID, Path);
    result:=path;
    GlobalFreePtr(lpItemID); //освобождаем ресурсы
  end;
end;

procedure FreeMemory;
  //Free memory
Var
  MainHandle: THandle;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
      SetProcessWorkingSetSize(MainHandle, DWORD(-1), DWORD(-1));
      CloseHandle(MainHandle);
    end;
end;

procedure RaseTo(Obj: TForm;H,W:Integer);
  // Do collaps or expand, do move!
var
  H_I,W_I,x:Integer;
begin
  if H=0 then H:=Obj.Height;
  if W=0 then W:=Obj.Width;

  if (Obj.Height=H) and (Obj.Width=W) then Exit;
  X:=20;

  if (Obj.Height>H) then H_I:=-1 else H_I:=1;
  if (Obj.Width=W)  then W_I:=0;

  if (Obj.Width>W)  then W_I:=-1 else W_I:=1;
  if (Obj.Height=H) then H_I:=0;

  repeat
    IF x>1 then Sleep(X);
    Obj.Height:=Obj.Height+H_I;
    if (Obj.Width=W)  then W_I:=0;
    Obj.Width:= Obj.Width+W_I;
    if (Obj.Height=H) then H_I:=0;
    X:=X-2;
  until (Obj.Height=H) and (Obj.Width=W);
end;

end.
