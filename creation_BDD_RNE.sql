-- CREATE DATABASE RNE;
USE RNE;
DROP TABLE IF EXISTS elus;
CREATE TABLE elus(
code_insee VARCHAR(10),
mode_de_scrutin VARCHAR(15),
numliste VARCHAR(6),
code_nuance_de_la_liste VARCHAR(6),
numero_du_candidat_dans_la_liste VARCHAR(4),
tour VARCHAR(2),
nom VARCHAR(50),
prenom VARCHAR(50),
sexe VARCHAR(1),
Date_de_naissance DATETIME,
code_profession VARCHAR(4),
libelle_profession VARCHAR(1000),
nationalite VARCHAR(4)
);

DROP TABLE IF EXISTS nuancier;
CREATE TABLE nuancier(
code VARCHAR(5),
libelle VARCHAR(1000),
ordre VARCHAR(3),
definition_ VARCHAR(1000)
);

DROP TABLE IF EXISTS population;
CREATE TABLE population(
Code_insee VARCHAR(10),
Population_legale BIGINT(225)
);

DROP TABLE IF EXISTS villes;
CREATE TABLE villes (
id BIGINT(225),
departement_code VARCHAR(3),
code_insee VARCHAR(6),
zip_code VARCHAR(6),
name VARCHAR(100)
);

DROP TABLE IF EXISTS departements;
CREATE TABLE departements(
id BIGINT(225),
region_code VARCHAR(3),
code VARCHAR(3),
name VARCHAR(100),
nom_normalise VARCHAR(100)
);

DROP TABLE IF EXISTS categorie;
CREATE TABLE categorie(
Code VARCHAR(10),
Nb_d_emplois INT(6),
Artisans_commerçants_chefs_d_entreprise INT(6),
Cadres_et_professions_intellectuelles_superieures INT(6),
Professions_intermedaires INT(6),
Employes INT(6),
Ouvriers INT(6)
);



