Autonomous System ■ Le reti e gli Intermediate System (IS) si suddividono in • interni ad un dominio di routing • esterni ad un dominio di routing ■ Per dominio di routing si intende l'insieme delle reti che sono soggette all’amministrazione ed al controllo di una stessa organizzazione ■ Il dominio di routing prende il nome di Autonomous System o AS ed identifica la politica di routing adottata. ■ L’AS condiziona il routing, consentendo ad un'organizzazione di attivare diverse politiche.

■ L'RFC 1930 definisce le modalità con le quali diverse organizzazioni possono effettuare routing BGP usando degli AS privati attraverso ad unico ISP che connette queste organizzazioni ad Internet. ■ Anche se ci possono essere diversi AS gestiti da un ISP, la sua politica di routing viene identificata da un Autonomous System Number (ASN) ufficialmente registrato. ■ Un ASN viene assegnato a ciascun AS per poter effettuare routing BGP. ■ Gli ASN identificano univocamente le reti ai fini del routing.

ASN ■ Fino al 2007 gli ASN erano indicati da un numero intero a 16 bit (0-65536), denominati asplain ■ RFC 4893 definisce una nuova sintassi per la numerazione degli AS, che prende il nome di asdot, nella forma x.y, con x e y numeri interi di 16 bit. ■ I numeri 0.y coincidono con gli asplain. ■ L'ASN 23456 è stato assegnato da IANA come variabile metasintattica per valori di ASN a 32 bit nel caso in cui router BGP in grado di gestire la nuova sintassi comunicassero con router BGP di vecchia generazione non in grado di comprendere ASN a 32 bit. ■ Gli ASN 0 e 65535, e l'ultimo ASN della numerazione a 32 bit: 4.294.967.295 sono riservati e non possono essere usati dagli operatori ■ Gli ASN 64.512–65.534 e 4.200.000.000- 4.294.967.294 sono riservati per uso privato dall'RFC 6996.

■ Condizione necessaria per ottenere il rilascio di un ASN è quella di possedere due distinte connessioni ad Internet, attraverso diversi provider (ISP). ■ In ISP ha più ASN assegnati per poter gestire situazioni differenti. ■ I router che instradano messaggi all’interno dello stesso AS sono detti Interior Router, mentre quelli che instradano messaggi anche tra AS diversi sono detti Exterior Router. • Gli Interior Router eseguono un Interior Gateway Protocol (IGP) per determinare il percorso ottimale • Gli Exterior Router eseguono un Exterior Gateway Protocol (EGP)

> [!example]
> //slide 31//

//slide 32//

Routing statico e routing dinamico ■ Route statiche: • Sono inizializzate allo start-up • Non cambiano mai • Sono tipiche degli host • Usate qualche volta nei router ■ Route dinamiche: • Sono inizializzate allo start-up • Aggiornate mediante dei protocolli di propagazione dei router • Sono tipiche dei router • Usate qualche volta negli host

> [!example]
> //immagine slide 34 + spiegazione//

> [!example]
> //immagine slide 35 + spiegazione//

Scambio di informazioni di routing all'interno ad un AS ■ Meccanismo denominato Interior Gateway Protocols, IGPs ■ Le scelte di tipo IGP sono effettuate dall'AS ■ NB: se un AS si connette al resto del mondo, un router nell'AS deve usare un protocollo EGP per annunciare la raggiungibilità della rete ad altri AS

![[Pasted image 20261023110854.png]]

Protocolli di routing
![[Pasted image 20261023111029.png]]
//aggiungi a lato una piccola spiegazione//

Open Shortest Path First (OSPF) 
■ Sviluppato nel 1988 dall’IGP working group di IETF, standard nel 1990 (RFC 1247) per routing all’interno di un AS ■ Una risposta di tipo Open Source ai protocolli proprietari, di straordinaria efficienza, molto complesso da configurare e gestire. ■ OSPF: • è aperto • è basato sull’algoritmo Shortest Path First (Dijkstra algorithm) • supporta subnet variabili • implementa routing dinamico • supporta routing in base al tipo di servizio • esegue il bilanciamento del carico • supporta l'autenticazione dei messaggi • supporta sistemi gerarchici (aree)

