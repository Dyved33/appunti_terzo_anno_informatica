\# Limite di profondità, funzioni di valutazione e giochi con casualità (expectimax)

## Alpha-beta quiz

> [!example] Primo albero
> ![[Pasted image 20261028163246.png|500]]
> La radice è MAX. Se sceglie `a`, MIN prende $\min(10,8)=8$; se sceglie `d`, MIN prende $\min(4,50)=4$. MAX sceglie `a` e garantisce 8.

> [!example] Potatura nel secondo albero
> ![[Pasted image 20261028163303.png|500]]
> Nel ramo sinistro i nodi MAX valgono $\max(10,6)=10$ e $\max(100,8)=100$; MIN sceglie 10. Alla radice si ha quindi $\alpha=10$. Nel ramo destro, il primo nodo MAX vale $\max(1,2)=2$. MIN può già scegliere 2, perciò il ramo destro vale al massimo 2. Poiché $2 \leq \alpha$, MAX sceglierà il ramo sinistro: le foglie `20` e `4` si possono potare.

## Ricerca con limite di profondità

*Definizione:* la **ricerca a profondità limitata** (*depth-limited search*) interrompe l'esplorazione dell'albero a una profondità prefissata e usa una funzione di valutazione per stimare il valore delle posizioni non terminali raggiunte.

Nei giochi realistici non è possibile espandere l'albero fino agli stati terminali. Si cerca quindi solo fino a una profondità limitata e, al posto delle utilità terminali, si usa una funzione di valutazione per le posizioni non terminali.

Con 100 secondi a disposizione e una velocità di 10.000 nodi al secondo, si possono esplorare un milione di nodi per mossa. Con alpha-beta si arriva circa alla profondità 8, sufficiente per un programma di scacchi decente.

La garanzia di gioco ottimale viene meno. Aumentare il numero di *plies* (mezze mosse) può migliorare molto la qualità del gioco.

**Iterative deepening:** ripete la ricerca con limiti di profondità crescenti e costituisce un algoritmo *anytime*: restituisce sempre una risposta, che può migliorare se è disponibile più tempo. Una variante più robusta mantiene un limite di profondità fisso e, allo scadere del tempo, restituisce la mossa della ricerca più profonda completata.

Se la tabella di trasposizione viene mantenuta fra le iterazioni, quelle successive possono essere più veloci; le valutazioni già calcolate aiutano anche a ordinare meglio le mosse.

![[slide-ia-32-32.png|500]]
*Slide Limiting Depth: la ricerca si ferma a una profondità prefissata e usa una funzione di valutazione al posto delle utilità terminali.*

## Funzioni di valutazione

*Definizione:* una **funzione di valutazione** assegna un punteggio a una posizione non terminale in una ricerca a profondità limitata.

`EVAL(s)` riceve lo stato `s` (la posizione corrente) e ne stima il valore usando caratteristiche ricavate da quella posizione. Si applica alle foglie non terminali dove la ricerca si ferma: non calcola il valore dai figli. I valori stimati vengono poi propagati verso la radice con le regole MAX, MIN o CHANCE.

La funzione ideale restituisce il vero valore minimax della posizione. Nella pratica si usa spesso una somma lineare pesata di feature:

$$EVAL(s) = w_1 \cdot f_1(s) + w_2 \cdot f_2(s) + \dots + w_n \cdot f_n(s)$$

Ogni $f_i$ è una feature della posizione e ogni $w_i$ è il peso che ne indica l'importanza. Per esempio, una feature può essere $f_1(s) = (\text{numero di regine bianche} - \text{numero di regine nere})$, con feature analoghe per gli altri pezzi. I pesi sono normalizzati affinché il valore resti fra la sconfitta (0) e la vittoria (+1).

Le feature descrivono aspetti della posizione (per esempio il materiale o la disposizione dei pezzi); i pesi stabiliscono quanto ciascun aspetto contribuisce alla stima. Feature e pesi dipendono dal gioco e possono essere progettati a mano oppure appresi. La somma pesata di `EVAL(s)` combina quindi caratteristiche dello stato, mentre la media pesata di un nodo CHANCE combina i valori dei possibili esiti secondo le loro probabilità.

Una buona funzione di valutazione deve:
- essere veloce da calcolare, così da lasciare più tempo alla ricerca;
- essere fortemente correlata con le effettive probabilità di vittoria;
- essere applicata a posizioni **quiescenti**, cioè senza una mossa pendente, come una cattura, che farebbe oscillare molto la valutazione.

Le funzioni di valutazione sono sempre imperfette. Più la valutazione è in profondità nell'albero, meno la sua qualità incide sul risultato. Questo mostra il compromesso fra complessità delle feature e costo computazionale.

