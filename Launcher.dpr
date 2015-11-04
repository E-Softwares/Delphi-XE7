Program Launcher;

{----------------------------------------------------------}
{Developed by Muhammad Ajmal p}
{ajumalp@gmail.com}
{----------------------------------------------------------}

uses
  Vcl.Forms,
  UnitMDIMain in 'UnitMDIMain.pas' {FormMDIMain},
  Vcl.Themes,
  Vcl.Styles,
  ESoft.Launcher.Application in 'ESoft.Launcher.Application.pas',
  ESoft.Launcher.UI.AppGroupEditor in 'ESoft.Launcher.UI.AppGroupEditor.pas' {FormAppGroupEditor},
  ESoft.Launcher.Parameter in 'ESoft.Launcher.Parameter.pas',
  ESoft.Launcher.UI.ParamEditor in 'ESoft.Launcher.UI.ParamEditor.pas' {FormParamEditor},
  ESoft.Launcher.UI.ParamBrowser in 'ESoft.Launcher.UI.ParamBrowser.pas' {FormParameterBrowser},
  ESoft.Utils in 'ESoft.Utils.pas',
  ESoft.Launcher.UI.BackupRestore in 'ESoft.Launcher.UI.BackupRestore.pas' {FormBackupRestore};

{$R *.res}

Begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Launcher';
  Application.CreateForm(TFormMDIMain, FormMDIMain);
  Application.Run;

End.
