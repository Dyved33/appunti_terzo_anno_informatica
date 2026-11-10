# Ricerca con memoria limitata: IDA*, RBFS e SMA*

La ricerca A* standard mantiene in memoria l'intera frontiera e il *reached set*, richiedendo spazio esponenziale nel caso peggiore. Quando la memoria disponibile è insufficiente, servono varianti che limitano l'uso di memoria preservando quanto più possibile l'ottimalità e la completezza.

## Contorni di f in A*

<div style="display: flex; justify-content: center;">
  <img src="slide5--01.png" width="30%">
</div>

A* espande i nodi in ordine di $f$ crescente: aggiunge progressivamente "contorni di $f$" (insiemi di nodi con lo stesso valore di $f$). Il contorno $i$ contiene tutti i nodi con $f = f_i$, dove $f_i < f_{i+1}$. Questo comportamento a contorni è la base per le varianti a memoria limitata.

## Confronto UCS vs A*: esplorazione dello spazio

<div style="display: flex; justify-content: center;">
  <img src="slide5--02.png" style="width: 30%;">
</div>

La ricerca a costo uniforme (UCS) espande nodi lungo curve di livello concentriche di $g$ attorno allo stato iniziale e questo comporta che i contorni di UCS coprono porzioni ampie dello spazio, espandendo nodi anche lontani dal goal.

A* invece guida l'espansione verso il goal grazie all'euristica $h$, riducendo drasticamente i nodi esplorati: i contorni di $f = g + h$ si allungano nella direzione dell'obiettivo.

## Potatura e soluzioni soddisfacenti

> [!info] In altre parole:
> $A^{*}$ con euristica ammissibile è ottimo ma può esplodere in memoria. Se rinunciamo all'ottimalità stretta, possiamo *potare* rami poco promettenti e cercare soluzioni "abbastanza buone" (*satisficing*), risparmiando tempo e spazio.

Proprietà di A*: è completo (salvo infiniti nodi con $f < f(G)$), ottimo e ottimalmente efficiente per l'euristica data (nessun altro algoritmo ottimo espande meno nodi). Tuttavia **espande troppi nodi** (spazio e tempo esponenziali nel caso peggiore). La soluzione: *rilassare i vincoli* e cercare soluzioni *satisficing* (subottime ma "abbastanza buone").

Le euristiche non ammissibili possono essere più accurate (più vicine al costo reale $h^*$), riducendo i nodi espansi, a costo di perdere la garanzia di ottimalità.

Esempio: **detour index**, un moltiplicatore applicato alla distanza in linea d'aria per tenere conto della tipica curvatura delle strade.

### Weighted A*

**Weighted A*** usa una funzione di valutazione modificata:

$$f(n) = g(n) + W \cdot h(n) \quad \text{con } W > 1$$

Pesa l'euristica più del costo accumulato, comportandosi in modo più *greedy*. Garantisce che il costo della soluzione $c$ soddisfi:

$$C^* \le c \le W \cdot C^*$$

In pratica si ottengono spesso risultati molto più vicini a $C^*$ che al limite superiore $W \cdot C^*$.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide5--05.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Confronto A* (a) vs Weighted A* con $W=2$ (b) su griglia con ostacoli. Le barre grigie sono ostacoli, la linea viola è il percorso dal verde (start) al rosso (goal), i puntini sono gli stati raggiunti. Weighted A* esplora 7 volte meno stati e trova un percorso solo il 5% più costoso.
  </div>
</div>

> [!warning] Ricorda:
> - $C^{*}$ = costo della soluzione ottima
## IDA* (Iterative Deepening A*)

IDA* applica la strategia di *iterative deepening* ad A*: invece di una frontiera in memoria, esegue una serie di ricerche in profondità limitate da una soglia sul valore di $f$.

**Funzionamento:**
1. Si parte con soglia $f\text{-limit} = h(\text{start})$
2. Ogni iterazione esegue una ricerca esaustiva (DFS) entro il limite $f\text{-limit}$ corrente
3. Se si trova il goal, terminare con successo
4. Altrimenti, si trova il nodo appena oltre il confine (con $f$ minimo tra quelli che superano il limite) e il suo valore $f$ diventa il nuovo limite per l'iterazione successiva

> [!info] In altre parole:
> IDA* non tiene la frontiera in memoria: rifà la ricerca da capo a ogni iterazione, alzando progressivamente la soglia su $f$. È come fare iterative deepening su $f$ invece che sulla profondità.

### Vantaggi e svantaggi di IDA*

