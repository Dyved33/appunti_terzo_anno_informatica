# Preparazione al primo esonero — Introduzione all’IA

Le tue risposte sono riportate prima della versione corretta. Le domande senza una tua risposta hanno direttamente una risposta proposta.


> [!important] Utility
> L’**utility** è il valore numerico assegnato a un esito terminale per indicare quanto è desiderabile per un giocatore. In Minimax i valori si misurano dal punto di vista di MAX: MAX li massimizza e MIN li minimizza. In un gioco a somma zero, le utility dei due giocatori sono opposte. Non confonderla con la misura di prestazione, che valuta il successo complessivo dell’agente.

### 1. Descrivi BFS, DFS, IDS e A*. Per ciascuno indica frontiera, completezza, ottimalità e complessità. 

**La tua risposta:**

BFS usa una struttura dati FIFO, è completo e ottimo dato che, se esiste, trova la soluzione con costo migliore. Ha una complessità sia spaziale che temporale di O(b^m). La caratteristica principale sta proprio nella gestione della coda e della frontiera dato che, partendo dal nodo iniziale, inserisce nella coda tutti i nodi figli e in ordine di ingresso li espande. Controlla che un nodo sia o meno il goal dopo averlo estratto dalla frontiera.

DFS usa una struttura dati LIFO ed è completo, ma non ha condizioni di ottimalità. La complessità spaziale è O(bm) mentre quella temporale è O(b^m). L'algoritmo, partendo dalla radice, esplora tutti i nodi raggiungibili e, quando non può avanzare ulteriorimente, torna indietro e visita così tutti gli altri nodi. Una particolarità che lo distingue dal BFS è che il controllo sul nodo se sia o meno il goal viene fatto appena scoperto, senza inserirlo dentro alla coda

IDS è un algoritmo che cerca di unire gli aspetti migliori di BFS e DFS. È completo e ottimo e ha complessità spaziale è O(bm) mentre quella temporale è O(b^m). Esattamente come una DFS usa una coda LIFO, ma come l'algoritmo BFS fa una ricerca per livello esplorando tutti i nodi possibili. A questo si aggiunge la presenza di una variabile che definisce la profondità raggiunta nel grafo e che viene incrementata ogni volta che viene raggiunta dall'esplorazione di quest'ultimo finché non si raggiunge la fine del grafo. Anche in questo caso il goal test viene effettuato quando il nodo viene estratto e prima di metterlo in coda

A* è un algoritmo che sfrutta l'euristica. Nel caso peggiore costa O(b^m) sia in tempo che in spazio ed è completo con costi positivi e condizioni finite ed è ottimale sia su alberi che su grafi (su questi ultimi solo se l'euristica è consistente). L'algoritmo si basa su una coda di priorità ordinata in maniera crescente in base alla formula f(n) = g(n) + h(n) dove f(n) è un valore assegnato ad ogni nodo ottenuto dal costo per raggiungere il nodo stesso dalla radice (g(n)) sommato all'euristica (h(n)). Ad ogni passo si estrae il nodo con f minore e si controlla subito se tale nodo è il goal

> [!info] Risposta corretta
> BFS usa una coda FIFO: estrae prima i nodi più vicini alla radice. È completo se il branching factor è finito ed è ottimo quando tutti i costi sono uguali, perché in quel caso il cammino con meno azioni è anche quello meno costoso. Se la soluzione più superficiale è a profondità $d$, tempo e spazio sono $O(b^d)$. Il goal test si controlla appena il figlio viene estratto dalla frontiera.
>
> DFS usa uno stack LIFO e scende lungo un ramo prima di passare agli altri. Nel caso peggiore impiega $O(b^m)$ tempo e $O(bm)$ spazio, con $m$ profondità massima. Non è ottimo e può non essere completo se incontra cammini infiniti o cicli senza controllo.
>
> IDS ripete una ricerca DFS con limite di profondità crescente. È completo con branching factor finito ed è ottimo se i costi sono unitari. Ha tempo $O(b^d)$ e spazio $O(bd)$.
>
> `A*` usa una coda di priorità e seleziona il nodo con il valore più basso di $f(n)=g(n)+h(n)$. $g(n)$ è il costo già sostenuto e $h(n)$ stima il costo rimanente. `A*` è ottimo su albero con euristica ammissibile; su grafo lo è con euristica consistente, oppure con euristica ammissibile se riapre gli stati quando trova un cammino migliore. Nel caso peggiore tempo e spazio sono esponenziali. Per `A*` il goal test si fa quando si estrae il nodo dalla frontiera.

