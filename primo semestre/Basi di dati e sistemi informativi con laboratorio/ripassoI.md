# Ripasso I - Algebra relazionale

Gli operatori prendono una o due relazioni e restituiscono una relazione. L'algebra relazionale è procedurale: una query descrive le operazioni da eseguire. Le operazioni si possono comporre, usando il risultato di un operatore come argomento di quello successivo.

Negli esempi useremo queste relazioni:

- `Impiegati(Matricola, Cognome, Dipartimento, Stipendio)`
- `Progetti(CodiceP, NomeP, Dipartimento)`
- `Lavora(Matricola, CodiceP, Ore)`
- `Fornisce(F, P)` e `Prodotto(P)`

## Ridenominazione

`ρ` cambia il nome della relazione e/o quello dei suoi attributi. È utile per rendere espliciti i nomi, evitare ambiguità o preparare operazioni tra relazioni.

```text
ρ Dip(CodiceD → Dipartimento)(Dipartimenti)
```

Il risultato si chiama `Dip` e il suo attributo `CodiceD` diventa `Dipartimento`. La ridenominazione non cambia le tuple.

## Operatori insiemistici

Unione, intersezione e differenza richiedono relazioni **compatibili all'unione**: stesso numero di attributi e domini corrispondenti uguali. Gli attributi del risultato prendono i nomi dal primo operando. Le relazioni sono insiemi, quindi una tupla ripetuta compare una volta sola.

Poniamo `Milano = σ Città='Milano'(Sedi)` e `Roma = σ Città='Roma'(Sedi)`. Poiché hanno lo stesso schema:

| Operatore | Significato | Esempio |
| --- | --- | --- |
| Unione `r ∪ s` | Tuple in `r` oppure in `s` | `Milano ∪ Roma`: sedi di Milano o Roma |
| Intersezione `r ∩ s` | Tuple sia in `r` sia in `s` | `Milano ∩ SediAttive`: sedi di Milano che sono attive |
| Differenza `r \\ s` | Tuple in `r` ma non in `s` | `Sedi \\ SediAttive`: sedi non attive |

L'intersezione è derivabile: `r ∩ s = r \\ (r \\ s)`.

## Prodotto cartesiano

`r × s` abbina ogni tupla di `r` con ogni tupla di `s`. Gli attributi dei due schemi devono essere disgiunti; se hanno lo stesso nome, si rinominano prima. Se `r` ha 3 tuple e `s` ne ha 4, il prodotto ha 12 tuple.

```text
Impiegati × Progetti
```

Forma tutte le coppie impiegato-progetto, anche quelle senza relazione logica. Di solito il prodotto cartesiano si combina con una selezione per ottenere un join.

## Selezione

`σ_F(r)` mantiene le tuple di `r` per cui la condizione `F` è vera. Non elimina attributi.

Le condizioni atomiche confrontano un attributo con un altro (`A θ B`) o con una costante (`A θ c`), usando `=`, `≠`, `<`, `≤`, `>` o `≥`. Si combinano con `∧`, `∨` e `¬`.

```text
σ Stipendio > 2000 ∧ Dipartimento='Informatica' (Impiegati)
```

Seleziona gli impiegati del dipartimento di Informatica con stipendio superiore a 2000. Se più selezioni sono consecutive, si possono accorpare: `σF(σG(r)) = σF∧G(r)`.

## Proiezione

`π_Y(r)` conserva soltanto gli attributi in `Y`. Le tuple che diventano uguali dopo aver tolto le altre colonne si riducono a una sola.

```text
π Cognome, Stipendio (Impiegati)
```

Restituisce cognome e stipendio, senza duplicati. Se serve filtrare e poi scegliere le colonne:

```text
π Cognome (σ Dipartimento='Informatica' (Impiegati))
```

## Join (concatenazione)

Il join combina tuple collegate da una condizione. In generale gli attributi dei due schemi vanno distinti; se necessario, si rinominano prima.

### θ-join ed equijoin

Il θ-join applica una condizione di confronto alle coppie del prodotto cartesiano:

```text
r ⋈F s = σF(r × s)
```

Un **equijoin** è un θ-join la cui condizione contiene solo uguaglianze.

```text
Impiegati ⋈ Impiegati.Matricola=Lavora.Matricola Lavora
```

Abbina ogni impiegato alle sue righe di lavoro; nel risultato `Matricola` appare due volte. Per esempio, una condizione come `Impiegati.Stipendio > Progetti.Budget` è un θ-join (confronto `>`).

### Join naturale

