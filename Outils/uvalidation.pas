  unit uValidation;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RegExpr;
function IsValidPhoneNumber(const PhoneNumber: string; NumberOfDigits: Integer): Boolean;
function IsValidEmail( const S: string): Boolean;

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
    RegEx := TRegExpr.Create;
    try
      RegEx.Expression := EMAIL_REGEX;
      Result := RegEx.Exec(S);  // Retourne True si l'email correspond
    finally
      RegEx.Free;
    end;
 end;

end.






