# UDP e TCP: protocolli di trasporto

## User Datagram Protocol (UDP)

*Definizione:* UDP è un protocollo di trasporto molto semplice, di trasmissione e ricezione di datagram, che offre due servizi all'IP:
- **Multiplexing:** permette la condivisione su un host dei datagram IP che provengono da diversi host
- **Controllo dell'errore sui dati**

UDP conosce il metodo per distinguere tra le diverse applicazioni che vengono eseguite sull'host.

UDP è un protocollo **connectionless**: non c'è handshaking e non c'è connessione. Ha un basso overhead per la gestione dell'header, ed i datagram possono essere persi o essere fuori controllo. Non c'è controllo di flusso, non c'è controllo della congestione.

### Porte UDP

Per consentire l'identificazione del processo al quale destinare il datagram viene introdotto il concetto di **portnumber**: un numero intero positivo che rappresenta diversi punti di destinazione astratti che vengono indirizzati dagli host internet per implementare i diversi servizi ed accedere alle diverse applicazioni. Il sistema operativo degli host si fa carico di fornire dei meccanismi di interfaccia che i processi utilizzeranno per specificare una porta o per accedervi.

Per comunicare con una porta esterna l'host che trasmette deve conoscere l'indirizzo IP del destinatario e il numero di porta del protocollo della destinazione all'interno di tale host.

**Applicazioni più diffuse:**
- Multimedia (RTP, Real Time Protocol)
- Servizi di rete (DNS, RIP, SNMP, etc)

> [!info] In altre parole:
> UDP fornisce un servizio di consegna non affidabile e senza connessione, utilizzando l'IP per trasportare i messaggi tra le macchine. Offre la capacità di distinguere tra più destinazioni all'interno di un certo host, tramite il portnumber. Un protocollo applicativo che impieghi l'UDP accetta l'intera responsabilità di gestire il problema dell'affidabilità: perdita di messaggi, loro duplicazione, ritardo, consegna fuori ordine e perdita di connettività.

### Formato del datagram UDP

**Range delle porte:**
- 0-255: Well-known ports
- 256-1023: Less well-known ports
- 1024-65535: ephemeral client ports

**Campi dell'header UDP:**
- **Source Port:** porta sorgente
- **Destination Port:** porta destinazione
- **UDP length:** lunghezza del Datagram incluso header e dati
- **UDP checksum:** controllo dell'errore nel datagram UDP (opzionale)

<div style="display: flex; justify-content: center;">
  <img src="slide-44.png" width="300">
</div>

### UDP De-multiplexing

Tutti i datagram che arrivano all'host B con portnumber n sono passati allo stesso processo. Il numero source port non viene utilizzato quando si effettua il de-multiplexing.

<div style="display: flex; justify-content: center;">
  <img src="slide-45.png" width="300">
</div>

### UDP Checksum

Il checksum UDP permette di individuare errori di comunicazione tra due host. Include uno pseudo-header seguito dal datagram UDP che contiene l'indirizzo IP del destinatario per intercettare false consegne di pacchetti. L'host ricevente ricalcola il checksum e se il risultato è errato cancella il pacchetto senza segnalare errori. L'uso dell'UDP checksum è facoltativo, ma i due host che comunicano devono avere il checksum abilitato.

<div style="display: flex; justify-content: center;">
  <img src="slide-46.png" width="300">
</div>

## Transmission Control Protocol (TCP)

*Definizione:* TCP fornisce un servizio di consegna affidabile delle informazioni con connessione.

*Definizione:* TCP è un singolo protocollo di applicabilità generale che contribuisce a isolare i programmi applicativi dai dettagli del networking e rende possibile la definizione di un'interfaccia uniforme per il servizio di trasferimento di stream.

### Caratteristiche del servizio TCP

L'interfaccia tra i programmi applicativi e il servizio di consegna affidabile del TCP/IP può essere descritta da:

- **Orientamento dello stream:** quando due programmi applicativi trasferiscono dati, questi vengono immagazzinati come sequenze di bit (stream) suddivisi in byte. Il servizio di consegna dello stream passa dal mittente al destinatario esattamente la stessa sequenza di ottetti.
- **Connessione di circuito virtuale:** il trasferimento di stream è analogo ad una chiamata telefonica: solo quando mittente e destinatario hanno verificato la sussistenza delle condizioni necessarie ha inizio il trasferimento.
- **Trasferimento bufferizzato:** anche se il programma applicativo genera le informazioni un ottetto alla volta, il trasferimento accorpa un insieme di ottetti, in modo da ottimizzare la trasmissione. Se il programma genera invece grandi blocchi di dati, il trasferimento potrebbe avvenire a blocchi più piccoli per ottimizzare la trasmissione stessa.
- **Stream non strutturata:** il servizio di stream del TCP non rispetta eventuali strutture presenti in dati strutturati. Sono i programmi che usano il servizio di trasferimento di stream che devono comprendere la struttura dei dati trasmessi.
- **Connessione full-duplex:** le connessioni fornite dal servizio di stream consentono il trasferimento simultaneo in entrambe le direzioni.

Il TCP garantisce l'affidabilità mediante una tecnica chiamata **riscontro positivo con ritrasmissione**. Per ottimizzare la trasmissione il TCP usa la tecnica della **finestra scorrevole**: si continua a trasmettere stream senza verificarne il riscontro sino a che ci si muove all'interno di una finestra predefinita di stream.

### Porte e Socket TCP

Anche il TCP usa i portnumber per identificare il flusso di dati tra le varie applicazioni di un host. Nel caso del TCP il meccanismo di comunicazione è però molto più complesso che nel caso dell'UDP, essendo stato definito un concetto di astrazione di connessione: gli oggetti da identificare sono connessioni virtuali di circuiti, non singole porte.

Il TCP usa una coppia di valori per identificare una connessione: l'indirizzo IP dell'host e la porta dell'applicazione. L'insieme indirizzo IP - portnumber è chiamato **socket**. Questo approccio fa sì che un certo portnumber possa essere condiviso contemporaneamente da più host, aumentando molto l'efficienza di Internet.

### Servizio affidabile e controllo di flusso

**Servizio byte stream affidabile:**
- Trasferimento di flussi di dati: trasferisce un flusso continuo di byte attraverso la rete, raggruppa i byte in segmenti, trasmette i segmenti nel modo opportuno
- Affidabilità: controllo degli errori per far fronte a problemi di trasferimento IP

**Controllo di flusso:** le limitazioni dei buffer e il disallineamento delle velocità trasmissive possono generare perdite di dati. Il ricevente controlla la velocità con la quale il mittente trasmette per prevenire il buffer overflow del ricevente.

<div style="display: flex; justify-content: center;">
  <img src="slide-53.png" width="300">
</div>

### TCP Multiplexing

La connessione TCP è specificata da una 4-tupla:
- Indirizzo mittente, porta mittente, indirizzo destinatario, porta destinatario

TCP consente il multiplexing di connessioni multiple tra sistemi per consentire nello stesso tempo l'uso ottimale delle varie risorse.

<div style="display: flex; justify-content: center;">
  <img src="slide-51.png" width="300">
</div>

### Servizio affidabile di trasporto di un flusso di byte

**Trasferimento di flussi di dati:**
- Trasferisce un flusso continuo di byte attraverso la rete
- Raggruppa i byte in segmenti
- Trasmette i segmenti nel modo opportuno

**Affidabilità:** controllo degli errori per far fronte a problemi di trasferimento IP

<div style="display: flex; justify-content: center;">
  <img src="slide-52.png" width="300">
</div>

### TCP Header

**Window size:**
- 16 bit per annunciare le dimensioni della finestra
- Usata per controllare il flusso
- Il mittente accetterà bytes da ACK a ACK+window
- Dimensioni massime della window 64K

**TCP checksum:** controllo di integrità sul segmento TCP.

<div style="display: flex; justify-content: center;">
  <img src="slide-54.png" width="300">
</div>

### Gestione della connessione TCP

