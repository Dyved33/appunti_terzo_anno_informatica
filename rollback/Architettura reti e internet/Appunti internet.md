# Internetworking, il villaggio globale e la storia di Internet

> [!NOTE] Materiale di riferimento
> Le sezioni da 1 a 3 e da 5 a 8 sono ricostruite integrando gli appunti presi a lezione con le slide `ArchitetturaRetiDef_I_a.pdf` (prima parte) e `ArchitetturaRetiDef_I_b.pdf` (prima parte, continuazione). La sezione 4 raccoglie i punti che le slide disponibili non coprono e che restano quindi da completare.

## 1. Introduzione

Internet ha rivoluzionato il mondo dei computer e delle comunicazioni: è la principale rivoluzione tecnologica del XX secolo e il più rivoluzionario mezzo di comunicazione umana. Si tratta di un evento culturale prima ancora che tecnologico.

È un'infrastruttura di sviluppo per le istituzioni, per le professioni, per la gente, per i paesi: distrugge il tempo e lo spazio e abolisce le frontiere e le barriere di ogni tipo. Il cambiamento non è stato graduale, ma una trasformazione continua e pervasiva dell'intero ecosistema delle comunicazioni.

## 2. Internetworking

L'*internetworking* è il processo e il risultato dell'interconnessione di reti eterogenee in un'unica infrastruttura globale. I tratti caratteristici:

* **Reti di reti:** non una singola rete, ma un agglomerato di reti che si uniscono tra loro.
* **Autostrade elettroniche:** servono a collegare isole di connettività precedenti e isolate.
* **Infrastrutture dell'era della comunicazione globale.**
* **Interconnessione di sistemi aperti:** nessun nodo proprietario e nessun single point of controllo.
* **Crescita esponenziale:** sia della rete sia dei servizi che su di essa si possono erogare.
* **Crescita dei servizi fruibili on-line** tramite Internet, fra cui le intranet aziendali.
* **Forte spinta a produrre applicativi innovativi**, sia via Web sia mediante App per smartphone.

## 3. Il villaggio globale

### 3.1 La ricerca scientifica

L'evoluzione delle reti della ricerca ha due direttrici:

* **Infrastrutture:** la rete GARR, la rete italiana della ricerca e dell'istruzione superiore.
* **Software per didattica e valutazioni online.**

La ricerca scientifica nel villaggio globale si articola in:

* **Posta elettronica e videoconferenza.**
* **Accesso a risorse remote:** SSH, Remote Job Entry.
* **HPC:** accesso remoto a risorse di calcolo ad alte prestazioni.
* **Machine learning.**
* **Cybersecurity.**

Nascono inoltre nuovi rapporti fra docenti e studenti: laboratori virtuali, simulazioni, software per didattica e valutazioni online.

### 3.2 Le aziende

* **Marketing, Branding, Social networking.**
* **Rapporti con clienti e con la rete di vendita.**
* **Intranet.**
* **E-commerce.**

### 3.3 Le pubbliche amministrazioni

* **Rete delle Pubbliche Amministrazioni:** oggi AgID, in precedenza AIPA e poi DigitPA.
* **Codice di Amministrazione Digitale (CAD).**
* **Agenda Digitale.**
* **Dematerializzazione** degli atti e delle informazioni.
* **Riuso** dei sistemi e delle applicazioni esistenti.
* **Adozione di FLOSS.**
* **Disaster recovery.**

## 4. Appunti ancora incompleti

I punti seguenti sono presenti negli appunti presi a lezione ma non sono coperti dalle slide I-a e I-b. Restano da recuperare sulle slide della lezione corrispondente.

> [!WARNING] Logica a bus
> Appunto in lista: `logica a bus`. Nessuna slide dei due PDF forniti copre l'argomento.

### 4.1 Banda base e banda larga

Appunto in lista: *differenza tra banda base e banda larga*, con le due definizioni (`banda base =`, `banda larga =`) rimaste vuote. Il confronto è ripreso solo implicitamente in 8.3, dove le slide citano i servizi a larga banda su protocollo SMDS e NSFNET come *backbone*.

