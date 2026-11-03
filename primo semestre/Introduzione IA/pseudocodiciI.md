# Pseudocodici per il primo esonero

Schema di ripasso ricavato dalle domande del primo esonero e dagli appunti delle lezioni. `problem` espone lo stato iniziale, il test del goal, le azioni applicabili, il risultato di un'azione e il costo della transizione. Un nodo conserva almeno stato, genitore, azione, costo del cammino `g` e profondità.

I blocchi in inglese corrispondenti a `algorithms.pdf` riprendono gli algoritmi delle figure 3.7, 3.9, 3.12, 3.22, 5.3 e 5.7. `TREE-SEARCH`, DFS, A*, IDA* e SMA* sono integrazioni dagli appunti e non compaiono nelle figure del PDF.

## Mappa rapida

Per riconoscere un algoritmo, guarda prima **come sceglie il prossimo nodo**. La frontiera contiene i nodi generati ma non ancora espansi.

| Algoritmo | Come sceglie il prossimo nodo | Cosa tenere a mente |
|---|---|---|
| BFS | Il più vecchio nella coda FIFO | Completa; ottimale con passi di costo uguale |
| DFS | L'ultimo inserito nello stack LIFO | Scende in profondità; nella ricerca su albero usa memoria lineare nella profondità |
| UCS | Il nodo con `g` minore | Conta il costo già sostenuto |
| A* | Il nodo con `g + h` minore | Costo già sostenuto più stima del costo rimanente |
| IDS | DFS, ripetuta con limite di profondità crescente | La memoria resta contenuta, i livelli alti si ripetono |
| IDA* | DFS, ripetuta con soglia `g + h` crescente | Come IDS, ma la soglia riguarda il costo stimato |
| RBFS | Il successore con `f` minore, entro un limite | Ricorda il valore del ramo sospeso |
| SMA* | La foglia con `f` minore, entro la memoria disponibile | Se serve spazio dimentica la foglia peggiore e ne salva il valore nel genitore |

`g` è il costo del cammino dall'inizio al nodo; `h` stima il costo dal nodo al goal; `f = g + h` è il costo stimato della soluzione passando per quel nodo.

## Ricerca generale

La ricerca su albero usa una frontiera e può visitare più volte lo stesso stato raggiungibile da cammini diversi. La ricerca su grafo tiene anche un insieme `reached` per evitare ripetizioni. La strategia è determinata dal modo in cui si estrae il prossimo nodo.

Best-first è lo schema generale: `f` determina la priorità nella coda e `reached` conserva il miglior cammino trovato per ogni stato.

```text
function BEST-FIRST-SEARCH(problem, f) returns a solution node or failure
    node ← NODE(STATE=problem.INITIAL)
    frontier ← a priority queue ordered by f, with node as an element
    reached ← a lookup table, with one entry with key problem.INITIAL and value node
    while not IS-EMPTY(frontier) do
        node ← POP(frontier)
        if problem.IS-GOAL(node.STATE) then return node
        for each child in EXPAND(problem, node) do
            s ← child.STATE
            if s is not in reached or child.PATH-COST < reached[s].PATH-COST then
                reached[s] ← child
                add child to frontier
    return failure

function EXPAND(problem, node) yields nodes
    s ← node.STATE
    for each action in problem.ACTIONS(s) do
        s' ← problem.RESULT(s, action)
        cost ← node.PATH-COST + problem.ACTION-COST(s, action, s')
        yield NODE(STATE=s', PARENT=node, ACTION=action, PATH-COST=cost)
```

Con UCS si passa `f(n) = path-cost(n)`; A* usa lo stesso schema con `f(n) = g(n) + h(n)`.

```text
TREE-SEARCH(problem, frontier)
    inserisci nodo iniziale in frontier
    mentre frontier non è vuota:
        node ← estrai secondo la strategia scelta
        se GOAL-TEST(node.state):
            restituisci node
        per ogni child in EXPAND(problem, node):
            inserisci child in frontier
    restituisci failure
```

## BFS e DFS

```text
function BREADTH-FIRST-SEARCH(problem) returns a solution node or failure
    node ← NODE(problem.INITIAL)
    if problem.IS-GOAL(node.STATE) then return node
    frontier ← a FIFO queue, with node as an element
    reached ← {problem.INITIAL}
    while not IS-EMPTY(frontier) do
        node ← POP(frontier)
        for each child in EXPAND(problem, node) do
            s ← child.STATE
            if problem.IS-GOAL(s) then return child
            if s is not in reached then
                add s to reached
                add child to frontier
    return failure
```

