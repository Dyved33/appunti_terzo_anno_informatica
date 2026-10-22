Game playing progress
- **Checkers**: 1950: First computer player. 1994: First computer champion: Chinook ended 40-year-reign of human champion Marion Tinsley using complete 8-piece endgame. 2007: Checkers solved! 
- **Chess**: 1997: Deep Blue defeats human champion Gary Kasparov in a six-game match. Deep Blue examined 200M positions per second, used very sophisticated evaluation and undisclosed methods for extending some lines of search up to 40 ply. Current programs are even better, if less historic. 
- **Go**: AlphaGo defeats human in 2016. Uses Monte Carlo Tree Search and learned evaluation function.
- **Pacman**
- Perché giocare ai giochi? Aiuta a tracciare il progresso nell'IA

![[Pasted image 20261022165937.png]]

Tipi di giochi:
- Deterministici o stocastici
- 1,2 o più giocatori
- Somma zero = se un giocatore vince implica che l'altro perde
- Informazione perfetta = si può vedere tutto lo stato. Informazione parziale = non vedo tutti gli elementi dello stato corrente

Voglio algoritmi che calcolino una strategia che raccomanda una mossa a partire da ogni stato

Giochi deterministici
Ci sono molte possibili formalizzazioni, una è:
- States: S (start a s_0)
- Players: P = {1...N} (di solito hanno dei turni)
- Actions: A (dipendono da chi è il giocatore e dallo stato corrente)
- Transition function: SxA -> S
- Terminal test: S -> {t,f}
- Terminal utilities: SxP -> R. Numero reale, mi dice l'utilità del giocatore in quello stato. Questo valore lo abbiamo in maniera certa solo negli stati finali

Una soluzione per un giocatore è una policy: S -> A (una lista di azioni)

Giochi a somma zero
Gli agenti hanno utilities opposte (valori in outcome). //Manca//

General games
Gli agenti hanno utilities indipendenti. Sono possibili cooperazione, indifferenza, competizione e molto di più.

Single-agent search trees
![[Pasted image 20261022171217.png]]

Value of a state
![[Pasted image 20261022171253.png]]
Per gli stati non terminali calcoliamo come massimo della utility dei figli //non ho capito cosa calcoliamo e che abbiamo negli stati terminali//

Adversial game trees
![[Pasted image 20261022171311.png]]

Minimax values
![[Pasted image 20261022171326.png]]
Se l'agente è razionale vuole minimizzare la utility dell'avversario. Conoscendo tutte le utility so che la più piccola (il minimo) è la mossa peggiore per l'avversario

Tic-tac-toe game tree
![[Pasted image 20261022171346.png]]

Adversial search (minimax)
Giochi deterministici e somma zero:
- Tic-tac-toe, scacchi e dama
- Un giocatore massimizza il risultato
- L'altro minimizza il risultato

Minimax search:
- Uno state-space search tree
- I giocatori alternano i turni
- Calcola per ogni nodo il minimax value: la migliore utility ottenibile contro un avversario razionale (ottimale)

![[Pasted image 20261022172323.png]]
È ottimale contro un giocatore perfetto

Problema: devo calcolare tutti gli stati finali 

Minimax implementation
```python
def value(state): 
	if the state is a terminal state: return the state’s utility 
	if the next agent is MAX: return max-value(state) 
	if the next agent is MIN: return min-value(state)
```

```python
def max-values(state)
	initialize v = -inf
	for each successor of state:
		v = max(v, min-value(successor))
	return v
```

$V(s) = max V(s')$

```python
def min-values(state)
	initialize v = +inf
	for each successor of state:
		v = min(v, max-value(successor))
	return v
```

$V(s) = min V(s')$

> [!example]
> ![[Pasted image 20261022173717.png]]

Minimax efficiency: simile a DFS
- In tempo: $O(B^m)$
- In spazio: $O(bm)$

Con b = branching factor

> [!example]
> For chess, b » 35, m » 100 For Go, b » 250-300, m » 150

Pruning
> [!example]
> ![[Pasted image 20261022180017.png]]
> In questo esempio qualsiasi valore io prenda sarà sempre minore o uguale a 2 che è più piccolo di 3 => posso fare pruning. Nel terzo ramo non posso fare pruning per via dell'ordinamento dei valori

Alpha-beta pruning
General configuration (MIN version)
- Possiamo calcolare il MIN-VALUE a qualche nodo n
- Loopiamo sui figli di n
- La stima dei figli di n sta diminuendo ???
- A chi importa il valore di n? A MAX
- Sia a il miglior valore che MAX può ottenere ad ogni punto di scelta lungo il percorso corrente dalla radice
- Se n diventa peggiore di a, MAX lo eviterà, così possiamo smettere di considerare gli altri figli di n (è già abbastanza cattivo che non verrà giocato)

MAX version è simmetrica

![[Pasted image 20261022181244.png]]

Alpha-Beta Implementation
α: MAX’s best option on path to root 
β: MIN’s best option on path to root

```python
def max-value(state, α, β): 
initialize v = -∞ 
for each successor of state: 
	v = max(v, value(successor, α, β)) 
	if v ≥ β return v 
	α = max(α, v) 
return v
```

```python
def min-value(state , α, β): 
	initialize v = +∞ 
	for each successor of state: 
		v = min(v, value(successor, α, β)) 
		if v ≤ α return v 
		β = min(β, v) 
	return v
```

Proprietà Alpha-Beta Pruning
Questo pruning non ha effetto sul valore di minimax calcolato per la radice. I valori dei nodi intermedi potrebbe essere sbagliato
- Importante: i figli della radice potrebbero avere valori sbagliati
- La versione più naïve non permetterà azioini di selezione

Good child ordering improves effectiveness of pruning

Con l'"ordinamento perfetto":
- Complessità temporale crolla a $O(b^{m/2}$
- Raddoppia la profondità risolvibile
- Full search of, e.g. chess, is still hopeless…

This is a simple example of metareasoning (computing about what to compute)

![[Pasted image 20261022182119.png]]