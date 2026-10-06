# Cancellazione e aggiornamento di una BD, il DML e le politiche di reazione

## Cancellazione di schemi, tabelle e domini

Accanto ai comandi `CREATE` visti nel [[Lezione 5-Il linguaggio SQL, il DDL e PostgreSQL|DDL di SQL]], il linguaggio offre i comandi `DROP` per cancellare gli oggetti dello schema. Ciascuno accetta le stesse due opzioni opzionali: `RESTRICT` e `CASCADE`.

**Soppressione di uno schema:**

```sql
DROP SCHEMA <nome_schema> [{CASCADE | RESTRICT}];
```

- `RESTRICT`: lo schema viene eliminato solo se vuoto, ovvero se non contiene alcuna definizione di tabelle, domini o altri oggetti (default);
- `CASCADE`: vengono cancellati sia lo schema sia tutto ciò che contiene.

**Soppressione di una tabella:**

```sql
DROP TABLE <nome_tabella> [{CASCADE | RESTRICT}];
```

- `CASCADE`: gli oggetti che dipendono dalla tabella (vincoli, viste…) vengono cancellati automaticamente;
- `RESTRICT`: la tabella non può essere cancellata se esistono oggetti dipendenti nella base di dati (default).

> [!example] Esempi di `DROP TABLE`
> Si consideri lo schema relazionale visto nella lezione precedente dell'esercitazione:
> ```
> persona(idpersona, codicefiscale, nome, cognome, datanascita)
> corso(idcorso, idinsegnante, sigla, crediti, descrizione)
> frequenza(idstudente, idcorso, voto)
> ```
> dove `idstudente` ed `idcorso` sono chiavi esterne su `persona` e `corso`.
>
> Il comando `DROP TABLE corso;` porta a un errore perché la tabella `frequenza` dipende dalla tabella `corso`.
>
> Il comando `DROP TABLE corso CASCADE;` porta all'effettiva cancellazione della tabella `corso`; la tabella `frequenza` non viene cancellata, ma vengono soppressi i vincoli di chiave esterna su `corso` in `frequenza`.

**Soppressione di un dominio:**

```sql
DROP DOMAIN <nome_dominio> [{CASCADE | RESTRICT}];
```

- `RESTRICT`: il dominio viene eliminato solo se non è utilizzato nella definizione di alcun altro oggetto dello schema logico (default);
- `CASCADE`: viene eliminato il dominio e vengono modificate le definizioni di ogni colonna che lo utilizza:
  - il tipo della colonna diventa quello espresso dalla definizione del dominio;
  - alla colonna viene dato l'eventuale valore di default del dominio;
  - i vincoli di integrità del dominio diventano vincoli di colonna.

## Aggiornamento di tabelle e domini

**Sintassi generale di `ALTER TABLE`:**

```sql
ALTER TABLE <nome_tabella> {
  ADD [COLUMN] <nome_col> <dominio> [<vincolo_col> [...]] |
  DROP [COLUMN] <nome_col> [{CASCADE | RESTRICT}] |
  ALTER [COLUMN] <nome_col> SET DEFAULT <valore> |
  ALTER [COLUMN] <nome_col> DROP DEFAULT |
  ADD CONSTRAINT <vincolo_tab> |
  DROP CONSTRAINT <nome_vincolo> [{CASCADE | RESTRICT}]
}
```

*Aggiunta di colonne:*

```sql
ALTER TABLE <nome_tabella>
  ADD [COLUMN] <nome_col> <dominio> [<vincolo_col> [...]];
```

> [!example] Aggiunta di colonne
> ```sql
> -- Aggiungere l'attributo sesso alla tabella persona
> ALTER TABLE persona ADD COLUMN sesso CHAR;
>
> -- Se si aggiunge un attributo con vincolo NOT NULL bisogna prevedere un valore
> -- di default, che il sistema aggiungerà automaticamente a tutte le tuple già presenti
> ALTER TABLE persona
>   ADD COLUMN istruzione CHAR(10)
>   NOT NULL DEFAULT 'diploma';
> ```

*Soppressione di colonne:*

```sql
ALTER TABLE <nome_tabella>
  DROP [COLUMN] <nome_col> [{CASCADE | RESTRICT}];
```

> [!example] Rimozione di una colonna
> ```sql
> ALTER TABLE persona DROP COLUMN sesso;
> ```
> I parametri opzionali `RESTRICT` (default) e `CASCADE` indicano come comportarsi in caso di dipendenze.

*Modifica dei valori di default:*

```sql
ALTER TABLE <nome_tabella>
  {ALTER [COLUMN] <nome_col> SET DEFAULT <valore> |
   ALTER [COLUMN] <nome_col> DROP DEFAULT};
```

