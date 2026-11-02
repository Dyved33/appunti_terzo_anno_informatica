# Ripasso I - Algebra relazionale

Gli operatori prendono una o due relazioni e restituiscono una relazione. L'algebra relazionale è procedurale: una query descrive le operazioni da eseguire. Le operazioni si possono comporre, usando il risultato di un operatore come argomento di quello successivo.

Negli esempi principali useremo questi schemi:

- `Impiegati(Matricola, Cognome, Dipartimento, Stipendio)`
- `Progetti(CodiceP, NomeP, Dipartimento)`
- `Lavora(Matricola, CodiceP, Ore)`
- `Dipartimenti(CodiceD, NomeD)`
- `Sedi(CodiceS, Città)` e `SediAttive(CodiceS, Città)`
- `Fornisce(F, P)` e `Prodotto(P)`

Ogni schema elenca gli attributi delle tuple; quando mostriamo righe, useremo valori coerenti con questi attributi. Nella sezione sul calcolo relazionale useremo anche `Employee(Fname, Lname, Bdate, Address)` e `Department(Dnumber, Dname)`, come nella notazione della lezione.

## Ridenominazione

`ρ` cambia il nome della relazione e/o quello dei suoi attributi, senza modificare i valori delle tuple. È utile per rendere espliciti i nomi, evitare ambiguità o preparare operazioni tra relazioni.

```text
ρ Dip(CodiceD → Dipartimento)(Dipartimenti)
```

Il risultato si chiama `Dip`; il suo attributo `CodiceD` prende il nome `Dipartimento`. I valori e il numero delle tuple restano invariati. In questo esempio, `CodiceD` deve appartenere allo schema della relazione rinominata.

## Operatori insiemistici

Unione, intersezione e differenza richiedono relazioni **compatibili all'unione**: stesso numero di attributi e domini corrispondenti uguali, nello stesso ordine. I nomi degli attributi possono essere diversi; il risultato usa quelli del primo operando. Le relazioni sono insiemi, quindi una tupla ripetuta compare una volta sola.

Poniamo `Milano = σ Città='Milano'(Sedi)` e `Roma = σ Città='Roma'(Sedi)`. Entrambe hanno schema `(CodiceS, Città)`, quindi sono compatibili all'unione:

| Operatore | Significato | Esempio |
| --- | --- | --- |
| Unione `r ∪ s` | Tuple in `r` oppure in `s` | `Milano ∪ Roma`: sedi di Milano o Roma |
| Intersezione `r ∩ s` | Tuple sia in `r` sia in `s` | `Milano ∩ SediAttive`: sedi di Milano che sono attive |
| Differenza `r \\ s` | Tuple in `r` ma non in `s` | `Sedi \\ SediAttive`: sedi non attive |

L'intersezione è derivabile: `r ∩ s = r \\ (r \\ s)`.

## Prodotto cartesiano

`r × s` abbina ogni tupla di `r` con ogni tupla di `s`. Gli schemi devono avere attributi disgiunti; se hanno attributi omonimi, si rinominano prima per distinguere le colonne. Se `r` ha 3 tuple e `s` ne ha 4, il prodotto ha `3 × 4 = 12` tuple.

```text
Impiegati × Progetti
```

Forma tutte le coppie impiegato-progetto, anche quelle senza relazione logica. Per esempio, ogni impiegato viene accoppiato a ogni progetto. Di solito il prodotto cartesiano si combina con una selezione per tenere solo le coppie collegate da una condizione: questa è la costruzione del θ-join.

## Selezione

`σ_F(r)` mantiene le tuple di `r` per cui la condizione `F` è vera. Non elimina né riordina attributi: il risultato conserva lo schema di `r`.

Le condizioni atomiche confrontano un attributo con un altro (`A θ B`) o con una costante (`A θ c`), usando `=`, `≠`, `<`, `≤`, `>` o `≥`. Si combinano con `∧`, `∨` e `¬`.

```text
σ Stipendio > 2000 ∧ Dipartimento='Informatica' (Impiegati)
```

Seleziona gli impiegati del dipartimento di Informatica con stipendio superiore a 2000. Se più selezioni sono consecutive, si possono accorpare: `σF(σG(r)) = σF∧G(r)`.

## Proiezione

`π_Y(r)` conserva soltanto gli attributi in `Y`. Le tuple che diventano uguali dopo aver tolto le altre colonne si riducono a una sola, perché una relazione è un insieme e non contiene duplicati.

```text
π Cognome, Stipendio (Impiegati)
```

Restituisce cognome e stipendio, senza duplicati. Se serve filtrare e poi scegliere le colonne:

```text
π Cognome (σ Dipartimento='Informatica' (Impiegati))
```

## Join (concatenazione)

Il join combina tuple collegate da una condizione. Per il θ-join, i nomi degli attributi dei due operandi devono essere distinguibili; se coincidono, si rinominano prima. La condizione specifica quali coppie del prodotto cartesiano mantenere.

### θ-join ed equijoin

Il θ-join applica una condizione di confronto alle coppie del prodotto cartesiano:

```text
r ⋈F s = σF(r × s)
```

Un **equijoin** è un θ-join la cui condizione contiene solo uguaglianze.

```text
Impiegati ⋈ Impiegati.Matricola=Lavora.Matricola Lavora
```

Abbina ogni impiegato alle righe di `Lavora` con la stessa matricola; nel risultato la matricola compare in entrambe le colonne. Anche una condizione con un confronto diverso dall'uguaglianza, per esempio `Impiegati.Stipendio > Lavora.Ore`, definisce un θ-join, purché gli attributi confrontati abbiano domini confrontabili.

