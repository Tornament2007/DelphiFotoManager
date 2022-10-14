unit FileAttrOnTini;

interface
uses
  dialogs,IniFiles, sysUtils, Classes, strutils, StdCtrls, messages;

  Procedure OpenConf(FileName:String);
  Procedure CloseConf;
  Procedure ReAssignName(Index:String;FileName:String);

  Function ReadConf    (FileName:String; Attr:Integer):TstringList;
  Function ReadOneConf (FileName:String; Attr:Integer):String;
  Function WriteConf   (FileName,Attr,Stat:String;Indx:Integer):Boolean;

  Procedure ScanForMAttr(FileName,SText:String;Attr:Integer;DestObj:Tobject);
  Procedure ScanForAttrL(FileName:String;Attr:Integer;DestObj:TObject;Indx:Integer);

  Function FindIndex(FileName:String;MaxRange:Integer;CreateF:Boolean = false):Integer;

  Function TagM(Source, Stag: String): Boolean;

  Function SFF(Dir:String):integer;

Const
  ParamCount = 7;
  AttrName: array[1..ParamCount] of string = ('N', 'T', 'R', 'X', 'D', 'A', 'C');

  SuppEXT: array[1..13] of string = ('.bmp','.jpg','.jpe','.jfif','.jpeg',
    '.gif','.tif','.tiff','.tga','.png','.icon','.emf','.wmf');

var
    WorkConf:TiniFile;
implementation
uses FsP;

Procedure OpenConf(FileName:String);
begin
  if (WorkConf=nil) then
    WorkConf:= TiniFile.Create(ExtractFilePath(FileName)+'ImagesAttributes.INI');
end;

Procedure CloseConf;
begin
  FreeAndNil(WorkConf);
end;

Procedure ReAssignName(Index:String;FileName:String);
begin
  OpenConf(FileName);
    WorkConf.WriteString('File'+Index,'FileName',ExtractFileName(FileName));
  CloseConf;
end;

Function FindIndex(FileName:String;MaxRange:Integer;CreateF:Boolean = false):Integer;

  function DoSort(list: TStringList): TStringList;
  var
    i, j: Integer;
    temp: string;
  begin
    for i := 0 to list.Count - 1 do begin
    for j := i to ( list.Count - 1 ) do begin
      if (
      StrToInt(Copy(list.Strings[j],5,5))<StrToInt(Copy(list.Strings[i],5,5))
      ) then begin
        temp              := list.Strings[j];
        list.Strings[j]   := list.Strings[i];
        list.Strings[i]   := temp;
      end; // endif
    end; // endwhile
    end; // endwhile
    Result := list;
  end;

var
  TmpStr:string;
  NameSIndex:String;

  tI,tJ,tD:Integer;
  tTSl,tTS2:TstringList;
  DirName,FN,fFN:String;

begin
  OpenConf(FileName);

  tTSl:=TstringList.Create;
  WorkConf.ReadSections(tTSl);
  Result:=0;
  tD:=0;

  if tTSl.Count>0 then begin
    DirName:=ExtractFilePath(FileName);
    tTS2:=TstringList.Create;
    tI:=0;
    repeat
      FN:=AnsiLowerCase(WorkConf.ReadString(tTSl[tI],'FileName',''));
      fFN:=DirName+FN;

      if FileExists(fFN) then begin
        if (AnsiLowerCase(ExtractFileName(FileName))=AnsiLowerCase(FN))
        and (Result=0) then Result:=StrToInt(Copy(tTSl[tI],5,5));

        If tTS2.IndexOf(FN)=-1 then
          tTS2.Add(FN)
        else begin
          if tD=0 then tD:=StrToInt(Copy(tTSl[tI],5,5));
          WorkConf.EraseSection(tTSl[tI]); //del: duplicat
          //ShowMessage(FN+' A E'+tTSl[tI]);
        end;
      end else begin
        if tD=0 then tD:=StrToInt(Copy(tTSl[tI],5,5));
        WorkConf.EraseSection(tTSl[tI]);   //del: Notex
        //ShowMessage(FN+' D S'+tTSl[tI]);
      end;
      Inc(tI);
    until tI=tTSL.Count;

    if (tD=0) or (Result=0) then begin
      tTSl:=DoSort(tTSl);
      tI:=0;
      repeat
        tJ:=StrToInt(Copy(tTSl[tI],5,4));   // it was as tJ:=StrToInt(Copy(FN,5,4)); SHTAAA???
        if tI>tJ then begin
          tD:=tI;
          break;
        end;
        Inc(tI);
      until tI=tTSl.Count;
      if tD=0 then
        tD:=tJ+1;
    end;
  end else tD:=1;
  if (Result=0) and (CreateF) then
  begin
    if Result=0 then Result:=tD;

    NameSIndex:='File'+IntToStr(Result);
    WorkConf.WriteString(NameSIndex,'FileName',ExtractFileName(FileName));
    WorkConf.WriteString(NameSIndex,'Attr1','');
    WorkConf.WriteString(NameSIndex,'Attr2','');
    WorkConf.WriteString(NameSIndex,'Attr3','');
    WorkConf.WriteString(NameSIndex,'Attr4','');
    WorkConf.WriteString(NameSIndex,'Attr5','');
    WorkConf.WriteString(NameSIndex,'Attr6','');
    WorkConf.WriteString(NameSIndex,'Attr7','');
  end;
