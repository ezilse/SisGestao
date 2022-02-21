object frmBase: TfrmBase
  Left = 0
  Top = 0
  Caption = 'frmBase'
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 684
    Top = 0
    Width = 100
    Height = 561
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 664
    object btnSalvar: TBitBtn
      Left = 0
      Top = 0
      Width = 100
      Height = 50
      Action = actSalvar
      Align = alTop
      Caption = 'Salvar'
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 98
    end
  end
  object actlstProd: TActionList
    Images = MainForm.ImageList1
    Left = 296
    Top = 216
    object actSalvar: TAction
      Caption = 'Salvar'
      ImageIndex = 8
    end
  end
end