### Join naturale

`r ⋈ s` abbina tuple che hanno valori uguali su **tutti** gli attributi comuni e lascia una sola copia di ciascuno di questi attributi nel risultato. Se non ci sono attributi in comune, coincide con il prodotto cartesiano.

```text
Impiegati ⋈ Lavora
```

Le due relazioni condividono `Matricola`: il join combina ogni impiegato con le sue righe in `Lavora` e presenta `Matricola` una volta sola. Se una matricola compare in `Impiegati` ma non in `Lavora`, quella tupla non compare nel risultato. Il join naturale è adatto quando gli attributi comuni rappresentano davvero la stessa informazione; nomi uguali per caso possono produrre abbinamenti indesiderati.

Il join è derivabile da prodotto cartesiano e selezione; il join naturale è derivabile anche da equijoin e proiezione, eliminando la copia degli attributi comuni.

## Raggruppamento e funzioni aggregate

La notazione `Y ℱ_listaFun(r)` raggruppa le tuple con gli stessi valori sugli attributi `Y` e calcola le funzioni aggregate indicate su ciascun gruppo. Ogni gruppo produce una tupla con gli attributi di raggruppamento e i risultati delle funzioni. Le funzioni trattate sono `SUM`, `AVG`, `MAX`, `MIN` e `COUNT`; a ciascun risultato va assegnato un nome di attributo.

```text
Dipartimento ℱ_{AVG(Stipendio), COUNT(Matricola)}(Impiegati)
```

Produce una riga per ogni dipartimento presente in `Impiegati`, con il valore medio degli stipendi e il numero di matricole. Le colonne aggregate del risultato vanno nominate, per esempio `MediaStipendio` e `NumeroImpiegati`.

Si può omettere `Y` (oppure indicare l'insieme vuoto `∅`): le funzioni sono calcolate su tutta la relazione, considerata come un unico gruppo.

```text
∅ ℱ_{AVG(Stipendio), MAX(Stipendio)}(Impiegati)
```

Restituisce lo stipendio medio e quello massimo complessivi.

## Join esterni

I join esterni conservano anche le tuple che un join normale scarterebbe perché non hanno una controparte. Per ogni tupla senza corrispondenza, le colonne provenienti dall'altro operando vengono completate con `NULL`.

| Operatore | Tuple sempre mantenute |
| --- | --- |
| Join esterno sinistro `⟕` | Tutte quelle del primo operando |
| Join esterno destro `⟖` | Tutte quelle del secondo operando |
| Join esterno completo `⟗` | Tutte quelle di entrambi gli operandi |

Esempio: `Impiegati ⟕ Lavora` conserva anche gli impiegati che non hanno righe in `Lavora`; per loro `CodiceP` e `Ore` valgono `NULL`. Il join esterno destro conserva anche le righe di lavoro prive di una controparte in `Impiegati`; quello completo conserva entrambe le categorie di tuple senza corrispondenza.

## Divisione

`r ÷ s` trova i valori del primo operando associati a **tutte** le tuple del secondo. Se `r` ha schema `X`, `s` ha schema `Y` e `Y ⊂ X`, il risultato ha gli attributi `X \\ Y`. La divisione esprime una condizione di quantificazione universale: ogni valore restituito deve essere associato, in `r`, a ciascuna tupla di `s`.

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

Restituisce `{F1}`, perché F1 fornisce sia P1 sia P2, cioè tutti i prodotti presenti in `Prodotto`. F2 non fornisce P2 e F3 non fornisce né P1 né P2, quindi non soddisfano la condizione universale.

La divisione si può derivare dagli operatori di base. Sia `Z = X \\ Y`:

```text
T1(Z)  ← πZ(r)
U(X)   ← T1 × s
T2(Z)  ← πZ(U \\ r)
Ris(Z) ← T1 \\ T2
```

`T1` contiene i possibili valori candidati di `Z`. `U` contiene tutte le combinazioni tra quei valori e le tuple di `s`; `T2` individua i candidati per cui manca almeno una combinazione richiesta. Tolti questi da `T1`, restano quelli validi per tutte le tuple di `s`.

## Valori nulli

Nella semantica estesa trattata a lezione, selezione e join valutano i confronti che coinvolgono `NULL` con una logica a tre valori: vero (`V`), falso (`F`) e indefinito (`?`). Un confronto come `Città='Milano'` vale `?` se `Città` è `NULL`. La selezione mantiene solo le tuple per cui la condizione vale `V`; scarta sia `F` sia `?`.

```text
σ Città IS NULL(Impiegati)
σ Stipendio IS NOT NULL(Impiegati)
```

`IS NULL` e `IS NOT NULL` permettono di verificare esplicitamente se un attributo contiene `NULL`; queste condizioni restituiscono `V` o `F`. Gli altri confronti (`=`, `≠`, `<`, `≤`, `>` e `≥`) con un operando nullo restituiscono `?`; anche la negazione di `?` resta `?`.

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

Secondo la convenzione adottata nella lezione, proiezione, unione, intersezione e differenza confrontano le tuple in modo sintattico: due tuple con `NULL` nelle stesse posizioni sono considerate uguali ai fini di questi operatori. Questo criterio è distinto dai confronti logici usati da selezione e join: non significa che il predicato `NULL = NULL` valga `V`.

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

Per ottenere data di nascita e indirizzo dell'impiegata Lia Bo, consideriamo una variabile `t` che rappresenta una tupla di `Employee`. La formula la limita alle tuple con nome e cognome richiesti; la target list seleziona poi i due attributi da restituire:

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

