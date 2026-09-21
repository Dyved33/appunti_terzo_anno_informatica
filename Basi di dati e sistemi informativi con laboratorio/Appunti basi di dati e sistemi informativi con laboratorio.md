Libro: sistemi di basi di dati (fondamenti)

1 compito: 9/11 -> 11:30, 13:30
2 compito: 18/12 -> 8:30, 10:30

# Lezione 1: introduzione alle BD e utenti di BD
Una base di dati è una collezionee di dati correlati. I dati sono fatti noti che possono essere memorizzati (aventi significato implicito). Una base di dati ha le seguenti proprietà implicite:
1. Rappresenta un certo aspetto del mondo reale (mini-mondo o universo del discorso)
2. è una collezione di dati logicamente coerenti con un significato intrinseco
3. è progettata, costruita e popolata con dati per uno scopo specifico. Ha un determinato gruppo di utenti, e applicazione di interessi per gli utenti

DBSM: sistema software che facilita il processo di definire, costruire, manipolare e condivide BD per varie applicazioni

![[Pasted image 20260921123252.png|200]]

Funzioni principale di un DBMS:
- Definire BD indicandone i tipi di dati, la relativa struttura ed i vincoli coinvolti 
- Costruire BD, immagazzinandone i dati su supporto di memoria adeguato 
- Manipolare BD 
	-  Interrogare BD per reperire dati specifici e generare prospetti (report) a partire dai dati 
	- Aggiornare BD per rispecchiare cambiamenti nel mini-mondo 
	- Accedere alla BD attraverso applicazioni WEB 
- Condividere BD, permettendo a più utenti ed applicazioni di accedere a BD, senza violare la consistenza dei dati.

Altre funzioni di un DBSM:
- Protezione e manutenzione BD
	- Protezione di sistema da crash
	- Protezione da accessi di utenti malintenzionati (sicurezza)
	- Manutenzione BD ed applicazioni relative nel corso di vita del sistema di BD
- Processing attivo dei dati, per attivare automaticamente insiemi di azioni sui dati in seguito a determinati eventi (DBMS attivi)
- Funzioni di presentazione e visualizzazione dei dati

Caratteriste dell'approccio con BD: le principali caratteristiche dell'approccio con BD rispetto all'approccio basato sulla gestione di file sono:
1. Natura autodescrittiva di un sistema di BD
2. Separazione tra programmi e dati ed astrazione dei dati
3. Supporto con viste multiple dei dati
4. Condivisione dei dati e gestione delle transazione in ambiente multiutente

Natura autodescrittiva sistema BD:
- Oltre ai dati stessi, un sistema di BD contiene anche una descrizione completa della sua struttura e dei suoi vincoli. 
- Tale definizione e’ memorizzata nel catalogo di sistema, dove sono mantenute informazioni quali: 
	- la struttura di ciascun file 
	- il tipo ed il formato di memorizzazione di ogni dato
	- i vincoli sui dati 
- Le informazioni memorizzate nel catalogo sono dette metadati 
- In virtù della natura autodescrittiva di un sistema di BD, i pacchetti software di un DBMS possono interagire con diverse applicazioni di BD 
- In particolare, il software del DBMS può accedere a diverse basi di dati estraendone le definizioni dal catalogo.

Separazione tra dati e programmi, ed astrazione sui dati:
- Un DBMS fornisce agli utenti una rappresentazione concettuale dei dati, senza dettagli sulla loro effettiva memorizzazione 
- Tale rappresentazione concettuale e’ detta modello dei dati 
- Programmi si riferiscono ai concetti logici del modello dei dati, piuttosto che all'effettiva memorizzazione dei dati

> [!note] Separazione tra dati e programmi
> La struttura dei file di dati è memorizzata nel catalogo del DBMS separatamente dai programmi di accesso. Tale proprietà è detta ==indipendenza tra programmi e dati==. In virtù dell’indipendenza tra dati e programmi e dell’astrazione dei dati è possibile modificare le strutture dati e la loro organizzazione in memoria senza modificare i relativi programmi di accesso.

Supporto di viste multiple sui dati:
- L’approccio con BD fornisce supporto per la gestione di viste multiple sui dati 
- Una BD ha infatti molti utenti, ciascuno dei quali può richiedere una diversa prospettiva o vista 
- Una vista può essere: 
	- un sottoinsieme della BD 
	- un insieme di dati virtuali, i.e. non esplicitamente memorizzati nella BD ma piuttosto derivati dai dati nella BD.

