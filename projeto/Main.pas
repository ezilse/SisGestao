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
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    actProdNew: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    FileOpen1: TAction;
    FileSaveAs1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2: TMenuItem;
    ImageList1: TImageList;
    pnlBotoes: TPanel;
    btnCadprod: TSpeedButton;
    pnlDados: TPanel;
    procedure FileExit1Execute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actProdNewExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SetUsuario(pUser:String);

    function  getUsuario:String;
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  vUsuarioSistema:String;

implementation

uses
  uCadProd, uLoginForm, uInfosMaq;

{$R *.dfm}

procedure TMainForm.actProdNewExecute(Sender: TObject);
begin
  CreateMDIChild('CadProd');
end;

procedure TMainForm.CreateMDIChild(const Name: string);
var
  Child: TfrmCadProd;
begin
  if (not (MainForm.ActiveMDIChild is TfrmCadProd)) then
  begin
    Child         :=  TfrmCadProd.Create(Application);
    Child.Caption :=  Name;
  end
  else
  begin
    Application.MessageBox('Esta tela j� est� ativa',
      PChar(Application.Title), MB_OK + MB_ICONWARNING);
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
  Result          :=  'USU�RIO: ' + vUsuarioSistema;
end;

procedure TMainForm.SetUsuario(pUser: String);
begin
  vUsuarioSistema :=  pUser;
end;

end.