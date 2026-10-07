# Agenti intelligenti, rappresentazione degli stati e ricerca su albero

## L'agente intelligente e il suo ambiente

*Definizione:* un **agente intelligente** è l'entità che interagisce con il mondo esterno (*environment*) attraverso due categorie di interfacce: i ==sensori==, con cui percepisce, e gli ==attuatori==, con cui agisce (es. Aspirapolvere Roomba, termostato intelligente, rilevatori di fumo, Agentic AI che eseguono autonomamente task multi-step)

**Sensori:** dispositivi che acquisiscono dati dall'ambiente e li forniscono all'agente sotto forma di **percezioni**: telecamere, microfoni, lettura di file, messaggi di rete, output di uno strumento.

**Attuatori:** meccanismi che l'agente invoca per modificare l'ambiente in funzione delle decisioni prese: motori, bracci robotici, click, scrittura su disco, chiamate a funzioni o API.

Il ciclo di interazione è continuo e ricorsivo: l'azione eseguita dall'attuatore modifica l'ambiente, il mutamento viene acquisito dai sensori come nuova percezione e reinserito nel processo decisionale.

```
   SENSORI                AGENTE                 ATTUATORI
 (percezioni)   ----->  (decisione)   ----->   (azioni sull'ambiente)
      ^                                          |
      +------------  nuova percezione  <---------+
                (l'ambiente è stato modificato)
```

L'ambiente non deve essere necessariamente digitale: può essere un ambiente fisico reale (un robot mobile che evita ostacoli), un ambiente software o una simulazione. La struttura del ciclo percezione-decisione-azione rimane invariata, variando unicamente la tipologia di sensori e attuatori impiegati.

**Le quattro proprietà dell'ambiente:** la difficoltà di progettazione e risoluzione di un agente razionale dipende dalla combinazione di quattro dimensioni tassonomiche.

| Proprietà         | Classificazione                             | Definizione e impatto computazionale                                                                                                                                                                                                           |
| :---------------- | :------------------------------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Osservabilità** | *Fully observable* / *Partially observable* | Nell'ambiente completamente osservabile i sensori forniscono in ogni istante l'intero stato del mondo (scacchi); in quello parzialmente osservabile l'agente deve mantenere uno stato interno e inferire le variabili non visibili (carte).    |
| **Determinismo**  | *Deterministic* / *Stochastic*              | In un ambiente deterministico l'esito di un'azione a partire da uno stato è univoco e certo; in uno stocastico l'esito è descritto da una distribuzione di probabilità.                                                                        |
| **Granularità**   | *Discrete* / *Continuous*                   | In un ambiente discreto l'insieme delle percezioni, degli stati e delle azioni possibili è finito e numerabile (es. mosse negli scacchi); in uno continuo le variabili assumono valori reali infiniti (es. coordinate, velocità, temperatura). |
| **Ostilità**      | *Benign* / *Adversarial*                    | L'ambiente benigno non agisce con scopi ostili verso l'agente (es. navigazione stradale su mappa statica); l'ambiente ostile o competitivo include altri agenti che contrastano attivamente gli obiettivi dell'agente.                         |

## L'agente razionale

> [!important] Razionalità:
> Per ogni possibile sequenza di percezioni, un agente razionale seleziona un'azione che massimizza il **valore atteso della propria misura di prestazione**, condizionatamente alle informazioni fornite dalla sequenza percettiva osservata e a ogni conoscenza a priori disponibile.

Formalizzando con $\mathbb{P}$ lo spazio delle sequenze percettive, $\mathbb{A}$ lo spazio delle azioni possibili e $U$ la **misura di prestazione** (*performance measure*, funzione di utilità):

$$
a^* = \arg\max_{a \in \mathbb{A}} \; \mathbb{E}\left[\, U(\text{sequenza di percezioni}, a) \right]
$$

Il ciclo operativo dell'agente si riassume nella sequenza: **percepire, aggiornare il proprio stato interno, selezionare l'azione ottima ed eseguirla**.

