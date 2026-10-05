E# Fondamenti di intelligenza artificiale, machine learning e modelli generativi

## Che cos'è l'intelligenza artificiale

L'**intelligenza artificiale** è la disciplina informatica che studia lo sviluppo di sistemi hardware e software capaci di risolvere compiti che richiederebbero intelligenza umana. Le sue radici teoriche sono nei primi anni '50: nel 1950 Alan Turing, nell'articolo *Computing Machinery and Intelligence*, si chiede se una macchina possa pensare e interagire con l'essere umano usando il suo stesso linguaggio naturale, con l'*Imitation Game*, noto come **Test di Turing**.

L'ecosistema dell'IA moderna è una gerarchia insiemistica:

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

- **Machine Learning (ML):** sottoinsieme dell'IA basato su algoritmi che apprendono pattern e relazioni matematiche direttamente dai dati, senza essere programmati con regole rigide.
- **Deep Learning (DL):** branca del machine learning basata su reti neurali artificiali multi-strato con un elevato numero di parametri.
- **IA generativa:** sistemi di deep learning progettati per generare nuovi contenuti, testo, codice, immagini, audio o azioni, a partire da distribuzioni di probabilità apprese.

> [!info] In altre parole:
> Nella programmazione tradizionale il programmatore combina *dati* e *regole logiche predeterminate* per calcolare le *risposte*. Nel machine learning si forniscono all'algoritmo di apprendimento i *dati* e le *risposte attese*, cioè esempi etichettati: l'algoritmo deduce da solo le relazioni statistiche e ne ricava un **modello**.

## L'addestramento

*Definizione:* l'**addestramento** (*training*) è il processo algoritmico che determina i valori ottimali dei parametri interni di un modello, minimizzando l'errore di predizione e garantendo un'accurata capacità di inferenza su dati non ancora osservati.

$$\text{Dati di Input} + \text{Risposte Attese} \xrightarrow{\text{Algoritmo di Apprendimento}} \text{Modello Ottimizzato}$$

L'algoritmo opera in modo **iterativo**: aggiorna progressivamente i parametri passo dopo passo e termina al raggiungimento della convergenza numerica, cioè quando l'errore non diminuisce più, oppure quando si verifica una condizione di arresto prefissata (*early stopping*).

> [!important] Generalizzazione, non memorizzazione
> L'obiettivo del machine learning è la **generalizzazione**, non la pura memorizzazione dei dati. Per questo il modello si addestra sul *training set*, ma ==le prestazioni vanno verificate su un insieme disgiunto di dati mai visti durante il training==, il **test set**: è ciò che previene l'**overfitting**, il sovradattamento.

**Complessità del modello:** per risolvere compiti complessi servono modelli con un elevato numero di parametri, cioè una *capacità rappresentativa* elevata, che richiedono però moli massicce di dati di addestramento per evitare l'instabilità o il sottoadattamento (*underfitting*).

**Distribuzione di probabilità:** il modello assegna una probabilità a ogni possibile risposta dello spazio di output. L'obiettivo dell'addestramento è incrementare progressivamente la massa di probabilità associata alla risposta attesa, il *target*.

## La funzione di perdita e l'ottimizzazione

Il problema di partenza è la separazione di due classi di punti bidimensionali, classe A e classe B, mediante un modello lineare, cioè una retta definita da due parametri: la pendenza $m$ e l'intercetta $q$.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260930174136.png" width="550">
</div>

L'algoritmo procede in tre tempi:

1. **Inizializzazione casuale:** i parametri $(m, q)$ assumono valori casuali e la retta taglia lo spazio senza separare correttamente i punti, nell'esempio 47 errori di classificazione su 92 campioni.
2. **Ottimizzazione iterativa:** i parametri vengono corretti passo dopo passo, orientando e traslando la retta verso la configurazione di massima separazione, che raggiunge un solo errore su 92.
3. **Misura dell'errore:** per guidare la correzione l'errore va quantificato con una funzione obiettivo scalare, la **loss**.

*Definizione:* la **loss** $\mathcal{L}$ è il valore numerico che misura la discrepanza fra la predizione del modello e il valore reale atteso. Durante l'apprendimento la curva della loss decresce progressivamente, tendendo idealmente a 0.

Nella classificazione probabilistica si adotta di solito la **Cross-Entropy Loss**, cioè il *Negative Log-Likelihood*:

$$\text{loss} = -\ln(P)$$

dove $P \in (0, 1]$ è la probabilità che il modello assegna alla risposta attesa:

- se $P \to 1$, cioè predizione perfetta con massima certezza, $-\ln(1) = 0$ e la loss è 0;
- se $P \to 0$, cioè predizione errata o incertezza elevata, $-\ln(P) \to +\infty$ e la loss è molto alta.

**Il paesaggio della loss:** ogni possibile combinazione dei parametri del modello è un punto dello spazio della loss, il *loss landscape*.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260930175214.png" width="600">
</div>

