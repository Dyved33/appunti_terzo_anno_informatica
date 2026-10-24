# Game Playing, Minimax e Alpha-Beta Pruning

## Game Playing Progress
Milestones storici:
- **Checkers**: 1950 primo giocatore automatico; 1994 Chinook batte il campione umano Marion Tinsley (database 8 pezzi endgame); 2007 dama risolta.
- **Chess**: 1997 Deep Blue batte Kasparov (200M posizioni/sec, estensioni di ricerca fino a 40 ply).
- **Go**: 2016 AlphaGo batte campione umano (Monte Carlo Tree Search + funzione di valutazione appresa).
- **Pacman**: ambiente didattico multi-agente.

*Osservazione:* i giochi servono come benchmark per tracciare il progresso nell'IA.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022165937.png" width="50%">
</div>

> [!info] In altre parole:
> La complessità dei giochi (branching factor, profondità) costringe a sviluppare ricerca, euristiche e apprendimento che poi si trasferiscono ad altri domini.

## Tipi di giochi
Assi di classificazione:
- **Deterministici / Stocastici** — presenza di casualità (dadi, carte coperte).
- **Numero di giocatori** — 1, 2, o più.
- **Somma zero / Somma non zero** — in somma zero l'utilità di un giocatore è l'opposto dell'altro (in altre parole un solo giocatore può vincere e ciò implica che tutti gli altri perdano); in somma non zero utilità indipendenti (cooperazione, indifferenza, competizione mista).
- **Informazione perfetta / Imperfetta** — nello stato perfetto l'agente vede tutto; nell'imperfetta ci sono parti nascoste.

Obiettivo: calcolare una **policy** (strategia) $S \to A$ che raccomandi una mossa per ogni stato.

## Giochi deterministici a somma zero
Formalizzazione standard:
- **Stati** $S$ (stato iniziale $s_0$)
- **Giocatori** $P = \{1,\dots,N\}$ (turni alternati)
- **Azioni** $A(s, p)$ — dipendono da stato e giocatore
- **Funzione di transizione** $S \times A \to S$
- **Test terminale** $S \to \{\text{true}, \text{false}\}$
- **Utilità terminale** $S \times P \to \mathbb{R}$ — valore certo solo negli stati finali

Una soluzione per un giocatore è una **policy** $\pi: S \to A$.

*Definizione:* **Gioco a somma zero** = gli agenti hanno utilità opposte; si può ragionare su un unico valore che MAX massimizza e MIN minimizza.

> [!info] In altre parole:
> In un gioco a somma zero con informazione perfetta, il risultato dipende solo dalle scelte dei due giocatori: non c'è casualità né informazione nascosta.

## Albero di gioco e valori dei nodi
Un **albero di gioco** rappresenta le mosse possibili a partire dallo stato iniziale:
- La radice è la posizione attuale.
- Ogni arco è una mossa legale.
- Ogni figlio è lo stato ottenuto applicando quella mossa.
- Le foglie sono stati terminali, oppure stati in cui la ricerca si ferma.

Ogni percorso dalla radice a un nodo descrive una possibile sequenza di mosse. Stati uguali possono comparire in più nodi se sono stati raggiunti con percorsi diversi.

In un problema **single-agent**, a ogni nodo scelgo io la mossa. Il valore del nodo è quindi il massimo valore dei suoi figli.

In un gioco **adversarial** a due giocatori, i turni si alternano:
- **MAX** rappresenta il nostro giocatore e sceglie il valore più alto.
- **MIN** rappresenta l'avversario e sceglie il valore più basso per MAX.

I valori delle foglie indicano l'utilità dell'esito per MAX. Per valutare una posizione non terminale, risalgo dai figli: MAX prende il massimo, MIN il minimo. Questo passaggio si chiama **propagazione dei valori**.

### Single-Agent Search Trees
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022171217.png" width="50%">
</div>
La radice è lo stato iniziale; ogni livello aggiunge una mossa. Le foglie hanno valori 8, 2, 0, 2, 6, 4, 6. Risalgo scegliendo il massimo dei figli a ogni nodo: il valore indica il miglior esito che posso ottenere da quel punto.

### Value of a State
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022171253.png" width="50%">
</div>
Il valore di uno stato terminale è la sua utilità. Per uno stato non terminale, il valore dipende da chi deve muovere: MAX sceglie il figlio con valore maggiore, MIN quello con valore minore.

### Adversarial Game Trees
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022171311.png" width="50%">
</div>
Qui le foglie valgono -20, -8, -18, -5, -10, +4, -20 e +8. Partendo dal basso, ogni nodo MIN seleziona il figlio peggiore per MAX; ogni nodo MAX seleziona il migliore tra i valori lasciati da MIN.

### Minimax Values
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022171326.png" width="50%">
</div>
Nei nodi MAX (cerchi) si propaga il massimo dei figli; nei nodi MIN (quadrati) il minimo. Alla radice scelgo la mossa con il valore più alto dopo aver considerato la migliore risposta possibile dell'avversario.

### Tic-Tac-Toe Game Tree
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022171346.png" width="50%">
</div>
L'albero del tris mostra quante posizioni possono nascere anche da poche mosse. Minimax visita le possibili continuazioni fino agli esiti finali e poi propaga i valori per scegliere la mossa.

## Minimax
Minimax è l'algoritmo che sceglie la mossa migliore assumendo che entrambi i giocatori giochino in modo ottimale. Si applica ai giochi deterministici, a somma zero e con informazione perfetta.

Il **valore minimax** di una posizione è l'esito che MAX può garantire contro le risposte migliori di MIN. Per calcolarlo, valuto prima le foglie e poi risalgo l'albero applicando `max` ai nodi MAX e `min` ai nodi MIN.

