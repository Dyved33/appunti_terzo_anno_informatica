# Progettazione concettuale e modello ER

## Overview sulla progettazione di basi di dati
Progettare un'applicazione di basi di dati prevede due attività principali:

1. **Progetto base di dati:** definizione della struttura e dei vincoli della BD in fase di progettazione.
2. **Progetto applicazioni:** progetto/test di programmi ed interfacce di accesso alla BD (tradizionalmente dominio dell'ingegneria del software).

In questa lezione ci occupiamo del progetto schema concettuale BD, mediante il **Modello Entità-Relazioni (ER)** per la rappresentazione dei dati concettuali ad alto livello.

## Running example: la BD AZIENDA
Nel corso della lezione utilizziamo un'applicazione di basi di dati **AZIENDA** per illustrare concretamente il processo di progettazione concettuale ed i concetti del modello ER.

La BD AZIENDA tiene traccia degli impiegati, dei dipartimenti e dei progetti di un'azienda.

### Requisiti della BD AZIENDA
1. L'azienda è organizzata in dipartimenti, ciascuno dei quali ha nome e numero univoci, più sedi, un dirigente. Si registra la data inizio direzione di ogni dipartimento.
2. Un dipartimento controlla un certo numero di progetti. Ogni progetto ha nome e numero univoci, ed una singola sede.
3. Per ciascun impiegato viene memorizzato nome, numero previdenza sociale, indirizzo, stipendio, sesso, e la data di nascita. Un impiegato è assegnato ad un solo dipartimento ma può lavorare su più progetti (arbitrariamente controllati). Si tiene traccia del numero di ore che un impiegato spende per ogni progetto e del diretto supervisore dell'impiegato.
4. Si registrano le persone a carico di ogni impiegato, mantenendone nome di battesimo, sesso, data di nascita, rapporto di parentela.

## Concetti del modello ER: entità e attributi
*Definizione:* **Entità:** oggetti (fisici o concettuali) del mini-mondo rappresentato dalla BD.

*Definizione:* **Attributi:** proprietà che descrivono le entità. Un'entità particolare avrà un valore per ciascuno dei suoi attributi.

### Tipi di attributi
Le varie caratteristiche possono essere arbitrariamente combinate (ad esempio, attributi multivalore composti, attributi composti con una componente multivalore, ecc.).

*Definizione:* **Attributo semplice (o atomico):** non divisibile. Ad esempio, SESSO oppure SSN per un'entità di tipo IMPIEGATO.

*Definizione:* **Attributo composto:** scomponibile in (sotto-)attributi (semplici o a loro volta composti). Ad esempio, NOME (composto da nome di battesimo e cognome) oppure INDIRIZZO per un'entità di tipo IMPIEGATO. La composizione di attributi può avere forma gerarchica.

*Definizione:* **Attributo a singolo valore:** un valore singolo per una particolare entità. Ad esempio, ETA' oppure SESSO.

*Definizione:* **Attributo multivalore:** può avere un insieme di valori per una particolare entità. Ad esempio, un attributo LAUREE per un'entità PERSONA.

*Definizione:* **Attributo complesso:** gli attributi composti e multivalore possono essere composti in modo arbitrario, generando attributi complessi.

*Definizione:* **Attributo memorizzato vs derivato:** i valori degli attributi possono essere talvolta correlati. Ad esempio, l'attributo ETA' (derivato) di un'entità di tipo PERSONA è derivabile dall'attributo DATA Nascita (memorizzato).

*Definizione:* **Valore NULL:** quando una particolare entità non ha valori adatti per un attributo, si può utilizzare il valore speciale NULL. Ad esempio, l'attributo LAUREA per un'entità di tipo PERSONA.

### Tipi di entità ed insiemi di entità (istanze)
Un tipo di entità è la classe; un insieme di entità è l'insieme delle istanze di quel tipo.

### Chiavi
*Definizione:* **Chiave:** un attributo di un'entità che identifica univocamente ogni esemplare concreto (istanza) del tipo di entità. Ad esempio, l'attributo SSN per il tipo di entità IMPIEGATO.

- Può essere un attributo semplice o composto. Ad esempio, l'attributo REGISTRAZIONE è una chiave (composta) per il tipo di entità AUTOMOBILE, formata dagli attributi componenti NUMERO REGISTRAZIONE, CITTA.
- Una chiave deve essere **minimale**, ovvero non deve contenere attributi superflui.
- Un'entità può possedere una o più chiavi.
- Nei diagrammi ER, ciascun attributo chiave ha il suo nome sottolineato.

## Entità, attributi e chiavi nei diagrammi ER
Notazione diagrammi ER:

- I (tipi di) entità sono rappresentati da rettangoli.
- Gli attributi sono rappresentati mediante ovali collegati alle entità.
- Gli attributi chiave sono sottolineati.
- Gli attributi multivalore sono rappresentati da doppi ovali.
- Le componenti di un attributo composto sono rappresentati da ovali collegati all'attributo composto.

## Progetto iniziale delle entità nella BD AZIENDA
In base ai requisiti, possiamo identificare 4 tipi di entità iniziali nella BD AZIENDA:

- DIPARTIMENTO
- PROGETTO
- IMPIEGATO
- PERSONA A CARICO

Il progetto iniziale di queste entità e dei loro attributi (dati i requisiti) è illustrato nella slide seguente.

![[Images/slide-08.png|500]]

## Concetti del modello ER: relazioni
Per raffinare il modello ER abbozzato, dobbiamo introdurre il terzo ed ultimo concetto fondamentale del modello ER: il concetto di relazione.

*Definizione:* **Relazione:** una (istanza di) relazione associa due o più (istanze di) entità. Ad esempio, l'IMPIEGATO Franco Rossi lavora sul PROGETTO progettoX; oppure, l'IMPIEGATO Franco Rossi dirige il DIPARTIMENTO Ricerca.

Un (tipo di) relazione associa due o più (tipi di) entità. Ad esempio, i tipi di relazione LAVORA SU e DIRIGE coinvolgono la coppia di entità IMPIEGATO e PROGETTO e la coppia di entità IMPIEGATO e DIPARTIMENTO, rispettivamente.

*Definizione:* **Grado di una relazione:** il numero di tipi di entità coinvolti nella relazione. Ad esempio, LAVORA SU e DIRIGE sono binarie.

## Relazioni ricorsive
*Definizione:* **Relazione ricorsiva:** tipo di relazione che coinvolge in ruoli diversi lo stesso tipo di entità. Ad esempio, la relazione SUPERVISIONE, dove lo stesso tipo di entità (IMPIEGATO) partecipa nel ruolo di supervisore e subalterno.

## Tipi di partecipazione a relazioni: rapporti di cardinalità
Il rapporto di cardinalità di una relazione specifica il numero massimo di istanze di relazione a cui può partecipare un'entità.

- **One-to-one (1:1):** DIRIGE è un esempio di relazione binaria 1:1 che correla un'entità di dipartimento all'impiegato che lo dirige.
- **One-to-many (1:N) / Many-to-one (N:1):** LAVORA PER è un esempio di relazione binaria N:1 che correla N entità di impiegati ad un dipartimento.
- **Many-to-many (M:N):** LAVORA SU è un esempio di relazione binaria M:N (i requisiti asseriscono che un impiegato può lavorare su più progetti e che un progetto può essere gestito da più impiegati).

## Vincoli di partecipazione (totale, parziale)
Il vincolo di partecipazione (o vincolo di cardinalità minima) specifica se l'esistenza di un'entità dipende dal suo essere correlata ad un'altra entità, mediante una relazione.

- **Partecipazione totale:** ad esempio, la partecipazione di IMPIEGATO a LAVORA PER è totale perché i requisiti asseriscono che ogni impiegato deve afferire ad un dipartimento.
- **Partecipazione parziale:** ad esempio, la partecipazione di IMPIEGATO a DIRIGE è parziale.

## Attributi di relazione
*Definizione:* **Attributo di relazione:** una relazione può avere attributi. Ad esempio, l'attributo NUMERO ORE per la relazione LAVORA SU.

Nelle relazioni 1:N, gli attributi possono essere trasferiti al lato N della relazione.

## Entità deboli
*Definizione:* **Entità debole:** è un'entità priva di attributi che possono fungere da chiave. Deve partecipare (con partecipazione totale) ad una relazione (detta relazione identificante) che coinvolge l'entità debole e un'entità (non debole) detta entità proprietaria. Possiede una chiave parziale che, concatenata con la chiave dell'entità proprietaria, ne identifica univocamente le istanze.

*Esempio:* un'istanza dell'entità debole PERSONA A CARICO è identificata dal nome di battesimo (chiave parziale) e dall'impiegato da cui dipende. IMPIEGATO è l'entità proprietaria di PERSONA A CARICO, attraverso la relazione identificante DIPENDE DA.

## Notazioni alternative diagrammi ER
V'è una notazione alternativa per specificare vincoli strutturali sulle relazioni dei modelli ER: si associa una coppia di numeri (min, max) a ciascuna partecipazione di un tipo di entità E ad un tipo di relazione R.

- Default (assenza di vincoli): min = 0, max = N.
- Vale 0 ≤ min ≤ max e 1 ≤ max.
- In questa notazione, min ≥ 1 indica partecipazione totale, min = 0 indica partecipazione parziale.

Molte rappresentazioni diagrammatiche alternative per rappresentare modelli ER (ad esempio, notazioni del linguaggio UML).

## Sulle relazioni di grado ≥ 2
- Relazioni di grado 2 sono dette **binarie**.
- Relazioni di grado 3 sono dette **ternarie**.
- Relazioni di grado n sono dette **n-arie**.

In generale, un tipo di associazione n-ario fornisce più informazione di quanto non facciano n relazioni binarie.

Una relazione n-aria può essere rappresentata anche come un'entità debole:
- senza chiave parziale;
- con 3 associazioni identificanti.

Le relazioni TENUTO DURANTE e PROPOSTO DURANTE sono ridondanti.

## Vincoli su relazioni di grado ≥ 2
Notazione basata sul rapporto di cardinalità: 1, M, N sono specificati su ogni arco. Ad esempio, se un solo fornitore fornisce una parte specifica ad uno specifico progetto: 1 sulla partecipazione di fornitore, M, N sulle partecipazioni di parte e progetto.

Notazione (min, max).

## Fasi della progettazione di un modello ER
Progettazione di modelli ER: 2 passi principali, uno di progettazione iniziale, l'altro di raffinamento.

1. Tipi di entità + relazioni come attributi.
2. Tipi di entità + tipi di relazione.

### Fase 1 della progettazione
Progetto iniziale delle entità e dei loro attributi.

### Fase 2 della progettazione: raffinamento
Raffinamento del modello ER per la BD AZIENDA. Esaminando i requisiti vengono identificate sei relazioni, tutte di tipo binario:

- LAVORA PER (tra IMPIEGATO e DIPARTIMENTO)
- DIRIGE (tra IMPIEGATO e DIPARTIMENTO)
- CONTROLLA (tra DIPARTIMENTO e PROGETTO)
- LAVORA SU (tra IMPIEGATO e PROGETTO)
- SUPERVISIONA (tra IMPIEGATO con ruolo di capo e IMPIEGATO con ruolo di subalterno)
- DIPENDE DA (tra l'entità debole PERSONA A CARICO e l'entità proprietaria IMPIEGATO)

[[Lezione 13-Gruppi, funzioni d'aggregazione, GROUP BY e HAVING|Lezione 13]]

