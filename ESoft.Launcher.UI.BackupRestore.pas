Unit ESoft.Launcher.UI.BackupRestore;

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
  Vcl.StdCtrls,
  Vcl.ActnList,
  System.Zip,
  ESoft.Utils;

Type
  TFormBackupRestore = Class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbRestore: TComboBox;
    btnCancel: TButton;
    btnRestore: TButton;
    ActionList: TActionList;
    alClose: TAction;
    Procedure alCloseExecute(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure btnRestoreClick(Sender: TObject);
    Procedure cbRestoreChange(Sender: TObject);
  Strict Private
    {Private declarations}
    Function FileNamePrifix(Const aIncludeFolder: Boolean = True): String;
  Public
    {Public declarations}
  End;

Var
  FormBackupRestore: TFormBackupRestore;

Implementation

{$R *.dfm}

Uses
  UnitMDIMain;

Procedure TFormBackupRestore.alCloseExecute(Sender: TObject);
Begin
  ModalResult := mrClose;
End;

Procedure TFormBackupRestore.btnRestoreClick(Sender: TObject);

  Procedure _ClearOldFiles;
  Begin
    DeleteFile(FormMDIMain.ParentFolder + 'Old_' + cConfig_INI);
    DeleteFile(FormMDIMain.ParentFolder + 'Old_' + cGroup_INI);
    DeleteFile(FormMDIMain.ParentFolder + 'Old_' + cParam_INI);

    RenameFile(FormMDIMain.ParentFolder + cConfig_INI, FormMDIMain.ParentFolder + 'Old_' + cConfig_INI);
    RenameFile(FormMDIMain.ParentFolder + cGroup_INI, FormMDIMain.ParentFolder + 'Old_' + cGroup_INI);
    RenameFile(FormMDIMain.ParentFolder + cParam_INI, FormMDIMain.ParentFolder + 'Old_' + cParam_INI);

    DeleteFile(FormMDIMain.ParentFolder + cConfig_INI);
    DeleteFile(FormMDIMain.ParentFolder + cGroup_INI);
    DeleteFile(FormMDIMain.ParentFolder + cParam_INI);
  End;

Var
  varZipFile: TZipFile;
  sZipFile: String;
Begin
  If MessageDlg('Are you sure you want to restore ?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo Then
    Exit;

  varZipFile := TZipFile.Create;
  Try
    sZipFile := FileNamePrifix + Trim(cbRestore.Text);
    If FileExists(sZipFile) Then
    Begin
      _ClearOldFiles;
      varZipFile.ExtractZipFile(sZipFile, FormMDIMain.ParentFolder);
      FormMDIMain.ReloadFromIni;
      ModalResult := mrOk;
    End;
  Finally
    varZipFile.Free;
  End;
End;

Procedure TFormBackupRestore.cbRestoreChange(Sender: TObject);
Begin
  btnRestore.Enabled := Trim(cbRestore.Text) <> '';
End;

Function TFormBackupRestore.FileNamePrifix(Const aIncludeFolder: Boolean = True): String;
Begin
  Result := cESoftLauncher + '_';
  If aIncludeFolder Then
    Result := FormMDIMain.BackupFolder + Result;
End;

Procedure TFormBackupRestore.FormCreate(Sender: TObject);
Var
  varSearch: TSearchRec;
  sFileNamePrifix: String;
Begin
  If FindFirst(FileNamePrifix + '*.zip', faArchive, varSearch) = 0 Then
  Begin
    Repeat
      cbRestore.Items.Add(StringReplace(varSearch.Name, FileNamePrifix(False), '', []));
    Until FindNext(varSearch) <> 0;
    FindClose(varSearch);
  End;
End;

End.
