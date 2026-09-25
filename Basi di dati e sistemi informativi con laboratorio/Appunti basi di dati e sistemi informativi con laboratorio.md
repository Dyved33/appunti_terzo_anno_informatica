# Lezione 1

> [!INFO] Informazioni sul Corso ed Esami
> - **Testo di riferimento:** R. Elmasri, S. B. Navathe, *Sistemi di basi di dati - Fondamenti*.
> - **1° Compitino:** 09/11 (ore 11:30 – 13:30)
> - **2° Compitino:** 18/12 (ore 08:30 – 10:30)

## 1. Concetti Fondamentali e Definizioni

Una **Base di Dati (BD)** è una collezione organizzata di dati logicamente correlati. I dati rappresentano fatti noti che possono essere registrati e che possiedono un significato implicito.

Una base di dati presenta le seguenti proprietà intrinseche:
1. **Rappresentazione del Mini-Mondo:** rappresenta un determinato aspetto del mondo reale, noto anche come **mini-mondo** o **universo del discorso**. Le modifiche che avvengono nel mini-mondo si riflettono puntualmente nella base di dati.
2. **Coerenza Logica:** costituisce una collezione di dati logicamente coerenti con un significato intrinseco ben definito; insiemi disgiunti di dati privi di legami concettuali non configurano una base di dati.
3. **Finalità Specifica:** viene progettata, costruita e popolata con dati per uno scopo ben preciso, rivolgendosi a un gruppo identificabile di utenti e ad applicazioni di specifico interesse.

Il **DBMS (Database Management System)** è il sistema software deputato a facilitare i processi di definizione, costruzione, manipolazione e condivisione di basi di dati tra molteplici utenti e applicazioni.

![[Pasted image 20260921123252.png|350]]

## 2. Funzionalità di un DBMS

### 2.1 Funzionalità Principali
* **Definire la BD:** specificare i tipi di dati, le strutture concettuali/logiche e i vincoli di integrità da imporre sui dati.
* **Costruire la BD:** memorizzare fisicamente i dati su supporti di memoria secondaria gestiti dal software.
* **Manipolare la BD:**
  * *Interrogare (Querying):* reperire dati specifici e produrre reportistica strutturata.
  * *Aggiornare:* inserire, modificare o eliminare dati per allineare lo stato della base di dati al mini-mondo.
  * *Accesso applicativo:* consentire l'accesso e l'interazione tramite applicazioni desktop e web.
* **Condividere la BD:** permettere l'accesso simultaneo a più utenti e processi applicativi, prevenendo corruzioni e garantendo costantemente la consistenza dei dati.

### 2.2 Funzionalità Avanzate e Gestionali
* **Protezione e Manutenzione:**
  * Tolleranza ai guasti e protezione da crash hardware o software (sottosistema di recovery).
  * Controllo degli accessi e politiche di sicurezza contro intrusioni o accessi non autorizzati.
  * Manutenzione evolutiva della BD e dell'ambiente operativo lungo tutto il ciclo di vita del sistema.
* **Processing Attivo dei Dati:** capacità di attivare automaticamente sequenze di azioni al verificarsi di specifici eventi o condizioni (DBMS attivi mediante *trigger* e *regole ECA*).
* **Presentazione e Visualizzazione:** fornitura di strumenti avanzati di formattazione grafica e generazione di report per gli utenti finali.

## 3. Caratteristiche dell'Approccio a Basi di Dati vs File System

L'approccio basato su DBMS differisce radicalmente dalla gestione tradizionale basata su file piatti (*file processing*) per quattro caratteristiche cardine:

### 3.1 Natura Autodescrittiva del Sistema
A differenza dell'approccio basato su file, in cui la struttura dei record è codificata internamente nei singoli programmi applicativi, un sistema di BD contiene sia i dati sia una descrizione esaustiva della loro struttura e dei relativi vincoli.
* Tale definizione formale risiede nel **catalogo di sistema** (o dizionario dati), che contiene:
  * La struttura di ciascun file o tabella.
  * Il tipo di dato e il formato di memorizzazione di ogni attributo.
  * I vincoli di integrità imposti.
