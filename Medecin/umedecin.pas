  unit uMedecin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ComCtrls, DBGrids,
   RegExpr;

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
    EdtRechercher: TEdit;
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
    procedure BtnRechercherClick(Sender: TObject);
    procedure BtnValiderClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    const
    //EMAIL_REGEX = '^[\w\.-]+@[\w\.-]+\.\w{2,}$';
      function IsValidEmail(const S: string): Boolean;
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
  BtnValider.Tag:=1;
  EdtCinMedecin.Enabled:=false;
  EdtCinMedecin.Text:=DataModule1.RecupererChampMedecin('CINmedecin');
  EdtNom.Text:=DataModule1.RecupererChampMedecin('nomMedecin');
  EdtPrenom.Text:=DataModule1.RecupererChampMedecin('prenomMedcin');
  EdtGSM.Text:=DataModule1.RecupererChampMedecin('gsmMedecin');
  edtEmail.Text:=DataModule1.RecupererChampMedecin('emailMedecinl');
  EdtAdresse.Text:=DataModule1.RecupererChampMedecin('adresseMedecin');
  PageControl1.ActivePage:=TabDetailMedecin;
end;

 procedure TFrmMedecin.BtnNouveauClick(Sender: TObject);
begin
  BtnValider.Tag:=0;
  EdtCinMedecin.Enabled:=True;
  EdtCinMedecin.clear;EdtNom.clear;EdtPrenom.Clear;EdtGSM.Clear;
  edtEmail.Clear;EdtAdresse.clear;
  PageControl1.ActivePage:=TabDetailMedecin;
end;

 procedure TFrmMedecin.BtnRechercherClick(Sender: TObject);
begin
  DataModule1.FiltrerMedecins(EdtRechercher.Text);
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

   if not IsValidEmail(edtEmail.Text) then
   begin
      ShowMessage('Adresse email invalide');
       edtEmail.SetFocus;
     exit;
   end;

    case BtnValider.Tag of
      0: begin
             if  DataModule1.AjouterMedecin(EdtCinMedecin.text,
                               EdtNom.text,
                               EdtPrenom.text,
                               EdtAdresse.text,
                               EdtGSM.Text,
                               edtEmail.Text) then ShowMessage('Operation Ajout Effectuée');
              PageControl1.ActivePage:=TabAllMedecin;
              exit;
        end;
      1: begin
             if  DataModule1.ModifierMedecin(EdtCinMedecin.text,
                               EdtNom.text,
                               EdtPrenom.text,
                               EdtAdresse.text,
                               EdtGSM.Text,
                               edtEmail.Text) then
              ShowMessage('Operation Modification Effectuée');
              PageControl1.ActivePage:=TabAllMedecin;
              exit;
        end;
    end;
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

 function TFrmMedecin.IsValidEmail( const S: string): Boolean;
   const
    EMAIL_REGEX = '^[\w\.-]+@[\w\.-]+\.\w{2,}$';
  var
    RegEx: TRegExpr;
  begin
    RegEx := TRegExpr.Create;
    try
      RegEx.Expression := EMAIL_REGEX;
      Result := RegEx.Exec(S);  // Retourne True si l'email correspond
    finally
      RegEx.Free;
    end;
 end;


end.

