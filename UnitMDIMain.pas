Unit UnitMDIMain;

{ ---------------------------------------------------------- }
{ Developed by Muhammad Ajmal p }
{ ajumalp@gmail.com }
{ ---------------------------------------------------------- }

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
   ShlObj,
   Vcl.Dialogs,
   Vcl.StdCtrls,
   Vcl.ExtCtrls,
   Vcl.ImgList,
   IniFiles,
   URLMon,
   Generics.Collections,
   Vcl.Buttons,
   Vcl.Menus,
   Vcl.FileCtrl,
   Vcl.AppEvnts,
   Vcl.ComCtrls,
   ESoft.Launcher.Application,
   ESoft.Launcher.Parameter,
   System.Zip,
   ESoft.Utils,
   IdBaseComponent,
   IdComponent,
   IdTCPConnection,
   IdTCPClient,
   IdHTTP,
   ShellApi,
   WinInet,
   BackgroundWorker;

Const
   cESoftLauncher = 'ESoft_Launcher';
   cV6_FOLDER = 'C:\Users\All Users\SoftTech\V6\';
   cConnection_INI = 'V6ConnectionIds.ini';
   cConfig_INI = 'Config.ini';
   cGroup_INI = 'Group.eini';
   cParam_INI = 'Params.eini';
   cConnectionState = 'CONNECTION_STATE';

Type
   TFormMDIMain = Class(TForm)
      pnlConnection: TPanel;
      Label1: TLabel;
      edtConnection: TButtonedEdit;
      sBtnBrowseConnection: TSpeedButton;
      OpenDialog: TOpenDialog;
      ImageList: TImageList;
      TrayIcon: TTrayIcon;
      PopupMenuTray: TPopupMenu;
      ApplicationEvents: TApplicationEvents;
      PMItemExit: TMenuItem;
      N1: TMenuItem;
      PMItemShowHide: TMenuItem;
      N2: TMenuItem;
      PMItemApplications: TMenuItem;
      PopupMenuListView: TPopupMenu;
      PMItemEditGroup: TMenuItem;
      PMItemAddGroup: TMenuItem;
      N3: TMenuItem;
      PMItemUpdate: TMenuItem;
      PMItemDeleteGroup: TMenuItem;
      tvApplications: TTreeView;
      MainMenu: TMainMenu;
      MenuSettings: TMenuItem;
      MenuFile: TMenuItem;
      N4: TMenuItem;
      MItemExit: TMenuItem;
      MItemShowHide: TMenuItem;
      MItemStartMinimized: TMenuItem;
      MItemParameters: TMenuItem;
      PanelDeveloper: TPanel;
      MItemConnections: TMenuItem;
      MItemAutoStart: TMenuItem;
      PMItemTrayUpdate: TMenuItem;
      N5: TMenuItem;
      MItemBackup: TMenuItem;
      MItemRestore: TMenuItem;
      MItemAutobackup: TMenuItem;
      MenuHelp: TMenuItem;
      PMItemCheckforupdate: TMenuItem;
      Procedure sBtnBrowseConnectionClick(Sender: TObject);
      Procedure edtConnectionRightButtonClick(Sender: TObject);
      Procedure FormCreate(Sender: TObject);
      Procedure FormDestroy(Sender: TObject);
      Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
      Procedure FormHide(Sender: TObject);
      Procedure PMItemShowHideClick(Sender: TObject);
      Procedure PMItemExitClick(Sender: TObject);
      Procedure PMItemEditGroupClick(Sender: TObject);
      Procedure PopupMenuListViewPopup(Sender: TObject);
      Procedure PMItemUpdateClick(Sender: TObject);
      Procedure PMItemDeleteGroupClick(Sender: TObject);
      Procedure PMItemAddGroupClick(Sender: TObject);
      Procedure tvApplicationsDblClick(Sender: TObject);
      Procedure PopupMenuTrayPopup(Sender: TObject);
      Procedure ApplicationEventsActivate(Sender: TObject);
      Procedure MItemParametersClick(Sender: TObject);
      Procedure MItemConnectionsClick(Sender: TObject);
      Procedure MItemAutoStartClick(Sender: TObject);
      Procedure MItemBackupClick(Sender: TObject);
      Procedure MItemRestoreClick(Sender: TObject);
      Procedure ApplicationEventsMinimize(Sender: TObject);
      Procedure PMItemCheckforupdateClick(Sender: TObject);
   Private
      // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
   Strict Private
      // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
      FLastUsedParamCode: String;
      FRunAsAdmin: Boolean;
      FParameters: TEParameters;
      FInitialized: Boolean;
      FAppGroups: TEApplicationGroups;
      FParentFolder: String;
      FConnections: TEConnections;

      Procedure OpenParamBrowser(Const aApplication: IEApplication = Nil);
      Procedure LoadConfig;
      Procedure SaveConfig;
      Function GetConnections: TEConnections;
      Function GetAppGroups: TEApplicationGroups;
      Function GetParameters: TEParameters;
      Procedure DeleteOldBackups;

   Public
      { Public declarations }
      Function BackupFolder: String;
      Procedure UpdateApplicationList;
      Procedure ReloadFromIni;

   Published
      Property AppGroups: TEApplicationGroups Read GetAppGroups;
      Property Parameters: TEParameters Read GetParameters;
      Property Connections: TEConnections Read GetConnections;
      Property ParentFolder: String Read FParentFolder;
      Property RunAsAdmin: Boolean Read FRunAsAdmin Write FRunAsAdmin;
      Property LastUsedParamCode: String Read FLastUsedParamCode Write FLastUsedParamCode;
   End;

