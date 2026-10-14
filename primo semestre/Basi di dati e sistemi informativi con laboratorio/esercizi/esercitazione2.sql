#Esercizio 1

CREATE SCHEMA BancaItalia

CREATE TABLE persone(
    CodiceFiscale
    Cognome
    Nome
    DataDiNascita
)

CREATE TABLE dipendenti(
    CodiceFiscale
    Filiale
    Qualifica
)

CREATE TABLE qualifiche(
    Codice
    Descrizione
)

CREATE TABLE filiali(
    Codice
    Citta
    Direttore
)

CREATE TABLE agenzie(
    Numero
    Filiale
    Indirizzo
    Reggente
)

CREATE TABLE contiCorrenti(
    Numero
    Agenzia
    Filiale
)

CREATE TABLE titolaritaCC(
    Conto
    Titolare
)