unit EditorProgClass;

interface

uses
  SysUtils;

type
  TEditorProgramm = class
  protected
    { Protected declarations }
  published
    { Published declarations }
  private
    { Private declarations }
    ep_vS_NoName,ep_vS_SetMe,ep_vS_EditWith,
    epName,epPath, epCmplName:String;
    procedure edChangeName(incName:String);
    procedure edChangePath(incPath:String);
  public
    { Public declarations }
    constructor Create(NoNameMSG, SetNeMSG, EditWithMSG: String);

    Property ComplitName:String read epCmplName;
    property Name: String read epName write edChangeName;
    property Path: String read epPath write edChangePath;

    property NoNameMSG: String Read ep_vS_NoName;
    property SetMeMSG: String Read ep_vS_SetMe;
  end;

implementation

{ EditorProgramm }

constructor TEditorProgramm.Create(NoNameMSG, SetNeMSG, EditWithMSG: String);
begin
  if (NoNameMSG='') or (SetNeMSG='') or (EditWithMSG='') then
  begin
    self.destroy;
  end;
  ep_vS_NoName:=NoNameMSG;
  ep_vS_SetMe:=SetNeMSG;
  epPath:='';
  epName:=SetNeMSG;
end;

procedure TEditorProgramm.edChangeName(incName: String);
begin
  epName:=incName;
  if Not FileExists(epPath) then
  begin
    epCmplName:=ep_vS_SetMe;
  end
  else
  begin
    if incName='' then
      epCmplName:=ep_vS_EditWith+'"'+ep_vS_NoName+'"'
    else
      epCmplName:=ep_vS_EditWith+'"'+incName+'"';
  end;
end;

procedure TEditorProgramm.edChangePath(incPath: String);
begin
  if Not FileExists(incPath) then
    epPath:=''
  else
  begin
    if AnsiLOwerCase(incPath)<>AnsiLOwerCase(epPath) then
      epPath:=incPath;
  end;
end;

end.
