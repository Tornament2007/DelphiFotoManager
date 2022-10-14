unit AttrMenuCode;

interface

uses
  MainCode,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, LanguageOperator, clipBrd, strutils;

type
  TAttrMenu = class(TForm)
    GroupBox1: TGroupBox;
    LFileName: TLabel;
    GroupBox2: TGroupBox;
    Lname: TLabel;
    LTheme: TLabel;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    LAuthor: TLabel;
    LCamera: TLabel;
    LRating: TLabel;
    AttrX: TEdit;
    AttrD: TMemo;
    AttrN: TEdit;
    AttrT: TEdit;
    AttrR: TTrackBar;
    AttrRsh: TLabel;
    AttrC: TComboBox;
    AttrA: TComboBox;
    AttrRSh2: TLabel;
    CBListChanges: TCheckBox;
    AttrTa: TComboBox;
    AM_LangWL: TListBox;
    CheckBox1: TCheckBox;
    SAttrN: TButton;
    SAttrT: TButton;
    SAttrD: TButton;
    SAttrX: TButton;
    SAttrA: TButton;
    SAttrC: TButton;
    SAttrR: TButton;
    AddToX: TButton;
    procedure Attr_Change(Sender: TObject);
    procedure SAttr_Click(Sender: TObject);
    procedure AttrNKeyPress(Sender: TObject; var Key: Char);
    procedure AttrAKeyPress(Sender: TObject; var Key: Char);
    procedure AttrRKeyPress(Sender: TObject; var Key: Char);
    procedure AttrTaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure AttrDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AttrTaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AttrTaClick(Sender: TObject);
    procedure AddToXClick(Sender: TObject);
    procedure AttrNKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AttrAKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AttrRKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AttrXKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GroupBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SAttrNMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
    Function WriteAll(Attr,Text:String):Boolean;
  public
    { Public declarations }
    procedure ReadAttr(FileName:String;SelNum:Integer);
    Procedure ShowAndRead(Sender:TForm;Lister:TlistBox);
  end;

var
  AttrMenu: TAttrMenu;

  V_attr_Description:String;

  AM_SLBox:TListBox;

implementation

uses FileAttrOnTini,ConfCode,FastWordCode, FsP,FM_Spec, ImageL_Index;

{$R *.dfm}

procedure TAttrMenu.AddToXClick(Sender: TObject);
var
  _Str,WhtC:String;
begin
  _Str:=Trim(AttrX.Text);
  WhtC:=Trim(AttrTa.Text);
  if WhtC='' then exit;

  if (CheckBox1.Checked) or (AddToX.Tag=1) then
  begin
    AddToX.Tag:=0;
    // add to the list
    if FastWord.Tag<>1 then
      FastWord.Editor1Click(FastWord.Editor1);
    FastWord.Edit1.Text:=WhtC;
    FastWord.Edit1Change(FastWord.Edit1);
    If FastWord.AdB.Enabled then
      FastWord.AdBClick(fastWord.Edit1)
    else
      FastWord.Edit1.clear;
  end;

  _Str:=Trim(AttrX.Text);
  WhtC:=Trim(AttrTa.Text);

  if (_Str<>'') and (_Str[length(_Str)]<>',') then
    _Str:=_Str+',';
  AttrX.Text:=_Str+WhtC;
  AttrTa.Text:='';
end;

procedure TAttrMenu.AttrAKeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key)=(Vk_Return) then
  begin
    SAttr_Click((FindComponent('SAttr'+Copy((Sender as TComboBox).Name,5,1)) as Tpanel));
    exit;
  end;
  if ord(Key)=(Vk_ESCAPE) then
  begin
    (Sender as TComboBox).Text:=(Sender as TComboBox).Hint;
    (Sender as TComboBox).SelStart:=Length((Sender as TComboBox).Text);
    exit;
  end;
end;

procedure TAttrMenu.AttrAKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ord(Key)=Ord('S')) and (Shift = [ssCtrl]) then
  begin
    SAttr_Click((FindComponent('SAttr'+Copy((Sender as TComboBox).Name,5,1)) as Tpanel));
    exit;
  end;