Condivisione dati e gestione transazioni in ambienti multi-utente:
- Un DBMS multiutente deve consentire a più utenti di accedere contemporaneamente alla BD 
- A tale scopo, un DBMS deve contenere una porzione di software per il controllo della concorrenza: ⇒ garantisce che le transazioni concorrenti operino correttamente ed efficacemente

> [!note] Transazioni
> - Processo o programma in esecuzione che esegue uno o più accessi alla BD (e.g per la lettura e l’aggiornamento di dati). 
> - Il DBMS deve garantire alcune proprietà fondamentali delle transazioni, come: 
> 	- isolamento: Ogni transazione sembra eseguita in isolamento rispetto alle altre, nonostante possano essere in esecuzione centinaia di transazioni contemporaneamente. 
> 	- atomicità: Le operazioni di una transazione vengono eseguite nella loro interezza, oppure non vengono eseguite affatto.

Utenti di una BD: Gli utenti di una BD si possono classificare in due categorie principali: 
1. Coloro che progettano, usano oppure amministrano direttamente una BD (gli ’attori in scenà). 
2. Coloro che collaborano al disegno, allo sviluppo ed al funzionamento dell’ambiente software e di sistema del DBMS, pur non essendo interessate alla BD in se’ (gli ’attori dietro le quinte’)

- Progettisti: 
	- Hanno la responsabilità di individuare i dati da memorizzare nella BD e di scegliere le strutture adeguate per rappresentarli e memorizzarli. 
	- Interagiscono con gli utenti finali della BD per definirne i requisiti in base alle esigenze degli utenti stessi. 
- Amministratori Tra i compiti di un DBA (DB administrator) vi sono quelli di: 
	- autorizzare accesso alla BD 
	- coordinare e monitorare uso BD 
	- rispondere a problemi quali violazioni di sistema o tempi di risposte scadenti da parte di quest’ultimo.
- Utenti Finali: Coloro la cui attività lavorativa richiede l’accesso alla BD per interrogazioni, aggiornamenti... Ci sono diverse sotto-categorie di utenti finali:   
	 1. Occasionali: Accedono occasionalmente a BD. Possono aver bisogno ogni volta di informazioni diverse. 
	 2.  Non Esperti Interagiscono abitualmente con la BD via tipi standard di interrogazioni/aggiornamenti (’canned transactions’). 
	 3.  Esperti. Comprendono categorie di persone (ingegneri, scienziati...) che acquisiscono completa familiarità con le funzionalità del DBMS. 
	 4.  Indipendenti. Mantengono BD a uso personale usando pacchetti di programmi con interfacce e menu di facile uso
- Analisti di Sistema e Programmatori (Ingegneri del SW) 
	- Analisti di Sistema. Determinano le esigenze degli utenti finali. Sviluppano specifiche di transazioni standard in accordo con tali esigenze. 
	- Programmatori di Applicazioni. Implementano le specifiche di cui sopra. Si occupano del test e della manutenzione delle transazioni standard.

Vantaggi uso DBMS:
1. Controllo della Ridondanza 
	- Problema: La ridondanza dei dati (tipica dello sviluppo tradizionale di BD mediante gestione di files) genera rischi di inconsistenza e tuttavia può essere utile a migliorare le prestazioni delle interrogazioni
	- Soluzione: Ridondanza Controllata. L’approccio con DBMS permette di controllare l’eventuale introduzione di ridondanza dei dati, al fine di garantirne la consistenza 
	- Opportune verifiche di consistenza dei dati possono essere: 
		- specificate al DBMS durante la progettazione 
		- imposte automaticamente al DBMS in seguito ad operazioni di aggiornamento
2. Divieto all'accesso non autorizzato
	- Problema quando più utenti condividono una BD sorge il problema di impedire l’accesso di alcune informazioni a determinate classi di utenti. 
	- Soluzione Tipicamente, un DBMS fornisce un sottosistema per la sicurezza e l’autorizzazione, utilizzato dal DBA per definire account ed autorizzazioni.