■ E’ un link-state routing protocol così chiamato perché invia link-state advertisements (LSA) a tutti i router di una stessa area gerarchica ■ Nell’ LSA invia informazioni relative alle interfaccie attive, alle metriche usate, ed altre variabili ■ Un router OSPF accumula LSA e calcola il percorso ottimale mediante l’algoritmo SPF ■ E’ computazionalmente relativamente pesante

■ I router di una stessa area condividono lo stesso topological database ■ La suddivisione in aree riduce il traffico di routing nell’AS ■ L’introduzione delle aree genera due tipi di traffico di routing • Inter-area routing • Intra-area routing ■ L’OSPF backbone è responsabile di distribuire informazioni di routing tra aree

![[Pasted image 20261023111642.png]]

■ Le aree possono essere definite in modo tale che il backbone non sia continuo: in tal caso la continuità può essere realizzata mediante virtual-links ■ Questo permette ai gestori della rete di definire una topologia logica differente da quella fisica. ■ I virtual-links vengono definiti tra i backbone router che condividono link con aree non-backbone e funzionano come se fossero link diretti ■ OSPF può apprendere informazioni da altri exterior gateway protocol, interior gateway protocol, o mediante istruzioni di configurazione

■ OSPF può operare all’interno di una gerarchia ■ la maggiore entità gerarchica è l’AS ■ OSPF è un intra-AS (IGP) routing protocol, anche se può inviare e ricevere route verso o da altri AS ■ Un AS può essere diviso in diverse aree, che è bene riguardino host in gruppi di reti contigue per semplificare la routing table. ■ Router con diverse interfacce possono appartenere a più aree e prendono il nome di Area Border Router (ABR). Essi mantengono diversi topological database per ogni area

■ OSPF distingue 4 tipi di router: • Internal router: interni ad un’area • Area Border router: che connettono 2 o più aree • Backbone router: che appartengono alla dorsale (area 0) • Border AS router: router di confine tra AS ■ Quando un router viene avviato mediante messaggi di tipo HELLO inviati su tutte le interfaccie, si costruisce la mappa topologica ed in particolare definisce: • i router adiacenti • il designed router (DR) • il backup designed router (BDR)

OSPF packets ■ Router che non sono adiacenti non scambiano tra loro informazioni ■ I pacchetti OSPF sono: Hello usato per scoprire i neighbors Link state update fornisce i propri criteri per la selezione del costo del link Link state ack conferma un LS update Database description comunica gli aggiornamenti che conosce Link state request richiesta di informazioni di stato ai neighbor routers

OSPF packet format
//immagine slide 46//

OSPF Hello packet
![[Pasted image 20261023112411.png]]

■ Due router OSPF vicini si scambiano periodicamente questo pacchetto per verificare la reciproca raggiungibilità ■ ROUTER DEAD INTERVAL indica il tempo trascorso il quale se il router vicino non risponde, è considerato inattivo ■ HELLO INTERVAL è il tempo che intercorre tra messaggi HELLO ■ GWAY PRIO indica la priorità del router e serve per identificare il Backup Designed Router (BDR)

Formato dei messaggi di descrizione del database OSPF
■ Per inizializzare il loro topological database i router si scambiano dei messaggi di descrizione del database OSPF ■ Nello scambio uno funge da router principale (master), l'altro secondario (slave) e conferma la ricezione di ogni messaggio con una risposta.

![[Pasted image 20261023112445.png]]

■ Poiché il messaggio può essere molto esteso, vengono utilizzati i bit I (impostato a 1 nel messaggio iniziale) e M (impostato a 1 nei messaggi che seguono) ■ Il bit S indica se il messaggio è stato inviato ad un master (1) o a uno slave (0). ■ DATABASE SEQUENCE NUMBER numera in sequenza i messaggi, in modo che il ricevente possa identificare eventuali messaggi persi. Il primo contiene un numero R casuale, i successivi interi sequenziali a partire da R. ■ I campi da Link AGE a Link LENGTH descrivono un collegamento di rete. Link TYPE indica il tipo di collegamento: 1. collegamento del router 2. collegamento di rete 3. Collegamento di riepilogo (rete IP) 4. Collegamento di riepilogo (collegamento al router di confine) 5. Collegamento esterno (collegamento ad un altro sito)

