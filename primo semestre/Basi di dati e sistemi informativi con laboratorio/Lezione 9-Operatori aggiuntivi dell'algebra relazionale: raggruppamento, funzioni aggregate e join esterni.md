# Lezione 9 - Operatori aggiuntivi dell'algebra relazionale: raggruppamento, funzioni aggregate e join esterni

## Operatori aggiuntivi dell'algebra relazionale

*Definizione:* Gli operatori aggiuntivi dell'algebra relazionale sono operatori che aumentano la capacità espressiva dell'algebra relazionale di base. Sono definiti per esprimere query utili nel contesto dei DBMS, non esprimibili con gli operatori primitivi dell'algebra relazionale.

Gli operatori aggiuntivi considerati sono:
- Raggruppamento e funzioni aggregate
- Join esterni

## Raggruppamento e funzioni aggregate

*Definizione:* L'operatore di raggruppamento permette di calcolare funzioni matematiche su gruppi di tuple definiti in base ai valori di un insieme di attributi.

**Sintassi.** Sia $r$ un'istanza di relazione sullo schema $R(X)$. L'espressione è:
$$
Y\ \mathcal{F}_{\langle listaFun\rangle}(r)
$$
dove:
- $Y \subseteq X$ è un insieme di attributi di $R$ (attributi di raggruppamento);
- $\langle listaFun\rangle$ è una lista di coppie $(f,A)$ con $f \in \{SUM, AVG, MAX, MIN, COUNT\}$ e $A \in X$.

*Osservazione:* Intuitivamente, si raggruppano le tuple di $r$ che hanno valori uguali sugli attributi in $Y$; per ogni gruppo si calcolano le funzioni indicate e si produce una tupla contenente gli attributi di raggruppamento e i risultati delle funzioni.

**Semantica.** Il risultato di $Y\ \mathcal{F}_{\langle listaFun\rangle}(r)$ è una relazione sullo schema
$$
Z = Y \cup \{ f(A) \mid (f,A) \in \langle listaFun\rangle\}
$$
(con la convenzione di dare un nome all'attributo risultante dalla funzione). Il calcolo avviene come segue:
- Le tuple di $r$ vengono partizionate in gruppi sulla base dei valori uguali sugli attributi di raggruppamento $Y$.
- Per ogni gruppo, si applicano le funzioni $(f,A)$ ai valori dell'attributo $A$ presenti nel gruppo.
- Da ogni gruppo si produce esattamente una tupla da inserire nel risultato.

*Esempio:* Raggruppare i dipendenti di ogni dipartimento e calcolarne lo stipendio medio.

**Raggruppamento vuoto.** È possibile omettere gli attributi di raggruppamento. In tal caso, le funzioni vengono applicate all'intero insieme di tuple della relazione (un unico gruppo).

## Join esterni

*Definizione:* I join esterni sono stati introdotti per evitare l'effetto di "scarto" delle tuple che non hanno controparte nell'altra relazione, tipico dei join visti in precedenza.

Esistono tre varianti:
- Join esterno sinistro
- Join esterno destro
- Join esterno completo

**Join esterno sinistro.** Include nel risultato tutte le tuple del primo operando, eventualmente estendendole con valori NULL.

**Join esterno destro.** Include nel risultato tutte le tuple del secondo operando, eventualmente estendendole con valori NULL.

**Join esterno completo.** Include nel risultato tutte le tuple del primo e del secondo operando, eventualmente estendendole con valori NULL.

> [!info] Sintesi:
> - Gli operatori aggiuntivi ampliano l'algebra relazionale per esprimere query utili nei DBMS.
> - Il raggruppamento $Y\ \mathcal{F}_{\langle listaFun\rangle}(r)$ partiziona le tuple per $Y$ e calcola funzioni aggregate (SUM, AVG, MAX, MIN, COUNT) per gruppo.
> - Se $Y$ è vuoto, le funzioni aggregate sono calcolate sull'intera relazione.
> - I join esterni (sinistro, destro, completo) mantengono le tuple senza controparte, estendendole con NULL.