# Internetworking, il villaggio globale e la storia di Internet

## La rivoluzione di Internet

Internet ha rivoluzionato il mondo dei computer e delle comunicazioni: è la principale rivoluzione tecnologica del XX secolo e il più rivoluzionario mezzo di comunicazione umana. <u>Si tratta di un evento culturale oltre che tecnologico.</u>

È un'infrastruttura di sviluppo per le istituzioni, le professioni, la gente, i paesi: distrugge il tempo e lo spazio e abolisce le frontiere e le barriere di ogni tipo. Il cambiamento non è stato graduale, ma una trasformazione continua e pervasiva dell'intero ecosistema delle comunicazioni.

## Internetworking

L'*internetworking* è il processo e il risultato dell'interconnessione di reti eterogenee in un'unica infrastruttura globale. I tratti caratteristici:

- **Reti di reti:** non una singola rete, ma un agglomerato di reti che si uniscono tra loro.
- **Autostrade elettroniche:** servono a collegare isole di connettività precedenti e isolate.
- **Interconnessione di sistemi aperti:** nessun nodo proprietario e nessun single point of controllo.
- **Crescita esponenziale:** sia della rete sia dei servizi che su di essa si possono erogare, con le intranet aziendali e nuovi applicativi via web o app per smartphone.

## Il villaggio globale

### La ricerca scientifica

L'evoluzione delle reti della ricerca ha due direttrici: le **infrastrutture**, cioè la rete GARR, la rete italiana della ricerca e dell'istruzione superiore, e il **software per didattica e valutazioni online**.

La ricerca scientifica nel villaggio globale si articola in:

- posta elettronica e videoconferenza;
- accesso a risorse remote, con SSH e Remote Job Entry;
- HPC, cioè accesso remoto a risorse di calcolo ad alte prestazioni;
- machine learning;
- cybersecurity.

Nascono inoltre rapporti nuovi fra docenti e studenti: laboratori virtuali, simulazioni, software per didattica e valutazioni online.

### Le aziende

Marketing e branding, social networking, rapporti con clienti e con la rete di vendita, intranet, e-commerce.

### Le pubbliche amministrazioni

La rete delle pubbliche amministrazioni, oggi AgID e in precedenza AIPA e poi DigitPA, il Codice dell'amministrazione digitale (CAD) e l'Agenda digitale, la dematerializzazione degli atti e delle informazioni, il riuso dei sistemi e delle applicazioni esistenti, l'adozione di software libero (*FLOSS*), il disaster recovery.

## Banda base, banda larga, collisioni e indirizzo MAC

**Collisioni e perdita di pacchetti in Ethernet:** su un mezzo condiviso due host che trasmettono nello stesso istante fanno collisione, il frame viene perso e la trasmissione va ritentata, occupando il canale e rallentando tutto il traffico.

A rendere Ethernet scalabile non è l'hub, ma lo **switch**: ogni porta è un dominio di collisione separato, lo switch impara gli indirizzi MAC dalla sorgente e inoltra i frame solo sulla porta della destinazione, eliminando di fatto le collisioni fra host.

### La logica a bus

La **logica a bus** è il modo di trasmettere di Ethernet prima dello switch: tutte le stazioni sono collegate a un **unico mezzo fisico condiviso**, un solo cavo che le attraversa e sul quale il segnale di una stazione si propaga in entrambe le direzioni, con un terminatore a ciascuna estremità che lo assorbe per evitare riflessi.

- **Un solo canale per tutti:** chi trasmette occupa l'intero mezzo; nessun'altra stazione può trasmettere contemporaneamente. Ogni stazione riceve comunque tutto il traffico e tiene solo i frame il cui indirizzo MAC di destinazione è il proprio, o quelli broadcast.
- **Prima di parlare si ascolta:** ogni stazione deve verificare che il canale sia libero (*carrier sense*) prima di trasmettere.
- **Se due parlano insieme, il frame si distrugge:** le due trasmissioni si sovrappongono sulla linea e il segnale risultante è incomprensibile. È la **collisione**, che rende necessaria la ritrasmissione e occupa il canale, rallentando tutto il resto della rete.
- **Come si gestisce:** con il protocollo **CSMA/CD**, *Carrier Sense Multiple Access with Collision Detection*: trasmissione 1-persistente, e in caso di collisione un segnale di *jamming* per allertare tutti, un *backoff* casuale con crescita esponenziale e poi un nuovo tentativo.
- **Conseguenze:** la banda è condivisa, quindi si ripartisce fra le stazioni attive e il throughput cala all'aumentare del carico; anche la distanza massima è limitata dalle attenuazioni del segnale, per esempio circa 500 m nel 10BASE5 su cavo coassiale spesso e 185 m nel 10BASE2 su cavo sottile.

