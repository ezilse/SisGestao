unit uBaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmBase = class(TForm)
    actlstProd: TActionList;
    pnlBotoes: TPanel;
    actSalvar: TAction;
    btnSalvar: TBitBtn;
    btnNovo: TBitBtn;
    actNovo: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBase: TfrmBase;

implementation

uses
  Main;

{$R *.dfm}

procedure TfrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action  :=  caFree;
end;

end.
