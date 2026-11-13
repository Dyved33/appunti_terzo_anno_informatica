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

Il grafico illustra l'andamento dell'indice Gini al variare della distribuzione delle classi: raggiunge il massimo quando i record sono equamente distribuiti tra tutte le classi (massima incertezza, minima informazione) e scende a zero quando il nodo è puro, cioè tutti i record appartengono a una sola classe.

*Definizione:* l'**entropia** di un nodo $t$:

$$Entropy(t) = -\sum_j p(j|t) \log p(j|t)$$

- Massimo $(\log n_c)$ quando i record sono equamente distribuiti tra tutte le classi
- Minimo $(0.0)$ quando tutti i record appartengono a una sola classe
- I calcoli basati sull'entropia sono molto simili a quelli dell'indice GINI

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112174910.png" width="500">
</div>

Gli esempi mostrano l'entropia per un nodo con 6 record: con 0 record di C1 l'entropia è 0 (nodo puro), con 1 record di C1 su 6 è circa 0.65, con 2 record di C1 su 6 è circa 0.92. L'entropia segue lo stesso andamento del Gini: minima a 0 per il nodo puro, massima per la distribuzione uniforme.

*Definizione:* l'**errore di misclassificazione** di un nodo $t$:

$$Error(t) = 1 - \max_i P(i|t)$$

- Massimo $(1 - 1/n_c)$ quando i record sono equamente distribuiti
- Minimo $(0)$ quando tutti i record appartengono a una stessa classe

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175151.png" width="500">
</div>

Gli esempi mostrano l'errore di misclassificazione per un nodo con 6 record: 0 quando tutti i record sono di una classe, 1/6 con 1 record di C1 e 1/3 con 2 record di C1. È la misura meno sensibile ai cambiamenti nella distribuzione delle classi.

## Trovare il miglior split

Quando un nodo padre $p$ viene diviso in $k$ partizioni (figli), con $n_i$ = numero di record al figlio $i$ e $n$ = numero di record al nodo padre $p$, la procedura è:

1. Calcolare la misura di impurità ($P$) prima dello split
2. Calcolare la misura di impurità ($M$) dopo lo split, cioè l'impurità media pesata dei figli
3. Scegliere la condizione di test sull'attributo che produce il gain più alto $Gain = P - M$, o equivalentemente la minore impurità dopo lo split ($M$)

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112172217.png" width="500">
</div>

Lo schema mostra il nodo padre diviso in partizioni figlie: si calcola l'impurità prima dello split ($P$) e dopo ($M$, impurità media pesata dei figli); lo split migliore è quello con il gain più alto, $Gain = P - M$.

## Gini index per una collezione di nodi

Quando un nodo $p$ viene split in $k$ partizioni (figli):

$$GINI_{split} = \sum_{i=1}^k \frac{n_i}{n} GINI(i)$$

dove $n_i$ = numero di record al figlio $i$, $n$ = numero di record al nodo padre $p$.

Si sceglie l'attributo che minimizza l'indice Gini medio pesato dei figli. L'indice Gini è usato negli algoritmi di alberi di decisione come CART, SLIQ, SPRINT.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112172338.png" width="500">
</div>

Tabella che riepiloga i calcoli di Gini su un nodo con 6 record: da 0 (nodo puro, 0 e 6 record) a 0.500 (distribuzione 3-3, massimo per due classi).

*Attributi binari:* Lo split divide i record in due partizioni. Si cercano partizioni più grandi e più pure (effetto della ponderazione delle partizioni).

Esempio di calcolo:

- Nodo padre: C1 = 7, C2 = 5 → Gini = 0.486
- Figlio N1: C1 = 5, C2 = 1 → Gini(N1) = 1 - (5/6)² - (1/6)² = 0.278
- Figlio N2: C1 = 2, C2 = 4 → Gini(N2) = 1 - (2/6)² - (4/6)² = 0.444
- Gini medio pesato dei figli = 6/12 × 0.278 + 6/12 × 0.444 = 0.361
- $Gain = 0.486 - 0.361 = 0.125$

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112172430.png" width="500">
</div>

