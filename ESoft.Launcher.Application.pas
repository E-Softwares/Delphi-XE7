Unit ESoft.Launcher.Application;

{ ---------------------------------------------------------- }
{ Developed by Muhammad Ajmal p }
{ ajumalp@gmail.com }
{ ---------------------------------------------------------- }

Interface

Uses
   Winapi.Windows,
   System.Classes,
   IniFiles,
   System.SysUtils,
   ShellApi,
   Vcl.Graphics,
{$IFDEF AbbreviaZipper}
   AbBase,
   AbBrowse,
   AbZBrows,
   AbUnzper,
   AbComCtrls,
{$ELSE}
   System.Zip,
{$ENDIF}
   Generics.Collections,
   ESoft.Utils;

Const
   cParameterNone = '<eNone>';
   cInvalidBuildNumber = -1;

Type
   IEApplication = Interface
      Function RunExecutable(aParameter: String = String.Empty): Boolean;
      Function UnZip: Boolean;
   End;

Type
   eTAppFile = (eafName, eafFileName, eafExtension);

   TEApplicationGroup = Class;

   TEApplication = Class(TPersistent, IEApplication)
   Private
      // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
   Strict Private
      // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
      FOwner: TEApplicationGroup;
      FFileName, FVersionName: String;

      Function GetFileName(aType: eTAppFile): String;
      Procedure SetOwner(Const Value: TEApplicationGroup);

   Public
      Constructor Create(Const aOwner: TEApplicationGroup);

      Function QueryInterface(Const IID: TGUID; Out Obj): HRESULT; Stdcall;
      Function _AddRef: Integer; Stdcall;
      Function _Release: Integer; Stdcall;

      Function TargetFolder: String;
      Function RunExecutable(aParameter: String = String.Empty): Boolean;
      Function UnZip: Boolean;

      Function VersionName: String;
      Function MajorVersionName: String;
      Function MinotVersionName: String;
      Function ReleaseVersionName: String;
      Function BuildNumber: Integer;

   Published
      Property Owner: TEApplicationGroup Read FOwner Write SetOwner;
      Property Name: String Index eafName Read GetFileName;
      Property Extension: String Index eafExtension Read GetFileName;
      Property FileName: String Index eafFileName Read GetFileName Write FFileName;
   End;

   TEApplications = Class(TObjectList<TEApplication>);

   TEApplicationGroup = Class(TEApplications, IEApplication)
   Private
      // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
   Strict Private
      // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
      FIsApplication: Boolean;
      FFixedParameter, FExecutableName, FName: String;
      FSourceFolder: String;
      FDestFolder: String;
      FFileMask: String;
      FDisplayLabel: String;
      FCreateFolder: Boolean;
      FIcon: TIcon;
      FIsMajorBranching, FIsMinorBranching, FIsReleaseBranching: Boolean;
      FBranchingPrefix, FBranchingSufix: String;
      FMainBranch, FNoOfBuilds: Integer;

      Procedure SetSourceFolder(Const Value: String);
      Procedure SetDestFolder(Const Value: String);
      Procedure SetFileMask(Const Value: String);
      Function AddItem: TEApplication;
      Function InsertItem(Const aIndex: Integer): TEApplication;
      Function GetIcon: TIcon;

   Public
      Constructor Create;
      Destructor Destroy; Override;

      Function QueryInterface(Const IID: TGUID; Out Obj): HRESULT; Stdcall;
      Function _AddRef: Integer; Stdcall;
      Function _Release: Integer; Stdcall;

      Function TargetFolder: String;
      Function RunExecutable(aParameter: String = String.Empty): Boolean;
      Function UnZip: Boolean;
      Procedure LoadApplications;
      Procedure LoadData(Const aFileName: String);
      Procedure SaveData(Const aFileName: String);

      Function IsBranchingEnabled: Boolean;

   Published
      Property Name: String Read FName Write FName;
      Property ExecutableName: String Read FExecutableName Write FExecutableName;
      Property FileMask: String Read FFileMask Write SetFileMask;
      Property DestFolder: String Read FDestFolder Write SetDestFolder;
      Property SourceFolder: String Read FSourceFolder Write SetSourceFolder;
      Property CreateFolder: Boolean Read FCreateFolder Write FCreateFolder;
      Property FixedParameter: String Read FFixedParameter Write FFixedParameter;
      Property IsApplication: Boolean Read FIsApplication Write FIsApplication;
      Property DisplayLabel: String Read FDisplayLabel Write FDisplayLabel;
      Property Icon: TIcon Read GetIcon;
      Property IsMajorBranching: Boolean Read FIsMajorBranching Write FIsMajorBranching;
      Property IsMinorBranching: Boolean Read FIsMinorBranching Write FIsMinorBranching;
      Property IsReleaseBranching: Boolean Read FIsReleaseBranching Write FIsReleaseBranching;
      Property BranchingPrefix: String Read fBranchingPrefix Write FBranchingPrefix;
      Property BranchingSufix: String Read FBranchingSufix Write FBranchingSufix;
      Property MainBranch: Integer Read FMainBranch Write FMainBranch;
      Property NoOfBuilds: Integer Read FNoOfBuilds Write FNoOfBuilds;
   End;

