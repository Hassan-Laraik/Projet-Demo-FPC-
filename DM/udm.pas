  unit uDM;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    DSMedecin: TDataSource;
    ZNX: TZConnection;
    ZqryMedecin: TZQuery;
    ZqryCRUD: TZQuery;
  private

  public
    function AjouterMedecin(
       cin,nom,prenom,adresse,gsm,email : string
      ):boolean;
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

 function TDataModule1.AjouterMedecin(cin, nom, prenom, adresse, gsm, email: string): boolean;
begin
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
end;

end.

