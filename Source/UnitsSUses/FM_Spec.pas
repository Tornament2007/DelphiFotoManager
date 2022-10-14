unit FM_Spec;

interface

uses
    System.SysUtils, Winapi.ShellAPI;

  Function GCName(InStr:String):String;
  Function GCN_M(InStr:String):String;
  Function GetIt(IncStr:String):String;

implementation
  Uses FsP;


function GetIt(IncStr: String): String;
var
  _Str:String;
  I:Integer;
begin
  IncStr:=DelSpecChars(IncStr,'&');

  if (Length(IncStr)=4) then    // or (IncStr[3]<>' ') idea
    Result:=Copy(IncStr,1,4)
  else
    Result:=Copy(IncStr,1,2);
  exit;

  if Length(IncStr)=4 then
    Result:=Copy(IncStr,1,4)
  else
    Result:=Copy(IncStr,1,2);
  exit;

  for i := 1 to length(IncStr) do
  begin
    if (IncStr[i]=' ') then
    begin
      Result:=Copy(IncStr,1,i-1);
      Break;
    end;
  end;
end;

  Function GCName(InStr:String):String;
  var
    St_T,St_T2:String;
  Begin
    if (Length(InStr)<5) then Begin Result:=InStr; Exit; End;
    
    if (InStr[2]='_') or (InStr[3]='_') then Begin Result:=GCN_M(InStr); Exit; end;

    St_T:= Replace1to2(InStr,'.',' ');
    St_T2:=GetMonThNames(Copy(St_T,4,2),3);
    St_T2:=AnCa(Copy(St_T2,1,1),True)+Copy(St_T2,2,2);
    Result:=Copy(St_T,1,2)+' '+St_T2+' '+Copy(St_T,7,2)+Copy(St_T,9,255);
  End;

  Function GCN_M(InStr:String):String;
  Begin
    if (InStr[2]='_') then
      Result:=GetMonThNames(Copy(InStr,0,1),4)
    else
      Result:=GetMonThNames(Copy(InStr,0,2),4)
  End;
end.