```text
DEPTH-FIRST-SEARCH(problem)
    root ← nodo(problem.initial)
    frontier ← stack LIFO contenente root
    reached ← {root.state}
    mentre frontier non è vuota:
        node ← estrai dalla cima di frontier
        se GOAL-TEST(node.state): restituisci node
        per ogni child in EXPAND(problem, node):
            se child.state non è in reached:
                aggiungi child.state a reached
                inserisci child in frontier
    restituisci failure
```

La frontiera BFS è FIFO e visita per livelli; quella DFS è LIFO e scende lungo un ramo. Nei grafi, segnare gli stati raggiunti evita cicli e duplicati. BFS trova una soluzione se esiste a profondità finita ed è ottimale quando tutti i passi hanno costo uguale; richiede tempo e spazio esponenziali, circa `O(b^d)`. DFS usa `O(bm)` spazio e `O(b^m)` tempo; senza controllo dei cicli può non essere completa e non è ottimale.

**Promemoria:** BFS = *prima i più vicini*; DFS = *prima il ramo più profondo*. FIFO conserva l'ordine di arrivo; LIFO riprende dall'ultimo nodo inserito.

## Iterative Deepening Search (IDS)

La ricerca a profondità limitata distingue `cutoff` (il limite ha impedito di proseguire) da `failure` (frontiera esaurita). IDS ripete DFS con limiti crescenti.

```text
function ITERATIVE-DEEPENING-SEARCH(problem) returns a solution node or failure
    for depth = 0 to ∞ do
        result ← DEPTH-LIMITED-SEARCH(problem, depth)
        if result ≠ cutoff then return result

function DEPTH-LIMITED-SEARCH(problem, ℓ) returns a node or failure or cutoff
    frontier ← a LIFO queue (stack) with NODE(problem.INITIAL) as an element
    result ← failure
    while not IS-EMPTY(frontier) do
        node ← POP(frontier)
        if problem.IS-GOAL(node.STATE) then return node
        if DEPTH(node) > ℓ then
            result ← cutoff
        else if not IS-CYCLE(node) do
            for each child in EXPAND(problem, node) do
                add child to frontier
    return result
```

IDS è completa e ottimale con costi unitari; richiede `O(b^d)` tempo e `O(bd)` spazio. Riesplora i livelli più alti a ogni iterazione, ma concentra il lavoro sul livello più profondo.

**Promemoria:** IDS aumenta il limite `0, 1, 2, ...`; `cutoff` significa “il limite potrebbe aver nascosto la soluzione”, mentre `failure` significa “la ricerca è terminata senza soluzione”.

## Uniform Cost Search (UCS)

UCS usa una coda di priorità ordinata per costo del cammino `g`. Il goal test avviene all'estrazione, quando il suo costo è il minimo tra quelli ancora in frontiera.

```text
function UNIFORM-COST-SEARCH(problem) returns a solution node or failure
    return BEST-FIRST-SEARCH(problem, PATH-COST)
```

È completa e ottimale se i costi degli archi sono positivi e limitati inferiormente da `ε > 0`. Tempo e spazio sono esponenziali nella profondità efficace, circa `O(b^(1 + floor(C*/ε)))`.

**Promemoria:** UCS sceglie il cammino meno costoso finora (`g`). Per questo il goal si controlla quando viene estratto dalla coda, non appena viene generato.

## A*

A* ordina la frontiera per `f(n) = g(n) + h(n)`, dove `g` è il costo già sostenuto e `h` la stima del costo rimanente. Il goal test si fa quando il nodo viene estratto.

```text
A*-GRAPH-SEARCH(problem, h)
    frontier ← coda di priorità con nodo iniziale a priorità h(initial)
    best-g ← {initial: 0}
    mentre frontier non è vuota:
        node ← estrai il nodo con f = g + h minimo
        se node.g > best-g[node.state]: continua
        se GOAL-TEST(node.state): restituisci node
        per ogni child in EXPAND(problem, node):
            new-g ← node.g + COST(node, child)
            se child.state non è in best-g oppure new-g < best-g[child.state]:
                best-g[child.state] ← new-g
                child.g ← new-g
                inserisci child con priorità new-g + h(child.state)
    restituisci failure
```

Con euristica ammissibile (`h(n) ≤ h*(n)`), A* su albero è ottimale; su grafo è ottimale con euristica consistente, oppure riaprendo gli stati quando si trova un costo `g` migliore. È completo con costi positivi e condizioni finite usuali; nel caso peggiore tempo e spazio sono esponenziali, `O(b^d)`. Con `h = 0` coincide con UCS.

**Promemoria:** UCS guarda solo ciò che è già costato (`g`); A* aggiunge una previsione (`h`). Se `h = 0`, la previsione non contribuisce e resta UCS.

