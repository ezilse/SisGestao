unit uCadMarcas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseForm, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.ComCtrls, System.Math;

type
  TfrmCadMarcas = class(TfrmBase)
    pnlFundo: TPanel;
    pnlInsereMarca: TPanel;
    dbgrdListaMarcas: TDBGrid;
    zqryMarcas: TZQuery;
    dsMarcas: TDataSource;
    lbledtCodigo: TLabeledEdit;
    lblDataCad: TLabel;
    dtpCad: TDateTimePicker;
    dtpDataAtual: TDateTimePicker;
    lblDataAtual: TLabel;
    lbledtDescMarca: TLabeledEdit;
    chkAtivo: TCheckBox;
    pnlResultados: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListarTodasMarcas;
    procedure FormActivate(Sender: TObject);
    procedure dbgrdListaMarcasCellClick(Column: TColumn);
    procedure actSalvarExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure dbgrdListaMarcasDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadMarcas: TfrmCadMarcas;

implementation

uses
  uDados, uGeral;

{$R *.dfm}

procedure TfrmCadMarcas.actNovoExecute(Sender: TObject);
var
  x: Integer;
begin
  inherited;
  for x := 0 to Self.ComponentCount - 1 do
  begin
    if (Self.Components[x] is TLabeledEdit) then
      TLabeledEdit(Self.Components[x]).Clear
    else if (Self.Components[x] is TDateTimePicker) then
      TDateTimePicker(Self.Components[x]).DateTime  :=  0
    else if (Self.Components[x] is TCheckBox) then
      TCheckBox(Self.Components[x]).Checked         :=  True;
  end;
end;

procedure TfrmCadMarcas.actSalvarExecute(Sender: TObject);
var
  vValores:String;
begin
  inherited;
  if (StrToIntDef(lbledtCodigo.Text,0) = 0) then
  begin
    vValores  :=  EmptyStr;
    vValores  :=  vValores  + StringSql(lbledtDescMarca.Text) + ',';
    vValores  :=  vValores  + NumeroSql(IfThen(chkAtivo.Checked,1,0));
    InsereAtualizaBanco('TB_MARCAS',vValores,'DS_MARCA,IS_ATIVO')
  end
  else
  begin
    vValores  :=  EmptyStr;
    vValores  :=  vValores  + 'DS_MARCA = ' + StringSql(lbledtDescMarca.Text) + ',';
    vValores  :=  vValores  + 'IS_ATIVO = ' + NumeroSql(IfThen(chkAtivo.Checked,1,0));
    InsereAtualizaBanco('TB_MARCAS',vValores,'','A',' ID = ' + lbledtCodigo.Text);
  end;
  ListarTodasMarcas;
  Mensagem(2,'Registro inserido/alterado com sucesso!');
end;

procedure TfrmCadMarcas.dbgrdListaMarcasCellClick(Column: TColumn);
begin
  inherited;
  with zqryMarcas do
  begin
    lbledtCodigo.Text     :=  Fields[0].AsString;
    dtpCad.DateTime       :=  Fields[1].AsDateTime;
    dtpDataAtual.DateTime :=  Fields[2].AsDateTime;
    lbledtDescMarca.Text  :=  Fields[3].AsString;
    chkAtivo.Checked      :=  (Fields[4].AsInteger = 1);
  end;
end;

procedure TfrmCadMarcas.dbgrdListaMarcasDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if (zqryMarcas.Fields[4].AsInteger = 0) then
  begin
    dbgrdListaMarcas.Canvas.Brush.Color   :=  clRed;
    dbgrdListaMarcas.Canvas.Font.Color    :=  clWhite;
  end;
  dbgrdListaMarcas.DefaultDrawDataCell(Rect, dbgrdListaMarcas.columns[datacol].field, State)
end;

procedure TfrmCadMarcas.FormActivate(Sender: TObject);
begin
  inherited;
  ListarTodasMarcas;
end;

procedure TfrmCadMarcas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadMarcas  :=  nil;
end;

procedure TfrmCadMarcas.ListarTodasMarcas;
var
  vNrAtivos,vNrInativos:Integer;
begin
  with zqryMarcas do
  begin
    Connection  :=  dm.conPrin;
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT A.*, (SELECT COUNT(*) FROM TB_PRODUTOS WHERE ID_MARCA = A.ID) FROM TB_MARCAS AS A');
    Open; First; FetchAll;
    Fields[0].DisplayLabel  :=  'C?digo';
    Fields[0].DisplayWidth  :=  0;
    Fields[1].DisplayLabel  :=  'Data de cadastro';
    Fields[1].DisplayWidth  :=  0;
    Fields[2].DisplayLabel  :=  'Data de atualiza??o';
    Fields[2].DisplayWidth  :=  0;
    Fields[3].DisplayLabel  :=  'Descri??o da marca';
    Fields[3].DisplayWidth  :=  120;
    Fields[4].Visible       :=  False;
    Fields[5].DisplayLabel  :=  'Quantidade de produtos';
    Fields[5].DisplayWidth  :=  0;
    vNrInativos             :=  0;
    vNrAtivos               :=  0;
    while not Eof do
    begin
      if Fields[4].AsInteger = 1 then
        Inc(vNrAtivos)
      else
        Inc(vNrInativos);
      Next;
    end;
    First;
  end;
  pnlResultados.Caption :=  'REGISTROS ENCONTRADOS: ATIVOS '+IntToStr(vNrAtivos)+' INATIVOS '+IntToStr(vNrInativos);
end;

end.