3. Memorizzazione persistente oggetti di un programma 
	- Le BD possono essere utilizzate per fornire memorizzazione persistente di oggetti di programmi e strutture dati. 
	- Problema: Conflitto di impedenza. I sistemi di basi di dati tradizionali hanno spesso sofferto del cosidetto problema del conflitto di impedenza, dal momento che le strutture dati fornite dal DBMS erano incompatibili con le strutture dati del linguaggio di programmazione. 
	- Questa e’ una della ragioni principali per cui sono stati sviluppati i sistemi di BD ad oggetti 
	- Soluzione I sistemi di BD ad oggetti sono compatibili con linguaggi di programmazione come C++ e Java: il software del DBMS esegue automaticamente ogni conversione di dato necessarie.
4. Strutture di memorizzazione per l’esecuzione efficiente di interrogazioni 
	- DBMS forniscono adeguate strutture dati (indici) per velocizzare la ricerca sul disco, i.e. per eseguire efficientemente interrogazioni ed aggiornamenti 
	- Gli indici si basano generalmente su strutture dati ad albero o su tabelle hash 
	- Scelta degli indici da creare e mantenere: fa parte del progetto fisico e dell’ottimizzazione della BD (tra i compiti del DBA). 
	- Modulo elaborazione/ottimizzazione interrogazioni del DBMS: responsabile scelta piano efficiente esecuzione interrogazioni, date strutture dati esistenti 
	- Modulo di buffering: mantiene porzioni della BD nei buffer della memoria principale
5. Backup & Recovery 
	- Sottosistema backup/recovery del DBMS: Fornisce funzioni di ripristino del DBMS da guasti hardware e software 
6.  Interfacce Utente 
	- DBMS forniscono una molteplicità di interfacce utente (form e moduli per utenti non esperti, interfacce a linguaggi di programmazione per programmatori di applicazioni . . .) 
7. Rappresentazione di associazioni complesse fra dati 
	- DBMS deve essere in grado di rappresentare una varietà di associazioni complesse fra i dati, e di reperire ed aggiornare facilmente ed efficientemente i dati correlati
8. Impostazione di vincoli di integrità 
	- Un DBMS dovrebbe fornire servizi per definire ed imporre opportuni vincoli di Integrità, specifici delle applicazioni di interesse. 
9. Permesseo eseguire inferenze e azioni tramite regole 
	- Sistemi di basi di dati deduttive: Forniscono la capacità di definire regole di deduzione per inferire nuove informazioni dai fatti memorizzati nella BD.
	- Sistemi di basi di dati attive: Forniscono la possibilità di definire regole in grado di attivare automaticamente un insieme di azioni come conseguenza del verificarsi di determinati eventi e condizioni (trigger, stored procedures)
10. Potenziale per imporre standard 
11. Tempo ridotto per lo sviluppo di applicazioni 
	- Una volta che un DBMS e’ realizzato ed in funzione, e’ richiesto decisamente meno tempo per creare nuove applicazioni utilizzando i servizi del DBMS.
12. Flessibilità 
	- I DBMS moderni consentono alcuni cambiamenti alla struttura della BD senza coinvolgere i dati memorizzati ed i programmi applicativi esistenti.
13. Disponibilità di Informazioni Aggiornate 
	- Un DBMS rende la BD disponibile a tutti gli utenti. Non appena in essa viene effettuato un aggiornamento da parte di un utente, tutti gli altri possono immediatamente vederlo. 
14. Economie di scala 
	- L’approccio con DBMS permette l’unificazione dei dati e delle applicazioni, riducendo l’ammontare di una dispendiosa sovrapposizione tra le attività del personale di elaborazione dei dati in diversi progetti/dipartimenti.

Quando non usare in DBMS: Ci sono alcune situazioni nelle quali l’approccio con DBMS può comportare spese generali non necessarie, a cui non ci si esporrebbe nella tradizionale gestione file. 
- alti investimenti in hw, sw, e formazione 
- spese generali per assicurare le funzioni di sicurezza, controllo della concorrenza, ripristino e integrità

Può essere conveniente usare solo file, piuttosto che un approccio basato su DBMS, nelle seguenti circostanze: 
- BD e applicazioni semplici, ben definite, e non si prevedono aggiornamenti/modifiche
- stringenti necessità di tempo reale per alcuni programmi, che non possono essere soddisfatte a causa dell’elaborazione aggiuntiva dovuta al DBMS
- non vi e’ accesso ai dati multiutente

> [!note] 
> Alla fine della lezione c'è un po di storia
