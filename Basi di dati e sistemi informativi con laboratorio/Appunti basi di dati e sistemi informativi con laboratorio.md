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

1. **Schema Interno (Livello Interno o Fisico):** (come i file sono memorizzati e.g file,... E meccanismi di accesso per agevolare scrittura e lettura)
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

---

# Lezione 3: Il Modello Relazionale dei Dati (Origini, Fondamenti Matematici, Schemi ed Istanze)

## 1. Introduzione al Modello Relazionale

Il **modello relazionale** è stato teorizzato nel 1970 da **Edgar F. Codd** (ricercatore presso i laboratori IBM di San Jose) con l'obiettivo primario di garantire una reale e rigorosa **indipendenza dei dati** (sia logica che fisica) rispetto alle applicazioni software.

Commercializzato a partire dai primi anni '80 (con l'avvento di piattaforme pionieristiche quali *System R*, *Oracle* e *IBM DB2*), il modello relazionale rappresenta oggi il paradigma dominante dell'industria del software, sotteso alla totalità dei più diffusi DBMS commerciali e open-source.

```
┌────────────────────────────────────────────────────────────────────────┐
│                        Fattori del Successo                            │
├───────────────────────────────────┬────────────────────────────────────┤
│     Semplicità Concettuale        │       Linguaggi Dichiarativi       │
├───────────────────────────────────┼────────────────────────────────────┤
│ La base di dati è percepita dagli │ Interrogazione e manipolazione     │
│ utenti in modo estremamente       │ ad alto livello (SQL, Algebra      │
│ intuitivo come un insieme         │ Relazionale): si specifica COSA    │
│ omogeneo di tabelle bidimensionali│ reperire, demandando al DBMS il    │
│ composte da righe e colonne.      │ COME eseguire l'accesso fisico.    │
└───────────────────────────────────┴────────────────────────────────────┘
```

---

## 2. Modello Relazionale vs Modelli Gerarchico e Reticolare

Il modello relazionale ha introdotto una netta discontinuità rispetto ai modelli precedenti:

1. **Rappresentazione delle Associazioni tra Record:**
   * **Modelli Gerarchico e Reticolare:** Utilizzano **puntatori fisici espliciti** e indirizzi di memoria incorporati nei record per collegare le strutture dati (*pointer-based*). La navigazione è vincolata ai cammini fisici previsti dal progettista.
   * **Modello Relazionale:** Le associazioni tra record sono interamente basate sui **valori dei dati** condivisi (*value-based*). I collegamenti logici vengono stabiliti confrontando i valori contenuti in campi correlati (es. corrispondenza tra chiave primaria e chiave esterna), senza alcun ricorso a puntatori fisici esposti.
2. **Fondamento Formale e Matematico:**
   * I modelli gerarchico e reticolare derivavano da approcci euristici e soluzioni implementative ad-hoc.
   * Il modello relazionale poggia su solide basi formali tratte dalla **teoria matematica degli insiemi** e dalla **logica dei predicati del primo ordine**, consentendo la dimostrazione formale di equivalenze tra espressioni e l'ottimizzazione automatica delle query.

---

## 3. Fondamenti Matematici: Dal Prodotto Cartesiano alle Relazioni

La formalizzazione del modello relazionale trae origine dai concetti di **prodotto cartesiano** e **relazione matematica**.

### 3.1 Prodotto Cartesiano
Siano $D_1, D_2, \dots, D_n$ $n$ insiemi (detti insiemi di supporto o domini, non necessariamente distinti).

> [!NOTE] Definizione di Prodotto Cartesiano
> Il **prodotto cartesiano** $D_1 \times D_2 \times \dots \times D_n$ è l'insieme di tutte le $n$-uple ordinate $(d_1, d_2, \dots, d_n)$ tali che ciascun elemento $d_i$ appartenga al rispettivo dominio $D_i$:
> $$D_1 \times D_2 \times \dots \times D_n = \{ (d_1, d_2, \dots, d_n) \mid d_1 \in D_1, d_2 \in D_2, \dots, d_n \in D_n \}$$

### 3.2 Relazione Matematica
> [!NOTE] Definizione di Relazione Matematica
> Una **relazione matematica** $R$ definita sugli insiemi $D_1, D_2, \dots, D_n$ è un qualsiasi sottoinsieme del loro prodotto cartesiano:
> $$R \subseteq D_1 \times D_2 \times \dots \times D_n$$

* **Grado di una Relazione:** È il numero $n$ di insiemi/domini componenti il prodotto cartesiano (ovvero il numero di componenti di ciascuna $n$-upla).
* **Cardinalità di una Relazione ($|R|$):** È il numero complessivo di elementi ($n$-uple) appartenenti all'insieme $R$.

---

## 4. Dalle Relazioni Matematiche alle Relazioni nel Modello Relazionale

Sebbene il modello relazionale poggi sulla nozione matematica di relazione, esso introduce due importanti adattamenti per rispondere alle esigenze pratiche di memorizzazione e manipolazione dei dati:

```
┌─────────────────────────────────┐       ┌─────────────────────────────────┐
│       Relazione Matematica      │       │  Relazione nel Modello dei Dati │
├─────────────────────────────────┼───────┼─────────────────────────────────┤
│ • n-uple ordinate: (d1, ..., dn)│  ──►  │ • Tuple NON ordinate            │
│ • Posizione fissa per indice i  │       │ • Attributi nominati (nomi col.)│
│ • Nessun valore nullo ammesso   │       │ • Supporto al valore speciale   │
│                                 │       │   NULL (dato mancante/ignoto)   │
└─────────────────────────────────┘       └─────────────────────────────────┘
```