### 2. Descrivi Minimax e Alpha-beta pruning. Indica a quali giochi si applicano e le complessità.

**La tua risposta:**

L'algoritmo minimax riguarda giochi antagonisti a somma zero e descrive le decisioni che prendono 2 giocatori. Introduce il giocatore MAX, colui che sceglie sempre la mossa migliore, e il giocatore MIN, colui che sceglie sempre la mossa peggiore per MAX. Si basa sulle utilities dei singoli giocatori, dei valori che indicano quanto MAX o MIN si siano avvicinati al proprio obiettivo. L'algoritmo lavora con un albero che rappresenta le decisioni possibili per ogni giocatore e ogni livello, alternatamente, rappresenta un turno dei due. Siccome si conoscono con certezza solo le utilities possibili al livello delle foglie, si parte dal fondo dell'albero verso la cima e ad ogni livello il giocatore prende la strada (l'arco tra due nodi) che lo porta più vicino al suo obiettivo (l'utility finale). Questo algoritmo costa in tempo O(b^m) e in spazio O(bm). In questo contesto si inserisce l'alfa beta pruning che si occupa di diminuire drasticamente il costo computazionale per ogni livello decisionale. Ad esempio se avessi un nodo MAX che deve scegliere un percorso basandosi sul MIN del livello inferiore può ricavare un grande vantaggio da questo algoritmo. Infatti, trovato un primo minimo in un gruppo di nodi figli, se analizzando un altro gruppo di figli trovassi un nodo dal valore inferiore, potrei scartare tutti i suoi fratelli perché non cerco un massimo e anche se ci fosse un nodo di costo inferiore alla fine MAX non lo sceglierebbe in ogni caso

> [!info] Risposta corretta
> Minimax si applica ai giochi deterministici, a somma zero e con informazione perfetta. Nei nodi terminali assegno un’utilità all’esito, misurata dal punto di vista di MAX. Risalgo poi l’albero: MAX sceglie il valore più alto fra i figli, mentre MIN sceglie quello più basso. Così trovo la mossa migliore assumendo che entrambi giochino in modo ottimale.
>
> Con branching factor $b$ e profondità $m$, Minimax richiede $O(b^m)$ tempo e $O(bm)$ spazio con una visita depth-first. In giochi grandi l’albero può essere troppo esteso da esplorare fino agli esiti terminali.
>
> Alpha-beta mantiene $\alpha$, il miglior valore che MAX può già garantire, e $\beta$, il miglior valore che MIN può già garantire. Quando $\alpha \geq \beta$, interrompo l’esplorazione dei figli rimanenti: non possono cambiare la scelta alla radice. Il risultato è lo stesso di Minimax. Nel caso peggiore il tempo resta $O(b^m)$; con un ordinamento perfetto delle mosse può scendere a $O(b^{m/2})$. Lo spazio resta $O(bm)$.

### 3. Descrivi RBFS, con vantaggi e svantaggi nella gestione della memoria.

**La tua risposta:**

L'algoritmo RBFS sfrutta il concetto di euristica come l'A*, ma propone una soluzione per ottimizzare lo spazio. Nel RBFS, infatti, il costo spaziale è lineare O(bm). Per fare ciò questo algoritmo non mantiene aperte tutte le ramificazioni come l'A*, ma usa una variabile per ricordare la seconda scelta migliore per proseguire il cammino dal nodo start al nodo goal. Quando la prima scelta diventa peggiore dell'alternativa queste due vengono scambiate: la seconda scelta diventa la migliore e viene sviluppata, la prima scelta diventa l'alternativa qualora il cambio non portasse nessun vantaggio

> [!info] Risposta corretta
> RBFS esplora ricorsivamente il nodo con il valore $f=g+h$ più basso, ma non conserva tutta la frontiera come A*. A ogni nodo confronta il ramo migliore con la sua alternativa migliore e usa quest’ultima per fissare un limite alla ricerca.
>
> Se il valore $f$ del ramo corrente supera il limite, RBFS torna indietro e salva il valore aggiornato del ramo (*backed-up value*). In questo modo può riprenderlo se in seguito torna a essere la scelta più promettente.
>
> Lo spazio richiesto è lineare nella profondità e nel branching factor, $O(bd)$. Con euristica ammissibile RBFS è ottimo, ma può dover riesplorare più volte i rami che aveva scartato; il tempo può quindi diventare elevato.

### 4. Definisci formalmente un problema di ricerca nello spazio degli stati e una sua soluzione.

**La tua risposta:**

Il problema di ricerca è definito da una quadrupla: uno spazio degli stati che rappresenta l'insieme finito di configurazione i possibili, una funzione di successore che specifica l'insieme di azioni applicabili e il relativo costo applicato il che permette di mappare uno stato e un'azione nello stato risultante, uno stato iniziale e un goal test per sapere il punto di partenza e le condizioni da verificare che, se rispettate, configurano uno stato come finale e infine una soluzione o piano, ovvero una sequenza finita di azioni che trasforma deterministicamente lo stato iniziale in uno stato che supera il goal test

### 5. Quali proprietà si usano per descrivere un ambiente operativo? Fai degli esempi.

**La tua risposta:**

Le 4 proprietà con cui vengono definiti gli ambienti i cui opera un intelligenza artificiale sono: osservabilità, determinismo, granularità, ostilità. Un ambiente osservabile è caratterizzato da sensori che permettono di conoscere in ogni momento l'intero stato del mondo (es scacchi). In alternativa l'agente deve considerare che ci sono delle variabili non visibili (es carte). Un ambiente deterministico è caratterizzato dal fatto che il risultato di una certa azione è dato  e sicuro, mentre in un ambiene stocastico c'è una dipendenza da una distribuzione di probabilità (lancio di dadi). La granularità è la proprietà che distingue un ambiene discreto da uno continuo, vale a dire un ambiente in cui l'insieme delle percezioni è finito e numerabile (mosse in un gioco) piuttosto che infinito con varori reali (es temperatura, velocità). Infine bisogna considerare se l'ambiente è ostile o meno, quindi se l'agente deve competere con altri agenti che lo contrastano o se non c'è nulla che agisca in maniera ostile con l'agente (es navigazione)

> [!info] Risposta alternativa
> Descrivo un ambiente secondo quattro proprietà:
>
> - **Osservabilità:** negli scacchi lo stato è completamente osservabile; con carte coperte alcune informazioni sono nascoste.
> - **Determinismo:** negli scacchi una mossa legale ha un risultato determinato; il lancio di un dado produce esiti incerti.
> - **Granularità:** le mosse degli scacchi sono discrete; temperatura e velocità sono variabili continue.
> - **Ostilità:** nella navigazione su una mappa statica l’ambiente è benigno; negli scacchi l’avversario contrasta i miei obiettivi.

### 6. Quali sono le quattro misure usate per valutare gli algoritmi di ricerca?

**La tua risposta:**

> [!info] Risposta corretta
> Valuto un algoritmo di ricerca con quattro misure. La **completezza** indica se trova una soluzione quando ne esiste una. L’**ottimalità** indica se trova una soluzione di costo minimo. La **complessità temporale** misura il lavoro svolto, spesso espresso tramite i nodi generati o espansi. La **complessità spaziale** misura quanti nodi conserva contemporaneamente in memoria.

### 7. Che cos’è un’euristica e qual è la differenza tra ricerca informata e non informata?

**La tua risposta:**

L'euristica è una funzione che assegna un valore ad ogni nodo di un grafo. Questo valore indica la distanza tra il nodo corrente e il nodo goal. Un'euristica ha il vantaggio di ottimizzare i problemi di ricerca. Nella ricerca senza euristica (non informata), infatti, l'algoritmo si muove con cerchi concentrici a partire dal nodo iniziale cercando alla cieca il nodo goal. Nel caso, invece, degli algoritmi che fanno uso di euristica, l'andamento dell'algoritmo è proteso naturalmente dal nodo di partenza al nodo goal. Un'euristica, però, ha 2 proprietà fondamentali per essere fruibile: ammissibilità e consistenza. La prima afferma che per ogni nodo l'euristica non può assegnare valori di distanza dal goal maggiori di quelli reali, la seconda impone un controllo stringente dato che la differenza tra l'euristica di un nodo e del suo successore deve essere minore o uguale al costo per raggiungere il secondo nodo dal primo

> [!info] Risposta corretta
> Un’euristica $h(n)$ stima il costo minimo per arrivare da uno stato $n$ a uno stato obiettivo. La ricerca non informata non usa questa stima e sceglie i nodi secondo una regola generale, come la profondità o il costo già percorso. La ricerca informata usa informazioni specifiche del problema per dare priorità ai nodi che sembrano più promettenti.
>
> Un’euristica è **ammissibile** se non sovrastima mai il costo reale rimanente: $h(n)\leq h^*(n)$. È **consistente** se per ogni transizione da $n$ a $n'$ vale $h(n)\leq c(n,a,n')+h(n')$. La consistenza è una disuguaglianza triangolare e garantisce che in A* su grafo i valori $f$ non diminuiscano lungo un cammino.

### 8. Definisci un gioco a somma zero con due giocatori.

**La tua risposta:**

Un gioco a somma zero tra 2 giocatori è tale per cui alla fine uno dei due vince e ciò implica che l'altro perde. Un esempio di ciò sono gli scacchi che però aggiungono lo stato di pareggio. Nell'esempio degli scacchi l'utility finale di chi vince sarà +1, mentre quella di chi perde -1. In caso di pareggio l'utility sarà 0

> [!info] Risposta corretta
> Un gioco a somma zero a due giocatori assegna utilità opposte ai giocatori: per ogni esito, $u_1=-u_2$. Per esempio, se MAX vince con utilità $+1$, MIN riceve $-1$; in caso di pareggio entrambi possono ricevere $0$. In Minimax considero l’utilità dal punto di vista di MAX: MAX la massimizza e MIN la minimizza.

### 9. Dato un problema e un albero di ricerca, come ricavi l’ordine di visita, la struttura e il contenuto della frontiera?

> [!info] Risposta proposta
> Per rispondere seguo l’algoritmo passo per passo. A ogni iterazione annoto il nodo estratto, il test del goal, i successori generati e la frontiera aggiornata. La struttura dipende dall’algoritmo: BFS usa FIFO, DFS e IDS usano LIFO, UCS ordina per costo $g$ e A* per $f=g+h$. Nei grafi tengo conto anche degli stati già raggiunti e degli eventuali cammini migliori trovati.

### 10. Confronta la ricerca su albero e la ricerca su grafo. A cosa serve il *reached set* e come si gestisce in A*?

**La tua risposta:**

In entrambe le ricerche avrò sempre un nodo di partenza: nel caso dell'albero si tratta della radice, mentre nel grafo è il nodo che viene configurato come lo start. La differenza più grande sta nel modo in cui si gestisce una situazione di loop. Nel momento in cui si dovesse rientrare in un nodo già visitato, infatti, l'albero crescerebbe in larghezza e profondità ogni volta aumentando il costo computazionale, mentre al grafo è sufficiente un arco che rientri dentro al nodo in questione. In questo contesto è necessario tenere in considerazione quali sono i nodi già visitati e quali no e per questo si usa il reached set: un array dei nodi già visitati.

> [!info] Risposta corretta
> Nella ricerca su albero posso generare più nodi che rappresentano lo stesso stato, anche attraverso cicli. Nella ricerca su grafo tengo traccia degli stati raggiunti per evitare di riesaminare inutilmente uno stato e per gestire i cicli.
>
> In BFS o DFS posso usare un insieme degli stati già raggiunti. In A* conservo anche il costo $g$ con cui ho raggiunto ciascuno stato: se trovo un cammino meno costoso aggiorno il record e inserisco il nuovo nodo in frontiera. Se l’euristica è consistente non devo riaprire uno stato già espanso; con una euristica solo ammissibile posso doverlo riaprire per mantenere l’ottimalità.

### 11. Definisci $g(n)$, $h(n)$ e $f(n)$ in A*. Perché il goal test si fa quando il nodo è estratto dalla frontiera?

**La tua risposta:**

Si tratta dei valori che vengono assegnati ad ogni nodo n nella ricerca informata tramite A*. f(n) è il risultato che viene inserito nella priority queue dell'algoritmo per decidere il passo successivo e si ottiene dalla somma tra il costo per raggiungere il nodo n dal nodo di partenza (g(n)) e l'euristica del nodo stesso per arrivare allo stato goal (h(n)). Il test viene fatto solo quando il nodo è estratto dalla frontiera perché altrimenti l'algoritmo potrebbe restituire un goal subottimo ottenuto tramite un percorso più costoso rispetto al migliore

> [!info] Risposta corretta
> $g(n)$ è il costo del cammino dallo stato iniziale a $n$; $h(n)$ è la stima del costo da $n$ al goal; $f(n)=g(n)+h(n)$ stima il costo totale passando per $n$. A* estrae dalla coda di priorità il nodo con $f$ minore.
>
> Faccio il goal test all’estrazione perché un goal generato per primo potrebbe essere raggiunto con un cammino costoso. Quando A* lo estrae, con le ipotesi di ottimalità dell’algoritmo, il suo costo è quello minimo.

### 12. Spiega la differenza tra euristica ammissibile e consistente. Che garanzia dà la consistenza in A* su grafo?

**La tua risposta:**

Un'euristica ammissibile implica che la stima di euristica non sovrastimi mai l'euristica reale. Un'euristica consistente assicura che la differenza tra l'euristica di un nodo e il suo successore sia minore o uguale al costo per raggiungere il secondo dal primo. Nella ricerca su grafo con A* la consistenza garantisce che un nodo esplorato sia stato raggiunto già nella maniera migliore e che quindi non vadano riespansi i nodi figli

> [!info] Risposta corretta
> Un’euristica ammissibile non sovrastima mai il costo ottimo rimanente: $h(n)\leq h^*(n)$. Un’euristica consistente soddisfa invece, per ogni arco $n\to n'$, la condizione $h(n)\leq c(n,a,n')+h(n')$.
>
> Con un’euristica consistente i valori $f$ non diminuiscono lungo il cammino. Quando A* estrae uno stato, lo ha raggiunto al costo minimo: non serve riaprirlo e riespanderlo.

### 13. Che cosa restituisce la ricerca in profondità limitata? Spiega la differenza tra `cutoff` e `failure` e il ruolo di IDS.

**La tua risposta:**

La ricerca con profondità limitata restituisce delle utilities stimate con la funzione EVAL che per ogni nodo calcola la somma pesata dei suoi figli (valori dei nodi e dei pesi assegnati in base al problema). Questo avviene perché lavorare su un albero completo concede sicuramente la risposta ottima, ma ha un costo computazionale potenzialmente molto elevato. Un albero a profondità limitata mi agevola nel costo, ma mi fa perdere l'ottimalità

> [!info] Risposta corretta
> La ricerca in profondità limitata esegue una DFS fino a un limite $\ell$. Se trova il goal restituisce il nodo soluzione. Restituisce `failure` se esaurisce la ricerca entro il limite senza trovare il goal; restituisce `cutoff` se raggiunge il limite e la soluzione potrebbe trovarsi più in profondità.
>
> IDS ripete la ricerca aumentando $\ell$. Continua dopo `cutoff` e termina quando trova una soluzione o riceve `failure`, che indica che non ci sono altre possibilità da esplorare.
>
> Nei giochi, una ricerca limitata può fermarsi a una profondità prefissata e usare una funzione di valutazione per stimare le posizioni non terminali; in quel caso non garantisce il gioco ottimale. È il caso trattato nella lezione sulle funzioni di valutazione.

### 14. Confronta IDA* e RBFS per memoria, ripetizione del lavoro e gestione dei rami abbandonati.

**La tua risposta:**

L'IDA* applica l'algoritmo A* tenendo un contatore che ad ogni iterazione viene aggiornato e che rappresenta il livello che l'algoritmo ha raggiunto

> [!info] Risposta corretta
> IDA* esegue ricerche in profondità con una soglia su $f$, che aumenta al valore più piccolo appena oltrepassato nella ricerca precedente. Usa memoria lineare, ma a ogni iterazione riparte dall’inizio e può visitare più volte gli stessi stati.
>
> RBFS segue ricorsivamente il ramo con $f$ più basso e usa come limite il valore della migliore alternativa. Quando abbandona un ramo ne salva il valore aggiornato (*backed-up value*), ma può comunque riesplorarlo in seguito. Entrambi usano memoria lineare e possono ripetere parte del lavoro; IDA* ripete l’intera ricerca a ogni soglia, RBFS riprende i rami secondo il confronto tra i valori di backup.

### 15. Descrivi Alpha-beta usando $\alpha$ e $\beta$. Quando si pota e perché la decisione alla radice non cambia?

**La tua risposta:**

Sia $\alpha$ il valore di MAX e $\beta$ quello di MIN, so che il primo è un limite superiore e il secondo un limite inferiore. Un ramo si pota se viene trovato un valore di un nodo tale che la decisione non può dipendere da valori eventualmente migliori. Ad esempio se devo scegliere il MAX tra i nodi che sto filtrando con MIN, non mi interessa trovare il minimo assoluto tra tutti i nodi, ma, una volta trovato un minimo dentro tra i figli di un nodo, posso fare pruning tra altri nodi solo se trovo un figlio minore del primo che ho trovato

> [!info] Risposta corretta
> $\alpha$ è il miglior valore trovato finora per MAX lungo il cammino; $\beta$ è il miglior valore trovato finora per MIN. Quando $\alpha\geq\beta$, interrompo la visita dei figli rimanenti: il giocatore che precede il nodo ha già un’alternativa almeno altrettanto buona, quindi quei figli non possono cambiare la scelta alla radice.
>
> La potatura elimina solo rami che non possono influire sulla decisione. Per questo Alpha-beta restituisce lo stesso valore e la stessa mossa di Minimax, visitando spesso meno nodi.

### 16. Per un problema di ricerca, specifica stato iniziale, azioni, modello di transizione, goal test e costo. Fai un esempio e definisci una soluzione.

> [!info] Risposta proposta
> Nel problema del viaggio tra città, lo stato iniziale può essere Arad. Le azioni sono gli spostamenti verso le città collegate da una strada; il modello di transizione porta alla città vicina scelta. Il goal test verifica se sono arrivato a Bucarest e il costo di ogni azione è la distanza della strada.
>
> Una soluzione è una sequenza di città e spostamenti che porta da Arad a Bucarest. Il costo totale è la somma delle distanze percorse.

### 17. Confronta le complessità temporale e spaziale di BFS e DFS in funzione di $b$ e $m$.

> [!info] Risposta proposta
> DFS richiede nel caso peggiore $O(b^m)$ tempo e $O(bm)$ spazio: può scendere fino alla massima profondità, ma conserva solo il cammino corrente e i nodi necessari per tornare indietro.
>
> BFS richiede $O(b^d)$ tempo e spazio, dove $d$ è la profondità della soluzione più superficiale. Esplora tutti i nodi dei livelli precedenti e conserva una frontiera ampia. Se si usa $m$ come limite di profondità, la stima viene espressa come $O(b^m)$.

### 18. Classifica un gioco di carte e gli scacchi secondo osservabilità, determinismo, granularità e ostilità.

> [!info] Risposta proposta
> Gli scacchi sono completamente osservabili, deterministici, discreti e avversariali: vedo tutta la scacchiera, ogni mossa ha un esito certo e l’avversario contrasta le mie mosse.
>
> Un gioco di carte con carte coperte è parzialmente osservabile, discreto e avversariale. Se la distribuzione delle carte è casuale, è anche stocastico: il caso influenza le carte ricevute o rivelate.

### 19. Che cosa rappresenta l’utilità di un esito in Minimax? Come si calcola il valore di un nodo MAX e di un nodo MIN?

> [!info] Risposta proposta
> L’utilità assegna un valore a un esito terminale dal punto di vista di MAX. Per esempio, una vittoria di MAX può valere $+1$, un pareggio $0$ e una sconfitta $-1$.
>
> Risalendo l’albero, in un nodo MAX prendo il massimo dei valori dei figli; in un nodo MIN prendo il minimo. Il valore alla radice indica il risultato che MAX può garantire se entrambi giocano in modo ottimale.

### 20. Che cos’è una funzione di valutazione e come si usa nella ricerca a profondità limitata?

> [!info] Risposta proposta
> Una funzione di valutazione assegna un punteggio a una posizione non terminale quando la ricerca si ferma al limite di profondità. Stima il valore della posizione usando caratteristiche dello stato, per esempio il materiale rimasto sulla scacchiera.
>
> Propago poi questi valori verso la radice usando le regole di MAX e MIN. La stima è imperfetta: interrompere la ricerca prima degli esiti terminali fa perdere la garanzia di gioco ottimale.

### 21. Come si calcola il valore di un nodo CHANCE in expectimax? In cosa differisce da un nodo MIN?

> [!info] Risposta proposta
> Un nodo CHANCE rappresenta un esito incerto. Calcolo il suo valore come media pesata dei valori dei figli, usando le probabilità degli esiti: $V(s)=\sum_i p_iV(s_i)$.
>
> Un nodo MIN rappresenta invece una scelta dell’avversario, che seleziona il valore più basso per MAX. In expectimax non ci sono nodi MIN; in expectiminimax possono comparire sia nodi MIN sia nodi CHANCE.


### 22. Che cos’è un agente razionale e come si valuta il suo comportamento?

> [!info] Risposta proposta
> Un agente razionale sceglie l’azione che massimizza il valore atteso della misura di prestazione, in base alle percezioni ricevute e alle conoscenze disponibili. La misura di prestazione descrive il risultato desiderato dal progettista; non coincide con i passaggi interni usati dall’agente per scegliere.
>
> L’agente percepisce l’ambiente tramite sensori e agisce tramite attuatori. La razionalità dipende dalle informazioni disponibili e dalla misura di prestazione scelta.

### 23. Quali sono le tre modalità di rappresentazione dello stato? Che differenza c’è tra stato del mondo e stato di ricerca?

> [!info] Risposta proposta
> Una rappresentazione **atomica** tratta ogni stato come un identificatore senza struttura interna. Una rappresentazione **fattorizzata** descrive lo stato con variabili e attributi. Una rappresentazione **strutturata** usa oggetti e relazioni tra loro.
>
> Lo stato del mondo comprende tutti i dettagli dell’ambiente; lo stato di ricerca contiene solo le informazioni necessarie per trovare un piano. La rappresentazione scelta influisce sulla dimensione dello spazio e sull’efficienza della ricerca.

### 24. Confronta Uniform Cost Search e Greedy Best-First Search con A*.

> [!info] Risposta proposta
> UCS estrae il nodo con costo accumulato $g(n)$ minore. È completa e ottima se i costi degli archi sono positivi, ma non usa informazioni sulla posizione del goal.
>
> Greedy Best-First estrae il nodo con $h(n)$ minore. Può raggiungere rapidamente il goal, ma non considera il costo già sostenuto e non garantisce né completezza né ottimalità in generale.
>
> A* combina i due criteri usando $f(n)=g(n)+h(n)$. Con le ipotesi adatte sull’euristica mantiene la garanzia di ottimalità, ma può richiedere molta memoria.

### 25. Che cosa fa SMA* e che cosa succede quando la memoria disponibile è piena?

> [!info] Risposta proposta
> SMA* è una variante di A* che rispetta un limite di memoria. Se la memoria è piena, elimina il nodo foglia con il valore $f$ peggiore e conserva nel genitore il valore di backup, così può rigenerare quel ramo se diventa di nuovo promettente.
>
> Può essere completo e ottimo se la memoria basta a mantenere il cammino della soluzione ottima. Se la memoria è insufficiente, può dimenticare e rigenerare nodi e non è garantito che trovi la soluzione ottima.

### 26. Come si calcola il valore di un nodo CHANCE? Fai un esempio numerico.

> [!info] Risposta proposta
> Calcolo il valore atteso moltiplicando il valore di ogni esito per la sua probabilità e sommando i risultati. Se i valori sono 8, 24 e $-12$, con probabilità $1/2$, $1/3$ e $1/6$, ottengo $8(1/2)+24(1/3)-12(1/6)=10$.
>
> Un nodo MIN sceglie il valore più basso per MAX; un nodo CHANCE non sceglie, ma calcola la media pesata degli esiti. Expectiminimax combina nodi MAX, MIN e CHANCE.

### 27. Perché una ricerca di gioco può fermarsi a una profondità limitata? Che caratteristiche dovrebbe avere la funzione di valutazione?

> [!info] Risposta proposta
> Negli alberi di gioco grandi non riesco in genere a esplorare tutte le mosse fino agli esiti terminali. Mi fermo a una profondità prefissata e uso una funzione di valutazione per stimare le posizioni non terminali raggiunte; così riduco il costo, ma perdo la garanzia di ottimalità.
>
> La funzione dovrebbe essere veloce da calcolare, correlata con le probabilità di vittoria e applicata a posizioni quiescenti, cioè senza mosse pendenti che farebbero oscillare molto la valutazione.

### 28. Qual è la relazione tra intelligenza artificiale, machine learning, deep learning e IA generativa?

> [!info] Risposta proposta
> L’intelligenza artificiale è il campo più ampio. Il machine learning ne è una branca: i suoi algoritmi apprendono regolarità dai dati. Il deep learning usa reti neurali con più strati; l’IA generativa usa modelli di deep learning per produrre nuovi contenuti, come testo, immagini o audio.
>
> La relazione è quindi: IA generativa ⊂ deep learning ⊂ machine learning ⊂ IA.

### 29. Descrivi il ciclo di addestramento di un modello e spiega che cosa sono generalizzazione e overfitting.

> [!info] Risposta proposta
> Durante l’addestramento il modello produce una predizione, calcola la loss rispetto alla risposta attesa, calcola il gradiente e aggiorna i parametri. Ripete il ciclo per ridurre l’errore.
>
> Il modello deve funzionare anche su dati mai visti: questa capacità si chiama generalizzazione. Se impara troppo bene gli esempi di addestramento ma funziona male su dati nuovi, si verifica overfitting. Per controllarlo si valuta il modello su un insieme di test separato.

### 30. Che cosa misura la loss e come funziona la cross-entropy nella classificazione probabilistica?

> [!info] Risposta proposta
> La loss misura numericamente la differenza fra la predizione del modello e la risposta attesa. Nella cross-entropy si usa $-\ln(P)$, dove $P$ è la probabilità assegnata alla risposta corretta: se $P$ è vicino a 1 la loss è vicina a 0; se $P$ è vicino a 0 la loss diventa molto alta.

### 31. Che cosa cambia in Weighted A* rispetto ad A* e quale compromesso introduce?

> [!info] Risposta proposta
> Weighted A* usa $f(n)=g(n)+W\cdot h(n)$ con $W>1$, quindi dà più peso alla stima euristica e cerca in modo più aggressivo verso il goal. In genere espande meno nodi, ma rinuncia all’ottimalità stretta.
>
> Con euristica ammissibile, il limite $C^*\leq c\leq W\cdot C^*$ sul costo $c$ della soluzione trovata, dove $C^*$ è il costo ottimo.
