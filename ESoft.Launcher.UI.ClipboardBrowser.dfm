object FormClipboardBrowser: TFormClipboardBrowser
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Clipboard Browser'
  ClientHeight = 354
  ClientWidth = 656
  Color = 14871789
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelSearch: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 650
    Height = 38
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 5
      Width = 37
      Height = 28
      Margins.Left = 8
      Align = alLeft
      Caption = 'Search'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object edtFilter: TButtonedEdit
      AlignWithMargins = True
      Left = 55
      Top = 8
      Width = 488
      Height = 21
      Margins.Left = 5
      Margins.Top = 6
      Margins.Right = 8
      Margins.Bottom = 7
      Align = alClient
      RightButton.ImageIndex = 24
      RightButton.Visible = True
      TabOrder = 0
      TextHint = ' Filter Text'
      OnChange = edtFilterChange
      OnKeyUp = edtFilterKeyUp
    end
    object chkSearchInData: TCheckBox
      Left = 551
      Top = 2
      Width = 97
      Height = 34
      Align = alRight
      Caption = ' Search in data'
      TabOrder = 1
      OnClick = chkSearchInDataClick
    end
  end
  object dbGridClpBrdItems: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 200
    Height = 263
    Align = alClient
    DataSource = SourceClipboardItems
    DrawingStyle = gdsGradient
    GradientEndColor = 14083302
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ClpBrdName'
        Title.Caption = 'Clipboard Item Name'
        Width = 600
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ClpBrdData'
        Visible = False
      end>
  end
  object DBMemoData: TDBMemo
    Left = 206
    Top = 44
    Width = 450
    Height = 269
    Align = alRight
    DataField = 'ClpBrdData'
    DataSource = SourceClipboardItems
    ReadOnly = True
    TabOrder = 2
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 316
    Width = 650
    Height = 35
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 3
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 565
      Top = 5
      Width = 75
      Height = 25
      Margins.Right = 8
      Align = alRight
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      TabStop = False
      OnClick = btnCancelClick
    end
    object btnSave: TButton
      AlignWithMargins = True
      Left = 479
      Top = 5
      Width = 75
      Height = 25
      Margins.Right = 8
      Align = alRight
      Caption = 'Save'
      Default = True
      ModalResult = 1
      TabOrder = 1
      TabStop = False
      OnClick = btnSaveClick
    end
  end
  object ClntDSetClipBboardItems: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ClpBrdName'
    Params = <>
    Left = 152
    Top = 104
    object ClntDSetClipBboardItemsName: TStringField
      FieldName = 'ClpBrdName'
      Size = 250
    end
    object ClntDSetClipBboardItemsData: TStringField
      FieldName = 'ClpBrdData'
      Visible = False
      Size = 1000
    end
  end
  object SourceClipboardItems: TDataSource
    AutoEdit = False
    DataSet = ClntDSetClipBboardItems
    Left = 120
    Top = 104
  end
  object MainMenu: TMainMenu
    Images = FormMDIMain.ImageList_20
    Left = 88
    Top = 104
    object MenuFile: TMenuItem
      Caption = 'File'
      object MItemDelete: TMenuItem
        Caption = 'Delete'
        ShortCut = 46
        OnClick = PMItemDeleteClick
      end
      object MItemRename: TMenuItem
        Caption = 'Rename'
        ShortCut = 113
        OnClick = PMItemRenameClick
      end
      object MItemSave: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = btnSaveClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MItemClose: TMenuItem
        Caption = 'Close'
        ShortCut = 27
        OnClick = MItemCloseClick
      end
    end
    object MenuSearch: TMenuItem
      Caption = 'Search'
      object MItemSearch: TMenuItem
        Caption = 'Search'
        ShortCut = 114
        OnClick = MItemSearchClick
      end
      object PMItemSearchInData: TMenuItem
        Caption = 'Search in data'
        ShortCut = 115
        OnClick = PMItemSearchInDataClick
      end
    end
  end
  object PopupMenu: TPopupMenu
    Images = FormMDIMain.ImageList_20
    OnPopup = PopupMenuPopup
    Left = 88
    Top = 136
    object PMItemDelete: TMenuItem
      Caption = 'Delete'
      ImageIndex = 31
      ShortCut = 46
      OnClick = PMItemDeleteClick
    end
    object PMItemRename: TMenuItem
      Caption = 'Rename'
      ImageIndex = 35
      ShortCut = 113
      OnClick = PMItemRenameClick
    end
  end
end
