  unit uPatient;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls, DBGrids, ExtCtrls, EditBtn;

type

  { TFrmPatient }

  TFrmPatient = class(TForm)
    BtnAnnuler: TButton;
    BtnFermer: TButton;
    BtnModifier: TButton;
    BtnNouveau: TButton;
    BtnRechercher: TButton;
    BtnSupprimer: TButton;
    BtnValider: TButton;
    Button1: TButton;
    DateNaissance: TDateEdit;
    EdtGSM: TEdit;
    EdtMituelle: TEdit;
    EdtAdresse: TEdit;
    EdtCinPatient: TEdit;
    EdtNom: TEdit;
    EdtPrenom: TEdit;
    EdtRechercher: TEdit;
    GridMedecin: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RdBoxGendre: TRadioGroup;
    TabAllPatient: TTabSheet;
    TabDetaiPatient: TTabSheet;
    TabSheet3: TTabSheet;
    procedure DateNaissanceEditingDone(Sender: TObject);
    procedure EdtGSMEditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);//
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnNouveauClick(Sender: TObject); //
    procedure BtnRechercherClick(Sender: TObject);
    procedure BtnValiderClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EdtNomEditingDone(Sender: TObject);
    procedure EdtNomKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtPrenomEditingDone(Sender: TObject);
  private

  public

  end;

var
  FrmPatient: TFrmPatient;

implementation
    Uses UDM,uValidation;
{$R *.lfm}

    { TFrmPatient }

    procedure TFrmPatient.FormClose(Sender: TObject; var CloseAction: TCloseAction);
    begin
      CloseAction :=  TCloseAction.caFree;
    FrmPatient := nil;
    FrmPatient.free;
    end;



 procedure TFrmPatient.FormShow(Sender: TObject);
begin
   PageControl1.ActivePage:=TabAllPatient;
  PageControl1.ShowTabs:= False;
