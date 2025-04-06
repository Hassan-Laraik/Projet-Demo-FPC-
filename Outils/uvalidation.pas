  unit uValidation;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RegExpr;
function IsValidPhoneNumber(const PhoneNumber: string; NumberOfDigits: Integer): Boolean;
function IsValidEmail( const S: string): Boolean;
function IsValidDate(const DateStr: string): Boolean;
function IsValidName(const Name: string): Boolean;
function IsValidNameVide(const Name: string): Boolean;

implementation


function IsValidPhoneNumber(const PhoneNumber: string; NumberOfDigits: Integer): Boolean;
var
  RegEx: TRegExpr;
  Pattern: string;
begin
  // Si le numéro est vide, considérer comme valide
  if Trim(PhoneNumber) = '' then
    Exit(True);

  // Crée un motif regex pour un numéro de téléphone composé uniquement de chiffres
  Pattern := '^\d{' + IntToStr(NumberOfDigits) + '}$';

  // Créer l'objet RegEx et définir l'expression régulière
  RegEx := TRegExpr.Create;
  try
    RegEx.Expression := Pattern;
    Result := RegEx.Exec(PhoneNumber);  // Vérifie si le numéro correspond au pattern
  finally
    RegEx.Free;
  end;
end;


 function IsValidEmail( const S: string): Boolean;
   const
    EMAIL_REGEX = '^[\w\.-]+@[\w\.-]+\.\w{2,}$';
  var
    RegEx: TRegExpr;
  begin
    if Trim(s) = '' then
    Exit(True);
    RegEx := TRegExpr.Create;
    try
      RegEx.Expression := EMAIL_REGEX;
      Result := RegEx.Exec(S);  // Retourne True si l'email correspond
    finally
      RegEx.Free;
    end;
 end;


function IsValidDate(const DateStr: string): Boolean;
var
  RegEx: TRegExpr;
  Pattern: string;
begin
  // Si la date est vide, la considérer comme valide
  if Trim(DateStr) = '' then
    Exit(True);

  // Crée un motif regex pour valider une date au format 'dd/mm/yyyy' ou 'yyyy-mm-dd'
  Pattern := '^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$|^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$';

  // Créer l'objet RegEx et définir l'expression régulière
  RegEx := TRegExpr.Create;
  try
    RegEx.Expression := Pattern;
    Result := RegEx.Exec(DateStr);  // Vérifie si la date correspond au pattern
  finally
    RegEx.Free;
  end;
end;


function IsValidName(const Name: string): Boolean;
var
  RegEx: TRegExpr;
  Pattern: string;
  //FormattedName: string;
begin
  // Si le nom est vide, le considérer comme invalide
  if Trim(Name) = '' then
    Exit(False);
  if Length(Trim(Name))< 3 then
    Exit(False);

  //// Convertir la première lettre en majuscule et le reste en minuscule
  //FormattedName := AnsiUpperCase(Copy(Name, 1, 1)) + AnsiLowerCase(Copy(Name, 2, Length(Name) - 1));

  // Crée un motif regex pour valider un nom (seulement des lettres et les espaces)
  Pattern := '^[A-Za-z]+([ A-Za-z]*[A-Za-z]+)*$';

  // Créer l'objet RegEx et définir l'expression régulière
  RegEx := TRegExpr.Create;
  try
    RegEx.Expression := Pattern;
    Result := RegEx.Exec(Name);  // Vérifie si le nom formaté correspond au pattern
  finally
    RegEx.Free;
  end;
end;


function IsValidNameVide(const Name: string): Boolean;
var
  RegEx: TRegExpr;
  Pattern: string;
 // FormattedName: string;
begin
  // Si le nom est vide, le considérer comme valide
  if Trim(Name) = '' then
    Exit(True);

  // Convertir la première lettre en majuscule et le reste en minuscule
  //FormattedName := AnsiUpperCase(Copy(Name, 1, 1)) + AnsiLowerCase(Copy(Name, 2, Length(Name) - 1));

  // Crée un motif regex pour valider un nom (seulement des lettres et les espaces)
  Pattern := '^[A-Za-z]+([ A-Za-z]*[A-Za-z]+)*$';

  // Créer l'objet RegEx et définir l'expression régulière
  RegEx := TRegExpr.Create;
  try
    RegEx.Expression := Pattern;
    Result := RegEx.Exec(Name);  // Vérifie si le nom formaté correspond au pattern
  finally
    RegEx.Free;
  end;
end;

end.






