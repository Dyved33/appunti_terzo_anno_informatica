# Game Playing, Minimax e Alpha-Beta Pruning

## Game Playing Progress
Milestones storici:
- **Checkers**: 1950 primo giocatore automatico; 1994 Chinook batte il campione umano Marion Tinsley (database 8 pezzi endgame); 2007 dama risolta.
- **Chess**: 1997 Deep Blue batte Kasparov (200M posizioni/sec, estensioni di ricerca fino a 40 ply).
- **Go**: 2016 AlphaGo batte campione umano (Monte Carlo Tree Search + funzione di valutazione appresa).
- **Pacman**: ambiente didattico multi-agente.

*Osservazione:* i giochi servono come benchmark per tracciare il progresso nell'IA.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022165937.png" width="300">
</div>

> [!info] In altre parole:
> La complessità dei giochi (branching factor, profondità) costringe a sviluppare ricerca, euristiche e apprendimento che poi si trasferiscono ad altri domini.

## Tipi di giochi
Assi di classificazione:
- **Deterministici / Stocastici** — presenza di casualità (dadi, carte coperte).
- **Numero di giocatori** — 1, 2, o più.
- **Somma zero / Somma non zero** — in somma zero l'utilità di un giocatore è l'opposto dell'altro (competizione pura); in somma non zero utilità indipendenti (cooperazione, indifferenza, competizione mista).
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

## Alberi di ricerca single-agent vs adversarial
*Single-agent:* il valore di uno stato non terminale è il massimo delle utility dei figli (l'agente sceglie la mossa migliore).
*Adversarial:* i nodi si alternano tra **MAX** (il nostro agente, massimizza) e **MIN** (l'avversario, minimizza). Il valore di un nodo MAX è il massimo dei valori dei figli; il valore di un nodo MIN è il minimo.

### Single-Agent Search Trees
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022171217.png" width="300">
</div>
Albero di ricerca single-agent: dalla radice (stato iniziale) si generano i successori; i valori alle foglie terminali (es. 8, 2, 0, 2, 6, 4, 6) risalgono verso l'alto prendendo il massimo a ogni livello.

### Value of a State
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022171253.png" width="300">
</div>
Valore di uno stato = miglior outcome raggiungibile da quello stato. Negli stati terminali l'utilità è data; negli stati non terminali si calcola come massimo (per MAX) o minimo (per MIN) dei valori dei figli.

### Adversarial Game Trees
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022171311.png" width="300">
</div>
Albero adversarial: i nodi alternano MAX e MIN. I valori alle foglie (es. -20, -8, -18, -5, -10, +4, -20, +8) risalgono: MIN prende il minimo, MAX prende il massimo dei minimi.

### Minimax Values
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022171326.png" width="300">
</div>
Valori minimax: nei nodi MAX (cerchi) si propaga il massimo dei figli; nei nodi MIN (quadrati) il minimo. La radice MAX sceglie il ramo che massimizza il valore minimo che l'avversario può imporre.

### Tic-Tac-Toe Game Tree
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022171346.png" width="300">
</div>
Albero del gioco del tris (tic-tac-toe): mostra l'esplosione combinatoria anche in un gioco semplice. Minimax esplora tutto l'albero per trovare la mossa ottimale.

## Minimax
**Definizione:** Per giochi deterministici a somma zero con informazione perfetta. I giocatori alternano i turni. Il **minimax value** di un nodo è la migliore utility ottenibile contro un avversario razionale (ottimale).

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
  <img src="Pasted image 20261022172323.png" width="300">
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
**Idea:** durante la ricerca minimax, se un nodo MIN ha già un figlio con valore $\le \alpha$ (dove $\alpha$ è la migliore opzione di MAX sul percorso alla radice), MAX eviterà quel nodo → possiamo **potare** i figli rimanenti. Simmetricamente per nodi MAX con $\beta$ (migliore opzione di MIN).

*Configurazione generale (versione MIN):*
- Stiamo calcolando MIN-VALUE al nodo $n$
- Loopiamo sui figli di $n$
- L'estimo del minimo dei figli sta scendendo
- Chi usa il valore di $n$? MAX (il padre)
- Sia $\alpha$ il miglior valore che MAX può ottenere lungo il percorso corrente dalla radice
- Se $n \le \alpha$, MAX lo evita → stop (pruning)

La versione MAX è simmetrica con $\beta$.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261022181244.png" width="300">
</div>
Slide Alpha-Beta Pruning: configurazione generale. MAX in alto, MIN al nodo $n$, $\alpha$ è il valore migliore per MAX sul percorso. Se $n \le \alpha$, potiamo i fratelli rimanenti di $n$.

> [!example] Pruning
> ![[Pasted image 20261022180017.png]]
> Esempio: MAX ha già un'alternativa con valore 3 ($\alpha=3$). MIN esplora un figlio che vale 2 → $2 \le 3$, quindi MAX eviterà questo nodo MIN. Possiamo fermarci e potare i fratelli rimanenti (non servono, il valore di questo MIN è già $\le 2$). Nel terzo ramo non si pota per l'ordinamento dei valori.

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
  <img src="Pasted image 20261022182119.png" width="300">
</div>
Slide Alpha-Beta Properties: riassume che il valore alla radice non cambia, i nodi intermedi possono avere valori incompleti, l'ordinamento perfetto dimezza l'esponente, e introduce il concetto di metareasoning.

> [!info] Sintesi:
> - Minimax: ricerca esaustiva, ottimale contro avversario perfetto, $O(b^m)$.
> - Alpha-beta: stesso risultato di minimax, pota rami che non influenzano la radice, $O(b^{m/2})$ con ordinamento perfetto.
> - I valori dei nodi potati sono incompleti; per scegliere l'azione alla radice serve completare i figli della radice.
> - L'ordinamento delle mosse (euristiche, killer moves, hash tables) è cruciale per l'efficacia pratica.