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
   DateUtils,
   StrUtils,
   System.Classes,
   Vcl.Graphics,
   Vcl.Controls,
   Vcl.Forms,
   ShlObj,
   Vcl.Dialogs,
   Vcl.StdCtrls,
   Vcl.ExtCtrls,
   Vcl.ImgList,
   ShellApi,
   IniFiles,
   Generics.Collections,
   Vcl.Buttons,
   Vcl.Menus,
   Vcl.FileCtrl,
   Vcl.AppEvnts,
   Vcl.ComCtrls,
   ESoft.Launcher.Application,
   ESoft.Launcher.Parameter,
   ESoft.Launcher.RecentItems,
   System.Zip,
   ESoft.Utils,
   PngImageList,
   Vcl.Samples.Spin,
   Vcl.StdActns,
   Vcl.BandActn,
   Vcl.ExtActns,
   Vcl.Bind.Navigator,
   Vcl.ListActns,
   Vcl.DBClientActns,
   Vcl.DBActns,
   System.Actions,
   Vcl.ActnList;

Const
   cIMG_NONE = -1;

   cESoftLauncher = 'ESoft_Launcher';
   cV6_FOLDER = 'C:\Users\All Users\SoftTech\V6\';
   cConnection_INI = 'V6ConnectionIds.ini';
   cConfig_INI = 'Config.ini';
   cGroup_INI = 'Group.eini';
   cParam_INI = 'Params.eini';
   cClipbord_Data = 'ClpBrd.edat';
   cConnectionState = 'CONNECTION_STATE';

   cMenuSeperatorCaption = '-';

