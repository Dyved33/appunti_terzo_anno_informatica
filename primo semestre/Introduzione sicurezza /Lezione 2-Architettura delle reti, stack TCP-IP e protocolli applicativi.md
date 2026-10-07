# Architettura delle reti, stack TCP/IP e protocolli applicativi

## Richiamo preliminare: lo standard TCP/IP

> [!important] Definizione formale di protocollo:
> Un **protocollo di rete** definisce il **formato** e l'**ordine** dei messaggi scambiati tra due o più entità in comunicazione, nonché l'insieme delle **azioni** intraprese dai nodi in fase di trasmissione o ricezione di un messaggio o al verificarsi di specifici eventi temporali.

L'architettura di rete odierna si fonda su tre principi cardine.

1. **Canale logico virtuale:** lo standard crea un canale virtuale astratto *end-to-end*. La modalità di interazione e la semantica non dipendono dalla distanza fisica: due host situati nella stessa stanza o in continenti diversi comunicano attraverso le medesime regole formali, e la distanza costituisce unicamente un parametro di latenza trasmissiva.
2. **Astrazione del percorso per l'host:** con il modello client-server l'host terminale ragiona esclusivamente sull'interazione logica applicativa, delegando integralmente allo stack di rete sottostante l'onere di instradare, frammentare, trasmettere e riassemblare i pacchetti.
3. **Governo tramite standard e RFC:** ogni servizio distribuito su Internet è rigorosamente disciplinato da specifiche formali pubbliche, le RFC (*request for comments*) curate da IETF, garantendo l'interoperabilità tra sistemi operativi ed elaboratori eterogenei.

```
   HOST A                                                      HOST B
  ┌────────┐          Protocollo Applicativo (es. HTTP)       ┌────────┐
  │ Client │ ───────────────────────────────────────────────► │ Server │
  └────────┘ ◄─────────────────────────────────────────────── └────────┘
       ▲  Lo standard definisce il canale logico                      ▲
       │  (il mezzo fisico è solo il supporto)                     │
  ─────┴───────────────────────────────────────────────────────────┴─────
             [ Rete: Router, Switch, Mezzi Fisici di Trasmissione ]
```

## La pila di protocoli TCP/IP

**Motivazioni della stratificazione:** le reti telematiche sono sistemi complessi composti da nodi (*host*, router), collegamenti fisici eterogenei, protocolli e processi software. La suddivisione in strati risponde a due esigenze primarie:

- **Semplificazione dell'analisi:** isola le responsabilità concettuali e facilita la comprensione e l'insegnamento dell'interazione sistemica.
- **Modularità e manutenzione:** i dettagli implementativi interni a ciascun livello sono del tutto **trasparenti** ai livelli adiacenti; è possibile aggiornare o sostituire un protocollo di trasporto, per esempio passare da TCP a UDP o QUIC, senza dover modificare il codice sorgente dell'applicazione.