Type
   TEApplicationGroups = Class(TObjectDictionary<String, TEApplicationGroup>)
   Private
      // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
   Strict Private
      // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
      FIsLoaded: Boolean;

   Public
      Constructor Create;

      Procedure LoadData(Const aFileName: String);
      Procedure SaveData(Const aFileName: String);
      Function AddItem(Const aName: String = String.Empty): TEApplicationGroup;
   End;

Implementation

{ TEApplicationGroup }

Uses
   UnitMDIMain,
   ESoft.Launcher.UI.ParamBrowser;

Const
   cGroupFixedParam = 'Fixed_Param';
   cGroupExeName = 'Executable_Name';
   cGroupFileMask = 'File_Mask';
   cGroupSourceFolder = 'Source_Folder';
   cGroupDestFolder = 'Target_Folder';
   cGroupCreateFolder = 'Create_Folder';
   cGroupIsApp = 'Is_Application';
   cGroupLabel = 'Display_Label';
   cGroupIsMajorBranching = 'Is_MajorBranching';
   cGroupIsMinorBranching = 'Is_MinorBranching';
   cGroupIsReleaseBranching = 'Is_ReleaseBranching';
   cGroupBranchingPrefix = 'BranchingPrefix';
   cGroupBranchingSufix = 'BranchingSufix';
   cGroupBranchingMainBranch = 'BranchingMainBranch';
   cGroupBranchingNoOfBuilds = 'BranchingNoOfBuilds';

Function TEApplicationGroup.AddItem: TEApplication;
Begin
   Result := TEApplication.Create(Self);
   Add(Result);
End;

Constructor TEApplicationGroup.Create;
Begin
   Inherited Create(True);

   FCreateFolder := True;
   FSourceFolder := String.Empty;
   FDestFolder := String.Empty;
End;

Destructor TEApplicationGroup.Destroy;
Begin
   If Assigned(FIcon) Then
      FreeAndNil(FIcon);

   Inherited;
End;

Function TEApplicationGroup.InsertItem(Const aIndex: Integer): TEApplication;
Begin
   Result := TEApplication.Create(Self);
   Insert(aIndex, Result);
End;

Function TEApplicationGroup.IsBranchingEnabled: Boolean;
Begin
   Result := IsMajorBranching Or IsMinorBranching Or IsReleaseBranching;
End;

Function TEApplicationGroup.GetIcon: TIcon;
Var
   varSmallIcon, varLargeIcon: HICON;
   iExtractedIconCount: Cardinal;
   sFileName: String;
Begin
   Result := Nil;
   Try
      If IsApplication Then
         sFileName := SourceFolder + ExecutableName
      Else
         sFileName := DestFolder + ExecutableName;
      iExtractedIconCount := ExtractIconEx(PWideChar(sFileName), 0, varLargeIcon, varSmallIcon, 1);
      Win32Check(iExtractedIconCount = 2);
      If Not Assigned(FIcon) Then
         FIcon := TIcon.Create;
      FIcon.Handle := varLargeIcon;
      Result := FIcon;
   Except
      FreeAndNil(FIcon);
      Raise;
   End;
End;

Procedure TEApplicationGroup.LoadApplications;
Var
   varSearch: TSearchRec;
Begin
   Clear;
   If SourceFolder <> '' Then
   Begin
      If FindFirst(SourceFolder + FileMask, faArchive, varSearch) = 0 Then
      Begin
         Repeat
            InsertItem(0).FileName := varSearch.Name;
         Until FindNext(varSearch) <> 0;
         FindClose(varSearch);
      End;
   End;
