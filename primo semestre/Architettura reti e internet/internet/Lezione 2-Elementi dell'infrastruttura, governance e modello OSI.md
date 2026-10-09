# Elementi dell'infrastruttura, governance e modello OSI

## L'era dei social network

L'era dei social networks è l'effetto combinato di due marcate tendenze: la diffusione massiva dei dispositivi cellulari e l'incremento delle capacità computazionali sui dispositivi mobili (CPU multicore, GPU sempre più potenti, facile accesso a strumenti come GPS e fotocamera, ridotto consumo di energia delle ARM). Ne è derivata un'enorme diffusione delle tecnologie Internet in moltissimi ambiti. In parallelo lo sviluppo di nuove tecnologie (AJAX, JavaScript, HTML5) ha permesso di realizzare siti sempre più interattivi e dinamici, rendendo possibile l'avvento del social networking che pervade oggi la vita di molte persone e ci fornisce servizi dei quali non potremmo fare a meno.

I protagonisti di questa fase:

- **Facebook**: fondato da Mark Zuckerberg nel febbraio 2004; nel 2023 il suo patrimonio è stato stimato in 130 miliardi di dollari, sesta persona più ricca al mondo.
- **Twitter**: nasce nel luglio 2006, sulle ceneri della start-up Odeo fondata da Noah Glass, Jack Dorsey, Evan Williams e Biz Stone. I messaggi ("tweets") erano lunghi al massimo 140 caratteri (usati in media 34), poi estesi a 280 (usati in media 33); sono raggruppati in *hashtag* preceduti da `#`, le risposte agli utenti sono indicate con `@`. Acquistato da Elon Musk, che ne ha cambiato il nome in X.
- **LinkedIn**: orientato all'occupazione professionale, nato nel 2002 e lanciato nel maggio 2003; disponibile in 20 lingue, nel 2023 ha dichiarato 830 milioni di utenti in 200 paesi; acquisito da Microsoft nel 2016 per 26,2 milioni di dollari.
- **Instagram**: orientato allo scambio di immagini e video, creato da Kevin Systrom e Mike Krieger e lanciato nell'ottobre 2010; acquisito da Facebook nel 2012, fu oggetto di polemica per aver dichiarato nei termini di servizio di poter rivendere a terzi le immagini degli utenti senza permesso preventivo (clausola poi ritirata). È il quarto social network più usato, dopo Facebook, YouTube e WhatsApp. Anche Flickr usa l'hashtag per identificare utenti e foto.
- **TikTok**: piattaforma di video brevi lanciata nel 2016 dall'azienda cinese ByteDance; la sua popolarità è esplosa rapidamente, diventando una delle app più scaricate al mondo. Gli utenti creano video di 15-60 secondi, spesso con musica o effetti sonori; il feed "Per Te" è personalizzato da un potente algoritmo; l'app offre editing, filtri, effetti e una vasta libreria musicale, con tendenze e sfide virali che coinvolgono milioni di utenti. Ha influenzato cultura pop, musica e marketing ed è diventato uno strumento di espressione creativa e attivismo per molti giovani; restano le preoccupazioni sulla privacy e la sicurezza dei dati, specialmente riguardo ai legami dell'azienda con la Cina.
- **YouTube**: fondata il 14 febbraio 2005 da tre ex dipendenti di PayPal (Steve Chen, Chad Hurley, Jawed Karim) per caricare, condividere e visualizzare video; acquisita da Google nel novembre 2006 per 1,65 miliardi di dollari. Dopo l'acquisizione è continuata a crescere rapidamente, con interfaccia intuitiva e una vasta gamma di contenuti caricati dagli utenti, ed è diventata il principale sito di condivisione video online.
- **WhatsApp**: fondato nel 2009 da Jan Koum e Brian Acton, due ex dipendenti di Yahoo!, con l'idea di base di fornire una piattaforma di messaggistica istantanea che mandasse messaggi di testo via Internet anziché via SMS tradizionali, costosi specialmente per le comunicazioni internazionali; acquisito da Facebook nel febbraio 2014 per 19 miliardi di dollari. È una delle applicazioni di messaggistica più utilizzate al mondo, con miliardi di utenti che inviano messaggi, effettuano chiamate vocali e videochiamate e condividono contenuti multimediali ogni giorno; la sua influenza nella comunicazione mobile è stata enorme e continua a plasmare il modo in cui le persone interagiscono attraverso i loro dispositivi mobili.

