Unit ESoft.Launcher.Parameter;

{----------------------------------------------------------}
{Developed by Muhammad Ajmal p}
{ajumalp@gmail.com}
{----------------------------------------------------------}

Interface

Uses
  System.Classes,
  IniFiles,
  Generics.Collections,
  System.SysUtils;

Const
  cParamTypeInvalid = -1;
  cParamTypeConnection = 0;
  cParamTypeAdditional = 1;

Type
  TEConnections = Class(TPersistent)
  Private
    // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
  Strict Private
    // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
    FItems: TStringList;
    FFileName: String;
    Function GetFileName: String;
    Procedure SetFileName(Const Value: String);
    Function GetItems(aIndex: Integer): String;

  Public
    Constructor Create;
    Destructor Destroy; Override;

    Procedure LoadConnections;

    // This is the default property of this call. We can access with Self[iCntr] { Ajmal }
    Property Items[aIndex: Integer]: String Read GetItems; Default;
    Property Connections: TStringList Read FItems;

  Published
    Property FileName: String Read GetFileName Write SetFileName;
  End;

Type
  TEParameterBase = Class(TPersistent)
  Private
    // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
  Strict Private
    // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
    FParamType: Integer;
    FParameter: String;
    FName: String;

  Public
    Constructor Create; Virtual;

    Procedure LoadData(Const aFilename: String); Virtual;
    Procedure SaveData(Const aFilename: String); Virtual;

  Published
    Property Name: String Read FName Write FName;
    Property Parameter: String Read FParameter Write FParameter;
    Property ParamType: Integer Read FParamType Write FParamType;
  End;

  TEParameters = Class(TObjectDictionary<String, TEParameterBase>)
  Strict Private
    FIsLoaded: Boolean;

  Public
    Constructor Create;

    Procedure LoadData(Const aFileName: String);
    Procedure SaveData(Const aFileName: String);
    Function AddItem(
      Const aName: String;
      Const aType: SmallInt = cParamTypeConnection): TEParameterBase;
  End;

  TEAdditionalParameter = Class(TEParameterBase)
  Private
    // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
  Strict Private
    // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
    FDefaultInclude: Boolean;

  Public
    Constructor Create; Override;

    Procedure LoadData(Const aFilename: String); Override;
    Procedure SaveData(Const aFilename: String); Override;

  Published
    Property DefaultInclude: Boolean Read FDefaultInclude Write FDefaultInclude;
  End;

  TEConnectionParameter = Class(TEParameterBase)
  Private
    // Private declarations. Variables/Methods can be access inside this class and other class in the same unit. { Ajmal }
  Strict Private
    // Strict Private declarations. Variables/Methods can be access inside this class only. { Ajmal }
    FConnection: String;

  Public
    Constructor Create; Override;

    Procedure LoadData(Const aFilename: String); Override;
    Procedure SaveData(Const aFilename: String); Override;

  Published
    Property Connection: String Read FConnection Write FConnection;
  End;

Implementation

Uses
  UnitMDIMain;

Const
  cParamType = 'Param_Type';
  cParamText = 'Param_Text';
  cParamConnection = 'Param_Connection';
  cParamDefaultInclude = 'Param_Default_Include';

  {TEParameterBase}

Constructor TEParameterBase.Create;
Begin
  // Virtual method, do nothing here. { Ajmal }
End;

Procedure TEParameterBase.LoadData(Const aFilename: String);
Var
  varIniFile: TIniFile;
Begin
  varIniFile := TIniFile.Create(aFilename);
  Try
    Parameter := varIniFile.ReadString(Name, cParamText, '');
    ParamType := varIniFile.ReadInteger(Name, cParamType, cParamTypeInvalid);
  Finally
    varIniFile.Free;
  End;
End;

Procedure TEParameterBase.SaveData(Const aFilename: String);
Var
  varIniFile: TIniFile;
  iParamType: Integer;
Begin
  varIniFile := TIniFile.Create(aFilename);
  Try
    If Self Is TEConnectionParameter Then
      iParamType := cParamTypeConnection
    Else If Self Is TEAdditionalParameter Then
      iParamType := cParamTypeAdditional
    Else
      iParamType := cParamTypeInvalid;

    varIniFile.WriteString(Name, cParamText, Parameter);
    varIniFile.WriteInteger(Name, cParamType, iParamType);
  Finally
    varIniFile.Free;
  End;
End;

{TEAdditionalParameter}

Constructor TEAdditionalParameter.Create;
Begin
  Inherited;

  ParamType := cParamTypeAdditional;
End;

Procedure TEAdditionalParameter.LoadData(Const aFilename: String);
Var
  varIniFile: TIniFile;
Begin
  Inherited;

  varIniFile := TIniFile.Create(aFilename);
  Try
    DefaultInclude := varIniFile.ReadBool(Name, cParamDefaultInclude, False);
  Finally
    varIniFile.Free;
  End;
End;

