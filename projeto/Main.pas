unit MAIN;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, System.ImageList, System.Actions, IdBaseComponent, IdComponent,
  IdIPWatch;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    OpenDialog: TOpenDialog;
    ActionList1: TActionList;
    actProdNew: TAction;
    ImageList1: TImageList;
    pnlBotoes: TPanel;
    btnCadprod: TSpeedButton;
    pnlDados: TPanel;
    actCadMarcas: TAction;
    btnMarcas: TSpeedButton;
    Marcas1: TMenuItem;
    procedure FileExit1Execute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actProdNewExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SetUsuario(pUser:String);

    function  getUsuario:String;
    procedure actCadMarcasExecute(Sender: TObject);
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string;pTipoForm:Integer);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  vUsuarioSistema:String;

implementation

uses
  uCadProd, uLoginForm, uInfosMaq, uBaseForm, uCadMarcas, uDados, uGeral;

{$R *.dfm}

procedure TMainForm.actCadMarcasExecute(Sender: TObject);
begin
  CreateMDIChild('Cadastro de marcas',2);
end;

procedure TMainForm.actProdNewExecute(Sender: TObject);
begin
  CreateMDIChild('Cadastro de produtos',1);
end;

procedure TMainForm.CreateMDIChild(const Name: string;pTipoForm:Integer);
begin
  case pTipoForm of
    1:begin
        if (frmCadProd <> nil) then
        begin
          Mensagem(5,'Esta tela j? est? ativa');
          Abort;
        end;
        Application.CreateForm(TfrmCadProd,frmCadProd);
        frmCadProd.Caption  :=  Name;
        frmCadProd.Show;
      end;
    2:begin
        if (frmCadMarcas <> nil) then
        begin
          Mensagem(5,'Esta tela j? est? ativa');
          Abort;
        end;
        Application.CreateForm(TfrmCadMarcas,frmCadMarcas);
        frmCadMarcas.Caption  :=  Name;
        frmCadMarcas.Show;
      end;
  end;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  Caption := Application.Title;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Application.CreateForm(TfrmLogin,frmLogin);
  frmLogin.ShowModal;
  pnlDados.Caption  :=  getUsuario;
  pnlDados.Caption  :=  pnlDados.Caption  + getIpMaquina;
  pnlDados.Caption  :=  pnlDados.Caption  + getNomeMaquina;
end;

function TMainForm.getUsuario: String;
begin
  Result          :=  'USU?RIO: ' + vUsuarioSistema;
end;

procedure TMainForm.SetUsuario(pUser: String);
begin
  vUsuarioSistema :=  pUser;
end;

end.
