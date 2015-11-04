Unit ESoft.Utils;

Interface

Uses
  Windows,
  System.Classes,
  System.SysUtils,
  ShellApi,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IniFiles,
  Vcl.Dialogs,
  Vcl.Controls,
  Registry;

Const
  cInvalidAppCode = 1;
  cNoNewAppVersionAvailablePrompt = 'No new update available.';
  cNewAppVersionAvailablePrompt = 'New version of application is available.' + sLineBreak + 'Do you want to update ?';
  cAppVersionFileLink = 'http://esoft.ucoz.com/ESoft_Licence/ESoft_App_Version.txt';
  cUniqueFileFormat = '%s-%s';
  cUniqueFileDateFormat = 'yyyy_MMM_dd';
  cUniqueFileTimeFormat = 'hh_nn_ss';

Type
  eTRegistryType = (REG_DELETE, REG_ADD, REG_READ);

Function StrStartsWith(
  aContent, aStart: String;
  aCaseSensitive: Boolean = True): Boolean;
Function StrSubString(
  aContent: String;
  aStart, aEnd: Integer): String; Overload;
Function StrSubString(
  aContent: String;
  aStart: Integer): String; Overload;
Function StrSubString(
  aReverseCnt: Integer;
  aContent: String): String; Overload;
Function StrEndsWith(aContent, aEnd: String): Boolean;
Function IfThen(
  Const aCondition: Boolean;
  Const aTrueValue, aFalseValue: Variant): Variant;
Function AddToStartup(
  Const aCaption: String;
  Const aRegtype: eTRegistryType): Boolean;
Function GetUniqueFilename(
  Const aFolder: String;
  aExtn: String;
  Const aPrefix: String = ''): String;
Procedure RunAsAdmin(
  hWnd: HWND;
  Const aFileName, aParameters, aDirectory: String;
  Const aShowState: Integer = SW_SHOWNORMAL);
Function GetAppVersionFromSite(
  Const aUniqueAppCode: String;
  Const aLink: String = cAppVersionFileLink): String;
Procedure EFreeAndNil(Var AObj);

Implementation

Function StrStartsWith(
  aContent, aStart: String;
  aCaseSensitive: Boolean): Boolean;
Begin
  // returns true if sContent starts with sStart
  If aCaseSensitive Then
    Result := SameStr(Copy(aContent, 0, Length(aStart)), aStart)
  Else
    Result := SameText(Copy(aContent, 0, Length(aStart)), aStart);
End;

Function IfThen(
  Const aCondition: Boolean;
  Const aTrueValue, aFalseValue: Variant): Variant;
Begin
  If aCondition Then
    Result := aTrueValue
  Else
    Result := aFalseValue;
End;

Function StrEndsWith(aContent, aEnd: String): Boolean;
Var
  iLen: Integer;
Begin
  // returns true if sContent ends with sEnd
  iLen := Length(aContent);
  Result := (Copy(aContent, iLen - (Length(aEnd) - 1), iLen) = aEnd);
End;

Function StrSubString(
  aContent: String;
  aStart, aEnd: Integer): String;
Begin
  // returns the substring from iStart to iEnd
  Result := Copy(aContent, aStart, aEnd - (aStart - 1));
End;

Function StrSubString(
  aContent: String;
  aStart: Integer): String;
Begin
  // returns the substring starting from iStart char index
  Result := StrSubString(aContent, aStart, Length(aContent));
End;

Function StrSubString(
  aReverseCnt: Integer;
  aContent: String): String;
Begin
  // returns the substring till the StrLen - iRevCnt
  Result := StrSubString(aContent, 1, Length(aContent) - aReverseCnt);
End;

Function AddToStartup(
  Const aCaption: String;
  Const aRegtype: eTRegistryType): Boolean;
Var
  Key: String;
  Reg: TRegIniFile;
Begin
  Result := False;
  Key := '\Software\Microsoft\Windows\CurrentVersion\Run' + #0; // RunOnce
  Reg := TRegIniFile.Create;
  Try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.CreateKey(Key);
    If Reg.OpenKey(Key, False) Then
    Begin
      Result := (Reg.ReadString(Key, aCaption, '') = ParamStr(0));
      If aRegtype In [REG_ADD, REG_DELETE] Then
      Begin
        Case aRegtype Of
          REG_DELETE:
            Begin
              If Result Then
                Reg.DeleteKey(Key, aCaption);
            End;
          REG_ADD:
            Begin
              If Not Result Then
                Reg.WriteString(Key, aCaption, ParamStr(0));
            End;
        End;
        Result := (Reg.ReadString(Key, aCaption, '') = ParamStr(0));
      End;
    End;
  Finally
    Reg.Free;
  End;
End;

Function GetUniqueFilename(
  Const aFolder: String;
  aExtn: String;
  Const aPrefix: String): String;
Begin
  Result := '';
  If (Trim(aFolder) = '') Or Not DirectoryExists(aFolder) Then
    Raise Exception.Create('Invalid folder');
  If (Length(aExtn) > 0) And (aExtn[1] <> '.') Then
    aExtn := '.' + aExtn;

  Repeat
    Sleep(100);
    Result := aFolder + aPrefix + FormatDateTime(Format(cUniqueFileFormat, [cUniqueFileDateFormat, cUniqueFileTimeFormat]), Now) + aExtn;
  Until Not FileExists(Result);
End;

Procedure RunAsAdmin(
  hWnd: HWND;
  Const aFileName, aParameters, aDirectory: String;
  Const aShowState: Integer);
Var
  varExecuteInfo: TShellExecuteInfo;
Begin
  FillChar(varExecuteInfo, SizeOf(varExecuteInfo), 0);
  varExecuteInfo.cbSize := SizeOf(varExecuteInfo);
  varExecuteInfo.Wnd := hWnd;
  varExecuteInfo.fMask := SEE_MASK_FLAG_DDEWAIT Or SEE_MASK_FLAG_NO_UI;
  varExecuteInfo.lpVerb := 'runas';
  varExecuteInfo.lpFile := PWideChar(aFileName);
  varExecuteInfo.lpParameters := PWideChar(aParameters);
  varExecuteInfo.lpDirectory := PWideChar(aDirectory);
  varExecuteInfo.nShow := aShowState;
  If Not ShellExecuteEx(@varExecuteInfo) Then
    RaiseLastOSError;
End;

Function GetAppVersionFromSite(
  Const aUniqueAppCode: String;
  Const aLink: String): String;
Var
  varHtttp: TIdHTTP;
  varList: TStringList;
  iCntr: Integer;
Begin
  Result := '';

  varHtttp := TIdHTTP.Create;
  varList := TStringList.Create;
  Try
    varList.Duplicates := dupAccept;
    varList.Sorted := True;
    varList.Text := varHtttp.Get(aLink);
    Result := varList.Values[aUniqueAppCode];
    If Result = '' Then
      Raise Exception.CreateHelp('Application code is not valid', cInvalidAppCode);
  Finally
    varList.Free;
    varHtttp.Free;
  End;
End;

Procedure EFreeAndNil(Var aObj);
Begin
  If Assigned(TObject(aObj)) Then
    FreeAndNil(aObj);
End;

End.
