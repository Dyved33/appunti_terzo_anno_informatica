# Fondamenti di networking, teoria della comunicazione e standard

## Convergenza telematica

Il settore delle reti di calcolatori e dei sistemi telematici è caratterizzato da una crescita pervasiva ed esponenziale. Questa continua evoluzione tecnologica è trainata dalla convergenza di molteplici fattori abilitanti:

- **Sviluppo delle Telecomunicazioni:** espansione delle infrastrutture ad altissima capacità trasmissiva (dorsali in fibra ottica ad altissima velocità, tecnologie wireless cellulari e satellitari).
- **Sviluppo delle Micro e Nano-tecnologie:** avanzamento continuo della miniaturizzazione dei semiconduttori, che permette di integrare elevate capacità computazionali e interfacce di rete in chip compatti a bassissimo consumo energetico.
- **Sensori ad Elevata Efficienza:** disponibilità di sensori sempre più miniaturizzati, affidabili ed economici, volano primario per l'Internet of Things (IoT), i sistemi embedded e il monitoraggio ambientale e industriale continuo.
- **Sviluppo di Soluzioni Software Avanzate:** ingegnerizzazione di stack protocollari altamente performanti, architetture a microservizi e soluzioni di virtualizzazione delle funzioni di rete (*Software-Defined Networking* - SDN).
- **Convergenza e Soluzioni Hardware/Software Integrate:**
  - Capacità di gestire e trasferire simultaneamente **dati numerici, flussi audio/voce e flussi video ad alta definizione**.
  - Requisito stringente di erogazione e sincronizzazione in **tempo reale (*real-time*)**, essenziale per videoconferenze, telemedicina e sistemi di controllo critici.

La transizione tecnologica ha segnato il superamento definitivo dei modelli centralizzati (fondati sui grandi mainframe con terminali passivi) a favore dei **sistemi di elaborazione distribuita**, sostenuti da tecnologie in grado di instradare volumi massivi di dati tramite segnali fisici a frequenze elevatissime.

## Il processo di comunicazione dati

L'infrastruttura globale consente a sistemi eterogenei di interagire e scambiare informazioni su qualsiasi scala geografica (da reti locali LAN fino all'interconnessione planetaria su scala WAN e Internet).

### La triade fondamentale della comunicazione
Un processo comunicativo si realizza unicamente in presenza di tre elementi costitutivi irrinunciabili:
1. **Sorgente dell'Informazione (*Source / Trasmettitore*):** il dispositivo che genera i dati da trasmettere (es. personal computer, telecamera IP, sensore IoT).
2. **Mezzo Trasmissivo (*Transmission Medium / Cammino Fisico*):** il supporto o percorso fisico lungo il quale si propaga il segnale (mezzi guidati come rame e fibra ottica, o mezzi non guidati come lo spazio libero tramite onde elettromagnetiche).
3. **Destinatario (*Destination / Ricevitore*):** il dispositivo a cui è destinato il flusso informativo e che acquisisce il segnale (es. server, workstation, attuatore).

```
┌──────────┐   Mezzo Trasmissivo (Canale Fisico)   ┌──────────────┐
│ Sorgente ├──────────────────────────────────────►│ Destinatario │
└──────────┘                                       └──────────────┘
```

### La definizione di comunicazione dati e il sistema di comunicazione
La **comunicazione dati** è lo scambio formale di informazioni tra due o più dispositivi realizzato attraverso un idoneo mezzo di trasmissione.

Affinché la comunicazione abbia luogo con successo, i singoli apparati devono integrarsi all'interno di un **sistema di comunicazione** coerente, strutturato in due componenti complementari:
- **Hardware:** le interfacce fisiche di rete (NIC - *Network Interface Card*), modem, amplificatori, antenne, commutatori (*switch*) e instradatori (*router*).
- **Software:** i driver di periferica, gli stack protocollari di sistema operativo (es. suite TCP/IP) e i programmi applicativi di rete.

## Teoria dell'informazione e il modello di Shannon-Weaver

### Definizioni fondamentali ed etimologia

> [!info] Definizioni di Informazione e Comunicazione
> * **Informazione:** L'insieme di dati, correlati e strutturati tra loro, attraverso cui un'idea, un concetto o un fatto assume forma intelligibile e può essere comunicato e compreso.
> * **Comunicazione:** Dal latino *cum* ("con", "insieme") e *munire* ("legare", "costruire"), e dal verbo *communico* ("mettere in comune", "rendere partecipe"). Indica il processo e l'insieme delle modalità attraverso cui un'informazione viene trasmessa da un soggetto a un altro (o da un luogo a un altro) tramite lo scambio di un messaggio codificato in accordo con un codice formale prestabilito.