end;

Function ReadConf(FileName:String; Attr:Integer):TstringList;
{  attr:
/  1: Name
/  2: Theme
/  3: Raiting
/  4: Tags
/  5: Description
/  6: Author
/  7: Camera
\  If Attr in 1..7 then returns Index and 1 Attribute[Attr] (2 param total)
\  If Attr = 0 then returns Index and all 7 Attributes      (8 param total)
/  FileName: Path to Image(File)
}

  Procedure FillInfo(FileName:String);
  var F: TextFile;
  begin
    AssignFile(F, FileName);
    Rewrite(F);
    Writeln(F, '#  Attr:');
    Writeln(F, '#  1: Name');
    Writeln(F, '#  2: Theme');
    Writeln(F, '#  3: Rating');
    Writeln(F, '#  4: Tags');
    Writeln(F, '#  5: Description');
    Writeln(F, '#  6: Author');
    Writeln(F, '#  7: Camera');
    Writeln(F, '#  ToR.T_UAЩ (Aleksey Shaparenko)');
    Writeln(F, '#');
    Reset(F);
    CloseFile(F);
  end;

var
  I,Indx:Integer;
begin
  OpenConf(FileName);
  if Not FileExists(WorkConf.FileName) then
    begin
      FillInfo(WorkConf.FileName);

      WorkConf.WriteString('File1','FileName',ExtractFileName(FileName));
      WorkConf.WriteString('File1','Attr1','');
      WorkConf.WriteString('File1','Attr2','');
      WorkConf.WriteString('File1','Attr3','0');
      WorkConf.WriteString('File1','Attr4','');
      WorkConf.WriteString('File1','Attr5','');
      WorkConf.WriteString('File1','Attr6','');
      WorkConf.WriteString('File1','Attr7','');
      Indx:=1;
    end
  else
    begin
      Indx:= FindIndex(FileName,SFF(ExtractFileDir(FileName)),True);
    end;

  Result:=TStringList.Create;
  Result.Add(IntToStr(Indx));
  if attr=0 then begin
    I:=0;
    repeat
      inc(I);
      Result.Add(WorkConf.ReadString('File'+IntToStr(Indx),'Attr'+IntToStr(I),'nil'));
    until i=ParamCount;
  end else begin
    Result.Add(WorkConf.ReadString('File'+IntToStr(Indx),'Attr'+IntToStr(Attr),'nil'));
    //ShowMessage(WorkConf.ReadString('File'+IntToStr(Indx),'Attr'+IntToStr(Attr),'nil')+#13+IntTOStr(attr));
  end;
  CloseConf;
end;

Function ReadOneConf (FileName:String; Attr:Integer):String;
var
  TempS_:TStringList;
begin
  Result:='';
  if Attr=0 then Exit;

  TempS_:=TStringList.Create;
  TempS_:=ReadConf(FileName,Attr);
  Result:=TempS_[1];
  TempS_.Free;
end;


Function WriteConf(FileName,Attr,Stat:String;Indx:Integer):Boolean;
Var
  FileX:integer;
begin
  OpenConf(FileName);
    //Uses strutils;
    FileX:=ansiIndexText(Attr ,['N', 'T', 'R', 'X', 'D', 'A', 'C'])+1;
  WorkConf.WriteString('File'+IntToStr(Indx),'Attr'+IntToStr(FileX),Stat);
  Result:=WorkConf.ReadString('File'+IntToStr(Indx),'Attr'+IntToStr(FileX),'') = Stat;
  CloseConf;
end;

function TagM(Source, Stag: String): Boolean;
// TAG Match | есть ли Stag в Source;
var
  //Li1,
  tI_:Integer;
  SubText:String;
begin
  Result:=False;
  if (Trim(source)='') or (Trim(Stag)='') then exit;
  Source:=','+Source;
  if Source[Length(source)]<>',' then source:=source+',';
  if Stag[Length(Stag)]<>',' then Stag:=Stag+',';
  Source:=ANSILOWERCASE(Source);
  Stag:=ANSILOWERCASE(Stag);

  // allowed simbols , * ?

  Result:=True;
  //Li1:=0;      //Loop breaker
  repeat
    //Inc(Li1);
    tI_:=pos(',',Stag);

    if (Stag[1]='*') and (Stag[TI_-1]='*') then
      SubText:=Copy(Stag,2,tI_-3)
    else if (Stag[TI_-1]='*') then
      SubText:=','+Copy(Stag,1,tI_-2)
    else if (Stag[1]='*') then
      SubText:=Copy(Stag,2,tI_-1)
    else
      SubText:=','+Copy(Stag,1,tI_);
    // Next line for info
    //ConfForm.ConfLog.Lines.Add(SubText+' in '+Source+' - '+IntToStr(Ord(ContainsText(Source,SubText))));
    Result:= (Result) and (ContainsText(Source,SubText));
    if LengtH(Stag)=Ti_ then Exit;
    Stag:=Copy(Stag,Ti_+1,255);//Delete(Stag,1,tI_);
  until (Length(Stag)=0);       // or (li1=100)
