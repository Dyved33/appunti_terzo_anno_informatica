# Lezione 12 - Join di Tabelle

## Join di tabelle
In SQL è possibile scrivere operazioni esplicite di join nella clausola `FROM` del comando `SELECT`, mediante lo statement `JOIN`. Si possono specificare esplicitamente diversi tipi di join:
- `CROSS JOIN`
- `INNER JOIN`
- `LEFT OUTER JOIN`
- `RIGHT OUTER JOIN`
- `FULL OUTER JOIN`
- `NATURAL JOIN`

## Join naturale
*Definizione:* Il join naturale è un operatore dell'algebra relazionale che collega dati in relazioni diverse, sulla base di valori uguali in attributi con lo stesso nome. Si denota $R_1 \bowtie R_2$.

Il join naturale $R_1 \bowtie R_2$ può essere introdotto esplicitamente nella clausola `FROM` del comando `SELECT` utilizzando:

1. il costrutto `NATURAL [INNER] JOIN`:
   ```sql
   SELECT * FROM R1 NATURAL [INNER] JOIN R2
   ```
2. il costrutto `[INNER] JOIN` + `USING`:
   ```sql
   SELECT * FROM R1 [INNER] JOIN R2 USING (<attributi>)
   ```

Lo statement `USING` permette di eliminare le colonne duplicate nel risultato.

> [!example] Esempio (join naturale di insegnante e corso)
> Si considerino le tabelle `insegnante` e `corso`:
>
> | id insegnante | cognome | nome |
> |---|---|---|
> | 3 | Donato | Rocco |
> | 2 | Bella | Donatella |
> | 7 | Pupo | Pino |
> | 10 | Moreno | Mario |
>
> | id corso | id insegnante | titolo |
> |---|---|---|
> | 1 | 3 | 'Circuiti' |
> | 2 | 2 | 'Programmazione' |
> | 3 | | 'Algoritmi' |
> | 10 | | 'Logica' |
>
> Il join naturale si ottiene con indifferentemente uno dei seguenti comandi:
> ```sql
> SELECT * FROM insegnante NATURAL JOIN corso;
> SELECT * FROM insegnante NATURAL INNER JOIN corso;
> SELECT * FROM insegnante JOIN corso USING (id insegnante);
> SELECT * FROM insegnante INNER JOIN corso USING (id insegnante);
> ```
>
> e produce il risultato:
>
> | id insegnante | cognome | nome | id corso | titolo |
> |---|---|---|---|---|
> | 3 | Donato | Rocco | 1 | 'Circuiti' |
> | 2 | Bella | Donatella | 2 | 'Programmazione' |

<div style="display: flex; justify-content: center;">
  <img src="lezione4-p06-06.png" width="300">
</div>

*Figura – Risultato del join naturale tra insegnante e corso.*

## Theta join
*Definizione:* L'operatore di theta join dell'algebra relazionale è definito come:
$$ R_1 \bowtie_{\exp} R_2 \equiv \sigma_{\exp}(R_1 \times R_2) $$
dove $\exp$ è un predicato logico.

Può essere introdotto esplicitamente nella clausola `FROM` del comando `SELECT` utilizzando il costrutto `[INNER] JOIN` + `ON`:
```sql
SELECT * FROM R1 [INNER] JOIN R2 ON <predicato>
```
dove `<predicato>` è un'espressione logica (come nella clausola `WHERE`).

> [!example] Esempio (theta join)
> Selezionare i corsi per cui è definito il corrispondente titolare del corso:
> ```sql
> SELECT id_corso, titolo
> FROM insegnante INNER JOIN corso
>        ON insegnante.id_insegnante = corso.id_insegnante;
> ```
> oppure, data l'equivalenza $R_1 \bowtie_{\exp} R_2 \equiv \sigma_{\exp}(R_1 \times R_2)$:
> ```sql
> SELECT id_corso, titolo
> FROM insegnante, corso
> WHERE insegnante.id_insegnante = corso.id_insegnante;
> ```

## CROSS JOIN
Il costrutto `CROSS JOIN` nella clausola `FROM` realizza il prodotto cartesiano nell'algebra relazionale, che può essere visto come un theta-join:
$$ R_1 \times R_2 \equiv R_1 \bowtie_{\text{true}} R_2 $$

Le seguenti espressioni sono equivalenti in SQL:
1. `SELECT * FROM tabella1, tabella2;`
2. `SELECT * FROM tabella1 CROSS JOIN tabella2;`
3. `SELECT * FROM tabella1 JOIN tabella2 ON TRUE;`
4. `SELECT * FROM tabella1 INNER JOIN tabella2 ON TRUE;`

