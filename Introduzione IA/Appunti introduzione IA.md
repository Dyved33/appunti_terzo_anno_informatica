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

# Lezione 2: Agenti Intelligenti, Rappresentazioni degli Stati e Ricerca Non Informata

## 1. L'Agente Intelligente e il suo Ambiente

Un **agente intelligente** è l'entità che interagisce con il mondo esterno (**environment**) attraverso due categorie di interfacce: i sensori, con cui percepisce, e gli attuatori, con cui agisce.

### 1.1 Sensori e Attuatori

* **Sensori:** dispositivi che acquisiscono dati dall'ambiente e li forniscono all'agente sotto forma di **percezioni** (vista, udito, lettura di file o output di un tool).
* **Attuatori:** meccanismi che l'agente **invoca** per modificare l'ambiente, se e quando le sue decisioni lo impongono (movimento, click, scrittura di un file, chiamata a un'API).

Il ciclo di interazione è continuo: la modifica prodotta dall'attuatore si traduce in un cambiamento dell'ambiente, che viene nuovamente percepito dai sensori e reinserito nel ciclo decisionale.

```
   SENSORI                AGENTE                 ATTUATORI
 (percezioni)   ─────►  (decisione)   ─────►   (azioni sull'ambiente)
      ▲                                          │
      └────────────  nuova percezione  ◄──────────┘
                 (l'ambiente è stato modificato)
```

> [!NOTE] Nota del Prof: Non è necessario che l'ambiente sia digitale
> L'ambiente può essere anche fisico (un robot che evita ostacoli) o simulato. Il ciclo percezione-decisione-azione è strutturalmente identico; cambia solo il tipo di sensori e attuatori impiegati.

### 1.2 Le Quattro Proprieta dell'Ambiente

Un ambiente è classificabile su quattro coppie di proprietà che determinano quanto sia difficile costruire un agente razionale su di esso:

| Proprieta | Valori | Significato |
| :--- | :--- | :--- |
| **Osservabilità** | *fully observable* / *partially observable* | Nell'ambiente completamente osservabile le percezioni successive determinano univocamente lo stato corrente; in quello parzialmente osservabile l'agente deve mantenere uno stato interno ed ipotizzare la parte non osservata. |
| **Determinismo** | *deterministic* / *stochastic* | In un ambiente deterministico la stessa azione dallo stesso stato produce sempre lo stesso successore; in uno stocastico la successione richiede una distribuzione di probabilità e non è prevedibile con certezza. |
| **Granularità** | *discrete* / *continuous* | In un ambiente discreto le percezioni e le azioni appartengono a insiemi finiti e contabili (le mosse di una scacchiera); in uno continuo assumono infiniti valori (velocità, coordinate, temperatura). |
| **Ostilita** | *benign* / *adversarial* | L'ambiente benigno non ostacola l'agente (un navigatore su mappa statica); quello ostile si oppone attivamente ai suoi obiettivi (un avversario in un gioco, un mercato finanziario regolato da altri operatori). |

### 1.3 L'Agente Razionale

> [!IMPORTANT] Definizione Formale di Agente Razionale
> **Per ogni possibile sequenza di percezioni, un agente razionale sceglie un'azione che massimizza il valore atteso della propria misura di prestazione, date le informazioni fornite dalla sequenza perceptiva e da ogni ulteriore conoscenza dell'agente.**

Formalizzando con $\mathbb{P}$ lo spazio delle sequenze di percezioni, $\mathbb{A}$ lo spazio delle azioni e $U$ la **misura di prestazione** (*performance measure*):

$$a^* = \arg\max_{a \in \mathbb{A}} \; \mathbb{E}\left[\, U(\text{sequenza di percezioni}, a) \right]$$

Il ciclo dell'agente corrisponde a **percepire, agire sul proprio stato interno e scegliere l'azione migliore**: l'agente razionale non è quello "intelligente in assoluto", ma quello ottimo rispetto alla misura di prestazione adottata.

> [!NOTE] Nota del Prof: Si Decide il Comportamento Desiderato
> Il progettista **può stabilire in anticipo il comportamento che si aspetta dall'agente**: basta codificare l'obiettivo nella misura di prestazione $U$. La razionalità non è una proprietà assoluta dell'agente, ma è relativa alla funzione di utilità scelta: un agente perfettamente razionale rispetto a $U$ può essere del tutto irrazionale rispetto a un altro criterio.

## 2. Rappresentazione dello Stato

Il modo in cui l'agente codifica il mondo determina sia l'efficacia della ricerca sia il suo costo computazionale. Si distinguono tre livelli di rappresentazione, dal meno al più informativo:

| Rappresentazione | Descrizione | Uso tipico |
| :--- | :--- | :--- |
| **Atomica** | Lo stato è una **scatola nera** priva di struttura interna: il problema di ricerca riceve le percezioni come simboli opachi e non può sfruttare la loro natura. | Ricerca non informata su spazi enormi, in cui la struttura non è conosciuta o non è utile. |
| **Fattorizzata** | Lo stato è un **vettore di valori di attributi**; ciascun valore può essere booleano, numerico reale oppure un simbolo appartenente a un insieme fissato. | Pianificazione classica e risolutori simbolici di problemi (es. SAT, CSP). |
| **Strutturata** | Lo stato include **oggetti**, ciascuno dotato di attributi propri oltre che di **relazioni** con gli altri oggetti. | Mondi aperti con oggetti complessi e relazioni variabili (pianificazione su descrizioni, ambienti 3D). |

## 3. Il Problema di Ricerca

Un **problema di ricerca** è definito da quattro componenti:

1. **Uno spazio degli stati** $S = \{S_1, \ldots, S_n\}$, insieme finito delle configurazioni possibili.
2. **Una funzione di successore** con azioni e costi, che mappa stato e azione nello stato successore:
   $$f : S \times A \rightarrow S, \qquad A = \{a_1, \ldots, a_m\}$$
3. **Uno stato iniziale** $S_0 \in S$.
4. **Una funzione di obiettivo** (*goal test*), che verifica se uno stato soddisfa la condizione di goal.

Una **soluzione** è una sequenza di azioni, cioè un **piano**, che trasforma lo stato iniziale nello stato di goal:

$$P = \langle a_1, a_2, \ldots, a_n \rangle \quad \text{tale che} \quad f(\ldots f(f(S_0, a_1), a_2) \ldots, a_n) \; \text{soddisfa il goal test in } S_g$$

> [!NOTE] Nota del Prof: Il Goal Test si Valuta Solo sullo Stato Finale
> Le proprietà che caratterizzano il goal sono valide **esclusivamente sull'ultimo stato** della sequenza. Gli stati intermedi possono non soddisfarle: un agente che attraversa un campo minato e diretto verso l'uscita deve poter occupare le caselle pericolose durante il percorso.

### 3.1 I Problemi di Ricerca Sono Modelli

La definizione formale appena data non descrive il mondo, ma un **modello** del mondo: una sua rappresentazione astratta, dichiarata come assunzione esplicita.

> [!IMPORTANT] La Ricerca Opera Solo sul Modello
> L'agente **non verifica realmente tutti i piani nel mondo reale**: la pianificazione avviene interamente **in simulazione**, e la validità dei risultati dipende dalla fedeltà del modello impiegato. *La ricerca è solo valida quanto il modello su cui opera.*

### 3.2 Esempio: Viaggio in Romania

Il problema canonico dei testi di riferimento è la ricerca del percorso da **Arad** a **Bucharest**:

* **Spazio degli stati:** le citta della Romania.
* **Funzione di successore:** le strade: spostarsi verso una citta adiacente, con **costo pari alla distanza** (in km).
* **Stato iniziale:** Arad.
* **Goal test:** lo stato è uguale a Bucharest?

### 3.3 Cosa Contiene uno Spazio degli Stati

* **Stato del mondo (*world state*):** include **ogni dettaglio** dell'ambiente.
* **Stato di ricerca (*search state*):** mantiene **solo i dettagli necessari alla pianificazione**: è una **astrazione** dello stato del mondo.

La differenza si misura sull'esempio di Pac-Man:

| Grandezza | World State | Search State: Pathing | Search State: Eat-All-Dots |
| :--- | :--- | :--- | :--- |
| Posizione agente | 120 | 120 | 120 |
| Pallini presenti | 30 booleani | non considerati | 30 booleani |
| Posizione fantasmi | 12 | non considerata | non considerata |
| Orientamento agente | 4 (NESW) | non considerato | non considerato |
| **Numero di stati** | $120 \times 2^{30} \times 12 \times 4$ | $120$ | $120 \times 2^{30}$ |

Per il problema *Pathing* si considerano solo le posizioni raggiungibili sulla griglia; per *Eat-All-Dots* lo stato è la coppia posizione-piastrellice, dato che i pallini non si rigenerano.

> [!IMPORTANT] Il Problema di Pac-Man è la Dimensione dello Spazio degli Stati
> Il collo di bottiglia del gioco non è l'azione da eseguire, ma il **numero di stati possibili**: mantenere in memoria tutte le combinazioni di posizioni e pallini è intrinsecamente più oneroso che risolvere il caso in cui i pallini non si contano. L'astrazione è l'unico strumento che rende il problema trattabile.

## 4. Grafo dello Spazio degli Stati e Albero di Ricerca

### 4.1 Grafo dello Spazio degli Stati

Il **grafo dello spazio degli stati** (*state space graph*) è la rappresentazione matematica di un problema di ricerca:

* i **nodi** sono configurazioni (mondo astratto);
* gli **archi** rappresentano i successori, cioè i risultati delle azioni;
* il **goal test** corrisponde a un insieme di nodi goal, eventualmente ridotto a un solo nodo.

La proprietà fondamentale del grafo è che **ogni stato compare una sola volta**: due percorsi diversi che raggiungono la stessa configurazione convergono sullo stesso nodo.

> [!NOTE] Il Grafo Non e Materializzabile
> Il grafo completo rappresenta l'insieme di **tutti i piani possibili**: è quindi un oggetto di dimensioni enormi, che nella pratica non può essere costruito in memoria. Resta un'idea di riferimento teorica, non una struttura dati utilizzabile.

> [!WARNING] IMMAGINE DA INSERIRE
> Inserire lo schema del grafo dello spazio degli stati, con i nodi `a`, `b`, `c`, `d`, `e`, `f`, `G`, `h`, `p`, `q`, `r`, lo stato iniziale `S` e gli archi che rappresentano i successori. File in `Introduzione IA/images/`.
>
> ![[INSERISCI_IMMAGINE_grafo_spazio_stati.png]]

### 4.2 Albero di Ricerca

L'**albero di ricerca** (*search tree*) e l'albero dei "cosa se": rappresenta i piani possibili e i loro esiti.

* lo **stato iniziale** e il nodo radice;
* i **figli** corrispondono ai successori del nodo;
* i nodi **mostrano stati**, ma ciascuno corrisponde a un **piano** che raggiunge quello stato;
* per la maggior parte dei problemi l'intero albero non può essere costruito.

> [!IMPORTANT] Ogni Nodo dell'Albero e un Piano, Non uno Stato
> La relazione fra le due strutture è di tipo molti-a-molti: **ogni nodo dell'albero di ricerca corrisponde a un intero cammino (*path*) nel grafo dello spazio degli stati**. Le stesse configurazioni compaiono più volte nell'albero, con piani diversi che vi arrivano. Grafo e albero vengono costruiti **su richiesta**, e si costruisce **il minimo necessario**.

> [!EXAMPLE] Grafo a 4 Stati e Dimensione dell'Albero
> Si consideri il grafo con archi $S \to a$, $a \to b$, $b \to G$, $S \to b$, $b \to a$.
> L'albero di ricerca con radice $S$ presenta una **notevole struttura ripetuta**: i sottoalberi che si dipartono da `a` e da `b` contengono lo stesso pattern, ripetuto indefinitamente perché il grafo contiene cicli. Ne segue che l'albero risulta **potenzialmente infinito**: è la ragione per cui gli algoritmi devono tenere traccia dei nodi già visitati.

> [!WARNING] IMMAGINE DA INSERIRE
> Slide 12-16: inserire lo schema dell'albero di ricerca con la radice `S`, i livelli successivi e l'evidenziazione dei piani (non degli stati) corrispondenti a ciascun nodo, con confronto affiancato al grafo dello spazio degli stati. File in `Introduzione IA/images/`.
>
> ![[INSERISCI_IMMAGINE_albero_ricerca.png]]

### 4.3 Confronto

| Caratteristica | Grafo dello Spazio degli Stati | Albero di Ricerca |
| :--- | :--- | :--- |
| **Cosa rappresenta** | L'insieme delle configurazioni e delle transizioni | I piani possibili e i loro esiti |
| **Occorrenza degli stati** | Ogni stato compare **una sola volta** | Lo stesso stato compare **in più nodi** diversi |
| **Costo della costruzione** | Esplosivo: richiederebbe l'intero grafo | Costruito **su richiesta**, parzialmente |
| **Uso nella pratica** | Idea teorica di riferimento | Struttura effettivamente utilizzata dagli algoritmi |

## 5. La Ricerca su Albero

L'algoritmo generale di ricerca su albero si articola in tre idee cardine:

* **Fringe:** l'insieme dei nodi parzialmente esplorati, ossia i piani ancora in valutazione.
* **Espansione (*expansion*):** la generazione dei successori di un nodo.
* **Strategia di esplorazione:** il criterio con cui si sceglie quale nodo della fringe espandere.

La domanda centrale dell'algoritmo e dunque: **quali nodi della fringe esplorare e in che ordine**.

```text
RICERCA-SU-ALBERO(problema)
    fringe <- [Nodo con stato = problema.stato_iniziale]
    while fringe non e vuota:
        nodo <- RIMOOVI-FRONTIER(fringe)
        if GOAL-TEST(problema, stato(nodo)): return PIANO(nodo)
        fringe <- AGGIUNGI(ESPANSI(nodo), fringe)
    return fallimento
```

Le strategie differiscono esclusivamente nell'implementazione di `RIMOOVI-FRONTIER`: modificando quel solo operatore si ottengono Depth-First, Breadth-First e Uniform Cost Search.

## 6. Gli Algoritmi di Ricerca Non Informata

La ricerca **non informata** (*uninformed search*) non utilizza alcuna conoscenza del problema oltre lo spazio degli stati e la funzione di successore. Ogni algoritmo viene valutato su quattro proprietà:

1. **Completezza:** garantisce di trovare una soluzione se questa esiste?
2. **Ottimalità:** garantisce di trovare il percorso di costo minimo?
3. **Complessita temporale:** quanti nodi espande?
4. **Complessita spaziale:** quanta memoria occupa la fringe?

Siano $b$ il **fattore di ramificazione** (*branching factor*, numero medio di successori per nodo) e $m$ la **profondità massima** dell'albero. Il numero di nodi dell'intero albero e:

$$1 + b + b^2 + \ldots + b^m = O(b^m)$$

> [!WARNING] IMMAGINE DA INSERIRE
> Schema dell'albero con i livelli da $1$ a $b^m$ nodi (1, $b$, $b^2$, ..., $b^m$) usato per confrontare le quattro strategie. File in `Introduzione IA/images/`.
>
> ![[INSERISCI_IMMAGINE_albero_livelli.png]]

### 6.1 Depth-First Search (DFS)

* **Strategia:** espande per primo il nodo più profondo. La fringe è implementata come **stack LIFO**.
* **Nodi espansi:** un prefisso laterale dell'albero; può quindi arrivare a processare l'intero albero. Se $m$ e finito, il tempo e $O(b^m)$.
* **Spazio:** la fringe contiene **solo i fratelli lungo il cammino che risale alla radice**, dunque al più un nodo per livello: $O(m)$.
* **Completezza:** e completa solo se $m$ e finito; in caso contrario può ripercorrere cicli indefinitamente, e rende necessario prevenire le ripetizioni.
* **Ottimalità:** **non e ottima**: trova la soluzione più a sinistra (*leftmost*), indipendentemente dalla sua profondità e dal suo costo.

### 6.2 Breadth-First Search (BFS)

* **Strategia:** espande per primo il nodo meno profondo. La fringe è implementata come **coda FIFO**.
* **Nodi espansi:** processa tutti i nodi posti al di sopra della soluzione più superficiale; indicando con $s$ la profondità della soluzione più superficiale, il tempo è $O(b^s)$.
* **Spazio:** la fringe contiene circa l'ultimo livello esplorato: $O(b^s)$.
* **Completezza:** **è completa**, perché $s$ deve essere finito se esiste una soluzione.
* **Ottimalità:** e ottima **solo se tutti i costi sono uguali a 1**; con costi non uniformi il percorso minimo in numero di azioni non coincide con quello a costo minimo.

### 6.3 Ricerca in Profondita Iterativa (Iterative Deepening)

* **Idea:** ottenere il vantaggio in spazio della DFS con il vantaggio in tempo della BFS sulle soluzioni superficiali.
* **Procedimento:** si esegue una DFS con **limite di profondità 1**; se non produce soluzioni si ripete con limite 2, poi 3, e così via.
* **Ridondanza:** il lavoro risulta chiaramente ridondante, ma **la maggior parte del lavoro si svolge nell'ultimo livello esplorato**, quindi la sovrapposizione tra i livelli inferiori è trascurabile rispetto al livello finale.
* **Proprieta:** completa e ottima (a parità di costi), con tempo $O(b^d)$ e spazio $O(d)$, dove $d$ e la profondità della soluzione.

### 6.4 Uniform Cost Search (UCS)

* **Strategia:** espande per primo il nodo **meno costoso**. La fringe e una **coda di priorità** ordinata sul costo cumulato.
* **Nodi espansi:** processa tutti i nodi con costo inferiore a quello della soluzione più economica. Se la soluzione costa $C^*$ e il costo minimo di un arco e $\epsilon$, la **profondità effettiva** e circa $C^* / \epsilon$: il tempo e $O(b^{C^*/\epsilon})$, quindi esponenziale nella profondità effettiva.
* **Spazio:** la fringe contiene circa l'ultimo livello: $O(b^{C^*/\epsilon})$.
* **Completezza:** e completa se la soluzione ottima ha costo finito e il costo minimo di un arco e positivo.
* **Ottimalità:** **e ottima** (la dimostrazione formale si basa sulla ricerca informata A*).

> [!NOTE] Limiti della Uniform Cost Search
> **A favore:** e completa e ottima, quindi risolve il caso generale a costi non uniformi.
> **Contro:** esplora le opzioni **in ogni direzione**, senza alcuna informazione sulla posizione del goal; con costi tutti uguali a 1 degenera nella BFS.

> [!WARNING] IMMAGINE DA INSERIRE
> Schema dei contouri di costo della UCS con i nodi etichettati dal costo cumulato (`a 6`, `b 4`, `e 5`, `f 8`, `q 11`...) e i nodi di costo superiore al costo della soluzione lasciati inesplorati. File in `Introduzione IA/images/`.
>
> ![[INSERISCI_IMMAGINE_ucs_contours.png]]

### 6.5 Confronto Sintetico

| Algoritmo | Fringe | Ordine di Espansione | Completezza | Ottimalità | Tempo | Spazio |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **DFS** | Stack (LIFO) | Nodo più profondo | Solo con $m$ finito | No | $O(b^m)$ | $O(m)$ |
| **BFS** | Coda (FIFO) | Nodo meno profondo | Si | Solo con costi unitari | $O(b^s)$ | $O(b^s)$ |
| **Iterative Deepening** | Stack con limite di profondità | Per livelli crescenti | Si | Con costi unitari | $O(b^d)$ | $O(d)$ |
| **UCS** | Coda di priorità | Nodo meno costoso | Si (costo minimo degli archi positivo) | Si | $O(b^{C^*/\epsilon})$ | $O(b^{C^*/\epsilon})$ |

### 6.6 La Coda Unica

Tutti questi algoritmi coincidono nell'implementazione e differiscono **soltanto nella strategia di fringe**:

* concettualmente **ogni fringe e una coda di priorità**, ossia un insieme di nodi con priorità associate;
* per DFS e BFS si possono usare stack e code, evitando il costo $O(\log n)$ di una coda di priorità vera e propria;
* e possibile scrivere **una sola implementazione** che accetti come parametro la struttura di accodamento da utilizzare.

## 7. Dalla Ricerca al Sistema Agentico

La sequenza di azioni prodotta dalla ricerca (il piano) e il cuore del ciclo agentico descritto in Lezione 1: nel sistema agentico, la **pianificazione** corrisponde alla generazione del piano, gli **attuatori** corrispondono alle chiamate di strumenti (*tool use*) e le **percezioni** alle osservazioni restituite da quegli strumenti.

> [!IMPORTANT] Il Limite della Ricerca Non Informata
> Tutti gli algoritmi di questo capitolo esplorano lo spazio dei piani **senza sapere dove si trova il goal**: il numero di nodi espansi cresce esponenzialmente e le strategie si limitano a cambiare il ordine di esplorazione. Per usare informazioni sul problema (stime di distanza, euristiche, vincoli) occorrono le strategie **informate**, a partire da A*.
