# Lezione 1: Fondamenti di Networking, Teoria della Comunicazione e Standard

## 1. Introduzione al Networking e Convergenza Telematica

Il settore delle reti di calcolatori e dei sistemi telematici è caratterizzato da una crescita pervasiva ed esponenziale. Questa continua evoluzione tecnologica è trainata dalla convergenza di molteplici fattori abilitanti:

* **Sviluppo delle Telecomunicazioni:** espansione delle infrastrutture ad altissima capacità trasmissiva (dorsali in fibra ottica ad altissima velocità, tecnologie wireless cellulari e satellitari).
* **Sviluppo delle Micro e Nano-tecnologie:** avanzamento continuo della miniaturizzazione dei semiconduttori, che permette di integrare elevate capacità computazionali e interfacce di rete in chip compatti a bassissimo consumo energetico.
* **Sensori ad Elevata Efficienza:** disponibilità di sensori sempre più miniaturizzati, affidabili ed economici, volano primario per l'Internet of Things (IoT), i sistemi embedded e il monitoraggio ambientale e industriale continuo.
* **Sviluppo di Soluzioni Software Avanzate:** ingegnerizzazione di stack protocollari altamente performanti, architetture a microservizi e soluzioni di virtualizzazione delle funzioni di rete (*Software-Defined Networking* - SDN).
* **Convergenza e Soluzioni Hardware/Software Integrate:**
  * Capacità di gestire e trasferire simultaneamente **dati numerici, flussi audio/voce e flussi video ad alta definizione**.
  * Requisito stringente di erogazione e sincronizzazione in **tempo reale (*real-time*)**, essenziale per videoconferenze, telemedicina e sistemi di controllo critici.

La transizione tecnologica ha segnato il superamento definitivo dei modelli centralizzati (fondati sui grandi mainframe con terminali passivi) a favore dei **sistemi di elaborazione distribuita**, sostenuti da tecnologie in grado di instradare volumi massivi di dati tramite segnali fisici a frequenze elevatissime.

## 2. Il Processo di Comunicazione Dati

L'infrastruttura globale consente a sistemi eterogenei di interagire e scambiare informazioni su qualsiasi scala geografica (da reti locali LAN fino all'interconnessione planetaria su scala WAN e Internet).

### 2.1 La Triade Fondamentale della Comunicazione
Un processo comunicativo si realizza unicamente in presenza di tre elementi costitutivi irrinunciabili:
1. **Sorgente dell'Informazione (*Source / Trasmettitore*):** il dispositivo che genera i dati da trasmettere (es. personal computer, telecamera IP, sensore IoT).
2. **Mezzo Trasmissivo (*Transmission Medium / Cammino Fisico*):** il supporto o percorso fisico lungo il quale si propaga il segnale (mezzi guidati come rame e fibra ottica, o mezzi non guidati come lo spazio libero tramite onde elettromagnetiche).
3. **Destinatario (*Destination / Ricevitore*):** il dispositivo a cui è destinato il flusso informativo e che acquisisce il segnale (es. server, workstation, attuatore).

```
	          Mezzo Trasmissivo (Canale Fisico)          
│ Sorgente ├─────────────────────────────────────►│ Destinatario │
                                                 
```

### 2.2 Definizione di Comunicazione Dati e Sistema di Comunicazione
La **comunicazione dati** è lo scambio formale di informazioni tra due o più dispositivi realizzato attraverso un idoneo mezzo di trasmissione.-

Affinché la comunicazione abbia luogo con successo, i singoli apparati devono integrarsi all'interno di un **sistema di comunicazione** coerente, strutturato in due componenti complementari:
* **Hardware:** le interfacce fisiche di rete (NIC - *Network Interface Card*), modem, amplificatori, antenne, commutatori (*switch*) e instradatori (*router*).
* **Software:** i driver di periferica, gli stack protocollari di sistema operativo (es. suite TCP/IP) e i programmi applicativi di rete.

