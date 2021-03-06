unit uGeral;

interface

uses Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Controls, ZAbstractRODataset,
      ZAbstractDataset, ZDataset, System.SysUtils, Winapi.Windows;

  procedure LimparCamposForm(pFormLimpar:TForm);overload;
  procedure LimparCamposForm(pFormLimpar:TForm;pCampoFocar:TLabeledEdit);overload;
  procedure CentralizaPanel(pPainel:TPanel; pForm:TForm);
  procedure CarregaComboBox(pCombo:TComboBox;pTabela,pCampoDesc,pWhere:String;pLinhas:Integer=45);
  procedure Mensagem(pTipo:Integer; pMensagem:String);
  procedure SetarTextoCombo(pCombo:TComboBox;pCodigo:Integer);
  procedure InsereAtualizaBanco(pTabela,pValores:String;pCampos:String='';pAtualiza:String='I';pWhere:String='');

  function  Concatenar(pAnterior,pNovo:String;pAddVirg:Boolean=True;pAntes:String='D'):String;
  function  getCodigoCombo(pCombo:TComboBox):Integer;
  function  StringSql(pTexto:String):String;
  function  StringSqlLike(pTexto:String):String;
  function  NumeroSql(pNumero:Integer):String;
  function  getCodBarras:String;
  function  JaExisteCodBarras(pCodBarras:String):Boolean;
  function  MensagemSimNao(pMensagem:String):Boolean;

implementation

uses
  uDados;

procedure LimparCamposForm(pFormLimpar:TForm);overload;
var
  x: Integer;
begin
  for x := 0 to pFormLimpar.ComponentCount - 1 do
  begin
    if (pFormLimpar.Components[x] is TLabeledEdit) then
      TLabeledEdit(pFormLimpar.Components[x]).Clear
    else if (pFormLimpar.Components[x] is TCheckBox) then
      TCheckBox(pFormLimpar.Components[x]).Checked  :=  False;
  end;
end;

procedure LimparCamposForm(pFormLimpar:TForm;pCampoFocar:TLabeledEdit);overload;
begin
  LimparCamposForm(pFormLimpar);
  if pCampoFocar.CanFocus then
    pCampoFocar.SetFocus;
end;

procedure CentralizaPanel(pPainel:TPanel; pForm:TForm);
begin
  pPainel.Left  := (pForm.ClientWidth div 2) - (pPainel.Width div 2);
  pPainel.Top   := (pForm.ClientHeight div 2) - (pPainel.Height div 2);
  pPainel.Update;
  pForm.Update;
end;

procedure CarregaComboBox(pCombo:TComboBox;pTabela,pCampoDesc,pWhere:String;pLinhas:Integer=45);
var
  zqCombo:TZQuery;
begin
  zqCombo :=  TZQuery.Create(nil);
  with zqCombo  do
  begin
    Connection  :=  dm.conPrin;
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT ID,'  + pCampoDesc  + ' FROM ' + pTabela  + ' WHERE 1=1 AND ' + pWhere);
    Open; First; FetchAll;
    pCombo.Items.Clear;
    if (RecordCount >= 1) then
    begin
      while not Eof do
      begin
        pCombo.Items.Add(Fields[0].AsString + ' - ' + Fields[1].AsString);
        Next;
      end;
    end;
  end;
  pCombo.DropDownCount  :=  pLinhas;
  FreeAndNil(zqCombo);
end;

function  getCodigoCombo(pCombo:TComboBox):Integer;
begin
  Result  :=  StrToIntDef(Copy(pCombo.Text,1,Pos(' - ',pCombo.Text)-1),0);
end;

procedure Mensagem(pTipo:Integer; pMensagem:String);
begin
  case pTipo of
    1:Application.MessageBox(PWideChar(pMensagem), PChar(Application.Title), MB_OK);
    2:Application.MessageBox(PWideChar(pMensagem), PChar(Application.Title), MB_OK +  MB_ICONINFORMATION);
    3:Application.MessageBox(PWideChar(pMensagem), PChar(Application.Title), MB_OK +  MB_ICONQUESTION);
    4:Application.MessageBox(PWideChar(pMensagem), PChar(Application.Title), MB_OK +  MB_ICONWARNING);
    5:Application.MessageBox(PWideChar(pMensagem), PChar(Application.Title), MB_OK +  MB_ICONSTOP);
  end;
end;

function  StringSql(pTexto:String):String;
begin
  if (pTexto = '') then
    Result  :=  'NULL'
  else
    Result  :=  Chr(39) + pTexto  + Chr(39);
end;

function  StringSqlLike(pTexto:String):String;
begin
  Result  :=  StringSql(pTexto+'%');
end;

function  NumeroSql(pNumero:Integer):String;
begin
  Result  :=  StringSql(IntToStr(pNumero));
end;

procedure SetarTextoCombo(pCombo:TComboBox;pCodigo:Integer);
var
  x: Integer;
begin
  pCombo.ItemIndex  :=  0;
  for x := 0 to pCombo.Items.Count - 1 do
  begin
    pCombo.ItemIndex  :=  x;
    if (getCodigoCombo(pCombo) = pCodigo) then
      Break;
  end;
end;

procedure InsereAtualizaBanco(pTabela,pValores:String;pCampos:String='';pAtualiza:String='I';pWhere:String='');
var
  zqInsere:TZQuery;
begin
  zqInsere  :=  TZQuery.Create(nil);
  with zqInsere do
  begin
    Connection  :=  dm.conPrin;
    if Active then
      Close;
    SQL.Clear;
    if (pAtualiza = 'I') then
      SQL.Add('INSERT INTO ' + pTabela  + ' ('  + pCampos + ') VALUES ('  + pValores  + ')')
    else
      SQL.Add('UPDATE ' + pTabela + ' SET ' + pValores + ' WHERE 1=1 AND ' + pWhere);
    ExecSQL;
  end;
  FreeAndNil(zqInsere);
end;

function  Concatenar(pAnterior,pNovo:String;pAddVirg:Boolean=True;pAntes:String='D'):String;
begin
  Result  :=  EmptyStr;
  if (pAntes = 'A') then
    Result  :=  pNovo     + pAnterior
  else
    Result  :=  pAnterior + pNovo;
  if pAddVirg then
    Result  :=  Result  + ',';
end;

function  getCodBarras:String;
var
  zqCodBar:TZQuery;
begin
  zqCodBar  :=  TZQuery.Create(nil);
  with zqCodBar do
  begin
    Connection  :=  dm.conPrin;
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT GERACODBARRAS() FROM DUAL');
    Open; First; FetchAll;
    Result  :=  Fields[0].AsString;
  end;
  FreeAndNil(zqCodBar);
end;

function  JaExisteCodBarras(pCodBarras:String):Boolean;
var
  zqCodBar:TZQuery;
begin
  zqCodBar  :=  TZQuery.Create(nil);
  with zqCodBar do
  begin
    Connection  :=  dm.conPrin;
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) FROM TB_PRODUTOS WHERE COD_BARRAS = ' + StringSql(pCodBarras));
    Open; First; FetchAll;
    Result  :=  (Fields[0].AsInteger >= 1);
  end;
  FreeAndNil(zqCodBar);
end;

function  MensagemSimNao(pMensagem:String):Boolean;
begin
  Result := Application.MessageBox(PWideChar(pMensagem), PChar(Application.Title), MB_YESNO +
    MB_ICONQUESTION) = IDYES;
end;

end.

