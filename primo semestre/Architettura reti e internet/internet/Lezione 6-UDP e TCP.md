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

> [!info] Sintesi:
> - UDP: protocollo connectionless, non affidabile, basso overhead, usato per DNS, streaming, servizi tempo-reale
> - TCP: protocollo connection-oriented, affidabile, controllo flusso/congestione, three-way handshake, usato per HTTP, SSH, SMTP
> - Porte 0-1023 well-known, 1024-65535 ephemeral
> - Socket = IP + porta; TCP usa 4-tupla per identificare connessioni
> - Finestra scorrevole per controllo flusso; checksum per integrità
> - Chiusura connessione a 4 vie con flag FIN