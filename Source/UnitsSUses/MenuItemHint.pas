unit MenuItemHint;

interface

uses
  Windows, Classes, Controls, Forms,  Menus, ExtCtrls;

type
  TMenuItemHint = class(THintWindow)
  private
    activeMenuItem : TMenuItem;
    showTimer : TTimer;
    hideTimer : TTimer;
    procedure HideTime(Sender : TObject);
    procedure ShowTime(Sender : TObject);
  public
    constructor Create(AOwner : TComponent); override;
    procedure DoActivateHint(menuItem : TMenuItem);
    destructor Destroy; override;
  end;

implementation

{ TMenuItemHint }

constructor TMenuItemHint.Create(AOwner: TComponent);
begin
  inherited;

  showTimer := TTimer.Create(self);
  showTimer.Interval := Application.HintPause;

  hideTimer := TTimer.Create(self);
  hideTimer.Interval := Application.HintHidePause;
end; (*Create*)


destructor TMenuItemHint.Destroy;
begin
  hideTimer.OnTimer := nil;
  showTimer.OnTimer := nil;
  self.ReleaseHandle;
  inherited;
end; (*Destroy*)

procedure TMenuItemHint.DoActivateHint(menuItem: TMenuItem);
begin
  //force remove of the "old" hint window
  hideTime(self);

  if (menuItem = nil) or (menuItem.Hint = '') then
  begin
    activeMenuItem := nil;
    Exit;
  end;

  activeMenuItem := menuItem;

  showTimer.OnTimer := ShowTime;
  hideTimer.OnTimer := HideTime;
end; (*DoActivateHint*)

procedure TMenuItemHint.HideTime(Sender: TObject);
begin
  //hide (destroy) hint window
  self.ReleaseHandle;
  hideTimer.OnTimer := nil;
end; (*HideTime*)

procedure TMenuItemHint.ShowTime(Sender: TObject);
var
  r : TRect;
  wdth : integer;
  hght : integer;
begin
  if activeMenuItem <> nil then
  begin
    //position and resize
    wdth := Canvas.TextWidth(activeMenuItem.Hint);
    hght := Canvas.TextHeight(activeMenuItem.Hint);

    r.Left := Mouse.CursorPos.X + 16;
    r.Top := Mouse.CursorPos.Y + 16;
    r.Right := r.Left + wdth + 6;
    r.Bottom := r.Top + hght + 4;

    ActivateHint(r,activeMenuItem.Hint);
  end;

  showTimer.OnTimer := nil;
end; (*ShowTime*)

end.