end;

procedure TAttrMenu.AttrDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then
  begin
    AttrD.Text:=V_attr_Description;
    AttrD.SelStart:=Length(AttrD.Text);
    Key:=0;
    Exit;
  end;
  if ((ord(Key)=Ord('S')) and (Shift = [ssCtrl])) or
     ((Key=Vk_Return) and (Shift= [ssShift])) then
  begin
    SAttr_Click(SAttrD);
    Key:=0;
  end;
  if (Key=ORD('A')) and (Shift = [ssctrl]) then
  begin
    AttrD.SelectAll;
    Exit;
  end;
end;

procedure TAttrMenu.Attr_Change(Sender: TObject);
var
  Butn:TButton;           ///??
  R,G,B:Integer;
begin
  if (Sender.ClassName='TEdit') then begin
  Butn:=(FindComponent('SAttr'+Copy((Sender as Tedit).Name,5,1)) as TButton);
  if (AM_SLBox.SelCount>1) then begin
    Butn.ImageIndex:=ImageL.Save_Half;
  end else
    if (((Sender as Tedit).Text)<>((Sender as Tedit).Hint)) then
      Butn.ImageIndex:=ImageL.Save_Not
    else
      Butn.ImageIndex:=ImageL.Save;
  end;

  if (Sender.ClassName='TMemo') then begin
    if (AM_SLBox.SelCount>1) then begin
    SAttrD.ImageIndex:=ImageL.Save_Half;
  end else
    if (AttrD.Text<>V_attr_Description) then
      SAttrD.ImageIndex:=ImageL.Save_Not
    else
      SAttrD.ImageIndex:=ImageL.Save;
  end;

  if (Sender.ClassName='TComboBox') then begin
  Butn:=(FindComponent('SAttr'+Copy((Sender as TComboBox).Name,5,1)) as TButton);
  if (AM_SLBox.SelCount>1) then begin
    Butn.ImageIndex:=ImageL.Save_Half;
  end else
    if (((Sender as TComboBox).Text)<>((Sender as TComboBox).Hint)) then
      Butn.ImageIndex:=ImageL.Save_Not
    else
      Butn.ImageIndex:=ImageL.Save;
  end;

  if (Sender.ClassName='TTrackBar') then begin
  AttrRsh.Caption:='"'+IntToStr(AttrR.Position)+'"';
  AttrRSh2.Caption:='"'+IntToStr(AttrR.Position)+'"';
  R:=255-Trunc((255/50)*AttrR.Position-(ord(AttrR.Position>50)*(((255/50)*AttrR.Position)-255)));
  G:=Trunc(ord(AttrR.Position>50)*((255/50)*AttrR.Position));
  B:=Trunc(ord((AttrR.Position>24) and (AttrR.Position<51))*((255/25)*(AttrR.Position-25)))+
     Trunc(ord((AttrR.Position>50) and (AttrR.Position<76))*(255-(255/25)*(AttrR.Position-25)));
  AttrRsh.font.Color:=RGB(R,G,B);

  // paint star with color RGB(R,G,B)
  if (AM_SLBox.SelCount>1) then begin
    SAttrR.ImageIndex:=ImageL.Save_Half;
  end else
    if ((AttrR.Position)<>(AttrR.Tag)) then
      SattrR.ImageIndex:=ImageL.Save_Not
    else
      SattrR.ImageIndex:=ImageL.Save;
  end;
end;

procedure TAttrMenu.AttrNKeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key)=(Vk_Return) then
    begin
      SAttr_Click((FindComponent('SAttr'+Copy((Sender as Tedit).Name,5,1)) as TButton));
      exit;
    end;

  if ord(Key)=(Vk_ESCAPE) then
    begin
      (Sender as TEdit).Text:=(Sender as TEdit).Hint;
      (Sender as TEdit).SelStart:=Length((Sender as TEdit).Text);
      exit;
    end;
  if key in ['*','?'] then key:=#0;
end;

procedure TAttrMenu.AttrNKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ord(Key)=Ord('S')) and (Shift = [ssCtrl]) then
  begin
    SAttr_Click((FindComponent('SAttr'+Copy((Sender as Tedit).Name,5,1)) as TButton));
    exit;
  end;
