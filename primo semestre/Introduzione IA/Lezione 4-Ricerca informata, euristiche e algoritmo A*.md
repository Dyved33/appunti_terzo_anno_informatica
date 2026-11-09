# Ricerca informata, euristiche e algoritmo A*

Gli algoritmi di ricerca differiscono soprattutto per il criterio con cui scelgono il prossimo nodo dalla **frontiera** (*fringe*).

Una coda di priorità può rappresentare questo criterio in modo generale. Se è implementata con un heap, inserire o estrarre un nodo costa $O(\log n)$. DFS e BFS usano strutture più semplici: rispettivamente uno stack LIFO e una coda FIFO, evitando questo costo aggiuntivo.

Nel codice si può riutilizzare la stessa procedura di ricerca passando strutture di frontiera diverse (*variable queuing object*).

## Ricerca a costo uniforme

La strategia della **Uniform Cost Search** (UCS) espande sempre il nodo della frontiera caratterizzato dal costo di cammino accumulato $g(n)$ minore.

*Vantaggi:*
- completezza: trova sempre una soluzione se i costi degli archi sono strettamente positivi ($c \ge \epsilon > 0$);
- ottimalità: garantisce di trovare il cammino a costo minimo verso il goal.

*Svantaggi:*
- esplorazione cieca in ogni direzione: espande i nodi lungo curve di livello concentriche (contorni di costo costante) attorno allo stato iniziale;
- assenza di informazioni sulla posizione dell'obiettivo nello spazio degli stati.

## Euristiche di ricerca

Una **funzione euristica** $h(n)$ è una funzione che mappa uno stato in una stima del costo necessario per raggiungere lo stato obiettivo più vicino a partire da $n$:

$$h(n) \approx \text{costo effettivo da } n \text{ al goal}$$

L'euristica è definita ad hoc per uno specifico problema di ricerca.

*Esempi di euristiche spaziali:*
- **Distanza euclidea:** distanza geometrica in linea d'aria, calcolata come $L_2 = \sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2}$;
- **Distanza di Manhattan:** distanza calcolata lungo una griglia ortogonale (somma delle differenze assolute delle coordinate, come i blocchi stradali di Manhattan), $L_1 = |x_1 - x_2| + |y_1 - y_2|$.

### Ricerca greedy (Greedy Best-First)

La ricerca **Greedy Best-First** espande sempre il nodo che appare più vicino all'obiettivo secondo la funzione euristica, minimizzando $f(n) = h(n)$. 

Sceglie l'ottimo locale guidandosi unicamente dall'euristica, ma non tiene conto del costo già accumulato per raggiungere il nodo: non garantisce né l'ottimalità della soluzione trovata né la completezza (può entrare in cicli infiniti su alberi di ricerca).

### Algoritmo Best-First generale

Nell'approccio *Best-First*, i nodi nella frontiera sono ordinati mediante una coda di priorità ordinata rispetto al valore minimo della funzione di valutazione $f(n)$: la coda estrae sempre l'elemento con priorità minima (cioè il nodo stimato migliore). In generale si pone:

$$f(n) = g(n) + h(n)$$

- $g(n)$ = costo effettivo sostenuto dallo stato iniziale al nodo $n$ (*backward cost*);
- $h(n)$ = stima euristica del costo rimanente da $n$ all'obiettivo (*forward cost*).

## Algoritmo A*

L'algoritmo **A\*** assegna a ogni nodo un costo stimato totale:

$$f(n) = g(n) + h(n)$$

- $g(n)$ è il costo già sostenuto per arrivare al nodo.
- $h(n)$ stima il costo che resta per raggiungere il goal.

A* sceglie dalla frontiera il nodo con $f$ minore. In questo modo combina il costo effettivo usato da UCS con la stima che guida la ricerca verso il goal.

L'algoritmo A\* è ottimo rispetto al costo = garantisce di restituire il cammino a costo minimo dallo stato iniziale al goal, purché la funzione euristica soddisfi la proprietà di **ammissibilità**.

> [!important]
> Nel funzionamento di A\*, il test di raggiungimento del goal (*goal test*) deve essere eseguito **soltanto quando un nodo viene estratto dalla frontiera**, non al momento della sua generazione. Se il test venisse effettuato alla generazione dei figli, l'algoritmo potrebbe terminare restituendo un goal subottimo trovato lungo un percorso costoso prima di aver terminato di esplorare un percorso alternativo più economico.

### Euristiche ammissibili

*Definizione:* un'euristica $h$ si dice **ammissibile** (ottimistica) se per ogni stato $n$ non sovrastima mai il costo effettivo per raggiungere il goal:

