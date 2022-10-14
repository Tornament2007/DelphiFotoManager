unit DropFileClass;

// procedure FromDropFiles(Sender: TObject);

{ модуль драг и дроп Файлов из проводника и в проводник Windows
 протестирован Delphi 7, XE
 Исходники
 http://www.webundmobile.de/content/download/7387/137496/file/Listings.zip
 http://www.delphisources.ru/forum/showthread.php?t=21869

 Repack by Alex_pac Тольятти 2012
 http://jqbook.narod.ru/delphi/DropFile.htm

 Версия 2.0

Свойства:
DropEffects: TDropEffects - определяет какие операции доступны: копирование, ссылка, перемещение
Методы:
function DropOut(Directory: String; AFileName: String): Integer; overload;
function DropOut(Directory: String; AFileList: TStrings): Integer; overload;
function DropOut(AFileList: TStrings): Integer; overload;
function DropOut(AFileName: String): Integer; overload;
Первый работает с одним файлом, второй со списком.
Третий работает со списком абсолютных путей
Червертый работает с одним абсолютным адресом файла
Directory указывает на каталог в котором находятся файлы. AFileName и AFileList содержат имена файлов.
Возвращаемое значение:
Результат операции:
0 - отменено пользователем (нажал Esc) = DROPEFFECT_NONE
1 - файл скопирован = DROPEFFECT_COPY
2 - файл перемещен. Если поддерживает источник, то исходный файл будет удален = DROPEFFECT_MOVE
4 - создана ссылка на файл = DROPEFFECT_LINK
}

interface

uses
  Windows, Messages, Classes, SysUtils, AppEvnts,
  Controls, ShellAPI, FileCtrl, ActiveX, ComObj, ShlObj;
type
  TDropEffect = (deNone, deCopy, deMove, deLink);

  TDropFile = class(TApplicationEvents, IDropSource)
    protected
      procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean); virtual;
      { IDropSource }
      function QueryContinueDrag(fEscapePressed: BOOL; grfKeyState: Longint): HResult; stdcall;
      function GiveFeedback(dwEffect: Longint): HResult; stdcall;
    public
      DropEffect: TDropEffect;
      Files: TStringList;
      OnDropFiles : TNotifyEvent;
      function DropOut(Directory: String; AFileName: String): Integer; overload;
      function DropOut(Directory: String; AFileList: TStrings): Integer; overload;
      function DropOut(AFileList: TStrings): Integer; overload;
      function DropOut(AFileName: String): Integer; overload;
      // методы для анализа
      function MouseMoveDrop(Sender: TObject; Shift: TShiftState; X, Y: Integer; offset: integer = 0):boolean;
      // конструктор
      constructor Create(AOwner: TWinControl);
      destructor Destroy; override;
  end;

// procedure DropFileEvent(Sender: TObject);

implementation

{ TDropFile }

procedure TDropFile.ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
var nCount, nFile : UINT;
    sFileNm : string;
    dwChars : DWORD;
const QUERY_FILES_COUNT = UINT($FFFFFFFF);
begin
  if (Msg.message=WM_DROPFILES) and (Msg.hwnd = TWinControl(self.Owner).Handle) then begin
    if @self.OnDropFiles=nil then begin
      // защита от выполнения
      Handled:=true;
      exit;
    end;
    // Событие поймано.
    // отключаем пост обработку
    Handled:=true;
    // обрабатываем событие
    nCount := DragQueryFile( Msg.wParam, QUERY_FILES_COUNT, nil, 0);
    if nCount = 0 then Exit;
    // чистим лист
     Files.Clear;
    try
      for nFile := 0 to nCount-1 do begin
        // GrцЯe des Buffers bestimmen
        dwChars := DragQueryFile( Msg.wParam, nFile, nil,0);
        Inc( dwChars);  // Platz fьr Arnold
        SetLength( sFileNm, dwChars);
        // Dateinamen abrufen
        dwChars := DragQueryFile( Msg.wParam, nFile, PChar(sFileNm), dwChars);
        if dwChars > 0 then begin
          SetLength( sFileNm, dwChars);  // Arnold entsorgen
          Files.Add(sFileNm);
        end;
    end;
    // an der Abwurfstelle im Fenster eine anklickbare Markierung setzen
    finally
      if @self.OnDropFiles<>nil then OnDropFiles(self);
    end;
  end;  // end IF
end;

