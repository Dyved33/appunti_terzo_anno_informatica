---
date: 2026-09-21
tags:
  - basi-di-dati
  - sistemi-informativi
  - introduzione-dbms
  - architettura-dbms
  - lezione
type: lezione
---
# Introduzione alle Basi di Dati e ai DBMS

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
> Al termine della lezione è stata illustrata una panoramica storica sull'evoluzione dei sistemi di gestione delle informazioni: dai file system gerarchici e reticolari degli anni '60 alla teorizzazione del modello relazionale (Codd, 1970), fino ai moderni sistemi distribuiti, a oggetti e NoSQL.

