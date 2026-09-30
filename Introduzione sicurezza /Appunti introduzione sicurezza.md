# Fondamenti di Sicurezza Informatica e Protezione dei Sistemi

> [!INFO] Informazioni sul Corso ed Esami
> - **Testo di riferimento:** William Stallings, *Network Security Essentials: Applications and Standards*.
> - **Modalità d'esame:** Prova orale vertente sugli argomenti trattati a lezione e sui capitoli corrispondenti del testo di riferimento.

## 1. Definizioni e Concetti Fondamentali

La **sicurezza** in senso generale è definibile come l'assenza di rischio, pericolo o minaccia. In ambito informatico, tale concetto si specializza nella protezione attiva e preventiva delle risorse digitali.

* **Sicurezza Informatica:** L'insieme delle misure, delle tecnologie e delle procedure volte a prevenire o proteggere le risorse hardware, software e le informazioni da accessi non autorizzati, alterazioni, sottrazioni o distruzione.
* **Definizione Formale di Computer Sicuro:**
  Un sistema di elaborazione si definisce sicuro se e solo se è accessibile ed utilizzabile esclusivamente da entità legittimamente autorizzate:
  $$\text{Computer Sicuro} \iff \text{Accessibile solo a soggetti autorizzati}$$
  In altri termini, un computer è sicuro quando esegue fedelmente e unicamente ciò per cui è stato progettato, consentendone l'operatività solo a chi ne ha il diritto.

> [!IMPORTANT] Il Principio di Non-Assolutezza della Sicurezza
> Un sistema informatico **non è mai sicuro al 100% in senso permanente**. La sicurezza è un processo dinamico e contingente: un sistema considerato inattaccabile ieri può risultare vulnerabile oggi o domani a causa della scoperta di nuove vulnerabilità (es. exploit *zero-day*), dell'evoluzione delle tecniche di attacco o dell'aumento della potenza di calcolo a disposizione degli attaccanti.

