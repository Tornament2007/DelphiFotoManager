unit LanguageOperator;

interface
  uses IniFiles, SysUtils, Forms, StdCtrls, ExtCtrls, menus, Classes;

  Procedure OpenConf(Path,FName:String);
  Procedure CloseConf;

  Procedure WriteAllToFile(Target:Tform;Path,FName:String);
  Procedure ReadLang(Target:Tform;Path,FName,Lang:String);

  Function RetLangEXT:String;

implementation

const
  NonEX = 'ijnhsu697l4002jd80s223dfd';
  LangFileFormat = 'lang';
var
  LanguageFile:TiniFile;

Procedure OpenConf(Path,FName:String);
begin
  if Path[Length(Path)]<>'\' then
    Path:=Path+'\';
  if not DirectoryExists(Path) then
    ForceDirectories(Path);
  LanguageFile:= TiniFile.Create(Path+FName+'.'+LangFileFormat);
end;

Procedure CloseConf;
begin
  LanguageFile.Free;
end;

Function RetLangEXT:String;
begin
  Result := LangFileFormat;
end;

Procedure WriteAllToFile(Target:Tform;Path,FName:String);
var
  I,I2:Integer;
  TStr1,TStr2,TCoN,CLSN,Section:String;
  CLS:TClass;
  TCo:TComponent;
begin
  if Target.ComponentCount = 0 then exit;
  openConf(Path,FName);
    Section:=Target.Name;
    LanguageFile.WriteString(Section,Target.Name,Target.Caption);
    for i:=1 to Target.ComponentCount do
    begin
      TCo:=Target.Components[i-1];
      CLS:=TCo.ClassType;
      CLSN:=TCo.ClassName;
      TCoN:=TCo.name;
      TStr2:=CLSN+'_'+Tcon;
      if  (CLS <> TButton)
      and (CLS <> TLabel)
      and (CLS <> TEdit)
      and (CLS <> TPanel)
      and (CLS <> TGroupBox)
      and (CLS <> TCheckBox)
      and (CLS <> TMenuItem)
      and (CLS <> TTrayIcon)
      and (CLS <> Tlistbox)
      and (CLS <> TComboBox)
      then
        Continue;


      if (CLS = Tlistbox) and
      ((TCoN='LangWL') or (Copy(TCoN,Length(TCoN)-5,6)='LangWL')) then
      begin
        for I2 := 0 to ((TCo as TlistBox).Items.Count-1) do
        begin
          TStr2:=CLSN+'_'+Tcon+IntTOStr(I2+1);
          TStr1:=(TCo as TlistBox).Items[i2];
          LanguageFile.WriteString(Section,TStr2,TStr1);
        end;
        Continue;
      end;

      if CLS = TButton then
        TStr1:=(TCo as TButton).Caption;
      if CLS = TLabel then
        TStr1:=(TCo as TLabel).Caption;
      if CLS = TEdit then
        TStr1:=(TCo as TEdit).TextHint;
      if CLS = TPanel then
        TStr1:=(TCo as TPanel).Caption;
      if CLS = TGroupBox then
        TStr1:=(TCo as TGroupBox).Caption;
      if CLS = TCheckBox then
        TStr1:=(TCo as TCheckBox).Caption;
      if CLS = TMenuItem then
        TStr1:=(TCo as TMenuItem).Caption;
      if CLS = TTrayIcon then
        TStr1:=(TCo as TTrayIcon).Hint;
      if CLS = TComboBox then
        TStr1:=(TCo as TComboBox).TextHint;

      if TStr2=TCoN then
        TStr2:=TCoN+'1';

      LanguageFile.WriteString(Section,TStr2,TStr1);
    end;
  CloseConf;
end;

Procedure ReadLang(Target:Tform;Path,FName,Lang:String);
var
  I,I2:Integer;
  TStr1,TStr2,TCoN,CLSN,Section,ForComp:String;
  CLS:TClass;
  TCo:TComponent;
begin
  if lang='def' then exit;
  
  if (Target.ComponentCount = 0)
  or (Not FileExists(Path+FName+'_'+Lang+'.'+LangFileFormat))
  then exit;
  openConf(Path,FName+'_'+Lang);
    Section:=Target.Name;
    if LanguageFile.ReadString(Section,Target.Name,NonEX)<>NonEX then
      Target.Caption:=LanguageFile.ReadString(Section,Target.Name,Target.Caption);

    for i:=1 to Target.ComponentCount do
    begin
      TCo:=Target.Components[i-1];
      CLS:=TCo.ClassType;
      CLSN:=TCo.ClassName;
      TCoN:=TCo.name;
      TStr2:=CLSN+'_'+Tcon;
      if  (CLS <> TButton)
      and (CLS <> TLabel)
      and (CLS <> TEdit)
      and (CLS <> TPanel)
      and (CLS <> TGroupBox)
      and (CLS <> TCheckBox)
      and (CLS <> TMenuItem)
      and (CLS <> TTrayIcon)
      and (CLS <> Tlistbox)
      and (CLS <> TComboBox)
      then
        Continue;

      if (CLS = Tlistbox) then
      begin
        if ((TCoN='LangWL') or (Copy(TCoN,Length(TCoN)-5,6)='LangWL')) then
        begin
          for I2 := 0 to ((TCo as TlistBox).Items.Count-1) do
          begin
            TStr1:=(TCo as TlistBox).Items[i2];
            TStr2:=CLSN+'_'+TCoN+IntTOStr(I2+1);
            ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
            if ForComp<>NonEX then
              (TCo as TlistBox).Items[i2]:=LanguageFile.ReadString(Section,TStr2,TStr1);
          end;
        end;
        Continue;
      end;

      if CLS = TButton then
        begin
          TStr1:=(TCo as TButton).Caption;
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TButton).Caption:=LanguageFile.ReadString(Section,TStr2,TStr1);
          continue;
        end;
      if CLS = TLabel then
        begin
          TStr1:=(TCo as TLabel).Caption;
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TLabel).Caption:=LanguageFile.ReadString(Section,TStr2,TStr1);
          continue;
        end;
      if CLS = TEdit then
        begin
          TStr1:=(TCo as TEdit).TextHint;
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TEdit).TextHint:=LanguageFile.ReadString(Section,TStr2,TStr1);
          continue;
        end;
      if CLS = TPanel then
        begin
          TStr1:=(TCo as TPanel).Caption;
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TPanel).Caption:=LanguageFile.ReadString(Section,TStr2,TStr1);
          continue;
        end;
      if CLS = TGroupBox then
        begin
          TStr1:=(TCo as TGroupBox).Caption;
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TGroupBox).Caption:=LanguageFile.ReadString(Section,TStr2,TStr1);
          continue;
        end;
      if CLS = TCheckBox then
        begin
          TStr1:=(TCo as TCheckBox).Caption;
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TCheckBox).Caption:=LanguageFile.ReadString(Section,TStr2,TStr1);
          continue;
        end;
      if CLS = TMenuItem then
        begin
          TStr1:=(TCo as TMenuItem).Caption;
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TMenuItem).Caption:=LanguageFile.ReadString(Section,TStr2,TStr1);
          continue;
        end;
      if CLS = TTrayIcon then
        begin
          TStr1:=(TCo as TTrayIcon).Hint;
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TTrayIcon).Hint:=LanguageFile.ReadString(Section,TStr2,TStr1);
          continue;
        end;
      if CLS = TComboBox then
        begin
          TStr1:=(TCo as TComboBox).TextHint;
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TComboBox).TextHint:=LanguageFile.ReadString(Section,TStr2,TStr1);
          continue;
        end;
    end;
  CloseConf;
end;
end.