![[Pasted image 20261028163758.png|30%]]

## Giochi con esiti incerti

L'incertezza serve a modellare eventi casuali del mondo e a costruire algoritmi efficienti basati su campionamento casuale, come *Monte Carlo Tree Search*.

Gli esiti incerti possono dipendere da:
- casualità esplicita, come il lancio di dadi;
- avversari imprevedibili, come i fantasmi che reagiscono a caso;
- azioni che possono fallire, come le ruote di un robot che slittano.

Nella ricerca avversaria (*minimax*) si assume il caso peggiore: l'avversario gioca sempre contro di noi. Con esiti incerti controllati dalla sorte, invece, si considerano i risultati medi.

## Ricerca expectimax

L'**expectimax** calcola il punteggio medio atteso assumendo gioco ottimale nei nodi decisionali. I nodi MAX funzionano come in minimax; nei nodi CHANCE l'esito è incerto e si calcola l'utilità attesa come media pesata dei valori dei figli.

MAX confronta il valore di tutti i suoi figli: se un figlio è un nodo CHANCE, usa il valore atteso già calcolato per quel nodo. In expectimax non ci sono nodi MIN. **Expectiminimax** estende minimax ai giochi con casualità: MAX prende il massimo, MIN il minimo e CHANCE la media pesata dei valori dei figli.

Nel backup dei valori, i nodi CHANCE calcolano la media pesata e i nodi MAX scelgono il massimo. In seguito, i problemi con esiti incerti saranno formalizzati come *Markov Decision Process* (MDP).

![[slide-ia-38-38.png|500]]
*Slide Expectimax Search: i nodi MAX scelgono il massimo, i nodi CHANCE calcolano l'utilità attesa.*

![[Pasted image 20261028164702.png|500]]

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

Per esempio, se gli esiti hanno probabilità $1/2$, $1/3$ e $1/6$ e valori rispettivamente 8, 24 e −12:

$$v = (1/2)(8) + (1/3)(24) + (1/6)(-12) = 10$$

![[slide-ia-40-40.png|500]]
*Slide Expectimax Pseudocode: pseudocodice e calcolo dell'utilità attesa.*

**Esempio:** le foglie hanno valori `3, 12, 9, 2, 4, 6, 15, 6, 0`.

> [!example]
> ![[slide-ia-41-41.png|500]]
> I valori delle foglie vengono mediati nei nodi CHANCE secondo le probabilità, poi propagati ai nodi MAX come massimo.

**Expectimax a profondità limitata:** il valore expectimax vero può richiedere molto lavoro di calcolo. La ricerca a profondità limitata ne fornisce una stima: per esempio, 400 e 300 oppure 492 e 362, a seconda della profondità.

![[Pasted image 20261028224418.png|500]]

## Probabilità dei nodi CHANCE

Expectimax usa un modello probabilistico del comportamento dell'avversario o dell'ambiente in ogni stato. Il modello può essere una distribuzione uniforme, come nel lancio di un dado, oppure sofisticato e costoso da calcolare.

Si introduce un nodo CHANCE per ogni esito fuori dal nostro controllo, dovuto all'avversario o all'ambiente. Il modello può assegnare probabilità elevate anche ad azioni avversarie. Per ora si assume che ogni nodo CHANCE fornisca le probabilità della distribuzione sui suoi esiti.

Una credenza probabilistica sull'azione di un altro agente non implica che quell'agente stia lanciando monete.

**Quiz sulle probabilità informate:** supponiamo che l'avversario esegua minimax a profondità 2, segua il risultato l'80% delle volte e si muova a caso nel restante 20%. Quale ricerca usare?

La risposta è expectimax. Per calcolare le probabilità di ogni nodo CHANCE bisogna simulare l'avversario; il calcolo diventa rapidamente molto lento. È ancora più costoso simulare l'avversario mentre simula noi, tranne nel caso di minimax, che può collassare tutto in un unico albero di gioco.

## Expectiminimax e backgammon

L'**expectiminimax** tratta l'ambiente come un giocatore casuale aggiuntivo, che si muove dopo ogni agente MAX o MIN. Ogni nodo calcola la combinazione appropriata dei valori dei figli.

Nel backgammon i lanci dei dadi aumentano il fattore di diramazione:
- due dadi producono 36 combinazioni, ma solo 21 lanci distinti, perché, per esempio, 6–5 equivale a 5–6;
- i sei doppi, da 1–1 a 6–6, hanno probabilità $1/36$ ciascuno;
- gli altri 15 lanci distinti hanno probabilità $1/18$ ciascuno;
- il backgammon ha di solito circa 20 mosse legali, ma in alcune situazioni può arrivare a 4000, con i doppi.

