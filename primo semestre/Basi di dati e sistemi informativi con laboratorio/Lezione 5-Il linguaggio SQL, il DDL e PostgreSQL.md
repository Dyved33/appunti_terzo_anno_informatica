# Il linguaggio SQL, il DDL e PostgreSQL

## Il linguaggio SQL

**SQL** (*structured query language*) è il linguaggio standard *de facto* e *de jure* per l'interazione con i sistemi di gestione di basi di dati relazionali (RDBMS).

**Origini e standardizzazione:**

- **1974:** nasce come **SEQUEL** (*structured English QUEry language*), sviluppato da Donald Chamberlin e Raymond Boyce presso i laboratori IBM Research nell'ambito del progetto prototipale **System R**.
- **1979:** Oracle Corporation (allora Relational Software Inc.) commercializza il primo RDBMS basato su SQL.
- **1981:** IBM lo segue con **SQL/DS**.
- **Dal 1983** è uno standard di fatto, recepito solo in parte dai vendor:
  - **1986 (SQL-86):** primo standard formale, ratificato da ANSI e, nel 1987, da ISO come **ISO 9075**.
  - **1992 (SQL-92 o SQL2):** standard ricco e articolato, base di riferimento per tutti i moderni motori relazionali.
  - **1999 (SQL-99 o SQL3):** estensione con funzionalità orientate agli oggetti (ORDBMS), trigger e tipi definiti dall'utente.
  - **2003 (SQL:2003):** supporto nativo a strutture dati XML e sequenze.

> [!info] Livelli di conformità dello standard SQL-92:
> Data la complessità dello standard sono stati definiti tre livelli incrementali di aderenza:
> 1. **Entry SQL:** livello base, abbastanza simile a SQL-89, supportato dalla totalità dei DBMS.
> 2. **Intermediate SQL:** supportato dalla maggior parte dei DBMS commerciali ed enterprise, include le funzionalità operative richieste dal mercato.
> 3. **Full SQL:** specifica avanzata completa; nessun sistema mette a disposizione tutte le funzionalità del linguaggio e i singoli vendor implementano dialetti proprietari ed estensioni non standard, che possono comportare leggere incompatibilità tra piattaforme e con i nuovi standard.

### I sottolinguaggi di SQL

1. **Data Definition Language (DDL):** definisce, modifica e rimuove schemi, tabelle, domini, viste e i relativi vincoli di integrità; istruzioni principali `CREATE`, `ALTER`, `DROP`, `RENAME`, `TRUNCATE`.
2. **Data Manipulation Language (DML):** interroga, inserisce, modifica e cancella i dati contenuti nella base di dati; istruzioni principali `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
3. **Data Control Language (DCL):** governa le politiche di sicurezza, l'accesso concorrente e i privilegi assegnati agli utenti della base di dati, con `GRANT` e `REVOKE`.
4. **Transaction Control Language (TCL):** governa l'esecuzione delle transazioni, garantendo il consolidamento o l'annullamento delle modifiche apportate alla base di dati, con `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `SET TRANSACTION`.
5. **Embedded SQL:** integra i comandi SQL in un linguaggio ospite, come C, C++, Java via JDBC/SQLJ o Python.

### L'architettura di un DBMS basato su SQL

Un DBMS basato su SQL è strutturato secondo un'architettura **client-server**:

- il **server DBMS** gestisce l'allocazione su memoria secondaria, il log delle transazioni, la sicurezza e l'esecuzione ottimizzata dei piani di interrogazione;
- il **client** stabilisce una connessione specificando l'utente e il database di destinazione su cui operare.

In coerenza con i fondamenti del modello relazionale, la base di dati è caratterizzata a livello intensionale dal proprio **schema** e a livello estensionale dall'**istanza corrente**, ed è descritta da un insieme di metadati, il **catalogo**, che conserva la definizione di tutti gli oggetti del database.

## Creare una base di dati: il DDL

### Il concetto di schema

Uno **schema** in SQL rappresenta un partizionamento logico della base di dati in namespace distinti e comunicanti, identificato da un nome: al seguito del nome uno schema può contenere un identificatore di autorizzazione che ne indica il proprietario, e definizioni di tabelle, domini, viste, privilegi, vincoli e funzioni. La creazione avviene mediante:

```sql
CREATE SCHEMA <nome_schema> [AUTHORIZATION <nome_proprietario>];
```

Qualora la clausola `AUTHORIZATION` venga omessa, il proprietario dello schema coincide per default con l'utente che ha eseguito il comando.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261002091155.png" width="450">
</div>

Il catalogo del DBMS memorizza le definizioni formali dei metadati articolati per schemi, ciascuno dei quali racchiude tabelle, viste, domini, vincoli e privilegi accessibili alle applicazioni.

Per fare riferimento a un oggetto situato dentro uno schema specifico si impiega la notazione qualificata con il punto, `<nome_schema>.<nome_oggetto>`:

```sql
CREATE DOMAIN Ditta.dom_stipendio AS NUMERIC(8, 2) CHECK (VALUE >= 900);
CREATE DOMAIN Ditta.dom_cod_impiegato AS VARCHAR(4);

CREATE TABLE Ditta.Impiegato (
    cod Ditta.dom_cod_impiegato PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    stipendio Ditta.dom_stipendio
);
```

Di solito lo schema in cui vengono dichiarati gli oggetti è specificato implicitamente dall'ambiente di esecuzione: in tal caso non è necessario qualificare i nomi.

> [!info] Schema predefinito in PostgreSQL:
> In PostgreSQL esiste uno schema di default denominato `public`: qualsiasi oggetto creato o referenziato senza specificare uno schema viene automaticamente associato a `public`.
> ```sql
> CREATE TABLE R (a CHAR PRIMARY KEY, b CHAR);
> -- Equivale a:
> CREATE TABLE public.R (a CHAR PRIMARY KEY, b CHAR);
> ```

> [!info] Convenzioni sintattiche:
> Nelle specifiche sintattiche standard: `[ ]` racchiude un contenuto **opzionale**; `< >` indica un segnaposto di **libera scelta** (per esempio il nome dello schema); `{ | }` indica una scelta esclusiva tra alternative disgiunte; `...` indica la possibilità di **ripetizione** dell'elemento precedente.

### La definizione delle tabelle

L'istruzione cardine del DDL è `CREATE TABLE`, che assolve a tre funzioni:

1. definisce uno schema di relazione;
2. crea un'istanza inizialmente vuota dello schema nel database;
3. specifica attributi, rispettivi domini, eventuali valori di default e l'insieme dei vincoli di integrità.

```sql
CREATE TABLE <nome_tabella> (
    <nome_colonna> <dominio> [DEFAULT <valore_default>] [<vincolo_colonna> ...]
    [, { <nome_colonna> <dominio> [DEFAULT <valore_default>] [<vincolo_colonna> ...] | <vincolo_tabella> } ...]
);
```

La clausola `DEFAULT` assegna un valore predefinito alla colonna nel caso in cui una tupla venga inserita omettendo il valore per quell'attributo.

> [!example] Creazione di una tabella semplice
> ```sql
> CREATE TABLE utente (
>     email VARCHAR(40) NOT NULL,
>     nome VARCHAR(30) NOT NULL,
>     cognome VARCHAR(30) NOT NULL,
>     anno_nascita INTEGER,
>     PRIMARY KEY (email)
> );
> ```

### I domini

I domini associabili alle colonne si suddividono in **domini elementari predefiniti** dallo standard SQL e **domini definiti dall'utente**.

**Domini elementari, stringhe di caratteri:**

| Dominio | Descrizione |
| :--- | :--- |
| `CHAR(n)` o `CHARACTER(n)` | Stringhe di testo a lunghezza fissa di $n$ caratteri; se la stringa inserita è più corta il sistema aggiunge spazi di riempimento (*padding*) in coda. |
| `CHAR` o `CHARACTER` | Sinonimo compatto di `CHAR(1)`. |
| `VARCHAR(n)` o `CHARACTER VARYING(n)` | Stringhe di testo a lunghezza variabile, al massimo $n$ caratteri, senza aggiunta di spazi in coda. |

**Domini numerici esatti**, che rappresentano valori interi o frazionari in notazione a virgola fissa, escludendo errori di arrotondamento binario:

| Dominio | Descrizione |
| :--- | :--- |
| `SMALLINT` | Intero su 2 byte (16 bit), intervallo $[-2^{15}, 2^{15}-1] = [-32768, 32767]$. |
| `INTEGER` (o `INT`) | Intero su 4 byte (32 bit), intervallo $[-2^{31}, 2^{31}-1] = [-2147483648, 2147483647]$. |
| `NUMERIC(prec, scala)` | Numero decimale a virgola fissa calcolato esattamente fino a 1000 cifre significative; `prec` è la precisione totale (numero complessivo di cifre significative) e `scala` il numero di cifre decimali dopo la virgola: `22.4454` ha precisione 6 e scala 4, gli interi presentano scala 0. |
| `DECIMAL(prec, scala)` (o `DEC`) | Analogo a `NUMERIC`, con l'implementazione che può consentire una precisione effettiva uguale o superiore a `prec`. |

**Domini numerici approssimati**, in notazione a virgola mobile ad ampio spettro:

| Dominio | Descrizione |
| :--- | :--- |
| `REAL` | Virgola mobile a precisione singola (4 byte), tipicamente nell'intervallo $[10^{-37}, 10^{37}]$ con almeno 6 cifre decimali di precisione. |
| `DOUBLE PRECISION` | Virgola mobile a doppia precisione (8 byte), tipicamente nell'intervallo $[10^{-307}, 10^{307}]$ con almeno 15 cifre decimali di precisione. |
| `FLOAT(prec)` | Virgola mobile in cui `prec` fissa la precisione minima richiesta in bit di mantissa binaria. |

**Domini temporali:**

| Dominio | Descrizione | Esempio formale |
| :--- | :--- | :--- |
| `DATE` | Data calendariale (anno, mese, giorno), formato canonico raccomandato ISO `'YYYY-MM-DD'`. | `'2026-10-02'` |
| `TIME` | Orario (ore, minuti, secondi). | `'14:30:00'` |
| `TIMESTAMP` | Data e orario congiunti, incluse le frazioni decimali di secondo. | `'2026-10-02 14:30:10.50'` |
| `INTERVAL` | Lasso (*span*) o intervallo temporale relativo. | `'1 day 12 hours 50 min'` |

**Domini booleani:**

| Dominio | Descrizione | Valori ammessi |
| :--- | :--- | :--- |
| `BOOLEAN` | Tipo logico con tre stati: `TRUE`, `FALSE` e assenza di valore `NULL`. Nello standard SQL il terzo stato è indicato come `UNKNOWN`, ma in PostgreSQL non esiste il letterale `UNKNOWN`: la terna incerta si ottiene con una condizione che può risultare `NULL`. | Letterali standard `TRUE` e `FALSE`; in PostgreSQL sono accettati anche `'t'`, `'f'`, `'true'`, `'false'`, `'1'`, `'0'`, `'yes'`, `'no'`. |

**Domini definiti dall'utente.** L'utente può formalizzare nuovi domini con vincoli e valori di default specifici tramite `CREATE DOMAIN`:

```sql
CREATE DOMAIN <nome_dominio> [AS] <tipo_base>
    [DEFAULT <valore_default>]
    [NOT NULL]
    [CONSTRAINT <nome_vincolo>] [CHECK (<condizione>)];
```

Nella clausola `CHECK` la parola chiave speciale **`VALUE`** indica il valore assunto dall'istanza del dato da validare.

> [!example] Domini definiti dall'utente
> ```sql
> -- Dominio per sigla provinciale (esattamente 2 caratteri non nulli)
> CREATE DOMAIN provincia AS CHAR(2) NOT NULL;
>
> -- Dominio per votazione universitaria d'esame
> CREATE DOMAIN voto AS INTEGER
>     CHECK (VALUE BETWEEN 18 AND 30);
>
> -- Dominio con vincoli multipli nominati
> CREATE DOMAIN nat_pari AS INTEGER
>     CONSTRAINT positivo CHECK (VALUE >= 0)
>     CONSTRAINT pari CHECK (VALUE % 2 = 0);
> ```

## I vincoli di integrità nel DDL

### Vincoli intrarelazionali

Impongono condizioni di consistenza valide all'interno della singola tabella:

1. **`NOT NULL`:** impedisce che all'attributo venga assegnato il valore speciale `NULL`; il dato deve essere obbligatoriamente specificato all'inserimento.
2. **`UNIQUE`:** impone che i valori dell'attributo, o dell'insieme di attributi, costituiscano una superchiave, vietando la presenza di tuple distinte con gli stessi valori non nulli. Su singolo attributo, `Matricola CHAR(6) UNIQUE` vieta matricole duplicate; su insieme di attributi, `UNIQUE(Nome, Cognome)` impone che non vi siano due righe con contemporaneamente lo stesso nome e lo stesso cognome, ammettendo però persone con lo stesso nome o con lo stesso cognome. Dichiarare invece `Nome VARCHAR(20) UNIQUE, Cognome VARCHAR(20) UNIQUE` vieterebbe sia la duplicazione del nome sia quella del cognome presi singolarmente.
3. **`PRIMARY KEY`:** dichiara la chiave primaria della tabella; ciascuna tabella ammette **una sola** chiave primaria, che per definizione implica le proprietà di unicità (`UNIQUE`) e non nullità (`NOT NULL`). Si può dichiarare inline su singola colonna, `matricola CHAR(6) PRIMARY KEY`, oppure a livello di tabella per una chiave composta, `PRIMARY KEY(Nome, Cognome)`.
4. **`CHECK (<condizione>)`:** impone un predicato booleano generico che ogni tupla deve verificare.

Sintassi dei vincoli di colonna:

```sql
[CONSTRAINT <nome_vincolo>] { NOT NULL | UNIQUE | PRIMARY KEY | CHECK (<condizione>) }
```

Sintassi dei vincoli di tabella:

```sql
[CONSTRAINT <nome_vincolo>] { PRIMARY KEY (<colonna> [, ...]) | UNIQUE (<colonna> [, ...]) | CHECK (<condizione>) }
```

> [!example] Vincoli intrarelazionali di colonna e di tabella
> ```sql
> CREATE TABLE Impiegato (
>     matricola CHAR(6) PRIMARY KEY,
>     nome VARCHAR(20) NOT NULL,
>     cognome VARCHAR(20) NOT NULL,
>     stipendio NUMERIC(8, 2) DEFAULT 1000,
>     CONSTRAINT impiegato_univoco UNIQUE (cognome, nome),
>     CONSTRAINT stipendio_minimo CHECK (stipendio >= 1000)
> );
> ```

### Vincoli interrelazionali: integrità referenziale

Stabiliscono relazioni di coerenza tra schemi distinti, collegando una **tabella referente (interna)** a una **tabella referenziata (esterna)** mediante il concetto di **chiave esterna** (*foreign key*).

*Semantica del vincolo:* per ogni tupla della tabella interna, i valori non nulli presenti negli attributi di chiave esterna devono esistere identici come valori di chiave primaria o superchiave (`UNIQUE`) nella tabella esterna.

> [!important] Unicità sulla tabella esterna:
> L'attributo referenziato della tabella esterna **deve** essere obbligatoriamente dichiarato come `PRIMARY KEY` o come `UNIQUE`.

SQL fornisce due costrutti complementari:

1. **Costrutto `REFERENCES`, vincolo di colonna:** impiegato quando la chiave esterna è definita su un singolo attributo.

```sql
<nome_colonna> <tipo_dato> REFERENCES <tabella_esterna>(<colonna_esterna>)
```

2. **Costrutto `FOREIGN KEY ... REFERENCES`, vincolo di tabella:** impiegato per chiavi esterne composte da più attributi o per attribuire un nome esplicito al vincolo.

```sql
[CONSTRAINT <nome_vincolo>] FOREIGN KEY (<colonna_1>, <colonna_2>)
    REFERENCES <tabella_esterna>(<colonna_1_est>, <colonna_2_est>)
```

> [!example] Costrutto `REFERENCES` su singola colonna
> ```sql
> CREATE TABLE dipartimento (
>     nome_dip VARCHAR(15) PRIMARY KEY,
>     sede VARCHAR(20) NOT NULL
> );
>
> CREATE TABLE impiegato (
>     matricola CHAR(6) PRIMARY KEY,
>     nome VARCHAR(20) NOT NULL,
>     cognome VARCHAR(20) NOT NULL,
>     nome_dpt VARCHAR(15) REFERENCES dipartimento(nome_dip)
> );
> ```

