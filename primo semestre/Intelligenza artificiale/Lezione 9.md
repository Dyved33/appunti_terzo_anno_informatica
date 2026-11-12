# Misure di impurità e criteri di split negli alberi di decisione

## Misure di impurità di un nodo

Un nodo $t$ di un albero di decisione contiene un insieme di record. Ogni record appartiene a una delle $n_c$ classi. Una misura di impurità indica quanto i record di un nodo sono "misti" rispetto alle classi: un nodo puro (tutti i record di una stessa classe) ha impurità minima, un nodo con record equamente distribuiti tra tutte le classi ha impurità massima.

Le misure di impurità più usate sono tre: Gini Index, Entropy e misclassification error.

*Definizione:* l'**indice Gini** di un nodo $t$:

$$GINI(t) = 1 - \sum_j [p(j|t)]^2$$

dove $p(j|t)$ è la frequenza relativa della classe $j$ al nodo $t$ = quota di record di classe $j$ tra i record che raggiungono $t$.

- Massimo $(1 - 1/n_c)$ quando i record sono equamente distribuiti tra tutte le classi, implicando la minore informazione
- Minimo $(0.0)$ quando tutti i record appartengono a una sola classe, implicando la maggiore informazione

Per un problema a 2 classi $(p, 1-p)$:

$$GINI = 1 - p^2 - (1-p)^2 = 2p(1-p)$$

<u>Più il nodo è puro, più basso è il suo indice Gini.</u>

Esempi di calcolo su un nodo con 6 record:

- C1 = 0, C2 = 6 → $P(C1) = 0/6 = 0$, $P(C2) = 6/6 = 1$ → $Gini = 1 - 0 - 1 = 0$
- C1 = 1, C2 = 5 → $P(C1) = 1/6$, $P(C2) = 5/6$ → $Gini = 1 - (1/6)^2 - (5/6)^2 = 0.278$
- C1 = 2, C2 = 4 → $P(C1) = 2/6$, $P(C2) = 4/6$ → $Gini = 1 - (2/6)^2 - (4/6)^2 = 0.444$
- C1 = 3, C2 = 3 → $P(C1) = 3/6$, $P(C2) = 3/6$ → $Gini = 1 - (3/6)^2 - (3/6)^2 = 0.500$

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112172320.png" width="500">
</div>

*Definizione:* l'**entropia** di un nodo $t$:

$$Entropy(t) = -\sum_j p(j|t) \log p(j|t)$$

- Massimo $(\log n_c)$ quando i record sono equamente distribuiti tra tutte le classi
- Minimo $(0.0)$ quando tutti i record appartengono a una sola classe
- I calcoli basati sull'entropia sono molto simili a quelli dell'indice GINI

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112174910.png" width="500">
</div>

*Definizione:* l'**errore di misclassificazione** di un nodo $t$:

$$Error(t) = 1 - \max_i P(i|t)$$

- Massimo $(1 - 1/n_c)$ quando i record sono equamente distribuiti
- Minimo $(0)$ quando tutti i record appartengono a una stessa classe

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175151.png" width="500">
</div>

## Trovare il miglior split

Quando un nodo padre $p$ viene diviso in $k$ partizioni (figli), con $n_i$ = numero di record al figlio $i$ e $n$ = numero di record al nodo padre $p$, la procedura è:

1. Calcolare la misura di impurità ($P$) prima dello split
2. Calcolare la misura di impurità ($M$) dopo lo split, cioè l'impurità media pesata dei figli
3. Scegliere la condizione di test sull'attributo che produce il gain più alto $Gain = P - M$, o equivalentemente la minore impurità dopo lo split ($M$)

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112172217.png" width="500">
</div>

## Gini Index per una collezione di nodi

Quando un nodo $p$ viene split in $k$ partizioni (figli):

$$GINI_{split} = \sum_{i=1}^k \frac{n_i}{n} GINI(i)$$

dove $n_i$ = numero di record al figlio $i$, $n$ = numero di record al nodo padre $p$.

Si sceglie l'attributo che minimizza l'indice Gini medio pesato dei figli. L'indice Gini è usato negli algoritmi di alberi di decisione come CART, SLIQ, SPRINT.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112172338.png" width="500">
</div>

