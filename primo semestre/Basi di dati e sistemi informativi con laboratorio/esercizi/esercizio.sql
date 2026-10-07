CREATE SCHEMA spettacoli;

CREATE TABLE persona(id_persona INTEGER PRIMARY KEY, 
nome VARCHAR NOT NULL,
cognome VARCHAR NOT NULL);

CREATE TABLE film(id_film INTEGER PRIMARY KEY,
id_registra VARCHAR,
titolo VARCHAR,
genere VARCHAR,
anno INTEGER CHECK (anno > 0 OR NULL));

CREATE TABLE partecipazione(
id_attore INTEGER REFERENCES persona(id_persona) ON DELETE CASCADE,
id_film INTEGER REFERENCES film(id_film) ON DELETE CASCADE,
ruolo VARCHAR NOT NULL
);

CREATE TABLE cinema(id_cinema INTEGER PRIMARY KEY,
nome VARCHAR NOT NULL,
indirizzo VARCHAR);

CREATE TABLE proiezione(
id_cinema INTEGER REFERENCES cinema(id_cinema) ON DELETE CASCADE,
id_film INTEGER REFERENCES film(id_film) ON DELETE CASCADE,
giorno TIMESTAMP NOT NULL
);

INSERT INTO cinema (id_cinema, nome, indirizzo) VALUES (02,'S.Angelo', 'Via Lucida 6 Perugia');
INSERT INTO cinema (id_cinema, nome, indirizzo) VALUES (01,'Zenith', 'Via Bonfigli 11 Perugia');
INSERT INTO cinema (id_cinema, nome, indirizzo) VALUES (03,'Multisala Clarici', 'Corso Cavour 84 Foligno');
INSERT INTO cinema (id_cinema, nome, indirizzo) VALUES (04,'Multiplex Giometti', 'Strada Centova Perugia');
