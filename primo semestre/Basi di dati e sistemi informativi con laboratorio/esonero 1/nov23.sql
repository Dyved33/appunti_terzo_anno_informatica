CREATE SCHEMA UmbriaJazz10023;

CREATE TABLE orchestra (
    codiceO INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    stato VARCHAR(100),
    direttore VARCHAR(100),
);

CREATE TABLE artista(
    codiceA INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    stato VARCHAR(100),
    strumento VARCHAR(100),
    orchestra INTEGER REFERENCES orchestra(codiceO) ON DELETE SET NULL,   
);

CREATE TABLE luogo(
    codiceL INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    indirizzo VARCHAR(100),
    tipo VARCHAR(100) NOT NULL,

    CHECK (tipo IN (
        'piazza',
        'giardino',
        'esercizio commerciale',
        'teatro',
        'arena'
    ))
);

CREATE TABLE esibizione_orchestra(
    orchestra INTEGER,
    codLuogo INTEGER,
    data DATE,
    ora TIME,
    prezzo_biglietto DECIMAL(8,2) CHECK (prezzo_biglietto >= 0),

    PRIMARY KEY (codLuogo, data, ora),
    FOREIGN KEY (orchestra) REFERENCES orchestra(codiceO),
    FOREIGN KEY (codLuogo) REFERENCES luogo(codiceL),    
);

CREATE TABLE esibizione_solista(
    artista VARCHAR(100),
    codLuogo INTEGER,
    data DATE,
    ora TIME,
    prezzo_biglietto DECIMAL(8,2) CHECK (prezzo_biglietto >= 0),

    PRIMARY KEY (codLuogo, data, ora),
    FOREIGN KEY (artista) REFERENCES artista(codiceA),
    FOREIGN KEY (codLuogo) REFERENCES luogo(codiceL),   
)