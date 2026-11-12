# Introduzione al Machine Learning e alberi di decisione per la classificazione

## Cos'è il machine learning

L'**apprendimento automatico** (*machine learning*) è lo studio di algoritmi che migliorano le loro prestazioni su un compito attraverso l'esperienza.

*Definizione:* secondo Tom Mitchell (1998), il machine learning è lo studio di algoritmi che migliorano la loro performance $P$ in un certo compito $T$ con l'esperienza $E$. Un task di apprendimento ben definito è dato dalla terna $\langle P, T, E \rangle$.

![[Pasted image 20261111161705.png]]

## Quando si usa il machine learning

Il machine learning si usa quando:
- non esiste competenza umana (per esempio navigare su Marte);
- gli esseri umani non sanno spiegare la loro competenza (per esempio il riconoscimento vocale);
- i modelli devono essere personalizzati (per esempio la medicina personalizzata);
- i modelli si basano su enormi quantità di dati (per esempio la genomica).

L'apprendimento non è sempre utile: non c'è bisogno di "imparare" a calcolare le buste paga.

> [!example]
> È molto difficile dire cosa renda riconoscibile un oggetto in un'immagine.
> ![[Pasted image 20261111161817.png|500]]

## Altri esempi di task risolti meglio con un algoritmo di apprendimento

- Riconoscere pattern:
  - Identità o espressioni facciali
  - Parole scritte o parlate
  - Immagini mediche
- Generare pattern:
  - Generare immagini o sequenze di movimento
- Riconoscere anomalie:
  - Transazioni di carte di credito insolite
  - Pattern insoliti di letture di sensori in una centrale nucleare
- Predizione:
  - Prezzi futuri di azioni o tassi di cambio

## Applicazioni di esempio

- Ricerca sul web
- Biologia computazionale
- Finanza
- E-commerce
- Esplorazione spaziale
- Robotica
- Estrazione di informazioni
- Reti sociali
- Debugging di software

## Definire il task di apprendimento

Migliorare sul compito $T$, rispetto a una metrica di performance $P$, sulla base dell'esperienza $E$.

- $T$: giocare a dama; $P$: percentuale di partite vinte contro un avversario arbitrario; $E$: giocare partite di allenamento contro se stesso.
- $T$: riconoscere parole scritte a mano; $P$: percentuale di parole classificate correttamente; $E$: database di immagini scritte a mano etichettate da umani.
- $T$: guidare su autostrade a quattro corsie usando sensori visivi; $P$: distanza media percorsa prima di un errore giudicato da un umano; $E$: sequenza di immagini e comandi di sterzo registrati osservando un guidatore umano.
- $T$: categorizzare messaggi email come spam o legittimi; $P$: percentuale di messaggi email classificati correttamente; $E$: database di email, alcune con etichette umane.

> [!example]
> Sensori:
> ![[Pasted image 20261111162428.png|500]]
> Tecnologia:
> ![[Pasted image 20261111162523.png|500]]

> [!example]
> ![[Pasted image 20261111162553.png|500]]

> [!example]
> ![[Pasted image 20261111162621.png|500]]

> [!example]
> ![[Pasted image 20261111162655.png|500]]

> [!example]
> ![[Pasted image 20261111162726.png|500]]

> [!example]
> ![[Pasted image 20261111162755.png|500]]

> [!example]
> ![[Pasted image 20261111162823.png|500]]

> [!example]
> ![[Pasted image 20261111162851.png|500]]

## Tipi di apprendimento

- **Apprendimento supervisionato** (*inductive learning*): dati di training + output desiderati (etichette)
- **Apprendimento non supervisionato**: dati di training (senza output desiderati)
- **Apprendimento semi-supervisionato**: dati di training + poche output desiderate
- **Apprendimento per rinforzamento**: ricompense da una sequenza di azioni

## Apprendimento supervisionato: regressione

Si hanno coppie $(x_1, y_1), (x_2, y_2), \dots, (x_n, y_n)$. Si impara una funzione $f(x)$ per predire $y$ dato $x$ ($y$ è a valori reali $\Rightarrow$ regressione).

![[Pasted image 20261111162320.png]]

## Overfitting e underfitting

L'**overfitting** (*sovradattamento*) si verifica quando un modello impara i dati di training troppo da vicino, inclusi rumore e dettagli irrilevanti, ottenendo un errore basso sul training set ma un errore significativamente più alto sul test set. Il modello ha memorizzato gli esempi invece di imparare il pattern generale, e quindi non generalizza bene su dati nuovi.