### Il modello di Shannon-Weaver (1949)
Formulato originariamente da Claude Shannon dei Bell Laboratories e da Warren Weaver nel 1949, il modello descrive la trasmissione dell'informazione attraverso **7 elementi fondamentali**:

1. **Fonte / Sorgente (*Information Source*):** l'entità che concepisce e genera il messaggio originario.
2. **Codifica (*Encoding / Trasmettitore*):** l'operazione che converte il messaggio logico in segnali fisici (elettrici, ottici o radio) trasmissibili attraverso il canale.
3. **Messaggio:** la sequenza informativa strutturata prodotta dal processo di codifica.
4. **Mezzo Trasmissivo / Canale (*Channel*):** il mezzo fisico che sostiene la propagazione dei segnali.
5. **Rumore (*Noise Source*):** disturbi casuali, attenuazioni, dispersioni o interferenze esterne introdotte dal canale, suscettibili di degradare o alterare il segnale.
6. **Decodifica (*Decoding / Ricevitore*):** l'operazione inversa che ricostruisce il messaggio logico originario a partire dai segnali fisici ricevuti.
7. **Destinatario (*Destination*):** la persona o il sistema finale a cui è indirizzata l'informazione.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260925115804.png" width="450">
</div>

> [!info] Il Modello di Shannon-Weaver
> Rappresentazione bidirezionale e ciclica del processo comunicativo: la fonte codifica il messaggio per il canale (soggetto a rumore ed errori di trasmissione); il destinatario decodifica il messaggio e, attraverso un meccanismo di retroazione (*feedback*), può assumere il ruolo di sorgente invertendo il flusso della comunicazione.

## La trasmissione fisica del segnale

**Banda base e banda larga.** In banda base il segnale digitale modula direttamente il canale e il suo spettro comprende le frequenze da zero in su: il mezzo trasmette un solo segnale per volta e serve la linea come conduttore unico, quindi il costo resta basso ma la capacità è limitata dalla banda del mezzo. In banda larga il segnale digitale modula una **portante analogica** sinusoidale e può essere collocato in una banda di frequenze anche lontana da zero: lo stesso mezzo può allora trasportare più canali contemporaneamente, ciascuno nella propria banda, ed è questa la base delle trasmissioni modulate su radio, televisione e telefonia e delle reti via cavo e in fibra ottica.

**Il teorema di Nyquist-Shannon.** La velocità di trasmissione è limitata da due fattori indipendenti: il **teorema di Nyquist** fissa il massimo numero di simboli trasmissibili al secondo in una banda di larghezza $B$, e con $M$ livelli di ampiezza la velocità è $2B \log_2 M$; il **teorema di Shannon** fissa il limite dovuto al rumore, $C = B \log_2 (1 + S/N)$ con $S/N$ il rapporto segnale/rumore, in bit al secondo.

**Campionamento e quantizzazione.** Per trasformare un segnale analogico in numeri si campiona il segnale a una frequenza almeno doppia della sua frequenza massima (criterio di Nyquist), si quantizza ogni campione in uno dei $2^b$ livelli di un quantizzatore a $b$ bit e infine si codificano i livelli in bit. La quantizzazione introduce un errore tanto più piccolo quanti più bit si usano, a fronte di una velocità in bit proporzionale a $b$.

**Multiplexing.** Su un singolo mezzo ad alta capacità si trasmettono più comunicazioni indipendenti dividendone la capacità:

- **FDM** (*frequency division multiplexing*) divide la banda in sottobande, una per canale, ciascuna con la propria portante e la propria guardia;
- **TDM** (*time division multiplexing*) divide il tempo in slot, assegnando un slot a ogni canale in modo ciclico;
- **WDM** (*wavelength division multiplexing*) è un FDM delle fibre ottiche, dove le sottobande sono diverse lunghezze d'onda, separate con filtri ottici;
- **CDM** (*code division multiplexing*) assegna a ogni canale una sequenza di codice e i segnali viaggiano contemporaneamente, separati al ricevitore tramite correlazione.