## IDA* (Iterative Deepening A*)

IDA* ripete una DFS limitata da una soglia sul valore `f = g + h`. La soglia successiva è il più piccolo valore `f` che ha superato quella corrente; non conserva la frontiera fra le iterazioni.

```text
IDA*-SEARCH(problem, h)
    bound ← h(problem.initial)
    path ← [nodo iniziale]
    ripeti:
        result ← CONTOUR-DFS(path, g=0, bound)
        se result è una soluzione oppure result = failure:
            restituisci result
        bound ← result                 // minimo f oltre la soglia

CONTOUR-DFS(path, g, bound)
    node ← ultimo nodo di path
    f ← g + h(node.state)
    se f > bound: restituisci f
    se GOAL-TEST(node.state): restituisci node
    min-excess ← +∞
    per ogni child in SUCCESSORS(node):
        se child.state non è già in path:
            aggiungi child a path
            result ← CONTOUR-DFS(path, g + COST(node, child), bound)
            rimuovi child da path
            se result è una soluzione: restituisci result
            se result = failure: continua
            min-excess ← min(min-excess, result)
    se min-excess = +∞: restituisci failure
    restituisci min-excess
```

Con euristica ammissibile è ottimo; usa `O(bd)` spazio, ma può riespandere gli stessi stati in iterazioni diverse e non conserva il lavoro svolto oltre la soglia successiva.

**Promemoria:** IDA* non limita la profondità: limita `f = g + h`. Quando supera la soglia, restituisce il valore eccedente minimo per scegliere la soglia del giro successivo.

## Recursive Best-First Search (RBFS)

RBFS esplora ricorsivamente il ramo con `f` più basso e limita la ricerca col valore della seconda alternativa migliore. Quando abbandona un ramo, ne conserva il valore `f` aggiornato (*backed-up value*).

```text
function RECURSIVE-BEST-FIRST-SEARCH(problem) returns a solution or failure
    solution, fvalue ← RBFS(problem, NODE(problem.INITIAL), ∞)
    return solution

function RBFS(problem, node, f-limit) returns a solution or failure, and a new f-cost limit
    if problem.IS-GOAL(node.STATE) then return node
    successors ← LIST(EXPAND(node))
    if successors is empty then return failure, ∞
    for each s in successors do        // update f with value from previous search
        s.f ← max(s.PATH-COST + h(s), node.f)
    while true do
        best ← the node in successors with lowest f-value
        if best.f > f-limit then return failure, best.f
        alternative ← the second-lowest f-value among successors
        result, best.f ← RBFS(problem, best, min(f-limit, alternative))
        if result ≠ failure then return result, best.f
```

RBFS è ottimale con euristica ammissibile e usa `O(bd)` spazio. Può riespandere più volte nodi dimenticati, quindi il tempo dipende dalla qualità dell'euristica e dai cambi di ramo migliore.

**Come leggere il limite:** RBFS segue il ramo migliore; `alternative` è il costo del concorrente più promettente. Il ramo corrente può continuare solo finché il suo `f` non supera il limite imposto dal genitore o dall'alternativa. Se lo supera, RBFS torna indietro portando con sé il nuovo `f` del ramo.

## SMA* (Simplified Memory-Bounded A*)

SMA* ordina le foglie generate per `f`, usa tutta la memoria disponibile e, quando è piena, dimentica la foglia peggiore (quella con `f` maggiore). Registra nel genitore il valore della foglia dimenticata per poter riprendere quel ramo se torna promettente.

```text
SMA*-SEARCH(problem, h, M)       // M = numero massimo di nodi conservati
    root ← nodo iniziale con g=0 e f=h(initial)
    frontier ← {root}           // contiene le foglie non ancora espanse
    ripeti:
        se frontier è vuota oppure il suo miglior nodo ha f=+∞:
            restituisci failure
        best ← foglia in frontier con f minimo
        se GOAL-TEST(best.state): restituisci best
        rimuovi best da frontier
        genera i successori di best
        se best non ha successori:
            best.f ← +∞
        altrimenti:
            per ogni child generato:
                child.g ← best.g + COST(best, child)
                child.f ← max(best.f, child.g + h(child.state))
                collega child a best e aggiungilo a frontier
        mentre numero di nodi conservati > M:
            worst ← foglia in frontier con f massimo, diversa da best
            rimuovi worst da frontier e libera la sua memoria
            parent ← genitore di worst
            parent.valore-backup[worst] ← worst.f
            se parent non ha più figli conservati:
                aggiungi parent a frontier come foglia rigenerabile
        aggiorna il f di best col miglior valore fra i figli conservati
            e i valori di backup dei figli dimenticati
        se best ora rappresenta una foglia rigenerabile:
            aggiungilo a frontier
```