L'**underfitting** (*sottodattamento*) si verifica quando il modello è troppo semplice per catturare i pattern veri nei dati, e l'errore resta alto sia sul training set che sul test set.

In altre parole: l'overfitting è un modello troppo complesso rispetto alla quantità di dati disponibili, mentre l'underfitting è un modello troppo semplice per rappresentare il problema. L'obiettivo è trovare un compromesso tra i due, ovvero un modello che generalizzi bene su dati mai visti durante l'addestramento.

## Apprendimento supervisionato: classificazione

Si hanno coppie $(x_1, y_1), (x_2, y_2), \dots, (x_n, y_n)$. Si impara una funzione $f(x)$ per predire $y$ dato $x$ ($y$ è categorico $\Rightarrow$ classificazione).

![[Pasted image 20261111163807.png]]

## Variabili di input multidimensionali

$x$ può essere multidimensionale: ogni dimensione corrisponde a un attributo.
- Clump Thickness
- Uniformity of Cell Size
- Uniformity of Cell Shape

![[Pasted image 20261111165617.png]]

## Apprendimento non supervisionato

Si hanno $x_1, x_2, \dots, x_n$ (senza etichette). Si scopre la struttura nascosta dietro gli $x$'s. Esempio: *clustering*.

![[Pasted image 20261111165632.png]]

## Esempi

**Applicazione genomica:** raggruppare individui per similarità genetica.

![[Pasted image 20261111165654.png]]

**Independent Component Analysis:** separare un segnale combinato nelle sue sorgenti originali.

![[Pasted image 20261111165741.png]]

## Apprendimento per rinforzamento

Si ha una sequenza di stati e azioni con ricompense (ritardate). Si impara una *policy*, cioè una mappatura da stati a azioni che dice cosa fare in un dato stato.
Esempi:
- Problema dell'assegnazione del credito (*credit assignment problem*)
- Gioco
- Robot in un labirinto
- Bilanciare un bastone sulla mano

## Interfaccia Agente-Ambiente

![[Pasted image 20261111165851.png]]

## Progettare un sistema di apprendimento

1. Scegliere l'esperienza di training.
2. Scegliere esattamente cosa si vuole imparare, cioè la *target function*.
3. Scegliere come rappresentare la *target function*.
4. Scegliere un algoritmo di apprendimento per dedurre la *target function* dall'esperienza.

![[Pasted image 20261111173652.png]]

## Distribuzione training vs test

Generalmente si assume che gli esempi di training e test siano estratti indipendentemente dalla stessa distribuzione complessiva dei dati. Lo si chiama *i.i.d.* (*independent and identically distributed*).
- Se gli esempi non sono indipendenti, serve la *collective classification*.
- Se la distribuzione del test è diversa, serve il *transfer learning*.

## Machine Learning in sintesi

Esistono decine di migliaia di algoritmi di machine learning (centinaia di nuovi ogni anno).
Ogni algoritmo di ML ha tre componenti:
- **Representation** (rappresentazione)
- **Optimization** (ottimizzazione)
- **Evaluation** (valutazione)

## Rappresentazioni di funzioni

- Funzioni numeriche: regressione lineare, reti neurali, macchine a vettori di supporto (*support vector machines*)
- Funzioni simboliche: alberi di decisione, regole di logica proposizionale, regole di logica dei predicati del primo ordine
- Funzioni basate su istanze: *nearest-neighbor*, *case-based*
- Modelli grafici probabilistici: *Naïve Bayes*, *Bayesian networks*, *Hidden-Markov Models* (HMM), *Probabilistic Context Free Grammars* (PCFG), *Markov networks*

## Algoritmi di ricerca/ottimizzazione

- Discesa del gradiente (*gradient descent*): Perceptron, Backpropagation
- Programmazione dinamica (*Dynamic Programming*): HMM Learning, PCFG Learning
- Dividi e conquista (*Divide and Conquer*): Decision tree induction, Rule learning
- Calcolo evolutivo (*Evolutionary Computation*): Genetic Algorithms (GA), Genetic Programming (GP), Neuro-evolution

## Evaluazione

- Accuracy
- Precision e recall
- Errore quadratico (*squared error*)
- Likelihood
- Probabilità posteriore (*posterior probability*)
- Costo / Utilità (*Cost / Utility*)
- Margine (*Margin*)
- Entropia (*Entropy*)
- Divergenza K-L (*K-L divergence*)
- ecc.

## Machine Learning in pratica

