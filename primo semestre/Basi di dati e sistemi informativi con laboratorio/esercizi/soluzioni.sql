-- ============================================================
-- ESERCITAZIONE 2 - Esercizio 1: BDcinema.sql
-- ============================================================
DROP TABLE IF EXISTS proiezione     CASCADE;
DROP TABLE IF EXISTS partecipazione CASCADE;
DROP TABLE IF EXISTS film           CASCADE;
DROP TABLE IF EXISTS cinema         CASCADE;
DROP TABLE IF EXISTS persona        CASCADE;

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

-- 1.b
INSERT INTO cinema (id_cinema, nome, indirizzo) VALUES
(2, 'S. Angelo',          'Via Lucida 6 Perugia'),
(1, 'Zenith',             'Via Bonfigli 11 Perugia'),
(3, 'Multisala Clarici',  'Corso Cavour 84 Foligno'),
(4, 'Multiplex Giometti', 'Strada Centova Perugia');

-- 1.c
SELECT * FROM cinema;

-- 1.d (da psql; ordine: persona, film, partecipazione, proiezione)
-- \copy persona        FROM 'persona.txt'
-- \copy film           FROM 'film.txt'
-- \copy partecipazione FROM 'partecipazione.txt'
-- \copy proiezione     FROM 'proiezione.txt'

-- 1.e  (le tuple collegate vengono gestite da SET NULL / CASCADE)
DELETE FROM persona WHERE nome = 'John' AND cognome = 'Travolta';

-- 1.f  verifica script:  \i BDcinema.sql


-- ============================================================
-- ESERCITAZIONE 2 - Esercizio 2: Europei2012
-- ============================================================
DROP SCHEMA IF EXISTS europei2012 CASCADE;
CREATE SCHEMA europei2012;
SET search_path TO europei2012;

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
    PRIMARY KEY (stadio, data),
    CHECK (squadra1 <> squadra2)
);

-- (verificare capienze, date di qualifica e spettatori su Wikipedia)
INSERT INTO stadio VALUES
('Stadion Narodowy',   'Varsavia', 56070),
('Stadion Miejski',    'Breslavia', 42771),
('Metalist Stadium',   'Charkiv',   38633),
('Arena Lviv',         'Leopoli',   34915);

INSERT INTO squadra VALUES
('Polonia',    'UEFA', '2007-04-18', NULL),
('Grecia',     'UEFA', '2011-10-11', NULL),
('Russia',     'UEFA', '2011-10-11', NULL),
('Rep. Ceca',  'UEFA', '2011-11-15', NULL),
('Paesi Bassi','UEFA', '2011-10-11', NULL),
('Danimarca',  'UEFA', '2011-10-11', NULL),
('Germania',   'UEFA', '2011-10-07', NULL),
('Portogallo', 'UEFA', '2011-11-15', NULL);

INSERT INTO partita VALUES
('Stadion Narodowy', '2012-06-08', 'Polonia',     'Grecia',     1, 1, 56070),
('Stadion Miejski',  '2012-06-08', 'Russia',      'Rep. Ceca',  4, 1, 40803),
('Metalist Stadium', '2012-06-09', 'Paesi Bassi', 'Danimarca',  0, 1, 35000),
('Arena Lviv',       '2012-06-09', 'Germania',    'Portogallo', 1, 0, 32990);

RESET search_path;


-- ============================================================
-- ESERCITAZIONE 3 - Interrogazioni
-- ============================================================
-- (1)
SELECT * FROM persona;

-- (2)
SELECT cognome FROM persona;

-- (3)
SELECT cognome FROM persona ORDER BY cognome;

-- (4)
SELECT DISTINCT cognome FROM persona;

-- (5)
SELECT * FROM persona WHERE nome = 'John';

-- (6)
SELECT cognome FROM persona WHERE nome = 'John';

