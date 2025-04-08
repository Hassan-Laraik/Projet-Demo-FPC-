  unit uPrincipale;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TFrmPrincipale }

  TFrmPrincipale = class(TForm)
    BtnMedecin: TButton;
    BtnPatient: TButton;
    PnlEntetet: TPanel;
    PnlMenu: TPanel;
    PnlWork: TPanel;
    PnlFooter: TPanel;
    procedure BtnMedecinClick(Sender: TObject);
    procedure BtnPatientClick(Sender: TObject);
  private

  public

  end;

var
  FrmPrincipale: TFrmPrincipale;

implementation
  uses umedecin ,uPatient,uDM;
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

 procedure TFrmPrincipale.BtnPatientClick(Sender: TObject);
begin
   if NOT Assigned(FrmPatient) then
       Application.CreateForm(TFrmPatient,FrmPatient);

   FrmPatient.Parent := PnlWork;
   FrmPatient.Align:=TAlign.alClient;

   FrmPatient.Show;
   FrmPatient.BringToFront;
end;




end.

