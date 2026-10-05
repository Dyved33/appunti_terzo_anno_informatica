# Vincoli di integrità nel modello relazionale

## I vincoli di integrità e la loro classificazione

*Definizione:* i **vincoli di integrità** sono predicati posti sui valori effettivi che caratterizzano uno stato, o istanza, di base di dati: uno stato è ammissibile solo se li soddisfa tutti, e la loro violazione rende lo stato incoerente rispetto al mini-mondo rappresentato.

Si distinguono quattro categorie:

1. **Vincoli intrinseci, basati sul modello:** imposti dalla struttura stessa del [[Lezione 3-Il modello relazionale - origini, fondamenti matematici, schemi e istanze|modello relazionale]], non richiedono di essere dichiarati esplicitamente e sono soddisfatti per costruzione da ogni costruzione consentita dal modello.
2. **Vincoli basati sullo schema:** esprimibili direttamente sugli schemi del modello dei dati mediante il linguaggio di definizione **DDL** (*data definition language*), e quindi verificati dal DBMS in modo automatico e centralizzato.
3. **Vincoli non esprimibili sullo schema:** non possono essere formalizzati negli schemi del modello dei dati e devono essere specificati realizzando programmi applicativi; la loro verifica è quindi demandata al codice applicativo e non è garantita dal DBMS.
4. **Vincoli di dipendenza funzionale:** costituiscono un ulteriore e importante insieme di vincoli, impiegati principalmente per verificare la qualità della progettazione di basi di dati relazionali.

> [!example] Il vincolo di assenza di tuple duplicate
> Il divieto per una relazione di contenere **tuple duplicate** è un vincolo intrinseco al modello relazionale: non è dichiarato in alcun modo, eppure ogni istanza ammissibile lo rispetta. Il motivo è formale: poiché un'istanza di relazione è matematicamente un **insieme** di tuple, per definizione non può contenere due elementi identici.

> [!important] Dove viene imposto il vincolo
> Le quattro categorie si distinguono in funzione del soggetto che assume la responsabilità di fare rispettare il vincolo: il **modello** dei dati, che lo garantisce da solo e senza dichiarazione; lo **schema**, che lo dichiara in DDL e ne affida la verifica al DBMS; i **programmi applicativi**, che devono codificarlo a mano con i margini di errore che ne conseguono. Le dipendenze funzionali hanno invece un ruolo diverso da tutti gli altri: non vengono usate per reprimere stati incoerenti, ma per valutare la bontà della progettazione.

## I vincoli basati sullo schema

I **vincoli basati sullo schema**, oggetto di studio sistematico di questa lezione, sono i vincoli esprimibili direttamente negli schemi del modello dei dati tramite il DDL. La loro formalizzazione nello schema ha due conseguenze decisive:

- **Centralizzazione della verifica:** il vincolo diventa parte della descrizione formale della base di dati, anziché logica disseminata nei programmi che la accedono.
- **Verifica automatica a ogni operazione:** il DBMS può controllare il rispetto del vincolo in corrispondenza di ogni operazione di aggiornamento, impedendo che uno stato non ammissibile venga mai materializzato.

A loro volta i vincoli basati sullo schema si suddividono in due famiglie, distinte per l'ampiezza dell'ambito che coinvolgono:

| Famiglia | Ambito di coinvolgimento | Portata della verifica |
| :--- | :--- | :--- |
| **Vincoli intrarelazionali** | Coinvolgono un unico schema di relazione | Verificabili relazione per relazione, in isolamento |
| **Vincoli interelazionali** | Coinvolgono più schemi di relazioni | Richiedono di considerare contemporaneamente lo stato di più relazioni della base di dati |

La distinzione è operativamente netta: la verifica di un vincolo intrarelazionale è un controllo *locale*, confinato all'interno di una singola relazione; quella di un vincolo interelazionale è un controllo *globale*, che deve tenere conto contemporaneamente del contenuto di più istanze di relazione e presuppone quindi un meccanismo di coordinazione tra le strutture coinvolte.