> [!example] Valore di default
> ```sql
> -- Per l'attributo sesso inserire come valore di default 'F'
> ALTER TABLE persona ALTER COLUMN sesso
>   SET DEFAULT 'F';
> ```

*Aggiunta di vincoli:*

```sql
ALTER TABLE <nome_tabella> ADD CONSTRAINT <def_vincolo>;
```

> [!example] Vincolo di controllo
> ```sql
> ALTER TABLE corso
>   ADD CONSTRAINT creditoMax CHECK (crediti ≤ 12);
> ```

*Cancellazione di vincoli:*

> [!example] Cancellazione di vincoli
> ```sql
> ALTER TABLE corso DROP CONSTRAINT creditoMax;
>
> ALTER TABLE persona DROP UNIQUE (nome, cognome);
> ```

*Estensioni PostgreSQL:* la rinomina di colonne e la rinomina di tabella sono estensioni di PostgreSQL allo standard SQL:

```sql
ALTER TABLE <nome_tab> RENAME COLUMN <nome1> TO <nome2>;
ALTER TABLE <nome_tab> RENAME TO <nome>;
```

**Modifica di un dominio:** `ALTER DOMAIN` consente di modificare default e vincoli di un dominio definito dall'utente:

```sql
ALTER DOMAIN <nome_dominio> {
  SET <clausola_default> |
  DROP DEFAULT |
  ADD <vincolo_dominio> |
  DROP <vincolo_dominio>
}
```

## Il DML: inserimento, cancellazione e modifica di tuple

Il **Data Manipulation Language (DML)** è l'insieme delle istruzioni di SQL che operano sui dati contenuti nella base di dati. Si dividono in istruzioni di *modifica* e di *interrogazione*:

- `INSERT`: inserisce nuove tuple nel DB;
- `UPDATE`: modifica tuple del DB;
- `DELETE`: cancella tuple del DB;
- `SELECT`: esegue interrogazioni (query) sul DB (interrogazione).

> [!warning] Attenzione:
> Nella slide 16 le descrizioni di `UPDATE` e `DELETE` sono scambiate ("UPDATE: Cancella", "DELETE: Modifica"); qui sopra c'è la semantica corretta.

**Inserimento di tuple:**

```sql
INSERT INTO <nome_tab> [(<nome_col> [, ...])]
VALUES [(<valori> [, ...])];
```

- la lista dei valori `(<valori> [, ...])` deve corrispondere con la lista delle colonne `(<nome_col> [, ...])`;
- la lista degli attributi si può omettere, nel qual caso vale l'ordine con cui sono stati definiti;
- le parole chiave `DEFAULT` e `NULL` possono prendere il posto di `<valori>`;
- se la lista non include tutti gli attributi, i restanti assumono valore `NULL` o il valore di default (se specificato).

> [!example] Inserimento nella tabella `prodotto(cod, nome, prezzo)`
> I nomi degli attributi possono essere omessi se si conosce l'ordine. Le due espressioni sono equivalenti:
> ```sql
> INSERT INTO prodotto(cod, prezzo, nome) VALUES (123, 3.40, 'pc');
> INSERT INTO prodotto VALUES (123, 'pc', 3.40);
> ```
> Se alcuni valori sono nulli, possono essere omessi. Le due espressioni sono equivalenti:
> ```sql
> INSERT INTO prodotto VALUES (123, 3.40);
> INSERT INTO prodotto VALUES (123, 3.40, NULL);
> ```

**Inserimento di tuple via query:** è anche possibile inserire in una tabella delle tuple che provengono dal risultato di una query:

```sql
INSERT INTO <nome_tab> [(<nome_col> [, ...])]
VALUES <select_query>;
```

La scrittura di una query mediante il costrutto `SELECT` del DML sarà trattata più avanti.

**Cancellazione di tuple:**

```sql
DELETE FROM <nome_tab> [WHERE <predicato>];
```

- l'istruzione `DELETE` può far uso di una condizione per specificare le tuple da cancellare;
- tutte le tuple per cui il predicato `<predicato>` ha valore vero vengono cancellate;
- in assenza della clausola `WHERE` vengono eliminate tutte le tuple della tabella a cui si fa riferimento.

> [!example] Cancellazione di tuple
> - Eliminare dall'iscrizione a un determinato corso gli studenti che non hanno ottenuto un voto pari almeno a 10:
> ```sql
> DELETE FROM frequenza
> WHERE voto IS NOT NULL AND voto < 10;
> ```
> - Eliminare i corsi con meno di tre crediti:
> ```sql
> DELETE FROM corso WHERE crediti < 3;
> ```
> Che succede se la cancellazione porta a violare il vincolo di integrità referenziale, per esempio agli studenti che frequentavano i corsi con meno di tre crediti? Lo vediamo con le politiche di reazione.