Ciclo:
- Comprendere il dominio, la conoscenza preliminare e gli obiettivi
- Integrazione dei dati, selezione, pulizia, pre-processamento, ecc.
- Imparare i modelli
- Interpretare i risultati
- Consolidare e distribuire la conoscenza scoperta

## Lezioni apprese sull'apprendimento

- L'apprendimento può essere visto come l'uso di esperienza diretta o indiretta per approssimare una funzione target scelta.
- L'approssimazione di funzione può essere vista come una ricerca attraverso uno spazio di ipotesi (rappresentazioni di funzioni) per trovarne una che si adatti meglio a un insieme di dati di training.
- Diversi metodi di apprendimento assumono spazi di ipotesi diversi (linguaggi di rappresentazione) e/o impiegano diverse tecniche di ricerca.

## Classificazione: definizione

Si ha una collezione di record (training set). Ogni record è caratterizzato da una tupla $(x, y)$, dove $x$ è l'insieme di attributi e $y$ è l'etichetta di classe.
- $x$: attributo, predittore, variabile indipendente, input
- $y$: classe, risposta, variabile dipendente, output

*Task:* imparare un modello che mappi ogni insieme di attributi $x$ in una delle etichette di classe predefinite $y$.

> [!example]
> ![[Pasted image 20261111173800.png]]

## Approccio generale per costruire un modello di classificazione

![[Pasted image 20261111173943.png]]

## Tecniche di classificazione

*Classifier di base:*
- Metodi basati su albero di decisione
- Metodi basati su regole
- Nearest-neighbor
- Reti neurali
- Deep Learning
- Naïve Bayes e *Bayesian Belief Networks*
- Support Vector Machines

*Classifier di insieme:*
- Boosting, Bagging, Random Forests

> [!example]
> ![[Pasted image 20261111174024.png]]
> ![[Pasted image 20261111174354.png]]

## Task di classificazione con alberi di decisione

![[Pasted image 20261111174416.png]]

## Induzione degli alberi di decisione

Molti algoritmi:
- Hunt's Algorithm (uno dei primi)
- CART
- ID3, C4.5
- SLIQ, SPRINT

## Struttura generale della procedura di Hunt

Sia $D_t$ l'insieme dei record di training che raggiungono il nodo $t$.
*Procedura generale:*
- Se $D_t$ contiene record che appartengono tutti alla stessa classe $y_t$, allora $t$ è un nodo foglia etichettato come $y_t$.
- Se $D_t$ contiene record che appartengono a più di una classe, si usa un test su un attributo per dividere i dati in sottoinsiemi più piccoli. Si applica ricorsivamente la procedura a ciascun sottoinsieme.

![[Pasted image 20261111180634.png]]

## Hunt's Algorithm

![[Pasted image 20261111180700.png]]

## Problemi di progettazione dell'induzione degli alberi di decisione

*Come dividere i record di training:*
- Metodo per specificare la condizione di test, a seconda dei tipi di attributo
- Misura per valutare la bontà di una condizione di test

*Quando fermare la procedura di divisione:*
- Fermare la divisione se tutti i record appartengono alla stessa classe o hanno valori di attributo identici
- Terminazione anticipata

## Condizione di test per attributi nominali

![[Pasted image 20261111180822.png]]

## Condizione di test per attributi ordinali

![[Pasted image 20261111180833.png]]

## Condizione di test per attributi continui

![[Pasted image 20261111180846.png]]

## Divisione basata su attributi continui

Diversi modi di gestirli:
- *Discretization* per formare un attributo categorico ordinale. Gli intervalli possono essere trovati con *equal interval bucketing*, *equal frequency bucketing* (percentili) o *clustering*.
  - Static: si discretizza una volta all'inizio
  - Dynamic: si ripete a ogni nodo
- *Binary Decision:* $(A < v)$ o $(A \geq v)$. Si considerano tutti i possibili *split* e si trova il taglio migliore. Può essere più costoso computazionalmente.

## Come determinare il miglior split

![[Pasted image 20261111180948.png]]

Approccio *greedy*: i nodi con una distribuzione di classe più pura sono preferiti. Serve una misura dell'impurità del nodo.

![[Pasted image 20261111181013.png]]

## Confronto tra misure di impurità

![[Pasted image 20261111182043.png]]

Sono state introdotte le misure di impurità del nodo (Gini Index, Entropy, Misclassification error) e il criterio del *gain* ($P - M$), ma i calcoli numerici dettagliati per ogni attributo non sono stati trattati a lezione.