- **Spazio dei parametri:** ogni coordinata $(m, q)$ sulla superficie corrisponde a un modello specifico, una precisa retta nel piano dei dati.
- **Gradiente** $\nabla \mathcal{L}$: vettore delle derivate parziali che indica la direzione di massima salita della loss. L'ottimizzazione procede nella direzione opposta, cioè in discesa del gradiente (*gradient descent*).
- **Learning rate** $\eta$: iperparametro che determina l'ampiezza dello spostamento, la lunghezza del passo, nello spazio dei parametri a ogni iterazione:

$$\theta^{(t+1)} = \theta^{(t)} - \eta \nabla \mathcal{L}(\theta^{(t)})$$

<u>Il ciclo di addestramento completo si compone di quattro fasi.</u>

1. **Predizione** (*forward pass*): calcolo delle uscite del modello a partire dagli esempi di input.
2. **Calcolo della loss**: valutazione numerica dell'errore rispetto alle risposte attese.
3. **Calcolo del gradiente** (*backward pass*, *backpropagation*): calcolo analitico di quanto ciascun parametro ha contribuito all'errore.
4. **Aggiornamento dei parametri:** modifica dei pesi in direzione contraria al gradiente.

A convergenza raggiunta i parametri vengono **fissati**, il modello entra in fase di **inferenza**.

Lo stesso principio matematico, forward pass, loss, gradiente e aggiornamento, si applica invariato alle **reti neurali profonde**: cambia la scala, da 2 parametri a centinaia di milioni o miliardi connessi in architetture stratificate.

## Dai classificatori ai large language model

A ogni passo generativo un **large language model** esegue, a livello fondamentale, un'operazione di **classificazione multi-classe**, in cui le classi target sono tutte le parole del suo vocabolario.

| Paradigma | Classificatore supervisionato | Pre-addestramento LLM | Personalizzazione e allineamento |
| :--- | :--- | :--- | :--- |
| **Origine delle etichette** | un essere umano, un "oracolo", etichetta esplicitamente ogni esempio | nessun oracolo: il target è la parola successiva già presente nel testo grezzo | esperti umani, con esempi di risposte desiderate e preferenze comparative |
| **Tipo di apprendimento** | apprendimento supervisionato classico | apprendimento auto-supervisionato (*self-supervised learning*) | *fine-tuning*, *instruction tuning*, RLHF, DPO |

Il modello impara quindi la struttura della lingua e la conoscenza del mondo minimizzando l'errore nella predizione della parola successiva (*next-token prediction*) su miliardi di documenti testuali. La supervisione umana specializzata interviene solo a valle, per allineare e personalizzare il modello verso compiti conversazionali o specifici.

**Dal testo ai numeri:** i modelli elaborano esclusivamente vettori numerici, e il passaggio dal linguaggio naturale alla rappresentazione numerica si articola in tre stadi.

```
[ Testo Grezzo ] ──► [ Tokenizzazione (Sub-word) ] ──► [ Vettori di Embedding ] ──► [ Modello ]
```

1. **Tokenizzazione:** il testo in ingresso viene scomposto in unità discrete dette **token**, frammenti di parola o *sub-word*, per esempio `«capitale»` diventa `«capi»` + `«tale»`.
2. **Embedding vettoriale:** a ciascun token viene associato un vettore numerico denso ad alta dimensionalità, i cui pesi vengono appresi durante il training.
3. **Geometria semantica:** lo spazio geometrico degli embedding codifica le relazioni semantiche fra i concetti: parole correlate o che ricorrono in contesti simili occupano posizioni vicine.

## L'architettura Transformer

Introdotta nel 2017 nel paper *Attention Is All You Need*, l'architettura **Transformer** ha superato le limitazioni delle reti ricorrenti (RNN, LSTM):

- **Elaborazione simultanea:** ogni posizione della sequenza interagisce contemporaneamente con tutti gli altri token del contesto (*self-attention*), senza dover processare il testo sequenzialmente parola per parola.
- **Parallelizzazione massiva:** durante l'addestramento tutte le posizioni vengono elaborate in parallelo su cluster di acceleratori hardware, GPU e TPU, il che rende fattibile il training su volumi di dati e parametri su scala planetaria.

Il flusso di trasformazione interno si articola attraverso blocchi Transformer ripetuti in profondità.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260930181234.png" width="600">
</div>

$$\text{Testo} \longrightarrow \text{Token} \longrightarrow \text{Vettori} \longrightarrow \left[ \begin{matrix} \text{Attenzione} \\ \text{Rete Feed-Forward} \end{matrix} \right] \times N \longrightarrow \text{Probabilità del Token Successivo}$$

**Generazione autoregressiva e campionamento:** a ogni iterazione il modello emette una distribuzione di probabilità sull'intero vocabolario, e da lì si sceglie in due modi:

- *Scelta deterministica* (*greedy*): si seleziona sempre il token a probabilità massima, quindi a parità di prompt l'output è identico.
- *Campionamento probabilistico*: estrazione stocastica pesata sulle probabilità, regolata da parametri come *temperature*, *top-k* e *top-p*: esecuzioni multiple dello stesso prompt possono divergere, introducendo variabilità e creatività.