$$0 \le h(n) \le h^*(n)$$

dove $h^*(n)$ rappresenta il costo reale del cammino ottimo da $n$ allo stato goal più vicino. Poiché $h(n) \le h^*(n)$, l'algoritmo stima che il costo rimanente sia inferiore o uguale a quello reale, impedendo che cammini promettenti vengano ignorati prematuramente.

### Dimostrazione dell'ottimalità di A* su albero (Tree Search)

*Teorema:* con euristica ammissibile, l'algoritmo A\* su albero (*Tree Search*) è ottimo rispetto al costo.

*Dimostrazione:*
Assumiamo che nello spazio di ricerca esistano:
- $A$, un nodo goal ottimo con costo minimo $g(A) = f(A) = g^*$;
- $B$, un nodo goal subottimo con costo $g(B) = f(B) > g^*$;
- un'euristica $h$ ammissibile ($h(A) = h(B) = 0$ poiché sono stati goal).

*Tesi:* il nodo ottimo $A$ verrà estratto dalla frontiera prima del nodo subottimo $B$.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ia-27.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Dimostrazione dell'ottimalit&agrave; di A* su albero: la frontiera blocca il nodo subottimo B. Finch&eacute; la soluzione ottima A non &egrave; stata ancora estratta, deve esistere lungo il cammino dalla radice verso A almeno un nodo antenato n presente nella coda di priorit&agrave;. L'antenato n possiede un valore di valutazione f inferiore a quello del goal subottimo B, garantendo che n venga estratto ed espanso prima di B.
  </div>
</div>

I passaggi formali della dimostrazione:

1. Se $B$ si trova nella frontiera prima che la ricerca sia terminata, lungo il cammino che porta dalla radice al goal ottimo $A$ deve necessariamente trovarsi almeno un nodo antenato $n$ presente nella frontiera (al limite $n = A$).
2. Per definizione della funzione di valutazione:
   $$f(n) = g(n) + h(n)$$
3. Poiché $h$ è ammissibile, la stima $h(n)$ non supera mai il costo effettivo da $n$ ad $A$:
   $$h(n) \le \text{costo}(n \to A)$$
   quindi:
   $$f(n) \le g(n) + \text{costo}(n \to A) = g(A)$$
4. Poiché $A$ è un goal, $h(A) = 0$, da cui segue che $g(A) = f(A)$, e quindi:
   $$f(n) \le f(A)$$
5. Poiché per ipotesi $B$ è un goal subottimo, il suo costo è strettamente maggiore del costo di $A$:
   $$f(A) = g(A) < g(B) = f(B)$$
6. Concatenando le disuguaglianze otteniamo:
   $$f(n) \le f(A) < f(B) \implies f(n) < f(B)$$

Poiché la coda di priorità estrae sempre l'elemento con il valore minimo di $f$, l'antenato $n$ verrà estratto prima di $B$. Questa proprietà si preserva iterativamente per tutti i discendenti di $n$ fino ad $A$, dimostrando che $A$ verrà estratto prima di $B$.

> [!tip] Ricorda
> Mentre nella UCS la frontiera si espande uniformemente in tutte le direzioni secondo cerchi concentrici di costo $g$, in A\* la frontiera si espande prevalentemente in direzione del goal, guidata dall'attrazione esercitata dalla stima $h$.

## Progettazione di euristiche e problemi rilassati

Un metodo sistematico per ricavare euristiche ammissibili consiste nel formulare la soluzione di **problemi rilassati**, ovvero versioni semplificate del problema originale in cui vengono rimossi alcuni vincoli sulle azioni ammissibili.

| Problema | Euristica ammissibile | Rilassamento applicato |
| --- | --- | --- |
| Navigazione su mappa | Distanza in linea d'aria | Rimozione di vincoli stradali e ostacoli orografici |
| Percorso su griglia ortogonale | Distanza di Manhattan | Rimozione degli ostacoli e dei muri tra le celle |

### Esempio: il problema dell'8-puzzle

Il gioco dell'8-puzzle consiste in una griglia $3 \times 3$ con 8 tessere numerate e una casella vuota. Lo spazio degli stati ammette $9! / 2 = 181.440$ configurazioni raggiungibili.

Dal problema originale si possono derivare due problemi rilassati:

1. **$h_1$: numero di tessere fuori posto (*misplaced tiles*):** si rilassa il vincolo di movimento assumendo che ogni tessera possa teletrasportarsi direttamente nella casella obiettivo, anche se occupata. L'euristica è ammissibile perché ogni tessera fuori posto dovrà compiere almeno uno spostamento.
2. **$h_2$: somma delle distanze di Manhattan:** si rilassa il vincolo assumendo che ogni tessera possa scorrere di una casella in qualsiasi direzione ignorando la presenza delle altre tessere. L'euristica è ammissibile perché in assenza di ostacoli ciascuna tessera richiederà almeno le mosse previste dalla distanza di Manhattan.

*Confronto sull'efficienza di ricerca:* all'aumentare della lunghezza della soluzione ottima, la qualità dell'euristica abbatte drasticamente il numero di nodi espansi prima di trovare la soluzione:

| Lunghezza cammino ottimo | Nodi espansi con UCS | Nodi espansi con A\* ($h_1$, tessere fuori posto) | Nodi espansi con A\* ($h_2$, Manhattan) |
| --- | --- | --- | --- |
| 4 passi | 112 | 13 | 12 |
| 8 passi | 6.300 | 39 | 25 |
| 12 passi | $3.6 \times 10^6$ | 227 | 73 |

Un'euristica pari al costo esatto $h^*(n)$ espanderebbe esclusivamente i nodi appartenenti al cammino ottimo, ma il calcolo di $h^*$ richiederebbe lo stesso costo computazionale della risoluzione dell'intero problema. In A\* esiste un costante trade-off tra la qualità della stima euristica e il tempo di calcolo necessario per valutarla su ogni nodo.

### Dominanza e semi-reticolo delle euristiche

*Definizione:* date due euristiche ammissibili $h_a$ e $h_b$, si dice che **$h_a$ domina $h_b$** se per ogni stato $n$ vale:

$$h_a(n) \ge h_b(n)$$

L'euristica dominante $h_a$, essendo più vicina al costo reale $h^*$, garantisce di espandere un numero di nodi minore o uguale rispetto a $h_b$.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ia-45.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Struttura a semi-reticolo delle euristiche: combinazione mediante operatore di massimo. Quando sono disponibili pi&ugrave; euristiche ammissibili non dominanti tra loro, il massimo puntuale &egrave; anch'esso ammissibile e domina ciascuna singola componente. Alla base del reticolo si colloca l'euristica nulla (h = 0, equivalente a UCS), mentre all'apice si trova l'euristica ideale esatta h*.
  </div>
</div>

Se si dispone di più euristiche ammissibili $h_1, h_2, \dots, h_k$ ma nessuna di esse domina le altre su tutti gli stati, è possibile definire:

$$h(n) = \max(h_1(n), h_2(n), \dots, h_k(n))$$

La funzione risultante $h(n)$ è sempre ammissibile e domina tutte le singole euristiche componenti.

*Osservazione:* la somma $h_1(n) + h_2(n)$ non è in generale ammissibile, poiché sommando due stime indipendenti si rischia di sovrastimare il costo reale $h^*(n)$ violando il vincolo di ottimismo.

## Ricerca su grafo (Graph Search)

Nei problemi in cui lo spazio degli stati contiene cicli o cammini multipli che riconducono al medesimo stato, la ricerca su albero (*Tree Search*) può generare un'esplosione esponenziale di lavoro ridondante riespandendo ripetutamente gli stessi stati.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ia-47.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Confronto tra grafo degli stati e albero di ricerca: presenza di percorsi ridondanti. Senza un meccanismo di rilevamento degli stati gi&agrave; visitati, un semplice grafo a quattro nodi con percorsi incrociati genera un albero di ricerca infinito o con duplicazioni esponenziali di nodi esplorati.
  </div>
</div>

Il principio fondamentale della **Graph Search** consiste nell'evitare di espandere due volte lo stesso stato mantenendo una memoria degli stati già visitati (*reached set* o *closed set*).

### Gestione del reached set e ottimalità

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ia-50.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Importanza del tracciamento dei costi nel reached set: grafo controesempio. Raggiungendo lo stato C tramite il percorso subottimo superiore con costo 4 prima di quello inferiore a costo 3, memorizzare C come insieme privo di costo scarterebbe erroneamente il percorso migliore successivo, compromettendo l'ottimalit&agrave; della soluzione finale verso il goal G.
  </div>
</div>

Per non compromettere l'ottimalità, il *reached set* non deve essere un semplice insieme booleano di stati visitati, ma un dizionario che associa a ogni stato il costo minimo con cui è stato raggiunto finora: `(stato, costo)`. Quando un nodo $n$ viene estratto dalla frontiera:
- se il suo stato non è presente nel *reached set*, viene registrato con il suo costo e i suoi figli vengono inseriti nella frontiera;
- se il suo stato è già presente, ma il nuovo costo è strettamente inferiore a quello registrato in precedenza, il costo nel *reached set* viene aggiornato e i figli vengono riespansi lungo il nuovo percorso più economico;
- se il nuovo costo è maggiore o uguale a quello già memorizzato, il nodo viene scartato.

