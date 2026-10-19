Algebra Relazionale: L’Operatore Derivato di Divisione 

La Divisione 
- E’ un operatore derivato dell’algebra relazionale. 
- E’ un operatore binario. 
- Viene indicato con il simbolo ÷. 
- E’ intuitivamente la controparte algebrica della quantificazione universale.

//servirebbe un esempio//

Definizione :
Siano R(X), S(Y ) due schemi di relazione tali che Y ⊂ X e siano r,s due istanze di R, S. L’operazione di divisione r ÷ s produce una relazione le cui tuple, se estese con una qualunque tupla del secondo operando, producono una tupla del primo operando: r ÷ s = = {t | ∀t 0 ∈ s : t ∪ t 0 ∈ r} = {t | {t} × s ⊆ r}

La divisione r ÷ s e’ dunque definita sugli attributi X \ Y

Derivazione della Divisione La Divisione: Derivazione dagli operatori dell’algebra relazionale di base della divisione. % Proietto su Z = X \ Y il primo operando T 1(Z) ← πZ (R) % Costruisco l’universo U U(X) ← T 1 × S % Individuo le tuple da non ammettere nel risultato T 2(Z) ← πZ (U \ R) % Ottengo il risultato Ris(Z) ← T 1 \ T 2

Algebra Relazionale e Null • La presenza di valori nulli nelle istanze di una BD richiede un’estensione della semantica degli operatori. • L’approccio tradizionale (usato nei DBMS basati sul meodello relazionale ed in SQL) e’ quello di considerare una logica a tre valori per la valutazione delle formule proposizionali e quindi degli operatori di selezione e concatenazione (join)

π, ∪, ∩, \ e valori nulli 
π, ∪, ∩, \ e valori nulli • Proiezione, unione, intersezione e differenza continuano a comportarsi usualmente. • L’uguaglianza tra Null e’ a livello sintattico e due tuple sono uguali anche se ci sono valori nulli.

σ e valori nulli
σ e valori nulli • Per la selezione, il problema e’ stabilire se, in presenza di Null, un predicato e’ vero oppure meno per una data tupla. • Guardiamo l’esempio che segue per capire meglio . . .

σF e valori nulli: Valutazione delle formule atomiche in F • per valutare predicati come quello dell’esempio precedente, si introduce una logica a tre valori • In partcolare, oltre ai valori Vero (V) e Falso (F) si ha un terzo valore Indefinito (?) Le tabelle di verita’ sopra possono essere estese ad altri tipi di confronto. Se D e’ un dominio su cui e’ definito un ordinamento < (risp. >,≤,≥) allora il confronto xθy (θ ∈ {<, >≤, ≥}) e’ ? se x e’ ? oppure y e’ ?.

σF e valori nulli: Valutazione della condizione di selezione F Infine, la tabella di verita’ le tabelle di verita’ nella logica a tre valori per gli operatori booleani sono: σF e valori nulli La selezione σF produce le sole tuple per cui la condizione di selezione F risulta vera (V). Per lavorare esplicitamente con i valori nulli si intro

//serve un esempio//

Concatenazione e valori nulli Concatenazione e valori nulli • Per il θ-join valgono le stesse regole per la valutazione della condizione di join F secondo la logica a tre valori. • il join naturale non combina due tuple se queste hanno entrambe valore nullo su un attributo in comune.

//serve un esempio//