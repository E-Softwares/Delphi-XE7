Unit ESoft.Launcher.Clipboard;

Interface

Uses
   Winapi.Windows,
   System.Classes,
   IniFiles,
   System.SysUtils,
   ShellApi,
   Vcl.Graphics,
   Generics.Collections,
   ESoft.Utils,
   Clipbrd;

Type
   TEClipboardItem = Class(TPersistent)
   Strict Private
      FName: String;
      FData: WideString;
   Public
      Constructor Create(Const aName: String);
   Published
      Property Name: String Read FName;
      Property Data: WideString Read FData Write FData;
   End;

   TEClipboardItems = Class(TObjectList<TEClipboardItem>)
   Strict Private
      FStringList: TStringList;

      Function GetStringList: TStringList;
   Public
      Destructor Destroy; Override;

      Function Contains(Const aName: String): Boolean;
      Function IndexOf(Const aName: String): Integer;
      Function AddItem(Const aName: String): TEClipboardItem;

      Procedure Save;
      Procedure Load;

      Property StringList: TStringList Read GetStringList;
   End;

Implementation

{ TEClipboard }

Uses
   UnitMDIMain;

{ TEClipboardItems }

Function TEClipboardItems.AddItem(Const aName: String): TEClipboardItem;
Var
   iIndex: Integer;
Begin
   Result := Nil;

   iIndex := IndexOf(aName);
   If iIndex <> -1 Then
      Exit(Items[iIndex]);

   Result := TEClipboardItem.Create(aName);
   Add(Result);
End;

Function TEClipboardItems.Contains(Const aName: String): Boolean;
Begin
   Result := IndexOf(aName) <> -1;
End;

Destructor TEClipboardItems.Destroy;
Begin
   EFreeAndNil(FStringList);

   Inherited;
End;

Function TEClipboardItems.GetStringList: TStringList;
Begin
   If Not Assigned(FStringList) Then
      FStringList := TStringList.Create;
   Result := FStringList;
End;

Function TEClipboardItems.IndexOf(Const aName: String): Integer;
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

Procedure TEClipboardItems.Load;
Begin
   StringList.LoadFromFile(FormMDIMain.ParentFolder + cClipbord_Data);
End;

Procedure TEClipboardItems.Save;
Begin
   StringList.SaveToFile(FormMDIMain.ParentFolder + cClipbord_Data);
End;

{ TEClipboardItem }

Constructor TEClipboardItem.Create(Const aName: String);
Begin
   FName := aName;
End;

End.