> [!NOTE] Nota del Prof: Ridisegno Architetturale e Sicurezza
> La sicurezza non è un componente applicabile a posteriori (*add-on*), ma una proprietà trasversale che coinvolge tutti i livelli architetturali (dall'hardware al software applicativo, fino alle procedure umane). Per rendere un sistema intrinsecamente sicuro sarebbe spesso necessario un **completo ridisegno architetturale**, operazione complessa e raramente praticabile a causa dei vincoli di retrocompatibilità, dei costi e dei tempi di sviluppo.

## 2. Proprietà di Sicurezza: La Triade CIA e Dimensioni Estese

La sicurezza informatica si articola storicamente attorno alla **Triade CIA**, a cui la moderna teoria della sicurezza affianca ulteriori dimensioni critiche:

### 2.1 La Triade CIA Cardine
1. **Confidenzialità (*Confidentiality*):** Garanzia che i dati, le comunicazioni e le risorse di sistema siano accessibili e leggibili esclusivamente dai soggetti (utenti, processi) esplicitamente autorizzati.
2. **Integrità (*Integrity*):** Garanzia che le informazioni, il software e le configurazioni non subiscano alterazioni, manomissioni o cancellazioni non autorizzate, preservando la correttezza e la completezza del dato originale.
3. **Disponibilità (*Availability*):** Garanzia che i sistemi, le reti e le informazioni siano tempestivamente accessibili e pienamente operativi ogni qualvolta un utente o servizio autorizzato ne faccia richiesta.

### 2.2 Proprietà di Sicurezza Estese
* **Autenticità (*Authenticity*):** Capacità di verificare e accertare con certezza la genuinità di una comunicazione, di un documento o l'identità dichiarata da un'entità mittente.
* **Tracciabilità e Imputabilità (*Accountability / Non-Repudiation*):** Capacità di correlare in modo univoco e non contestabile ogni singola operazione compiuta nel sistema al soggetto specifico che l'ha eseguita, impedendo a chiunque di negare le proprie azioni.
* **Possesso o Controllo (*Possession / Control*):** Capacità del legittimo proprietario di esercitare il pieno controllo logico e fisico sui propri dati e sulle infrastrutture.
* **Utilità (*Utility*):** Garanzia che le informazioni conservino la loro forma utile e fruibile (es. dati cifrati la cui chiave di decifratura è andata perduta rimangono confidenziali e integri, ma perdono totalmente la loro utilità).

## 3. Il Modello IAAA: Autenticazione, Identificazione, Autorizzazione e Accounting

Il controllo degli accessi poggia su quattro pilastri logici distinti ma interconnessi:

1. **Autenticazione (*Authentication*):** Processo di validazione delle credenziali o delle evidenze fornite da un'entità per dimostrare di essere chi afferma di essere (es. inserimento di username e password, certificati digitali, token OTP, fattori biometrici).
2. **Identificazione (*Identification*):** Associazione formale tra un'entità logica o account e la reale identità civile/anagrafica nel mondo fisico (es. esibizione di un documento di riconoscimento, SPID, verifica notarile).
3. **Autorizzazione (*Authorization*):** Determinazione e attribuzione dei privilegi operativi e dei diritti di accesso a specifiche risorse (definizione puntuale di *cosa* l'utente autenticato ha il permesso di leggere, modificare o eseguire).
4. **Tracciabilità / Accounting (*Auditing & Accountability*):** Monitoraggio e registrazione continuativa delle azioni svolte dagli utenti all'interno del sistema (*verificare chi fa cosa* tramite registri di audit e log immutabili).

```
[ Identificazione / Anagrafica ] 
              ↓
  [ Autenticazione (Credenziali) ] → [ Autorizzazione (Policy & ACL) ] → [ Accounting (Log & Audit) ]
```

> [!NOTE] Nota del Prof: Autenticazione vs Identificazione
> Nei sistemi informatici l'**autenticazione** precede la verifica operativa dei permessi: un utente fornisce credenziali (es. username/password o token) per autenticare la propria sessione prima che il sistema ne verifichi i diritti o ne colleghi formalmente l'identità.

> [!EXAMPLE] Spunto di Riflessione: Autenticazione Senza Identificazione
> Esistono molteplici scenari pratici in cui un sistema effettua un'autenticazione valida senza procedere all'identificazione nominale della persona fisica:
> * **Blockchain e Criptovalute:** Le transazioni vengono autenticate mediante firma crittografica con chiave privata senza richiedere l'identità anagrafica del firmatario (garantendo pseudonimato).
> * **Badge e Token di Accesso Fisico Anonimi:** Biglietti elettronici, gettoni o badge numerati validano il diritto di ingresso (autenticazione del titolo) senza identificare l'individuo.
> * **Sistemi di Credenziali Anonime e Zero-Knowledge Proofs (ZKP):** Protocolli che consentono a un utente di dimostrare di possedere un attributo valido (es. essere maggiorenne o iscritto a un servizio) senza rivelare la propria identità.

## 4. Ambiti di Difesa e Fasi del Piano di Sicurezza

La protezione di un'organizzazione o infrastruttura richiede un approccio difensivo su molteplici livelli:

### 4.1 I Livelli di Protezione
* **Physical Security (Sicurezza Fisica):** Barriere e controlli per regolare e impedire l'accesso fisico non autorizzato a locali server, rack, cablaggi e postazioni di lavoro.
* **Operational / Procedural Security (Sicurezza Operativa e Procedurale):** Definizione e adozione di policy aziendali, standard operativi, procedure di gestione degli incidenti e piani di continuità del business (*Business Continuity*).
* **Personnel Security (Sicurezza del Personale):** Formazione e sensibilizzazione degli utenti contro attacchi di ingegneria sociale (*phishing*, *pretexting*), controllo delle referenze e gestione delle deleghe.
* **System Security (Sicurezza di Sistema):** Applicazione del principio del minimo privilegio, gestione rigorosa delle Access Control List (ACL), disabilitazione dei servizi superflui (*hardening*) e analisi dei log.
* **Network Security (Sicurezza di Rete):** Firewall, apparati IDS/IPS, segmentazione del traffico, routing sicuro e filtraggio dei pacchetti.

### 4.2 Le Fasi del Piano di Sicurezza
Un piano di sicurezza organico struttura la difesa in cinque stadi temporali e operativi:

1. **Risk Avoidance (Evitamento del Rischio):** Scelte architetturali e di business mirate a eliminare alla radice l'esposizione al rischio (es. disconnettere dalla rete pubblica un sistema industriale SCADA critico che non necessita di collegamento a Internet permanente).
2. **Deterrence (Deterrenza):** Pubblicizzazione visibile delle misure difensive adottate, dei sistemi di monitoraggio e delle sanzioni disciplinari/legali previste per scoraggiare potenziali malintenzionati.
3. **Prevention (Prevenzione):** Meccanismi attivi (firewall, cifratura, controlli di autenticazione forte, antivirus) volti a bloccare sul nascere i tentativi di intrusione.
4. **Detection (Rilevamento):** Individuazione tempestiva di violazioni o anomalie in corso tramite sistemi IDS (*Intrusion Detection System*), SIEM e monitoraggio del traffico.
5. **Reaction (Reazione e Ripristino):** Procedure di risposta all'incidente (*Incident Response*), contenimento della minaccia, ripristino dell'operatività da backup integri (*Disaster Recovery*) e conservazione delle prove digitali per il perseguimento legale (*Digital Forensics* e tribunale).

## 5. Soluzioni Tecnologiche e Contromisure contro gli Attacchi

Per contrastare efficacemente gli attacchi informatici si impiegano soluzioni tecniche integrate:

1. **Pianificazione e Segmentazione della Rete:**
   * Utilizzo di apparati di rete adeguati (router, switch layer 3/gestiti).
   * Suddivisione della rete in zone con differenti livelli di fiducia e sicurezza (es. VLAN separate, creazione di una **DMZ - Demilitarized Zone** per isolare i server pubblici dalla rete interna).
2. **Integrità Applicativa e Hardening:**
   * Adozione di metodologie di sviluppo sicuro per ridurre al minimo i bug nel codice sorgente (*Secure Coding*, analisi statica e dinamica del codice).
   * Verifica puntuale e hardening delle configurazioni dei sistemi operativi e dei server.
3. **Controllo e Filtraggio dei Flussi di Traffico:**
   * Utilizzo di apparati firewall (packet filter, stateful inspection, application firewall) e router screening per ispezionare, filtrare e bloccare il traffico anomalo da e verso l'esterno.
4. **Crittografia e Canali Sicuri:**
   * Applicazione di algoritmi e protocolli crittografici per cifrare i dati prima della loro trasmissione su canali non protetti (es. **SSH** per amministrazione remota sicura, **TLS/SSL** per il traffico web, **PGP/GPG** per email e file, **VPN** con IPsec/OpenVPN per tunnel cifrati).

## 6. Distinzione Terminologica: Computer Security, Cybersecurity e Information Assurance

La disciplina della protezione dei dati e dei sistemi si articola in tre definizioni complementari:

```
┌─────────────────────────────────────────────────────────┐
│                 Information Assurance                   │
│  (Governo del dato: CIA, Autenticità, Policy, Utilità) │
│  ┌───────────────────────────────────────────────────┐  │
│  │                   Cybersecurity                   │  │
│  │  (Difesa e protezione delle risorse nel ciberspazio)│  │
│  │  ┌─────────────────────────────────────────────┐  │  │
│  │  │              Computer Security              │  │  │
│  │  │  (Protezione fisica e logica di HW, SW,     │  │  │
│  │  │   firmware e dati memorizzati/trasmessi)    │  │  │
│  │  └─────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

* **Computer Security:** Misure e controlli tecnici volti a garantire la confidenzialità, l'integrità e la disponibilità degli asset di un sistema di elaborazione, inclusi componenti hardware, software, firmware e informazioni durante l'elaborazione, la memorizzazione e la trasmissione.
* **Cybersecurity:** La capacità di proteggere, difendere e mitigare gli attacchi informatici condotti attraverso il ciberspazio (reti pubbliche, Internet e infrastrutture interconnesse).
* **Information Assurance (IA):** Insieme integrato di controlli tecnici, organizzativi e manageriali progettati per garantire la confidenzialità, il controllo del possesso, l'integrità, l'autenticità, la disponibilità e l'utilità delle informazioni e dei sistemi informativi lungo tutto il loro ciclo di vita.

---

# Lezione 2: Architettura delle Reti, Stack Protocollare TCP/IP e Protocolli Applicativi

## 1. Richiamo Preliminare: lo Standard TCP/IP

> [!IMPORTANT] Definizione Formale di Protocollo
> Un **protocollo di rete** definisce il **formato** e l'**ordine** dei messaggi scambiati tra due o più entità in comunicazione, nonché l'insieme delle **azioni** intraprese dai nodi in fase di trasmissione o ricezione di un messaggio o al verificarsi di specifici eventi temporali.

L'architettura di rete odierna si fonda su tre principi cardine:
1. **Canale Logico Virtuale:** Lo standard crea un canale virtuale astratto *end-to-end*. La modalità di interazione e la semantica non dipendono dalla distanza fisica: due host situati nella stessa stanza o in continenti diversi comunicano attraverso le medesime regole formali (la distanza costituisce unicamente un parametro di latenza trasmissiva).
2. **Astrazione del Percorso per l'Host:** Con il modello Client-Server, l'host terminale ragiona esclusivamente sull'interazione logica applicativa, delegando integralmente allo stack di rete sottostante l'onere di instradare, frammentare, trasmettere e riassemblare i pacchetti.
3. **Governo Tramite Standard e RFC:** Ogni servizio distribuito su Internet è rigorosamente disciplinato da specifiche formali pubbliche (RFC - *Request for Comments* curate da IETF), garantendo l'interoperabilità tra sistemi operativi ed elaboratori eterogenei.

```
   HOST A                                                      HOST B
  ┌────────┐          Protocollo Applicativo (es. HTTP)       ┌────────┐
  │ Client │ ───────────────────────────────────────────────► │ Server │
  └────────┘ ◄─────────────────────────────────────────────── └────────┘
       ▲  Lo standard ASTRAE il canale logico                      ▲
       │  (il mezzo fisico e solo il supporto)                     │
  ─────┴───────────────────────────────────────────────────────────┴─────
             [ Rete: Router, Switch, Mezzi Fisici di Trasmissione ]
```

---

## 2. La Pila di Protocolli TCP/IP

### 2.1 Motivazioni della Stratificazione (Layering)
Le reti telematiche sono sistemi complessi composti da nodi (*host*, router), collegamenti fisici eterogenei, protocolli e processi software. La suddivisione in strati risponde a due esigenze primarie:
* **Semplificazione dell'Analisi:** Isola le responsabilità concettuali e facilita la comprensione e l'insegnamento dell'interazione sistemica.
* **Modularità e Manutenzione:** I dettagli implementativi interni a ciascun livello sono del tutto **trasparenti** ai livelli adiacenti. È possibile aggiornare o sostituire un protocollo di trasporto (es. passare da TCP a UDP o QUIC) senza dover modificare il codice sorgente dell'applicazione.

> [!WARNING] Valutazione Critica: La Stratificazione Introduce Vulnerabilità?
> Sebbene la stratificazione comporti un inevitabile sovraccarico computazionale (*overhead* dovuto all'aggiunta di header per ogni strato), essa costituisce un **fondamentale vantaggio difensivo in ambito di sicurezza**. Consente infatti di predisporre contromisure specializzate e disaccoppiate a ciascun livello della pila:
> * Livello Link: Port Security, 802.1X, isolamento VLAN.
> * Livello Rete/Trasporto: Packet Filtering, firewall di stato, IPsec, VPN, TLS.
> * Livello Applicazione: Web Application Firewall (WAF), Intrusion Prevention System (IPS), validazione semantica dei payload e autenticazione applicativa.

### 2.2 Gerarchia dei Cinque Livelli e Unità Dati di Protocollo (PDU)

| Livello TCP/IP | Funzione Primaria | Protocolli Tipici | PDU (*Protocol Data Unit*) |
| :--- | :--- | :--- | :--- |
| **5. Applicazione** | Supporto e interfaccia per i servizi e le applicazioni distribuite | HTTP, HTTPS, FTP, SMTP, DNS, SSH | **Messaggio (*Message*)** |
| **4. Trasporto** | Trasferimento logico dei messaggi tra processi (*process-to-process*); multiplexing/demultiplexing | TCP, UDP | **Segmento (*Segment*)** / Datagramma UDP |
| **3. Rete** | Instradamento (*routing*) e indirizzamento logico dei pacchetti dall'origine al destinatario | IP (IPv4, IPv6), ICMP, OSPF, BGP | **Datagramma (*Datagram / Packet*)** |
| **2. Collegamento (*Link*)** | Trasferimento affidabile dei dati su singolo collegamento fisico (*hop-by-hop*) tra nodi adiacenti | Ethernet (IEEE 802.3), Wi-Fi (802.11), PPP | **Frame (*Trama*)** |
| **1. Fisico** | Trasmissione dei singoli segnali elettrici, ottici o elettromagnetici sul mezzo | Cavi in rame, fibra ottica, onde radio | **Bit** |

> [!NOTE] Nota del Prof: Significato del Termine "Pacchetto"
> Nel gergo informatico comune il termine **"pacchetto"** viene impiegato in modo generico per indicare una qualsiasi unità di dati in transito sulla rete. Formalmente, si tratta della medesima informazione che assume denominazioni tecniche differenti a seconda dello strato della pila in cui viene osservata: **messaggio** (applicazione), **segmento** (trasporto), **datagramma** (rete), **frame** (collegamento).

### 2.3 Meccanismo di Incapsulamento e Decapsulazione
Ciascun livello aggiunge in testa ai dati ricevuti dal livello superiore una propria intestazione contenente i metadati di controllo di competenza (**incapsulamento** in trasmissione) e ne esegue la rimozione al momento della ricezione (**decapsulazione**):

```
  Host Mittente                                                 Host Ricevente
 ┌──────────────┐                                              ┌──────────────┐
 │ Applicazione │ Messaggio (M)                                │ Applicazione │
 ├──────────────┼──────────────────────────────┐               ├──────────────┤
 │  Trasporto   │ Ht | M                       │ (Segmento)    │  Trasporto   │
 ├──────────────┼──────────────────────────────┼───────────────┼──────────────┤
 │     Rete     │ Hn | Ht | M                  │ (Datagramma)  │     Rete     │
 ├──────────────┼──────────────────────────────┼───────────────┼──────────────┤
 │ Collegamento │ Hl | Hn | Ht | M | Tl        │ (Frame)       │ Collegamento │
 ├──────────────┼──────────────────────────────┼───────────────┼──────────────┤
 │    Fisico    │ 011010010110111001110100...  │ (Bit)         │    Fisico    │
 └──────────────┴──────────────────────────────┴───────────────┴──────────────┘
                         │                               ▲
                         ▼                               │
                   ┌───────────────────────────────────────────┐
                   │    Router / Commutatori Intermedi        │
                   │ (Ispezionano fino al livello Link/Rete)   │
                   └───────────────────────────────────────────┘
```

---

## 3. Processi Comunicanti, Socket e Indirizzamento dei Servizi

### 3.1 Processi Comunicanti e Paradigmi di Rete
Un **processo** è un programma in esecuzione all'interno di un elaboratore:
* Due processi residenti sul **medesimo host** comunicano tramite i meccanismi di comunicazione interprocesso (IPC) messi a disposizione dal kernel (es. pipe, code di messaggi, memoria condivisa).
* Due processi residenti su **host distinti** devono comunicare tramite lo **scambio esplicito di messaggi** attraverso l'infrastruttura di rete.
* **Client:** Processo che assume l'iniziativa e invia la prima richiesta di connessione.
* **Server:** Processo che si pone in ascolto passivo su una determinata porta logica, in attesa di essere contattato.
* **Peer-to-Peer (P2P):** Architettura simmetrica in cui ciascun nodo agisce contemporaneamente da client e da server.

### 3.2 La Primitiva Socket
Una **socket** costituisce l'interfaccia software (API) e il punto di accesso logico che connette il processo applicativo in spazio utente (*user space*) con i moduli di trasporto gestiti dal kernel del sistema operativo:

```
  Processo Applicativo (User Space)
  [ send() / write() ]        ▲ [ recv() / read() ]
          │                   │
          ▼                   │
  ┌───────────────────────────────────────────────────────────┐
  │                 API SOCKET (Porta Logica)                 │
  │    (Scelta del protocollo e parametri della connessione)  │
  ├───────────────────────────────────────────────────────────┤
  │    Kernel / Stack di Trasporto TCP o UDP                  │
  │    • Buffer di Trasmissione (Tx)   • Buffer di Ricezione (Rx)│
  │    • Variabili di Stato (Seq, Ack, Finestra di Ricezione) │
  └───────────────────────────────────────────────────────────┘
```

Lo sviluppatore controlla l'interfaccia socket a livello applicativo, mentre il sistema operativo governa interamente i buffer di memoria RAM, le code di pacchetti e le macchine a stati del protocollo di trasporto.

### 3.3 Indirizzamento Completo: La 5-Tupla e le Porte di Rete
L'indirizzo IP identifica in modo univoco l'**interfaccia di rete dell'host**, ma poiché su un singolo host operano simultaneamente centinaia di processi, è indispensabile specificare il **numero di porta** (intero a 16 bit, intervallo $0 - 65535$) per individuare l'esatto socket di destinazione (**socket address** = `IP:porta`).

Formalmente, una connessione TCP/IP bidirezionale è univocamente identificata dalla **5-tupla**:
$$\langle \text{IP Sorgente}, \text{Porta Sorgente}, \text{IP Destinazione}, \text{Porta Destinazione}, \text{Protocollo di Trasporto} \rangle$$

#### Classificazione delle Porte Logiche
* **Well-Known Ports ($0 - 1023$):** Riservate e standardizzate da IANA per i servizi di sistema fondamentali (es. `20/21` FTP, `22` SSH, `25` SMTP, `53` DNS, `80` HTTP, `110` POP3, `143` IMAP, `443` HTTPS). Nei sistemi Unix-like richiedono privilegi di root/amministratore per il binding.
* **Registered Ports ($1024 - 49151$):** Assegnate da IANA a servizi e software commerciali specifici (es. `3306` MySQL, `5432` PostgreSQL).
* **Dynamic / Ephemeral Ports ($49152 - 65535$):** Porte temporanee allocate automaticamente dal kernel ai processi client all'avvio della sessione e rilasciate al termine della comunicazione.

> [!WARNING] Implicazioni di Sicurezza: Port Scanning e Fingerprinting
> L'utilizzo di porte well-known rende i servizi di rete immediatamente individuabili dagli attaccanti mediante tecniche di **Port Scanning** (es. con `nmap`). Attraverso l'analisi dei banner di risposta (*banner grabbing*) e dei comportamenti a fronte di pacchetti anomali, l'attaccante effettua il **Service Fingerprinting**, identificando l'esatta versione del software server per ricercare vulnerabilità note (CVE) ed exploit pubblici.

---

## 4. Tassonomia dei Protocolli Applicativi e Scelta del Livello di Trasporto

### 4.1 Caratteristiche dei Protocolli Applicativi
Un protocollo applicativo definisce formalmente:
1. **Tipologia dei Messaggi:** Distinzione esplicita tra messaggi di richiesta, risposta, controllo o notifica.
2. **Sintassi:** Struttura dei campi, intestazioni, delimitatori e formati dei dati.
3. **Semantica:** Significato formale del contenuto di ciascun campo.
4. **Regole Temporali:** Condizioni e sequenze che stabiliscono *quando* e *come* un'entità deve trasmettere o rispondere.

I protocolli si distinguono in:
* **Protocolli di Pubblico Dominio:** Disciplinati da RFC aperte (HTTP, FTP, SMTP, DNS). Garantiscono interoperabilità tra fornitori differenti. L'apertura dello standard garantisce trasparenza e possibilità di audit di sicurezza continuo (principio di Kerckhoffs: la sicurezza deve risiedere nell'algoritmo/chiave e non nell'occultamento del protocollo).
* **Protocolli Proprietari:** Sviluppati da singoli vendor (es. vecchi sistemi di streaming o gaming); l'assenza di specifiche pubbliche (*security through obscurity*) costituisce una protezione debole e illusoria.

### 4.2 Requisiti delle Applicazioni e Confronto TCP vs UDP

Le applicazioni di rete presentano requisiti eterogenei su tre parametri critici:

| Tipologia di Applicazione | Tolleranza alle Perdite | Fabbisogno di Banda | Sensibilità al Ritardo (Latenza) |
| :--- | :--- | :--- | :--- |
| **Trasferimento File (FTP)** | **Nessuna (0%)** | Elastica / Variabile | No |
| **Posta Elettronica (SMTP)** | **Nessuna (0%)** | Elastica / Variabile | No |
| **Pagine Web (HTTP)** | **Nessuna (0%)** | Elastica / Variabile | No |
| **Streaming Multimediale** | Tolleranza parziale | Costante/Elevata | Sì (buffer di pochi secondi) |
| **VoIP / Videoconferenze** | Tolleranza parziale | Bassa/Media | **Critica (centinaia di ms)** |
| **Giochi Online Real-Time** | Tolleranza parziale | Bassa | **Critica (< 50-100 ms)** |

```
┌────────────────────────────────────────┬────────────────────────────────────────┐
│   TCP (Transmission Control Protocol)  │      UDP (User Datagram Protocol)      │
├────────────────────────────────────────┼────────────────────────────────────────┤
│ • Orientato alla connessione (3-way HW)│ • Senza connessione (Connectionless)   │
│ • Trasporto affidabile (ACK + Retrans) │ • Trasporto inaffidabile (Best-Effort) │
│ • Consegna ordinata dei byte           │ • Nessun controllo sull'ordine         │
│ • Controllo di Flusso (Receive Window) │ • Nessun controllo di flusso           │
│ • Controllo della Congestione          │ • Nessun controllo della congestione   │
│ • Overhead elevato (header 20 byte)    │ • Overhead minimo (header 8 byte)      │
└────────────────────────────────────────┴────────────────────────────────────────┘
```

> [!INFO] Perché si utilizza UDP se TCP è affidabile?
> L'affidabilità di TCP introduce latenza inevitabile: handshake a tre vie, attesa di ACK, ritrasmissioni in caso di perdita e riordino dei segmenti nei buffer. Nelle applicazioni *real-time* (VoIP, streaming live, videogiochi competitivi), un pacchetto audio/video che arrivi con 300 ms di ritardo è del tutto inservibile; è preferibile tollerare la perdita di un singolo frame audio piuttosto che bloccare l'intero flusso per richiederne la ritrasmissione. Inoltre, UDP consente al server di gestire un volume di client concorrenti enormemente superiore, riducendo lo stato di memoria allocato.

| Applicazione di Rete | Protocollo Applicativo | Protocollo di Trasporto Sottostante |
| :--- | :--- | :--- |
| **Posta Elettronica** | SMTP [RFC 5321] | **TCP (Porta 25)** |
| **Accesso Terminale Remoto** | SSH [RFC 4251] / Telnet | **TCP (Porta 22 / 23)** |
| **Navigazione Web** | HTTP [RFC 2616, 7230] | **TCP (Porta 80)** |
| **Navigazione Web Sicura** | HTTPS [RFC 2818] | **TCP (Porta 443 via TLS)** |
| **Trasferimento File** | FTP [RFC 959] | **TCP (Porte 20, 21)** |
| **Risoluzione Nomi di Dominio** | DNS [RFC 1034, 1035] | **UDP (Porta 53)** (TCP per zone transfer) |
| **Streaming e Telefonia IP** | RTP / SIP / Proprietari | **Tipicamente UDP** |

---

## 5. Il Web e il Protocollo HTTP / HTTPS

### 5.1 Terminologia e Funzionamento
* Una **pagina web** è un documento ipertestuale composto da un file HTML base e da molteplici **oggetti referenziati** (immagini JPEG/PNG, script JavaScript, fogli di stile CSS, applet).
* Ciascun oggetto è univocamente individuato da un indirizzo **URL** (*Uniform Resource Locator*):
  $$\text{URL} = \underbrace{\text{http://www.site.com}}_{\text{Nome Host}} / \underbrace{\text{images/logo.png}}_{\text{Percorso Risorsa}}$$
* Il protocollo **HTTP** (*HyperText Transfer Protocol*) opera sul modello Client-Server:
  1. Il client (browser) apre una connessione TCP verso la porta 80 del server web.
  2. Il server web accetta la connessione.
  3. Client e server si scambiano messaggi di richiesta (*Request*) e risposta (*Response*).
  4. La connessione TCP viene chiusa o mantenuta attiva (*keep-alive*).

### 5.2 Statelessness e l'Introduzione dei Cookie
HTTP è per progettazione un protocollo **senza stato (*stateless*)**: il server web non trattiene memoria storica delle richieste precedentemente effettuate dal medesimo client.
* **Vantaggio:** Semplifica notevolmente l'architettura dei server e garantisce resilienza ai crash (non occorre ripristinare o sincronizzare stati applicativi complessi tra client e server).
* **Svantaggio:** Non supporta nativamente carrelli e-commerce, profili di accesso o sessioni continuative.

Per reintrodurre lo stato applicativo mantenendo il protocollo stateless si adottano i **Cookie**, composti da 4 componenti:
1. Header di risposta inviato dal server: `Set-Cookie: ID_SESSIONE=1678; Path=/; Secure; HttpOnly`.
2. Header di richiesta ritrasmesso dal client: `Cookie: ID_SESSIONE=1678`.
3. File di memorizzazione dei cookie gestito dal browser sul filesystem locale del client.
4. Database/Archivio di sessione sul server che associa l'ID ai dati dell'utente.

```
   Client (Browser)                                    Server Web
          │                                                 │
          │  1. Richiesta HTTP (GET /login)                 │
          │────────────────────────────────────────────────►│  Autenticazione OK:
          │                                                 │  Genera ID 1678 nel DB
          │  2. Risposta HTTP + Set-Cookie: id=1678         │
          │◄────────────────────────────────────────────────│
   Salva cookie                                             │
   amazon:1678                                              │
          │                                                 │
          │  3. Nuova Richiesta HTTP + Cookie: id=1678      │
          │────────────────────────────────────────────────►│  Riconosce ID 1678
          │                                                 │  Recupera carrello/profilo
          │  4. Risposta HTTP personalizzata                │
          │◄────────────────────────────────────────────────│
```

> [!WARNING] Rischi di Sicurezza dei Cookie e Flag Fondamentali
> Poiché i cookie fungono da token di autenticazione (*bearer token*), la loro intercettazione equivale al furto completo dell'identità dell'utente (*Session Hijacking*):
> * **Flag `Secure`:** Impone al browser di trasmettere il cookie **esclusivamente su connessioni cifrate HTTPS**, prevenendo lo sniffing del token su reti Wi-Fi pubbliche o canali non protetti.
> * **Flag `HttpOnly`:** Impedisce l'accesso al cookie tramite codice JavaScript lato client (`document.cookie`), neutralizzando l'esfiltrazione dei token di sessione in caso di attacchi **Cross-Site Scripting (XSS)**.
> * **Flag `SameSite` (`Strict`/`Lax`):** Limita l'invio dei cookie in richieste cross-site per mitigare gli attacchi di tipo **Cross-Site Request Forgery (CSRF)**.

### 5.3 Connessioni Non Persistenti vs Persistenti e Calcolo del Ritardo (RTT)
* **Connessioni Non Persistenti (default HTTP/1.0):** Ciascun oggetto web richiede l'apertura e la chiusura di una connessione TCP dedicata.
  * Il tempo per prelevare un singolo oggetto con tempo di andata e ritorno $RTT$ (*Round Trip Time*) è:
    $$T_{\text{totale}} = 2 \cdot RTT + t_{\text{trasmissione}}$$
  * ($1 \cdot RTT$ per il three-way handshake TCP + $1 \cdot RTT$ per la richiesta HTTP e i primi byte della risposta + tempo di trasferimento del payload).
  * Per scaricare una pagina con 10 immagini servono 11 connessioni TCP distinte ($22 \cdot RTT$ sequenziali, ridotti aprendo connessioni TCP parallele).
* **Connessioni Persistenti (default HTTP/1.1):** Più oggetti vengono trasferiti attraverso una **singola connessione TCP persistente** tra client e server:
  * *Senza Pipelining:* Il client attende la risposta prima di inoltrare la richiesta successiva ($1 \cdot RTT$ per ogni oggetto aggiuntivo).
  * *Con Pipelining:* Il client invia immediatamente tutte le richieste non appena incontra i riferimenti nel codice HTML ($1 \cdot RTT$ cumulativo per tutti gli oggetti referenziati).

### 5.4 Anatomia dei Messaggi HTTP

#### Messaggio di Richiesta (*Request Message*)
Formattato in testo puro ASCII e strutturato in:
1. **Riga di Richiesta (*Request Line*):** `METODO URL VERSIONE`
2. **Righe di Intestazione (*Header Lines*):** Metadati chiave-valore (`Host:`, `User-Agent:`, `Accept:`, `Connection:`).
3. **CRLF (`\r\n`):** Riga vuota obbligatoria che delimita la fine degli header.
4. **Entity Body (Payload opzionale):** Dati inviati nei metodi `POST` o `PUT`.

```http
GET /somedir/page.html HTTP/1.1\r\n
Host: www.someschool.edu\r\n
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64)\r\n
Accept-Language: it-IT,it;q=0.9\r\n
Connection: keep-alive\r\n
\r\n
```

> [!IMPORTANT] L'Header `Host:` e la Sicurezza del Virtual Hosting
> L'intestazione `Host:` è obbligatoria in HTTP/1.1: consente a un unico server web e a un unico indirizzo IP di ospitare centinaia di domini differenti (*Virtual Hosting*). Se il server non valida accuratamente questo campo, l'attaccante può manometterlo conducendo attacchi di **Host Header Injection**, avvelenamento dei link nelle email di reset password e alterazione della cache (*Web Cache Poisoning*).

#### Metodi HTTP Principali
* `GET`: Recupera la risorsa target. I parametri del form vengono accodati all'URL (*query string*).
  > [!WARNING] Rischio di Sicurezza nell'uso di `GET` per Dati Riservati
  > I parametri inviati tramite `GET` rimangono registrati in chiaro nella cronologia del browser, nei file di log dei server web, nell'header `Referer` inoltrato a siti terzi e nelle memorie cache dei proxy. È categoricamente vietato usare `GET` per trasmettere credenziali o dati personali.
* `POST`: Invia dati strutturati al server all'interno del corpo (*body*) del messaggio HTTP.
* `HEAD`: Chiede al server di restituire **esclusivamente le righe di intestazione di risposta**, omettendo il corpo della risorsa. Usato per verificare la validità di un link, la dimensione di un file (`Content-Length`) o la data di ultima modifica (`Last-Modified`) senza sprecare banda.
* `PUT`: Carica o sovrascrive interamente un documento nel percorso indicato.
* `DELETE`: Richiede la cancellazione permanente della risorsa sul server.

#### Messaggio di Risposta (*Response Message*)
```http
HTTP/1.1 200 OK\r\n
Date: Mon, 28 Sep 2026 12:00:00 GMT\r\n
Server: Apache/2.4.41 (Ubuntu)\r\n
Last-Modified: Sun, 27 Sep 2026 18:22:00 GMT\r\n
Content-Length: 6821\r\n
Content-Type: text/html; charset=UTF-8\r\n
\r\n
<!DOCTYPE html>
<html>...dati html...</html>
```

* **Codici di Stato Standard:** `200 OK` (successo), `301 Moved Permanently` (reindirizzamento permanente con header `Location`), `304 Not Modified` (copia in cache ancora valida), `400 Bad Request` (errore sintattico del client), `401 Unauthorized` (mancata autenticazione), `403 Forbidden` (accesso negato), `404 Not Found` (risorsa inesistente), `500 Internal Server Error` (fallimento interno del server), `505 HTTP Version Not Supported`.

### 5.5 Web Caching, Server Proxy e GET Condizionale
Un **Server Proxy / Web Cache** intercetta le richieste dei client e memorizza copie locali delle risorse più richieste:
* Riduce la latenza percepita dall'utente e abbatte il carico di banda sulle dorsali di rete.
* **GET Condizionale:** Per evitare di scaricare file non modificati, il proxy invia la richiesta con l'header:
  `If-Modified-Since: Sun, 27 Sep 2026 18:22:00 GMT`
* Se la risorsa sul server d'origine è immutata, il server risponde con `304 Not Modified` a payload vuoto; se è stata modificata, risponde con `200 OK` e il nuovo contenuto.

> [!WARNING] Vulnerabilità di Web Cache Poisoning
> Se un attaccante riesce a iniettare una risposta manipolata all'interno della cache di un proxy (sfruttando debolezze negli header HTTP o HTTP Request Smuggling), il server proxy distribuirà il payload dannoso a tutti gli utenti che richiederanno quella risorsa, scavalcando totalmente il server di origine.

### 5.6 Evoluzione da HTTP a HTTPS
HTTP trasmette tutti i dati e le credenziali in chiaro. **HTTPS (HTTP Secure)** interpone il livello crittografico **TLS (Transport Layer Security)** su porta **`443`**, garantendo:
1. **Confidenzialità:** Cifratura simmetrica del flusso (AES, ChaCha20).
2. **Integrità:** Codici di autenticazione dei messaggi (HMAC, AEAD).
3. **Autenticazione:** Certificati digitali X.509 emessi da Certification Authority (CA) fidate.

---

## 6. Il Protocollo FTP (File Transfer Protocol - RFC 959)

> [!IMPORTANT] Architettura Fuori Banda (*Out-of-Band*) di FTP
> Il protocollo **FTP** opera sul modello Client-Server per il trasferimento bidirezionale di file e adotta una peculiare **architettura a due connessioni TCP parallele e distinte**:
> 1. **Connessione di Controllo (TCP Porta 21):** Canale persistente per tutta la sessione, utilizzato per inviare comandi utente in formato ASCII e ricevere codici di stato. Mantiene lo stato dell'utente (directory corrente, autenticazione). È una connessione *out-of-band* perché non trasporta i byte dei file.
> 2. **Connessione Dati (TCP Porta 20 o Porta Dinamica):** Canale non persistente aperto *on-demand* esclusivamente durante il trasferimento fisico del file o dell'elenco directory (`LIST`), e chiuso immediatamente al termine del singolo trasferimento.

```
┌────────────────────────────────────────────────────────┐
│                      Client FTP                        │
│   [Interfaccia Utente] ── [Controllo] ── [Dati]        │
└────────────┬───────────────────┬─────────────┬─────────┘
             │                   │             │
             │ Connessione di    │             │ Connessione Dati
             │ Controllo (TCP 21)│             │ (TCP 20)
             ▼                   ▼             ▼
┌────────────────────────────────────────────────────────┐
│                      Server FTP                        │
│   [File System Remoto] ── [Controllo] ── [Dati]        │
└────────────────────────────────────────────────────────┘
```

### 6.1 Comandi e Codici di Stato FTP
* **Comandi ASCII Principali:** `USER username`, `PASS password`, `LIST` (elenco directory), `RETR filename` (download/get), `STOR filename` (upload/put), `QUIT`.
* **Codici di Stato Tipici:** `331 Username OK, password required`, `125 Data connection already open`, `425 Can't open data connection`, `452 Error writing file`.

> [!WARNING] Gravi Criticità di Sicurezza in FTP Tradizionale
> 1. **Credenziali in Chiaro:** I comandi `USER` e `PASS` e i dati dei file transitano non cifrati sulla rete, esponendosi a intercettazione (*sniffing*) e man-in-the-middle.
> 2. **Complessità di Filtraggio nei Firewall:** Poiché la connessione dati viene aperta su porte dinamiche negoziate sul canale di controllo, i firewall tradizionali faticano a tracciare i flussi senza moduli avanzati di Application Layer Gateway (ALG).
> 3. **Alternative Sicure:** L'FTP in chiaro è oggi sostituito da **SFTP** (SSH File Transfer Protocol, su porta TCP 22 all'interno di un tunnel SSH) o **FTPS** (FTP incapsulato in TLS/SSL).

