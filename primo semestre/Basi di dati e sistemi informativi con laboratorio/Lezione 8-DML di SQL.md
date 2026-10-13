# Il DML di SQL - interrogazione di una BD (la clausola SELECT)

## Il DML e l'istruzione SELECT

Il **Data Manipulation Language** raccoglie le istruzioni SQL che operano sui dati: `INSERT`, `UPDATE` e `DELETE` per la modifica ([[Lezione 6-Cancellazione e aggiornamento di una BD, il DML e le politiche di reazione|Lezione 6]]) e `SELECT` per l'interrogazione. Questa lezione riguarda `SELECT`, l'istruzione con cui si formulano le query.

**Sintassi generale:** l'istruzione è composta da 7 clausole, 5 delle quali opzionali.

```sql
SELECT [ALL | DISTINCT] {* | <espressione> [AS <nome>]} [,...]
FROM <nometab> [[AS] <alias>]
[WHERE <predicato>]
[GROUP BY <espressione> [,...]]
[HAVING <predicato>]
[{UNION | INTERSECT | EXCEPT [ALL]} <richiesta>]
[ORDER BY <espressione> [ASC | DESC] [,...]]
```

**Ruolo delle clausole:**

- `SELECT`: specifica gli attributi che devono apparire nel risultato;
- `FROM`: specifica le tabelle su cui si pone la query;
- `WHERE`: filtra le tuple in base a condizioni da soddisfare;
- `GROUP BY`: definisce dei gruppi;
- `UNION`, `INTERSECT`, `EXCEPT`: operazioni insiemistiche sui risultati delle query;
- `ORDER BY`: ordina le tuple del risultato.

`GROUP BY`, `HAVING` e le clausole insiemistiche sono solo introdotte: la loro trattazione e quella della clausola esplicita di `JOIN` vengono rimandate alle lezioni successive.

> [!todo] Nelle slide le istruzioni di modifica sono invertite (`UPDATE` indicata come cancellazione, `DELETE` come modifica): è un refuso. Vale la definizione corretta della [[Lezione 6-Cancellazione e aggiornamento di una BD, il DML e le politiche di reazione|Lezione 6]].

## La clausola SELECT

L'istruzione `SELECT [ALL | DISTINCT] {* | <espressione> [AS <nome>]} [,...]`:

- definisce le colonne del risultato della query;
- opera una proiezione sulla tabella intermedia generata dal resto della query;
- elenca gli attributi in una lista separata da virgole;
- permette anche di rinominare colonne e di generarne di nuove.

**L'operatore `*`:** recupera tutti gli attributi della tabella specificata nella clausola `FROM`. Con lo schema `persona(idpersona, codicefiscale, nome, cognome, datanascita)`:

> [!example]
> ```sql
> SELECT * FROM persona;
> ```
> equivale a:
> ```sql
> SELECT idpersona, codicefiscale, nome, cognome, datanascita FROM persona;
> ```

**`DISTINCT` e `ALL`:** il risultato di una query può contenere righe duplicate.

```sql
SELECT nome FROM persona WHERE cognome = 'Rossi'
```

> [!example]
> | nome |
> | :--- |
> | Francesca |
> | Paolo |
> | Francesca |

Per eliminare le duplicazioni si usa `DISTINCT` nella clausola `SELECT`:

```sql
SELECT DISTINCT nome FROM persona WHERE cognome = 'Rossi'
```

`ALL` è l'opzione di default.

**Espressioni:** la lista del `SELECT` può contenere non solo attributi ma anche espressioni.

```sql
SELECT idstudente, voto + 2 FROM frequenza WHERE idcorso = 5
```

In questo caso la seconda colonna è priva di nome; i valori di esempio di `idstudente` nel risultato sono `130`, `218`, `319`, …. L'operatore `||` permette di concatenare campi di tipo carattere:

```sql
SELECT cognome || ' ' || nome || ' e nato il:' || datanascita FROM persona
```

**Ridenominazione con `AS`:** a ogni elemento della lista si può associare un nome a piacere.

```sql
SELECT idstudente, voto + 2 AS votocalmierato FROM frequenza;
```

La parola chiave `AS` può anche essere omessa:

```sql
SELECT idstudente, voto + 2 votocalmierato FROM frequenza;
```

## La clausola FROM

L'istruzione `FROM <nometab> [[AS] <alias>]`:

- specifica le tabelle su cui si pone la query;
- costruisce la tabella intermedia a partire da una o più tabelle, su cui operano le altre clausole (`SELECT`, `WHERE`, …);
- la tabella intermedia è il risultato del prodotto cartesiano delle tabelle elencate;
- la sintassi è semplificata: non include la clausola esplicita di `JOIN`, che sarà vista nella lezione successiva.

