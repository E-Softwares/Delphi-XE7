Unit ESoft.Launcher.UI.ParamEditor;

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
  ESoft.Launcher.Parameter;

Type
  TFormParamEditor = Class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TButton;
    btnOK: TButton;
    Label5: TLabel;
    Label1: TLabel;
    edtParameter: TButtonedEdit;
    edtParamName: TButtonedEdit;
    chkDefaultInclude: TCheckBox;
    chkConnectionParam: TCheckBox;
    cbConnections: TComboBox;
    Label2: TLabel;
    Procedure chkConnectionParamClick(Sender: TObject);
    Procedure btnOKClick(Sender: TObject);
    Procedure edtParamNameKeyPress(
      Sender: TObject;
      Var Key: Char);
    Procedure edtParamNameRightButtonClick(Sender: TObject);
    Procedure FormActivate(Sender: TObject);
    Procedure cbConnectionsExit(Sender: TObject);

  Private
    // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
  Strict Private
    // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
    FInitialized: Boolean;
    FParameter: TEParameterBase;

  Public
    {Public declarations}
    Constructor Create(
      aOwner: TComponent;
      Const aParameter: TEParameterBase = Nil); Reintroduce;

    Procedure LoadData;

  Published
    Property Parameter: TEParameterBase Read FParameter;
  End;

Var
  FormParamEditor: TFormParamEditor;

Implementation

{$R *.dfm}

Uses
  UnitMDIMain;
{TFormParamEditor}

Procedure TFormParamEditor.btnOKClick(Sender: TObject);
Var
  iParameterType: Integer;
Begin
  cbConnectionsExit(Nil);

  If chkConnectionParam.Checked Then
    iParameterType := cParamTypeConnection
  Else
    iParameterType := cParamTypeAdditional;

  If Not Assigned(FParameter) Then
  Begin
    If Trim(edtParamName.Text) = '' Then
    Begin
      MessageDlg('Name cannot be empty', mtError, [mbOK], 0);
      Abort;
    End;
    FParameter := FormMDIMain.Parameters.AddItem(edtParamName.Text, iParameterType);
  End;
  Parameter.Name := edtParamName.Text;
  Parameter.Parameter := edtParameter.Text;
  Case iParameterType Of
    cParamTypeConnection:
      Begin
        TEConnectionParameter(FParameter).Connection := cbConnections.Text;
      End;
    cParamTypeAdditional:
      Begin
        TEAdditionalParameter(FParameter).DefaultInclude := chkDefaultInclude.Checked;
      End;
  End;
  Parameter.SaveData(FormMDIMain.ParentFolder + cParam_INI);
  ModalResult := mrOk;
End;

Procedure TFormParamEditor.cbConnectionsExit(Sender: TObject);
Begin
  If (cbConnections.Text <> '') And ((cbConnections.Items.IndexOf(cbConnections.Text)) = -1) Then
  Begin
    MessageDlg('Invalid connection', mtError, [mbOK], 0);
    Abort;
  End;
End;

Procedure TFormParamEditor.chkConnectionParamClick(Sender: TObject);
Begin
  chkDefaultInclude.Enabled := Not chkConnectionParam.Checked;
  cbConnections.Enabled := chkConnectionParam.Checked;
End;

Constructor TFormParamEditor.Create(
  aOwner: TComponent;
  Const aParameter: TEParameterBase);
Begin
  FInitialized := False;
  Inherited Create(aOwner);

  FParameter := aParameter;
  edtParamName.Enabled := Not Assigned(FParameter);
  chkConnectionParam.Enabled := edtParamName.Enabled;
End;

Procedure TFormParamEditor.edtParamNameKeyPress(
  Sender: TObject;
  Var Key: Char);
Begin
  If Not(key In ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '_', ' ', #46, #8]) Then
    Abort;
End;

Procedure TFormParamEditor.edtParamNameRightButtonClick(Sender: TObject);
Begin
  TButtonedEdit(Sender).Text := '';
End;

Procedure TFormParamEditor.FormActivate(Sender: TObject);
Begin
  If Not FInitialized Then
  Begin
    FInitialized := True;
    // Reload connections. { Ajmal }
    FormMDIMain.Connections.LoadConnections;
    cbConnections.Items.AddStrings(FormMDIMain.Connections.Connections);
    If Assigned(FParameter) Then
      LoadData;
  End;
End;

Procedure TFormParamEditor.LoadData;
Begin
  chkConnectionParamClick(Nil);

  edtParamName.Text := Parameter.Name;
  edtParameter.Text := Parameter.Parameter;
  chkConnectionParam.Checked := Parameter Is TEConnectionParameter;
  If Not chkConnectionParam.Checked Then
    chkDefaultInclude.Checked := TEAdditionalParameter(Parameter).DefaultInclude
  Else
    cbConnections.ItemIndex := cbConnections.Items.IndexOf(TEConnectionParameter(Parameter).Connection);
End;

End.
