# Internet Protocol, indirizzamento IPv4, subnetting e protocolli di supporto (ARP, ICMP, IGMP)

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261016111015.png" width="300">
</div>

## Internet protocol (IP)

*Definizione:* L'utente considera un'internet come una singola rete virtuale che interconnette tutti gli host e attraverso cui è possibile comunicare.

*Definizione:* Il software dell'internet è progettato intorno a tre servizi di rete disposti su scala gerarchica:
- Servizio di consegna del pacchetto senza connessione
- Servizio di trasporto inaffidabile
- Servizi di applicazione

*Definizione:* Consegna senza connessione = ogni pacchetto è consegnato indipendentemente dagli altri.

*Definizione:* Servizio inaffidabile = i pacchetti possono andare persi o fuori sequenza.

*Definizione:* Consegna best-effort = si fa di tutto per consegnare i pacchetti; l'inaffidabilità si verifica solo per malfunzionamenti hardware. È compito dei servizi di più alto livello provvedere a garantire l'affidabilità della trasmissione reinviando i pacchetti persi e ristabilendo la giusta sequenza tra i pacchetti.

### Funzioni dell'IP

*Definizione:* L'IP definisce l'esatto formato dei dati mentre attraversano l'internet TCP/IP.

*Definizione:* L'IP svolge la funzione di routing scegliendo il percorso che dovranno seguire i dati.

*Definizione:* L'IP definisce un insieme di regole che inglobano i concetti di:
- consegna non affidabile dei pacchetti
- elaborazione dei pacchetti da parte di host e gateway
- generazione dei messaggi di errore (ICMP)
- determinazione delle condizioni in cui occorre scartare i pacchetti

### Datagram IP

*Definizione:* L'unità fondamentale di trasferimento è detta datagram IP, divisa in area di intestazione (header), campo di controllo dell'header e blocco dei dati.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261016111047.png" width="300">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261016111101.png" width="300">
</div>

## Formato del datagram IP

*Definizione:* Nell'header del datagram IP sono presenti i seguenti campi:

- **VERS:** campo di 4 bit che indica la versione IP del datagram. La versione attualmente in uso è la 4 (IPv4); si sta introducendo la versione 6 (IPv6) che potenzia l'indirizzo IP a 64 bit e ne estende i servizi e le potenzialità.
- **HLEN:** campo di 4 bit che indica la lunghezza dell'header del datagram in parole da 32 bit.
- **LUNGHEZZA TOTALE:** campo lungo 16 bit che indica la lunghezza totale del datagram in ottetti, compresa l'area dati. La massima dimensione possibile per un datagram è 2^16 = 65535 ottetti.
- **TIPO DI SERVIZIO:** campo di 8 bit che indica come deve essere gestito il datagram. È diviso in 5 sottocampi: 3 bit di PRECEDENZA (valori da 0 a 7) consentono al trasmettitore di specificare l'importanza del datagram. Il software dell'host e dei gateway ignora questo tipo di informazione; se fosse gestito, sarebbe possibile implementare algoritmi di controllo della congestione e attivare servizi basati sul Quality of Service (QoS). Tale anomalia è risolta con IPv6.
- **D, T, R:** 3 bit che specificano il tipo di trasporto desiderato. Se attivi: il bit D chiede un basso ritardo, il bit T richiede un alto throughput, il bit R alta affidabilità. Una internet non garantisce il trasporto richiesto, quindi questo campo va interpretato come indicazione agli algoritmi di routing.
- **IDENTIFICAZIONE, FLAG e OFFSET DEL FRAMMENTO:** controllano la frammentazione e il riassemblaggio dei datagram a seguito dell'incapsulamento nelle trame a livello fisico. Frammentazione e riassemblaggio sono funzioni svolte dai protocolli a livello fisico della rete in cui si opera.
- **TTL:** indica la durata in secondi concessa al datagram per restare nel sistema internet.
- **PROTOCOL:** indica quale protocollo di più alto livello ha generato la porzione DATI trasportata dal datagram (es.: 1=ICMP, 2=IGMP, 16=TCP, 17=UDP).
- **CHECKSUM:** garantisce il controllo dell'integrità dell'header del datagram, mediante calcolo di un algoritmo Cyclic Redundancy Check (CRC) sui bit dell'header.
- **IP ADDRESS DI PROVENIENZA:** indirizzo IP a 32 bit dell'host che ha generato l'informazione contenuta nel datagram.
- **IP ADDRESS DI DESTINAZIONE:** indirizzo IP a 32 bit dell'host al quale è destinata l'informazione contenuta nel datagram. Anche se il datagram è istradato attraverso diversi gateway, questi campi non cambiano mai.
- **DATI:** contiene i dati trasportati dal datagram.
- **OPZIONI IP:** campo opzionale usato per funzioni di test e debugging della rete.
- **RIEMPIMENTO:** area riempita di bit a 0 per garantire che la lunghezza del datagram sia multipla di 32 bit.

