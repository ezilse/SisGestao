unit uCadProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseForm, Vcl.StdCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Imaging.jpeg,
  Data.DB, Vcl.Grids, Vcl.DBGrids, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Datasnap.DBClient, Datasnap.Provider, System.Math;

type
  TfrmCadProd = class(TfrmBase)
    pgcProd: TPageControl;
    tsCadProd: TTabSheet;
    tsImagens: TTabSheet;
    imgProd: TImage;
    lbledtCodigo: TLabeledEdit;
    btnPesquisa: TBitBtn;
    actPesquisa: TAction;
    pnlPesquisa: TPanel;
    pnlTituloPesq: TPanel;
    pnlFechar: TPanel;
    pnlPesqOpt: TPanel;
    dbgrdLista: TDBGrid;
    zqryPesquisa: TZQuery;
    dsPesquisa: TDataSource;
    rgPesqPor: TRadioGroup;
    lbledtPesquisaTexto: TLabeledEdit;
    btnPesquisaBuscar: TBitBtn;
    lblMarcas: TLabel;
    actPesquisaBuscar: TAction;
    lbledtNomeProd: TLabeledEdit;
    lblMarca: TLabel;
    cbbMarcasProd: TComboBox;
    lbledtCodBarras: TLabeledEdit;
    lbledtQuantidade: TLabeledEdit;
    actCadMarcas: TAction;
    btnMarcas: TBitBtn;
    cbbMarcas: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actPesquisaExecute(Sender: TObject);
    procedure pnlFecharClick(Sender: TObject);
    procedure rgPesqPorClick(Sender: TObject);
    procedure actPesquisaBuscarExecute(Sender: TObject);
    procedure ListarProdutos(pSql:String);
    procedure dbgrdListaDblClick(Sender: TObject);
    procedure UsarRegistro;
    procedure LimpaPesquisa;
    procedure CarregarProdutoPesquisado;
    procedure actCadMarcasExecute(Sender: TObject);
    procedure AbrirMarcas(Name:String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadProd: TfrmCadProd;

const
  cFoto:String='\Imagens\sfoto.jpg';

implementation

uses
  uGeral, uDados, uCadMarcas;

{$R *.dfm}

procedure TfrmCadProd.AbrirMarcas(Name: String);
begin
  if (frmCadMarcas <> nil) then
  begin
    Mensagem(5,'Esta tela j? est? ativa');
    Abort;
  end;
  Application.CreateForm(TfrmCadMarcas,frmCadMarcas);
  frmCadMarcas.Caption  :=  Name;
  frmCadMarcas.Show;
end;

procedure TfrmCadProd.actCadMarcasExecute(Sender: TObject);
begin
  inherited;
  AbrirMarcas('Cadastro de marcas');
end;

procedure TfrmCadProd.actPesquisaBuscarExecute(Sender: TObject);
  function getSql:String;
  var
    idMarca:Integer;
  begin
    Result  :=  EmptyStr;
    Result  :=  ' SELECT * FROM TB_PRODUTOS WHERE 1=1 ';
    idMarca :=  IfThen(cbbMarcas.Text = '',0,getCodigoCombo(cbbMarcas));
    case rgPesqPor.ItemIndex of
      0:begin
          if (lbledtPesquisaTexto.Text = '') then
          begin
            Mensagem(4,'Digite um nome a ser pesquisado');
            Abort;
          end;
          Result  :=  Result  + ' AND NM_PRODUTO LIKE ' + StringSqlLike(lbledtPesquisaTexto.Text);
        end;
      1:begin
          if (idMarca = 0) then
          begin
            Mensagem(4,'Uma marca deve ser selecionada.');
            Abort;
          end;
          Result  :=  Result  + ' AND ID_MARCA = ' + IntToStr(idMarca);
        end;
      2:begin
          if (lbledtPesquisaTexto.Text = '') then
          begin
            Mensagem(4,'Digite o c?digo do produto a ser pesquisado');
            Abort;
          end;
          Result  :=  Result  + ' AND ID = ' + lbledtPesquisaTexto.Text;
        end;
      3:begin
          if (lbledtPesquisaTexto.Text = '') then
          begin
            Mensagem(4,'Digite o c?digo de barras do produto a ser pesquisado');
            Abort;
          end;
          Result  :=  Result  + ' AND COD_BARRAS = ' + lbledtPesquisaTexto.Text;
        end;
    end;
  end;
begin
  inherited;
  ListarProdutos(getSql);
end;

procedure TfrmCadProd.actPesquisaExecute(Sender: TObject);
begin
  inherited;
  CentralizaPanel(pnlPesquisa,Self);
  pnlTituloPesq.Caption :=  'PESQUISA POR PRODUTOS';
  pnlPesquisa.Visible   :=  True;
  ListarProdutos('select * from tb_produtos');
  lbledtPesquisaTexto.EditLabel.Caption :=  rgPesqPor.Items[rgPesqPor.ItemIndex];
end;

procedure TfrmCadProd.actSalvarExecute(Sender: TObject);
var
  vValores:String;
const
  cCampos:String='NM_PRODUTO,IMG_PRODUTO,ID_MARCA,COD_BARRAS,QTIDADE';
begin
  inherited;
  if (JaExisteCodBarras(lbledtCodBarras.Text) and (lbledtCodBarras.Enabled)) then
  begin
    Mensagem(5,'J? existe produto com este c?digo de barras. ('+lbledtCodBarras.Text+')');
    Abort;
  end;
  if (StrToIntDef(lbledtCodigo.Text,0) = 0) then
  begin
    vValores  :=  EmptyStr;
    vValores  :=  vValores    + StringSql(lbledtNomeProd.Text)                    + ',';
    vValores  :=  vValores    + StringSql('')                                     + ',';
    vValores  :=  vValores    + NumeroSql(getCodigoCombo(cbbMarcasProd))          + ',';
    if (lbledtCodBarras.Text = '') then
      vValores  :=  vValores  + StringSql(getCodBarras)                           + ','
    else
      vValores  :=  vValores  + StringSql(lbledtCodBarras.Text)                   + ',';
    vValores  :=  vValores    + NumeroSql(StrToIntDef(lbledtQuantidade.Text,0));
    InsereAtualizaBanco('TB_PRODUTOS',vValores,cCampos);
  end
  else
  begin
    vValores  :=  EmptyStr;
    vValores  :=  vValores    + 'NM_PRODUTO = '   + StringSql(lbledtNomeProd.Text)                  + ',' ;
    vValores  :=  vValores    + 'IMG_PRODUTO = '  + StringSql('')                                   + ',' ;
    vValores  :=  vValores    + 'ID_MARCA = '     + NumeroSql(getCodigoCombo(cbbMarcasProd))        + ',' ;
    if (lbledtCodBarras.Text = '') then
      vValores  :=  vValores  + 'COD_BARRAS = '   + StringSql(getCodBarras)                         + ','
    else
      vValores  :=  vValores  + 'COD_BARRAS = '   + StringSql(lbledtCodBarras.Text)                 + ',' ;
    vValores  :=  vValores    + 'QTIDADE = '      + NumeroSql(StrToIntDef(lbledtQuantidade.Text,0))       ;
    InsereAtualizaBanco('TB_PRODUTOS',vValores,'','A',' ID = ' + lbledtCodigo.Text);
  end;
  CarregarProdutoPesquisado;
  Mensagem(2,'Registro inserido/alterado com sucesso!');
end;

procedure TfrmCadProd.CarregarProdutoPesquisado;
var
  zqProdutos:TZQuery;
begin
  zqProdutos  :=  TZQuery.Create(nil);
  with zqProdutos do
  begin
    Connection  :=  dm.conPrin;
    if (Active) then
      Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TB_PRODUTOS WHERE 1=1 AND ID = ' + NumeroSql(StrToIntDef(lbledtCodigo.Text,0)));
    Open; First; FetchAll;
    if (RecordCount >= 1) then
    begin
      lbledtNomeProd.Text :=  Fields[3].AsString;
      SetarTextoCombo(cbbMarcasProd,Fields[5].AsInteger);
      if (FileExists(Fields[4].AsString)) then
        imgProd.Picture.LoadFromFile(Fields[4].AsString)
      else
        imgProd.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+cFoto);
      lbledtCodBarras.Text    :=  Fields[6].AsString;
      lbledtCodBarras.Enabled :=  (lbledtCodBarras.Text = '');
      lbledtQuantidade.Text   :=  Fields[7].AsString;
    end;
  end;
  FreeAndNil(zqProdutos);
