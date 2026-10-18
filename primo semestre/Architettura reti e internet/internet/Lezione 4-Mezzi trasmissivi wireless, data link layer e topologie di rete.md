# Mezzi trasmissivi wireless, data link layer e topologie di rete

I mezzi trasmissivi non guidati consentono la propagazione dei segnali elettromagnetici nello spazio libero, superando i vincoli fisici e geografici della cablatura terrestre.

## Connessioni wireless

La comunicazione wireless consiste nella trasmissione di informazioni a distanza senza l'ausilio di conduttori fisici o fili elettrici:

- comprende l'insieme delle tecnologie, dei protocolli e dei dispositivi che trasmettono segnali elettromagnetici a radiofrequenza o a infrarossi nello spazio;
- permette lo scambio bidirezionale o broadcast di dati senza alcun collegamento meccanico tra gli apparati.

### Vantaggi delle comunicazioni wireless

L'assenza di un'infrastruttura di cablaggio fisico offre benefici operativi ed economici determinanti:

- **Efficienza dei costi:** non richiede la stesura e la manutenzione di complesse linee fisiche di collegamento (cavi in rame o fibra), riducendo drasticamente i costi di impianto;
- **Flessibilità e mobilità:** gli utenti possono stabilire comunicazioni continue e scambiare dati indipendentemente dalla loro posizione geografica;
- **Convenienza e semplicità d'uso:** i dispositivi terminali (come i telefoni cellulari e i calcolatori portatili) operano senza necessità di innesti fisici per inviare o ricevere messaggi;
- **Velocità di connettività:** elevata prontezza nell'attivazione e nell'accesso alla rete;
- **Accessibilità ad aree remote:** consente la copertura di territori isolati, montani o rurali in cui la posa di infrastrutture di terra risulterebbe tecnicamente impossibile o economicamente insostenibile;
- **Connettività costante:** disponibilità del collegamento continuo in movimento.

### Ambiti applicativi e tecnologie wireless

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ret-44.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Panoramica delle tecnologie e dei campi applicativi delle comunicazioni wireless: dai sistemi aerospaziali, GPS e trasporti intelligenti, fino alla telemedicina, comunicazioni cellulari, Internet of Things (IoT), reti locali wireless (Wi-Fi) e collegamenti personali a corto raggio (Bluetooth).
  </div>
</div>

I principali settori applicativi comprendono:

- **Televisione analogica e digitale:** diffusione radiotelevisiva broadcast (terrestre e satellitare);
- **Reti domestiche e aziendali Wi-Fi:** standard IEEE 802.11 per reti locali ad alta velocità;
- **Bluetooth:** comunicazioni a corto raggio per reti personali (PAN, standard IEEE 802.15);
- **Telefonia mobile cellulare:** evoluzione delle reti mobili per trasmissione integrata di voce e dati digitali;
- **Applicazioni satellitari e satelliti di posizionamento:** sistemi GPS e costellazioni di telecomunicazione aerospaziale;
- **Internet of Things (IoT) e telemedicina:** sensori distribuiti a basso consumo per monitoraggio ambientale, industriale e clinico.

## Livello di collegamento (data link layer)

