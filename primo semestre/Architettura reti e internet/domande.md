## 1. TCP -- Sequence Number

Nel protocollo **TCP**, il **Sequence Number** (numero di sequenza) è un campo a **32 bit** presente nell'intestazione di ogni segmento che indica la posizione del **primo byte dei dati** (payload) all'interno del flusso di byte complessivo inviato da un host. ⁠

Le sue funzioni principali sono:

- **Ordinamento dei dati**: Poiché i pacchetti possono arrivare fuori ordine o per percorsi diversi, il ricevente utilizza il Sequence Number per **reassemblare il flusso originale** nella corretta sequenza. ⁠
- **Rilevamento perdite e duplicati**: Permette di identificare i segmenti mancanti (richiedendo ritrasmissioni) e di scartare i pacchetti duplicati. ⁠
- **Controllo del flusso**: Definisce i confini della **finestra scorrevole**, aiutando a gestire la quantità di dati che il mittente può inviare prima di ricevere un riconoscimento. ⁠

Il valore iniziale, chiamato **Initial Sequence Number (ISN)**, è scelto in modo **casuale** all'avvio della connessione per motivi di sicurezza (prevenire attacchi di hijacking) e non parte da zero. ⁠ Ogni volta che viene inviato un segmento, il Sequence Number viene incrementato del numero di byte di dati contenuti in quel segmento.

### E l'ACK Number?

L'ACK (Acknowledgment Number) indica il numero del prossimo byte che il
destinatario si aspetta di ricevere.

Ad esempio:

-   Ricevo correttamente i byte da 1000 a 1499.
-   Invio ACK = 1500.

Questo significa: «Ho ricevuto tutto fino al byte 1499 e mi aspetto il
byte 1500».

**Attenzione:** durante il three-way handshake, SYN consuma un numero di
sequenza. Per questo il primo byte di dati generalmente parte da ISN +
1, dove ISN è l'Initial Sequence Number.

------------------------------------------------------------------------

## 2. Routing Table -- Come raggiunge reti distanti un router?

Un router non conosce necessariamente il percorso completo per
raggiungere ogni singolo dispositivo della rete mondiale. Conosce invece
le reti raggiungibili e il prossimo router a cui inoltrare i pacchetti.

Questo è il concetto di **Next Hop**.

### Cosa contiene una Routing Table?

Una routing table contiene generalmente:

  Informazione           Significato
  ---------------------- -------------------------------------
  Destination Network    Rete di destinazione
  Subnet Mask / Prefix   Identifica la dimensione della rete
  Next Hop               Indirizzo del router successivo
  Interface              Interfaccia da utilizzare
  Metric                 Costo del percorso

Esempio semplificato:

  Destinazione     Next Hop      Interfaccia
  ---------------- ------------- -------------
  192.168.1.0/24   Diretta       eth0
  10.0.0.0/8       192.168.1.2   eth0
  172.16.0.0/16    192.168.1.3   eth1
  0.0.0.0/0        192.168.1.1   eth0

### Come prende una decisione?

Immaginiamo che un pacchetto debba raggiungere un host con IP
`10.20.30.40`.

1.  Il router esamina l'indirizzo IP di destinazione.
2.  Confronta l'indirizzo con le reti presenti nella routing table.
3.  Individua la rotta più specifica compatibile, utilizzando il
    criterio del **Longest Prefix Match**.
4.  Inoltra il pacchetto verso il Next Hop indicato.

Il router successivo ripeterà lo stesso procedimento.

``` mermaid
flowchart LR
    A[Host sorgente] --> R1[Router 1]
    R1 --> R2[Router 2]
    R2 --> R3[Router 3]
    R3 --> B[Host destinazione]
```

### Fino a che distanza si spinge?

Non esiste una distanza geografica massima definita dalla routing table.

Il router può raggiungere anche reti dall'altra parte del mondo, purché
abbia una rotta valida per raggiungerle.

La conoscenza delle rotte può derivare da:

-   **Rotte statiche:** inserite manualmente dall'amministratore.
-   **Rotte dinamiche:** apprese tramite protocolli di routing, come
    RIP, OSPF e BGP.