1. **Assenza di Ordinamento Posizionale:** Nelle relazioni matematiche gli elementi di una $n$-upla sono rigidamente ordinati per posizione; nelle basi di dati la sequenza orizzontale delle colonne non deve avere rilevanza semantica.
2. **Identificazione tramite Attributi:** Risulta conveniente e intuitivo associare a ciascuna componente un **nome simbolico (attributo)** esplicito (es. `Nome`, `Matricola`, `Stipendio`), anziché identificarla tramite il suo indice numerico posizionale $i$.

---

## 5. Domini, Attributi e il Concetto Formale di Tupla

### 5.1 Domini
> [!NOTE] Definizione di Dominio
> Un **dominio** $D$ è un insieme non vuoto di valori atomici (indivisibili dal punto di vista del DBMS).

* Con $\text{Dom}(A)$ indichiamo il dominio formalmente associato all'attributo $A$.
* *Esempio:* $\text{Dom}(\text{Nazione})$ rappresenta l'insieme delle stringhe di caratteri indicanti nomi validi di stati sovrani; $\text{Dom}(\text{Voto})$ rappresenta l'insieme dei numeri interi $\{18, 19, \dots, 30, 30L\}$.

### 5.2 Attributi
Un **attributo** $A$ è un'etichetta o nome simbolico associato a un determinato dominio con un preciso significato semantico all'interno dello schema.

### 5.3 Il Concetto di Tupla
Sia $X = \{A_1, A_2, \dots, A_n\}$ un insieme finito di attributi.

> [!NOTE] Definizione di Tupla
> Una **tupla** $t$ definita sull'insieme di attributi $X$ è una funzione che associa a ogni attributo $A_i \in X$ un valore appartenente al suo dominio $\text{Dom}(A_i)$, oppure lo speciale valore `NULL`:
> $$t: X \rightarrow \bigcup_{A_i \in X} \text{Dom}(A_i) \cup \{\text{NULL}\} \quad \text{tale che} \quad t[A_i] \in \text{Dom}(A_i) \lor t[A_i] = \text{NULL}$$

* Indichiamo con la notazione $t[A_i]$ (oppure $t.A_i$) il valore assunto dalla tupla $t$ in corrispondenza dell'attributo $A_i$.

> [!INFO] Il Valore Speciale NULL
> Il valore `NULL` indica l'assenza di un valore reale; viene impiegato per rappresentare tre condizioni semantiche distinte:
> 1. Valore **sconosciuto** (es. data di nascita non ancora registrata).
> 2. Valore **inesistente o non applicabile** (es. numero di patente per un cittadino non patentato).
> 3. Valore **omesso/riservato**.

---

## 6. Relazioni: Schemi ed Istanze

La distinzione tra livello intensionale (statico) ed estensionale (dinamico) si applica puntualmente alle relazioni:

### 6.1 Schema di Relazione
> [!NOTE] Definizione di Schema di Relazione
> Dato un insieme di attributi $X = \{A_1, A_2, \dots, A_n\}$, uno **schema di relazione** è costituito da un nome di relazione $R$ e dall'insieme di attributi $X$:
> $$R(X) \quad \text{oppure} \quad R(A_1, A_2, \dots, A_n)$$

Qualora sia necessario esplicitare i domini di riferimento, si adotta la notazione estesa:
$$R(A_1: \text{Dom}(A_1), A_2: \text{Dom}(A_2), \dots, A_n: \text{Dom}(A_n))$$

### 6.2 Istanza di Relazione
> [!NOTE] Definizione di Istanza di Relazione
> Dato uno schema di relazione $R(X)$, un'**istanza di relazione** $r(R)$ (o semplicemente $r$) su $X$ è un **insieme finito di tuple** su $X$:
> $$r(R) = \{t_1, t_2, \dots, t_k\}$$

Poiché un'istanza è matematicamente un **insieme** di tuple:
* Non possono esistere tuple duplicate identiche all'interno della medesima istanza.
* L'ordine delle tuple (righe) non ha alcuna rilevanza.

---

## 7. Basi di Dati: Schemi ed Istanze

Estendendo il formalismo a livello di sistema globale:

### 7.1 Schema di Base di Dati
> [!NOTE] Definizione di Schema di Base di Dati
> Uno **schema di base di dati** $\mathcal{B}$ è una collezione di schemi di relazione con denominazioni distinte:
> $$\mathcal{B} = \{R_1(X_1), R_2(X_2), \dots, R_m(X_m)\}$$
> corredato dalla specifica dell'insieme dei relativi **vincoli di integrità** $\mathcal{I}$.

### 7.2 Istanza di Base di Dati
> [!NOTE] Definizione di Istanza di Base di Dati
> Un'**istanza di base di dati** $b$ definita sullo schema $\mathcal{B} = \{R_1(X_1), \dots, R_m(X_m)\}$ è un insieme di istanze di relazione:
> $$b = \{r_1, r_2, \dots, r_m\}$$
> tale che ciascuna $r_i$ sia un'istanza valida dello schema di relazione $R_i(X_i)$ (per ogni $i \in \{1, \dots, m\}$) e rispetti l'insieme dei vincoli $\mathcal{I}$.

---

## 8. Esempio Pratico di Formalizzazione

Si consideri uno schema universitario $\mathcal{B} = \{\text{Studente}(\text{Matricola}, \text{Nome}), \text{Corso}(\text{Codice}, \text{Nome}), \text{Iscrizione}(\text{Studente}, \text{Corso})\}$:

