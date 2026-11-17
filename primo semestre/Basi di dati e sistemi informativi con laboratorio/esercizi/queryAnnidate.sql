DROP SCHEMA IF EXISTS Biblioteca CASCADE;
CREATE SCHEMA Biblioteca;
SET search_path TO Biblioteca;

CREATE TABLE Scrittore(
	nome VARCHAR(30) PRIMARY KEY,
	sesso CHAR(1) CHECK (sesso IN ('M', 'F')),
	nazione VARCHAR(30)
);

CREATE TABLE Genere(
	nome VARCHAR(20) PRIMARY KEY,
	sala CHAR(1)
);

CREATE TABLE Libro(
	ISBN CHAR(13) PRIMARY KEY,
	titolo VARCHAR(50),
	autore VARCHAR(30) REFERENCES Scrittore(nome) ON DELETE RESTRICT,
	genere VARCHAR(20) REFERENCES Genere(nome)
);

CREATE TABLE Socio(
	idSocio CHAR(9) PRIMARY KEY,
	nome VARCHAR(30),
	sesso CHAR(1) CHECK (sesso IN ('M', 'F')),
	eta INTEGER
);

CREATE TABLE HaLetto(
	socio CHAR(9) REFERENCES Socio(idSocio) ON UPDATE CASCADE ON DELETE CASCADE,
	ISBN CHAR(13) REFERENCES Libro(ISBN) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (ISBN, socio)
);

-- 1. determinare gli autori dei libri il cui titolo precede in ordine alfabetico il titolo del libro con ISBN'88-55-55555-5'
SELECT Biblioteca.scrittore.nome 
FROM Biblioteca.scrittore
JOIN Biblioteca.libro ON Biblioteca.libro.autore = Biblioteca.scrittore.nome
WHERE Biblioteca.libro.titolo < (
    SELECT Biblioteca.libro.titolo
    FROM Biblioteca.libro
    WHERE Biblioteca.libro.ISBN = '88-55-55555-5'
);

-- 2. determinare, per ogni socio, il numero di libri letti, includendo i soci che non hannno letto alcun libro
SELECT Biblioteca.socio.idsocio, Biblioteca.socio.nome, COUNT(Biblioteca.haletto.ISBN) AS letti
FROM Biblioteca.socio
LEFT OUTER JOIN Biblioteca.haletto ON Biblioteca.socio.idsocio = Biblioteca.haletto.socio
GROUP BY Biblioteca.socio.idsocio, Biblioteca.socio.nome;

-- 3. determinare gli autori di cui è presente il massimo numero di libri
SELECT Biblioteca.libro.autore, COUNT(*) AS num
FROM Libro
GROUP BY autore
HAVING COUNT(*) = (
    SELECT MAX(num)
    FROM (
        SELECT COUNT(*) AS num
        FROM Libro
        GROUP BY autore
    ) 
);

-- 4. determinare i nomi delle coppie di soci che hanno letto uno stesso libro
SELECT DISTINCT s1.nome AS socio1, s2.nome AS socio2
FROM Biblioteca.haletto h1
JOIN Biblioteca.haletto h2 ON h1.ISBN = h2.ISBN AND h1.socio < h2.socio
JOIN Biblioteca.socio s1 ON h1.socio = s1.idSocio
JOIN Biblioteca.socio s2 ON h2.socio = s2.idSocio;