Type
   TFormMDIMain = Class(TForm)
      OpenDialog: TOpenDialog;
      TrayIcon: TTrayIcon;
      PopupMenuTray: TPopupMenu;
      ApplicationEvents: TApplicationEvents;
      PMItemExit: TMenuItem;
      N1: TMenuItem;
      PMItemShowHide: TMenuItem;
      N2: TMenuItem;
      PMItemAppSep: TMenuItem;
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
      MItemShowHideSettings: TMenuItem;
      MItemAutoStart: TMenuItem;
      PMItemTrayUpdate: TMenuItem;
      N5: TMenuItem;
      MItemBackup: TMenuItem;
      MItemRestore: TMenuItem;
      MItemAutobackup: TMenuItem;
      MenuHelp: TMenuItem;
      PMItemCheckforupdate: TMenuItem;
      PMItemRefresh: TMenuItem;
      imlAppIcons: TPngImageList;
      grpSettings: TGroupBox;
      pnlConnection: TPanel;
      Label1: TLabel;
      Panel1: TPanel;
      Label2: TLabel;
      sBtnBrowseConnection: TSpeedButton;
      edtConnection: TButtonedEdit;
      hKeyGeneral: THotKey;
      Label3: TLabel;
      PMItemRecentItems: TMenuItem;
      N6: TMenuItem;
      PMItemClipboard: TMenuItem;
      PMItemSaveClipboard: TMenuItem;
      PMItemClipboardItems: TMenuItem;
      PMItemExecutionMode: TMenuItem;
      Panel2: TPanel;
      Label4: TLabel;
      sEdtRecentItemCount: TSpinEdit;
      PMItemApplications: TMenuItem;
      PMItemCategories: TMenuItem;
      Label5: TLabel;
      cbGroupItems: TComboBox;
      ImageList_20: TImageList;
      PMItemNormal: TMenuItem;
      PMItemRunasAdministrator: TMenuItem;
      Procedure sBtnBrowseConnectionClick(Sender: TObject);
      Procedure edtConnectionRightButtonClick(Sender: TObject);
      Procedure FormCreate(Sender: TObject);
      Procedure FormDestroy(Sender: TObject);
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
      Procedure MItemShowHideSettingsClick(Sender: TObject);
      Procedure MItemAutoStartClick(Sender: TObject);
      Procedure MItemBackupClick(Sender: TObject);
      Procedure MItemRestoreClick(Sender: TObject);
      Procedure PMItemCheckforupdateClick(Sender: TObject);
      Procedure PMItemRefreshClick(Sender: TObject);
      Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
      Procedure tvApplicationsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      Procedure cbGroupItemsChange(Sender: TObject);
      // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
   Strict Private
      // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
      FFixedMenuItems: TList<TMenuItem>;
      FHotKeyMain: NativeUInt;
      FLastUsedParamCode: String;
      FParameters: TEParameters;
      FInitialized: Boolean;
      FAppGroups: TEApplicationGroups;
      FParentFolder: String;
      FConnections: TEConnections;
      FDisplayLabels: TStringList;
      FRecentItems: TERecentItems;

      Procedure OnRecentItemsChange(aSender: TObject);
      Function MenuItemApplications(Const aType: Integer = cIMG_NONE): TMenuItem;
      Procedure WMHotKey(Var Msg: TWMHotKey); Message WM_HOTKEY;
      Procedure OpenParamBrowser(Const aApplication: IEApplication = Nil);
      Function GetConnections: TEConnections;
      Function GetAppGroups: TEApplicationGroups;
      Function GetParameters: TEParameters;
      Function GetDisplayLabels: TStringList;
      Procedure DeleteOldBackups;
      Procedure RegisterAppHotKey;
      Function ApplicationFromMenuItem(Const aMenuItem: TMenuItem): TEApplication;
      Function GetRunAsAdmin: Boolean;
      Procedure SetRunAsAdmin(Const aValue: Boolean);
      Function GetRecentItems: TERecentItems;
      Procedure ClearRecentItems(aSender: TObject);
      Function AppSeparatorMenuIndex(Const aType: Integer): Integer;
   Public
      { Public declarations }
      Procedure LoadConfig;
      Procedure SaveConfig;
      Function BackupFolder: String;
      Procedure UpdateApplicationList;
      Procedure ReloadFromIni;
      Procedure RunApplication(Const aName, aExecutableName, aParameter, aSourcePath: String);

      Property RecentItems: TERecentItems Read GetRecentItems;
   Published
      Property AppGroups: TEApplicationGroups Read GetAppGroups;
      Property Parameters: TEParameters Read GetParameters;
      Property Connections: TEConnections Read GetConnections;
      Property ParentFolder: String Read FParentFolder;
      Property IsRunAsAdmin: Boolean Read GetRunAsAdmin Write SetRunAsAdmin;
      Property LastUsedParamCode: String Read FLastUsedParamCode Write FLastUsedParamCode;
      Property DisplayLabels: TStringList Read GetDisplayLabels;
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
   cApplication_Version = 1008;

   cIMG_DELETE = 4;
   cIMG_BRANCH = 9;
   cIMG_GROUP = 12;
   cIMG_CATEGORY = 19;
   cIMG_HIDE = 40;
   cIMG_SHOW = 41;
   cIMG_APPLICATION = 45;
   cIMG_PARENT_GROUP = 48;

   cGroupVisible_None = 0;
   cGroupVisible_All = 1;
   cGroupVisible_ApplicationOnly = 2;
   cGroupVisible_CategoryOnly = 3;

   cAppZipFileNameInSite = 'http://esoft.ucoz.com/Downloads/Launcher/Launcher.zip';
   cUniqueAppVersionCode = cESoftLauncher;

   cConfigBasic = 'Basic';
   cConfigFileName = 'FileName';
   cConfigStartMinimized = 'StartMinimized';
   cConfigRunAsAdmin = 'RunAsAdmin';
   cConfigLastUsedParam = 'LastUsedParam';
   cConfigAutoBackUpOnExit = 'AutoBackUpOnExit';
   cConfigHotKey = 'HotKey';
   cConfigDefaultHotKeyText = 'Alt+Q';
   cConfigRecentCount = 'RecentItemsCount';
   cConfigGroupItems = 'GroupItems';

   cBackups = 'Backups\';

Resourcestring
   rsClearRecentItems = 'Clear';

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

Function TFormMDIMain.ApplicationFromMenuItem(Const aMenuItem: TMenuItem): TEApplication;
Var
   varObject: TObject;