### 4.2 Collisioni e perdita di pacchetti in Ethernet

Appunto in lista: *problema se mando un pacchetto e questo si perde e per questo la rete rallenta fino a fermarsi. Ethernet è comunque popolare perché l'hub usa uno switch e usa il MAC address*.

Il testo è da mettere a punto: il nodo centrale è il meccanismo di gestione delle collisioni su mezzo condiviso e il ruolo dell'indirizzo MAC nel delivery a livello di collegamento dati. Le slide I-a e I-b si limitano a citare Ethernet come tecnologia di cablaggio per edifici e campus (1985-86) e la sua commercializzazione come causa della crescita degli host (1983): non entrano nel dettaglio del dominio di collisione né del ritrasmissione.

## 5. La storia di Internet

### 5.1 Le origini: 1961-1969

Internet è il risultato dell'evoluzione del concetto di **Galactic Network**, discusso da **J.C.R. Licklider** nell'agosto 1962 in una serie di memo al MIT. L'idea era un'infrastruttura basata su un insieme di computer globalmente interconnessi, attraverso la quale ciascuno potesse scambiare dati, informazioni e programmi (J.C.R. Licklider e W. Clark, *On-Line Man Computer Communication*, agosto 1962).

Nello stesso periodo:

* **Licklider** fu direttore del programma di ricerca in computer di **DARPA**, iniziato nell'ottobre 1962. Convince i suoi successori, **Ivan Sutherland**, **Bob Taylor** e il ricercatore del MIT **Lawrence G. Roberts**, dell'importanza del concetto di rete. L'agenzia ha cambiato nome nel tempo: *Advanced Research Projects Agency* (ARPA), *Defense Advanced Research Projects Agency* (DARPA) dal 1971, ancora ARPA dal 1993, ancora DARPA dal 1996; si fa riferimento al nome corrente.
* Nel **1962** viene completato **SAGE** (*Semi Automatic Ground Environment*), basato su lavori sviluppati al MIT e in IBM: primo sistema di allarme del Nord America. Si basava su sistemi di puntamento ottico capaci di identificare gli oggetti in movimento e di mostrarli sugli schermi radar; le postazioni SAGE dirigevano la difesa aerea. Sulla scia di questa esperienza maturarono le competenze per i sistemi di prenotazione di viaggi e di controllo del traffico aereo.
* **1961:** **Leonard Kleinrock** pubblica al MIT il primo articolo sulla teoria del packet switching: *Information Flow in Large Communication Nets*, RLE Quarterly Progress Report. Seguono il primo libro in materia nel 1964, *Communication Nets: Stochastic Message Flow and Delay*, McGraw-Hill, New York, e nel 1976 *Queueing Systems: Vol II, Computer Applications*, John Wiley and Sons, New York.
* **1965-68:** lo step successivo è far parlare due computer. Nel 1965, lavorando con **Thomas Merrill**, **Roberts** connette il **TX-2** del MIT al **Q-32** in California con un collegamento dial-up a bassa velocità, creando la prima **wide-area network** della storia. Il risultato fu che si capì che i computer time-shared potevano cooperare, eseguendo programmi e scambiando dati, ma che i circuiti telefonici esistenti non erano adeguati: questo confermava gli studi di Kleinrock e la necessità del packet switching.
* **1969:** prima connessione host-to-host riuscita da **UCLA** a **Stanford Research Institute** (SRI), il secondo nodo ARPANET, il 25 ottobre 1969. Il primo login IMP andò in crash, il secondo riuscì.

### 5.2 ARPANET: 1968-1973

* **Agosto 1968:** completata la specifica di ARPANET. Il **Network Measurement Center** dell'UCLA diventa il primo nodo. Molteplici reti diverse vengono interconnesse e dialogano usando tecniche di packet switching.
* **7 aprile 1969:** **Steve Crocker** invia un documento intitolato **Request for Comments**: il primo di migliaia di RFC che hanno documentato l'architettura di ARPANET e di Internet.
* **1972:** l'**ILLIAC IV**, il più grande supercomputer dell'epoca, viene collegato alla rete ARPANET, permettendo a migliaia di scienziati l'accesso remoto alle sue uniche capacità di calcolo.