> [!example]
> 1. Selezionare tutti i corsi con un credito:
> ```sql
> SELECT * FROM corsi WHERE crediti = 1;
> ```
> 2. Selezionare id, nome e cognome degli studenti:
> ```sql
> SELECT DISTINCT idstudente, nome, cognome
> FROM persona, frequenza
> WHERE persona.idpersona = frequenza.idstudente;
> ```
> La query realizza un equi-join: $\sigma_E(R_1 \times R_2) \equiv R_1 \bowtie_E R_2$.

**Pseudonimi e alias:** per chiarezza ogni nome di colonna può (o deve) essere scritto prefissandolo con il nome della tabella; si può usare uno pseudonimo (*alias*) in luogo del nome della tabella.

> [!example]
> ```sql
> SELECT f.idstudente FROM frequenza AS f WHERE f.idcorso = 7;
> ```
> ```sql
> SELECT corso.idcorso FROM corso, frequenza
> WHERE corso.idcorso = frequenza.idcorso AND idstudente = 7;
> ```

Dopo aver introdotto un alias, riferirsi alla tabella con il nome originale è errato:

```sql
SELECT f.idstudente FROM frequenza AS f WHERE frequenza.idcorso = 7;  -- errato
```

**Self-join:** l'uso degli alias è forzato quando si deve eseguire una self-join, cioè mettere in relazione una tabella con se stessa. Con la tabella `genitore(genitore, figlio)`, per rispondere a «Chi sono i nonni di Luca?»:

```sql
SELECT g1.genitore AS nonno
FROM genitore AS g1, genitore AS g2
WHERE g1.figlio = g2.genitore AND g2.figlio = 'Luca';
```

## La clausola ORDER BY

L'istruzione `[ORDER BY <espressione> [ASC | DESC] [,...]]` permette di ordinare il risultato di una query secondo i valori di una o più colonne:

- per ogni colonna si specifica se l'ordinamento è per valori ascendenti (`ASC`) o discendenti (`DESC`);
- come nella clausola `SELECT`, al posto della colonna si può usare un'espressione.

> [!example]
> ```sql
> SELECT idpersona, cognome, nome
> FROM persona
> ORDER BY cognome ASC, nome ASC;
> ```
> | idpersona | cognome | nome |
> | :--- | :--- | :--- |
> | 19 | Bianchi | Francesco |
> | 2 | Rossi | Andrea |
> | 17 | Rossi | Emilio |

## La clausola WHERE

L'istruzione `[WHERE <predicato>]`:

- filtra le tuple della tabella intermedia in base alla soddisfazione di un predicato;
- usa la logica a tre valori: solo le tuple per cui il predicato è vero appaiono nel risultato;
- i predicati possono essere combinati con gli operatori logici `AND`, `OR`, `NOT`.

> [!example]
> Persone di nome Giovanni nate prima del 1970:
> ```sql
> SELECT * FROM persona
> WHERE nome = 'Giovanni' AND datanascita <= '01/01/1970';
> ```

Un predicato è una formula logica su espressioni. In PostgreSQL i comandi `\df` e `\do` permettono di elencare le funzioni e gli operatori disponibili.

**Operatori logici:**

| Operatore | Descrizione |
| :--- | :--- |
| `AND` | congiunzione logica |
| `OR` | disgiunzione logica |
| `NOT` | negazione logica |

**Operatori di comparazione:**

| Operatore | Descrizione |
| :--- | :--- |
| `<x> = <y>` | `<x>` è uguale a `<y>` |
| `<x> != <y>`, `<x> <> <y>` | `<x>` è diverso da `<y>` |
| `<x> < (<=, >, >=) <y>` | `<x>` è minore (minore o uguale, maggiore, maggiore o uguale) a `<y>` |
| `<a> BETWEEN <x> AND <y>` | equivale a `<a> >= <x> AND <a> <= <y>` |
| `<a> NOT BETWEEN <x> AND <y>` | equivale a `<a> < <x> OR <a> > <y>` |
| `<x> IS NULL` | vero se `<x>` ha valore `NULL` |
| `<x> IS NOT NULL` | vero se il valore di `<x>` non è `NULL` |
| `<x> IS DISTINCT FROM <y>` | `<x>` è diverso da `<y>`, supporta `NULL` |
| `<x> IS NOT DISTINCT FROM <y>` | `<x>` è uguale a `<y>`, supporta `NULL` |

