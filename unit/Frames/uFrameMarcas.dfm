object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 185
  Height = 43
  TabOrder = 0
  object grpMarcas: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 43
    Align = alClient
    Caption = ' Marcas '
    TabOrder = 0
    ExplicitLeft = 224
    ExplicitTop = 96
    ExplicitHeight = 105
    object edtCodMarcas: TEdit
      Left = 3
      Top = 16
      Width = 50
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      OnChange = edtCodMarcasChange
    end
    object edtDescMarca: TEdit
      Left = 59
      Top = 16
      Width = 121
      Height = 21
      Color = clBtnFace
      Enabled = False
      TabOrder = 1
    end
  end
end