---

## 7. Meccanismi di Controllo dell'Integrità nei Protocolli di Rete

I dati trasmessi sui canali fisici sono soggetti ad alterazioni dovute a rumore, attenuazione e collisioni. I protocolli di rete implementano meccanismi di rilevamento errori:

### 7.1 Tecniche Fondamentali
1. **Bit di Parità:** Aggiunta di un bit di controllo a una sequenza per rendere pari (*parità pari*) o dispari (*parità dispari*) il numero complessivo di bit a $1$. Rileva solo errori su singoli bit.
2. **Internet Checksum (Livello di Trasporto e Rete):**
   * Il mittente raggruppa il segmento in parole a 16 bit e ne calcola la somma in complemento a 1.
   * Il complemento a 1 della somma viene inserito nel campo *Checksum* dell'header.
   * Il ricevente somma tutte le parole a 16 bit (incluso il checksum): se il risultato è composto da tutti $1$ (`0xFFFF`), il pacchetto non presenta errori accidentali; altrimenti viene scartato.

### 7.2 Implementazione del Checksum nei Vari Livelli
* **TCP:** Checksum calcolato sulla **pseudo-intestazione IP + intero segmento TCP (header + dati)**. Obbligatorio sia in IPv4 che in IPv6.
* **IPv4:** Checksum calcolato **esclusivamente sull'intestazione IP** (il payload/dati non è protetto da IP, demandando l'integrità a TCP o al livello applicazione). In IPv6 il checksum di rete è stato eliminato per velocizzare il routing.
* **Ethernet (Data Link):** Frame Check Sequence (**FCS**) basato su polinomio ciclico **CRC a 32 bit**, in grado di rilevare sequenze complesse di burst error.
* **HTTP:** Non prevede alcun checksum nativo nel corpo; l'integrità è delegata interamente a TLS in HTTPS.