## I vincoli intrarelazionali

I vincoli intrarelazionali più importanti sono di due tipi.

**Vincoli di tupla:** coinvolgono uno o più valori della **stessa** tupla. I più comuni sono:

- **vincoli di dominio:** restringono i valori attribuibili a un attributo;
- **vincoli su più valori della stessa tupla:** mettono in relazione attributi diversi della stessa tupla;
- **vincoli di valore non nullo:** vietano che un attributo assuma il valore `NULL`.

**Vincoli di univocità:** vietano a due tuple di una stessa istanza di coincidere sui valori di un dato sottoinsieme di attributi.

> [!example] I vincoli intrarelazionali di ESAME
> Dato lo schema $\text{ESAME}(\text{matricola}, \text{corso}, \text{voto}, \text{lode})$, sono vincoli intrarelazionali:
> - il **vincolo di dominio** $18 \leq \text{voto} \leq 30$;
> - il **vincolo su più valori della stessa tupla** $\text{lode} = \text{yes}$ solo se $\text{voto} = 30$;
> - il **vincolo di valore non nullo** che specifica che `matricola` non può essere `NULL`;
> - il **vincolo di univocità** su $\{ \text{matricola}, \text{corso} \}$: non esistono due tuple che coincidono contemporaneamente su entrambi i valori.

## Il vincolo di univocità

*Definizione:* sia $R(X)$ uno schema di relazione e sia $Y \subseteq X$, $Y \neq \emptyset$ un insieme di attributi sottoposto a vincolo di univocità, in simboli $UNI: Y$. Un'istanza $r$ su $R$ soddisfa il vincolo di univocità su $Y$ se e solo se, per ogni coppia di tuple $t_1, t_2 \in r$ con $t_1 \neq t_2$, esiste un attributo $A \in Y$ tale che:

$$
t_1[A] \neq t_2[A] \quad \text{oppure} \quad t_1[A] \text{ è nullo} \quad \text{oppure} \quad t_2[A] \text{ è nullo}
$$

> [!info] In altre parole:
> Due righe violano `UNI:Y` solo se coincidono su **tutti** gli attributi di $Y$ e nessuno di questi è `NULL`. I `NULL` non sono considerati uguali fra loro, quindi righe diverse possono avere `NULL` sugli stessi attributi senza violare il vincolo.

## Il concetto di chiave

I vincoli di valore non nullo e di univocità appena definiti permettono di introdurre superchiavi, chiavi candidate e chiave primaria. Data $R(X)$ e un insieme di attributi $K \subseteq X$:

- $K$ è una **superchiave** se e solo se in ogni istanza ammissibile $r$ di $R(X)$ non esistono due tuple distinte $t_1, t_2 \in r$ tali che $t_1[K] = t_2[K]$. Una superchiave è dunque un insieme di attributi sottoposto a vincolo di univocità, $UNI: K$.
- $K$ è una **chiave candidata** se e solo se $K$ è una **superchiave minimale**, cioè non esiste $K' \subset K$ dove $K'$ è una superchiave.

> [!example] Superchiavi e chiavi candidate di STUDENTI
> Dato lo schema $\text{STUDENTI}(\text{matricola}, \text{codiceFiscale}, \text{cognome}, \text{nome}, \text{dataNascita})$:
> - $Z = \{ \text{matricola} \}$ è una chiave candidata di `STUDENTI`;
> - $W = \{ \text{codiceFiscale} \}$ è una chiave candidata di `STUDENTI`;
> - qualunque insieme di attributi che contiene $Z$ oppure $W$ è una superchiave di `STUDENTI`.

> [!warning] Il problema dei NULL
> Nell'istanza mostrata dal docente una tupla ha il `codiceFiscale` a `NULL` e un'altra ha la `matricola` a `NULL`. Poiché i `NULL` non sono uguali fra loro, né l'univocità su `matricola` né quella su `codiceFiscale` identificano quelle tuple in modo affidabile.