end;

procedure TfrmCadProd.dbgrdListaDblClick(Sender: TObject);
begin
  inherited;
  UsarRegistro;
end;

procedure TfrmCadProd.FormActivate(Sender: TObject);
begin
  inherited;
  imgProd.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+cFoto);
  CarregaComboBox(cbbMarcasProd,'TB_MARCAS','DS_MARCA','IS_ATIVO = 1');
end;

procedure TfrmCadProd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadProd  :=  nil;
end;

procedure TfrmCadProd.LimpaPesquisa;
begin
  lbledtPesquisaTexto.Clear;
  CarregaComboBox(cbbMarcas,'TB_MARCAS','DS_MARCA','IS_ATIVO = 1');
  rgPesqPor.ItemIndex :=  0;
end;

procedure TfrmCadProd.ListarProdutos(pSql: String);
begin
  with zqryPesquisa do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(pSql);
    Active                  :=  True;
    Fields[0].Visible       :=  False;
    Fields[1].Visible       :=  False;
    Fields[2].Visible       :=  False;
    Fields[3].DisplayLabel  :=  'Nome do produto';
    Fields[4].Visible       :=  False;
    Fields[5].Visible       :=  False;
    Fields[6].DisplayLabel  :=  'C?d de barras';
    Fields[7].DisplayLabel  :=  'Quantidade';
  end;