| Vantaggi | Svantaggi |
|---|---|
| Se $h$ è ammissibile, trova la soluzione ottima | Può visitare lo stesso stato più volte nella **stessa** iterazione |
| Requisito di memoria lineare nella profondità massima ($O(bd)$) | Quando riparte, **scarta tutta l'informazione** eccetto la nuova soglia |
| Non serve il *reached set* | Numero di iterazioni = numero di valori $f$ distinti lungo il cammino ottimo |

## RBFS

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide5--08.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  <b>RBFS (Recursive Best-First Search)</b> — best-first search con spazio lineare $O(bd)$.
  <br><br>
  • Non mantiene aperte tutte le ramificazioni come A*; usa una variabile per ricordare la <b>seconda scelta migliore</b> (*best alternative*).
  <br>
  • Quando la scelta corrente diventa peggiore della seconda, l'algoritmo sa dove tornare.
  <br>
  • Cancella il ramo fallito, memorizzando il miglior valore $f$ di quel ramo come <i>backed-up value</i> (valore di backup).
  <br><br>
  </div>
</div>

<div style="display: flex; justify-content: center;">
  <img src="slide5--09.png" style="width: 50%;">
</div>

Traccia Romania: 
- Dopo aver espanso Rimnicu Vilcea, il successore Pitesti ha $f=417$, ma la seconda scelta per Rimnicu è $415$. Il ramo da Rimnicu viene cancellato, $417$ registrato come valore di backup, e la ricerca continua da Fagaras (seconda scelta globale).
- Dopo essere tornati indietro a Sibiu ed espanso Fagaras: i successori mostrano i loro valori $f$ aggiornati (Sibiu 447, Arad 417, Oradea 646, ecc.). Il ramo da Fagaras non porta al goal in modo ottimale.
- Si torna indietro a Rimnicu Vilcea (la seconda scelta globale con $f=415$) ed espande Pitesti con $f=417$. Il valore $f=417$ diventa il nuovo *backed-up value* per quel ramo.

Questo illustra il meccanismo chiave: RBFS "ricorda" il miglior $f$ del ramo abbandonato e lo usa per decidere quando tornarci.

Pseudocodice di RBFS (dal libro): la funzione `RBFS` riceve un nodo e un limite $f\text{-limit}$; aggiorna $f$ di ogni successore con `max(PATH-COST + h, node.f)` per mantenere il *backed-up value*; espande ricorsivamente il successore migliore (`best`) passando come nuovo limite `min(f-limit, alternative)` dove `alternative` è il secondo $f$ minore; se `best.f > f-limit` ritorna fallimento con il nuovo limite.

### Pseudocodice di RBFS

```RBFS
function RECURSIVE-BEST-FIRST-SEARCH(problem) returns a solution or failure
    solution, f-value = RBFS(problem, NODE(problem.INITIAL), ∞)
    return solution

function RBFS(problem, node, f-limit) returns a solution or failure, and a new f-cost limit
    if problem.IS-GOAL(node.STATE) then return node
    successors = LIST(EXPAND(node))
    if successors is empty then return failure, ∞
    for each s in successors do
        // aggiorna f con il valore di backup dalla ricerca precedente
        s.f = max(s.PATH-COST + h(s), node.f)
    while true do
        best = the node in successors with lowest f-value
        if best.f > f-limit then return failure, best.f
        alternative = the second-lowest f-value among successors
        result, best.f = RBFS(problem, best, min(f-limit, alternative))
        if result ≠ failure then return result, best.f
```

### Proprietà di RBFS

<div style="display: flex; justify-content: center;">
  <img src="slide5--11.png" style="width: 30%;">
</div>

- **Ottimalità:** come A*, ottimo se $h(n)$ è ammissibile
- **Complessità temporale:** difficile da caratterizzare; dipende dall'accuratezza di $h$ e da quante volte il cammino migliore cambia (può "switchare" avanti e indietro)
- **Complessità spaziale:** $O(bd)$ — estremo opposto di A* (che usa $O(b^d)$); usa **troppo poca** memoria, non sfrutta quella disponibile

> [!warning] Attenzione
> RBFS può riespandere molte volte gli stessi nodi perché "dimentica" i rami non correnti, ricordando solo il loro miglior $f$ di backup. Questo costa tempo per risparmiare spazio.

## SMA* (Simplified Memory-Bounded A*)

SMA* è una semplificazione di A* a memoria limitata che **sfrutta tutta la memoria disponibile** (limita la dimensione della coda di priorità). Quando la memoria si esaurisce, dimentica i nodi peggiori (con $f$ più alto) per fare spazio a quelli migliori.

<div style="display: flex; justify-content: center;">
  <img src="slide5--12.png" style="width: 30%;">
</div>

