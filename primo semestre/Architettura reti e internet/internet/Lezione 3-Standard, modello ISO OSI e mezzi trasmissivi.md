# Standard, modello ISO/OSI e mezzi trasmissivi

## Standards

Gli standard e il lavoro delle organizzazioni di standardizzazione sono stati fondamentali per lo sviluppo delle telecomunicazioni:

- definiscono le caratteristiche fisiche e operative degli apparati di rete;
- la loro adozione aiuta la vendita dei prodotti;
- il processo di standardizzazione favorisce l'interconnessione e l'integrazione di hardware prodotto da costruttori diversi.

Esistono standard *de jure*, cioè codificati da organismi nazionali o internazionali, e standard *de facto*, affermatisi per la massiccia adozione da parte degli utenti.

Gli enti di standardizzazione internazionale sono descritti anche in [[Lezione 1-Fondamenti di networking, teoria della comunicazione e standard#Gli enti di standardizzazione internazionale|Lezione 1 (protocolli)]].

## Organizzazioni di standardizzazione

### IEEE

L'*Institute of Electrical and Electronic Engineers* (IEEE) è molto attivo nello sviluppo di standard di comunicazione dati (Communication Society, COMSOC). Il sottocomitato **802** ha iniziato i lavori nel 1980, prima che fosse stabilito un valido mercato per le reti locali, segnando comunque un avanzamento teorico fondamentale.

Il progetto 802 è concentrato sull'interfaccia fisica degli apparati e sulle procedure richieste per stabilire, mantenere e terminare le connessioni tra dispositivi di rete, inclusi:

- la definizione del formato dei dati,
- il controllo dell'errore,
- le attività per il controllo del flusso dell'informazione.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-110.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  La tabella dei gruppi di lavoro dello standard IEEE 802, con numero, nome e ambito (Topic): Internetworking (routing, bridging e comunicazioni rete-rete), Logical Link Control (controllo d'errore e di flusso sui frame), Ethernet LAN, Token Bus LAN, Token Ring LAN, Metropolitan Area Network (802.6, tecnologie, indirizzamento e servizi MAN), Network Security (controllo degli accessi, cifratura e certificazione), Wireless Networks, High-Speed Networking (tecnologie oltre i 100 Mbps, come 100BASE-VG), Cable Broadband LANs and MANs (reti su connessioni broadband coassiali), Wireless Personal Area Networks (coesistenza con altri dispositivi wireless in bande non licenziate) e Broadband Wireless Access (interfaccia atmosferica e funzioni del Wireless Local Loop, WLL).
  </div>
</div>

### CCITT - ITU

Il lavoro del CCITT (poi ITU) è articolato in periodi quadriennali chiamati *Study Period*, al termine dei quali un'assemblea plenaria emana le raccomandazioni. Alcune raccomandazioni storiche per i modem:

- V.21: modulazione duplex a 300 bit/s;
- V.22: 1200 bit/s;
- V.22bis: 2400 bit/s;
- V.32: fino a 9600 bit/s;
- V.32bis: fino a 14400 bit/s;
- V.34: fino a 28800 bit/s.

### ISO

L'*International Standards Organization* (ISO) è un organo consulente dell'ONU. Il suo scopo è promuovere lo sviluppo di standard nel mondo, con l'obiettivo di favorire lo scambio internazionale di cose e servizi; ne sono membri oltre 100 organizzazioni standard nazionali. Il maggior successo dell'ISO nel campo delle telecomunicazioni è stato il concepimento del modello a sette livelli **Open Systems Interconnection (OSI) Reference Model**.

## ISO OSI Reference Model

Il modello definisce un impianto concettuale sulla base del quale è possibile definire le modalità di interconnessione dei sistemi informatici e fornisce un modello di riferimento per confrontare diverse implementazioni di protocolli di rete, proprietari e non. Rimane però fondamentalmente uno strumento teorico e concettuale, con uno scarsissimo numero di implementazioni di servizi: per esempio ISO/IEC 10021 per la posta elettronica (X.400) e ISO/IEC 9594 per i servizi di Directory (X.500).

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-104.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Lo schema accosta il modello OSI, con hub, switch e router collocati ai livelli bassi che competono loro, ai livelli concettuali del TCP/IP, dove le funzioni dei livelli alti si raccolgono in <i>Application</i> e quelle dei livelli bassi in <i>Network Interface</i>.
  </div>
</div>

OSI introduce il concetto di **sistema** — risorse hardware, risorse software, periferiche, programmi — e di **applicazione**, cioè il programma che elabora i dati ed eroga servizi; OSI si preoccupa dello scambio di informazioni tra sistemi. Il modello a sette livelli e il confronto con TCP/IP sono in [[Lezione 2-Elementi dell'infrastruttura, governance e modello OSI#Modello di riferimento ISO/OSI|Lezione 2]].

## Definizioni

In una tipica struttura di rete i cerchi rappresentano i **nodi** della rete, connessi tra loro mediante dei *communication path*; i percorsi tra due nodi sono *information path*.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-115.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Rappresentazione grafica di nodi, <i>communication path</i> e <i>information path</i>.
  </div>
</div>

## Architettura a livelli

La suddivisione in livelli adotta l'approccio scientifico di dividere un problema complesso in più sotto-problemi, più agevoli da risolvere: risultano sette livelli, ciascuno deputato a uno specifico insieme di servizi.

Ad eccezione dei livelli 1 e 7, ciascun livello è collegato ai livelli precedente e successivo e sfrutta i servizi del livello immediatamente inferiore; un dispositivo deve potersi connettere con un qualsiasi altro dispositivo in rete.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-116.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  L'elenco dei sette livelli, dalla base al vertice: Physical (Layer 1), Data Link (2), Network (3), Transport (4), Session (5), Presentation (6) e Application (7), secondo la CCITT Recommendation X.200.
  </div>
</div>

I livelli adiacenti comunicano attraverso le loro interfacce. Ogni livello è costituito da una o più **entità**, e le entità appartenenti allo stesso livello in sistemi diversi sono dette *peer entities*. Le entità usano i servizi del livello inferiore e forniscono servizi al livello superiore mediante il proprio *Service Access Point* (SAP); le operazioni specifiche di un livello sono realizzate mediante un insieme di protocolli.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-120.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Lo schema accosta due entità adiacenti: ciascun livello eroga servizi al livello superiore e ne fruisce dal livello inferiore, mentre le entità omologhe dialogano tramite il protocollo di livello N-1.
  </div>
</div>

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-121.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Lo schema dell'interfaccia SAP fra livello N e livello N-1 e il passaggio da (N)-PDU a (N-1)-SDU con l'aggiunta delle informazioni di controllo.
  </div>
</div>

La figura seguente mostra i dati che scendono lungo i livelli fino alla sequenza di bit trasmessa sul mezzo fisico.

<div style="display: flex; justify-content: center;">
  <img src="slide-105.png" width="300">
</div>

**PDU, SDU e PCI:** <u>lo scopo di ciascun livello è fornire servizi al livello superiore</u>, con cui comunica attraverso l'interfaccia detta SAP (*Service Access Point*). I dati N-PDU (*Protocol Data Unit*) generati da un protocollo di livello N, una volta attraversata l'interfaccia SAP tra il livello N e il livello N-1, diventano (N-1)-SDU (*Service Data Unit*); ogni livello N-1 aggiunge ai dati N-PDU ricevuti dal livello superiore N le informazioni di controllo (N-1)-PCI (*Protocol Control Information*).

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-106.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  L'incapsulamento progressivo: il messaggio dei livelli alti diventa messaggio TCP/UDP con l'header di trasporto, poi datagram IP con l'header di rete, infine frame di livello 2 con header e footer.
  </div>
</div>

## Intermediate Systems (IS)

End System A e End System B eseguono lo stack completo dei livelli; il **Router**, cioè l'*Intermediate System*, si ferma al livello di rete. Ogni tratta ha il proprio mezzo fisico: mezzo fisico 1 e mezzo fisico 2.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-122.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Lo stack completo dei sette livelli nei due End System e il Router, <i>Intermediate System</i>, che si ferma al livello di rete; i due tratti hanno mezzi fisici distinti.
  </div>
</div>

## Physical layer

Al livello più basso, il **livello fisico**, è un insieme di regole che specificano le connessioni elettriche e fisiche tra i dispositivi. Questo livello specifica le connessioni dei cavi e il tipo di segnale elettrico associato ai vari pin di connessione delle interfacce utilizzate per trasferire dati tra i diversi dispositivi di rete.

<div style="display: flex; justify-content: center;">
  <img src="slide-123.png" width="300">
</div>

Il *physical link* corrisponde agli standard di interfaccia dei vari dispositivi; appartengono a questo livello, per esempio, le interfacce **RS232**, **V.24**, **V.35** e **SONET/SDH**. Le regole definiscono la trasmissione dati per i terminali, i modem, le schede di rete e così via.

## Mezzi trasmissivi

### Doppino

Un **doppino ritorto**, detto anche coppia bifilare, è un tipo di linea di trasmissione composto da una coppia di conduttori in rame isolati; è un elemento essenziale nella telefonia e in Ethernet.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-125.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  La composizione del doppino: una coppia di conduttori in rame con l'isolante, la schermatura e la guaina esterna che avvolge il cavo in rame.
  </div>
</div>

Esistono diversi tipi di doppino a seconda della schermatura; l'**UTP** (*Unshielded Twisted Pair*) è il più utilizzato per Ethernet.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-126.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  I tipi di doppino secondo la schermatura mostrano conduttore, isolante, una coppia o più coppie, schermatura e guaina nelle varianti UTP, FTP, S/FTP e S/STP.
  </div>
</div>

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-127.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  I cavi di diverse categorie nelle varianti UTP, STP, SFTP e FTP: al crescere della categoria il cavo diventa più rigido e più affidabile.
  </div>
</div>

Il doppino UTP ha queste caratteristiche:

- è il mezzo più economico;
- è facile da installare;
- consente di realizzare il cablaggio strutturato degli edifici;
- la connessione delle stazioni avviene mediante il connettore **RJ45**;
- è l'evoluzione del singolo doppino in rame: più doppini vengono torti in maniera molto precisa, in modo da ridurre al minimo le interferenze elettromagnetiche, e affiancati in una guaina.

*Svantaggi:* è fortemente soggetto a disturbi di macchine elettriche e luci fluorescenti e agisce da antenna: più è lungo il segmento, maggiore è il disturbo. Per ridurre i disturbi si usa lo *Shielded Twisted Pair* (STP), ma è troppo costoso e difficile da stendere.

I cavi UTP non sono schermati; perché un impianto sia certificato deve essere realizzato con cavi di Cat 5/5e, mentre per Gigabit Ethernet servono cavi di qualità superiore schermati. Le categorie disponibili:

| Categoria | Velocità | Larghezza di banda | Coppie utilizzate |
| :--- | :--- | :--- | :--- |
| Cat 5 | fino a 100 Mbps (FastEthernet) | 100 MHz | 4/8 |
| Cat 5e | fino a 1 Gbps | 100 MHz | 8 |
| Cat 6/6A | fino a 10 Gbps | 250-500 MHz | 8 |
| Cat 7/7A | fino a 10 Gbps | 600-1000 MHz | 8 |
| Cat 8/Supra Cat 8 | fino a 40 Gbps | fino a 1600-2000 MHz | 8 |

### Cavo coassiale

Il **cavo coassiale** è un cavo elettrico utilizzato come mezzo trasmissivo di un segnale elettrico informativo.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-131.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  La sezione del cavo coassiale: il conduttore centrale, il dielettrico che lo avvolge, la protezione intrecciata, la protezione laminata e il rivestimento esterno.
  </div>
</div>

I cavi coassiali vengono prodotti di diversi tipi in funzione della frequenza del segnale da trasportare e della potenza dello stesso. I valori di impedenza sono principalmente due:

- **50 ohm**: usato negli apparecchi per le misure elettriche ed elettroniche e nella trasmissione dati;
- **75 ohm**: per i segnali televisivi, analogici e digitali.

È il cavo originale usato nelle reti Ethernet e ArcNet ed è costituito da un filo di rame centrale, ricoperto da un dielettrico, poi da una calza in rame e infine dalla guaina in polietilene. Esistono due versioni per Ethernet, entrambe con impedenza 50 ohm:

- cavo *thick* (RG-8), con diametro 0.4";
- cavo *thin* (RG-58), con diametro 0.25".

La *thick Ethernet* usa il transceiver, collegato con un cavo a 9 fili (lunghezza massima 50 m) a un connettore AUI a 15 pin; la *thin Ethernet* usa un connettore a T con innesto a baionetta.

### Fibre ottiche

Una **fibra ottica** è una fibra flessibile e trasparente, realizzata trafilando vetro (silice) o plastica fino a raggiungere un diametro poco più spesso di quello di un capello umano. Le fibre ottiche sono usate per trasmettere la luce tra le due estremità della fibra e trovano largo impiego nelle comunicazioni; consentono distanze più lunghe e larghezze di banda (velocità di trasferimento dati) più elevate rispetto ai cavi elettrici.

*Vantaggi:* è il mezzo trasmissivo del futuro, economico e relativamente sicuro; è immune da interferenze elettriche; teoricamente supporta velocità di trasmissione illimitate; l'installazione è stata notevolmente semplificata. Piccoli laser o diodi emittenti convertono il segnale elettrico in segnale ottico, mentre la funzione inversa è svolta da un ricevitore dotato di foto-detector.

*Svantaggi:* la terminazione del cavo è abbastanza complessa e eventuali interruzioni del cavo richiedono interventi complessi.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-136.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Lo schema di un collegamento in fibra: box ottico, bretelle ottiche e in rame, transceiver e modulo GBic, con le tratte in rame verso le LAN alle due estremità.
  </div>
</div>

**Funzionamento e struttura.** La fibra è formata da un *core* centrale, dal *cladding* che lo circonda, dal rivestimento primario e dalla guaina protettiva.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-137.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  La struttura della fibra ottica: <i>core</i>, <i>cladding</i>, rivestimento primario e guaina protettiva.
  </div>
</div>

La luce si propaga guidata: un raggio incidente che colpisce la superficie di separazione tra core e cladding viene in parte rifratto e, oltre l'angolo critico, riflesso completamente all'interno della fibra.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-138.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  La propagazione della luce: raggio incidente e raggio rifratto, l'angolo critico e il fenomeno della riflessione totale interna che confina il raggio nel core.
  </div>
</div>

A seconda di come la luce si propaga si distinguono fibre **multimodali**, in cui più modi (*different modes*) percorrono il core, e fibre **monomodali**, in cui il core è così sottile da ammettere un solo modo.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-139.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Il confronto fra fibra multimodale e monomodale: nella multimodale più raggi seguono percorsi diversi nel core, nella monomodale ne passa uno solo.
  </div>
</div>

### Connessioni wireless

La comunicazione **wireless** prevede la trasmissione di informazioni a distanza senza l'ausilio di fili, cavi o altre forme di conduttori elettrici. È un termine ampio, che incorpora tutte le procedure e le forme di connessione e comunicazione tra due o più dispositivi che utilizzano un segnale wireless attraverso tecnologie e dispositivi di comunicazione wireless, e prevede il trasferimento di informazioni senza alcun collegamento fisico tra i punti.

*Vantaggi:*

- **Efficienza dei costi:** la comunicazione via cavo comporta l'uso di fili di collegamento, mentre nelle reti wireless non serve un'infrastruttura fisica elaborata né manutenzione, quindi i costi sono ridotti.
- **Flessibilità:** consente alle persone di comunicare indipendentemente dalla loro posizione.
- **Convenienza:** i dispositivi senza fili, come i telefoni cellulari, sono semplici e permettono a chiunque di usarli ovunque si trovi, senza collegare fisicamente nulla per ricevere o trasmettere messaggi.
- **Velocità:** la connettività di rete o l'accessibilità migliorano in termini di precisione e velocità.
- **Accessibilità:** le aree remote in cui le linee di terra non possono essere posate vengono facilmente collegate alla rete.
- **Connettività costante.**

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-143.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  La mappa delle applicazioni della comunicazione wireless: aerospazio, trasporti, computer, Internet of Things, GPS, ambito medicale e Bluetooth.
  </div>
</div>

**TV analogica e digitale:**

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-144.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  La televisione analogica e digitale: canali digitali divisi in bande separate, LNB e ricezione con decoder DTT o SAT verso il televisore.
  </div>
</div>

**Reti domestiche WiFi:**

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-145.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Schematizzazione di una rete domestica WiFi.
  </div>
</div>

**Bluetooth:**

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-146.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Le applicazioni Bluetooth: periferiche del PC, cuffie, stampanti, mouse, navigatori per auto, orologi, domotica, beacon, videocamere digitali, accessori per sport e fitness, glucometri, contapassi, termometri, monitor sanitari, audio portatile e vivavoce.
  </div>
</div>

**Telefonia mobile:**

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-147.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  L'evoluzione della telefonia mobile: 1G con voce analogica a 2,4 kbps, 2G con voce digitale e dati semplici a 64 kbps, 3G con mobile broadband a 2.000 kbps, 4G con trasmissione più veloce e migliore a 100.000 kbps, 5G con velocità fino a 1 Gbps per applicazioni nel mondo reale.
  </div>
</div>

> [!info] Sintesi:
> - Gli standard, codificati *de jure* o affermatisi *de facto*, definiscono le caratteristiche fisiche e operative degli apparati e rendono interoperabile hardware di costruttori diversi.
> - IEEE sviluppa gli standard 802 su interfaccia fisica, formato dei dati, controllo d'errore e di flusso; CCITT-ITU emana raccomandazioni per periodo quadriennale, come la serie V per i modem; l'ISO ha concepito il modello OSI.
> - Il modello ISO/OSI è un impianto concettuale per l'interconnessione dei sistemi, rimasto quasi solo teorico (X.400, X.500), che introduce i concetti di sistema e applicazione.
> - L'architettura a livelli divide il problema in sette livelli: ogni livello usa i servizi di quello inferiore ed eroga i propri al superiore, comunicando tramite le interfacce SAP; entità omologhe dialogano con un protocollo, e i dati passano da N-PDU a (N-1)-SDU aggiungendo le informazioni di controllo (N-1)-PCI.
> - Il livello fisico specifica connessioni e segnali (RS232, V.24, V.35, SONET/SDH) e si appoggia ai mezzi trasmissivi.
> - I mezzi trasmissivi sono il doppino (UTP/STP, connettore RJ45, categorie fino a Cat 8), il cavo coassiale (50 e 75 ohm, thick/thin), la fibra ottica (core, cladding, multimodale o monomodale) e le connessioni wireless (TV, WiFi, Bluetooth, telefonia mobile).