Begin
   Result := Nil;

   varObject := Pointer(aMenuItem.Tag);
   If varObject.InheritsFrom(TEApplication) Then
      Result := varObject As TEApplication;
End;

Function TFormMDIMain.AppSeparatorMenuIndex(Const aType: Integer): Integer;
Begin
   Result := 0;
   If MenuItemApplications(aType) <> PopupMenuTray.Items Then
      Exit;

   Result := MenuItemApplications.IndexOf(PMItemAppSep);
End;

Function TFormMDIMain.BackupFolder: String;
Begin
   Result := ParentFolder + cBackups;
End;

Procedure TFormMDIMain.cbGroupItemsChange(Sender: TObject);
Begin
   PMItemUpdate.Click;
End;

Procedure TFormMDIMain.edtConnectionRightButtonClick(Sender: TObject);
Begin
   Connections.FileName := String.Empty;
   edtConnection.Text := Connections.FileName;
End;

Procedure TFormMDIMain.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
   CanClose := False;
   Hide;
End;

Procedure TFormMDIMain.FormCreate(Sender: TObject);
Var
   iCntr: Integer;
Begin
   // Store the permenent menu into FixedItem list. { Ajmal }
   // While updating the TrayIcon popup, we should not remove these menu items. { Ajmal }
   FFixedMenuItems := TList<TMenuItem>.Create;
   For iCntr := 0 To Pred(MenuItemApplications.Count) Do
      FFixedMenuItems.Add(MenuItemApplications[iCntr]);

   PanelDeveloper.Caption := 'Developed by Muhammad Ajmal P';
   FInitialized := False;
   FParentFolder := ExtractFilePath(ParamStr(0));
   MItemAutoStart.Checked := AddToStartup(cESoftLauncher, REG_READ);

   LoadConfig;
   RegisterAppHotKey;

   edtConnection.Text := Connections.FileName;
End;

Procedure TFormMDIMain.FormDestroy(Sender: TObject);
Begin
   UnRegisterHotKey(Handle, FHotKeyMain);
   GlobalDeleteAtom(FHotKeyMain);

   EFreeAndNil(FFixedMenuItems);
   EFreeAndNil(FRecentItems);
   EFreeAndNil(FDisplayLabels);
   EFreeAndNil(FConnections);

   If Assigned(FParameters) Then
   Begin
      Parameters.SaveData(ParentFolder + cParam_INI);
      FreeAndNil(FParameters);
   End;
   If Assigned(FAppGroups) Then
   Begin
      AppGroups.SaveData(ParentFolder + cGroup_INI);
      FreeAndNil(FAppGroups);
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

Function TFormMDIMain.GetDisplayLabels: TStringList;
Begin
   If Not Assigned(FDisplayLabels) Then
   Begin
      FDisplayLabels := TStringList.Create;
      FDisplayLabels.Duplicates := dupIgnore;
      FDisplayLabels.Sorted := True;
   End;
   Result := FDisplayLabels;
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

Function TFormMDIMain.GetRecentItems: TERecentItems;
Begin
   If Not Assigned(FRecentItems) Then
   Begin
      FRecentItems := TERecentItems.Create(True);
      FRecentItems.OnChange := OnRecentItemsChange;
   End;
   Result := FRecentItems;
End;

Function TFormMDIMain.GetRunAsAdmin: Boolean;
Begin
   Result := PMItemRunasAdministrator.Checked;
End;

Procedure TFormMDIMain.LoadConfig;
Var
   varIniFile: TIniFile;