```
Istanza Studente (r_Studente):
┌───────────┬──────────────┐
│ Matricola │ Nome         │
├───────────┼──────────────┤
│ 37891     │ Mario Rossi  │
│ 5421      │ Luigi Verdi  │
└───────────┴──────────────┘

Istanza Corso (r_Corso):
┌────────┬──────────────┐
│ Codice │ Nome         │
├────────┼──────────────┤
│ 1      │ BD           │
│ 2      │ ASD          │
└────────┴──────────────┘

Istanza Iscrizione (r_Iscrizione):
┌──────────┬───────┐
│ Studente │ Corso │
├──────────┼───────┤
│ 37891    │ 1     │
│ 37891    │ 2     │
└──────────┴───────┘
```

Nel formalismo matematico delle funzioni/tuple, l'istanza globale corrisponde all'insieme:
$$b = \left\{
\begin{aligned}
&\{ \{(\text{Matricola}, 37891), (\text{Nome}, \text{"Mario Rossi"})\}, \{(\text{Matricola}, 5421), (\text{Nome}, \text{"Luigi Verdi"})\} \}, \\
&\{ \{(\text{Codice}, 1), (\text{Nome}, \text{"BD"})\}, \{(\text{Codice}, 2), (\text{Nome}, \text{"ASD"})\} \}, \\
&\{ \{(\text{Studente}, 37891), (\text{Corso}, 1)\}, \{(\text{Studente}, 37891), (\text{Corso}, 2)\} \}
\end{aligned}
\right\}$$

---

## 9. Mappatura Terminologica: Concetto Formale vs Equivalente Informale

| Concetto Formale (Modello Relazionale) | Equivalente Tabellare Informale | Corrispettivo nei File Tradizionali |
| :--- | :--- | :--- |
| **Relazione** | Tabella | File |
| **Attributo** | Intestazione di Colonna / Campo | Campo del record |
| **Tupla** | Riga della tabella | Singolo Record |
| **Dominio** | Tipo di dato e vincoli di colonna | Tipo di dato del campo |
| **Grado** | Numero di colonne della tabella | Numero di campi per record |
| **Cardinalità** | Numero di righe della tabella | Numero di record nel file |
| **Schema di Relazione** | Struttura / DDL dell'intestazione | Definizione del tracciato record |
| **Istanza di Relazione** | Insieme corrente di righe popolate | Contenuto del file su disco |

---

# Lezione 4: Vincoli di Integrità nel Modello Relazionale

## 1. I Vincoli di Integrità e la loro Classificazione

> [!NOTE] Definizione di Vincolo di Integrità
> I **vincoli di integrità** sono predicati posti sui valori effettivi che caratterizzano uno stato (o istanza) di base di dati: uno stato è ammissibile solo se li soddisfa tutti, e la loro violazione rende lo stato incoerente rispetto al mini-mondo rappresentato.

Si distinguono quattro categorie:

1. **Vincoli intrinseci (basati sul modello):** sono imposti dalla struttura stessa del modello dei dati e non richiedono di essere dichiarati esplicitamente, essendo soddisfatti per costruzione da ogni costruzione consentita dal modello.
2. **Vincoli basati sullo schema:** sono esprimibili direttamente sugli schemi del modello dei dati, mediante il linguaggio di definizione **DDL** (*Data Definition Language*), e vengono di conseguenza verificati dal DBMS in modo automatico e centralizzato.
3. **Vincoli non esprimibili sullo schema:** sono vincoli che non possono essere formalizzati negli schemi del modello dei dati e devono essere specificati realizzando programmi applicativi; la loro verifica è quindi demandata al codice applicativo e non è garantita dal DBMS.
4. **Vincoli di dipendenza funzionale:** costituiscono un ulteriore ed importante insieme di vincoli, impiegati principalmente per verificare la qualità della progettazione di basi di dati relazionali.

> [!EXAMPLE] Il vincolo di assenza di tuple duplicate
> Il divieto per una relazione di contenere **tuple duplicate** è un vincolo intrinseco al modello relazionale: non è dichiarato in alcun modo, eppure ogni istanza ammissibile lo rispetta. Il motivo è formale e già anticipato nella Lezione 3: poiché un'istanza di relazione è matematicamente un **insieme** di tuple, per definizione non può contenere due elementi identici.

> [!IMPORTANT] Dove viene imposto il vincolo
> Le quattro categorie si distinguono in funzione del soggetto che assume la responsabilità di fare rispettare il vincolo: il **modello** dei dati, che lo garantisce da solo e senza dichiarazione; lo **schema**, che lo dichiara in DDL e ne affida la verifica al DBMS; i **programmi applicativi**, che devono codificarlo a mano con i margini di errore che ne conseguono. Le dipendenze funzionali, infine, hanno un ruolo diverso da tutti gli altri: non vengono usate per reprimere stati incoerenti, ma per valutare la bontà della progettazione.

## 2. I Vincoli Basati sullo Schema

I **vincoli basati sullo schema**, oggetto di studio sistematico di questa lezione, sono i vincoli che possono essere espressi direttamente negli schemi del modello dei dati tramite il DDL. La loro formalizzazione nello schema ha due conseguenze decisive:

* **Centralizzazione della verifica:** il vincolo diventa parte della descrizione formale della base di dati, anziché logica disseminata nei programmi che la accedono.
* **Verifica automatica a ogni operazione:** il DBMS può controllare il rispetto del vincolo in corrispondenza di ogni operazione di aggiornamento, impedendo che uno stato non ammissibile venga mai materializzato.

