	# SNMP, DHCP e NAT

## Protocollo SNMP

*Definizione:* protocollo applicativo standard per il monitoraggio e la gestione di nodi, apparati di rete (router, switch, hub, access point), server e stampanti in un ambiente TCP/IP.

Consente agli amministratori di sistema di controllare da remoto lo stato di salute dei dispositivi, raccogliere statistiche prestazionali, modificare parametri operativi e ricevere notifiche tempestive di guasti o anomalie prima che provochino l'interruzione dei servizi.

Usando SNMP gli amministratori di sistema possono indirizzare richieste e comandi ai nodi della rete, monitorando lo stato delle risorse e delle applicazioni.

### Architettura SNMP

L'architettura di gestione si compone di 5 elementi cardine:

1. **Managed Nodes (Agent):** processo demone in esecuzione su ciascun apparato gestito. Raccoglie e aggiorna lo stato delle risorse locali e risponde alle richieste del gestore sulla porta **UDP 161**.
2. **Network Management Station (Manager / NMS):** applicazione di controllo centrale che interroga periodicamente gli agenti, elabora allarmi e invia comandi di riconfigurazione.
3. **Management Information Base (MIB):** archivio concettuale strutturato contenente l'insieme di tutti gli oggetti e le variabili gestibili all'interno dell'apparato.
4. **Protocollo SNMP:** protocollo di trasporto applicativo che formalizza i messaggi di query, risposta e allarme asincrono.
5. **Structure of Management Information (SMI):** standard che stabilisce le regole di denominazione, tipizzazione e codifica delle variabili memorizzate nella MIB.

### Evoluzione delle versioni

- **SNMPv1 (RFC 1157):** prima versione standard; utilizza l'autenticazione tramite stringa di testo condivisa (*community string*) trasmessa in chiaro sulla rete (solitamente `public` per sola lettura e `private` per scrittura). Vulnerabile a intercettazione.
- **SNMPv2p (RFC 1441, RFC 1445, RFC 1446, RFC 1448, RFC 1449):** versione intermedia.
- **SNMPv2 (RFC 1901, RFC 1902, RFC 1903, RFC 1904, RFC 1905, RFC 1906, RFC 1907, RFC 1908, RFC 1909, RFC 1910):** introduce la PDU `GetBulkRequest` per scaricare grandi tabelle in un unico messaggio, contatori a 64 bit per interfacce ad alta velocità e codici di errore dettagliati. Mantiene l'autenticazione debole tramite community string in chiaro.
- **SNMPv3 (RFC 2026, RFC 2200):** introduce un framework di sicurezza modulare:
  - *Autenticazione crittografica:* basata su algoritmi HMAC-MD5 o HMAC-SHA per garantire l'integrità del messaggio ed evitare attacchi di mascheramento o alterazione della sequenza dei pacchetti.
  - *Privacy (Confidenzialità):* cifratura del payload tramite DES o AES per impedire lo sniffing di rete.
  - *Controllo accessi (VACM):* definizione granulare dei diritti di lettura/scrittura su porzioni dell'albero MIB per ciascun gruppo o utente.

La grossa limitazione mostrata fino alla versione SNMPv2 riguarda la sicurezza (credenziali in chiaro). SNMPv3 è la versione più recente, che corregge queste limitazioni.

## Structure of Management Information (SMI)

*Definizione:* è l'insieme delle regole che definiscono il nome delle variabili MIB. Include definizioni di base come:

- **Indirizzo:** valori costituiti da 4 byte.
- **Contatore:** intero da 0 a $2^{32}-1$.

È specificato con l'**Abstract Syntax Notation 1 (ASN.1)**, standard ISO. Specifica:

