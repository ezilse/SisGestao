unit uCadProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseForm, Vcl.StdCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Imaging.jpeg;

type
  TfrmCadProd = class(TfrmBase)
    pgcProd: TPageControl;
    tsCadProd: TTabSheet;
    tsImagens: TTabSheet;
    imgProd: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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

{$R *.dfm}

procedure TfrmCadProd.actSalvarExecute(Sender: TObject);
begin
  inherited;
  ShowMessage('Salvar');
end;

procedure TfrmCadProd.FormActivate(Sender: TObject);
begin
  inherited;
  imgProd.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+cFoto);
end;

procedure TfrmCadProd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadProd  :=  nil;
end;

end.