-   **Default route:** utilizzata quando non esiste una rotta più
    specifica.

La default route IPv4 è `0.0.0.0/0` e rappresenta una destinazione
generica: tutto ciò per cui non esiste una rotta più specifica viene
inoltrato verso il gateway predefinito.

**Da ricordare:** Internet funziona proprio grazie all'inoltro
hop-by-hop. Ogni router deve conoscere soltanto il prossimo passo, non
necessariamente l'intero percorso.

------------------------------------------------------------------------

## 3. FTP -- Modalità attiva e passiva

FTP (File Transfer Protocol) è un protocollo applicativo utilizzato per
trasferire file tra client e server.

Utilizza due connessioni TCP distinte:

-   **Control connection:** per i comandi e le risposte.
-   **Data connection:** per trasferire i file o visualizzare il
    contenuto delle directory.

La porta TCP 21 viene utilizzata per la connessione di controllo.

La differenza tra modalità attiva e passiva riguarda principalmente
**chi inizia la connessione dati**.

### Modalità attiva (Active FTP)

1.  Il client apre una connessione TCP verso la porta 21 del server.
2.  Il client comunica al server su quale porta vuole ricevere i dati,
    tramite il comando PORT.
3.  Il server apre una connessione TCP verso il client.
4.  La connessione dati parte dal server, tradizionalmente dalla porta
    20.

**Problema:** se il client è dietro un firewall o NAT, potrebbe non
accettare la connessione in ingresso proveniente dal server.

``` mermaid
sequenceDiagram
    participant C as Client
    participant S as Server FTP
    C->>S: Connessione di controllo (porta 21)
    C->>S: PORT (comunica la porta dati del client)
    S->>C: Connessione dati (tradizionalmente porta sorgente 20)
```

### Modalità passiva (Passive FTP)

1.  Il client apre una connessione TCP verso la porta 21 del server.
2.  Il client invia il comando PASV.
3.  Il server comunica una porta TCP su cui è in ascolto.
4.  Il client apre una seconda connessione TCP verso quella porta del
    server.

**Vantaggio:** entrambe le connessioni vengono iniziate dal client,
rendendo questa modalità più compatibile con firewall e NAT.

``` mermaid
sequenceDiagram
    participant C as Client
    participant S as Server FTP
    C->>S: Connessione di controllo (porta 21)
    C->>S: PASV
    S-->>C: Comunica la porta dati in ascolto
    C->>S: Connessione dati verso la porta comunicata
```

  Caratteristica                  Attiva                Passiva
  ------------------------------- --------------------- -----------------------
  Connessione di controllo        Client → Server       Client → Server
  Chi apre la connessione dati?   Server                Client
  Porta dati server               Tradizionalmente 20   Porta dinamica
  Compatibilità con NAT           Più problematica      Generalmente migliore

**Da ricordare per l'esonero:** nella modalità attiva il server apre la
connessione dati; nella passiva la apre il client.

------------------------------------------------------------------------

## 4. DNS -- Cosa restituisce un server DNS?

Il DNS (Domain Name System) è un sistema distribuito e gerarchico che
permette di tradurre i nomi di dominio in informazioni utilizzabili
dalla rete.

Ad esempio, permette di trovare l'indirizzo IP associato a
`www.google.com`.

Il server DNS restituisce una risposta contenente uno o più **Resource
Record (RR)**.

I principali tipi sono:

  Record   Informazione restituita
  -------- -------------------------------
  A        Indirizzo IPv4
  AAAA     Indirizzo IPv6
  CNAME    Nome canonico (alias)
  MX       Server di posta elettronica
  NS       Server DNS autoritativi
  PTR      Risoluzione inversa IP → nome
  TXT      Informazioni testuali

### Ricerca ricorsiva

Quando un client vuole risolvere un nome di dominio, normalmente
interroga un DNS resolver configurato sul proprio dispositivo.

La ricerca ricorsiva funziona così:

``` mermaid
sequenceDiagram
    participant C as Client
    participant R as Resolver ricorsivo
    participant Root as Root DNS
    participant TLD as DNS TLD (.com)
    participant Auth as DNS autoritativo
    C->>R: Indirizzo di www.example.com?
    R->>Root: Cerca www.example.com
    Root-->>R: Riferimento al DNS .com
    R->>TLD: Cerca example.com
    TLD-->>R: Riferimento al DNS autoritativo
    R->>Auth: Cerca www.example.com
    Auth-->>R: Record DNS (es. indirizzo IP)
    R-->>C: Risposta finale
```

1.  Il client chiede al resolver l'indirizzo IP di `www.example.com`.
2.  Il resolver interroga un Root DNS Server.
3.  Il Root indica a quale server TLD rivolgersi (ad esempio `.com`).
4.  Il server TLD indica il server DNS autoritativo per `example.com`.
5.  Il resolver interroga il server autoritativo.
6.  Ottiene l'indirizzo IP e lo restituisce al client.

Il resolver può memorizzare la risposta nella propria cache per un
determinato periodo (TTL).

### Attenzione: ricorsiva vs iterativa

-   **Ricorsiva:** il server interrogato deve fornire la risposta finale
    oppure un errore. È il comportamento tipico del resolver nei
    confronti del client.
-   **Iterativa:** il server interrogato può restituire un riferimento a
    un altro server DNS da contattare. È il comportamento tipico nelle
    interrogazioni tra resolver e server DNS gerarchici.

**Possibile domanda:** il client deve conoscere tutti i server DNS della
gerarchia?

No. Il client conosce generalmente soltanto il proprio resolver DNS. È
quest'ultimo a occuparsi delle interrogazioni successive.

------------------------------------------------------------------------

## 5. Configurazione resolver client

Se è questo l'argomento, si riferisce a come un dispositivo viene
configurato per utilizzare un server DNS.

In Linux, ad esempio, la configurazione può essere gestita attraverso
`/etc/resolv.conf`.

Un esempio:

``` text
nameserver 8.8.8.8
nameserver 1.1.1.1
```

-   `8.8.8.8`: DNS pubblico di Google.
-   `1.1.1.1`: DNS pubblico di Cloudflare.

Quando un'applicazione deve risolvere un nome di dominio, il resolver
locale utilizza i server DNS configurati.

------------------------------------------------------------------------

## 6. IPv6 -- Indirizzi Unicast

In IPv6 esistono diverse categorie di indirizzi:

-   **Unicast:** identifica una singola interfaccia di rete. Il
    pacchetto viene consegnato a quella specifica interfaccia.
-   **Multicast:** identifica un gruppo di interfacce. Il pacchetto
    viene consegnato a tutte le interfacce appartenenti al gruppo.
-   **Anycast:** identifica più interfacce, ma il pacchetto viene
    consegnato a una sola di esse, generalmente quella topologicamente
    più vicina.

IPv6 non utilizza broadcast: questa funzionalità viene sostituita dal
multicast.

### Tipologie di indirizzi Unicast

  -----------------------------------------------------------------------
  Tipo                    Prefisso                Utilizzo
  ----------------------- ----------------------- -----------------------
  Global Unicast          `2000::/3`              Indirizzi pubblici e
                                                  instradabili su
                                                  Internet

  Link-Local              `FE80::/10`             Comunicazione
                                                  all'interno del
                                                  collegamento locale

  Unique Local            `FC00::/7`              Comunicazione privata,
                                                  simile agli indirizzi
                                                  IPv4 privati

  Loopback                `::1/128`               Identifica il
                                                  dispositivo stesso

  Unspecified             `::/128`                Indirizzo non
                                                  specificato
  -----------------------------------------------------------------------

**Approfondiamo i più importanti:**

-   Global Unicast: equivalenti, per funzione, agli indirizzi IPv4
    pubblici.
-   Link-Local: vengono utilizzati per comunicazioni all'interno della
    rete locale. Non vengono instradati dai router.
-   Unique Local: indirizzi privati utilizzabili nelle reti locali e non
    instradabili su Internet.

Un indirizzo IPv6 è composto da 128 bit, rappresentati normalmente
attraverso otto gruppi esadecimali.

Esempio:

``` text
2001:0db8:0000:0000:0000:ff00:0042:8329
```

