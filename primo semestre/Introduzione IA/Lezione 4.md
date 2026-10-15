Tutti gli algoritmi di ricerca sono uguali tranne per le strategie della frontiera. Concettualmente tutte le frontiere sono code di priorità. Praticamente, per DFS e BFS, si può evitare l'overhead log(n) di una coda di priorità usando code e stack (si può anche codificare un implementazione che prende un variable queuinig object)

Uniform cost search:
La strategia è quella di espandere il path dal costo minore

Vantaggio = UCS è completo e ottimale

Svantaggi = 
- Esplora opzioni in tutte le direzioni
- Non ci sono informazioni riguardo la posizione del goal

Search heuristics
Un euristica è:
- Una funzione che stima quanto uno stato è vicino al goal
- Designata per un particolare search problem

Esempio: la distanza di manhattan (//cosa è?//), distanza euclidea per il pathing (?)

> [!note]
> Ricorda cosa è una funzione euristica

Greedy search: espande il nodo che sembra il più vicino (sceglie l'ottimo locale ma non c'è motivo per il quale sia anche un ottimo globale)

> [!note] Best-First
> - priority queue (ordinata rispetto min //cosa significa?//)
> - $f(n) = g(n) + h(n)$ con $g(n)$ il costo dallo stato iniziale -> n e $h(n)$ è la stima del costo da n -> goal

$A^*$ search
È ottimo rispetto al costo (//cosa implica//) se l'euristica è ==ammissibile==. Ciò significa che non sovrastima mai il costo effettivo. Se lo sovrastimasse potremmo scegliere quella che ci sembra la soluzione migliore ma in realtà non lo è. Se l'euristica non esistono altre soluzioni migliori => $A^*$ è ottimo. 

Questa caratteristica crolla se facciamo la verifica del goal quando espando un nodo e cerco il goal tra i figli. 

Nell'A^* quando estraggo un nodo mi chiedo se è il goal, altrimenti lo estraggo

Questa caratteristica crolla se facciamo la verifica del goal quando espando un nodo e cerco il goal tra i figli. 

Admissible heuristics definizione: una euristica h è ammissibile (ottimistica) se $$
0 minoreo uguale h(n) minore o uguale h^*(n)
$$ dove $h^{*}(n)$ è il vero costo del goal più vicino

Ottimalità dell'A^* tree search: 
Si assuma che:
- A è un goal node ottimo
- B è un goal node sub ottimo
- H è ammissibile

Claim:  A uscirà dalla frontiera prima di B

Dimostrazione:
//slide 27 con foto a parte//

> [!note]
> Mentre nella UCS la frontiera si espande in tutte le direzioni, l'A^* si espande prevalentemente verso il goal 

//salta le applications e riprendi con creating heuristics//


| Problema            | Admissible heurisstics                      |
| ------------------- | ------------------------------------------- |
| Percorso            | Distanza linea aria                         |
| Percorso su griglia | Distanza linea aria o distanza di Manhattan |
> [!note]
> Un modo per trovare una buona euristica è cercare la soluzione come se non ci fossero vincoli (eliminare i vincoli)

> [!example] problema dell'eight puzzle
> 1. Spostare caselle occupate -> dist. Manhattan (da pos attuale a pos goal)
> 2. Spostarsi un passo alla volta -> numero tessere (non in pos goal)

> [!note]
> Le euristiche più vicine all'euristica del goal ci fanno arrivare allo stato goal più velocemente di euristiche più piccole ma lontane

Gran parte del lavoro nel risolvere search problem complessi ottimamente è attraverso le euristiche ammissibili. Spesso le euristiche ammissibili sono "soluzioni a problemi" rilassati dove nuove azioni sono disponibili

//la parte sull'8 puzzle correggila con le slide 40-43//

//inserisci contenuto e immagine della slide 45 e spiega//

Se ho h1 e h2 ammissibili ma non dominanti ho che max(h1,h2) è ammissibile ma h1 + h2 non lo è //?//

//inserisci le slide 47-50 con immagini//

Summary:
- A^* usa sia backward costs e da una stima di forward costs
- A^* è ottimo con un'euristica ammissibile
- Il design dell'euristica è la chiave, spesso si usano problemi rilassati

//aggiungi pseudocodici a slide 54-55//

Consistenza dell'euristica (specie di disuguaglianza triangolare)
![[Pasted image 20261015180349.png]]

//da 56 a 59 inserisci il contenuto con immagini//

