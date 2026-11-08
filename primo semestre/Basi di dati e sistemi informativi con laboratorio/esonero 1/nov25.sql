CREATE TABLE Fantino(
    nome VARCHAR(50) PRIMARY KEY,
    eta INTEGER CHECK (eta >= 18)
);

CREATE TABLE Cavallo(
    nome VARCHAR(50) PRIMARY KEY, 
    eta INTEGER CHECK (eta >= 0), 
    scuderia VARCHAR(100)
);

CREATE TABLE Coppia(
    pettorale INTEGER CHECK (pettorale <= 20 AND pettorale >= 1), 
    nazione VARCHAR(100), 
    fantino VARCHAR(50) REFERENCES Fantino(nome), 
    cavallo VARCHAR(50) REFERENCES Cavallo(nome),

    PRIMARY KEY(pettorale, nazione),
    UNIQUE(fantino, cavallo)
);

CREATE TABLE Gara(
    giorno DATE PRIMARY KEY,
    ippodromo VARCHAR(100), 
    vinc_pett INTEGER, 
    vinc_naz VARCHAR(100),

    FOREIGN KEY (vinc_pett, vinc_naz) REFERENCES Coppia(pettorale, nazione)
);