Esempio numerico: il nodo padre con 7 record di C1 e 5 di C2 ha Gini 0.486. Dopo lo split i figli hanno Gini 0.278 e 0.444; il Gini medio pesato è $6/12 \times 0.278 + 6/12 \times 0.444 = 0.361$, quindi $Gain = 0.486 - 0.361 = 0.125$.

*Attributi categorici:* Per ogni valore distinto, si raccolgono i conteggi per ogni classe nel dataset. Si usa la matrice di conteggi per prendere le decisioni.

Si distinguono due tipi di split:
- *Multi-way split:* un ramo per ogni valore distinto dell'attributo
- *Two-way split:* si cerca la miglior partizione dei valori in due gruppi

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

Esempio con l'attributo categorico CarType (Family, Sports, Luxury): il multi-way split dà Gini 0.163 (il migliore), mentre i due-way split danno 0.468 e 0.167.

*Attributi continui:* Si usano decisioni binarie basate su un singolo valore: $(A < v)$ oppure $(A \geq v)$.

- Il numero di possibili valori di split è uguale al numero di valori distinti dell'attributo
- Ogni valore di split ha una matrice di conteggi associata (classi nelle partizioni $A < v$ e $A \geq v$)

*Metodo semplice (inefficiente):* per ogni $v$, scansionare l'intero database per raccogliere la matrice di conteggi e calcolare il suo indice Gini. C'è ripetizione di lavoro.

*Metodo efficiente:* per ogni attributo:
1. Ordinare l'attributo sui valori
2. Scansionare linearmente questi valori, ogni volta aggiornando la matrice di conteggi e calcolando l'indice Gini
3. Scegliere la posizione di split che ha l'indice Gini minore

Esempio con l'attributo Annual Income (valori ordinati da 60 a 220) e le relative posizioni di split (da 55 a 230), con i valori di Gini associati (0.420, 0.400, 0.375, 0.343, 0.417, 0.400, 0.300, 0.343, 0.375, 0.400, 0.420).

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112172530.png" width="500">
</div>

