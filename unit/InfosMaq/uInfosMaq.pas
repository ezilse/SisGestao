unit uInfosMaq;

interface

uses
  IdBaseComponent, IdComponent, IdIPWatch, System.SysUtils, Winapi.Windows;

  function getIpMaquina(pAddTexto:Boolean=True):String;
  function getNomeMaquina(pAddTexto:Boolean=True):String;

implementation

function getIpMaquina(pAddTexto:Boolean=True):String;
var
  pegaIp:TIdIPWatch;
begin
  pegaIp    :=  TIdIPWatch.Create(nil);
  Result    :=  EmptyStr;
  if (pAddTexto) then
    Result  := ' IP: ';
  Result    :=  Result + pegaIp.LocalIP;
  FreeAndNil(pegaIp);
end;

function getNomeMaquina(pAddTexto:Boolean=True):String;
var
  ipBuffer:String;
  nComp:DWORD;
begin
  Result      :=  EmptyStr;
  nComp       :=  255;
  SetLength(ipBuffer,nComp);
  if GetComputerName(PChar(ipBuffer),nComp) then
  begin
    if (pAddTexto) then
      Result  :=  ' NOME DA MAQUINA: ';
    Result    :=  Result  + Trim(ipBuffer);
  end;
end;

end.