## Elaborazione dell'header IP

*Definizione:* Le operazioni svolte sull'header IP sono:
- Calcolo del checksum e verifica della sua validità, verifica che i campi dell'header contengano valori validi
- Analisi della routing table per calcolare il next hop
- Modifica dei campi che richiedono aggiornamento (TTL, header checksum).

## Indirizzi IPv4

*Definizione:* Un indirizzo IP su 32 bit (4 byte) permette di identificare univocamente una rete ed uno specifico host appartenente alla rete: `x.y.z.w` (Es.: 141.250.1.7).

*Definizione:* L'indirizzo si divide in due parti:
- rete
- host

*Definizione:* Esistono 5 tipi di classi di indirizzi IP.

## Classi di indirizzi IP

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261016111201.png" width="300">
</div>

## Connessione alla rete

*Definizione:* Le tre classi primarie (A, B, C) sono identificabili in base ai primi due bit, per cui è agevole per i router estrarre la parte rete e la parte host di un indirizzo IP.

*Osservazione:* L'indirizzo IP identifica la connessione di un host alla rete (non l'host in sé).

*Osservazione:* Macchine (quali i router) con più connessioni alla rete hanno più indirizzi IP: uno per ogni connessione alla rete.

## Indirizzi di rete e broadcast

*Definizione:* Gli indirizzi IP possono far riferimento a reti oppure a host.

*Definizione:* Per convenzione, l'hostid 0 non è mai assegnato ad un singolo host: un indirizzo IP in cui i bit della parte host sono pari a 0 denota la rete stessa ed è chiamato indirizzo di rete.

*Definizione:* Gli indirizzi broadcast sono riservati a tutti gli host della rete e si ottengono ponendo a 1 tutti i bit della parte host dell'indirizzo IP.

## Indirizzi speciali, privati e link-local

*Definizione:* Indirizzi speciali:
- 0.0.0.0 (default route)
- 127.0.0.1 (loopback address)

*Definizione:* Indirizzi di rete e indirizzi broadcast:
- 255.255.255.255 broadcast locale
- x.0.0.0 e x.255.255.255 per una rete di classe A
- x.y.0.0 e x.y.255.255 per una rete di classe B
- x.y.z.0 e x.y.z.255 per una rete di classe C

*Definizione:* Indirizzi privati (RFC 1918), non istradabili dai router (gestiti dai server NAT per la conversione pubblico-privato):
- 10.0.0.0/8
- 172.16.0.0/12
- 192.168.0.0/16

*Definizione:* Indirizzi link-local (RFC 3927), validi solo in una rete locale e non istradati dai router:
- 169.254.0.0/16

*Osservazione:* Tali indirizzi vengono assegnati dal sistema operativo all'interfaccia quando ci sono problemi con l'assegnazione di indirizzi da parte di un server DHCP.

## Configurazione IP

*Definizione:* Per configurare un host IP occorre specificare le seguenti entità:
- Indirizzo IP
- Subnet mask
- Default gateway
- Indirizzo IP del nameserver