La complessità dell'expectiminimax è $O(b^m \cdot n^m)$, dove $n$ è il numero di lanci distinti. Nel backgammon $n=21$ e $b \approx 20$. La stima riportata per profondità 2 è $20 \times (21 \times 20)^3 \approx 1{,}2 \times 10^9$.

All'aumentare della profondità, ogni singola sequenza di lanci rappresenta una frazione più piccola delle possibilità complessive: il contributo di una foglia lontana pesa meno sul valore atteso. Per questo il limite di profondità può essere meno dannoso che nei giochi deterministici. Però il numero di nodi cresce rapidamente e il pruning è più difficile: per calcolare una media pesata corretta, in genere bisogna considerare tutti gli esiti casuali.

TDGammon usa una ricerca a profondità 2, una funzione di valutazione molto buona e *reinforcement learning*. Ha raggiunto un livello di gioco mondiale ed è stato il primo campione del mondo di IA in un gioco.

![[slide-ia-46-46.png|500]]
*Slide Example: Backgammon: lanci di dadi, fattore di diramazione, profondità 2 e TDGammon.*

## Utilità per più agenti

Se il gioco non è a somma zero o ha più giocatori, si generalizza minimax:
- gli stati terminali hanno tuple di utilità;
- anche i valori dei nodi sono tuple;
- ogni giocatore massimizza la propria componente;
- possono emergere dinamicamente cooperazione e competizione.

Con tre giocatori, per esempio, `(3, 1, 5)` assegna utilità 3 al primo, 1 al secondo e 5 al terzo per quell'esito. Al proprio turno ciascun giocatore sceglie la mossa che massimizza la propria componente della tupla. I valori delle componenti sono definiti dall'utilità degli esiti per ciascun giocatore.

Esempi di tuple: `(1,6,6)`, `(7,1,2)`, `(6,1,2)`, `(7,2,1)`, `(5,1,7)`, `(1,5,2)`, `(7,7,1)`, `(5,2,5)`.

![[slide-ia-47-47.png|500]]
*Slide Multi-Agent Utilities: tuple di utilità per giochi non a somma zero con più giocatori.*

## Difficoltà della ricerca

Anche con alpha-beta pruning e profondità limitata, un fattore di diramazione grande resta un problema. Nel caso migliore alpha-beta ha complessità temporale $b^{m/2}$:
- negli scacchi, con $b=35$ e profondità 8, $35^{8/2} \approx 1$ milione di nodi; profondità 8 è già buona;
- nel Go, con $b=300$ e profondità 8, $300^{8/2} \approx 8$ miliardi di nodi.

La ricerca a profondità limitata richiede funzioni di valutazione ben progettate. Non è una soluzione generale: serve una nuova funzione per ogni problema, e una funzione sbagliata può rendere la ricerca inefficiente o distorcere i risultati. Una tendenza nell'IA è preferire metodi generali che richiedano meno interventi manuali.

## Implementazione dal libro di testo: expectimax con profondità limitata

Il libro di testo (AIMA, Cap. 17) estende minimax ai giochi con esiti incerti introducendo i nodi **CHANCE**: in un nodo MAX si prende il massimo dei figli come sempre, ma in un nodo CHANCE il valore è la media pesata dei valori dei figli secondo le loro probabilità. Quando la ricerca si ferma a una profondità prefissata, invece dell'utilità terminale si usa una funzione di valutazione EVAL(stato).

```
Expectimax
valore(stato):
    se stato e' terminale: restituisci utilita(stato)
    se il prossimo agente e' MAX: restituisci max-succ(valore)
    se il prossimo agente e' CHANCE: restituisci exp-succ(valore)

exp-succ(stato):
    v = 0
    per ogni successore s con probabilita' p:
        v += p * valore(s)
    restituisci v
```

A profondità limitata le foglie non terminali ricevono EVAL(s), una stima del valore della posizione, e i valori vengono poi propagati verso la radice con max nei nodi MAX e media pesata nei nodi CHANCE. Questo permette di gestire giochi con dadi, carte coperte o avversari imprevedibili, anche se il numero di nodi cresce rapidamente (nell'expectiminimax il fattore di ramificazione si moltiplica per il numero di esiti casuali).

> [!info] Sintesi:
> - A profondità limitata la ricerca si ferma prima del goal e usa una funzione di valutazione EVAL.
> - Una buona EVAL è veloce, correlata con la probabilita' di vittoria e applicata a posizioni quiescenti.
> - Expectimax gestisce l'incertezza con nodi CHANCE che calcolano l'utilita' attesa come media pesata.
> - Expectiminimax combina MAX (massimo), MIN (minimo) e CHANCE (media pesata) nello stesso albero.
> - Il backgammon è il caso classico: i lanci dei dadi moltiplicano il fattore di ramificazione.

