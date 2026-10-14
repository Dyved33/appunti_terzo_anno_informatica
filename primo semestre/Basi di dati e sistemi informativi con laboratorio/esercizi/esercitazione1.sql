#Esercizio 1

CREATE TABLE persona{
    id_persona INTEGER PRIMARY KEY;
    nome VARCHAR(20) NOT NULL;
    cognome VARCHAR(20) NOT NULL;
}

CREATE TABLE film{
    id_film INTEGER PRIMARY KEY;
    id_regista INTEGER REFERENCES persona(id_persone) ON DELETE SET NULL;
    titolo VARCHAR(20);
    genere VARCHAR(20);
    anno INTEGER CHECK (anno >0 OR NULL);
}

CREATE TABLE partecipazione{
    id_attore INTEGER REFERENCES persona(id_persona) ON DELETE CASCADE;
    id_film INTEGER REFERENCES film(id_film) ON DELETE CASCADE;
    ruolo VARCHAR(20);
}

CREATE TABLE cinema{
    id_cinema INTEGER PRIMARY KEY;
    nome VARCHAR(20) NOT NULL;
    indirizzo VARCHAR(20);
}

CREATE TABLE proiezione{
    id_cinema INTEGER REFERENCES cinema(id_cinema) ON DELETE CASCADE;
    id_film INTEGER REFERENCES film(id_film) ON DELETE CASCADE;
    giorno DATE;
} 

INSERT INTO cinema VALUES (02, "S. Angelo", "Via Lucida 6 Perugia");
INSERT INTO cinema VALUES (01, "Zenith", "Via Bonfigli 11 Perugia");
INSERT INTO cinema VALUES (03, "Multisala Clarici", "Corso Cavour 84 Foligno");
INSERT INTO cinema VALUES (04, " Multiplex Giometti", " Strada Centova Perugia");

DELETE FROM partecipazione WHERE id_attore = "John Travolta"

#Esercizio 2

CREATE SCHEMA Europei2012;

CREATE TABLE stadio(
    nome VARCHAR(20) PRIMARY KEY;
    citta VARCHAR(20);
    capienza INTEGER;
)

CREATE TABLE squadra(
    nazione VARCHAR(20) PRIMARY KEY;
    confederazione VARCHAR(20);
    data_qualifica DATE;
    sponsor VARCHAR(20);
)

CREATE TABLE partita(
    stadio VARCHAR(20) REFERENCES stadio(nome);
    data DATE;
    squadra1 VARCHAR(20) REFERENCES squadra(nazione);
    squadra2 VARCHAR(20) REFERENCES squadra(nazione);
    goal1 INTEGER;
    goal2 INTEGER;
    spettatori INTEGER;

    PRIMARY KEY(stadio, data);
)
