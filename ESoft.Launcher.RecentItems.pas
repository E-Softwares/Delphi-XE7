Unit ESoft.Launcher.RecentItems;

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
   Generics.Collections,
   ESoft.Utils;

Type
   IEApplication = Interface
      Function GetActualName: String;
      Function RunExecutable(aParameter: String = String.Empty): Boolean;
      Function UnZip: Boolean;

      Property ActualName: String Read GetActualName;
   End;

   TERecentItem = Class(TPersistent, IEApplication)
   Strict Private
      FName: String;
      FSourceFolder: String;
      FExecutableName: String;
      FParameter: String;
      FIcon: TIcon;

      Function GetActualName: String;
      Function GetIcon: TIcon;
   Public
      Constructor Create(Const aName: String);
      Destructor Destroy; Override;

      Function QueryInterface(Const IID: TGUID; Out Obj): HRESULT; Stdcall;
      Function _AddRef: Integer; Stdcall;
      Function _Release: Integer; Stdcall;

      Function RunExecutable(aParameter: String = String.Empty): Boolean;
      Function UnZip: Boolean;

      Property ActualName: String Read GetActualName;
      Property Name: String Read FName;
      Property SourceFolder: String Read FSourceFolder Write FSourceFolder;
      Property ExecutableName: String Read FExecutableName Write FExecutableName;
      Property Parameter: String Read FParameter Write FParameter;
      Property Icon: TIcon Read GetIcon;
   End;

   TERecentItems = Class(TObjectList<TERecentItem>)
   Strict Private
      FOnChange: TNotifyEvent;

      Procedure DoChange(Const aItem: TERecentItem);
   Public
      Function Contains(Const aName: String): Boolean;
      Function IndexOf(Const aName: String): Integer;
      Function AddItem(Const aName: String): TERecentItem;
   Published
      Property OnChange: TNotifyEvent Read FOnChange Write FOnChange;
   End;

Implementation

{ TERecentItem }

Uses
   UnitMDIMain;

Constructor TERecentItem.Create(Const aName: String);
Begin
   FName := aName;
End;

Destructor TERecentItem.Destroy;
Begin
   EFreeAndNil(FIcon);

   Inherited;
End;

Function TERecentItem.GetActualName: String;
Begin
   Result := Name;
End;

Function TERecentItem.GetIcon: TIcon;
Begin
   Result := Nil;

   EFreeAndNil(FIcon);
   FIcon := TIcon.Create;
   Try
      FetchIcon(SourceFolder + ExecutableName, FIcon);
      Result := FIcon;
   Except
      EFreeAndNil(FIcon);
      // Do nothing, it's not mandatory to have icon { Ajmal }
   End;
End;

Function TERecentItem.QueryInterface(Const IID: TGUID; Out Obj): HRESULT;
Begin
   Inherited;
End;

Function TERecentItem.RunExecutable(aParameter: String): Boolean;
Begin
   FormMDIMain.RunApplication(Name, ExecutableName, aParameter, SourceFolder);
End;

Function TERecentItem.UnZip: Boolean;
Begin
   // Nothing to do. { Ajmal }
End;

Function TERecentItem._AddRef: Integer;
Begin
   Inherited;
End;

Function TERecentItem._Release: Integer;
Begin
   Inherited;
End;

{ TERecentItems }

Function TERecentItems.AddItem(Const aName: String): TERecentItem;
Var
   iIndex: Integer;
Begin
   Result := Nil;

   iIndex := IndexOf(aName);
   If iIndex <> -1 Then
   Begin
      Result := Items[iIndex];
      Move(iIndex, 0);
      If iIndex <> IndexOf(aName) Then
         DoChange(Result);
      Exit;
   End;

   Result := TERecentItem.Create(aName);
   Insert(0, Result);
   DoChange(Result);
End;

Function TERecentItems.Contains(Const aName: String): Boolean;
Begin
   Result := IndexOf(aName) <> -1;
End;

Procedure TERecentItems.DoChange(Const aItem: TERecentItem);
Begin
   If Assigned(FOnChange) Then
      FOnChange(aItem);
End;

Function TERecentItems.IndexOf(Const aName: String): Integer;
Var
   iCntr: Integer;
Begin
   Result := -1;

   For iCntr := 0 To Pred(Count) Do
   Begin
      If SameText(Items[iCntr].Name, aName) Then
         Exit(iCntr);
   End;
End;

End.