**Aggiornamento di tuple:**

```sql
UPDATE <nome_tab>
SET <nome_col> = {<espressione> | <select_query>} [, ...]
WHERE <predicato>;
```

- i valori delle colonne specificate sono modificati in tutte le tuple che soddisfano il predicato `<predicato>`;
- `<espressione>` può far riferimento ai valori attuali delle tuple in via di modifica;
- le parole chiave `NULL` e `DEFAULT` costituiscono espressioni valide.

> [!example] Aggiornamento di tuple
> Aggiungere un punto a tutti i voti nella tabella `frequenza`:
> ```sql
> UPDATE frequenza
> SET voto = voto + 1 WHERE voto IS NOT NULL;
> ```
> Anche l'`UPDATE` può portare a violare vincoli di integrità referenziale.

## Politiche di reazione

**Violazione dei vincoli e politiche di reazione:** anziché lasciare al programmatore il compito di garantire che, a fronte di cancellazioni e modifiche della base di dati, i vincoli di [[Lezione 4-Vincoli di integrità nel modello relazionale|integrità referenziale]] siano rispettati, si possono specificare opportune **politiche di reazione** in fase di definizione degli schemi.

> [!example] Tabelle interna ed esterna
> Tabella interna `impiegato`:
>
> | matricola | nome | cognome | dipartimento |
> | :--- | :--- | :--- | :--- |
> | A0001 | Romolo | Neri | Acquisti |
> | A0002 | Remo | Bianchi | Vendite |
>
> Tabella esterna `dipartimento`:
>
> | nome_dipartimento | sede | telefono |
> | :--- | :--- | :--- |
> | Acquisti | Roma | NULL |
> | Vendite | Perugia | 075558767 |

**Violazioni operando sulla tabella interna:** si possono introdurre violazioni modificando il contenuto della tabella interna in due modi:

- modificando il valore dell'attributo referente;
- inserendo una nuova tupla.

Per queste operazioni SQL non offre alcun supporto: le operazioni vengono semplicemente impedite.

> [!example] Inserimento che causa violazione
> | matricola | nome | cognome | dipartimento |
> | :--- | :--- | :--- | :--- |
> | A0001 | Romolo | Neri | Acquisti |
> | A0002 | Remo | Bianchi | Vendite |
> | A003 | Caligola | Verdi | Marketing |
>
> `Marketing` non esiste nella tabella esterna: l'inserimento viene impedito.

**Violazioni operando sulla tabella esterna:** per rispondere alle violazioni generate da modifiche sulla tabella esterna (o tabella *master*) esistono diverse alternative: la tabella interna (o *slave*) deve adeguarsi alle modifiche che avvengono nella tabella master. Le violazioni possono avvenire per:

- modifiche dell'attributo riferito;
- cancellazione di tuple nella tabella master.

**Politiche di reazione per la modifica dell'attributo riferito.** Nei tre esempi seguenti la modifica è la stessa: nella tabella esterna l'attributo `nome_dipartimento` assume il nuovo valore `VenditeSuccursale` al posto di `Vendite`.

*Cascade:* la politica cascade prevede che, in caso di modifica dell'attributo riferito, il nuovo valore dell'attributo della tabella esterna venga riportato su tutte le corrispondenti righe della tabella interna.

> [!example] Politica cascade
> | matricola | nome | cognome | dipartimento |
> | :--- | :--- | :--- | :--- |
> | A0001 | Romolo | Neri | Acquisti |
> | A0002 | Remo | Bianchi | VenditeSuccursale |

*Set null:* la politica set null prevede che, in caso di modifica dell'attributo riferito, all'attributo referente (nella tabella interna) venga assegnato valore nullo al posto del valore modificato nella tabella esterna.

> [!example] Politica set null
> | matricola | nome | cognome | dipartimento |
> | :--- | :--- | :--- | :--- |
> | A0001 | Romolo | Neri | Acquisti |
> | A0002 | Remo | Bianchi | NULL |

*Set default:* la politica set default prevede che, in caso di modifica dell'attributo riferito, all'attributo referente (nella tabella interna) venga assegnato un valore di default al posto del valore modificato nella tabella esterna.

> [!example] Politica set default
> | matricola | nome | cognome | dipartimento |
> | :--- | :--- | :--- | :--- |
> | A0001 | Romolo | Neri | Acquisti |
> | A0002 | Remo | Bianchi | TBA |

