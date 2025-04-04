  unit uMedecin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ComCtrls, DBGrids;

type

  { TFrmMedecin }

  TFrmMedecin = class(TForm)
    BtnFermer: TButton;
    BtnSupprimer: TButton;
    BtnModifier: TButton;
    BtnNouveau: TButton;
    BtnRechercher: TButton;
    BtnValider: TButton;
    BtnAnnuler: TButton;
    EdtCinMedecin: TEdit;
    EdtNom: TEdit;
    EdtPrenom: TEdit;
    EdtAdresse: TEdit;
    EdtGSM: TEdit;
    edtEmail: TEdit;
    GridMedecin: TDBGrid;
    EdtName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    TabAllMedecin: TTabSheet;
    TabDetailMedecin: TTabSheet;
    TabSheet3: TTabSheet;
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnNouveauClick(Sender: TObject);
    procedure BtnValiderClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FrmMedecin: TFrmMedecin;

implementation
   uses uDM;
{$R *.lfm}

   { TFrmMedecin }

   procedure TFrmMedecin.BtnFermerClick(Sender: TObject);
   begin
     close;
   end;
    ///Projet-Demo-FPC
 procedure TFrmMedecin.BtnAnnulerClick(Sender: TObject);
begin
  PageControl1.ActivePage:=TabAllMedecin;
end;

 procedure TFrmMedecin.BtnModifierClick(Sender: TObject);
begin
  PageControl1.ActivePage:=TabDetailMedecin;
end;

 procedure TFrmMedecin.BtnNouveauClick(Sender: TObject);
begin
  EdtCinMedecin.clear;EdtNom.clear;EdtPrenom.Clear;EdtGSM.Clear;
  edtEmail.Clear;EdtAdresse.clear;
  PageControl1.ActivePage:=TabDetailMedecin;
end;

 procedure TFrmMedecin.BtnValiderClick(Sender: TObject);
begin
   if TRIM(EdtCinMedecin.text) = '' then
   begin
      ShowMessage('Cin Medecin Obligatoire !');
       EdtCinMedecin.SetFocus;
     exit;
   end;
   if Length(TRIM(EdtCinMedecin.text))<6 then
   begin
      ShowMessage('Cin Medecin Doit avoir au minimum  6 caracteres !');
       EdtCinMedecin.SetFocus;
     exit;
   end;
   if TRIM(EdtNom.text) = '' then
   begin
      ShowMessage('Nom Medecin Obligatoire !');
       EdtNom.SetFocus;
     exit;
   end;
   if Length(TRIM(EdtNom.text))< 3 then
   begin
      ShowMessage('Nom Medecin Doit avoir au minimum   3 caracteres !');
       EdtNom.SetFocus;
     exit;
   end;
    if TRIM(EdtPrenom.text) = '' then
   begin
      ShowMessage('Prenom Medecin Obligatoire !');
       EdtPrenom.SetFocus;
     exit;
   end;
   if Length(TRIM(EdtPrenom.text))< 3 then
   begin
      ShowMessage('Prenom Medecin Doit avoir au minimum  3 caracteres !');
       EdtPrenom.SetFocus;
     exit;
   end;

    if     (Length(trim(EdtGSM.Text))> 0)
           and
           (Length(trim(EdtGSM.Text))<10)
   then
   begin
      ShowMessage('GSM Medecin Incorrecte !');
       EdtGSM.SetFocus;
     exit;
   end;

    DataModule1.AjouterMedecin(EdtCinMedecin.text,
                               EdtNom.text,
                               EdtPrenom.text,
                               EdtAdresse.text,
                               EdtGSM.Text,
                               edtEmail.Text);

  PageControl1.ActivePage:=TabAllMedecin;
end;

 procedure TFrmMedecin.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction :=  TCloseAction.caFree;
    FrmMedecin := nil;
    FrmMedecin.free;
end;

 procedure TFrmMedecin.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage:=TabAllMedecin;
  PageControl1.ShowTabs:= False;
end;

end.

