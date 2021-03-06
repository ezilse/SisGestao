unit uLoginForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList, Vcl.Imaging.pngimage;

type
  TfrmLogin = class(TForm)
    lbledtLogin: TLabeledEdit;
    lbledtSenha: TLabeledEdit;
    chkMostraSenha: TCheckBox;
    btnLogar: TBitBtn;
    actlstLogin: TActionList;
    actLogin: TAction;
    actCancelar: TAction;
    btnCancelar: TBitBtn;
    imgLogin: TImage;
    procedure chkMostraSenhaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actLoginExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
  vFecharSistema:Boolean;

implementation

uses
  uLoginCode, Main, uGeral;

{$R *.dfm}

procedure TfrmLogin.actCancelarExecute(Sender: TObject);
begin
  vFecharSistema  :=  True;
  Close;
end;

procedure TfrmLogin.actLoginExecute(Sender: TObject);
begin
  if (TesteLogin(lbledtLogin.Text, lbledtSenha.Text)) then
  begin
    vFecharSistema  :=  False;
    MainForm.SetUsuario(AnsiUpperCase(lbledtLogin.Text));
    Close;
  end
  else
  begin
    LimparCamposForm(frmLogin,lbledtLogin);
    Application.MessageBox('Login ou senha incorretos. Verifique!',
      PChar(Application.Title), MB_OK + MB_ICONSTOP);
  end;
end;

procedure TfrmLogin.chkMostraSenhaClick(Sender: TObject);
begin
  if chkMostraSenha.Checked then
    lbledtSenha.PasswordChar  :=  #0
  else
    lbledtSenha.PasswordChar  :=  '*';
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  vFecharSistema  :=  True;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if vFecharSistema then
    Application.Terminate;
end;

end.