> [!warning] La stratificazione introduce vulnerabilità?
> Sebbene comporti un inevitabile sovraccarico computazionale (*overhead* dovuto all'aggiunta di header per ogni strato), la stratificazione costituisce un **fondamentale vantaggio difensivo in ambito di sicurezza**, perché consente di predisporre contromisure specializzate e disaccoppiate a ciascun livello della pila:
> - Livello link: *port security*, 802.1X, isolamento VLAN.
> - Livello rete/trasporto: *packet filtering*, firewall di stato, IPsec, VPN, TLS.
> - Livello applicazione: Web Application Firewall (WAF), Intrusion Prevention System (IPS), validazione semantica dei payload e autenticazione applicativa.

**I cinque livelli e le unità dati di protocollo (PDU):**

| Livello TCP/IP | Funzione Primaria | Protocolli Tipici | PDU (*Protocol Data Unit*) |
| :--- | :--- | :--- | :--- |
| **5. Applicazione** | Supporto e interfaccia per i servizi e le applicazioni distribuite | HTTP, HTTPS, FTP, SMTP, DNS, SSH | **Messaggio (*Message*)** |
| **4. Trasporto** | Trasferimento logico dei messaggi tra processi (*process-to-process*); multiplexing/demultiplexing | TCP, UDP | **Segmento (*Segment*)** / Datagramma UDP |
| **3. Rete** | Instradamento (*routing*) e indirizzamento logico dei pacchetti dall'origine al destinatario | IP (IPv4, IPv6), ICMP, OSPF, BGP | **Datagramma (*Datagram / Packet*)** |
| **2. Collegamento (*Link*)** | Trasferimento affidabile dei dati su singolo collegamento fisico (*hop-by-hop*) tra nodi adiacenti | Ethernet (IEEE 802.3), Wi-Fi (802.11), PPP | **Frame (*Trama*)** |
| **1. Fisico** | Trasmissione dei singoli segnali elettrici, ottici o elettromagnetici sul mezzo | Cavi in rame, fibra ottica, onde radio | **Bit** |

> [!info] Significato del termine "pacchetto":
> Nel gergo informatico comune il termine **"pacchetto"** viene impiegato in modo generico per indicare una qualsiasi unità di dati in transito sulla rete. Formalmente si tratta della medesima informazione, che assume denominazioni tecniche differenti a seconda dello strato della pila in cui viene osservata: **messaggio** (applicazione), **segmento** (trasporto), **datagramma** (rete), **frame** (collegamento).

**Multiplexing e demultiplexing:** il livello di trasporto realizza il trasferimento logico **process-to-process**. Poiché ==su un singolo host possono essere attivi numerosi processi contemporaneamente, TCP e UDP devono distinguere a quale processo consegnare i dati ricevuti.==

- **Multiplexing (dal lato mittente):** il livello di trasporto raccoglie i dati provenienti da diversi processi applicativi, li incapsula in segmenti (o datagrammi UDP) e assegna a ciascuno un opportuno numero di porta sorgente, in modo da poterli distinguere all'arrivo.
- **Demultiplexing (dal lato ricevente):** il livello di trasporto esamina il numero di porta di destinazione presente nell'intestazione del segmento o datagramma e lo consegna al corretto processo applicativo tramite la relativa socket.

Per **UDP** (connectionless) il demultiplexing si basa unicamente sulla coppia `(IP destinazione, porta destinazione)`. Per **TCP** (connection-oriented) la consegna avviene in base all'intera **5-tupla**: `(IP sorgente, porta sorgente, IP destinazione, porta destinazione, protocollo)`, così che connessioni distinte, anche dallo stesso processo client ma con porte sorgenti diverse, vengano gestite separatamente.

**Incapsulamento e decapsulamento:** ciascun livello aggiunge in testa ai dati ricevuti dal livello superiore una propria intestazione contenente i metadati di controllo di competenza (**incapsulamento** in trasmissione) e ne esegue la rimozione al momento della ricezione (**decapsulazione**).

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

## Processi, socket e indirizzamento dei servizi

Un **processo** è un programma in esecuzione all'interno di un elaboratore.

- Due processi residenti sul **medesimo host** comunicano tramite i meccanismi di comunicazione interprocesso (IPC) messi a disposizione dal kernel, come pipe, code di messaggi o memoria condivisa.
- Due processi residenti su **host distinti** devono comunicare tramite lo **scambio esplicito di messaggi** attraverso l'infrastruttura di rete.
- **Client:** processo che assume l'iniziativa e invia la prima richiesta di connessione.
- **Server:** processo che si pone in ascolto passivo su una determinata porta logica, in attesa di essere contattato.
- **Peer-to-Peer (P2P):** architettura simmetrica in cui ciascun nodo agisce contemporaneamente da client e da server.

**La primitiva socket:** una **socket** costituisce l'interfaccia software (API) e il punto di accesso logico che connette il processo applicativo in spazio utente (*user space*) con i moduli di trasporto gestiti dal kernel del sistema operativo.

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

**Indirizzamento completo: la 5-tupla e le porte.** L'indirizzo IP identifica in modo univoco l'**interfaccia di rete dell'host**, ma poiché su un singolo host operano simultaneamente centinaia di processi è indispensabile specificare il **numero di porta** (intero a 16 bit, intervallo $0 - 65535$) per individuare l'esatto socket di destinazione, il cosiddetto **socket address** `IP:porta`. Formalmente una connessione TCP/IP bidirezionale è univocamente identificata dalla **5-tupla**:

$$\langle \text{IP Sorgente}, \text{Porta Sorgente}, \text{IP Destinazione}, \text{Porta Destinazione}, \text{Protocollo di Trasporto} \rangle$$

*Classificazione delle porte logiche:*

- **Well-known ports ($0 - 1023$):** riservate e standardizzate da IANA per i servizi di sistema fondamentali (`20/21` FTP, `22` SSH, `25` SMTP, `53` DNS, `80` HTTP, `110` POP3, `143` IMAP, `443` HTTPS). Nei sistemi Unix-like richiedono privilegi di root o amministratore per il binding.
- **Registered ports ($1024 - 49151$):** assegnate da IANA a servizi e software commerciali specifici (`3306` MySQL, `5432` PostgreSQL).
- **Dynamic / ephemeral ports ($49152 - 65535$):** porte temporanee allocate automaticamente dal kernel ai processi client all'avvio della sessione e rilasciate al termine della comunicazione.

> [!warning] Port scanning e fingerprinting:
> L'utilizzo di porte well-known rende i servizi di rete immediatamente individuabili dagli attaccanti mediante tecniche di **port scanning**, per esempio con `nmap`. Attraverso l'analisi dei banner di risposta (*banner grabbing*) e dei comportamenti a fronte di pacchetti anomali l'attaccante effettua il **service fingerprinting**, identificando l'esatta versione del software server per ricercare vulnerabilità note (CVE) ed exploit pubblici.

## I protocolli applicativi

Un protocollo applicativo definisce formalmente:

1. **Tipologia dei messaggi:** distinzione esplicita tra messaggi di richiesta, risposta, controllo o notifica.
2. **Sintassi:** struttura dei campi, intestazioni, delimitatori e formati dei dati.
3. **Semantica:** significato formale del contenuto di ciascun campo.
4. **Regole temporali:** condizioni e sequenze che stabiliscono *quando* e *come* un'entità deve trasmettere o rispondere.

I protocolli si distinguono in due famiglie:

- **Protocolli di pubblico dominio:** disciplinati da RFC aperte (HTTP, FTP, SMTP, DNS), garantiscono interoperabilità tra fornitori differenti. L'apertura dello standard garantisce trasparenza e possibilità di audit di sicurezza continuo, secondo il principio di Kerckhoffs: ==la sicurezza deve risiedere nell'algoritmo o nella chiave e non nell'occultamento del protocollo.==
- **Protocolli proprietari:** sviluppati da singoli vendor, come vecchi sistemi di streaming o gaming; l'assenza di specifiche pubbliche (*security through obscurity*) costituisce una protezione debole e illusoria.

**Requisiti delle applicazioni e scelta del livello di trasporto:** le applicazioni di rete presentano requisiti eterogenei su tre parametri critici.

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
│ • Orientato alla connessione (3-way handshake)│ • Senza connessione (Connectionless)   │
│ • Trasporto affidabile (ACK + Retrans) │ • Trasporto inaffidabile (Best-Effort) │
│ • Consegna ordinata dei byte           │ • Nessun controllo sull'ordine         │
│ • Controllo di Flusso (Receive Window) │ • Nessun controllo di flusso           │
│ • Controllo della Congestione          │ • Nessun controllo della congestione   │
│ • Overhead elevato (header 20 byte)    │ • Overhead minimo (header 8 byte)      │
└────────────────────────────────────────┴────────────────────────────────────────┘
```

**Il segmento TCP:** è composto da intestazione e dati, con i seguenti campi principali: porte sorgente e destinazione, Sequence Number (SEQ), Acknowledgment Number (ACK), Header Length, Flags (SYN, ACK, FIN, RST, PSH, URG), Receive Window (per il **controllo di flusso**), Checksum e Urgent Pointer.

- **Controllo di flusso:** meccanismo end-to-end tra mittente e ricevente per evitare di sovraccaricare il buffer del ricevente; si basa sulla *receive window*.
- **Controllo della congestione:** meccanismo volto a evitare che il mittente inondi la rete, cioè collegamenti e router intermedi, riducendo perdite e ritardi. TCP lo gestisce tramite algoritmi come Slow Start, Congestion Avoidance, Fast Retransmit e Fast Recovery, in risposta a timeout e ACK duplicati.

> [!info] Cause e costi della congestione di rete
> La congestione si verifica per due ragioni distinte: perché **troppe sorgenti inviano troppo velocemente**, e il tasso di arrivo della somma dei flussi supera la capacità del link bottleneck; oppure perché si verifica un **overflow dei buffer di un router**, cioè la coda di un link è piena e i pacchetti in arrivo devono essere scartati.
>
> I costi non si limitano ai pacchetti persi. Il pacchetto perso va **ritrasmesso**, quindi si sprecano risorse di rete che avrebbero potuto trasportare altro traffico e l'efficienza complessiva cala; inoltre il ritardo di accodamento cresce con il carico, e un pacchetto che arriva in ritardo può far scattare un timeout spurio e provocare la ritrasmissione anche di segmenti che non erano andati persi. Infine, quando scatta un timeout il mittente **riduce drasticamente la finestra di congestione**, e il throughput effettivo crolla finché la finestra non ricresce.

> [!todo] immagine mancante: schema dell'header del segmento TCP con i campi principali (porte, SEQ, ACK, offset, flags, finestra, checksum, urgent pointer, opzioni e dati)

> [!info] Perché si utilizza UDP se TCP è affidabile?
> L'affidabilità di TCP introduce latenza inevitabile: handshake a tre vie, attesa di ACK, ritrasmissioni in caso di perdita e riordino dei segmenti nei buffer. Nelle applicazioni *real-time* (VoIP, streaming live, videogiochi competitivi) un pacchetto audio o video che arrivi con 300 ms di ritardo è del tutto inservibile: è preferibile tollerare la perdita di un singolo frame audio piuttosto che bloccare l'intero flusso per richiederne la ritrasmissione. Inoltre UDP consente al server di gestire un volume di client concorrenti enormemente superiore, riducendo lo stato di memoria allocato.

| Applicazione di Rete | Protocollo Applicativo | Protocollo di Trasporto Sottostante |
| :--- | :--- | :--- |
| **Posta Elettronica** | SMTP [RFC 5321] | **TCP (Porta 25)** |
| **Accesso Terminale Remoto** | SSH [RFC 4251] / Telnet | **TCP (Porta 22 / 23)** |
| **Navigazione Web** | HTTP [RFC 9110] | **TCP (Porta 80)** |
| **Navigazione Web Sicura** | HTTPS [RFC 9110-9113] | **TCP (Porta 443 via TLS)** |
| **Trasferimento File** | FTP [RFC 959] | **TCP (Porte 20, 21)** |
| **Risoluzione Nomi di Dominio** | DNS [RFC 1034, 1035] | **UDP (Porta 53)** (TCP per zone transfer) |
| **Streaming e Telefonia IP** | RTP / SIP / Proprietari | **Tipicamente UDP** |

## Il Web e il protocollo HTTP/HTTPS

Una **pagina web** è un documento ipertestuale composto da un file HTML base e da molteplici **oggetti referenziati**: immagini JPEG/PNG, script JavaScript, fogli di stile CSS e applet. Ciascun oggetto è univocamente individuato da un indirizzo **URL** (*uniform resource locator*):

$$\text{URL} = \underbrace{\text{http://www.site.com}}_{\text{Nome Host}} / \underbrace{\text{images/logo.png}}_{\text{Percorso Risorsa}}$$

Il protocollo **HTTP** (*HyperText Transfer Protocol*) opera sul modello client-server:

1. Il client (browser) apre una connessione TCP verso la porta 80 del server web.
2. Il server web accetta la connessione.
3. Client e server si scambiano messaggi di richiesta (*request*) e risposta (*response*).
4. La connessione TCP viene chiusa o mantenuta attiva (*keep-alive*).

**Statelessness e cookie:** HTTP è per progettazione un protocollo **senza stato (*stateless*)**: il server web non conserva memoria storica delle richieste precedentemente effettuate dal medesimo client.

- *Vantaggio:* semplifica notevolmente l'architettura dei server e garantisce resilienza ai crash, perché non occorre ripristinare o sincronizzare stati applicativi complessi tra client e server.
- *Svantaggio:* non supporta nativamente carrelli e-commerce, profili di accesso o sessioni continuative.

Per reintrodurre lo stato applicativo mantenendo il protocollo stateless si adottano i **cookie**, composti da quattro componenti:

1. Header di risposta inviato dal server: `Set-Cookie: ID_SESSIONE=1678; Path=/; Secure; HttpOnly`.
2. Header di richiesta ritrasmesso dal client: `Cookie: ID_SESSIONE=1678`.
3. File di memorizzazione dei cookie gestito dal browser sul filesystem locale del client.
4. Database o archivio di sessione sul server che associa l'ID ai dati dell'utente.

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

> [!warning] Rischi di sicurezza dei cookie e flag fondamentali:
> Poiché i cookie fungono da token di autenticazione (*bearer token*), la loro intercettazione equivale al furto completo dell'identità dell'utente (*session hijacking*):
> - **Flag `Secure`:** impone al browser di trasmettere il cookie **esclusivamente su connessioni cifrate HTTPS**, prevenendo lo sniffing del token su reti Wi-Fi pubbliche o canali non protetti.
> - **Flag `HttpOnly`:** impedisce l'accesso al cookie tramite codice JavaScript lato client (`document.cookie`), neutralizzando l'esfiltrazione dei token di sessione in caso di attacchi **Cross-Site Scripting (XSS)**.
> - **Flag `SameSite` (`Strict`/`Lax`):** limita l'invio dei cookie in richieste cross-site per mitigare gli attacchi di tipo **Cross-Site Request Forgery (CSRF)**.

**Connessioni non persistenti vs persistenti e RTT:**

- **Connessioni non persistenti (default HTTP/1.0):** ciascun oggetto web richiede l'apertura e la chiusura di una connessione TCP dedicata. Il tempo per prelevare un singolo oggetto con tempo di andata e ritorno $RTT$ (*round trip time*) è:
  $$T_{\text{totale}} = 2 \cdot RTT + t_{\text{trasmissione}}$$
  cioè $1 \cdot RTT$ per il three-way handshake TCP, più $1 \cdot RTT$ per la richiesta HTTP e i primi byte della risposta, più il tempo di trasferimento del payload. Per scaricare una pagina con 10 immagini servono 11 connessioni TCP distinte, con $22 \cdot RTT$ sequenziali, ridotti aprendo connessioni TCP parallele.
- **Connessioni persistenti (default HTTP/1.1):** più oggetti vengono trasferiti attraverso una **singola connessione TCP persistente** tra client e server. *Senza pipelining* il client attende la risposta prima di inoltrare la richiesta successiva, con $1 \cdot RTT$ per ogni oggetto aggiuntivo; *con pipelining* il client invia immediatamente tutte le richieste non appena incontra i riferimenti nel codice HTML, con $1 \cdot RTT$ cumulativo per tutti gli oggetti referenziati.

**Anatomia dei messaggi HTTP.** Il messaggio di richiesta (*request message*) è formattato in testo puro ASCII e strutturato in:

1. **Riga di richiesta (*request line*):** `METODO URL VERSIONE`
2. **Righe di intestazione (*header lines*):** metadati chiave-valore (`Host:`, `User-Agent:`, `Accept:`, `Connection:`).
3. **CRLF (`\r\n`):** riga vuota obbligatoria che delimita la fine degli header.
4. **Entity body (payload opzionale):** dati inviati nei metodi `POST` o `PUT`.

```http
GET /somedir/page.html HTTP/1.1\r\n
Host: www.someschool.edu\r\n
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64)\r\n
Accept-Language: it-IT,it;q=0.9\r\n
Connection: keep-alive\r\n
\r\n
```

> [!important] L'header `Host:` e la sicurezza del virtual hosting:
> L'intestazione `Host:` è obbligatoria in HTTP/1.1: consente a un unico server web e a un unico indirizzo IP di ospitare centinaia di domini differenti (*virtual hosting*). Se il server non valida accuratamente questo campo, l'attaccante può manometterlo conducendo ad attacchi di **host header injection**, avvelenamento dei link nelle email di reset password e alterazione della cache (*web cache poisoning*).

**Metodi HTTP principali:**

- `GET`: recupera la risorsa target; i parametri del form vengono accodati all'URL come *query string*.
- `POST`: invia dati strutturati al server all'interno del corpo (*body*) del messaggio HTTP.
- `HEAD`: chiede al server di restituire **esclusivamente le righe di intestazione di risposta**, omettendo il corpo della risorsa; è usato per verificare la validità di un link, la dimensione di un file (`Content-Length`) o la data di ultima modifica (`Last-Modified`) senza sprecare banda.
- `PUT`: carica o sovrascrive interamente un documento nel percorso indicato.
- `DELETE`: richiede la cancellazione permanente della risorsa sul server.

> [!warning] Rischio di sicurezza nell'uso di `GET` per dati riservati:
> I parametri inviati tramite `GET` rimangono registrati in chiaro nella cronologia del browser, nei file di log dei server web, nell'header `Referer` inoltrato a siti terzi e nelle memorie cache dei proxy. È categoricamente vietato usare `GET` per trasmettere credenziali o dati personali.

**Il messaggio di risposta (*response message*):**

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

I **codici di stato** standard sono `200 OK` (successo), `301 Moved Permanently` (reindirizzamento permanente con header `Location`), `304 Not Modified` (copia in cache ancora valida), `400 Bad Request` (errore sintattico del client), `401 Unauthorized` (mancata autenticazione), `403 Forbidden` (accesso negato), `404 Not Found` (risorsa inesistente), `500 Internal Server Error` (fallimento interno del server) e `505 HTTP Version Not Supported`.

**Web caching, server proxy e GET condizionale:** un **server proxy / web cache** intercetta le richieste dei client e memorizza copie locali delle risorse più richieste, riducendo la latenza percepita dall'utente e abbattendo il carico di banda sulle dorsali di rete.

- **GET condizionale:** per evitare di scaricare file non modificati il proxy invia la richiesta con l'header `If-Modified-Since: Sun, 27 Sep 2026 18:22:00 GMT`. Se la risorsa sul server d'origine è immutata il server risponde con `304 Not Modified` a payload vuoto; se è stata modificata risponde con `200 OK` e il nuovo contenuto.

> [!warning] Vulnerabilità di web cache poisoning:
> Se un attaccante riesce a iniettare una risposta manipolata all'interno della cache di un proxy, sfruttando debolezze negli header HTTP o l'*HTTP request smuggling*, il server proxy distribuirà il payload dannoso a tutti gli utenti che richiederanno quella risorsa, scavalcando totalmente il server di origine.

**Da HTTP a HTTPS:** HTTP trasmette tutti i dati e le credenziali in chiaro. **HTTPS (HTTP Secure)** interpone il livello crittografico **TLS (Transport Layer Security)** su porta **`443`**, garantendo:

1. **Confidenzialità:** cifratura simmetrica del flusso (AES, ChaCha20).
2. **Integrità:** codici di autenticazione dei messaggi (HMAC, AEAD).
3. **Autenticazione:** certificati digitali X.509 emessi da Certification Authority (CA) fidate.

## Il protocollo FTP

> [!important] Architettura fuori banda (*out-of-band*) di FTP:
> Il protocollo **FTP** opera sul modello client-server per il trasferimento bidirezionale di file e adotta una peculiare **architettura a due connessioni TCP parallele e distinte**:
> 1. **Connessione di controllo (TCP porta 21):** canale persistente per tutta la sessione, utilizzato per inviare comandi utente in formato ASCII e ricevere codici di stato; mantiene lo stato dell'utente (directory corrente, autenticazione). È una connessione *out-of-band* perché non trasporta i byte dei file.
> 2. **Connessione dati (TCP porta 20 o porta dinamica):** canale non persistente aperto *on-demand* esclusivamente durante il trasferimento fisico del file o dell'elenco directory (`LIST`), e chiuso immediatamente al termine del singolo trasferimento.

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

**Comandi e codici di stato:**

- **Comandi ASCII principali:** `USER username`, `PASS password`, `LIST` (elenco directory), `RETR filename` (download/get), `STOR filename` (upload/put), `QUIT`.
- **Codici di stato tipici:** `331 Username OK, password required`, `125 Data connection already open`, `425 Can't open data connection`, `452 Error writing file`.