### Attributi binari

Lo split divide i record in due partizioni. Si cercano partizioni più grandi e più pure (effetto della ponderazione delle partizioni).

Esempio di calcolo:

- Nodo padre: C1 = 7, C2 = 5 → Gini = 0.486
- Figlio N1: C1 = 5, C2 = 1 → Gini(N1) = 1 - (5/6)² - (1/6)² = 0.278
- Figlio N2: C1 = 1, C2 = 4 → Gini(N2) = 1 - (2/6)² - (4/6)² = 0.444
- Gini medio pesato dei figli = 6/12 × 0.278 + 6/12 × 0.444 = 0.361
- $Gain = 0.486 - 0.361 = 0.125$

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112172430.png" width="500">
</div>

### Attributi categorici

Per ogni valore distinto, si raccolgono i conteggi per ogni classe nel dataset. Si usa la matrice di conteggi per prendere le decisioni.

Si distinguono due tipi di split:
- **Multi-way split:** un ramo per ogni valore distinto dell'attributo
- **Two-way split:** si cerca la miglior partizione dei valori in due gruppi

Esempio con l'attributo CarType (Family, Sports, Luxury):

| Split | C1 | C2 | Gini |
|---|---|---|---|
| Multi-way (Family, Sports, Luxury) | 1, 8, 1 | 3, 0, 7 | 0.163 |
| Two-way {Sports, Luxury} / {Family} | 9, 1 | 7, 3 | 0.468 |
| Two-way {Family, Sports} / {Luxury} | 8, 2 | 0, 10 | 0.167 |

Il miglior split è quello con Gini più basso (0.163, il multi-way).

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112172502.png" width="500">
</div>

### Attributi continui

Si usano decisioni binarie basate su un singolo valore: $(A < v)$ oppure $(A \geq v)$.

- Il numero di possibili valori di split è uguale al numero di valori distinti dell'attributo
- Ogni valore di split ha una matrice di conteggi associata (classi nelle partizioni $A < v$ e $A \geq v$)

**Metodo semplice (inefficiente):** per ogni $v$, scansionare l'intero database per raccogliere la matrice di conteggi e calcolare il suo indice Gini. C'è ripetizione di lavoro.

**Metodo efficiente:** per ogni attributo:
1. Ordinare l'attributo sui valori
2. Scansionare linearmente questi valori, ogni volta aggiornando la matrice di conteggi e calcolando l'indice Gini
3. Scegliere la posizione di split che ha l'indice Gini minore

Esempio con l'attributo Annual Income (valori ordinati da 60 a 220) e le relative posizioni di split (da 55 a 230), con i valori di Gini associati (0.420, 0.400, 0.375, 0.343, 0.417, 0.400, 0.300, 0.343, 0.375, 0.400, 0.420).

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112172530.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112174833.png" width="500">
</div>

## Information Gain

*Definizione:* quando il nodo padre $p$ viene split in $k$ partizioni, con $n_i$ = numero di record nella partizione $i$:

$$GAIN = Entropy(p) - \sum_{i=1}^k \frac{n_i}{n} Entropy(i)$$

Si sceglie lo split che ottiene la riduzione maggiore, cioè massimizza GAIN. L'Information Gain è usato negli algoritmi ID3 e C4.5.

*Nota sotto:* l'Information Gain misura quanta entropia viene "rimossa" dallo split, cioè quanto diventa più puro l'insieme dei figli rispetto al padre.

## Problema con un numero elevato di partizioni

Le misure di impurità dei nodi tendono a preferire split che risultano in un gran numero di partizioni, ciascuna piccola ma pura. Per esempio, l'attributo Customer ID ha l'information gain più alto perché l'entropia per tutti i figli è zero (ogni figlio contiene un solo record, quindi è puro per definizione).

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175042.png" width="500">
</div>

## Gain Ratio

*Definizione:*

$$GainRATIO = \frac{GAIN}{SplitINFO}$$

dove

$$SplitINFO = -\sum_{i=1}^k \frac{n_i}{n} \log \frac{n_i}{n}$$

