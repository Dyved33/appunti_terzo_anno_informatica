# Algebra relazionale

## L'algebra relazionale

L'algebra relazionale è un linguaggio per l'interrogazione di BD basate sul modello relazionale:

- è costituita da un insieme di operatori unari e binari su istanze di relazioni: ciascun operatore ha come argomento una o due istanze di relazioni e produce una nuova istanza di relazione;
- è un linguaggio procedurale: viene specificata la sequenza di operazioni necessarie per ottenere il risultato atteso.

L'algebra relazionale è importante perché:

- è il fondamento formale per le operazioni nel modello relazionale;
- è la base per implementare e ottimizzare le interrogazioni nei RDBMS commerciali;
- alcuni suoi concetti sono incorporati nel linguaggio di interrogazione SQL, standard per i RDBMS.

## Operatori dell'algebra relazionale

Gli operatori possono essere classificati in:

1. **Operatori insiemistici:** unione, intersezione, differenza, prodotto cartesiano.
2. **Operatori propriamente relazionali:** ridenominazione, selezione, proiezione, concatenazione (join), divisione.

Non tutti i precedenti operatori sono primitivi: l'intersezione, la concatenazione e la divisione possono infatti essere espressi mediante i restanti operatori (lo vedremo).

## La ridenominazione

Inizieremo illustrando gli operatori insiemistici; poiché semplice e utile nel contesto delle operazioni insiemistiche, presentiamo prima l'operatore relazionale di ridenominazione.

*Definizione:* data un'istanza di relazione $r$ sullo schema di relazione $R(A_1, \dots, A_n)$, la ridenominazione

$$\rho_{S(A_1 \to B_1, \dots, A_n \to B_n)}(r)$$

del nome di relazione $R$ con il nome di relazione $S$ e degli attributi $A_1, \dots, A_n$ con $B_1, \dots, B_n$ è definita dall'istanza di relazione $s$ sullo schema di relazione $S(B_1, \dots, B_n)$, dove:

$$s = \{(B_1, v_1), \dots, (B_n, v_n) \mid (A_1, v_1), \dots, (A_n, v_n) \in r\}$$

Nel seguito utilizzeremo le notazioni:

- $\rho_S(r)$ per indicare una ridenominazione del solo nome di relazione;
- $\rho_{A_1 \to B_1, \dots, A_j \to B_j}(r)$ per indicare una ridenominazione dei soli attributi $A_1, \dots, A_j$ in $B_1, \dots, B_j$;
- $S(B_1, \dots, B_n) \leftarrow R(A_1, \dots, A_n)$ oppure $S \leftarrow R$ per indicare la ridenominazione in una sequenza di operazioni dell'algebra relazionale.

## Operatori insiemistici

La seguente definizione introduce la nozione di compatibilità all'unione per due schemi di relazione, utile a definire nel seguito gli operatori insiemistici di unione, intersezione e differenza.

*Definizione:* le relazioni $R(A_1, \dots, A_n)$, $S(B_1, \dots, B_m)$ sono dette **compatibili all'unione** sse:

- hanno lo stesso grado, ovvero $n = m$;
- $\forall i = 1 \dots n : \text{Dom}(A_i) = \text{Dom}(B_i)$.

### L'unione

*Definizione:* siano $r$, $s$ due istanze di relazione i cui schemi ($R(X)$ ed $S(Y)$, rispettivamente) sono compatibili all'unione. L'unione applicata a $r$, $s$, indicata con $r \cup s$, è una relazione sull'insieme di attributi $X$ contenente le tuple che appartengono ad $r$ oppure ad $s$:

$$r \cup s = \{t \mid t \in r \lor t \in s\}$$

### L'intersezione

*Definizione:* siano $r$, $s$ due istanze di relazione i cui schemi ($R(X)$ ed $S(Y)$, rispettivamente) sono compatibili all'unione. L'intersezione applicata a $r$, $s$, indicata con $r \cap s$, è una relazione sull'insieme di attributi $X$ contenente le tuple che appartengono sia ad $r$ che ad $s$:

$$r \cap s = \{t \mid t \in r \land t \in s\}$$

### La differenza

*Definizione:* siano $r$, $s$ due istanze di relazione i cui schemi ($R(X)$ ed $S(Y)$, rispettivamente) sono compatibili all'unione. La differenza $r \setminus s$ è una relazione sull'insieme di attributi $X$ contenente le tuple che appartengono ad $r$ ma non appartengono ad $s$:

$$r \setminus s = \{t \mid t \in r \land t \notin s\}$$

### Esempio

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261009095408.png" style="width: 100%;">
</div>