-- (7)
SELECT DISTINCT p.*
FROM persona p JOIN partecipazione pa ON p.id_persona = pa.id_attore;

-- (8)
SELECT p.cognome, p.nome, pa.ruolo, f.titolo
FROM persona p
JOIN partecipazione pa ON p.id_persona = pa.id_attore
JOIN film f            ON f.id_film = pa.id_film;

-- (9)
SELECT p.nome || ' ' || p.cognome || ' ha interpretato il ruolo di '
       || pa.ruolo || ' nel film ' || f.titolo AS interpretazione
FROM persona p
JOIN partecipazione pa ON p.id_persona = pa.id_attore
JOIN film f            ON f.id_film = pa.id_film;

-- (10)
SELECT titolo FROM film WHERE genere ILIKE 'drammatico';

-- (11)
SELECT DISTINCT f.titolo
FROM film f JOIN proiezione pr ON f.id_film = pr.id_film
WHERE EXTRACT(YEAR FROM pr.giorno) = 2002;

-- (12)
SELECT f.titolo
FROM film f JOIN persona p ON f.id_regista = p.id_persona
WHERE p.nome = 'Lars' AND p.cognome = 'von Trier';

-- (13)
SELECT DISTINCT f.titolo
FROM film f
JOIN proiezione pr ON f.id_film = pr.id_film
JOIN cinema c      ON c.id_cinema = pr.id_cinema
WHERE c.nome = 'S. Angelo';

-- (14)
SELECT DISTINCT p.nome, p.cognome
FROM persona p JOIN film f ON f.id_regista = p.id_persona;

-- (15)
SELECT DISTINCT p.nome, p.cognome
FROM persona p JOIN partecipazione pa ON pa.id_attore = p.id_persona;

-- (16)
SELECT DISTINCT p.nome, p.cognome
FROM persona p
JOIN film f            ON f.id_regista = p.id_persona
JOIN partecipazione pa ON pa.id_attore = p.id_persona;

-- (17)
SELECT DISTINCT p.nome, p.cognome
FROM persona p
JOIN partecipazione pa ON pa.id_attore = p.id_persona
JOIN proiezione pr     ON pr.id_film = pa.id_film
JOIN cinema c          ON c.id_cinema = pr.id_cinema
WHERE c.nome = 'Zenith' AND EXTRACT(YEAR FROM pr.giorno) > 2000;

-- (18)
SELECT DISTINCT f.titolo
FROM film f
JOIN partecipazione pa ON pa.id_film = f.id_film
JOIN persona p         ON p.id_persona = pa.id_attore
WHERE p.nome = 'Nicole' AND p.cognome = 'Kidman'
  AND NOT EXISTS (
      SELECT 1
      FROM proiezione pr JOIN cinema c ON c.id_cinema = pr.id_cinema
      WHERE pr.id_film = f.id_film AND c.nome = 'Zenith'
  );

-- (19)
SELECT cognome FROM persona WHERE cognome ILIKE '%s%';

-- (20)
SELECT titolo FROM film WHERE titolo ~* '(e.*){3}';


-- ============================================================
-- MODELLO RELAZIONALE - Esercizio 1: BancaItalia
-- Assunzioni: numero conto unico a livello globale; Direttore e
-- Reggente sono dipendenti; ciclo Filiali<->Dipendenti risolto con ALTER.
-- ============================================================
CREATE TABLE Persone (
    CodiceFiscale CHAR(16) PRIMARY KEY,
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
    Direttore CHAR(16)
);
CREATE TABLE Dipendenti (
    CodiceFiscale CHAR(16) PRIMARY KEY REFERENCES Persone(CodiceFiscale),
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
    Titolare CHAR(16) REFERENCES Persone(CodiceFiscale),
    PRIMARY KEY (Conto, Titolare)
);


