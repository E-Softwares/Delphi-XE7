Unit ESoft.Launcher.Clipboard;

Interface

Uses
   Winapi.Windows,
   System.Classes,
   System.Json,
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
      Constructor Create(Const aName: String = '');

      Function ToJSONString: String;
      Procedure FromJSON(Const aJSONString: String);
      Procedure LoadFromClipboard;
      Procedure SaveToClipboard;
      Procedure Rename(Const aName: String);
   Published
      Property Name: String Read FName;
      Property Data: WideString Read FData Write FData;
   End;

   TEClipboardItems = Class(TObject)
   Strict Private
      FItems: TObjectList<TEClipboardItem>;

      Function GetItemByName(aName: String): TEClipboardItem;
   Private
      Function GetItem(aIndex: Integer): TEClipboardItem;
   Public
      Constructor Create;
      Destructor Destroy; Override;

      Function Contains(Const aName: String): Boolean;
      Function IndexOf(Const aName: String): Integer;
      Function AddItem(Const aName: String): TEClipboardItem;

      Procedure Save;
      Procedure Load;
      Function Count: Integer;
      Procedure DeleteByItemName(aName: String);

      Property Item[aIndex: Integer]: TEClipboardItem Read GetItem; Default;
      Property ItemByName[aName: String]: TEClipboardItem Read GetItemByName;
   End;

Implementation

{ TEClipboard }

Uses
   UnitMDIMain;

Const
   cJSON_NAME = 'CPL_NAME';
   cJSON_VALUE = 'CPL_VALUE';

   { TEClipboardItems }

Function TEClipboardItems.AddItem(Const aName: String): TEClipboardItem;
Var
   iIndex: Integer;
Begin
   Result := Nil;

   iIndex := IndexOf(aName);
   If iIndex <> -1 Then
      Exit(FItems[iIndex]);

   Result := TEClipboardItem.Create(aName);
   FItems.Add(Result);
End;

Function TEClipboardItems.Contains(Const aName: String): Boolean;
Begin
   Result := IndexOf(aName) <> -1;
End;

Function TEClipboardItems.Count: Integer;
Begin
   Result := FItems.Count;
End;

Constructor TEClipboardItems.Create;
Begin
   Inherited;

   FItems := TObjectList<TEClipboardItem>.Create(True);
End;

Procedure TEClipboardItems.DeleteByItemName(aName: String);
Var
   varClpBrdItem: TEClipboardItem;
Begin
   varClpBrdItem := ItemByName[aName];
   If Assigned(varClpBrdItem) Then
      FItems.Remove(varClpBrdItem);
End;

Destructor TEClipboardItems.Destroy;
Begin
   EFreeAndNil(FItems);

   Inherited;
End;

Function TEClipboardItems.GetItem(aIndex: Integer): TEClipboardItem;
Begin
   Result := FItems[aIndex];
End;

Function TEClipboardItems.GetItemByName(aName: String): TEClipboardItem;
Var
   iIndex: Integer;
Begin
   Result := Nil;

   iIndex := IndexOf(aName);
   If iIndex <> -1 Then
      Exit(FItems[iIndex]);
End;

Function TEClipboardItems.IndexOf(Const aName: String): Integer;
Var
   iCntr: Integer;
Begin
   Result := -1;

   For iCntr := 0 To Pred(FItems.Count) Do
   Begin
      If SameText(FItems[iCntr].Name, aName) Then
         Exit(iCntr);
   End;
End;

Procedure TEClipboardItems.Load;
Var
   varClpItem: TEClipboardItem;
   varList: TStringList;
   iCntr: Integer;
Begin
   If Not FileExists(FormMDIMain.ParentFolder + cClipbord_Data) Then
      Exit;

   varList := TStringList.Create;
   Try
      varList.LoadFromFile(FormMDIMain.ParentFolder + cClipbord_Data);
      FItems.Clear; // Clear all items { Ajmal }
      For iCntr := 0 To Pred(varList.Count) Do
      Begin
         varClpItem := TEClipboardItem.Create;
         varClpItem.FromJSON(varList[iCntr]);
         // Don't use FItems.IndexOf(), we need to compare incasesensitive { Ajmal }
         If Not Contains(varClpItem.Name) Then
            FItems.Add(varClpItem);
      End;
   Finally
      varList.Free;
   End;
End;

Procedure TEClipboardItems.Save;
Var
   varClpItem: TEClipboardItem;
   varList: TStringList;
Begin
   varList := TStringList.Create;
   Try
      For varClpItem In FItems Do
         varList.Add(varClpItem.ToJSONString);
      varList.SaveToFile(FormMDIMain.ParentFolder + cClipbord_Data);
   Finally
      varList.Free;
   End;
End;

{ TEClipboardItem }

Constructor TEClipboardItem.Create(Const aName: String);
Begin
   FName := aName;
End;

Procedure TEClipboardItem.FromJSON(Const aJSONString: String);
Var
   varJSONObj: TJSONObject;
Begin
   varJSONObj := TJSONObject.ParseJSONValue(aJSONString) As TJSONObject;
   Try
      FName := varJSONObj.Values[cJSON_NAME].Value;
      FData := varJSONObj.Values[cJSON_VALUE].Value;
   Finally
      varJSONObj.Free;
   End;
End;

Procedure TEClipboardItem.LoadFromClipboard;
Begin
   FData := Clipboard.AsText;
End;

Procedure TEClipboardItem.Rename(Const aName: String);
Begin
   FName := aName;
End;

Procedure TEClipboardItem.SaveToClipboard;
Begin
   Clipboard.AsText := FData;
End;

Function TEClipboardItem.ToJSONString: String;
Var
   varJSONObj: TJSONObject;
Begin
   varJSONObj := TJSONObject.Create;
   Try
      varJSONObj.AddPair(cJSON_NAME, FName);
      varJSONObj.AddPair(cJSON_VALUE, FData);
      Result := varJSONObj.ToJSON;
   Finally
      FreeAndNil(varJSONObj);
   End;
End;

End.