> [!IMPORTANT] Distinzione Critica: Checksum vs Integrità Crittografica
> Il checksum e il CRC sono funzioni **matematiche non crittografiche** progettate unicamente per rilevare **errori accidentali e casuali** del canale di trasmissione. **Non offrono alcuna sicurezza contro attaccanti intenzionali**: un utente malintenzionato che intercetta e modifica un pacchetto può ricalcolare istantaneamente il checksum valido corrispondente al dato manomesso. Per garantire una reale integrità e autenticità contro manomissioni attive sono indispensabili primitive crittografiche come i **Message Authentication Code (MAC / HMAC)**, le **firme digitali** e i cifrari autenticati (AEAD).

---

## 8. Architettura della Posta Elettronica: SMTP, MIME, POP3 e IMAP

L'infrastruttura di posta elettronica si articola su tre componenti fondamentali:
* **Mail User Agent (MUA):** Client di posta utilizzato dall'utente (es. Thunderbird, Outlook, Apple Mail).
* **Mail Transfer Agent (MTA) / Mail Server:** Server che gestisce le caselle di posta (*mailbox*) e le code di messaggi in uscita.
* **Protocolli di Comunicazione:** SMTP per l'invio e il routing inter-server; POP3/IMAP per il prelievo della posta da parte del destinatario.

