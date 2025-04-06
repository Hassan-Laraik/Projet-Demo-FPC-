  unit uDM;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset,dialogs;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    DSMedecin: TDataSource;
    ZNX: TZConnection;
    ZqryMedecin: TZQuery;
    ZqryCRUD: TZQuery;
  private
    function SiExiste(const TableName, FieldName, Value: string): Boolean;

  public
    function AjouterMedecin(cin,nom,prenom,adresse,gsm,email : string):boolean;
    function ModifierMedecin(cin, nom, prenom, adresse, gsm, email: string): boolean;
    function FiltrerMedecins(clause : string):Boolean;
    function RecupererChampMedecin(champ : string):string;overload;
    function RecupererChampMedecin(champ : string):TDatetime;overload;
    function RecupererChampMedecin(champ : string):Double;overload;


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

 function TDataModule1.RecupererChampMedecin(champ: string): TdateTime;
 begin
  result := date;
 end;

 function TDataModule1.RecupererChampMedecin(champ: string): Double;
 begin
   result:=0.0;
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