> [!info] In altre parole:
> La razionalità non è una virtù assoluta né una facoltà cognitiva universale: è vincolata alla funzione obiettivo $U$ scelta dal progettista. Posso dire all'agente il comportamento che voglio da lui semplicemente fissando $U$, che impone formalmente il comportamento atteso dal sistema.

## La rappresentazione dello stato

Il formalismo adottato per descrivere lo stato del mondo determina l'efficienza degli algoritmi di ricerca e la trattabilità computazionale del problema. Si individuano tre paradigmi:

| Paradigma | Struttura dello stato | Applicazione principale |
| :--- | :--- | :--- |
| **Atomica** | Lo stato è una **scatola nera** (*black box*) priva di struttura interna visibile; il sistema manipola solo identificatori opachi senza poterne ispezionare le componenti. | Ricerca non informata e algoritmi generici su grafi di grandi dimensioni. |
| **Fattorizzata** | Lo stato è un **vettore di attributi**: variabili booleane, numeriche o simboliche appartenenti a domini definiti. | Pianificazione classica, soddisfacimento di vincoli (CSP), SAT solver. |
| **Strutturata** | Lo stato è composto da **oggetti espliciti**, ciascuno con propri attributi e **relazioni logico-relazionali** con gli altri oggetti. | Modelli aperti, ragionamento simbolico, ambienti 3D complessi e basi di conoscenza relazionali. |

## Il problema di ricerca

Un **problema di ricerca** (*search problem*) formale è definito da una quadrupla:

1. **Spazio degli stati ($S$):** l'insieme finito o numerabile delle configurazioni possibili $S = \{S_1, \ldots, S_n\}$.
2. **Funzione di successore ($f$):** specifica l'insieme delle azioni applicabili $A = \{a_1, \ldots, a_m\}$ e il rispettivo costo associato, mappando uno stato e un'azione nello stato risultante:
   $$f : S \times A \to S$$
3. **Stato iniziale ($S_0$) e test di obiettivo (*goal test*):** lo stato di partenza $S_0 \in S$ e un predicato logico booleano che determina se uno stato soddisfa le condizioni di successo ($S \in S_g$).
4. **Soluzione (piano):** una sequenza finita di azioni ordinata $\langle a_1, a_2, \ldots, a_k \rangle$ che trasforma deterministicamente lo stato iniziale in uno stato che supera il goal test:
   $$f(\ldots f(f(S_0, a_1), a_2) \ldots, a_k) \in S_g$$

<div style="display: flex; justify-content: center;">
  <img src="lec02_search_problem_components.png" width="600">
</div>

> [!info] In altre parole:
> La condizione di obiettivo viene verificata **esclusivamente sullo stato finale** generato dal piano: le proprietà che caratterizzano il goal sono valide solo nell'ultimo stato. Gli stati intermedi attraversati durante l'esecuzione non devono necessariamente soddisfare quei vincoli.

### I problemi di ricerca sono modelli

La formulazione matematica del problema non coincide con il mondo reale, ma ne costituisce un **modello astratto semplificato**.

> [!important] Pianificazione in simulazione:
> L'agente non esegue fisicamente tutti i piani possibili nell'ambiente reale durante la ricerca: la pianificazione avviene interamente **in simulazione** all'interno del modello. L'efficacia e la correttezza del piano calcolato sono quindi limitate dalla fedeltà e dall'accuratezza del modello adottato (*"Your search is only as good as your models"*).

### L'esempio fondamentale: il viaggio in Romania

Un esempio classico è la ricerca del percorso ottimale tra città sulla rete stradale della Romania:

- **Spazio degli stati:** le città della rete stradale.
- **Funzione di successore:** percorrere una strada verso una città adiacente, con **costo dell'azione pari alla distanza chilometrica**.
- **Stato iniziale:** Arad.
- **Goal test:** $\text{stato} == \text{Bucharest}$.

<div style="display: flex; justify-content: center;">
  <img src="lec02_romania_graph.png" width="600">
</div>

## Lo stato del mondo e lo stato di ricerca

La progettazione efficiente di un problema di ricerca richiede di separare le informazioni ridondanti da quelle essenziali:

- **Stato del mondo (*world state*):** include ogni minimo dettaglio dell'ambiente operativo.
- **Stato di ricerca (*search state*):** trattiene unicamente i dettagli strettamente necessari alla formulazione del piano, astraendo le variabili ininfluenti.

<div style="display: flex; justify-content: center;">
  <img src="lec02_state_space_pacman.png" width="600">
</div>

Nell'ambiente di Pac-Man la scelta delle variabili di stato varia in funzione dell'obiettivo:

| Task | Stati | Azioni | Successore | Goal test |
| :--- | :--- | :--- | :--- | :--- |
| **Pathing** (navigazione) | posizione $(x, y)$ | NESW | aggiorna solo la posizione | is $(x, y) =$ END |
| **Eat-All-Dots** (raccolta totale) | $\{(x, y), \text{booleani dei pallini}\}$ | NESW | aggiorna la posizione ed eventualmente un booleano di pallino | tutti i pallini falsi |

Con il task di puntamento basta sapere dove si trova l'agente; con la raccolta totale lo stato di ricerca deve includere anche quali pallini sono ancora presenti.

### La dimensione dello spazio degli stati

Il confronto combinatorio illustra l'esplosione dello spazio degli stati all'aumentare dei dettagli modellati:

| Tipologia di stato | Componenti incluse | Dimensione combinatoria totale |
| :--- | :--- | :--- |
| **World state completo** | 120 posizioni agente, 30 pallini booleani, 12 posizioni fantasmi, 4 orientamenti (NESW) | $120 \times 2^{30} \times 12 \times 4 \approx 6.18 \times 10^{12}$ stati |
| **Search state: Pathing** | Posizione agente $(x, y)$ | $120$ stati |
| **Search state: Eat-All-Dots** | Posizione agente $(x, y)$ + stato dei 30 pallini | $120 \times 2^{30} \approx 1.29 \times 10^{11}$ stati |

> [!important] Il vero collo di bottiglia:
> La complessità intrinseca del problema non risiede nel numero di azioni disponibili, ma nell'**esplosione combinatoria del numero di stati possibili**. L'astrazione mirata è lo strumento concettuale primario per rendere computazionalmente trattabili problemi complessi.

## Il grafo dello spazio degli stati e l'albero di ricerca

**Grafo dello spazio degli stati** (*state space graph*): è la rappresentazione matematica astratta del problema di ricerca.

- I **nodi** rappresentano configurazioni astratte del mondo.
- Gli **archi orientati** corrispondono ai risultati delle azioni, cioè alle transizioni tra stati.
- Il **goal test** individua il sottoinsieme dei nodi obiettivo, che può essere composto anche da un solo nodo.

<div style="display: flex; justify-content: center;">
  <img src="lec02_state_space_graph.png" width="600">
</div>

Due proprietà distintive: ogni stato del problema compare **una e una sola volta** nel grafo, e per problemi di scala reale il grafo completo è troppo vasto per essere costruito o memorizzato esplicitamente, resta un modello concettuale di riferimento.

**Albero di ricerca** (*search tree*): è la struttura gerarchica che rappresenta i piani ipotetici ("cosa se", *what if*) e le rispettive conseguenze.

- La **radice** corrisponde allo stato iniziale $S_0$.
- I **nodi figli** corrispondono ai successori generati dall'applicazione delle azioni ammissibili.
- I nodi mostrano stati, ma rappresentano **piani**: ogni nodo individua l'intera sequenza di azioni che consente di raggiungere quello specifico stato a partire dalla radice.

<div style="display: flex; justify-content: center;">
  <img src="lec02_search_tree_concept.png" width="600">
</div>

Come il grafo, nella maggior parte dei problemi l'albero completo non può essere costruito davvero.

### Confronto fondamentale: grafo e albero

La distinzione tra grafo dello spazio degli stati e albero di ricerca è un cardine teorico della disciplina.

<div style="display: flex; justify-content: center;">
  <img src="lec02_state_space_vs_search_tree.png" width="600">
</div>