```
┌───────────┐                      ┌─────────────┐                      ┌─────────────┐                      ┌───────────┐
│ MUA Alice │ ──(SMTP, porta 25)──►│ Mail Server │ ──(SMTP, porta 25)──►│ Mail Server │ ◄──(POP3/IMAP)───────│  MUA Bob  │
│  Client   │                      │    Alice    │                      │     Bob     │ (Porte 110/143/993)  │  Client   │
└───────────┘                      └─────────────┘                      └─────────────┘                      └───────────┘
```

### 8.1 SMTP (Simple Mail Transfer Protocol - RFC 5321)
* **Funzione:** Protocollo di livello applicativo orientato all'**invio (*push*)** dei messaggi di posta elettronica da client a server e tra server di posta intermedi su connessione **TCP (porta 25)**.
* **Modalità Operativa:** A differenza di HTTP che è un protocollo di tipo *pull* (il client preleva le risorse), SMTP è strettamente *push* (il mittente spinge il messaggio verso il destinatario).
* **Connessioni Persistenti:** SMTP mantiene la connessione TCP aperta per trasferire molteplici messaggi consecutivi verso il medesimo server.

#### Le Tre Fasi del Dialogo SMTP (Comando/Risposta ASCII)
```text
S: 220 hamburger.edu ESMTP Server Ready
C: HELO crepes.fr
S: 250 Hello crepes.fr, pleased to meet you
C: MAIL FROM: <alice@crepes.fr>
S: 250 alice@crepes.fr... Sender ok
C: RCPT TO: <bob@hamburger.edu>
S: 250 bob@hamburger.edu ... Recipient ok
C: DATA
S: 354 Enter mail, end with "." on a line by itself
C: From: "Alice" <alice@crepes.fr>
C: To: "Bob" <bob@hamburger.edu>
C: Subject: Prova invio
C: 
C: Ciao Bob, questo e il corpo del messaggio.
C: .
S: 250 Message accepted for delivery
C: QUIT
S: 221 hamburger.edu closing connection
```

