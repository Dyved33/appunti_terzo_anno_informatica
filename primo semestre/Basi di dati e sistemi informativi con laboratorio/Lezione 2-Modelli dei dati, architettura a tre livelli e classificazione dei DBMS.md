# Modelli dei dati, architettura a tre livelli e classificazione dei DBMS

## I modelli dei dati

*Definizione:* un **modello dei dati** è una collezione strutturata di concetti e formalismi impiegata per descrivere la struttura di una base di dati e le operazioni di manipolazione ammesse su di essa.

Per **struttura** di una base di dati si intendono congiuntamente i **tipi di dato** e i domini ammissibili, le **associazioni e relazioni** logiche intercorrenti tra i dati e i **vincoli di integrità** che devono essere costantemente soddisfatti dai dati memorizzati.

La totalità dei modelli dei dati include un nucleo di **operazioni fondamentali** preposte all'interrogazione e all'aggiornamento della base di dati: inserimento, cancellazione e modifica dei record. Oltre a queste, un modello può fornire costrutti per modellare l'**aspetto dinamico e comportamentale** del sistema informativo, formalizzando un insieme di **operazioni definite dall'utente**, per esempio l'operazione `calcola_media` associata all'entità `Studente`. Nel modello relazionale moderno questo paradigma si concretizza associando logica attiva direttamente allo schema mediante **trigger**, **stored procedure** e funzioni di dominio.

**Tassonomia.** I modelli dei dati si classificano in tre categorie secondo il livello di astrazione offerto:

- **Modelli di alto livello o concettuali:** concetti e costrutti molto vicini alle modalità di percezione e ragionamento degli utenti finali del dominio applicativo; il principale esponente è il **Modello Entità-Relazione (ER)** e le sue estensioni concettuali.
- **Modelli implementabili o logici:** livello intermedio, con concetti comprensibili per gli utenti finali ma non eccessivamente distanti dalle modalità di memorizzazione e rappresentazione del calcolatore; mascherano i dettagli fisici di basso livello (blocchi, tracce, allocazione di memoria) e sono direttamente implementabili e gestibili dai moderni motori DBMS; includono i modelli tradizionali (relazionale, reticolare, gerarchico) e quelli orientati agli oggetti.
- **Modelli di basso livello o fisici:** descrivono le modalità e i dettagli tecnici con cui i dati sono fisicamente allocati e formattati sui supporti di memoria secondaria, specificando strutture di accesso, ordinamento dei record, formattazione dei blocchi e percorsi di scansione su disco.

## Schemi, istanze e stati della base di dati

**Schema della base di dati (intensione).** È la descrizione formale e globale della base di dati, specificata e validata durante la fase di progettazione iniziale. Non muta frequentemente nel corso del tempo e definisce la struttura invariante dell'applicazione. Ogni singolo elemento che lo compone, come l'entità `Studente`, l'entità `Corso` o l'attributo `Matricola`, è un **costrutto di schema**; la rappresentazione grafica di alcuni aspetti strutturali salienti (nomi dei record, attributi primari, associazioni), che omette i dettagli esaustivi come i vincoli di integrità avanzati o i tipi di memorizzazione fisica, è il **diagramma di schema**.

**Stato o istanze della base di dati (estensione).** È la totalità dei dati effettivamente memorizzati nella base di dati in un preciso istante temporale. Ciascun costrutto di schema possiede un proprio insieme corrente di istanze: il costrutto `Studente` conterrà, in un dato momento, l'insieme dei record (tuple) corrispondenti a ciascun singolo studente iscritto e registrato nel sistema.

**Stati iniziali e stati validi.** La natura dello stato è intrinsecamente dinamica e si articola in:

- *Stato iniziale:* la configurazione assunta dalla base di dati nel momento in cui viene popolata o caricata per la prima volta con i dati di partenza.
- *Stato valido (consistente):* uno stato che soddisfa rigorosamente la struttura formale e l'integrità dei vincoli definiti nello schema:

$$
\text{Stato } S \text{ è valido} \iff \forall v \in \text{Vincoli}(\text{Schema}), \; S \models v
$$

Ogni operazione di aggiornamento (scrittura, modifica o cancellazione) determina una transizione di stato della base di dati, che il DBMS deve validare per preservarne la consistenza.

| Dimensione di confronto | Schema (intensione) | Stato e istanze (estensione) |
| :--- | :--- | :--- |
| **Dinamica temporale** | Statico: non cambia frequentemente nel tempo | Dinamico: muta ad ogni aggiornamento o transazione |
| **Fase di definizione** | Specificato durante la fase di progettazione | Popolato e manipolato durante la fase di esercizio |
| **Ruolo semantico** | Rappresenta la struttura, le regole e i vincoli | Rappresenta i dati effettivi registrati |