A loro volta, i vincoli basati sullo schema si suddividono ulteriormente in due famiglie, distinte per l'ampiezza dell'ambito che coinvolgono:

| Famiglia | Ambito di coinvolgimento | Portata della verifica |
| :--- | :--- | :--- |
| **Vincoli intrarelazionali** | Coinvolgono un unico schema di relazione | Verificabili relazione per relazione, in isolamento |
| **Vincoli interelazionali** | Coinvolgono più schemi di relazioni | Richiedono di considerare contemporaneamente lo stato di più relazioni della base di dati |

La distinzione è operativamente netta: la verifica di un vincolo intrarelazionale è un controllo *locale*, confinato all'interno di una singola relazione; quella di un vincolo interrelazionale è un controllo *globale*, che deve tenere conto contemporaneamente del contenuto di più istanze di relazione e presuppone quindi un meccanismo di coordinazione tra le strutture coinvolte.

---
# Lezione 5: Introduzione al Linguaggio SQL, DDL (Data Definition Language) e PostgreSQL

## 1. Il Linguaggio SQL e Concetti Fondamentali

### 1.1 Inquadramento Storico ed Evoluzione degli Standard
Il linguaggio **SQL** (*Structured Query Language*) costituisce il linguaggio standard de facto e de jure per l'interazione con i sistemi di gestione di basi di dati relazionali (RDBMS).

* **Origini Storiche (1974):** Nasce originariamente con il nome di **SEQUEL** (*Structured English QUEry Language*), sviluppato da Donald Chamberlin e Raymond Boyce presso i laboratori IBM Research nell'ambito del progetto prototipale **System R**.
* **Prime Implementazioni Commerciali (1981):** Introdotto sul mercato da IBM con **SQL/DS** e da **Oracle Corporation** con il proprio RDBMS.
* **Processo di Standardizzazione:**
  * **1986 (SQL-86):** Primo standard formale ratificato da ANSI e ISO.
  * **1992 (SQL-92 o SQL2):** Standard fondamentale che ha introdotto una specifica ricca e articolata, diventando la base di riferimento per tutti i moderni motori relazionali.
  * **1999 (SQL-99 o SQL3):** Estensione dello standard per includere funzionalità orientate agli oggetti (ORDBMS), trigger e tipi definiti dall'utente.
  * **2003 (SQL:2003):** Introduzione del supporto nativo a strutture dati XML e sequenze.

> [!INFO] Livelli di Conformità dello Standard SQL-92
> Data la complessità dello standard SQL-92, sono stati definiti tre livelli incrementali di aderenza:
> 1. **Entry SQL:** Livello base (molto vicino a SQL-89), supportato dalla totalità dei DBMS.
> 2. **Intermediate SQL:** Supportato dalla maggior parte dei DBMS commerciali ed enterprise, include le funzionalità operative richieste dal mercato.
> 3. **Full SQL:** Specifica avanzata completa; i singoli vendor implementano dialetti proprietari ed estensioni non standard che possono comportare leggere incompatibilità tra piattaforme.

### 1.2 Tassonomia delle Funzionalità e Sottolinguaggi di SQL
SQL integra in un unico formalismo dichiarativo molteplici componenti funzionali:

1. **Data Definition Language (DDL):** Permette di definire, modificare e rimuovere gli schemi, le tabelle, i domini, le viste e i relativi vincoli di integrità.
   * *Istruzioni principali:* `CREATE`, `ALTER`, `DROP`, `RENAME`, `TRUNCATE`.
2. **Data Manipulation Language (DML):** Consente di interrogare ed aggiornare i dati memorizzati nelle istanze di relazione.
   * *Istruzioni principali:* `SELECT` (interrogazione), `INSERT`, `UPDATE`, `DELETE` (manipolazione).
3. **Data Control Language (DCL):** Regola le politiche di sicurezza, l'accesso concorrente e i privilegi assegnati agli utenti della base di dati.
   * *Istruzioni principali:* `GRANT`, `REVOKE`.