## 3. Teoria dell'Informazione e Modello di Shannon-Weaver

### 3.1 Definizioni Fondamentali ed Etimologia

> [!NOTE] Definizioni di Informazione e Comunicazione
> * **Informazione:** L'insieme di dati, correlati e strutturati tra loro, attraverso cui un'idea, un concetto o un fatto assume forma intelligibile e può essere comunicato e compreso.
> * **Comunicazione:** Dal latino *cum* ("con", "insieme") e *munire* ("legare", "costruire"), e dal verbo *communico* ("mettere in comune", "rendere partecipe"). Indica il processo e l'insieme delle modalità attraverso cui un'informazione viene trasmessa da un soggetto a un altro (o da un luogo a un altro) tramite lo scambio di un messaggio codificato in accordo con un codice formale prestabilito.

### 3.2 Il Modello di Shannon-Weaver (1949)
Formulato originariamente da Claude Shannon e Warren Weaver nei Bell Laboratories, il modello descrive la trasmissione dell'informazione attraverso **7 elementi fondamentali**:

1. **Fonte / Sorgente (*Information Source*):** l'entità che concepisce e genera il messaggio originario.
2. **Codifica (*Encoding / Trasmettitore*):** l'operazione che converte il messaggio logico in segnali fisici (elettrici, ottici o radio) trasmissibili attraverso il canale.
3. **Messaggio:** la sequenza informativa strutturata prodotta dal processo di codifica.
4. **Mezzo Trasmissivo / Canale (*Channel*):** il mezzo fisico che sostiene la propagazione dei segnali.
5. **Rumore (*Noise Source*):** disturbi casuali, attenuazioni, dispersioni o interferenze esterne introdotte dal canale, suscettibili di degradare o alterare il segnale.
6. **Decodifica (*Decoding / Ricevitore*):** l'operazione inversa che ricostruisce il messaggio logico originario a partire dai segnali fisici ricevuti.
7. **Destinatario (*Destination*):** la persona o il sistema finale a cui è indirizzata l'informazione.

![[Pasted image 20260925115804.png|450]]

> [!NOTE] Il Modello di Shannon-Weaver
> Rappresentazione bidirezionale e ciclica del processo comunicativo: la fonte codifica il messaggio per il canale (soggetto a rumore ed errori di trasmissione); il destinatario decodifica il messaggio e, attraverso un meccanismo di retroazione (*feedback*), può assumere il ruolo di sorgente invertendo il flusso della comunicazione.

## 4. La Gerarchia della Conoscenza: La Piramide DIKW

La gestione e la trasformazione delle informazioni nei sistemi telematici e decisionali è formalizzata nel modello gerarchico **DIKW** (*Data, Information, Knowledge, Wisdom*):

![[Pasted image 20260925115953.png|450]]

> [!NOTE] La Piramide DIKW
> Struttura gerarchica dell'elaborazione conoscitiva: dai dati grezzi alla base fino alla saggezza apicale. Evidenzia la transizione continua tra le dimensioni empiriche di elevato volume e oggettività alla base, verso contesti di alto valore aggiunto, struttura e soggettività al vertice.

La piramide articola la conoscenza in quattro stadi ascendenti:

1. **Dati (*Data*):**
   * Elementi grezzi, simboli non contestualizzati, misurazioni o segnali binari privi di significato intrinseco (es. il valore `25`, la stringa `10101`).
   * *Proprietà:* massimi livelli di **oggettività**, **volume** e **completezza**, ma utilità operativa nulla in assenza di un contesto interpretativo.
2. **Informazione (*Information*):**
   * Dati organizzati, correlati e contestualizzati, a cui viene associato un significato semantico ben preciso.
   * Risponde alle interrogazioni empiriche: *chi?*, *cosa?*, *dove?*, *quando?*
   * *Esempio:* `"La temperatura registrata nella sala server alle 11:59 è di 25°C"`.
