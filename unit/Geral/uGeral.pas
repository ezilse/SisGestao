unit uGeral;

interface
  uses Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls;

  procedure LimparCamposForm(pFormLimpar:TForm);overload;
  procedure LimparCamposForm(pFormLimpar:TForm;pCampoFocar:TLabeledEdit);overload;

implementation

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

end.
