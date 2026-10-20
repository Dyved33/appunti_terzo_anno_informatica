## nullAlgebraRel.pdf (PDF, 96.9 KB)

- **Title**:  Basi di Dati  - Algebra Relazionale e Valori Nulli
- **Author**: Raffaella Gentilini 
- **Created**: D:20201020203859+02'00'
- **Modified**: D:20201020203859+02'00'
- **Pages**: 24
- **Format**: PDF
- **Word Count**: 1152

- Words: 1152 | Chars: 7,337 | Pages: 24

### Content

Basi di Dati
Algebra Relazionale e Valori Nulli
Raffaella Gentilini
October 20, 2020
Raffaella GentiliniBasi di Dati1 / 12

Algebra Relazionale:  L’Operatore Derivato di
Divisione
Algebra Relazionale e Null
•
La presenza di valori nulli nelle istanze di una BD richiede
un’estensione della semantica degli operatori.
•
L’approccio tradizionale (usato nei DBMS basati sul meodello
relazionale ed in SQL) e’ quello di considerare una logica a tre
valori per la valutazione delle formule proposizionali e quindi
degli operatori di selezione e concatenazione (join)
Raffaella GentiliniBasi di Dati2 / 12

Algebra Relazionale:  L’Operatore Derivato di
Divisione
Algebra Relazionale e Null
•
La presenza di valori nulli nelle istanze di una BD richiede
un’estensione della semantica degli operatori.
•
L’approccio tradizionale (usato nei DBMS basati sul meodello
relazionale ed in SQL) e’ quello di considerare una logica a tre
valori per la valutazione delle formule proposizionali e quindi
degli operatori di selezione e concatenazione (join)
Raffaella GentiliniBasi di Dati2 / 12

Algebra Relazionale:  L’Operatore Derivato di
Divisione
Algebra Relazionale e Null
•
La presenza di valori nulli nelle istanze di una BD richiede
un’estensione della semantica degli operatori.
•
L’approccio tradizionale (usato nei DBMS basati sul meodello
relazionale ed in SQL) e’ quello di considerare una logica a tre
valori per la valutazione delle formule proposizionali e quindi
degli operatori di selezione e concatenazione (join)
Raffaella GentiliniBasi di Dati2 / 12

π,∪,∩,\e valori nulli
π,∪,∩,\e valori nulli
•Proiezione, unione, intersezione e differenza continuano a
comportarsi usualmente.
•L’uguaglianza tra Null e’ a livello sintattico e due tuple sono
uguali anche se ci sono valori nulli.
Raffaella GentiliniBasi di Dati3 / 12

π,∪,∩,\e valori nulli
π,∪,∩,\e valori nulli
•Proiezione, unione, intersezione e differenza continuano a
comportarsi usualmente.
•L’uguaglianza tra Null e’ a livello sintattico e due tuple sono
uguali anche se ci sono valori nulli.
Raffaella GentiliniBasi di Dati3 / 12

π,∪,∩,\e valori nulli
π,∪,∩,\e valori nulli
•Proiezione, unione, intersezione e differenza continuano a
comportarsi usualmente.
•L’uguaglianza tra Null e’ a livello sintattico e due tuple sono
uguali anche se ci sono valori nulli.
Raffaella GentiliniBasi di Dati3 / 12

π,∪,∩,\e valori nulli
Raffaella GentiliniBasi di Dati4 / 12

π,∪,∩,\e valori nulli
Raffaella GentiliniBasi di Dati5 / 12

σe valori nulli
σe valori nulli
•Per la selezione, il problema e’ stabilire se, in presenza di Null,
un predicato e’ vero oppure meno per una data tupla.
•Guardiamo l’esempio che segue per capire meglio...
Raffaella GentiliniBasi di Dati6 / 12

σe valori nulli
σe valori nulli
•Per la selezione, il problema e’ stabilire se, in presenza di Null,
un predicato e’ vero oppure meno per una data tupla.
•Guardiamo l’esempio che segue per capire meglio...
Raffaella GentiliniBasi di Dati6 / 12

σe valori nulli
σe valori nulli
•Per la selezione, il problema e’ stabilire se, in presenza di Null,
un predicato e’ vero oppure meno per una data tupla.
•Guardiamo l’esempio che segue per capire meglio...
Raffaella GentiliniBasi di Dati6 / 12

σe valori nulli
Raffaella GentiliniBasi di Dati7 / 12

