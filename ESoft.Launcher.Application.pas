Unit ESoft.Launcher.Application;

{----------------------------------------------------------}
{Developed by Muhammad Ajmal p}
{ajumalp@gmail.com}
{----------------------------------------------------------}

Interface

Uses
  Winapi.Windows,
  System.Classes,
  IniFiles,
  System.SysUtils,
  ShellApi,
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

Type
  IEApplication = Interface
    Function RunExecutable(aParameter: String = ''): Boolean;
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
    FFileName: String;

    Function GetFileName(aType: eTAppFile): String;
    Procedure SetOwner(Const Value: TEApplicationGroup);

  Public
    Constructor Create(Const aOwner: TEApplicationGroup);

    Function QueryInterface(
      Const IID: TGUID;
      Out Obj): HRESULT; Stdcall;
    Function _AddRef: Integer; Stdcall;
    Function _Release: Integer; Stdcall;

    Function RunExecutable(aParameter: String = ''): Boolean;
    Function UnZip: Boolean;

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
    FCreateFolder: Boolean;

    Procedure SetSourceFolder(Const Value: String);
    Procedure SetDestFolder(Const Value: String);
    Procedure SetFileMask(Const Value: String);
    Function AddItem: TEApplication;

  Public
    Constructor Create;

    Function QueryInterface(
      Const IID: TGUID;
      Out Obj): HRESULT; Stdcall;
    Function _AddRef: Integer; Stdcall;
    Function _Release: Integer; Stdcall;

    Function RunExecutable(aParameter: String = ''): Boolean;
    Function UnZip: Boolean;
    Procedure LoadApplications;
    Procedure LoadData(Const aFileName: String);
    Procedure SaveData(Const aFileName: String);

  Published
    Property Name: String Read FName Write FName;
    Property ExecutableName: String Read FExecutableName Write FExecutableName;
    Property FileMask: String Read FFileMask Write SetFileMask;
    Property DestFolder: String Read FDestFolder Write SetDestFolder;
    Property SourceFolder: String Read FSourceFolder Write SetSourceFolder;
    Property CreateFolder: Boolean Read FCreateFolder Write FCreateFolder;
    Property FixedParameter: String Read FFixedParameter Write FFixedParameter;
    Property IsApplication: Boolean Read FIsApplication Write FIsApplication;
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
    Function AddItem(Const aName: String = ''): TEApplicationGroup;
  End;

Implementation

{TEApplicationGroup}

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

Function TEApplicationGroup.AddItem: TEApplication;
Begin
  Result := TEApplication.Create(Self);
  Add(Result);
End;

Constructor TEApplicationGroup.Create;
Begin
  Inherited Create(True);

  FCreateFolder := True;
  FSourceFolder := '';
  FDestFolder := '';
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
        AddItem.FileName := varSearch.Name;
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
  Finally
    varIniFile.Free;
  End;
End;

Function TEApplicationGroup.QueryInterface(
  Const IID: TGUID;
  Out Obj): HRESULT;
Begin
  Inherited;
End;

Function TEApplicationGroup.RunExecutable(aParameter: String = ''): Boolean;
Begin
  If Not IsApplication Then
    Raise Exception.Create('Execution failed. Group is not created as application.');

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

{TEApplicationGroups}

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
      If sCurrName = '' Then
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

{TEApplication}

Constructor TEApplication.Create(Const aOwner: TEApplicationGroup);
Begin
  Assert(aOwner <> Nil, 'Owner cannot be nil');
  Owner := aOwner;
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

Function TEApplication.QueryInterface(
  Const IID: TGUID;
  Out Obj): HRESULT;
Begin
  Inherited;
End;

Function TEApplication.RunExecutable(aParameter: String): Boolean;
Var
  sDestFolder: String;
Begin
  aParameter := Owner.FixedParameter + ' ' + aParameter;
  If Owner.CreateFolder Then
    sDestFolder := Owner.DestFolder + Name
  Else
    sDestFolder := Owner.DestFolder;
  Try
    If FormMDIMain.RunAsAdmin Then
      RunAsAdmin(FormMDIMain.Handle, PWideChar(Owner.ExecutableName), PWideChar(aParameter), PWideChar(sDestFolder))
    Else
      ShellExecute(FormMDIMain.Handle, 'open', PWideChar(Owner.ExecutableName), PWideChar(aParameter), PWideChar(sDestFolder), SW_SHOWNORMAL);
  Except
    // Do nothing. It's not easily possible to handle all the issues related to shell execute. { Ajmal }
  End;
End;

Procedure TEApplication.SetOwner(Const Value: TEApplicationGroup);
Begin
  FOwner := Value;
End;

Function TEApplication.UnZip: Boolean;
Var
  sDestFolder: String;
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

    If Owner.CreateFolder Then
    Begin
      sDestFolder := Owner.DestFolder + Name;
      If DirectoryExists(sDestFolder) Then
        Exit;
      ForceDirectories(sDestFolder);
    End
    Else
      sDestFolder := Owner.DestFolder;
{$IFDEF AbbreviaZipper}
    varUnAbZipper.FileName := Owner.SourceFolder + FileName;
    varUnAbZipper.BaseDirectory := sDestFolder;
    varUnAbZipper.ExtractFiles('*.*');
{$ELSE}
    varZipFile.ExtractZipFile(Owner.SourceFolder + FileName, sDestFolder);
{$ENDIF}
    Result := True;
  Finally
    varZipObj.Free;
  End;
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