End;

Procedure TEApplicationGroup.LoadData(Const aFileName: String);
Var
   varIniFile: TIniFile;
Begin
   varIniFile := TIniFile.Create(aFileName);
   Try
      FixedParameter := varIniFile.ReadString(Name, cGroupFixedParam, '');
      ExecutableName := varIniFile.ReadString(Name, cGroupExeName, '');
      FileMask := varIniFile.ReadString(Name, cGroupFileMask, '');
      SourceFolder := varIniFile.ReadString(Name, cGroupSourceFolder, '');
      DestFolder := varIniFile.ReadString(Name, cGroupDestFolder, '');
      CreateFolder := varIniFile.ReadBool(Name, cGroupCreateFolder, True);
      IsApplication := varIniFile.ReadBool(Name, cGroupIsApp, False);
      DisplayLabel := varIniFile.ReadString(Name, cGroupLabel, '');
      IsMajorBranching := varIniFile.ReadBool(Name, cGroupIsMajorBranching, False);
      IsMinorBranching := varIniFile.ReadBool(Name, cGroupIsMinorBranching, False);
      IsReleaseBranching := varIniFile.ReadBool(Name, cGroupIsReleaseBranching, False);
      BranchingPrefix := varIniFile.ReadString(Name, cGroupBranchingPrefix, '');
      BranchingSufix := varIniFile.ReadString(Name, cGroupBranchingSufix, '');
      MainBranch := varIniFile.ReadInteger(Name, cGroupBranchingMainBranch, 0);
      NoOfBuilds := varIniFile.ReadInteger(Name, cGroupBranchingNoOfBuilds, 0);
   Finally
      varIniFile.Free;
   End;
End;

Function TEApplicationGroup.QueryInterface(Const IID: TGUID; Out Obj): HRESULT;
Begin
   Inherited;
End;

Function TEApplicationGroup.RunExecutable(aParameter: String = String.Empty): Boolean;
Begin
   If Not IsApplication Then
      Raise Exception.Create('Execution failed. Group is not created as application.');

   If FixedParameter <> cParameterNone Then
      aParameter := aParameter + ' ' + FixedParameter;
   Try
      If FormMDIMain.RunAsAdmin Then
         RunAsAdmin(FormMDIMain.Handle, PWideChar(ExecutableName), PWideChar(aParameter), PWideChar(SourceFolder))
      Else
         ShellExecute(FormMDIMain.Handle, 'open', PWideChar(ExecutableName), PWideChar(aParameter), PWideChar(SourceFolder), SW_SHOWNORMAL);
   Except
      // Do nothing. It's not easily possible to handle all the issues related to shell execute. { Ajmal }
   End;
End;

Procedure TEApplicationGroup.SaveData(Const aFileName: String);
Var
   varIniFile: TIniFile;
Begin
   varIniFile := TIniFile.Create(aFileName);
   Try
      varIniFile.WriteString(Name, cGroupFixedParam, FixedParameter);
      varIniFile.WriteString(Name, cGroupExeName, ExecutableName);
      varIniFile.WriteString(Name, cGroupFileMask, FileMask);
      varIniFile.WriteString(Name, cGroupSourceFolder, SourceFolder);
      varIniFile.WriteString(Name, cGroupDestFolder, DestFolder);
      varIniFile.WriteBool(Name, cGroupCreateFolder, CreateFolder);
      varIniFile.WriteBool(Name, cGroupIsApp, IsApplication);
      varIniFile.WriteString(Name, cGroupLabel, DisplayLabel);
      varIniFile.WriteBool(Name, cGroupIsMajorBranching, IsMajorBranching);
      varIniFile.WriteBool(Name, cGroupIsMinorBranching, IsMinorBranching);
      varIniFile.WriteBool(Name, cGroupIsReleaseBranching, IsReleaseBranching);
      varIniFile.WriteString(Name, cGroupBranchingPrefix, BranchingPrefix);
      varIniFile.WriteString(Name, cGroupBranchingSufix, BranchingSufix);
      varIniFile.WriteInteger(Name, cGroupBranchingMainBranch, MainBranch);
      varIniFile.WriteInteger(Name, cGroupBranchingNoOfBuilds, NoOfBuilds);
   Finally
      varIniFile.Free;
   End;
End;