Var
   FormMDIMain: TFormMDIMain;

Implementation

{$R *.dfm}

Uses
   ESoft.Launcher.UI.AppGroupEditor,
   ESoft.Launcher.UI.ParamBrowser,
   ESoft.UI.Downloader,
   ESoft.Launcher.UI.BackupRestore;

Const
   cApplication_Version = 1002;

   cIMG_HIDE = 40;
   cIMG_SHOW = 41;

   cAppZipFileNameInSite = 'http://esoft.ucoz.com/Downloads/Launcher/Launcher.zip';
   cUniqueAppVersionCode = 'ESoft_Launcher';
   cConfigBasic = 'Basic';
   cConfigFileName = 'FileName';
   cConfigStartMinimized = 'StartMinimized';
   cConfigRunAsAdmin = 'RunAsAdmin';
   cConfigLastUsedParam = 'LastUsedParam';
   cConfigAutoBackUpOnExit = 'AutoBackUpOnExit';
   cBackups = 'Backups\';

   { TFormMDIMain }
Procedure TFormMDIMain.ApplicationEventsActivate(Sender: TObject);
Var
   Mutex: THandle;
Begin
   If Not FInitialized Then
   Begin
      FInitialized := True;
      Mutex := CreateMutex(Nil, False, cESoftLauncher);
      If WaitForSingleObject(Mutex, 0) = WAIT_TIMEOUT Then
      Begin
         MessageDlg('Aplication is already running.' + sLineBreak + 'Only single instance allowed.', mtError, [mbOK], 0);
         Application.Terminate;
      End;
      Visible := Not MItemStartMinimized.Checked;
      UpdateApplicationList;
   End;
End;

Procedure TFormMDIMain.ApplicationEventsMinimize(Sender: TObject);
Begin
   Hide;
End;

Function TFormMDIMain.BackupFolder: String;
Begin
   Result := ParentFolder + cBackups;
End;

Procedure TFormMDIMain.edtConnectionRightButtonClick(Sender: TObject);
Begin
   Connections.FileName := '';
   edtConnection.Text := Connections.FileName;
End;

Procedure TFormMDIMain.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
   SaveConfig;
End;

Procedure TFormMDIMain.FormCreate(Sender: TObject);
Begin
   PanelDeveloper.Caption := 'Developed by Muhammad Ajmal P';
   FInitialized := False;
   FParentFolder := ExtractFilePath(ParamStr(0));
   MItemAutoStart.Checked := AddToStartup(cESoftLauncher, REG_READ);

   LoadConfig;
   edtConnection.Text := Connections.FileName;
End;

Procedure TFormMDIMain.FormDestroy(Sender: TObject);
Begin
   If Assigned(FConnections) Then
      FConnections.Free;
   If Assigned(FParameters) Then
   Begin
      Parameters.SaveData(ParentFolder + cParam_INI);
      FParameters.Free;
   End;
   If Assigned(FAppGroups) Then
   Begin
      AppGroups.SaveData(ParentFolder + cGroup_INI);
      FAppGroups.Free;
   End;
End;

Procedure TFormMDIMain.FormHide(Sender: TObject);
Begin
   TrayIcon.ShowBalloonHint;
End;