## L'architettura a tre livelli

L'**architettura a tre livelli**, formalizzata dal comitato ANSI/SPARC, è stata teorizzata per supportare in modo sistematico due caratteristiche cardine dei moderni DBMS: l'**indipendenza dei dati** e il supporto a **viste multiple e personalizzate** per classi eterogenee di utenti. Separa la gestione del sistema in tre livelli gerarchici di schema:

```
                  ┌──────────────────────┐   ┌──────────────────────┐
   Livello        │ Vista Esterna 1      │...│ Vista Esterna n      │
   Esterno        └──────────┬───────────┘   └──────────┬───────────┘
                             │                          │
                 ════════════╪══════════════════════════╪═════════════  Mappatura Esterno/Concettuale
                             └───────────┬──────────────┘
                                         ▼
   Livello                       ┌────────────────┐
   Concettuale                   │Schema Concettuale│
                                 └───────┬────────┘
                 ════════════════════════╪════════════════════════════  Mappatura Concettuale/Interno
                                         ▼
   Livello                       ┌────────────────┐
   Interno                       │ Schema Interno │
                                 └───────┬────────┘
                                         ▼
                               [ Base di Dati Fisica ]
```

1. **Schema interno (livello interno o fisico):** descrive la struttura di memorizzazione fisica dei dati, cioè come i file sono memorizzati, e le strutture di accesso rapido (puntatori fisici, indici B-Tree, tabelle hash) che agevolano scrittura e lettura; impiega un modello dei dati fisico di basso livello.
2. **Schema concettuale (livello concettuale o logico globale):** descrive l'intera struttura, le entità, i tipi di dato, le associazioni e i vincoli di integrità della base di dati per una collettività di utenti; nasconde integralmente i dettagli implementativi fisici e adotta un modello concettuale o un modello implementabile.
3. **Schema esterno (livello esterno o delle viste):** descrive le prospettive parziali o le viste ritagliate su misura per specifiche comunità di utenti o applicazioni; adotta il medesimo modello dei dati impiegato per il livello concettuale, isolando le informazioni non pertinenti o riservate.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260925091712.png" width="450">
</div>

Il diagramma illustra le interconnessioni tra gli utenti finali (*end users*), i livelli di schema (*external*, *conceptual*, *internal*) e il database persistente memorizzato (*stored database*), evidenziando il ruolo pivotale delle mappature intermedie.

**Processi di mappatura (*mapping*).** La trasformazione delle richieste e dei dati attraverso i tre livelli richiede un'esplicita opera di mappatura:

- **Dall'alto verso il basso, risoluzione delle richieste:** i programmi applicativi e gli utenti interagiscono con il proprio schema esterno; il DBMS intercetta le richieste e le mappa verso lo schema concettuale, traducendole successivamente nello schema interno affinché i moduli di I/O possano reperire i blocchi di memoria su disco.
- **Dal basso verso l'alto, composizione dei risultati:** i dati grezzi estratti dal livello interno vengono rielaborati e formattati dal DBMS per risalire la gerarchia fino a conformarsi alla vista esterna dell'utente richiedente, per esempio convertendo il risultato di una query relazionale in una struttura tabellare su interfaccia web.

## L'indipendenza dei dati

L'**indipendenza dei dati** è la proprietà dei sistemi DBMS che consente di modificare la definizione dello schema a un dato livello architetturale senza dover alterare gli schemi ai livelli gerarchici superiori né i programmi applicativi associati. Si articola in due forme:

- **Indipendenza logica dei dati:** capacità di apportare modifiche allo **schema concettuale** senza modificare gli schemi esterni né i programmi applicativi preesistenti. Si manifesta quando si espande la base di dati introducendo nuove tabelle, nuove relazioni o nuovi attributi facoltativi: le applicazioni preesistenti continuano a operare regolarmente ed è sufficiente aggiornare la sola **mappatura esterno/concettuale** per garantire l'allineamento.
- **Indipendenza fisica dei dati:** capacità di apportare modifiche allo **schema interno** senza modificare lo schema concettuale né, a cascata, gli schemi esterni o i programmi applicativi. Si manifesta quando si riorganizzano i file di memorizzazione su disco, si modificano i percorsi di allocazione fisica o si creano ed eliminano strutture ausiliarie come indici su chiavi primarie o secondarie per ottimizzare le prestazioni (*tuning* prestazionale); è sufficiente aggiornare la **mappatura concettuale/interna**, mantenendo invariata la logica dei livelli superiori.

> [!important] Meccanismo operativo:
> Quando uno schema subisce variazioni a un livello più basso, il DBMS richiede esclusivamente la ricalibrazione del modulo di **mapping** verso i livelli sovrastanti. I livelli superiori rimangono inalterati, preservando l'integrità del software applicativo e azzerando i costi di ricompilazione o refactoring del codice.

