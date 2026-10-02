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
La **comunicazione dati** è lo scambio formale di informazioni tra due o più dispositivi realizzato attraverso un idoneo mezzo di trasmissione.

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

---

# Lezione 2: Codifica dei Dati, Flussi Trasmissivi e Valutazione delle Prestazioni di Rete

## 1. La Codifica dell'Informazione

### 1.1 Dal Carattere ai Codici

In un sistema elaborativo il **carattere** può essere associato al singolo bit: di conseguenza, sequenze significative di caratteri divengono collezioni di bit esistenti all'interno di strutture di codifica denominate **codici**, fra cui:

* **BCD** (*Binary Decimal Code*)
* **AIKEN**
* **Gray**
* **EBCDIC** (*Extended Binary Coded Decimal Code*)
* **ASCII** (*American Standard Code for Information Interchange*)
* **UNICODE**

A seconda della natura dell'informazione possiamo associare **diverse quantità di bit** ad ogni singolo elemento. Si consideri un'immagine, rappresentabile tramite una matrice di pixel: se ogni sequenza di bit deve rappresentare un pixel *e* il rispettivo colore, un'immagine a colori richiederà una quantità di bit per pixel superiore rispetto a una in bianco e nero, ove un singolo bit diventa sufficiente a rappresentare il colore del pixel.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="Architettura reti e internet/images/codifica_pixels_immagine.jpg" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
    La quantità di bit per elemento non è dunque una proprietà del dato in astratto, ma della sua natura: più l'insieme dei valori distinguibili è ampio, più bit occorrono a ciascun elemento. È la stessa logica che presiede alla scelta dei codici testuali, dove l'ampiezza in bit è determinata dal numero di simboli distinti da rappresentare.
  </div>
</div>

### 1.2 I Tre Codici Più Usati

| Codice | Estensione | Note |
| :--- | :--- | :--- |
| **ASCII** (*American Standard Code for Information Interchange*) | 7 bit | Codice di base |
| **ASCII Extended** | 8 bit | Variante che introduce i caratteri accentati |
| **EBCDIC** (*Extended Binary Coded Decimal Code*) | 8 bit | — |
| **Unicode** (es. UTF-8) | — | — |

#### Codice ASCII

<div style="display: flex; justify-content: center;">
  <img src="Architettura reti e internet/images/codice_ascii.jpg" width="420">
</div>

#### Codice ASCII Extended

In questa variante ci sono i **caratteri accentati**.

<div style="display: flex; justify-content: center;">
  <img src="Architettura reti e internet/images/codice_ascii_extended.jpg" width="240">
</div>

#### Codice EBCDIC

<div style="display: flex; justify-content: center;">
  <img src="Architettura reti e internet/images/codice_ebcdic.jpg" width="420">
</div>

## 2. I Flussi Trasmissivi

Tra mittente e destinatario il **flusso trasmissivo** può essere istituito secondo tre modalità, che si distinguono per il grado di bidirezionalità consentito:

| Tipo di Flusso | Schema | Comportamento | Esempio |
| :--- | :---: | :--- | :--- |
| **Simplex** | ![[flusso_simplex.jpg\|140]] | Solo uno dei dispositivi può spedire informazione, mentre l'altro dispositivo può solo ricevere | Radio |
| **Half Duplex** | ![[flusso_half_duplex.jpg\|140]] | Ogni dispositivo può sia trasmettere che ricevere, ma **non contemporaneamente** | Walkie-talkie |
| **Full Duplex** | ![[flusso_full_duplex.jpg\|140]] | Entrambi i dispositivi possono spedire e ricevere contemporaneamente, ottenendo bidirezionalità tramite **2 collegamenti fisici** | — |

La progressione è netta: il *simplex* azzera la bidirezionalità, l'*half duplex* la rende possibile ma mutuamente esclusiva (dato che i due dispositivi non possono operare contemporaneamente), il *full duplex* la rende simultanea su due collegamenti fisici distinti.

## 3. Gli Apparecchi della Comunicazione: DTE, DCE e CPE

Il ruolo svolto da ciascun apparato lungo il canale di comunicazione è definito da una classe di sigle specifica:

* **DTE (*Data Terminal Equipment*):** è il dispositivo informatico che permette la comunicazione dati (es. computer) e nel quale risiede l'applicazione utente.
* **DCE (*Data Circuit Terminating Equipment*, anche conosciuto come *Data Communication Equipment*):** per connettersi alla linea si rende necessario un DCE, dispositivo che converte i segnali nella forma migliore per l'invio sul canale di comunicazione (es. modem).
* **CPE (*Customer Premises Equipment*):** qualora sia richiesto un dispositivo di pertinenza dell'utente, solitamente inserito nell'abitazione del medesimo (es. reti ISDN, wireless o *voice over IP*), si parla di CPE.