Function TFormMDIMain.GetAppGroups: TEApplicationGroups;
Begin
   If FAppGroups = Nil Then
   Begin
      FAppGroups := TEApplicationGroups.Create;
      FAppGroups.LoadData(ParentFolder + cGroup_INI);
   End;

   Result := FAppGroups;
End;

Function TFormMDIMain.GetConnections: TEConnections;
Begin
   If FConnections = Nil Then
      FConnections := TEConnections.Create;
   Result := FConnections;
End;

Function TFormMDIMain.GetParameters: TEParameters;
Begin
   If Not Assigned(FParameters) Then
   Begin
      FParameters := TEParameters.Create;
      FParameters.LoadData(ParentFolder + cParam_INI);
   End;
   Result := FParameters;
End;

Procedure TFormMDIMain.LoadConfig;
Var
   varIniFile: TIniFile;
Begin
   varIniFile := TIniFile.Create(ParentFolder + cConfig_INI);
   Try
      MItemAutobackup.Checked := varIniFile.ReadBool(cConfigBasic, cConfigAutoBackUpOnExit, False);
      MItemStartMinimized.Checked := varIniFile.ReadBool(cConfigBasic, cConfigStartMinimized, True);
      RunAsAdmin := varIniFile.ReadBool(cConfigBasic, cConfigRunAsAdmin, False);
      LastUsedParamCode := varIniFile.ReadString(cConfigBasic, cConfigLastUsedParam, '');
      Connections.FileName := varIniFile.ReadString(cConfigBasic, cConfigFileName, '');
   Finally
      varIniFile.Free;
   End;
End;

Procedure TFormMDIMain.MItemAutoStartClick(Sender: TObject);
Begin
   MItemAutoStart.Checked := Not MItemAutoStart.Checked;
   If MItemAutoStart.Checked Then
      AddToStartup(cESoftLauncher, REG_ADD)
   Else
      AddToStartup(cESoftLauncher, REG_DELETE);
End;

Procedure TFormMDIMain.DeleteOldBackups;
Var
   varSearch: TSearchRec;
   sFileNamePrifix: String;
Begin
   sFileNamePrifix := BackupFolder + cESoftLauncher + '_' + FormatDateTime(cUniqueFileDateFormat, Date - 1);
   If FindFirst(sFileNamePrifix + '*.zip', faArchive, varSearch) = 0 Then
   Begin
      Repeat
         If Not StrStartsWith(BackupFolder + varSearch.Name, sFileNamePrifix, False) Then
            DeleteFile(BackupFolder + varSearch.Name);
      Until FindNext(varSearch) <> 0;
      FindClose(varSearch);
   End;
End;

Procedure TFormMDIMain.MItemBackupClick(Sender: TObject);
Var
   varZipFile: TZipFile;

   Procedure _AddFileToZip(Const aFileName: String);
   Begin
      If FileExists(aFileName) Then
         varZipFile.Add(aFileName);
   End;

Var
   sZipFileName: String;
Begin
   If Not DirectoryExists(BackupFolder) Then
   Begin
      If Not ForceDirectories(BackupFolder) Then
         Raise Exception.Create('Access denied. Cannot create backup folder.');
   End;

   DeleteOldBackups;
   varZipFile := TZipFile.Create;
   Try
      sZipFileName := GetUniqueFilename(BackupFolder, '.zip', cESoftLauncher + '_');
      varZipFile.Open(sZipFileName, zmWrite);
      _AddFileToZip(ParentFolder + cConfig_INI);
      _AddFileToZip(ParentFolder + cGroup_INI);
      _AddFileToZip(ParentFolder + cParam_INI);
      varZipFile.Close;
   Finally
      varZipFile.Free;
   End;
End;

Procedure TFormMDIMain.MItemConnectionsClick(Sender: TObject);
Begin
   pnlConnection.Visible := MItemConnections.Checked;
End;

Procedure TFormMDIMain.MItemParametersClick(Sender: TObject);
Begin
   OpenParamBrowser;
End;

Procedure TFormMDIMain.MItemRestoreClick(Sender: TObject);
Begin
   FormBackupRestore := TFormBackupRestore.Create(Self);
   Try
      FormBackupRestore.ShowModal;
   Finally
      FormBackupRestore.Free;
   End;
End;

Procedure TFormMDIMain.OpenParamBrowser(Const aApplication: IEApplication);
Begin
   FormParameterBrowser := TFormParameterBrowser.Create(Self, aApplication);
   Try
      FormParameterBrowser.ShowModal;
   Finally
      FormParameterBrowser.Free;
   End;
