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

CREATE TABLE reparto(
    nome VARCHAR(20) PRIMARY KEY,
    ubicazione VARCHAR(20),
    primario VARCHAR(20)
);

CREATE TABLE stanza(
    numero INTEGER CHECK(numero >= 1),
    reparto VARCHAR(20),
    PRIMARY KEY(numero, reparto)
);

CREATE TABLE letto(
    numero INTEGER CHECK(numero >= 1),
    stanza INTEGER,
    reparto VARCHAR(20)
    PRIMARY KEY (numero, rtanza, reparto),
    FOREIGN KEY (stanza, reparto) REFERENCES stanza(numero, reparto)
);

CREATE TABLE medico(
    codice_fiscale CHAR(16) PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    cognome VARCHAR(20) NOT NULL,
    reparto VARCHAR(20) NOT NULL REFERENCES reparto(nome)
);

CREATE TABLE paziente(
    numero_tessera VARCHAR(20) PRIMARY KEY,
    codice_fiscale CHAR(16) NOT NULL UNIQUE,
    nome VARCHAR(20) NOT NULL,
    indirizzo VARCHAR(100),
    sesso BOOLEAN CHECK(sesso IN ('M','F'))
);

CREATE TABLE ricovero(
    paziente VARCHAR(20) REFERENCES paziente(numero_tessera),
    data_ammissione DATE,
    data_dimissione DATE,
    PRIMARY KEY(paziente, data_ammissione),
    CHECK(data_dimissione IS NULL OR data_dimissione >= data_ammissione)
);

CREATE TABLE degenza(
    paziente VARCHAR(20),
    ammissione_paziente DATE,
    data_inizio DATE,
    data_fine DATE,
    letto INTEGER NOT NULL,
    stanza INTEGER NOT NULL,
    reparto VARCHAR(20) NOT NULL,

    PRIMARY KEY (paziente, ammissione_paziente, data_inizio),
    FOREIGN KEY (paziente, ammissione_paziente) REFERENCES ricovero(paziente, data_ammissione),
    FOREIGN KEY (letto, stanza, reparto) REFERENCES letto(numero, stanza, reparto),
    CHECK (data_fine IS NULL OR data_fine >= data_inizio)
);

#Esercizio 3

CREATE TABLE Corso (
    codiceCorso VARCHAR(10) PRIMARY KEY,
    nomeCorso   VARCHAR(100) NOT NULL,
    CFU         INTEGER NOT NULL CHECK (CFU > 0),
    SSD         VARCHAR(15)
);

CREATE TABLE Indirizzo (
    codiceIndirizzo VARCHAR(10) PRIMARY KEY,
    titolo          VARCHAR(100) NOT NULL
);

CREATE TABLE Composizione (
    indirizzo VARCHAR(10) REFERENCES Indirizzo(codiceIndirizzo)
                  ON DELETE CASCADE ON UPDATE CASCADE,
    corso     VARCHAR(10) REFERENCES Corso(codiceCorso)
                  ON DELETE NO ACTION ON UPDATE CASCADE,
    tipo      VARCHAR(3) NOT NULL CHECK (tipo IN ('Obb','Fac')),
    anno      VARCHAR(3) NOT NULL CHECK (anno IN ('I','II','III')),
    PRIMARY KEY (indirizzo, corso)
);

#Esercizio 4

CREATE TABLE Persona (
    CodiceFiscale CHAR(16) PRIMARY KEY,
    Nome          VARCHAR(50) NOT NULL,
    Cognome       VARCHAR(50) NOT NULL,
    Eta           INTEGER CHECK (Eta >= 0)
);

CREATE TABLE Citta (
    Nome          VARCHAR(50) PRIMARY KEY,
    NumeroAbitanti INTEGER CHECK (NumeroAbitanti >= 0)
);

CREATE TABLE HaAbitato (
    Persona CHAR(16) REFERENCES Persona(CodiceFiscale),
    Citta   VARCHAR(50) REFERENCES Citta(Nome),
    DaAnno  INTEGER,
    AdAnno  INTEGER,
    PRIMARY KEY (Persona, Citta, DaAnno),
    CHECK (AdAnno IS NULL OR AdAnno >= DaAnno)
);

CREATE TABLE Ditta (
    PIVA            CHAR(11) PRIMARY KEY,
    NumeroImpiegati INTEGER CHECK (NumeroImpiegati >= 0),
    CapitaleSociale NUMERIC(14,2) CHECK (CapitaleSociale >= 0) #sostanzialmente è un float
);

CREATE TABLE HaAvutoSede (
    Ditta  CHAR(11) REFERENCES Ditta(PIVA),
    Citta  VARCHAR(50) REFERENCES Citta(Nome),
    DaAnno INTEGER,
    AdAnno INTEGER,
    PRIMARY KEY (Ditta, Citta, DaAnno),
    CHECK (AdAnno IS NULL OR AdAnno >= DaAnno)
);

CREATE TABLE HaLavorato (
    Persona CHAR(16) REFERENCES Persona(CodiceFiscale),
    Ditta   CHAR(11) REFERENCES Ditta(PIVA),
    DaAnno  INTEGER,
    AdAnno  INTEGER,
    PRIMARY KEY (Persona, Ditta, DaAnno),
    CHECK (AdAnno IS NULL OR AdAnno >= DaAnno)
);

#Esercizio 5

CREATE TABLE CLIENTE (
    numC       INTEGER PRIMARY KEY,
    nomeC      VARCHAR(50) NOT NULL,
    cognomeC   VARCHAR(50) NOT NULL,
    citta      VARCHAR(50)
);

CREATE TABLE ARTICOLO (
    numA   INTEGER PRIMARY KEY,
    prezzo NUMERIC(10,2) NOT NULL CHECK (prezzo >= 0)
);

CREATE TABLE MAGAZZINO (
    numM  INTEGER PRIMARY KEY,
    citta VARCHAR(50) NOT NULL
);

CREATE TABLE ORDINE (
    numO     INTEGER PRIMARY KEY,
    dataO    DATE NOT NULL,
    numC     INTEGER NOT NULL REFERENCES CLIENTE(numC),
    importoO NUMERIC(12,2) CHECK (importoO >= 0)
);

CREATE TABLE ORDINE_ART (
    numO     INTEGER REFERENCES ORDINE(numO) ON DELETE CASCADE,
    numA     INTEGER REFERENCES ARTICOLO(numA),
    quantita INTEGER NOT NULL CHECK (quantita > 0),
    PRIMARY KEY (numO, numA)
);

CREATE TABLE SPEDIZIONE (
    numO  INTEGER REFERENCES ORDINE(numO) ON DELETE CASCADE,
    numM  INTEGER REFERENCES MAGAZZINO(numM),
    dataS DATE,
    PRIMARY KEY (numO, numM)
);