> [!WARNING] La Porta 25 e il Problema dell'Open Relay / Mail Spoofing
> Poiché originariamente i server SMTP non richiedevano alcuna autenticazione e consentivano a chiunque di dichiarare qualsiasi mittente nel comando `MAIL FROM:`, i server configurati in modalità **Open Relay** sono stati massicciamente sfruttati per l'invio indiscriminato di **spam e phishing**. I moderni sistemi applicano protocolli di autenticazione e reputazione del mittente:
> * **SPF (Sender Policy Framework):** Record DNS che autorizza specifici indirizzi IP all'invio di email per quel dominio.
> * **DKIM (DomainKeys Identified Mail):** Firma crittografica a chiave pubblica apposta nell'header dell'email.
> * **DMARC:** Policy che definisce le azioni da intraprendere (es. scarto o quarantena) qualora i controlli SPF o DKIM falliscano.

### 8.2 Formato dei Messaggi: RFC 822 e Standard MIME

#### Struttura del Messaggio RFC 822
Il messaggio è composto da:
1. **Header RFC 822:** Righe `To:`, `From:`, `Subject:`, `Date:` (separate dai comandi del protocollo SMTP).
2. **Riga Vuota (CRLF).**
3. **Body:** Corpo del messaggio in formato testo ASCII a 7 bit.