La logica a bus è quindi la spiegazione del limite di Ethernet: un dominio di collisione unico e condiviso. Lo **hub** la conserva, perché ripete il segnale su tutte le porte; lo **switch** la elimina, perché ogni porta diventa un dominio di collisione separato e i frame vengono inoltrati in base all'indirizzo MAC. Il confronto fra hub, bridge, switch e router è in [[Lezione 1-Fondamenti di networking, teoria della comunicazione e standard#La commutazione|la commutazione]].

## La storia di Internet

### Le origini: 1961-1969

Internet è il risultato dell'evoluzione del concetto di **Galactic Network**, discusso da **J.C.R. Licklider** nell'agosto 1962 in una serie di memo al MIT: un'infrastruttura basata su un insieme di computer globalmente interconnessi, attraverso la quale ciascuno potesse scambiare dati, informazioni e programmi (J.C.R. Licklider e W. Clark, *On-Line Man Computer Communication*, agosto 1962).

Nello stesso periodo:

- **Licklider** fu direttore del programma di ricerca in computer di **DARPA**, iniziato nell'ottobre 1962. Convince i suoi successori, **Ivan Sutherland**, **Bob Taylor** e il ricercatore del MIT **Lawrence G. Roberts**, dell'importanza del concetto di rete. L'agenzia ha cambiato nome nel tempo: *Advanced Research Projects Agency* (ARPA), *Defense Advanced Research Projects Agency* (DARPA) dal 1971, ancora ARPA dal 1993, ancora DARPA dal 1996; si fa riferimento al nome corrente.
- Nel **1962** viene completato **SAGE** (*Semi Automatic Ground Environment*), basato su lavori sviluppati al MIT e in IBM: primo sistema di allarme del Nord America. Si basava su sistemi di puntamento ottico capaci di identificare gli oggetti in movimento e di mostrarli sugli schermi radar, e le postazioni SAGE dirigevano la difesa aerea. Sulla scia di questa esperienza maturarono le competenze per i sistemi di prenotazione di viaggi e di controllo del traffico aereo.
- **1961:** **Leonard Kleinrock** pubblica al MIT il primo articolo sulla teoria del packet switching: *Information Flow in Large Communication Nets*, RLE Quarterly Progress Report. Seguono il primo libro in materia nel 1964, *Communication Nets: Stochastic Message Flow and Delay*, McGraw-Hill, New York, e nel 1976 *Queueing Systems: Vol II, Computer Applications*, John Wiley and Sons, New York.
- **1965-68:** lo step successivo è far parlare due computer. Nel 1965, lavorando con **Thomas Merrill**, **Roberts** connette il **TX-2** del MIT al **Q-32** in California con un collegamento dial-up a bassa velocità, creando la prima **wide-area network** della storia. Si capì che i computer time-shared potevano cooperare, eseguendo programmi e scambiando dati, ma che i circuiti telefonici esistenti non erano adeguati: questo confermava gli studi di Kleinrock e la necessità del packet switching.
- **1969:** prima connessione host-to-host riuscita da **UCLA** a **Stanford Research Institute** (SRI), il secondo nodo ARPANET, il 25 ottobre 1969. Il primo login IMP andò in crash, il secondo riuscì.

### ARPANET: 1968-1973

- **Agosto 1968:** completata la specifica di ARPANET. Il **Network Measurement Center** dell'UCLA diventa il primo nodo. Molteplici reti diverse vengono interconnesse e dialogano usando tecniche di packet switching.
- **7 aprile 1969:** **Steve Crocker** invia un documento intitolato **Request for Comments**: il primo di migliaia di RFC che hanno documentato l'architettura di ARPANET e di Internet.
- **1972:** l'**ILLIAC IV**, il più grande supercomputer dell'epoca, viene collegato alla rete ARPANET, permettendo a migliaia di scienziati l'accesso remoto alle sue uniche capacità di calcolo.

