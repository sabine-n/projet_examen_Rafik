#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 17 10:02:45 2020

@author: utilisateur
"""

import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('mysql+pymysql://RNE_user:RNE_password@localhost/RNE')


def r_names(s):
    c1 = "\.\'"
    for character1 in c1:
        s1=s.replace(character1,'_')
    s2 = s1.replace('é','e')
    s3 = s2.replace('è', 'e')
    s4 = s3.replace('(', '')
    s5 = s4.replace(')', '')
    s6 = s5.replace(' ','_')
    s7 = s6.replace(',', '')
    s8 = s7.split('\t')   
    return s8

# EXEMPLE

#string = "code (insee)	mode de scrutin	numliste	code (nuance de la liste)	numéro du candidat dans la liste	tour	nom	prénom	sexe	Date de naissance	code (profession)	libellé profession	nationalité"
#name_cols = r_names(string)
#print(name_cols)
    
#############################################################################
# r_names et parse_dates : EN UNE SEULE FONCTION
    # retourne tuple de deux listes  :

#def r_names(s):
#    c1 = "\.\'"
#    for character1 in c1:
#        s1=s.replace(character1,'_')
#    s2 = s1.replace('é','e')
#    s3 = s2.replace('è', 'e')
#    s4 = s3.replace('(', '')
#    s5 = s4.replace(')', '')
#    s6 = s5.replace(' ','_')
#    s7 = s6.replace(',', '')
#    s8 = s7.split('\t')   
#    #return s8
#    a =  []
#    for i in range(len(s8)):
#        if 'Date' in s8[i]:
#            a.append(s8[i])
#    return s8, a

################################################################################

def parse_dates(l):
    a =  []
    for i in range(len(l)):
        if 'Date' in l[i]:
            a.append(l[i])
    return a

# EXEMPLE
#date_cols = parse_dates(name_cols)
#print(date_cols)            

path_eval = "/home/utilisateur/Documents/SIMPLON/projet_examen_Rafik/documents_examen/"

# Elus municipaux :																																	
municipaux = "code (insee)	mode de scrutin	numliste	code (nuance de la liste)	numéro du candidat dans la liste	tour	nom	prénom	sexe	Date de naissance	code (profession)	libellé profession	nationalité"
																				
# Nuanceier plolitique :	
nuance_pol = "code	libellé	ordre	définition_"

# Liste des villes :			
villes = "id	departement_code	code_insee	zip_code	name"

# Référentiel géographique : France par commune								
ref_geo_commune = "Code	Nb d'emplois	Artisans, commerçants, chefs d'entreprise	Cadres et professions intellectuelles supérieures	Professions intermédaires	Employés	Ouvriers"

# Population France par commune	
population_commune = "Code insée	Population légale"

# Liste départements :			
departements = "id	region_code	code	name	nom normalisé"

municipal = r_names(municipaux)
nuances = r_names(nuance_pol)
ville = r_names(villes)
ref = r_names(ref_geo_commune)
pop = r_names(population_commune)
dep = r_names(departements)

print('elus = ', municipal,'\n\n', 'nuancier = ', nuances, '\n\n', 'villes = ', ville, "\n\n", 'catégorie = ', ref, '\n\n', "population = ", pop, '\n\n', 'départements = ', dep)


def chargement(s,path,table):
    name_cols = r_names(s)
    df = pd.read_excel(path, delimiter='|', skiprows=2, names=name_cols, parse_dates = parse_dates(s))
    df.to_sql(table, con=engine, if_exists='append', index=False)
    return print('tableau', table, 'has been filled')
    
chargement(municipaux, path_eval+'elus_mun2014.xlsx','elus')    
chargement(nuance_pol, path_eval+'codes_nuances.xlsx', 'nuancier')    
chargement(villes, path_eval+'cities.xlsx', 'villes')  
chargement(ref_geo_commune, path_eval+'categorie_professionelle.xlsx', 'categorie')  
chargement(population_commune, path_eval+'population2017.xlsx', 'population')  
chargement(departements, path_eval+'departments.xlsx', 'departements') 