*Definizione:* In alternativa si può utilizzare il protocollo DHCP, lasciando gestire tali informazioni a esso. Ciò semplifica la configurazione e permette di cambiare indirizzi/parametri senza intervenire sui client, utile in reti di grandi dimensioni.

*Osservazione:* Errori nella configurazione IP generano malfunzionamenti:
- Se si sbaglia la definizione del default gateway, le applicazioni locali funzionano, mentre quelle verso l'esterno no.
- Un errore nella subnet mask può generare problemi di connettività. Anche se altamente sconsigliabile, la subnet mask può differire tra host della stessa rete, con effetti non predicibili.

## Indirizzamento con subnet e subnetting

*Definizione:* L'indirizzamento con subnet introduce un nuovo livello gerarchico negli indirizzi IP.

*Definizione:* È una tecnica trasparente per le reti e i router remoti, semplifica la gestione delle varie LAN di un'organizzazione.

*Definizione:* Si definisce la subnet mask per trovare il numero associato alla rete.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261016111332.png" width="300">
</div>

### Schema per subnetting

*Definizione:* Considerando l'indirizzo di classe B 141.250.0.0, generalmente ad ogni struttura dell'Università viene assegnato un indirizzo equivalente ad una classe C, con subnet mask 255.255.255.0 (o /24). Per l'indirizzo 141.250.5.25, l'indirizzo della subnet si calcola con l'operazione AND bitwise tra IP e mask:

```
IP:      141     250     5       25
         10001101 11111010 00000101 00011001
Mask:    255     255     255     0
         11111111 11111111 11111111 00000000
AND:
         10001101 11111010 00000101 00000000
Subnet:  141.250.5.0
```

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261016111347.png" width="300">
</div>

### Schema per subnetting (i)

*Definizione:* Per subnet più piccole (circa 100 host) si usa una subnet mask più restrittiva: 255.255.255.128 (/25), ottenendo due reti: 141.250.5.0 e 141.250.5.128.

*Definizione:* L'intervallo degli indirizzi host è rappresentato come segue:

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261016111422.png" width="300">
</div>

*Definizione:* Con subnet mask 255.255.255.128, il primo indirizzo host è 141.250.5.129, l'ultimo 141.250.5.254, l'indirizzo broadcast è 141.250.5.255.

### Subnetting

*Definizione:* Un indirizzo IP di una rete può essere gestito come un insieme di sottoreti introducendo una subnet mask più restrittiva, che assegna i bit più significativi della parte host alla parte network, ottenendo da un indirizzo di una certa classe un insieme di sottoreti di classe inferiore, di dimensioni conseguentemente inferiori.

### Esempio

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261016111456.png" width="300">
</div>

### Subnet mask

*Definizione:* La subnet mask deve avere per la parte rete tutti i bit a 1 (senza 0 nella sequenza della parte di rete).

*Definizione:* Questo implica che i possibili indirizzi di una rete di classe C, ad esempio 194.143.128.0, sono:

```
0                  111111111111111111111111          (/24)
0, 128             1111111111111111111111111         (/25)
0, 64, 128, 192    11111111111111111111111111        (/26)
0, 32, 64, 96, 128, 160, 192, 224  111111111111111111111111111  (/27)
0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240
             1111111111111111111111111111  (/28)
0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 128,
136, 144, 152, 160, 168, 176, 184, 192, 200, 208, 216, 224, 232, 240, 248
             11111111111111111111111111111  (/29)
0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116,
120, 124, 128, 132, 136, 140, 144, 148, 152, 156, 160, 164, 168, 172, 176, 180, 184, 188, 192, 196, 200, 204, 208, 212, 216,
220, 224, 228, 232, 236, 240, 244, 248, 252
             111111111111111111111111111111 (/30)
0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36,
38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72,
74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106,
108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 128, 130, 132, 134, 136,
138, 140, 142, 144, 146, 148, 150, 152, 154, 156, 158, 160, 162, 164, 166,
168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196,
198, 200, 202, 204, 206, 208, 210, 212, 214, 216, 218, 220, 222, 224, 226,
228, 230, 232, 234, 236, 238, 240, 242, 244, 246, 248, 250, 252
             1111111111111111111111111111111  (/31)
```