### Pseudocodice di ricerca su albero e su grafo

```Tree_Search
function TREE-SEARCH(problem, fringe) return a solution, or failure
    fringe = INSERT(MAKE-NODE(INITIAL-STATE[problem]), fringe)
    loop do
        if fringe is empty then return failure
        node = REMOVE-FRONT(fringe)
        if GOAL-TEST(problem, STATE[node]) then return node
        for child-node in EXPAND(STATE[node], problem) do
            fringe = INSERT(child-node, fringe)
        end
    end
```

```A_Star_Graph_Search
function A*-GRAPH-SEARCH(problem, frontier) return a solution or failure
    reached = an empty dict mapping nodes to the cost to each one
    frontier = INSERT((MAKE-NODE(INITIAL-STATE[problem]), 0), frontier)
    while not IS-EMPTY(frontier) do
        node, CostToNode = POP(frontier)
        if problem.IS-GOAL(node.STATE) then 
            return node
        end if
        if node.STATE is not in reached or reached[node.STATE] > CostToNode then
            reached[node.STATE] = CostToNode
            for each child-node in EXPAND(problem, node) do
                frontier = INSERT((child-node, child-node.COST + CostToNode), frontier)
            end for
        end if
    end while
    return failure
```

## Consistenza delle euristiche

Con la semplice ammissibilità, l'algoritmo A\* su grafo potrebbe dover riespandere nodi già visitati se incontrati successivamente con un costo inferiore. Per evitare qualunque riapertura di stati garantendo che ogni nodo venga estratto ed espanso una sola volta, si richiede una condizione più stringente: la **consistenza** (o monotonia).

*Definizione:* un'euristica $h$ è **consistente** se per ogni stato $n$ e per ogni suo successore $n'$ generato dall'azione $a$ con costo di transizione $c(n, a, n')$ soddisfa:

$$h(n) \le c(n, a, n') + h(n') \iff h(n) - h(n') \le c(n, a, n')$$

La consistenza rappresenta la disuguaglianza triangolare applicata ai costi euristici.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="Pasted image 20261015180349.png" style="width: 50%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Interpretazione geometrica della consistenza: disuguaglianza triangolare tra stati. La differenza nella stima euristica tra un nodo e il suo successore non pu&ograve; mai superare il costo effettivo dell'arco che li congiunge.
  </div>
</div>

### Conseguenze della consistenza

