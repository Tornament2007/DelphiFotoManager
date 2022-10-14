unit XPCheckTreeView;
{********************************************************}
{                                                        }
{ Delphi VCL Extensions (XP)                             }
{                                                        }
{ Компонент XPCheckTreeView - является расширением компо-}
{ нента TreeView за счет появления свойства, обеспечива- }
{ ющего создание каскадных списков, характеризующих мно- }
{ жественное выделение элементов списка (узлов дерева), а}
{ отображающего элементы CheckBox в стиле Windows XP.    }
{                                                        }
{ Copyright (c) 2008-2010, Толоконников Андрей (ViRuS)   }
{********************************************************}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, CommCtrl, Menus, ImgList;

const
  STATE_UNCHECKED = 1;
  STATE_CHECKED = 2;
  STATE_PARTCHECKED = 3;

type
  TCheckState = (csUnknown, csUnchecked, csChecked, csPartiallyChecked);

  TCheckTreeChangingEvent = procedure(Sender: TObject; Node: TTreeNode; NewState: TCheckState; var AllowChange: boolean) of object;
  TCheckTreeChangeEvent = procedure(Sender: TObject; Node: TTreeNode; NewState: TCheckState) of object;

  TCustomCheckTreeView = class(TCustomTreeView)
  private
    fBmpWidth: integer;
    fCascadeChecks: boolean;
    fChangingState: boolean;
    fCheckImages: TImageList;
    fImageWidth: integer;
    fSelectedItem: integer;
    fShowCheckImage: boolean;
    fSilentStateChanges: boolean;
    fSuspendCascades: boolean;
    fOnStateChanging: TCheckTreeChangingEvent;
    fOnStateChange: TCheckTreeChangeEvent;
    fOnUpdateChildren: TNotifyEvent; 
    procedure WMChar(var Msg: TWMChar); message wm_Char;
    procedure WMPaint(var Msg: TWMPaint); message wm_Paint;
  protected
    procedure InitStateImages; virtual;

    function GetImages: TCustomImageList;
    function GetItemState(AbsoluteIndex: integer): TCheckState;
    function CanChangeState(Node: TTreeNode; newValue: TCheckState): boolean; dynamic;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure RecurseChildren(Node: TTreeNode; newValue: boolean);
    procedure SetAllChildren(Node: TTreeNode; newValue: TCheckState);
    procedure StateChange(Node: TTreeNode; newValue: TCheckState); dynamic;
    procedure SetImages(newValue: TCustomImageList);
    procedure SetItemState(AbsoluteIndex: integer; newValue: TCheckState);
    procedure SetNodeCheckState(Node: TTreeNode; newValue: TCheckState);
    procedure SetShowCheckImage(newValue: boolean);
    procedure UpdateChildren(Node: TTreeNode; newValue: boolean); virtual;
    procedure UpdateImageWidth; virtual;
    procedure UpdateParents(Node: TTreeNode; newValue: boolean); virtual;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure ChangeNodeCheckState(Node: TTreeNode; newValue: TCheckState);
    procedure ForceCheckState(Node: TTreeNode; newValue: TCheckState);
    property ItemState[Index: integer]: TCheckState read GetItemState write SetItemState;
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);
    procedure SetAllNodes(newValue: TCheckState);
    property SilentCheckChanges: boolean read fSilentStateChanges write fSilentStateChanges;
    procedure ToggleCheckState(Node: TTreeNode );
    procedure UpdateCascadingStates(Node: TTreeNode);
    procedure UpdateChildrenCascadingStates(ParentNode: TTreeNode);
  published 
    property Align;
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property CascadeChecks: boolean read fCascadeChecks write fCascadeChecks default true;
    property ChangeDelay;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HotTrack;
    property Images: TCustomImageList read GetImages write SetImages;
    property Indent;
    property Items;
    property MultiSelect;
    property MultiSelectStyle;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly default True;
    property RightClickSelect;
    property RowSelect;
    property ShowButtons;
    property ShowCheckImage: boolean read fShowCheckImage write SetShowCheckImage default true;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnAddition;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnCompare;
    property OnContextPopup;
    property OnCreateNodeClass;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanded;
    property OnExpanding;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
    property OnStateChanging: TCheckTreeChangingEvent read fOnStateChanging write fOnStateChanging;
    property OnStateChange: TCheckTreeChangeEvent read fOnStateChange write fOnStateChange;
    property OnUpdateChildren: TNotifyEvent read fOnUpdateChildren write fOnUpdateChildren;
  end;

  TXPCheckTreeView = class(TCustomCheckTreeView)
  published   
    property Align;
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property CascadeChecks;
    property ChangeDelay;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HotTrack;
    property Images;
    property Indent;
    property Items;
    property MultiSelect;
    property MultiSelectStyle;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RightClickSelect;
    property RowSelect;
    property ShowButtons;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property ShowCheckImage;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnAddition;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnCompare;
    property OnContextPopup;
    property OnCreateNodeClass;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanded;
    property OnExpanding;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
    property OnStateChanging;
    property OnStateChange;
    property OnUpdateChildren;
  end;