Per attributi continuativi si prova ogni valore di split possibile (uno per valore distinto dell'attributo), costruendo via via la matrice di conteggi delle classi nelle due partizioni $A < v$ e $A \ge v$.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112174833.png" width="500">
</div>

Esempio sull'attributo Annual Income: ordinando i valori e scansionandoli linearmente si aggiorna la matrice di conteggi e si calcola il Gini per ogni posizione di split, scegliendo quella con Gini minore.

*Discretizzazione degli attributi continui:* in alternativa agli split binari $A < v$ / $A \geq v$, un attributo continuo può essere discretizzato prima o durante l'apprendimento. La discretizzazione statica divide il dominio dell'attributo in intervalli (per esempio di uguale ampiezza, di uguale frequenza o tramite clustering) prima di costruire l'albero; la discretizzazione dinamica sceglie i punti di taglio durante la costruzione dell'albero, ad esempio in base all'impurità delle partizioni risultanti.

## Information gain

*Definizione:* quando il nodo padre $p$ viene split in $k$ partizioni, con $n_i$ = numero di record nella partizione $i$:

$$GAIN = Entropy(p) - \sum_{i=1}^k \frac{n_i}{n} Entropy(i)$$

Si sceglie lo split che ottiene la riduzione maggiore, cioè massimizza GAIN. L'Information Gain è usato negli algoritmi ID3 e C4.5.

*Nota sotto:* l'Information Gain misura quanta entropia viene "rimossa" dallo split, cioè quanto diventa più puro l'insieme dei figli rispetto al padre.

## Problema con un numero elevato di partizioni

Le misure di impurità dei nodi tendono a preferire split che risultano in un gran numero di partizioni, ciascuna piccola ma pura. Per esempio, l'attributo Customer ID ha l'information gain più alto perché l'entropia per tutti i figli è zero (ogni figlio contiene un solo record, quindi è puro per definizione).

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175042.png" width="500">
</div>

L'Information Gain tende a premiare attributi con molti valori distinti (es. Customer ID): ogni figlio contenente un singolo record è puro per definizione, quindi l'entropia dei figli è zero e il gain è massimo.

## Gain ratio

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

Il Gain Ratio divide l'Information Gain per lo SplitINFO, l'entropia della partizione: così le partizioni ad alta entropia (molti gruppi piccoli) vengono penalizzate. Per CarType, SplitINFO è 1.52 per il multi-way e 0.72 / 0.97 per i due-way split.

## Confronto tra le misure di impurità

Per un problema a 2 classi, le tre misure (misclassification error, Gini Index, entropy) hanno curve simili ma non identiche: il misclassification error è meno sensibile ai cambiamenti nella distribuzione delle classi rispetto a Gini e entropia.

<div style="display: flex; justify-content: center;">
  <img src="Screenshot From 2026-11-12 17-52-03.png" width="500">
</div>

Per un problema a due classi, le tre misure (errore di misclassificazione, Gini e entropia) tracciano curve simili ma non identiche: l'errore di misclassificazione è meno sensibile ai cambiamenti nella distribuzione delle classi rispetto a Gini ed entropia.

## Errore di misclassificazione vs indice Gini

Il Gini Index può segnalare un miglioramento (impurità che diminuisce) anche quando l'errore di misclassificazione resta invariato.

Esempio: nodo padre con C1 = 7, C2 = 3 (Gini = 0.42). Dopo lo split su A:
- N1: C1 = 3, C2 = 0 → Gini(N1) = 0
- N2: C1 = 4, C2 = 3 → Gini(N2) = 1 - (4/7)² - (3/7)² = 0.489
- Gini medio pesato dei figli = 3/10 × 0 + 7/10 × 0.489 = 0.342 → Gini migliora
- Ma l'errore di misclassificazione resta 0.3 in tutti e tre i casi!

Nel secondo caso, il Gini medio pesato dello split è 0.416, e l'errore di misclassificazione è ancora 0.3.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175442.png" width="500">
</div>

Esempio in cui il Gini segnala un miglioramento (l'impurità scende da 0.42 a 0.342) ma l'errore di misclassificazione resta invariato a 0.3.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175455.png" width="500">
</div>

Nell'esempio, il Gini medio pesato dello split è 0.416, ma l'errore di misclassificazione resta 0.3 in tutti e tre i casi (padre, N1 e N2).

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

Con attributi X e Y ad alta entropia, aggiungere un terzo attributo Z rumoroso (distribuzione uniforme) può essere scelto per lo split pur non essendo informativo: l'albero non riesce a catturare l'interazione tra attributi.

## Limitazioni dei confini decisionali a singolo attributo

Ogni confine decisionale in un albero di decisione coinvolge un solo attributo. Questo limita la capacità dell'albero di rappresentare confini obliqui o complessi che coinvolgono più attributi contemporaneamente.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261112175535.png" width="500">
</div>

Le classi positive e negative sono generate da gaussiani inclinate con centri in (8, 8) e (12, 12): un confine obliquo ottimale non è rappresentabile da un albero di decisione, i cui test coinvolgono un singolo attributo alla volta e producono confini axis-aligned (rettangolari).

## Collegamenti

Le basi del machine learning, la classificazione e l'induzione degli alberi di decisione sono state introdotte nella [[Lezione 8-Introduzione al Machine Learning|Lezione 8]].

## Approfondimento: alberi di decisione dal libro di testo

Un albero di decisione è una rappresentazione di una funzione che mappa un vettore di valori di attributo a un singolo valore di output, la "decisione". L'albero raggiunge la decisione eseguendo una sequenza di test, partendo dalla radice e seguendo il ramo appropriato fino a una foglia. Ogni nodo interno corrisponde a un test sul valore di uno degli attributi di input, i rami che escono dal nodo sono etichettati con i possibili valori dell'attributo, e i nodi foglia specificano il valore restituito dalla funzione.

Gli alberi di decisione possono gestire input discreti o continui e output discreti. Un albero booleano è equivalente a un'affermazione logica della forma Output <=> (Path1 v Path2 v ...), dove ogni Path è una congiunzione di test attributo-valore corrispondenti a un percorso dalla radice a una foglia vera. L'espressione è quindi in forma disgiuntiva, il che significa che qualsiasi funzione della logica proposizionale può essere espressa come albero di decisione. Tuttavia, alcune funzioni non possono essere rappresentate in modo compatto: ad esempio, la funzione maggioranza (vero se e solo se più della metà degli input è vera) e la parità (vero se e solo se un numero pari di attributi è vero) richiedono alberi esponenzialmente grandi. Con attributi a valori reali, la funzione y > A*x + B è difficile da rappresentare perché il confine decisionale è una retta diagonale, mentre tutti i test dell'albero dividono lo spazio in box rettangolari allineati agli assi; servirebbe impilare molti box per approssimare la retta. In altre parole, gli alberi di decisione sono adatti ad alcuni tipi di funzioni e inadatti ad altri.

L'apprendimento di un albero di decisione dagli esempi adotta una strategia greedy divide-and-conquer: si testa per primo l'attributo più importante, poi si risolve ricorsivamente i sottoproblemi più piccoli definiti dai possibili risultati del test. L'attributo "più importante" è quello che fa più differenza nella classificazione di un esempio, in modo da arrivare alla classe corretta con un numero ridotto di test, ottenendo percorsi brevi e un albero poco profondo. Durante la ricorsione si presentano quattro casi. Se gli esempi rimanenti sono tutti positivi (o tutti negativi), si è terminati e si restituisce la foglia corrispondente. Se ci sono sia positivi che negativi, si sceglie il miglior attributo per dividerli. Se non rimangono esempi, significa che nessun esempio è stato osservato per quella combinazione di valori di attributo, e si restituisce il valore di output più comune tra gli esempi usati per costruire il nodo genitore. Se non rimangono attributi ma ci sono sia positivi che negativi, gli esempi hanno esattamente la stessa descrizione ma classifiche diverse: può essere per rumore nei dati, perché il dominio è non-deterministico o perché non si osserva un attributo che li distinguerebbe; la soluzione migliore è restituire il valore di output più comune tra gli esempi rimanenti.

Per scegliere i test sugli attributi si misura l'importanza di ciascun attributo tramite l'information gain, definito in termini di entropia, la quantità fondamentale dell'informazione teorica. L'entropia di una variabile casuale V con valori vk e probabilità P(vk) è H(V) = -Σ P(vk) log P(vk). Essa misura l'incertezza della variabile: più informazione c'è, meno entropia c'è. Una moneta che esce sempre testa ha entropia zero; una moneta equa ha entropia 1 bit; un dado a quattro facce equo ha 2 bit. Nel contesto degli alberi, se l'insieme di addestramento contiene p esempi positivi e n negativi, l'entropia dell'output sull'intero insieme è H(Output) = B(p/(p+n)), dove B(q) è l'entropia di una variabile booleana vera con probabilità q. Un attributo A con d valori distinti divide l'insieme di addestramento E in sottoinsiemi E1 ... Ed; l'entropia attesa residua dopo aver testato A è Remainder(A) = Σ (|Ek|/|E|) B(pk/(pk+nk)), dove pk e nk sono gli esempi positivi e negativi in Ek. L'information gain dell'attributo A è la riduzione attesa di entropia: Gain(A) = H(Output) - Remainder(A). L'attributo con l'information gain massimo viene scelto come radice dell'albero; per esempio, sull'insieme di addestramento del dominio del ristorante, Patrons ha gain circa 0.541 bit mentre Type ha gain 0, confermando che Patrons è un attributo migliore su cui dividere per primo.

Infine, si vuole che l'albero generalizzi bene su dati mai visti, non che si limiti ad adattarsi ai dati di addestramento. L'overfitting diventa più probabile all'aumentare del numero di attributi e meno probabile all'aumentare degli esempi di addestramento; spazi di ipotesi più ampi, come alberi con più nodi, hanno più capacità sia di adattarsi ai dati che di overfittare. Per gli alberi di decisione si usa il pruning: si parte dall'albero completo generato dall'apprendimento, si cerca un nodo di test che ha solo nodi foglia come discendenti e, se il test sembra irrilevante — rileva solo rumore nei dati, quindi ha information gain vicino a zero — lo si elimina sostituendolo con un nodo foglia. Si ripete il processo considerando ogni test con solo discendenti foglia, finché ciascuno è stato potato o accettato così com'è. Un gain basso è un buon indizio che l'attributo è irrilevante.
