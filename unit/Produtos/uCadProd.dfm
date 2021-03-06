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
    ExplicitLeft = 709
    ExplicitHeight = 489
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
      ExplicitLeft = 2
      ExplicitTop = 28
      object lblMarca: TLabel
        Left = 3
        Top = 83
        Width = 29
        Height = 13
        Caption = 'Marca'
      end
      object lbledtCodigo: TLabeledEdit
        Left = 3
        Top = 16
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        Enabled = False
        TabOrder = 0
      end
      object btnPesquisa: TBitBtn
        Left = 130
        Top = 14
        Width = 75
        Height = 25
        Action = actPesquisa
        Caption = 'Pesquisa'
        TabOrder = 1
      end
      object lbledtNomeProd: TLabeledEdit
        Left = 3
        Top = 56
        Width = 695
        Height = 21
        EditLabel.Width = 83
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome do produto'
        TabOrder = 2
      end
      object cbbMarcasProd: TComboBox
        Left = 3
        Top = 99
        Width = 614
        Height = 21
        TabOrder = 3
      end
      object lbledtCodBarras: TLabeledEdit
        Left = 3
        Top = 138
        Width = 121
        Height = 21
        EditLabel.Width = 82
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo de barras'
        TabOrder = 4
      end
      object lbledtQuantidade: TLabeledEdit
        Left = 130
        Top = 138
        Width = 75
        Height = 21
        EditLabel.Width = 56
        EditLabel.Height = 13
        EditLabel.Caption = 'Quantidade'
        NumbersOnly = True
        TabOrder = 5
      end
      object btnMarcas: TBitBtn
        Left = 623
        Top = 97
        Width = 75
        Height = 25
        Action = actCadMarcas
        Caption = 'Marcas'
        TabOrder = 6
      end
    end
    object tsImagens: TTabSheet
      Caption = 'Imagens'
      ImageIndex = 1
      object imgProd: TImage
        Left = 3
        Top = 3
        Width = 400
        Height = 400
        Stretch = True
      end
    end
  end
  object pnlPesquisa: TPanel [2]
    Left = 104
    Top = 112
    Width = 512
    Height = 281
    TabOrder = 2
    Visible = False
    object pnlTituloPesq: TPanel
      Left = 1
      Top = 1
      Width = 510
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlTituloPesq'
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object pnlFechar: TPanel
        Left = 485
        Top = 0
        Width = 25
        Height = 25
        Cursor = crHandPoint
        Align = alRight
        BevelOuter = bvNone
        Caption = 'X'
        Color = clRed
        ParentBackground = False
        TabOrder = 0
        OnClick = pnlFecharClick
      end
    end
    object pnlPesqOpt: TPanel
      Left = 1
      Top = 26
      Width = 510
      Height = 95
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lblMarcas: TLabel
        Left = 191
        Top = 51
        Width = 44
        Height = 13
        Caption = 'lblMarcas'
        Visible = False
      end
      object rgPesqPor: TRadioGroup
        Left = 0
        Top = 0
        Width = 185
        Height = 95
        Align = alLeft
        Caption = 'Pesquisar por'
        ItemIndex = 0
        Items.Strings = (
          'Nome'
          'Marca'
          'C'#243'digo'
          'C'#243'digo de barras')
        TabOrder = 0
        OnClick = rgPesqPorClick
      end
      object lbledtPesquisaTexto: TLabeledEdit
        Left = 191
        Top = 24
        Width = 229
        Height = 21
        EditLabel.Width = 96
        EditLabel.Height = 13
        EditLabel.Caption = 'lbledtPesquisaTexto'
        TabOrder = 1
      end
      object btnPesquisaBuscar: TBitBtn
        Left = 426
        Top = 22
        Width = 75
        Height = 25
        Action = actPesquisaBuscar
        Caption = 'Pesquisa'
        TabOrder = 2
      end
      object cbbMarcas: TComboBox
        Left = 191
        Top = 65
        Width = 229
        Height = 21
        TabOrder = 3
        Visible = False
      end
    end
    object dbgrdLista: TDBGrid
      Left = 1
      Top = 121
      Width = 510
      Height = 159
      Align = alClient
      DataSource = dsPesquisa
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = dbgrdListaDblClick
    end
  end
  inherited actlstProd: TActionList
    Left = 720
    Top = 232
    inherited actSalvar: TAction
      Category = 'Buttons'
      OnExecute = actSalvarExecute
    end
    object actPesquisa: TAction
      Caption = 'Pesquisa'
      ImageIndex = 12
      OnExecute = actPesquisaExecute
    end
    object actPesquisaBuscar: TAction
      Caption = 'Pesquisa'
      ImageIndex = 12
      OnExecute = actPesquisaBuscarExecute
    end
    object actCadMarcas: TAction
      Caption = 'Marcas'
      ImageIndex = 10
      OnExecute = actCadMarcasExecute
    end
  end
  object zqryPesquisa: TZQuery
    Connection = dm.conPrin
    Params = <>
    Left = 193
    Top = 282
  end
  object dsPesquisa: TDataSource
    AutoEdit = False
    DataSet = zqryPesquisa
    Left = 320
    Top = 280
  end
end