end;

Procedure ScanForAttrL(FileName:String;Attr:Integer;DestObj:TObject;Indx:Integer);

 function ParseFRepeated(Line1,Line2:String):String;
 var
   tS:String;
 Begin
   Line1:=AnsiLowerCase(Line1);
   Line2:=AnsiLowerCase(Line2);
   if (Line2[Length(Line2)]<>',') then Line2:=Line2+',';

   repeat
     tS:=Copy(Line2,0,AnsiPos(',',Line2)-1);
     if (AnsiPos(tS,Line1)=0) then
       Line1:=Line1+','+tS;
     Line2:=Copy(Line2,AnsiPos(',',Line2)+1,Length(Line2));
   until (AnsiPos(',',Line2)=0);
   Result:=Line1;
 End;
 
var
  SFileName,SAttr,lastI:String;
  tS:String;
  I:Integer;
begin
  if (DestObj=nil) or (Not FileExists(FileName)) then exit;

  OpenConf(FileName);
  for I := 0 to SFF(ExtractFileDir(FileName)) do
  begin
    SFileName:=WorkConf.ReadString('File'+IntToStr(I),'FileName','nil');
      if (SFileName='nil') or (Trim(SFileName)='') then continue;
    SAttr:=WorkConf.ReadString('File'+IntToStr(I),'Attr'+IntToStr(Attr),'nil');
      if (SAttr='nil') or (Trim(SAttr)='') then continue;

    //indx 1=Day 2=Month 3=Year

    Ts:= Copy(ExtractDir(FileName,1),Sqr(indx)-ord(indx=3)*2,8);

    if DestObj.ClassName='TListBox' then
    with (DestObj as TlistBox) do begin
      if (Items.Count=0)
      or (AnsiPos(Copy(ExtractDir(FileName,1),Sqr(indx)-ord(indx=3)*2,8),Copy(items[Items.Count-1],0,8))=0)
      then
        Items.Add(AnsiLowerCase(Ts)+': '+SAttr)
      else
        Items[Items.Count-1]:=ParseFRepeated(items[Items.Count-1],SAttr);
    end else
    if DestObj.ClassName='TMemo' then
    with (DestObj as TMemo) do begin
      if (Lines.Count=0) or (Copy(Lines[Lines.Count-1],0,Length(ExtractDir(FileName,Indx)))<>ExtractDir(FileName,Indx)) then
        Lines.Add(ExtractDir(FileName,Indx)+': '+SAttr)
      else
        Lines[Lines.Count-1]:=ParseFRepeated(Lines[Lines.Count-1],SAttr);
    end;
  end;
  CloseConf;
end;

Procedure ScanForMAttr(FileName,SText:String;Attr:Integer;DestObj:Tobject);
var
  SFileName,SAttr:String;
  I:Integer;
begin
  if (DestObj=nil) or (Not FileExists(FileName)) then exit;

  OpenConf(FileName);
  for I := 0 to SFF(ExtractFileDir(FileName)) do
  begin
    SFileName:=WorkConf.ReadString('File'+IntToStr(I),'FileName','nil');
      if (SFileName='nil') or (Trim(SFileName)='') then continue;
    SAttr:=WorkConf.ReadString('File'+IntToStr(I),'Attr'+IntToStr(Attr),'nil');
      if (SAttr='nil') or (Trim(SAttr)='') then continue;

    //ExtractFilePath(FileName)+SFileName

    If (TagM(SAttr,Stext)) then
    if DestObj.ClassName='TListBox' then
      (DestObj as TlistBox).Items.Add(ExtractFilePath(FileName)+SFileName)
    else
      if DestObj.ClassName='TMemo' then
        (DestObj as TMemo).Lines.Add(ExtractFilePath(FileName)+SFileName);

  end;
  CloseConf;
end;

Function SFF(Dir:String):Integer;
var
  SR: TSearchRec;
  FindRes,I: Integer;
  FileEXT:String;
begin
  Result:=0;
  FindRes := FindFirst(Dir+'\*.*', faNormal, SR);
  while FindRes = 0 do begin
    if (((SR.Attr and faDirectory) = faDirectory)
    and ((SR.Name = '.') or (SR.Name = '..'))) then
      FindRes := FindNext(SR);
    FileEXT:=AnsiLowerCase(ExtractFileEXT(SR.Name));

    If MatchStr(FileEXT,SuppEXT) then
      Result:=Result+1;
    FindRes := FindNext(SR);
  end;
  FindClose(SR);
  //Result:=Result+Round(Result/2); //for now, while not fix indexing
end;

end.