> [!NOTE] Il ruolo della rete di comunicazione
> Il percorso tra due DTE non è l'unico elemento in gioco: è identificato dalla **rete di comunicazione**, che si interpone tra i due DTE e ne media il collegamento.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1.5;">
    <img src="Architettura reti e internet/images/schema_dte_dce.jpg" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1;">
    La distinzione DTE/DCE è ciò che consente all'applicazione utente, ospitata nel DTE, di dialogare attraverso la rete: il DCE è l'apparato che adatta il segnale alla forma migliore per l'invio sul canale di comunicazione, e si colloca quindi fra il terminale e la rete.
  </div>
</div>

## 4. Le Reti e il loro Mondo

Si parla di **rete** intendendo un insieme di dispositivi connessi da canali di comunicazione. Una rete presenta uno o più **nodi** capaci di inviare o ricevere dati, generati o ricevuti, da altri dispositivi o da altri nodi.

L'organizzazione delle funzioni computazionali all'interno della rete si articola in due modelli:

* **Reti ad elaborazione concentrata:** è il modello nativo per le reti telematiche; un potente DTE viene messo a disposizione di uno o più DTE che ne sfruttano le capacità di calcolo.
* **Reti ad elaborazione distribuita:** invece di essere un solo DTE a svolgere un compito, quest'ultimo viene diviso in varie parti, ognuna svolta da un nodo della rete.

### 4.1 Le Tre Procedure di Colloquio

Per entrambi i modelli proposti, il trasferimento dell'informazione tra DTE può dare luogo a tre differenti procedure di colloquio:

1. **Inquiry:** tipica forma di interrogazione ad uno o più servizi messi a disposizione dal sistema elaborativo.
2. **Conversazionale:** applicazione che permette al DTE di inviare tutte e sole quelle applicazioni previste secondo regole e formati d'immissione preimpostate.
3. **Interattivo:** risponde ad applicazioni flessibili; al DTE è permesso inviare tutte le applicazioni che consentono pieno sfruttamento di tutte le risorse elaborative.

> [!IMPORTANT] Gradazione del grado di autonomia del DTE
> Le tre procedure si differenziano per la flessibilità concessa al terminale: nell'*inquiry* il DTE interroga uno o più servizi messi a disposizione dal sistema elaborativo; nel *conversazionale* sceglie tra le applicazioni previste, ma deve rispettare regole e formati d'immissione preimpostati; nell'*interattivo* ha il pieno sfruttamento di tutte le risorse elaborative.

## 5. Gli Aspetti di Valutazione di una Rete

La bontà della rete viene valutata in base a tre aspetti: **Affidabilità**, **Sicurezza** e **Prestazioni**.

### 5.1 Affidabilità

L'affidabilità di una rete è definita come la capacità della rete di:
* Consegnare l'informazione **priva di errori**.
* Porre **rimedio a malfunzionamenti**.
* Essere **robusta in situazioni critiche**.

### 5.2 Sicurezza

La sicurezza di una rete ha come caratteristica principale la **protezione dei dati** che vengono gestiti all'interno della rete, al fine di impedire:
* Accesso non autorizzato.
* Modifiche non autorizzate.
* Perdita di dati.

### 5.3 Prestazioni

Le prestazioni di una rete possono essere valutate misurando:

| Metrica | Definizione |
| :--- | :--- |
| **Ritardo** | Tempo di transito dei dati, ovvero tempo necessario a un dato messaggio per raggiungere la destinazione partendo dalla sorgente |
| **Tempo di risposta** | Tempo intercorrente tra il momento in cui si effettua una richiesta e il momento in cui arriva la risposta |
| **Throughput** | Quantità effettiva di dati spediti nell'unità di tempo (velocità) |

Le prestazioni dipendono anche da fattori **strutturali**, e non solo dalle misure stesse:
* **Numero di DTE** presenti sulla rete.
* **Tipologia dei mezzi trasmissivi** utilizzati.
* **Efficienza del software** che gestisce la comunicazione.

> [!NOTE] Ritardo e tempo di risposta
> Le due metriche misurano cose diverse: il **ritardo** è riferito al tempo di transito di un singolo messaggio, mentre il **tempo di risposta** è riferito all'intervallo fra una richiesta e la risposta ad essa corrispondente.

### 5.4 La Banda

La **banda** è la banda passante di frequenze che può essere utilizzata per la trasmissione di segnale attraverso un canale di comunicazione. Essendo collegata alla quantità d'informazione che può essere inviata tramite quel segnale nell'unità di tempo, può essere definita come la **massima velocità** alla quale è possibile trasmettere informazioni.