- La sintassi dei nomi (in formato leggibile all'utente).
- La codifica binaria (nel formato usato nei messaggi).
- Lo spazio dei nomi è assoluto e gerarchico.

### ASN.1

Il nucleo dell'SNMP è costituito dagli oggetti gestiti dagli agenti che vengono letti e scritti dal Manager. È fondamentale uno standard per la definizione degli oggetti SNMP e per il modo di codificare e trasferire queste informazioni in rete.

SNMP per questa funzione usa un sottoinsieme delle regole definite nell'Abstract Syntax Notation 1 (ASN.1) del protocollo ISO/OSI.

I tipi permessi in SNMP dell'ASN.1 sono: `INTEGER`, `BIT STRING`, `OCTET STRING`, `NULL`, `OBJECT IDENTIFIER`.

### Basic Encoding Rules (BER)

ASN.1 definisce il modo univoco in cui i valori dei tipi ASN.1 sono convertiti senza ambiguità in una sequenza di bytes, che viene detta **Basic Encoding Rules (BER)**. La codifica è ricorsiva, così che la codifica di un oggetto composto risulta dalla concatenazione delle codifiche degli oggetti componenti.

Ciascun valore trasmesso deve essere costituito dai campi:

- **Identificatore:** tipo o estensione.
- **Lunghezza:** del campo dati in bytes.
- **Campo dati.**

A seguito dell'adozione dell'ASN.1 per SNMP sono state definite 4 macro e 8 tipi di dati che sono usatissimi in SNMP, descritti da Structure of Management Information (SMI).

## Albero degli Object Identifiers (OID)

*Object IDentifier* contiene i criteri per definire un oggetto. Si segue una struttura ad albero di standard e si pone qualsiasi oggetto o standard in una regione precisa dell'albero.

La porzione usata da SNMP ha come radici gli organismi di standardizzazione ISO e CCITT (ora ITU). Dalla radice si dipartono degli archi che definiscono sotto-organizzazioni, le quali hanno associato sia una etichetta che un numero.

Tutti gli oggetti MIB SNMP vengono identificati da un'etichetta (cammino sull'albero) del tipo:

```text
{iso (1) . identified-organization (3) . dod (6) . internet (1) . mgmt (2) . mib-2 (1) …}
```

o, alternativamente:

```text
{ 1 . 3 . 6 . 1 . 2 . 1 …}
```

Prefisso numerico canonico: **`1.3.6.1.2.1`**.

Per identificare una specifica variabile foglia si concatena il cammino numerico aggiungendo `.0` per le variabili scalari:

- Variabile `ipInReceives` (pacchetti IP ricevuti):
  - Etichetta: `iso.org.dod.internet.mgmt.mib.ip.ipInReceives`
  - OID numerico: `1.3.6.1.2.1.4.3` (istanza scalare `1.3.6.1.2.1.4.3.0`)

## Management Information Base (MIB)

*Definizione:* ogni oggetto mantiene una serie di variabili SNMP che descrivono il suo stato. La collezione di tutti i possibili oggetti in una rete è chiamata **Management Information Base**, MIB.

Il Manager comunica con gli Agent mediante il protocollo SNMP che gli consente di conoscere lo stato delle variabili MIB e di modificarle se opportuno. A volte capitano eventi imprevisti: si genera un **SNMP trap**. La stazione (manager) può chiedere informazioni sullo stato delle variabili mediante messaggi. Se si verificano trap i messaggi si intensificano: questo modo di operare è denominato **polling orientato ai trap**.

### Categorie MIB

Gli oggetti che appartengono a MIB sono raggruppati in categorie che corrispondono a nodi al di sotto del nodo `mib-2` della struttura ad albero. Esse servono per definire le categorie di base per ciò che deve essere compreso dal Manager. In futuro verranno aggiunte altre categorie e oggetti; i produttori di hardware di rete potranno definire oggetti aggiuntivi per i loro prodotti.