3. **Conoscenza (*Knowledge*):**
   * Comprensione contestuale derivata dall'assimilazione, dall'integrazione e dal confronto di informazioni mediante esperienza, regole inferenziali e modelli cognitivi.
   * Risponde alla domanda: *come?*
   * *Esempio:* `"Una temperatura costante di 25°C nella sala server supera la soglia raccomandata e rischia di innescare il thermal throttling delle CPU"`.
4. **Saggezza (*Wisdom*):**
   * Livello apicale della gerarchia: integra la conoscenza con il giudizio critico, la visione a lungo termine e le decisioni strategiche.
   * Risponde alla domanda: *perché?*
   * *Esempio:* Progettare una riconfigurazione dell'impianto di climatizzazione e delle policy di carico computazionale per garantire la continuità operativa ottimizzando al contempo l'impatto energetico complessivo.

| Livello della Piramide | Caratteristiche Distintive | Funzione nel Sistema Informativo |
| :--- | :--- | :--- |
| **Vertice: Saggezza e Conoscenza** | Soggettività, Alto Valore Aggiunto, Sintesi, Struttura | Supporto alle decisioni strategiche e comprensione di sistema |
| **Base: Informazione e Dati** | Oggettività, Elevato Volume, Completezza, Misurabilità | Rilevazione sensoriale, codifica, memorizzazione e trasporto di rete |

## 5. I Protocolli di Rete e gli Standard Internazionali

### 5.1 Il Concetto Fondamentale di Protocollo
Un **protocollo di rete** è un insieme formale di regole, formati e convenzioni condivise che stabiliscono le modalità con cui due o più entità devono comunicare.

Un protocollo specifica in modo deterministico:
* **Cosa si scambia (Sintassi e Semantica):**
  * *Sintassi:* la struttura del pacchetto, la disposizione dei bit e dei campi (header, payload, checksum) e i formati di codifica.
  * *Semantica:* il significato associato a ciascun pattern di bit o campo di controllo e le azioni da intraprendere alla ricezione di ciascun comando.
* **Come avviene lo scambio (Temporizzazione / *Timing*):**
  * La sincronizzazione temporale, l'ordine sequenziale dei messaggi e i meccanismi di regolazione della velocità trasmissiva (*flow control*).

> [!IMPORTANT] Necessità Ineludibile del Protocollo
> Due o più dispositivi possono essere fisicamente e correttamente collegati tramite cavi o onde radio, ma in assenza di un protocollo comune **non sono assolutamente in grado di comunicare**. Senza regole condivise, i segnali elettrici o ottici ricevuti risultano indecifrabili, analogamente a due individui collegati tramite una linea telefonica impeccabile che parlino due lingue del tutto sconosciute l'uno all'altro.

### 5.2 Gli Enti e le Organizzazioni di Standardizzazione Internazionale
Affinché apparati realizzati da produttori indipendenti e basati su architetture differenti possano interoperare senza frizioni su scala mondiale, i protocolli devono essere formalizzati come standard aperti e condivisi.

I principali organismi internazionali responsabili della definizione degli standard telematici e delle reti sono:

![[Pasted image 20260925120233.png|180]]

* **ISO (*International Organization for Standardization*):**
  * La più grande organizzazione mondiale indipendente e non governativa per la standardizzazione tecnica.
  * Sviluppa norme in molteplici settori industriali, svolgendo un ruolo cardine nel networking grazie alla definizione del modello di riferimento **ISO/OSI (*Open Systems Interconnection*)** e alle normative internazionali per la sicurezza informatica (es. serie ISO/IEC 27000).

![[standard_organizations.png|500]]

* **IEEE-SA (*Institute of Electrical and Electronics Engineers - Standards Association*):**
  * Organizzazione leader nella standardizzazione dei livelli fisici e di accesso al mezzo (sottolivelli PHY e MAC).
  * Responsabile della celebre famiglia di standard **IEEE 802** (es. **IEEE 802.3** per Ethernet cablata, **IEEE 802.11** per il Wi-Fi, **IEEE 802.15** per WPAN/Bluetooth/Zigbee).
