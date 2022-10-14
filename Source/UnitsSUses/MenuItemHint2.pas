unit MenuItemHint2;

 interface

 uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 StdCtrls, ExtCtrls;

 type
 TMyHintWindow = class(TForm)
 Label1: TLabel;
 Timer1: TTimer;
 procedure Timer1Timer(Sender: TObject);


 private
 { Declarations privees }
 function ElapsedTime: integer;   // declaration du délai (temps) d'affichage du Hint

 public
 { Declarations publiques }
 Mdate: TDateTime;  // declaration de la variable temps
 end;

 var
 MyHintWindow: TMyHintWindow;

procedure ShowHintAt(X, Y: integer);  // declaration de la procédure affichant le Hint

 implementation

 {$R *.DFM}

// procedure du delai (temps) d'affichage du Hint

function TMyHintWindow.ElapsedTime: integer;
var
 Hour, Min, Sec, MSec: word;
begin
   DecodeTime(now - MDate, Hour, Min, Sec, MSec);
   Result := Hour * 3600000 + Min * 60000 + Sec * 1000 + MSec;
end;

// procedure pour afficher le Hint
 procedure ShowHintAt(X, Y: integer);
begin
  MyHintWindow.Label1.Caption := Application.Hint;
  MyHintWindow.Left := X;
  MyhintWindow.Top := Y;
  SetWindowPos(MyHintWindow.Handle, HWND_TOPMOST, X, Y, MyHintwindow.Width,  MyHintWindow.Height, SWP_SHOWWINDOW or SWP_NOACTIVATE);
  MyHintwindow.MDate := now;
  MyHintwindow.Timer1.Enabled := true;
end;

// evenement declenché par le Timer qui permet d'afficher le Hint et ensuite de le faire disparaître
 procedure TMyHintWindow.Timer1Timer(Sender: TObject);
begin
   if ElapsedTime > Application.HintHidePause then
   begin
    SetWindowPos(MyHintWindow.Handle, HWND_TOPMOST, 0, 0, MyHintwindow.Width,      MyHintWindow.Height, SWP_HIDEWINDOW or SWP_NOACTIVATE);
    Timer1.Enabled := false;
 end;
 end;

end.
