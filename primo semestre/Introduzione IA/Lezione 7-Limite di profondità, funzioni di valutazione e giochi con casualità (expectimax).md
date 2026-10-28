# Limite di profondità, funzioni di valutazione e giochi con casualità (expectimax)

## Alpha-Beta Quiz

Le slide 29-30 propongono due quiz sull'alpha-beta pruning. Il testo delle slide è solo il titolo; il contenuto è nelle immagini allegate.

> [!example] Alpha-Beta Quiz 1
> ![[Pasted image 20261028163246.png|30%]]

> [!example] Alpha-Beta Quiz 2
> ![[Pasted image 20261028163303.png|30%]]

> [!todo] Verificare il contenuto dei due quiz Alpha-Beta: le immagini non restituiscono testo via OCR, leggere a mano dal PDF. Spostare le 4 immagini `Pasted image 20261028163246.png`, `20261028163303.png`, `20261028163758.png`, `20261028164702.png` dalla radice di `primo semestre/` in `images/` perché i link funzionino.

## Limite di profondità: depth-limited search

*Definizione:* il **depth-limited search** è una variante della ricerca su albero di gioco in cui, invece di espandere fino alle foglie terminali, ci si ferma a una profondità prefissa e si sostituiscono le utilità terminali con una funzione di valutazione per le posizioni non terminali.

- Problema: nei giochi realistici non si possono ricercare le foglie.
- Soluzione: cercare solo fino a una profondità limitata nell'albero; al posto delle utilità terminali si usa una funzione di valutazione per le posizioni non terminali.

Esempio pratico: si hanno 100 secondi a disposizione e si possono esplorare 10.000 nodi al secondo, quindi 1 milione di nodi per mossa. Con alpha-beta si arriva a circa la profondità 8, sufficiente per un programma di scacchi decente.

La garanzia di gioco ottimale viene meno. Aumentare il numero di plies fa una grande differenza sulla qualità del gioco.

Si usa l'**iterative deepening** per ottenere un algoritmo *anytime*, che restituisce sempre una risposta e può migliorarla se ha più tempo. Una variante più robusta è tenere un limite di profondità fisso e, quando il tempo scade, restituire la mossa trovata nella ricerca più profonda completata; se si mantiene una tabella di transposizione tra i giri, i giri successivi sono più veloci e le valutazioni aiutano a ordinare meglio le mosse.

![[slide-ia-32-32.png|30%]]
*Slide Limiting Depth: depth-limited search con funzione di valutazione al posto delle utilità terminali.*

> [!todo] Verificare che l'immagine slide-ia-32-32.png corrisponda alla slide 32 (Limiting Depth).

## Funzioni di valutazione

*Definizione:* una **funzione di valutazione** assegna un punteggio a una posizione non terminale in una ricerca depth-limited.

- Funzione ideale: restituisce il vero valore minimax della posizione.
- Nella pratica: tipicamente una **funzione lineare pesata di feature**:

  $$EVAL(s) = w_1 \cdot f_1(s) + w_2 \cdot f_2(s) + \dots + w_n \cdot f_n(s)$$

  dove ogni $f_i$ è una feature della posizione (es. "numero di bianchi regine") e ogni $w_i$ è un peso (quanto conta quella feature). I pesi sono normalizzati così che il valore stia sempre tra la sconfitta (0) e la vittoria (+1).

- Esempio di feature: `f1(s) = (num white queens – num black queens)`, e analogamente per altre piece.

Requisiti di una buona funzione di valutazione:

1. Deve essere veloce da calcolare (tutto il punto è cercare più in fretta).
2. Deve essere fortemente correlata con le probabilità effettive di vincita.
3. Va applicata solo a posizioni **quiescenti**, cioè posizioni in cui non c'è una mossa pendente (come una cattura) che farebbe oscillare selvaggiamente la valutazione.

Le funzioni di valutazione sono sempre imperfette. Più in profondità nell'albero la funzione di valutazione è "sepolta", minore è la qualità della funzione di valutazione che conta.

Esempio importante del tradeoff tra complessità delle feature e complessità computazionale.

> [!info] In altre parole:
> La funzione di valutazione stima l'utilità attesa di uno stato: per gli stati terminali coincide con l'utilità vera, per gli stati non terminali restituisce un valore compreso tra sconfitta e vittoria.



![[Pasted image 20261028163758.png|30%]]

