Unit ESoft.Launcher.UI.AppGroupEditor;

{----------------------------------------------------------}
{Developed by Muhammad Ajmal p}
{ajumalp@gmail.com}
{----------------------------------------------------------}

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
  Vcl.ExtCtrls,
  Vcl.FileCtrl,
  ESoft.Launcher.Application,
  Vcl.Buttons;

Type
  TFormAppGroupEditor = Class(TForm)
    GroupBox2: TGroupBox;
    Label2: TLabel;
    sBtnBrowseAppSource: TSpeedButton;
    Label3: TLabel;
    sBtnBrowseAppDest: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    edtAppSource: TButtonedEdit;
    edtAppDest: TButtonedEdit;
    edtFileMask: TButtonedEdit;
    edtExeName: TButtonedEdit;
    btnCancel: TButton;
    btnOK: TButton;
    Label1: TLabel;
    edtGroupName: TButtonedEdit;
    Label6: TLabel;
    edtFixedParams: TButtonedEdit;
    chkCreateFolder: TCheckBox;
    chkIsApplication: TCheckBox;
    Procedure sBtnBrowseAppSourceClick(Sender: TObject);
    Procedure btnOKClick(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure edtAppSourceRightButtonClick(Sender: TObject);
    Procedure edtGroupNameKeyPress(
      Sender: TObject;
      Var Key: Char);
    Procedure edtGroupNameEnter(Sender: TObject);
    Procedure edtGroupNameChange(Sender: TObject);
    Procedure FormClose(
      Sender: TObject;
      Var Action: TCloseAction);
    Procedure chkIsApplicationClick(Sender: TObject);
  Private
    // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
  Strict Private
    // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
    FInitialized: Boolean;
    FUpdateFileMakWithName: Boolean;
    FAppGroup: TEApplicationGroup;
  Public
    {Public declarations}
    Constructor Create(
      aOwner: TComponent;
      Const aAppGroup: TEApplicationGroup = Nil); Reintroduce;

    Procedure LoadData;

  Published
    Property AppGroup: TEApplicationGroup Read FAppGroup;
  End;

Var
  FormAppGroupEditor: TFormAppGroupEditor;

Implementation

{$R *.dfm}

Uses
  UnitMDIMain;

Procedure TFormAppGroupEditor.btnOKClick(Sender: TObject);
Begin
  If Not Assigned(FAppGroup) Then
  Begin
    If Trim(edtGroupName.Text) = '' Then
    Begin
      MessageDlg('Name cannot be empty', mtError, [mbOK], 0);
      Abort;
    End;
    FAppGroup := FormMDIMain.AppGroups.AddItem(edtGroupName.Text);
  End;
  AppGroup.FixedParameter := edtFixedParams.Text;
  AppGroup.ExecutableName := edtExeName.Text;
  AppGroup.Name := edtGroupName.Text;
  AppGroup.SourceFolder := edtAppSource.Text;
  AppGroup.DestFolder := edtAppDest.Text;
  AppGroup.FileMask := edtFileMask.Text;
  AppGroup.CreateFolder := chkCreateFolder.Checked;
  AppGroup.IsApplication := chkIsApplication.Checked;
  AppGroup.SaveData(FormMDIMain.ParentFolder + cGroup_INI);
  ModalResult := mrOk;
End;

Procedure TFormAppGroupEditor.chkIsApplicationClick(Sender: TObject);
Begin
  edtAppDest.Enabled := Not chkIsApplication.Checked;
  edtFileMask.Enabled := Not chkIsApplication.Checked;
  chkCreateFolder.Enabled := Not chkIsApplication.Checked;
End;

Constructor TFormAppGroupEditor.Create(
  aOwner: TComponent;
  Const aAppGroup: TEApplicationGroup);
Begin
  FInitialized := False;
  Inherited Create(aOwner);

  FAppGroup := aAppGroup;
  edtGroupName.Enabled := Not Assigned(FAppGroup);
End;

Procedure TFormAppGroupEditor.edtAppSourceRightButtonClick(Sender: TObject);
Begin
  TButtonedEdit(Sender).Text := '';
End;

Procedure TFormAppGroupEditor.edtGroupNameChange(Sender: TObject);
Begin
  If FUpdateFileMakWithName Then
    edtFileMask.Text := edtGroupName.Text;
End;

Procedure TFormAppGroupEditor.edtGroupNameEnter(Sender: TObject);
Begin
  FUpdateFileMakWithName := (edtFileMask.Text = '') Or (edtFileMask.Text = edtGroupName.Text);
End;

Procedure TFormAppGroupEditor.edtGroupNameKeyPress(
  Sender: TObject;
  Var Key: Char);
Begin
  If Not(key In ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '_', ' ', #46, #8]) Then
    Abort;
End;

Procedure TFormAppGroupEditor.FormActivate(Sender: TObject);
Begin
  If Not FInitialized Then
  Begin
    FInitialized := True;
    If Assigned(FAppGroup) Then
      LoadData;
  End;
End;

Procedure TFormAppGroupEditor.FormClose(
  Sender: TObject;
  Var Action: TCloseAction);
Begin
  If ModalResult = mrOk Then
    FormMDIMain.UpdateApplicationList;
End;

Procedure TFormAppGroupEditor.LoadData;
Begin
  edtFixedParams.Text := AppGroup.FixedParameter;
  edtExeName.Text := AppGroup.ExecutableName;
  edtGroupName.Text := AppGroup.Name;
  edtAppSource.Text := AppGroup.SourceFolder;
  edtAppDest.Text := AppGroup.DestFolder;
  edtFileMask.Text := AppGroup.FileMask;
  chkCreateFolder.Checked := AppGroup.CreateFolder;
  chkIsApplication.Checked := AppGroup.IsApplication;
  chkIsApplicationClick(Nil);
End;

Procedure TFormAppGroupEditor.sBtnBrowseAppSourceClick(Sender: TObject);
Var
  sPath: String;
Begin
  If SelectDirectory('Select a folder', '', sPath, [sdNewFolder, sdShowEdit], Self) Then
  Begin
    If Sender = sBtnBrowseAppSource Then
    Begin
      edtAppSource.Text := sPath;
      If edtAppDest.Text = '' Then
        edtAppDest.Text := sPath;
    End
    Else If Sender = sBtnBrowseAppDest Then
      edtAppDest.Text := sPath;
  End;
End;

End.