## Linguaggi e interfacce per DBMS

**Linguaggi di definizione (DDL, SDL e VDL).**

- *Data Definition Language (DDL):* utilizzato dal DBA e dai progettisti per specificare formalmente lo schema concettuale della base di dati; nella maggior parte dei DBMS commerciali moderni viene adoperato anche per definire gli schemi interni ed esterni.
- *Storage Definition Language (SDL):* linguaggio specifico, presente in sistemi ad architettura avanzata o pura, preposto alla definizione dettagliata dello schema interno e dei parametri fisici di memorizzazione.
- *View Definition Language (VDL):* deputato a specificare le viste dello schema esterno e la relativa mappatura concettuale. Nei sistemi contemporanei basati su standard SQL, le funzionalità di DDL, SDL e VDL sono unificate all'interno dei costrutti di definizione (`CREATE TABLE`, `CREATE INDEX`, `CREATE VIEW`).

**Linguaggi di manipolazione dei dati (DML).** Il **DML** è impiegato per specificare le interrogazioni (*retrieval*) e gli aggiornamenti dello stato della base di dati (inserimenti, modifiche, cancellazioni). I comandi DML possono essere eseguiti:

1. *In modalità stand-alone* (*query language*): direttamente e in modo interattivo da terminale o interfaccia grafica.
2. *In modalità integrata* (*embedded DML*): annidati all'interno di un linguaggio di programmazione generico a scopo generale, il **linguaggio ospite**, come Java, C o Python.
3. *Mediante API e librerie dedicate*: connessione e manipolazione tramite interfacce standardizzate, come JDBC, ODBC e librerie ORM.

I linguaggi DML si distinguono in due paradigmi:

- **Linguaggi di alto livello o non procedurali (dichiarativi, *set-oriented*):** l'esempio paradigmatico è **SQL**, che specifica dichiarativamente **quali dati reperire**, demandando completamente al modulo di *query optimization* del DBMS la definizione dell'algoritmo di accesso; opera su insiemi di tuple (*set-at-a-time*), estraendo o manipolando un'intera collezione di record con una sola istruzione.
- **Linguaggi di basso livello o procedurali (*record-oriented*):** specificano dettagliatamente la sequenza algoritmica di passi necessaria per recuperare i dati; operano su singoli record (*record-at-a-time*) e richiedono strutture iterative (`loop`), puntatori espliciti e costrutti condizionali all'interno del linguaggio ospite per scorrere sequenze di record.

## Classificazione dei DBMS in base al modello dei dati

I sistemi DBMS si classificano in base al paradigma del modello dei dati adottato, distinguendosi in modelli tradizionali e modelli emergenti:

```
┌──────────────────────────────────────────────────────────────┐
│                    Modelli dei Dati                          │
├──────────────────────────────┬───────────────────────────────┤
│    Modelli Tradizionali      │      Modelli Emergenti        │
├──────────────────────────────┼───────────────────────────────┤
│ • Modello Gerarchico (Anni 60)│ • Modello a Oggetti (OODBMS)  │
│ • Modello Reticolare (1971)  │ • Modello Relazionale a       │
│ • Modello Relazionale (1970) │   Oggetti (ORDBMS, SQL:1999)  │
└──────────────────────────────┴───────────────────────────────┘
```

### Modelli tradizionali

**Modello gerarchico.** Rappresenta i dati come una collezione di alberi gerarchici rigidi, in cui a partire da un record radice (*padre*) si accede per discendenza ai record *figli* che ne dipendono, con relazioni strettamente 1:N. Sviluppato durante la prima fase dei DBMS, negli anni '60, da IBM e North American Rockwell intorno al 1965 per il programma spaziale Apollo. Non esiste uno standard formale universale: il DML storicamente più diffuso è il linguaggio procedurale **DL/1** del sistema **IMS** (*Information Management System*) di IBM.

*Punti di forza:* rispecchia fedelmente la natura strettamente gerarchica di domini organizzativi e produttivi verticali.

*Limiti:*
- la rigida alberatura impone vincoli stringenti su interrogazioni e aggiornamenti;
- assenza di ottimizzazione automatica delle query: la navigazione fisica è a carico del programmatore;
- forte dipendenza dei programmi applicativi dall'organizzazione fisica delle strutture;
- inefficienza nella modellazione di relazioni molti-a-molti ($N:M$): la rappresentazione di associazioni complesse costringe alla duplicazione dei dati, generando ridondanza incontrollata.