## Problema del gran numero di partizioni
Le misure di impurità dei nodi tendono a preferire split che generano un elevato numero di partizioni, ciascuna piccola ma pura. Per esempio, un attributo come *Customer ID* può ottenere l'information gain più alto perché l'entropia di tutti i figli risulta zero, pur non essendo realmente predittivo.

## Gain Ratio
Il **Gain Ratio** corregge questo limite dividendo l'Information Gain per lo *Split Information*, cioè l'entropia della partizionamento:

$$GainRatio = \frac{Gain}{SplitInfo}, \qquad SplitInfo = -\sum_{i=1}^{k} \frac{n_i}{n} \log \frac{n_i}{n}$$

dove $n_i$ è il numero di record nella partizione $i$ e $n$ il totale dei record. Una partizione ad alta entropia (molte partizioni piccole) viene quindi penalizzata. Il Gain Ratio è usato nell'algoritmo C4.5 ed è stato progettato per superare lo svantaggio dell'Information Gain.

## Alberi di decisione: vantaggi e svantaggi

*Vantaggi:*
- Economici da costruire.
- Estremamente veloci nel classificare record sconosciuti.
- Facili da interpretare per alberi di piccole dimensioni.
- Robusti al rumore, specialmente quando si impiegano metodi per evitare l'overfitting.
- Possono gestire facilmente attributi ridondanti o irrilevanti (a meno che gli attributi non interagiscano).

*Svantaggi:*
- Lo spazio degli alberi di decisione possibili è esponenzialmente grande: gli approcci greedy spesso non riescono a trovare il miglior albero.
- Non tengono conto delle interazioni tra attributi.
- Ogni confine di decisione coinvolge un singolo attributo.

## Interazioni tra attributi e confini di decisione
Alcuni attributi diventano informativi solo in combinazione con altri (*interazioni tra attributi*): individualmente possono avere un'entropia elevata, ma insieme determinano la classe. Inoltre, poiché ogni test di un albero di decisione coinvolge un singolo attributo, i confini di decisione sono box allineati agli assi dello spazio degli attributi; rappresentare confini obliqui o diagonali richiede di impilare molti di questi box.

## Capitolo finale dal libro di testo: apprendimento degli alberi di decisione (AIMA, Cap. 19.3)

Un **albero di decisione** è una rappresentazione di una funzione che mappa un vettore di valori di attributo in un singolo valore di output, una "decisione". L'albero prende una decisione eseguendo una sequenza di test, partendo dalla radice e seguendo il ramo appropriato fino a raggiungere una foglia. Ogni nodo interno corrisponde a un test sul valore di uno degli attributi di input, i rami dal nodo sono etichettati con i possibili valori dell'attributo e i nodi foglia specificano il valore restituito dalla funzione.

In generale, i valori di input e output possono essere discreti o continui, ma si considerano inizialmente solo input discreti e output che sono vero (esempio positivo) o falso (esempio negativo): si parla di *Boolean classification*.

### Espressività degli alberi di decisione

Un albero di decisione booleano è equivalente a un'affermazione logica della forma:

$$\text{Output} \Leftrightarrow (\text{Path}_1 \lor \text{Path}_2 \lor \cdots)$$

dove ogni $\text{Path}_i$ è una congiunzione della forma $(A_m = v_x \land A_n = v_y \land \cdots)$ di test su coppie attributo-valore corrispondenti a un percorso dalla radice a una foglia vera. L'espressione complessiva è in *disjunctive normal form*, quindi qualsiasi funzione della logica proposizionale può essere espressa come albero di decisione.

Per molti problemi, il formato ad albero di decisione dà un risultato piacevole, conciso e comprensibile. Molti manuali "How To" (per esempio per la riparazione di auto) sono scritti come alberi di decisione. Ma alcune funzioni non possono essere rappresentate in modo conciso. Per esempio, la funzione *majority*, che restituisce vero se e solo se più della metà degli input è vera, richiede un albero di decisione esponenzialmente grande, così come la funzione *parity*, che restituisce vero se e solo se un numero pari di attributi di input è vero.

### Apprendimento degli alberi di decisione dagli esempi

Si vuole trovare un albero che sia coerente con gli esempi e il più piccolo possibile. Purtroppo trovare l'albero consistente più piccolo garantito è intrattabile. Con alcune euristiche semplici, si può trovare efficientemente uno vicino al più piccolo.