### 1973-1981: TCP/IP, Ethernet, USENET

- **1973:** **Vint Cerf** e **Bob Kahn**, a Stanford, creano il **TCP/IP**: nasce la posta elettronica. Sempre nel 1973 **Bob Metcalfe**, alla Xerox Parc, inventa l'**Ethernet**.
- **1976-78:** **Seymour Cray** dimostra il primo supercomputer basato su processore vettoriale, il **Cray-1** (clock 12.5 ns secondo le slide). I primi clienti sono il **Lawrence Livermore National Laboratory** e il **Los Alamos National Laboratory**. **Harry Landweber** crea **THEORYNET**, fornendo e-mail a più di 100 ricercatori e collegando varie città all'**University of Wisconsin** mediante una rete a pacchetto pubblica.
- **1979:** **Cerf**, in DARPA, prosegue la sua visione di Internet formando l'**International Cooperation Board**, coordinato da **Peter Kirstein** dell'University College London, e l'**Internet Configuration Control Board**, coordinato da **Dave Clark** al MIT. Nello stesso anno **Landweber** organizza un meeting alla Wisconsin University insieme ad altre 6 Università per disegnare **CSNET**, la rete scientifica che ne deriva.
- **1980:** **TCP** viene adottato come protocollo standard dal **DoD**. Inizia l'attività di **USENET** e compaiono i primi gruppi di discussione delle **NEWS**: la prima applicazione client-server su larga scala.
- **1980-81:** agli inizi del 1981 oltre 200 computer sono connessi a CSNET. **Bill Joy** a Berkeley incorpora il **TCP/IP nella release BSD di Unix**. Viene lanciato il primo computer portatile (**Osborne**).

### 1981-1986: PC, Ethernet di campus, NSFNET

- **1981-82:** il **PC IBM** viene lanciato nell'agosto del 1981. Nel 1981 **G. Freeman** e **I. Fuchs** creano **BITNET**. Nel 1982 la rivista *Times* nomina 'il computer' *Man of the Year*; Cray annuncia il **Cray XMP** al posto del Cray-1; compaiono i primi cloni del PC IBM. **Drew Major** e **Kyle Powell** scrivono **Snipes**, un action game da giocare su PC in rete, il cui package contiene una demo di un prodotto sviluppato da SuperSet Software, Inc.: è l'inizio di **Novell**, azienda poi famosa nel mondo delle reti.
- **1983:** in novembre **Jon Postel**, **Paul Mockapetris** di USC/ISI e **Craig Partridge** di BBN sviluppano il **Domain Name System (DNS)** e raccomandano l'uso della forma di indirizzamento `user@host.domain` (Postel è scomparso il 16/10/1998). L'aumento degli host è favorito dalla commercializzazione di Ethernet. Appare evidente, al di là di un uso limitato in digital, lo scarso successo del modello di riferimento **ISO/OSI** rispetto a **TCP/IP**. Il **1 gennaio 1983 ARPANET abbandona il protocollo NCP** fra mainframe e adotta TCP/IP (RFC 801).
- **1983-84:** **Bill Joy** fonda **Sun Microsystems**, che sviluppa workstation con facility di rete e TCP/IP integrate. La workstation **Apollo** appare sul mercato con una speciale versione di rete **Token Ring**. A causa dell'aumentato numero di host in rete vengono introdotte le **reti IP di classe A, B e C**. Nel gennaio 1984 **Apple** annuncia il **Macintosh**, con un'interfaccia grafica rivoluzionaria.
- **1984:** lo scrittore **William Gibson** conia il termine **cyberspace** nel romanzo *Neuromancer*. Vengono introdotti i **Top Level Domain** .edu, .com, .net, .org, oltre ai TLD della codifica ISO per i nomi delle nazioni (.it, .fr, .de, ecc.). In Inghilterra nasce **JANET**, con l'intento di connettere tutte le istituzioni scientifiche e di ricerca. La **National Science Foundation (NSF)** costituisce i **supercomputer centers** per servire la comunità scientifica americana, fondamentali per lo sviluppo di Internet.
- **1985:** il MIT pubblica *Computer & Communications* del chair di **NEC**, **Dr. Koji Kobayashi** (entrato in NEC nel 1929), che descrive la sua chiara visione di **C & C**, l'integrazione di computing e communication.
- **1985:** l'algoritmo di routing originario, unico su tutte le macchine, viene rimpiazzato dai protocolli gerarchici **IGP** (interno a reti regionali) ed **EGP**. **Dennis Jennings** passa un anno alla NSF per lanciare **NSFNET**, un *backbone* a 56 Kbps basato su TCP/IP: è il boom di Internet nel mondo della ricerca.
- **1985-86:** tra il 1985 e il 1986 gli host Internet passano da **2.000 a 30.000**. **TCP** diventa disponibile nelle workstation e nei PC, così come nel portatile **Compaq** di recentissima introduzione. **Ethernet** viene accettata come tecnologia di cablaggio per edifici e campus, e con essa si diffondono i termini **bridging** e **routing**. Compaiono le prime multinazionali del settore: IBM, Proteon, Synoptis, Banyan, Cabletron, Wellfleet e **Cisco**.
- **Aprile 1995:** **NSFNET** viene completamente privatizzata: una nuova era per Internet.