> [!example]
> 1. Corsi con un numero di crediti strettamente superiore a 2:
> ```sql
> SELECT * FROM corso WHERE crediti > 2;
> ```
> 2. Corsi con un numero di crediti definito:
> ```sql
> SELECT * FROM corso WHERE crediti IS NOT NULL;
> ```
> 3. Corsi con un numero di crediti compreso tra 2 e 3:
> ```sql
> SELECT * FROM corso WHERE crediti BETWEEN 2 AND 3;
> ```

**Operatori matematici:**

| Operatore | Descrizione |
| :--- | :--- |
| `<x> + <y>` | addizione |
| `<x> - <y>` | sottrazione |
| `<x> * <y>` | moltiplicazione |
| `<x> / <y>` | divisione |
| `<x> % <y>` | resto |
| `@(<x>)` | valore assoluto |

**Funzioni e operatori su stringhe:**

| Operatore | Descrizione |
| :--- | :--- |
| `<exp> || <exp>` | concatenazione di stringhe |
| `CHARLENGTH(<st>)` | numero di caratteri della stringa |
| `LOWER(<st>)` | converte i caratteri della stringa in minuscole |
| `UPPER(<st>)` | converte i caratteri della stringa in maiuscole |

> [!example]
> 1. `SELECT '2*3=' || 2*3;` → `2*3=6`
> 2. `SELECT CHARLENGTH('Anna');` → `4`
> 3. `SELECT LOWER('Anna');` → `anna`

**Corrispondenza di pattern con `LIKE`:** mediante le *wildcard* `_` (un carattere arbitrario) e `%` (una stringa arbitraria) si esprimono pattern su stringa.

> [!example]
> Cognomi delle persone che finiscono con una `i` e hanno una `i` in seconda posizione:
> ```sql
> SELECT cognome FROM persona WHERE cognome LIKE '_i%i';
> ```

**Appartenenza con `IN`:** permette di esprimere condizioni di appartenenza a un insieme.

> [!example]
> ```sql
> SELECT cognome FROM persona WHERE idpersona IN (5, 18, 30);
> ```

**Funzioni su data/ora:**

| Funzione | Descrizione |
| :--- | :--- |
| `CURRENT TIME` | ora corrente |
| `CURRENT DATE` | data corrente |
| `CURRENT TIMESTAMP` | data e ora corrente |

## Interrogazione SQL e algebra relazionale

Il `SELECT` permette di definire in SQL gli operatori dell'[[Lezione 7-Algebra relazionale|algebra relazionale]].

**Proiezione** $\Pi_{A_1, \dots, A_n}(\text{relazione})$:

```sql
SELECT DISTINCT A_1, ..., A_n FROM relazione;
```

`DISTINCT` elimina le tuple identiche nel risultato. Esempio: `SELECT DISTINCT cognome FROM persona;`

**Selezione** $\sigma_{predicato}(\text{relazione})$:

```sql
SELECT * FROM relazione WHERE predicato;
```

Esempio: `SELECT * FROM corso WHERE crediti = 2;`

**Prodotto cartesiano** $relazione_1 \times relazione_2$:

```sql
SELECT * FROM relazione_1, relazione_2;
```

**Theta-join** $relazione_1 \bowtie_{exp} relazione_2 \equiv \sigma_{exp}(relazione_1 \times relazione_2)$:

```sql
SELECT * FROM relazione_1, relazione_2 WHERE exp;
```

Esempio, elenco dei corsi con i relativi insegnanti mediante un equi-join su `persona` e `corso`:

```sql
SELECT * FROM persona, corso WHERE persona.idpersona = corso.idinsegnante;
```

> [!info] Sintesi:
> - Il `SELECT` è l'istruzione di interrogazione del DML e si compone di 7 clausole, 5 opzionali: `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `UNION`/`INTERSECT`/`EXCEPT`, `ORDER BY`.
> - La clausola `SELECT` sceglie e rinomina le colonne del risultato (proiezione), con `*`, `ALL` (default) e `DISTINCT` per eliminare i duplicati, e ammette espressioni come `voto + 2` o concatenazioni con `||`.
> - La clausola `FROM` elenca le tabelle e ne costruisce la tabella intermedia come prodotto cartesiano; gli alias servono a qualificare le colonne ed è forzato usarli nella self-join.
> - La clausola `WHERE` filtra le tuple con logica a tre valori, usando operatori logici, di comparazione (`BETWEEN`, `IS NULL`, `IS [NOT] DISTINCT FROM`), matematici, su stringhe (`LIKE`, `IN`) e su data/ora.
> - La clausola `ORDER BY` ordina il risultato per una o più colonne, in ordine ascendente (`ASC`) o discendente (`DESC`).
> - Gli operatori dell'algebra relazionale (proiezione, selezione, prodotto cartesiano, θ-join) si traducono direttamente in query `SELECT`.