### 5.3 1973-1981: TCP/IP, Ethernet, USENET

* **1973:** **Vint Cerf** e **Bob Kahn**, a Stanford, creano il **TCP/IP**: nasce la posta elettronica. Sempre nel 1973 **Bob Metcalfe**, alla Xerox Parc, inventa l'**Ethernet**.
* **1976-78:** **Seymour Cray** dimostra il primo supercomputer basato su processore vettoriale, il **Cray-1** (clock 12.5 ns secondo le slide). I primi clienti sono il **Lawrence Livermore National Laboratory** e il **Los Alamos National Laboratory**. **Harry Landweber** crea **THEORYNET**, fornendo e-mail a più di 100 ricercatori e collegando varie città all'**University of Wisconsin** mediante una rete a pacchetto pubblica.
* **1979:** **Cerf**, in DARPA, prosegue la sua visione di Internet formando l'**International Cooperation Board**, coordinato da **Peter Kirstein** dell'University College London, e l'**Internet Configuration Control Board**, coordinato da **Dave Clark** al MIT. Nello stesso anno **Landweber** organizza un meeting alla Wisconsin University insieme ad altre 6 Università per disegnare **CSNET**, la rete scientifica che ne deriva.
* **1980:** **TCP** viene adottato come protocollo standard dal **DoD**. Inizia l'attività di **USENET** e compaiono i primi gruppi di discussione delle **NEWS**: la prima applicazione client-server su larga scala.
* **1980-81:** agli inizi del 1981 oltre 200 computer sono connessi a CSNET. **Bill Joy** a Berkeley incorpora il **TCP/IP nella release BSD di Unix**. Viene lanciato il primo computer portatile (**Osborne**).

### 5.4 1981-1986: PC, Ethernet di campus, NSFNET

* **1981-82:** il **PC IBM** viene lanciato nell'agosto del 1981. Nel 1981 **G. Freeman** e **I. Fuchs** creano **BITNET**. Nel 1982 la rivista *Times* nomina 'il computer' *Man of the Year*; Cray annuncia il **Cray XMP** al posto del Cray-1; compaiono i primi cloni del PC IBM. **Drew Major** e **Kyle Powell** scrivono **Snipes**, un action game da giocare su PC in rete, il cui package contiene una demo di un prodotto sviluppato da SuperSet Software, Inc.: è l'inizio di **Novell**, azienda poi famosa nel mondo delle reti.
* **1983:** in novembre **Jon Postel**, **Paul Mockapetris** di USC/ISI e **Craig Partridge** di BBN sviluppano il **Domain Name System (DNS)** e raccomandano l'uso della forma di indirizzamento `user@host.domain` (Postel è scomparso il 16/10/1998). L'aumento degli host è favorito dalla commercializzazione di Ethernet. Appare evidente, al di là di un uso limitato in digital, lo scarso successo del modello di riferimento **ISO/OSI** rispetto a **TCP/IP**. Il **1 gennaio 1983 ARPANET abbandona il protocollo NCP** fra mainframe e adotta TCP/IP (RFC 801).
* **1983-84:** **Bill Joy** fonda **Sun Microsystems**, che sviluppa workstation con facility di rete e TCP/IP integrate. La workstation **Apollo** appare sul mercato con una speciale versione di rete **Token Ring**. A causa dell'aumentato numero di host in rete vengono introdotte le **reti IP di classe A, B e C**. Nel gennaio 1984 **Apple** annuncia il **Macintosh**, con un'interfaccia grafica rivoluzionaria.
* **1984:** lo scrittore **William Gibson** conia il termine **cyberspace** nel romanzo *Neuromancer*. Vengono introdotti i **Top Level Domain** .edu, .com, .net, .org, oltre ai TLD della codifica ISO per i nomi delle nazioni (.it, .fr, .de, ecc.). In Inghilterra nasce **JANET**, con l'intento di connettere tutte le istituzioni scientifiche e di ricerca. La **National Science Foundation (NSF)** costituisce i **supercomputer centers** per servire la comunità scientifica americana, fondamentali per lo sviluppo di Internet.
* **1985:** il MIT pubblica *Computer & Communications* del chair di **NEC**, **Dr. Koji Kobayashi** (entrato in NEC nel 1929), che descrive la sua chiara visione di **C & C**, l'integrazione di computing e communication.
* **1985:** l'algoritmo di routing originario, unico su tutte le macchine, viene rimpiazzato dai protocolli gerarchici **IGP** (interno a reti regionali) ed **EGP**. Nel 1985 **Dennis Jennings** passa un anno alla NSF per lanciare **NSFNET**, un *backbone* a 56 Kbps basato su TCP/IP: è il boom di Internet nel mondo della ricerca.
* **1985-86:** tra il 1985 e il 1986 gli host Internet passano da **2.000 a 30.000**. **TCP** diventa disponibile nelle workstation e nei PC, così come nel portatile **Compaq** di recentissima introduzione. **Ethernet** viene accettata come tecnologia di cablaggio per edifici e campus, e con essa si diffondono i termini **bridging** e **routing**. Compaiono le prime multinazionali del settore: IBM, Proteon, Synoptis, Banyan, Cabletron, Wellfleet e **Cisco**.
* **Aprile 1995:** **NSFNET** viene completamente privatizzata: una nuova era per Internet.