* Le informazioni conservate nel catalogo prendono il nome di **metadati**.
* Questa proprietà consente ai moduli del DBMS di interagire con basi di dati eterogenee, ricavandone dinamicamente lo schema direttamente dal catalogo.

### 3.2 Separazione tra Programmi e Dati ed Astrazione dei Dati
Il DBMS fornisce agli utenti un'astrazione concettuale dei dati (**modello dei dati**), nascondendo i dettagli implementativi e fisici relativi all'allocazione sui dispositivi di memoria secondaria.

> [!NOTE] Separazione tra Dati e Programmi
> La struttura dei file di dati è memorizzata nel catalogo del DBMS separatamente dai programmi applicativi di accesso. Tale proprietà è detta **indipendenza tra programmi e dati**. In virtù dell’indipendenza tra dati e programmi e dell’astrazione dei dati, è possibile modificare le strutture di memorizzazione interne e l'organizzazione fisica dei dati senza dover ricompilare o riscrivere i relativi programmi di accesso.

### 3.3 Supporto di Viste Multiple sui Dati
Una base di dati conta una molteplicità di utenti con privilegi ed esigenze differenti. Il DBMS deve offrire a ciascun utente una prospettiva personalizzata:
* Una **vista** (*view*) può essere un sottoinsieme specifico della base di dati.
* Può trattarsi di una collezione di dati virtuali, ossia dati non memorizzati fisicamente ma derivati dinamicamente dai dati persistenti al momento della richiesta.

### 3.4 Condivisione dei Dati e Gestione delle Transazioni Multiutente
Un DBMS multiutente implementa un sottosistema specializzato per il **controllo della concorrenza**, assicurando che transazioni simultanee non interferiscano reciprocamente producendo anomalie o stati incoerenti.

> [!NOTE] Transazioni e Proprietà Fondamentali
> Una **transazione** è un programma o processo in esecuzione che esegue uno o più accessi alla base di dati (lettura e/o scrittura). Il DBMS garantisce proprietà fondamentali (ACID), tra cui:
> * **Isolamento:** Ogni transazione viene eseguita in isolamento logico rispetto alle altre; gli effetti intermedi di una transazione non sono visibili alle transazioni concorrenti finché essa non viene confermata (*commit*).
> * **Atomicità:** Le operazioni di una transazione vengono eseguite nella loro interezza (*all-or-nothing*); in caso di guasto o interruzione anomala, ogni modifica parziale viene rollbackata.

## 4. Classificazione degli Utenti di una Base di Dati

L'ambiente di una base di dati coinvolge due macro-categorie di attori:

### 4.1 Attori sulla Scena (Attori Diretti)
Coloro la cui attività quotidiana è rivolta all'amministrazione, progettazione ed effettivo utilizzo della base di dati:
1. **Progettisti della BD:** responsabili dell'individuazione dei dati da memorizzare e della selezione delle strutture concettuali e logiche idonee. Dialogano con gli utenti finali per formalizzarne i requisiti.
2. **Amministratori della Base di Dati (DBA - Database Administrator):** responsabili della gestione operativa della risorsa dati. Tra i loro compiti primari:
   * Autorizzare e revocare gli accessi e i privilegi alla BD.
   * Coordinare, monitorare e ottimizzare l'uso delle risorse hardware e software.
   * Risolvere violazioni di sicurezza, malfunzionamenti o decadimenti prestazionali.
3. **Utenti Finali:** soggetti che accedono alla base di dati per compiti operativi o analitici:
   * *Occasionali:* accedono saltuariamente richiedendo informazioni eterogenee tramite linguaggi di interrogazione complessi.
   * *Non Esperti (Parametrici):* costituiscono la maggioranza; interagiscono mediante transazioni predefinite (*canned transactions*) attraverso interfacce guidate (es. cassieri, operatori di sportello).
   * *Esperti:* figure tecniche (analisti, ingegneri, scienziati) che sfruttano appieno le potenzialità analitiche del DBMS.
   * *Indipendenti:* gestiscono basi di dati a uso personale tramite software applicativi autonomi con interfacce visuali.