> [!warning] Gravi criticità di sicurezza in FTP tradizionale:
> 1. **Credenziali in chiaro:** i comandi `USER` e `PASS` e i dati dei file transitano non cifrati sulla rete, esponendosi a intercettazione (*sniffing*) e *man-in-the-middle*.
> 2. **Complessità di filtraggio nei firewall:** poiché la connessione dati viene aperta su porte dinamiche negoziate sul canale di controllo, i firewall tradizionali faticano a tracciare i flussi senza moduli avanzati di Application Layer Gateway (ALG).
> 3. **Alternative sicure:** l'FTP in chiaro è oggi sostituito da **SFTP** (SSH File Transfer Protocol, su porta TCP 22 all'interno di un tunnel SSH) o **FTPS** (FTP incapsulato in TLS/SSL).

## I meccanismi di controllo dell'integrità

I dati trasmessi sui canali fisici sono soggetti ad alterazioni dovute a rumore, attenuazione e collisioni; i protocolli di rete implementano meccanismi di rilevamento errori.

1. **Bit di parità:** aggiunta di un bit di controllo a una sequenza per rendere pari (*parità pari*) o dispari (*parità dispari*) il numero complessivo di bit a $1$. Rileva solo errori su singoli bit.
2. **Internet checksum (livello di trasporto e rete):**
   - il mittente raggruppa il segmento in parole a 16 bit e ne calcola la somma in complemento a 1;
   - il complemento a 1 della somma viene inserito nel campo *checksum* dell'header;
   - il ricevente somma tutte le parole a 16 bit, incluso il checksum: se il risultato è composto da tutti $1$ (`0xFFFF`) il pacchetto non presenta errori accidentali, altrimenti viene scartato.

