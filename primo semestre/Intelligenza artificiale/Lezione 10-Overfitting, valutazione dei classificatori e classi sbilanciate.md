# Overfitting, valutazione dei classificatori e classi sbilanciate

## Errori di classificazione

*Errore di training* (o *errore apparente*): proporzione di esempi classificati in modo errato nel training set. *Errore di test*: proporzione di errori sul test set. *Errore di generalizzazione*: errore atteso del modello su nuovi record estratti casualmente dalla stessa distribuzione dei dati.

Per stimare la capacità di generalizzazione, training e test devono rappresentare la stessa distribuzione. L'errore di training da solo non basta: un modello può adattarsi molto bene agli esempi usati per costruirlo e fallire su quelli nuovi.

## Overfitting e complessità del modello

*Underfitting* si verifica quando il modello è troppo semplice e commette molti errori sia sul training set sia sul test set. *Overfitting* si verifica quando il modello è troppo complesso: riduce l'errore di training adattandosi anche al rumore, ma l'errore di test resta alto o cresce.

> [!example] Dataset a due classi
> Il materiale mostra 10 400 punti: 5 200 positivi, di cui 5 000 generati da una distribuzione gaussiana centrata in $(10,10)$ e 200 punti rumorosi aggiunti, e 5 200 negativi generati da una distribuzione uniforme. Il 10% dei dati viene usato per il training e il 90% per il test. La nuvola centrale rende riconoscibile la classe positiva, mentre i punti rumorosi possono indurre il modello a inseguire dettagli casuali.
> ![[Pasted image 20261118162900.png|500]]

**Numero di nodi negli alberi:** aumentando i nodi, l'errore di training diminuisce. Un albero con pochi nodi produce regioni ampie e può non distinguere bene i dati; un albero molto grande crea confini più frastagliati e può isolare singoli esempi. Le immagini confrontano un albero con 4 nodi e uno con 50 nodi: il secondo segue più da vicino anche i punti anomali.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261118162944.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261118163002.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261118163020.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261118163039.png" width="500">
</div>

La scelta del modello dipende dai dati non usati durante l'addestramento. Il grafico dell'errore rispetto al numero di nodi mostra l'errore di training che cala progressivamente; quando il modello diventa troppo complesso, l'errore di test può invece aumentare. Perciò l'albero da 50 nodi non è automaticamente migliore di quello da 4.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261118163217.png" width="500">
</div>

Se il training set non rappresenta bene la distribuzione, aumentando i nodi l'errore di training diminuisce ma quello di test può aumentare. Raddoppiare il numero di esempi disponibili riduce la distanza tra i due errori a parità di complessità: più esempi rendono meno probabile che il modello scambi il rumore per una regola generale.

## Cause dell'overfitting

Le cause principali sono:

- **Training set limitato:** pochi esempi rappresentano male la distribuzione e lasciano spazio a regole spurie.
- **Modello troppo complesso:** un modello con molti parametri o nodi può adattarsi a particolari casuali dei dati.

La procedura di confronto multiplo è un caso di complessità che può causare overfitting. Se si provano molte alternative, alcune sembreranno efficaci per caso e si rischia di scegliere proprio una di esse.

> [!example] Previsioni casuali sul mercato
> Supponiamo di prevedere se il mercato salirà o scenderà nei prossimi 10 giorni di negoziazione, indovinando ogni giorno a caso. La probabilità di una previsione corretta è $0{,}5$. Il numero di successi segue una distribuzione binomiale:
> $$P(X\geq 8)=\sum_{i=8}^{10}\binom{10}{i}(0{,}5)^{10}=\frac{\binom{10}{8}+\binom{10}{9}+\binom{10}{10}}{2^{10}}=0{,}0547.$$
> Quindi anche un analista che indovina almeno 8 giorni su 10 può aver avuto fortuna: la probabilità è circa il 5,47%.