* **Broadband:** insieme di tecnologie che consentono di fornire all'utente collegamenti di velocità notevolmente superiore rispetto alla normale linea telefonica.
* **Digital divide:** in presenza di disparità tra zone che dispongono o meno di accesso alla banda larga.

## 6. Gli Strumenti di Valutazione della Velocità

### 6.1 Il Comando `ping`

Il comando **`ping`** indica se un host remoto può essere raggiunto. Può essere utilizzato anche per riportare statistiche sui pacchetti persi e sul tempo di spedizione: fa uso dell'*Echo message* del protocollo **ICMP** (*Internet Control Message Protocol*) per forzare un host remoto a rispedire indietro all'host locale un pacchetto a lui inviato.

> [!EXAMPLE] Ping verso un host raggiungibile
> 
> ```bash
> ping 141.250.5.2
> PING 141.250.5.2 (141.250.5.2): 56 data bytes
> 64 bytes from 141.250.5.2: icmp_seq=0 ttl=64 time=0.352 ms
> 64 bytes from 141.250.5.2: icmp_seq=1 ttl=64 time=0.474 ms
> ^C
> --- 141.250.5.2 ping statistics ---
> 2 packets transmitted, 2 packets received, 0% packet loss
> round-trip min/avg/max/stddev = 0.352/0.413/0.474/0.061 ms
> ```
> 
> Il comando riporta il tempo di trasmissione in millisecondi (ms) e si interrompe da solo, oppure con i tasti `Ctrl + c` o `Ctrl + z`.

Il comportamento del comando cambia in funzione dello stato dell'host di destinazione: se l'host è situato su una rete inesistente si ottiene un errore immediato, mentre se l'host esiste ma non risponde il pacchetto resta in attesa fino all'interruzione.

```bash
ping 26.40.0.17
sendto: Network is unreachable
```

```bash
ping 141.250.233.1
PING 141.250.233.1 (141.250.233.1): 56 data bytes
^C
--- 141.250.233.1 ping statistics ---
131 packets transmitted, 0 packets received, 100% packet loss
```

> [!IMPORTANT] I Due Parametri da Controllare nel Ping
> Riprendendo il ping che funziona, è necessario prestare attenzione a due parametri: il **Packet Loss** e il **Round Trip Time**.
> * **Packet Loss:** dovrebbe sempre essere pari a zero. In caso contrario ci potrebbe essere un problema alla connessione oppure, più probabilmente, che il sito contattato sia congestionato o, al limite, disconnesso dalla rete.
> * **Round Trip Time:** per una buona connessione Internet dovrebbe essere dell'ordine di qualche millisecondo. Se questo parametro assumesse valori a tre cifre, indicherebbe un problema della vostra connessione Internet o uno più generalizzato sulla rete.

### 6.2 Il Comando `traceroute`

Il comando **`traceroute`** (o **`tracert`**) dice quale instradamento prendono i pacchetti in uscita dal nostro sistema verso un sistema remoto. Mostra tutti i dispositivi di rete attraversati (nome e indirizzo tra parentesi) per arrivare a destinazione e dà l'idea della **"distanza"** (in termini di numero di dispositivi attraversati, *hops*) che ci separa da essa.

> [!EXAMPLE] Traceroute verso un host remoto
> 
> ```bash
> traceroute 141.250.1.3
> traceroute to 141.250.1.3 (141.250.1.3), 64 hops max, 40 byte packets
>  1  gw25.dipmat.unipg.it (141.250.25.3)   2.556 ms  3.264 ms  4.534 ms
>  2  141.250.115.77 (141.250.115.77)       4.220 ms  2.844 ms  2.996 ms
>  3  fe.r.unipg.it (141.250.253.1)         3.856 ms 17.168 ms  3.464 ms
>  4  sw-cs.r.unipg.it (141.250.253.21)     3.758 ms  2.281 ms  3.709 ms
> ```
> 
> Ogni riga corrisponde a un *hop*: il numero di righe fino a destinazione è il numero di dispositivi attraversati, e ciascun valore è il round trip verso quel dispositivo.

### 6.3 Speed Test

Per verificare la velocità effettiva della nostra connessione possiamo utilizzare il sito web **www.speedtest.net**.

> [!EXAMPLE] Come funziona Speed Test
> Sul territorio italiano sono sparsi vari **server di test**: ne viene scelto uno, il più vicino a noi, e si dà avvio alla prova. In un minuto si ottiene il risultato del test, con ping, velocità in download e in upload.
>
> Il server di test può essere scelto anche **automaticamente** in base al ping: per farlo basta cliccare su "Inizia Test" e sarà direttamente il sistema a scegliere il server migliore.
