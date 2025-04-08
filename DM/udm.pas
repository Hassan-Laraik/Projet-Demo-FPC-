  unit uDM;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset,dialogs;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    DSMedecin: TDataSource;
    DSPatient: TDataSource;
    ZNX: TZConnection;
    ZqryMedecin: TZQuery;
    ZqryCRUD: TZQuery;
    ZqryPatient: TZQuery;
  private
    function SiExiste(const TableName, FieldName, Value: string): Boolean;

  public
    function AjouterMedecin(cin,nom,prenom,adresse,gsm,email : string):boolean;
    function ModifierMedecin(cin, nom, prenom, adresse, gsm, email: string): boolean;
    function FiltrerMedecins(clause : string):Boolean;
    function RecupererChampMedecin(champ : string):string;//overload;
    function RecupererChampPatient(champ : string):string;
    //function RecupererChampMedecin(champ : string):TDatetime;overload;
    //function RecupererChampMedecin(champ : string):Double;overload;
     function AjouterPatient(cin, nom, prenom, adresse, gsm, sexe, mituelle: string; naissance: TDate): boolean;
     function ModifierPatient(cin, nom, prenom, adresse, gsm, sexe, mituelle: string; naissance: TDate): boolean;
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }



 function TDataModule1.AjouterMedecin(cin, nom, prenom, adresse, gsm, email: string): boolean;
begin
    if  SiExiste('medecins','CINmedecin',cin) then
    begin
      ShowMessage('Medecin existe Deja');
      Result:=False;
      exit;
    end;
  try
   result := true;
   ZqryCRUD.SQL.clear;
   ZqryCRUD.SQL.Text:='INSERT INTO medecins values (:cin,:nom,:prenom,:adresse,:gsm,:email)';
   ZqryCRUD.ParamByName('cin').AsString:=cin;
   ZqryCRUD.ParamByName('nom').AsString:=nom;
   ZqryCRUD.ParamByName('prenom').AsString:=prenom;
   ZqryCRUD.ParamByName('adresse').AsString:=adresse;
   ZqryCRUD.ParamByName('gsm').AsString:=gsm;
   ZqryCRUD.ParamByName('email').AsString:=email;
   ZqryCRUD.ExecSQL;
   ZqryMedecin.Refresh;
  except
   result:=False;
  end;
end;
 function TDataModule1.ModifierMedecin(cin, nom, prenom, adresse, gsm, email: string): boolean;
begin
   if NOT SiExiste('medecins','CINmedecin',cin) then
    begin
      ShowMessage('Medecin Non Enregistré');
      Result:=false;
      exit;
    end;
  try
   result:=true;
   ZqryCRUD.SQL.clear;
   ZqryCRUD.SQL.add('UPDATE medecins set nomMedecin=:nom,prenomMedcin=:prenom,adresseMedecin=:adresse,') ;
   ZqryCRUD.SQL.add('gsmMedecin=:gsm,emailMedecinl=:email where CINmedecin=:cin');
   ZqryCRUD.ParamByName('cin').AsString:=cin;
   ZqryCRUD.ParamByName('nom').AsString:=nom;
   ZqryCRUD.ParamByName('prenom').AsString:=prenom;
   ZqryCRUD.ParamByName('adresse').AsString:=adresse;
   ZqryCRUD.ParamByName('gsm').AsString:=gsm;
   ZqryCRUD.ParamByName('email').AsString:=email;
   ZqryCRUD.ExecSQL;
   ZqryMedecin.Refresh;
  except
   result:=False;
  end;