#### Standard MIME (Multipurpose Internet Mail Extensions - RFC 2045-2049)
Per consentire il trasporto di caratteri non ASCII (accenti, caratteri orientali) e **allegati binari multimediali** (immagini, PDF, audio, video) all'interno di un canale storicamente limitato all'ASCII a 7 bit, MIME introduce intestazioni supplementari:
* `MIME-Version: 1.0`
* `Content-Type`: Dichiara il formato del dato (`text/html; charset=UTF-8`, `image/jpeg`, `multipart/mixed`, `multipart/alternative`).
* `Content-Transfer-Encoding`: Metodo di codifica dei byte binari in caratteri stampabili:
  * **Base64:** Raggruppa i byte in blocchi di 3 byte (24 bit) e li mappa in 4 caratteri ASCII a 6 bit (incremento di overhead pari a circa il $+33\%$).
  * **Quoted-Printable:** Preserva i caratteri ASCII standard codificando i caratteri speciali nella forma `=XX` (dove `XX` è l'esadecimale del byte).

#### Analisi delle Intestazioni di un'Email Reale
```http
Return-Path: <fancello@sci.unich.it>
Received: from phobos.unich.it (phobos.unich.it [192.167.13.101])
	by gotham.sci.unich.it (8.12.8/8.12.8) with ESMTP id i8GAZMaS011065
	for <bista@sci.unich.it>; Thu, 16 Sep 2026 12:35:23 +0200
Message-ID: <001801c49bd8$b54118c0$0b5ca7c0@sci.unich.it>
From: "Maura Fancello" <fancello@sci.unich.it>
To: "Stefano Bistarelli" <bista@sci.unich.it>
Subject: Re: lavagna luminosa e proiettore
Date: Thu, 16 Sep 2026 12:34:10 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----=_NextPart_000_0015_01C49BE9"
X-Mailer: Microsoft Outlook Express 6.00
X-Antivirus: Scanned by F-Prot Antivirus
X-Spam-Status: No, hits=-4.8 required=3.0
```

* `Return-Path` e intestazioni `Received`: Tracciano l'intera catena di server MTA attraversati dal messaggio, essenziali per la digital forensics e per verificare l'autenticità del percorso di instradamento.
* `Message-ID`: Identificatore univoco globale del messaggio generato dal primo mail server.
* `boundary`: Stringa di delimitazione che separa le diverse sezioni nei messaggi multipart.
* Intestazioni `X-*`: Metadati non standard introdotti da client o filtri specifici (antivirus, antispam, client di posta).

> [!INFO] Il Parametro `boundary` e gli Attacchi di MIME Injection
> Il tipo `multipart` separa testo ed allegati tramite la stringa `boundary`. Se il contenuto di un allegato include accidentalmente o deliberatamente tale stringa senza adeguata sanitizzazione, l'interprete email può dividere erroneamente il messaggio, aprendo a tecniche di **MIME Boundary Injection** per mascherare codice malevolo o alterare la visualizzazione del messaggio.

### 8.3 Protocolli di Prelievo e Accesso: POP3 vs IMAP

| Dimensione di Confronto | POP3 (*Post Office Protocol v3*) [RFC 1939] | IMAP (*Internet Message Access Protocol*) [RFC 1730] |
| :--- | :--- | :--- |
| **Porta Standard** | TCP **110** (POP3S su TCP **995** con TLS) | TCP **143** (IMAPS su TCP **993** con TLS) |
| **Paradigma Operativo** | Download in locale ("Scarica e Cancella" o "Scarica e Mantieni") | Gestione centralizzata e sincronizzata direttamente sul server |
| **Mantenimento dello Stato** | **Stateless** tra sessioni distinte | **Stateful**: conserva lo stato dei messaggi (*letto*, *risposto*, *bozza*) |
| **Organizzazione Cartelle** | Solo casella di posta in arrivo locale | Cartelle gerarchiche multiple create e sincronizzate sul server |
| **Accesso Multidispositivo** | Problematico (disallineamento tra client diversi) | Ottimale (piena sincronizzazione tra PC, smartphone, webmail) |

#### Esempio di Sessione POP3 (Fase di Autorizzazione e Transazione)
```text
S: +OK POP3 server ready
C: user bob
S: +OK
C: pass secretpassword
S: +OK user successfully logged on
C: list
S: 1 498
S: 2 912
S: .
C: retr 1
S: <visualizzazione messaggio 1>
S: .
C: dele 1
S: +OK message 1 deleted
C: quit
S: +OK POP3 server signing off
```

---

## 9. Il Sistema dei Nomi di Dominio (DNS - Domain Name System)

Il **DNS** [RFC 1034, 1035] è il servizio di directory fondamentale di Internet operante a livello applicativo su protocollo di trasporto **UDP (porta 53)** (con fallback su TCP per trasferimenti di zona o risposte con payload superiore a 512 byte).

### 9.1 Architettura del Database Distribuito e Gerarchico
Il DNS traduce gli hostname mnemonici (es. `www.unipg.it`) negli indirizzi IP numerici instradabili (es. `141.250.x.x`). La sua architettura è scalabile e distribuita per scongiurare singoli punti di vulnerabilità (*Single Point of Failure*):

```
                      [ Root DNS Servers (13 indirizzi logici Anycast) ]
                                          │
                  ┌───────────────────────┴───────────────────────┐
                  ▼                                               ▼
      [ TLD Server (.it) ]                            [ TLD Server (.com) ]
                  │                                               │
                  ▼                                               ▼
  [ Authoritative DNS (unipg.it) ]               [ Authoritative DNS (google.com) ]
```

1. **Root DNS Servers:** 13 indirizzi logici (replicati capillarmente tramite *Anycast*) che indirizzano le interrogazioni verso i server TLD di competenza.
2. **Top-Level Domain (TLD) Servers:** Gestiscono i domini di primo livello generici (gTLD: `.com`, `.org`, `.net`, `.edu`) e nazionali (ccTLD: `.it`, `.fr`, `.de`).
3. **Authoritative DNS Servers (Server Autoritativi):** Conservano i record ufficiali di risoluzione per i domini di una specifica organizzazione.
4. **Local DNS Server (Default Resolver):** Server DNS dell'ISP o dell'azienda che riceve direttamente le query dagli host locali e gestisce la cache di risoluzione.

### 9.2 Modalità di Risoluzione: Iterativa vs Ricorsiva
* **Query Ricorsiva:** Il nodo richiedente delega completamente al server DNS interrogato il compito di reperire la risposta finale, attendendo la mappatura IP definitiva.
* **Query Iterativa:** Il server DNS interrogato risponde fornendo l'indirizzo IP del server DNS di livello successivo da contattare, demandando al resolver locale l'onere di proseguire la catena gerarchica.

### 9.3 Struttura dei Resource Record (RR)
I dati nel database DNS sono formalizzati come quartine `(Name, Value, Type, TTL)`:
* **Tipo `A`:** Associa un hostname a un indirizzo IPv4: `(sito.com, 192.0.2.1, A, 3600)`.
* **Tipo `AAAA`:** Associa un hostname a un indirizzo IPv6 a 128 bit.
* **Tipo `NS` (*Name Server*):** Specifica l'hostname del server DNS autoritativo responsabile per il dominio specificato in `Name`.
* **Tipo `CNAME` (*Canonical Name*):** Definisce un alias rispetto al nome canonico reale: `(www.server.com, server-principale.com, CNAME, 3600)`.
* **Tipo `MX` (*Mail Exchange*):** Specifica il nome del server di posta elettronica di riferimento per il dominio.
* **TTL (*Time to Live*):** Intervallo temporale in secondi durante il quale il record può essere memorizzato nella cache dei resolver prima della sua rivalidazione obbligatoria.

---

## 10. Confronto Architetturale: Modello ISO/OSI vs Stack TCP/IP

Il modello **ISO/OSI** (ISO 7498) costituisce il riferimento concettuale e teorico a **7 livelli**, mentre lo stack **TCP/IP** rappresenta l'architettura effettivamente implementata su scala globale a **5 livelli**:

```
        Modello ISO/OSI (7 Livelli)                 Stack TCP/IP (5 Livelli)
  ┌─────────────────────────────────────┐     ┌─────────────────────────────────────┐
  │ 7. Livello di Applicazione          │     │                                     │
  ├─────────────────────────────────────┤     │  5. Livello di Applicazione         │
  │ 6. Livello di Presentazione         │ ──► │     (HTTP, HTTPS, FTP, SMTP, DNS)   │
  ├─────────────────────────────────────┤     │                                     │
  │ 5. Livello di Sessione              │     ├─────────────────────────────────────┤
  ├─────────────────────────────────────┤     │  4. Livello di Trasporto (TCP, UDP) │
  │ 4. Livello di Trasporto             │ ──► ├─────────────────────────────────────┤
  ├─────────────────────────────────────┤     │  3. Livello di Rete (IP, ICMP)      │
  │ 3. Livello di Rete                  │ ──► ├─────────────────────────────────────┤
  ├─────────────────────────────────────┤     │  2. Livello di Collegamento (Link)  │
  │ 2. Livello di Collegamento Dati     │ ──► ├─────────────────────────────────────┤
  ├─────────────────────────────────────┤     │  1. Livello Fisico (Bit e Segnali)  │
  │ 1. Livello Fisico                   │ ──► └─────────────────────────────────────┘
  └─────────────────────────────────────┘
```

| Livello ISO/OSI | Corrispettivo TCP/IP | Responsabilità e Funzioni | Esempi di Protocolli |
| :--- | :--- | :--- | :--- |
| **7. Applicazione** | **5. Applicazione** | Interfaccia utente e servizi di rete distribuiti | HTTP, FTP, SMTP, DNS |
| **6. Presentazione** | *(Inglobato in Applicazione)* | Formattazione dati, codifica caratteri, cifratura e compressione | TLS/SSL, MIME, ASCII |
| **5. Sessione** | *(Inglobato in Applicazione)* | Controllo e sincronizzazione dei dialoghi tra processi | Gestione sessioni HTTP/Cookie |
| **4. Trasporto** | **4. Trasporto** | Trasferimento logico process-to-process, affidabilità, flusso | TCP, UDP |
| **3. Rete** | **3. Rete** | Indirizzamento logico globale e routing tra sottoreti | IPv4, IPv6, ICMP, BGP |
| **2. Collegamento** | **2. Collegamento** | Framing, controllo errori e indirizzamento fisico su singolo hop | Ethernet (MAC), Wi-Fi, PPP |
| **1. Fisico** | **1. Fisico** | Trasmissione dei bit grezzi sul mezzo fisico | Segnali elettrici, ottici |

### Differenze Sostanziali
1. **Granularità e Praticità:** OSI è nato come modello teorico a priori; TCP/IP è nato dall'esperienza operativa di ARPANET ed è il modello realmente adottato.
2. **Collasso di Presentazione e Sessione:** In TCP/IP le problematiche di formattazione, crittografia (TLS) e gestione dello stato non richiedono livelli dedicati nel sistema operativo ma sono gestite direttamente dalle librerie applicative.
3. **Strategia di Affidabilità Multilivello:** In OSI l'affidabilità era teorizzata prevalentemente al livello trasporto; in TCP/IP ogni livello implementa controlli di errore indipendenti (FCS a livello link, checksum IP sull'header, checksum TCP sul segmento), garantendo robustezza end-to-end.

