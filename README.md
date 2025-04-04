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

