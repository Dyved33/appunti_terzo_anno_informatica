# Pseudocodici per il primo esonero

Schema di ripasso ricavato dalle domande del primo esonero e dagli appunti delle lezioni. `problem` espone lo stato iniziale, il test del goal, le azioni applicabili, il risultato di un'azione e il costo della transizione. Un nodo conserva almeno stato, genitore, azione, costo del cammino `g` e profondità.

Il PDF `algorithms.pdf` presenta lo schema best-first e `EXPAND` (fig. 3.7), BFS e UCS (fig. 3.9), IDS (fig. 3.12), RBFS (fig. 3.22), Minimax (fig. 5.3) e Alpha-Beta (fig. 5.7). Qui sono riportati in forma uniforme con la notazione degli appunti.

## Ricerca generale

La ricerca su albero usa una frontiera e può visitare più volte lo stesso stato raggiungibile da cammini diversi. La ricerca su grafo tiene anche un insieme `reached` per evitare ripetizioni. La strategia è determinata dal modo in cui si estrae il prossimo nodo.

Best-first è lo schema generale: `f` determina la priorità nella coda e `reached` conserva il miglior cammino trovato per ogni stato.

```text
BEST-FIRST-SEARCH(problem, f)
    root ← nodo(problem.initial)
    frontier ← coda di priorità ordinata per f(root)
    reached ← {problem.initial: root}
    mentre frontier non è vuota:
        node ← estrai il nodo con f minimo
        se node ≠ reached[node.state]: continua  // voce superata da un cammino migliore
        se GOAL-TEST(node.state): restituisci node
        per ogni child in EXPAND(node):
            s ← child.state
            se s non è in reached oppure child.g < reached[s].g:
                reached[s] ← child
                inserisci child in frontier
    restituisci failure

EXPAND(problem, node)
    per ogni azione applicabile a node.state:
        s' ← RESULT(node.state, azione)
        g' ← node.g + ACTION-COST(node.state, azione, s')
        genera nodo(state=s', parent=node, action=azione, g=g')
```

Con UCS si passa `f(n) = g(n)`; con A* si passa `f(n) = g(n) + h(n)`.

```text
TREE-SEARCH(problem, frontier)
    inserisci nodo iniziale in frontier
    mentre frontier non è vuota:
        node ← estrai secondo la strategia scelta
        se GOAL-TEST(node.state):
            restituisci node
        per ogni child in EXPAND(node):
            inserisci child in frontier
    restituisci failure
```

## BFS e DFS

```text
BREADTH-FIRST-SEARCH(problem)
    root ← nodo(problem.initial)
    se GOAL-TEST(root.state): restituisci root
    frontier ← coda FIFO contenente root
    reached ← {root.state}
    mentre frontier non è vuota:
        node ← estrai dalla testa di frontier
        per ogni child in EXPAND(node):
            se GOAL-TEST(child.state): restituisci child
            se child.state non è in reached:
                aggiungi child.state a reached
                accoda child in frontier
    restituisci failure
```

```text
DEPTH-FIRST-SEARCH(problem)
    root ← nodo(problem.initial)
    frontier ← stack LIFO contenente root
    reached ← {root.state}
    mentre frontier non è vuota:
        node ← estrai dalla cima di frontier
        se GOAL-TEST(node.state): restituisci node
        per ogni child in EXPAND(node):
            se child.state non è in reached:
                aggiungi child.state a reached
                inserisci child in frontier
    restituisci failure
```

La frontiera BFS è FIFO e visita per livelli; quella DFS è LIFO e scende lungo un ramo. Nei grafi, segnare gli stati raggiunti evita cicli e duplicati. BFS trova una soluzione se esiste a profondità finita ed è ottimale quando tutti i passi hanno costo uguale; richiede tempo e spazio esponenziali, circa `O(b^d)`. DFS usa `O(bm)` spazio e `O(b^m)` tempo; senza controllo dei cicli può non essere completa e non è ottimale.

## Iterative Deepening Search (IDS)

