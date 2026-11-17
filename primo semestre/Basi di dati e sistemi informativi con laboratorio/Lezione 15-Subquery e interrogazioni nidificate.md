# Subquery e interrogazioni nidificate

Le subquery (o interrogazioni nidificate) permettono di inserire uno statement SQL all'interno di un altro statement, rendendo il linguaggio più espressivo e, in certi casi, più leggibile rispetto alla forma flat.

*Definizione:* **Subquery:** uno statement inserito all'interno di un altro statement SQL. Si può trovare:
1. nelle clausole `WHERE` e `HAVING` di un `SELECT`;
2. nella clausola `WHERE` di un `INSERT INTO`, `DELETE FROM`, `UPDATE`;
3. nella clausola `SET` di un comando `UPDATE`.

Una subquery è sempre racchiusa tra parentesi e può restituire:
- un singolo valore, utilizzabile come espressione scalare;
- una colonna, utilizzabile come elenco di costanti;
- una tabella, utilizzabile ovunque si possa usare una tabella.

Le subquery non possono contenere operatori insiemistici. La forma nidificata è più procedurale della forma flat e, per questo, talvolta più leggibile.

Consideriamo lo schema relazionale usato nelle lezioni precedenti:

```
persona(id persona, codice fiscale, nome, cognome, data nascita)
corso(id corso, id insegnante, sigla, crediti, descrizione)
frequenza(id studente, id corso, voto)
```

dove `id studente` ed `id corso` sono chiavi esterne su `persona` e `corso`.

Esempio:

```sql
SELECT persona.nome, persona.cognome
FROM persona
WHERE persona.id persona IN (SELECT corso.id insegnante FROM corso)
```

restituisce il nome e cognome degli insegnanti che tengono almeno un corso.

## Predicato IN

Il predicato `IN` può essere applicato a liste di attributi e può essere negato (`NOT IN`).

```sql
SELECT persona.nome, persona.cognome
FROM persona
WHERE persona.id persona NOT IN (SELECT corso.id insegnante FROM corso
                                 WHERE corso.id insegnante IS NOT NULL)
```

restituisce il nome e cognome degli insegnanti che non tengono alcun corso.

*Osservazione:* con `NOT IN`, i valori `NULL` nella colonna restituita dalla subquery devono essere soppressi (es. con `WHERE ... IS NOT NULL`), altrimenti il predicato può non restituire i risultati attesi.

## Predicati di confronto su subquery

Gli operatori di confronto `=`, `<>`, `<`, `>`, `<=`, `>=` si possono usare con una subquery solo se quest'ultima restituisce al più una riga (subquery scalare). Se la subquery non restituisce alcuna riga, il confronto dà come risultato `NULL`. In PostgreSQL, solo `<>` ed `=` sono supportati se il confronto coinvolge più colonne.

Esempio:

```sql
SELECT id corso
FROM corso
WHERE crediti = (SELECT MAX(crediti) FROM corso)
```

restituisce gli id dei corsi con il massimo numero di crediti.

## Predicato ANY

Per usare predicati di confronto con selezioni che possono restituire più di una riga, occorre usare le quantificazioni `ALL` o `ANY`.

*Definizione:* **Predicato ANY:** dà vero se il confronto è vero per almeno una riga della subquery; dà falso se tutti i confronti sono falsi o se la subquery restituisce una tabella vuota; restituisce `NULL` se non ci sono confronti veri ma almeno uno è `NULL`.

Il predicato `IN` è equivalente a `= ANY`.

Esempio:

```sql
SELECT persona.nome, persona.cognome
FROM persona
WHERE persona.id persona = ANY (SELECT corso.id insegnante
                                FROM corso)
```

restituisce il nome e cognome degli insegnanti che tengono almeno un corso.

## Predicato ALL

*Definizione:* **Predicato ALL:** dà vero se tutti i confronti di riga sono veri o se la subquery restituisce una tabella vuota; dà falso se almeno un confronto è falso; restituisce `NULL` se non ci sono confronti falsi ma almeno uno è indefinito.

Il predicato `NOT IN` è equivalente a `<> ALL`.