> [!important] Nodi dell'albero e cammini del grafo:
> **Ogni singolo nodo dell'albero di ricerca corrisponde a un intero percorso (*path*) nel grafo dello spazio degli stati.** Poiché uno stesso stato può essere raggiunto attraverso molteplici cammini distinti, la stessa configurazione può comparire replicata in più nodi dell'albero. Il grafo resta un modello formale: in pratica se ne istanzia *on demand* solo la porzione raggiunta durante la ricerca, e sempre nel minimo necessario.

| Proprietà | Grafo dello spazio degli stati | Albero di ricerca |
| :--- | :--- | :--- |
| **Entità rappresentata** | Insieme delle configurazioni e delle transizioni | Insieme dei piani esaminati e dei loro esiti |
| **Occorrenza di ciascuno stato** | Ogni configurazione compare **esattamente una volta** | Uno stesso stato compare **in più nodi distinti** |
| **Dimensione e costruzione** | Esplosivo; modello formale, di cui si istanzia *on demand* solo la porzione esplorata | Costruito *on demand* ed espanso il minimo necessario |
| **Ruolo algoritmico** | Modello formale di riferimento | Struttura generata ed esplorata dagli algoritmi |

### Strutture ripetute e gestione dei cicli

Si consideri un grafo a 4 stati ($S, a, b, G$) con transizioni $S \to a$, $S \to b$, $a \to G$, $b \to G$ e un ciclo bidirezionale $a \leftrightarrow b$.

<div style="display: flex; justify-content: center;">
  <img src="lec02_search_tree_quiz_cycles.png" width="600">
</div>

Dato il ciclo tra $a$ e $b$, l'albero di ricerca con radice $S$ manifesta una **continua e infinita struttura ripetuta** nei sottoalberi:

- Dal nodo $a$ si può generare $b$, dal quale si può rigenerare $a$, e così via ricorsivamente.
- Pur a fronte di uno spazio degli stati finito (4 nodi), l'**albero di ricerca associato ha dimensione infinita ($\infty$)**.
- Questa evidenza teorica impone agli algoritmi di ricerca di implementare meccanismi espliciti per la gestione degli stati già visitati e la potatura dei cammini ciclici ridondanti.

## La ricerca su albero e la frontiera

L'esplorazione dell'albero di ricerca si fonda su tre concetti operativi:

1. **Espansione (*expansion*):** generazione dei nodi figli, cioè dei piani successivi, a partire da un nodo selezionato.
2. **Frontiera (*fringe*, *frontier*):** la struttura dati che mantiene l'insieme dei nodi parzialmente esplorati, i piani parziali attualmente sotto esame e in attesa di selezione.
3. **Strategia di esplorazione:** il criterio decisionale impiegato per determinare quale nodo estrarre dalla frontiera ed espandere al passo successivo. L'obiettivo è raggiungere il goal espandendo il minor numero possibile di nodi complessivi.

### Costruzione dell'albero sul problema della Romania

L'applicazione del paradigma di ricerca all'itinerario in Romania illustra il ruolo della *fringe*.

<div style="display: flex; justify-content: center;">
  <img src="lec02_romania_tree_search_fringe.png" width="600">
</div>

1. **Passo 0 (inizializzazione):** la fringe contiene solo il nodo radice $\{\text{Arad}\}$.
2. **Passo 1 (espansione di Arad):** il nodo $\text{Arad}$ viene rimosso dalla fringe ed espanso, generando i successori $\text{Sibiu}$, $\text{Timisoara}$ e $\text{Zerind}$. La nuova frontiera diventa $\{\text{Sibiu}, \text{Timisoara}, \text{Zerind}\}$.
3. **Passo 2 (scelta ed espansione di Sibiu):** la strategia seleziona $\text{Sibiu}$; espandendolo si generano i sotto-piani verso $\text{Arad}$, $\text{Fagaras}$, $\text{Oradea}$ e $\text{Rimnicu Vilcea}$.

I nodi foglia non ancora espansi, evidenziati con tratteggio verde, costituiscono la frontiera attiva tra cui la strategia opererà la successiva selezione.

> [!important] Il quesito centrale della ricerca:
> **Quale nodo presente nella frontiera (*fringe*) deve essere scelto ed espanso per primo?**

La scelta della politica di estrazione dalla fringe determina le proprietà algoritmiche e differenzia le strategie di:

- **Ricerca non informata (*uninformed search*):** operano sfruttando unicamente la struttura dello spazio degli stati, es. *depth-first search* tramite stack LIFO, *breadth-first search* tramite coda FIFO, *uniform cost search* tramite coda di priorità su costo cumulato.
- **Ricerca informata (*informed search*):** guidano l'esplorazione mediante funzioni euristiche informative dirette verso il goal, es. *greedy best-first*, $A^*$.

## I criteri di valutazione di un algoritmo di ricerca

Prima di confrontare le strategie servono quattro proprietà. Ogni algoritmo viene valutato su quattro domande: quali nodi espande, quanto tempo richiede, quanto spazio occupa la fringe, e se è completo e ottimale.

- **Completezza:** l'algoritmo garantisce di trovare una soluzione *se e solo se* una soluzione esiste?
- **Ottimalità:** l'algoritmo garantisce di trovare il percorso di *minor costo*, non una soluzione qualsiasi?
- **Complessità temporale:** quanti nodi espande, quindi quanto tempo impiega.
- **Complessità spaziale:** quanti nodi deve tenere contemporaneamente, quindi quanta memoria occupa.

Per esprimere tempo e spazio in funzione della forma dell'albero servono due parametri: il **fattore di ramificazione $b$** (*branching factor*), il numero di figli che ogni nodo genera in media, e la **profondità massima $m$**, il livello più profondo raggiungibile. L'albero cresce a potenza di $b$: al livello 0 c'è $1$ nodo, al livello 1 ci sono $b$ nodi, al livello 2 ci sono $b^2$ nodi, e così via fino a $b^m$ all'ultimo livello. Il numero totale di nodi dell'intero albero è quindi una serie geometrica:

$$1 + b + b^2 + \dots + b^m = O(b^m)$$

Il numero di nodi al livello $k$ è $b^k$: a ogni passo la ramificazione moltiplica il totale per $b$. Per questo la crescita è **esponenziale** in profondità, ed è il parametro $b$ a fare la differenza in pratica.

## Depth-First Search (DFS)

La strategia è espandere **prima il nodo più profondo** (*expand a deepest node first*), e l'implementazione mantiene la fringe come uno **stack LIFO** (*last in, first out*), così che l'ultimo nodo generato è il primo ad essere estratto. Espanso un nodo, i suoi figli vengono impilati in cima e il successivo ad essere estratto è l'ultimo inserito: la ricerca procede a zigzag, scendendo in profondità su un ramo prima di risalire.

- **Quali nodi espande:** un **prefisso sinistro** dell'albero (*some left prefix of the tree*); potrebbe arrivare a processare l'albero intero.
- **Complessità temporale:** se $m$ è finita, impiega $O(b^m)$.
- **Complessità spaziale:** la fringe contiene solo i fratelli lungo il cammino che porta alla radice, quindi $O(b^m) (1+b+b^{2}+\dots+b^{m})$. Questo è il vantaggio rispetto a BFS: memoria contenuta anche su alberi enormi.
- **Completezza:** $m$ potrebbe essere infinita, quindi l'algoritmo è completo **solo se si impediscono i cicli**, gestendo gli stati già visitati (cfr. il ciclo $a \leftrightarrow b$).
- **Ottimalità:** **no.** Trova la soluzione "più a sinistra", cioè la prima incontrata, **indipendentemente dalla profondità e dal costo**.

![[Pasted image 20261007162205.png]]

> [!warning] DFS non è completo in presenza di cicli
> Su uno spazio di stati finito ma ciclico l'albero di ricerca è infinito, e il DFS può restare intrappolato nel ciclo senza mai raggiungere il goal. Senza il controllo degli stati già visitati non c'è garanzia di terminare con una soluzione.

## Breadth-First Search (BFS)

La strategia è espandere **prima il nodo più superficiale** (*expand a shallowest node first*), e l'implementazione mantiene la fringe come una **coda FIFO** (*first in, first out*): il primo nodo generato è il primo ad essere estratto. L'effetto è che tutti i nodi di un livello vengono espansi prima di passare al livello successivo.