■ Dopo aver scambiato messaggi di descrizione del database con un vicino, un router può scoprire parti obsolete del suo database ■ Affinché il vicino gli risponda con gli aggiornamenti, il router invia un messaggio di richiesta dello stato dei collegamenti ■ Il vicino risponde con le informazioni aggiornate che ha.

![[Pasted image 20261023112510.png]]

■ I router trasmettono in broadcast lo stato dei collegamenti con un messaggio di aggiornamento dello stato dei collegamenti.

![[Pasted image 20261023112527.png]]

■ L'intestazione dello stato dei collegamenti usa uno dei quattro possibili formati per descrivere i collegamenti del router ad una certa area, a una rete specifica, alle reti fisiche di una rete IP suddivisa in sottoreti ed infine a reti di altri siti.

![[Pasted image 20261023112548.png]]

> [!example]
> ![[Pasted image 20261023112607.png]]

> [!example]
> hostname Matt ! interface serial 1 ip address 10.0.0.2 255.0.0.0 ip ospf network point-to-multipoint encapsulation frame-relay frame-relay map ip 10.0.0.1 201 broadcast frame-relay map ip 10.0.0.3 202 broadcast frame-relay map ip 10.0.0.4 203 broadcast ! router ospf 1 network 10.0.0.0 0.0.0.255 area 0
> 
> hostname Wayne ! interface serial 0 ip address 10.0.0.1 255.0.0.0 ip ospf network point-to-multipoint encapsulation frame-relay frame-relay map ip 10.0.0.2 101 broadcast frame-relay map ip 10.0.0.4 102 broadcast ! router ospf 1 network 10.0.0.0 0.0.0.255 area 0
> 
> hostname Robin ! interface serial 3 ip address 10.0.0.4 255.0.0.0 ip ospf network point-to-multipoint encapsulation frame-relay clockrate 1000000 frame-relay map ip 10.0.0.1 401 broadcast frame-relay map ip 10.0.0.2 402 broadcast ! router ospf 1 network 10.0.0.0 0.0.0.255 area 0
> 
> hostname Ben ! interface serial 2 ip address 10.0.0.3 255.0.0.0 ip ospf network point-to-multipoint encapsulation frame-relay clockrate 2000000 frame-relay map ip 10.0.0.2 301 broadcast ! router ospf 1 network 10.0.0.0 0.0.0.255 area 0

RIP 
■ RIP è un popolare algoritmo di routing, definito negli RFC 1058 e 1023. ■ E' implementato dal programma routed ■ Si basa sull’algoritmo di Bellman-Ford, detto anche vettoredistanza ■ RIP ha il limite di 15 hops: reti più distanti sono considerate irraggiungibili ■ RIP v 1 non supporta subnet variabili ■ Un router che implementa RIP invia tutta la routing table o una porzione di essa ai router vicini (neighbor) (distanti 1 hop) ad intervalli di tempo regolari

Due forme di RIP ■ Attiva • Forma usata dai router • Invia in broadcast periodicamente aggiornamenti di routing • Usa I messaggi in arrivo per aggiornare la routing table ■ Passiva • Forma usata dagli host • Usa I messaggi in arrivo per aggiornare la routing table • Non invia aggiornamenti ■ Ogni router invia update ogni 30 secondi ■ Gli aggiornamenti contengono coppie di valori del tipo: (destination address, distance) ■ La distanza di 16 è infinita (non viene fatto routing)

■ RIP converge meno rapidamente di OSPF: ciò lo rende più fragile per quanto attiene la possibilità di generare routing loops ■ RIP ha bisogno di meno risorse di OSPF, in quanto l’algoritmo è più leggero ■ RIP è disponibile per default sui sistemi Unix/Linux (daemon routed) ■ E’ più semplice da implementare e gestire rispetto a OSPF ■ RIP distingue i router tra attivi (coloro che trasmettono le istruzioni di routing) e passivi (ricevono i messaggi e aggiornano la loro routing table): solo un router può essere attivo (un host è passivo)