Begin
   varIniFile := TIniFile.Create(ParentFolder + cConfig_INI);
   Try
      MItemAutobackup.Checked := varIniFile.ReadBool(cConfigBasic, cConfigAutoBackUpOnExit, False);
      MItemStartMinimized.Checked := varIniFile.ReadBool(cConfigBasic, cConfigStartMinimized, True);
      IsRunAsAdmin := varIniFile.ReadBool(cConfigBasic, cConfigRunAsAdmin, False);
      LastUsedParamCode := varIniFile.ReadString(cConfigBasic, cConfigLastUsedParam, String.Empty);
      Connections.FileName := varIniFile.ReadString(cConfigBasic, cConfigFileName, String.Empty);
      hKeyGeneral.HotKey := TextToShortCut(varIniFile.ReadString(cConfigBasic, cConfigHotKey, cConfigDefaultHotKeyText));
      sEdtRecentItemCount.Value := varIniFile.ReadInteger(cConfigBasic, cConfigRecentCount, 5);
      cbGroupItems.ItemIndex := varIniFile.ReadInteger(cConfigBasic, cConfigGroupItems, cGroupVisible_None);
   Finally
      varIniFile.Free;
   End;
End;

Function TFormMDIMain.MenuItemApplications(Const aType: Integer): TMenuItem;
Begin
   Result := PopupMenuTray.Items;
   If cbGroupItems.ItemIndex = cGroupVisible_None Then
      Exit;

   Case aType Of
      cIMG_CATEGORY:
         Begin
            If cbGroupItems.ItemIndex In [cGroupVisible_All, cGroupVisible_CategoryOnly] Then
               Result := PMItemCategories;
         End;
      cIMG_APPLICATION:
         Begin
            If cbGroupItems.ItemIndex In [cGroupVisible_All, cGroupVisible_ApplicationOnly] Then
               Result := PMItemApplications;
         End;
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
Const
   cDate_Year = 0;
   cDate_Month = 1;
   cDate_Day = 2;
Var
   varSearch: TSearchRec;
   varDate: TDate;
   sFileDate: TArray<String>;
   iYear, iMonth, iDay: Word;
Begin
   If FindFirst(BackupFolder + cESoftLauncher + '_*.zip', faArchive, varSearch) = 0 Then
   Begin
      Repeat
         // The name of the file will be
         // ESoft_Launcher_2015_Nov_02-22_30_13
         // So if we split using '_' 3rd will be the year, 4th month and 5th is day.
         // We split again to get the Year, Month and day { Ajmal }
         sFileDate := StringReplace(varSearch.Name, cESoftLauncher + '_', '', []).Split(['-'])[0].Split(['_']);
         iYear := StrToInt(sFileDate[cDate_Year]);
         iMonth := IndexText(sFileDate[cDate_Month], FormatSettings.ShortMonthNames) + 1;
         iDay := StrToInt(sFileDate[cDate_Day]);
         varDate := EncodeDate(iYear, iMonth, iDay);

         If varDate < (Date - 2) Then
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

Procedure TFormMDIMain.MItemShowHideSettingsClick(Sender: TObject);
Begin
   grpSettings.Visible := MItemShowHideSettings.Checked;
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

Procedure TFormMDIMain.ClearRecentItems(aSender: TObject);
Begin
   RecentItems.Clear;
   PMItemRecentItems.Clear;
End;

Procedure TFormMDIMain.OnRecentItemsChange(aSender: TObject);

   Function _AddMenuItem(Const aCaption: String; Const aItem: TERecentItem = Nil): TMenuItem;
   Var
      iImageIndex: Integer;
      varIcon: TIcon;
   Begin
      Result := TMenuItem.Create(PMItemRecentItems);
      Result.Caption := aCaption;
      If Assigned(aItem) Then
      Begin
         // varIcon := aItem.Icon;
         // If Assigned(varIcon) Then
         // Begin
         // iImageIndex := imlAppIcons.AddIcon(aItem.Icon);
         // imlAppIcons.GetBitmap(iImageIndex, Result.Bitmap);
         // End;
         Result.Hint := aItem.Parameter;
         Result.Tag := NativeInt(aItem);
         Result.OnClick := tvApplicationsDblClick;
      End;
      PMItemRecentItems.Add(Result);
   End;

Var
   iCntr: Integer;
