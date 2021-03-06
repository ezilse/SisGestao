program SisGestao;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  uBaseForm in '..\unit\Base\uBaseForm.pas' {frmBase},
  uCadProd in '..\unit\Produtos\uCadProd.pas' {frmCadProd},
  uDados in '..\unit\Dados\uDados.pas' {dm: TDataModule},
  uLoginCode in '..\unit\Login\uLoginCode.pas',
  uLoginForm in '..\unit\Login\uLoginForm.pas' {frmLogin},
  uInfosMaq in '..\unit\InfosMaq\uInfosMaq.pas',
  uGeral in '..\unit\Geral\uGeral.pas',
  uCadMarcas in '..\unit\Marcas\uCadMarcas.pas' {frmCadMarcas},
  uFrameMarcas in '..\unit\Frames\uFrameMarcas.pas' {Frame1: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
