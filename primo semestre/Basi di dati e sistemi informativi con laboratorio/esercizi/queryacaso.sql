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

-- 1. Definire la lista degli attori (nome e cognome) ed il numero di film interpretati, ordinando il risultato in ordine alfabetico rispetto al cognome
SELECT p.nome, p.cognome, COUNT(pa.id_film) AS numero_film
FROM persona p
JOIN partecipazione pa ON p.id_persona = pa.id_attore
GROUP BY p.id_persona, p.nome, p.cognome
ORDER BY p.cognome ASC, p.nome ASC;

-- 2. Modificare il risultato della query precedente per tenere conto solo degli attori che hanno interpretato almeno 2 film
SELECT p.nome, p.cognome, COUNT(pa.id_film) AS numero_film
FROM persona p
JOIN partecipazione pa ON p.id_persona = pa.id_attore
GROUP BY p.id_persona, p.nome, p.cognome
HAVING COUNT(pa.id_film) >= 2
ORDER BY p.cognome ASC, p.nome ASC;

-- 3. Modificare la prima query in modo da aggiungere al risultato due colonne per specificare: l'anno di produzione del primo film interpretato e l'anno di produzione dell'ultimo film interpretato
SELECT p.nome, p.cognome, COUNT(pa.id_film) AS numero_film, MIN(f.anno) AS anno_primo_film, MAX(f.anno) AS anno_ultimo_film
FROM persona p
JOIN partecipazione pa ON p.id_persona = pa.id_attore
JOIN film f ON pa.id_film = f.id_film
GROUP BY p.id_persona, p.nome, p.cognome
ORDER BY p.cognome ASC, p.nome ASC;

-- 4. Elencare il numero di film diretti da ogni regista
SELECT p.nome, p.cognome, COUNT(f.id_film) AS numero_film_diretti
FROM persona p
JOIN film f ON p.id_persona = f.id_regista
GROUP BY p.id_persona, p.nome, p.cognome;

-- 5. Elencare gli attori (nome e cognome) che hanno interpretato film drammatici e per ognuno di tali attori precisare il numero di film drammatici interpretati
SELECT p.nome, p.cognome, COUNT(pa.id_film) AS numero_film_drammatici
FROM persona p
JOIN partecipazione pa ON p.id_persona = pa.id_attore
JOIN film f ON pa.id_film = f.id_film
WHERE f.genere = 'Drammatico'
GROUP BY p.id_persona, p.nome, p.cognome;
