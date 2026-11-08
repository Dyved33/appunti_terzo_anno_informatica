CREATE TABLE Persona(
    CodiceFiscale VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(100),
    Cognome VARCHAR(100),
    Eta INTEGER CHECK (Eta >= 0)
);
CREATE TABLE Citta(
    Nome VARCHAR(100) PRIMARY KEY, 
    NumeroAbitanti INTEGER CHECK (NumeroAbitanti >= 0)
);
CREATE TABLE HaAbitato(
    Persona VARCHAR(16)ER REFERENCES Persona(CodiceFiscale) ON DELETE CASCADE ON UPDATE CASCADE, 
    Citta VARCHAR(100) REFERENCES Citta(Nome) ON DELETE CASCADE ON UPDATE CASCADE, 
    DaAnno INTEGER, 
    AdAnno INTEGER,

    PRIMARY KEY(Persona, Citta)
    CHECK (DaAnno <= AdAnno)
);