σe valori nulli
σ
F
e valori nulli:  Valutazione delle formule atomiche inF
•per valutare predicati come quello dell’esempio precedente, si
introduce una logica a tre valori
•In partcolare, oltre ai valori Vero (V) e Falso (F) si ha un terzo
valore Indefinito (?)
Le tabelle di verita’ sopra possono essere estese ad altri tipi di confronto.
SeDe’  un  dominio  su  cui  e’  definito  un  ordinamento<(risp.>,≤,≥)
allora il confrontoxθy(θ∈{<,>≤,≥}) e’ ?  sexe’ ?  oppureye’ ?.
Raffaella GentiliniBasi di Dati8 / 12

σe valori nulli
σ
F
e valori nulli:  Valutazione delle formule atomiche inF
•per valutare predicati come quello dell’esempio precedente, si
introduce una logica a tre valori
•In partcolare, oltre ai valori Vero (V) e Falso (F) si ha un terzo
valore Indefinito (?)
Le tabelle di verita’ sopra possono essere estese ad altri tipi di confronto.
SeDe’  un  dominio  su  cui  e’  definito  un  ordinamento<(risp.>,≤,≥)
allora il confrontoxθy(θ∈{<,>≤,≥}) e’ ?  sexe’ ?  oppureye’ ?.
Raffaella GentiliniBasi di Dati8 / 12

σe valori nulli
σ
F
e valori nulli:  Valutazione delle formule atomiche inF
•per valutare predicati come quello dell’esempio precedente, si
introduce una logica a tre valori
•In partcolare, oltre ai valori Vero (V) e Falso (F) si ha un terzo
valore Indefinito (?)
Le tabelle di verita’ sopra possono essere estese ad altri tipi di confronto.
SeDe’  un  dominio  su  cui  e’  definito  un  ordinamento<(risp.>,≤,≥)
allora il confrontoxθy(θ∈{<,>≤,≥}) e’ ?  sexe’ ?  oppureye’ ?.
Raffaella GentiliniBasi di Dati8 / 12

σe valori nulli
σ
F
e valori nulli:  Valutazione delle formule atomiche inF
•per valutare predicati come quello dell’esempio precedente, si
introduce una logica a tre valori
•In partcolare, oltre ai valori Vero (V) e Falso (F) si ha un terzo
valore Indefinito (?)
Le tabelle di verita’ sopra possono essere estese ad altri tipi di confronto.
SeDe’  un  dominio  su  cui  e’  definito  un  ordinamento<(risp.>,≤,≥)
allora il confrontoxθy(θ∈{<,>≤,≥}) e’ ?  sexe’ ?  oppureye’ ?.
Raffaella GentiliniBasi di Dati8 / 12

σe valori nulli
σ
F
e valori nulli:  Valutazione della condizione di selezioneF
Infine,  la tabella di verita’ le tabelle di verita’ nella logica a tre valori per
gli operatori booleani sono:
σ
F
e valori nulli
La selezioneσ
F
produce le sole tuple per cui la condizione di selezioneF
risulta vera (V).
Per lavorare esplicitamente con i valori nulli si introducono inoltre le con-
dizioni atomiche ’a IS NULL’ ed ’a IS NOT NULL’
Raffaella GentiliniBasi di Dati9 / 12

σe valori nulli
σ
F
e valori nulli:  Valutazione della condizione di selezioneF
Infine,  la tabella di verita’ le tabelle di verita’ nella logica a tre valori per
gli operatori booleani sono:
σ
F
e valori nulli
La selezioneσ
F
produce le sole tuple per cui la condizione di selezioneF
risulta vera (V).
Per lavorare esplicitamente con i valori nulli si introducono inoltre le con-
dizioni atomiche ’a IS NULL’ ed ’a IS NOT NULL’
Raffaella GentiliniBasi di Dati9 / 12

Esempio
Raffaella GentiliniBasi di Dati10 / 12

Concatenazione e valori nulli
Concatenazione e valori nulli
•Per ilθ-join valgono le stesse regole per la valutazione della
condizione di join F secondo la logica a tre valori.
•il join naturale non combina due tuple se queste hanno entrambe
valore nullo su un attributo in comune.
Raffaella GentiliniBasi di Dati11 / 12

Concatenazione e valori nulli
Concatenazione e valori nulli
•Per ilθ-join valgono le stesse regole per la valutazione della
condizione di join F secondo la logica a tre valori.
•il join naturale non combina due tuple se queste hanno entrambe
valore nullo su un attributo in comune.
Raffaella GentiliniBasi di Dati11 / 12

Concatenazione e valori nulli
Concatenazione e valori nulli
•Per ilθ-join valgono le stesse regole per la valutazione della
condizione di join F secondo la logica a tre valori.
•il join naturale non combina due tuple se queste hanno entrambe
valore nullo su un attributo in comune.
Raffaella GentiliniBasi di Dati11 / 12

Esempio
Raffaella GentiliniBasi di Dati12 / 12