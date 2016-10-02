Program Launcher;

{ ---------------------------------------------------------- }
{ Developed by Muhammad Ajmal p }
{ ajumalp@gmail.com }
{ ---------------------------------------------------------- }

Uses
   Vcl.Forms,
   UnitMDIMain In 'UnitMDIMain.pas' {FormMDIMain} ,
   ESoft.Launcher.Application In 'ESoft.Launcher.Application.pas',
   ESoft.Launcher.UI.AppGroupEditor In 'ESoft.Launcher.UI.AppGroupEditor.pas' {FormAppGroupEditor} ,
   ESoft.Launcher.Parameter In 'ESoft.Launcher.Parameter.pas',
   ESoft.Launcher.UI.ParamEditor In 'ESoft.Launcher.UI.ParamEditor.pas' {FormParamEditor} ,
   ESoft.Launcher.UI.ParamBrowser In 'ESoft.Launcher.UI.ParamBrowser.pas' {FormParameterBrowser} ,
   ESoft.Utils In 'ESoft.Utils.pas',
   ESoft.Launcher.UI.BackupRestore In 'ESoft.Launcher.UI.BackupRestore.pas' {FormBackupRestore} ,
   ESoft.Launcher.RecentItems In 'ESoft.Launcher.RecentItems.pas',
   ESoft.Launcher.Clipboard In 'ESoft.Launcher.Clipboard.pas';

{$R *.res}

Begin
   ReportMemoryLeaksOnShutdown := DebugHook <> 0;

   Application.Initialize;
   Application.MainFormOnTaskbar := True;
   Application.Title := 'Launcher';
   Application.CreateForm(TFormMDIMain, FormMDIMain);
   Application.Run;

End.