end;

 function TDataModule1.FiltrerMedecins(clause: string): Boolean;
 begin
     ZqryMedecin.Filtered:=false;
     ZqryMedecin.filter := 'concat(CINmedecin,nomMedecin) like '+QuotedStr('*'+clause+'*');
     ZqryMedecin.Filtered:=true;
 end;

 function TDataModule1.RecupererChampMedecin(champ: string): string;
 begin
  result := ZqryMedecin.FieldByName(champ).AsString;
 end;

 function TDataModule1.RecupererChampPatient(champ: string): string;
 begin
   result := ZqryPatient.FieldByName(champ).AsString;
 end;

 function TDataModule1.AjouterPatient(cin, nom, prenom, adresse, gsm,sexe,mituelle: string;naissance:TDate): boolean;
 begin
   ShowMessage('1');
    if  SiExiste('patients','CINpatient',cin) then
    begin
      ShowMessage('Patient existe Deja');
      Result:=False;
      exit;
    end;
      ShowMessage('2');
  try
   result := true;
   ZqryCRUD.SQL.clear;
   ZqryCRUD.Params.Clear;
   ZqryCRUD.SQL.add('INSERT INTO patients ');
   //ZqryCRUD.SQL.add('(CINpatient,nomPatient,prenomPatient,adressePatient,telephonePatient,)');
   ZqryCRUD.SQL.add('values (:cin,:nom,:prenom,:adresse,:gsm,:naissance,:sexe,:mituelle)');
   ZqryCRUD.ParamByName('cin').AsString:=cin;
   ZqryCRUD.ParamByName('nom').AsString:=nom;
   ZqryCRUD.ParamByName('prenom').AsString:=prenom;
   ZqryCRUD.ParamByName('adresse').AsString:=adresse;
   ZqryCRUD.ParamByName('gsm').AsString:=gsm;
   ZqryCRUD.ParamByName('naissance').AsDate:=naissance;
   ZqryCRUD.ParamByName('sexe').AsString:=sexe;
   ZqryCRUD.ParamByName('mituelle').AsString:=mituelle;
   ShowMessage('3');
   ZqryCRUD.ExecSQL;
   ShowMessage('4');
   ZqryPatient.Refresh;
   ShowMessage('5');
  except
    on E: Exception do
    begin
    ShowMessage('Erreur : ' + E.Message);
     result:=False;
  end;
 end;
 end;

 //function TDataModule1.RecupererChampMedecin(champ: string): TdateTime;
 //begin
 // result := ZqryMedecin.FieldByName(champ).AsDateTime;
 //end;
 //
 //function TDataModule1.RecupererChampMedecin(champ: string): Double;
 //begin
 //  result:=ZqryMedecin.FieldByName(champ).AsFloat;
  //end;

 function TDataModule1.ModifierPatient(cin, nom, prenom, adresse, gsm, sexe, mituelle: string;
   naissance: TDate): boolean;
 begin
   if NOT SiExiste('patients','CINPatient',cin) then
    begin
      ShowMessage('PAtient Non Enregistré');
      Result:=false;
      exit;
    end;
  try
   result:=true;
   ZqryCRUD.SQL.clear;
   ZqryCRUD.SQL.add('UPDATE patients set nomPatient=:nom,prenomPatient=:prenom,adressePatient=:adresse,') ;
   ZqryCRUD.SQL.add('telephonePatient=:gsm,dateNaissancePatient=:naissance,sexePatient=:sexe,mutuellePatient=:mituelle') ;
   ZqryCRUD.SQL.add(' where CINpatient=:cin');

   ZqryCRUD.ParamByName('cin').AsString:=cin;
   ZqryCRUD.ParamByName('nom').AsString:=nom;
   ZqryCRUD.ParamByName('prenom').AsString:=prenom;
   ZqryCRUD.ParamByName('adresse').AsString:=adresse;
   ZqryCRUD.ParamByName('gsm').AsString:=gsm;
   ZqryCRUD.ParamByName('naissance').AsDate:=naissance;
   ZqryCRUD.ParamByName('sexe').AsString:=sexe;
   ZqryCRUD.ParamByName('mituelle').AsString:=mituelle;
   ZqryCRUD.ExecSQL;
   ZqryPatient.Refresh;
  except
   result:=False;
  end;
 end;

function TDataModule1.SiExiste(const TableName, FieldName, Value: string): Boolean;
begin
  Result := False;
  ZqryCRUD.Close;
  ZqryCRUD.SQL.Clear;

  ZqryCRUD.SQL.Add('SELECT 1 FROM ' + TableName);
  ZqryCRUD.SQL.Add('WHERE ' + FieldName + ' = :Value');

  ZqryCRUD.ParamByName('Value').AsString := Value;

  try
    ZqryCRUD.Open;
    Result := not ZqryCRUD.IsEmpty;
  except
    on E: Exception do
    begin
      // Ici tu peux aussi logger l'exception si tu veux :
      // ShowMessage('Erreur SQL : ' + E.Message);
      Result := False;
    end;
  end;
end;

end.

