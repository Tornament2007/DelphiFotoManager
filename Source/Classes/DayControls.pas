unit DayControls;

interface

uses
  SysUtils;

type
  TDayControl = class
  protected
    { Protected declarations }
  published
    { Published declarations }
  private
    { Private declarations }
    iv_day,iv_mon,iv_yea,
    iv_day_p,iv_mon_p,iv_yea_p,

    iv_sday,iv_smon,iv_syea,
    iv_sday_p,iv_smon_p,iv_syea_p,

    iv_lday,iv_lmon,iv_lyea:String;

    WorkingDir:String;

    Procedure SetWorkingDir(WDirectory:String);

    Procedure ReformToday;

    Procedure ReadSday(IncStr:String);
    Procedure ReadSmon(IncStr:String);
    Procedure ReadSyea(IncStr:String);

    Function IfTodayEx:Boolean;
    Function IfTomonEx:Boolean;
    Function IfToyeaEx:Boolean;

    Function IfSdayEx:Boolean;
    Function IfSmonEx:Boolean;
    Function IfSyeaEx:Boolean;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy;


    property Day: String read iv_day;
    property Mon: String read iv_mon;
    property Yea: String read iv_yea;

    property DayPath: String read iv_day_p;
    property MonPath: String read iv_mon_p;
    property YeaPath: String read iv_yea_p;

    property SeDay: String read iv_sday write ReadSday;
    property SeMon: String read iv_smon write ReadSmon;
    property SeYea: String read iv_syea write ReadSyea;

    property SeDayPath: String read iv_sday_p;
    property SeMonPath: String read iv_smon_p;
    property SeYeaPath: String read iv_syea_p;

    property DayEx: Boolean read IfTodayEx;
    property MonEx: Boolean read IfTomonEx;
    property YeaEx: Boolean read IfToyeaEx;

    property SDayEx: Boolean read IfSdayEx;
    property SMonEx: Boolean read IfSmonEx;
    property SYeaEx: Boolean read IfSyeaEx;

    //property LSDay: String read iv_lday write ;
    //property LSSeMon: String read iv_lmon write ;
    //property LSSeYea: String read iv_lyea write ;
  end;

implementation

{ EditorProgramm }


{ TDayControl }

constructor TDayControl.Create;
begin
//
end;

destructor TDayControl.Destroy;
begin
//
end;

function TDayControl.IfSdayEx: Boolean;
begin
  result:=DirectoryExists(iv_Sday_p);
end;

function TDayControl.IfSmonEx: Boolean;
begin
  result:=DirectoryExists(iv_Smon_p);
end;

function TDayControl.IfSyeaEx: Boolean;
begin
  result:=DirectoryExists(iv_Syea_p);
end;

function TDayControl.IfTodayEx: Boolean;
begin
  result:=DirectoryExists(iv_day_p);
end;

function TDayControl.IfTomonEx: Boolean;
begin
  result:=DirectoryExists(iv_mon_p);
end;

function TDayControl.IfToyeaEx: Boolean;
begin
  result:=DirectoryExists(iv_yea_p)
end;

procedure TDayControl.ReadSday(IncStr: String);
begin


//
end;

procedure TDayControl.ReadSmon(IncStr: String);
begin
//
end;

procedure TDayControl.ReadSyea(IncStr: String);
begin
//
end;

procedure TDayControl.ReformToday;
begin
  iv_day:=FormatDateTime('dd', Date);
  iv_mon:=FormatDateTime('mm', Date);
  iv_yea:=FormatDateTime('yyyy', Date);

  iv_yea_p:=WorkingDir+iv_day+'\';
  iv_mon_p:=iv_yea_p+IntToStr(StrToInt(iv_mon))+'_'+FormatDateTime('mmmm', Date)+'\';
  iv_day_p:=iv_mon_p+'\'+iv_day+'.'+iv_mon+'.'+FormatDateTime('yy', Date)+'\';
end;

procedure TDayControl.SetWorkingDir(WDirectory: String);
begin
  if WDirectory[length(WDirectory)]<>'\' then
    WorkingDir:=WDirectory+'\'
  else
    WorkingDir:=WDirectory;
end;

end.
