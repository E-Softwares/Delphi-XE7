object FormAppGroupEditor: TFormAppGroupEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Group Editor'
  ClientHeight = 405
  ClientWidth = 371
  Color = 14871789
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 365
    Height = 399
    Align = alClient
    TabOrder = 0
    DesignSize = (
      365
      399)
    object Label2: TLabel
      Left = 17
      Top = 99
      Width = 39
      Height = 13
      Caption = 'Source'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sBtnBrowseAppSource: TSpeedButton
      Left = 327
      Top = 96
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = sBtnBrowseAppSourceClick
    end
    object Label3: TLabel
      Left = 17
      Top = 126
      Width = 65
      Height = 13
      Caption = 'Destination'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sBtnBrowseAppDest: TSpeedButton
      Left = 327
      Top = 123
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = sBtnBrowseAppSourceClick
    end
    object Label4: TLabel
      Left = 17
      Top = 153
      Width = 52
      Height = 13
      Caption = 'File Mask'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 17
      Top = 72
      Width = 62
      Height = 13
      Caption = 'Executable'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 17
      Top = 45
      Width = 32
      Height = 13
      Caption = 'Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 17
      Top = 180
      Width = 61
      Height = 13
      Caption = 'Parameter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 17
      Top = 18
      Width = 52
      Height = 13
      Caption = 'Category'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtAppSource: TButtonedEdit
      Left = 100
      Top = 96
      Width = 221
      Height = 21
      Images = FormMDIMain.ImageList_Ord
      ReadOnly = True
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 4
      TextHint = 'Source Folder'
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object edtAppDest: TButtonedEdit
      Left = 100
      Top = 123
      Width = 221
      Height = 21
      Images = FormMDIMain.ImageList_Ord
      ReadOnly = True
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 5
      TextHint = 'Target Folder'
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object edtFileMask: TButtonedEdit
      Left = 100
      Top = 150
      Width = 150
      Height = 21
      Images = FormMDIMain.ImageList_Ord
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 6
      TextHint = 'File Mask'
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object edtExeName: TButtonedEdit
      Left = 100
      Top = 69
      Width = 150
      Height = 21
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 2
      TextHint = 'Executable File Name'
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object btnCancel: TButton
      Left = 275
      Top = 362
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 8
      TabStop = False
    end
    object btnOK: TButton
      Left = 194
      Top = 362
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 9
      TabStop = False
      OnClick = btnOKClick
    end
    object edtGroupName: TButtonedEdit
      Left = 100
      Top = 42
      Width = 250
      Height = 21
      Images = FormMDIMain.ImageList_Ord
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 1
      TextHint = 'Group Name'
      OnChange = edtGroupNameChange
      OnEnter = edtGroupNameEnter
      OnKeyPress = edtGroupNameKeyPress
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object edtFixedParams: TButtonedEdit
      Left = 100
      Top = 177
      Width = 250
      Height = 21
      Images = FormMDIMain.ImageList_Ord
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 7
      TextHint = 'Fixed Prameter'
      OnRightButtonClick = edtFixedParamsRightButtonClick
    end
    object chkCreateFolder: TCheckBox
      Left = 264
      Top = 152
      Width = 90
      Height = 17
      Caption = ' Create Folder'
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = chkCreateFolderClick
    end
    object chkIsApplication: TCheckBox
      Left = 264
      Top = 71
      Width = 90
      Height = 17
      Caption = ' Application'
      TabOrder = 3
      OnClick = chkIsApplicationClick
    end
    object cbDisplayLabel: TComboBox
      Left = 100
      Top = 15
      Width = 250
      Height = 21
      TabOrder = 0
      OnKeyPress = edtGroupNameKeyPress
    end
    object grpBranching: TGroupBox
      Left = 17
      Top = 204
      Width = 333
      Height = 141
      Caption = '  Branching  '
      TabOrder = 11
      object Label8: TLabel
        Left = 177
        Top = 82
        Width = 69
        Height = 13
        Caption = 'Main Branch'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label9: TLabel
        Left = 177
        Top = 110
        Width = 68
        Height = 13
        Caption = 'No: Of Builds'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label10: TLabel
        Left = 15
        Top = 82
        Width = 85
        Height = 13
        Caption = 'Current Branch'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object chkMajor: TCheckBox
        Left = 15
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Major Version'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkMajorClick
      end
      object chkMinor: TCheckBox
        Left = 119
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Minor Version'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = chkMajorClick
      end
      object chkRelease: TCheckBox
        Left = 222
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Release Version'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = chkMajorClick
      end
      object edtPrefix: TLabeledEdit
        Left = 53
        Top = 52
        Width = 110
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Prefix'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Enabled = False
        LabelPosition = lpLeft
        LabelSpacing = 5
        TabOrder = 3
        TextHint = 'Prefix'
      end
      object edtSufix: TLabeledEdit
        Left = 210
        Top = 52
        Width = 110
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Sufix'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Enabled = False
        LabelPosition = lpLeft
        LabelSpacing = 5
        TabOrder = 4
        TextHint = 'Sufix'
      end
      object sEdtMainBranch: TSpinEdit
        Left = 254
        Top = 79
        Width = 65
        Height = 22
        Enabled = False
        MaxValue = 9999
        MinValue = 0
        TabOrder = 5
        Value = 0
      end
      object sEdtNoOfBuilds: TSpinEdit
        Left = 254
        Top = 107
        Width = 65
        Height = 22
        Enabled = False
        MaxValue = 25
        MinValue = 0
        TabOrder = 6
        Value = 25
      end
      object sEdtCurrBranch: TSpinEdit
        Left = 111
        Top = 79
        Width = 52
        Height = 22
        Enabled = False
        MaxValue = 9999
        MinValue = 0
        TabOrder = 7
        Value = 0
      end
      object chkCreateBranchFolder: TCheckBox
        Left = 15
        Top = 109
        Width = 143
        Height = 17
        Caption = ' Create Branch Folders'
        Enabled = False
        TabOrder = 8
      end
    end
  end
end