4. **Transaction Control Language (TCL):** Governa l'esecuzione delle transazioni, garantendo il consolidamento o l'annullamento delle modifiche apportate alla base di dati.
   * *Istruzioni principali:* `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `SET TRANSACTION`.
5. **Embedded SQL (Interfacce con Linguaggi Ospite):** Permette l'incorporamento diretto delle istruzioni SQL all'interno del codice sorgente di linguaggi di programmazione procedurali o a oggetti (C, C++, Java via JDBC/SQLJ, Python).

### 1.3 Architettura e Funzionamento di un DBMS basato su SQL
Dal punto di vista sistemistico, un DBMS basato su SQL è strutturato come un'architettura **Client-Server**:
* Il **server DBMS** gestisce l'allocazione su memoria secondaria, il log delle transazioni, la sicurezza e l'esecuzione ottimizzata dei piani di interrogazione.
* Il **client** stabilisce una connessione specificando l'utente e il database di destinazione su cui operare.

In piena coerenza con i fondamenti del modello relazionale:
* La base di dati è caratterizzata a livello intensionale dal proprio **schema** e a livello estensionale dall'**istanza corrente** dei dati memorizzati.
* L'autodescrizione del sistema è garantita dal **catalogo di sistema** (o dizionario dei dati), che conserva i **metadati** descrittivi di tutti gli oggetti del database.

---

## 2. Creazione di una Base di Dati in SQL: Il DDL

### 2.1 Astrazione dei Dati e Concetto di Schema
Uno **schema** in SQL rappresenta un partizionamento logico della base di dati in namespace distinti e comunicanti.

![[Pasted image 20261002091155.png|450]]

> [!NOTE] Astrazione dei Dati e Catalogo in SQL
> Il catalogo del DBMS memorizza le definizioni formali dei metadati articolati per schemi, ciascuno dei quali racchiude tabelle, viste, domini, vincoli e privilegi accessibili alle applicazioni.

#### I. Definizione di uno Schema
La creazione di uno schema avviene mediante l'istruzione:
```sql
CREATE SCHEMA <nome_schema> [AUTHORIZATION <nome_proprietario>];
```
* Qualora la clausola `AUTHORIZATION` venga omessa, il proprietario dello schema coincide per default con l'utente che ha eseguito il comando.
* Uno schema può fungere da contenitore per definizioni di tabelle, domini, viste, vincoli di integrità e funzioni.

> [!NOTE] Convenzioni Sintattiche BNF
> Nelle specifiche sintattiche standard si adottano le seguenti convenzioni formali:
> * `[ ]` : Il contenuto racchiuso tra parentesi quadre è **opzionale**.
> * `< >` : Segnaposto indicante un valore a **libera scelta dell'utente** (es. identificatori di schema o tabella).
> * `{ | }` : Scelta esclusiva tra alternative mutuamente disgiunte.
> * `...` : Possibilità di **ripetizione** dell'elemento o della sequenza precedente.

#### II. Risoluzione dei Nomi e Qualificazione degli Oggetti
Per fare riferimento a un oggetto situato all'interno di uno schema specifico si impiega la notazione qualificata con punto (`<nome_schema>.<nome_oggetto>`):

```sql
CREATE DOMAIN Ditta.dom_stipendio AS NUMERIC(8, 2) CHECK (VALUE >= 900);
CREATE DOMAIN Ditta.dom_cod_impiegato AS VARCHAR(4);

CREATE TABLE Ditta.Impiegato (
    cod Ditta.dom_cod_impiegato PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    stipendio Ditta.dom_stipendio
);
```

Se l'ambiente di esecuzione imposta implicitamente uno schema di lavoro attivo, non è necessario qualificare esplicitamente il nome degli oggetti.

> [!INFO] Schema Predefinito `public` in PostgreSQL
> In PostgreSQL esiste uno schema di default denominato `public`. Qualsiasi oggetto creato o referenziato senza specificare uno schema viene automaticamente associato allo schema `public`:
> ```sql
> CREATE TABLE R (a CHAR PRIMARY KEY, b CHAR);
> -- Equivale a:
> CREATE TABLE public.R (a CHAR PRIMARY KEY, b CHAR);
> ```

---

### 2.2 Definizione delle Tabelle (`CREATE TABLE`)
L'istruzione cardine del DDL per la creazione di una tabella è `CREATE TABLE`. Essa assolve a tre funzioni:
1. Definisce la struttura dello schema di relazione.
2. Alloca un'istanza inizialmente vuota della tabella nel database.
3. Specifica gli attributi, i rispettivi domini, gli eventuali valori di default e l'insieme dei vincoli di integrità.

#### Sintassi Generale dell'Istruzione `CREATE TABLE`
```sql
CREATE TABLE <nome_tabella> (
    <nome_colonna> <dominio> [DEFAULT <valore_default>] [<vincolo_colonna> ...]
    [, { <nome_colonna> <dominio> [DEFAULT <valore_default>] [<vincolo_colonna> ...] | <vincolo_tabella> } ...]
);
```

* **Clausola `DEFAULT`:** Assegna un valore predefinito alla colonna nel caso in cui una tupla venga inserita omettendo il valore per quell'attributo.

> [!EXAMPLE] Creazione di una Tabella Semplice
> ```sql
> CREATE TABLE utente (
>     email VARCHAR(40) NOT NULL,
>     nome VARCHAR(30) NOT NULL,
>     cognome VARCHAR(30) NOT NULL,
>     anno_nascita INTEGER,
>     PRIMARY KEY (email)
> );
> ```

---

### 2.3 I Domini in SQL
I domini associabili alle colonne si suddividono in **domini elementari predefiniti** dallo standard SQL e **domini definiti dall'utente**.

#### I. Domini Elementari (Standard SQL)

##### 1. Domini Stringa di Caratteri
| Dominio | Descrizione |
| :--- | :--- |
| `CHAR(n)` o `CHARACTER(n)` | Stringhe di testo a lunghezza fissa di $n$ caratteri. Se la stringa inserita ha una lunghezza inferiore a $n$, il sistema aggiunge automaticamente spazi di riempimento (*padding*) in coda. |
| `CHAR` o `CHARACTER` | Sinonimo compatto di `CHAR(1)` (singolo carattere). |
| `VARCHAR(n)` o `CHARACTER VARYING(n)` | Stringhe di testo a lunghezza variabile, contenenti al massimo $n$ caratteri (senza aggiunta di spazi in coda). |

##### 2. Domini Numerici Esatti (Fixed-Point ed Interi)
Rappresentano valori interi o frazionari mediante una notazione in virgola fissa, escludendo errori di arrotondamento binario:
| Dominio | Descrizione |
| :--- | :--- |
| `SMALLINT` | Valore intero memorizzato su 2 byte (16 bit), con intervallo $[-2^{15}, 2^{15}-1] = [-32768, 32767]$. |
| `INTEGER` (o `INT`) | Valore intero memorizzato su 4 byte (32 bit), con intervallo $[-2^{31}, 2^{31}-1] = [-2147483648, 2147483647]$. |
| `NUMERIC(prec, scala)` | Numero decimale a virgola fissa con calcolo esatto fino a 1000 cifre significative. `prec` rappresenta la precisione totale (numero complessivo di cifre significative), mentre `scala` definisce il numero di cifre decimali dopo la virgola (es. `22.4454` ha precisione 6 e scala 4; gli interi presentano scala 0). |
| `DECIMAL(prec, scala)` (o `DEC`) | Analogo a `NUMERIC`, con la specifica che l'implementazione del DBMS può consentire una precisione effettiva uguale o superiore a `prec`. |

##### 3. Domini Numerici Approssimati (Floating-Point)
Rappresentano numeri reali mediante notazione in virgola mobile ad ampio spettro:
| Dominio | Descrizione |
| :--- | :--- |
| `REAL` | Numero in virgola mobile a precisione singola (4 byte). Tipicamente opera nell'intervallo $[10^{-37}, 10^{37}]$ con almeno 6 cifre decimali di precisione. |
| `DOUBLE PRECISION` | Numero in virgola mobile a doppia precisione (8 byte). Tipicamente opera nell'intervallo $[10^{-307}, 10^{307}]$ con almeno 15 cifre decimali di precisione. |
| `FLOAT(prec)` | Numero in virgola mobile in cui `prec` fissa la precisione minima richiesta in termini di bit di mantissa binaria. |

##### 4. Domini Temporali
| Dominio | Descrizione | Esempio Formale |
| :--- | :--- | :--- |
| `DATE` | Memorizza una data calendariale (anno, mese, giorno). Formato canonico raccomandato ISO: `'YYYY-MM-DD'`. | `'2026-10-02'` |
| `TIME` | Memorizza l'orario (ore, minuti, secondi). | `'14:30:00'` |
| `TIMESTAMP` | Memorizza data e orario congiunti, includendo frazioni decimali di secondo. | `'2026-10-02 14:30:10.50'` |
| `INTERVAL` | Rappresenta un lasso o intervallo temporale relativo. | `'1 day 12 hours 50 min'` |

##### 5. Domini Booleani
| Dominio | Descrizione | Valori Ammessi |
| :--- | :--- | :--- |
| `BOOLEAN` | Rappresenta il tipo logico trivalente (`TRUE`, `FALSE`, `UNKNOWN`/`NULL`). | Letterali standard: `TRUE`, `FALSE` (in PostgreSQL sono accettati anche `'t'`, `'f'`, `'true'`, `'false'`, `'1'`, `'0'`, `'yes'`, `'no'`). |

---

#### II. Domini Definiti dall'Utente (`CREATE DOMAIN`)
In SQL l'utente può formalizzare nuovi domini con vincoli e valori di default specifici tramite il comando `CREATE DOMAIN`.

#### Sintassi di Definizione del Dominio
```sql
CREATE DOMAIN <nome_dominio> [AS] <tipo_base>
    [DEFAULT <valore_default>]
    [CONSTRAINT <nome_vincolo>] [CHECK (<condizione>)];
