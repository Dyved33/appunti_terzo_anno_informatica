---
tags: [intelligenza-artificiale]
---
# Lezione 1: Fondamenti di Intelligenza Artificiale, Machine Learning e Modelli Generativi

## 1. Introduzione all'Intelligenza Artificiale e Tassonomia

La disciplina dell'**Intelligenza Artificiale (IA)** affonda le proprie radici teoriche nei primi anni '50. Nel 1950 Alan Turing, nel celebre articolo *"Computing Machinery and Intelligence"*, formulò la domanda fondamentale se una macchina potesse pensare ed interagire con l'essere umano utilizzando il suo stesso linguaggio naturale (introducendo l'Imitation Game, noto come **Test di Turing**).

L'ecosistema dell'IA moderna si struttura secondo una gerarchia insiemistica ben definita:

$$\text{IA Generativa} \subseteq \text{Deep Learning} \subseteq \text{Machine Learning} \subseteq \text{Intelligenza Artificiale}$$

```
┌─────────────────────────────────────────────────────────────┐
│ Intelligenza Artificiale (IA)                               │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ Machine Learning (ML)                                 │  │
│  │  ┌─────────────────────────────────────────────────┐  │  │
│  │  │ Deep Learning (Reti Neurali Profonde)           │  │  │
│  │  │  ┌───────────────────────────────────────────┐  │  │  │
│  │  │  │ IA Generativa (LLM, VLM, Diffusion Model) │  │  │  │
│  │  │  └───────────────────────────────────────────┘  │  │  │
│  │  └─────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

* **Intelligenza Artificiale:** disciplina informatica che studia lo sviluppo di sistemi hardware e software capaci di risolvere compiti che richiederebbero intelligenza umana.
* **Machine Learning (ML):** sottoinsieme dell'IA basato su algoritmi che apprendono pattern e relazioni matematiche direttamente dai dati, senza essere esplicitamente programmati con regole rigide.
* **Deep Learning (DL):** branca del Machine Learning basata su reti neurali artificiali multi-strato caratterizzate da un elevato numero di parametri.
* **IA Generativa:** sistemi deep learning progettati per generare nuovi contenuti (testo, codice, immagini, audio, azioni) a partire da distribuzioni di probabilità apprese.

> [!NOTE] Cambio di Paradigma del Machine Learning
> Nella **programmazione tradizionale** il programmatore combina *dati* e *regole logiche predeterminate* per calcolare le *risposte*.
> Nel **Machine Learning** si forniscono all'algoritmo di apprendimento i *dati* e le *risposte attese (esempi etichettati)*: l'algoritmo deduce automaticamente le relazioni statistiche producendo un **modello**.

---

## 2. Il Processo di Apprendimento Automatico

### 2.1 Definizione di Addestramento (Training)
L'**addestramento** (*training*) è il processo algoritmico volto a determinare i valori ottimali dei parametri interni di un modello al fine di minimizzare l'errore di predizione sui dati di addestramento e garantire un'accurata capacità di inferenza su dati non ancora osservati.

$$\text{Dati di Input} + \text{Risposte Attese} \xrightarrow{\text{Algoritmo di Apprendimento}} \text{Modello Ottimizzato}$$

L'algoritmo opera in modo **iterativo**:
* Aggiorna progressivamente i parametri passo dopo passo.
* Termina al raggiungimento della convergenza numerica (quando l'errore non diminuisce ulteriormente) oppure quando viene raggiunta una condizione di arresto prefissata (*early stopping*).

> [!IMPORTANT] Generalizzazione vs Memorizzazione
> L'obiettivo del Machine Learning è la **generalizzazione**, non la pura memorizzazione dei dati. 
> Per questa ragione, il modello viene addestrato sul **training set**, ma le sue prestazioni devono essere tassativamente verificate e validate su un insieme disgiunto di dati mai visti durante il training (**test set**), prevenendo il fenomeno dell'**overfitting** (sovradattamento).

### 2.2 Complessità del Modello e Distribuzione delle Risposte
* **Complessità del Problema e Dati:** Per risolvere compiti complessi è necessario addestrare modelli con un elevato numero di parametri (*capacità rappresentativa* elevata), i quali richiedono proporzionalmente moli massicce di dati di addestramento per evitare l'instabilità o il sottoadattamento (*underfitting*).
* **Distribuzione di Probabilità:** Il modello assegna una probabilità a ogni possibile risposta dello spazio di output. L'obiettivo del processo di addestramento è incrementare progressivamente la massa di probabilità associata alla risposta attesa (target).

---

## 3. Funzione di Perdita (Loss) e Ottimizzazione del Modello

### 3.1 Esempio Fondamentale: Classificazione Lineare
Consideriamo il problema di separare due classi di punti bidimensionali (Classe A e Classe B) mediante un modello lineare (una retta definita da due parametri: pendenza $m$ e intercetta $q$).

![[Pasted image 20260930174136.png|550]]

1. **Inizializzazione Casuale:** All'avvio dell'algoritmo i parametri ($m, q$) assumono valori puramente casuali; la retta taglia lo spazio senza separare correttamente i punti (nell'esempio, 47 errori di classificazione su 92 campioni).
2. **Ottimizzazione Iterativa:** L'algoritmo corregge i parametri passo dopo passo, orientando e traslando la retta verso la configurazione di massima separazione (raggiungendo 1 solo errore su 92).
3. **Misura dell'Errore:** Per guidare la correzione è necessario quantificare l'errore tramite una funzione obiettivo scalare: la **loss** (funzione di perdita).

### 3.2 La Funzione di Loss
La **loss** $\mathcal{L}$ è un valore numerico che misura la discrepanza tra la predizione del modello e il valore reale target. Durante l'apprendimento la curva della loss decresce progressivamente, tendendo idealmente a 0.

Nel contesto della classificazione probabilistica, si adotta frequentemente la **Cross-Entropy Loss** (o *Negative Log-Likelihood*):

$$\text{loss} = -\ln(P)$$

dove $P \in (0, 1]$ rappresenta la probabilità assegnata dal modello alla classe/risposta attesa:
* Se $P \to 1$ (predizione perfetta con massima certezza), $-\ln(1) = 0 \implies \text{loss} = 0$.
* Se $P \to 0$ (predizione errata o incertezza elevata), $-\ln(P) \to +\infty \implies \text{loss}$ molto alta.

### 3.3 Il Paesaggio della Loss e la Discesa del Gradiente
Ogni possibile combinazione dei parametri del modello definisce un punto all'interno dello spazio della loss (*loss landscape*).

![[Pasted image 20260930175214.png|600]]

* **Spazio dei Parametri:** Ogni coordinata $(m, q)$ sulla superficie corrisponde a un modello specifico (una precisa retta nel piano dei dati).
* **Gradiente ($\nabla \mathcal{L}$):** Vettore delle derivate parziali che indica la direzione di massima salita della funzione di loss. L'ottimizzazione procede nella **direzione opposta al gradiente** (discesa del gradiente, *Gradient Descent*).
* **Learning Rate ($\eta$):** Iperparametro fondamentale che determina l'ampiezza dello spostamento (la lunghezza del passo) nello spazio dei parametri a ogni iterazione:
  $$\theta^{(t+1)} = \theta^{(t)} - \eta \nabla \mathcal{L}(\theta^{(t)})$$

### 3.4 Ciclo Completo di Addestramento
Il ciclo iterativo di ottimizzazione si compone di 4 fasi:
1. **Predizione (*Forward Pass*):** Calcolo delle uscite del modello a partire dagli esempi di input.
2. **Calcolo della Loss:** Valutazione numerica dell'errore rispetto alle risposte attese.
3. **Calcolo del Gradiente (*Backward Pass / Backpropagation*):** Calcolo analitico di quanto ciascun parametro ha contribuito all'errore.
4. **Aggiornamento dei Parametri:** Modifica dei pesi in direzione contraria al gradiente.

A convergenza raggiunta, i parametri vengono **fissati (congelati)** e il modello entra in fase di **inferenza**.

> [!NOTE] Scalabilità alle Reti Neurali Profonde
> Il medesimo principio matematico (forward pass, loss, gradiente, update) si applica invariato alle **reti neurali profonde**: la differenza risiede nella scala, passando da 2 parametri a centinaia di milioni o miliardi di parametri connessi in architetture stratificate.

---

## 4. Dai Classificatori ai Large Language Model (LLM)

### 4.1 Generazione come Classificazione del Token Successivo
A ogni singolo passo generativo, un **Large Language Model (LLM)** esegue a livello fondamentale un'operazione di **classificazione multi-classe**, in cui le classi target corrispondono all'insieme di tutte le parole/token che compongono il suo vocabolario.

| Paradigma | Classificatore Supervisionato | Pre-addestramento LLM | Personalizzazione / Allineamento |
| :--- | :--- | :--- | :--- |
| **Origine delle Etichette** | Un essere umano ("oracolo") etichetta esplicitamente ogni esempio | Nessun oracolo: il target è la parola successiva già presente nel testo grezzo | Esperti umani: esempi di risposte desiderate e preferenze comparative |
| **Tipo di Apprendimento** | Apprendimento Supervisionato classico | Apprendimento Auto-Supervisionato (*Self-Supervised Learning*) | *Fine-Tuning*, *Instruction Tuning*, RLHF / DPO |

> [!IMPORTANT] Il Principio dell'Auto-Supervisione
> Il modello apprende la struttura della lingua e la conoscenza del mondo minimizzando l'errore nella predizione della parola successiva (*Next-Token Prediction*) su miliardi di documenti testuali. La supervisione umana specializzata interviene solo a valle per allineare e personalizzare il modello verso compiti conversazionali o specifici.

### 4.2 Dal Testo ai Numeri: Tokenizzazione ed Embedding
I modelli computazionali elaborano esclusivamente vettori numerici. Il passaggio da linguaggio naturale a rappresentazione numerica si articola in due stadi:

```
[ Testo Grezzo ] ──► [ Tokenizzazione (Sub-word) ] ──► [ Vettori di Embedding ] ──► [ Modello ]
```

1. **Tokenizzazione:** Il testo in ingresso viene scomposto in unità discrete dette **token** (frammenti di parole o sub-word, es. `«capitale»` $\to$ `«capi»` + `«tale»`).
2. **Embedding Vettoriale:** A ciascun token viene associato un vettore numerico denso ad alta dimensionalità, i cui pesi vengono appresi durante la fase di training.
3. **Geometria Semantica:** Lo spazio geometrico degli embedding codifica le relazioni semantiche tra i concetti: parole semanticamente correlate o che ricorrono in contesti simili occupano posizioni vicine nello spazio vettoriale.

---

## 5. L'Architettura Transformer e Generazione del Testo

### 5.1 Il Meccanismo di Attenzione
Introdotta nel 2017 nel paper *"Attention Is All You Need"*, l'architettura **Transformer** ha superato le limitazioni delle reti ricorrenti (RNN/LSTM):
* **Elaborazione Simultanea:** Consente a ciascuna posizione della sequenza di interagire contemporaneamente con tutti gli altri token del contesto (*Self-Attention*), senza dover processare il testo sequenzialmente parola per parola.
* **Parallelizzazione Massiva:** Durante l'addestramento tutte le posizioni vengono elaborate in parallelo su cluster di acceleratori hardware (GPU/TPU), rendendo fattibile il training su volumi di dati e parametri su scala planetaria.

### 5.2 Pipeline di Elaborazione
Il flusso di trasformazione interno si articola attraverso blocchi Transformer ripetuti in profondità:

![[Pasted image 20260930181234.png|600]]

$$\text{Testo} \longrightarrow \text{Token} \longrightarrow \text{Vettori} \longrightarrow \left[ \begin{matrix} \text{Attenzione} \\ \text{Rete Feed-Forward} \end{matrix} \right] \times N \longrightarrow \text{Probabilità del Token Successivo}$$

### 5.3 Generazione Autoregressiva e Campionamento
A ogni iterazione il modello emette una distribuzione di probabilità sull'intero vocabolario:
* **Scelta Deterministica (*Greedy*):** Seleziona sempre il token a probabilità massima. A parità di prompt, l'output generato sarà identico.
* **Campionamento Probabilistico:** Estrazione stocastica pesata sulle probabilità (regolata da parametri come *temperature*, *top-k*, *top-p*). Esecuzioni multiple dello stesso prompt possono divergere, introducendo variabilità e creatività.

> [!WARNING] Fluidità Sintattica vs Affidabilità Concettuale
> La fluidità e la coerenza grammaticale del testo generato derivano esclusivamente dal calcolo probabilistico iterativo. L'apparente padronanza linguistica **non implica di per sé comprensione semantica, correttezza fattuale o facoltà cognitive umane**, esponendo il sistema a potenziali **allucinazioni**.

---

## 6. Tassonomia dei Modelli Generativi ed Evoluzione dell'IA

### 6.1 Famiglie di Modelli Generativi
In base alla tipologia di input e output elaborati, i modelli generativi si classificano in:
* **LLM (Large Language Model):** elaborano sequenze testuali in ingresso per produrre testo in uscita ($\text{testo} \to \text{testo}$).
* **VLM (Vision-Language Model):** elaborano congiuntamente immagini e testo in ingresso per generare descrizioni, risposte o analisi testuali ($\text{immagine} + \text{testo} \to \text{testo}$).
* **VLA (Vision-Language-Action):** elaborano input visivi e istruzioni testuali per calcolare comandi attuativi e azioni fisiche nel mondo reale per sistemi robotici ($\text{immagine} + \text{testo} \to \text{azioni}$).
* **Modelli Generativi di Immagini:** generano o modificano immagini sintetiche a partire da descrizioni testuali ($\text{testo} \to \text{immagine}$, es. modelli a diffusione).

### 6.2 I Foundation Model
Un **Foundation Model** è un modello di grandi dimensioni pre-addestrato su vastissimi dataset eterogenei, in grado di fungere da base comune ed essere adattato (*fine-tuned*) a molteplici task applicativi verticali (inclusi sistemi multimodali come VLM e VLA).

### 6.3 Invarianti ed Evoluzione dell'IA
Nell'evoluzione storica e tecnologica dei modelli di intelligenza artificiale:

```
┌────────────────────────────────────────┬────────────────────────────────────────┐
│               COSA RESTA               │               COSA CAMBIA              │
├────────────────────────────────────────┼────────────────────────────────────────┤
│ • Apprendimento guidato dai dati       │ • Scala di dati, parametri e calcolo   │
│ • Minimizzazione di una funzione loss  │ • Architetture (avvento Transformer)   │
│ • Discesa del gradiente come motore    │ • Metodologie di allineamento/tuning   │
│   matematico fondamentale              │ • Modalità d'uso: RAG, tool e agenti   │
└────────────────────────────────────────┴────────────────────────────────────────┘
```

> [!NOTE] Ruolo della Dimensione dei Parametri
> L'incremento del numero di parametri conferisce al modello una maggiore capacità di rappresentazione geometrica e generalizzazione concettuale. Il modello **non opera come un database deterministico o un archivio rigido di risposte**, sebbene alcuni dati fattuali frequenti possano rimanere memorizzati nei pesi.

---

## 7. Sistemi Basati su Documenti e Sistemi Agentici

### 7.1 Integrazione di Fonti Esterne (RAG)
L'accesso diretto a documenti e fonti informative esterne (*Retrieval-Augmented Generation* - RAG) garantisce vantaggi strutturali critici:
* Rende la risposta generata **verificabile, ispezionabile e controllabile**.
* Consente l'aggiornamento dinamico delle conoscenze senza richiedere costosi riaddestramenti del modello.
* Riduce drasticamente le allucinazioni ancorando le asserzioni a contesti documentali certi.

### 7.2 Flusso Fisso vs Sistema Agentico
La discriminante fondamentale tra un'architettura documentale convenzionale e un sistema agentico risiede nell'**autonomia decisionale sui passi operativi**:

![[Pasted image 20260930182802.png|600]]

#### I. Architettura a Flusso Fisso (Pipeline Deterministica)
* I passaggi esecutivi sono rigidamente prefissati dal progettista del software (es. `Cerca nel DB` $\to$ `Inserisci nel Prompt` $\to$ `Genera Risposta`).
* Il flusso compie un unico passaggio deterministico, invariante rispetto alla complessità della richiesta.

#### II. Sistema Agentico (Agent Loop)
Nel **sistema agentico** è il modello stesso a pianificare dinamicamente la sequenza di azioni necessarie per completare un obiettivo articolato:
1. **Pianificazione (*Plan*):** Analizza l'obiettivo e stabilisce il sotto-task immediato (es. reperire un dato o eseguire un calcolo).
2. **Utilizzo di Strumenti (*Tool Use / Action*):** Invoca tool esterni specializzati (motori di ricerca, interpreti Python, calcolatori, API).
3. **Osservazione (*Observation*):** Riceve e interpreta il risultato prodotto dallo strumento.
4. **Valutazione e Decisione (*Reflect & Decide*):** Valuta se i dati raccolti sono sufficienti; decide se iterare il ciclo invocando ulteriori strumenti o formulare la risposta finale.

> [!IMPORTANT] Principio Architetturale
> Un sistema informativo arricchito con accesso a basi di dati o documenti **non costituisce necessariamente un agente**. La natura agentica è determinata dalla capacità del modello di **scegliere in autonomia percorsi, strumenti e criteri di arresto su più passi iterativi**.

---

# Lezione 2: Agenti Intelligenti, Rappresentazioni degli Stati e Ricerca su Albero

## 1. L'Agente Intelligente e il suo Ambiente

Un **agente intelligente** e l'entita che interagisce con il mondo esterno (**environment**) attraverso due categorie di interfacce: i sensori, con cui percepisce, e gli attuatori, con cui agisce.

### 1.1 Sensori e Attuatori

* **Sensori:** dispositivi che acquisiscono dati dall'ambiente e li forniscono all'agente sotto forma di **percezioni** (telecamere, microfoni, lettura di file, messaggi di rete o output di uno strumento).
* **Attuatori:** meccanismi che l'agente invoca per modificare l'ambiente in funzione delle decisioni prese (motori, bracci robotici, click, scrittura su disco, chiamate a funzioni o API).

Il ciclo di interazione e continuo e ricorsivo: l'azione eseguita dall'attuatore modifica l'ambiente; tale mutamento viene acquisito dai sensori come nuova percezione e reinserito nel processo decisionale.

```
   SENSORI                AGENTE                 ATTUATORI
 (percezioni)   ----->  (decisione)   ----->   (azioni sull'ambiente)
      ^                                          |
      +------------  nuova percezione  <---------+
                 (l'ambiente e stato modificato)
```

> [!NOTE] Natura dell'Ambiente
> L'ambiente non deve essere necessariamente digitale: puo essere un ambiente fisico reale (un robot mobile che evita ostacoli), un ambiente software o una simulazione. La struttura del ciclo percezione-decisione-azione rimane invariata, variando unicamente la tipologia di sensori e attuatori impiegati.

### 1.2 Le Quattro Proprieta dell'Ambiente

La difficolta di progettazione e risoluzione di un agente razionale dipende dalla combinazione di quattro dimensioni tassonomiche dell'ambiente:

| Proprieta | Classificazione | Definizione e Impatto Computazionale |
| :--- | :--- | :--- |
| **Osservabilita** | *Fully Observable* / *Partially Observable* | Nell'ambiente completamente osservabile i sensori forniscono in ogni istante l'intero stato del mondo; in quello parzialmente osservabile l'agente deve mantenere uno stato interno e inferire le variabili non visibili. |
| **Determinismo** | *Deterministic* / *Stochastic* | In un ambiente deterministico l'esito di un'azione a partire da uno stato e univoco e certo; in uno stocastico l'esito e descritto da una distribuzione di probabilita. |
| **Granularita** | *Discrete* / *Continuous* | In un ambiente discreto l'insieme delle percezioni, degli stati e delle azioni possibili e finito e numerabile (es. mosse negli scacchi); in uno continuo le variabili assumono valori reali infiniti (es. coordinate, velocita, temperatura). |
| **Ostilita** | *Benign* / *Adversarial* | L'ambiente benigno non agisce con scopi ostili verso l'agente (es. navigazione stradale su mappa statica); l'ambiente ostile o competitivo include altri agenti che contrastano attivamente gli obiettivi dell'agente. |

### 1.3 L'Agente Razionale

> [!IMPORTANT] Definizione Formale di Razionalita
> Per ogni possibile sequenza di percezioni, un agente razionale seleziona un'azione che massimizza il **valore atteso della propria misura di prestazione**, condizionatamente alle informazioni fornite dalla sequenza percettiva osservata e a ogni conoscenza a priori disponibile.

Formalizzando con $\mathbb{P}$ lo spazio delle sequenze percettive, $\mathbb{A}$ lo spazio delle azioni possibili e $U$ la **misura di prestazione** (*performance measure* / funzione di utilita):

$$a^* = \arg\max_{a \in \mathbb{A}} \; \mathbb{E}\left[\, U(\text{sequenza di percezioni}, a) \right]$$

Il ciclo operativo dell'agente si riassume nella sequenza: **percepire, aggiornare il proprio stato interno, selezionare l'azione ottima ed eseguirla**.

> [!NOTE] Relativita della Razionalita
> La razionalita non e una virtu assoluta o una facolta cognitiva universale: e strettamente vincolata alla funzione obiettivo $U$ definita dal progettista. Fissando la misura di prestazione desiderata, il progettista impone formalmente il comportamento atteso dal sistema.

---

## 2. Rappresentazione dello Stato

Il formalismo adottato per descrivere lo stato del mondo determina l'efficienza degli algoritmi di ricerca e la trattabilita computazionale del problema. Si individuano tre paradigmi:

| Paradigma | Struttura dello Stato | Applicazione Principale |
| :--- | :--- | :--- |
| **Atomica** | Lo stato e una **scatola nera** (*black box*) priva di struttura interna visibile; il sistema manipola solo identificatori opachi senza poterne ispezionare le componenti. | Ricerca non informata e algoritmi generici su grafi di grandi dimensioni. |
| **Fattorizzata** | Lo stato e rappresentato come un **vettore di attributi** (variabili booleane, numeriche o simboliche appartenenti a domini definiti). | Pianificazione classica, soddisfacimento di vincoli (CSP), SAT solver. |
| **Strutturata** | Lo stato e composto da **oggetti espliciti**, ciascuno caratterizzato da propri attributi e da **relazioni logico-relazionali** con gli altri oggetti. | Modelli aperti, ragionamento simbolico, ambienti 3D complessi e basi di conoscenza relazionali. |

---

## 3. Definizione del Problema di Ricerca

Un **problema di ricerca** (*search problem*) formale e definito da una quadrupla:

1. **Spazio degli stati ($S$):** l'insieme finito o numerabile delle configurazioni possibili $S = \{S_1, \ldots, S_n\}$.
2. **Funzione di successore ($f$):** specifica l'insieme delle azioni applicabili $A = \{a_1, \ldots, a_m\}$ e il rispettivo costo associato, mappando uno stato e un'azione nello stato risultante:
   $$f : S \times A \to S$$
3. **Stato iniziale ($S_0$) e Test di Obiettivo (*Goal Test*):** lo stato di partenza $S_0 \in S$ e un predicato logico booleano che determina se uno stato soddisfa le condizioni di successo ($S \in S_g$).
4. **Soluzione (Piano):** una sequenza finita di azioni ordinata $\langle a_1, a_2, \ldots, a_k \rangle$ che trasforma deterministicamente lo stato iniziale in uno stato che supera il goal test:
   $$f(\ldots f(f(S_0, a_1), a_2) \ldots, a_k) \in S_g$$

![[lec02_search_problem_components.png|600]]

> [!NOTE] Valutazione del Goal Test
> La condizione di obiettivo viene verificata **esclusivamente sullo stato finale** generato dal piano. Gli stati intermedi attraversati durante l'esecuzione non devono necessariamente soddisfare i vincoli del goal.

### 3.1 I Problemi di Ricerca Sono Modelli

La formulazione matematica del problema non coincide con il mondo reale, ma ne costituisce un **modello astratto semplificato**.

> [!IMPORTANT] Pianificazione in Simulazione
> L'agente non esegue fisicamente tutti i piani possibili nell'ambiente reale durante la ricerca. La pianificazione avviene interamente **in simulazione** all'interno del modello. Di conseguenza, l'efficacia e la correttezza del piano calcolato sono limitate dalla fedelta e dall'accuratezza del modello adottato (*"Your search is only as good as your models"*).

### 3.2 Esempio Fondamentale: Il Viaggio in Romania

Un esempio classico e la ricerca del percorso ottimale tra citta sulla rete stradale della Romania:

* **Spazio degli stati:** le citta della rete stradale.
* **Funzione di successore:** percorrere una strada collegata verso una citta adiacente, con **costo dell'azione pari alla distanza chilometrica**.
* **Stato iniziale:** Arad.
* **Goal test:** $\text{stato} == \text{Bucharest}$.

![[lec02_romania_graph.png|600]]

### 3.3 World State vs Search State: Il Ruolo dell'Astrazione

La progettazione efficiente di un problema di ricerca richiede di separare le informazioni ridondanti da quelle essenziali:

* **Stato del Mondo (*World State*):** include ogni minimo dettaglio dell'ambiente operativo.
* **Stato di Ricerca (*Search State*):** trattiene unicamente i dettagli strettamente necessari alla formulazione del piano, astraendo le variabili ininfluenti.

![[lec02_state_space_pacman.png|600]]

Nell'ambiente di Pac-Man, la scelta delle variabili di stato varia in funzione dell'obiettivo:

* **Task di Puntamento / Navigazione (*Pathing*):** interessa solo raggiungere una posizione $(x, y)$. Lo stato di ricerca contiene esclusivamente la posizione $(x, y)$ dell'agente.
* **Task di Raccolta Totale (*Eat-All-Dots*):** richiede di consumare tutti i pallini. Lo stato di ricerca deve includere sia la posizione $(x, y)$ dell'agente sia un vettore booleano indicante la presenza o assenza di ciascun pallino.

### 3.4 Dimensioni dello Spazio degli Stati

Il confronto combinatorio illustra l'esplosione dello spazio degli stati all'aumentare dei dettagli modellati:

| Tipologia di Stato | Componenti Incluse | Dimensione Combinatoria Totale |
| :--- | :--- | :--- |
| **World State Completo** | 120 posizioni agente, 30 pallini booleani, 12 posizioni fantasmi, 4 orientamenti (NESW) | $120 \times 2^{30} \times 12 \times 4 \approx 6.18 \times 10^{12}$ stati |
| **Search State: Pathing** | Posizione agente $(x, y)$ | $120$ stati |
| **Search State: Eat-All-Dots** | Posizione agente $(x, y)$ + stato dei 30 pallini | $120 \times 2^{30} \approx 1.28 \times 10^{11}$ stati |

> [!IMPORTANT] Il Vero Collo di Bottiglia: La Dimensione dello Spazio degli Stati
> La complessita intrinseca del problema non risiede nel numero di azioni disponibili, ma nell'**esplosione combinatoria del numero di stati possibili**. L'astrazione mirata e lo strumento concettuale primario per rendere computazionalmente trattabili problemi complessi.

---

## 4. Grafo dello Spazio degli Stati e Albero di Ricerca

### 4.1 Grafo dello Spazio degli Stati (*State Space Graph*)

Il **grafo dello spazio degli stati** e la rappresentazione matematica astratta del problema di ricerca:

* I **nodi** rappresentano configurazioni astratte del mondo.
* Gli **archi orientati** corrispondono ai risultati delle azioni (transizioni tra stati).
* Il **goal test** individua il sottoinsieme dei nodi obiettivo.

![[lec02_state_space_graph.png|600]]

Proprieta distintive del grafo dello spazio degli stati:
* **Unicita degli stati:** ogni stato del problema compare **una e una sola volta** all'interno del grafo.
* **Intrattabilita della memoria:** per problemi di scala reale, il grafo completo e troppo vasto per poter essere costruito o memorizzato esplicitamente. Rimane un modello concettuale di riferimento.

### 4.2 Albero di Ricerca (*Search Tree*)

L'**albero di ricerca** e una struttura gerarchica che rappresenta i piani ipotetici ("cosa se" / *what if*) e le rispettive conseguenze:

* La **radice** corrisponde allo stato iniziale $S_0$.
* I **nodi figli** corrispondono ai successori generati dall'applicazione delle azioni ammissibili.
* **I nodi mostrano stati, ma rappresentano PIANI:** ogni nodo dell'albero individua l'intera sequenza di azioni che consente di raggiungere quello specifico stato a partire dalla radice.

![[lec02_search_tree_concept.png|600]]

### 4.3 Confronto Fondamentale: Grafo vs Albero

La distinzione tra grafo dello spazio degli stati e albero di ricerca e un cardine teorico della disciplina:

![[lec02_state_space_vs_search_tree.png|600]]

> [!IMPORTANT] Relazione tra Nodi dell'Albero e Cammini del Grafo
> **Ogni singolo NODO nell'albero di ricerca corrisponde a un intero PERCORSO (PATH) nel grafo dello spazio degli stati.**
> Poiche uno stesso stato puo essere raggiunto attraverso molteplici cammini distinti, la stessa configurazione fisica puo comparire replicata in molteplici nodi differenti dell'albero di ricerca.

| Proprieta | Grafo dello Spazio degli Stati | Albero di Ricerca |
| :--- | :--- | :--- |
| **Entita rappresentata** | Insieme delle configurazioni e delle transizioni | Insieme dei piani esaminati e dei loro esiti |
| **Occorrenza di ciascuno stato** | Ogni configurazione compare **esattamente una volta** | Uno stesso stato compare **in piu nodi distinti** |
| **Dimensione e costruzione** | Esplosivo; teorico, raramente istanziabile per intero | Costruito **on-demand** ed espanso il minimo necessario |
| **Ruolo algoritmico** | Modello formale di riferimento | Struttura generata ed esplorata dagli algoritmi |

### 4.4 Strutture Ripetute e Gestione dei Cicli

Si consideri un grafo a 4 stati ($S, a, b, G$) con transizioni $S \to a$, $S \to b$, $a \to G$, $b \to G$ e un ciclo bidirezionale $a \leftrightarrow b$:

![[lec02_search_tree_quiz_cycles.png|600]]

Dato il ciclo tra $a$ e $b$, l'albero di ricerca con radice $S$ manifesta una **continua e infinita struttura ripetuta** nei sottoalberi:

* Dal nodo $a$ si puo generare $b$, dal quale si puo rigenerare $a$, e cosi via ricorsivamente.
* Di conseguenza, pur a fronte di uno spazio degli stati finito (4 nodi), l'**albero di ricerca associato ha dimensione infinita ($\infty$)**.
* Questa evidenza teorica impone agli algoritmi di ricerca di implementare meccanismi espliciti per la gestione degli stati gia visitati e la potatura dei cammini ciclici ridondanti.

---

## 5. La Ricerca su Albero (*Tree Search*) e la Frontiera (*Fringe*)

### 5.1 Principi Operativi del Tree Search

L'esplorazione dell'albero di ricerca si fonda su tre concetti operativi fondamentali:

1. **Espansione (*Expansion*):** generazione dei nodi figli (piani successivi) a partire da un nodo selezionato.
2. **Frontiera (*Fringe / Frontier*):** la struttura dati che mantiene l'insieme dei nodi parzialmente esplorati (piani parziali attualmente sotto esame e in attesa di selezione).
3. **Strategia di esplorazione:** il criterio decisionale impiegato per determinare quale nodo estrarre dalla frontiera ed espandere al passo successivo. L'obiettivo e raggiungere il goal espandendo il minor numero possibile di nodi complessivi.

### 5.2 Esempio Applicato: Costruzione dell'Albero sul Problema della Romania

L'applicazione del paradigma di ricerca all'itinerario in Romania illustra il ruolo della *fringe*:

![[lec02_romania_tree_search_fringe.png|600]]

* **Passo 0 (Inizializzazione):** la fringe contiene solo il nodo radice $\{\text{Arad}\}$.
* **Passo 1 (Espansione di Arad):** il nodo $\text{Arad}$ viene rimosso dalla fringe ed espanso, generando i successori $\text{Sibiu}$, $\text{Timisoara}$ e $\text{Zerind}$. La nuova frontiera diventa $\{\text{Sibiu}, \text{Timisoara}, \text{Zerind}\}$.
* **Passo 2 (Scelta ed espansione di Sibiu):** la strategia seleziona $\text{Sibiu}$; espandendolo si generano i sotto-piani verso $\text{Arad}$, $\text{Fagaras}$, $\text{Oradea}$ e $\text{Rimnicu Vilcea}$.
* I nodi foglia non ancora espansi (evidenziati con tratteggio verde) costituiscono la frontiera attiva tra cui la strategia operera la successiva selezione.

### 5.3 L'Interrogativo Fondamentale degli Algoritmi di Ricerca

L'intero impianto algoritmico della ricerca si riduce alla risposta a una singola domanda:

> [!IMPORTANT] Il Quesito Centrale della Ricerca
> **Quale nodo presente nella frontiera (*fringe*) deve essere scelto ed espanso per primo?**

La scelta della politica di estrazione dalla fringe determina le proprieta algoritmiche (completezza, ottimalita, complessita temporale e complessita spaziale) e differenzia le strategie di:
* **Ricerca Non Informata (*Uninformed Search*):** operano sfruttando unicamente la struttura dello spazio degli stati (es. Depth-First Search tramite stack LIFO, Breadth-First Search tramite coda FIFO, Uniform Cost Search tramite coda di priorita su costo cumulato).
* **Ricerca Informata (*Informed Search*):** guidano l'esplorazione mediante funzioni euristiche informative dirette verso il goal (es. Greedy Best-First, $A^*$).
