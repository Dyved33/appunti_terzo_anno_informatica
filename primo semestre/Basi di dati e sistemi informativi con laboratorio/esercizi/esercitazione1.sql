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
    anno       INTEGER CHECK (anno > 0) 
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

#1 contenuto della tabella persona
\d persona

#2 Selezionare i cognomi delle persone nella BD, senza eliminare i doppioni
SELECT cognome FROM persona;

#3 Selezionare i cognomi delle persone ordinati in ordine alfabetico, senza
eliminare i doppioni
SELECT cognome FROM persona ORDER BY cognome ASC;

#4 Definire l’insieme dei cognomi delle persone mantenute nella BD
SELECT DISTINCT cognome FROM persona;

#5 Selezionare le persone di nome John mantenute nella BD
SELECT DISTINCT * FROM persona WHERE nome='John';

#6 Selezionare i cognomi delle persone di nome John, mantenute nella BD
SELECT DISTINCT cognome FROM persona WHERE nome='John';

#7  Selezionare le persone mantenute nella BD che sono attori
SELECT DISTINCT id_persona, nome, cognome FROM persona, partecipazione WHERE id_persona=id_attore; 

#8 Definire la lista di tutte le interpretazioni, precisando il nome dell’attore, il cognome dell’attore, il ruolo interpretato ed il titolo del film
SELECT DISTINCT nome, cognome, ruolo, titolo FROM persona, partecipazione, film WHERE persona.id_persona = partecipazione.id_attore AND parteciazione.id_film = film.id_film;

#9 Definire la lista di tutte le interpretazioni, precisando il nome dell’attore, il cognome dell’attore, il ruolo interpretato ed il titolo del film
SELECT DISTINCT nome || ' ' || cognome || ' ha interpretato il ruolo di ' || ruolo || ' nel film ' || titolo FROM persona, partecipazione, film WHERE persona.id_persona = partecipazione.id_attore AND parteciazione.id_film = film.id_film; 

#10 Quali sono i titoli dei film di genere drammatico?
SELECT titolo FROM film WHERE genere = 'drammatico';

#11 Quali film (titoli) sono stati proiettati nel 2002?
SELECT titolo FROM film WHERE anno = '2007';

#12 Elencare i titoli dei film diretti da Lars von Trier
SELECT titolo FROM film,persona WHERE film.id_regista = persona.id_persona;

#13 Elencare i film (titoli) proiettati al cinema S. Angelo
SELECT DISTINCT titolo from film, proiezione, cinema WHERE film.id_film = proiezione.id_film AND proiezione.id_cinema = cinema.id_cinema AND cinema.nome = 'S.Angelo';

#14 Elencare i nomi ed i cognomi dei registi
SELECT DISTINCT nome, cognome FROM film, persona WHERE film.id_regista = persona.id_persona;

#15 Selezionare i nomi ed i cognomi degli attori
SELECT DISTINCT nome, cognome FROM partecipazione, persona WHERE partecipazione.id_attore = persona.id_persona;

#16 Selezionare i nomi ed i cognomi degli attori che sono anche registi
SELECT DISTINCT nome, cognome FROM partecipazione,film, persona WHERE partecipazione.id_attore = persona.id_persona AND persona.id_persona = film.id_regista;

#17 Quali attori hanno preso parte a film proiettati al cinema Zenith dopo l’anno 2000?
SELECT DISTINCT id_persona, nome, cognome FROM persona,partecipazione,cinema, proiezione WHERE persona.id_persona = partecipazione.id_attore AND partecipazione.id_film = proiezione.id_film AND cinema.id_cinema = proiezione.id_cinema AND cinema.nome = 'Zenith' AND proiezione.giorno > '2000-12-31';

#18 Quali sono i titoli dei film interpretati da Nicole Kidman che non sono stati proiettati al cinema Zenith?
SELECT DISTINCT titolo FROM film,partecipazione,persona WHERE persona.id_persona = partecipazione.id_attore AND persona.nome = 'Nicole' AND persona.cognome = 'Kidman' 
EXCEPT
SELECT titolo FROM film, proiezione, cinema WHERE film.id_film = proiezione.id_film AND proiezione.id_cinema = cinema.id_cinema AND cinema.name = 'Zenith';

#19 Quali sono i cognomi delle persone che contengono la lettera s?
SELECT DISTINCT cognome FROM persona WHERE LOWER(cognome) LIKE '%s%';

#20  Elencare i titoli dei film che contengono almeno tre e
SELECT DISTINCT titolo FROM film WHERE LOWER(titolo) LIKE '%e%e%e%';

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

    