Può accadere che pacchetti relativi a comunicazioni precedenti arrivino in ritardo complicando il calcolo dei pacchetti duplicati. TCP risolve questo problema tramite un **Initial Sequence Number (ISN)**, un campo di 32 bit scelto casualmente. TCP esegue un periodo di timeout alla fine della connessione, chiamato **maximum segment lifetime (MSL)**, in genere 2 minuti. ISN viene stabilito durante il setup della connessione (il bit SYN è posto a 1). Il ricevente risponde con un Acknowledgment number che indica il Sequence Number del prossimo byte che deve ricevere il destinatario. Il flag ACK deve essere impostato.

### Bit di controllo TCP

6 bit flags:
- **URG:** urgent pointer flag
- **ACK:** acknowledgment of the communication
- **PSH:** override TCP Buffering
- **RST:** reset connection
- **SYN:** establish connection
- **FIN:** close connection
### Three-way handshake

La connessione TCP viene stabilita tramite un three-way handshake:
1. Il client invia un segmento con SYN=1 e un Initial Sequence Number (ISN) casuale
2. Il server risponde con SYN=1, ACK=1, il proprio ISN e ACK = ISN_client + 1
3. Il client invia ACK=1 con ACK = ISN_server + 1

<div style="display: flex; justify-content: center;">
  <img src="slide-57.png" width="300">
</div>

### Chiusura della connessione TCP

La chiusura della connessione TCP utilizza il flag FIN:
1. Una parte invia FIN per chiudere la propria direzione di trasmissione
2. L'altra parte risponde con ACK
3. Quando anche l'altra parte ha finito, invia il proprio FIN
4. La prima parte risponde con ACK finale

<div style="display: flex; justify-content: center;">
  <img src="slide-58.png" width="300">
</div>

## Routing

*Definizione:* Il routing è l'azione di scambiare informazioni in una rete da una sorgente a una destinazione, incontrando almeno un nodo intermedio. Coinvolge due attività di base: determinare il percorso ottimale di routing e trasportare gruppi di informazioni (chiamati pacchetti) attraverso una rete. Il routing riguarda il livello 3 del modello di riferimento ISO/OSI.

**Metric e next hop:** Si introduce il concetto di *metric* per indicare una modalità standard di misura (es. lunghezza del percorso in gateway attraversati) per stabilire il percorso ottimale. Un router considera l'associazione *destination/next_hop* per calcolare quale sistema intermedio rappresenta il miglior percorso; ricevuto un pacchetto, il router calcola in base alle sue informazioni il *next hop*.

> [!info] In altre parole:
> La *metric* è il "costo" di un percorso (hop, latenza, banda...). Il *next hop* è il router a cui consegnare il pacchetto per andare verso la destinazione.

**Messaggi tra router:** I router comunicano tra loro e mantengono aggiornate le *routing table* mediante la trasmissione di vari messaggi. Il *routing update* consiste in un messaggio contenente tutta o parte di una routing table; analizzandolo, un router costruisce un disegno dettagliato della topologia della rete. Il *link-state advertisement* (LSA) informa i router che usano OSPF dello stato del link del mittente, consentendo il calcolo del miglior percorso.

<div style="display: flex; justify-content: center;">
  <img src="slide-05.png" width="300">
</div>

**Requisiti degli algoritmi di routing:** Gli algoritmi di routing devono possedere uno o più dei seguenti requisiti:
- *Ottimali:* devono scegliere la migliore strada
- *Semplici e con basso overhead:* farlo consumando meno risorse possibile
- *Robusti e stabili:* comportarsi correttamente in condizioni inusuali e mai viste prima
- *Rapidi nella convergenza:* la scelta del percorso ottimale deve avvenire subito e con il minor sforzo possibile
- *Flessibili:* adattarsi facilmente a diverse condizioni

**Classificazione degli algoritmi di routing:** Vengono classificati in base al comportamento rispetto a:
- *Statici vs. dinamici*
- *Single-path vs. multi-path*
- *Piatti vs. gerarchici*
- *Host-intelligent vs. router-intelligent*
- *Intradomain vs. interdomain*
- *Link state vs. distance vector*

**Metriche di routing:** Gli algoritmi usano una o più delle seguenti caratteristiche per determinare il percorso ottimale:
- *Path Length* (lunghezza del percorso)
- *Reliability* (affidabilità)
- *Delay* (ritardo)
- *Bandwidth* (larghezza di banda)
- *Load* (carico)
- *Communication Cost* (costo di comunicazione)

