unit uLoginCode;

interface

uses
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, System.SysUtils;

  function TesteLogin(pLogin,pSenha:String):Boolean;

implementation

uses
  uDados, uInfosMaq;

function TesteLogin(pLogin,pSenha:String):Boolean;
var
  zqLogin:TZQuery;
  vContaLog,vIdLogin:Integer;
begin
  Result  :=  False;
  zqLogin :=  TZQuery.Create(nil);
  with zqLogin do
  begin
    Connection  :=  dm.conPrin;
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TB_LOGIN WHERE DS_LOGIN = :LOGIN AND DS_SENHA = CRIPTOGRAFAR(:SENHA)');
    ParamByName('LOGIN').AsString :=  AnsiUpperCase(pLogin);
    ParamByName('SENHA').AsString :=  AnsiUpperCase(pSenha);
    Open; First; FetchAll;
    vIdLogin  :=  Fields[0].AsInteger;
    vContaLog :=  Fields[0].AsInteger;
    if (vContaLog >= 1) then
    begin
      Result  :=  True;
      SQL.Clear;
      SQL.Add('INSERT INTO TB_LOG (ID_USER,DS_ACAO,NM_MAQUINA,IP_MAQUINA) VALUES (:ID,:ACAO,:NOMEMAQ,:IPMAQ)');
      ParamByName('ID').AsInteger     :=  vIdLogin;
      ParamByName('ACAO').AsString    :=  'USUÁRIO ' + AnsiUpperCase(pLogin) + ' REALIZOU LOGIN NO SISTEMA';
      ParamByName('NOMEMAQ').AsString := getNomeMaquina(False);
      ParamByName('IPMAQ').AsString   := getIpMaquina(False);
      ExecSQL;
    end;
  end;
  FreeAndNil(zqLogin);
end;

end.
