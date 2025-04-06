# Gestion des Médecins – Application Lazarus (FPC)

## 🩺 Description

Ce projet est une application de bureau développée avec **Lazarus** (Free Pascal) permettant de gérer les informations des médecins dans une base de données MySQL.  
Il s'agit d'une interface CRUD (Créer, Lire, Mettre à jour, Supprimer) simple et intuitive.

---

## 📁 Structure du Projet

- **uMedecin.pas** : Unité principale contenant l’interface utilisateur et la logique de gestion des médecins.
- **uDM.pas** : Unité de gestion des données via ZeosLib (TZConnection, TZQuery).
- **Formulaires** :
  - **PageControl1** avec des onglets pour l’affichage de la liste et des détails.
  - **DBGrid** pour afficher tous les médecins.
  - **Éditeurs de texte (TEdit)** pour saisir les données du médecin (CIN, Nom, Prénom, etc.).
  - **Boutons** pour effectuer les opérations CRUD.

---

## ✅ Fonctionnalités

- Ajouter un nouveau médecin.
- Modifier les informations d’un médecin existant.
- Supprimer un médecin (à implémenter).
- Rechercher un médecin (à implémenter).
- Validation des champs :
  - Le **CIN** est requis (minimum 6 caractères).
  - Le **Nom** et **Prénom** sont requis (minimum 3 caractères).
  - Le **GSM** est facultatif mais s’il est rempli, il doit contenir au moins 10 chiffres.

---

## 🛠️ Technologies Utilisées

- **Lazarus IDE**
- **Free Pascal Compiler (FPC)**
- **ZeosLib** (pour la connexion MySQL)
- **MySQL/MariaDB**

---

## ⚙️ Base de Données

### Table : `medecins`

```sql
CREATE TABLE medecins (
  cin VARCHAR(20) PRIMARY KEY,
  nom VARCHAR(50),
  prenom VARCHAR(50),
  adresse TEXT,
  gsm VARCHAR(15),
  email VARCHAR(100)
);


# README - Projet de Gestion des Médecins

Ce projet est une application développée avec **Free Pascal (FPC)** et le framework **Lazarus**. L'unité `uMedecin` permet de gérer les informations des médecins à partir d'une interface graphique. Les utilisateurs peuvent ajouter, modifier, rechercher et supprimer des médecins à partir d'une base de données. L'application inclut également la validation des emails à l'aide d'une expression régulière (regex).

## Structure de l'unité `uMedecin`

### 1. **Déclarations des composants visuels**

L'interface contient plusieurs composants visuels tels que des boutons (`TButton`), des champs de saisie (`TEdit`), des étiquettes (`TLabel`), une grille (`TDBGrid`), ainsi que des onglets de contrôle (`TPageControl`), permettant une gestion fluide de la fenêtre.

Voici un aperçu des composants :

- **Composants de contrôle** :
  - `BtnFermer`, `BtnSupprimer`, `BtnModifier`, `BtnNouveau`, `BtnRechercher`, `BtnValider`, `BtnAnnuler` : Boutons pour effectuer différentes actions.
  - `EdtCinMedecin`, `EdtNom`, `EdtPrenom`, `EdtAdresse`, `EdtGSM`, `edtEmail` : Champs de texte pour saisir les informations du médecin.
  - `GridMedecin` : Grille pour afficher les médecins.
  - `PageControl1`, `TabAllMedecin`, `TabDetailMedecin` : Composants pour afficher les onglets de l'interface.

- **Labels et panels** :
  - `Label1`, `Label2`, etc. : Étiquettes pour afficher des titres à côté des champs de texte.
  - `Panel1`, `Panel2`, `Panel3` : Panneaux pour organiser les éléments visuels.

### 2. **Les événements des boutons**

Le code définit des événements pour chaque bouton afin de gérer les actions correspondantes :

- **`BtnFermerClick`** : Ferme la fenêtre.
- **`BtnAnnulerClick`** : Annule l'action en cours et revient à l'onglet principal (`TabAllMedecin`).
- **`BtnModifierClick`** : Permet de modifier un médecin sélectionné en affichant ses informations dans les champs de texte et en activant l'onglet `TabDetailMedecin`.
- **`BtnNouveauClick`** : Permet d'ajouter un nouveau médecin, en réinitialisant les champs de saisie et en affichant l'onglet `TabDetailMedecin`.
- **`BtnRechercherClick`** : Lance la recherche des médecins à partir du texte saisi dans le champ de recherche `EdtRechercher`.
- **`BtnValiderClick`** : Valide les données saisies et enregistre le médecin dans la base de données en fonction de l'action sélectionnée (ajouter ou modifier).

### 3. **Validation des champs**

La méthode **`BtnValiderClick`** contient des vérifications sur les champs de saisie avant de valider les données :

- **Validation de la CIN** : Le champ `EdtCinMedecin` ne doit pas être vide et doit contenir au moins 6 caractères.
- **Validation du nom et prénom** : Les champs `EdtNom` et `EdtPrenom` ne doivent pas être vides et doivent contenir au moins 3 caractères.
- **Validation du GSM** : Le champ `EdtGSM` doit contenir exactement 10 caractères s'il est rempli.
- **Validation de l'email** : La méthode `IsValidEmail` est utilisée pour valider le format de l'email à l'aide d'une expression régulière (regex).

### 4. **Fonction de validation d'email**

La fonction **`IsValidEmail`** utilise une expression régulière pour valider si un email est conforme au format classique `user@example.com`. L'expression régulière utilisée est la suivante :

```pascal
const EMAIL_REGEX = '^[\w\.-]+@[\w\.-]+\.\w{2,}$';
```

Elle vérifie que l'email :
- Contient des caractères alphanumériques, des points ou des tirets avant le `@`.
- Contient un domaine après le `@`, suivi d'un point et d'un suffixe de domaine valide (au moins 2 caractères).

Si l'email est valide, la méthode retourne `True`, sinon elle retourne `False`.

### 5. **Gestion de la fermeture et de l'affichage de la fenêtre**

- **`FormClose`** : Gère la fermeture de la fenêtre et la libération des ressources.
- **`FormShow`** : Lorsque le formulaire est affiché, l'onglet principal (`TabAllMedecin`) est activé et les onglets secondaires sont masqués.

### 6. **Gestion des données via `DataModule`**

Les méthodes `DataModule1.AjouterMedecin`, `DataModule1.ModifierMedecin`, et `DataModule1.FiltrerMedecins` sont appelées pour interagir avec la base de données ou le module de données (souvent un module séparé où les opérations de base de données sont définies).

---

## Conclusion

Cette unité permet de gérer les informations des médecins dans une application en **Free Pascal** (FPC). Elle valide les champs importants comme la CIN, le nom, le prénom, le GSM, et surtout l'email à l'aide d'une expression régulière. Le système offre une interface utilisateur pour ajouter, modifier, et rechercher des médecins, avec des contrôles de validation pour garantir l'intégrité des données avant toute modification dans la base de données.

Si vous avez des questions ou si vous souhaitez des précisions sur une partie du code, n'hésitez pas à demander !
