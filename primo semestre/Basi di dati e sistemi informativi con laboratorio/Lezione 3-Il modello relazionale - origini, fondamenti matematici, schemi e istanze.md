# Il modello relazionale: origini, fondamenti matematici, schemi e istanze

## Le origini del modello relazionale

Il **modello relazionale** è stato teorizzato nel 1970 da **Edgar F. Codd**, ricercatore presso i laboratori IBM di San Jose, con l'obiettivo primario di garantire una reale e rigorosa **indipendenza dei dati**, sia logica che fisica, rispetto alle applicazioni software. Commercializzato a partire dai primi anni '80, con l'avvento di piattaforme pionieristiche come *Oracle* e *IBM DB2*, dopo i prototipi di ricerca quali *System R*, rappresenta oggi il paradigma dominante dell'industria del software, sotteso alla totalità dei più diffusi DBMS commerciali e open source.

```
┌────────────────────────────────────────────────────────────────────────┐
│                        Fattori del Successo                            │
├───────────────────────────────────┬────────────────────────────────────┤
│     Semplicità Concettuale        │       Linguaggi Dichiarativi       │
├───────────────────────────────────┼────────────────────────────────────┤
│ La base di dati è percepita dagli │ Interrogazione e manipolazione     │
│ utenti in modo estremamente       │ ad alto livello (SQL, Algebra      │
│ intuitivo come un insieme         │ Relazionale): si specifica COSA    │
│ omogeneo di tabelle bidimensionali│ reperire, demandando al DBMS il    │
│ composte da righe e colonne.      │ COME eseguire l'accesso fisico.    │
└───────────────────────────────────┴────────────────────────────────────┘
```

## La discontinuità rispetto ai modelli precedenti

1. **Rappresentazione delle associazioni tra record.** I modelli gerarchico e reticolare utilizzano **puntatori fisici espliciti** e indirizzi di memoria incorporati nei record per collegare le strutture dati (*pointer-based*): la navigazione è vincolata ai cammini fisici previsti dal progettista. Il modello relazionale basa invece le associazioni interamente sui **valori dei dati** condivisi (*value-based*): i collegamenti logici vengono stabiliti confrontando i valori contenuti in campi correlati, per esempio la corrispondenza tra chiave primaria e chiave esterna, senza alcun ricorso a puntatori fisici esposti.
2. **Fondamento formale e matematico.** I modelli gerarchico e reticolare derivavano da approcci euristici e soluzioni implementative *ad hoc*; il modello relazionale poggia su solide basi formali tratte dalla **teoria matematica degli insiemi** e dalla **logica dei predicati del primo ordine**, consentendo la dimostrazione formale di equivalenze tra espressioni e l'ottimizzazione automatica delle query.

## I fondamenti matematici

Siano $D_1, D_2, \dots, D_n$ $n$ insiemi, detti insiemi di supporto o domini, non necessariamente distinti.

*Definizione:* il **prodotto cartesiano** $D_1 \times D_2 \times \dots \times D_n$ è l'insieme di tutte le $n$-uple ordinate $(d_1, d_2, \dots, d_n)$ tali che ciascun elemento $d_i$ appartenga al rispettivo dominio $D_i$:

$$
D_1 \times D_2 \times \dots \times D_n = \{ (d_1, d_2, \dots, d_n) \mid d_1 \in D_1, d_2 \in D_2, \dots, d_n \in D_n \}
$$

*Definizione:* una **relazione matematica** $R$ definita sugli insiemi $D_1, D_2, \dots, D_n$ è un qualsiasi sottoinsieme del loro prodotto cartesiano:

$$
R \subseteq D_1 \times D_2 \times \dots \times D_n
$$

- **Grado di una relazione:** è il numero $n$ di insiemi o domini componenti il prodotto cartesiano, ovvero il numero di componenti di ciascuna $n$-upla.
- **Cardinalità di una relazione** $|R|$: è il numero complessivo di elementi, cioè di $n$-uple, appartenenti all'insieme $R$.

## Dalle relazioni matematiche alle relazioni del modello