> [!example] Costrutto `FOREIGN KEY` su insieme di attributi
> ```sql
> CREATE TABLE anagrafica (
>     codice_fiscale CHAR(16) PRIMARY KEY,
>     nome VARCHAR(20) NOT NULL,
>     cognome VARCHAR(20) NOT NULL,
>     UNIQUE (nome, cognome)
> );
>
> CREATE TABLE impiegato (
>     matricola CHAR(6) PRIMARY KEY,
>     nome VARCHAR(20) NOT NULL,
>     cognome VARCHAR(20) NOT NULL,
>     nome_dpt VARCHAR(15) REFERENCES dipartimento(nome_dip),
>     FOREIGN KEY (nome, cognome) REFERENCES anagrafica(nome, cognome)
> );
> ```

## PostgreSQL e il client `psql`

**PostgreSQL** è un sistema di gestione di basi di dati relazionale a oggetti (**ORDBMS**) open source tra i più avanzati al mondo, derivato dal progetto di ricerca *Postgres* avviato nel 1986 presso l'Università della California a Berkeley. La comunicazione e l'elaborazione dei dati avvengono tra il motore server e i diversi client applicativi tramite protocolli di rete standard.

`psql` è il client a riga di comando distribuito nativamente con PostgreSQL: permette l'interazione diretta con il server e l'amministrazione completa delle istanze. La sintassi di accesso da shell è:

```bash
psql -U <nome_utente> -h <hostname> -p <porta> -d <database>
```

All'avvio della sessione fornisce i comandi primari di consultazione: `\h` per la guida in linea sulla sintassi dei comandi SQL, `\?` per la guida in linea sui meta-comandi interni (*slash commands*) e `\q` per uscire dalla sessione.

| Comando slash | Descrizione e funzionalità |
| :--- | :--- |
| `\l` | Elenca tutti i database presenti nel cluster. |
| `\c[onnect] [nomedb [utente]]` | Commuta la connessione verso un nuovo database, opzionalmente con un altro utente. |
| `\d` | Elenca le relazioni (tabelle, viste, sequenze) presenti nello schema corrente. |
| `\d <tabella>` | Descrive dettagliatamente la struttura della tabella: colonne, tipi, modificatori, indici e vincoli. |
| `\dt` | Elenca esclusivamente le tabelle. |
| `\dv` | Elenca le viste (*views*). |
| `\di` | Elenca gli indici. |
| `\ds` | Elenca le sequenze. |
| `\dT` | Elenca i tipi di dato. |
| `\dD` | Elenca i domini definiti. |
| `\df` | Elenca le funzioni memorizzate. |
| `\do` | Elenca gli operatori disponibili. |
| `\da` | Elenca le funzioni di aggregazione. |
| `\dp` (o `\z`) | Mostra i privilegi e i permessi di accesso assegnati alle tabelle. |
| `\dd [oggetto]` | Mostra la documentazione e i commenti associati all'oggetto. |
| `\e [file]` | Apre l'editor esterno di sistema per modificare il buffer della query corrente o il file specificato. |
| `\i <file>` | Legge ed esegue i comandi SQL contenuti nel file indicato (*script execution*). |
| `\p` | Visualizza il contenuto del buffer della query corrente. |
| `\r` | Cancella il contenuto del buffer della query. |
| `\g [file]` | Invia la query al server e scrive opzionalmente i risultati nel file indicato. |
| `\o [file]` | Reindirizza tutti i risultati delle query successive nel file indicato. |
| `\s [file]` | Stampa la cronologia dei comandi eseguiti e consente di salvarla su file. |
| `\x` | Attiva o disattiva l'output esteso, con i record mostrati colonna per colonna in verticale. |
| `\a` | Attiva o disattiva l'allineamento delle colonne nelle tabelle di output. |
| `\t` | Attiva o disattiva la modalità solo tuple, che omette intestazioni di colonna e conteggi finali. |
| `\H` | Attiva o disattiva la formattazione tabellare HTML. |
| `\! [comando]` | Esegue un comando nella shell del sistema operativo ospite senza chiudere `psql`. |

