# k-NN e Naive Bayes Classifier

## Classificatori basati su istanze

I *classificatori basati su istanze* non costruiscono un modello esplicito dai dati di training: memorizzano gli esempi e li usano direttamente in fase di classificazione. Ne esistono due casi principali: il *rote learner*, che memorizza l'intero training set e classifica un record solo se i suoi attributi corrispondono esattamente a uno degli esempi di training, e il *nearest neighbor*, che usa i k punti "più vicini" (*nearest neighbors*) per effettuare la classificazione.

## Classificatori nearest neighbor

L'idea di base è: se cammina come un'anatra, fa quack come un'anatra, allora è probabilmente un'anatra.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261119170925.png" width="500">
</div>

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="Pasted image 20261119170948.png" width="500">
  </div>
  <div style="flex: 1.5;">
  Per classificare un record sconosciuto servono tre elementi:
  <ul>
    <li>l'insieme di record etichettati;</li>
    <li>una <i>distanza metrica</i> per calcolare la distanza tra record;</li>
    <li>il valore di k, cioè il numero di <i>nearest neighbors</i> da recuperare.</li>
  </ul>
  La procedura è:
  <ol>
    <li>calcola la distanza del record sconosciuto rispetto a tutti i record di training;</li>
    <li>individua i k <i>nearest neighbors</i>;</li>
    <li>usa le etichette di classe dei k <i>nearest neighbors</i> per determinare la classe del record sconosciuto, per esempio con voto a maggioranza.</li>
  </ol>
  </div>
</div>

*Definizione:* I k *nearest neighbors* di un record x sono i punti dati che hanno le k distanze più piccole da x.

<div style="text-align: center;">
  <img src="Pasted image 20261119171031.png" alt="Immagine" />
  <p>I k nearest neighbors di un record x sono i punti dati che hanno le k distanze più piccole da x.</p>
</div>

> [!example] Diagramma di Voronoi (1-nearest-neighbor)
> ![[Pasted image 20261119171123.png|500]]

## Classificazione nearest neighbor

Per classificare un record sconosciuto:
- si calcola la distanza tra due punti, tipicamente con la *distanza euclidea*;
- si determina la classe dalla lista dei *nearest neighbor*, prendendo il voto a maggioranza delle etichette di classe tra i k *nearest neighbors*;
- si può pesare il voto in base alla distanza, con fattore di peso $w = 1/d^2$.

$$d(p,q)=\sqrt{\sum_i (p_i - q_i)^2}$$

*Osservazione:* con il voto pesato, i vicini più lontani contano meno perché il loro peso $w = 1/d^2$ diminuisce rapidamente con la distanza.

> [!info] In altre parole:
> Il voto a maggioranza conta quante volte appare ogni classe tra i k vicini più prossimi e sceglie la più frequente; il voto pesato dà più influenza ai vicini più vicini.

## Scelta del valore di k

- Se k è troppo piccolo, il classificatore è sensibile ai punti di rumore.
- Se k è troppo grande, il vicinato può includere punti di altre classi.

> [!info] Overfitting sul test set
> Nel k-NN l'overfitting si manifesta quando k è troppo piccolo: il classificatore memorizza il rumore del training set, ottiene un errore di training bassissimo ma un errore di test alto perché non generalizza. Con k troppo grande accade il contrario: il vicinato si allarga fino a includere punti di altre classi e l'errore di test sale di nuovo. Il test set serve proprio a scoprirlo: un k che sembra ottimo sul training può rivelarsi pessimo sui dati mai visti. È il compromesso tra underfitting (k troppo grande, modello troppo smussato) e overfitting (k troppo piccolo, modello troppo reattivo al rumore). Vedi anche [[Lezione 10-Overfitting, valutazione dei classificatori e classi sbilanciate|Lezione 10]].

> [!info] Cross-validation per scegliere k
> La cross-validation divide il training set in parti disgiunte (fold). Nella k-fold cross-validation si addestra su k-1 parti e si valida sulla parte restante, ruotando finché ogni parte è stata usata come test; la stima finale è la media delle prestazioni. Nel contesto del k-NN serve a scegliere il valore di k: si provano diversi k (per esempio 1, 3, 5, 7), per ognuno si calcola l'errore di validation con cross-validation e si sceglie il k che minimizza l'errore medio. Il test set resta tenuto da parte per la valutazione finale, così non influenza la scelta di k.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261119171212.png" width="500">
</div>

