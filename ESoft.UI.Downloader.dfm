object FormDownloader: TFormDownloader
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Download Manager'
  ClientHeight = 152
  ClientWidth = 394
  Color = clBtnFace
  Constraints.MaxHeight = 180
  Constraints.MaxWidth = 400
  Constraints.MinHeight = 180
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    394
    152)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    AlignWithMargins = True
    Left = 15
    Top = 15
    Width = 376
    Height = 15
    Margins.Left = 15
    Margins.Top = 15
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    ExplicitWidth = 3
  end
  object lblText: TLabel
    AlignWithMargins = True
    Left = 15
    Top = 36
    Width = 376
    Height = 15
    Cursor = crHandPoint
    Hint = 'Copy to clipboard'
    Margins.Left = 15
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Times New Roman'
    Font.Style = [fsUnderline]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Layout = tlCenter
    OnClick = lblTextClick
    ExplicitWidth = 3
  end
  object lblPercentDone: TLabel
    Left = 15
    Top = 115
    Width = 81
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = '0% Percent done'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    ExplicitTop = 108
  end
  object btnCancel: TButton
    Left = 304
    Top = 111
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 0
    OnClick = btnCancelClick
  end
  object pbMain: TProgressBar
    AlignWithMargins = True
    Left = 15
    Top = 69
    Width = 364
    Height = 17
    Margins.Left = 15
    Margins.Top = 15
    Margins.Right = 15
    Align = alTop
    Smooth = True
    SmoothReverse = True
    TabOrder = 1
  end
  object bkGndWorker: TBackgroundWorker
    OnWork = bkGndWorkerWork
    OnWorkComplete = bkGndWorkerWorkComplete
    OnWorkProgress = bkGndWorkerWorkProgress
    Left = 264
    Top = 104
  end
end