```

All'interno della clausola di `CHECK`, la parola chiave speciale **`VALUE`** indica il valore assunto dall'istanza del dato da validare.

> [!EXAMPLE] Esempi di Domini Utente
> ```sql
> -- Dominio per sigla provinciale (esattamente 2 caratteri non nulli)
> CREATE DOMAIN provincia AS CHAR(2) NOT NULL;
> 
> -- Dominio per votazione universitaria d'esame
> CREATE DOMAIN voto AS INTEGER
>     CHECK (VALUE BETWEEN 18 AND 30);
> 
> -- Dominio con vincoli multipli nominati
> CREATE DOMAIN nat_pari AS INTEGER
>     CONSTRAINT positivo CHECK (VALUE >= 0)
>     CONSTRAINT pari CHECK (VALUE % 2 = 0);
> ```

---

## 3. Vincoli di Integrità nel DDL di SQL

### 3.1 Vincoli di Integrità Intrarelazionali
I vincoli intrarelazionali impongono condizioni di consistenza valide all'interno della singola tabella:

1. **`NOT NULL`:** Impedisce che all'attributo venga assegnato il valore speciale `NULL`. Il dato deve essere obbligatoriamente specificato all'inserimento.
2. **`UNIQUE`:** Impone che i valori dell'attributo (o dell'insieme di attributi) costituiscano una superchiave, vietando la presenza di tuple distinte con gli stessi valori non nulli.
   * *Su singolo attributo:* `Matricola CHAR(6) UNIQUE` vieta matricole duplicate.
   * *Su insieme di attributi (vincolo di tabella):* `UNIQUE(Nome, Cognome)` impone che non vi siano due righe che abbiano contemporaneamente lo stesso nome e lo stesso cognome (ammettendo però persone con lo stesso nome o con lo stesso cognome).
   * *Distinzione:* Dichiarare `Nome VARCHAR(20) UNIQUE, Cognome VARCHAR(20) UNIQUE` vieterebbe invece sia la duplicazione del nome sia la duplicazione del cognome presi singolarmente.
3. **`PRIMARY KEY`:** Dichiara la chiave primaria della tabella. Ciascuna tabella ammette **una sola** chiave primaria, che per definizione implica le proprietà di unicità (`UNIQUE`) e non nullità (`NOT NULL`).
   * *Inline su singola colonna:* `matricola CHAR(6) PRIMARY KEY`.
   * *A livello di tabella (chiave composta):* `PRIMARY KEY(Nome, Cognome)`.
4. **`CHECK (<condizione>)`:** Impone un predicato booleano generico che ogni tupla deve verificare.

#### Sintassi dei Vincoli Intrarelazionali
* **Vincoli di Colonna:**
  ```sql
  [CONSTRAINT <nome_vincolo>] { NOT NULL | UNIQUE | PRIMARY KEY | CHECK (<condizione>) }
  ```
* **Vincoli di Tabella:**
  ```sql
  [CONSTRAINT <nome_vincolo>] { PRIMARY KEY (<colonna> [, ...]) | UNIQUE (<colonna> [, ...]) | CHECK (<condizione>) }
  ```

> [!EXAMPLE] Definizione con Vincoli Intrarelazionali di Colonna e di Tabella
> ```sql
> CREATE TABLE Impiegato (
>     matricola CHAR(6) PRIMARY KEY,
>     nome VARCHAR(20) NOT NULL,
>     cognome VARCHAR(20) NOT NULL,
>     stipendio NUMERIC(8, 2) DEFAULT 1000,
>     CONSTRAINT impiegato_univoco UNIQUE (cognome, nome),
>     CONSTRAINT stipendio_minimo CHECK (stipendio >= 1000)
> );
> ```

---

### 3.2 Vincoli di Integrità Interrelazionali (Integrità Referenziale)
I vincoli interrelazionali stabiliscono relazioni di coerenza tra schemi distinti, collegando una **tabella referente (interna)** a una **tabella referenziata (esterna)** mediante il concetto di **Chiave Esterna (*Foreign Key*)**.

* **Semantica del Vincolo:** Per ogni tupla della tabella interna, i valori non nulli presenti negli attributi di chiave esterna devono esistere identici come valori di chiave primaria o superchiave (`UNIQUE`) nella tabella esterna.

> [!IMPORTANT] Vincolo di Unicità sulla Tabella Esterna
> L'attributo referenziato della tabella esterna **deve** essere obbligatoriamente dichiarato come `PRIMARY KEY` o come `UNIQUE`.

#### Costrutti SQL: `REFERENCES` vs `FOREIGN KEY`
SQL fornisce due costrutti complementari:
1. **Costrutto `REFERENCES` (Vincolo di Colonna):** Impiegato quando la chiave esterna è definita su un singolo attributo.
   ```sql
   <nome_colonna> <tipo_dato> REFERENCES <tabella_esterna>(<colonna_esterna>)
   ```
2. **Costrutto `FOREIGN KEY ... REFERENCES` (Vincolo di Tabella):** Impiegato per chiavi esterne composte da più attributi o per attribuire un nome esplicito al vincolo.
   ```sql
   [CONSTRAINT <nome_vincolo>] FOREIGN KEY (<colonna_1>, <colonna_2>) 
       REFERENCES <tabella_esterna>(<colonna_1_est>, <colonna_2_est>)
   ```

> [!EXAMPLE] Uso del Costrutto `REFERENCES` su Singola Colonna
> ```sql
> CREATE TABLE dipartimento (
>     nome_dip VARCHAR(15) PRIMARY KEY,
>     sede VARCHAR(20) NOT NULL
> );
> 
> CREATE TABLE impiegato (
>     matricola CHAR(6) PRIMARY KEY,
>     nome VARCHAR(20) NOT NULL,
>     cognome VARCHAR(20) NOT NULL,
>     nome_dpt VARCHAR(15) REFERENCES dipartimento(nome_dip)
> );
> ```

> [!EXAMPLE] Uso del Costrutto `FOREIGN KEY` su Insieme di Attributi
> ```sql
> CREATE TABLE anagrafica (
>     codice_fiscale CHAR(16) PRIMARY KEY,
>     nome VARCHAR(20) NOT NULL,
>     cognome VARCHAR(20) NOT NULL,
>     UNIQUE (nome, cognome)
> );
> 
> CREATE TABLE impiegato (
>     matricola CHAR(6) PRIMARY KEY,
>     nome VARCHAR(20) NOT NULL,
>     cognome VARCHAR(20) NOT NULL,
>     nome_dpt VARCHAR(15) REFERENCES dipartimento(nome_dip),
>     FOREIGN KEY (nome, cognome) REFERENCES anagrafica(nome, cognome)
> );
> ```

---

## 4. Introduzione a PostgreSQL e al Client `psql`

### 4.1 Caratteristiche di PostgreSQL
**PostgreSQL** è un sistema di gestione di basi di dati relazionale a oggetti (**ORDBMS**) open source tra i più avanzati al mondo, derivato dal progetto di ricerca *Postgres* avviato nel 1977 presso l'Università della California a Berkeley.

* **Modello Client-Server:** La comunicazione e l'elaborazione dei dati avvengono tra il motore server e i diversi client applicativi tramite protocolli di rete standard.

### 4.2 Il Client Interattivo da Terminale `psql`
`psql` è il client a riga di comando distribuito nativamente con PostgreSQL. Permette l'interazione diretta con il server e l'amministrazione completa delle istanze.

#### I. Connessione al Server
La sintassi di accesso da shell è:
```bash
psql -U <nome_utente> -h <hostname> -p <porta> -d <database>
```

All'avvio della sessione, `psql` fornisce i comandi primari di consultazione:
* `\h` : Guida in linea sulla sintassi dei comandi SQL.
* `\?` : Guida in linea sui meta-comandi interni ("Slash Commands") di `psql`.
* `\q` : Uscita dalla sessione interattiva di `psql`.

#### II. Principali Comandi Slash di `psql`

| Comando Slash | Descrizione e Funzionalità |
| :--- | :--- |
| `\l` | Elenca tutti i database presenti nel cluster. |
| `\c[onnect] [nomedb [utente]]` | Commuta la connessione verso un nuovo database (opzionalmente con un altro utente). |
| `\d` | Elenca le relazioni (tabelle, viste, sequenze) presenti nello schema corrente. |
| `\d <tabella>` | Descrive dettagliatamente la struttura della tabella specificata (colonne, tipi, modificatori, indici e vincoli). |
| `\dt` | Elenca esclusivamente le tabelle. |
| `\dv` | Elenca le viste (*views*). |
| `\di` | Elenca gli indici. |
| `\ds` | Elenca le sequenze. |
| `\dT` | Elenca i tipi di dato e i domini definiti. |
| `\df` | Elenca le funzioni memorizzate. |
| `\do` | Elenca gli operatori disponibili. |
| `\da` | Elenca le funzioni di aggregazione. |
| `\dp` (o `\z`) | Mostra i privilegi e i permessi di accesso assegnati alle tabelle. |
| `\dd [oggetto]` | Mostra la documentazione/commenti associati all'oggetto. |
| `\e [file]` | Apre l'editor esterno di sistema per modificare il buffer della query corrente o il file specificato. |
| `\i <file>` | Legge ed esegue i comandi SQL contenuti nel file indicato (*script execution*). |
| `\p` | Visualizza il contenuto del buffer della query corrente. |
| `\r` | Cancella il contenuto del buffer della query. |
| `\g [file]` | Invia la query al server e scrive opzionalmente i risultati nel file indicato. |
| `\o [file]` | Reindirizza tutti i risultati delle query successive nel file indicato. |
| `\s [file]` | Stampa la cronologia dei comandi eseguiti e consente di salvarla su file. |
| `\x` | Attiva o disattiva la modalità di output esteso (visualizzazione record colonna per colonna in verticale). |
| `\a` | Attiva o disattiva la modalità di allineamento delle colonne nelle tabelle di output. |
| `\t` | Attiva o disattiva la modalità solo tuple (omette intestazioni di colonna e conteggi finali). |
| `\H` | Attiva o disattiva la modalità di formattazione tabellare HTML. |
| `\! [comando]` | Esegue un comando nella shell del sistema operativo ospite senza chiudere `psql`. |

---

### 4.3 Domini ed Estensioni Specifiche in PostgreSQL
PostgreSQL estende i tipi di dato previsti dallo standard SQL per offrire maggiore flessibilità:

* **Tipi Carattere:**
  * `VARCHAR` (senza specificare la lunghezza massima $n$): supporta stringhe di testo di lunghezza arbitraria.
  * `TEXT`: tipo nativo ottimizzato per stringhe di lunghezza indefinita (fino a 1 GB).
* **Tipi Numerici Interi:**
  * `BIGINT`: intero a 8 byte (64 bit), con intervallo $[-2^{63}, 2^{63}-1]$.
* **Tipi Numerici Decimali a Precisione Arbitraria:**
  * `NUMERIC` e `DECIMAL` sono sinonimi perfetti; memorizzano numeri decimali fino alla massima precisione consentita senza forzare una scala obbligatoria.
* **Tipi in Virgola Mobile:**
  * `FLOAT(1)` fino a `FLOAT(24)` equivale nativamente al tipo `REAL` (4 byte).
  * `FLOAT(25)` fino a `FLOAT(53)` equivale nativamente a `DOUBLE PRECISION` (8 byte).

---

## 5. Esempio Completo di Riepilogo DDL in PostgreSQL

A riepilogo pratico dei costrutti DDL e dei vincoli di integrità esaminati, si consideri la modellazione di una base di dati per la gestione di un'anagrafica di persone e dei rispettivi legami di parentela genitore-figlio.

### 5.1 Specifiche dello Schema e Vincoli
Lo schema è costituito da due tabelle:
1. **`persone(id, nome, reddito, eta, sesso)`**:
   * `id`: stringa di 2 caratteri, costituisce la **chiave primaria**.
   * `nome`: stringa di 20 caratteri, soggetta a vincolo di obbligatorietà (**`NOT NULL`**).
   * `reddito`: valore intero in migliaia di euro, con valore predefinito pari a 0 (**`DEFAULT 0`**).
   * `eta`: intero a 2 byte (`SMALLINT`), soggetto a vincolo di controllo (**`CHECK (eta < 200)`**).
   * `sesso`: singolo carattere (`CHAR`), vincolato ai soli valori ammessi `'M'` o `'F'` (**`CHECK (sesso = 'M' OR sesso = 'F')`**).
2. **`genitori(figlio, genitore)`**:
   * `figlio`: stringa di 2 caratteri, **chiave esterna** referenziante `persone(id)`.
   * `genitore`: stringa di 2 caratteri, **chiave esterna** referenziante `persone(id)`.
   * **Chiave primaria composta** costituita dalla coppia `(figlio, genitore)`.

### 5.2 Implementazione DDL in PostgreSQL

```sql
-- Creazione della tabella delle persone con vincoli intrarelazionali
CREATE TABLE persone (
    id CHAR(2) PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    reddito INT DEFAULT 0,
    eta SMALLINT,
    sesso CHAR CHECK (sesso = 'M' OR sesso = 'F'),
    CONSTRAINT vincolo_eta CHECK (eta >= 0 AND eta < 200)
);

-- Creazione della tabella delle relazioni di parentela con chiavi esterne e chiave primaria composta
CREATE TABLE genitori (
    figlio CHAR(2) REFERENCES persone(id),
    genitore CHAR(2) REFERENCES persone(id),
    PRIMARY KEY (figlio, genitore)
);
```