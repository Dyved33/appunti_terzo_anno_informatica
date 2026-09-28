### modello relazionale
introdotto nel 1970 da Codd (ricercatore in IBM) per favorire indipendenza dati. venne adottato dai sistemi commerciali all'inizio degli anni 80. oggi è il modello di basi di dati più diffuso sotteso ai DBMS commerciali. ragioni del successo:
- semplicità = BD percepita come insieme di tabelle 
- carattere dichiarativo dei linguaggi di manipolazione ed interrogazione associati

### modello relazionale vs reticolare / gerarchico
Le principali differenze tra modello relazionale e modelli gerarchico/reticolare sono:
• modo in cui si rappresentano le associazioni tra record:
    • gerarchico e reticolare usano puntatori
    • valori, nel modello relazionale
• A differenza dei modelli gerarchico/reticolare, il modello relazionale è formalmente definito e trae fondamento nella teoria degli insiemi e nella logica dei predicati al primo ordine

Definizione: Il modello relazionale si basa sui concetti di relazione e tupla, variazione delle nozioni matematiche di relazione ed n-upla

Si considerino n insiemi D1, . . . , Dn (non necessariamente distiniti):
• il prodotto cartesiano D1 × · · · × Dn è l’insieme di tutte le n-uple ordinate  (d1 . . . dn) tali che d1 ∈ D1, . . . , dn ∈ Dn
• una relazione (matematica) R su D1, . . . , Dn è un sottoinsieme del prodotto cartesiano R ⊆ D1 × · · · × Dn
• il grado di R ⊆ D1 × · · · × Dn è n
• La cardinalità |R| di R ⊆ D1 × · · · × Dn è il numero di elementi di R.

### Dalle Relazioni Matematiche alle Relazioni nel Modello Relazionale
• Gli elementi di una relazione matematica R sono n-uple ordinate nella forma (d1 . . . dn), di ∈ Di , i ∈ {1, . . . , n}
• Nel contesto delle basi di dati l’ordine degli elementi in una n-upla non è importante.
• Risulta piuttosto conveniente essere in grado di nominare un particolare elemento di
, piuttosto che individuarlo mediante il suo indice i.

## Domini e attributi
Definizione: Un dominio è un insieme non vuoto di valori atomici (indivisibili). Un attributo è un nome associato ad un dominio. Indichiamo con Dom(A) il dominio associato all’attributo A.

es. Dom(Nazione): insieme di stringhe di caratteri che rappresentano nomi di nazione.

## Tupla
Siamo ora in grado di introdurre il concetto fondamentale di tupla, variazione della nozione di n-upla dove l’ ordine degli elementi non ha rilevanza.

Definizione: Si consideri un insieme di attributi X = {A1, . . . , An}. Una tupla t su X è una funzione che associa ad ogni Ai ∈ X un valore in Dom(Ai), oppure uno speciale valore Null. Indicheremo con t[Ai] il valore della tupla t sull’attributo Ai.

## Relazioni: schemi ed istanze
Precediamo definendo le nozioni di schema di relazione ed istanza di relazione nel modello relazionale.

Definizione: Dato l’insieme di attributi X = {A1, . . . , An}, uno schema di relazione su
X è dato da: un nome (di relazione) R e dall’insieme di attributi X. 

Utilizzeremo la notazione R(X) (oppure R(A1 . . . An) in luogo di R({A1, . . . , An})) per indicare uno schema di relazione R su X. Sarà inoltre a volte conveniente specificare i domini di ogni attributo, scrivendo R(A1 : Dom(A1, . . . , An : Dom(An)).

Istanza di Relazione = Dato l’insieme di attributi X = {A1, . . . , An}, un’istanza di relazione su X è un insieme di tuple su X.

## Basi di dati: schemi ed istanze
Possiamo ora dare la seguente definizione parziale della nozione di schema/istanza di basi di dati. La definizione completa include anche la specifica di un insieme di vincoli
di integrità

Definizione: Uno schema di basi di dati è un insieme di schemi di relazioni con nomi
diversi.

Istanza di Basi di Dati = Un'istanza di basi di dati sullo schema :
B = {R1(X1), . . . , Rn(Xn)}
è un insieme di istanze di relazioni {r1, . . .rn} tali che ri è un’istanza di
Ri, per ogni i ∈ {1 . . . n}.

## Esempio: istanza di studente
{
    {{(matricola,37891),(nome, Mario Rossi)}, {(matricola,5421),(nome, Luigi Verdi}}
    {{(codice,1), (nome,BD)}, {(codice,2), (nome,ASD)}}
    {{(studente, 37891), (corso,1)}, {(studente, 37891), (corso,2)}}
}

*concetto relazione* | *equivalente informale*
  ___________________|______________________
  relazione            tabella
  ___________________|______________________
  attributo            colonna
  ___________________|______________________
  tupla                riga
  ___________________|______________________
  grado                numero colonne
  ___________________|______________________
  cardinalità          numero righe
  ___________________|______________________
  
  