Esempio:

```sql
SELECT persona.nome, persona.cognome
FROM persona
WHERE persona.id persona <> ALL (SELECT corso.id insegnante FROM corso
                                 WHERE corso.id insegnante IS NOT NULL)
```

restituisce il nome e cognome degli insegnanti che non tengono alcun corso.

## Predicato EXISTS

*Definizione:* **Predicato EXISTS:** è vero se la subquery restituisce almeno una riga, altrimenti è falso. Con `NOT EXISTS` si verifica se la subquery non restituisce alcuna tupla.

Esempio:

```sql
SELECT persona.nome, persona.cognome
FROM persona
WHERE EXISTS (SELECT * FROM corso WHERE crediti > 3)
```

Si noti che questa query non è molto interessante perché il risultato della subquery è sempre lo stesso, indipendente dalla tupla del blocco esterno.

## Subquery correlate

Se la subquery fa riferimento al blocco esterno, si dice **correlata**. Il risultato della query innestata dipende dalla tupla specificata nel blocco esterno: per ogni tupla del blocco esterno, si considera il valore di riferimento e si risolve la query innestata.

Esempio:

```sql
SELECT persona.nome, persona.cognome
FROM persona P
WHERE EXISTS (SELECT * FROM corso C WHERE crediti > 3
              AND C.id insegnante = P.id persona)
```

restituisce gli insegnanti che tengono almeno un corso con più di 3 crediti.

Altro esempio:

```sql
SELECT persona.nome, persona.cognome
FROM persona
WHERE EXISTS (SELECT frequenza.voto FROM frequenza
              WHERE persona.id persona = frequenza.id studente
                AND frequenza.voto IS NOT NULL)
  AND 10 <= ALL (SELECT frequenza.voto FROM frequenza
                 WHERE persona.id persona = frequenza.id studente
                   AND frequenza.voto IS NOT NULL)
```

restituisce gli studenti che hanno preso solo voti superiori a 10.

## Livelli multipli di annidamento

Una subquery può fare uso a sua volta di altre subquery. Il risultato si ottiene risolvendo a partire dal blocco più interno.

Esempio:

```sql
SELECT nome, reddito
FROM persone
WHERE nome IN
    (SELECT padre FROM paternita'
     WHERE figlio = ANY
         (SELECT nome FROM persone
          WHERE reddito > 40))
```

## Unnesting

È spesso possibile ricondurre una subquery a una forma flat, anche se non è sempre ovvio.

Esempio: la query precedente si può riscrivere come:

```sql
SELECT DISTINCT p.nome, p.reddito
FROM persone p, paternita', persone f
WHERE p.nome = padre AND figlio = f.nome AND f.reddito > 40
```

## Divisione relazionale

Le subquery permettono di eseguire la divisione relazionale, ovvero di esprimere quantificazione universale (`∀`). In SQL non esiste l'operatore di quantificazione universale, ma vale l'equivalenza:

`∀x P(x) ≡ ¬∃ ¬P(x)`

Esempio: schemi `Impiegati(CodiceImp, Nome, Sede, Ruolo, Stipendio)` e `Sedi(Sede, Responsabile, Citta')`.

**Quali sono le sedi in cui sono presenti tutti i ruoli?** equivale a: quali sono le sedi che verificano: per ogni ruolo, tale ruolo è presente nella sede? Oppure: quali sono le sedi in cui non esiste un ruolo non presente?

Query in SQL con doppio `NOT EXISTS`:

```sql
SELECT Sede FROM Sedi AS S
WHERE NOT EXISTS (SELECT * FROM Impiegati I1
                   WHERE NOT EXISTS (SELECT * FROM Impiegati I2
                                      WHERE S.Sede = I2.Sede
                                        AND I1.Ruolo = I2.Ruolo))
```

Il blocco più interno viene valutato per ogni combinazione di `S` ed `I1`. Il blocco intermedio funge da divisore (riguarda `I1`). Se in una sede `S` manca un ruolo, la subquery più interna non restituisce nulla, la subquery intermedia restituisce almeno una tupla, e quindi la clausola `WHERE` non è soddisfatta per `S`.