## Join esterni
Il risultato del join (interno) tralascia le tuple di una relazione senza controparte nell'altra. Il join esterno prevede che tutte le tuple diano un contributo al risultato, estendendo con valori nulli le tuple che non hanno controparte:
- il **join sinistro** estende le tuple del primo operando;
- il **join destro** estende le tuple del secondo operando;
- il **join completo** le estende tutte.

In SQL l'operatore di outer join può essere introdotto esplicitamente nella clausola `FROM` utilizzando i costrutti:
- `{LEFT|RIGHT|FULL}[OUTER] JOIN + ON <predicato>`
- `{LEFT|RIGHT|FULL}[OUTER] JOIN + USING <colonne>`
- `NATURAL{LEFT|RIGHT|FULL}[OUTER] JOIN`

### Join esterno sinistro
Permette di preservare nel risultato gli insegnanti che non tengono alcun corso.

<div style="display: flex; justify-content: center;">
  <img src="lezione4-p14-14.png" width="300">
</div>

*Figura – Risultato del join esterno sinistro tra insegnante e corso.*

Può essere realizzato in SQL con:
```sql
SELECT * FROM insegnante NATURAL LEFT JOIN corso;
SELECT * FROM insegnante NATURAL LEFT OUTER JOIN corso;
SELECT * FROM insegnante LEFT JOIN corso USING (id insegnante);
SELECT * FROM insegnante LEFT OUTER JOIN corso USING (id insegnante);
```

> [!warning] Attenzione:
> Se si usa `LEFT JOIN ... ON insegnante.id_insegnante = corso.id_corso` (confondendo le colonne), la colonna che mantiene gli id degli insegnanti appare duplicata nel risultato.

### Join esterno destro
Permette di preservare nel risultato i corsi per cui non è stato designato alcun titolare del corso.

<div style="display: flex; justify-content: center;">
  <img src="lezione4-p17-17.png" width="300">
</div>

*Figura – Risultato del join esterno destro tra insegnante e corso.*

Può essere realizzato con:
```sql
SELECT * FROM insegnante NATURAL RIGHT JOIN corso;
SELECT * FROM insegnante NATURAL RIGHT OUTER JOIN corso;
SELECT * FROM insegnante RIGHT JOIN corso USING (id insegnante);
SELECT * FROM insegnante RIGHT OUTER JOIN corso USING (id insegnante);
```

### Join esterno completo
Permette di preservare nel risultato gli insegnanti che non tengono alcun corso ed i corsi non ancora assegnati ad alcun docente.

<div style="display: flex; justify-content: center;">
  <img src="lezione4-p19-19.png" width="300">
</div>

*Figura – Risultato del join esterno completo tra insegnante e corso.*

Può essere realizzato con:
```sql
SELECT * FROM insegnante NATURAL FULL JOIN corso;
SELECT * FROM insegnante NATURAL FULL OUTER JOIN corso;
SELECT * FROM insegnante FULL JOIN corso USING (id insegnante);
SELECT * FROM insegnante FULL OUTER JOIN corso USING (id insegnante);
```

## Operazioni insiemistiche su tabelle
L'istruzione `SELECT` non permette di eseguire unione, intersezione e differenza di tabelle. Si possono però combinare i risultati di due istruzioni `SELECT` utilizzando la clausola:
`[ { UNION | INTERSECT | EXCEPT [ ALL ] } <richiesta> ]`

Requisiti:
- gli elementi delle SELECT list devono avere tipi compatibili;
- se si vogliono colonne con un'intestazione definita, devono avere gli stessi nomi;
- l'ordine degli elementi è importante (notazione posizionale);
- il risultato è di default privo di duplicati. Per ottenerli occorre aggiungere l'opzione `ALL`.

> [!example] Esempio (UNION)
> ```sql
> SELECT A FROM R
> UNION
> SELECT C FROM S;
> ```

Le traduzioni degli operatori insiemistici in SQL:
- $R \cup S$: `SELECT * FROM R UNION SELECT * FROM S;`
- $R \cap S$: `SELECT * FROM R INTERSECT SELECT * FROM S;`
- $R \setminus S$: `SELECT * FROM R EXCEPT SELECT * FROM S;`

<div style="display: flex; justify-content: center;">
  <img src="lezione4-p22-22.png" style="width: 30%;">
</div>

*Figura – Esempio di UNION sulle tabelle S e R.*

<div style="display: flex; justify-content: center;">
  <img src="lezione4-p24-24.png" style="width: 30%;">
</div>

*Figura – Esempio di UNION ALL sulle tabelle S e R.*