> [!warning] Attenzione:
> La fluidità e la coerenza grammaticale del testo generato derivano esclusivamente dal calcolo probabilistico iterativo. L'apparente padronanza linguistica **non implica di per sé comprensione semantica, correttezza fattuale o facoltà cognitive umane**, e espone il sistema a **allucinazioni**.

## La tassonomia dei modelli generativi

In base alla tipologia di input e output elaborati i modelli generativi si classificano in:

- **LLM** (*large language model*): elaborano sequenze testuali per produrre testo, $\text{testo} \to \text{testo}$.
- **VLM** (*vision-language model*): elaborano congiuntamente immagini e testo per generare descrizioni, risposte o analisi testuali, $\text{immagine} + \text{testo} \to \text{testo}$.
- **VLA** (*vision-language-action*): elaborano input visivi e istruzioni testuali per calcolare comandi attuativi e azioni fisiche nel mondo reale, per sistemi robotici, $\text{immagine} + \text{testo} \to \text{azioni}$.
- **Modelli generativi di immagini:** generano o modificano immagini sintetiche a partire da descrizioni testuali, $\text{testo} \to \text{immagine}$, come i modelli a diffusione.

Un **foundation model** è un modello di grandi dimensioni pre-addestrato su vastissimi dataset eterogenei, che funge da base comune e può essere adattato (*fine-tuned*) a molteplici task applicativi verticali, inclusi i sistemi multimodali come VLM e VLA.

Nell'evoluzione storica e tecnologica dei modelli di IA alcune cose restano e altre cambiano:

| Cosa resta | Cosa cambia |
| :--- | :--- |
| apprendimento guidato dai dati | scala di dati, parametri e calcolo |
| minimizzazione di una funzione loss | architetture, con l'avvento del Transformer |
| discesa del gradiente come motore matematico fondamentale | metodologie di allineamento e di tuning |
| | modalità d'uso: RAG, tool e agenti |

L'incremento del numero di parametri conferisce al modello maggiore capacità di rappresentazione geometrica e generalizzazione concettuale. Il modello **non opera come un database deterministico o un archivio rigido di risposte**, sebbene alcuni dati fattuali frequenti possano rimanere memorizzati nei pesi.

## Sistemi basati su documenti e sistemi agentici

L'accesso diretto a documenti e fonti informative esterne, il *Retrieval-Augmented Generation* (RAG), garantisce vantaggi strutturali critici:

- rende la risposta generata **verificabile, ispezionabile e controllabile**;
- consente l'aggiornamento dinamico delle conoscenze senza richiesti costosi riaddestramenti del modello;
- riduce drasticamente le allucinazioni, ancorando le asserzioni a contesti documentali certi.

La discriminante fra un'architettura documentale convenzionale e un sistema agentico risiede nell'**autonomia decisionale sui passi operativi**.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260930182802.png" width="600">
</div>

**Architettura a flusso fisso**, pipeline deterministica: i passaggi esecutivi sono rigidamente prefissati dal progettista del software, per esempio cerca nel database, poi inserisci nel prompt, poi genera risposta. Il flusso compie un unico passaggio deterministico, invariante rispetto alla complessità della richiesta.

**Sistema agentico**, agent loop: è il modello stesso a pianificare dinamicamente la sequenza di azioni necessarie per completare un obiettivo articolato.

1. *Pianificazione* (*plan*): analizza l'obiettivo e stabilisce il sotto-task immediato, per esempio reperire un dato o eseguire un calcolo.
2. *Utilizzo di strumenti* (*tool use*, *action*): invoca tool esterni specializzati, motori di ricerca, interpreti Python, calcolatori, API.
3. *Osservazione* (*observation*): riceve e interpreta il risultato prodotto dallo strumento.
4. *Valutazione e decisione* (*reflect and decide*): valuta se i dati raccolti sono sufficienti e decide se iterare il ciclo invocando ulteriori strumenti o formulare la risposta finale.

<u>Un sistema informativo con accesso a basi di dati o documenti non costituisce necessariamente un agente.</u> ==La natura agentica è determinata dalla capacità del modello di scegliere in autonomia percorsi, strumenti e criteri di arresto su più passi iterativi.==

> [!info] Sintesi:
> - L'IA comprende il machine learning, che comprende il deep learning, che comprende l'IA generativa: la differenza è chi fornisce le regole, il programmatore o i dati.
> - L'addestramento determina i parametri del modello iterativamente e si ferma a convergenza o per *early stopping*; l'obiettivo è generalizzare, verificata sul test set.
> - La loss misura la discrepanza fra predizione e target; con la cross-entropy $-\ln(P)$ una $P \to 1$ dà loss 0 e una $P \to 0$ la fa divergere.
> - L'ottimizzazione segue la direzione opposta al gradiente, con passo determinato dal learning rate, in quattro fasi: predizione, loss, gradiente, aggiornamento.
> - Un LLM è un classificatore multi-classe il cui target è il token successivo, appreso per auto-supervisione; embedding e Transformer rendono possibile il parallelismo.
> - Il fatto di generare si ottiene dallo scegliere un token dalla distribuzione di probabilità, in modo greedy o per campionamento; RAG e sistemi agentici aggiungono fonti esterne e autonomia sui passi.

