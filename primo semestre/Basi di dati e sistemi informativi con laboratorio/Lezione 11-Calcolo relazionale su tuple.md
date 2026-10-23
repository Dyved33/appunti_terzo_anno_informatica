# Lezione 11 - Calcolo relazionale su tuple

## Calcolo relazionale su tuple
Il calcolo relazionale su tuple è un linguaggio di interrogazione formale per il modello relazionale.

*   **Dichiarativo**, ovvero non procedurale: si specifica *cosa* si vuole ottenere, non *come* ottenerlo.
*   **Base per SQL**: SQL si ispira direttamente al calcolo relazionale.
*   **Stesso potere espressivo dell'algebra relazionale di base**: qualunque query esprimibile in uno lo è anche nell'altro.

> [!info] In altre parole:
> L'algebra relazionale dice *come* costruire il risultato (sequenza di operazioni). Il calcolo relazionale dice *che proprietà* deve avere il risultato (condizione logica).

## Linguaggio relazionale completo
*Definizione:* Un linguaggio di interrogazione relazionale **L** si dice **completo** se ha lo stesso potere espressivo del calcolo relazionale.

L'algebra relazionale è dunque un linguaggio relazionale completo. La maggior parte dei linguaggi di interrogazione per RDBMS commerciali (come SQL) è completa, ma ha **più potere espressivo** dell'algebra relazionale di base (e del calcolo relazionale) — ad esempio per aggregazioni, ordinamento, aggiornamenti.

<div style="display: flex; justify-content: center;">
  <img src="slide-08.png" style="width: 100%; border-radius: 8px;">
</div>

*Figure 5.7 – Vincoli di integrità referenziale sullo schema relazionale COMPANY (da Elmasri & Navathe).*

## Esempio
> [!example] Query in calcolo relazionale su tuple
> Si determini la data di nascita e l'indirizzo dell'impiegata **Lia Bo**.
>
> $$ \{ t.Bdate, t.Address \mid Employee(t) \land t.Fname = \text{'Lia'} \land t.Lname = \text{'Bo'} \} $$

*Esempio formale: proiezione su attributi selezionati con condizione di selezione.*

## Calcolo relazionale: sintassi
Un'**espressione del calcolo relazionale su tuple** ha la forma:

$$ \{T \mid C\} $$

dove:

*   **T** (target list) è la lista degli obiettivi dell'interrogazione. È una lista di elementi del tipo $t.A$ in cui:
    *   $t$ è una **variabile di tupla**,
    *   $A$ è un **attributo** della relazione sulle cui tuple prende valore $t$.
*   Se $t_1, \dots, t_n$ sono le variabili di tupla che compaiono in **T**, allora **C = COND(t_1, \dots, t_n)** è una **condizione**, ovvero una *formula del calcolo relazionale* su $t_1, \dots, t_n$.

> [!info] In altre parole:
> $T$ dice *quali colonne* restituire (come `SELECT` in SQL), $C$ dice *quali righe* selezionare (come `WHERE`).

## Atomo del calcolo relazionale
Per definire le formule, si introduce la nozione di **atomo**. Un atomo del calcolo relazionale è un'espressione appartenente a uno dei tre tipi seguenti:

1.  **R(t)** — dove **R** è un nome di relazione e **t** una variabile di tupla (es. $Employee(t)$). Significa: «la tupla t appartiene alla relazione R».
2.  **ti.A θ tj.B** — dove **θ ∈ {=, ≠, <, >, ≤, ≥}**, $t_i$ e $t_j$ sono variabili di tupla, $A$ e $B$ attributi delle relazioni su cui prendono valore $t_i$, $t_j$ (es. $t.Fname = s.Fname$ con $t$, $s$ su $Employee$).
3.  **t.A θ c** — dove **θ ∈ {=, ≠, <, >, ≤, ≥}**, $t$ è una variabile di tupla, $A$ attributo della relazione su cui $t$ prende valore, $c$ è una **costante** (es. $t.Lname = \text{'Bo'}$).

## Formule del calcolo relazionale
La nozione di **formula** è definita induttivamente:

1.  **Ogni atomo** è una formula.
2.  Se $F_1$, $F_2$ sono formule, allora $F_1 \lor F_2$, $F_1 \land F_2$, $\lnot F_1$ sono formule (connettivi logici classici).
3.  Se $t$ è una variabile di tupla ed $F$ una formula, allora **∃t F** e **∀t F** sono formule (quantificatori esistenziale e universale).

## Variabili libere e legate
Per dare la semantica alle formule serve distinguere le occorrenze di variabili **libere** da quelle **legate** (quantificate).

*Definizione formale:*
*   Se $F$ è un atomo, ogni occorrenza di variabile di tupla $t$ è **libera** in $F$.
*   Se $F \in \{F_1 \land F_2, F_1 \lor F_2, \lnot F_1\}$, un'occorrenza di $t$ è libera in $F$ se lo è nelle sottoformule in cui compare.
*   **Tutte** le occorrenze di $t$ libere in $F$ diventano **legate** in $\exists t F$ e $\forall t F$.

> [!example] Esempi di libere/legate 
>
> Si consideri la formula $$ F:\ d.name = \text{'Ricerca'} \quad\Rightarrow\quad d \text{ è libera} $$
>
> Si consideri la formula  $$ F_1:\ \exists d\,(Department(d) \land d.Dnumber = 5) \quad\Rightarrow\quad d \text{ è legata in } F_1 $$
>
> Si consideri la formula  $$ F_2:\ \exists d\,(Department(d) \land d.Dnumber = t.Dnumber) \quad\Rightarrow\quad d \text{ legata, } t \text{ libera in } F_2 $$

> [!important] Regola pratica
> In un'espressione $\{T \mid C\}$, **tutte** le variabili che compaiono in $T$ devono essere **libere** in $C$. Le variabili quantificate in $C$ non appaiono in $T$.

## Formule del calcolo relazionale: semantica
Il valore di verità di una formula è dato dalle regole seguenti (rispetto a un'istanza di database e un'assegnazione di tuple alle variabili libere):

1.  **R(t)** è vera se $t$ è assegnata a una tupla di $R$.
2.  **ti.A θ tj.B** (risp. **ti.A θ c**) è vera se le tuple assegnate a $t_i$, $t_j$ soddisfano la condizione sugli attributi (es. $t.Fname = \text{'Mario'}$ vera per le tuple con $Fname = \text{'Mario'}$).
3.  $F_1 \lor F_2,\ F_1 \land F_2,\ \lnot F_1$ hanno la solita semantica logica.
4.  **∃t F** è vera se $F$ è vera per **almeno una** tupla assegnata alle occorrenze libere di $t$ in $F$.
5.  **∀t F** è vera se $F$ è vera per **ogni** tupla assegnata alle occorrenze libere di $t$ in $F$.

## Espressioni del calcolo relazionale: semantica
> [!info] Sintesi
> Un'**espressione del calcolo relazionale** $\{T \mid C\}$ restituisce l'insieme delle tuple su cui la formula $C$ assume valore **vero**.

In pratica: si considerano tutte le possibili assegnazioni di tuple alle variabili libere di $C$; quelle che rendono $C$ vera determinano i valori degli attributi in $T$, che formano le tuple del risultato.

---

> [!info] Sintesi:
> - Il calcolo relazionale su tuple è **dichiarativo**, non procedurale, ed è la base formale di SQL.
> - Ha lo stesso potere espressivo dell'algebra relazionale di base → **linguaggio relazionale completo**.
> - Un'espressione è $\{T \mid C\}$: $T$ = attributi da restituire (target list), $C$ = condizione (formula).
> - Gli **atomi** sono di tre tipi: appartenenza a relazione ($R(t)$), confronto tra attributi ($t_i.A \;\theta\; t_j.B$), confronto con costante ($t.A \;\theta\; c$).
> - Le **formule** si costruiscono induttivamente con $\land, \lor, \lnot, \exists, \forall$.
> - Una variabile è **legata** se quantificata ($\exists t$, $\forall t$), altrimenti **libera**; in $\{T \mid C\}$ le variabili di $T$ devono essere libere in $C$.
> - Semantica: $\exists t F$ vera se $F$ vera per almeno una tupla; $\forall t F$ vera se $F$ vera per tutte le tuple.
> - Il risultato di $\{T \mid C\}$ sono le tuple che soddisfano $C$.