### 4.2 Attori Dietro le Quinte
Figure che sviluppano e mantengono l'infrastruttura software e di sistema del DBMS:
* **Analisti di Sistema:** determinano i requisiti degli utenti finali e definiscono le specifiche per le transazioni predefinite.
* **Programmatori di Applicazioni:** traducono le specifiche in codice sorgente (es. Java, Python, C#), occupandosi del test e della manutenzione delle transazioni parametriche.
* Progettisti e costruttori del software DBMS, sviluppatori di tool di supporto e operatori di sistema.

## 5. Vantaggi dell'Adozione di un DBMS

1. **Controllo della Ridondanza dei Dati:** nei sistemi basati su file ciascun gruppo sviluppa propri file, causando duplicazioni e stati incoerenti. Il DBMS implementa la **ridondanza controllata**, integrando i dati ed eseguendo controlli automatici di consistenza al momento delle modifiche.
2. **Restrizione degli Accessi Non Autorizzati:** sottosistemi di sicurezza gestiti dal DBA consentono la profilazione degli account e l'applicazione puntuale di privilegi di lettura, scrittura e modifica su singoli dati o tabelle.
3. **Memorizzazione Persistente degli Oggetti di Programma:**
   > [!INFO] Conflitto di Impedenza (*Impedance Mismatch*)
   > I sistemi tradizionali soffrono della discrepanza tra le strutture dati tabellari/relazionali del DBMS e i paradigmi ad oggetti dei linguaggi di programmazione. I sistemi di BD a oggetti (OODBMS) e i framework ORM moderni colmano questa lacuna convertendo automaticamente le strutture in memoria.
4. **Strutture di Ottimizzazione delle Query:** introduzione di indici su memoria di massa (basati su alberi B-Tree o tabelle hash), moduli di *query optimization* per la formulazione del piano di esecuzione più efficiente e moduli di buffering in RAM.
5. **Sottosistema di Backup e Ripristino:** recupero automatico e consistente dello stato del database a fronte di guasti hardware o crash software improvvisi.
6. **Molteplicità di Interfacce Utente:** disponibilità simultanea di interfacce grafiche/web per utenti non esperti, interfacce a riga di comando (CLI) per amministratori e API/driver (JDBC, ODBC) per sviluppatori.
7. **Rappresentazione di Associazioni Complesse:** capacità di modellare relazioni articolate tra entità e di navigare le associazioni tramite operazioni di giunzione (*join*) ottimizzate.
8. **Imposizione di Vincoli di Integrità:** il DBMS verifica nativamente vincoli di dominio, vincoli di unicità, integrità della chiave primaria e vincoli di integrità referenziale (chiavi esterne).
9. **Inferenze e Processing Attivo mediante Regole:**
   * *Basi di dati deduttive:* applicazione di regole logiche formali per derivare nuova conoscenza a partire dai dati memorizzati.
   * *Basi di dati attive:* esecuzione di azioni scatenate da eventi specifici tramite **trigger** e **stored procedure**.
10. **Imposizione di Standard Aziendali:** uniformazione della nomenclatura, dei formati e delle regole di documentazione su scala organizzativa.
11. **Riduzione dei Tempi di Sviluppo Applicativo:** rapido sviluppo di nuove applicazioni grazie alla delega al DBMS di funzionalità critiche (concorrenza, recovery, sicurezza).
12. **Flessibilità ed Evoluzione dello Schema:** possibilità di alterare lo schema o l'organizzazione fisica dei dati senza impattare i programmi applicativi preesistenti.
13. **Disponibilità di Informazioni Sempre Aggiornate:** propagazione istantanea degli aggiornamenti a tutte le transazioni e agli utenti concorrenti.
14. **Economie di Scala:** riduzione dei costi globali di gestione grazie al consolidamento infrastrutturale e all'eliminazione delle sovrapposizioni gestionali tra dipartimenti.

## 6. Quando Non Conviene Utilizzare un DBMS

L'approccio basato su DBMS comporta costi vivi e un sovraccarico (*overhead*) sistemico non sempre giustificato:
* Elevati costi iniziali di investimento in licenze software, requisiti hardware aggiuntivi e formazione del personale.
* Overhead prestazionale introdotto dai meccanismi di controllo della concorrenza, sicurezza, integrità e gestione del registro di log (*recovery*).

È opportuno preferire la tradizionale architettura basata su file nelle seguenti condizioni:
* Applicazioni semplici, circoscritte e stabili, per le quali non sono previsti aggiornamenti evolutivi o estensioni future.
* Requisiti di calcolo in tempo reale (*hard real-time*) così stringenti da risultare incompatibili con le latenze introdotte dai moduli del DBMS.
* Contesti operativi con accesso strettamente monoutente, in cui non sussiste alcuna necessità di condivisione simultanea o concorrenza sui dati.

> [!NOTE] Nota del Prof

---

# Lezione 2: Modelli dei Dati, Architettura a Tre Livelli e Classificazione dei DBMS

## 1. I Modelli dei Dati

### 1.1 Definizione e Componenti di un Modello
Un **modello dei dati** è una collezione strutturata di concetti e formalismi impiegata per descrivere la struttura di una base di dati e le operazioni di manipolazione ammesse su di essa.

> [!NOTE] Struttura della Base di Dati
> Per **struttura** di una base di dati si intendono congiuntamente:
> * I **tipi di dato** e i domini ammissibili.
> * Le **associazioni e relazioni** logiche intercorrenti tra i dati.
> * I **vincoli di integrità** che devono essere costantemente soddisfatti dai dati memorizzati.

La totalità dei modelli dei dati include un nucleo di **operazioni fondamentali** preposte all'interrogazione e all'aggiornamento della base di dati (inserimento, cancellazione e modifica dei record).

Oltre alle operazioni di base, un modello può fornire costrutti per modellare l'**aspetto dinamico e comportamentale** del sistema informativo:
* Consente al progettista di formalizzare un insieme di **operazioni definite dall'utente** (ad esempio, l'operazione `calcola_media` associata all'entità `Studente`).
* Nel modello relazionale moderno, questo paradigma si concretizza associando logica attiva direttamente allo schema mediante **trigger**, **stored procedure** e funzioni di dominio.

### 1.2 Tassonomia dei Modelli dei Dati
I modelli dei dati si classificano in tre categorie a seconda del livello di astrazione offerto:

1. **Modelli di Alto Livello o Concettuali:**
   * Forniscono concetti e costrutti molto vicini alle modalità di percezione e ragionamento degli utenti finali del dominio applicativo.
   * Il principale esponente è il **Modello Entità-Relazione (ER)** e le sue estensioni concettuali.
2. **Modelli Implementabili o Logici:**
   * Costituiscono il livello intermedio: presentano concetti comprensibili per gli utenti finali ma non eccessivamente distanti dalle modalità di memorizzazione e rappresentazione del calcolatore.
   * Mascherano i dettagli fisici di basso livello (blocchi, tracce, allocazione di memoria), risultando direttamente implementabili e gestibili dai moderni motori DBMS.
   * Includono i modelli tradizionali (relazionale, reticolare, gerarchico) e orientati agli oggetti.
3. **Modelli di Basso Livello o Fisici:**
   * Descrivono le modalità e i dettagli tecnici con cui i dati sono fisicamente allocati e formattati sui supporti di memoria secondaria.
   * Specificano le strutture di accesso, l'ordinamento dei record, la formattazione dei blocchi e i percorsi di scansione su disco.

## 2. Schemi, Istanze e Stati della Base di Dati

Una distinzione teorica essenziale nella disciplina delle basi di dati separa la descrizione concettuale della base di dati dalla base di dati fisica effettivamente memorizzata.

### 2.1 Schema della Base di Dati (Intensione)
Lo **schema** è la descrizione formale e globale della base di dati, specificata e validata durante la fase di progettazione iniziale.
* **Stabilità Temporale:** Lo schema non muta frequentemente nel corso del tempo; definisce la struttura invariante dell'applicazione.
* **Costrutto di Schema:** Ciascun singolo elemento componente dello schema (es. l'entità `Studente`, l'entità `Corso`, o l'attributo `Matricola`).
* **Diagramma di Schema:** Rappresentazione grafica che illustra alcuni aspetti strutturali salienti dello schema (es. nomi dei record, attributi primari e associazioni), omettendone i dettagli esaustivi come vincoli di integrità avanzati o tipi di memorizzazione fisica.

### 2.2 Stato o Istanze della Base di Dati (Estensione)
Lo **stato** (o **insieme delle istanze**) di una base di dati rappresenta la totalità dei dati effettivamente memorizzati nella base di dati in un preciso istante temporale.

> [!NOTE] Corrispondenza Schema-Istanze
> All'interno della base di dati, ciascun costrutto di schema possiede un proprio insieme corrente di istanze.
> 
> > [!EXAMPLE] Istanza di Costrutto
> > Il costrutto di schema `Studente` conterrà, in un dato momento, l'insieme dei record (o tuple) corrispondenti a ciascun singolo studente iscritto e registrato nel sistema.

### 2.3 Stati Iniziali e Stati Validi
La natura dello stato è intrinsecamente dinamica e si articola in:
* **Stato Iniziale:** La configurazione assunta dalla base di dati nel momento in cui essa viene popolata o caricata per la prima volta con i dati di partenza.
* **Stato Valido (Consistente):** Uno stato che soddisfa rigorosamente la struttura formale e l'integralità dei vincoli definiti nello schema:
  $$\text{Stato } S \text{ è valido} \iff \forall v \in \text{Vincoli}(\text{Schema}), \; S \models v$$
* Ogni operazione di aggiornamento (scrittura, modifica o cancellazione) determina una transizione di stato della base di dati, che il DBMS deve validare per preservarne la consistenza.

| Dimensione di Confronto | Schema (Intensione) | Stato / Istanze (Estensione) |
| :--- | :--- | :--- |
| **Dinamica Temporale** | Statico: non cambia frequentemente nel tempo | Dinamico: muta ad ogni aggiornamento o transazione |
| **Fase di Definizione** | Specificato durante la fase di progettazione | Popolato e manipolato durante la fase di esercizio |
| **Ruolo Semantico** | Rappresenta la struttura, le regole e i vincoli | Rappresenta i dati effettivi registrati |
| **Denominazione Logica** | **Intensione** del sistema informativo | **Estensione** del sistema informativo |

## 3. L'Architettura a Tre Livelli (ANSI/SPARC)

L'**architettura a tre livelli** (formalizzata dal comitato ANSI/SPARC) è stata teorizzata per supportare in modo sistematico due caratteristiche cardine dei moderni DBMS:
1. L'**indipendenza dei dati**.
2. Il supporto a **viste multiple e personalizzate** per classi eterogenee di utenti.

L'architettura separa la gestione del sistema in tre livelli gerarchici di schema:

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

1. **Schema Interno (Livello Interno o Fisico):**
   * Descrive la struttura di memorizzazione fisica dei dati e le strutture di accesso rapido (es. puntatori fisici, indici B-Tree o tabelle hash).
   * Impiega un modello dei dati fisico di basso livello.
2. **Schema Concettuale (Livello Concettuale o Logico Globale):**
   * Descrive l'intera struttura, le entità, i tipi di dato, le associazioni e i vincoli di integrità della base di dati per una collettività di utenti.
   * Nasconde integralmente i dettagli implementativi fisici; adotta un modello concettuale o un modello implementabile.
3. **Schema Esterno (Livello Esterno o delle Viste):**
   * Descrive le prospettive parziali o le viste ritagliate su misura per specifiche comunità di utenti o applicazioni.
   * Adotta il medesimo modello dei dati impiegato per il livello concettuale, isolando le informazioni non pertinenti o riservate.

![[Pasted image 20260925091712.png|450]]

> [!NOTE] Architettura a Tre Schemi
> Il diagramma sopra riportato illustra le interconnessioni tra gli utenti finali (*End Users*), i livelli di schema (*External*, *Conceptual*, *Internal*) e il database persistente memorizzato (*Stored Database*), evidenziando il ruolo pivotale delle mappature intermedie.

### Processi di Mappatura (Mapping)
La trasformazione delle richieste e dei dati attraverso i tre livelli architetturali richiede un'esplicita opera di **mappatura**:
* **Dall'alto verso il basso (Risoluzione delle Richieste):** I programmi applicativi e gli utenti interagiscono con il proprio schema esterno. Il DBMS intercetta le richieste e le mappa verso lo schema concettuale, traducendole successivamente nello schema interno affinché i moduli di I/O possano reperire i blocchi di memoria su disco.
* **Dal basso verso l'alto (Composizione dei Risultati):** I dati grezzi estratti dal livello interno vengono rielaborati e formattati dal DBMS per risalire la gerarchia fino a conformarsi alla vista esterna dell'utente richiedente (ad esempio, la conversione del risultato di una query relazionale in una struttura tabellare su interfaccia web).

## 4. L'Indipendenza dei Dati

L'**indipendenza dei dati** è la proprietà dei sistemi DBMS che consente di modificare la definizione dello schema a un dato livello architetturale senza dover alterare gli schemi ai livelli gerarchici superiori né i programmi applicativi associati.

Si articola rigorosamente in due forme:

### 4.1 Indipendenza Logica dei Dati
È la capacità di apportare modifiche allo **schema concettuale** senza dover modificare gli schemi esterni né i programmi applicativi preesistenti:
* Si manifesta quando si espande la base di dati introducendo nuove tabelle, nuove relazioni o nuovi attributi facoltativi.
* Le applicazioni preesistenti continuano a operare regolarmente; è sufficiente aggiornare la sola **mappatura esterno/concettuale** per garantire l'allineamento.

### 4.2 Indipendenza Fisica dei Dati
È la capacità di apportare modifiche allo **schema interno** senza dover modificare lo schema concettuale né, a cascata, gli schemi esterni o i programmi applicativi:
* Si manifesta quando si riorganizzano i file di memorizzazione su disco, si modificano i percorsi di allocazione fisica o si creano/eliminano strutture ausiliarie (come indici su chiavi primarie o secondarie) per ottimizzare le prestazioni (*tuning* prestazionale).
* È sufficiente aggiornare la **mappatura concettuale/interna**, mantenendo invariata la logica dei livelli superiori.

> [!IMPORTANT] Meccanismo Operativo dell'Indipendenza dei Dati
> Quando uno schema subisce variazioni a un livello più basso, il DBMS richiede esclusivamente la ricalibrazione del modulo di **mapping** verso i livelli sovrastanti. I livelli superiori rimangono inalterati, preservando l'integrità del software applicativo e azzerando i costi di ricompilazione o refactoring del codice.

## 5. Linguaggi e Interfacce per DBMS

Per interagire con i vari livelli architetturali, i sistemi di basi di dati mettono a disposizione linguaggi specializzati:

### 5.1 Linguaggi di Definizione (DDL, SDL e VDL)
* **Data Definition Language (DDL):**
  * Utilizzato dal DBA e dai progettisti per specificare formalmente lo schema concettuale della base di dati.
  * Nella maggior parte dei DBMS commerciali moderni, il DDL viene adoperato anche per definire gli schemi interni ed esterni.
* **Storage Definition Language (SDL):**
  * Linguaggio specifico (presente in sistemi ad architettura avanzata o pura) preposto alla definizione dettagliata dello schema interno e dei parametri fisici di memorizzazione.
* **View Definition Language (VDL):**
  * Linguaggio deputato a specificare le viste dello schema esterno e la relativa mappatura concettuale.
  * Nei sistemi contemporanei basati su standard SQL, le funzionalità di DDL, SDL e VDL sono unificate all'interno dei costrutti di definizione (`CREATE TABLE`, `CREATE INDEX`, `CREATE VIEW`).

### 5.2 Linguaggi di Manipolazione dei Dati (DML)
Il **Data Manipulation Language (DML)** è impiegato per specificare le interrogazioni (*retrieval*) e gli aggiornamenti dello stato della base di dati (inserimenti, modifiche, cancellazioni).

I comandi DML possono essere eseguiti:
1. **In modalità stand-alone (*Query Language*):** Eseguiti direttamente in modo interattivo da terminale o interfaccia grafica.
2. **In modalità integrata (*Embedded DML*):** Annidati all'interno di un linguaggio di programmazione generico a scopo generale (**linguaggio ospite**, come Java, C, Python).
3. **Mediante API e librerie dedicate:** Connessione e manipolazione tramite interfacce standardizzate (es. JDBC, ODBC, librerie ORM).

### 5.3 Classificazione dei DML: Dichiarativi vs Procedurali
I linguaggi DML si distinguono operativamente in due paradigmi:

* **Linguaggi di Alto Livello o Non-Procedurali (Dichiarativi / Set-Oriented):**
  * L'esempio paradigmatico è il linguaggio **SQL**.
  * Specificano dichiarativamente **quali dati reperire**, demandando completamente al modulo di *Query Optimization* del DBMS la definizione dell'algoritmo di accesso.
  * Operano su insiemi di tuple (*set-at-a-time*): una singola istruzione estrae o manipola un'intera collezione di record.
* **Linguaggi di Basso Livello o Procedurali (Record-Oriented):**
  * Specificano dettagliatamente la sequenza algoritmica di passi necessaria per recuperare i dati.
  * Operano su singoli record (*record-at-a-time*): richiedono l'utilizzo di strutture iterative (`loop`), puntatori espliciti e costrutti condizionali all'interno del linguaggio ospite per scorrere sequenze di record.

## 6. Evoluzione e Classificazione dei DBMS in base al Modello dei Dati

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

### 6.1 Modelli Tradizionali

#### I. Modello Gerarchico
* **Struttura:** Rappresenta i dati come una collezione di alberi gerarchici rigidi, in cui a partire da un record radice (*padre*) si accede per discendenza ai record *figli* che ne dipendono (relazioni strettamente 1:N).
* **Contesto Storico:** Sviluppato durante la prima fase dei DBMS (anni '60) ad opera congiunta di IBM e North American Rockwell intorno al 1965 (sviluppato per il programma spaziale Apollo).
* **Linguaggi:** Assenza di uno standard formale universale. Il DML storicamente più diffuso è stato il linguaggio procedurale **DL/1** del sistema **IMS** (*Information Management System*) di IBM.
* **Punti di Forza:** Rispecchia fedelmente la natura strettamente gerarchica di domini organizzativi e produttivi verticali.
* **Limiti:**
  * La rigida alberatura impone vincoli stringenti su interrogazioni e aggiornamenti.
  * Assenza di ottimizzazione automatica delle query: la navigazione fisica è a carico del programmatore.
  * Forte dipendenza dei programmi applicativi dall'organizzazione fisica delle strutture.
  * Inefficienza nella modellazione di relazioni molti-a-molti ($N:M$): la rappresentazione di associazioni complesse costringe alla duplicazione dei dati, generando ridondanza incontrollata.

#### II. Modello Reticolare
* **Struttura:** Rappresenta i dati come tipi di record interconnessi mediante una ragnatela di puntatori espliciti (*set types*), permettendo a un record membro di possedere molteplici record proprietari (*padri*).
* **Contesto Storico:** Il primo prototipo fu l'**IDS** (*Integrated Data Store*), sviluppato da Honeywell nel 1965. Rimase alla base dei principali sistemi commerciali fino alla metà degli anni '80 (IDMS di Cullinet, DMS 1100 di Unisys, IMAGE di HP, VAX-DBMS di Digital/Compaq).
* **Standardizzazione:** Standardizzato dalla **CODASYL** (*Conference on Data Systems Languages*) nel celebre report **DBTG** (*Database Task Group*) del 1971.
* **Punti di Forza:**
  * Un record può avere più genitori, eliminando le anomalie di ridondanza tipiche del modello gerarchico.
  * Consente la modellazione naturale e diretta di relazioni molti-a-molti ($N:M$).
  * Qualsiasi nodo del grafo può costituire il punto di ingresso per navigare la base di dati.
* **Limiti:**
  * Elevata complessità di gestione: la presenza di un fittissimo reticolo di puntatori rende onerosa la manutenzione.
  * Navigazione procedurale a carico dello sviluppatore (*record-at-a-time*), con scarso margine di ottimizzazione automatica da parte del sistema.

![[Pasted image 20260925093710.png|500]]

> [!NOTE] Modello Reticolare: Schema Universitario CODASYL
> Il grafo illustra un'applicazione accademica nel modello reticolare: l'entità `COURSE` agisce come proprietaria verso `SECTION` (tramite `COURSE_OFFERINGS`) e verso `PREREQUISITE` (`HAS_A`/`IS_A`), mentre `GRADE_REPORT` riceve puntatori concorrenti sia da `STUDENT` (`STUDENT_GRADES`) sia da `SECTION` (`SECTION_GRADES`), concretizzando relazioni multilaterali senza duplicazione logica dei record.

#### III. Modello Relazionale
* **Struttura:** Modella l'intera base di dati come una collezione di **relazioni** matematiche (tabelle bidimensionali composte da righe/tuple e colonne/attributi), svincolando la logica dei dati dai puntatori fisici.
* **Contesto Storico:** Teorizzato nel 1970 da **Edgar F. Codd** (ricercatore IBM) nell'articolo seminale *"A Relational Model of Data for Large Shared Data Banks"*. I primi sistemi commerciali debuttarono sul mercato nel 1981-1982.
* **Diffusione e Standard:** Costituisce il paradigma dominante dell'industria del software (IBM DB2, Oracle Database, Microsoft SQL Server, PostgreSQL, MySQL). Ha introdotto lo standard universale **SQL** attraverso le sue successive evoluzioni (SQL-89, SQL-92, SQL:1999 e successive).

### 6.2 Modelli Evoluti ed Emergenti

#### IV. Modello ad Oggetti (OODBMS)
* **Struttura:** Definisce la base di dati conformemente ai principi dell'Object-Oriented Programming (OOP): classi di oggetti, identità persistente indipendente dal valore (OID - *Object Identifier*), incapsulamento di stato e metodi, tipi di dato astratti e gerarchie di ereditarietà.
* **Contesto Storico:** Ha iniziato a diffondersi alla fine degli anni '80 con l'obiettivo di abbattere il *conflitto di impedenza* (*impedance mismatch*) tra i linguaggi OOP e i database tabellari.
* **Penetrazione di Mercato:** Nonostante le elevate potenzialità analitiche e concettuali, la quota complessiva di penetrazione industriale è rimasta confinata al di sotto del 5%, a causa della maturità, robustezza e capillarità degli ecosistemi relazionali.

#### V. Modello Ibrido Relazionale ad Oggetti (ORDBMS)
* **Struttura:** Modello ibrido che estende l'architettura relazionale classica con le funzionalità del paradigma ad oggetti: supporto a tipi di dato complessi e strutturati definiti dall'utente, costruttori di tipo (array, collezioni), ereditarietà tra tabelle e incapsulamento di funzioni.
* **Contesto Storico ed Evoluzione:** Trend affermatosi nella seconda metà degli anni '90 a partire dall'avvento di piattaforme pionieristiche quali *Informix Universal Server*.
* **Adozione Industriale:** Concetti standardizzati formalmente all'interno di **SQL:1999 (SQL3)** e integrati stabilmente nei principali motori DBMS enterprise (Oracle Database a partire da 8i/10g, IBM DB2, PostgreSQL).