Begin
   PMItemRecentItems.Clear;
   With _AddMenuItem(rsClearRecentItems, Nil) Do
   Begin
      ImageIndex := cIMG_DELETE;
      OnClick := ClearRecentItems;
   End;

   _AddMenuItem(cMenuSeperatorCaption);
   For iCntr := 0 To Pred(RecentItems.Count) Do
   Begin
      If iCntr = sEdtRecentItemCount.Value Then
         Break;

      _AddMenuItem(RecentItems[iCntr].Name, RecentItems[iCntr]);
   End;
End;

Procedure TFormMDIMain.OpenParamBrowser(Const aApplication: IEApplication);
Begin
   If Assigned(FormParameterBrowser) Then
   Begin
      FormParameterBrowser.BringToFront;
      EFlashWindow(FormParameterBrowser.Handle);
      Exit;
   End;

   If Visible Then
      FormParameterBrowser := TFormParameterBrowser.Create(Self, aApplication)
   Else
      FormParameterBrowser := TFormParameterBrowser.Create(Application, aApplication);
   Try
      FormParameterBrowser.ShowModal;
   Finally
      EFreeAndNil(FormParameterBrowser);
   End;
End;

Procedure TFormMDIMain.PMItemAddGroupClick(Sender: TObject);
Begin
   FormAppGroupEditor := TFormAppGroupEditor.Create(Self);
   Try
      FormAppGroupEditor.ShowModal;
   Finally
      EFreeAndNil(FormAppGroupEditor);
   End;
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
               If FileExists(ParentFolder + 'Old_' + ExtractFileName(ParamStr(0))) Then
               Begin
                  If Not DeleteFile(ParentFolder + 'Old_' + ExtractFileName(ParamStr(0))) Then
                     Raise Exception.Create('Cannot delete the file.');
               End;
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
   SaveConfig;
   Application.Terminate;
End;

Procedure TFormMDIMain.PMItemRefreshClick(Sender: TObject);
Begin
   //
End;

Procedure TFormMDIMain.PMItemShowHideClick(Sender: TObject);
Begin
   If Assigned(FormParameterBrowser) Then
   Begin
      OpenParamBrowser;
      Exit;
   End;

   Visible := Not Visible;
   If Visible And (WindowState = wsMinimized) Then
      WindowState := wsNormal;
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
   // PMItemRecentItems.Enabled := Assigned(FRecentItems) And (RecentItems.Count > 0);
   PMItemApplications.Visible := cbGroupItems.ItemIndex In [cGroupVisible_All, cGroupVisible_ApplicationOnly];
   PMItemCategories.Visible := cbGroupItems.ItemIndex In [cGroupVisible_All, cGroupVisible_CategoryOnly];
   PMItemApplications.Enabled := PMItemApplications.Count > 0;
   PMItemCategories.Visible := PMItemCategories.Count > 0;

   If Visible Then
      PMItemShowHide.ImageIndex := cIMG_HIDE
   Else
      PMItemShowHide.ImageIndex := cIMG_SHOW;
End;

Procedure TFormMDIMain.RegisterAppHotKey;

   Function _GetModifier(Const aModifiers: THKModifiers = [hkAlt]): Cardinal;
   Begin
      Result := 0;
      If hkShift In aModifiers Then
         Result := Result Or MOD_SHIFT;
      If hkCtrl In aModifiers Then
         Result := Result Or MOD_CONTROL;
      If hkAlt In aModifiers Then
         Result := Result Or MOD_ALT;
   End;

Var
   varShift: TShiftState;
   cKey: Word;
Begin
   FHotKeyMain := GlobalAddAtom(cESoftLauncher);
   ShortCutToKey(hKeyGeneral.HotKey, cKey, varShift);
   RegisterHotKey(Handle, FHotKeyMain, _GetModifier(hKeyGeneral.Modifiers), cKey);
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
      varIniFile.WriteBool(cConfigBasic, cConfigRunAsAdmin, IsRunAsAdmin);
      varIniFile.WriteString(cConfigBasic, cConfigLastUsedParam, LastUsedParamCode);
      varIniFile.WriteString(cConfigBasic, cConfigHotKey, ShortCutToText(hKeyGeneral.HotKey));
      varIniFile.WriteInteger(cConfigBasic, cConfigRecentCount, sEdtRecentItemCount.Value);
      varIniFile.WriteInteger(cConfigBasic, cConfigGroupItems, cbGroupItems.ItemIndex);
      If Connections.FileName = (cV6_FOLDER + cConnection_INI) Then
         varIniFile.WriteString(cConfigBasic, cConfigFileName, String.Empty)
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