end;

procedure TAttrMenu.AttrRKeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key)=(Vk_Return) then
    begin
      SAttr_Click((FindComponent('SAttr'+Copy((Sender as TTrackBar).Name,5,1)) as Tpanel));
      exit;
    end;
end;

procedure TAttrMenu.AttrRKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ord(Key)=Ord('S')) and (Shift = [ssCtrl]) then
  begin
    SAttr_Click((FindComponent('SAttr'+Copy((Sender as TTrackBar).Name,5,1)) as Tpanel));
    exit;
  end;
end;

procedure TAttrMenu.AttrTaClick(Sender: TObject);
begin
  if FastWord.Tag<>1 then
    FastWord.Editor1Click(FastWord.Editor1);
end;

procedure TAttrMenu.AttrTaKeyPress(Sender: TObject; var Key: Char);
begin
  if key in [',','*','?'] then key:=#0;
end;

procedure TAttrMenu.AttrTaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ord(Key)=(Vk_ESCAPE) then
  begin
    //AttRx.Text:=AttRx.Hint;
    AttrTa.Text:='';;
    exit;
  end;
  if (ord(Key)=Ord('S')) and (Shift = [ssCtrl]) then
  begin
    SAttr_Click(SattrX);
    Attrta.DroppedDown := False;
    Exit;
  end;
  if ord(Key)=(Vk_Return) then
  begin
    if (Shift = [ssCtrl]) then
    begin
      SAttr_Click(SattrX);
      Attrta.DroppedDown := False;
      Exit;
    end;
    if (Shift = [ssShift]) and (not CheckBox1.Checked) then AddToX.Tag:=1;
    AddToX.Click;
    exit;
  end;
end;

procedure TAttrMenu.AttrXKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
  ts:String;
begin
  if (ord(Key)=Ord('S')) and (Shift = [ssCtrl]) then
  begin
    SAttr_Click(SattrX);
    Attrta.DroppedDown := False;
    Exit;
  end;

  if Not((Shift=[ssShift,ssCtrl]) and (Key=Ord('C'))) then exit;

  if AttrX.SelText='' then
    ts:=AttrX.Text
  else
  begin
    ts:=Trim(AttrX.SelText);
    if (ts[1]=',') then Delete(ts,1,1);
  end;

  ts:='#'+Replace1to2(ts,' ',',');
  ts:=Replace1to2(Ts,',',' #');
  ts:=Replace1to2(Ts,'-','_');
  Clipboard.AsText:=ts;
  MainForm.SetStatus1(ts,1500,True);
end;

procedure TAttrMenu.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := Application.Handle;
end;