Procedure TEApplicationGroup.SetDestFolder(Const Value: String);
Var
   iLen: Integer;
Begin
   iLen := Length(Value);
   If (iLen > 0) And (Value[iLen] <> '\') Then
      FDestFolder := Value + '\'
   Else
      FDestFolder := Value;
End;

Procedure TEApplicationGroup.SetFileMask(Const Value: String);
Begin
   FFileMask := Value;
End;

Procedure TEApplicationGroup.SetSourceFolder(Const Value: String);
Var
   iLen: Integer;
Begin
   iLen := Length(Value);
   If (iLen > 0) And (Value[iLen] <> '\') Then
      FSourceFolder := Value + '\'
   Else
      FSourceFolder := Value;
End;

Function TEApplicationGroup.TargetFolder: String;
Begin
   If CreateFolder Then
      Result := DestFolder // + Copy(ExecutableName, 1, Length(FFileName) - Length(ExtractFileExt(FFileName)))
   Else
      Result := DestFolder;
End;

Function TEApplicationGroup.UnZip: Boolean;
Begin
   // Nothing to do. { Ajmal }
End;

Function TEApplicationGroup._AddRef: Integer;
Begin
   Inherited;
End;

Function TEApplicationGroup._Release: Integer;
Begin
   Inherited;
End;

{ TEApplicationGroups }

Function TEApplicationGroups.AddItem(Const aName: String): TEApplicationGroup;
Begin
   If ContainsKey(aName) Then
      Raise Exception.Create('Group with same name already exist');

   Result := TEApplicationGroup.Create;
   Result.Name := aName;
   Add(aName, Result);
End;

Constructor TEApplicationGroups.Create;
Begin
   Inherited Create([doOwnsValues]);

   FIsLoaded := False;
End;

Procedure TEApplicationGroups.LoadData(Const aFileName: String);
Var
   varIniFile: TIniFile;
   varList: TStringList;
   iCntr: Integer;
   sCurrName: String;
   varCurrAppGrp: TEApplicationGroup;
Begin
   varIniFile := TIniFile.Create(aFileName);
   varList := TStringList.Create;
   varList.Duplicates := dupIgnore;
   varList.Sorted := True;
   Try
      Try
         varIniFile.ReadSections(varList);
      Finally
         varIniFile.Free;
      End;
      For iCntr := 0 To Pred(varList.Count) Do
      Begin
         sCurrName := varList[iCntr];
         If sCurrName.IsEmpty Then
            Continue;

         varCurrAppGrp := AddItem(sCurrName);
         If Not Assigned(varCurrAppGrp) Then
            Continue; // A group with same name already exist. { Ajmal }

         varCurrAppGrp.LoadData(aFileName);
      End;
      FIsLoaded := True;
   Finally
      varList.Free;
   End;
End;

Procedure TEApplicationGroups.SaveData(Const aFileName: String);
Var
   varCurrAppGrp: TEApplicationGroup;
Begin
   If Not FIsLoaded Then
      Exit; // Don't save if it's not loaded. { Ajmal }

   DeleteFile(aFileName);
   For varCurrAppGrp In Values Do
      varCurrAppGrp.SaveData(aFileName);
End;

{ TEApplication }

Function TEApplication.BuildNumber: Integer;
Begin
   If Not Owner.IsBranchingEnabled Then
      Exit(cInvalidBuildNumber);

   Try
      Result := StrToInt(VersionName.Split(['.'])[3].Trim);
   Except
      Result := cInvalidBuildNumber;
   End;
End;

Constructor TEApplication.Create(Const aOwner: TEApplicationGroup);
Begin
   Assert(aOwner <> Nil, 'Owner cannot be nil');
   Owner := aOwner;
   FVersionName := '';
End;

Function TEApplication.GetFileName(aType: eTAppFile): String;
Begin
   Case aType Of
      eafName:
         Result := Copy(FFileName, 1, Length(FFileName) - Length(ExtractFileExt(FFileName)));
      eafFileName:
         Result := FFileName;
      eafExtension:
         Result := ExtractFileExt(FFileName);
   End;
End;

Function TEApplication.MajorVersionName: String;
Begin
   If Not Owner.IsMajorBranching Then
      Exit('');

   Try
      Result := 'Version ' + VersionName.Split(['.'])[0].Trim;
   Except
      Result := '';
   End;
End;

Function TEApplication.MinotVersionName: String;
Begin
   If Not Owner.IsMinorBranching Then
      Exit('');

   Try
      Result := Format('Version %s.%s', [VersionName.Split(['.'])[0].Trim, VersionName.Split(['.'])[1].Trim]);
   Except
      Result := '';
   End;
End;

Function TEApplication.QueryInterface(Const IID: TGUID; Out Obj): HRESULT;
Begin
   Inherited;
End;

Function TEApplication.ReleaseVersionName: String;
Var
   sRelease: String;
Begin
   If Not Owner.IsReleaseBranching Then
      Exit('');

   Try
      sRelease := VersionName.Split(['.'])[2].Trim;
      If sRelease.Equals(IntToStr(Owner.MainBranch)) Then
         Result := 'Main Release'
      Else
         Result := 'Release ' + sRelease;
   Except
      Result := '';
   End;
End;

Function TEApplication.RunExecutable(aParameter: String): Boolean;
Begin
   If Owner.FixedParameter <> cParameterNone Then
      aParameter := aParameter + ' ' + Owner.FixedParameter;
   Try
      If FormMDIMain.RunAsAdmin Then
         RunAsAdmin(FormMDIMain.Handle, PWideChar(Owner.ExecutableName), PWideChar(aParameter), PWideChar(TargetFolder))
      Else
         ShellExecute(FormMDIMain.Handle, 'open', PWideChar(Owner.ExecutableName), PWideChar(aParameter), PWideChar(TargetFolder), SW_SHOWNORMAL);
   Except
      // Do nothing. It's not easily possible to handle all the issues related to shell execute. { Ajmal }
   End;
End;

Procedure TEApplication.SetOwner(Const Value: TEApplicationGroup);
Begin
   FOwner := Value;
End;

Function TEApplication.TargetFolder: String;
Begin
   If Owner.CreateFolder Then
      Result := Owner.DestFolder + Name
   Else
      Result := Owner.DestFolder;
End;

Function TEApplication.UnZip: Boolean;
Var
   varZipObj: TObject;
{$IFDEF AbbreviaZipper}
   varUnAbZipper: TAbUnZipper Absolute varZipObj;
Begin
   varZipObj := TAbUnZipper.Create(Nil);
   If Assigned(FormParameterBrowser) Then
   Begin
      varUnAbZipper.ArchiveProgressMeter := TAbProgressBar(FormParameterBrowser.ZipProgressBarArchive);
      varUnAbZipper.ItemProgressMeter := TAbProgressBar(FormParameterBrowser.ZipProgressBarItem);
   End;
{$ELSE}
   varZipFile: TZipFile Absolute varZipObj;
Begin
   varZipObj := TZipFile.Create;
{$ENDIF}
   Result := False;
   Try
      If Not SameText(Extension, '.zip') Then
         Exit(False); // This will go to finally before function exit. So objected ll be freed. { Ajmal }

      If DirectoryExists(TargetFolder) Then
         Exit;
      ForceDirectories(TargetFolder);
{$IFDEF AbbreviaZipper}
      varUnAbZipper.FileName := Owner.SourceFolder + FileName;
      varUnAbZipper.BaseDirectory := TargetFolder;
      varUnAbZipper.ExtractFiles('*.*');
{$ELSE}
      varZipFile.ExtractZipFile(Owner.SourceFolder + FileName, sDestFolder);
{$ENDIF}
      Result := True;
   Finally
      varZipObj.Free;
   End;
End;

Function TEApplication.VersionName: String;
Begin
   If Not Owner.IsBranchingEnabled Then
      Exit('');

   If Not FVersionName.IsEmpty Then
      Exit(FVersionName);

   FVersionName := Name;

   If (Not Owner.BranchingPrefix.IsEmpty) And Name.StartsWith(Owner.BranchingPrefix, True) Then
      FVersionName := StringReplace(FVersionName, Owner.BranchingPrefix, '', [rfIgnoreCase]);

   If (Not Owner.BranchingSufix.IsEmpty) And Name.EndsWith(Owner.BranchingSufix, True) Then
      FVersionName := StrSubString(Length(Owner.BranchingSufix), FVersionName);

   Result := FVersionName;
End;

Function TEApplication._AddRef: Integer;
Begin
   Inherited;
End;

Function TEApplication._Release: Integer;
Begin
   Inherited;
End;

End.