constructor TDropFile.Create(AOwner: TWinControl);
begin
  TApplicationEvents(self).Create(AOwner);
  self.OnMessage:=self.ApplicationEventsMessage;
  Files:=TStringList.Create;
  DropEffect:=deCopy;
  DragAcceptFiles(TWinControl(Owner).Handle, TRUE);
end;

destructor TDropFile.Destroy;
begin
  Files.free;
  if Assigned(Owner) then DragAcceptFiles(TWinControl(Owner).Handle, FALSE);
  inherited;
end;

function TDropFile.DropOut(AFileList: TStrings): Integer;
var s1:string; i:integer;
begin
  if AFileList.Count=0 then exit;
  Files.Clear;
  s1:=ExtractFilePath(AFileList[0]);
  i:=0;
  repeat
    if (s1<>ExtractFilePath(AFileList[i])) then break;
    Files.Add(ExtractFileName(AFileList[i]));
    inc(i);
  until (i=AFileList.Count);
  DropOut(s1,Files);
  Files.Clear;
end;

// базовый обработчик
function TDropFile.DropOut(Directory: String; AFileList: TStrings): Integer;
var
  dataObj: IDataObject;
  Root: IShellFolder;
  pchEaten: ULONG;
  DirectoryItemIDList: PItemIDList;
  dwAttributes: ULONG;
  Folder: IShellFolder;
  i: Integer;
  ItemIDLists: array of PItemIDList;
  dwOKEffects: Longint;
begin
  OleCheck(SHGetDesktopFolder(Root));

  OleCheck(Root.ParseDisplayName(0, nil, PWideChar(WideString(Directory)),
    pchEaten, DirectoryItemIDList, dwAttributes));

  try
    OleCheck(Root.BindToObject(DirectoryItemIDList, nil, IShellFolder, Folder));

    SetLength(ItemIDLists, AFileList.Count);

    for i:=0 to AFileList.Count-1 do OleCheck(Folder.ParseDisplayName(0, nil,
      PWideChar(WideString(AFileList[i])),
      pchEaten, ItemIDLists[i], dwAttributes));

    try
      OleCheck(Folder.GetUIObjectOf(0, AFileList.Count, ItemIDLists[0],
        IDataObject, nil, dataObj));
    finally
      for i:=0 to AFileList.Count-1 do CoTaskMemFree(ItemIDLists[i]);
    end;

    dwOKEffects:=0;
    if deNone = DropEffect then dwOKEffects:=dwOKEffects or DROPEFFECT_NONE;
    if deCopy = DropEffect then dwOKEffects:=dwOKEffects or DROPEFFECT_COPY;
    if deMove = DropEffect then dwOKEffects:=dwOKEffects or DROPEFFECT_MOVE;
    if deLink = DropEffect then dwOKEffects:=dwOKEffects or DROPEFFECT_LINK;

    DoDragDrop(dataObj, Self, dwOKEffects, Result);
  finally
    CoTaskMemFree(DirectoryItemIDList);
  end;
end;

function TDropFile.DropOut(Directory, AFileName: String): Integer;
begin
  Files.Clear;
  try
    Files.Add(AFileName);
    Result:=DropOut(Directory, Files);
  finally
    Files.Clear;
  end;
end;

function TDropFile.DropOut(AFileName: String): Integer;
begin
  Files.Clear;
  try
    Files.Add(ExtractFileName(AFileName));
    Result:=DropOut(ExtractFilePath(AFileName), Files);
  finally
    Files.Clear;
  end;
end;

function TDropFile.GiveFeedback(dwEffect: Integer): HResult;
begin
  Result:=DRAGDROP_S_USEDEFAULTCURSORS;
end;

function TDropFile.MouseMoveDrop(Sender: TObject; Shift: TShiftState; X, Y, offset: Integer): boolean;
begin
  result:=false;
  if not (Sender is TControl) then exit;
  if (ssLeft in Shift) and
  ((x<=offset)or(x>=TControl(Sender).Width-5-offset) or
  (y<=offset)or(y>=TControl(Sender).Height-5-offset)) then result:=true;
end;

function TDropFile.QueryContinueDrag(fEscapePressed: BOOL;
  grfKeyState: Integer): HResult;
begin
  if fEscapePressed then Result:=DRAGDROP_S_CANCEL
  else if (grfKeyState and MK_LBUTTON)=0 then Result:=DRAGDROP_S_DROP
  else Result:=S_OK;
end;

initialization
  OleInitialize(nil);

finalization
  OleUninitialize;


end.
