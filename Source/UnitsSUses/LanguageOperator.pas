unit LanguageOperator;

interface
  uses IniFiles, SysUtils, Forms, StdCtrls, ExtCtrls, menus, Classes,
  ComCtrls;

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

Function Support(var CLS:TClass):Boolean;
begin
  result:=(CLS = TButton)
      or  (CLS = TLabel)
      or  (CLS = TEdit)
      or  (CLS = TPanel)
      or  (CLS = TGroupBox)
      or  (CLS = TCheckBox)
      or  (CLS = TMenuItem)
      or  (CLS = TTrayIcon)
      or  (CLS = Tlistbox)
      or  (CLS = TComboBox)
      or  (CLS = TTabSheet);
end;

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
  Procedure FormAndWrite(var Section,tKey,tStat,CompoName:String);
    begin
      if (Trim(tStat)='') then exit;
      LanguageFile.WriteString(Section,tKey,tStat);
    end;
var
  I,I2:Integer;
  tStat,tKey,CompoName,ClassName,Section:String;
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
      if not support(CLS) then Continue;
      ClassName:=TCo.ClassName;   //
      CompoName:=TCo.name;
      tKey:=ClassName+'_'+CompoName;

      if (CLS = Tlistbox) and
      ((CompoName='LangWL') or (Copy(CompoName,Length(CompoName)-5,6)='LangWL')) then
      begin
        for I2 := 0 to ((TCo as TlistBox).Items.Count-1) do
        begin
          tKey:=ClassName+'_'+CompoName+IntTOStr(I2+1);
          tStat:=(TCo as TlistBox).Items[i2];
          FormAndWrite(Section,tKey,tStat, CompoName);
        end;
        Continue;
      end;

      if CLS = TButton then
      begin
        tStat:=(TCo as TButton).Caption;
        FormAndWrite(Section,tKey,tStat, CompoName);
        if ((TCo as TButton).ShowHint) then begin
          tStat:=(TCo as TButton).Hint;
          tKey:=tKey+'_Hint';
          FormAndWrite(Section,tKey,tStat, CompoName);
        end;
        Continue;
      end;

      if CLS = TLabel then begin
        tStat:=(TCo as TLabel).Caption;
        FormAndWrite(Section,tKey,tStat, CompoName);
        Continue;
      end;
      if CLS = TEdit then begin
        tStat:=(TCo as TEdit).TextHint;
        FormAndWrite(Section,tKey,tStat, CompoName);
        Continue;
      end;
      if CLS = TPanel then begin
        tStat:=(TCo as TPanel).Caption;
        FormAndWrite(Section,tKey,tStat, CompoName);
        Continue;
      end;
      if CLS = TGroupBox then begin
        tStat:=(TCo as TGroupBox).Caption;
        FormAndWrite(Section,tKey,tStat, CompoName);
        Continue;
      end;
      if CLS = TCheckBox then begin
        tStat:=(TCo as TCheckBox).Caption;
        FormAndWrite(Section,tKey,tStat, CompoName);
        Continue;
      end;
      if CLS = TMenuItem then begin
        tStat:=(TCo as TMenuItem).Caption;
        FormAndWrite(Section,tKey,tStat, CompoName);
        Continue;
      end;
      if CLS = TTrayIcon then begin
        tStat:=(TCo as TTrayIcon).Hint;
        FormAndWrite(Section,tKey,tStat, CompoName);
        Continue;
      end;
      if CLS = TComboBox then begin
        tStat:=(TCo as TComboBox).TextHint;
        FormAndWrite(Section,tKey,tStat, CompoName);
        Continue;
      end;
      if CLS = TTabSheet then begin
        tStat:=(TCo as TTabSheet).Caption;
        FormAndWrite(Section,tKey,tStat, CompoName);
        Continue;
      end;
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
      if not support(CLS) then Continue;
      CLSN:=TCo.ClassName;
      TCoN:=TCo.name;
      TStr2:=CLSN+'_'+Tcon;

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

          TStr1:=(TCo as TButton).Hint;
          TStr2:=TStr2+'_Hint';
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TButton).Hint:=LanguageFile.ReadString(Section,TStr2,TStr1);
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
      if CLS = TTabSheet then
        begin
          TStr1:=(TCo as TTabSheet).Caption;
          ForComp:=LanguageFile.ReadString(Section,TStr2,NonEX);
          if ForComp<>NonEX then
            (TCo as TTabSheet).Caption:=LanguageFile.ReadString(Section,TStr2,TStr1);
          continue;
        end;
    end;
  CloseConf;
end;
end.
