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
        Application.MessageBox('O sistema não foi liberado para esta máquina. Por favor, entre em contato com o suporte.',
          PChar(Application.Title), MB_OK + MB_ICONSTOP);
        Application.Terminate;
      end;
    except
      Application.MessageBox('Não foi possível conectar ao banco de dados',
        PChar(Application.Title), MB_OK + MB_ICONSTOP);
      Application.Terminate;
    end;
  end;
end;

end.
