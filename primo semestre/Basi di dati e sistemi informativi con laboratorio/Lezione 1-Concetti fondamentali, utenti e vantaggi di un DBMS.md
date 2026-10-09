# Concetti fondamentali, utenti e vantaggi di un DBMS

> [!info] Informazioni sul corso:
> - **Testo di riferimento:** R. Elmasri, S. B. Navathe, *Sistemi di basi di dati - Fondamenti*.
> - **1° Compitino:** 09/11, ore 11:30 – 13:30.
> - **2° Compitino:** 18/12, ore 08:30 – 10:30.

## La base di dati e il DBMS

*Definizione:* una **base di dati (BD)** è una collezione organizzata di dati logicamente correlati. I dati rappresentano fatti noti che possono essere registrati e che possiedono un significato implicito.

Una base di dati presenta tre proprietà intrinseche:

1. **Rappresentazione del mini-mondo:** rappresenta un determinato aspetto del mondo reale, noto anche come **mini-mondo** o **universo del discorso**. Le modifiche che avvengono nel mini-mondo si riflettono puntualmente nella base di dati.
2. **Coerenza logica:** costituisce una collezione di dati logicamente coerenti con un significato intrinseco ben definito; insiemi disgiunti di dati privi di legami concettuali non configurano una base di dati.
3. **Finalità specifica:** viene progettata, costruita e popolata con dati per uno scopo ben preciso, rivolgendosi a un gruppo identificabile di utenti e ad applicazioni di specifico interesse.

Il **DBMS** (*database management system*) è il sistema software deputato a facilitare i processi di definizione, costruzione, manipolazione e condivisione di basi di dati tra molteplici utenti e applicazioni.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260921123252.png" width="350">
</div>

## Le funzionalità di un DBMS

**Funzionalità principali:**

- **Definire la BD:** specificare i tipi di dati, le strutture concettuali e logiche e i vincoli di integrità da imporre sui dati.
- **Costruire la BD:** memorizzare fisicamente i dati su supporti di memoria secondaria gestiti dal software.
- **Manipolare la BD:**
  - *Interrogare (querying):* reperire dati specifici e produrre reportistica strutturata.
  - *Aggiornare:* inserire, modificare o eliminare dati per allineare lo stato della base di dati al mini-mondo.
  - *Accesso applicativo:* consentire l'accesso e l'interazione tramite applicazioni desktop e web.
- **Condividere la BD:** permettere l'accesso simultaneo a più utenti e processi applicativi, prevenendo corruzioni e garantendo costantemente la consistenza dei dati.

**Funzionalità avanzate e gestionali:**

- *Protezione e manutenzione:* tolleranza ai guasti e protezione da crash hardware o software (sottosistema di recovery), controllo degli accessi e politiche di sicurezza contro intrusioni o accessi non autorizzati, manutenzione evolutiva della BD e dell'ambiente operativo lungo tutto il ciclo di vita del sistema.
- *Processing attivo dei dati:* capacità di attivare automaticamente sequenze di azioni al verificarsi di specifici eventi o condizioni, tramite DBMS attivi con *trigger* e regole ECA.
- *Presentazione e visualizzazione:* strumenti avanzati di formattazione grafica e generazione di report per gli utenti finali.

## Le caratteristiche dell'approccio a basi di dati

L'approccio basato su DBMS differisce radicalmente dalla gestione tradizionale basata su file piatti (*file processing*) per quattro caratteristiche cardine.

**Natura autodescrittiva del sistema.** Nell'approccio basato su file la struttura dei record è codificata internamente nei singoli programmi applicativi; un sistema di BD contiene invece sia i dati sia una descrizione esaustiva della loro struttura e dei relativi vincoli. Questa definizione formale risiede nel **catalogo di sistema** (o dizionario dati), che contiene la struttura di ciascun file o tabella, il tipo di dato e il formato di memorizzazione di ogni attributo e i vincoli di integrità imposti. Le informazioni conservate nel catalogo prendono il nome di **metadati**. La proprietà consente ai moduli del DBMS di interagire con basi di dati eterogenee, ricavandone dinamicamente lo schema direttamente dal catalogo.

**Separazione tra programmi e dati e astrazione dei dati.** Il DBMS fornisce agli utenti un'astrazione concettuale dei dati, il **modello dei dati**, nascondendo i dettagli implementativi e fisici relativi all'allocazione sui dispositivi di memoria secondaria.