Algoritmo (ricorsivo):
```python
def value(state):
    if terminal(state): return utility(state)
    if player(state) == MAX: return max_value(state)
    else: return min_value(state)

def max_value(state):
    v = -inf
    for s in successors(state):
        v = max(v, value(s))
    return v

def min_value(state):
    v = +inf
    for s in successors(state):
        v = min(v, value(s))
    return v
```

Equivalentemente:
- $V(s) = \max_{s'} V(s')$ per nodi MAX
- $V(s) = \min_{s'} V(s')$ per nodi MIN

*Teorema:* Minimax è **ottimale contro un giocatore perfetto**. Se l'avversario non è ottimale, minimax non garantisce il massimo guadagno (ma non perde mai contro un razionale).

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022172323.png" width="50%">
</div>
Slide Minimax: mostra la ricorsione max-value/min-value e la struttura dell'albero con valori terminali che risalgono.

> [!warning] Attenzione:
> Minimax richiede di esplorare **tutto l'albero** fino ai terminali. In scacchi $b \approx 35, m \approx 100$ → $O(b^m)$ impraticabile.

> [!example] Minimax Example
> ![[Pasted image 20261022173717.png]]
> Esempio numerico: foglie con valori 3, 12, 8, 2, 4, 6, 14, 5, 2. MIN prende min(3,12,8)=3, min(2,4,6)=2, min(14,5,2)=2; MAX prende max(3,2,2)=3.

## Efficienza Minimax
- Tempo: $O(b^m)$ (come DFS esaustivo)
- Spazio: $O(bm)$ (solo il percorso corrente)

> [!example] Ordini di grandezza
> - Scacchi: $b \approx 35, m \approx 100$
> - Go: $b \approx 250\text{--}300, m \approx 150$
> Soluzione esatta completamente infattibile.

## Alpha-Beta Pruning
Alpha-beta calcola la stessa scelta di minimax, ma può interrompere l'esplorazione di rami che non cambierebbero la decisione alla radice.

**Idea nel nodo MIN:** $\alpha$ è il valore che MAX ha già garantito con un'altra scelta lungo il percorso. Se MIN trova un figlio con valore $\le \alpha$, quel ramo non può battere l'alternativa di MAX: MIN potrebbe ottenere un valore uguale o ancora più basso. Quindi posso potare i figli restanti del nodo.

Simmetricamente, in un nodo MAX posso potare quando il valore raggiunto è almeno $\beta$, cioè l'opzione che MIN ha già a disposizione altrove.

Nel disegno, MAX ha già un'alternativa di valore $\alpha$. Se il nodo MIN trova un figlio che vale al massimo $\alpha$, MAX sceglierà l'alternativa già nota; non serve valutare gli altri figli di MIN.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022181244.png" width="50%">
</div>
Slide Alpha-Beta Pruning: configurazione generale. MAX in alto, MIN al nodo $n$, $\alpha$ è il valore migliore per MAX sul percorso. Se $n \le \alpha$, potiamo i fratelli rimanenti di $n$.

> [!example] Pruning
> ![[Pasted image 20261022180017.png]]
> MAX ha già un'alternativa di valore 3 ($\alpha=3$). In un altro ramo MIN trova un figlio di valore 2. Il valore del nodo MIN sarà quindi $\le 2$; poiché $2 \le 3$, MAX preferirà l'alternativa già nota. I figli restanti di MIN non possono cambiare la scelta e si potano. Il terzo ramo dell'immagine non soddisfa questa condizione e va esplorato.

### Implementazione Alpha-Beta
$\alpha$: miglior opzione di MAX sul percorso alla radice  
$\beta$: miglior opzione di MIN sul percorso alla radice

```python
def max_value(state, α, β):
    v = -∞
    for s in successors(state):
        v = max(v, value(s, α, β))
        if v ≥ β: return v      # β-cutoff
        α = max(α, v)
    return v

def min_value(state, α, β):
    v = +∞
    for s in successors(state):
        v = min(v, value(s, α, β))
        if v ≤ α: return v      # α-cutoff
        β = min(β, v)
    return v
```

Chiamata iniziale: `value(root, -∞, +∞)`.

### Proprietà Alpha-Beta Pruning
- **Correttezza:** il pruning **non cambia** il valore minimax calcolato per la radice.
- **Valori intermedi:** i nodi potati possono avere valori "sbagliati" (non completamente calcolati). *Importante:* i figli della radice potrebbero avere valori errati → la versione naïve non permette action selection diretta (serve completare la ricerca sui figli della radice).
- **Ordinamento dei figli:** un buon ordinamento (provare prima le mosse migliori) massimizza il pruning.
  - Con **ordinamento perfetto**: complessità temporale $O(b^{m/2})$ → **raddoppia la profondità risolvibile**.
  - Anche con ordinamento perfetto, scacchi completa resta irraggiungibile.
- Alpha-beta è un esempio semplice di **metareasoning** (calcolare cosa calcolare).

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022182119.png" width="50%">
</div>
Slide Alpha-Beta Properties: riassume che il valore alla radice non cambia, i nodi intermedi possono avere valori incompleti, l'ordinamento perfetto dimezza l'esponente, e introduce il concetto di metareasoning.

> [!info] Sintesi:
> - Minimax: ricerca esaustiva, ottimale contro avversario perfetto, $O(b^m)$.
> - Alpha-beta: stesso risultato di minimax, pota rami che non influenzano la radice, $O(b^{m/2})$ con ordinamento perfetto.
> - I valori dei nodi potati sono incompleti; per scegliere l'azione alla radice serve completare i figli della radice.
> - L'ordinamento delle mosse (euristiche, killer moves, hash tables) è cruciale per l'efficacia pratica.