> [!todo] Verificare a quale slide corrisponde l'immagine già incollata `Pasted image 20261028163758.png`.

## Giochi con esiti incerti: expectimax

**Perché l'incertezza:**

Perché ci interessiamo a incertezza e randomicità?

- Vogliamo modellare eventi randomici che accadono nel mondo.
- Costruire algoritmi efficienti con sampling random (es. Monte Carlo Tree Search).

Idea: esiti incerti sono controllati dalla fortuna, non da un avversario.

**Worst-case vs average-case:**

Nella ricerca adversarial (minimax) si assume il peggiore caso: l'avversario gioca sempre contro di noi. Con esiti incerti, invece, gli esiti sono mediati: si calcola l'utilità attesa, non il peggiore caso.

![[slide-ia-37-37.png|30%]]
*Slide Worst-Case vs Average Case: confronto tra minimax (peggiore caso) e expectimax (caso medio).*

> [!todo] Verificare che slide-ia-37-37.png corrisponda alla slide 37.

**Expectimax search:**

L'**expectimax search** calcola il punteggio medio sotto gioco ottimale, invece del peggiore caso.

- I nodi MAX funzionano come in minimax.
- I nodi CHANCE sono come i nodi MIN, ma l'esito è incerto: si calcola l'utilità attesa, cioè la media pesata (expectation) dei valori dei figli, ponderata per le probabilità.
- Il backup dei valori risale dalle foglie: **media nei nodi CHANCE**, **massimo nei nodi decisionali (MAX)**.
- In seguito si formalizzano questi problemi come *Markov Decision Process* (MDP).

![[slide-ia-38-38.png|30%]]
*Slide Expectimax Search: nodi MAX come minimax, nodi CHANCE come media pesata dei figli.*

> [!todo] Verificare che slide-ia-38-38.png corrisponda alla slide 38.

![[Pasted image 20261028164702.png|30%]]

> [!todo] Verificare a quale slide corrisponde l'immagine già incollata `Pasted image 20261028164702.png` (era associata al placeholder `//slide 38//`).

**Pseudocodice expectimax:**

```python
def value(state):
    if the state is a terminal state: return the state's utility
    if the next agent is MAX: return max-value(state)
    if the next agent is EXP: return exp-value(state)

def max-value(state):
    v = -∞
    for each successor of state:
        v = max(v, value(successor))
    return v

def exp-value(state):
    v = 0
    for each successor of state:
        p = probability(successor)
        v += p * value(successor)
    return v
```

Esempio numerico:

`v = (1/2)(8) + (1/3)(24) + (1/6)(-12) = 10`

![[slide-ia-40-40.png|30%]]
*Slide Expectimax Pseudocode: definizione di value, max-value, exp-value e esempio con probabilità 1/2, 1/3, 1/6.*

> [!todo] Verificare che slide-ia-40-40.png corrisponda alla slide 40.

**Esempio expectimax:**

Foglie: `3 12 9 2 4 6 15 6 0`

> [!example] Expectimax Example
> ![[slide-ia-41-41.png|30%]]
> Svolgimento: i valori delle foglie vengono mediati nei nodi CHANCE secondo le loro probabilità, poi propagati ai nodi MAX come massimo.

> [!todo] Verificare che slide-ia-41-41.png corrisponda alla slide 41 (Expectimax Example).

**Depth-limited expectimax:**

Con profondità limitata, il valore vero dell'expectimax richiede molto lavoro da calcolare. Si ha quindi una stima del valore vero: ad esempio 400 e 300, oppure 492 e 362, a seconda della profondità.

![[slide-ia-42-42.png|30%] ] *(immagine non estratta, slide 42)*

**Quali probabilità usare:**

