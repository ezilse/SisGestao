unit uFrameMarcas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TFrame1 = class(TFrame)
    grpMarcas: TGroupBox;
    edtCodMarcas: TEdit;
    edtDescMarca: TEdit;
    procedure SetCodMarca(pCodMarca:Integer);
    procedure SetDescMarca(pDescMarca:String);

    function  GetCodMarca:Integer;
    function  GetDescMarca:String;
    procedure edtCodMarcasChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrame1.edtCodMarcasChange(Sender: TObject);
var
  zqMarcas:TZQuery;
begin
  zqMarcas  :=  TZQuery.Create(nil);
  with zqMarcas do
  begin

  end;
end;

function TFrame1.GetCodMarca: Integer;
begin
  Result  :=  StrToIntDef(edtCodMarcas.Text,0);
end;

function TFrame1.GetDescMarca: String;
begin
  Result  :=  edtDescMarca.Text;
end;

procedure TFrame1.SetCodMarca(pCodMarca: Integer);
begin
  edtCodMarcas.Text :=  IntToStr(pCodMarca);
end;

procedure TFrame1.SetDescMarca(pDescMarca: String);
begin
  edtDescMarca.Text :=  pDescMarca;
end;

end.