> [!todo] La slide riporta l'acquisizione di LinkedIn da parte di Microsoft nel 2016 a 26,2 milioni di dollari; il valore pubblico dell'operazione è 26,2 miliardi.

## Internet: definizione

*Definizione:* Internet è una rete globale di reti che abilita i computer di ogni tipo a comunicare direttamente e in modo trasparente e a condividere servizi attraverso gran parte del mondo. Essendo un'infrastruttura di enorme importanza, capace di attivare così tante persone e organizzazioni, costituisce anche una fonte condivisa e globale di informazioni, conoscenza e senso di collaborazione e cooperazione fra comunità innumerevoli. È definita formalmente nell'**RFC 1122** (originariamente in RFC 760).

> [!info]
> "Jon has been our North Star for decades ... He was the Internet's Boswell and its technical conscience." — Vint Cerf su Jon Postel (6 agosto 1943 – 16 ottobre 1998). Di Postel è anche il motto "Be liberal in what you accept, and conservative in what you send."

**Internet Protocol (IP):** fornisce le funzioni necessarie per l'invio di un pacchetto di bit, chiamato *internet datagram*, da una sorgente a una destinazione usando un sistema interconnesso di reti.

- Sorgente e destinazione sono due **host**, cioè qualsiasi computer (PC, MacIntosh, workstation, server, mainframe), identificati ciascuno da un indirizzo a lunghezza fissa, l'**indirizzo IP**.
- L'IP versione 4 fornisce anche i servizi di frammentazione e riassemblaggio dei datagram, quando la trasmissione avviene attraverso reti con capacità di trasporto di pacchetti più piccola del pacchetto originale (dovuto alle diverse tecnologie di rete del passato). IP versione 6 abolisce questo comportamento.
- Le funzionalità dell'IP sono volutamente limitate alla trasmissione di datagram: l'IP è invocato dai protocolli host-to-host (a livello superiore di astrazione) e a sua volta invoca i protocolli di rete locali (a livello inferiore) per trasportare il datagram al successivo gateway o host di destinazione.

**Routing:** i vari moduli internet usano gli indirizzi presenti nell'*internet header* per trasmettere i datagram verso la loro destinazione, e la selezione del cammino da seguire per la trasmissione si chiama *routing*. Il modello operativo prevede che un modulo internet risieda in ogni host impegnato in comunicazioni internet e in ogni gateway che interconnette reti: questi moduli condividono regole comuni per interpretare i campi dell'indirizzo internet e per frammentare e riassemblare i datagram, mentre i gateway possiedono in più le procedure per effettuare le scelte di routing.

- Il routing è un processo dinamico, che tiene conto delle variazioni istantanee della rete e viene eseguito avvalendosi dei protocolli di routing dinamici.
- L'IP tratta ogni internet datagram come un'entità completamente indipendente dagli altri: **non esistono connessioni o circuiti virtuali**.

## Elementi dell'infrastruttura

<div style="display: flex; justify-content: center;">
  <img src="slide-062.png" style="width: 30%;">
</div>

Lo schema traccia il percorso completo di una comunicazione: si parte dalla postazione dell'utente (home o dial-in, web client, modem, LAN, apparati di casa) e dal *user's location*, si attraversa il collegamento fino ai POP e al data center dell'ISP e si arriva al lato del contenuto online (enterprise networks, web server, server applicativi con relativo firewall e apparati legacy).

**User PC:** è un PC o un dispositivo mobile multimediale equipaggiato per ricevere e inviare ogni tipo di audio e video: scheda audio, microfono e casse; video e scheda grafica (GPU); videocamera e webcam; riconoscitori vocali.