- Aggiusta l'Information Gain in base all'entropia della partizione (SplitINFO)
- Una partizione ad alta entropia (gran numero di piccole partizioni) viene penalizzata
- Usato nell'algoritmo C4.5
- Progettato per superare lo svantaggio dell'Information Gain

Esempio con l'attributo CarType: SplitINFO = 1.52 per il multi-way, 0.72 e 0.97 per i due-way split.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175114.png" width="500">
</div>

## Confronto tra le misure di impurità

Per un problema a 2 classi, le tre misure (misclassification error, Gini Index, entropy) hanno curve simili ma non identiche: il misclassification error è meno sensibile ai cambiamenti nella distribuzione delle classi rispetto a Gini e entropia.

<div style="display: flex; justify-content: center;">
  <img src="Screenshot From 2026-11-12 17-52-03.png" width="500">
</div>

## Errore di misclassificazione vs indice Gini

Il Gini Index può segnalare un miglioramento (impurità che diminuisce) anche quando l'errore di misclassificazione resta invariato.

Esempio: nodo padre con C1 = 7, C2 = 3 (Gini = 0.42). Dopo lo split su A:
- N1: C1 = 3, C2 = 0 → Gini(N1) = 0
- N2: C1 = 4, C2 = 3 → Gini(N2) = 1 - (4/7)² - (3/7)² = 0.489
- Gini medio pesato dei figli = 3/10 × 0 + 7/10 × 0.489 = 0.342 → Gini migliora
- Ma l'errore di misclassificazione resta 0.3 in tutti e tre i casi!

Nel secondo caso, N2 con C1 = 3, C2 = 2 dà Gini = 0.416, e l'errore di misclassificazione è ancora 0.3.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175442.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175455.png" width="500">
</div>

## Classificazione basata su alberi di decisione

Vantaggi degli alberi di decisione:
- Economici da costruire
- Estremamente veloci nel classificare record sconosciuti
- Facili da interpretare per alberi di dimensioni ridotte
- Robusti al rumore (specialmente quando si usano metodi per evitare l'overfitting)
- Possono gestire facilmente attributi ridondanti o irrilevanti (a meno che gli attributi non interagiscano tra loro)

Svantaggi:
- Lo spazio degli alberi di decisione possibili è esponenzialmente grande. Gli approcci greedy spesso non trovano l'albero migliore.
- Non tengono conto delle interazioni tra attributi
- Ogni confine decisionale coinvolge un solo attributo

## Handling interactions

Quando gli attributi interagiscono, un albero di decisione basato su test a singolo attributo può non riuscire a catturare il pattern. Per esempio, con due attributi X e Y entrambi ad alta entropia, aggiungere un terzo attributo Z rumoroso generato da una distribuzione uniforme può essere scelto per lo split pur non essendo informativo.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175520.png" width="500">
</div>

## Limitazioni dei confini decisionali a singolo attributo

Ogni confine decisionale in un albero di decisione coinvolge un solo attributo. Questo limita la capacità dell'albero di rappresentare confini obliqui o complessi che coinvolgono più attributi contemporaneamente.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175535.png" width="500">
</div>

## Collegamenti

Le basi del machine learning, la classificazione e l'induzione degli alberi di decisione sono state introdotte nella [[Lezione 8-Introduzione al Machine Learning|Lezione 8]].

> [!info] Sintesi:
> - Le tre misure di impurità di un nodo sono Gini Index, Entropy ed errore di misclassificazione; tutte sono massime quando i record sono equamente distribuiti tra le classi e minime quando il nodo è puro.
> - Il miglior split si sceglie massimizzando il gain $Gain = P - M$ (o minimizzando l'impurità media pesata dei figli).
> - L'indice Gini si usa in CART, SLIQ, SPRINT; l'Information Gain in ID3 e C4.5.
> - L'Information Gain tende a favorire attributi con molti valori distinti (es. Customer ID); il Gain Ratio corregge questo difetto penalizzando le partizioni ad alta entropia e si usa in C4.5.
> - Il Gini può segnalare un miglioramento anche quando l'errore di misclassificazione non cambia.
> - Gli alberi di decisione sono veloci e interpretabili, ma ogni confine coinvolge un solo attributo e non catturano le interazioni tra attributi.