Sebbene poggia sulla nozione matematica di relazione, il modello relazionale introduce due importanti adattamenti per rispondere alle esigenze pratiche di memorizzazione e manipolazione dei dati:

1. **Assenza di ordinamento posizionale:** nelle relazioni matematiche gli elementi di una $n$-upla sono rigidamente ordinati per posizione; nelle basi di dati la sequenza orizzontale delle colonne non deve avere rilevanza semantica.
2. **Identificazione tramite attributi:** conviene associare a ciascuna componente un **nome simbolico**, l'attributo (per esempio `Nome`, `Matricola`, `Stipendio`), anziché identificarla tramite il suo indice numerico posizionale $i$.

## Domini, attributi e tuple

*Definizione:* un **dominio** $D$ è un insieme non vuoto di valori atomici, indivisibili dal punto di vista del DBMS. Con $\text{Dom}(A)$ indichiamo il dominio formalmente associato all'attributo $A$: per esempio $\text{Dom}(\text{Nazione})$ è l'insieme delle stringhe di caratteri indicanti nomi validi di stati sovrani, mentre $\text{Dom}(\text{Voto})$ è l'insieme dei numeri interi $\{18, 19, \dots, 30, 30L\}$.

Un **attributo** $A$ è un'etichetta o nome simbolico associato a un determinato dominio con un preciso significato semantico all'interno dello schema.

Sia $X = \{A_1, A_2, \dots, A_n\}$ un insieme finito di attributi.

*Definizione:* una **tupla** $t$ definita sull'insieme di attributi $X$ è una funzione che associa a ogni attributo $A_i \in X$ un valore appartenente al suo dominio $\text{Dom}(A_i)$, oppure lo speciale valore `NULL`:

$$
t: X \rightarrow \bigcup_{A_i \in X} \text{Dom}(A_i) \cup \{\text{NULL}\} \quad \text{tale che} \quad t[A_i] \in \text{Dom}(A_i) \lor t[A_i] = \text{NULL}
$$

Con la notazione $t[A_i]$ (o $t.A_i$) si indica il valore assunto dalla tupla $t$ in corrispondenza dell'attributo $A_i$.

> [!info] Il valore speciale NULL:
> Indica l'assenza di un valore reale e rappresenta tre condizioni semantiche distinte:
> 1. valore **sconosciuto**, per esempio la data di nascita non ancora registrata;
> 2. valore **inesistente o non applicabile**, per esempio il numero di patente di un cittadino non patentato;
> 3. valore **omesso o riservato**.

## Schemi e istanze di relazione

*Definizione:* dato un insieme di attributi $X = \{A_1, A_2, \dots, A_n\}$, uno **schema di relazione** è costituito da un nome di relazione $R$ e dall'insieme di attributi $X$:

$$
R(X) \quad \text{oppure} \quad R(A_1, A_2, \dots, A_n)
$$

Qualora sia necessario esplicitare i domini di riferimento si adotta la notazione estesa:

$$
R(A_1: \text{Dom}(A_1), A_2: \text{Dom}(A_2), \dots, A_n: \text{Dom}(A_n))
$$

*Definizione:* dato uno schema di relazione $R(X)$, un'**istanza di relazione** $r(R)$, o semplicemente $r$ su $X$, è un **insieme finito di tuple** su $X$:

$$
r(R) = \{t_1, t_2, \dots, t_k\}
$$

Poiché un'istanza è matematicamente un **insieme** di tuple, non possono esistere tuple duplicate identiche all'interno della medesima istanza e l'ordine delle tuple, cioè delle righe, non ha alcuna rilevanza.

## Schemi e istanze di base di dati

*Definizione:* uno **schema di base di dati** $\mathcal{B}$ è una collezione di schemi di relazione con denominazioni distinte:

$$
\mathcal{B} = \{R_1(X_1), R_2(X_2), \dots, R_m(X_m)\}
$$

corredato dalla specifica dell'insieme dei relativi **vincoli di integrità** $\mathcal{I}$.

*Definizione:* un'**istanza di base di dati** $b$ definita sullo schema $\mathcal{B} = \{R_1(X_1), \dots, R_m(X_m)\}$ è un insieme di istanze di relazione:

$$
b = \{r_1, r_2, \dots, r_m\}
$$

tale che ciascuna $r_i$ sia un'istanza valida dello schema di relazione $R_i(X_i)$, per ogni $i \in \{1, \dots, m\}$, e rispetti l'insieme dei vincoli $\mathcal{I}$.

## L'esempio di formalizzazione

Si consideri lo schema universitario $\mathcal{B} = \{\text{Studente}(\text{Matricola}, \text{Nome}), \text{Corso}(\text{Codice}, \text{Nome}), \text{Iscrizione}(\text{Studente}, \text{Corso})\}$.

```
Istanza Studente (r_Studente):
┌───────────┬──────────────┐
│ Matricola │ Nome         │
├───────────┼──────────────┤
│ 37891     │ Mario Rossi  │
│ 5421      │ Luigi Verdi  │
└───────────┴──────────────┘

Istanza Corso (r_Corso):
┌────────┬──────────────┐
│ Codice │ Nome         │
├────────┼──────────────┤
│ 1      │ BD           │
│ 2      │ ASD          │
└────────┴──────────────┘

Istanza Iscrizione (r_Iscrizione):
┌──────────┬───────┐
│ Studente │ Corso │
├──────────┼───────┤
│ 37891    │ 1     │
│ 37891    │ 2     │
└──────────┴───────┘
```

Nel formalismo matematico delle funzioni e delle tuple l'istanza globale corrisponde all'insieme:

$$
b = \left\{
\begin{aligned}
&\{ \{(\text{Matricola}, 37891), (\text{Nome}, \text{"Mario Rossi"})\}, \{(\text{Matricola}, 5421), (\text{Nome}, \text{"Luigi Verdi"})\} \}, \\
&\{ \{(\text{Codice}, 1), (\text{Nome}, \text{"BD"})\}, \{(\text{Codice}, 2), (\text{Nome}, \text{"ASD"})\} \}, \\
&\{ \{(\text{Studente}, 37891), (\text{Corso}, 1)\}, \{(\text{Studente}, 37891), (\text{Corso}, 2)\} \}
\end{aligned}
\right\}
$$

## La mappatura terminologica

| Concetto formale (modello relazionale) | Equivalente tabellare informale | Corrispettivo nei file tradizionali |
| :--- | :--- | :--- |
| **Relazione** | Tabella | File |
| **Attributo** | Intestazione di colonna / campo | Campo del record |
| **Tupla** | Riga della tabella | Singolo record |
| **Dominio** | Tipo di dato e vincoli di colonna | Tipo di dato del campo |
| **Grado** | Numero di colonne della tabella | Numero di campi per record |
| **Cardinalità** | Numero di righe della tabella | Numero di record nel file |
| **Schema di relazione** | Struttura / DDL dell'intestazione | Definizione del tracciato record |
| **Istanza di relazione** | Insieme corrente di righe popolate | Contenuto del file su disco |

> [!info] Sintesi:
> - Codd teorizza il modello relazionale nel 1970 per ottenere indipendenza logica e fisica dei dati; oggi è il paradigma dominante, alla base del linguaggio SQL.
> - Rispetto a gerarchico e reticolare, le associazioni sono *value-based* e non con puntatori fisici, e il modello ha basi formali in teoria degli insiemi e logica del primo ordine.
> - La relazione matematica è un sottoinsieme del prodotto cartesiano dei domini: il grado è il numero di domini, la cardinalità il numero di tuple.
> - Nel modello le tuple non sono ordinate e gli attributi sono nominati; `NULL` indica valore sconosciuto, inesistente o omesso.
> - Schema di relazione $R(X)$ e istanza $r(R) = \{t_1, \dots, t_k\}$; schema di base di dati $\mathcal{B}$ e istanza $b = \{r_1, \dots, r_m\}$ con vincoli $\mathcal{I}$.
> - In pratica relazione è tabella, tupla è riga, attributo è colonna, dominio è il tipo di dato della colonna, e l'istanza è il contenuto corrente del file.