> [!info] In altre parole:
> La struttura dei file di dati è memorizzata nel catalogo del DBMS separatamente dai programmi applicativi di accesso: proprietà detta **indipendenza tra programmi e dati**. In virtù dell'indipendenza tra dati e programmi e dell'astrazione dei dati, si possono modificare le strutture di memorizzazione interne e l'organizzazione fisica dei dati senza dover ricompilare o riscrivere i relativi programmi di accesso.

**Supporto di viste multiple sui dati.** Una base di dati conta una molteplicità di utenti con privilegi ed esigenze differenti, quindi il DBMS deve offrire a ciascuno una prospettiva personalizzata. Una **vista** (*view*) può essere un sottoinsieme specifico della base di dati, oppure una collezione di dati virtuali, cioè dati non memorizzati fisicamente ma derivati dinamicamente dai dati persistenti al momento della richiesta.

**Condivisione dei dati e transazioni multiutente.** Un DBMS multiutente implementa un sottosistema specializzato per il **controllo della concorrenza**, assicurando che transazioni simultanee non interferiscano reciprocamente producendo anomalie o stati incoerenti.

> [!info] Transazioni:
> Una **transazione** è un programma o processo in esecuzione che esegue uno o più accessi alla base di dati, in lettura e/o scrittura. Il DBMS garantisce proprietà fondamentali (ACID), tra cui:
> - **Isolamento:** ogni transazione viene eseguita in isolamento logico rispetto alle altre; gli effetti intermedi di una transazione non sono visibili alle transazioni concorrenti finché essa non viene confermata (*commit*).
> - **Atomicità:** le operazioni di una transazione vengono eseguite nella loro interezza (*all-or-nothing*); in caso di guasto o interruzione anomala ogni modifica parziale viene annullata (*rollback*).
> - **Consistenza:** una transazione porta la base di dati da uno stato consistente a un altro stato consistente, rispettando i vincoli di integrità.
> - **Durabilità:** gli effetti di una transazione confermata (*commit*) sono permanenti, anche in caso di guasto del sistema.

## Gli utenti di una base di dati

**Attori sulla scena.** Coloro la cui attività quotidiana è rivolta all'amministrazione, progettazione ed effettivo utilizzo della base di dati:

- **Progettisti della BD:** individuano i dati da memorizzare e selezionano le strutture concettuali e logiche idonee, dialogando con gli utenti finali per formalizzarne i requisiti.
- **Amministratori della base di dati (DBA, *database administrator*):** gestiscono la risorsa dati, autorizzando e revocando gli accessi e i privilegi, coordinando e ottimizzando l'uso delle risorse hardware e software e risolvendo violazioni di sicurezza, malfunzionamenti o decadimenti prestazionali.
- **Utenti finali:** accedono alla base di dati per compiti operativi o analitici:
  - *Occasionali:* accedono saltuariamente, richiedendo informazioni eterogenee tramite linguaggi di interrogazione complessi.
  - *Non esperti (parametrici):* costituiscono la maggioranza e interagiscono mediante transazioni predefinite (*canned transactions*) attraverso interfacce guidate, ad esempio cassieri e operatori di sportello.
  - *Esperti:* figure tecniche, analisti, ingegneri e scienziati, che sfruttano appieno le potenzialità analitiche del DBMS.
  - *Indipendenti:* gestiscono basi di dati a uso personale tramite software applicativi autonomi con interfacce visuali.

**Attori dietro le quinte.** Figure che sviluppano e mantengono l'infrastruttura software e di sistema del DBMS:

- **Analisti di sistema:** determinano i requisiti degli utenti finali e definiscono le specifiche per le transazioni predefinite.
- **Programmatori di applicazioni:** traducono le specifiche in codice sorgente (ad esempio Java, Python, C#), occupandosi del test e della manutenzione delle transazioni parametriche.
- Progettisti e costruttori del software DBMS, sviluppatori di tool di supporto e operatori di sistema.

## I vantaggi dell'adozione di un DBMS

1. **Controllo della ridondanza dei dati:** nei sistemi basati su file ciascun gruppo sviluppa propri file, causando duplicazioni e stati incoerenti; il DBMS implementa la **ridondanza controllata**, integrando i dati ed eseguendo controlli automatici di consistenza al momento delle modifiche.
2. **Restrizione degli accessi non autorizzati:** sottosistemi di sicurezza gestiti dal DBA consentono la profilazione degli account e l'applicazione puntuale di privilegi di lettura, scrittura e modifica su singoli dati o tabelle.
3. **Memorizzazione persistente degli oggetti di programma:** i dati sopravvivono alla terminazione dei programmi che li hanno prodotti, così che l'informazione inserita una volta non venga persa.
4. **Strutture di ottimizzazione delle query:** indici su memoria di massa (basati su alberi B-Tree o tabelle hash), moduli di *query optimization* per la formulazione del piano di esecuzione più efficiente e moduli di buffering in RAM.
5. **Sottosistema di backup e ripristino:** recupero automatico e consistente dello stato del database a fronte di guasti hardware o crash software improvvisi.
6. **Molteplicità di interfacce utente:** disponibilità simultanea di interfacce grafiche e web per utenti non esperti, interfacce a riga di comando (CLI) per amministratori e API e driver (JDBC, ODBC) per sviluppatori.
7. **Rappresentazione di associazioni complesse:** capacità di modellare relazioni articolate tra entità e di navigare le associazioni tramite operazioni di giunzione (*join*) ottimizzate.
8. **Imposizione di vincoli di integrità:** il DBMS verifica nativamente vincoli di dominio, vincoli di unicità, integrità della chiave primaria e vincoli di integrità referenziale (chiavi esterne).
9. **Inferenze e processing attivo mediante regole:**
   - *Basi di dati deduttive:* applicazione di regole logiche formali per derivare nuova conoscenza a partire dai dati memorizzati.
   - *Basi di dati attive:* esecuzione di azioni scatenate da eventi specifici tramite **trigger** e **stored procedure**.
10. **Imposizione di standard aziendali:** uniformazione della nomenclatura, dei formati e delle regole di documentazione su scala organizzativa.
11. **Riduzione dei tempi di sviluppo applicativo:** rapido sviluppo di nuove applicazioni grazie alla delega al DBMS di funzionalità critiche, come concorrenza, recovery e sicurezza.
12. **Flessibilità ed evoluzione dello schema:** possibilità di alterare lo schema o l'organizzazione fisica dei dati senza impattare i programmi applicativi preesistenti.
13. **Disponibilità di informazioni sempre aggiornate:** propagazione istantanea degli aggiornamenti a tutte le transazioni e agli utenti concorrenti.
14. **Economie di scala:** riduzione dei costi globali di gestione grazie al consolidamento infrastrutturale e all'eliminazione delle sovrapposizioni gestionali tra dipartimenti.

> [!info] Conflitto di impedenza (*impedance mismatch*):
> I sistemi tradizionali soffrono la discrepanza tra le strutture dati tabellari e relazionali del DBMS e i paradigmi ad oggetti dei linguaggi di programmazione. I sistemi di BD a oggetti (OODBMS) e i framework ORM moderni colmano questa lacuna convertendo automaticamente le strutture in memoria. Il problema è indipendente dal vantaggio n. 3: riguarda il disallineamento tra il modello relazionale e il modello a oggetti, non la persistenza dei dati.

## Quando non conviene utilizzare un DBMS

L'approccio basato su DBMS comporta costi vivi e un sovraccarico (*overhead*) sistemico non sempre giustificato:

- elevati costi iniziali di investimento in licenze software, requisiti hardware aggiuntivi e formazione del personale;
- overhead prestazionale introdotto dai meccanismi di controllo della concorrenza, sicurezza, integrità e gestione del registro di log (*recovery*).

È opportuno preferire la tradizionale architettura basata su file nelle seguenti condizioni:

- applicazioni semplici, circoscritte e stabili, per le quali non sono previsti aggiornamenti evolutivi o estensioni future;
- requisiti di calcolo in tempo reale (*hard real-time*) così stringenti da risultare incompatibili con le latenze introdotte dai moduli del DBMS;
- contesti operativi con accesso strettamente monoutente, in cui non sussiste alcuna necessità di condivisione simultanea o concorrenza sui dati.

> [!info] Sintesi:
> - La base di dati rappresenta il mini-mondo con dati logicamente coerenti e per uno scopo preciso; il DBMS ne facilita definizione, costruzione, manipolazione e condivisione.
> - Le quattro funzionalità principali sono definire, costruire, manipolare (interrogare, aggiornare, accedere da applicazioni) e condividere la BD.
> - Rispetto ai file piatti il DBMS è autodescrittivo (catalogo di sistema e metadati), separa programmi e dati, offre viste multiple e controlla la concorrenza con transazioni ACID.
> - Gli attori sono progettisti, DBA, utenti finali (occasionali, parametrici, esperti, indipendenti), analisti e programmatori.
> - I vantaggi sono 14: dalla ridondanza controllata alle economie di scala; tra i costi, licenze, formazione e overhead prestazionale rendono il DBMS sproporzionato su applicazioni semplici, hard real-time o monoutente.