| Gruppo MIB | Numero OID | N° Oggetti | Descrizione e metriche monitorate |
|---|---|---|---|
| `system` | `1.3.6.1.2.1.1` | 7 | Descrizione hardware/software, `sysUpTime`, contatto amministrativo, nome host (`sysName`) e posizione fisica (`sysLocation`). |
| `interfaces` | `1.3.6.1.2.1.2` | 23 | Tabella delle schede di rete (NIC): stato operativo, MTU, velocità, pacchetti/byte ricevuti e trasmessi, errori e pacchetti scartati. |
| `at` | `1.3.6.1.2.1.3` | 3 | *Address Translation*: conversione tra indirizzi fisici (MAC) e IP (deprecato in SNMPv2 e migrato dentro i gruppi IP e ARP). |
| `ip` | `1.3.6.1.2.1.4` | 42 | Statistiche di livello rete: routing IP, frammentazione, riassemblaggio, pacchetti scartati per assenza di route. |
| `icmp` | `1.3.6.1.2.1.5` | 26 | Contatori dei messaggi [[Lezione 5-Internet Protocol, indirizzamento IPv4, subnetting e protocolli di supporto (ARP, ICMP, IGMP)|ICMP]] inviati e ricevuti suddivisi per tipologia (Echo, Unreachable, Time Exceeded). |
| `tcp` | `1.3.6.1.2.1.6` | 19 | Parametri e contatori [[Lezione 6-UDP e TCP e routing|TCP]]: connessioni attive, connessioni stabilite, segmenti trasmessi, segmenti ritrasmessi, algoritmo di timeout. |
| `udp` | `1.3.6.1.2.1.7` | 6 | Statistiche sul traffico datagrammi UDP: datagrammi recapitati e porte non in ascolto (*No Port*). |
| `egp` | `1.3.6.1.2.1.8` | 20 | Statistiche sui protocolli di routing esterno all'[[Lezione 7-Protocolli di routing|Autonomous System]] (Exterior Gateway Protocol). |
| `transmission` | `1.3.6.1.2.1.10` | - | Gruppo riservato a statistiche sui mezzi trasmissivi fisici specifici (es. Ethernet). |
| `snmp` | `1.3.6.1.2.1.11` | 29 | Metriche sulle transazioni SNMP stesse: pacchetti inviati, richieste errate, trap generate. |

### Variabili MIB principali

| MIB Variable | Category | Meaning |
|---|---|---|
| `sysUpTime` | system | Time since last reboot |
| `ifNumber` | interfaces | Number of network interfaces |
| `ifMtu` | interfaces | MTU for a particular interface |
| `ipDefaultTTL` | ip | Value IP uses in time-to-live field |
| `ipInReceives` | ip | Number of datagrams received |
| `ipForwDatagrams` | ip | Number of datagrams forwarded |
| `ipOutNoRoutes` | ip | Number of routing failures |
| `ipReasmOKs` | ip | Number of datagrams reassembled |
| `ipFragOKs` | ip | Number of datagrams fragmented |
| `ipRoutingTable` | ip | IP Routing table |
| `icmpInEchos` | icmp | Number of ICMP Echo Requests received |
| `tcpRtoMin` | tcp | Minimum retransmission time TCP allows |
| `tcpMaxConn` | tcp | Maximum TCP connections allowed |
| `tcpInSegs` | tcp | Number of segments TCP has received |
| `udpInDatagrams` | udp | Number of UDP datagrams received |

### Forma sintattica MIB

Le variabili sono scritte come sequenze di numeri, con il punto come delimitatore. Nei messaggi viene usata la codifica numerica. Ad esempio, il prefisso per il nodo di gestione è `1.3.6.1.2.1`.

Tutti i comandi di gestione sono codificati come operazioni di lettura o scrittura di variabili. Ad esempio, per effettuare il reboot di un dispositivo si scrive 0 nella variabile che corrisponde al tempo che manca fino al reboot.

MIB è un insieme di variabili e la semantica per effettuare operazioni di lettura e scrittura su di esse.

MIB II è definito nell'RFC 1213. Nel documento sono definiti 175 oggetti appartenenti ai gruppi visti, con gli oggetti suddivisi per gruppo. Per ciascun oggetto viene descritta la funzione.

## Messaggi e operazioni SNMP

