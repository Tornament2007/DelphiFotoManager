program ToRT_UA_Foto_Manager;

{$R *.dres}

uses
  windows,
  Dialogs,
  Forms,
  SysUtils,
  MainCode in 'Source\Forms\MainMenu\MainCode.pas' {MainForm},
  ConfCode in 'Source\Forms\ConfMenu\ConfCode.pas' {ConfForm},
  LookMenuCode in 'Source\Forms\FastLook\LookMenuCode.pas' {LookMenu},
  ProgSelectCode in 'Source\Forms\ProgSelect\ProgSelectCode.pas' {SelectProg},
  AttrMenuCode in 'Source\Forms\AttrMenu\AttrMenuCode.pas' {AttrMenu},
  TagSearchCode in 'Source\Forms\TagSearch\TagSearchCode.pas' {TagSearch},
  FastWordCode in 'Source\Forms\FastWord\FastWordCode.pas' {FastWord},
  RenItWFMenu in 'Source\UnitsSUses\RenItWFMenu.pas' {RenFilMenu},
  LanguageOperator in 'Source\UnitsSUses\LanguageOperator.pas',
  DropFileClass in 'Source\UnitsSUses\DropFileClass.pas',
  FileAttrOnTini in 'Source\UnitsSUses\FileAttrOnTini.pas',
  LicenseCode in 'Source\Forms\LicenseMenu\LicenseCode.pas' {LicenseMenu},
  FsP in 'Source\UnitsSUses\FsP.pas',
  uShell in 'Source\UnitsSUses\uShell.pas',
  MenuItemHint in 'Source\UnitsSUses\MenuItemHint.pas',
  kuDrag in 'Source\UnitsSUses\kuDrag.pas',
  FM_Spec in 'Source\UnitsSUses\FM_Spec.pas',
  ImageL_Index in 'Source\UnitsSUses\ImageL_Index.pas';

const
  ProgrammVersion = 'v0.024';

{$R *.res}

begin
  // ConfForm MUST BE LOADED LAST //
  Application.Initialize;
  Application.Title:='ToR.T_UA™  Foto Manager '+ProgrammVersion;

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TLookMenu, LookMenu);
  Application.CreateForm(TSelectProg, SelectProg);
  Application.CreateForm(TAttrMenu, AttrMenu);
  Application.CreateForm(TRenFilMenu, RenFilMenu);
  Application.CreateForm(TTagSearch, TagSearch);
  Application.CreateForm(TLicenseMenu, LicenseMenu);
  Application.CreateForm(TFastWord, FastWord);
  Application.CreateForm(TConfForm, ConfForm);
  //LAST
  //Showmessage(Application.Title);
  // ConfForm MUST BE LOADED LAST //
  Application.Run;
end.
