  unit uPrincipale;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TFrmPrincipale }

  TFrmPrincipale = class(TForm)
    BtnMedecin: TButton;
    PnlEntetet: TPanel;
    PnlMenu: TPanel;
    PnlWork: TPanel;
    PnlFooter: TPanel;
    procedure BtnMedecinClick(Sender: TObject);
  private

  public

  end;

var
  FrmPrincipale: TFrmPrincipale;

implementation
  uses uMedecin ,uDM;
{$R *.lfm}

  { TFrmPrincipale }

  procedure TFrmPrincipale.BtnMedecinClick(Sender: TObject);
  begin
   if NOT Assigned(FrmMedecin) then
       Application.CreateForm(TFrmMedecin,FrmMedecin);

   FrmMedecin.Parent := PnlWork;
   FrmMedecin.Align:=TAlign.alClient;

   FrmMedecin.Show;
   FrmMedecin.BringToFront;
  end;




end.