Ogni riga riporta, in quest'ordine: indirizzi di rete possibili, sequenza di bit a 1 della subnet mask, notazione CIDR.

### Esempio: 194.143.128.0/26

Con subnet mask 255.255.255.192 si ottengono 4 sottoreti, con questi indirizzi di rete e di broadcast:

```
11111111 11111111 11111111 11000000 (Subnet mask: 255.255.255.192)

11000010 10001111 10000000 00 000000  (Rete 194.143.128.0)     0 ind. rete 1     111111 63 ind. broadcast 1
11000010 10001111 10000000 01 000000  (Rete 194.143.128.64)   64 ind. rete 2    111111 127 ind. broadcast 2
11000010 10001111 10000000 10 000000  (Rete 194.143.128.128) 128 ind. rete 3    111111 191 ind. broadcast 3
11000010 10001111 10000000 11 000000  (Rete 194.143.128.192) 192 ind. rete 4    111111 255 ind. broadcast 4
```

### Subnetting: aspetti topologici e organizzativi

*Definizione:* La realizzazione di subnet comporta l'alterazione del comportamento standard della classe primaria IP mediante l'introduzione di una subnet mask che ne altera il significato.

*Definizione:* La decisione di creare una sottorete dipende da aspetti topologici ed organizzativi.

*Osservazione:* Ragioni topologiche:
- **Superamento limiti di distanza:** a seconda del tipo di rete considerata occorre considerarne le caratteristiche fisiche e le specifiche di interfaccia. Ad esempio ogni segmento UTP deve essere al massimo lungo 100 m. La lunghezza dei cavi della rete è data dalla somma di tutti i segmenti, incluse le bretelle di giunzione negli armadi e i segmenti che vanno dalla presa di rete all'interfaccia di rete dei singoli host.
- **Connessione di reti fisiche diverse:** router IP possono collegare reti con diversa tecnologia o diverso mezzo trasmissivo (da token ring a ethernet, o tra ethernet con diverso mezzo trasmissivo, es.: fibra-cavo coassiale).
- **Filtro del traffico fra reti:** il traffico locale rimane nella sottorete locale; solo il traffico verso altre reti è inviato al gateway.

### Subnetting e supernetting

*Definizione:* Mediante subnetting si suddivide una rete primaria in più sottoreti differenti, autonome dal punto di vista del routing e del TCP/IP.

*Definizione:* Mediante supernetting si accorpano più reti fisiche primarie diverse in un'unica rete per semplificare le informazioni di routing da trasmettere ai router.

*Osservazione:* Ragioni organizzative:
- **Amministrazione:** delega della gestione degli indirizzi, controllo e diagnostica a piccole entità.
- **Visibilità di strutture:** singole strutture (es.: dipartimenti universitari) necessitano di autonomia per organizzare i servizi.
- **Isolamento del traffico:** per motivi di sicurezza, isolare il traffico locale per renderlo inaccessibile all'esterno.

*Osservazione:* Ragioni tecniche:
- Ottimizzazione dell'uso dello spazio di indirizzamento IP
- Limitazione del dominio di broadcast IP
- Limitazione degli effetti di eventuali malfunzionamenti

### Piano di indirizzamento IP

*Definizione:* Documento che il network administrator deve scrivere e tenere aggiornato per descrivere l'utilizzo del proprio spazio di indirizzamento IP.

Esempio:

| Indirizzo | Subnet mask | Descrizione |
|---|---|---|
| 194.143.128.0/26 | 255.255.255.192 | rete interna 1 |
| 194.143.128.64/26 | 255.255.255.192 | rete interna 2 |
| 194.143.128.128/25 | 255.255.255.128 | rete interna 3 |
| 194.143.129.0/30 | 255.255.255.252 | punto-punto 1 |
| 194.143.129.4/30 | 255.255.255.252 | punto-punto 2 |
| 194.143.129.8/29 | 255.255.255.248 | rete lab 1 |
| 194.143.129.16/28 | 255.255.255.240 | rete lab 2 |
| 194.143.129.32/27 | 255.255.255.224 | rete lab 3 |
| 194.143.129.64/26 | 255.255.255.192 | rete lab 3 |
| 194.143.129.128/25 | 255.255.255.128 | rete amm 1 |

