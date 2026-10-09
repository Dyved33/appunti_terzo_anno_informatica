Algebra Relazionale
Linguaggio per l’interrogazione di BD basate sul modello relazionale: 
- E’ costituita da un insieme di operatori unari e binari su istanze di relazioni: 
	- ciascun operatore ha come argomento una o due istanze di relazioni e produce una nuova istanza di relazione. 
- E’ un linguaggio procedurale: viene specificata la sequenza di operazioni necessarie per ottenere il risultato atteso. 
- L’algebra relazionale e’ importante perche’: 
	- fondamento formale per le operazioni nel modello relazionale 
	- base per implementare ed ottimizzare le interrogazioni nei RDBMS commerciali 
	- alcuni suoi concetti sono incorporati nel linguaggio di interrogazione SQL, standard per i RDBMS

Gli operatori dell’algebra relazionale possono essere classificati in: 
1. Operatori Insiemistici: 
	- unione, intersezione, di↵erenza, prodotto cartesiano 
2. Operatori Propriamente Relazionali: 
	- ridenominazione, selezione, proiezione, concatenazione (join), divisione 
	
Non tutti i precedenti operatori sono primitivi: l’intersezione, la concatenazione e la divisione possono infatti essere espressi mediante i restanti operatori (lo vedremo).

La Ridenominazione $/rho_{(r)}$ 
Data un’ istanza di relazione r sullo schema di relazione R(A_1,..., A_n), la ridenominazione: $/rho_{S}(A_1->B_1,...,A_n->B->n)(r)$ del nome di relazione R con il nome di relazione S e degli attributi A_1,..., A_n con B_1,..., B_n e’ definita dall’ istanza di relazione s sullo schema di relazione S(B_1,..., B_n), dove: $s = {{(B_1, v_1),...,(B_n, v_n)}|{(A_1, v_1),...,(A_n, v_n)} /appartiene r}$

Nel seguito utilizzeremo le notazioni: 
- $/rho_S(r)$ per indicare una ridenominazione del solo nome di relazione 
- $/rho_{A_{1} -> B_{1},\dots, A_{j}->B_{j}}(r)$ per indicare una ridenominazione dei soli attributi $A_1,..., A_j in B_1,..., B_j$
- $S(B_{1},..., B_{n}) <- R(A_{1},..., A_{n})$ oppure $S <- R$ per indicare la ridenominazione in una sequenza di operazioni dell’algebra relazionale

La seguente definizione introduce la nozione di compatibilita all’unione per due schemi di relazione, utile a definire nel seguito gli operatori insiemistici dell’algebra relazionale di unione, intersezione e di↵erenza.

Relazioni Compatibili all’Unione Le relazioni $R(A _{1},..., A_{n}), S(B_{1},..., B_{m})$ sono dette compatibili all’unione sse: 
- hanno lo stesso grado, ovvero n = m 
- $per ogni i =1 ... n : Dom(A_{i})= Dom(B_{i})$

L’Unione 
Unione di Relazioni Siano r,s sue istanza di relazione i cui schemi (R(X) ed S(Y ), rispettivamente) sono compatibili all’unione. L’unione applicata ad r,s, indicata con r [ s e’ una relazione sull’insieme di attributi X contenente le tuple che appartengono ad r oppure ad s: r [ s = {t | t 2 r _ t 2 s}

L’Intersezione 
Intersezione di Relazioni Siano r,s sue istanza di relazione i cui schemi (R(X) ed S(Y ), rispettivamente) sono compatibili all’unione. L’intersezione applicata ad r,s, indicata con r \ s e’ una relazione sull’insieme di attributi X contenente le tuple che appartengono sia ad r che ad s: r \ s = {t | t 2 r ^ t 2 s}

La Differenza 
Differenza di Relazioni Siano r,s sue istanza di relazione i cui schemi (R(X) ed S(Y ), rispettivamente) sono compatibili all’unione. La di↵erenza r \ s e’ una relazione sull’insieme di attributi X contenente le tuple che appartengono ad r ma non appartengono ad s: r \ s = {t | t 2 r ^ t 2/ s}

![[Pasted image 20261009095408.png]]

Il Prodotto Cartesiano 
L’ultimo operatore insiemistico dell’algebra relazionale e’ il prodotto cartesiano. Prodotto Cartesiano di Relazioni Siano R(X), S(Y ) due schemi di relazione tali che X = {A 1,..., An}, Y = {B 1,..., Bm} ed X \ Y = ; e si considerino due istanze di relazione r,s sugli schemi R(X), S(Y ). L’operatore di prodotto cartesiano r ⇥ s produce un’istanza di relazione formata da tutte le tuple che e’ possibile ottenere unendo le tuple di r ed s: r ⇥ s = {{(A 1, v 1),...,(An, vn)} [ {(B 1, v 1),...,(Bn, vm)}| {(A 1, v 1),...,(An, vn)} 2 r ^ {(B 1, v 1),...,(Bn, vm)} 2 s}

![[Pasted image 20261009095431.png]]

Selezione e Proiezione 
Gli operatori di selezione e proiezione sono operatori unari che svolgono funzioni complementari: • La selezione produce come risultato un’istanza di relazione costituita da un sottoinsieme di tuple dell’istanza di relazione in input • La proiezione produce come risultato un’istanza di relazione costituita da un sottoinsieme di colonne della tabella che illustra l’istanza di relazione in input.

![[Pasted image 20261009095505.png]]

La selezione L’operatore di selezione e’ denotato con il simbolo F , dove F rappresenta la condizione di selezione. Condizione di Selezione Data R(X), una condizione di selezione su X e’ una formula proposizionale F, ovvero una formula ottenuta combinando con i connettivi ^, _ e ¬ condizioni atomiche (clausole) del tipo A✓B oppure A✓c, dove: • ✓ e’ un operatore di confronto $theta appartiene {uguale, diverso, >, maggiore o uguale, minore o uguale, <}$
• A e B sono attributi in X sui cui valori il confronto ✓ abbia senso • c e’ una costante compatibile con il dominio di A Data una tupla t in un’istanza di relazione r sullo schema R(X): • A✓B e’ vera su t sse t[A] e’ in relazione ✓ con t[B] • A✓c e’ vera su t sse t[A] e’ in relazione ✓ con c • F 1 _ F 2, F 1 ^ F 2, ¬F 1 hanno l’usuale significato

L’Operatore di Selezione 
La Selezione F Data un’istanza di relazione r sullo schema R(X) ed una condizione di selezione F (su X), l’operazione di selezione F (r) produce una relazione su X che contiene le sole tuple di r su cui F e’ vera: F (r)= {t | t 2 r ^ t |= F}

ESEMPIO SELEZIONE
![[Pasted image 20261009095736.png]]

L’Operatore di Proiezione 
La Proiezione ⇡Y Data un’istanza di relazione r sullo schema R(X) ed un sottoinsieme di attributi Y ✓ X, l’operazione di proiezione ⇡Y (r) e’ definita da: ⇡Y (r)= {t[Y ] | t 2 r} ovvero ⇡Y (r) contiene le tuple su Y ottenute dalle tuple di r considerando solo i valori su Y .

ESEMPIO PROIEZIONE
![[Pasted image 20261009095818.png]]