Il Manager e gli Agenti comunicano scambiando messaggi PDU:

- `GetRequest`: il Manager richiede il valore di una o più variabili MIB indicate tramite OID.
- `GetNextRequest`: richiede il valore dell'oggetto lessicograficamente successivo nell'albero MIB. Utilizzato per scandire interamente tabelle e liste senza conoscerne a priori gli indici.
- `GetBulkRequest`: (introdotto in SNMPv2) richiede l'estrazione massiva di blocchi di variabili o intere tabelle MIB con un singolo round-trip.
- `SetRequest`: il Manager modifica o assegna il valore di una variabile scrivibile sull'Agent (es. impostare a 0 il contatore di spegnimento per comandare il riavvio immediato dell'apparato).
- `GetResponse`: messaggio di risposta inviato dall'Agent al Manager contenente i valori delle variabili richieste o codici di eccezione/errore.
- `InformRequest`: notifica asincrona scambiata da Manager a Manager per coordinamento in architetture gerarchiche distribuite.
- `Trap` (`snmpv2-trap`): notifica asincrona non sollecitata inviata dall'Agent al Manager sulla porta **UDP 162** al verificarsi di un evento critico (es. link down di un'interfaccia, riavvio imprevisto, tentata violazione di accesso).

SNMP definisce 7 tipi di messaggi per svolgere queste funzioni: 6 di query ed 1 di risposta. Possono essere riportati errori.

## Strumenti di gestione: Nagios

Nagios è un sistema di supervisione open source ampiamente utilizzato che si integra nativamente con SNMP. Sfrutta architetture a plugin per inviare interrogazioni SNMP ad agenti remoti, aggregare gli allarmi, generare notifiche automatiche (email/SMS) ed esporre cruscotti web interattivi sullo stato dell'infrastruttura.

---

## Protocollo DHCP

*Definizione:* protocollo applicativo client/server (RFC 2131) che fornisce una procedura automatica e centralizzata per configurare i parametri di rete TCP/IP degli host.

### Evoluzione da RARP e BOOTP