- **Quali nodi espande:** processa **tutti i nodi al di sopra della soluzione più superficiale**.
- **Complessità temporale:** indicando con $s$ la profondità della soluzione più superficiale, impiega $O(b^s)$.
- **Complessità spaziale:** la fringe contiene circa l'ultimo livello esplorato, quindi $O(b^s)$. È il prezzo della completezza: memoria molto più grande del DFS.
- **Completezza:** $s$ deve essere finita se esiste una soluzione, quindi **sì, è completo**.
- **Ottimalità:** **solo se tutti i costi sono 1.** Con costi diversi trova la soluzione con meno *azioni*, non necessariamente quella più economica.

![[Pasted image 20261007162652.png]]

> [!example] La differenza tra "meno azioni" e "minore costo"
> Nell'esempio *cost-sensitive* della lezione il BFS trova il cammino più corto **in termini di numero di azioni**, e la slide avverte che con costi diversi esso **non** trova il cammino di minor costo. Il controesempio minimo: un percorso di 2 azioni da 10 punti l'una costa 20, mentre un percorso di 3 azioni da 1 punto costa 3. Il BFS restituisce il primo, cioè il più economico in numero di passi ma il più caro in valore.

## Iterative Deepening

L'idea è ottenere il **vantaggio di spazio del DFS** (la fringe piccola) con il **vantaggio di tempo del BFS** (la soluzione superficiale viene trovata presto), perché ogni algoritmo è "sfruttato male" su un aspetto e "bene" sull'altro.

- Si esegue un DFS con **limite di profondità 1**: se non si trova una soluzione, si esegue un DFS con limite 2; poi con limite 3, e così via fino a trovare il goal.
- **Obiezione:** non è uno spreco ridondante? In generale **no**, perché la maggior parte del lavoro di ciascun giro avviene al livello più profondo cercato, e quel livello non è mai stato esplorato prima. I livelli superiori vengono riesplorati, ma sono economici rispetto all'ultimo.

<div style="text-align: center;">
  <img src="Pasted image 20261007163920.png" alt="Immagine" />
  <p>BFS finds the shortest path in terms of number of actions. It does not find the least-cost path. We will now cover a similar algorithm which does find the least-cost path.</p>
</div> 

> [!note]
> Gli algoritmi greedy non garantiscono l'ottimalità in quanto ad ogni passo si sceglie l'arco che costa di meno e questo può portare a percorsi molto lunghi ma non ottimizzati

## Uniform Cost Search (UCS)

Prima di UCS il problema è messo in evidenza: il BFS trova il percorso più corto **in termini di numero di azioni**, ma non il percorso a **minor costo**. UCS è l'algoritmo che trova invece il percorso economico.

- **Strategia:** espandere **prima il nodo più economico** (*expand a cheapest node first*). 
- **Fringe:** una **coda di priorità**, con priorità data dal **costo cumulato** del piano rappresentato da ciascun nodo.
- **Quali nodi espande:** processa **tutti i nodi con costo inferiore a quello della soluzione più economica**. Nell'esempio le etichette di costo $1$, $2$, $3$ si dispongono a **contorni concentrici** (*cost contours*) attorno allo stato iniziale: l'algoritmo esplora espandendosi a cerchi di costo crescente.
- **Profondità efficace:** se la soluzione ottima ha costo $C^*$ e ogni arco ha costo almeno $\varepsilon$, allora la profondità effettiva è circa $C^*/\varepsilon$. In altre parole, le "tiers" da esplorare sono $C^*/\varepsilon$ anziché $m$.
- **Complessità temporale:** $O(b^{C^*/\varepsilon})$, **esponenziale nella profondità efficace**.
- **Complessità spaziale:** la fringe contiene circa l'ultimo livello, quindi $O(b^{C^*/\varepsilon})$.
- **Completezza:** **sì**, purché la soluzione migliore abbia costo finito e il costo minimo di un arco sia positivo.
- **Ottimalità:** **sì**, è garantita (la dimostrazione si dà nella lezione successiva con $A^*$).

![[Pasted image 20261007164115.png]]

