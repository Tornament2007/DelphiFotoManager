unit kuDrag;
{
версия 2014.03.13
kuzduk@mail.ru
kuzduk.zz.mu
}

interface

uses
  ActiveX, ComObj, ShlObj, Windows, Classes, ShellAPI, Controls;

type
  TDropEffect = (deNone, deCopy, deMove, deLink);
  TDropEffects = set of TDropEffect;

  TkuDrag = class(TComponent, IDropSource)
  
  private
    FDropEffects: TDropEffects;
//    FPointBegin: TPoint;

  public
    constructor Create(AOwner: TComponent); override;
    function DragDrop(Directory: string; AFileName: string): Integer; overload;
    function DragDrop(Directory: string; AFileList: TStrings): Integer; overload;

    {IDropSource}
    function QueryContinueDrag(fEscapePressed: BOOL; grfKeyState: Longint): HResult; stdcall;
    function GiveFeedback(dwEffect: Longint): HResult; stdcall;

  published
    property DropEffects: TDropEffects read FDropEffects write FDropEffects;
//    property PointBegin: TPoint read FPointBegin write FPointBegin;

  end;



var
  _kuDragPoint1: TPoint;
  _kuDragCan: Boolean = False;
  


procedure kuDragDo(itOwner: TComponent; Directory: string; FileList: TStrings; Shift: TShiftState; X, Y: Integer);



implementation



constructor TkuDrag.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropEffects := [deCopy];
  _kuDragCan := False;
end;

     

function TkuDrag.DragDrop(Directory: string; AFileName: string): Integer;
var AStrings: TStrings;
begin

AStrings := TStringList.Create;
try
  AStrings.Add(AFileName);
  Result := DragDrop(Directory, AStrings);
finally
  AStrings.Free;
end;

end;



function TkuDrag.DragDrop(Directory: string; AFileList: TStrings): Integer;
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

OleCheck(Root.ParseDisplayName(0, nil, PWideChar(WideString(Directory)), pchEaten, DirectoryItemIDList, dwAttributes));

try
  OleCheck(Root.BindToObject(DirectoryItemIDList, nil, IShellFolder, Folder));

  SetLength(ItemIDLists, AFileList.Count);

  for i := 0 to AFileList.Count - 1
  do OleCheck(Folder.ParseDisplayName(0, nil,
     PWideChar(WideString(AFileList[i])), pchEaten, ItemIDLists[i], dwAttributes));

  try
    OleCheck(Folder.GetUIObjectOf(0, AFileList.Count, ItemIDLists[0], IDataObject, nil, dataObj));
  finally
    for i := 0 to AFileList.Count - 1 do CoTaskMemFree(ItemIDLists[i]);
  end;

  dwOKEffects := 0;
  if deNone in FDropEffects then dwOKEffects := dwOKEffects or DROPEFFECT_NONE;
  if deCopy in FDropEffects then dwOKEffects := dwOKEffects or DROPEFFECT_COPY;
  if deMove in FDropEffects then dwOKEffects := dwOKEffects or DROPEFFECT_MOVE;
  if deLink in FDropEffects then dwOKEffects := dwOKEffects or DROPEFFECT_LINK;

  DoDragDrop(dataObj, Self, dwOKEffects, Result);
  
finally
  CoTaskMemFree(DirectoryItemIDList);
end;

end;



function TkuDrag.QueryContinueDrag(fEscapePressed: BOOL; grfKeyState: Integer): HResult;
begin

if fEscapePressed

then Result := DRAGDROP_S_CANCEL

else if grfKeyState and MK_LBUTTON = 0
     then Result := DRAGDROP_S_DROP
     else Result := S_OK;
     
end;



function TkuDrag.GiveFeedback(dwEffect: Integer): HResult;
begin
  Result := DRAGDROP_S_USEDEFAULTCURSORS;
end;






procedure kuDragDo(itOwner: TComponent; Directory: string; FileList: TStrings; Shift: TShiftState; X, Y: Integer);
var
  kuDrag1: TkuDrag;

begin

if _kuDragCan = false then exit;
if (ssLeft in Shift) = false then exit;
if (Abs(X - _kuDragPoint1.X) < 5) and (Abs(Y - _kuDragPoint1.Y) < 5) then exit;
                

//DragAcceptFiles(TWinControl(itOwner).Handle, FALSE); //Запрещаем бросок на источник

kuDrag1 := TkuDrag.Create(itOwner);
kuDrag1.DragDrop(Directory, FileList);
kuDrag1.Free;

//DragAcceptFiles(TWinControl(itOwner).Handle, TRUE);

_kuDragCan := False;



end;






initialization
  OleInitialize(nil);

finalization
  OleUninitialize;

end.