### Routing table

I gateway instradano i dati tra diverse reti. Gli host prendono decisioni di instradamento nel modo seguente:
- Se l'host di destinazione è sulla rete locale, i dati vengono spediti all'host di destinazione
- Se l'host di destinazione è su una rete remota, i dati vengono mandati al gateway locale

Il protocollo IP basa le sue decisioni di instradamento sulla parte rete dell'indirizzo IP.

**Analisi dell'indirizzo IP fatta dall'host:**
1. Determina il tipo di classe dell'indirizzo IP (bit più significativi)
2. Controlla la rete di destinazione: se è locale (sottorete) applica la subnet mask all'indirizzo di destinazione
3. Cerca la rete di destinazione nella routing table
4. Instrada i pacchetti di dati seguendo il percorso indicato nella tabella di routing (interfaccia)

In ambiente Unix il comando per visualizzare la tabella di routing è: `netstat -nr`

<div style="display: flex; justify-content: center;">
  <img src="slide-11.png" width="300">
</div>

*Esempio di routing table su host Unix:*
```
Destination     Gateway         Flags  Refcnt  Use     Interface
127.0.0.1       127.0.0.1       UH     1       298     lo0
default         128.66.12.1     UG     2       50360   en0
128.66.12.0     128.66.12.2     U      40      98379   en0
128.66.2.0      128.66.12.3     UG     4       1179    en0
```
Dove: *Destination* = rete o host di destinazione; *Gateway* = gateway da usare; *Flags*: U = route attiva, H = host specifico, G = usa gateway, D = da ICMP redirect; *Refcnt* = volte usata; *Use* = pacchetti trasmessi; *Interface* = interfaccia di rete.

### Tipi di definizione di routing

Esistono tre tipi di definizione di routing:
- *Minimale:* le operazioni minime di aggiornamento della tabella di routing effettuate al momento della definizione di un'interfaccia
- *Statico:* l'instradamento viene gestito mediante informazioni di routing predefinite e costanti; sufficiente in configurazioni con topologia molto semplice
- *Dinamico:* l'instradamento viene gestito via software da protocolli di routing che si adattano a tutti i cambiamenti della rete; usano pacchetti per lo scambio delle informazioni necessarie all'aggiornamento

In un dato istante le informazioni potranno provenire da tutti e tre i tipi. Le informazioni assunte mediante protocolli di routing dinamici prendono il sopravvento su quelle statiche in caso di contraddizioni. In un router possono essere eseguiti contemporaneamente diversi protocolli di routing; in alcuni casi (es. Cisco) è possibile iniettare informazioni da un protocollo dinamico all'altro per controllare la distribuzione.

### Comandi per routing statiche

**Cisco:**
```
ip route network subnet gateway distance
ip route 141.250.4.0 255.255.255.0 141.250.9.3 2
sh ip route [network]
```

**Linux:**
```
route add network subnet gateway
route add 141.250.4.0 255.255.255.0 141.250.9.3
netstat -nr
```

### Fonti della routing table

La routing table permette a un router di operare le corrette scelte per indirizzare i pacchetti. Riceve informazioni da due sorgenti:
- Dal file di configurazione creato dall'amministratore di rete e salvato sul disco del dispositivo, interpretato in fase di inizializzazione
- Da protocolli dinamici di aggiornamento (protocolli di routing)

Gli host tendono a mantenere congelata la tabella di routing (non eseguono protocolli di routing dinamici). I router eseguono protocolli di routing dinamici per ricevere aggiornamenti sulle destinazioni e calcolare i corretti percorsi dinamicamente.

### Routing con informazioni parziali

Nel caso di router interni ad un AS (Interior Gateway Protocols, IGP) le informazioni che un singolo router possiede sono assolutamente parziali: il router conosce esplicitamente soltanto i percorsi per raggiungere le reti a esso collegate e le routing statiche verso gateway. Il router si affida al *default router* per istradare correttamente i pacchetti destinati a reti che non conosce. Il routing con informazioni parziali permette localmente a dei router di modificare autonomamente alcune istruzioni, introducendo il rischio di inconsistenze che possano rendere inaccessibili certe reti.