> [!warning] I limiti di UCS
> Il *good* è che UCS è completo e ottimale. Il *bad* è che **esplora opzioni in ogni direzione** e **non ha alcuna informazione sulla posizione del goal**: mancando un'informazione che guidi la ricerca, è costretto a espandere tutti i nodi più economici prima di arrivare alla soluzione, anche quando il goal è vicino. È il problema che $A^*$ risolverà con l'euristica.

> [!note]
> L'algoritmo UCS non ammette archi a costo negativo. Crea la coda di priorità ed espande in nodi in ordine crescente di costo cumulato. Alla fine avrà visto tutti i nodi (completo) e conoscerà il percorso di costo minore (ottimo) da nodo di partenza a nodo di arrivo
## Un'unica coda per tutti gli algoritmi (*The One Queue*)

Tutti questi algoritmi sono **identici tranne che per la strategia sulla fringe**:

- **Concettualmente**, ogni fringe è una **coda di priorità**, cioè una collezione di nodi con priorità associata.
- **In pratica**, per DFS e BFS si può evitare il costo $\log(n)$ di una coda di priorità vera usando rispettivamente uno stack e una coda, perché l'ordine di estrazione è già determinato dalla struttura.
- Si può persino scrivere **una sola implementazione** che accetti come parametro un oggetto coda variabile: cambia la struttura dati, cambia l'algoritmo.

> [!info] La ricerca opera su modelli
> La ricerca lavora sopra **modelli** del mondo: l'agente non prova davvero tutti i piani nel mondo reale, il *planning* avviene interamente "in simulazione". La qualità della ricerca è quindi limitata dalla qualità dei modelli che le si forniscono.

# Questione della stima
$f = g + h$ con h è l'euristica
Funzione quindi dipende da:
- Dipende dal problema
- Buona stima (possono esistere diverse euristiche)
- Poco costosa

> [!info] Sintesi:
> - L'agente interagisce con l'ambiente attraverso sensori (percezioni) e attuatori (azioni); il ciclo percezione-decisione-azione è continuo e ricorsivo.
> - L'ambiente si classifica per osservabilità, determinismo, granularità e ostilità; l'agente razionale massimizza il valore atteso della misura di prestazione $U$ scelta dal progettista.
> - Lo stato si rappresenta in modo atomico, fattorizzato o strutturato; la scelta del formalismo decide l'efficienza della ricerca.
> - Un problema di ricerca è la quadrupla $(S, f, S_0, \text{goal test})$, e la sua soluzione è il piano di azioni che porta da $S_0$ a uno stato che supera il goal test; il goal test si verifica solo sullo stato finale del piano.
> - World state e search state si distinguono per astrazione: nel Pac-Man si passa da 120 a $120 \times 2^{30} \approx 1.29 \times 10^{11}$ stati, ed è la dimensione dello spazio degli stati il vero collo di bottiglia.
> - Nel grafo ogni stato compare una volta sola, nell'albero un nodo è un intero percorso e gli stessi stati si ripetono: i cicli rendono l'albero infinito.
> - Il *tree search* mantiene una *fringe* e la domanda che distingue ogni algoritmo è quale nodo della frontiera espandere per primo.
> - Gli algoritmi si giudicano su quattro proprietà: quali nodi espandono, complessità temporale e spaziale, completezza e ottimalità; tempo e spazio si esprimono in $O(b^m)$ con $b$ fattore di ramificazione e $m$ profondità massima.
> - DFS espande il nodo più profondo con fringe LIFO: $O(b^m)$ in tempo e spazio, completo solo senza cicli, mai ottimale. BFS espande il più superficiale con fringe FIFO: $O(b^s)$, completo, ottimale solo con costi unitari.
> - Iterative Deepening ripete il DFS con limiti di profondità crescenti per unire il vantaggio di spazio del DFS a quello di tempo del BFS.
> - UCS espande il nodo a costo cumulato minimo con coda di priorità: completo e ottimale, con profondità efficace $C^*/\varepsilon$, ma esplora in ogni direzione e ignora dove sia il goal.
> - Tutti questi algoritmi sono lo stesso a parte la fringe: ogni fringe è concettualmente una coda di priorità e una sola implementazione parametrizzata cambia algoritmo.