end;

procedure TfrmCadProd.pnlFecharClick(Sender: TObject);
begin
  inherited;
  pnlPesquisa.Visible :=  False;
end;

procedure TfrmCadProd.rgPesqPorClick(Sender: TObject);
begin
  inherited;
  lbledtPesquisaTexto.EditLabel.Caption :=  rgPesqPor.Items[rgPesqPor.ItemIndex];
  lbledtPesquisaTexto.Clear;
  lbledtPesquisaTexto.NumbersOnly       :=  ((rgPesqPor.ItemIndex = 2) or
                                             (rgPesqPor.ItemIndex = 3));
  lbledtPesquisaTexto.Visible           :=  (rgPesqPor.ItemIndex <> 1);
  if (rgPesqPor.ItemIndex = 1) then
  begin
    lblMarcas.Caption :=  rgPesqPor.Items[rgPesqPor.ItemIndex];
    CarregaComboBox(cbbMarcas,'TB_MARCAS','DS_MARCA','IS_ATIVO = 1');
  end;
  lblMarcas.Visible :=  (rgPesqPor.ItemIndex = 1);
  cbbMarcas.Visible :=  (rgPesqPor.ItemIndex = 1);
  cbbMarcas.Top     :=  IfThen(cbbMarcas.Visible,24,66);
  lblMarcas.Top     :=  cbbMarcas.Top-15;
end;

procedure TfrmCadProd.UsarRegistro;
begin
  lbledtCodigo.Text   :=  zqryPesquisa.Fields[0].AsString;
  pnlPesquisa.Visible :=  False;
  LimpaPesquisa;
  CarregarProdutoPesquisado;
end;

end.
