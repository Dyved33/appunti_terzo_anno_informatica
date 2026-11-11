# Gruppi, funzioni d'aggregazione, GROUP BY e HAVING

Le query di SQL viste finora estraggono informazioni su singole tuple, eventualmente tramite join. Si passa ora alle informazioni di sintesi su gruppi di tuple, mediante le funzioni d'aggregazione e le clausole `GROUP BY` e `HAVING` del comando `SELECT`.
## Funzioni d'aggregazione

Lo standard SQL mette a disposizione una serie di funzioni d'aggregazione (o 'di colonna').

*Definizione:* Le funzioni d'aggregazione sono:
- `MAX`: massimo
- `MIN`: minimo
- `SUM`: somma
- `AVG`: media aritmetica
- `COUNT`: contatore

L'argomento di una funzione d'aggregazione è una qualunque espressione della SELECT list:

```sql
SELECT MAX(data nascita) FROM persona;
SELECT MIN(voto + 2) FROM frequenza;
```

È possibile utilizzare l'opzione `DISTINCT`, per considerare soltanto i valori distinti:

```sql
SELECT SUM (DISTINCT voto) FROM frequenza;
```

*Osservazione:* tutte le funzioni d'aggregazione, ad eccezione di `COUNT`, ignorano i valori nulli.

Per quanto riguarda la funzione d'aggregazione `COUNT`:
- la forma `COUNT(*)` conta le tuple del risultato, considerando anche i valori nulli;
- specificando invece il nome di una colonna (ad esempio, `COUNT(id corso)`), i valori nulli vengono ignorati.

> [!example] Esempio (COUNT(*) vs COUNT(colonna))
> Si consideri la tabella `corso`:
>
> | id corso | id insegnante | titolo | retribuzione |
> |---|---|---|---|
> | 1 | 3 | 'Circuiti' | 100 |
> | 2 | 3 | 'Programmazione' | NULL |
> | 3 | 2 | 'Algoritmi' | 300 |
> | 10 | 1 | 'Logica' | 300 |
>
> ```sql
> SELECT COUNT(*) AS r
> FROM corso
> WHERE id insegnante = 3;
> ```
> restituisce `2`, mentre
>
> ```sql
> SELECT COUNT(retribuzione) AS r
> FROM corso
> WHERE id insegnante = 3;
> ```
> restituisce `1`.

## La clausola SELECT e le funzioni aggregate

La SELECT list deve essere omogenea: non si possono mescolare colonne singole e funzioni aggregate senza un raggruppamento.

```sql
SELECT crediti, MAX(crediti)
FROM corso
```
è errato, mentre è ammesso mescolare solo funzioni aggregate:

```sql
SELECT MIN(crediti), MAX(crediti)
FROM corso;
```

## La clausola GROUP BY

I valori di sintesi calcolati dalle funzioni aggregate si riferiscono a tutte le tuple che soddisfano le condizioni della clausola `WHERE`. In molti casi è utile fornire tali valori per gruppi omogenei di tuple (ad esempio il gruppo degli studenti di un certo corso). La clausola `GROUP BY` permette di definire tali gruppi, specificando una o più colonne di raggruppamento sulla base delle quali le tuple sono raggruppate per valori uguali.

*Definizione:* `GROUP BY <espressione1> [, ...], <espressionen>` definisce gruppi di tuple che hanno valori uguali sulle colonne indicate; a ciascun gruppo si applica poi la funzione aggregata presente nella SELECT list.

> [!example] Esempio (GROUP BY passo passo)
> Si consideri la tabella `frequenza`:
>
> | id studente | id corso | voto |
> |---|---|---|
> | 1 | 3 | 30 |
> | 2 | 3 | 25 |
> | 1 | 1 | 20 |
> | 10 | 1 | 23 |
> | 7 | 1 | 14 |
>
> Query:
>
> ```sql
> SELECT id corso, COUNT(*) AS NumStudenti
> FROM frequenza
> WHERE voto >= 18
> GROUP BY id corso;
> ```
>
> Esecuzione:
> 1. le tuple che soddisfano la clausola `WHERE` (`voto >= 18`) sono selezionate;
> 2. sono raggruppate per valori uguali della colonna `id corso` (gruppo 3: due tuple, gruppo 1: due tuple);
> 3. a ciascun gruppo si applica la funzione aggregata `COUNT(*)`.
>
> Risultato:
>
> | id corso | NumStudenti |
> |---|---|
> | 3 | 2 |
> | 1 | 2 |

## La clausola HAVING

Oltre a poter formare dei gruppi, è anche possibile selezionare dei gruppi sulla base di loro proprietà complessive. La clausola `HAVING` ha per i gruppi una funzione simile a quella che la clausola `WHERE` ha per le tuple: `WHERE` filtra le tuple prima del raggruppamento, `HAVING` filtra i gruppi dopo il raggruppamento.

> [!example] Esempio (HAVING)
> Selezionare per ogni corso superato da almeno 10 studenti, il numero di studenti promossi:
>
> ```sql
> SELECT id corso, COUNT(*)
> FROM frequenza
> WHERE voto >= 18
> GROUP BY id corso
> HAVING COUNT(*) >= 10;
> ```

## Raggruppamenti: esempi sullo schema del corso

Schema di riferimento:

```
persona(id persona, codice fiscale, nome, cognome, data nascita)
corso(id corso, id insegnante, sigla, crediti, descrizione)
frequenza(id studente, id corso, voto)
```

dove `id studente` ed `id corso` sono chiavi esterne su `persona` e `corso`.

> [!example] Numero dei corsi impartiti da ogni docente
>
> ```sql
> SELECT id insegnante, cognome, nome, COUNT(*)
> FROM corso JOIN persona ON id insegnante = id persona
> GROUP BY id insegnante, cognome, nome;
> ```

> [!example] Corsi di informatica impartiti da docenti che insegnano in almeno due corsi di informatica
>
> ```sql
> SELECT id insegnante, cognome, nome, COUNT(*)
> FROM corso JOIN persona ON id insegnante = id persona
> WHERE sigla LIKE 'INF%'
> GROUP BY id insegnante, cognome, nome
> HAVING COUNT(*) >= 2;
> ```

> [!example] ...di cui almeno uno garantisce più di 4 crediti
>
> ```sql
> SELECT id insegnante, cognome, nome, COUNT(*)
> FROM corso JOIN persona ON id insegnante = id persona
> WHERE sigla LIKE 'INF%'
> GROUP BY id insegnante, cognome, nome
> HAVING COUNT(*) >= 2 AND MAX(crediti) > 4;
> ```

## Sintassi

*Definizione:* La sintassi di una query che utilizza i costrutti di raggruppamento (funzioni di aggregazione, clausole `GROUP BY` e `HAVING`) è data da:

```sql
SELECT <espressione1> [, ...], <espressionen> [, <funzione aggreg> [, ...]]
FROM <tabella> [[AS <alias>]] [, ...]
[ WHERE <predicato> ]
[ GROUP BY <espressione1> [, ...], <espressionen> ]
[ HAVING <predicato> ]
```

Sintassi delle funzioni d'aggregazione:

- `AVG ( [DISTINCT|ALL] <espressione>)`
- `COUNT ( {*|[DISTINCT|ALL] <espressione>})`
- `MAX ( [DISTINCT|ALL] <espressione>)`
- `MIN ( [DISTINCT|ALL] <espressione>)`
- `SUM ( [DISTINCT|ALL] <espressione>)`