procedure Register;

implementation

{$R *.res}

uses
  TypInfo, ComStrs;

procedure TreeViewError(const Msg: string);
begin
  raise ETreeViewError.Create(Msg)
end;

procedure TreeViewErrorFmt(const Msg: string; Format: array of const);
begin
  raise ETreeViewError.CreateFmt(Msg, Format)
end;


type
  TCheckTreeStrings = class(TStrings)
  private
    fOwner: TTreeNodes;
  protected
    function Get(Index: integer ): string; override;
    function GetBufStart(Buffer: pChar; var Level: integer): pChar;
    function GetCount: integer; override;
    function GetObject(Index: integer): TObject; override;
    procedure PutObject(Index: integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: boolean); override;
  public
    constructor Create(AOwner: TTreeNodes);
    function Add(const S: string): integer; override;
    procedure Clear; override;
    procedure Delete(Index: integer); override;
    procedure Insert(Index: integer; const S: string); override;
    procedure LoadTreeFromStream(Stream: TStream);
    procedure SaveTreeToStream(Stream: TStream);
    property Owner: TTreeNodes read fOwner;
  end;

constructor TCheckTreeStrings.Create(AOwner: TTreeNodes);
begin
  inherited Create;
  fOwner:=AOwner
end;

function TCheckTreeStrings.Get(Index: integer): string;
const
  TabChar = #9;
var
  Level, i: integer;
  Node: TTreeNode;
begin
  result:='';
  Node:=Owner.Item[Index];
  Level:=Node.Level;
  for i:=0 to (Level - 1) do
    result:=result + TabChar;
  result:=result + Node.Text
end;