La ricerca a profondità limitata distingue `cutoff` (il limite ha impedito di proseguire) da `failure` (frontiera esaurita). IDS ripete DFS con limiti crescenti.

```text
ITERATIVE-DEEPENING-SEARCH(problem)
    per limit ← 0, 1, 2, ...:
        result ← DEPTH-LIMITED-SEARCH(problem, limit)
        se result ≠ cutoff:
            restituisci result

DEPTH-LIMITED-SEARCH(problem, limit)
    restituisci VISIT(nodo(problem.initial), 0)

VISIT(node, depth)
    se GOAL-TEST(node.state): restituisci node
    se depth = limit: restituisci cutoff
    cutoff_seen ← falso
    per ogni child in EXPAND(node):
        result ← VISIT(child, depth + 1)
        se result è una soluzione: restituisci result
        se result = cutoff: cutoff_seen ← vero
    se cutoff_seen: restituisci cutoff
    altrimenti: restituisci failure
```

IDS è completa e ottimale con costi unitari; richiede `O(b^d)` tempo e `O(bd)` spazio. Riesplora i livelli più alti a ogni iterazione, ma concentra il lavoro sul livello più profondo.

## Uniform Cost Search (UCS)

UCS usa una coda di priorità ordinata per costo del cammino `g`. Il goal test avviene all'estrazione, quando il suo costo è il minimo tra quelli ancora in frontiera.

```text
UNIFORM-COST-SEARCH(problem)
    frontier ← coda di priorità con nodo iniziale a priorità 0
    best-g ← {iniziale: 0}
    mentre frontier non è vuota:
        node ← estrai il nodo con g minimo
        se node.g > best-g[node.state]: continua
        se GOAL-TEST(node.state): restituisci node
        per ogni child in EXPAND(node):
            new-g ← node.g + COST(node, child)
            se child.state non è in best-g oppure new-g < best-g[child.state]:
                best-g[child.state] ← new-g
                child.g ← new-g
                inserisci child con priorità new-g
    restituisci failure
```

È completa e ottimale se i costi degli archi sono positivi e limitati inferiormente da `ε > 0`. Tempo e spazio sono esponenziali nella profondità efficace, circa `O(b^(1 + floor(C*/ε)))`.

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
        per ogni child in EXPAND(node):
            new-g ← node.g + COST(node, child)
            se child.state non è in best-g oppure new-g < best-g[child.state]:
                best-g[child.state] ← new-g
                child.g ← new-g
                inserisci child con priorità new-g + h(child.state)
    restituisci failure
```

Con euristica ammissibile (`h(n) ≤ h*(n)`), A* su albero è ottimale; su grafo è ottimale con euristica consistente, oppure riaprendo gli stati quando si trova un costo `g` migliore. È completo con costi positivi e condizioni finite usuali; nel caso peggiore tempo e spazio sono esponenziali, `O(b^d)`. Con `h = 0` coincide con UCS.

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
            min-excess ← min(min-excess, result)
    se min-excess = +∞: restituisci failure
    restituisci min-excess
```

Con euristica ammissibile è ottimo; usa `O(bd)` spazio, ma può riespandere gli stessi stati in iterazioni diverse e non conserva il lavoro svolto oltre la soglia successiva.

## Recursive Best-First Search (RBFS)

RBFS esplora ricorsivamente il ramo con `f` più basso e limita la ricerca col valore della seconda alternativa migliore. Quando abbandona un ramo, ne conserva il valore `f` aggiornato (*backed-up value*).

```text
RECURSIVE-BEST-FIRST-SEARCH(problem)
    root ← nodo iniziale
    root.f ← h(root.state)
    result, _ ← RBFS(problem, root, +∞)
    restituisci result

RBFS(problem, node, f-limit)
    se GOAL-TEST(node.state): restituisci node, node.f
    successors ← EXPAND(node)
    se successors è vuoto: restituisci failure, +∞
    per ogni s in successors:
        s.f ← max(s.g + h(s.state), node.f)
    ripeti:
        ordina successors per f crescente
        best ← successore con f minore
        se best.f > f-limit: restituisci failure, best.f
        alternative ← f del secondo successore migliore, oppure +∞
        result, best.f ← RBFS(problem, best, min(f-limit, alternative))
        se result ≠ failure: restituisci result, best.f
```

