inherited frmCadProd: TfrmCadProd
  Caption = 'frmCadProd'
  ClientHeight = 489
  ClientWidth = 809
  OnActivate = FormActivate
  ExplicitWidth = 825
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Left = 709
    Height = 489
    ExplicitLeft = 20
    ExplicitHeight = 0
  end
  object pgcProd: TPageControl [1]
    Left = 0
    Top = 0
    Width = 709
    Height = 489
    ActivePage = tsCadProd
    Align = alClient
    TabOrder = 1
    object tsCadProd: TTabSheet
      Caption = 'Cadastro principal'
    end
    object tsImagens: TTabSheet
      Caption = 'Imagens'
      ImageIndex = 1
      ExplicitLeft = 2
      ExplicitTop = 28
      object imgProd: TImage
        Left = 3
        Top = 3
        Width = 400
        Height = 400
        Stretch = True
      end
    end
  end
  inherited actlstProd: TActionList
    Left = 720
    Top = 232
    inherited actSalvar: TAction
      OnExecute = actSalvarExecute
    end
  end
end