**Implementazione del checksum nei vari livelli:**

- **TCP:** checksum calcolato sulla **pseudo-intestazione IP più l'intero segmento TCP** (header e dati); obbligatorio sia in IPv4 che in IPv6.
- **IPv4:** checksum calcolato **esclusivamente sull'intestazione IP**, perché il payload non è protetto da IP e la sua integrità è demandata a TCP o al livello applicazione; in IPv6 il checksum di rete è stato eliminato per velocizzare il routing.
- **Ethernet (data link):** Frame Check Sequence (**FCS**) basato su polinomio ciclico, **CRC a 32 bit**, in grado di rilevare sequenze complesse di burst error.
- **HTTP:** non prevede alcun checksum nativo nel corpo; l'integrità è delegata interamente a TLS in HTTPS.

> [!important] Checksum vs integrità crittografica:
> Il checksum e il CRC sono funzioni **matematiche non crittografiche** progettate unicamente per rilevare **errori accidentali e casuali** del canale di trasmissione. **Non offrono alcuna sicurezza contro attaccanti intenzionali**: un utente malintenzionato che intercetta e modifica un pacchetto può ricalcolare istantaneamente il checksum valido corrispondente al dato manomesso. Per garantire reale integrità e autenticità contro manomissioni attive sono indispensabili primitive crittografiche come i **Message Authentication Code (MAC/HMAC)**, le **firme digitali** e i cifrari autenticati (AEAD).

