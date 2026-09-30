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