`r ⋈ s` abbina tuple con uguali valori sugli attributi comuni e lascia una sola copia di tali attributi nel risultato. Se non ci sono attributi in comune, coincide con il prodotto cartesiano.

```text
Impiegati ⋈ Lavora
```

Le due relazioni condividono `Matricola`: il join combina ogni impiegato con le sue righe in `Lavora` e presenta `Matricola` una volta sola. Il join naturale è comodo quando gli attributi comuni rappresentano davvero la stessa informazione; nomi uguali per caso possono produrre abbinamenti indesiderati.

Il join è derivabile da prodotto cartesiano e selezione; il join naturale è derivabile anche da equijoin e proiezione, eliminando la copia degli attributi comuni.

## Raggruppamento e funzioni aggregate

La notazione `Y ℱ_listaFun(r)` raggruppa le tuple con gli stessi valori sugli attributi `Y` e calcola le funzioni aggregate indicate su ciascun gruppo. Ogni gruppo produce una tupla con gli attributi di raggruppamento e i risultati. Le funzioni trattate sono `SUM`, `AVG`, `MAX`, `MIN` e `COUNT`.

```text
Dipartimento ℱ_{AVG(Stipendio), COUNT(Matricola)}(Impiegati)
```

Produce una riga per dipartimento, con stipendio medio e numero di impiegati. I risultati delle funzioni diventano attributi, a cui si assegna un nome.

Si può omettere `Y`: le funzioni sono calcolate su tutta la relazione, come su un unico gruppo.

```text
∅ ℱ_{AVG(Stipendio), MAX(Stipendio)}(Impiegati)
```

Restituisce lo stipendio medio e quello massimo complessivi.

## Join esterni

I join esterni conservano le tuple che un join normale scarterebbe perché non hanno una controparte. Le colonne mancanti vengono completate con `NULL`.

| Operatore | Tuple sempre mantenute |
| --- | --- |
| Join esterno sinistro `⟕` | Tutte quelle del primo operando |
| Join esterno destro `⟖` | Tutte quelle del secondo operando |
| Join esterno completo `⟗` | Tutte quelle di entrambi gli operandi |

Esempio: `Impiegati ⟕ Lavora` conserva anche gli impiegati che non hanno progetti; per loro gli attributi provenienti da `Lavora` valgono `NULL`. Il join esterno destro conserva invece anche le righe di lavoro prive di una controparte in `Impiegati`; quello completo conserva entrambe le categorie.

## Divisione

`r ÷ s` trova i valori del primo operando associati a **tutte** le tuple del secondo. Se `r` ha schema `X`, `s` ha schema `Y` e `Y ⊂ X`, il risultato ha gli attributi `X \\ Y`. La divisione esprime una condizione di quantificazione universale.

Esempio con `Fornisce(F, P)`:

| F | P |
| --- | --- |
| F1 | P1 |
| F1 | P2 |
| F2 | P1 |
| F3 | P3 |

e `Prodotto(P) = {P1, P2}`:

```text
Fornisce ÷ Prodotto
```

Restituisce `{F1}`, perché F1 fornisce tutti i prodotti elencati in `Prodotto`. F2 e F3 non li forniscono tutti.

La divisione si può derivare dagli operatori di base. Sia `Z = X \\ Y`:

```text
T1(Z)  ← πZ(r)
U(X)   ← T1 × s
T2(Z)  ← πZ(U \\ r)
Ris(Z) ← T1 \\ T2
```

`U` contiene tutte le combinazioni possibili; `T2` individua i valori di `Z` che mancano almeno una combinazione richiesta. Tolti questi da `T1`, restano quelli validi per tutte le tuple di `s`.

## Valori nulli

Per selezione e join i confronti che coinvolgono `NULL` usano una logica a tre valori: vero (`V`), falso (`F`) e indefinito (`?`). Un confronto come `Città='Milano'` vale `?` se `Città` è `NULL`. La selezione mantiene solo le tuple per cui la condizione vale `V`; scarta sia `F` sia `?`.

```text
σ Città IS NULL(Impiegati)
σ Stipendio IS NOT NULL(Impiegati)
```

`IS NULL` e `IS NOT NULL` permettono di verificare esplicitamente la presenza del valore nullo. Gli altri confronti (`=`, `≠`, `<`, `≤`, `>` e `≥`) con un operando nullo restituiscono `?`; anche la negazione di `?` resta `?`.

Per gli operatori booleani valgono, tra le altre, queste regole:

| Espressione | Risultato |
| --- | --- |
| `F ∧ ?` | `F` |
| `V ∧ ?` | `?` |
| `V ∨ ?` | `V` |
| `F ∨ ?` | `?` |
| `¬?` | `?` |

Quindi `Città='Milano' ∨ Stipendio>2200` può essere vera anche se uno dei due confronti è `?`, quando l'altro è `V`. Se invece il risultato complessivo è `?`, la tupla non passa la selezione.

Nel join la condizione deve essere vera perché le tuple si combinino. Perciò un confronto con `NULL` non abbina le tuple; anche il join naturale non combina due tuple che hanno entrambe `NULL` sull'attributo comune.

Proiezione, unione, intersezione e differenza trattano `NULL` come un valore confrontabile sintatticamente: due tuple con `NULL` nelle stesse posizioni sono considerate uguali ai fini di questi operatori. Questo criterio è distinto dai confronti logici usati da selezione e join.

## Lezione 11: calcolo relazionale su tuple

Il calcolo relazionale su tuple è un linguaggio di interrogazione **dichiarativo**: specifica quali proprietà deve avere il risultato, senza descrivere la sequenza di operazioni per costruirlo. L'algebra relazionale è procedurale. I due linguaggi hanno lo stesso potere espressivo; un linguaggio con questo potere si dice relazionalmente completo. Il calcolo relazionale è una base formale di SQL, che include anche funzionalità ulteriori, come aggregazioni, ordinamento e aggiornamenti.

### Forma di una query

Un'espressione ha la forma:

```text
{ T | C }
```

- `T` è la lista degli attributi da restituire, scritti come `t.A`, dove `t` è una variabile di tupla e `A` un attributo della relazione cui `t` appartiene.
- `C` è una condizione, cioè una formula che stabilisce quali tuple soddisfano la query.

In `T` possono comparire solo variabili **libere** in `C`: non devono essere legate da un quantificatore. Il risultato contiene i valori degli attributi di `T` per le assegnazioni che rendono `C` vera.

### Atomi e formule

Gli atomi sono le condizioni elementari:

| Tipo | Esempio | Significato |
| --- | --- | --- |
| Appartenenza a relazione | `Employee(t)` | La tupla `t` appartiene a `Employee` |
| Confronto tra attributi | `t.A = s.B` | I valori degli attributi sono in relazione secondo `θ` |
| Confronto con costante | `t.Lname = 'Bo'` | L'attributo è confrontato con una costante |

Il confronto `θ` può essere `=`, `≠`, `<`, `>`, `≤` o `≥`. Gli atomi si combinano con `∧`, `∨`, `¬` e con i quantificatori esistenziale `∃` e universale `∀`.

### Variabili libere, legate e quantificatori

Una variabile è **libera** se non è quantificata nella formula; diventa **legata** nelle occorrenze comprese nell'ambito di `∃t` o `∀t`.

```text
Department(d) ∧ d.Dnumber = t.Dnumber
```

Qui `d` e `t` sono libere. Invece:

```text
∃d (Department(d) ∧ d.Dnumber = t.Dnumber)
```

`d` è legata da `∃d`, mentre `t` resta libera.

- `∃t F` è vera se esiste almeno una tupla assegnabile a `t` che rende vera `F`.
- `∀t F` è vera se ogni tupla assegnabile a `t` rende vera `F`.

### Esempio

Per ottenere data di nascita e indirizzo dell'impiegata Lia Bo:

```text
{ t.Bdate, t.Address |
  Employee(t) ∧ t.Fname = 'Lia' ∧ t.Lname = 'Bo'
}
```

`Employee(t)` restringe `t` alle tuple della relazione; le uguaglianze selezionano Lia Bo; la target list restituisce solo `Bdate` e `Address`. L'espressione corrisponde a una selezione seguita da una proiezione in algebra relazionale.

## Promemoria rapido

| Cosa vuoi ottenere | Operatore |
| --- | --- |
| Filtrare righe | Selezione `σ` |
| Scegliere colonne | Proiezione `π` |
| Combinare ogni coppia di righe | Prodotto `×` |
| Combinare righe secondo una condizione | Join `⋈F` |
| Combinare righe sugli attributi comuni | Join naturale `⋈` |
| Conservare righe senza controparte | Join esterno `⟕`, `⟖`, `⟗` |
| Calcolare valori per gruppo | Raggruppamento `ℱ` |
| Trovare chi soddisfa tutti i requisiti | Divisione `÷` |
| Unire, confrontare o sottrarre insiemi compatibili | `∪`, `∩`, `\\` |