È possibile abbreviare gli indirizzi eliminando gli zeri iniziali dei
gruppi e sostituendo una sequenza di gruppi a zero con `::` (una sola
volta per indirizzo).

------------------------------------------------------------------------

## 7. SLAAC -- Stateless Address Autoconfiguration

SLAAC è un meccanismo IPv6 che permette a un host di configurare
autonomamente il proprio indirizzo IP, senza necessariamente utilizzare
un server DHCPv6.

SLAAC significa *Stateless Address Autoconfiguration*.

### Come funziona?

Il processo avviene principalmente attraverso questi passaggi:

**1. Creazione dell'indirizzo Link-Local**

Quando un dispositivo si collega alla rete, genera autonomamente un
indirizzo IPv6 Link-Local (`FE80::/10`).

**2. Router Solicitation (RS)**

L'host può inviare un messaggio Router Solicitation per chiedere ai
router presenti nella rete le informazioni necessarie alla
configurazione.

**3. Router Advertisement (RA)**

Il router risponde con un messaggio Router Advertisement, che contiene
informazioni come:

-   Prefisso IPv6 della rete.
-   Lunghezza del prefisso.
-   Informazioni sui parametri di configurazione.
-   Informazioni sul router predefinito.

**4. Generazione dell'indirizzo Global Unicast**

L'host combina il prefisso ricevuto dal router con un identificatore
dell'interfaccia, ottenendo un indirizzo IPv6.

Ad esempio:

``` text
Prefisso ricevuto:       2001:db8:1234:5678::/64
Identificatore host:     0000:0000:0000:abcd
Indirizzo risultante:    2001:db8:1234:5678::abcd
```

L'identificatore può essere generato in diversi modi, anche casualmente
per motivi di privacy.

**5. Verifica dell'indirizzo**

L'host esegue la Duplicate Address Detection (DAD), per verificare che
l'indirizzo scelto non sia già utilizzato da un altro dispositivo sul
collegamento.

``` mermaid
sequenceDiagram
    participant H as Host IPv6
    participant R as Router
    H->>H: Genera indirizzo Link-Local
    H->>R: Router Solicitation (RS)
    R-->>H: Router Advertisement (RA) con prefisso
    H->>H: Forma indirizzo IPv6
    H->>H: Duplicate Address Detection (DAD)
    Note over H: Indirizzo pronto all'uso se non duplicato
```

### SLAAC vs DHCPv6

  -----------------------------------------------------------------------
  SLAAC                               DHCPv6
  ----------------------------------- -----------------------------------
  Configurazione autonoma             Configurazione tramite server

  Riceve il prefisso dai Router       Riceve informazioni dal server
  Advertisement                       DHCPv6

  Non richiede necessariamente un     Richiede un server DHCPv6
  server DHCPv6                       

  Può configurare autonomamente       Può assegnare indirizzi e altre
  l'indirizzo                         informazioni
 
  -----------------------------------------------------------------------

Attenzione: SLAAC e DHCPv6 possono anche coesistere. Inoltre, SLAAC non
significa necessariamente assenza di DNS: le informazioni DNS possono
essere distribuite attraverso i Router Advertisement (RDNSS) oppure
DHCPv6.


---