Procedure TEAdditionalParameter.SaveData(Const aFilename: String);
Var
  varIniFile: TIniFile;
Begin
  Inherited;

  varIniFile := TIniFile.Create(aFilename);
  Try
    varIniFile.WriteBool(Name, cParamDefaultInclude, DefaultInclude);
  Finally
    varIniFile.Free;
  End;
End;

{TEConnections}

Constructor TEConnections.Create;
Begin
  Inherited;

  FItems := TStringList.Create;
  FItems.Duplicates := dupIgnore;
  FItems.Sorted := True;
End;

Destructor TEConnections.Destroy;
Begin
  FItems.Free;

  Inherited;
End;

Function TEConnections.GetFileName: String;
Begin
  If Trim(FFileName) = '' Then
    Result := cV6_FOLDER + cConnection_INI
  Else
    Result := FFileName;
End;

Procedure TEConnections.SetFileName(Const Value: String);
Begin
  If FFileName <> Value Then
  Begin
    FFileName := Value;
    LoadConnections;
  End;
End;

Function TEConnections.GetItems(aIndex: Integer): String;
Begin
  Result := FItems[aIndex];
End;

Procedure TEConnections.LoadConnections;
Var
  varIniFile: TIniFile;
  varList: TStringList;
  iCntr: Integer;
Begin
  FItems.Clear;
  varIniFile := TIniFile.Create(FileName); // Don't use local variable [FFileName] directly. Always use property. { Ajmal }
  varList := TStringList.Create;
  Try
    varList.Duplicates := dupIgnore;
    varList.Sorted := True;
    varIniFile.ReadSections(varList);
    For iCntr := 0 To Pred(varList.Count) Do
    Begin
      // Check if this is connected. { Ajmal }
      If varIniFile.ReadInteger(varList[iCntr], cConnectionState, 0) = 2 Then
        FItems.Add(varList[iCntr])
    End;
  Finally
    varList.Free;
    varIniFile.Free;
  End;
End;

{TEParameters}

Function TEParameters.AddItem(
  Const aName: String;
  Const aType: SmallInt): TEParameterBase;
Begin
  If ContainsKey(aName) Then
    Raise Exception.Create('Parameter with same name already exist');

  Case aType Of
    cParamTypeConnection:
      Result := TEConnectionParameter.Create;
    cParamTypeAdditional:
      Result := TEAdditionalParameter.Create;
  Else
    Raise Exception.Create(Format('Invalid type [Value %d - %d expected]', [cParamTypeConnection, cParamTypeAdditional]));
  End;
  Result.Name := aName;
  Add(aName, Result);
End;

Constructor TEParameters.Create;
Begin
  Inherited Create([doOwnsValues]);

  FIsLoaded := False;
End;

Procedure TEParameters.LoadData(Const aFileName: String);
Var
  varIniFile: TIniFile;
  varList: TStringList;
  varParameter: TEParameterBase;
  sCurrName: String;
  iCntr: Integer;
Begin
  varIniFile := TIniFile.Create(aFileName);
  varList := TStringList.Create;
  varList.Duplicates := dupIgnore;
  varList.Sorted := True;
  Try
    varIniFile.ReadSections(varList);
    For iCntr := 0 To Pred(varList.Count) Do
    Begin
      sCurrName := varList[iCntr];
      If sCurrName = '' Then
        Continue;

      varParameter := AddItem(sCurrName, varIniFile.ReadInteger(sCurrName, cParamType, cParamTypeInvalid));
      If Not Assigned(varParameter) Then
        Continue; // Parameter with same name already exist or invalid parameter type. { Ajmal }

      varParameter.LoadData(aFileName);
    End;
    FIsLoaded := True;
  Finally
    varIniFile.Free;
    varList.Free;
  End;
End;

Procedure TEParameters.SaveData(Const aFileName: String);
Var
  varParameter: TEParameterBase;
Begin
  If Not FIsLoaded Then
    Exit; // Don't save if it's not loaded. { Ajmal }

  DeleteFile(aFileName);
  For varParameter In Values Do
    varParameter.SaveData(aFileName);
End;

{TEConnectionParameter}

Constructor TEConnectionParameter.Create;
Begin
  Inherited;

  ParamType := cParamTypeConnection;
End;

Procedure TEConnectionParameter.LoadData(Const aFilename: String);
Var
  varIniFile: TIniFile;
Begin
  Inherited;

  varIniFile := TIniFile.Create(aFilename);
  Try
    Connection := varIniFile.ReadString(Name, cParamConnection, '');
  Finally
    varIniFile.Free;
  End;
End;

Procedure TEConnectionParameter.SaveData(Const aFilename: String);
Var
  varIniFile: TIniFile;
Begin
  Inherited;

  varIniFile := TIniFile.Create(aFilename);
  Try
    varIniFile.WriteString(Name, cParamConnection, Connection);
  Finally
    varIniFile.Free;
  End;
End;

End.