Procedure TFormMDIMain.SetRunAsAdmin(Const aValue: Boolean);
Begin
   PMItemRunasAdministrator.Checked := aValue;
End;

Procedure TFormMDIMain.tvApplicationsDblClick(Sender: TObject);
Var
   varSelected: TObject;
   varAppGroup: TEApplicationGroup Absolute varSelected;
   varApplication: TEApplication Absolute varSelected;
   varRecentItem: TERecentItem Absolute varSelected;
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
      If varSelected.InheritsFrom(TERecentItem) Then
         varRecentItem.RunExecutable
      Else If varSelected.InheritsFrom(TEApplication) Then
         OpenParamBrowser(varApplication)
      Else If varSelected.InheritsFrom(TEApplicationGroup) And varAppGroup.IsApplication Then
      Begin
         If varAppGroup.FixedParameter.IsEmpty Then
            OpenParamBrowser(varAppGroup)
         Else
            varAppGroup.RunExecutable;
      End;
   End;
End;

Procedure TFormMDIMain.tvApplicationsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
   varSelectedNode: TTreeNode;
Begin
   varSelectedNode := tvApplications.GetNodeAt(X, Y);
   If Assigned(varSelectedNode) Then
      varSelectedNode.Selected := True;
End;

Procedure TFormMDIMain.UpdateApplicationList;
Var
   varMenuItems: TStringList;

   Function _AddMenu(Const aLabel: String; Const aMenuItem: TMenuItem; Const aParentMenu: TMenuItem = Nil): TMenuItem;
   Var
      varCurrMenuLabel: TMenuItem;
      iCntr: Integer;
   Begin
      Result := Nil;

      If Assigned(aParentMenu) Then
      Begin
         Result := aParentMenu.Find(aLabel);
         If Assigned(Result) Then
            Exit;

         Result := TMenuItem.Create(aParentMenu);
         Result.Caption := aLabel;
         Result.ImageIndex := cIMG_BRANCH;
         aParentMenu.Add(Result);
         Exit;
      End;

      If aLabel.IsEmpty Then
      Begin
         MenuItemApplications(cIMG_APPLICATION).Insert(AppSeparatorMenuIndex(cIMG_APPLICATION), aMenuItem);
         Exit;
      End;

      varCurrMenuLabel := Nil;
      For iCntr := 0 To Pred(varMenuItems.Count) Do
      Begin
         varCurrMenuLabel := varMenuItems.Objects[iCntr] As TMenuItem;
         If SameText(aLabel, varCurrMenuLabel.Caption) Then
            Break;
         varCurrMenuLabel := Nil;
      End;
      If Not Assigned(varCurrMenuLabel) Then
      Begin
         varCurrMenuLabel := TMenuItem.Create(MenuItemApplications(cIMG_CATEGORY));
         varCurrMenuLabel.Caption := aLabel;
         varCurrMenuLabel.ImageIndex := cIMG_CATEGORY;
         varMenuItems.AddObject(aLabel, varCurrMenuLabel);
      End;
      varCurrMenuLabel.Add(aMenuItem);
   End;

   Function _GetLabelNode(Const aLabel: String; Const aCurrentNode: TTreeNode): TTreeNode;
   Var
      varNode: TTreeNode;
      iCntr: Integer;
   Begin
      If aLabel.IsEmpty Then
         Exit(aCurrentNode);

      For iCntr := 0 To Pred(aCurrentNode.Count) Do
      Begin
         varNode := aCurrentNode.Item[iCntr];
         If SameText(varNode.Text, aLabel) Then
            Exit(varNode);
      End;
      Result := tvApplications.Items.AddChild(aCurrentNode, aLabel);
      Result.ImageIndex := cIMG_CATEGORY;
      Result.SelectedIndex := cIMG_CATEGORY;
      DisplayLabels.Add(Result.Text);
   End;

   Procedure _ClearMenuItems;
   Var
      iCntr: Integer;
   Begin
      iCntr := 0;
      PMItemApplications.Clear;
      PMItemCategories.Clear;

      While iCntr < MenuItemApplications.Count Do
      Begin
         If FFixedMenuItems.IndexOf(MenuItemApplications[iCntr]) = -1 Then
            MenuItemApplications.Delete(iCntr)
         Else
            Inc(iCntr);
      End;
   End;

   Function _ApplicationBranch(Const aApplication: TEApplication; Const aParentGroup: TMenuItem): TMenuItem;
   Var
      iCntr: Integer;
   Begin
      Result := aParentGroup;

      If Not aApplication.Owner.IsBranchingEnabled Then
         Exit;

      If Not aApplication.MajorVersionName.IsEmpty Then
         Result := _AddMenu(aApplication.MajorVersionName, Nil, Result);

      If Not aApplication.MinorVersionName.IsEmpty Then
         Result := _AddMenu(aApplication.MinorVersionName, Nil, Result);

      If Not aApplication.ReleaseVersionName.IsEmpty Then
         Result := _AddMenu(aApplication.ReleaseVersionName, Nil, Result);

      // For build seperation { Ajmal }
      If (aApplication.Owner.NoOfBuilds = 0) Or (aApplication.BuildNumber = cInvalidBuildNumber) Then
         Exit;

      If (Result.Count > 0) And (Result.Items[Pred(Result.Count)].Count < aApplication.Owner.NoOfBuilds) Then
      Begin
         Result := Result.Items[Pred(Result.Count)];
         Result.Caption := Format('Builds [%d-%d]', [ //
            aApplication.BuildNumber, //
            ApplicationFromMenuItem(Result.Items[0]).BuildNumber]);
      End
      Else
         Result := _AddMenu(Format('Builds [%d-%d]', [aApplication.BuildNumber, aApplication.BuildNumber]), Nil, Result);
   End;

