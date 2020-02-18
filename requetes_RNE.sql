-- USE RNE;

-- 8) Quel sont les parties politiques qui dans leur libellé comporte le terme « Union »?
SELECT libelle 
FROM nuancier
WHERE libelle LIKE "%Union%";

-- LES INDEX --

-- ALTER TABLE population 
-- ADD INDEX idx_pop_code_insee (Code_insee); 
-- ALTER TABLE categorie
-- ADD INDEX idx_cat_code_insee (Code); 
-- ALTER TABLE villes
-- ADD INDEX idx_v_code_dep (departement_code)
-- ALTER TABLE villes 
-- ADD INDEX idx_villes_code_insee (code_insee); 
-- ALTER TABLE elus
-- ADD INDEX idx_elus_code_insee (code_insee)
-- ALTER TABLE departements
-- ADD INDEX idx_dep_code_dep (code)


-- 9) Quels élus du département du « var » sont nais entre le mois de juin et aout ?
SELECT nom, prenom
FROM departements d
INNER JOIN villes v ON d.code = v.departement_code AND d.nom_normalise = 'var'
INNER JOIN elus e ON v.code_insee = e.code_insee
WHERE month(Date_de_naissance) BETWEEN 06 and 08;

-- 10) Quel est l’âge moyen des élus homme au 01/01/2014 ? Celui des élus femme ?
SELECT AVG(ABS(TIMESTAMPDIFF(year, '2014-01-01', Date_de_naissance))) as age_moyen_H
FROM elus 
WHERE sexe = 'M';

SELECT AVG(ABS(TIMESTAMPDIFF(year, '2014-01-01', Date_de_naissance))) as age_moyen, sexe
FROM elus 
GROUP BY sexe;

-- 11) Afficher la population totale du département des « Bouches-du-Rhône »
SELECT SUM(population_legale) as population
FROM population p 
INNER JOIN villes v ON p.Code_insee = v.code_insee
INNER JOIN departements d ON d.code = 13 AND v.departement_code = d.code;


-- 12) Quel sont les 10 départements comptant le plus d’ouvriers?
SELECT SUM(Ouvriers) as nb_ouvriers, d.name FROM categorie c
INNER JOIN population p ON c.Code = p.Code_insee
INNER JOIN villes v ON p.Code_insee = v.code_insee
INNER JOIN departements d ON v.departement_code = d.code
GROUP BY d.name
ORDER BY nb_ouvriers DESC
LIMIT 10;

-- 13) Afficher le nombre d’élus regroupés par nuance politique et par département.
SELECT COUNT(CONCAT(nom, prenom, Date_de_naissance)) as nb_elus, n.libelle, d.name
FROM nuancier n
INNER JOIN elus e ON n.code = e.code_nuance_de_la_liste
INNER JOIN villes v ON e.code_insee = v.code_insee
INNER JOIN departements d ON v.departement_code = d.code
GROUP BY n.libelle, d.name;

-- 14) Afficher le nombre d’élus regroupé par nuance politique et par villes pour le département des « Bouches-du-Rhône ».
SELECT COUNT(CONCAT(nom, prenom, Date_de_naissance)) as nb_elus, n.libelle, v.name
FROM nuancier n
INNER JOIN elus e ON n.code = e.code_nuance_de_la_liste
INNER JOIN villes v ON e.code_insee = v.code_insee
INNER JOIN departements d ON v.departement_code = d.code AND d.code = 13
GROUP BY n.libelle, v.name;

-- 15) Afficher les 10 départements dans lesquelles il y a le plus d’élus femme, ainsi que le nombre d’élus femme correspondant.
SELECT COUNT(sexe) as nb_F , d.name as département
FROM elus e
INNER JOIN villes v ON sexe = 'F'  AND e.code_insee =  v.code_insee
INNER JOIN departements d ON v.departement_code = d.code
GROUP BY d.name
ORDER BY nb_F DESC
LIMIT 10;

-- 16) Donner l’âge moyen des élus par départements au 01/01/2014. Les afficher par ordre décroissant.
SELECT AVG(ABS(TIMESTAMPDIFF(year, '2014-01-01', Date_de_naissance))) as age_moyen, d.name as département
FROM elus e
INNER JOIN villes v ON e.code_insee =  v.code_insee
INNER JOIN departements d ON v.departement_code = d.code
GROUP BY d.name
ORDER BY age_moyen DESC;

-- 17) Afficher les départements où l’âge moyen des élus est strictement inférieur à 54 ans.
SELECT AVG(ABS(TIMESTAMPDIFF(year, '2014-01-01', Date_de_naissance))) as age_moyen, d.name as département
FROM elus e
INNER JOIN villes v ON e.code_insee =  v.code_insee
INNER JOIN departements d ON v.departement_code = d.code 
GROUP BY d.name
HAVING age_moyen < 54
ORDER BY age_moyen DESC;