> [!warning] Perché il multiplexing
> Senza multiplexing ogni terminale dovrebbe avere un collegamento fisico dedicato con ogni altro terminale: servirebbero $n(n-1)/2$ circuiti su $n$ nodi. Il multiplexing trasforma invece un unico canale ad alta velocità in molti canali logici indipendenti, ed è la ragione per cui una rete locale con una sola fibra può servire migliaia di utenti.

## La commutazione

Il **commutatore** (*switch*, livello 2) e l'**instradatore** (*router*, livello 3) sono i due apparati che instradano il traffico, e la scelta fra hub, switch e router è una scelta di livello:

| Apparato | Livello | Decide in base a | Comportamento |
| :--- | :--- | :--- | :--- |
| **Hub** | 1 | nulla | ripete il segnale su tutte le porte; ogni host vede tutto il traffico e nascono collisioni |
| **Bridge e switch** | 2 | indirizzo MAC | inoltra il frame solo sulla porta della destinazione, mantenendo una tabella di inoltro appresa dal traffico |
| **Router** | 3 | indirizzo IP | inoltra il pacchetto fra reti diverse scegliendo il percorso e segmentando il dominio di collisione |
| **Gateway** | 3+ | regole applicative | traduce fra protocolli o applicazioni diversi |

Lo **switching** può essere *store-and-forward*, che memorizza l'intero frame prima di inoltrarlo e ne verifica il CRC, oppure *cut-through*, che inoltra appena legge l'indirizzo di destinazione, con latenza minore ma senza protezione contro i frame corrotti.

## La gerarchia della conoscenza: la piramide DIKW

La gestione e la trasformazione delle informazioni nei sistemi telematici e decisionali è formalizzata nel modello gerarchico **DIKW** (*Data, Information, Knowledge, Wisdom*):

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260925115953.png" width="450">
</div>

> [!info] La Piramide DIKW
> Struttura gerarchica dell'elaborazione conoscitiva: dai dati grezzi alla base fino alla saggezza apicale. Evidenzia la transizione continua tra le dimensioni empiriche di elevato volume e oggettività alla base, verso contesti di alto valore aggiunto, struttura e soggettività al vertice.

La piramide articola la conoscenza in quattro stadi ascendenti:

1. **Dati (*Data*):**
   - Elementi grezzi, simboli non contestualizzati, misurazioni o segnali binari privi di significato intrinseco (es. il valore `25`, la stringa `10101`).
   - *Proprietà:* massimi livelli di **oggettività**, **volume** e **completezza**, ma utilità operativa nulla in assenza di un contesto interpretativo.
2. **Informazione (*Information*):**
   - Dati organizzati, correlati e contestualizzati, a cui viene associato un significato semantico ben preciso.
   - Risponde alle interrogazioni empiriche: *chi?*, *cosa?*, *dove?*, *quando?*
   - *Esempio:* `"La temperatura registrata nella sala server alle 11:59 è di 25°C"`.
3. **Conoscenza (*Knowledge*):**
   - Comprensione contestuale derivata dall'assimilazione, dall'integrazione e dal confronto di informazioni mediante esperienza, regole inferenziali e modelli cognitivi.
   - Risponde alla domanda: *come?*
   - *Esempio:* `"Una temperatura costante di 25°C nella sala server supera la soglia raccomandata e rischia di innescare il thermal throttling delle CPU"`.
4. **Saggezza (*Wisdom*):**
   - Livello apicale della gerarchia: integra la conoscenza con il giudizio critico, la visione a lungo termine e le decisioni strategiche.
   - Risponde alla domanda: *perché?*
   - *Esempio:* Progettare una riconfigurazione dell'impianto di climatizzazione e delle policy di carico computazionale per garantire la continuità operativa ottimizzando al contempo l'impatto energetico complessivo.

| Livello della Piramide | Caratteristiche Distintive | Funzione nel Sistema Informativo |
| :--- | :--- | :--- |
| **Vertice: Saggezza e Conoscenza** | Soggettività, Alto Valore Aggiunto, Sintesi, Struttura | Supporto alle decisioni strategiche e comprensione di sistema |
| **Base: Informazione e Dati** | Oggettività, Elevato Volume, Completezza, Misurabilità | Rilevazione sensoriale, codifica, memorizzazione e trasporto di rete |

## I protocolli di rete e gli standard internazionali

### Il concetto di protocollo
<u>Un **protocollo di rete** è un insieme formale di regole, formati e convenzioni condivise che stabiliscono le modalità con cui due o più entità devono comunicare.</u>