## L'architettura della posta elettronica

L'infrastruttura di posta elettronica si articola su tre componenti fondamentali:

- **Mail User Agent (MUA):** client di posta utilizzato dall'utente, come Thunderbird, Outlook o Apple Mail.
- **Mail Transfer Agent (MTA) / mail server:** server che gestisce le caselle di posta (*mailbox*) e le code di messaggi in uscita.
- **Protocolli di comunicazione:** SMTP per l'invio e il routing inter-server; POP3 e IMAP per il prelievo della posta da parte del destinatario.

```
┌───────────┐                      ┌─────────────┐                      ┌─────────────┐                      ┌───────────┐
│ MUA Alice │ ──(SMTP, porta 25)──►│ Mail Server │ ──(SMTP, porta 25)──►│ Mail Server │ ◄──(POP3/IMAP)───────│  MUA Bob  │
│  Client   │                      │    Alice    │                      │     Bob     │ (Porte 110/143/993)  │  Client   │
└───────────┘                      └─────────────┘                      └─────────────┘                      └───────────┘
```

**SMTP:** protocollo *Simple Mail Transfer Protocol* (RFC 5321).

- **Funzione:** protocollo di livello applicativo orientato all'**invio (*push*)** dei messaggi di posta elettronica da client a server e tra server di posta intermedi su connessione **TCP (porta 25)**.
- **Modalità operativa:** a differenza di HTTP, che è un protocollo di tipo *pull* (il client preleva le risorse), SMTP è strettamente *push*, perché il mittente spinge il messaggio verso il destinatario.
- **Connessioni persistenti:** SMTP mantiene la connessione TCP aperta per trasferire molteplici messaggi consecutivi verso il medesimo server.

