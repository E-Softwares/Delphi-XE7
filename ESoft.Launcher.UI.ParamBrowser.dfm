object FormParameterBrowser: TFormParameterBrowser
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Parameter Browser'
  ClientHeight = 352
  ClientWidth = 694
  Color = 14871789
  Constraints.MaxHeight = 400
  Constraints.MaxWidth = 700
  Constraints.MinHeight = 400
  Constraints.MinWidth = 700
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelSearch: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 688
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
      Width = 577
      Height = 21
      Margins.Left = 5
      Margins.Top = 6
      Margins.Right = 8
      Margins.Bottom = 7
      Align = alClient
      Images = FormMDIMain.ImageList
      RightButton.ImageIndex = 24
      RightButton.Visible = True
      TabOrder = 0
      TextHint = ' Filter Text'
      OnChange = edtFilterChange
      OnKeyUp = edtFilterKeyUp
    end
    object btnAdditionalParameters: TButton
      AlignWithMargins = True
      Left = 643
      Top = 5
      Width = 40
      Height = 28
      Align = alRight
      DropDownMenu = PopupMenuAdditionalParameters
      ImageAlignment = iaRight
      ImageIndex = 9
      Images = FormMDIMain.ImageList
      Style = bsSplitButton
      TabOrder = 1
      TabStop = False
      OnClick = btnAdditionalParametersClick
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 264
    Width = 688
    Height = 54
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Label2: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 106
      Height = 25
      Align = alLeft
      Caption = 'Selected Parameter '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object lblParameter: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 36
      Width = 678
      Height = 13
      Align = alBottom
      Layout = tlCenter
      ExplicitWidth = 3
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 603
      Top = 5
      Width = 75
      Height = 25
      Margins.Right = 8
      Align = alRight
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      TabStop = False
    end
    object btnOK: TButton
      AlignWithMargins = True
      Left = 517
      Top = 5
      Width = 75
      Height = 25
      Margins.Right = 8
      Align = alRight
      Caption = '  Ok'
      Default = True
      DropDownMenu = PopupMenuRunApp
      Style = bsSplitButton
      TabOrder = 1
      TabStop = False
      OnClick = btnOKClick
    end
    object EditParam: TEdit
      AlignWithMargins = True
      Left = 117
      Top = 7
      Width = 384
      Height = 21
      Margins.Top = 5
      Margins.Right = 13
      Margins.Bottom = 5
      Align = alClient
      TabOrder = 2
      OnChange = EditParamChange
    end
  end
  object dbGridParameters: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 47
    Width = 532
    Height = 211
    Align = alClient
    DataSource = SourceParametres
    DrawingStyle = gdsGradient
    GradientEndColor = 14083302
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbGridParametersCellClick
    OnDblClick = dbGridParametersDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ParamCode'
        Title.Caption = 'Parameter Name'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ParamText'
        Title.Caption = 'Application Parameter'
        Width = 252
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ParamConnection'
        Title.Caption = 'Connection'
        Width = 200
        Visible = True
      end>
  end
  object lbAdditionalParams: TListBox
    AlignWithMargins = True
    Left = 541
    Top = 47
    Width = 150
    Height = 211
    Align = alRight
    ItemHeight = 13
    PopupMenu = PopupMenu
    TabOrder = 3
    Visible = False
    OnExit = lbAdditionalParamsExit
  end
  object pnlProgress: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 324
    Width = 688
    Height = 25
    Align = alBottom
    BevelInner = bvLowered
    Caption = 'pnlProgress'
    ShowCaption = False
    TabOrder = 4
  end
  object MainMenu: TMainMenu
    Left = 88
    Top = 104
    object MenuFile: TMenuItem
      Caption = 'File'
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
    end
  end
  object SourceParametres: TDataSource
    AutoEdit = False
    DataSet = ClntDSetParameters
    Left = 120
    Top = 104
  end
  object ClntDSetParameters: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ParamCode'
    Params = <>
    AfterOpen = ClntDSetParametersAfterOpen
    AfterScroll = ClntDSetParametersAfterScroll
    Left = 152
    Top = 104
    object ClntDSetParametersParamCode: TStringField
      FieldName = 'ParamCode'
      Size = 1000
    end
    object ClntDSetParametersParamText: TStringField
      FieldName = 'ParamText'
      Size = 1000
    end
    object ClntDSetParametersParamConnection: TStringField
      FieldName = 'ParamConnection'
      Size = 1000
    end
    object ClntDSetParametersData: TIntegerField
      FieldName = 'Data'
    end
  end
  object PopupMenuAdditionalParameters: TPopupMenu
    Left = 184
    Top = 104
  end
  object PopupMenu: TPopupMenu
    Images = FormMDIMain.ImageList
    OnPopup = PopupMenuPopup
    Left = 216
    Top = 104
    object PMItemAdd: TMenuItem
      Caption = 'Add'
      ImageIndex = 30
      OnClick = PMItemAddClick
    end
    object PMItemDelete: TMenuItem
      Caption = 'Delete'
      ImageIndex = 31
      OnClick = PMItemDeleteClick
    end
    object PMItemEdit: TMenuItem
      Caption = 'Edit'
      ImageIndex = 32
      OnClick = PMItemEditClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object PMItemUpdate: TMenuItem
      Caption = 'Update '
      ImageIndex = 36
      OnClick = PMItemUpdateClick
    end
  end
  object PopupMenuRunApp: TPopupMenu
    Images = FormMDIMain.ImageList
    Left = 216
    Top = 136
    object PMItemRun: TMenuItem
      Caption = 'Run'
      OnClick = btnOKClick
    end
    object PMItemRunasadministrator: TMenuItem
      Caption = 'Run as administrator'
      ImageIndex = 43
      OnClick = btnOKClick
    end
  end
end