Questo è uno schema operativo: la gestione dei collegamenti e dei valori di backup va adattata alla struttura dati usata. SMA* è ottimale se `h` è ammissibile e la memoria basta a mantenere il cammino della soluzione ottima; è completo se la memoria basta per quel cammino. Lo spazio è limitato da `M`; il tempo può aumentare quando i nodi dimenticati vengono rigenerati.

**Come leggerlo:** quando la memoria si riempie, SMA* elimina la foglia meno promettente (`f` massimo), ma ne conserva il valore nel genitore. Se quel ramo torna competitivo, il valore segnala che può essere rigenerato.

## Minimax

Si applica a giochi deterministici, a somma zero e con informazione perfetta. MAX massimizza il valore; MIN lo minimizza. Le foglie hanno l'utilità degli esiti.

```text
function MINIMAX-SEARCH(game, state) returns an action
    player ← game.TO-MOVE(state)
    value, move ← MAX-VALUE(game, state)
    return move

function MAX-VALUE(game, state) returns a (utility, move) pair
    if game.IS-TERMINAL(state) then return game.UTILITY(state, player), null
    v ← −∞
    for each a in game.ACTIONS(state) do
        v2, a2 ← MIN-VALUE(game, game.RESULT(state, a))
        if v2 > v then
            v, move ← v2, a
    return v, move

function MIN-VALUE(game, state) returns a (utility, move) pair
    if game.IS-TERMINAL(state) then return game.UTILITY(state, player), null
    v ← +∞
    for each a in game.ACTIONS(state) do
        v2, a2 ← MAX-VALUE(game, game.RESULT(state, a))
        if v2 < v then
            v, move ← v2, a
    return v, move
```

Minimax è ottimale contro un avversario perfetto, ma esplora l'albero fino agli esiti terminali: tempo `O(b^m)`, spazio `O(bm)` con ricerca depth-first. Con fattore di ramificazione e profondità elevati diventa impraticabile.

**Promemoria:** MAX sceglie il valore più alto; MIN risponde scegliendo il più basso. Ogni livello valuta le mosse assumendo che l'avversario scelga la risposta migliore per sé.

## Alpha-Beta Pruning

Alpha-beta restituisce la stessa scelta di Minimax. `α` è il miglior valore già garantito a MAX sul percorso; `β` è il miglior limite già garantito a MIN. Si interrompe l'esplorazione quando `v ≥ β` in MAX o `v ≤ α` in MIN.

```text
function ALPHA-BETA-SEARCH(game, state) returns an action
    player ← game.TO-MOVE(state)
    value, move ← MAX-VALUE(game, state, −∞, +∞)
    return move

function MAX-VALUE(game, state, α, β) returns a (utility, move) pair
    if game.IS-TERMINAL(state) then return game.UTILITY(state, player), null
    v ← −∞
    for each a in game.ACTIONS(state) do
        v2, a2 ← MIN-VALUE(game, game.RESULT(state, a), α, β)
        if v2 > v then
            v, move ← v2, a
            α ← MAX(α, v)
        if v ≥ β then return v, move
    return v, move

function MIN-VALUE(game, state, α, β) returns a (utility, move) pair
    if game.IS-TERMINAL(state) then return game.UTILITY(state, player), null
    v ← +∞
    for each a in game.ACTIONS(state) do
        v2, a2 ← MAX-VALUE(game, game.RESULT(state, a), α, β)
        if v2 < v then
            v, move ← v2, a
            β ← MIN(β, v)
        if v ≤ α then return v, move
    return v, move
```

Il pruning non cambia il valore minimax alla radice. L'ordine di visita dei figli influenza quanti rami si potano: nel caso migliore, con ordinamento perfetto, il tempo scende a `O(b^(m/2))`; lo spazio resta `O(bm)`.

**Promemoria:** `α` è il risultato che MAX ha già garantito; `β` è il limite che MIN ha già garantito. Se MAX raggiunge o supera `β`, oppure MIN scende a `α` o sotto, quel ramo non può cambiare la scelta e si può potare.

## Da ricordare quando si descrive un algoritmo

- **Frontiera:** struttura dati e regola con cui si estrae il prossimo nodo.
- **Visita:** ordine di espansione e momento del goal test.
- **Completezza:** se trova una soluzione quando ne esiste una.
- **Ottimalità:** se restituisce la soluzione di costo minimo, con quali ipotesi.
- **Complessità:** tempo e spazio; definire `b` (ramificazione), `d` (profondità della soluzione), `m` (profondità massima), `C*` (costo ottimo) ed `ε` (costo minimo positivo di un arco).
