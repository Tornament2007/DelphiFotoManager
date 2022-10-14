unit DelItWFMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, strUtils, Winapi.ShellAPI;


type
  TMyIntegers = Array of Integer;
  TDelFileMenu = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);
  private
    var
      msg_File,
      v_LastLa,
      v_FileName:String;
      v_LastCh,
      v_FileIndx:Integer;
    { Private declarations }
    procedure ImplementLangForOne(lng:String);
    procedure ImplementLangForMore(lng:String);
  public
    { Public declarations }
    Function DeletFileWF(FilePath:String;DelWAAsc:Boolean;Lang:String = 'EN'):Integer;Overload;
    Function DeletFileWF(FilePaths:Tstrings;DelWAAsc:Boolean;Lang:String = 'EN'):TMyIntegers;Overload;
  end;

var
  DelFileMenu: TDelFileMenu;

implementation

{$R *.dfm}

{ TForm1 }

  function DelDir(dir: string): Boolean;
  var
    fos: TSHFileOpStruct;
  begin
    ZeroMemory(@fos, SizeOf(fos));
    with fos do
    begin
      wFunc  := FO_DELETE;
      fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION; // or FOF_SILENT
      pFrom  := PChar(dir + #0);
    end;
    Result := (0 = ShFileOperation(fos));
  end;

procedure TDelFileMenu.Button1Click(Sender: TObject);
begin
  if fileExists(Self.Hint) then
  begin
    if DelDir(Self.Hint) then
      Self.Tag:=1
    else
      Self.Tag:=2;
  end
  else
    Self.Tag:=4;
end;

procedure TDelFileMenu.Button1KeyPress(Sender: TObject; var Key: Char);
begin
  if ORD(key)=Vk_Escape then Button2.Click;
end;

procedure TDelFileMenu.Button2Click(Sender: TObject);
begin
  Self.Tag:=0;
  Button1.SetFocus;
end;

procedure TDelFileMenu.Button3Click(Sender: TObject);
begin
  Self.Tag:=3;
  Button1.SetFocus;
end;

function TDelFileMenu.DeletFileWF(FilePaths: Tstrings; DelWAAsc: Boolean;
  Lang: String): TMyIntegers;
var
  tv_I:integer;
begin
  tag:=FilePaths.Count;
  Lang:=AnsiLowerCase(Lang);
  if (v_LastLa<>Lang) or (v_LastCh<>2)
  then ImplementLangForMore(Lang);

  SetLength(Result, FilePaths.Count);
  Self.ShowModal;
  tv_i:=-1;
  repeat
    inc(tv_i);
    if fileExists(FilePaths[tv_i]) then
    begin
      if DelWAAsc then
      begin
        if DelDir(FilePaths[tv_i]) then
          Result[tv_i]:=1
        else
          Result[tv_i]:=2;
      end;

      Result[tv_i]:=Self.Tag;
      Self.Close;
    end
    else
    begin
      Result[tv_i]:=5;
    end;
  until tv_i=1;
  Self.Close;
end;

Function TDelFileMenu.DeletFileWF(FilePath:String;DelWAAsc:Boolean;
  Lang:String): Integer;
{
 0: Cancel
 1: File deleted
 2: File Not deleted
 3: You do not know what to do
 4: File not exist
}
begin
  Self.Hint:=FilePath;
  Lang:=AnsiLowerCase(Lang);
  if (v_LastLa<>Lang) or (v_LastCh<>1)
  then ImplementLangForOne(Lang);


  if fileExists(FilePath) then
    begin
      if DelWAAsc then
      begin
        if DelDir(Self.Hint) then
          Result:=1
        else
          Result:=2;
      end
      else
      begin
        Self.ShowModal;
        Result:=Self.Tag;
        Self.Close;
      end;
    end
  else
    begin
      Result:=5;
    end;
 v_LastCh:=1;
end;


procedure TDelFileMenu.ImplementLangForMore(lng: String);

  function LstChars(Num:Integer;end1,end2,end3: string): String;
  // Выдает правильное окончание в зависимости от числа. Допустим для числ 1 2 15
  begin
  if Num in [10..20] then
    Result:=end3
  else
  begin
    Num:=StrToInt(IntToStr(Num)[Length(IntToStr(num))]);
    if (Num=1) then Result:=end1;
    if (Num in [2..4]) then Result:=end2;
    if (Num in [5..9,0]) then Result:=end3;
  end;
  end;

 procedure setEnglish;
 begin
    msg_File:='Файл';
    GroupBox1.Caption:=' '+msg_File+':'+ExtractFileName(Self.Hint)+' ';
    label1.Caption:='Этот файл прожил долгую жизнь, и служил вам, всё это время...';
    label2.Caption:='У вас были радости и невзгоды...';
    label3.Caption:='Но вы всё еще вместе, всё еще Друзья!!';
    label4.Caption:='И сейчас ВЫ ходите удалить Его?!';
    label5.Caption:='Вы действительно хотите УБИТЬ своего Друга!?!?!';

    Button1.Caption:='Удалить (ДА!)';
    Button2.Caption:='Выйти (Нет!)';
    Button3.Caption:='Я НЕ ЗНАЮ!! (Убежать прочь!)';

    Caption:='Удаление: '+IntToStr(tag)+' файл'+LstChars(tag,'','а','в');;
 end;

begin
  msg_File:='File';
  case ansiIndexText(lng ,['en','ru']) of

  -1:
  begin //Lang Not def
    setEnglish;
    Caption:=' File deletion (Language not recognized)';
  end;

  0:
  begin //En
    setEnglish;
  end;

  1:
  begin //RU
    msg_File:='Файл';
    GroupBox1.Caption:=' '+msg_File+': '+ExtractFileName(Self.Hint)+' ';
    label1.Caption:='Этот файл прожил долгую жизнь, и служил вам, всё это время...';
    label2.Caption:='У вас были радости и невзгоды...';
    label3.Caption:='Но вы всё еще вместе, всё еще Друзья!!';
    label4.Caption:='И сейчас ВЫ ходите удалить Его?!';
    label5.Caption:='Вы действительно хотите УБИТЬ своего Друга!?!?!';

    Button1.Caption:='Удалить (ДА!)';
    Button2.Caption:='Выйти (Нет!)';
    Button3.Caption:='Я НЕ ЗНАЮ!! (Убежать прочь!)';

    Caption:='Удаление файла';
  end;

  end; //cese end
  v_LastLa:=lng;
end;

procedure TDelFileMenu.ImplementLangForOne(lng: String);

 procedure setEnglish;
 begin
    msg_File:='Файл';
    GroupBox1.Caption:=' '+msg_File+': '+ExtractFileName(Self.Hint)+' ';
    label1.Caption:='Этот файл прожил долгую жизнь, и служил вам, всё это время...';
    label2.Caption:='У вас были радости и невзгоды...';
    label3.Caption:='Но вы всё еще вместе, всё еще Друзья!!';
    label4.Caption:='И сейчас ВЫ ходите удалить Его?!';
    label5.Caption:='Вы действительно хотите УБИТЬ своего Друга!?!?!';

    Button1.Caption:='Удалить (ДА!)';
    Button2.Caption:='Выйти (Нет!)';
    Button3.Caption:='Я НЕ ЗНАЮ!! (Убежать прочь!)';

    Caption:='Удаление файла';
 end;

begin
  msg_File:='File';
  case ansiIndexText(lng ,['en','ru']) of

  -1:
  begin //Lang Not def
    setEnglish;
    Caption:=' File deletion (Language not recognized)';
  end;

  0:
  begin //En
    setEnglish;
  end;

  1:
  begin //RU
    msg_File:='Файл';
    GroupBox1.Caption:=' '+msg_File+': '+ExtractFileName(Self.Hint)+' ';
    label1.Caption:='Этот файл прожил долгую жизнь, и служил вам, всё это время...';
    label2.Caption:='У вас были радости и невзгоды...';
    label3.Caption:='Но вы всё еще вместе, всё еще Друзья!!';
    label4.Caption:='И сейчас ВЫ ходите удалить Его?!';
    label5.Caption:='Вы действительно хотите УБИТЬ своего Друга!?!?!';

    Button1.Caption:='Удалить (ДА!)';
    Button2.Caption:='Выйти (Нет!)';
    Button3.Caption:='Я НЕ ЗНАЮ!! (Убежать прочь!)';

    Caption:='Удаление файла';
  end;

  end; //cese end
  v_LastLa:=lng;
end;

end.