* **IETF (*Internet Engineering Task Force*):**
  * Comunità internazionale aperta di ingegneri, progettisti e ricercatori incaricata dello sviluppo e dell'evoluzione dell'architettura e dei protocolli della suite Internet.
  * Gli standard IETF vengono formalizzati attraverso i documenti ufficiali denominati **RFC (*Request for Comments*)**, che regolamentano protocolli fondamentali quali IP, TCP, UDP, DNS, HTTP, BGP e TLS.
* **ITU (*International Telecommunication Union*, ex CCITT):**
  * Agenzia specializzata delle Nazioni Unite (ONU) per le tecnologie dell'informazione e della comunicazione.
  * Il settore **ITU-T** definisce standard globali per le telecomunicazioni, la telefonia, le reti a banda larga e le infrastrutture di trasporto ottico.
* **ICANN (*Internet Corporation for Assigned Names and Numbers*):**
  * Ente no-profit responsabile del coordinamento globale degli identificatori univoci di Internet.
  * Assegna e gestisce lo spazio degli **indirizzi IP** (attraverso la funzione IANA) e coordina il sistema dei nomi di dominio (**DNS**), inclusa la gestione della radice (*Root Zone*) e dei domini di primo livello (*TLD - Top-Level Domains*, sia generici gTLD che nazionali ccTLD).
* **W3C (*World Wide Web Consortium*):**
  * Consorzio internazionale guidato storicamente da Tim Berners-Lee per lo sviluppo degli standard aperti del World Wide Web.
  * Definisce le specifiche di linguaggi e tecnologie web quali **HTML5**, **CSS**, **XML**, standard di accessibilità (**WAI/WCAG**) e linee guida per il Web Semantico.

---

## 6. Modelli Architetturali di Riferimento: ISO/OSI vs TCP/IP

### 6.1 Principi dell'Architettura a Livelli
I moderni sistemi di telecomunicazione adottano un'**architettura modulare a livelli (*layered architecture*)**, strutturata secondo principi cardine dell'ingegneria del software:
* **Astrazione e Separazione degli Interessi (*Separation of Concerns*):** ogni livello (*layer*) risolve un sottoinsieme specifico di problematiche comunicative, offrendo servizi ben definiti al livello superiore e nascondendo i dettagli implementativi sottostanti.
* **Incapsulamento:** ogni livello riceve dati dal livello superiore, aggiunge la propria informazione di controllo sotto forma di intestazione (*header*) o coda (*trailer*), generando la specifica unità di dati di protocollo.
* **Interoperabilità e Flessibilità:** la modifica interna di un protocollo ad un determinato livello non impatta i livelli adiacenti, purché le interfacce di comunicazione rimangano inalterate.

### 6.2 Struttura dei Livelli: Host Layers vs Media Layers
I livelli architetturali si dividono in due macro-categorie funzionali:

1. **Host Layers (Livelli Host / End-to-End / Software):**
   * Operano **esclusivamente sui sistemi terminali (*End Systems / Hosts*)**.
   * Sono implementati a livello software nel sistema operativo e nelle applicazioni utente, indipendentemente dal mezzo fisico sottostante.
   * Gestiscono l'interazione con l'utente, la rappresentazione dei formati, il controllo di sessione e l'affidabilità del trasporto da estremo a estremo (*end-to-end*).
2. **Media Layers (Livelli Media / Subnet / Hardware-Network):**
   * Governano il trasferimento effettivo delle informazioni attraverso i canali trasmissivi e gli apparati intermedi di rete (router, switch).
   * Risolvono l'indirizzamento logico, l'instradamento (*routing*), l'indirizzamento fisico (*MAC*), l'accesso al mezzo e la modulazione/trasmissione dei segnali.

