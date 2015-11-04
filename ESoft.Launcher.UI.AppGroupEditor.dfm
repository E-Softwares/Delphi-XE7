object FormAppGroupEditor: TFormAppGroupEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Group Editor'
  ClientHeight = 227
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
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 365
    Height = 221
    Align = alClient
    TabOrder = 0
    DesignSize = (
      365
      221)
    object Label2: TLabel
      Left = 17
      Top = 71
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
      Top = 68
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = sBtnBrowseAppSourceClick
    end
    object Label3: TLabel
      Left = 17
      Top = 98
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
      Top = 95
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = sBtnBrowseAppSourceClick
    end
    object Label4: TLabel
      Left = 17
      Top = 125
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
      Top = 44
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
      Top = 17
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
      Top = 152
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
    object edtAppSource: TButtonedEdit
      Left = 100
      Top = 68
      Width = 221
      Height = 21
      Images = FormMDIMain.ImageList
      ReadOnly = True
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 3
      TextHint = 'Source Folder'
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object edtAppDest: TButtonedEdit
      Left = 100
      Top = 95
      Width = 221
      Height = 21
      Images = FormMDIMain.ImageList
      ReadOnly = True
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 4
      TextHint = 'Target Folder'
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object edtFileMask: TButtonedEdit
      Left = 100
      Top = 122
      Width = 150
      Height = 21
      Images = FormMDIMain.ImageList
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 5
      TextHint = 'File Mask'
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object edtExeName: TButtonedEdit
      Left = 100
      Top = 41
      Width = 150
      Height = 21
      Images = FormMDIMain.ImageList
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 1
      TextHint = 'Executable File Name'
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object btnCancel: TButton
      Left = 275
      Top = 184
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 7
      TabStop = False
    end
    object btnOK: TButton
      Left = 194
      Top = 184
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 8
      TabStop = False
      OnClick = btnOKClick
    end
    object edtGroupName: TButtonedEdit
      Left = 100
      Top = 14
      Width = 250
      Height = 21
      Images = FormMDIMain.ImageList
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 0
      TextHint = 'Group Name'
      OnChange = edtGroupNameChange
      OnEnter = edtGroupNameEnter
      OnKeyPress = edtGroupNameKeyPress
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object edtFixedParams: TButtonedEdit
      Left = 100
      Top = 149
      Width = 250
      Height = 21
      Images = FormMDIMain.ImageList
      RightButton.ImageIndex = 34
      RightButton.PressedImageIndex = 4
      RightButton.Visible = True
      TabOrder = 6
      TextHint = 'Fixed Prameter'
      OnRightButtonClick = edtAppSourceRightButtonClick
    end
    object chkCreateFolder: TCheckBox
      Left = 264
      Top = 124
      Width = 97
      Height = 17
      Caption = ' Create Folder'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object chkIsApplication: TCheckBox
      Left = 264
      Top = 43
      Width = 90
      Height = 17
      Caption = ' Application'
      TabOrder = 2
      OnClick = chkIsApplicationClick
    end
  end
end