-- ============================================================
-- MODELLO RELAZIONALE - Esercizio 2: Ospedale
-- ============================================================
CREATE TABLE REPARTO (
    Nome       VARCHAR(50) PRIMARY KEY,
    Ubicazione VARCHAR(100),
    Primario   CHAR(16)
);
CREATE TABLE MEDICO (
    CodiceFiscale CHAR(16) PRIMARY KEY,
    Nome          VARCHAR(50) NOT NULL,
    Cognome       VARCHAR(50) NOT NULL,
    Reparto       VARCHAR(50) NOT NULL REFERENCES REPARTO(Nome)
);
ALTER TABLE REPARTO ADD FOREIGN KEY (Primario) REFERENCES MEDICO(CodiceFiscale);
CREATE TABLE STANZA (
    Numero  INTEGER CHECK (Numero >= 1),
    Reparto VARCHAR(50) REFERENCES REPARTO(Nome),
    PRIMARY KEY (Numero, Reparto)
);
CREATE TABLE LETTO (
    Numero  INTEGER CHECK (Numero >= 1),
    Stanza  INTEGER,
    Reparto VARCHAR(50),
    PRIMARY KEY (Numero, Stanza, Reparto),
    FOREIGN KEY (Stanza, Reparto) REFERENCES STANZA(Numero, Reparto)
);
CREATE TABLE PAZIENTE (
    NumeroTessera VARCHAR(20) PRIMARY KEY,
    CodiceFiscale CHAR(16) NOT NULL UNIQUE,
    Nome          VARCHAR(50) NOT NULL,
    Indirizzo     VARCHAR(100),
    Sesso         CHAR(1) CHECK (Sesso IN ('M','F'))
);
CREATE TABLE RICOVERO (
    Paziente        VARCHAR(20) REFERENCES PAZIENTE(NumeroTessera),
    DataAmmissione  DATE,
    DataDimissione  DATE,
    PRIMARY KEY (Paziente, DataAmmissione),
    CHECK (DataDimissione IS NULL OR DataDimissione >= DataAmmissione)
);
CREATE TABLE DEGENZA (
    Paziente           VARCHAR(20),
    AmmissionePaziente DATE,
    DataInizio         DATE,
    DataFine           DATE,
    Letto              INTEGER NOT NULL,
    Stanza             INTEGER NOT NULL,
    Reparto            VARCHAR(50) NOT NULL,
    PRIMARY KEY (Paziente, AmmissionePaziente, DataInizio),
    FOREIGN KEY (Paziente, AmmissionePaziente) REFERENCES RICOVERO(Paziente, DataAmmissione),
    FOREIGN KEY (Letto, Stanza, Reparto) REFERENCES LETTO(Numero, Stanza, Reparto),
    CHECK (DataFine IS NULL OR DataFine >= DataInizio)
);


-- ============================================================
-- MODELLO RELAZIONALE - Esercizio 3: Corsi / Indirizzi
-- ============================================================
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


-- ============================================================
-- MODELLO RELAZIONALE - Esercizio 4: Persone / Città / Ditte
-- Vincolo non esprimibile a schema: i periodi di HaAbitato (per la stessa
-- persona) non devono sovrapporsi; idem HaAvutoSede / HaLavorato
-- (da gestire con trigger o a livello applicativo).
-- ============================================================
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
    CapitaleSociale NUMERIC(14,2) CHECK (CapitaleSociale >= 0)
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

-- 4.3.1 istanza non valida (violazione integrità referenziale):
--   HaAbitato('RSSMRA80A01H501Z', 'Atlantide', 2000, 2005)  con 'Atlantide' non in Citta
-- 4.3.2 tupla che viola un vincolo di dominio:
--   Persona('RSSMRA80A01H501Z', 'Mario', 'Rossi', -5)       -- Eta < 0


-- ============================================================
-- MODELLO RELAZIONALE - Esercizio 5: Ordini
-- Assunzione: un ordine può avere più spedizioni da magazzini diversi.
-- ============================================================
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