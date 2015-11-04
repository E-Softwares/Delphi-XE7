Unit UnitMDIMain;

Interface

Uses
   Winapi.Windows,
   Winapi.Messages,
   System.SysUtils,
   System.Variants,
   System.Classes,
   Vcl.Graphics,
   Vcl.Controls,
   Vcl.Forms,
   Vcl.Dialogs,
   Wininet,
   Vcl.StdCtrls;

Type
   TForm1 = Class(TForm)
      Button1: TButton;
      Procedure Button1Click(Sender: TObject);
   Private
      { Private declarations }
   Public
      { Public declarations }
   End;

Var
   Form1: TForm1;

Implementation

{$R *.dfm}

Uses
   ESoft.UI.Downloader;

Const
   cURL = 'http://esoft.ucoz.com/Downloads/Launcher/Launcher.zip';
   cFileName = 'E:\Test\Launcher.zip';

Procedure TForm1.Button1Click(Sender: TObject);
Var
   varDownloader: IEDownloadManager;
Begin
   varDownloader := TEDownloadManager.Create(Self);
   varDownloader.Add(cURL, cFileName);
   varDownloader.Add('http://esoft.ucoz.com/Downloads/SIIJ.rar', 'E:\Test\SIIJ.jar');
   varDownloader.Add('http://esoft.ucoz.com/Downloads/RchrgMgr.zip', 'E:\Test\RchrgMgr.zip');
   varDownloader.Download;
End;

End.
