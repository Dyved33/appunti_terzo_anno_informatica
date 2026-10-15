#Esercizio 1

CREATE SCHEMA BancaItalia;

CREATE TABLE Persone (
    CodiceFiscale VARCHAR(16) PRIMARY KEY,
    Cognome       VARCHAR(50) NOT NULL,
    Nome          VARCHAR(50) NOT NULL,
    DataDiNascita DATE NOT NULL
);

CREATE TABLE Qualifiche (
    Codice      VARCHAR(10) PRIMARY KEY,
    Descrizione VARCHAR(100) NOT NULL
);

CREATE TABLE Filiali (
    Codice    VARCHAR(10) PRIMARY KEY,
    Citta     VARCHAR(50) NOT NULL,
    Direttore VARCHAR(16)
);

CREATE TABLE Dipendenti (
    CodiceFiscale VARCHAR(16) PRIMARY KEY REFERENCES Persone(CodiceFiscale),
    Filiale       VARCHAR(10) NOT NULL REFERENCES Filiali(Codice),
    Qualifica     VARCHAR(10) NOT NULL REFERENCES Qualifiche(Codice)
);

ALTER TABLE Filiali ADD FOREIGN KEY (Direttore) REFERENCES Dipendenti(CodiceFiscale);

CREATE TABLE Agenzie (
    Numero    INTEGER,
    Filiale   VARCHAR(10) REFERENCES Filiali(Codice),
    Indirizzo VARCHAR(100) NOT NULL,
    Reggente  CHAR(16) REFERENCES Dipendenti(CodiceFiscale),
    PRIMARY KEY (Numero, Filiale)
);

CREATE TABLE ContiCorrenti (
    Numero  INTEGER PRIMARY KEY,
    Agenzia INTEGER NOT NULL,
    Filiale VARCHAR(10) NOT NULL,
    FOREIGN KEY (Agenzia, Filiale) REFERENCES Agenzie(Numero, Filiale)
);

CREATE TABLE TitolaritaCC (
    Conto    INTEGER REFERENCES ContiCorrenti(Numero),
    Titolare VARCHAR(16) REFERENCES Persone(CodiceFiscale),
    PRIMARY KEY (Conto, Titolare)
);

#Esercizio 2

