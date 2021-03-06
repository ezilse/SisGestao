inherited frmCadMarcas: TfrmCadMarcas
  Caption = 'frmCadMarcas'
  OnActivate = FormActivate
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    ExplicitLeft = 20
    ExplicitHeight = 0
  end
  object pnlFundo: TPanel [1]
    Left = 0
    Top = 0
    Width = 684
    Height = 561
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 20
    ExplicitHeight = 0
    object pnlInsereMarca: TPanel
      Left = 0
      Top = 0
      Width = 684
      Height = 50
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 20
      object lblDataCad: TLabel
        Left = 132
        Top = 3
        Width = 83
        Height = 13
        Caption = 'Data de cadastro'
      end
      object lblDataAtual: TLabel
        Left = 233
        Top = 3
        Width = 95
        Height = 13
        Caption = 'Data de atualiza'#231#227'o'
      end
      object lbledtCodigo: TLabeledEdit
        Left = 5
        Top = 19
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        Enabled = False
        TabOrder = 0
      end
      object dtpCad: TDateTimePicker
        Left = 132
        Top = 19
        Width = 95
        Height = 21
        Date = 44620.778151956030000000
        Time = 44620.778151956030000000
        Enabled = False
        TabOrder = 1
      end
      object dtpDataAtual: TDateTimePicker
        Left = 233
        Top = 19
        Width = 95
        Height = 21
        Date = 0.778151956023066400
        Time = 0.778151956023066400
        Enabled = False
        TabOrder = 2
      end
      object lbledtDescMarca: TLabeledEdit
        Left = 334
        Top = 19
        Width = 300
        Height = 21
        EditLabel.Width = 93
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o da marca'
        TabOrder = 3
      end
      object chkAtivo: TCheckBox
        Left = 640
        Top = 20
        Width = 44
        Height = 17
        Caption = 'Ativo'
        TabOrder = 4
      end
    end
    object dbgrdListaMarcas: TDBGrid
      Left = 0
      Top = 50
      Width = 684
      Height = 486
      Align = alClient
      DataSource = dsMarcas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = dbgrdListaMarcasCellClick
      OnDrawColumnCell = dbgrdListaMarcasDrawColumnCell
    end
    object pnlResultados: TPanel
      Left = 0
      Top = 536
      Width = 684
      Height = 25
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'REGISTROS ENCONTRADOS: ATIVOS 0 INATIVOS 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ExplicitTop = -25
      ExplicitWidth = 20
    end
  end
  inherited actlstProd: TActionList
    inherited actSalvar: TAction
      OnExecute = actSalvarExecute
    end
    inherited actNovo: TAction
      OnExecute = actNovoExecute
    end
  end
  object zqryMarcas: TZQuery
    Connection = dm.conPrin
    SQL.Strings = (
      
        'SELECT A.*, (SELECT COUNT(*) FROM TB_PRODUTOS WHERE ID_MARCA = A' +
        '.ID) FROM TB_MARCAS AS A')
    Params = <>
    Left = 184
    Top = 280
  end
  object dsMarcas: TDataSource
    AutoEdit = False
    DataSet = zqryMarcas
    Left = 376
    Top = 304
  end
end