### 1986-1989: T1, T3 e la nascita del WWW

- **30 aprile 1986:** l'Italia si connette a Internet.
- **1987:** la NSF intuisce la portata e il significato commerciale della velocità di crescita di Internet. La rete NSF passa a linee **T1 (1.55 Mbps)**, con un successo enorme, e parte la proposta di migrare a linee **T3 (45 Mbps)**. Il numero di host passa a **10.000** e il numero di RFC supera quota **1.000**. Diventano serie le problematiche di **Network Management**.
- **1988:** la NSF connette anche **Canada, Danimarca, Finlandia, Francia, Norvegia e Svezia**. In California nascono reti regionali quali **Los Nettos** e **CERFNet**. **Fidonet**, il popolare sistema BBS, si connette a Internet. Nasce **Interop**, evento-fiera per i produttori Internet. Il primo **WORM** appare al **CERT**.
- **1989:** il numero di host è di **80.000** a gennaio, **130.000** a luglio e **160.000** a novembre. Si connettono **Australia, Germania, Israele, Italia, Giappone, Messico, Olanda, Nuova Zelanda e Inghilterra**. La velocità aumenta: le linee **T3 (45 Mbit/s)** diventano operative e a Interop si osservano connessioni a **100 Mbps in FDDI**. Le compagnie telefoniche attivano servizi a larga banda con il protocollo **SMDS**.
- **1989:** **Cerf** e **Kahn** organizzano il primo **workshop sul Gigabit**: oltre 600 persone discutono esperimenti da realizzare per una dorsale a **6 Gbps**. Nello stesso anno **Tim Berners-Lee** al **CERN** pone il problema di un'efficiente modalità di condivisione dei documenti riguardanti progetti e pubblicazioni scientifiche, cercando di ottimizzare l'uso di carta e stampanti, e propone il concetto di **ipertesto**: nasce il **World Wide Web**.

### 1990-1994: commercializzazione e apertura

- **1990:** **ARPANET viene chiusa**: in venti anni è passata da 4 a **300.000 host**. Tra le nazioni collegate figurano Argentina, Austria, Belgio, Brasile, Cile, Grecia, India, Irlanda, Sud Corea, Spagna e Svizzera. Appare i tool di **Network Information Retrieval**: **ARCHIE**, **Gopher**, **WAIS**. Si registrano 130 incidenti relativi a **WORM**.
- **1991:** la **NSF rimuove le restrizioni sull'uso commerciale** della rete. Nasce **PGP** (*Pretty Good Privacy*). Sono connesse più di **100 nazioni**, **600.000 host** e più di **5.000 reti separate**.
- **1992:** nasce **ISOC** (*Internet Society*), che vede fra i fondatori **Vint Cerf** e **Bob Kahn**; l'*Internet Activity Board* diventa parte di ISOC. Si contano più di **7.500 reti** e **1.000.000 di host**. Il progetto **MBONE** consente l'uso di audio e video e rende possibili le prime **videoconferenze in rete**. Presso la **NCSA** **Larry Smarr** modifica la proposta di ipertesto di **Tim Berners-Lee**: nasce **NCSA Mosaic**, una delle prime homepage a mostrare la foto di Elvis e il link a un suo brano. **Marc Andreessen** fonda con **Jim Clark** **Netscape Inc**. Il **WWW esplode** nella rete.
- **1994:** foto pubblicata su *Newsweek* l'8 agosto 1994 per il 25esimo anniversario di ARPANET. **Jon Postel** disegnò le immagini, **Steve Crocker** e **Vint Cerf** legarono le zucchine e le zucche gialle, impiegando circa 8 ore.