**Modello reticolare.** Rappresenta i dati come tipi di record interconnessi mediante una ragnatela di puntatori espliciti (*set types*), permettendo a un record membro di possedere molteplici record proprietari (*padri*). Il primo prototipo fu l'**IDS** (*Integrated Data Store*), sviluppato da Charles Bachman alla General Electric nel 1964, che rimase alla base dei principali sistemi commerciali fino alla metà degli anni '80: IDMS di Cullinet, DMS 1100 di Unisys, IMAGE di HP, VAX-DBMS di Digital/Compaq. Fu standardizzato dalla **CODASYL** (*Conference on Data Systems Languages*) nel celebre report **DBTG** (*Database Task Group*) del 1971.

*Punti di forza:* un record può avere più genitori, eliminando le anomalie di ridondanza tipiche del modello gerarchico; consente la modellazione naturale e diretta di relazioni molti-a-molti ($N:M$); qualsiasi nodo del grafo può costituire il punto di ingresso per navigare la base di dati.

*Limiti:* elevata complessità di gestione, perché la presenza di un fittissimo reticolo di puntatori rende onerosa la manutenzione; navigazione procedurale a carico dello sviluppatore (*record-at-a-time*), con scarso margine di ottimizzazione automatica da parte del sistema.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260925093710.png" width="500">
</div>

Il grafo illustra un'applicazione accademica nel modello reticolare: l'entità `COURSE` agisce come proprietaria verso `SECTION` (tramite `COURSE_OFFERINGS`) e verso `PREREQUISITE` (`HAS_A`/`IS_A`), mentre `GRADE_REPORT` riceve puntatori concorrenti sia da `STUDENT` (`STUDENT_GRADES`) sia da `SECTION` (`SECTION_GRADES`), concretizzando relazioni multilaterali senza duplicazione logica dei record.

**Modello relazionale.** Modella l'intera base di dati come una collezione di **relazioni** matematiche, cioè tabelle bidimensionali composte da righe (tuple) e colonne (attributi), svincolando la logica dei dati dai puntatori fisici. Teorizzato nel 1970 da **Edgar F. Codd**, ricercatore IBM, nell'articolo seminale *"A Relational Model of Data for Large Shared Data Banks"*; i primi sistemi commerciali debuttarono sul mercato nel 1979. Costituisce il paradigma dominante dell'industria del software (IBM DB2, Oracle Database, Microsoft SQL Server, PostgreSQL, MySQL) e ha introdotto lo standard universale **SQL** attraverso le sue successive evoluzioni (SQL-89, SQL-92, SQL:1999 e successive).

### Modelli evoluti ed emergenti

**Modello ad oggetti (OODBMS).** Definisce la base di dati conformemente ai principi dell'*object-oriented programming* (OOP): classi di oggetti, identità persistente indipendente dal valore (OID, *object identifier*), incapsulamento di stato e metodi, tipi di dato astratti e gerarchie di ereditarietà. Ha iniziato a diffondersi alla fine degli anni '80 con l'obiettivo di abbattere il *conflitto di impedenza* tra i linguaggi OOP e i database tabellari. Nonostante le elevate potenzialità analitiche e concettuali, la quota complessiva di penetrazione industriale è rimasta confinata al di sotto del 5%, a causa della maturità, robustezza e capillarità degli ecosistemi relazionali.

**Modello ibrido relazionale ad oggetti (ORDBMS).** Estende l'architettura relazionale classica con le funzionalità del paradigma ad oggetti: supporto a tipi di dato complessi e strutturati definiti dall'utente, costruttori di tipo (array, collezioni), ereditarietà tra tabelle e incapsulamento di funzioni. Trend affermatosi nella seconda metà degli anni '90 a partire dall'avvento di piattaforme pionieristiche quali *Informix Universal Server*. I concetti sono standardizzati formalmente all'interno di **SQL:1999 (SQL3)** e integrati stabilmente nei principali motori DBMS enterprise (Oracle Database a partire da 8i/10g, IBM DB2, PostgreSQL).

> [!info] Sintesi:
> - Un modello dei dati descrive struttura e operazioni; si classificano in concettuali (ER), implementabili o logici e fisici.
> - Schema e istanza sono le due facce del sistema: lo schema è l'intensione statica, l'istanza l'estensione dinamica; uno stato è valido se soddisfa tutti i vincoli dello schema.
> - L'architettura ANSI/SPARC separa schema esterno, concettuale e interno, con mappature tra i livelli, e dà indipendenza logica (dal concettuale verso l'alto) e fisica (dall'interno verso l'alto).
> - DDL, SDL e VDL definiscono; il DML interroga e aggiorna, in modalità stand-alone, embedded o tramite API, dichiarativo (*set-oriented*) o procedurale (*record-oriented*).
> - I modelli tradizionali sono gerarchico (1:N, DL/1, IMS) e reticolare (CODASYL 1971, N:M con padri multipli); il relazionale di Codd (1970) è dominante e ha introdotto SQL.
> - Gli emergenti sono l'OODBMS e l'ORDBMS, standardizzato in SQL:1999.