Se 50 analisti fanno ciascuno 10 previsioni casuali e si sceglie quello con più risposte corrette, la probabilità che almeno uno ne indovini almeno 8 è:
$$P(\text{almeno uno})=1-(1-0{,}0547)^{50}=0{,}9399.$$
La probabilità sale al 93,99% perché si seleziona il risultato migliore fra molte prove, anche se tutte le previsioni sono casuali.

Molti algoritmi usano una strategia greedy: partono da un modello $M$, costruiscono un'alternativa $M'=M\cup\gamma$ aggiungendo una componente (per esempio una condizione di split) e la conservano se il miglioramento $\Delta(M,M')$ supera una soglia $\alpha$. Se $\gamma$ viene scelta fra molte alternative $\Gamma=\{\gamma_1,\gamma_2,\ldots,\gamma_k\}$, una componente irrilevante può apparire utile per caso e finire nel modello.

> [!example] Variabili rumorose
> Un esperimento aggiunge a $X$ e $Y$ 100 variabili rumorose generate da una distribuzione uniforme e usa il 30% dei dati per il training e il 70% per il test. Le due immagini mettono a confronto l'uso delle sole variabili $X$ e $Y$ con l'aggiunta delle 100 variabili: quelle casuali offrono molti split che possono adattarsi al training senza aiutare sulle osservazioni nuove.
> <div style="display: flex; justify-content: center; gap: 12px;">
>   <img src="Pasted image 20261118163355.png" width="500">
>   <img src="Pasted image 20261118163406.png" width="500">
> </div>

L'overfitting produce alberi più complessi del necessario. L'errore di training non è una buona stima della prestazione su record mai visti; occorrono metodi che stimino l'errore di generalizzazione.

## Selezione del modello

La selezione del modello avviene durante la costruzione e serve a limitare la complessità. Si può stimare l'errore di generalizzazione usando un validation set, penalizzando la complessità o calcolando limiti statistici.

**Validation set:** si divide il training set in due parti. Il training set serve a costruire il modello; il validation set a stimarne l'errore di generalizzazione e a scegliere il modello. Il validation set non è il test set, che va tenuto da parte per la valutazione finale. Lo svantaggio della divisione è che rimangono meno dati per l'addestramento.

**Rasoio di Occam e penalità di complessità:** fra due modelli con errori di generalizzazione simili si preferisce quello più semplice, perché un modello complesso ha più possibilità di adattarsi accidentalmente al rumore.
$$E_{gen}(M)=E_{train}(M,D_{train})+\alpha\,C(M),$$
dove $C(M)$ misura la complessità e $\alpha$ ne regola il peso.

Per un albero $T$ con $k$ foglie, una stima pessimistica dell'errore è:
$$e_{gen}(T)=err(T)+\Omega\frac{k}{N_{train}},$$
dove $err(T)$ è il tasso di errore sui record di training, $N_{train}$ è il numero di record e $\Omega$ è un iperparametro di compromesso che rappresenta il costo relativo dell'aggiunta di una foglia.

> [!example] Confronto fra due alberi
> Nell'immagine, $T_L$ ha errore di training $4/24$ e 7 foglie; $T_R$ ha errore $6/24$ e 4 foglie. Con $\Omega=1$:
> $$e_{gen}(T_L)=\frac{4}{24}+1\cdot\frac{7}{24}=\frac{11}{24}\approx0{,}458,$$
> $$e_{gen}(T_R)=\frac{6}{24}+1\cdot\frac{4}{24}=\frac{10}{24}\approx0{,}417.$$
> $T_L$ classifica meglio il training set, ma la stima penalizzata favorisce $T_R$, che è più semplice.
> ![[Pasted image 20261118163531.png|500]]

**Stima per ri-sostituzione:** usa l'errore di training come stima ottimistica dell'errore di generalizzazione. È ottimistica perché il modello è stato costruito proprio su quegli esempi.

**Minimum Description Length (MDL):** sceglie il modello che minimizza il costo complessivo di codifica:
$$Cost(M,D)=Cost(D\mid M)+\lambda Cost(M).$$
Il costo è misurato in bit. $Cost(D\mid M)$ codifica gli errori di classificazione; $Cost(M)$ codifica il modello, per esempio il numero di figli dei nodi e le condizioni di split. Il parametro $\lambda$ controlla il peso assegnato alla descrizione del modello. La figura illustra come i dati vengano rappresentati dal modello e come l'albero codifichi le condizioni necessarie a ricostruire le predizioni.
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261118163624.png" width="500">
</div>

**Limiti statistici:** si può stimare un limite superiore dell'errore vero $e$ a partire dall'errore osservato $\hat e$ su $N$ esempi, con livello di confidenza determinato da $z_{\alpha/2}$:
$$e'=\frac{\hat e+\frac{z_{\alpha/2}^{2}}{2N}+z_{\alpha/2}\sqrt{\frac{\hat e(1-\hat e)}{N}+\frac{z_{\alpha/2}^{2}}{4N^{2}}}}{1+\frac{z_{\alpha/2}^{2}}{N}}.$$
Per confrontare alberi, si sommano i limiti dei nodi terminali, pesandoli per il numero di esempi che contengono. Nell'esempio della slide, prima dello split $e=2/7$ e $e'(7,2/7,0{,}25)=0{,}503$, quindi $e'(T)=7\cdot0{,}503=3{,}521$. Dopo lo split, $e(T_L)=1/4$, $e'(4,1/4,0{,}25)=0{,}537$; $e(T_R)=1/3$, $e'(3,1/3,0{,}25)=0{,}650$. La stima complessiva diventa $4\cdot0{,}537+3\cdot0{,}650=4{,}098$. Poiché peggiora, non si esegue lo split.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261118163653.png" width="500">
</div>

## Potatura degli alberi

**Pre-pruning (arresto anticipato):** interrompe la crescita prima che l'albero sia completo. Si può fermare un nodo quando:

- tutti gli esempi appartengono alla stessa classe;
- tutti i valori degli attributi sono uguali;
- il numero di esempi è inferiore a una soglia stabilita;
- la distribuzione delle classi è indipendente dalle caratteristiche disponibili, per esempio secondo un test $\chi^2$;
- lo split non migliora una misura di impurità, come [[Lezione 9-Misure di impurità e criteri di split negli alberi di decisione|Gini o guadagno informativo]];
- l'errore di generalizzazione stimato scende sotto una soglia.

**Post-pruning:** prima si fa crescere l'albero completo, poi si eliminano parti che non migliorano la generalizzazione. Nella sostituzione del sottoalbero si procede dal basso verso l'alto; se sostituire un sottoalbero con una foglia riduce l'errore stimato, si mantiene la foglia, etichettandola con la classe maggioritaria degli esempi contenuti nel sottoalbero. Nell'innalzamento del sottoalbero (*subtree raising*) si sostituisce un sottoalbero con il ramo più usato.

> [!example] Confronto prima e dopo lo split
> Prima dello split, l'errore di training è $10/30$ e la stima pessimistica è $(10+0{,}5)/30=10{,}5/30$. Dopo lo split l'errore di training scende a $9/30$, ma la stima pessimistica diventa $(9+4\cdot0{,}5)/30=11/30$. L'albero più grande ha un errore apparente minore ma una stima pessimistica peggiore, quindi si pota.
> ![[Pasted image 20261118163845.png|500]]

L'altra figura mostra un esempio di sostituzione di sottoalbero e innalzamento: porzioni dell'albero vengono rimosse o rimpiazzate per ottenere una struttura più semplice.
> [!example]
> ![[Pasted image 20261118163904.png|500]]

## Valutazione dei modelli

Lo scopo della valutazione è stimare le prestazioni del classificatore su dati mai visti, mantenuti in un test set.

- **Holdout:** si riserva una quota $k\%$ per il training e il restante $(100-k)\%$ per il test. Nel *random subsampling* la divisione viene ripetuta più volte.
- **Cross-validation:** si divide il dataset in $k$ sottoinsiemi disgiunti. Nella *k-fold cross-validation* si addestra su $k-1$ parti e si testa sulla parte restante, ripetendo il procedimento finché ogni parte è stata usata come test. La stima è la media delle prestazioni ottenute.
- **Leave-one-out:** è il caso limite della cross-validation con $k=n$, dove $n$ è il numero di esempi: a ogni iterazione un solo esempio è test e gli altri sono training.

> [!example] Cross-validation a 3 fold
> Nell'immagine, il dataset è diviso in $S_1,S_2,S_3$. In ciascuna delle tre esecuzioni una partizione diversa è il test set e le altre due sono il training set.
> ![[Pasted image 20261118163945.png|500]]

## Classi sbilanciate

Il problema delle classi sbilanciate si presenta quando una classe ha molti più record dell'altra. Esempi: frodi con carte di credito, intrusioni informatiche, prodotti difettosi in una linea di assemblaggio e risultati di test COVID-19 raccolti su un campione casuale. In questi casi l'accuratezza può essere fuorviante.

### Matrice di confusione e misure

La matrice di confusione confronta classe reale e classe predetta. Considerando *Yes* come classe positiva:

| Classe reale | Predetta Yes | Predetta No |
|---|---:|---:|
| Yes | $a=TP$ | $b=FN$ |
| No | $c=FP$ | $d=TN$ |

$TP$ (*true positive*) è un positivo riconosciuto; $FN$ (*false negative*) un positivo classificato come negativo; $FP$ (*false positive*) un negativo classificato come positivo; $TN$ (*true negative*) un negativo riconosciuto.

L'accuratezza è la frazione di predizioni corrette:
$$Accuracy=\frac{a+d}{a+b+c+d}=\frac{TP+TN}{TP+TN+FP+FN}.$$

> [!example] Perché l'accuratezza può ingannare
> Con 990 record negativi e 10 positivi, un classificatore che predice sempre *No* ottiene $990/1000=99\%$ di accuratezza, pur non trovando nessun positivo. Se rilevare la classe rara è l'obiettivo (per esempio frodi o difetti), questa misura nasconde il fallimento.

Due esempi mostrano che accuratezza, precisione, richiamo e F reagiscono in modo diverso agli errori:

| $TP$ | $FN$ | $FP$ | $TN$ | Precisione | Richiamo | F | Accuratezza |
|---:|---:|---:|---:|---:|---:|---:|---:|
| 10 | 0 | 10 | 980 | 0,5 | 1,0 | 0,62 | 0,99 |
| 1 | 9 | 0 | 990 | 1,0 | 0,1 | 0,18 | 0,991 |

Nel primo caso si rilevano tutti i positivi, ma metà delle predizioni positive è falsa. Nel secondo ogni predizione positiva è corretta, ma si trova solo un decimo dei positivi reali. La seconda accuratezza è leggermente più alta, mentre il richiamo e F sono molto più bassi.

Le misure alternative sono:

| Misura | Formula | Significato |
|---|---|---|
| Precisione (*precision*) $p$ | $\frac{TP}{TP+FP}=\frac{a}{a+c}$ | Fra i record predetti positivi, quanti sono davvero positivi. |
| Richiamo (*recall*) $r$, o TPR | $\frac{TP}{TP+FN}=\frac{a}{a+b}$ | Fra i positivi reali, quanti vengono rilevati. |
| Tasso di falsi positivi (FPR) | $\frac{FP}{FP+TN}=\frac{c}{c+d}$ | Fra i negativi reali, quanti sono classificati positivi. |
| Misura F ($F_1$) | $\frac{2rp}{r+p}=\frac{2TP}{2TP+FP+FN}$ | Media armonica di precisione e richiamo. |

In un test visto come verifica di un'ipotesi nulla, $\alpha$ è la probabilità di rifiutare l'ipotesi nulla quando è vera: errore di tipo I, corrispondente a un falso positivo. $\beta$ è la probabilità di accettarla quando è falsa: errore di tipo II, corrispondente a un falso negativo.

I confronti delle slide mostrano che due modelli possono avere la stessa accuratezza ma comportarsi diversamente sulla classe rara. Per esempio, con 50 positivi e 50 negativi, il modello A ha $TP=40$, $FN=10$, $FP=10$, $TN=40$: precisione, richiamo, F e accuratezza valgono tutti $0{,}8$, mentre $TPR/FPR=4$. Il modello B ha gli stessi $TP$ e $FN$, ma $FP=1000$ e $TN=4000$: accuratezza circa $0{,}8$, richiamo $0{,}8$, precisione circa $0{,}04$ e F circa $0{,}08$. Lo sbilanciamento modifica precisione e F anche quando TPR e FPR restano uguali.

Nel caso B, con 5 000 negativi e 50 positivi, il classificatore mantiene $TP=40$, $FN=10$, $FP=1000$ e $TN=4000$: precisione circa $0{,}038$, TPR $0{,}8$, FPR $0{,}2$, F circa $0{,}07$ e accuratezza circa $0{,}8$. Il rapporto TPR/FPR vale 4 come nel caso A, ma la precisione è molto più bassa perché i falsi positivi sono numerosi rispetto ai positivi reali.

Un altro confronto mostra che i criteri possono favorire modelli diversi: con 50 positivi e 100 negativi, il modello A ha $TP=10,FN=40,FP=10,TN=40$ (precisione $0{,}5$, TPR $0{,}2$, F $0{,}28$, FPR $0{,}2$); B ha $TP=25,FN=25,FP=25,TN=25$ (precisione $0{,}5$, TPR $0{,}5$, F $0{,}5$, FPR $0{,}5$); C ha $TP=40,FN=10,FP=40,TN=10$ (precisione $0{,}5$, TPR $0{,}8$, F $0{,}61$, FPR $0{,}8$). B o C possono essere preferibili a seconda del costo relativo dei falsi allarmi e dei positivi mancati.

### Curve ROC e AUC

La curva ROC (*Receiver Operating Characteristic*) rappresenta il compromesso fra tasso di veri positivi (TPR, tasso di rilevamento) e tasso di falsi positivi (FPR, tasso di falso allarme). Nella convenzione usata qui, l'asse orizzontale è FPR e quello verticale è TPR. La curva fu sviluppata negli anni Cinquanta per la teoria del rilevamento dei segnali rumorosi; ogni punto rappresenta le prestazioni del classificatore a una determinata soglia.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261118165511.png" width="500">
</div>

- $(0,0)$: tutti gli esempi sono dichiarati negativi.
- $(1,1)$: tutti gli esempi sono dichiarati positivi.
- $(0,1)$: classificazione ideale (TPR $=1$, FPR $=0$).
- La diagonale rappresenta una classificazione casuale; punti sotto la diagonale indicano prestazioni peggiori del caso casuale, equivalenti a predizioni sistematicamente invertite.

*Soglia* (*threshold*): valore di separazione applicato al punteggio continuo prodotto dal classificatore. Se la soglia viene abbassata, più record sono predetti positivi: TPR tende ad aumentare, ma può aumentare anche FPR. Alzandola, entrambi tendono a diminuire. La soglia permette quindi di scegliere il compromesso adatto al costo degli errori nel problema.

> [!example] Soglia su dati unidimensionali
> Nell'esempio, i punti con $x>t$ vengono classificati positivi. Alla soglia mostrata, $TPR=0{,}5$, $FNR=0{,}5$, $FPR=0{,}12$ e $TNR=0{,}88$. La curva ROC visualizza questo punto e gli altri compromessi ottenuti spostando $t$.

> [!example] Punteggio prodotto da un albero
> Un albero può associare a una foglia la proporzione di esempi positivi che contiene. Questo valore continuo permette di ordinare i record dal più al meno probabile positivo e di provare soglie differenti.
> ![[Pasted image 20261118170617.png|500]]

Le immagini successive mostrano come cambiano la matrice di confusione e il punto ROC variando la soglia: a una soglia bassa si classificano più record come positivi; aumentando la soglia diminuiscono i positivi predetti e si sposta il punto sulla curva.
> [!example] Esempi di soglie e curva ROC
> ![[Pasted image 20261118170645.png|500]]
> ![[Pasted image 20261118170714.png|500]]

Per tracciare una curva ROC il classificatore deve assegnare un punteggio continuo a ciascun record. Si ordinano i record in ordine decrescente di punteggio, si applica una soglia per ciascun punteggio distinto e si contano $TP,FP,TN,FN$. Poi, per ogni soglia, si calcolano $TPR=TP/(TP+FN)$ e $FPR=FP/(FP+TN)$. Molti classificatori possono fornire punteggi continui: alberi, classificatori basati su regole, reti neurali, classificatori bayesiani, $k$-nearest neighbors e SVM.

| Istanza | Punteggio | Classe reale |
|---:|---:|:---:|
| 1 | 0,95 | + |
| 2 | 0,93 | + |
| 3 | 0,87 | − |
| 4 | 0,85 | − |
| 5 | 0,85 | − |
| 6 | 0,85 | + |
| 7 | 0,76 | − |
| 8 | 0,53 | + |
| 9 | 0,43 | − |
| 10 | 0,25 | + |

La tabella seguente mostra i conteggi e le coordinate ROC a ogni soglia della slide. I punteggi 0,85 sono uguali: la curva effettiva aggiorna i conteggi quando si include il gruppo alla stessa soglia; le colonne intermedie della slide mostrano anche i passaggi all'interno del gruppo.

| Soglia ≥ | TP | FP | TN | FN | TPR | FPR |
|---:|---:|---:|---:|---:|---:|---:|
| 0,25 | 5 | 5 | 0 | 0 | 1,0 | 1,0 |
| 0,43 | 4 | 5 | 0 | 1 | 0,8 | 1,0 |
| 0,53 | 4 | 4 | 1 | 1 | 0,8 | 0,8 |
| 0,76 | 3 | 4 | 1 | 2 | 0,6 | 0,8 |
| 0,85 (dopo 1 negativo) | 3 | 3 | 2 | 2 | 0,6 | 0,6 |
| 0,85 (dopo 2 negativi) | 3 | 2 | 3 | 2 | 0,6 | 0,4 |
| 0,85 (dopo il positivo) | 3 | 1 | 4 | 2 | 0,6 | 0,2 |
| 0,87 | 2 | 1 | 4 | 3 | 0,4 | 0,2 |
| 0,93 | 2 | 0 | 5 | 3 | 0,4 | 0,0 |
| 0,95 | 1 | 0 | 5 | 4 | 0,2 | 0,0 |
| 1,00 | 0 | 0 | 5 | 5 | 0,0 | 0,0 |

La curva è formata dai punti $(FPR,TPR)$ ottenuti, ordinati dal caso in cui tutti sono positivi a quello in cui tutti sono negativi. L'area sotto la curva (*Area Under the Curve*, AUC) riassume la curva: vale 1 per un classificatore ideale e 0,5 per una classificazione casuale. Il grafico di confronto mostra che nessun modello domina sempre: $M_1$ è migliore quando si vuole un FPR piccolo, mentre $M_2$ è migliore per FPR più grandi. La scelta dipende dal costo accettabile dei falsi allarmi.
<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261118170803.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261118170822.png" width="500">
</div>

### Confrontare classificatori con classi sbilanciate

Nessuna misura è ideale in ogni situazione. Anche classificatori casuali possono ottenere valori alti su alcune metriche; TPR e FPR sono utili ma non bastano sempre. $C_1$ è strettamente migliore di $C_2$ quando ha TPR maggiore e FPR minore, oppure quando ha lo stesso TPR e FPR minore, o lo stesso FPR e TPR maggiore.

La misura F di un classificatore può peggiorare rispetto a un altro quando cambia lo sbilanciamento dei dataset, anche se le sue prestazioni TPR/FPR restano uguali. La scelta dipende dal rapporto tra classi, dall'importanza di veri positivi e falsi positivi e dai costi o tempi delle decisioni.

Le tre matrici delle slide confrontano i classificatori $T_1,T_2,T_3$ su dataset con sbilanciamento basso, medio e alto. Le prestazioni TPR/FPR dei modelli restano rispettivamente $(0{,}5,0{,}01)$, $(0{,}99,0{,}1)$ e $(0{,}99,0{,}01)$, ma la precisione e la misura F cambiano con la prevalenza dei positivi:

| Modello | Precisione bassa / media / alta | TPR | FPR | F bassa / media / alta |
|---|---|---:|---:|---|
| $T_1$ | 0,98 / 0,83 / 0,3 | 0,5 | 0,01 | 0,66 / 0,62 / 0,375 |
| $T_2$ | 0,9 / 0,5 / 0,09 | 0,99 | 0,1 | 0,94 / 0,66 / 0,165 |
| $T_3$ | 0,99 / 0,9 / 0,5 | 0,99 | 0,01 | 0,99 / 0,94 / 0,66 |

Nel caso ad alto sbilanciamento, anche un FPR dell'1% può produrre molti falsi positivi rispetto ai veri positivi. Per questo $T_2$, pur avendo un richiamo elevato, scende a $F=0{,}165$; $T_3$ mantiene F maggiore perché combina TPR alto e FPR basso.

Per addestrare un classificatore su dati sbilanciati si può modificare la distribuzione del training set, così che la classe rara sia rappresentata meglio:

- *undersampling*: si riducono gli esempi della classe maggioritaria;
- *oversampling*: si aumentano gli esempi della classe rara.

## Capitolo dal libro: generalizzazione e potatura

Il libro chiarisce che l'obiettivo dell'apprendimento è trovare un'ipotesi che si adatti ai dati di training e generalizzi sui dati non osservati. Aumentare il numero di attributi o la dimensione dello spazio delle ipotesi rende più probabile l'overfitting; aumentare gli esempi di training lo rende meno probabile. Un modello capace può descrivere sia regolarità reali sia coincidenze del campione.

Per gli alberi, la potatura elimina nodi che non sembrano rilevanti. Si considera un test i cui discendenti sono foglie e lo si sostituisce con una foglia quando sembra rilevare solo rumore. Se l'attributo è irrilevante, i sottoinsiemi prodotti dallo split dovrebbero mantenere proporzioni di positivi e negativi simili a quelle del nodo; il guadagno informativo atteso è quindi vicino a zero.

Il libro descrive il test $\chi^2$ per verificare la significatività dello split. L'ipotesi nulla afferma che l'attributo sia irrilevante. Se nel nodo ci sono $p$ esempi positivi e $n$ negativi, nel sottoinsieme $k$ con $p_k+n_k$ record i conteggi attesi sotto l'ipotesi di irrilevanza sono:
$$\hat p_k=p\frac{p_k+n_k}{p+n},\qquad \hat n_k=n\frac{p_k+n_k}{p+n}.$$
La deviazione tra conteggi osservati e attesi è:
$$\Delta=\sum_{k=1}^{d}\left(\frac{(p_k-\hat p_k)^2}{\hat p_k}+\frac{(n_k-\hat n_k)^2}{\hat n_k}\right),$$
e, sotto l'ipotesi nulla, segue una distribuzione $\chi^2$ con $d-1$ gradi di libertà, dove $d$ è il numero di valori dell'attributo. Nell'esempio del libro per l'attributo *Type*, con quattro valori e quindi tre gradi di libertà, $\Delta\geq7{,}82$ rifiuta l'ipotesi nulla al 5%; $\Delta\geq11{,}35$ la rifiuta all'1%. Valori inferiori portano a considerare l'attributo irrilevante e a potare il ramo.

Il validation set permette di confrontare modelli di complessità diversa. In genere l'errore di training diminuisce man mano che cresce la complessità, mentre l'errore di validation può prima scendere e poi salire: il minimo della curva identifica il compromesso fra underfitting e overfitting. Il libro precisa che il comportamento dipende dalla famiglia di modelli: alcune curve possono continuare a migliorare aumentando la capacità. Dopo aver scelto gli iperparametri con il validation set, si può riaddestrare il modello sui dati di training disponibili e usare il test set tenuto da parte per la valutazione finale.