Un protocollo specifica in modo deterministico:
- **Cosa si scambia (Sintassi e Semantica):**
  - *Sintassi:* la struttura del pacchetto, la disposizione dei bit e dei campi (header, payload, checksum) e i formati di codifica.
  - *Semantica:* il significato associato a ciascun pattern di bit o campo di controllo e le azioni da intraprendere alla ricezione di ciascun comando.
- **Come avviene lo scambio (Temporizzazione / *Timing*):**
  - La sincronizzazione temporale, l'ordine sequenziale dei messaggi e i meccanismi di regolazione della velocità trasmissiva (*flow control*).

> [!important] Necessità Ineludibile del Protocollo
> Due o più dispositivi possono essere fisicamente e correttamente collegati tramite cavi o onde radio, ma in assenza di un protocollo comune **non sono assolutamente in grado di comunicare**. Senza regole condivise, i segnali elettrici o ottici ricevuti risultano indecifrabili, analogamente a due individui collegati tramite una linea telefonica impeccabile che parlino due lingue del tutto sconosciute l'uno all'altro.

### Gli enti di standardizzazione internazionale
Affinché apparati realizzati da produttori indipendenti e basati su architetture differenti possano interoperare senza frizioni su scala mondiale, i protocolli devono essere formalizzati come standard aperti e condivisi.

I principali organismi internazionali responsabili della definizione degli standard telematici e delle reti sono:

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260925120233.png" width="180">
</div>

- **ISO (*International Organization for Standardization*):**
  - La più grande organizzazione mondiale indipendente e non governativa per la standardizzazione tecnica.
  - Sviluppa norme in molteplici settori industriali, svolgendo un ruolo cardine nel networking grazie alla definizione del modello di riferimento **ISO/OSI (*Open Systems Interconnection*)** e alle normative internazionali per la sicurezza informatica (es. serie ISO/IEC 27000).

<div style="display: flex; justify-content: center;">
  <img src="standard_organizations.png" width="500">
</div>
- **IEEE-SA (*Institute of Electrical and Electronics Engineers - Standards Association*):**
  - Organizzazione leader nella standardizzazione dei livelli fisici e di accesso al mezzo (sottolivelli PHY e MAC).
  - Responsabile della celebre famiglia di standard **IEEE 802** (es. **IEEE 802.3** per Ethernet cablata, **IEEE 802.11** per il Wi-Fi, **IEEE 802.15** per WPAN/Bluetooth/Zigbee).
- **IETF (*Internet Engineering Task Force*):**
  - Comunità internazionale aperta di ingegneri, progettisti e ricercatori incaricata dello sviluppo e dell'evoluzione dell'architettura e dei protocolli della suite Internet.
  - Gli standard IETF vengono formalizzati attraverso i documenti ufficiali denominati **RFC (*Request for Comments*)**, che regolamentano protocolli fondamentali quali IP, TCP, UDP, DNS, HTTP, BGP e TLS.
- **ITU (*International Telecommunication Union*, ex CCITT):**
  - Agenzia specializzata delle Nazioni Unite (ONU) per le tecnologie dell'informazione e della comunicazione.
  - Il settore **ITU-T** definisce standard globali per le telecomunicazioni, la telefonia, le reti a banda larga e le infrastrutture di trasporto ottico.
- **ICANN (*Internet Corporation for Assigned Names and Numbers*):**
  - Ente no-profit responsabile del coordinamento globale degli identificatori univoci di Internet.
  - Assegna e gestisce lo spazio degli **indirizzi IP** (attraverso la funzione IANA) e coordina il sistema dei nomi di dominio (**DNS**), inclusa la gestione della radice (*Root Zone*) e dei domini di primo livello (*TLD - Top-Level Domains*, sia generici gTLD che nazionali ccTLD).
- **W3C (*World Wide Web Consortium*):**
  - Consorzio internazionale guidato storicamente da Tim Berners-Lee per lo sviluppo degli standard aperti del World Wide Web.
  - Definisce le specifiche di linguaggi e tecnologie web quali **HTML5**, **CSS**, **XML**, standard di accessibilità (**WAI/WCAG**) e linee guida per il Web Semantico.

## Modelli architetturali di riferimento: ISO/OSI e TCP/IP