**Estensioni di PostgreSQL rispetto allo standard:**

- *Tipi carattere:* `VARCHAR` senza specificare la lunghezza massima $n$ supporta stringhe di lunghezza arbitraria; `TEXT` è il tipo nativo ottimizzato per stringhe di lunghezza indefinita, fino a 1 GB.
- *Tipi interi:* `BIGINT` è un intero a 8 byte (64 bit), con intervallo $[-2^{63}, 2^{63}-1]$.
- *Tipi decimali:* `NUMERIC` e `DECIMAL` sono sinonimi perfetti e memorizzano numeri decimali fino alla massima precisione consentita, senza forzare una scala obbligatoria.
- *Tipi in virgola mobile:* `FLOAT(1)` fino a `FLOAT(24)` equivale nativamente a `REAL` (4 byte); `FLOAT(25)` fino a `FLOAT(53)` equivale nativamente a `DOUBLE PRECISION` (8 byte).

## L'esempio completo di DDL

Modellazione di una base di dati per la gestione di un'anagrafica di persone e dei rispettivi legami di parentela genitore-figlio. Lo schema è costituito da due tabelle:

1. **`persone(id, nome, reddito, eta, sesso)`**
   - `id`: stringa di 2 caratteri, **chiave primaria**;
   - `nome`: stringa di 20 caratteri con `NOT NULL`;
   - `reddito`: valore intero in migliaia di euro, con `DEFAULT 0`;
   - `eta`: intero a 2 byte (`SMALLINT`) con `CHECK (eta < 200)`;
   - `sesso`: singolo carattere (`CHAR`), vincolato ai soli valori `'M'` o `'F'`, con `CHECK (sesso = 'M' OR sesso = 'F')`.
2. **`genitori(figlio, genitore)`**
   - `figlio`: stringa di 2 caratteri, **chiave esterna** referenziante `persone(id)`;
   - `genitore`: stringa di 2 caratteri, **chiave esterna** referenziante `persone(id)`;
   - **chiave primaria composta** dalla coppia `(figlio, genitore)`.

```sql
-- Creazione della tabella delle persone con vincoli intrarelazionali
CREATE TABLE persone (
    id CHAR(2) PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    reddito INT DEFAULT 0,
    eta SMALLINT,
    sesso CHAR CHECK (sesso = 'M' OR sesso = 'F'),
    CONSTRAINT vincolo_eta CHECK (eta >= 0 AND eta < 200)
);

-- Creazione della tabella delle relazioni di parentela con chiavi esterne e chiave primaria composta
CREATE TABLE genitori (
    figlio CHAR(2) REFERENCES persone(id),
    genitore CHAR(2) REFERENCES persone(id),
    PRIMARY KEY (figlio, genitore)
);
```

> [!info] Sintesi:
> - SQL nasce da SEQUEL (IBM, 1974) ed è standard *de facto* dal 1983: SQL-86, SQL-92, SQL-99 e SQL:2003; SQL-92 ha tre livelli di aderenza (Entry, Intermediate, Full).
> - SQL comprende DDL, DML, DCL, TCL ed embedded SQL, e si usa su un'architettura client-server in cui schema, istanza e catalogo caratterizzano la base di dati.
> - `CREATE SCHEMA` partiziona logicamente la base di dati e si crea con `AUTHORIZATION`; in PostgreSQL gli oggetti non qualificati finiscono in `public`.
> - `CREATE TABLE` definisce schema, istanza vuota, attributi, domini, default e vincoli; `CREATE DOMAIN` definisce domini utente e in `CHECK` il valore da validare si indica con `VALUE`.
> - I vincoli intrarelazionali sono `NOT NULL`, `UNIQUE`, `PRIMARY KEY` e `CHECK`; quelli interrelazionali sono le chiavi esterne, con `REFERENCES` su colonna e `FOREIGN KEY` su tabella, e l'attributo referenziato deve essere `PRIMARY KEY` o `UNIQUE`.
> - `psql` è il client a riga di comando di PostgreSQL, con i meta-comandi `\d`, `\dt`, `\l`, `\i`, `\g`, `\x`; PostgreSQL è un ORDBMS open source nato da *Postgres* (Berkeley, 1977).