## Il vincolo di integrità dell'entità e la chiave primaria

Per evitare i problemi dell'esempio precedente è necessario scegliere una chiave candidata che svolga il ruolo di **chiave primaria**, sulla quale non si ammettono valori nulli. Gli attributi di chiave primaria sono convenzionalmente sottolineati nello schema.

*Definizione:* il **vincolo di integrità dell'entità** stabilisce che nessun attributo facente parte della chiave primaria può assumere valore nullo.

> [!important] I due vincoli che definiscono la chiave primaria
> Una chiave primaria è, insieme, un insieme di attributi con `UNI` (che rende identificata ciascuna tupla) e sottoposto a vincolo di integrità dell'entità (che impedisce che l'identificazione venga persa perché un suo attributo sia `NULL`). Per questo ogni tabella ammette una sola chiave primaria, che implica le proprietà di `UNIQUE` e `NOT NULL` (cfr. [[Lezione 5-Il linguaggio SQL, il DDL e PostgreSQL#Vincoli intrarelazionali|la sintassi DDL]]).

## I vincoli interelazionali: le chiavi esterne

Per evitare i problemi dell'esempio precedente si introducono i **vincoli di integrità referenziale**, specificati mediante il concetto di **chiave esterna**. Si consideri lo schema universitario con tre relazioni, `STUDENTI(matricola, nome, cognome, data di nascita, sesso, residenza)`, `CORSO(codice, CFU, anno)` e `ISCRIZIONE(studente, corso)`: l'iscrizione è lecita solo se lo studente e il corso esistono davvero.

**Chiave esterna semplice.** Siano $R(X)$ e $S(Y)$ due schemi di relazione in una base di dati $B = \{R, S, \dots\}$. Una chiave esterna semplice di $R$ che fa riferimento a $S$ è definita da:

- un attributo $A \in X$;
- un attributo $B' \in Y$ tale che $\text{Dom}(A) = \text{Dom}(B')$ e $UNI: \{B'\}$, cioè $B'$ è sottoposto a vincolo di univocità;
- un **vincolo di integrità referenziale** sulla coppia di attributi $(A, B')$: per ogni istanza $\{r, s, \dots\}$ della base di dati, l'insieme dei valori di $A$ in $r$ **non nulli** è un sottoinsieme dei valori di $B'$ in $s$.

La chiave esterna si denota con la notazione $CE: A \rightarrow S(B')$, cioè l'attributo $A$ di $R$ punta all'attributo $B'$ di $S$.

> [!example] Le due chiavi esterne di ISCRIZIONE
> Su $\text{ISCRIZIONE}(\text{studente}, \text{corso})$ servono due chiavi esterne:
> $CE: \text{studente} \rightarrow \text{STUDENTI}(\text{matricola})$ e $CE: \text{corso} \rightarrow \text{CORSO}(\text{codice})$.

I vincoli di integrità referenziali possono essere illustrati anche graficamente sul diagramma di schema della base di dati: ogni relazione è un nodo e le chiavi esterne sono archi che la collegano a quelle che referenzia, così che dal diagramma si legge a colpo d'occhio il grafo degli riferimenti fra tabelle.

**Chiave esterna composta.** Siano ancora $R(X)$ e $S(Y)$ due schemi di relazione. Una chiave esterna composta di $R$ che fa riferimento a $S$ è definita da:

- una lista ordinata di attributi $L = \langle A_1, \dots, A_m \rangle$, con $\{A_1, \dots, A_m\} \subseteq X$;
- una lista ordinata di attributi $L' = \langle B_1, \dots, B_m \rangle$, con $\{B_1, \dots, B_m\} \subseteq Y$, tale che $\forall i = 1 \dots m: \text{Dom}(A_i) = \text{Dom}(B_i)$ e $UNI: \{B_1, \dots, B_m\}$;
- un vincolo di integrità referenziale che stabilisce: per ogni istanza $\{r, s, \dots\}$ della base di dati, per ogni tupla $t \in r$ **senza valori nulli** sugli attributi della lista $L$, esiste una tupla $t' \in s$ tale che $\forall i = 1 \dots m: t[A_i] = t'[B_i]$.

> [!warning] Il vincolo referenziale tollera i NULL
> Nella definizione formale la condizione vale solo per le tuple senza valori nulli su $L$: una chiave esterna può quindi contenere `NULL`, e quel `NULL` non è un riferimento pendente. È il motivo per cui una cancellazione può violare l'integrità referenziale solo se restano tuple che la referenziano con valori effettivi.

## Schema e istanza di base di dati

Con i vincoli definiti si può dare la definizione completa delle nozioni di schema e istanza di base di dati.

*Definizione:* uno **schema di base di dati** è definito da un insieme di schemi di relazione con nomi diversi, dalla definizione delle **chiavi primarie** di ogni schema di relazione e da un insieme di ulteriori **vincoli di integrità** sullo schema di base di dati.

*Definizione:* un'**istanza di base di dati** sullo schema $B = \{R_1(X_1), \dots, R_n(X_n)\}$ è un insieme di istanze di relazione $\{r_1, \dots, r_n\}$ tali che $\forall i \in \{1 \dots n\}$, $r_i$ è un'istanza di $R_i$ che soddisfa i vincoli di integrità associati a $R_i$.

> [!info] In altre parole:
> Lo schema dice **quali** dati sono ammessi (nomi, domini, chiavi, vincoli); l'istanza dice **quali** dati sono effettivamente presenti, e per essere legittima deve rispettare tutti i vincoli dello schema. La formalizzazione matematica completa è in [[Lezione 3-Il modello relazionale - origini, fondamenti matematici, schemi e istanze#Schemi e istanze di base di dati|Schemi e istanze di base di dati]].

## Le operazioni nel modello relazionale

Un'**operazione** sul modello relazionale è una trasformazione che produce una relazione modificata a partire dalle relazioni della base di dati. La lezione mostra che lo stesso effetto viene descritto in formalismi diversi: l'**algebra relazionale**, linguaggio dichiarativo i cui operatori ricevono relazioni e restituiscono relazioni, e le **procedure dichiarative** con cui lo stesso risultato viene richiesto, che in SQL trovano espressione con le istruzioni `INSERT`, `DELETE` e `UPDATE`.

Gli operatori fondamentali dell'algebra relazionale sono:

| Operatore | Effetto |
| :--- | :--- |
| Selezione $\sigma$ | tiene le tuple che soddisfano una condizione |
| Proiezione $\pi$ | tiene solo gli attributi indicati |
| Prodotto cartesiano $\times$ | concatena ogni tupla della prima relazione con ogni tupla della seconda |
| Unione $\cup$ e differenza $-$ | combinano due relazioni compatibili attributo per attributo |
| Rinomina $\rho$ | cambia il nome di un attributo o di una relazione |
| Join $\bowtie$ | variante del prodotto cartesiano che unisce le tuple con valori uguali sugli attributi comuni |

## L'aggiornamento della base di dati e la gestione della violazione dei vincoli

Ogni operazione di aggiornamento può portare il DBMS a trovarsi davanti a uno stato non ammissibile: il suo compito è decidere se ammetterlo e, in caso contrario, come intervenire.

**Inserimento.** L'inserimento può violare tutti i tipi di vincoli: dominio, univocità, non nullità, integrità dell'entità e integrità referenziale. I DBMS di solito impediscono inserimenti che portano a un'istanza di base di dati non valida.

**Cancellazione.** La cancellazione può portare alla violazione del solo vincolo di integrità referenziale, perché nessuna tupla cancellata può più essere referenziata. I DBMS forniscono di solito varie opzioni per gestire la violazione:

| Politica | Cosa fa | In SQL |
| :--- | :--- | :--- |
| **Rifiuto della cancellazione** | l'operazione che lascerebbe riferimenti pendenti non viene eseguita | `ON DELETE RESTRICT` / `NO ACTION` |
| **Propagazione della cancellazione** | si risolve il problema cancellando le tuple che riferiscono la tupla che si sta eliminando | `ON DELETE CASCADE` |
| **Modifica dei valori referenti** | i valori degli attributi referenti che causano la violazione sono posti a `NULL` o a un valore di default | `ON DELETE SET NULL` / `SET DEFAULT` |

**Modifica.** La modifica può essere vista come un'operazione di cancellazione seguita da un'operazione di inserimento: entrano dunque in gioco le politiche viste sinora per inserimento e cancellazione.

## Le dipendenze funzionali e la normalizzazione

La lezione introduce le **dipendenze funzionali** fra le categorie di vincoli, con l'intento di verificare la qualità della progettazione di una base di dati relazionale; lo sviluppo del metodo che le usa per decomporre lo schema è il completamento dell'argomento.

*Definizione:* su uno schema $R$ una dipendenza funzionale $X \rightarrow Y$ afferma che, per ogni istanza $r$ valida, due tuple che coincidono su $X$ coincidono anche su $Y$.

- Una dipendenza è **triviale** se $Y \subseteq X$, cioè se non dice nulla; le altre sono **non triviali**.
- Gli assiomi derivano le dipendenze implicite: **riflessività**, **aumento** e **transitività**; da $X \rightarrow Y$ con $Z \subseteq Y$ si ricava $X \cup Z \rightarrow Z$.
- L'**involucro** di $X$ rispetto all'insieme $F$ di dipendenze, $X^{+}_F$, è l'insieme degli attributi raggiungibili da $X$ applicando le dipendenze in $F$; $K$ è superchiave se e solo se $X \subseteq K^{+}_F$ per qualche attributo $X \subseteq K$.

La decomposizione di uno schema serve a ridurre la duplicazione e le anomalie di aggiornamento, mantenendo due proprietà: la **perdita di join** nulla, cioè la relazione ricostruita con una join naturale coincide con quella originaria, e la **preservazione delle dipendenze**, cioè ogni dipendenza dello schema decomposto è implicata da quelle dello schema di partenza.

Le forme normali si susseguono per inclusione:

- **1FN:** ogni attributo ha valore atomico e non ulteriormente scomponibile.
- **2NF:** in 1FN e nessun attributo non primario dipende funzionalmente da una parte propria di una chiave candidata.
- **3FN:** in 2FN e per ogni dipendenza funzionale non triviale $X \rightarrow A$ vale che $X$ è superchiave oppure $A$ è attributo primo, cioè appartenente a una chiave candidata.
- **BCNF:** in 3NF e per ogni dipendenza funzionale non triviale $X \rightarrow A$, $X$ è sempre superchiave; elimina le dipendenze parziali che la 3FN tollera quando la chiave candidata è composta.

> [!info] Sintesi:
> - I vincoli di integrità si distinguono in intrinseci al modello, basati sullo schema (DDL), non esprimibili sullo schema e dipendenze funzionali.
> - Intrarelazionali: di dominio, su più valori della stessa tupla, di non nullità e di univocità `UNI:Y`; interrelazionali: integrità referenziale tramite chiavi esterne semplici `CE: A → S(B)` o composte.
> - Superchiave = insieme con `UNI`; chiave candidata = superchiave minimale; chiave primaria = la candidata scelta, che non ammette `NULL` per il **vincolo di integrità dell'entità**.
> - Inserimento può violare ogni vincolo, cancellazione solo l'integrità referenziale, gestita con rifiuto, propagazione in cascata o `SET NULL`; modifica è cancellazione più inserimento.
> - Le dipendenze funzionali servono a valutare la progettazione e guidano la normalizzazione in 1FN, 2NF, 3NF e BCNF, con perdita di join nulla e preservazione delle dipendenze.