Le tre fasi del dialogo SMTP in comando/risposta ASCII:

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

> [!warning] La porta 25 e il problema dell'open relay e del mail spoofing:
> Poiché originariamente i server SMTP non richiedevano alcuna autenticazione e consentivano a chiunque di dichiarare qualsiasi mittente nel comando `MAIL FROM:`, i server configurati in modalità **open relay** sono stati massicciamente sfruttati per l'invio indiscriminato di **spam e phishing**. I moderni sistemi applicano protocolli di autenticazione e reputazione del mittente:
> - **SPF (Sender Policy Framework):** record DNS che autorizza specifici indirizzi IP all'invio di email per quel dominio.
> - **DKIM (DomainKeys Identified Mail):** firma crittografica a chiave pubblica apposta nell'header dell'email.
> - **DMARC:** policy che definisce le azioni da intraprendere, per esempio scarto o quarantena, qualora i controlli SPF o DKIM falliscano.

**Formato dei messaggi: RFC 822 e standard MIME.** Il messaggio è composto da:

1. **Header RFC 822:** righe `To:`, `From:`, `Subject:`, `Date:`, separate dai comandi del protocollo SMTP.
2. **Riga vuota (CRLF).**
3. **Body:** corpo del messaggio in formato testo ASCII a 7 bit.

Lo standard **MIME** (*Multipurpose Internet Mail Extensions*, RFC 2045-2049) consente il trasporto di caratteri non ASCII, come accenti e caratteri orientali, e di **allegati binari multimediali** (immagini, PDF, audio, video) all'interno di un canale storicamente limitato all'ASCII a 7 bit, introducendo intestazioni supplementari:

- `MIME-Version: 1.0`
- `Content-Type`: dichiara il formato del dato (`text/html; charset=UTF-8`, `image/jpeg`, `multipart/mixed`, `multipart/alternative`).
- `Content-Transfer-Encoding`: metodo di codifica dei byte binari in caratteri stampabili:
  - **Base64:** raggruppa i byte in blocchi di 3 byte (24 bit) e li mappa in 4 caratteri ASCII a 6 bit, con un incremento di overhead pari a circa il $+33\%$.
  - **Quoted-Printable:** preserva i caratteri ASCII standard codificando i caratteri speciali nella forma `=XX`, dove $XX$ è l'esadecimale del byte.

**Le intestazioni di un'email reale:**

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

- `Return-Path` e intestazioni `Received` tracciano l'intera catena di server MTA attraversati dal messaggio, elementi essenziali per la digital forensics e per verificare l'autenticità del percorso di instradamento.
- `Message-ID` è l'identificatore univoco globale del messaggio, generato dal primo mail server.
- `boundary` è la stringa di delimitazione che separa le diverse sezioni nei messaggi multipart.
- Le intestazioni `X-*` sono metadati non standard introdotti da client o filtri specifici (antivirus, antispam, client di posta).

> [!info] Il parametro `boundary` e gli attacchi di MIME injection:
> Il tipo `multipart` separa testo e allegati tramite la stringa `boundary`. Se il contenuto di un allegato include accidentalmente o deliberatamente tale stringa senza adeguata sanitizzazione, l'interprete email può dividere erroneamente il messaggio, aprendo a tecniche di **MIME boundary injection** per mascherare codice malevolo o alterare la visualizzazione del messaggio.

**POP3 vs IMAP:**