## Flashcard
1.  Secondo il teorema di Nyquist, qual è la massima velocità di trasmissione teorica (in bps) in un canale privo di rumore con banda di larghezza B e M livelli di ampiezza?  $2Blog_{2}​M$, con B banda passante (intervallo di frequenze in Hertz che il canale è in grado di trasportare) e M i livelli di ampiezza del segnale (livelli discreti di tensione che il segnale può assumere per codificare i dati)
2.  Qual è la formula del teorema di Shannon per la capacità massima C di un canale soggetto a rumore in bit al secondo?  $C=Blog_{2}​(1+S/N)$, dove B è la larghezza di banda e S/N è il rapporto segnale/rumore.
3. Qual è la differenza fondamentale tra la trasmissione in banda base e la trasmissione in banda larga? La trasmissione in banda base è caratterizzata da un segnale digitale, mentre in banda larga il segnale modula una portante analogica sinusoidale (per avere diverse bande di frequenza traslate e consentire multiplexing di più canali)
4. In cosa differisce il Wavelength Division Multiplexing (WDM) dal classico Frequency Division Multiplexing (FDM)? WDM è una forma di FDM specifica per fibre ottiche in cui le sottobande corrispondono a diverse lunghezze d'onda separate mediante filtri ottici.
5. Su quali livelli del modello OSI operano rispettivamente uno switch di livello 2 e un router di livello 3, e su quali indirizzi basano l'inoltro? Lo switch è un apparecchio che opera al livello 2 (data link) del modello OSI, mentre il router è sul livello 3 (network). Basano l'inoltro sugli indirizzi IP
6. Qual è il trade-off prestazionale e di affidabilità tra lo switching store-and-forward e il cut-through? Lo store-and-forward offre protezione contro i frame corrotti verificando il CRC a scapito di una latenza maggiore; il cut-through riduce la latenza inoltrando il frame appena legge l'indirizzo MAC di destinazione, senza verificare il CRC.
7. Nella piramide DIKW, a quale domanda risponde il livello di 'Conoscenza' (Knowledge) e da cosa si differenzia dal livello 'Informazione'? Il livello di informazione è caratterizzato dalla contestualizzazione dei dati grezzi, mentre il livello di conoscenza si chiede la correlazione tra i dati 
8. Quali sono i 7 elementi fondamentali del modello di comunicazione di Shannon-Weaver (1949)? Sorgente -> codifica  -> messaggio -> mezzo di trasmissione -> rumore -> decodifica -> destinatario
9. Qual è l'ambito di competenza principale dell'organismo di standardizzazione IEEE-SA nell'architettura delle reti? Definisce gli standard dei livelli fisici e di accesso al mezzo
10. Nel modello OSI, quali livelli operano esclusivamente sui nodi terminali (Host Layers) e quali operano anche sui nodi intermedi (Media Layers)? I media layer sono i primi 3 livelli : fisico, connessione dati e rete. I restanti livelli (trasmissione, sessione, presentazione, applicazione) operano end to end e sono livelli host
11. Quali sono le specifiche unità di dati di protocollo (PDU) dei livelli 1, 2, 3 e 4 del modello OSI? Livello 1: Bit; Livello 2: Frame (Trama); Livello 3: Packet (Pacchetto); Livello 4: Segment (TCP) o Datagram (UDP).
12. Quali sono le quattro fasi del protocollo CSMA/CD in una rete Ethernet a bus in presenza di una collisione? Carrier Sense (ascolto canale); 2. Trasmissione 1-persistente; 3. Rilevamento collisione e invio segnale di jamming; 4. Attesa con algoritmo di backoff esponenziale prima del rinvio.
13. Quanti collegamenti punto-a-punto dedicati sono necessari per interconnettere direttamente n nodi in una topologia a maglia completa? $N(N-1)/2$
14. Qual è il ruolo funzionale distinto di DTE, DCE e CPE all'interno di un canale di comunicazione dati? Un DTE è un dispositivo utilizzato da un utente che genera o elabora dati, un DCE è un apparecchio che adatta il segnale per il trasporto in rete e il CPE indica l'insieme di appareti presso l'utente volti alla connessione
15. In che modo il comando traceroute determina la distanza in hop e gli apparati attraversati verso una destinazione remota? Invia pacchetti incrementando progressivamente il valore del TTL a partire da 1 per provocare l'invio di messaggi ICMP Time Exceeded da ogni router lungo il cammino
16. Qual è la differenza strutturale tra un single-homed ISP e un multi-homed ISP all'interno della gerarchia di provider di livello Tier 3? Un single-homed ISP è collegato a un solo provider di livello superiore; un multi-homed ISP è connesso a più provider superiori per garantire ridondanza e bilanciamento del traffico.
17. Per quale motivo architetturale i server di una Extranet aziendale vengono posizionati all'interno di una DMZ anziché nella LAN interna protetta? Perché offrono servizi ridondanti e se vengono attaccati, l'attaccante rimane confinato nella DMZ senza avere accesso alla LAN interna (isola i servizi pubblici)
18. Qual è il fenomeno fisico che consente la guida della luce all'interno del core di una fibra ottica? La riflessione totale interna, che si verifica quando l'angolo di incidenza del raggio sulla superficie di separazione tra core e cladding supera l'angolo critico.
19. Quali sono le funzioni distinte dei sottolivelli LLC e MAC all'interno del livello 2 delle specifiche IEEE 802? L'indirizzo MAC identifica univocamente il dispositivo cui si riferisce e gestisce l'indirizzamento fisico e la contesa del canale. LLC è un'interfaccia tra il livello di rete e il sottolivello MAC e garantisce il multiplexing (protocolli di livello superiore possono coesistere su uno stesso mezzo fisico identificando sempre lo stesso destinatario)
20. In cosa differiscono i protocolli ARQ Go-Back-N e Selective Repeat (SR) nella gestione dei pacchetti errati o fuori sequenza?  In Go-Back-N il ricevitore scarta tutti i pacchetti fuori sequenza e il mittente ritrasmette tutti i frame dall'errore in poi; in Selective Repeat il ricevitore memorizza i pacchetti fuori sequenza e il mittente ritrasmette solo il pacchetto perso.
21. Come risolve il meccanismo RTS/CTS il problema del nodo nascosto nelle trasmissioni wireless? Il trasmettitore invia una Request-To-Send e attende dal destinatario un Clear-To-Send, il quale notifica a tutte le stazioni circostanti nel suo raggio di tacere per la durata della trasmissione.
22. Qual è la relazione matematica tra la lunghezza d'onda λ, la velocità di propagazione c e la frequenza f di un segnale elettromagnetico? $\lambda = \frac{c}{f}$
23. Come si calcola la larghezza di banda di un segnale analogico composto con intervallo di frequenze da fmin​ a fmax​? $f_{max} - f_{min}$
24. Quali valori numerici assume il campo Protocol dell'header IPv4 per identificare i protocolli ICMP, TCP e UDP? ICMP = 1; TCP = 6; UDP = 17.
25. Qual è la funzione del campo TTL (Time-To-Live) nell'header IPv4 e cosa accade quando raggiunge lo valore zero?  Previene i loop di routing decrementando il proprio valore a ogni hop; quando arriva a 0, il router scarta il datagramma e invia un messaggio ICMP Time Exceeded
26. Quali intervalli di valore del primo ottetto caratterizzano le Classi di indirizzi IPv4 A, B, C, D ed E? A = 0-127, B = 128 - 191, C = 192 - 223, D = 224 - 239, E = 240 - 255
27. Qual è la differenza concettuale tra le operazioni di subnetting e supernetting?  Il subnetting suddivide una rete primaria in sottoreti più piccole; il supernetting accorpa più reti primarie in un'unica rotta aggregata riducendo le dimensioni delle tabelle di routing.
28. In che modo il protocollo ARP risolve l'indirizzo MAC di destinazione associato a un indirizzo IP appartenente alla medesima sottorete?  Invia una richiesta ARP Request in broadcast a livello 2; l'host con quell'IP risponde con un ARP Reply in unicast comunicando il proprio indirizzo MAC.
29. Quali ruoli svolgono RPC e XDR nell'architettura Network File System (NFS)? RPC (Remote Procedure Call) gestisce l'invocazione di procedure remote nascondendo il trasporto; XDR (eXternal Data Representation) garantisce la serializzazione dei dati indipendente dalla rappresentazione hardware (endianness).
30. Che cos'è la SMI (Structure of Management Information) in SNMP e quale standard ISO utilizza per la sintassi? È lo standard che definisce le regole di denominazione, tipizzazione e codifica delle variabili MIB; si basa sulla sintassi ASN.1 (Abstract Syntax Notation 1) e sulle regole di codifica BER.
31. Quali limiti di RARP e BOOTP hanno portato allo sviluppo del protocollo DHCP?  RARP operava solo a livello 2 (non attraversava i router); BOOTP richiedeva la registrazione statica dei MAC; DHCP ha introdotto l'assegnazione automatica e riusabile da un pool dinamico (lease).
32. In che modo il meccanismo PAT (Port Address Translation / NAPT) permette a più host privati di condividere un unico IP pubblico?  Mappa l'indirizzo IP privato e la porta sorgente di ciascuna sessione interna in una porta effimera univoca sull'indirizzo IP pubblico del router, memorizzando l'associazione in una tabella di traslazione.
33. Quali sono le principali implicazioni negative dell'uso diffuso del NAT sull'architettura complessiva di Internet? Viola il principio fondante End-to-End, complica l'esecuzione di server e protocolli peer-to-peer e genera un forte sovraccarico di ricalcolo del checksum sui router di confine.
34. Da quanti bit è composto un indirizzo IPv6 e qual è la quantità teorica complessiva di indirizzi disponibili? 128 bit e $2^{128}$ indirizzi
35. Quale campo dell'header IPv6 sostituisce il campo TTL di IPv4 e qual è la sua funzione? Il campo **Hop Limit** (8 bit), che viene decrementato di 1 ad ogni router; se raggiunge 0, il pacchetto viene scartato con invio di ICMPv6 Time Exceeded.
36. Quali sono le tre regole di compressione sintattica di un indirizzo IPv6 e quale vincolo stringente riguarda il simbolo `::`? 1. Insensibilità al maiuscolo/minuscolo; 2. Omissione degli zeri iniziali in ogni blocco; 3. Compressione di blocchi contigui di zeri con `::`. Vincolo: `::` può essere usato **al massimo una volta** per evitare ambiguità.
37. Come devono essere scritti gli indirizzi IPv6 letterali all'interno delle URL web per evitare conflitti con la porta? Tra parentesi quadre
38. Quali sono la notazione contratta e l'uso degli indirizzi speciali IPv6 Unspecified e Loopback?  Unspecified: `::/128` (indica l'assenza di un indirizzo IP); Loopback: `::1/128` (identifica l'host locale per test dello stack).
39. Qual è il prefisso degli indirizzi Multicast in IPv6 e quale indirizzo specifico sostituisce il Broadcast per raggiungere tutti i nodi locali? Prefisso `ff00::/8`. L'indirizzo `FF02::1` (Link-local All Nodes) sostituisce la funzionalità del broadcast.
40. Cos'è un indirizzo Anycast in IPv6 e qual è il suo principio di recapito? È un indirizzo Unicast assegnato alle interfacce di più nodi distinti; la rete lo recapita all'interfaccia topologicamente più vicina (_one-to-nearest_).
41. Come funziona la determinazione della Path MTU in IPv6 ed evita la frammentazione nei router intermedi? I router intermedi scartano i pacchetti troppo grandi inviando al mittente un ICMPv6 Packet Too Big (Type 2) con la propria MTU. Il mittente riduce la dimensione ed eventualmente frammenta alla sorgente (Extension Header 44).
42. Quali sono i quattro passi sequenziali del processo di autoconfigurazione SLAAC in IPv6? 1.Generazione dell'IP Link-Local; 2. Procedura DAD (Duplicate Address Detection); 3. Invio di Router Solicitation (RS); 4. Ricezione di Router Advertisement (RA) per comporre l'IP Global Unicast.
43. Qual è la differenza fondamentale di operatività tra flussi trasmissivi Half-Duplex e Full-Duplex? In Half-Duplex le stazioni possono trasmettere e ricevere ma non contemporaneamente; in Full-Duplex trasmissione e ricezione avvengono simultaneamente su due canali fisici distinti.
44. Come si definiscono rispettivamente le tre metriche prestazionali di rete: Ritardo, Tempo di Risposta e Throughput? Ritardo: tempo di transito di un singolo messaggio; Tempo di Risposta: intervallo tra invio della richiesta e ricezione della risposta; Throughput: quantità effettiva di dati inviata nell'unità di tempo.
45. Quali sono i due parametri prestazionali critici riportati dalle statistiche dell'utility ping? Packet loss (percentuale di pacchetti persi) e Round Trip Time (RTT, tempo di andata e ritorno espresso in millisecondi).
46. Chi esegue la frammentazione dei pacchetti dati rispettivamente nel protocollo IPv4 ed in IPv6?  In IPv4 la frammentazione può essere eseguita sia dall'host sorgente sia dai router intermedi; in IPv6 viene eseguita esclusivamente dall'host sorgente mediante Path MTU Discovery.