1. **Monotonia della funzione di valutazione:** il valore di $f$ lungo qualsiasi cammino non decresce mai:
   $$f(n') = g(n') + h(n') = g(n) + c(n, a, n') + h(n') \ge g(n) + h(n) = f(n)$$
2. **Espansione per contorni di f crescenti:** A\* espande i nodi in ordine strettamente non decrescente di $f$ (*f-contours*).
3. **Ottimalità alla prima espansione (*Single State Expansion*):** la prima volta che uno stato viene estratto dalla frontiera, è garantito che sia stato raggiunto attraverso il cammino a costo minimo assoluto (perché $A^{*}$ usa coda di priorità sul nodo con costo minore g+h). Non è mai necessario riespandere uno stato già chiuso.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ia-57.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Espansione singola degli stati con euristica consistente: contorni di livello f. I nodi che raggiungono qualsiasi stato s in modo ottimale vengono sempre espansi prima dei nodi che raggiungono lo stesso stato in modo subottimale, rendendo l'algoritmo A* su grafo privo di riaperture.
  </div>
</div>

### Dimostrazione della prima espansione ottima

*Teorema:* se $h$ è consistente, quando A\* estrae un nodo $n$ dalla frontiera, $g(n)$ è il costo minimo per raggiungere lo stato associato a $n$.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ia-59.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Dimostrazione per contraddizione dell'espansione al costo minimo: se per assurdo venisse estratto per primo un nodo subottimo n', dovrebbe esistere un antenato p del cammino ottimo presente nella frontiera. Per effetto della consistenza f(p) &le; f(n) &lt; f(n'), imponendo che p venga estratto prima di n', contraddicendo l'ipotesi.
  </div>
</div>

La dimostrazione formale si articola per assurdo:
1. Supponiamo per assurdo che venga estratto ed espanso per primo un nodo $n'$ associato allo stato $s$ lungo un cammino subottimale, mentre il cammino ottimo verso $s$ non è ancora stato completato.
2. Sul cammino ottimo verso $s$ deve esistere un antenato $p$ presente nella frontiera al momento dell'estrazione di $n'$.
3. Poiché $h$ è consistente, i valori di $f$ lungo il cammino ottimo non decrescono, da cui $f(p) \le f(n)$, dove $n$ è il nodo che raggiunge $s$ in modo ottimale.
4. Poiché $n'$ è subottimale rispetto a $n$ e raggiungono lo stesso stato ($h(n) = h(n')$), si ha $g(n) < g(n')$, implicando:
   $$f(n) < f(n')$$
5. Dalle relazioni precedenti segue:
   $$f(p) \le f(n) < f(n') \implies f(p) < f(n')$$
6. Poiché $f(p) < f(n')$, la coda di priorità avrebbe dovuto estrarre $p$ prima di $n'$, contraddicendo l'assunzione che $n'$ sia stato estratto per primo. Dunque il primo cammino espanso verso qualsiasi stato è sempre quello a costo minimo.

## Implementazione dal libro di testo: A* e le sue varianti

Il libro di testo (AIMA, Cap. 3) presenta **A*** come una ricerca su grafo che espande i nodi in ordine di valore $f(n) = g(n) + h(n)$ crescente, dove $g(n)$ è il costo del cammino dallo stato iniziale a $n$ e $h(n)$ è l'euristica che stima il costo restante fino al goal. Come per UCS si usa una coda di priorità, ma ora la priorità è $f$ invece del solo $g$: in questo modo la ricerca è guidata verso il goal e non esplora più in tutte le direzioni. A* è completo e ottimale se l'euristica $h$ è **ammissibile** (non sovrastima mai il costo reale), ed espone il minor numero di nodi fra tutti gli algoritmi ottimali per quell'euristica.

```
A_Stella
node <- NODO(problema.STATO_INIZIALE)
if problema.test_obiettivo(node.stato): return node
frontiera <- coda_di_priorita_contenente(node) ordinato su f = g + h
esplorato <- insieme_vuoto()
while frontiera non e' vuota:
    node <- estrai_minimo_f(frontiera)
    if problema.test_obiettivo(node.stato): return node
    esplorato.aggiungi(node.stato)
    for child in node.esproandi(problema):
        if child.stato non in esplorato:
            if child.stato non in frontiera:
                frontiera.aggiungi(child)
            else if f(child) < f_del_nodo_già_in_frontiera:
                sostituisci_quel_nodo_con(child)
return fallimento
```

Il libro discute poi diverse varianti utili a seconda dei vincoli:

- **Weighted A\*** usa $f(n) = g(n) + W \cdot h(n)$ con $W > 1$, pesando l'euristica più del costo accumulato. Si comporta in modo più *greedy*, espande molti meno nodi (nell'esempio del libro 7 volte di meno) ma perde l'ottimalità: il costo della soluzione è al più $W \cdot C^*$.
- **Ricerca a memoria limitata:** quando la memoria non basta a conservare tutta la frontiera:
  - *Beam search:* tiene in frontiera solo i $k$ nodi migliori a ogni livello; è rapida ma incompleta e subottima.
  - *Iterative-deepening A\** (IDA*): ripete ricerche in profondità limitata su soglie di $f$ crescenti; ottiene i vantaggi di A* senza memorizzare il reached set, riespandendo però alcuni stati.
  - *Recursive best-first search* (RBFS): best-first a spazio lineare, ricorda solo la seconda scelta migliore e i valori di backup dei rami abbandonati; ottimo se $h$ è ammissibile.
  - *SMA\**: semplificazione di A* a memoria limitata che sfrutta tutta la memoria disponibile, dimenticando i nodi con $f$ più alto quando serve spazio.
- **Pattern databases:** per costruire euristiche ammissibili si precalcolano i costi esatti delle soluzioni di sottoproblemi e li si memorizzano in una tabella; le *disjoint pattern databases* combinano i costi di sottoproblemi disgiunti.

> [!info] Sintesi:
> - A* espande i nodi in ordine di f = g + h crescente, guidando la ricerca verso il goal.
> - È completo e ottimale se l'euristica h è ammissibile (non sovrastima il costo reale).
> - Espone il minor numero di nodi fra gli algoritmi ottimali per un'euristica data.
> - Weighted A* scambia un po' di ottimalità per molta meno memoria e meno nodi espansi.
> - Quando la memoria scarseggia si usano IDA*, RBFS o SMA*, che esplorano con spazio lineare o limitato.