| Dimensione di Confronto | POP3 (*Post Office Protocol v3*) [RFC 1939] | IMAP (*Internet Message Access Protocol*) [RFC 9051] |
| :--- | :--- | :--- |
| **Porta Standard** | TCP **110** (POP3S su TCP **995** con TLS) | TCP **143** (IMAPS su TCP **993** con TLS) |
| **Paradigma Operativo** | Download in locale ("scarica e cancella" o "scarica e mantieni") | Gestione centralizzata e sincronizzata direttamente sul server |
| **Mantenimento dello Stato** | **Stateful** durante la sessione (stati AUTHORIZATION, TRANSACTION, UPDATE), ma **senza memoria tra sessioni distinte** | **Stateful**: conserva lo stato dei messaggi (letto, risposto, bozza) |
| **Organizzazione Cartelle** | Solo casella di posta in arrivo locale | Cartelle gerarchiche multiple create e sincronizzate sul server |
| **Accesso Multidispositivo** | Problematico (disallineamento tra client diversi) | Ottimale (piena sincronizzazione tra PC, smartphone, webmail) |

Esempio di sessione POP3, nelle fasi di autorizzazione e transazione:

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

## Il sistema dei nomi di dominio (DNS)

Il **DNS** [RFC 1034, 1035] è il servizio di directory fondamentale di Internet, operante a livello applicativo su protocollo di trasporto **UDP (porta 53)**, con fallback su TCP per trasferimenti di zona o risposte che superano il limite trasportabile in UDP (512 byte senza EDNS0, fino a 4096 byte con EDNS0). Traduce gli hostname mnemonici, per esempio `www.unipg.it`, negli indirizzi IP numerici instradabili, per esempio `141.250.x.x`.

**Architettura del database distribuito e gerarchico:** la sua architettura è scalabile e distribuita per scongiurare singoli punti di vulnerabilità (*single point of failure*).

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

1. **Root DNS servers:** 13 indirizzi logici, replicati capillarmente tramite *anycast*, che indirizzano le interrogazioni verso i server TLD di competenza.
2. **Top-Level Domain (TLD) servers:** gestiscono i domini di primo livello generici (gTLD: `.com`, `.org`, `.net`, `.edu`) e nazionali (ccTLD: `.it`, `.fr`, `.de`).
3. **Authoritative DNS servers (server autoritativi):** conservano i record ufficiali di risoluzione per i domini di una specifica organizzazione.
4. **Local DNS server (default resolver):** server DNS dell'ISP o dell'azienda che riceve direttamente le query dagli host locali e gestisce la cache di risoluzione.

**Modalità di risoluzione:**

- **Query ricorsiva:** il nodo richiedente delega completamente al server DNS interrogato il compito di reperire la risposta finale, attendendo la mappatura IP definitiva.
- **Query iterativa:** il server DNS interrogato risponde fornendo l'indirizzo IP del server DNS di livello successivo da contattare, demandando al resolver locale l'onere di proseguire la catena gerarchica.

**Struttura dei resource record (RR):** i dati nel database DNS sono formalizzati come quartine `(Name, Value, Type, TTL)`.

- **Tipo `A`:** associa un hostname a un indirizzo IPv4, `(sito.com, 192.0.2.1, A, 3600)`.
- **Tipo `AAAA`:** associa un hostname a un indirizzo IPv6 a 128 bit.
- **Tipo `NS` (*name server*):** specifica l'hostname del server DNS autoritativo responsabile per il dominio indicato in `Name`.
- **Tipo `CNAME` (*canonical name*):** definisce un alias rispetto al nome canonico reale, `(www.server.com, server-principale.com, CNAME, 3600)`.
  Il `CNAME` serve a dichiarare che un nome è un sinonimo di un altro nome, ed è l'unico record che **non contiene un indirizzo**: la risoluzione prosegue con una seconda interrogazione sul nome canonico. La differenza con il record `A` è quindi che l'`A` chiude la catena fornendo l'IP, mentre il `CNAME` la riapre verso un altro nome. Per questo un nome con `CNAME` non può ospitare altri record, perché l'alias è solo un puntamento: è il caso di `www.esempio.com` che punta a `esempio.com`, o dei servizi ospitati su un dominio di terze parti.

- **Tipo `MX` (*mail exchange*):** specifica il nome del server di posta elettronica di riferimento per il dominio.
- **TTL (*time to live*):** intervallo temporale in secondi durante il quale il record può essere memorizzato nella cache dei resolver prima della sua rivalidazione obbligatoria.

**Indirizzo IP, maschera di rete e default gateway:** per inviare un pacchetto su una rete IP ogni host necessita di tre parametri fondamentali.

- **Indirizzo IP:** identifica univocamente l'interfaccia di rete del dispositivo e serve a ricevere informazioni dalla rete.
- **Maschera di rete (*subnet mask*):** determina quale porzione dell'indirizzo IP rappresenta la **rete** e quale l'**host**; il confronto bit a bit tra indirizzi IP mediante la maschera stabilisce se due host si trovano nella **stessa rete locale** oppure in reti differenti.
- **Default gateway:** indirizzo IP del router di uscita dalla rete locale; se il destinatario non appartiene alla stessa rete il pacchetto viene inviato al default gateway per l'inoltro verso altre reti.

Di solito in una configurazione di rete si indicano due DNS, uno principale e uno di backup.