**Principio di funzionamento:**
- Espande verso il nodo migliore (come A*)
- Ha un limite di memoria fisso
- Quando la memoria è piena e deve inserire un nuovo nodo, **rimuove il nodo con $f$ più alto** (il meno promettente)
- Memorizza il valore $f$ del nodo dimenticato nel suo genitore (*backed-up value*), così se quel ramo diventa di nuovo promettente l'algoritmo sa quanto valeva
- Se tutti i nodi in memoria sono goal, restituisce il migliore; se la memoria contiene solo nodi con $f = \infty$, fallisce

### Proprietà di SMA*

| Proprietà       | Descrizione                                                                                         |
| --------------- | --------------------------------------------------------------------------------------------------- |
| **Completezza** | Sì, se la memoria basta per contenere il cammino ottimo                                             |
| **Ottimalità**  | Sì, se $h$ è ammissibile e la memoria basta per il cammino ottimo (se la soluzione è raggiungibile) |
| **Spazio**      | Usa tutta la memoria disponibile (configurabile)                                                    |
| **Tempo**       | Migliore di IDA* e RBFS quando c'è memoria sufficiente, perché non riespande ciecamente             |

> [!info] In altre parole:
> SMA* sta a metà tra A* (memoria illimitata) e RBFS/IDA* (memoria minima). È la scelta pratica quando hai un budget di memoria fisso: usa ogni byte per ricordare i nodi più promettenti e "dimentica" solo quelli peggiori, tenendo traccia del loro valore per non perdere lavoro.

## Sintesi delle varianti a memoria limitata

| Algoritmo       | Spazio        | Ottimo se $h$ amm.       | Note                                                   |
| --------------- | ------------- | ------------------------ | ------------------------------------------------------ |
| **A***          | $O(b^d)$      | Sì                       | Standard, serve molta memoria                          |
| **IDA***        | $O(bd)$       | Sì                       | Rifà la ricerca da capo a ogni iterazione; scarta info |
| **RBFS**        | $O(bd)$       | Sì                       | Ricorsivo, ricorda solo 2° scelta; molto switching     |
| **SMA***        | Configurabile | Sì (se memoria basta)    | Usa tutta la memoria, dimentica nodi con $f$ max       |
| **Weighted A*** | $O(b^d)$      | No ($c \le W \cdot C^*$) | Più veloce, subottimo controllato                      |
| **Beam Search** | $O(k)$        | No                       | Mantiene solo $k$ migliori per livello; incompleto     |

## Implementazione dal libro di testo: IDA* e SMA*

Il libro di testo (AIMA, Cap. 3, sez. 3.5) propone due varianti di A* pensate per quando la memoria non basta a tenere tutta la frontiera.

**IDA* (Iterative Deepening A*)** applica l'idea dell'iterative deepening ad A*: invece di mantenere una frontiera in memoria, esegue una serie di ricerche in profondità, ciascuna limitata da una soglia sul valore di $f$. Si parte con soglia $h(\text{iniziale})$; a ogni iterazione si esplora esaustivamente entro il limite corrente, e se non si trova il goal si alza la soglia al valore $f$ minimo tra i nodi appena oltre il confine. IDA* usa memoria lineare nella profondità ($O(bd)$), non serve il reached set, ma tra un'iterazione e l'altra scarta quasi tutte le informazioni e può riespandere più volte gli stessi stati.

```
IDA_Stella
soglia <- h(stato_iniziale)
loop:
    result, nuovo_limite <- ricerca_in_profondita_limitata(problema, soglia)
    if result != fallimento: return result
    soglia <- nuovo_limite
```

**SMA* (Simplified Memory-Bounded A*)** è l'opposto: invece di usare poca memoria, ne usa quanta ne è disponibile. Espande sempre il nodo migliore come A*, ma quando la memoria si esaurisce rimuove il nodo con $f$ più alto (il meno promettente) per fare spazio, memorizzandone il valore di backup nel genitore così che, se quel ramo diventa di nuovo promettente, l'algoritmo sappia quanto valeva. SMA* è completo e ottimale se la memoria basta a contenere il cammino ottimo e $h$ è ammissibile; è la scelta pratica quando si ha un budget di memoria fisso.

> [!info] Sintesi:
> - IDA* esplora per soglie di f crescenti con memoria lineare O(bd), ma riespande stati e scarta informazioni tra un'iterazione e l'altra.
> - RBFS è best-first ricorsivo a spazio lineare, ricorda solo la seconda scelta e i valori di backup.
> - SMA* usa tutta la memoria disponibile, dimenticando i nodi con f più alto e tenendo traccia del loro valore di backup.
> - A* è ottimale ma richiede memoria esponenziale O(b^d); le varianti a memoria limitata scambiano qualcosa in tempo per stare nello spazio.
> - Weighted A* e beam search rinunciano all'ottimalita' per guadagnare velocita'.