### I principi dell'architettura a livelli
I moderni sistemi di telecomunicazione adottano un'**architettura modulare a livelli (*layered architecture*)**, strutturata secondo principi cardine dell'ingegneria del software:
- **Astrazione e Separazione degli Interessi (*Separation of Concerns*):** ogni livello (*layer*) risolve un sottoinsieme specifico di problematiche comunicative, offrendo servizi ben definiti al livello superiore e nascondendo i dettagli implementativi sottostanti.
- **Incapsulamento:** ogni livello riceve dati dal livello superiore, aggiunge la propria informazione di controllo sotto forma di intestazione (*header*) o coda (*trailer*), generando la specifica unità di dati di protocollo.
- **Interoperabilità e Flessibilità:** la modifica interna di un protocollo ad un determinato livello non impatta i livelli adiacenti, purché le interfacce di comunicazione rimangano inalterate.

### La struttura dei livelli: host e apparati intermedi
I livelli architetturali si dividono in due macro-categorie funzionali:

1. **Host Layers (Livelli Host / End-to-End / Software):**
   - Operano **esclusivamente sui sistemi terminali (*End Systems / Hosts*)**.
   - Sono implementati a livello software nel sistema operativo e nelle applicazioni utente, indipendentemente dal mezzo fisico sottostante.
   - Gestiscono l'interazione con l'utente, la rappresentazione dei formati, il controllo di sessione e l'affidabilità del trasporto da estremo a estremo (*end-to-end*).
2. **Media Layers (Livelli Media / Subnet / Hardware-Network):**
   - Governano il trasferimento effettivo delle informazioni attraverso i canali trasmissivi e gli apparati intermedi di rete (router, switch).
   - Risolvono l'indirizzamento logico, l'instradamento (*routing*), l'indirizzamento fisico (*MAC*), l'accesso al mezzo e la modulazione/trasmissione dei segnali.

### La PDU di ogni livello
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

### Il confronto fra ISO/OSI e TCP/IP

<div style="display: flex; justify-content: center;">
  <img src="iso_osi_vs_tcp_ip.png" width="450">
</div>

**Il livello fisico:**
- **Funzione:** Trasmissione di bit grezzi non strutturati lungo il canale di comunicazione.
- **Competenze:** Specifiche elettriche, ottiche, meccaniche e funzionali; livelli di tensione; durata dei bit; modulazione e codifica del segnale; connettori e cavi fisici.
- **TCP/IP:** Integrato all'interno del *Network Access Layer*.

**Il livello collegamento dati:**
- **Funzione:** Trasferimento affidabile e privo di errori di trame (*frame*) tra due nodi direttamente adiacenti sullo stesso canale fisico.
- **Competenze:**
  - **Indirizzamento Fisico:** gestione del *MAC Address*.
  - **Controllo di Flusso e di Errore:** rilevamento (es. CRC / FCS) e correzione/ritrasmissione su singolo link.
  - **Sottolivelli:** diviso storicamente dallo standard IEEE in **LLC (*Logical Link Control*)** e **MAC (*Medium Access Control*)**.
- **TCP/IP:** Integrato all'interno del *Network Access Layer*.

**Il livello di rete:**
- **Funzione:** Determinazione del cammino (*routing / path determination*) e instradamento dei pacchetti attraverso reti eterogenee interconnesse (*Internetworking*).
- **Competenze:** Indirizzamento logico gerarchico (indirizzi IPv4 e IPv6), tabelle di instradamento, gestione della frammentazione dei pacchetti e controllo della congestione a livello di subnet.
- **TCP/IP:** Corrisponde al livello **Internet Layer** (protocolli IP, ICMP, ARP).

**Il livello di trasporto:**
- **Funzione:** Consegna trasparente, ordinata e affidabile dei dati da processo applicativo a processo applicativo (*End-to-End communication*).
- **Competenze:** Multiplexing e demultiplexing tramite numeri di porta (*ports*), instaurazione/chiusura connessione, controllo di flusso end-to-end, rilevamento errori con ritrasmissioni e controllo di congestione.
- **TCP/IP:** Corrisponde al livello **Transport Layer** (protocolli TCP per trasporto affidabile orientato alla connessione, UDP per trasporto non affidabile e privo di connessione).

**Il livello di sessione:**
- **Funzione:** Instaurazione, gestione, sincronizzazione e terminazione delle sessioni di dialogo tra applicazioni remote.
- **Competenze:** Gestione dei turni di dialogo (*half-duplex* o *full-duplex*) e inserimento di punti di sincronizzazione (*checkpoints*) per riprendere il trasferimento dati a seguito di interruzioni.
- **TCP/IP:** Le sue funzioni sono integrate direttamente nel livello **Application**.