L'algoritmo **LEARN-DECISION-TREE** adotta una strategia *greedy* divide-and-conquer: testa sempre prima l'attributo più importante, poi risolve ricorsivamente i sottoproblemi più piccoli definiti dai possibili risultati del test. Per "attributo più importante" si intende quello che fa la maggiore differenza nella classificazione di un esempio. Così si spera di arrivare alla classificazione corretta con un piccolo numero di test, il che significa che tutti i percorsi nell'albero saranno brevi e l'albero nel suo insieme poco profondo.

L'algoritmo considera quattro casi per i sottoproblemi ricorsivi:
1. Se gli esempi rimanenti sono tutti positivi (o tutti negativi), si è finiti: si risponde Yes o No.
2. Se ci sono esempi positivi e negativi, si sceglie il miglior attributo per dividerli.
3. Se non ci sono esempi rimasti, significa che nessun esempio è stato osservato per quella combinazione di valori di attributo, e si restituisce il valore di output più comune tra gli esempi usati per costruire il nodo genitore.
4. Se non ci sono attributi rimanenti, ma sia esempi positivi che negativi, significa che questi esempi hanno esattamente la stessa descrizione, ma classificazioni diverse. Può accadere per errore o rumore nei dati, perché il dominio è nondeterministico, o perché non si può osservare un attributo che li distinguerebbe. Il meglio che si può fare è restituire il valore di output più comune degli esempi rimanenti.

L'albero è costituito da test su attributi nei nodi interni, valori di attributo sui rami e valori di output nei nodi foglia.

### Scegliere i test sugli attributi

L'algoritmo di apprendimento degli alberi di decisione sceglie l'attributo con la massima *importance*. Per misurare l'importanza si usa la nozione di *information gain*, definita in termini di *entropia*, che è la quantità fondamentale della teoria dell'informazione.

L'entropia è una misura dell'incertezza di una variabile casuale; più informazione c'è, meno entropia c'è. Una variabile casuale con un solo valore possibile (una moneta che esce sempre testa) non ha incertezza e quindi la sua entropia è definita come zero. Una moneta equa ha entropia di 1 bit. Il lancio di un dado equo a quattro facce ha 2 bit di entropia.

In generale, l'entropia di una variabile casuale $V$ con valori $v_k$ di probabilità $P(v_k)$ è:

$$H(V) = -\sum_k P(v_k) \log_2 P(v_k)$$

### Generalizzazione e overfitting

Si vogliono algoritmi di apprendimento che trovino un'ipotesi che si adatti ai dati di training, ma soprattutto che generalizzi bene su dati mai visti. Un polinomio di grado elevato può adattarsi a tutti i dati, ma ha oscillazioni selvagge non giustificate dai dati: si adatta ma può andare in *overfitting*. L'overfitting diventa più probabile all'aumentare del numero di attributi e meno probabile all'aumentare del numero di esempi di training. Spazi di ipotesi più ampi (per esempio alberi di decisione con più nodi o polinomi di grado elevato) hanno più capacità sia di adattarsi che di andare in overfitting; alcune classi di modelli sono più inclini all'overfitting di altre.

Per gli alberi di decisione, una tecnica chiamata *decision tree pruning* combatte l'overfitting. Il pruning funziona eliminando nodi che non sono chiaramente rilevanti. Si parte da un albero completo, generato da LEARN-DECISION-TREE. Poi si guarda un nodo di test che ha solo nodi foglia come discendenti. Se il test sembra irrilevante (rintraccia solo rumore nei dati), si elimina il test, sostituendolo con un nodo foglia. Si ripete questo processo, considerando ogni test con solo discendenti foglia, finché ciascuno è stato potato o accettato così com'è.

Per rilevare che un nodo sta testando un attributo irrilevante: se l'attributo è irrilevante, ci si aspetta che divida gli esempi in sottoinsiemi tali che ciascuno abbia più o meno la stessa proporzione di esempi positivi dell'insieme totale, $p/(p+n)$, e quindi l'information gain sarà vicino a zero. Un information gain basso è quindi un buon indizio che l'attributo è irrilevante. La domanda è quanto grande debba essere il gain per decidere di dividere su un particolare attributo. Si può rispondere usando un test di significatività statistica, che parte assumendo che non ci sia un pattern sottostante (la cosiddetta *null hypothesis*).

## Collegamenti

Le basi del machine learning e la gerarchia IA $\supset$ ML $\supset$ Deep Learning $\supset$ IA generativa sono state introdotte nella [[Lezione 1-Fondamenti di intelligenza artificiale, machine learning e modelli generativi|Lezione 1]].