end;

 procedure TFrmPatient.BtnAnnulerClick(Sender: TObject);
 begin
   PageControl1.ActivePage:=TabAllPatient;
 end;

 procedure TFrmPatient.BtnFermerClick(Sender: TObject);
 begin

 end;

 procedure TFrmPatient.BtnModifierClick(Sender: TObject);
 begin
  BtnValider.Tag:=1;
  EdtCinPatient.Enabled:=false;
  EdtCinPatient.Text:=DataModule1.RecupererChampPatient('CINpatient');
  EdtNom.Text:=DataModule1.RecupererChampPatient('nomPatient');
  EdtPrenom.Text:=DataModule1.RecupererChampPatient('prenomPatient');
  EdtGSM.Text:=DataModule1.RecupererChampPatient('telephonePatient');
  EdtAdresse.Text:=DataModule1.RecupererChampPatient('adressePatient');
  DateNaissance.Text:= DataModule1.RecupererChampPatient('dateNaissancePatient');
  case DataModule1.RecupererChampPatient('sexePatient') of
    'Homme': RdBoxGendre.ItemIndex:= 0 ;
    'Femme': RdBoxGendre.ItemIndex:= 1;
    'Fille':RdBoxGendre.ItemIndex:= 2 ;
    'Garçon':RdBoxGendre.ItemIndex:= 3;
    'Bébe':RdBoxGendre.ItemIndex:= 4  ;
  end;
  EdtMituelle.Text:= DataModule1.RecupererChampPatient('mutuellePatient');
  PageControl1.ActivePage:=TabDetaiPatient;
 end;

 procedure TFrmPatient.BtnNouveauClick(Sender: TObject);
 begin
   BtnValider.Tag:=0;
   EdtCinPatient.Enabled:=True;
   EdtCinPatient.clear;EdtNom.clear;EdtPrenom.Clear;EdtGSM.Clear;EdtAdresse.Clear;
   EdtMituelle.Clear;
   DateNaissance.Date:= StrToDate('01-01-1970');
   RdBoxGendre.ItemIndex:=0;
   PageControl1.ActivePage:=TabDetaiPatient;
 end;

 procedure TFrmPatient.BtnRechercherClick(Sender: TObject);
 begin

 end;

 procedure TFrmPatient.BtnValiderClick(Sender: TObject);
 begin
    if TRIM(EdtCinPatient.text) = '' then
   begin
      ShowMessage('Cin Patient Obligatoire !');
       EdtCinPatient.SetFocus;
     exit;
   end;
    ShowMessage('1');
   if Length(TRIM(EdtCinPatient.text))<6 then
   begin
      ShowMessage('Cin Patient Doit avoir au minimum  6 caracteres !');
       EdtCinPatient.SetFocus;
     exit;
   end;
     ShowMessage('2');
   //
   if  not uValidation.IsValidNameVide(EdtNom.text,2) then
   begin
     ShowMessage('Nom Patient Doit avoir au minimum   2 caracteres seulement des lettres et les espaces !');
       EdtNom.SetFocus;
       exit;
   end;
   //
   if  not uValidation.IsValidNameVide(EdtPrenom.text,2) then
   begin
     ShowMessage('Prenom Patient Doit avoir au minimum 2 caracteres seulement des lettres et les espaces !');
       EdtPrenom.SetFocus;
       exit;
   end;
   //

     if not uValidation.IsValidPhoneNumber(EdtGSM.Text,10) then
   begin
       ShowMessage('GSM Patient Incorrecte !');
      EdtGSM.SetFocus;
     exit;
   end;



  case BtnValider.Tag of
      0: begin
             if  DataModule1.AjouterPatient(
                               EdtCinPatient.text,
                               EdtNom.text,
                               EdtPrenom.text,
                               EdtAdresse.text,
                               EdtGSM.Text,
                               RdBoxGendre.Items[RdBoxGendre.ItemIndex],
                               EdtMituelle.Text,
                               DateNaissance.Date) then
                               ShowMessage('Operation Ajout Effectuée');
              PageControl1.ActivePage:=TabAllPatient;
              exit;
        end;
      1: begin
             if  DataModule1.ModifierPatient(
                               EdtCinPatient.text,
                               EdtNom.text,
                               EdtPrenom.text,
                               EdtAdresse.text,
                               EdtGSM.Text,
                               RdBoxGendre.Items[RdBoxGendre.ItemIndex],
                               EdtMituelle.Text,
                               DateNaissance.Date) then
              ShowMessage('Operation Modification Effectuée');
              PageControl1.ActivePage:=TabAllPatient;
              exit;
        end;
    end;
  PageControl1.ActivePage:=TabAllPatient;
 end;

 procedure TFrmPatient.Button1Click(Sender: TObject);
 begin

 end;

 procedure TFrmPatient.EdtNomEditingDone(Sender: TObject);
 begin
    EdtNom.text := uValidation.CapitaliseParMot(EdtNom.Text);
   if  not uValidation.IsValidNameVide(EdtNom.text,2) then
   begin
     ShowMessage('Nom Patient Doit avoir au minimum 2 caracteres seulement des lettres et les espaces !');
       EdtNom.SetFocus;
       exit;
   end;
 end;
  procedure TFrmPatient.EdtGSMEditingDone(Sender: TObject);
begin
    if not uValidation.IsValidPhoneNumber(EdtGSM.Text,10) then
   begin
       ShowMessage('GSM Patient Incorrecte !');
      EdtGSM.SetFocus;
     exit;
   end;
end;

 procedure TFrmPatient.DateNaissanceEditingDone(Sender: TObject);
begin
    if not uValidation.IsValidDate(DateNaissance.Text) then
   begin
       ShowMessage('Date Patient Incorrecte !');
      EdtGSM.SetFocus;
     exit;
   end;
end;

 procedure TFrmPatient.EdtNomKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
 begin

 end;

 procedure TFrmPatient.EdtPrenomEditingDone(Sender: TObject);
 begin
  EdtPrenom.text := uValidation.CapitaliseParMot(EdtPrenom.text);
 if  not uValidation.IsValidNameVide(EdtPrenom.text,2) then
   begin
     ShowMessage('Prenom Patient Doit avoir au minimum 2 caracteres seulement des lettres et les espaces !');
       EdtPrenom.SetFocus;
       exit;
   end;
 end;

end.