*No action:* la politica no action prevede che, in caso di modifica dell'attributo riferito, il sistema non inneschi alcuna reazione speciale. Questo è il valore di default e corrisponde semplicemente a rifiutare modifiche sui dati che portano alla violazione dell'integrità referenziale.

**Politiche di reazione per la cancellazione di tuple nella tabella esterna:** SQL mette a disposizione le stesse politiche di reazione:

- *cascade:* tutte le righe della tabella interna corrispondenti alla riga cancellata vengono cancellate;
- *set null:* all'attributo referente viene assegnato il valore nullo al posto del valore presente nella riga cancellata dalla tabella esterna;
- *set default:* all'attributo referente viene assegnato un valore di default al posto del valore presente nella riga cancellata dalla tabella esterna;
- *no action:* il sistema non innesca alcuna azione speciale; è il valore di default e corrisponde semplicemente a rifiutare cancellazioni sui dati che violino l'integrità referenziale.

**Definizione dei vincoli interrelazionali e specifica delle politiche di reazione:** la politica scelta si scrive nella definizione del vincolo di integrità, in una clausola di tipo `ON DELETE` (per le cancellazioni) oppure `ON UPDATE` (per gli aggiornamenti).

Vincolo interrelazionale di colonna:

```sql
REFERENCES <nome_tab> [<nome_col>]
[{ON DELETE | ON UPDATE}
 {NO ACTION | CASCADE | SET NULL | SET DEFAULT}]
```

Vincolo interrelazionale di tabella:

```sql
FOREIGN KEY (<nome_col> [, ...])
REFERENCES <nome_tab> (<nome_col> [, ...])
[{ON DELETE | ON UPDATE}
 {NO ACTION | CASCADE | SET NULL | SET DEFAULT}]
```

## Lo script completo in PostgreSQL

A titolo di ricapitolazione, script per la generazione in PostgreSQL della base di dati corrispondente allo schema relazionale `persona` / `corso` / `frequenza` introdotto nell'esercitazione precedente. In particolare:

- lo script prevede la cancellazione preventiva dalla base di dati delle tabelle `persona`, `corso`, `frequenza`, se presenti;
- si definiscono opportune politiche di reazione alla modifica/cancellazione dei dati.

```sql
DROP TABLE persona;
DROP TABLE corso;
DROP TABLE frequenza;

CREATE TABLE persona (
  idpersona INTEGER PRIMARY KEY,
  codicefiscale CHAR(11) UNIQUE,
  nome VARCHAR(40) NOT NULL,
  cognome VARCHAR(40) NOT NULL,
  datanascita DATE);

CREATE TABLE corso (
  idcorso INTEGER PRIMARY KEY,
  idinsegnante INTEGER REFERENCES persona (idpersona) ON DELETE SET NULL,
  sigla CHAR(7) UNIQUE NOT NULL,
  crediti INTEGER CHECK (crediti > 0 OR crediti IS NULL),
  descrizione TEXT);

CREATE TABLE frequenza (
  idstudente INTEGER REFERENCES persona ON DELETE CASCADE,
  idcorso INTEGER REFERENCES corso ON DELETE CASCADE,
  voto INTEGER CHECK (voto > 0 AND voto ≤ 30),
  PRIMARY KEY (idstudente, idcorso));
```

*Approfondimenti:* R.A. Elmasri, S.B. Navathe, *Sistemi di Basi di Dati – Fondamenti*: capitolo 8 (8.2); capitolo 5 (*Data Definition*) e capitolo 6 (*Data Manipulation*) del manuale di PostgreSQL.

> [!info] Sintesi:
> - `DROP SCHEMA`, `DROP TABLE` e `DROP DOMAIN` cancellano gli oggetti dello schema con `RESTRICT` (default, rifiuta se ci sono dipendenze) o `CASCADE` (cancella le dipendenze).
> - `ALTER TABLE` aggiunge e toglie colonne, modifica i default, aggiunge e toglie vincoli; `RENAME` è estensione PostgreSQL; `ALTER DOMAIN` modifica default e vincoli di un dominio.
> - Il DML è fatto da `INSERT`, `UPDATE`, `DELETE` (modifica) e `SELECT` (interrogazione): senza `WHERE`, `DELETE` cancella tutte le tuple e `UPDATE` le modifica tutte.
> - Le politiche di reazione spostano il rispetto dell'integrità referenziale dal programmatore alla definizione dello schema.
> - Le quattro politiche sono *cascade*, *set null*, *set default* e *no action* (default), specificate con `ON UPDATE` o `ON DELETE` nella chiave esterna.