End;

Procedure TFormMDIMain.PMItemAddGroupClick(Sender: TObject);
Begin
   FormAppGroupEditor := TFormAppGroupEditor.Create(Self);
   FormAppGroupEditor.ShowModal;
   FormAppGroupEditor.Free;
End;

Procedure TFormMDIMain.PMItemCheckforupdateClick(Sender: TObject);
Var
   iAppVersion: Integer;
   sZipFilaeName: String;
   varZipFile: TZipFile;
   varDownloadManager: IEDownloadManager;
Begin
   iAppVersion := StrToInt(GetAppVersionFromSite(cUniqueAppVersionCode));
   If cApplication_Version < iAppVersion Then
   Begin
      If MessageDlg(cNewAppVersionAvailablePrompt, mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes Then
      Begin
         sZipFilaeName := ParamStr(0) + '.zip';
         // Delete the file if exists { Ajmal }
         If FileExists(sZipFilaeName) Then
         Begin
            If Not DeleteFile(sZipFilaeName) Then
               Raise Exception.Create('Cannot delete the file.');
         End;
         varDownloadManager := TEDownloadManager.Create(Self);
         varZipFile := TZipFile.Create;
         Try
            varDownloadManager.Add(cAppZipFileNameInSite, sZipFilaeName);
            If varDownloadManager.Download Then
            Begin
               RenameFile(ParamStr(0), ParentFolder + 'Old_' + ExtractFileName(ParamStr(0)));
               varZipFile.ExtractZipFile(sZipFilaeName, ParentFolder);
               MessageDlg('Application updated.', mtWarning, [mbOK], 0);
               Close;
            End;
         Finally
            varZipFile.Free;
         End;
      End;
   End
   Else
      MessageDlg(cNoNewAppVersionAvailablePrompt, mtInformation, [mbOK], 0);
End;

Procedure TFormMDIMain.PMItemDeleteGroupClick(Sender: TObject);
Var
   varSelected: TObject;
Begin
   If MessageDlg('Are you sure you want to delete ?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes Then
   Begin
      If Assigned(tvApplications.Selected) Then
         varSelected := tvApplications.Selected.Data;
      If Assigned(varSelected) And varSelected.InheritsFrom(TEApplicationGroup) Then
      Begin
         AppGroups.Remove(TEApplicationGroup(varSelected).Name);
         AppGroups.SaveData(ParentFolder + cGroup_INI);
      End;
      UpdateApplicationList;
   End;
End;

Procedure TFormMDIMain.PMItemEditGroupClick(Sender: TObject);
Var
   varSelected: TObject;
Begin
   varSelected := TObject(tvApplications.Selected.Data);
   If Assigned(varSelected) And varSelected.InheritsFrom(TEApplicationGroup) Then
   Begin
      FormAppGroupEditor := TFormAppGroupEditor.Create(Self, varSelected As TEApplicationGroup);
      Try
         FormAppGroupEditor.ShowModal;
      Finally
         FormAppGroupEditor.Free;
      End;
   End;
End;

Procedure TFormMDIMain.PMItemExitClick(Sender: TObject);
Begin
   Close;
End;

Procedure TFormMDIMain.PMItemShowHideClick(Sender: TObject);
Begin
   Visible := Not Visible;
End;

Procedure TFormMDIMain.PMItemUpdateClick(Sender: TObject);
Begin
   UpdateApplicationList;
End;

Procedure TFormMDIMain.PopupMenuListViewPopup(Sender: TObject);
Begin
   PMItemEditGroup.Enabled := Assigned(tvApplications.Selected) And Assigned(tvApplications.Selected.Data) And TObject(tvApplications.Selected.Data).InheritsFrom(TEApplicationGroup);
   PMItemDeleteGroup.Enabled := PMItemEditGroup.Enabled;
End;

Procedure TFormMDIMain.PopupMenuTrayPopup(Sender: TObject);
Begin
   If Visible Then
      PMItemShowHide.ImageIndex := cIMG_HIDE
   Else
      PMItemShowHide.ImageIndex := cIMG_SHOW;
End;

Procedure TFormMDIMain.ReloadFromIni;
Begin
   LoadConfig;
   If Assigned(FParameters) Then
      FreeAndNil(FParameters);
   If Assigned(FAppGroups) Then
      FreeAndNil(FAppGroups);
   UpdateApplicationList;
End;

Procedure TFormMDIMain.SaveConfig;
Var
   varIniFile: TIniFile;
Begin
   If MItemAutobackup.Checked Then
      MItemBackup.Click;

   varIniFile := TIniFile.Create(ParentFolder + cConfig_INI);
   Try
      varIniFile.WriteBool(cConfigBasic, cConfigAutoBackUpOnExit, MItemAutobackup.Checked);
      varIniFile.WriteBool(cConfigBasic, cConfigStartMinimized, MItemStartMinimized.Checked);
      varIniFile.WriteBool(cConfigBasic, cConfigRunAsAdmin, RunAsAdmin);
      varIniFile.WriteString(cConfigBasic, cConfigLastUsedParam, LastUsedParamCode);
      If Connections.FileName = (cV6_FOLDER + cConnection_INI) Then
         varIniFile.WriteString(cConfigBasic, cConfigFileName, '')
      Else
         varIniFile.WriteString(cConfigBasic, cConfigFileName, Connections.FileName);
   Finally
      varIniFile.Free;
   End;
End;

Procedure TFormMDIMain.sBtnBrowseConnectionClick(Sender: TObject);
Begin
   If OpenDialog.Execute(Handle) Then
   Begin
      Connections.FileName := OpenDialog.FileName;
      edtConnection.Text := Connections.FileName;
   End;
End;

Procedure TFormMDIMain.tvApplicationsDblClick(Sender: TObject);
Var
   varSelected: TObject;
   varAppGroup: TEApplicationGroup Absolute varSelected;
   varApplication: TEApplication Absolute varSelected;
Begin
   If Sender Is TTreeView Then
   Begin
      If Not Assigned(tvApplications.Selected) Then
         Exit;
      varSelected := tvApplications.Selected.Data;
   End
   Else If Sender Is TMenuItem Then
      varSelected := Pointer(TMenuItem(Sender).Tag);

   If Assigned(varSelected) Then
   Begin
      If varSelected.InheritsFrom(TEApplication) Then
         OpenParamBrowser(varApplication)
      Else If varSelected.InheritsFrom(TEApplicationGroup) And varAppGroup.IsApplication Then
      Begin
         If varAppGroup.FixedParameter = '' Then
            OpenParamBrowser(varAppGroup)
         Else
            varAppGroup.RunExecutable;
      End;
   End;
End;

Procedure TFormMDIMain.UpdateApplicationList;
Var
   varAppGrp: TEApplicationGroup;
   varApp: TEApplication;
   iCurrGroupID: Integer;
   varCurrNode, varParentNode: TTreeNode;
   varCurrMenuGroup, varCurrMenuItem: TMenuItem;
   varGroupNames: TArray<String>;
   sCurrGroupName: String;
Begin
   tvApplications.Items.Clear;
   PMItemApplications.Clear;

   tvApplications.Items.BeginUpdate;
   Try
      varParentNode := tvApplications.Items.AddChild(Nil, 'Groups');
      PMItemApplications.Enabled := AppGroups.Count > 0;

      varGroupNames := AppGroups.Keys.ToArray;
      TArray.Sort<String>(varGroupNames);
      For sCurrGroupName In varGroupNames Do
      Begin
         varAppGrp := AppGroups[sCurrGroupName];
         varCurrNode := tvApplications.Items.AddChildObject(varParentNode, varAppGrp.Name, varAppGrp);
         varCurrMenuGroup := TMenuItem.Create(PMItemApplications);
         varCurrMenuGroup.Caption := varAppGrp.Name;
         PMItemApplications.Add(varCurrMenuGroup);
         If varAppGrp.IsApplication Then
         Begin
            varCurrMenuGroup.Tag := NativeInt(varAppGrp);
            varCurrMenuGroup.OnClick := tvApplicationsDblClick;
            Continue;
         End;

         varAppGrp.LoadApplications;
         varCurrMenuGroup.Enabled := varAppGrp.Count > 0;
         For varApp In varAppGrp Do
         Begin
            tvApplications.Items.AddChildObject(varCurrNode, varApp.Name, varApp);
            varCurrMenuItem := TMenuItem.Create(varCurrMenuGroup);
            varCurrMenuItem.Caption := varApp.Name;
            varCurrMenuItem.Tag := NativeInt(varApp);
            varCurrMenuItem.OnClick := tvApplicationsDblClick;
            varCurrMenuGroup.Add(varCurrMenuItem);
         End;
      End;
      varParentNode.Expand(False);
   Finally
      tvApplications.Items.EndUpdate;
   End;
End;

End.