Nel [[Lezione 3-Standard, modello ISO OSI e mezzi trasmissivi#ISO OSI Reference Model|modello OSI]], il livello di collegamento (livello 2) governa le modalità con cui un dispositivo acquisisce l'accesso al mezzo fisico e realizza il trasferimento affidabile dei dati tra nodi adiacenti direttamente connessi.

*Funzioni principali del livello 2:*
- definizione del formato dei dati e incapsulamento dei pacchetti in trame (*framing*);
- frammentazione dei messaggi trasmessi;
- gestione delle procedure di rilevazione e controllo dell'errore;
- controllo del flusso dei dati per evitare la saturazione del ricevitore.

### Dispositivi di rete e domini di collisione

Al livello di collegamento appartengono:

- le schede di interfaccia di rete (**NIC**, *Network Interface Card*);
- i **bridge** (ponti di collegamento tra segmenti);
- i dispositivi di commutazione (**switch**), che operano la separazione dei domini di collisione Ethernet analizzando l'indirizzo fisico di destinazione (*MAC address*).

*Osservazione:* gli hub sono apparati fisici di livello 1 che operano come ripetitori multiporta e condividono un unico dominio di collisione tra tutte le porte; bridge e switch operano invece a livello 2, segmentando il traffico e inoltrando i frame unicamente verso la porta associata al MAC address destinatario.

### Protocolli e sottolivelli IEEE 802

Tra i protocolli storici del livello di collegamento (*Data Link Control Protocols*, DLCP) figurano:

- **BSC** (*Binary Synchronous Communications*);
- **HDLC** (*High-Level Data Link Control*), impiegato per la trasmissione sincrona su linee dedicate numeriche (CDN).

Nelle reti locali ad accesso multiplo (architettura IEEE 802), il livello 2 è suddiviso in due distinti sottolivelli funzionali:

- **LLC (Logical Link Control):** sottolivello superiore, responsabile del controllo d'errore logico, dell'ordinamento dei frame e dell'interfaccia verso il livello di rete;
- **MAC (Media Access Control):** sottolivello inferiore (che scende a contatto con il livello 1), incaricato della gestione dell'indirizzamento fisico e della contesa per l'accesso al canale condiviso (serve a **identificare in modo univoco e permanente** ogni scheda di rete di un dispositivo, consentendo la corretta comunicazione all'interno di una **rete locale**)

## Topologia delle reti

*Definizione:* la disposizione geometrica e funzionale degli elementi costitutivi (collegamenti, apparati intermedi e stazioni terminali) di una rete di comunicazione è definita **topologia di rete**.

La topologia rappresenta un'applicazione diretta della teoria dei grafi:
- i dispositivi comunicanti e i sistemi di instradamento sono modellati come **nodi** (vertici del grafo);
- i mezzi trasmissivi e i canali di interconnessione sono modellati come **collegamenti** (archi o linee del grafo).

Si distingue nettamente tra:
- **Topologia fisica:** la reale disposizione spaziale e collocazione fisica dei dispositivi, dei cablaggi e degli apparati di commutazione;
- **Topologia logica:** il percorso concettuale e le modalità secondo cui i dati e i segnali fluiscono effettivamente tra i nodi della rete.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ret-52.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Tassonomia delle strutture topologiche di rete: collegamento punto-punto (point-to-point), topologia a bus, topologia a stella, topologia ad anello (ring), topologia ad albero (tree), topologia a maglia (mesh) e configurazioni ibride composite.
  </div>
</div>

### Topologia a bus

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ret-53.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Schema della topologia a bus: un unico cavo funge da dorsale comune a cui sono allacciate tutte le stazioni. Il canale &egrave; condiviso in broadcast e richiede terminatori resistivi a entrambi i capi per presentare la corretta impedenza ed evitare riflessioni distruttive del segnale.
  </div>
</div>

Nella topologia a bus, un unico segmento di cavo continuo funge da percorso principale (*backbone*) per i dati, al quale tutte le stazioni sono collegate in derivazione:

- tutti i dati trasmessi da una stazione si propagano lungo l'intera dorsale e risultano fisicamente disponibili a tutte le stazioni in ascolto (canale condiviso broadcast);
- ogni scheda di rete esamina l'indirizzo MAC di destinazione e accetta solo le informazioni destinate a essa, scartando le altre;
- il cavo deve essere terminato su entrambi i capi mediante resistori di terminazione per garantire il corretto adattamento d'impedenza ed evitare la riflessione dell'onda elettromagnetica verso l'interno;
- *Svantaggio principale:* la vulnerabilità al guasto singolo; qualsiasi interruzione o disconnessione lungo il cavo dorsale compromette immediatamente il funzionamento dell'intera rete.

### Topologia a stella

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ret-54.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Schema della topologia a stella: ciascuna stazione terminale &egrave; interconnessa tramite una linea punto-punto dedicata a un controllore centrale di rete (hub o switch), che governa e instrada le comunicazioni isolando i guasti dei singoli cavi.
  </div>
</div>

Ciascuna stazione è connessa direttamente a un dispositivo centrale di controllo (*network controller*, tipicamente un hub o uno switch) mediante un proprio cavo dedicato:

- il controllore centrale gestisce la comunicazione con ciascun nodo indipendentemente dagli altri apparati;
- le moderne reti Ethernet adottano universalmente una topologia fisica a stella, pur potendo comportarsi logicamente come una topologia a bus condiviso (se il centro stella è un hub) o come connessioni commutate punto-punto (se il centro stella è uno switch);
- *Vantaggi:* un eventuale guasto a un cavo periferico isola unicamente la singola stazione interessata, lasciando inalterata l'operatività del resto della rete;
- risolve le anomalie generate dai nodi bloccati in trasmissione continua (*jabbering nodes* = nodi malfunzionanti che inviano trame errate o continue a causa di guasti hardware o cavi difettosi, agevolmente isolabili dalla porta centrale).

### Topologia ad anello

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ret-55.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Schema della topologia ad anello: le stazioni sono collegate in sequenza chiusa lungo un percorso circolare unidirezionale. Nelle reti moderne l'anello logico &egrave; realizzato mediante concentratori MAU (Multistation Access Unit) interconnessi tramite anello principale e nodi cablati a stella.
  </div>
</div>

La topologia ad anello può essere considerata concettualmente come una topologia a bus chiusa su se stessa:

- il cavo interconnette in sequenza tutte le stazioni formando una configurazione circolare chiusa;
- il metodo di accesso impone che i dati e i frame circolino ordinatamente lungo l'anello da una stazione all'altra in un'unica direzione, con ciascun nodo che rigenera il segnale prima di rilanciarlo al successivo;
- nelle architetture reali (come Token Ring di IBM e FDDI), la rete viene implementata con topologia fisica a stella e topologia logica ad anello;
- più unità di concentrazione denominate **MAU** (*Multistation Access Unit*) vengono collegate tra loro ad anello mediante porte *Ring In* (RI) e *Ring Out* (RO), mentre le stazioni terminali sono collegate a stella alle porte delle singole MAU.

### Topologia ad albero

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ret-56.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Schema della topologia ad albero: evoluzione gerarchica a livelli della topologia a stella o bus ramificato. I nodi intermedi instradano i dati lungo la gerarchia fino alle foglie. La comunicazione tra stazioni periferiche su rami distanti risulta inefficiente dovendo risalire la radice.
  </div>
</div>

Costituisce una variante gerarchica della topologia a stella, estendibile a più livelli:

- un nodo centrale (radice) si dirama verso nodi intermedi, i quali forniscono connettività a stazioni locali o instradano il traffico verso ulteriori rami subordinati;
- *Svantaggio di efficienza:* la comunicazione risulta marcatamente inefficiente tra nodi situati su rami periferici opposti della gerarchia, poiché i pacchetti devono percorrere l'intero albero risalendo verso i nodi superiori comuni prima di ridiscendere (la distanza complessiva percorsa è molto maggiore del singolo segmento più lungo).

## Cenni storici sulle reti geografiche (WAN)

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ret-57.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Architettura iniziale delle reti geografiche (WAN) nella seconda met&agrave; degli anni '50: centri EDP altamente centralizzati con elaboratori mainframe, collegamenti remoti punto-punto mediante coppie di modem telefonici e trasmissione periodica a lotti (Remote Batch Transmission).
  </div>
</div>

Le origini e lo sviluppo delle reti geografiche (*Wide Area Network*, WAN) sono strettamente connessi all'evoluzione della prima generazione di calcolatori elettronici nella seconda metà degli anni '50:

- **Elaborazione centralizzata:** il calcolo era concentrato in ristretti centri specializzati di elaborazione dati (*Electronic Data Processing*, EDP) basati su costosi mainframe monolitici;
- **Terminali remoti stupidi:** gli utenti interagivano con l'elaboratore centrale da postazioni geograficamente distanti prive di intelligenza locale (*dummy terminals*);
- **Remote Batch Transmission:** i dati e i programmi venivano trasmessi a lotti (*batch*) tramite linee telefoniche analogiche con interposizione di coppie di modem, richiedendo imponenti investimenti di capitale per le infrastrutture di collegamento.

### Sistema IBM 3270 Information Display

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-ret-58.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Architettura del sistema IBM 3270: mainframe centrale interfacciato a Communication Controller e unit&agrave; di controllo locale. Il collegamento geografico verso la sede remota avviene tramite linea con modem dedicati e Control Unit remota, a cui fanno capo molteplici terminali video e stampanti.
  </div>
</div>

L'architettura **IBM 3270** rappresenta lo standard industriale storicamente dominante per l'interconnessione geografica di terminali a calcolatori centrali:

- il mainframe centrale comunica localmente con un'unità di controllo locale (*Control Unit locale*) e un controllore di comunicazione (*Communication Controller*);
- il collegamento a lungo raggio verso le filiali remote si realizza attraverso coppie di modem sincroni interfacciati alla rete di telecomunicazioni;
- presso la sede periferica, il modem locale si interfaccia a una **Control Unit remota** (come i controller IBM serie 3174/3274);
- la Control Unit remota gestisce il multiplexing e controlla un cluster di terminali video (display IBM 3278/3279) e stampanti locali, inviando i pacchetti strutturati a blocchi di schermata verso il calcolatore centrale.

> [!info] Sintesi:
> - I mezzi trasmissivi wireless consentono comunicazioni senza vincoli fisici, offrendo flessibilità, risparmio infrastrutturale e copertura di aree remote.
> - Il livello Data Link (livello 2) gestisce framing, controllo dell'errore, controllo di flusso e accesso al mezzo (sottolivelli LLC e MAC in IEEE 802).
> - La topologia di rete definisce la disposizione fisica e logica dei nodi secondo i modelli della teoria dei grafi.
> - La topologia a bus condivide un unico canale terminato; la topologia a stella isola i guasti tramite apparato centrale; l'anello fa circolare i dati in un percorso chiuso.
> - Nelle reti locali moderne, la topologia fisica a stella si combina con logiche a bus (Ethernet su hub) o ad anello (MAU in Token Ring/FDDI).
> - Le prime architetture WAN (anni '50 e sistema IBM 3270) si basavano su elaborazione centralizzata su mainframe, modem e unità di controllo remote per terminali.