### 6.3 Protocol Data Unit (PDU) per Livello
Ciascun livello elabora e scambia una propria specifica unità di dati denominata **PDU (*Protocol Data Unit*)**:

| Livello OSI | Livello Funzionale | PDU (Data Unit) | Descrizione della PDU |
| :--- | :--- | :--- | :--- |
| **7. Application** | Host Layer | **Data (Dati)** | Messaggio o payload applicativo originario |
| **6. Presentation** | Host Layer | **Data (Dati)** | Dati formattati, cifrati o compressi |
| **5. Session** | Host Layer | **Data (Dati)** | Flusso dati strutturato all'interno della sessione logica |
| **4. Transport** | Host Layer | **Segment / Datagram** | Segmento (TCP, con controllo di sequenza) o Datagramma (UDP) |
| **3. Network** | Media Layer | **Packet (Pacchetto)** | Pacchetto o Datagramma di rete con indirizzi logici IP |
| **2. Data Link** | Media Layer | **Frame (Trama)** | Trama con indirizzi fisici MAC e codici di controllo errore (CRC) |
| **1. Physical** | Media Layer | **Bits (Bit / Segnali)** | Sequenza binaria grezza trasmessa sul mezzo fisico |

### 6.4 Confronto Dettagliato: Modello ISO/OSI (7 Livelli) vs Stack TCP/IP (4 Livelli)

![[iso_osi_vs_tcp_ip.png|450]]

#### 1. Livello Fisico (*Physical Layer - Livello 1 OSI*)
* **Funzione:** Trasmissione di bit grezzi non strutturati lungo il canale di comunicazione.
* **Competenze:** Specifiche elettriche, ottiche, meccaniche e funzionali; livelli di tensione; durata dei bit; modulazione e codifica del segnale; connettori e cavi fisici.
* **TCP/IP:** Integrato all'interno del *Network Access Layer*.

#### 2. Livello Collegamento Dati (*Data Link Layer - Livello 2 OSI*)
* **Funzione:** Trasferimento affidabile e privo di errori di trame (*frame*) tra due nodi direttamente adiacenti sullo stesso canale fisico.
* **Competenze:**
  * **Indirizzamento Fisico:** gestione del *MAC Address*.
  * **Controllo di Flusso e di Errore:** rilevamento (es. CRC / FCS) e correzione/ritrasmissione su singolo link.
  * **Sottolivelli:** diviso storicamente dallo standard IEEE in **LLC (*Logical Link Control*)** e **MAC (*Medium Access Control*)**.
* **TCP/IP:** Integrato all'interno del *Network Access Layer*.

#### 3. Livello di Rete (*Network Layer - Livello 3 OSI*)
* **Funzione:** Determinazione del cammino (*routing / path determination*) e instradamento dei pacchetti attraverso reti eterogenee interconnesse (*Internetworking*).
* **Competenze:** Indirizzamento logico gerarchico (indirizzi IPv4 e IPv6), tabelle di instradamento, gestione della frammentazione dei pacchetti e controllo della congestione a livello di subnet.
* **TCP/IP:** Corrisponde al livello **Internet Layer** (protocolli IP, ICMP, ARP).

#### 4. Livello di Trasporto (*Transport Layer - Livello 4 OSI*)
* **Funzione:** Consegna trasparente, ordinata e affidabile dei dati da processo applicativo a processo applicativo (*End-to-End communication*).
* **Competenze:** Multiplexing e demultiplexing tramite numeri di porta (*ports*), instaurazione/chiusura connessione, controllo di flusso end-to-end, rilevamento errori con ritrasmissioni e controllo di congestione.
* **TCP/IP:** Corrisponde al livello **Transport Layer** (protocolli TCP per trasporto affidabile orientato alla connessione, UDP per trasporto non affidabile e privo di connessione).

