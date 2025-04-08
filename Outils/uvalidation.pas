  unit uValidation;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, RegExpr;
function IsValidPhoneNumber(const PhoneNumber: string; NumberOfDigits: Integer): Boolean;
function IsValidEmail( const S: string): Boolean;
function IsValidDate(const DateStr: string): Boolean;
function IsValidName(const Name: string): Boolean;
function IsValidName(const Name: string; MinWordLength: Integer): Boolean;
function IsValidNameVide(const Name: string): Boolean;
function IsValidNameVide(const Name: string; MinWordLength: Integer): Boolean;
function CapitaliseParMot(const S: string): string;
function IsValidNumber(const InputText: string; const ValidationType: string; MinLength: Integer = 0): Boolean;

implementation



function IsValidNumber(const InputText: string; const ValidationType: string; MinLength: Integer = 0): Boolean;
var
  RegEx: TRegExpr;
  Pattern: string;
begin
  Result := False;

  // Si vide, accepter directement
  if Trim(InputText) = '' then
  begin
    Result := True;
    Exit;
  end;

  // Déterminer le pattern selon ValidationType
  if SameText(ValidationType, 'Phone') then
    Pattern := '^[0-9]{10,15}$' // Numéro de téléphone : 10 à 15 chiffres
  else if SameText(ValidationType, 'Date') then
    Pattern := '^\d{4}-\d{2}-\d{2}$' // Date format : YYYY-MM-DD
  else if SameText(ValidationType, 'Name') then
    Pattern := '^[A-Za-z]+([ A-Za-z]*[A-Za-z]+)*$' // Nom : lettres et espaces
  else if SameText(ValidationType, 'Email') then
    Pattern := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' // Email classique
  else if SameText(ValidationType, 'CIN') then
    Pattern := '^[A-Z]{1,2}[0-9]{5,8}$' // CIN Maroc : 1-2 lettres + 5-8 chiffres
  else if SameText(ValidationType, 'PostalCode') then
    Pattern := '^[0-9]{5}$' // Code Postal Maroc : 5 chiffres
  else
    Exit(False); // Type inconnu => retourne False directement

  // Vérification avec RegEx
  RegEx := TRegExpr.Create;
  try
    RegEx.Expression := Pattern;
    Result := RegEx.Exec(InputText);
  finally
    RegEx.Free;
  end;

  // Vérification de longueur minimale si demandé
  if Result and (MinLength > 0) then
    Result := Length(Trim(InputText)) >= MinLength;
end;



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
  if Length(Trim(Name))< 2 then
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

 function IsValidName( const Name: string; MinWordLength: Integer): Boolean;
 var
  RegEx: TRegExpr;
  Pattern: string;
  Words: TStringArray;
begin
  // Crée un motif regex pour valider un nom (seulement des lettres et des espaces)
  Pattern := '^[A-Za-z]+([ A-Za-z]*[A-Za-z]+)*$';

  // Créer l'objet RegEx et définir l'expression régulière
  RegEx := TRegExpr.Create;
  try
    RegEx.Expression := Pattern;
    if not RegEx.Exec(Name) then
    begin
      Result := False;
      Exit;
    end;
  finally
    RegEx.Free;
  end;

  // Maintenant, vérifier la longueur de chaque mot
  Words := Name.Split([' ']); // Découpe par espaces

    if (Words[0] <> '') and (Length(Words[0]) < MinWordLength) then
    begin
      Result := False;
      Exit;
    end;

  // Si tout est OK
  Result := True;

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



function IsValidNameVide(const Name: string; MinWordLength: Integer): Boolean;
var
  RegEx: TRegExpr;
  Pattern: string;
  Words: TStringArray;
begin
  // Si le nom est vide, le considérer comme valide
  if Trim(Name) = '' then
    Exit(True);

  // Crée un motif regex pour valider un nom (seulement des lettres et des espaces)
  Pattern := '^[A-Za-z]+([ A-Za-z]*[A-Za-z]+)*$';

  // Créer l'objet RegEx et définir l'expression régulière
  RegEx := TRegExpr.Create;
  try
    RegEx.Expression := Pattern;
    if not RegEx.Exec(Name) then
    begin
      Result := False;
      Exit;
    end;
  finally
    RegEx.Free;
  end;

  // Maintenant, vérifier la longueur de chaque mot
  Words := Name.Split([' ']); // Découpe par espaces

    if (Words[0] <> '') and (Length(Words[0]) < MinWordLength) then
    begin
      Result := False;
      Exit;
    end;

  // Si tout est OK
  Result := True;
end;


function CapitaliseParMot(const S: string): string;
var
  i: Integer;
  InWord: Boolean;
  ResultStr: string;
begin
  ResultStr := LowerCase(S); // Tout mettre en minuscule d'abord
  InWord := False;

  for i := 1 to Length(ResultStr) do
  begin
    if (ResultStr[i] in ['A'..'Z', 'a'..'z']) then
    begin
      if not InWord then
      begin
        // Première lettre d'un mot : mettre en majuscule
        ResultStr[i] := UpCase(ResultStr[i]);
        InWord := True;
      end;
    end
    else
      InWord := False; // Si espace ou autre, le prochain caractère sera la première lettre d'un mot
  end;

  Result := ResultStr;
end;


end.