## Scaling e scelta della misura di similarità

Gli attributi possono dover essere scalati per evitare che le misure di distanza siano dominate da uno di essi. Esempio:
- l'altezza di una persona può variare da 1,5 m a 1,8 m;
- il peso di una persona può variare da 90 lb a 300 lb;
- il reddito di una persona può variare da 10 000 $ a 1 000 000 $.

Occorre scegliere la giusta misura di similarità: due coppie di punti apparentemente simili possono avere la stessa distanza euclidea (1,4142) pur rappresentando relazioni diverse.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261119171304.png" width="500">
</div>

## Caratteristiche dei classificatori k-NN

I classificatori k-NN sono *lazy learners*: non costruiscono un modello esplicito, quindi l'addestramento è rapido ma classificare un record sconosciuto è relativamente costoso perché richiede di scorrere l'intero training set. Possono produrre confini decisionali di forma arbitraria e gestiscono facilmente le interazioni tra variabili, poiché le decisioni si basano su informazioni locali. La scelta della giusta misura di prossimità è essenziale: attributi superflui o ridondanti possono creare problemi, e gli attributi mancanti sono difficili da gestire.

## Efficienza del k-NN

Per evitare di dover calcolare la distanza rispetto a tutti gli oggetti del training set si possono usare metodi di accesso multidimensionali (k-d trees), ricerca approssimata veloce di similarità (*fast approximate similarity search*) o *Locality Sensitive Hashing* (LSH). Il training set si può poi ridurre in due modi: con il *condensing*, che determina un insieme più piccolo di oggetti che offra le stesse prestazioni, o con l'*editing*, che rimuove oggetti per migliorare l'efficienza.

## k-NN e proximity graphs

I *proximity graphs* sono grafi in cui due vertici sono connessi da un arco se e solo se soddisfano particolari requisiti geometrici. Rientrano in questa famiglia i *nearest neighbor graphs*, gli *minimum spanning trees*, le *Delaunay triangulations*, i *relative neighborhood graphs* e i *Gabriel graphs*.

<div style="text-align: center;">
  <img src="Pasted image 20261119175944.png" width="500" alt="Immagine" />
  <p>Proximity graphs: un grafo in cui due vertici sono connessi da un arco se e solo se soddisfano particolari requisiti geometrici. Rientrano in questa famiglia i nearest neighbor graphs, i minimum spanning trees, le Delaunay triangulations, i relative neighborhood graphs e i Gabriel graphs. Riferimenti: G. T. Toussaint, "Proximity graphs for nearest neighbor decision rules: recent progress", Interface-2002; "Open problems in geometric methods for instance based learning", Discrete and Computational Geometry, 2003; "Geometric proximity graphs for improving nearest neighbor methods in instance-based learning and data mining", Int. J. Comput. Geometry Appl., 2005.</p>
</div>

<div style="text-align: center;">
  <img src="Pasted image 20261119180020.png" width="500" alt="Immagine" />
  <p>Proximity graphs: un grafo in cui due vertici sono connessi da un arco se e solo se soddisfano particolari requisiti geometrici. Rientrano in questa famiglia i nearest neighbor graphs, i minimum spanning trees, le Delaunay triangulations, i relative neighborhood graphs e i Gabriel graphs. Riferimenti: G. T. Toussaint, "Proximity graphs for nearest neighbor decision rules: recent progress", Interface-2002; "Open problems in geometric methods for instance based learning", Discrete and Computational Geometry, 2003; "Geometric proximity graphs for improving nearest neighbor methods in instance-based learning and data mining", Int. J. Comput. Geometry Appl., 2005.</p>
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261119180103.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261119180113.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261119180125.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261119180146.png" width="500">
</div>

## Capitolo dal libro: Instance-Based Learning e k-NN