### 5.5 1986-1989: T1, T3 e la nascita del WWW

* **30 aprile 1986:** l'Italia si connette a Internet.
* **1987:** la NSF intuisce la portata e il significato commerciale della velocità di crescita di Internet. La rete NSF passa a linee **T1 (1.55 Mbps)**, con un successo enorme, e parte la proposta di migrare a linee **T3 (45 Mbps)**. Il numero di host passa a **10.000** e il numero di RFC supera quota **1.000**. Diventano serie le problematiche di **Network Management**.
* **1988:** la NSF connette anche **Canada, Danimarca, Finlandia, Francia, Norvegia e Svezia**. In California nascono reti regionali quali **Los Nettos** e **CERFNet**. **Fidonet**, il popolare sistema BBS, si connette a Internet. Nasce **Interop**, evento-fiera per i produttori Internet. Il primo **WORM** appare al **CERT**.
* **1989:** il numero di host è di **80.000** a gennaio, **130.000** a luglio e **160.000** a novembre. Si connettono **Australia, Germania, Israele, Italia, Giappone, Messico, Olanda, Nuova Zelanda e Inghilterra**. La velocità aumenta: le linee **T3 (45 Mbit/s)** diventano operative e a Interop si osservano connessioni a **100 Mbps in FDDI**. Le compagnie telefoniche attivano servizi a larga banda con il protocollo **SMDS**.
* **1989:** **Cerf** e **Kahn** organizzano il primo **workshop sul Gigabit**: oltre 600 persone discutono esperimenti da realizzare per una dorsale a **6 Gbps**. Nello stesso anno **Tim Berners-Lee** al **CERN** pone il problema di un'efficiente modalità di condivisione dei documenti riguardanti progetti e pubblicazioni scientifiche, cercando di ottimizzare l'uso di carta e stampanti, e propone il concetto di **ipertesto**: nasce il **World Wide Web**.

### 5.6 1990-1994: commercializzazione e apertura