#### 5. Livello di Sessione (*Session Layer - Livello 5 OSI*)
* **Funzione:** Instaurazione, gestione, sincronizzazione e terminazione delle sessioni di dialogo tra applicazioni remote.
* **Competenze:** Gestione dei turni di dialogo (*half-duplex* o *full-duplex*) e inserimento di punti di sincronizzazione (*checkpoints*) per riprendere il trasferimento dati a seguito di interruzioni.
* **TCP/IP:** Le sue funzioni sono integrate direttamente nel livello **Application**.

#### 6. Livello di Presentazione (*Presentation Layer - Livello 6 OSI*)
* **Funzione:** Rappresentazione sintattica e semantica dei dati trasferiti tra sistemi eterogenei.
* **Competenze:** Conversione e normalizzazione dei formati (es. codifiche caratteri UTF-8, ASCII), crittografia/decifratura per la riservatezza e compressione dei dati.
* **TCP/IP:** Le sue funzioni sono integrate direttamente nel livello **Application**.

#### 7. Livello di Applicazione (*Application Layer - Livello 7 OSI*)
* **Funzione:** Fornire un'interfaccia di comunicazione diretta ai processi e ai programmi software utilizzati dall'utente.
* **Competenze:** Protocolli applicativi di rete specializzati (es. HTTP/HTTPS per il web, DNS per la risoluzione dei nomi, SMTP/IMAP per la posta elettronica, SSH per l'accesso remoto sicuro).
* **TCP/IP:** Corrisponde al livello **Application Layer** (raggruppa le funzioni dei livelli 5, 6 e 7 di OSI).

---

## 7. Meccanismi di Comunicazione nel Modello di Riferimento: Comunicazione End-to-End vs Inoltro di Rete

![[iso_osi_host_communication.png|480]]

> [!NOTE] Principio di Inoltro a Livello di Rete
> *"Network layer protocols forward encapsulated Transport Layer PDUs between hosts"*
> I protocolli del livello di trasporto (e dei livelli superiori) operano esclusivamente da estremo a estremo (**End-to-End**) tra i due host terminali. I protocolli del livello di rete inoltrano i pacchetti che incapsulano le PDU di trasporto attraversando la nuvola di rete mediante apparati intermedi di instradamento (**Hop-by-Hop**).

### 7.1 Confronto tra Nodi Terminali (*Hosts*) e Nodi Intermedi (*Routers*)
1. **End Systems (Hosts Terminali - Sorgente e Destinazione):**
   * Implementano lo **stack completo a 7 livelli** (o tutti i 4 livelli TCP/IP).
   * Sul nodo sorgente, il messaggio applicativo discende l'intero stack subendo il processo di **incapsulamento progressivo** fino al livello fisico.
   * Sul nodo destinatario, il flusso di bit risale lo stack subendo il processo inverso di **decapsulamento** fino al recapito all'applicazione.
2. **Intermediate Systems (Nodi Intermedi / Nodi di Rete / Routers):**
   * Appartengono alla sottorete di comunicazione (*cloud di rete*).
   * Implementano unicamente i **primi 3 livelli inferiori (*Media Layers*)**:
     * **Livello 1 (Fisico):** riceve e trasmette i segnali e la sequenza di bit grezzi dai collegamenti fisici.
     * **Livello 2 (Data Link):** acquisisce la trama, verifica l'integrità (CRC) e decapsula il pacchetto di rete rimuovendo header e trailer di livello 2.
     * **Livello 3 (Network):** esamina l'indirizzo IP di destinazione nell'header del pacchetto, consulta la propria tabella di instradamento (*routing table*), seleziona l'interfaccia di uscita ottimale (*forwarding*) e re-incapsula il pacchetto in una nuova trama di livello 2 adatta al link successivo.
   * I nodi intermedi sono **del tutto trasparenti rispetto ai livelli 4-7**: non ispezionano né modificano i dati di trasporto o di applicazione, garantendo la netta separazione tra il trasporto dati dell'utente e l'infrastruttura di instradamento.