**CPE, gli apparati di casa dell'utente:** sono gli apparati localizzati in casa dell'utente per connettere il PC al *local loop*, detti **Customer Premise Equipment** (CPE) — il confronto con DTE e DCE è in [[Lezione 2-Codifica dei dati, flussi trasmissivi e valutazione delle prestazioni#Gli apparecchi della comunicazione: DTE, DCE e CPE|appunti di protocolli]].

- Linea telefonica ADSL (ADSL Forum)
- Fibra ottica (FTTH)
- Modem/router (NAT, DHCP, firewall, port forwarding)
- LAN, WiFi, firewall

Nello schema il blocco comprende modem, scheda di rete (NIC), il collegamento Ethernet verso casa dell'utente e i *user services* locali (DNS, email, ecc.).

**Local loop (carrier):** è il collegamento che connette la casa dell'utente all'ISP.

- Linee di comunicazione (ADSL)
- Fibra ottica (FTTH)
- Wireless
- Satelliti e ponti radio
- *Cable network*
- *Electric power lines*

Nella figura sono etichettate POTS, DSL e ADSL, *leased lines*, wireless, satellite, cavo e linee elettriche.

**ISP's data center:** è il punto di accesso all'ISP, generalmente il data center centrale. Le connessioni vengono veicolate dalle centrali del fornitore dei servizi di ultimo miglio della rete di accesso (ad esempio Telecom) al fornitore di servizi che ha il diritto di vendere il servizio all'utente.

**User services:** sono i servizi che gli utenti usano durante l'accesso a Internet — Domain Name Server (BIND), host di posta (Sendmail, Postfix), servizi speciali quali SSH, web hosting dell'utente. Questi server richiedono collegamenti veloci, processori potenti e grandi quantità di memoria, e devono essere *fault tolerant* e *load balanced*.

**ISP backbone:** la dorsale dell'ISP interconnette i POP dell'ISP, ciascun ISP agli altri ISP e al contenuto online. Gli elementi sono *backbone providers*, *large circuits* (circuiti in fibra dei *carrier*), router, switch SONET/SDH, gigaswitch e *network access points*. I **NAP** (Neutral Access Point) sono punti di interconnessione fra ISP diversi per ottimizzare il traffico fra operatori; nella figura compaiono anche i collegamenti in *private peering* fra reti di grande capacità.

<div style="display: flex; justify-content: center;">
  <img src="slide-073.png" style="width: 30%;">
</div>

**La gerarchia dei provider:** la stessa architettura vista per livelli, dai provider più in alto fino agli utenti in fondo. In alto compaiono i **Tier 1 Networks** e i **Tier 2 Networks**; sotto i **Tier 3 Network**, che la figura divide in *multi-homed ISP*, collegati a più di un provider superiore, e *single-homed ISP*, collegati a un unico provider; in fondo gli **utenti Internet**, business e consumatori.

**Online content:** sono gli host con cui interagiscono gli utenti: piattaforme per web server e *hosting farm*. I sistemi cloud offrono soluzioni scalabili a costi sostenibili.

**Origini del contenuto online:** sono le sorgenti di informazioni del mondo reale.

- Le informazioni elettroniche esistenti sono connesse con i *legacy systems*, sistemi basati su tecnologie obsolete ma dei quali non si può fare a meno per le loro caratteristiche di affidabilità e sicurezza.
- Le risorse stampate sono acquisite con scanner e trasformate in formato elettronico.
- Molti tipi di informazioni audio e video sono trasmessi in *broadcast* su Internet.
- Voice over IP (VoIP).

## Internet governance

<div style="display: flex; justify-content: center;">
  <img src="slide-078.png" style="width: 30%;">
</div>

Chi c'è dietro Internet e chi la governa? La figura riassume l'evoluzione del governo di Internet dal 1968 al 1996: dall'epoca di ARPANET sotto DARPA e DCA si passa alla fase NSF, poi alla transizione a TCP/IP e a un ambiente multiprotocolare, con i comitati ICCB e ICB, l'IAB, l'IETF e l'IRTF che compaiono negli anni Ottanta, e infine la Internet Society.

La governance di Internet è una struttura complessa ed estremamente meritocratica, formata da:

- i leader storici, che coordinano i vari organismi di standardizzazione;
- i rappresentanti dei governi (dei più forti, ovviamente);
- le aziende che hanno il core business in questo mondo;
- i tecnici e gli sviluppatori che mantengono e sviluppano i principali software;
- gli utenti, che con i canoni che pagano per usare la rete immettono denaro fresco nelle casse delle aziende.

*Definizione:* alcuni standard di Internet richiedono una forma organizzativa per funzionare correttamente, come la gestione dello spazio di indirizzamento IP, dei nomi a dominio, dei numeri di Autonomous System e dei numeri di protocollo IP. La responsabilità complessiva è stata assegnata inizialmente all'**IANA** (Internet Assigned Numbers Authority, `www.iana.org`).

**Regional Internet Registries (RIR):** l'IANA ha delegato ad alcune entità regionali la gestione locale:

- **ARIN** (`www.arin.net`) per le Americhe
- **RIPE NCC** (`www.ripe.net`) per l'Europa
- **APNIC** (`www.apnic.net`) per l'area Asia-Pacifico
- **LACNIC** (Latin America and Caribbean Network Information Centre)
- **AFRINIC** (African Network Information Centre)

**ICANN:** l'ente che coordina i Regional Internet Registries è l'ICANN (Internet Corporation for Assigned Name and Numbers, `www.icann.org`), che ha una struttura più partecipata e democratica rispetto all'IANA.

### Amministrazione di Internet

I grafici descrivono come è finito lo spazio di indirizzamento:

- **Indirizzi IPv4 gestiti da ciascun RIR**, in termini di blocchi /8: l'asse arriva a 60 e i valori leggibili nel grafico sono 53,10, 49,94 e 11,33, quindi nessun RIR supera le poche decine di /8.
- **Spazio IPv4 ancora disponibile in ogni RIR**, sempre in /8: i valori sono bassissimi (0,16, 0,15, 0,08, 0,07, 0,02), cioè lo spazio libero è praticamente esaurito.
- **Spazio IPv4 emesso dagli RIR per anno**, in /8, dal 2019 al 2023, con una serie per ciascun RIR: si continua a emettere poco, perché non ce n'è.
- **Due torte sotto il titolo "How much has been allocated to the RIRs?"**: a sinistra l'**IPv4 address space**, diviso in riserva IETF, blocchi allocati agli RIR prima di ottobre 2006 e blocchi /18+ assegnati; a destra l'**IPv6 address space**, diviso in *link-scoped unicast* /10, *unique local unicast* /7, *multicast* /8 e *global unicast* /3, con la riserva IANA di 504 blocchi /12 e le allocazioni già effettuate ai RIR (prefissi 2a00::/11 per RIPE NCC, 2600::/12 per ARIN, 2400::/12 per APNIC, 2c00::/12 per AFRINIC).
- **Prefissi IPv6 allocati per anno dagli RIR**, dal 2019 al 2023: migliaia di prefissi l'anno, a differenza dell'IPv4.
- **Spazio IPv6 totale allocato** da ciascun RIR, in blocchi /32: i valori in grafico sono 185.966, 136.771, 105.803, 17.221 e 10.436 /32.
- **ASN emessi per RIR** (distinzione fra ASN a 32 bit e a 16 bit), con le emissioni del 2023 per AFRINIC, APNIC, ARIN, LACNIC e RIPE NCC.

### Standard di Internet

Internet esiste a livello tecnico e di sviluppo attraverso la creazione, la verifica e l'implementazione di standard Internet.

- Gli standard sono sviluppati dall'**IETF** (Internet Engineering Task Force, `www.ietf.org`).
- Sono poi esaminati dall'**IESG** (Internet Engineering Steering Group) e promulgati dalla **ISOC** (Internet Society, `www.isoc.org`) come standard internazionali.
- L'**RFC Editor** è responsabile della preparazione e organizzazione dello standard nella forma finale.

### Sviluppo di Internet

L'**IRTF** (Internet Research Task Force, `www.irtf.org`) promuove la ricerca e lo sviluppo di Internet coordinando le attività di diversi gruppi di ricerca. L'IRTF lavora sotto il controllo dell'Internet Research Steering Group, il suo coordinatore fa parte del comitato di gestione dell'IRSG ed è nominato dall'Internet Activity Board (IAB, `www.iab.org`). Le finalità dell'IRTF sono definite nell'RFC 2014.

## Aziende e Internet

### Intranet aziendali

*L'intranet* è il termine che descrive l'uso delle tecnologie Internet all'interno di una organizzazione, invece che per le connessioni esterne con l'Internet globale. Viene realizzata trasferendo la mole di informazione aziendale a ogni individuo con costi, tempo e sforzo minimi; il suo impatto influenza le operazioni della compagnia, la sua efficienza, la ricerca e lo sviluppo.

Prerequisiti per l'attivazione di una intranet aziendale:

- rete locale che interconnetta i computer;
- informatizzazione diffusa dei vari settori.

*Vantaggi:* con la intranet le tecnologie telematiche e i servizi di Internet si diffondono orizzontalmente e verticalmente nella struttura aziendale, divenendo momento di grande partecipazione, formazione e aggiornamento. Internet ha come periferica un computer e da qui origina la sua straordinaria capacità di trasmettere, integrare e rappresentare qualsiasi tipo di informazione; sono inoltre tecnologie che portano all'ottimizzazione e alla riduzione dei costi di comunicazione e marketing.

<div style="display: flex; justify-content: center;">
  <img src="slide-095.png" style="width: 30%;">
</div>

Nello schema ci sono tre sedi (LAN sede A, LAN sede B, LAN sede C), ciascuna con il proprio router e il proprio firewall, che si collegano fra loro attraverso Internet usando tunnel **VPN**: è il caso tipico di una organizzazione multi-sede che estende la propria rete privata sopra la rete pubblica.

**Il router** all'interno della intranet svolge tre funzioni:

- instrada i dati fra i computer della rete aziendale e Internet;
- consente l'attivazione di una politica di controllo degli accessi alla rete locale;
- consente l'accesso controllato e selettivo a computer e servizi.

### Extranet

Con *extranet* si identificano le risorse hardware e software che realizzano la presenza visibile in Internet di una organizzazione: data mining, data warehouse, e-commerce, servizi Web.

Normalmente sono servizi posti in un'area in cui il controllo del firewall è più lasco, la **De-Militarized Zone** (DMZ): i server in quest'area non sono ritenuti critici e i servizi sono in genere replicati da server protetti.

<div style="display: flex; justify-content: center;">
  <img src="slide-098.png" style="width: 30%;">
</div>

Lo schema mostra la posizione della DMZ: la LAN interna, il firewall e il gateway che fanno da confine, e l'area intermedia in cui stanno i server esposti verso l'esterno.

## Modello di riferimento ISO/OSI

Il confronto approfondito con TCP/IP e la struttura dei livelli sono in [[Lezione 1-Fondamenti di networking, teoria della comunicazione e standard#Modelli architetturali di riferimento: ISO/OSI e TCP/IP|Lezione 1 di protocolli]].

*Definizione:* il modello ISO OSI (Open Systems Interconnection) è un modello concettuale che definisce il modo in cui le reti inviano i dati dal mittente al destinatario. È utilizzato per descrivere ogni componente nell'ambito della comunicazione dei dati, in modo da permettere la definizione di regole e standard riguardo alle applicazioni e all'infrastruttura di rete. Il modello contiene sette livelli disposti concettualmente dal basso verso l'alto: **Fisico, Collegamento Dati, Rete, Trasporto, Sessione, Presentazione, Applicazione**.

<div style="display: flex; justify-content: center;">
  <img src="slide-101.png" style="width: 30%;">
</div>

Lo schema mette in fila **End System A**, un **Transit System** e **End System B**: per ogni livello è disegnato il blocco relativo al protocollo (`Application protocol`, `Presentation protocol`, `Session protocol`, `Transport protocol`, `Network protocol`, `Datalink protocol`, `Physical protocol`) e, fra un livello e l'altro, l'*interface* che li mette in comunicazione sulla stessa macchina. Il transit system si occupa dei livelli di rete, mentre i livelli più alti restano fra i due sistemi terminali.

<div style="display: flex; justify-content: center;">
  <img src="slide-102.png" style="width: 30%;">
</div>

La tabella grande ha quattro colonne: livello, protocolli ed esempi di funzioni, apparato centrale e il corrispettivo modello DOD. In sintesi, livello per livello:

- **Application (7)**: apparato centrale l'utente finale; il programma che apre ciò che è stato inviato o crea ciò che deve essere inviato; condivisione di risorse, accesso remoto a file e stampanti, servizi di directory, gestione della rete.
- **Presentation (6)**, *syntax layer*: traduzione dei caratteri, conversione dei dati, compressione, cifratura e decifratura; esempi EBCDIC, TIFF, GIF, PICT, JPEG.
- **Session (5)**: stabilimento, manutenzione e chiusura della sessione, sincronizzazione e invio alle porte logiche, riconoscimento dei nomi e logging; RPC, SQL, NFS, NetBIOS.
- **Transport (4)**: TCP, corrispondenza host-to-host e controllo del flusso; segmentazione del messaggio, accettazione, controllo del traffico e molteplicizzazione delle sessioni; TCP/SPX e UDP.
- **Network (3)**: i pacchetti, che contengono l'indirizzo IP, instradati dai router; decide il percorso, controlla il traffico di sottorete, frammenta i frame, fa la corrispondenza fra indirizzo logico e fisico; protocolli IP, IPX, ICMP.
- **Data Link (2)**: i frame, che contengono l'indirizzo MAC, fra NIC e switch; sequenziamento, accettazione, delimitazione e controllo degli errori del frame, accesso al mezzo; protocolli PPP e SLIP.
- **Physical (1)**: la struttura fisica (cavi, hub), codifica dei dati, attacco al mezzo fisico, tecnica di trasmissione, *baseband* o *broadband*, bit e volt.

<div style="display: flex; justify-content: center;">
  <img src="slide-103.png" style="width: 30%;">
</div>

Il confronto finale fra i due modelli: i livelli Application, Presentation e Session dell'OSI corrispondono alla **Application** del TCP/IP, che raccoglie i protocolli di servizio DHCP, DNS, FTP, HTTP, HTTPS, POP, SMTP, SSH; il Transport OSI si divide in **TCP** e **UDP**; il Network corrisponde alla parte **Internet** con gli indirizzi IPv4 e IPv6; il Data Link e il Physical diventano **Network Access**, basato sull'indirizzo MAC.

> [!info] Sintesi:
> - Internet è definita dall'RFC 1122 come rete globale di reti; l'IP invia datagram indipendenti fra host identificati da indirizzo, senza connessioni né circuiti virtuali, e il cammino lo decide il routing dinamico.
> - L'infrastruttura va dal PC e dagli apparati CPE dell'utente al local loop, al data center e ai servizi dell'ISP, poi al backbone con NAP e peering, fino ai data center del contenuto online.
> - La governance è meritocratica: IANA gestisce spazio di indirizzi, nomi a dominio, ASN e numeri di protocollo e li delega ai cinque RIR regionali, ICANN coordina i RIR; IETF sviluppa gli standard, IESG li esamina, ISOC li promulga, RFC Editor li forma, IRTF cura la ricerca.
> - I grafici IPv4 mostrano che lo spazio disponibile è praticamente esaurito (0,16 /8 o meno per RIR), mentre quello IPv6 è ancora abbondante.
> - L'intranet usa le tecnologie Internet dentro l'organizzazione (router, VPN, controllo accessi), l'extranet le espone in Internet mettendo i server non critici nella DMZ.
> - Il modello ISO/OSI ha sette livelli, dal Fisico all'Applicazione; nel TCP/IP i tre livelli più alti si fondono in Application e i due bassi in Network Access.