* **1990:** **ARPANET viene chiusa**: in venti anni è passata da 4 a **300.000 host**. Tra le nazioni collegate figurano Argentina, Austria, Belgio, Brasile, Cile, Grecia, India, Irlanda, Sud Corea, Spagna e Svizzera. Appare i tool di **Network Information Retrieval**: **ARCHIE**, **Gopher**, **WAIS**. Si registrano 130 incidenti relativi a **WORM**.
* **1991:** la **NSF rimuove le restrizioni sull'uso commerciale** della rete. Nasce **PGP** (*Pretty Good Privacy*). Sono connesse più di **100 nazioni**, **600.000 host** e più di **5.000 reti separate**.
* **1992:** nasce **ISOC** (*Internet Society*), che vede fra i fondatori **Vint Cerf** e **Bob Kahn**; l'*Internet Activity Board* diventa parte di ISOC. Si contano più di **7.500 reti** e **1.000.000 di host**. Il progetto **MBONE** consente l'uso di audio e video e rende possibili le prime **videoconferenze in rete**. Presso la **NCSA** **Larry Smarr** modifica la proposta di ipertesto di **Tim Berners-Lee**: nasce **NCSA Mosaic**, una delle prime homepage a mostrare la foto di Elvis e il link a un suo brano. **Marc Andreessen** fonda con **Jim Clark** **Netscape Inc**. Il **WWW esplode** nella rete.
* **1994:** foto pubblicata su *Newsweek* l'8 agosto 1994 per il 25esimo anniversario di ARPANET. **Jon Postel** disegnò le immagini, **Steve Crocker** e **Vint Cerf** legarono le zucchine e le zucche gialle, impiegando circa 8 ore.

> [!NOTE] La foto del 1994
> Nella foto non esiste alcun collegamento fra la bocca e l'orecchio, quindi la rete non poteva funzionare: tale era lo stato del networking nei primitivi anni Sessanta. (Vint Cerf)

### 5.7 La definizione FNC di Internet (24 ottobre 1995)

La **Federal Networking Council (FNC)**, con risoluzione del 24 ottobre 1995, concorda la seguente definizione del termine *Internet*:

> [!NOTE] Resolution of FNC, 24 October 1995
> *"Internet" refers to the global information system that*
> - *is logically linked together by a globally unique address space based on the Internet Protocol (IP) or its subsequent extensions/follow-ons;*
> - *is able to support communications using the Transmission Control Protocol/Internet Protocol (TCP/IP) suite or its subsequent extensions/follow-ons, and/or other IP-compatible protocols; and*
> - *provides, uses or makes accessible, either publicly or privately, high level services layered on the communications and related infrastructure described here in.*

## 6. Domini Internet

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

## 7. Connettività e mappe

Le slide riportano l'evoluzione topografica della rete attraverso le mappe Internet di **John Quarterman** (*Matrix Survey*, `http://www.mids.org`):

* **1987:** Internet Map 1987 e NSFNet Map 1987.
* **1987-88:** NCAR Network Map e NSFNet T-1 Backbone Map 1988.
* **1992:** NSFNet Backbone 1992.
* **Connettività, 1994:** Internet Map, *Version 11* dell'11 luglio 1994.
* **Connettività, 1997:** Internet Map, *Version 16* del 16 giugno 1997.

## 8. Statistiche

### 8.1 Statistiche pre-Covid

Le slide contengono **otto grafici** di statistiche pre-Covid (dati, trend e mappe). Il testo delle slide è interamente dentro le immagini, quindi non è estraibile come testo: vanno letti direttamente dal PDF `ArchitetturaRetiDef_I_b.pdf`, alle pagine 18-25.

### 8.2 Connettività e numeri del 2022

* **Utenti:** 5,1+ miliardi, connessi per **6h 43'** ogni giorno.
* **Italia:** 50 milioni di utenti e 70 milioni di cellulari.
* **Siti web:** al 31/12/2021 erano **1,9 miliardi**.
* **Google:** elabora **5,6 miliardi di query di ricerca** ogni giorno nel mondo.
* **Browser:** Google Chrome è il più diffuso, con il **64,5%** del mercato globale.

### 8.3 Composizione del traffico

* Nella prima metà del 2021 il **64% di tutto il traffico Internet era automatizzato**: il **39%** proveniva da bot cattivi e il **25%** da bot buoni. Gli esseri umani hanno rappresentato il restante **36%**.
* Nel primo trimestre del 2021 i dispositivi mobili (esclusi i tablet) hanno generato il **54,8%** del traffico globale dei siti web.