## Famiglia di protocolli TCP/IP

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261016120308.png" width="300">
</div>

## Address resolution protocol (ARP)

*Definizione:* Nel modello ISO/OSI, quando un pacchetto di livello 3 (Network) viene incapsulato in un protocollo di livello 2 (Data Link, in genere Ethernet), occorre inserire nell'header l'indirizzo Data Link.

*Definizione:* Un host Internet può comunicare con un altro host solo se ne conosce l'indirizzo fisico del protocollo di rete locale (es.: indirizzo Ethernet).

*Definizione:* Se l'host destinatario appartiene alla stessa rete del mittente, occorre conoscerne l'indirizzo fisico; se appartiene ad altra rete, occorre conoscere l'indirizzo fisico del gateway.

*Osservazione:* Gli indirizzi fisici (Ethernet) non possono essere desunti, in quanto preassegnati dal produttore alla scheda di rete (e possono essere alterati).

*Definizione:* ARP fornisce il servizio di risolvere la corrispondenza indirizzo IP – indirizzo fisico.

*Definizione:* L'host A invia un pacchetto broadcast chiedendo all'host il cui indirizzo IP è specificato di rispondere fornendo il proprio indirizzo fisico.

*Definizione:* Ciascuna macchina ha una cache ARP che memorizza gli indirizzi risolti per consultazioni successive.

*Osservazione:* La cache ARP è un esempio di soft state: le informazioni possono diventare obsolete senza preavviso; il problema è gestito da timer che ne fanno scadere la validità.

*Definizione:* L'host che effettua la richiesta ARP via broadcast include il proprio indirizzo fisico nel pacchetto broadcast, cosicché tutti gli host possono aggiornare l'informazione nella propria cache.

*Definizione:* Il protocollo è composto funzionalmente dai processi di:
- determinazione degli indirizzi fisici quando si trasmette un pacchetto da un host ad un altro
- risposta a richieste ARP di altre macchine

*Osservazione:* Il meccanismo di richiesta via broadcast può generare problemi (metodo best-effort di Ethernet, errori hardware, ecc.):
- l'aggiornamento dei dati in cache allo scadere del timer può portare ritardi (jitter), per cui si effettua la rivalidazione anticipata
- impatto sull'operatività degli altri protocolli in presenza di richieste ARP pendenti

## Reverse address resolution protocol (RARP)

*Definizione:* Le workstation diskless hanno bisogno di caricare il sistema operativo e la configurazione da uno o più server, effettuando una richiesta broadcast con il protocollo RARP.

*Definizione:* L'host spedisce la richiesta RARP a un server mediante un pacchetto broadcast in cui è evidenziato il MAC address dell'host mittente, e attende dallo stesso una risposta che include l'IP address a partire dall'indirizzo fisico trasmesso in fase di richiesta. Se la richiesta è ripetuta, rispondono anche i server secondari.

*Osservazione:* L'identificatore unico è l'indirizzo fisico della macchina.

*Osservazione:* Richiesta e risposta ARP differiscono per il campo tipo della frame. Il server, nel rispondere, scambia gli indirizzi mittente/destinatario, cambia il contenuto del campo tipo e trasmette l'indirizzo IP.

## Il protocollo ICMP

*Definizione:* Il protocollo Internet Control Message Protocol (ICMP) è stato progettato per riportare anomalie che accadono nel routing dei pacchetti IP e per verificare lo stato della rete.

*Definizione:* I vari tipi di messaggi ICMP sono:

| Codice | Messaggio | Codice | Messaggio |
|---|---|---|---|
| 0 | Echo Reply | 13 | Timestamp Request |
| 3 | Destination Unreachable | 14 | Timestamp Replay |
| 4 | Source Quence | 15 | Information Request |
| 5 | Redirect | 16 | Information Replay |
| 8 | Echo Request | 17 | Address Mask Request |
| 11 | Time Exceeded for a Datagram | 18 | Address Mask Replay |
| 12 | Parameter Problem on a Datagram | | |

I messaggi si dividono in messaggi che riportano anomalie e messaggi di verifica della raggiungibilità di un nodo.

*Definizione:* Il messaggio Redirect indica una condizione di stimolo per un instradamento migliore dei pacchetti, in quanto un router è stato attraversato inutilmente (ha dovuto ritrasmettere il messaggio sulla stessa rete da cui lo ha ricevuto). Quando un host riceve un pacchetto di routing redirect associa un router diverso da quello di default a quella destinazione.

*Definizione:* I messaggi Mask Request e Address Mask Reply sono stati introdotti per permettere ad una interfaccia di scoprire automaticamente la netmask usata in quella rete.

> [!todo] slide 36: nella tabella i simboli che distinguono i messaggi di anomalia da quelli di raggiungibilità non sono leggibili nel PDF, quindi non è indicato quali codici appartengono a ciascun gruppo.

## IP multicasting

*Definizione:* IP multicasting è definito come la trasmissione di un datagram ad un gruppo di host: un insieme di host identificato da un indirizzo IP di destinazione.

*Definizione:* Un datagram multicast è inviato a tutti i membri del suo gruppo di host di destinazione con la stessa affidabilità best effort di un datagram unicast: il datagram non è garantito che arrivi a tutti i membri del gruppo di destinazione o nello stesso ordine rispetto ad altri datagram.

*Definizione:* Gli appartenenti al gruppo possono cambiare dinamicamente: gli host possono aggiungersi o uscire dal gruppo senza limitazioni, anche se è possibile definire una chiave di accesso che renda l'ingresso nel gruppo selettivo.

*Definizione:* Un gruppo di host può essere permanente (in questo caso ha un indirizzo IP ben noto ed assegnato amministrativamente) o transitorio.

*Definizione:* La creazione di gruppi transitori ed il mantenimento delle informazioni relative alla composizione dei gruppi è responsabilità dei multicast agents, che sono entità che girano sui routers o su host speciali.

*Definizione:* I multicast agents sono responsabili anche dell'invio in Internet dei datagram multicast. Se un host di destinazione è in una rete diversa rispetto a quella degli altri host, il multicast agent diventa esso stesso destinatario del datagram e lo consegna ad altri agenti fino alla consegna all'host destinatario.

## Internet group management protocol (IGMP)

*Definizione:* IGMP è il protocollo che supporta le funzioni di IP multicasting, consentendo ad un host di creare, unirsi ad un gruppo multicast o di abbandonarlo.

*Definizione:* IGMP provvede anche all'invio di datagram IP ad un gruppo di host. Esso richiede l'implementazione di IGMP e l'estensione di servizi IP e della rete locale al fine di gestire IP multicast.

*Definizione:* È definito negli RFC 966, RFC 1112, RFC 1122, RFC 1812, RFC 2236, RFC 2715, RFC 2933, RFC 3228.

> [!info] Sintesi:
> - L'IP consegna datagram in best-effort e senza connessione, con header che riporta versione, lunghezza, TTL, protocollo, checksum e indirizzi sorgente/destinazione.
> - Un indirizzo IPv4 è su 32 bit, diviso in rete e host, e si articola in 5 classi con indirizzi speciali, privati (RFC 1918) e link-local (RFC 3927).
> - Il subnetting suddivide una rete con una subnet mask più restrittiva, stabilita dal piano di indirizzamento; il supernetting fa il percorso inverso.
> - ARP traduce indirizzo IP in indirizzo fisico con richiesta broadcast e cache soft state; RARP fa l'inverso per le workstation diskless.
> - ICMP segnala anomalie di routing e verifica la raggiungibilità; con il multicast i datagram arrivano a gruppi di host, gestiti da IGMP.
