program Downloader;

uses
  Vcl.Forms,
  UnitMDIMain in 'UnitMDIMain.pas' {Form1},
  ESoft.UI.Downloader in 'ESoft.UI.Downloader.pas' {FormDownloader},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