Nell'expectimax search si ha un modello probabilistico di come si comporterà l'avversario (o l'ambiente) in ogni stato:

- Il modello può essere una distribuzione uniforme (es. lancio di un dado).
- Il modello può essere sofisticato e richiedere molto calcolo.
- Si ha un chance node per ogni esito fuori dal nostro controllo: avversario o ambiente.
- Il modello potrebbe dire che le azioni avversarie sono probabili!

Per ora, si assume che ogni chance node arrivi "magicamente" con le probabilità che specificano la distribuzione sui suoi esiti.

Avere una credenza probabilistica sull'azione di un altro agente non significa che l'agente stia lanciando monete.

**Quiz: probabilità informate:**

Si sa che l'avversario esegue effettivamente un minimax di profondità 2, usando il risultato l'80% delle volte, e si muove a caso altrimenti.

**Domanda:** quale tree search si deve usare?

**Risposta:** Expectimax. Per calcolare le probabilità di ogni chance node bisogna simulare l'avversario. Questo diventa molto lento molto in fretta. Ancora peggio se si deve simulare l'avversario che simula noi… tranne che per minimax, che ha la proprietà di collassare tutto in un unico albero di gioco.

## Mixed layer types e backgammon

Esempio: **Backgammon**.

L'**expectiminimax** tratta l'ambiente come un giocatore "random" extra che si muove dopo ogni agente min/max. Ogni nodo calcola la combinazione appropriata dei suoi figli.

- I lanci di dadi aumentano il branching factor: con 2 dadi ci sono 36 combinazioni ma solo 21 lanci distinti (6–5 equivale a 5–6). I sei doppi (1–1 attraverso 6–6) hanno probabilità 1/36 ciascuno; gli altri 15 lanci distinti hanno probabilità 1/18 ciascuno.
- Backgammon ha di solito circa 20 mosse legali, ma in alcune situazioni può arrivare a 4000 (per i doppi).
- Complessità dell'expectiminimax: $O(b^m \cdot n^m)$ dove $n$ è il numero di lanci distinti. In backgammon $n=21$ e $b \approx 20$.
- Profondità 2 = 20 × (21 × 20)³ ≈ 1,2 × 10⁹.
- All'aumentare della profondità, la probabilità di raggiungere un dato nodo di ricerca si restringe. Quindi l'utilità della ricerca diminuisce: limitare la profondità è meno dannoso, ma il pruning è più difficile.

Storico dell'IA: TDGammon usa depth-2 search + funzione di valutazione molto buona + reinforcement learning: gioco di livello mondiale. Primo campione del mondo di IA in un gioco.

![[slide-ia-46-46.png|30%]]
*Slide Example: Backgammon: lanci di dadi, branching factor, profondità 2, TDGammon.*

> [!todo] Verificare che slide-ia-46-46.png corrisponda alla slide 46.

## Multi-agent utilities

Cosa succede se il gioco non è a somma zero, o ha più giocatori?

Generalizzazione del minimax:

- I terminali hanno tuple di utilità.
- I valori dei nodi sono anch'essi tuple di utilità.
- Ogni giocatore massimizza la propria componente.
- Possono nascere cooperazione e competizione dinamicamente.

Esempio di tuple: `1,6,6 7,1,2 6,1,2 7,2,1 5,1,7 1,5,2 7,7,1 5,2,5`

![[slide-ia-47-47.png|30%]]
*Slide Multi-Agent Utilities: tuple di utilità per giochi non somma zero con più giocatori.*

> [!todo] Verificare che slide-ia-47-47.png corrisponda alla slide 47.

## Difficoltà della ricerca fin qui

Anche con alpha-beta pruning e profondità limitata, un branching factor grande resta un problema (ricordare la complessità temporale nel migliore caso `b^(m/2)`):

- Possibile per scacchi: con alpha-beta, 35^(8/2) ≈ 1 milione; profondità 8 è già buona.
- Difficile per Go: 300^(8/2) ≈ 8 miliardi.

Limitare la profondità richiede di progettare buone funzioni di valutazione:

- Non è una soluzione generale: serve una nuova funzione di valutazione per ogni nuovo problema.
- Una funzione di valutazione sbagliata può rendere le soluzioni inefficienti o distorte.
- Il trend nell'IA è preferire metodi generali e meno tweaking umano.

> [!info] Sintesi:
> - Depth-limited search: si ferma a una profondità prefissa e usa una funzione di valutazione al posto delle utilità terminali; perde la garanzia di ottimalità, iterative deepening dà un algoritmo anytime.
> - Funzioni di valutazione: somma pesata di feature, sempre imperfette, più contano in profondità bassa.
> - Expectimax: nodi MAX come minimax, nodi CHANCE come media pesata dei figli per esiti incerti controllati dalla fortuna.
> - Backgammon / expectiminimax: agente casuale extra, branching factor alto, TDGammon primo campione del mondo IA.
> - Multi-agent utilities: tuple di utilità, ogni giocatore massimizza la propria componente, cooperazione e competizione dinamica.