**UDP e TCP nel servizio DNS:** il DNS utilizza prevalentemente **UDP sulla porta 53**, per query e risposte di dimensioni ridotte, e ricorre a **TCP sulla porta 53** per i trasferimenti di zona (*zone transfer*) tra server primario e secondario o quando la risposta non è trasportabile in UDP: la soglia è 512 byte senza EDNS0 e sale a 4096 byte con EDNS0, usato in particolare con DNSSEC.

## Modello ISO/OSI e stack TCP/IP

Il modello **ISO/OSI** (ISO 7498) costituisce il riferimento concettuale e teorico a **7 livelli**, mentre lo stack **TCP/IP** rappresenta l'architettura effettivamente implementata su scala globale a **5 livelli**.

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

**Differenze sostanziali:**

1. **Granularità e praticità:** OSI è nato come modello teorico *a priori*; TCP/IP è nato dall'esperienza operativa di ARPANET ed è il modello realmente adottato.
2. **Collasso di presentazione e sessione:** in TCP/IP le problematiche di formattazione, crittografia (TLS) e gestione dello stato non richiedono livelli dedicati nel sistema operativo, ma sono gestite direttamente dalle librerie applicative.
3. **Strategia di affidabilità multilivello:** in OSI l'affidabilità era teorizzata prevalentemente al livello trasporto; in TCP/IP ogni livello implementa controlli di errore indipendenti (FCS a livello link, checksum IP sull'header, checksum TCP sul segmento), garantendo robustezza end-to-end.

## Dove si attacca la pila dei protocolli

La comprensione dello stack a strati consente di mappare con precisione le vulnerabilità e le relative contromisure di difesa.

| Livello Protocollare | Protocolli Target | Debolezze e Vettori di Attacco Tipici | Contromisure e Difese Primarie |
| :--- | :--- | :--- | :--- |
| **5. Applicazione** | HTTP, FTP, SMTP, DNS | • Trasmissione dati e credenziali in chiaro<br>• Mancata validazione dell'input (SQLi, XSS)<br>• Manipolazione header (`Host`, MIME)<br>• Web Cache Poisoning e DNS Spoofing | • Cifratura applicativa (HTTPS/TLS, SFTP, SMTPS)<br>• Web Application Firewall (WAF) e IPS<br>• Cookie flags (`HttpOnly`, `Secure`, `SameSite`)<br>• Email: DKIM firma il messaggio, SPF autorizza gli IP mittenti, DMARC allinea e applica policy<br>• DNSSEC |
| **4. Trasporto** | TCP, UDP | • Mancanza di cifratura/integrità nativa<br>• TCP SYN Flood (DoS/DDoS)<br>• TCP Session Hijacking (predizione Seq Number)<br>• UDP Amplification Attack | • Protocolli TLS / DTLS su socket<br>• SYN Cookies a livello kernel del SO<br>• Randomizzazione iniziale dei numeri di sequenza<br>• Rate limiting del traffico UDP sui firewall |
| **3. Rete** | IPv4, ICMP, Routing | • Mancanza di integrità del payload in IPv4<br>• IP Spoofing (falsificazione mittente)<br>• ICMP Redirect / Ping of Death<br>• BGP Route Hijacking | • IPsec (AH per integrità e autenticazione, ESP per integrità e confidenzialità)<br>• Filtri anti-spoofing (Ingress/Egress Filtering - BCP 38)<br>• Disabilitazione ICMP Redirect sui router |
| **2. Collegamento** | Ethernet, ARP, Wi-Fi | • Assenza di autenticazione in ARP (ARP Spoofing)<br>• Sniffing su domini broadcast / CAM Table Overflow<br>• Rogue DHCP Server | • Port Security e Dynamic ARP Inspection (DAI)<br>• DHCP Snooping sugli switch gestiti<br>• Segmentazione tramite VLAN e standard 802.1X |
| **1. Fisico** | Cavi, Wi-Fi | • Intercettazione fisica (cable tapping, sniffing RF)<br>• Manomissione hardware e rogue device | • Protezione fisica dei rack e dei condotti di rete<br>• Cifratura end-to-end a prescindere dal canale |

> [!info] Sintesi:
> - Un protocollo definisce formato, ordine dei messaggi e azioni dei nodi; lo standard TCP/IP astrae un canale logico end-to-end dove la distanza fisica è solo latenza.
> - La pila ha cinque livelli con PDU distinti (messaggio, segmento, datagramma, frame, bit); incapsulamento e decapsulamento aggiungono e tolgono header, e i router ispezionano solo fino al livello link/rete.
> - Le socket collegano i processi in user space al kernel; la connessione TCP è identificata da una 5-tupla e le porte si dividono in well-known, registered ed ephemeral.
> - TCP è affidabile e orientato alla connessione, UDP è leggero e best-effort: si sceglie in base a tolleranza alle perdite, banda e latenza richieste.
> - HTTP è stateless, e i cookie con `Secure`, `HttpOnly` e `SameSite` reintrodcono lo stato proteggendo il token di sessione; HTTPS aggiunge TLS su porta 443.
> - FTP usa due connessioni TCP, di controllo e dati, e in chiaro è insicuro; checksum e CRC rilevano solo errori accidentali, non attacchi intenzionali.
> - SMTP è push su porta 25 con SPF, DKIM e DMARC, MIME gestisce allegati e non ASCII, POP3 e IMAP si differenziano per stato e cartelle.
> - Il DNS è una directory distribuita gerarchica su UDP 53 con record A, AAAA, NS, CNAME, MX e TTL; l'host ha bisogno di IP, maschera e default gateway.
> - Ogni livello della pila ha debolezze proprie e contromisure dedicate, dal cable tapping fino a SQLi, XSS e cache poisoning.