Il libro (*Introduction to Data Mining*, 2nd Edition, cap. 4) presenta i classificatori basati su istanze come tecniche alternative di classificazione. Il *rote learner* memorizza l'intero training set e restituisce la classe di un record solo quando trova una corrispondenza esatta tra i suoi attributi e quelli di un esempio già visto; altrimenti non sa classificarlo. Il *nearest neighbor* rilassa questo requisito: invece di cercare una corrispondenza esatta, cerca i k punti del training set più vicini al record da classificare e assegna la classe più frequente tra di essi.

La classificazione di un record sconosciuto richiede tre ingredienti: l'insieme di record etichettati, una metrica di distanza per misurare la distanza tra record e il valore di k. L'algoritmo calcola la distanza del record sconosciuto rispetto a ogni record di training, seleziona i k vicini più prossimi e determina la classe con voto a maggioranza (eventualmente pesato per distanza inversa al quadrato, $w = 1/d^2$).

La definizione di nearest neighbor si basa sulle k distanze più piccole: i k *nearest neighbors* di un record x sono proprio i punti dati con le k distanze minime da x. Per k = 1 si ottiene il diagramma di Voronoi, in cui ogni regione contiene tutti i punti più vicini a un determinato record di training che a qualsiasi altro.

La scelta di k influisce sul comportamento: un k troppo piccolo rende il classificatore sensibile al rumore, mentre un k troppo grande allarga il vicinato fino a includere punti di altre classi. Le misure di distanza devono essere applicate su attributi comparabili: se un attributo ha una scala molto ampia (per esempio il reddito in dollari) rispetto a un altro (per esempio l'altezza in metri), domina la distanza e distorce il risultato, quindi gli attributi vanno scalati. Anche la scelta della misura di similarità è critica: coppie di punti apparentemente equivalenti possono dare distanze diverse a seconda della metrica usata.

I classificatori k-NN sono *lazy learners*: non costruiscono un modello esplicito durante il training, quindi l'addestramento è rapido ma la classificazione di ogni nuovo record è costosa perché richiede di scorrere l'intero training set. Vantaggi sono i confini decisionali di forma arbitraria, la gestione naturale delle interazioni tra variabili (le decisioni si basano su informazioni locali) e la semplicità concettuale. Gli svantaggi sono la sensibilità a attributi superflui o ridondanti, la difficoltà con attributi mancanti e il costo della classificazione.

Per migliorare l'efficienza si evitano i calcoli di distanza su tutto il training set usando metodi di accesso multidimensionali (k-d trees), ricerca approssimata veloce di similarità o *Locality Sensitive Hashing* (LSH). Il *condensing* riduce il training set a un sottoinsieme più piccolo che preserva le prestazioni; l'*editing* rimuove singoli oggetti per migliorare l'efficienza.

Infine, i *proximity graphs* collegano il k-NN alla geometria computazionale: due vertici sono uniti da un arco se soddisfano requisiti geometrici particolari. Rientrano in questa famiglia i *nearest neighbor graphs*, gli *minimum spanning trees*, le *Delaunay triangulations*, i *relative neighborhood graphs* e i *Gabriel graphs*.

## Naive Bayes Classifier

Il *Naive Bayes Classifier* è un classificatore probabilistico basato sul teorema di Bayes. La parola "naive" (ingenuo) si riferisce all'assunzione semplificatrice di indipendenza condizionata tra gli attributi, dato la classe. Nonostante questa assunzione sia spesso violata nella realtà, il classificatore si dimostra sorprendentemente efficace in molte applicazioni pratiche.

### Il teorema di Bayes

Il teorema di Bayes fornisce un framework probabilistico per risolvere problemi di classificazione. Parte dalle probabilità condizionate:

$$P(Y \mid X) = \frac{P(X, Y)}{P(X)}$$

e dal teorema di Bayes:

$$P(Y \mid X) = \frac{P(X \mid Y) P(Y)}{P(X)}$$

dove:
- $P(Y \mid X)$ è la *probabilità posteriore* della classe Y dato il record X;
- $P(X \mid Y)$ è la *verosimiglianza*, cioè la probabilità di osservare X dato che la classe è Y;
- $P(Y)$ è la *probabilità prior* della classe Y;
- $P(X)$ è la probabilità di osservare il record X.

### Esempio: meningite e collo rigido

Un medico sa che:
- la meningite causa collo rigido il 50% delle volte, cioè $P(\text{collo rigido} \mid \text{meningite}) = 0.5$;
- la probabilità prior che un paziente abbia meningite è $P(\text{meningite}) = 1/50000$;
- la probabilità prior che un paziente abbia collo rigido è $P(\text{collo rigido}) = 1/20$.

Se un paziente ha collo rigido, qual è la probabilità che abbia meningite?

$$P(\text{meningite} \mid \text{collo rigido}) = \frac{P(\text{collo rigido} \mid \text{meningite}) \cdot P(\text{meningite})}{P(\text{collo rigido})} = \frac{0.5 \times 1/50000}{1/20} = 0.0002$$

Il risultato è molto basso: anche se il collo rigido è un sintomo della meningite, la probabilità prior della malattia è così piccola che la probabilità posteriore resta trascurabile.

### Uso del teorema di Bayes per la classificazione

Si consideri ogni attributo e l'etichetta di classe come variabili casuali. Dato un record con attributi $(X_1, X_2, \dots, X_d)$, l'obiettivo è prevedere la classe $Y$, cioè trovare il valore di $Y$ che massimizza $P(Y \mid X_1, X_2, \dots, X_d)$.

Si può stimare $P(Y \mid X_1, X_2, \dots, X_d)$ direttamente dai dati? In generale no, perché servirebbe un numero enorme di esempi per coprire tutte le combinazioni possibili di attributi. Si usa allora il teorema di Bayes:

$$P(Y \mid X_1, X_2, \dots, X_d) = \frac{P(X_1, X_2, \dots, X_d \mid Y) P(Y)}{P(X_1, X_2, \dots, X_d)}$$

Poiché il denominatore $P(X_1, X_2, \dots, X_d)$ non dipende da $Y$, scegliere la $Y$ che massimizza $P(Y \mid X_1, X_2, \dots, X_d)$ è equivalente a scegliere la $Y$ che massimizza:

$$P(X_1, X_2, \dots, X_d \mid Y) P(Y)$$

Questa è la regola del *Maximum a-posteriori (MAP)*: si sceglie la classe che massimizza il prodotto tra la verosimiglianza congiunta e il prior.

Il problema è stimare $P(X_1, X_2, \dots, X_d \mid Y)$, cioè la probabilità congiunta di tutti gli attributi dato una classe. Stimarla direttamente richiederebbe dati per ogni combinazione di valori di attributi per ogni classe, cosa spesso impossibile.

### Esempio di dati

Si consideri il seguente training set di 10 record:

| Tid | Refund | Marital Status | Taxable Income | Evade |
|-----|--------|----------------|----------------|-------|
| 1 | Yes | Single | 125K | No |
| 2 | No | Married | 100K | No |
| 3 | No | Single | 70K | No |
| 4 | Yes | Married | 120K | No |
| 5 | No | Divorced | 95K | Yes |
| 6 | No | Married | 60K | No |
| 7 | Yes | Divorced | 220K | No |
| 8 | No | Single | 85K | Yes |
| 9 | No | Married | 75K | No |
| 10 | No | Single | 90K | Yes |

Vogliamo classificare un nuovo record:

$$X = (\text{Refund} = \text{No}, \text{Divorced}, \text{Income} = 120\text{K})$$

cioè calcolare $P(\text{Evade} = \text{Yes} \mid X)$ e $P(\text{Evade} = \text{No} \mid X)$, e scegliere la classe con probabilità maggiore.

### Assunzione di indipendenza condizionata (Naive Bayes)

Il Naive Bayes assume che gli attributi $X_i$ siano condizionalmente indipendenti dato la classe:

$$P(X_1, X_2, \dots, X_d \mid Y_j) = P(X_1 \mid Y_j) \cdot P(X_2 \mid Y_j) \cdots P(X_d \mid Y_j)$$

Grazie a questa assunzione, non serve più stimare la congiunta di tutti gli attributi: basta stimare ogni $P(X_i \mid Y_j)$ singolarmente dai dati di training, cosa molto più semplice.

Un nuovo punto viene classificato nella classe $Y_j$ che massimizza:

$$P(Y_j) \prod_i P(X_i \mid Y_j)$$

### Indipendenza condizionata

Due variabili $X$ e $Y$ sono *condizionalmente indipendenti* dato $Z$ se:

$$P(X \mid Y, Z) = P(X \mid Z)$$

Esempio: la lunghezza delle braccia e le abilità di lettura di un bambino. Un bambino piccolo ha braccia più corte e abilità di lettura più limitate rispetto a un adulto. Tuttavia, se si fissa l'età (dato $Z$ = età), non c'è una relazione apparente tra lunghezza delle braccia e abilità di lettura. Le due variabili sono quindi condizionalmente indipendenti dato l'età.

Nel Naive Bayes, questa assunzione significa che, una volta nota la classe, ciascun attributo fornisce informazione in modo indipendente dagli altri attributi.

### Applicazione ai dati di esempio

Per il record di prova $X = (\text{Refund} = \text{No}, \text{Divorced}, \text{Income} = 120\text{K})$:

$$P(X \mid \text{Yes}) = P(\text{Refund} = \text{No} \mid \text{Yes}) \cdot P(\text{Divorced} \mid \text{Yes}) \cdot P(\text{Income} = 120\text{K} \mid \text{Yes})$$

$$P(X \mid \text{No}) = P(\text{Refund} = \text{No} \mid \text{No}) \cdot P(\text{Divorced} \mid \text{No}) \cdot P(\text{Income} = 120\text{K} \mid \text{No})$$

### Stima delle probabilità dai dati

**Probabilità prior:**

$$P(Y) = \frac{N_c}{N}$$

dove $N_c$ è il numero di istanze della classe $c$ e $N$ il numero totale di istanze.

Nel training set di 10 record:
- $P(\text{No}) = 7/10$
- $P(\text{Yes}) = 3/10$

**Attributi categorici:**

$$P(X_i \mid Y_k) = \frac{|X_{ik}|}{N_{c_k}}$$

dove $|X_{ik}|$ è il numero di istanze che hanno il valore dell'attributo $X_i$ e appartengono alla classe $Y_k$.

Esempi dal training set:
- $P(\text{Marital Status} = \text{Married} \mid \text{No}) = 4/7$
- $P(\text{Refund} = \text{Yes} \mid \text{Yes}) = 0$
- $P(\text{Refund} = \text{No} \mid \text{No}) = 4/7$
- $P(\text{Refund} = \text{Yes} \mid \text{No}) = 3/7$
- $P(\text{Refund} = \text{No} \mid \text{Yes}) = 1$
- $P(\text{Marital Status} = \text{Single} \mid \text{No}) = 2/7$
- $P(\text{Marital Status} = \text{Divorced} \mid \text{No}) = 1/7$
- $P(\text{Marital Status} = \text{Married} \mid \text{No}) = 4/7$
- $P(\text{Marital Status} = \text{Single} \mid \text{Yes}) = 2/3$
- $P(\text{Marital Status} = \text{Divorced} \mid \text{Yes}) = 1/3$
- $P(\text{Marital Status} = \text{Married} \mid \text{Yes}) = 0$

**Attributi continuhi:**

Per attributi continuhi (come Taxable Income) si possono usare due approcci:

1. **Discretization**: si partiziona il range in bin (intervalli). Ogni valore continuo viene sostituito con il valore del bin a cui appartiene. L'attributo passa da continuo a ordinale.

2. **Probability density estimation**: si assume che l'attributo segua una distribuzione normale. Si usano i dati per stimare i parametri della distribuzione (media e deviazione standard). Una volta nota la distribuzione, la si usa per stimare la probabilità condizionata $P(X_i \mid Y)$.

La formula della distribuzione normale è:

$$P(X_i \mid Y_j) = \frac{1}{\sqrt{2\pi\sigma_{ij}^2}} e^{-\frac{(X_i - \mu_{ij})^2}{2\sigma_{ij}^2}}$$

dove $\mu_{ij}$ e $\sigma_{ij}$ sono la media e la deviazione standard campionaria calcolate sugli attributi $X_i$ delle istanze della classe $Y_j$. C'è una coppia di parametri per ogni coppia $(X_i, Y_j)$.

Esempio per (Taxable Income, Class = No):
- Se Class = No: sample mean = 110, sample variance = 2975
- $P(\text{Income} = 120 \mid \text{No}) = \frac{1}{\sqrt{2\pi(54.54)^2}} e^{-\frac{(120-110)^2}{2(2975)}} = 0.0072$

Per (Taxable Income, Class = Yes):
- Se Class = Yes: sample mean = 90, sample variance = 25

### Esempio completo di classificazione

Per il record $X = (\text{Refund} = \text{No}, \text{Divorced}, \text{Income} = 120\text{K})$:

$$P(X \mid \text{No}) = P(\text{Refund} = \text{No} \mid \text{No}) \times P(\text{Divorced} \mid \text{No}) \times P(\text{Income} = 120\text{K} \mid \text{No}) = \frac{4}{7} \times \frac{1}{7} \times 0.0072 = 0.0006$$

$$P(X \mid \text{Yes}) = P(\text{Refund} = \text{No} \mid \text{Yes}) \times P(\text{Divorced} \mid \text{Yes}) \times P(\text{Income} = 120\text{K} \mid \text{Yes}) = 1 \times \frac{1}{3} \times 1.2 \times 10^{-9} = 4 \times 10^{-10}$$

Moltiplicando per i prior:

- $P(X \mid \text{No}) P(\text{No}) = 0.0006 \times 0.7 = 0.00042$
- $P(X \mid \text{Yes}) P(\text{Yes}) = 4 \times 10^{-10} \times 0.3 = 1.2 \times 10^{-10}$

Poiché $P(X \mid \text{No}) P(\text{No}) > P(X \mid \text{Yes}) P(\text{Yes})$, allora $P(\text{No} \mid X) > P(\text{Yes} \mid X)$, quindi il record viene classificato come **No** (non evade).

Si possono anche calcolare probabilità condizionate parziali:
- $P(\text{Yes} \mid \text{Divorced}) = \frac{1}{3} \times \frac{3}{10} / P(\text{Divorced})$
- $P(\text{No} \mid \text{Divorced}) = \frac{1}{7} \times \frac{7}{10} / P(\text{Divorced})$
- $P(\text{Yes} \mid \text{Married}) = 0 \times \frac{3}{10} / P(\text{Married}) = 0$
- $P(\text{No} \mid \text{Married}) = \frac{4}{7} \times \frac{7}{10} / P(\text{Married})$

Notare che $P(\text{Yes} \mid \text{Married}) = 0$ perché nessun esempio di classe Yes ha Marital Status = Married nel training set.

### Problemi del Naive Bayes: zero-probability

Se una delle probabilità condizionate è zero, l'intera espressione diventa zero, rendendo impossibile la classificazione.

Esempio: si elimina il record Tid 7 (Yes, Divorced, 220K, No) dal training set. Il nuovo training set ha 6 record di classe No e 3 di classe Yes.

- $P(\text{Refund} = \text{Yes} \mid \text{No}) = 2/6$
- $P(\text{Refund} = \text{No} \mid \text{No}) = 4/6$
- $P(\text{Refund} = \text{Yes} \mid \text{Yes}) = 0$
- $P(\text{Refund} = \text{No} \mid \text{Yes}) = 1$
- $P(\text{Marital Status} = \text{Single} \mid \text{No}) = 2/6$
- $P(\text{Marital Status} = \text{Divorced} \mid \text{No}) = 0$ (nessun Divorced nella classe No dopo l'eliminazione)
- $P(\text{Marital Status} = \text{Married} \mid \text{No}) = 4/6$
- $P(\text{Marital Status} = \text{Single} \mid \text{Yes}) = 2/3$
- $P(\text{Marital Status} = \text{Divorced} \mid \text{Yes}) = 1/3$
- $P(\text{Marital Status} = \text{Married} \mid \text{Yes}) = 0/3$

Per $X = (\text{Refund} = \text{Yes}, \text{Divorced}, 120\text{K})$:
- $P(X \mid \text{No}) = \frac{2}{6} \times 0 \times 0.0083 = 0$
- $P(X \mid \text{Yes}) = 0 \times \frac{1}{3} \times 1.2 \times 10^{-9} = 0$

Entrambe le probabilità sono zero, quindi Naive Bayes non è in grado di classificare X né come Yes né come No.

### Soluzioni al problema della zero-probability

Si usano stime di probabilità diverse dalle semplici frazioni:

1. **Laplace smoothing**:
   $$P(A_i \mid C) = \frac{N_{ic} + 1}{N_c + c}$$
   dove $c$ è il numero di classi.

2. **m-estimate**:
   $$P(A_i \mid C) = \frac{N_{ic} + mp}{N_c + m}$$
   dove:
   - $p$: prior probability della classe
   - $m$: parametro (peso dato al prior)
   - $N_c$: numero di istanze nella classe
   - $N_{ic}$: numero di istanze che hanno il valore dell'attributo $A_i$ nella classe $c$

### Esempio: classificazione di animali

Si consideri il seguente training set:

| Name | Give Birth | Can Fly | Live in Water | Have Legs | Class |
|------|------------|---------|---------------|-----------|-------|
| human | yes | no | no | yes | mammals |
| python | no | no | no | no | non-mammals |
| salmon | no | no | yes | no | non-mammals |
| whale | yes | no | yes | no | mammals |
| frog | no | no | sometimes | yes | non-mammals |
| komodo | no | no | no | yes | non-mammals |
| bat | yes | yes | no | yes | mammals |
| pigeon | no | yes | no | no | non-mammals |
| cat | yes | no | no | yes | mammals |
| leopard shark | yes | no | yes | no | non-mammals |
| turtle | no | no | sometimes | yes | non-mammals |
| penguin | no | no | sometimes | yes | non-mammals |
| porcupine | yes | no | no | yes | mammals |
| eel | no | no | yes | no | non-mammals |
| salamander | no | no | sometimes | yes | non-mammals |
| gila monster | no | no | no | yes | non-mammals |
| platypus | no | no | no | yes | mammals |
| owl | no | yes | no | yes | non-mammals |
| dolphin | yes | no | yes | no | mammals |
| eagle | no | yes | no | yes | non-mammals |

Con $A$ = attributi, $M$ = mammals, $N$ = non-mammals:

$$P(A \mid M) = \frac{6}{7} \times \frac{6}{7} \times \frac{2}{7} \times \frac{2}{7} = 0.06$$

$$P(A \mid N) = \frac{7}{13} \times \frac{7}{13} \times \frac{3}{13} \times \frac{4}{13} = 0.0042$$

Con $P(M) = 7/20$ e $P(N) = 13/20$:

$$P(A \mid M) P(M) = 0.06 \times \frac{7}{20} = 0.021$$

$$P(A \mid N) P(N) = 0.0042 \times \frac{13}{20} = 0.0027$$

Poiché $P(A \mid M) P(M) > P(A \mid N) P(N)$, l'esemplare sconosciuto con attributi (yes, no, yes, no) viene classificato come **mammal**.

### Riepilogo del Naive Bayes

- Robusto a punti di rumore isolati.
- Gestisce i missing values ignorando l'istanza durante il calcolo delle stime di probabilità.
- Robusto ad attributi irrilevanti.
- L'assunzione di indipendenza potrebbe non valere per alcuni attributi. In tal caso si possono usare altre tecniche, come le *Bayesian Belief Networks* (BBN).

### Violazione dell'indipendenza condizionata

L'indipendenza condizionata degli attributi è spesso violata. Esempio di tabella con attributi $X = 1, 2, 3, 4$ e classi $Y = 1, 2, 3, 4$:

| | X = 1 | X = 2 | X = 3 | X = 4 |
|---|-------|-------|-------|-------|
| Y = 1 | 1 | 1 | 1 | 1 |
| Y = 2 | 0 | 1 | 0 | 0 |
| Y = 3 | 0 | 0 | 1 | 1 |
| Y = 4 | 0 | 0 | 1 | 1 |

In questo caso l'indipendenza condizionata è violata. Tuttavia, i Naive Bayes possono comunque costruire confini decisionali obliqui (non solo assi-paralleli), il che può essere un vantaggio in alcune situazioni.

### Bayesian Belief Networks

Le *Bayesian Belief Networks* (BBN) forniscono una rappresentazione grafica delle relazioni probabilistiche tra un insieme di variabili casuali. Consistono di:

1. Un *directed acyclic graph* (DAG), dove:
   - Ogni nodo corrisponde a una variabile.
   - Ogni arco corrisponde a una relazione di dipendenza tra una coppia di variabili.

2. Una *probability table* che associa ogni nodo ai suoi genitori immediati.

Relazioni tra nodi:
- Se $D$ è genitore di $C$, allora $C$ è figlio di $D$.
- Se $B$ è discendente di $D$, allora $D$ è antenato di $A$.

Un nodo in una Bayesian network è condizionalmente indipendente da tutti i suoi non-discendenti, se i suoi genitori sono noti.

L'assunzione del Naive Bayes può essere vista come un caso particolare di BBN: $X_1, X_2, \dots, X_d$ sono indipendenti condizionatamente dato $y$ (la classe è l'unico genitore di tutti gli attributi).

### Probability Tables

Nella BBN, la tabella di probabilità di un nodo dipende dai suoi genitori:

- Se $X$ non ha genitori, la tabella contiene la probabilità prior $P(X)$.
- Se $X$ ha un solo genitore $Y$, la tabella contiene la probabilità condizionata $P(X \mid Y)$.
- Se $X$ ha più genitori $(Y_1, Y_2, \dots, Y_k)$, la tabella contiene la probabilità condizionata $P(X \mid Y_1, Y_2, \dots, Y_k)$.

### Esempio completo di BBN

Variabili: Exercise, Diet, Heart Disease, Chest Pain, Blood Pressure.

Probabilità prior:

| Exercise | P |
|----------|---|
| Yes | 0.7 |
| No | 0.3 |

| Diet | P |
|------|---|
| Healthy | 0.25 |
| Unhealthy | 0.75 |

Probabilità condizionate per Heart Disease (genitori: Exercise, Diet):

| Exercise | Diet | HD = Yes | HD = No |
|----------|------|----------|---------|
| Healthy | Yes | 0.25 | 0.75 |
| Healthy | No | 0.45 | 0.55 |
| Unhealthy | Yes | 0.55 | 0.45 |
| Unhealthy | No | 0.75 | 0.25 |

Probabilità condizionate per Chest Pain (genitore: Heart Disease):

| Chest Pain | HD = Yes | HD = No |
|------------|----------|---------|
| Yes | 0.8 | 0.01 |
| No | 0.2 | 0.99 |

Probabilità condizionate per Blood Pressure (genitore: Heart Disease):

| Blood Pressure | HD = Yes | HD = No |
|----------------|----------|---------|
| High | 0.85 | 0.2 |
| Low | 0.15 | 0.8 |

### Esempio di inferenza con BBN

Dato: $X = (E = \text{No}, D = \text{Yes}, CP = \text{Yes}, BP = \text{High})$.

Calcolare $P(\text{HD} \mid E, D, CP, BP)$.

- $P(\text{HD} = \text{Yes} \mid E = \text{No}, D = \text{Yes}) = 0.55$
- $P(CP = \text{Yes} \mid \text{HD} = \text{Yes}) = 0.8$
- $P(BP = \text{High} \mid \text{HD} = \text{Yes}) = 0.85$

$$P(\text{HD} = \text{Yes} \mid E = \text{No}, D = \text{Yes}, CP = \text{Yes}, BP = \text{High}) \propto 0.55 \times 0.8 \times 0.85 = 0.374$$

- $P(\text{HD} = \text{No} \mid E = \text{No}, D = \text{Yes}) = 0.45$
- $P(CP = \text{Yes} \mid \text{HD} = \text{No}) = 0.01$
- $P(BP = \text{High} \mid \text{HD} = \text{No}) = 0.2$

$$P(\text{HD} = \text{No} \mid E = \text{No}, D = \text{Yes}, CP = \text{Yes}, BP = \text{High}) \propto 0.45 \times 0.01 \times 0.2 = 0.0009$$

Poiché $0.374 > 0.0009$, si classifica $X$ come **HD = Yes**.

## Capitolo finale dal libro di testo