■ Routing updates: RIP invia questi messaggi a intervalli regolari o quando cambia la topologia della rete ai router confinanti. ■ RIP timers: RIP mantiene i timer routing-update timer(30 sec, in genere), route timeout, route-flush timer ■ RIP mantiene solo le informazioni relative a best routes ■ RIP usa il protocollo UDP e la porta 520

RIP packet format
![[Pasted image 20261023115154.png]]

RIP 2 packet format
![[Pasted image 20261023115218.png]]

■ Per evitare oscillazioni tra percorsi di costo uguale, RIP specifica che gli istradamenti esistenti dovrebbero essere mantenuti sino a che uno nuovo non abbia un costo rigorosamente più basso (applica l'isteresi, cioè un meccanismo che reagisce in ritardo alle sollecitazioni e dove lo stato attuale dipende anche dallo stato precedente) ■ Quando un router si guasta gli altri router annulleranno le informazioni di routing relative allo scadere dei timer associati all'istruzione di route ■ RIP deve gestire tre errori causati dall'algoritmo sottostante. In primo luogo poiché non rileva i routing loop. Inoltre per evitare instabilità deve usare un numero basso (16 in genere) come distanza massima presa in esame in termini di routers. Inoltre l'algoritmo genera problemi di convergenza lenta.

■ Per evitare I problemi di convergenza lenta I router adottano la tecnica dello split horizon update: il router non propaga informazioni su una route al router che ha generato tale aggiornamento. ■ Un'altra tecnica è l'hold down, che costringe un router a ignorare aggiornamenti inerenti una rete per un certo tempo (60 sec in genere), una volta che ha ricevuto un messaggio di rete irrangiugibile. ■ Altra tecnica è il poison reverse: quando un collegamento scompare, il router che effettuava l'annuncio continua ad annunciarlo ancora per un certo tempo assegnandogli una distanza infinita. ■ Questo va accompagnato al triggered update, che obbliga i routerad annunciare la scomparsa di route immediatamente senza attendere che i timer si azzerino.

> [!example]
> ![[Pasted image 20261023115246.png]]

RIP: schema di indirizzamento
![[Pasted image 20261023115307.png]]

> [!example] Esempio di configurazione
> ![[Pasted image 20261023115329.png]]

Inserimento di una dorsale OSPF in RIP
![[Pasted image 20261023115352.png]]

> [!example] Esempio di configurazione
> ![[Pasted image 20261023115411.png]]

Unicast updates ■ E’ possibile in RIP 2 ridurre le informazioni di routing mediante invio di routing update a selezionati router (neighbor) invece che in modalità broadcast: router rip network 10.109.0.0 passive-interface ethernet 1 neighbor 10.109.20.4

Modifica delle informazioni di routing ■ E’ possibile alterare localmente le informazioni di routing apprese tramite RIP o da propagare all’esterno, in modo da alterarne volutamente l’effetto: offset-list [acl_num|name] {in|out} offset [type_number]

Timers
![[Pasted image 20261023115733.png]]

Autenticazione (RIP 2)
![[Pasted image 20261023115751.png]]

Border Gateway Protocol (BGP)
■ I router di Internet devono essere divisi in gruppi per 3 motivi: • Se ogni organizzazione fosse costituita da una singola rete, non esisterebbe un protocollo di routing in grado di scambiare informazioni di routing in modo efficiente: se il numro di router è grande il traffico diventa insostenibile. • Poiché non condividono una rete comune, i router di Internet non possono comunicare direttamente • In una grande rete Internet, le reti e i router non possono essere gestiti tutti da una singola entità e non sono sempre scelti I percorsi più brevi. Poiché le reti sono possedute e gestite da organizzazioni commerciali indipendenti, queste devono poter scegliere politiche differenti

■ Un'architettura d'instradamento deve fornire un modo perché ciascun gruppo controlli indipendentemente l'istradamento e l'accesso ■ Due sono i problemi che impattano sulla capacità dei router di scambiarsi efficientemente le informazioni di routing: • Il ritardo: il tempo che occorre affinché le informazioni aggiornate si propaghino dipende dal numero di router coinvolti, N. Per questo N deve essere mantenuto piccolo. • L'overhead: poiché ogni router deve inviare messaggi per aggiornare le informazioni, maggiore è il numero di router coinvolti, maggiore è il traffico. Siccome i messaggi contengono l'elenco delle possibili destinazioni, anche le dimensioni aumentano al crescere del numero di router.

![[Pasted image 20261023115826.png]]

■ Se un router esterno ad un gruppo (R 3) sceglie un router partecipante ad un gruppo (R 1) come default router si generano inefficienze: R 3 invierà a R 1 anche il traffico destinato alla rete 2 invece che inviare i pacchetti direttamente a R 2 (problema del salto extra). ■ ICMP non aiuta perché tali info non possono essere scambiate con i router intermedi, ma solo alla sorgente.

![[Pasted image 20261023115846.png]]

■ I router R 1 e R 2 sono peer BGP uno dell'altro e sono detti router di confine dei rispettivi Autonomous System ■ I router R 1 e R 2, attraverso BGP, annunciano la raggiungibilità delle reti dei propri AS all'esterno

■ Caratteristiche di BGP: • Comunicazione tra AS • Coordinamento tra più router BGP (iBGP) • Diffusione delle informazioni di raggiungibilità • Paradigma del salto successivo • Supporto delle politiche di routing • Trasporto affidabile • Informazioni d'instradamento • Aggiornamenti incrementali • Supporto per l'indirizzamento senza classi • Aggregazione di routes • Autenticazione

■ I peer che eseguono il protocollo BGP eseguono tre funzioni di base: • Innanzitutto i peer si autenticano l'un l'altro e si scambiano un insieme di messaggi per stabilire la correttezza delle operazioni e se entrambi sono disponibili a comunicare • Successivamente avviene la fase principale del BGP: ciascuno invia all'altro le informazioni relative alle reti raggiungibili, fornendo i dati del salto successivo, o non più raggiungibili. • La terza funzione permette di verificare che i peer e la connessione di rete stanno funzionando correttamente. ■ Per eseguire queste tre funzioni, il protocollo BGP definisce un insieme di 5 messaggi: • Open • Update • Notification • Keepalive • Refresh

■ Diversi sono i documenti RFC relativi a BGP, tra i quali: • RFC 1771—Descrive BGP 4, la versione corrente di BGP • RFC 1654—Descrive la prima specifica di BGP 4 • RFC 1105, RFC 1163, e RFC 1267—Descrivono le versioni precedenti di BGP rispetto a BGP 4

■ BGP effettua interdomain routing in reti TCP/IP. ■ E’ un Exterior Gateway Protocol (EGP) usato per la comunicazione tra AS ■ Si basa su un algoritmo vettore-distanza evoluto ■ Si occupa del transito di dati di terze parti su una certa rete. Le reti vengono suddivise in: reti stub (unica connessione al grafo BGP) reti multiconnesse (usate per il traffico in transito) reti di transito (sono disponibili al transito di traffico di terze parti, sono spesso reti di tipo backbone)

![[Pasted image 20261023115921.png]]

BGP effettua inter-autonomous system routing: • avviene tra due o più router BGP appartenenti ad AS diversi. • Router vicini (peers, o neighbors) usano BGP per mantenere una vista omogenea della topologia della rete. • Internet usa questo tipo di routing, essendo costituita da entità che appartengono a diversi AS • BGP è utilizzato in questi casi per calcolare il percorso che fornisca il routing migliore attraverso Internet

intra-autonomous system routing: • avviene tra due o più router BGP appartenenti allo stesso AS (iBGP). • Router vicini usano BGP per mantenere una vista omogenea della topologia del sistema. • BGP identifica quale router serve da punto di connessione ottimale per l’interconnessione con specifici AS esterni. • Internet usa questo tipo di routing per consentire ad un’organizzazione di usare BGP per fornire il routing ottimale tra i suoi AS. • BGP può fornire servizi di routing sia inter- che intra- autonomous system

pass-through autonomous system routing: • avviene tra due o più router BGP che scambiano traffico attraverso un AS che non esegue BGP. • In un ambiente pass-through il traffico BGP non origina dentro l’AS in questione e non è destinato a nessun nodo interno dell’AS stesso.

![[Pasted image 20261023115949.png]]

■ BGP usa la porta TCP 179 ■ Due router BGP formano tra loro una connessione TCP (peer o neighbor routers), si autenticano reciprocamente e scambiano messaggi per aprire e confermare i parametri di connessione. ■ I due neighbor all’inizio si scambiano tutta la loro routing table, comunicando per ciascuna rete (in formato Classless Inter Doman Router (CIDR), cioè indirizzo IP/bit subnet mask) il prossimo hop ■ Successivamente vengono scambiati messaggi contenenti gli aggiornamenti sui percorsi modificati ■ BGP verifica continuamente che i partner e le reti stiano funzionando correttamente.

BGP routing 
■ BGP mantiene le routing tables, trasmette routing update e basa le decisioni di routing sulla base delle routing metric ■ Le funzioni primarie sono lo scambio di informazioni network reachability, inclusa la lista dei percorsi per gli AS con altri sistemi BGP ■ Ogni router BGP mantiene una lista di tutti i percorsi fattibili verso una particolare rete. Il router non aggiorna le tabelle fino a che non riceve un aggiornamento incrementale.

■ I dispositivi BGP scambiano informazioni di routing sulla base di uno scambio iniziale e successivi aggiornamenti. ■ Quando un router si collega per la prima volta riceve l’intera tabella di routing. Similmente quando le informazioni cambiano, vengono spedite in forma di insieme di aggiornamenti periodici. ■ L’aggiornamento propaga solo il routing ottimale per una certa rete

■ BGP mantiene un numero di versione della routing table che deve essere lo stesso per il rispettivo peer BGP ■ Il numero di versione cambia ogni volta che BGP aggiorna la routing table attraverso aggiornamenti ■ pacchetti di tipo keepalive sono inviati per verificare l’integrità della sessione BGP tra i peers ■ pacchetti di tipo notification sono inviati in risposta a condizioni di errore o in situazioni speciali

■ BGP usa una routing metric singola, che consiste in un numero in unità arbitrarie che specifica il grado di preferenza per quel dato link. ■ Viene assegnato dal Network Administrator ad ogni link ■ Il numero assegnato può basarsi su ogni tipo di criterio possibile, incluso il numero di AS che devono essere attraversati, la scalabilità, la velocità, il ritardo della comunicazione, il costo.

BGP: tipi di messaggi 
■ L’RFC 1771, A Border Gateway Protocol 4 (BGP-4), definisce 5 tipi di messaggio: open message: apre una sessione BGP tra peers ed è il primo messaggio inviato da ciascuna parte dopo l’attivazione della sessione TCP. Questo messaggio è confermato da un messaggio keep-alive del peer e deve essere confermato prima che abbia luogo lo scambio di messaggi ordinario. update message: è usato per effettuare l’aggiornamento del routing ad ogni sistema BGP, consentendo ai router di effettuare un disegno consistente della topologia di rete. Gli aggiornamenti sono inviati usando TCP per ragioni di affidabilità. Il messaggio di update può cancellare route irrangiungibili dalla routing table

notification message: è inviato quando si evidenzia una condizione di errore. Il messaggio notification è utilizzato per chiudere una sessione attiva e per avvisare i router connessi del perché la sessione viene chiusa keep-alive message: informa ogni sistema peer BGP che un dispositivo è attivo. I messaggi keep-alive sono inviati con una frequenza tale da prevenire che la sessione BGP si esaurisca. refresh message: richiede il reinvio delle informazioni di routing per una rete da parte di un peer

//inserisci tutto: testo e foto fino alla fine del pdf//