---

## 11. Quadro di Sintesi: Dove si Attacca la Pila dei Protocolli

La comprensione dello stack a strati consente di mappare con precisione le vulnerabilità e le relative contromisure di difesa:

| Livello Protocollare | Protocolli Target | Debolezze e Vettori di Attacco Tipici | Contromisure e Difese Primarie |
| :--- | :--- | :--- | :--- |
| **5. Applicazione** | HTTP, FTP, SMTP, DNS | • Trasmissione dati e credenziali in chiaro<br>• Mancata validazione dell'input (SQLi, XSS)<br>• Manipolazione header (`Host`, MIME)<br>• Web Cache Poisoning e DNS Spoofing | • Cifratura applicativa (HTTPS/TLS, SFTP, SMTPS)<br>• Web Application Firewall (WAF) e IPS<br>• Cookie flags (`HttpOnly`, `Secure`, `SameSite`)<br>• Autenticazione email (SPF, DKIM, DMARC)<br>• DNSSEC |
| **4. Trasporto** | TCP, UDP | • Mancanza di cifratura/integrità nativa<br>• TCP SYN Flood (DoS/DDoS)<br>• TCP Session Hijacking (predizione Seq Number)<br>• UDP Amplification Attack | • Protocolli TLS / DTLS su socket<br>• SYN Cookies a livello kernel del SO<br>• Randomizzazione iniziale dei numeri di sequenza<br>• Rate limiting del traffico UDP sui firewall |
| **3. Rete** | IPv4, ICMP, Routing | • Mancanza di integrità del payload in IPv4<br>• IP Spoofing (falsificazione mittente)<br>• ICMP Redirect / Ping of Death<br>• BGP Route Hijacking | • IPsec (AH/ESP per integrità e confidenzialità)<br>• Filtri anti-spoofing (Ingress/Egress Filtering - BCP 38)<br>• Disabilitazione ICMP Redirect sui router |
| **2. Collegamento** | Ethernet, ARP, Wi-Fi | • Assenza di autenticazione in ARP (ARP Spoofing)<br>• Sniffing su domini broadcast / CAM Table Overflow<br>• Rogue DHCP Server | • Port Security e Dynamic ARP Inspection (DAI)<br>• DHCP Snooping sugli switch gestiti<br>• Segmentazione tramite VLAN e standard 802.1X |
| **1. Fisico** | Cavi, Wi-Fi | • Intercettazione fisica (cable tapping, sniffing RF)<br>• Manomissione hardware e rogue device | • Protezione fisica dei rack e dei condotti di rete<br>• Cifratura end-to-end a prescindere dal canale |

---