> [!example]
> Nella foto non esiste alcun collegamento fra la bocca e l'orecchio, quindi la rete non poteva funzionare: tale era lo stato del networking nei primitivi anni Sessanta. (Vint Cerf)

### La definizione FNC di Internet del 24 ottobre 1995

La **Federal Networking Council (FNC)**, con risoluzione del 24 ottobre 1995, concorda la seguente definizione del termine *Internet*:

> *"Internet" refers to the global information system that*
> - *is logically linked together by a globally unique address space based on the Internet Protocol (IP) or its subsequent extensions/follow-ons;*
> - *is able to support communications using the Transmission Control Protocol/Internet Protocol (TCP/IP) suite or its subsequent extensions/follow-ons, and/or other IP-compatible protocols; and*
> - *provides, uses or makes accessible, either publicly or privately, high level services layered on the communications and related infrastructure described here in.*

## Domini Internet

Rilevazione **VeriSign**, dati **2004**:

| Categoria | Domini registrati |
| :--- | ---: |
| Totale worldwide | 62,9 milioni |
| `.COM` | 22.215.530 |
| `.NET` | 3.851.052 |
| `.ORG` | 2.423.508 |
| `.EDU` | 7.253 |
| `.GOV` | 1.322 |
| `CO.UK` (United Kingdom) | 3.275.700 |

Solo nei primi tre mesi del 2004 sono stati assegnati nel mondo **4,1 milioni** di domini Internet. I domini `.it` raggiunsero la quota di **un milione**.

## Connettività e mappe

Le slide riportano l'evoluzione topografica della rete attraverso le mappe Internet di **John Quarterman** (*Matrix Survey*, `http://www.mids.org`): Internet Map 1987 e NSFNet Map 1987 nel 1987, NCAR Network Map e NSFNet T-1 Backbone Map 1988 nel 1987-88, NSFNet Backbone 1992 nel 1992, Internet Map *Version 11* dell'11 luglio 1994 e Internet Map *Version 16* del 16 giugno 1997.

## Statistiche

**Connettività e numeri del 2022:**

- **Utenti:** 5,1 miliardi, connessi per 6h 43' ogni giorno.
- **Italia:** 50 milioni di utenti e 70 milioni di cellulari.
- **Siti web:** al 31/12/2021 erano 1,9 miliardi.
- **Google:** elabora 5,6 miliardi di query di ricerca ogni giorno nel mondo.
- **Browser:** Google Chrome è il più diffuso, con il 64,5% del mercato globale.

**Composizione del traffico:**

- Nella prima metà del 2021 il **64% di tutto il traffico Internet era automatizzato**: il 39% proveniva da bot cattivi e il 25% da bot buoni. Gli esseri umani hanno rappresentato il restante 36%.
- Nel primo trimestre del 2021 i dispositivi mobili, esclusi i tablet, hanno generato il 54,8% del traffico globale dei siti web.

> [!info] Sintesi:
> - Internet è l'infrastruttura che ha reso superflui tempo e spazio ed è un evento culturale prima che tecnologico.
> - Internetworking è l'interconnessione di reti eterogenee in un'unica infrastruttura, caratterizzata da apertura e crescita esponenziale.
> - Nel villaggio globale la ricerca usa infrastrutture come GARR, le aziende intranet ed e-commerce, le amministrazioni CAD, dematerializzazione e FLOSS.
> - Le origini: Licklider e il Galactic Network (1962), Kleinrock sul packet switching (1961), la prima WAN fra MIT e California (1965), la prima connessione UCLA-SRI (1969).
> - ARPANET (1968-73) porta il packet switching e gli RFC; dal 1983 TCP/IP sostituisce NCP e nasce il DNS.
> - Dal 1985 NSFNET a 56 Kbps, poi T1 e T3, dà il boom; nel 1989 nasce il WWW e nel 1991 la NSF toglie i vincoli commerciali.
> - La definizione FNC del 24 ottobre 1995 è lo spazio di indirizzi univoco su IP, la suite TCP/IP e i servizi che ci si appoggiano.