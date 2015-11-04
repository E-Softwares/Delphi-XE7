object FormBackupRestore: TFormBackupRestore
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Restore'
  ClientHeight = 92
  ClientWidth = 295
  Color = 14871789
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 289
    Height = 86
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 160
    ExplicitWidth = 185
    ExplicitHeight = 105
    object Label1: TLabel
      Left = 17
      Top = 17
      Width = 40
      Height = 13
      AutoSize = False
      Caption = 'Select '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object cbRestore: TComboBox
      Left = 71
      Top = 14
      Width = 200
      Height = 22
      Style = csOwnerDrawFixed
      Sorted = True
      TabOrder = 0
      OnChange = cbRestoreChange
    end
    object btnCancel: TButton
      Left = 206
      Top = 49
      Width = 65
      Height = 25
      Action = alClose
      TabOrder = 1
    end
    object btnRestore: TButton
      Left = 135
      Top = 49
      Width = 65
      Height = 25
      Caption = 'Restore'
      Default = True
      Enabled = False
      TabOrder = 2
      OnClick = btnRestoreClick
    end
  end
  object ActionList: TActionList
    Left = 64
    Top = 48
    object alClose: TAction
      Caption = 'Close'
      ShortCut = 27
      OnExecute = alCloseExecute
    end
  end
end