## Il prodotto cartesiano

L'ultimo operatore insiemistico dell'algebra relazionale è il prodotto cartesiano.

*Definizione:* siano $R(X)$, $S(Y)$ due schemi di relazione tali che $X = \{A_1, \dots, A_n\}$, $Y = \{B_1, \dots, B_m\}$ ed $X \cap Y = \emptyset$, e si considerino due istanze di relazione $r$, $s$ sugli schemi $R(X)$, $S(Y)$. L'operatore di prodotto cartesiano $r \times s$ produce un'istanza di relazione formata da tutte le tuple che è possibile ottenere unendo le tuple di $r$ ed $s$:

$$r \times s = \{\{(A_1, v_1), \dots, (A_n, v_n)\} \cup \{(B_1, v_1), \dots, (B_m, v_m)\} \mid \{(A_1, v_1), \dots, (A_n, v_n)\} \in r \land \{(B_1, v_1), \dots, (B_m, v_m)\} \in s\}$$

### Esempio

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261009095431.png" style="width: 100%;">
</div>

## Selezione e proiezione

Gli operatori di selezione e proiezione sono operatori unari che svolgono funzioni complementari:

- la selezione produce come risultato un'istanza di relazione costituita da un sottoinsieme di tuple dell'istanza di relazione in input;
- la proiezione produce come risultato un'istanza di relazione costituita da un sottoinsieme di colonne della tabella che illustra l'istanza di relazione in input.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261009095505.png" style="width: 100%;">
</div>

### La selezione

L'operatore di selezione è denotato con il simbolo $\sigma_F$, dove $F$ rappresenta la condizione di selezione.

*Definizione:* data $R(X)$, una **condizione di selezione** su $X$ è una formula proposizionale $F$, ovvero una formula ottenuta combinando con i connettivi $\land$, $\lor$ e $\lnot$ condizioni atomiche (clausole) del tipo $A \theta B$ oppure $A \theta c$, dove:

- $\theta$ è un operatore di confronto: $\theta \in \{=, \ne, >, \ge, \le, <\}$;
- $A$ e $B$ sono attributi in $X$ sui cui valori il confronto $\theta$ abbia senso;
- $c$ è una costante compatibile con il dominio di $A$.

Data una tupla $t$ in un'istanza di relazione $r$ sullo schema $R(X)$:

- $A \theta B$ è vera su $t$ sse $t[A]$ è in relazione $\theta$ con $t[B]$;
- $A \theta c$ è vera su $t$ sse $t[A]$ è in relazione $\theta$ con $c$;
- $F_1 \lor F_2$, $F_1 \land F_2$, $\lnot F_1$ hanno l'usuale significato.

*Definizione:* data un'istanza di relazione $r$ sullo schema $R(X)$ ed una condizione di selezione $F$ (su $X$), l'operazione di selezione $\sigma_F(r)$ produce una relazione su $X$ che contiene le sole tuple di $r$ su cui $F$ è vera:

$$\sigma_F(r) = \{t \mid t \in r \land t \models F\}$$

### Esempio selezione

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261009095736.png" style="width: 100%;">
</div>

### La proiezione

*Definizione:* data un'istanza di relazione $r$ sullo schema $R(X)$ ed un sottoinsieme di attributi $Y \subseteq X$, l'operazione di proiezione $\pi_Y(r)$ è definita da:

$$\pi_Y(r) = \{t[Y] \mid t \in r\}$$

ovvero $\pi_Y(r)$ contiene le tuple su $Y$ ottenute dalle tuple di $r$ considerando solo i valori su $Y$.

### Esempio proiezione

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261009095818.png" style="width: 100%;">
</div>

> [!info] Sintesi:
> - L'algebra relazionale è un linguaggio procedurale di operatori unari e binari su istanze di relazioni; è il fondamento formale del modello relazionale e la base per l'ottimizzazione delle interrogazioni nei RDBMS.
> - Gli operatori si dividono in insiemistici (unione, intersezione, differenza, prodotto cartesiano) e propriamente relazionali (ridenominazione, selezione, proiezione, join, divisione); intersezione, join e divisione sono derivabili dagli altri.
> - La ridenominazione $\rho$ cambia nome di relazione e attributi; unione, intersezione e differenza richiedono schemi compatibili all'unione (stesso grado e stessi domini).
> - Il prodotto cartesiano combina ogni tupla di $r$ con ogni tupla di $s$, richiedendo attributi disgiunti.
> - La selezione $\sigma_F$ estrae le tuple che soddisfano una formula proposizionale $F$; la proiezione $\pi_Y$ estrae i valori su un sottoinsieme di attributi $Y$.