function TCheckTreeStrings.GetBufStart(Buffer: pChar; var Level: integer): pChar;
begin
  Level:=0;
  while Buffer^ in [' ', #9] do
    begin
      inc(Buffer);
      inc(Level)
    end;
  result:=Buffer
end;

function TCheckTreeStrings.GetObject(Index: integer): TObject;
begin
  result:=Owner.Item[Index].Data
end;

procedure TCheckTreeStrings.PutObject(Index: integer; AObject: TObject);
begin
  Owner.Item[Index].Data:=AObject
end;

function TCheckTreeStrings.GetCount: integer;
begin
  result:=Owner.Count
end;

procedure TCheckTreeStrings.Clear;
begin
  Owner.Clear
end;

procedure TCheckTreeStrings.Delete(Index: integer);
begin
  Owner.Item[Index].Delete
end;

procedure TCheckTreeStrings.SetUpdateState(Updating: boolean);
begin
  SendMessage(Owner.Handle, WM_SETREDRAW, ord(not Updating), 0);
  if not Updating then
    Owner.Owner.Refresh
end;

function TCheckTreeStrings.Add(const S: string): integer;
var
  Level, oldLevel, i: integer;
  newStr: string;
  Node: TTreeNode;
begin
  result:=GetCount;
  if (length(S) = 1) and (S[1] = chr($1A)) then exit;
  Node:=nil; oldLevel:=0;
  newStr:=GetBufStart(pChar(S), Level);
  if result > 0 then
    begin
      Node:=Owner.Item[result - 1];
      oldLevel:=Node.Level
    end;
  if (Level > oldLevel) or (Node = nil) then
    begin
      if (Level - oldLevel) > 1 then
        TreeViewError(sInvalidLevel)
    end
  else
    begin
      for i:=oldLevel downto Level do
        begin
          Node:=Node.Parent;
          if (Node = nil) and (i - Level > 0) then
            TreeViewError( sInvalidLevel)
        end
    end;
  Owner.AddChild(Node, newStr)
end;

procedure TCheckTreeStrings.Insert(Index: integer; const S: string);
begin
  Owner.Insert(Owner.Item[Index], S)
end;

procedure TCheckTreeStrings.LoadTreeFromStream(Stream: TStream);
var
  List: TStringList;
  ANode, nextNode: TTreeNode;
  ALevel, i, nodeState: integer;
  currStr: string;
begin
  List:=TStringList.Create;
  Owner.BeginUpdate;
  try
    try
      Clear; List.LoadFromStream(Stream);
      ANode:=nil;
      for i:=0 to (List.Count - 1) do
      begin
        currStr:=GetBufStart(pChar(List[i]), ALevel);
        nodeState:=strtoint(currStr[1]);
        system.Delete(CurrStr, 1, 1);
        if ANode = nil then
          ANode:=Owner.AddChild(nil, currStr)
        else
          if ANode.Level = ALevel then
            ANode:=Owner.AddChild(ANode.Parent, CurrStr)
          else
            if ANode.Level = (ALevel - 1) then
              ANode:=Owner.AddChild(ANode, currStr)
            else
              if ANode.Level > ALevel then
                begin
                  nextNode:=ANode.Parent;
                  while nextNode.Level > ALevel do
                    nextNode:=nextNode.Parent;
                  ANode:=Owner.AddChild(nextNode.Parent, currStr)
                end
              else
                TreeViewErrorFmt(sInvalidLevelEx, [ALevel, currStr]);
        if ANode <> nil then
          ANode.StateIndex:=nodeState
      end
    finally
      Owner.EndUpdate;
      List.Free
    end
  except
    Owner.Owner.Invalidate;
    raise
  end
end;

procedure TCheckTreeStrings.SaveTreeToStream(Stream: TStream);
const
  TabChar = #9;
  EndOfLine = #13#10;
var
  i: integer;
  ANode: TTreeNode;
  nodeState, nodeStr: string;
begin
  if Count > 0 then
    begin
      ANode:=Owner[0];
      while ANode <> nil do
        begin
          nodeStr:='';
          for i:=0 to ANode.Level - 1 do
            nodeStr:=nodeStr + TabChar;
          nodeState:=inttostr(ANode.StateIndex);
          nodeStr:=nodeStr + nodeState + ANode.Text + EndOfLine;
          Stream.Write(pointer(nodeStr)^, length(nodeStr));
          ANode:=ANode.GetNext
        end
    end
end;

constructor TCustomCheckTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fCheckImages:=TImageList.Create(self);
  fCheckImages.Name:='CheckImages';
  StateImages:=fCheckImages;
  InitStateImages;
  fBmpWidth:=fCheckImages.Width;
  ReadOnly:=true;
  fSuspendCascades:=false;
  fCascadeChecks:=true;
  fSilentStateChanges:=false;
  fShowCheckImage:=true
end;

procedure TCustomCheckTreeView.InitStateImages;
const
  baseColors: array[0..6] of TColor = (clWhite, clGray, clRed, clFuchsia, clBlue, clTeal, clOlive);
  resNames: array[TCheckBoxState] of pChar = ('CHECKBOX_UNCHECKED', 'CHECKBOX_CHECKED', 'CHECKBOX_GRAYED');

var
  R: TRect;
  replaceColors: array[0..6] of TColor;
  ChkBmp, ImgBmp: TBitmap;

  function CheckColor(Value: TColor): TColor;
  begin
    if (ColorToRGB(Value) = ColorToRGB(clOlive)) or
       (ColorToRGB(Value) = ColorToRGB(clGray)) then
      result:=ColorToRGB(Value) + 1
    else
      result:=Value
  end;


begin
  ChkBmp:=TBitmap.Create;
  try
    ChkBmp.Width:=16;
    ChkBmp.Height:=16;
    R:=Rect(0, 0, 16, 16);
    replaceColors[0]:=clWindow;
    replaceColors[1]:=clsilver;
    replaceColors[2]:=clWindow;
    replaceColors[3]:=clWindow;
    replaceColors[4]:=CheckColor(clHighlight);
    ImgBmp:=TBitmap.Create;
    try
      ImgBmp.Width:=16; ImgBmp.Height:=16;
      ImgBmp.Canvas.Brush.Color:=clOlive;
      ImgBmp.Canvas.FillRect(R);
      ChkBmp.Handle:=CreateMappedRes(HInstance, resNames[cbUnchecked], baseColors, replaceColors);
      ImgBmp.Canvas.Draw(2, 2, ChkBmp);
      fCheckImages.AddMasked(ImgBmp, clOlive);
      ChkBmp.Handle:=CreateMappedRes(HInstance, resNames[cbUnchecked], baseColors, replaceColors);
      ImgBmp.Canvas.Draw(2, 2, ChkBmp);
      fCheckImages.AddMasked( ImgBmp, clOlive );
      ChkBmp.Handle := CreateMappedRes(HInstance, resNames[cbChecked], baseColors, replaceColors);
      ImgBmp.Canvas.Draw(2, 2, ChkBmp);
      fCheckImages.AddMasked( ImgBmp, clOlive );
      ChkBmp.Handle:=CreateMappedRes(HInstance, resNames[cbGrayed], baseColors, replaceColors);
      ImgBmp.Canvas.Draw(2, 2, ChkBmp);
      fCheckImages.AddMasked(ImgBmp, clOlive)
    finally
      ImgBmp.Free
    end
  finally
    ChkBmp.Free
  end
end;

destructor TCustomCheckTreeView.Destroy;
begin
  fCheckImages.Free;
  inherited Destroy
end;

procedure TCustomCheckTreeView.Loaded;
begin
  inherited Loaded;
  UpdateImageWidth
end;

procedure TCustomCheckTreeView.UpdateImageWidth;
begin
  if Images = nil then
    fImageWidth:=0
  else
    fImageWidth:=Images.Width
end;

procedure TCustomCheckTreeView.WMPaint(var Msg: TWMPaint);
var
  i: integer;
begin
  for i:=0 to (Items.Count - 1) do
  begin
    if (Items[i].StateIndex = -1) and fShowCheckImage then
      Items[i].StateIndex:=Ord(csUnchecked)
  end;
  inherited;
end;

procedure TCustomCheckTreeView.SetShowCheckImage(newValue: boolean);
var
  i: integer;
begin
  if newValue <> fShowCheckImage then
    begin
      fShowCheckImage:=newValue;
      if not fShowCheckImage then
        for i:=0 to (Items.Count - 1) do
          Items[i].StateIndex:=-1
    end
end;

function TCustomCheckTreeView.GetItemState(AbsoluteIndex: integer): TCheckState;
begin
  result:=TCheckState(Items[AbsoluteIndex].StateIndex);
end;

procedure TCustomCheckTreeView.SetItemState(AbsoluteIndex: integer; newValue: TCheckState);
begin
  if TCheckState(Items[AbsoluteIndex].StateIndex) <> newValue then
    ChangeNodeCheckState(Items[AbsoluteIndex], newValue)
end;

procedure TCustomCheckTreeView.SetNodeCheckState(Node: TTreeNode; newValue: TCheckState);
begin
  if CanChangeState(Node, newValue) then
  begin
    Node.StateIndex:=ord(newValue);
    if not fSilentStateChanges then
      StateChange(Node, newValue)
  end;
end;

function TCustomCheckTreeView.CanChangeState(Node: TTreeNode; newValue: TCheckState): boolean;
begin
  result:=true;
  if not fSilentStateChanges and Assigned(fOnStateChanging) then
    fOnStateChanging(self, Node, newValue, result)
end;

procedure TCustomCheckTreeView.StateChange(Node: TTreeNode; newValue: TCheckState);
begin
  if Assigned(fOnStateChange) then
    fOnStateChange(self, Node, newValue)
end;

procedure TCustomCheckTreeView.ForceCheckState(Node: TTreeNode; newValue: TCheckState);
begin
  if Node.StateIndex <> ord(newValue) then
    begin
      Node.StateIndex:=ord(newValue);
      if not fSilentStateChanges then
        StateChange(Node, newValue)
    end
end;

procedure TCustomCheckTreeView.ToggleCheckState(Node: TTreeNode);
begin
  if fShowCheckImage then
    begin
      fChangingState:=false;
      if Node.StateIndex = 0 then exit;
      if Node.StateIndex = STATE_CHECKED then
        SetNodeCheckState(Node, csUnchecked)
      else
        SetNodeCheckState(Node, csChecked);
      if fCascadeChecks then
        begin
          UpdateChildren(Node, Node.StateIndex = STATE_CHECKED);
          UpdateParents(Node, Node.StateIndex = STATE_CHECKED)
        end
    end
end;

procedure TCustomCheckTreeView.UpdateCascadingStates(Node: TTreeNode);
begin
  if fCascadeChecks then
    begin
      if (Node.StateIndex = STATE_CHECKED) or (Node.StateIndex = STATE_UNCHECKED) then
        begin
          UpdateChildren(Node, Node.StateIndex = STATE_CHECKED);
          UpdateParents(Node, Node.StateIndex = STATE_CHECKED)
        end
    end
end;

procedure TCustomCheckTreeView.UpdateChildrenCascadingStates(ParentNode: TTreeNode);
var
  Node: TTreeNode;
begin
  if (ParentNode = nil) or not fCascadeChecks then exit;
  Node:=ParentNode.GetFirstChild;
  if Node = nil then
    UpdateCascadingStates(ParentNode)
  else
    begin
      while Node <> nil do
        begin
          if Node.HasChildren then
            UpdateChildrenCascadingStates(Node)
          else
            UpdateCascadingStates(Node);
          Node:=Node.GetNextSibling
        end
    end
end;

procedure TCustomCheckTreeView.ChangeNodeCheckState(Node: TTreeNode; newValue: TCheckState);
begin
  fChangingState:=false;
  if Node.StateIndex <> ord(newValue) then
    SetNodeCheckState(Node, newValue);
  if fCascadeChecks then
    begin
      UpdateChildren(Node, Node.StateIndex = STATE_CHECKED);
      UpdateParents(Node, Node.StateIndex = STATE_CHECKED)
    end
end;

procedure TCustomCheckTreeView.UpdateParents(Node: TTreeNode; newValue: boolean);
var
  checkedCount, unCheckedCount, newState: integer;
begin
  newState:=STATE_UNCHECKED;
  while (Node <> nil) and (Node.Parent <> nil) do
    begin
      Node:=Node.Parent.GetFirstChild;
      CheckedCount:=0; UnCheckedCount:=0;
      while true do
        begin
          inc(unCheckedCount, ord(Node.StateIndex = STATE_UNCHECKED));
          inc(checkedCount, ord(Node.StateIndex = STATE_CHECKED));
          if (Node.StateIndex = STATE_PARTCHECKED) or
             ((checkedCount > 0) and (unCheckedCount > 0)) then
            begin
              newState:=STATE_PARTCHECKED;
              break
            end;
          if Node.GetNextSibling = nil then
            begin
              if CheckedCount > 0 then
                newState:=STATE_CHECKED
              else
                newState:=STATE_UNCHECKED;
              break
            end
          else
            Node:=Node.GetNextSibling
        end;
      Node:=Node.Parent;
      if Node <> nil then
        SetNodeCheckState(Node, TCheckState(NewState))
    end
end;

procedure TCustomCheckTreeView.RecurseChildren(Node: TTreeNode; newValue: boolean);
begin
  while Node <> nil do
    begin
      if newValue then
        SetNodeCheckState(Node, csChecked)
      else
        SetNodeCheckState(Node, csUnchecked);
      if Node.GetFirstChild <> nil then
        RecurseChildren(Node.GetFirstChild, newValue);
      Node:=Node.GetNextSibling
    end
end;

procedure TCustomCheckTreeView.UpdateChildren(Node: TTreeNode; newValue: boolean);
var
  wasSuspended: boolean;
begin
  wasSuspended:=fSuspendCascades;
  fSuspendCascades:=true;
  RecurseChildren(Node.GetFirstChild, newValue);
  fSuspendCascades:=wasSuspended;
  if Assigned(fOnUpdateChildren) then
    fOnUpdateChildren(self)
end;

procedure TCustomCheckTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  R: TRect;
  Idx: integer;
begin
  if Selected <> nil then
    begin
      if Selected.AbsoluteIndex > -1 then
        begin
          Idx:=Selected.AbsoluteIndex;
          R:=Selected.DisplayRect(true);
          if (Button = mbLeft) and (X <= (R.Left - fImageWidth)) and
             (X > (R.Left - fBmpWidth - fImageWidth)) and
             (Y >= R.Top) and (Y <= R.Bottom) then
            begin
              fChangingState:=true;
              fSelectedItem:=Idx
            end
        end
    end;
  inherited MouseDown(Button, Shift, X, Y)
end;

procedure TCustomCheckTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if (Button = mbLeft) and fChangingState and (Selected.AbsoluteIndex = fSelectedItem) and
     PtInRect(ClientRect, Point(X, Y)) then
    ToggleCheckState(Selected);
  inherited MouseUp(Button, Shift, X, Y)
end;

procedure TCustomCheckTreeView.KeyUp(var Key: word; Shift: TShiftState);
begin
  if (Key = vk_Space) and not IsEditing then
    ToggleCheckState(Selected);
  inherited KeyUp(Key, Shift)
end;

procedure TCustomCheckTreeView.WMChar(var Msg: TWMChar);
begin
  if Msg.CharCode <> vk_Space then
    inherited
end;

procedure TCustomCheckTreeView.SetAllChildren(Node: TTreeNode; newValue: TCheckState);
begin
  while Node <> nil do
    begin
      Node.StateIndex:=ord(newValue);
      if Node.GetFirstChild <> nil then
        SetAllChildren(Node.GetFirstChild, newValue);
      Node:=Node.GetNextSibling
    end
end;

procedure TCustomCheckTreeView.SetAllNodes(newValue: TCheckState);
begin
  SetAllChildren(Items[0], newValue)
end;

function TCustomCheckTreeView.GetImages: TCustomImageList;
begin
  result:=inherited Images
end;

procedure TCustomCheckTreeView.SetImages(newValue: TCustomImageList);
begin
  inherited Images:=newValue;
  UpdateImageWidth
end;
         
procedure TCustomCheckTreeView.LoadFromFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream:=TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream)
  finally
    Stream.Free
  end
end;

procedure TCustomCheckTreeView.LoadFromStream(Stream: TStream);
var
  S: TCheckTreeStrings;
begin
  S:=TCheckTreeStrings.Create(Items);
  try
    S.LoadTreeFromStream(Stream)
  finally
    S.Free
  end;
end;

procedure TCustomCheckTreeView.SaveToFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream:=TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream)
  finally
    Stream.Free
  end
end;

procedure TCustomCheckTreeView.SaveToStream(Stream: TStream);
var
  S: TCheckTreeStrings;
begin
  S:=TCheckTreeStrings.Create(Items);
  try
    S.SaveTreeToStream(Stream)
  finally
    S.Free
  end;
end;

procedure Register;
begin
  RegisterComponents('XP Components',[TXPCheckTreeView])
end;

end.