**Il livello di presentazione:**
- **Funzione:** Rappresentazione sintattica e semantica dei dati trasferiti tra sistemi eterogenei.
- **Competenze:** Conversione e normalizzazione dei formati (es. codifiche caratteri UTF-8, ASCII), crittografia/decifratura per la riservatezza e compressione dei dati.
- **TCP/IP:** Le sue funzioni sono integrate direttamente nel livello **Application**.

**Il livello di applicazione:**
- **Funzione:** Fornire un'interfaccia di comunicazione diretta ai processi e ai programmi software utilizzati dall'utente.
- **Competenze:** Protocolli applicativi di rete specializzati (es. HTTP/HTTPS per il web, DNS per la risoluzione dei nomi, SMTP/IMAP per la posta elettronica, SSH per l'accesso remoto sicuro).
- **TCP/IP:** Corrisponde al livello **Application Layer** (raggruppa le funzioni dei livelli 5, 6 e 7 di OSI).

## Comunicazione end-to-end e inoltro di rete

<div style="display: flex; justify-content: center;">
  <img src="iso_osi_host_communication.png" width="480">
</div>

> [!info] Principio di Inoltro a Livello di Rete
> *"Network layer protocols forward encapsulated Transport Layer PDUs between hosts"*
> I protocolli del livello di trasporto (e dei livelli superiori) operano esclusivamente da estremo a estremo (**End-to-End**) tra i due host terminali. I protocolli del livello di rete inoltrano i pacchetti che incapsulano le PDU di trasporto attraversando la nuvola di rete mediante apparati intermedi di instradamento (**Hop-by-Hop**).

### Il confronto fra nodi terminali e nodi intermedi
1. **End Systems (Hosts Terminali - Sorgente e Destinazione):**
   - Implementano lo **stack completo a 7 livelli** (o tutti i 4 livelli TCP/IP).
   - Sul nodo sorgente, il messaggio applicativo discende l'intero stack subendo il processo di **incapsulamento progressivo** fino al livello fisico.
   - Sul nodo destinatario, il flusso di bit risale lo stack subendo il processo inverso di **decapsulamento** fino al recapito all'applicazione.
2. **Intermediate Systems (Nodi Intermedi / Nodi di Rete / Routers):**
   - Appartengono alla sottorete di comunicazione (*cloud di rete*).
   - Implementano unicamente i **primi 3 livelli inferiori (*Media Layers*)**:
     - **Livello 1 (Fisico):** riceve e trasmette i segnali e la sequenza di bit grezzi dai collegamenti fisici.
     - **Livello 2 (Data Link):** acquisisce la trama, verifica l'integrità (CRC) e decapsula il pacchetto di rete rimuovendo header e trailer di livello 2.
     - **Livello 3 (Network):** esamina l'indirizzo IP di destinazione nell'header del pacchetto, consulta la propria tabella di instradamento (*routing table*), seleziona l'interfaccia di uscita ottimale (*forwarding*) e re-incapsula il pacchetto in una nuova trama di livello 2 adatta al link successivo.
   - I nodi intermedi sono **del tutto trasparenti rispetto ai livelli 4-7**: non ispezionano né modificano i dati di trasporto o di applicazione, garantendo la netta separazione tra il trasporto dati dell'utente e l'infrastruttura di instradamento.

> [!info] Sintesi:
> - I fattori della convergenza telematica sono telecomunicazioni, micro e nano-tecnologie, sensori, software avanzato e integrazione hardware e software in tempo reale.
> - La comunicazione dati è lo scambio formale di informazioni: servono sorgente, mezzo trasmissivo e destinatario, più un sistema di comunicazione coerente.
> - Shannon-Weaver descrive la trasmissione con sette elementi, dal messaggio al destinatario, con il rumore come perturbazione e il feedback che chiude il ciclo; i limiti di velocità sono dati da Nyquist e da Shannon, e FDM, TDM, WDM e CDM multiplexano più canali su un solo mezzo.
> - Un protocollo specifica sintassi, semantica e temporizzazione; standardizzarli per l'interoperabilità è compito di ISO, IEEE, IETF, ITU, ICANN e W3C.
> - Ogni livello ha una PDU propria: data, segmento, pacchetto, trama, bit; ISO/OSI ha sette livelli, TCP/IP quattro, con i livelli 5 e 6 di OSI confluiti nell'application layer.
> - Solo gli host eseguono lo stack completo: i router stanno sotto il livello di rete e inoltrano i pacchetti salto a salto senza toccare i dati di trasporto.