Secondo esempio: schemi `persona`, `corso`, `frequenza` come sopra.

**Chi sono gli studenti che seguono tutti i corsi di matematica?** equivale a: chi sono gli studenti che verificano: per ogni corso di matematica, lo studente segue tale corso? Oppure: non esiste un corso di matematica non seguito dallo studente.

Query con doppio `NOT EXISTS`:

```sql
SELECT DISTINCT nome, cognome FROM persona AS p
WHERE NOT EXISTS (
    SELECT * FROM (SELECT * FROM corso WHERE sigla LIKE 'mat%') AS c
    WHERE NOT EXISTS (
        SELECT * FROM persona JOIN frequenza ON id persona = id studente
        WHERE id persona = p.id persona AND id corso = c.id corso))
```

Query alternativa con `COUNT` e `HAVING`:

```sql
SELECT id persona, nome, cognome
FROM persona JOIN frequenza ON id persona = id studente
     JOIN corso USING (id corso)
WHERE corso.sigla LIKE 'mat%'
GROUP BY id persona, nome, cognome
HAVING COUNT(DISTINCT corso.id corso) =
       (SELECT COUNT(*) FROM corso WHERE sigla LIKE 'mat%')
```

o equivalentemente:

```sql
SELECT id persona, nome, cognome
FROM persona
WHERE (
    SELECT COUNT(DISTINCT id corso)
    FROM frequenza NATURAL JOIN corso
    WHERE sigla LIKE 'mat%' AND id studente = id persona
) = (SELECT COUNT(*) FROM corso WHERE sigla LIKE 'mat%')
```

## Subquery per aggiornamento dei dati

Le subquery si possono usare efficacemente per aggiornare i dati di una tabella sulla base di criteri che dipendono dal contenuto di altre tabelle.

Esempio:

```sql
DELETE FROM persona
WHERE persona.id persona NOT IN (SELECT corso.id insegnante FROM corso
                                 WHERE corso.id insegnante IS NOT NULL)
```

elimina gli insegnanti che non tengono alcun corso.

## Subquery in CHECK

Lo standard SQL prevede l'uso di interrogazioni annidate anche nella clausola `CHECK`. Questa caratteristica non è supportata attualmente da PostgreSQL (per farvi fronte si usano i trigger, cf. [[Lezione 9-Operatori aggiuntivi dell'algebra relazionale: raggruppamento, funzioni aggregate e join esterni|Lezione 9]]).

Esempio:

```sql
CHECK ( NOT EXISTS (SELECT * FROM ImpiegatiUD
                    WHERE ImpiegatiUD.codiceImp = ImpiegatiUD.codicePG))
```

[[Lezione 10-L'operatore di divisione e i valori nulli nell'algebra relazionale|Lezione 10]]

> [!info] Sintesi:
> - Una subquery è uno statement SQL annidato in un altro, sempre tra parentesi; può restituire un singolo valore, una colonna o una tabella.
> - `IN` / `NOT IN` testano l'appartenenza a un elenco restituito da una subquery.
> - I confronti `=`, `<>`, `<`, `>`, `<=`, `>=` richiedono una subquery scalare (al più una riga).
> - `ANY` è vero se il confronto vale per almeno una riga; `IN` equivale a `= ANY`.
> - `ALL` è vero se il confronto vale per tutte le righe; `NOT IN` equivale a `<> ALL`.
> - `EXISTS` è vero se la subquery restituisce almeno una riga; `NOT EXISTS` verifica l'assenza.
> - Una subquery correlata riferisce al blocco esterno e viene risolta per ogni sua tupla.
> - La divisione relazionale si esprime con doppio `NOT EXISTS` (`¬∃¬P`) oppure con `COUNT`/`HAVING`.
> - Le subquery si usano anche in `DELETE`/`UPDATE` e, nello standard SQL, in `CHECK` (non in PostgreSQL: usare i trigger).

[[Lezione 10-L'operatore di divisione e i valori nulli nell'algebra relazionale|Lezione 10]]
