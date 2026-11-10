# Ricerca su grafo: BFS e DFS

## Nodo, stato e cammini

Nel grafo dello spazio degli stati e nell'albero di ricerca il **nodo** e lo **stato** non coincidono.

*Definizione:* il **nodo** si trova all'interno dell'[[Lezione 2-Agenti intelligenti, rappresentazione degli stati e ricerca su albero#Il grafo dello spazio degli stati e l'albero di ricerca|albero di ricerca]] e codifica il *percorso* che permette di raggiungerlo; lo **stato** è la rappresentazione di una configurazione nello spazio degli stati.

> [!info] Un solo nodo radice:
> Un albero ha un solo nodo che fa da padre di tutto l'albero (la radice); se la struttura non ha un'unica radice si parla di grafo.

Il risultato di una ricerca si legge su due livelli: la **soluzione** è la lista di azioni, il **percorso** (*path*) è la lista di nodi dallo stato iniziale fino a quello finale.

## Ricerca su albero e su grafo

Gli algoritmi di ricerca si possono implementare sia su albero sia su grafo. Sull'albero bisogna implementare esplicitamente il controllo dei cicli; il grafo porta invece nella struttura dati un flag, o un insieme, che dice se uno stato è già stato esplorato, sempre per individuare i cicli. In pratica entrambi tengono due strutture: la **frontiera** (`frontier`) e l'insieme degli stati già raggiunti (`explored`).

## BFS su grafo

La frontiera è una **coda FIFO** (`deque`): si estrae con `popleft()`, quindi il nodo generato per primo è anche il primo a essere espanso, e tutti i nodi di un livello vengono processati prima di scendere a quello successivo. Accanto alla frontiera c'è `explored`, l'insieme degli stati già raggiunti, che evita di riespandere lo stesso stato.

Ad ogni giro si estrae un nodo e si generano i suoi figli con `node.expand(problem)`. Per ogni figlio:
- la **verifica del goal è anticipata**: se lo stato del figlio supera `goal_test` l'algoritmo si ferma subito e restituisce il figlio, senza inserirlo in frontiera;
- altrimenti, se il suo stato non è già in `explored`, lo si aggiunge a `explored` e lo si accoda alla frontiera.

Se la frontiera si svuota senza aver trovato il goal, la funzione restituisce `None`.

```Python
# BFS su grafo
def breadth_search_graph(problem: Problem) -> Node:
    # inizializzazione
    node = Node(problem.initial)
    if problem.goal_test(node.state):
        return node
    frontier = deque([node])
    explored = set(node.state)
    print("Frontier DFS:")

    # scorrimento frontiera
    while frontier:
        node = frontier.popleft()  # estrazione del nodo da deque

        # analisi dei figli
        for child in node.expand(problem):

            # verifica anticipata del goal
            if problem.goal_test(child.state):
                print("Last Expanded: ", node)
                print("Explored node in BFS: ", len(explored))
                return child

            # se non l'ho già esplorato e non è già in frontiera
            if child.state not in explored:
                explored.add(child.state)
                frontier.append(child)
                print("Added", child)

    return None
```

## DFS su grafo

La frontiera è uno **stack LIFO** (una lista): si estrae con `pop()`, che toglie l'ultimo elemento inserito, per cui la ricerca scende in profondità lungo un ramo prima di risalire. A differenza del BFS, `explored` parte vuoto e il **goal test si fa sul nodo estratto**, non sul figlio appena generato: si estrae il nodo, lo si controlla, lo si marca come esplorato e solo allora se ne generano i figli. Un figlio viene impilato solo se il suo stato non è già in `explored`.

Anche qui, se la frontiera si svuota la funzione restituisce `None`.

```Python
# DFS su grafo
def depth_search_graph(problem: Problem) -> Node:
    # inizializzazione
    node = Node(problem.initial)

    frontier = [node]  # LIFO
    explored = set()
    print("Frontier BFS:")

    # scorrimento frontiera
    while frontier:
        node = frontier.pop()  # estrae l'ultimo nodo inserito (LIFO)

        if problem.goal_test(node.state):
            print("Last Expanded: ", node)
            print("Explored nodes in DFS: ", len(explored))
            return node

        # analisi dei figli
        explored.add(node.state)
        for child in node.expand(problem):

            # se non l'ho già esplorato e non è già in frontiera
            if child.state not in explored:
                explored.add(child.state)
                frontier.append(child)
                print("Added", child)

    return None
```

## Differenze tra BFS e DFS

- **Quando si controlla il goal:** il BFS lo verifica sul figlio appena generato (controllo anticipato); il DFS sul nodo che estrae dalla frontiera.
- **Ordine di esplorazione:** il BFS procede per livelli, il DFS scende in profondità.

> [!warning] Attenzione:
> La DFS non ha condizioni di ottimalità.

## Implementazione dal libro di testo: ricerca a costo uniforme (UCS)

BFS e DFS esplorano senza tenere conto dei costi delle azioni. Il libro di testo (AIMA, Cap. 3) introduce la **ricerca a costo uniforme (UCS)**, che espande per primo il nodo a costo cumulato più basso, usando una coda di priorità ordinata sul costo del cammino dallo stato iniziale. UCS esplora lo spazio a "contori di costo" sempre più ampi attorno allo stato iniziale e si ferma non appena estrae un nodo che supera il goal test: in quel momento il cammino trovato è garantito a costo minimo.

```
Uniform_Cost_Search
node <- NODO(problema.STATO_INIZIALE)
frontiera <- coda_di_priorita_contenente(node) ordinato su costo_cumulato
esplorato <- insieme_vuoto()
while frontiera non e' vuota:
    node <- estrai_minimo_costo(frontiera)
    if problema.test_obiettivo(node.stato): return node
    esplorato.aggiungi(node.stato)
    for child in node.esproandi(problema):
        if child.stato non in esplorato:
            if child.stato non in frontiera:
                frontiera.aggiungi(child)
            else if costo_cumulato(child) < costo_del_nodo_già_in_frontiera:
                sostituisci_quel_nodo_con(child)
return fallimento
```

UCS è **completo** (trova una soluzione se esiste, purché i costi siano positivi) e **ottimale** (restituisce il cammino di costo minore). Il prezzo è che esplora in ogni direzione, senza alcuna informazione sulla posizione del goal: è proprio il limite che A* supererà aggiungendo l'euristica h.

> [!info] Sintesi:
> - BFS esplora per livelli ed è completo e ottimale solo se tutti i costi sono uguali a 1.
> - DFS scende in profondità, usa poca memoria ma non è completo su grafi ciclici né ottimale.
> - La ricerca su grafo aggiunge un set esplorato per evitare di riespandere gli stessi stati.
> - UCS espande prima il nodo a costo cumulato minimo; è completo e ottimale con costi positivi.
> - UCS esplora in tutte le direzioni: senza una guida verso il goal può essere molto dispendioso.

