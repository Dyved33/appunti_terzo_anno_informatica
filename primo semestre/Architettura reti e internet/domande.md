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