procedure TAttrMenu.FormCreate(Sender: TObject);
begin
  Self.Width:=340;
  ReadLang(Self,Data+'Lang\','Lang',Language);
end;

procedure TAttrMenu.GroupBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  Boxes: array[1..5] of Byte = (44,66,70,66,103);
// 44  1
// 66  2
// 70  3
// 66  4
// 103 5
Procedure RaseGP(Obj:TGroupBox;H,W:Integer);
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

  Procedure DoM(Colapse:Boolean;Obj:TObject);
  var
    Num:Integer;
  begin
    if Colapse then
      MainForm.SetStatus1('Collaps '+(Sender as TGroupBox).Name)
    else
      MainForm.SetStatus1('Expand '+(Sender as TGroupBox).Name);
    Num:=StrToInt(Copy((Sender as TGroupBox).name,LEngth((Sender as TGroupBox).name),1));
    if Colapse then
      RaseGP((Sender as TGroupBox),15,0)
    else
      RaseGP((Sender as TGroupBox),Boxes[Num],0);
    if Num=3 then SAttrD.Visible:=Not Colapse;
    if Num=4 then SAttrX.Visible:=Not Colapse;
    //regroup

  end;

var
 tNa:String;
 //XIB,YIB:Integer;
begin
  tNa:=(Sender as TGroupBox).Caption;
  if (Y>13) or (X>(6*Length(tNa)+Length(tNa)-1+5)) then exit;

  if (Sender as TGroupBox).Tag=0 then
    DoM(True,(Sender as TGroupBox))
  else
    DoM(False,(Sender as TGroupBox));
  (Sender as TGroupBox).Tag:=Ord((Sender as TGroupBox).Tag=0);
  end;

procedure TAttrMenu.ReadAttr(FileName: String; SelNum: Integer);
var
  TestString:String;
  TempString:TStringList;
begin
  if SelNum=0 then begin
    Tag:=0;
    Caption:=AM_LangWL.Items[10]+' '+AM_LangWL.Items[11]+'';
    Hint:='';
    LFileName.Caption:=AM_LangWL.Items[11];
    AttrN.Text:='';
    AttrN.Hint:='';
      Attr_Change(AttrN);
    AttrT.Text:='';
    AttrT.Hint:='';
      Attr_Change(AttrT);
    AttrR.Position:=0;
    AttrR.Tag:=0;
      Attr_Change(AttrR);
    AttrX.Text:='';
    AttrX.Hint:='';
    AttrD.Clear;
    AttrA.Text:='';
    AttrA.Hint:='';
    AttrC.Text:='';
    AttrC.Hint:='';
    exit;
  end;

  TempString:=TStringList.Create;
  TempString.Clear;
  TempString:=ReadConf(FileName,0);
  try
    if (SelNum>1) then begin
      GroupBox1.Caption:=FORMAT(' '+AM_LangWL.Items[13]+' ',[SelNum]);
      Caption:=FORMAT(' '+AM_LangWL.Items[15]+' ',[SelNum]);
    end else begin
      GroupBox1.Caption:=' '+AM_LangWL.Items[12]+' ';
      Caption:=FORMAT(' '+AM_LangWL.Items[10]+' ',[ExtractFileName(FileName)]);
    end;

    if TempString.Count<>0 then begin
      if (TempString[3]='nil') or (TempString[3]='') then TempString[3]:='0';

      Tag:=StrToInt(TempString[0]);
      Hint:=FileName;
      LFileName.Caption:='"'+ExtractFileName(FileName)+'"';

      AttrN.Text:=TempString[1];
      AttrN.Hint:=TempString[1];
        Attr_Change(AttrMenu.AttrN);
      AttrT.Text:=TempString[2];
      AttrT.Hint:=TempString[2];
        Attr_Change(AttrMenu.AttrT);
      AttrR.Position:=StrToInt(TempString[3]);
      AttrR.Tag:=StrToInt(TempString[3]);
        Attr_Change(AttrMenu.SAttrR);
      AttrX.Text:=TempString[4];
      AttrX.Hint:=TempString[4];
        Attr_Change(AttrMenu.AttrX);
      AttrD.Clear;
      AttrD.Text:=Replace1to2(TempString[5],'|>|<|',#13+#10);
      V_attr_Description:= AttrMenu.AttrD.Text;
        Attr_Change(AttrMenu.AttrD);
      AttrA.Text:=TempString[6];
      AttrA.Hint:=TempString[6];
        Attr_Change(AttrMenu.AttrA);
      AttrC.Text:=TempString[7];
      AttrC.Hint:=TempString[7];
        Attr_Change(AttrMenu.AttrC);
    end else begin
      MainForm.SetStatus1(AM_LangWL.Items[16],3000)
    end;
  finally
    TempString.Free;
  end;
end;

procedure TAttrMenu.SAttr_Click(Sender: TObject);
var
  Attr,Text:String;
begin
  if ((Sender as TButton).ImageIndex=ImageL.Save)
  or (AM_SLBox.SelCount=0)
  then exit;

  Attr:=Copy((Sender as TButton).Name,6,1);
  //Uses strutils;
  case ansiIndexText(Attr ,['N', 'T', 'D', 'X', 'A', 'C', 'R']) of
    0,1,3: Text:=(FindComponent('Attr'+Attr) as Tedit).text;     // N T X
    2:   Text:=Replace1to2(AttrMenu.AttrD.Text,#13+#10,'|>|<|'); // D
    4,5: Text:=(FindComponent('Attr'+Attr) as TCombobox).text;   // A C
    6:   Text:=IntTOStr((FindComponent('Attr'+Attr) as TTrackBar).Position); // R
  end;

  if Text='0' then BEgin
    MainForm.SetStatus1(AM_LangWL.Items[0],1000);
    exit;
  End;

  if WriteAll(Attr,Text) then begin
    (Sender as TButton).ImageIndex:=ImageL.Save;
    case ansiIndexText(Attr ,['N', 'T', 'D', 'X', 'A', 'C', 'R']) of
      0,1,3:(FindComponent('Attr'+Attr) as Tedit).Hint:=
              (FindComponent('Attr'+Attr) as Tedit).Text;     // N T X
      2:     V_attr_Description:=Text;                        // X
      4,5:  (FindComponent('Attr'+Attr) as TCombobox).Hint:=
              (FindComponent('Attr'+Attr) as TCombobox).Text; // A C
      6:     AttrR.Tag:=AttrR.Position;                       // R
    end;
  end;
end;

procedure TAttrMenu.SAttrNMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  procedure Edits(SN:String);
  begin
    (FindComponent(SN) as TEdit).Text:=(FindComponent(SN) as TEdit).Hint;
    (FindComponent(SN) as TEdit).SelStart:=Length((FindComponent(SN) as TEdit).Text);
  end;

  Procedure Combos(SN:String);
  begin
    (FindComponent(SN) as TComboBox).Text:=(FindComponent(SN) as TComboBox).Hint;
  end;
var
  SName:String;
  Edt:TEdit;
begin
  if Button <> mbright then exit;
  SName:='Attr'+Copy((Sender as TButton).Name,6,1);
  //Uses strutils;
  case ansiIndexText(Copy((Sender as TButton).Name,6,1) ,['N', 'T', 'D', 'X', 'A', 'C', 'R']) of
    0,1,3:Edits(SName);
    2:Begin Exit; End;
    4,5:Combos(SName);
    6:AttrR.Position:= AttrR.Tag;
  end;
  (Sender as TButton).ImageIndex:=ImageL.Save;
end;

procedure TAttrMenu.ShowAndRead(Sender: TForm; Lister:TlistBox);
begin
  AM_SLBox:=Lister;
  if not Visible then begin
    Show;
    Sender.BringToFront;
  end;
  ReadAttr(AM_SLBox.Items[AM_SLBox.ItemIndex],AM_SLBox.SelCount);
end;

Function TAttrMenu.WriteAll(Attr, Text:String):Boolean;
var
  I,SI,IC,L:Integer;
  Index:Integer;
  FileName:String;
begin
  IC:=AM_SLBox.SelCount;
  if text='' then
    MainForm.SetStatus1(AM_LangWL.Items[0],3000);
  if IC>1 then begin
    MainForm.SetStatus1(FORMAT(AM_LangWL.Items[1],[IC]),3000);
    Si:=Ic;
    i:=-1;

      repeat
        inc(I);
        if AM_SLBox.Selected[I] then begin
          FileName:=AM_SLBox.Items[I];
          OpenConf(FileName);
          Index:=FindIndex(FileName,AM_SLBox.Items.Count,True);
          CloseConf;
          Dec(Si);
          L:=Ic-Si;
          if WriteConf(FileName,Attr,Text,Index) then
            MainForm.SetStatus1(FORMAT(AM_LangWL.Items[5],[L,IC]),1500)
          else
            MainForm.SetStatus1(FORMAT(AM_LangWL.Items[6],[L,IC]),1500)
          end;
      until (Si<0) or (I=AM_SLBox.Items.Count-1);
      MainForm.SetStatus1(FORMAT(AM_LangWL.Items[7],[IC]),3000);
    end
  else
    if WriteConf(AttrMenu.Hint,Attr,Text,AttrMenu.Tag) then begin
      result:=True;
      MainForm.SetStatus1(AM_LangWL.Items[8],3000);

    end else begin
      result:=False;
      MainForm.SetStatus1(AM_LangWL.Items[9],3000);
    end;
end;

end.