- **RARP (*Reverse ARP*):** operava a livello Data Link (Ethernet). Consentiva solo di ottenere un indirizzo IP a partire dal MAC address, richiedendo un server dedicato su ogni segmento fisico poiché i frame di livello 2 non attraversano i router.
- **BOOTP (*Bootstrap Protocol*, RFC 1534):** incapsulato in datagrammi UDP (porta 67 per il server e 68 per il client), consentiva il passaggio di default gateway e boot file. Era limitato a configurazioni statiche (l'amministratore doveva pre-registrare ciascun MAC address nel file `/etc/bootptab`).
- **DHCP:** estende BOOTP introducendo l'assegnazione automatica e riusabile di indirizzi da un pool dinamico temporizzato (*lease*), oltre a decine di parametri di configurazione facoltativi.

DHCP non è utilizzato per configurare i router; si basa sul paradigma client-server: gli host designati (dall'amministratore) ad essere server DHCP assegnano indirizzi di rete e comunicano i relativi parametri di configurazione ai client.

### Meccanismi di allocazione degli indirizzi

1. **Allocazione manuale (statica):** l'amministratore riserva un indirizzo IP fisso a una specifica scheda di rete mappando il suo MAC address. DHCP elimina l'errore umano di configurazione locale garantendo consistenza centralizzata.
2. **Allocazione automatica:** DHCP assegna permanentemente un indirizzo IP libero a un client al suo primo avvio; l'indirizzo non viene revocato a meno di modifiche manuali.
3. **Allocazione dinamica:** DHCP concede in prestito un indirizzo IP al client per un tempo limitato (*lease time*). Se il client non ne rinnova l'utilizzo o si disconnette, l'indirizzo ritorna nel pool e viene riassegnato ad altri host, massimizzando il riutilizzo degli indirizzi disponibili.

### Ciclo di assegnazione: Procedura DORA

L'inizializzazione del client attraversa 4 fasi sequenziali scambiate in broadcast:

1. **`DHCPDISCOVER` (Client -> Broadcast):** il client non possiede ancora un indirizzo IP. Invia un pacchetto UDP con IP sorgente `0.0.0.0` e destinazione broadcast limitata `255.255.255.255` (da porta UDP 68 a porta 67) per rilevare i server DHCP presenti.
2. **`DHCPOFFER` (Server -> Client/Broadcast):** ogni server DHCP che riceve il Discover e possiede un IP libero riserva provvisoriamente l'indirizzo e risponde inviando una proposta contenente: IP offerto (`yiaddr`), subnet mask, tempo di lease, indirizzo del gateway e del server.
3. **`DHCPREQUEST` (Client -> Broadcast):** il client seleziona una delle offerte ricevute e invia in broadcast un messaggio di richiesta specificando l'indirizzo del server prescelto. La trasmissione in broadcast avvisa contemporaneamente tutti gli altri server del rifiuto delle loro offerte, consentendo loro di liberare gli indirizzi prenotati.
4. **`DHCPACK` (Server -> Client):** il server prescelto conferma l'assegnazione registrando il lease e trasmettendo i parametri di rete definitivi. Il client memorizza i parametri e avvia i timer di conteggio del lease.

   - In caso di incoerenza o se l'indirizzo è stato riassegnato nel frattempo, il server invia un **`DHCPNAK`**, costringendo il client a ricominciare la procedura da capo.

**Messaggi ausiliari:**

- `DHCPDECLINE`: inviato dal client al server se rileva (tramite un ARP probe preliminare) che l'IP assegnato è già utilizzato abusivamente da un altro host sulla LAN.
- `DHCPRELEASE`: inviato dal client per rinunciare volontariamente e liberare l'indirizzo IP prima della scadenza naturale del lease.
- `DHCPINFORM`: inviato da un host che possiede già un indirizzo IP configurato staticamente ma necessita di richiedere solo parametri accessori (DNS, domini di ricerca).

### Macchina a stati finiti (FSM) del client DHCP

Il comportamento temporale del client è descritto da una FSM con due timer cardine:

- **Timer $T_1$ (Renewal Timer):** fissato convenzionalmente al **50%** della durata totale del lease.
- **Timer $T_2$ (Rebinding Timer):** fissato convenzionalmente all'**87.5%** ($7/8$) della durata del lease.

Stati di funzionamento:

1. `INIT`: stato di partenza all'avvio. Invia `DHCPDISCOVER` e transita in `SELECTING`.
2. `SELECTING`: raccoglie le offerte `DHCPOFFER`, seleziona la migliore, invia `DHCPREQUEST` e transita in `REQUESTING`.
3. `REQUESTING`: attende la risposta del server. Se riceve `DHCPACK` passa in `BOUND`; se riceve `DHCPNAK` torna in `INIT`.
4. `BOUND`: stato operativo a regime; l'host comunica regolarmente sulla rete usando l'IP concesso. Allo scadere di $T_1$ (50% del tempo), invia un `DHCPREQUEST` in modalità *unicast* al solo server concedente e transita in `RENEWING`.
5. `RENEWING`: se il server risponde con `DHCPACK`, il lease viene reimpostato al 100% e il client torna in `BOUND`. Se il server non risponde, al raggiungimento di $T_2$ (87.5% del tempo) il client passa in `REBINDING`.
6. `REBINDING`: il client invia messaggi `DHCPREQUEST` in modalità *broadcast* a tutti i server DHCP della rete. Se un server risponde con `DHCPACK`, il client rinnova il lease e torna in `BOUND`; se il lease scade completamente senza alcuna risposta, o in caso di `DHCPNAK`, il client deve immediatamente cessare l'uso dell'indirizzo IP e ripartire dallo stato `INIT`.

<div style="display: flex; justify-content: center;">
  <img src="images/slide-snmp-40.png" width="500">
</div>

### Formato del messaggio DHCP

Il pacchetto ricalca la struttura fissa dell'header BOOTP:

- `op` (1 byte): tipo operazione (`1` = BOOTREQUEST dal client, `2` = BOOTREPLY dal server).
- `htype` (1 byte) e `hlen` (1 byte): tipo e lunghezza dell'indirizzo hardware (es. `1` e `6` per Ethernet).
- `hops` (1 byte): conteggio dei relay attraversati (inizializzato a 0 dal client).
- `xid` (*Transaction ID*, 4 byte): numero casuale scelto dal client per abbinare richieste e risposte.
- `secs` (2 byte): secondi trascorsi dall'avvio della procedura di configurazione.
- `flags` (2 byte): bit più significativo indica il flag Broadcast (richiede al server di rispondere in broadcast se il client non è in grado di ricevere unicast prima di configurare l'IP).
- `ciaddr` (*Client IP address*, 4 byte): indirizzo IP corrente del client (valorizzato solo se il client è in stato BOUND, RENEW o REBIND; `0.0.0.0` durante il Discover).
- `yiaddr` (*Your IP address*, 4 byte): indirizzo IP che il server assegna al client.
- `siaddr` (*Server IP address*, 4 byte): indirizzo IP del server da contattare per il bootstrap successivo.
- `giaddr` (*Gateway / Relay IP address*, 4 byte): indirizzo IP del Relay Agent se il messaggio ha attraversato router.
- `chaddr` (*Client Hardware address*, 16 byte): indirizzo MAC del client.
- `sname` (64 byte): nome simbolico opzionale del server.
- `file` (128 byte): percorso del file immagine di boot (per boot da rete PXE).
- `options` (lunghezza variabile): parametri aggiuntivi TLV introdotti dal magic cookie `99.130.83.99`.

**Opzioni DHCP frequenti:**

- *Opzione 53 (DHCP Message Type):* identifica il tipo di messaggio (1=Discover, 2=Offer, 3=Request, 4=Decline, 5=Ack, 6=Nak, 7=Release, 8=Inform).
- *Opzione 1 (Subnet Mask).*
- *Opzione 3 (Routers / Default Gateway).*
- *Opzione 6 (Domain Name Servers).*
- *Opzione 15 (Domain Name).*
- *Opzioni di livello Link e IP:* Interface MTU, Broadcast address, Ethernet encapsulation.
- *Opzioni di livello TCP e Applicativo:* Default TTL, Keepalive interval, NIS domain name, NIS server list.

<div style="display: flex; justify-content: center;">
  <img src="images/slide-snmp-41.png" width="500">
</div>

### DHCP Relay Agent (RFC 1542)

I router bloccano per definizione i pacchetti con indirizzo IP di destinazione broadcast limitato (`255.255.255.255`). Per evitare di dover installare un server DHCP fisico in ciascuna sottorete:

- Si configura il router intermedio (o un host del segmento) come **DHCP Relay Agent**.
- Il Relay Agent intercetta i pacchetti broadcast `DHCPDISCOVER` e `DHCPREQUEST` generati dai client locali, inserisce il proprio indirizzo IP di interfaccia nel campo **`giaddr`** dell'intestazione DHCP, e li re-incapsula in pacchetti unicast inoltrandoli al server DHCP centralizzato.
- Il server DHCP, leggendo il campo `giaddr`, deduce la sottorete a cui il client appartiene e alloca un indirizzo IP appartenente al pool corretto.

### Configurazione del server ISC dhcpd (`/etc/dhcpd.conf`)

```text
# Impostazioni e opzioni globali
default-lease-time 86400;      # Durata predefinita del lease (24 ore)
max-lease-time 604800;          # Durata massima consentita (7 giorni)
option subnet-mask 255.255.255.0;
option domain-name "unipg.it";
option domain-name-servers 192.168.12.1, 192.168.3.5;

# Configurazione del pool dinamico per la sottorete
subnet 192.168.12.0 netmask 255.255.255.0 {
    option routers 192.168.12.1;
    option broadcast-address 192.168.12.255;
    range 192.168.12.64 192.168.12.192;
    range 192.168.12.200 192.168.12.250;
}

# Prenotazioni statiche per specifici client
group {
    use-host-decl-names true;
    host moe {
        hardware ethernet 00:80:c7:aa:a8:04;
        fixed-address 192.168.12.4;
    }
    host larry {
        hardware ethernet 08:80:20:01:59:c4;
        fixed-address 192.168.3.16;
    }
}
```

---

## Network Address Translation (NAT)

*Definizione:* meccanismo (RFC 1631) implementato tipicamente sui router di confine che interconnettono una rete privata locale con la rete pubblica Internet, effettuando la traslazione dinamica degli indirizzi IP.

NAT è un servizio concepito per realizzare la conservazione degli indirizzi IP. È un servizio che permette a reti IP private di connettersi ad Internet. NAT viene eseguito da un router, che connette normalmente due reti, traducendo gli indirizzi della rete interna in indirizzi IP pubblici, ritornando al client la rispettiva risposta.

NAT viene configurato in modo da convertire tutti gli indirizzi di una rete privata in un unico indirizzo pubblico. Questo fornisce un elemento di sicurezza molto robusto, perché nasconde la rete all'esterno.

### Indirizzi IP privati (RFC 1918)

Vengono usati indirizzi privati invece degli indirizzi di classe A, B e C. Gli indirizzi privati permettono di lavorare all'interno di reti locali private. Pacchetti con indirizzi IP privati **NON SONO GESTITI** dai router.

Per rallentare l'esaurimento degli indirizzi IPv4 pubblici sono stati riservati tre blocchi di indirizzi per l'uso esclusivo nelle reti interne:

- `10.0.0.0/8` (da `10.0.0.0` a `10.255.255.255`)
- `172.16.0.0/12` (da `172.16.0.0` a `172.31.255.255`)
- `192.168.0.0/16` (da `192.168.0.0` a `192.168.255.255`)

I pacchetti aventi come sorgente o destinazione un indirizzo privato **non vengono instradati dai router pubblici di Internet**: vengono immediatamente scartati per evitare collisioni di routing globali.

### Port Address Translation (PAT / NAPT)

Il NAT moderno opera combinando indirizzo IP e numeri di porta TCP/UDP:

- Tutti gli host della rete privata condividono l'unico indirizzo IP pubblico assegnato all'interfaccia WAN del router.
- Quando un host privato (es. `192.168.0.10:1234`) invia un pacchetto verso Internet, il router NAT riscrive l'indirizzo IP sorgente con il proprio indirizzo pubblico e la porta con un numero effimero libero (es. `128.100.10.15:50001`), registrando l'associazione nella propria tabella di traslazione (*Address Translation Table*).
- Quando il server remoto risponde a `128.100.10.15:50001`, il router NAT consulta la tabella, riconosce la sessione, ripristina IP e porta originali (`192.168.0.10:1234`) e inoltra il pacchetto all'host della rete interna.

NAT mappa ogni indirizzo privato + porta nel corrispondente indirizzo IP pubblico + porta. Una tabella di traduzione permette ai pacchetti di essere istradati in modo non ambiguo.

**Implicazioni architetturali:**

- *Vantaggi:* massiccio risparmio di indirizzi IPv4 pubblici; sicurezza perimetrale passiva (la topologia e gli indirizzi interni rimangono invisibili dall'esterno, impedendo a un host esterno di avviare una connessione non richiesta verso un host privato).
- *Limiti:* rottura del principio fondante *end-to-end* di Internet; complicazione notevole per servizi server o protocolli peer-to-peer situati dietro NAT; significativo sovraccarico computazionale per i router di confine (ricalcolo continuo del checksum IP e TCP/UDP). Questi limiti hanno costituito uno dei principali motori per lo sviluppo di [[Lezione 12-IPv6|IPv6]].