Var
   varAppGrp: TEApplicationGroup;
   varApp: TEApplication;
   iCurrGroupID: Integer;
   varCurrNode, varParentNode, varCurrLabelNode: TTreeNode;
   varCurrMenuGroup, varCurrMenuItem, varBranchMenuItem: TMenuItem;
   varGroupNames: TArray<String>;
   sCurrGroupName: String;
   iCurrGrpImageIndex: Integer;
   iCntr: Integer;
Begin
   tvApplications.Items.Clear;
   _ClearMenuItems;
   imlAppIcons.Clear;

   varMenuItems := TStringList.Create;
   tvApplications.Items.BeginUpdate;
   Try
      varMenuItems.Duplicates := dupIgnore;
      varMenuItems.Sorted := True;
      varParentNode := tvApplications.Items.AddChild(Nil, 'Groups');
      varParentNode.ImageIndex := cIMG_PARENT_GROUP;
      varParentNode.SelectedIndex := cIMG_PARENT_GROUP;
      MenuItemApplications.Enabled := AppGroups.Count > 0;

      varGroupNames := AppGroups.Keys.ToArray;
      TArray.Sort<String>(varGroupNames);
      For sCurrGroupName In varGroupNames Do
      Begin
         varAppGrp := AppGroups[sCurrGroupName];
         varCurrLabelNode := _GetLabelNode(varAppGrp.DisplayLabel, varParentNode);
         varCurrNode := tvApplications.Items.AddChildObject(varCurrLabelNode, varAppGrp.Name, varAppGrp);
         varCurrNode.ImageIndex := cIMG_GROUP;
         varCurrNode.SelectedIndex := cIMG_GROUP;
         varCurrMenuGroup := TMenuItem.Create(MenuItemApplications(cIMG_APPLICATION));
         varCurrMenuGroup.Caption := varAppGrp.Name;
         varCurrMenuGroup.ImageIndex := cIMG_GROUP;
         _AddMenu(varAppGrp.DisplayLabel, varCurrMenuGroup);
         iCurrGrpImageIndex := cIMG_NONE;
         If varAppGrp.IsApplication Then
         Begin
            varCurrMenuGroup.Tag := NativeInt(varAppGrp);
            varCurrMenuGroup.OnClick := tvApplicationsDblClick;
            Try
               iCurrGrpImageIndex := imlAppIcons.AddIcon(varAppGrp.Icon);
               imlAppIcons.GetBitmap(iCurrGrpImageIndex, varCurrMenuGroup.Bitmap);
               varCurrMenuGroup.ImageIndex := cIMG_NONE;
               varCurrNode.ImageIndex := iCurrGrpImageIndex;
               varCurrNode.SelectedIndex := iCurrGrpImageIndex;
            Except
               varCurrMenuGroup.ImageIndex := cIMG_APPLICATION;
               varCurrNode.ImageIndex := cIMG_APPLICATION;
               varCurrNode.SelectedIndex := cIMG_APPLICATION;
            End;
            Continue;
         End;

         varAppGrp.LoadApplications;
         varCurrMenuGroup.Enabled := varAppGrp.Count > 0;
         For varApp In varAppGrp Do
         Begin
            With tvApplications.Items.AddChildObject(varCurrNode, varApp.Name, varApp) Do
            Begin
               ImageIndex := cIMG_NONE;
               SelectedIndex := cIMG_NONE;
            End;

            varBranchMenuItem := _ApplicationBranch(varApp, varCurrMenuGroup);
            varCurrMenuItem := TMenuItem.Create(varBranchMenuItem);
            varCurrMenuItem.Caption := varApp.Name;
            varCurrMenuItem.Tag := NativeInt(varApp);
            varCurrMenuItem.OnClick := tvApplicationsDblClick;
            If iCurrGrpImageIndex <> cIMG_NONE Then
               imlAppIcons.GetBitmap(iCurrGrpImageIndex, varCurrMenuItem.Bitmap);
            varBranchMenuItem.Add(varCurrMenuItem);
         End;
      End;

      // Add a seperator before categories. Only if we have enabled no grouping { Ajmal }
      If cbGroupItems.ItemIndex = cGroupVisible_None Then
      Begin
         varCurrMenuItem := TMenuItem.Create(MenuItemApplications);
         varCurrMenuItem.Caption := cMenuSeperatorCaption;
         MenuItemApplications.Insert(AppSeparatorMenuIndex(cIMG_CATEGORY), varCurrMenuItem);
      End;
      // Add label menu items to popup menu { Ajmal }
      For iCntr := 0 To Pred(varMenuItems.Count) Do
         MenuItemApplications(cIMG_CATEGORY).Insert(AppSeparatorMenuIndex(cIMG_CATEGORY), varMenuItems.Objects[iCntr] As TMenuItem);
      varParentNode.Expand(False);
   Finally
      tvApplications.Items.EndUpdate;
      varMenuItems.Free;
   End;
End;

Procedure TFormMDIMain.WMHotKey(Var Msg: TWMHotKey);
Begin
   If Msg.HotKey = FHotKeyMain Then
      PopupMenuTray.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
End;

Procedure TFormMDIMain.RunApplication(Const aName, aExecutableName, aParameter, aSourcePath: String);
Var
   varRecentItems: TERecentItem;
Begin
   Try
      If IsRunAsAdmin Then
         RunAsAdmin(Handle, PWideChar(aExecutableName), PWideChar(aParameter), PWideChar(aSourcePath))
      Else
         ShellExecute(FormMDIMain.Handle, 'open', PWideChar(aExecutableName), PWideChar(aParameter), PWideChar(aSourcePath), SW_SHOWNORMAL);

      varRecentItems := RecentItems.AddItem(aName);
      varRecentItems.ExecutableName := aExecutableName;
      varRecentItems.Parameter := aParameter;
      varRecentItems.SourceFolder := aSourcePath;
   Except
      // Do nothing. It's not easily possible to handle all the issues related to shell execute. { Ajmal }
   End;
End;

End.