### Architettura dell'Internet originale

L'Internet iniziale era costituita da un *backbone centrale* e da una serie di router, ciascuno che connette una propria rete. Se ogni router è oggetto di una default route, nel peggiore dei casi pacchetti destinati a reti inesistenti girano nella rete fino allo scadere del TTL.

<div style="display: flex; justify-content: center;">
  <img src="slide-17.png" width="300">
</div>

L'architettura prevedeva un insieme di *core router* centrali che conoscevano completamente le destinazioni di tutte le reti; gli altri router conoscevano le informazioni locali e usavano i core router come router centrali.

> [!warning] Controindicazioni:
> - Collo di bottiglia rappresentato dai router del Core System
> - Non sono possibili scorciatoie
> - Non scala con l'aumentare del traffico

### Oltre il Core System

Un unico Core System diventa insufficiente al crescere degli ISP con proprie reti di dorsale. Due dorsali sono apparse quando NSF e ARPA crearono le proprie infrastrutture: sono diventate note come *peer backbones*.

<div style="display: flex; justify-content: center;">
  <img src="slide-19.png" width="300">
</div>

Nel nuovo schema non veniva supportato il *Partial Core*: pacchetti destinati a reti inesistenti rimangono intrappolati fino a che non scade il TTL.

<div style="display: flex; justify-content: center;">
  <img src="slide-20.png" width="300">
</div>

### Core routing

La soluzione adottata è il *Core Routing*, dove i router del Core System conoscono le destinazioni di tutte le reti. Un meccanismo consente ai router di contattare i Core router per conoscere le informazioni di routing e apprendere gli aggiornamenti automaticamente. Due sono gli algoritmi utilizzati per distribuire gli aggiornamenti di routing: *Distance-vector* e *Link-state*.

### Algoritmo Distance-vector

1. Viene inizializzata la routing table con una riga per ogni rete direttamente connessa
2. Con cadenza periodica viene eseguito un algoritmo distance-vector per scambiare le informazioni con i router raggiungibili attraverso le reti connesse
3. Un router invia le sue istruzioni di routing a un altro: la lista contiene coppie (indirizzo di rete di destinazione, distanza)
4. Il ricevente rimpiazza le istruzioni che presentano una soluzione più ottimale rispetto a quella in suo possesso
5. Le nuove istruzioni verranno propagate al prossimo aggiornamento trasmesso

<div style="display: flex; justify-content: center;">
  <img src="slide-24.png" width="300">
</div>

*Esempio di distance-vector update: (a) tabella di routing esistente, (b) aggiornamenti in arrivo.*

### Link-state update

Alternativo al distance-vector. Si basa su calcolo distribuito:
- Informazioni via broadcast
- Permette a ciascun router di calcolare il cammino ottimale
- Evita i problemi che si hanno quando un router trasmette informazioni errate

I router imparano la topologia della rete (sono nodi di un grafo interconnessi da reti). Periodicamente le coppie di router connessi verificano l'esistenza del link attivo e propagano lo stato dei link. Tutti i router ricevono i routing updates e ricalcolano i percorsi ottimali sulla base delle loro informazioni.

<div style="display: flex; justify-content: center;">
  <img src="slide-25.png" width="300">
</div>

> [!info] Sintesi:
> - Il routing scambia pacchetti sorgente-destinazione via nodi intermedi (livello 3 ISO/OSI)
> - Metriche (path length, delay, bandwidth...) guidano la scelta del percorso ottimale
> - Routing table: decisioni basate su parte rete dell'IP; `netstat -nr` su Unix
> - Tre tipi: minimale, statico (costante), dinamico (protocolli adattivi); dinamico prevale su statico
> - Architettura originale: core router centrali → collo di bottiglia, non scala
> - Soluzione: peer backbones + core routing con algoritmi distance-vector e link-state
> - Distance-vector: scambio periodico coppie (destinazione, distanza), convergenza lenta
> - Link-state: broadcast stato link, ogni router calcola SPF su grafo completo, convergenza rapida