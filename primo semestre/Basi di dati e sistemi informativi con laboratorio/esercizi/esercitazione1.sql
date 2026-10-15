#Esercizio 1

CREATE TABLE persona (
    id_persona INTEGER PRIMARY KEY,
    nome       VARCHAR(50) NOT NULL,
    cognome    VARCHAR(50) NOT NULL
);

CREATE TABLE film (
    id_film    INTEGER PRIMARY KEY,
    id_regista INTEGER REFERENCES persona(id_persona) ON DELETE SET NULL,
    titolo     VARCHAR(100),
    genere     VARCHAR(30),
    anno       INTEGER CHECK (anno > 0)   -- NULL ammesso
);

CREATE TABLE partecipazione (
    id_attore INTEGER REFERENCES persona(id_persona) ON DELETE CASCADE,
    id_film   INTEGER REFERENCES film(id_film)       ON DELETE CASCADE,
    ruolo     VARCHAR(50),
    PRIMARY KEY (id_attore, id_film)
);

CREATE TABLE cinema (
    id_cinema INTEGER PRIMARY KEY,
    nome      VARCHAR(50) NOT NULL,
    indirizzo VARCHAR(100)
);

CREATE TABLE proiezione (
    id_cinema INTEGER REFERENCES cinema(id_cinema) ON DELETE CASCADE,
    id_film   INTEGER REFERENCES film(id_film)     ON DELETE CASCADE,
    giorno    DATE,
    PRIMARY KEY (id_cinema, id_film, giorno)
); 

INSERT INTO cinema VALUES (02, "S. Angelo", "Via Lucida 6 Perugia");
INSERT INTO cinema VALUES (01, "Zenith", "Via Bonfigli 11 Perugia");
INSERT INTO cinema VALUES (03, "Multisala Clarici", "Corso Cavour 84 Foligno");
INSERT INTO cinema VALUES (04, " Multiplex Giometti", " Strada Centova Perugia");

DELETE FROM persona WHERE nome = 'John' AND cognome = 'Travolta';

#Esercizio 2

CREATE SCHEMA Europei2012;

CREATE TABLE stadio (
    nome     VARCHAR(50) PRIMARY KEY,
    citta    VARCHAR(50) NOT NULL,
    capienza INTEGER CHECK (capienza > 0)
);

CREATE TABLE squadra (
    nazione       VARCHAR(50) PRIMARY KEY,
    confederazione VARCHAR(20),
    data_qualifica DATE,
    sponsor        VARCHAR(50)
);

CREATE TABLE partita (
    stadio     VARCHAR(50) REFERENCES stadio(nome)
                   ON DELETE NO ACTION ON UPDATE CASCADE,
    data       DATE,
    squadra1   VARCHAR(50) NOT NULL REFERENCES squadra(nazione)
                   ON DELETE NO ACTION ON UPDATE CASCADE,
    squadra2   VARCHAR(50) NOT NULL REFERENCES squadra(nazione)
                   ON DELETE NO ACTION ON UPDATE CASCADE,
    goal1      INTEGER CHECK (goal1 >= 0),
    goal2      INTEGER CHECK (goal2 >= 0),
    spettatori INTEGER CHECK (spettatori >= 0),
    PRIMARY KEY (stadio, data)
);

    