RBFS è ottimale con euristica ammissibile e usa `O(bd)` spazio. Può riespandere più volte nodi dimenticati, quindi il tempo dipende dalla qualità dell'euristica e dai cambi di ramo migliore.

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

## Minimax

Si applica a giochi deterministici, a somma zero e con informazione perfetta. MAX massimizza il valore; MIN lo minimizza. Le foglie hanno l'utilità degli esiti.

```text
MINIMAX-SEARCH(game, state)
    player ← PLAYER-TO-MOVE(state)
    value, move ← MAX-VALUE(game, state, player)
    restituisci move

MAX-VALUE(game, state, player)
    se TERMINAL(state): restituisci UTILITY(state, player), nessuna mossa
    v ← -∞
    per ogni azione a in ACTIONS(state):
        v2, _ ← MIN-VALUE(game, RESULT(state, a), player)
        se v2 > v: v, move ← v2, a
    restituisci v, move

MIN-VALUE(game, state, player)
    se TERMINAL(state): restituisci UTILITY(state, player), nessuna mossa
    v ← +∞
    per ogni azione a in ACTIONS(state):
        v2, _ ← MAX-VALUE(game, RESULT(state, a), player)
        se v2 < v: v, move ← v2, a
    restituisci v, move
```

Minimax è ottimale contro un avversario perfetto, ma esplora l'albero fino agli esiti terminali: tempo `O(b^m)`, spazio `O(bm)` con ricerca depth-first. Con fattore di ramificazione e profondità elevati diventa impraticabile.

## Alpha-Beta Pruning

Alpha-beta restituisce la stessa scelta di Minimax. `α` è il miglior valore già garantito a MAX sul percorso; `β` è il miglior limite già garantito a MIN. Si interrompe l'esplorazione quando `v ≥ β` in MAX o `v ≤ α` in MIN.

```text
ALPHA-BETA-SEARCH(game, state)
    player ← PLAYER-TO-MOVE(state)
    value, move ← MAX-VALUE(game, state, player, -∞, +∞)
    restituisci move

MAX-VALUE(game, state, player, α, β)
    se TERMINAL(state): restituisci UTILITY(state, player), nessuna mossa
    v ← -∞
    per ogni azione a in ACTIONS(state):
        v2, _ ← MIN-VALUE(game, RESULT(state, a), player, α, β)
        se v2 > v: v, move ← v2, a
        α ← max(α, v)
        se v ≥ β: restituisci v, move
    restituisci v, move

MIN-VALUE(game, state, player, α, β)
    se TERMINAL(state): restituisci UTILITY(state, player), nessuna mossa
    v ← +∞
    per ogni azione a in ACTIONS(state):
        v2, _ ← MAX-VALUE(game, RESULT(state, a), player, α, β)
        se v2 < v: v, move ← v2, a
        β ← min(β, v)
        se v ≤ α: restituisci v, move
    restituisci v, move

Chiamata iniziale: MAX-VALUE(game, root, player, -∞, +∞)
```

Il pruning non cambia il valore minimax alla radice. L'ordine di visita dei figli influenza quanti rami si potano: nel caso migliore, con ordinamento perfetto, il tempo scende a `O(b^(m/2))`; lo spazio resta `O(bm)`.

## Da ricordare quando si descrive un algoritmo

- **Frontiera:** struttura dati e regola con cui si estrae il prossimo nodo.
- **Visita:** ordine di espansione e momento del goal test.
- **Completezza:** se trova una soluzione quando ne esiste una.
- **Ottimalità:** se restituisce la soluzione di costo minimo, con quali ipotesi.
- **Complessità:** tempo e spazio; definire `b` (ramificazione), `d` (profondità della soluzione), `m` (profondità massima), `C*` (costo ottimo) ed `ε` (costo minimo positivo di un arco).
