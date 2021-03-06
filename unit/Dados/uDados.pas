unit uDados;

interface

uses
  System.SysUtils, System.Classes, ZAbstractConnection, ZConnection, System.Win.Registry,
  Winapi.Windows, Vcl.Dialogs, Vcl.Forms, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  Tdm = class(TDataModule)
    conPrin: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure FazLeituraDados;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;
  Registro:TRegistry;

const
  cChave:String='SOFTWARE\SisGestao';
  cUserReg:String='DBUser';
  cPassReg:String='DBPassword';
  cProtocol:String='DBProtocol';
  cPorta:String='DBPort';
  cServer:String='DBServer';
  cBase:String='DBBase';

implementation

uses
  uGeral;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  FazLeituraDados;
end;

procedure Tdm.FazLeituraDados;
var
  vServerTemp:String;
begin
  with conPrin do
  begin
    Registro          :=  TRegistry.Create;
    Registro.RootKey  :=  HKEY_CURRENT_USER;
    try
      if (Registro.KeyExists(cChave)) then
      begin
        if (Registro.OpenKey(cChave,True)) then
        begin
          User          :=  Registro.ReadString(cUserReg);
          Password      :=  Registro.ReadString(cPassReg);
          Port          :=  StrToIntDef(Registro.ReadString(cPorta),3306);
          vServerTemp   :=  Registro.ReadString(cServer);
          HostName      :=  Copy(vServerTemp,Pos('-',vServerTemp)+1,length(vServerTemp));
          vServerTemp   :=  Registro.ReadString(cProtocol);
          Protocol      :=  Copy(vServerTemp,Pos('-',vServerTemp)+1,length(vServerTemp));
          Database      :=  Registro.ReadString(cBase);
          Connected     :=  True;
        end;
      end
      else
      begin
        if (MensagemSimNao('O sistema n?o foi liberado para esta m?quina. Deseja configurar?')) then
          WinExec('GravaRegedit.exe', sw_show);
        Application.Terminate;
      end;
    except
      Mensagem(5,'N?o foi poss?vel conectar ao banco de dados');
      Application.Terminate;
    end;
    FreeAndNil(Registro);
  end;
end;

end.
