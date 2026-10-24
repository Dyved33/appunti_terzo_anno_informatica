# Protocolli di routing: OSPF, RIP e BGP

## Autonomous System e ASN

Le reti e gli Intermediate System (IS) si suddividono in:
- interni ad un dominio di routing
- esterni ad un dominio di routing

Per dominio di routing si intende l'insieme delle reti che sono soggette all'amministrazione ed al controllo di una stessa organizzazione. Il dominio di routing prende il nome di **Autonomous System** o AS ed identifica la politica di routing adottata. L'AS condiziona il routing, consentendo ad un'organizzazione di attivare diverse politiche.

L'RFC 1930 definisce le modalità con le quali diverse organizzazioni possono effettuare routing BGP usando degli AS privati attraverso ad unico ISP che connette queste organizzazioni ad Internet. Anche se ci possono essere diversi AS gestiti da un ISP, la sua politica di routing viene identificata da un Autonomous System Number (ASN) ufficialmente registrato. Un ASN viene assegnato a ciascun AS per poter effettuare routing BGP. Gli ASN identificano univocamente le reti ai fini del routing.

**Formato degli ASN:**
- Fino al 2007 gli ASN erano indicati da un numero intero a 16 bit (0-65536), denominati *asplain*
- RFC 4893 definisce una nuova sintassi per la numerazione degli AS, che prende il nome di *asdot*, nella forma x.y, con x e y numeri interi di 16 bit. I numeri 0.y coincidono con gli asplain
- L'ASN 23456 è stato assegnato da IANA come variabile metasintattica per valori di ASN a 32 bit nel caso in cui router BGP in grado di gestire la nuova sintassi comunicassero con router BGP di vecchia generazione non in grado di comprendere ASN a 32 bit
- Gli ASN 0 e 65535, e l'ultimo ASN della numerazione a 32 bit: 4.294.967.295 sono riservati e non possono essere usati dagli operatori
- Gli ASN 64.512–65.534 e 4.200.000.000-4.294.967.294 sono riservati per uso privato dall'RFC 6996

Gli ASN vengono assegnati da ICANN (in passato da IANA) ai Regional Internet Registries (RIRs). Gli AS si suddividono in:
- *multihomed autonomous system:* AS che mantiene connessioni con più di un AS. Ciò consente all'AS di rimanere connesso alla rete Internet anche in presenza di un malfunzionamento di una delle connessioni. Questo AS non consente di effettuare il pass-through con un altro AS
- *stub autonomous system:* AS connesso solamente con un altro AS. Sembra un controsenso e uno spreco di ASN. Questo AS consente forme di peering privato con altri AS che non viene riflesso nelle politiche generali di routing
- *transit autonomous system:* AS che fornisce attraverso di sé connessioni con altre reti. La rete A può usare la rete B, appartenente ad un transit AS, per connettersi alla rete C. Se un AS è un ISP per un altro AS, allora questi è un transit AS

Condizione necessaria per ottenere il rilascio di un ASN è quella di possedere due distinte connessioni ad Internet, attraverso diversi provider (ISP). Un ISP ha più ASN assegnati per poter gestire situazioni differenti.

I router che instradano messaggi all'interno dello stesso AS sono detti *Interior Router*, mentre quelli che instradano messaggi anche tra AS diversi sono detti *Exterior Router*:
- Gli Interior Router eseguono un Interior Gateway Protocol (IGP) per determinare il percorso ottimale
- Gli Exterior Router eseguono un Exterior Gateway Protocol (EGP)

> [!example] Esempio di connessione multihomed, considerando degli asplain
> ![[images/slide-031.png|500]]

![[images/slide-032.png|500]]

## Routing statico e routing dinamico

**Route statiche:**
- Sono inizializzate allo start-up
- Non cambiano mai
- Sono tipiche degli host
- Usate qualche volta nei router

**Route dinamiche:**
- Sono inizializzate allo start-up
- Aggiornate mediante dei protocolli di propagazione dei router
- Sono tipiche dei router
- Usate qualche volta negli host

> [!example] Esempio di routing statico ottimale
> Ogni rete ha soltanto una possibile route.
> ![[images/slide-034.png|500]]

> [!example] Esempio nel quale è necessario il routing dinamico
> Ci sono più percorsi possibili per raggiungere una rete.
> ![[images/slide-035.png|500]]

## Interior Gateway Protocol

Lo scambio di informazioni di routing all'interno di un AS avviene tramite un meccanismo denominato Interior Gateway Protocols, IGP. Le scelte di tipo IGP sono effettuate dall'AS.

N.B.: se un AS si connette al resto del mondo, un router nell'AS deve usare un protocollo EGP per annunciare la raggiungibilità della rete ad altri AS.

![[images/Pasted image 20261023110854.png|500]]

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="images/Pasted image 20261023111029.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Schema dei protocolli di routing: a sinistra gli Interior Gateway Protocol (RIP - Routing Information Protocol, IGRP - Interior Gateway Routing Protocol, OSPF - Open Shortest Path First), usati all'interno di un AS; a destra gli Exterior Gateway Protocol (EGP - Exterior Gateway Protocol, BGP - Border Gateway Protocol, IS-IS - Intermediate System to Intermediate System), usati per lo scambio tra AS diversi. In basso CIDR - Classless Inter Domain Routing.
  </div>
</div>

## OSPF

Open Shortest Path First (OSPF):
- Sviluppato nel 1988 dall'IGP working group di IETF, standard nel 1990 (RFC 1247) per routing all'interno di un AS
- Una risposta di tipo Open Source ai protocolli proprietari, di straordinaria efficienza, molto complesso da configurare e gestire
- OSPF è aperto
- È basato sull'algoritmo Shortest Path First (Dijkstra algorithm)
- Supporta subnet variabili
- Implementa routing dinamico
- Supporta routing in base al tipo di servizio
- Esegue il bilanciamento del carico
- Supporta l'autenticazione dei messaggi
- Supporta sistemi gerarchici (aree)

È un *link-state routing protocol* così chiamato perché invia *link-state advertisements* (LSA) a tutti i router di una stessa area gerarchica. Nell'LSA invia informazioni relative alle interfacce attive, alle metriche usate, ed altre variabili. Un router OSPF accumula LSA e calcola il percorso ottimale mediante l'algoritmo SPF. È computazionalmente relativamente pesante.

I router di una stessa area condividono lo stesso *topological database*. La suddivisione in aree riduce il traffico di routing nell'AS. L'introduzione delle aree genera due tipi di traffico di routing:
- Inter-area routing
- Intra-area routing

L'OSPF backbone è responsabile di distribuire informazioni di routing tra aree.

**Esempio di OSPF gerarchico:** le aree 1, 2 e 3 condividono il backbone dell'AS; i router di confine collegano le aree e consentono lo scambio delle informazioni di routing.

![[images/Pasted image 20261023111642.png|500]]

Le aree possono essere definite in modo tale che il backbone non sia continuo: in tal caso la continuità può essere realizzata mediante *virtual-links*. Questo permette ai gestori della rete di definire una topologia logica differente da quella fisica. I virtual-links vengono definiti tra i backbone router che condividono link con aree non-backbone e funzionano come se fossero link diretti. OSPF può apprendere informazioni da altri exterior gateway protocol, interior gateway protocol, o mediante istruzioni di configurazione.

OSPF può operare all'interno di una gerarchia; la maggiore entità gerarchica è l'AS. OSPF è un intra-AS (IGP) routing protocol, anche se può inviare e ricevere route verso o da altri AS. Un AS può essere diviso in diverse aree, che è bene riguardino host in gruppi di reti contigue per semplificare la routing table. Router con diverse interfacce possono appartenere a più aree e prendono il nome di *Area Border Router* (ABR). Essi mantengono diversi topological database per ogni area.

OSPF distingue 4 tipi di router:
- *Internal router:* interni ad un'area
- *Area Border router:* che connettono 2 o più aree
- *Backbone router:* che appartengono alla dorsale (area 0)
- *Border AS router:* router di confine tra AS

Quando un router viene avviato mediante messaggi di tipo HELLO inviati su tutte le interfacce, si costruisce la mappa topologica ed in particolare definisce:
- i router adiacenti
- il *designated router* (DR)
- il *backup designated router* (BDR)

**OSPF packets:** i router che non sono adiacenti non scambiano tra loro informazioni. I pacchetti OSPF sono:
- *Hello:* usato per scoprire i neighbors
- *Link state update:* fornisce i propri criteri per la selezione del costo del link
- *Link state ack:* conferma un LS update
- *Database description:* comunica gli aggiornamenti che conosce
- *Link state request:* richiesta di informazioni di stato ai neighbor routers

![[images/Pasted image 20261023112411.png|500]]

**OSPF Hello packet:** due router OSPF vicini si scambiano periodicamente questo pacchetto per verificare la reciproca raggiungibilità.
- *ROUTER DEAD INTERVAL* indica il tempo trascorso il quale se il router vicino non risponde, è considerato inattivo
- *HELLO INTERVAL* è il tempo che intercorre tra messaggi HELLO
- *GWAY PRIO* indica la priorità del router e serve per identificare il Backup Designed Router (BDR)

**Formato dei messaggi di descrizione del database OSPF:** per inizializzare il loro topological database i router si scambiano dei messaggi di descrizione del database OSPF. Nello scambio uno funge da router principale (master), l'altro secondario (slave) e conferma la ricezione di ogni messaggio con una risposta.

![[images/Pasted image 20261023112445.png|500]]

Poiché il messaggio può essere molto esteso, vengono utilizzati i bit I (impostato a 1 nel messaggio iniziale) e M (impostato a 1 nei messaggi che seguono). Il bit S indica se il messaggio è stato inviato ad un master (1) o a uno slave (0). *DATABASE SEQUENCE NUMBER* numera in sequenza i messaggi, in modo che il ricevente possa identificare eventuali messaggi persi. Il primo contiene un numero R casuale, i successivi interi sequenziali a partire da R. I campi da *Link AGE* a *Link LENGTH* descrivono un collegamento di rete. *Link TYPE* indica il tipo di collegamento:
1. collegamento del router
2. collegamento di rete
3. collegamento di riepilogo (rete IP)
4. collegamento di riepilogo (collegamento al router di confine)
5. collegamento esterno (collegamento ad un altro sito)

Dopo aver scambiato messaggi di descrizione del database con un vicino, un router può scoprire parti obsolete del suo database. Affinché il vicino gli risponda con gli aggiornamenti, il router invia un messaggio di richiesta dello stato dei collegamenti. Il vicino risponde con le informazioni aggiornate che ha.

![[images/Pasted image 20261023112510.png|500]]

I router trasmettono in broadcast lo stato dei collegamenti con un messaggio di aggiornamento dello stato dei collegamenti.

![[images/Pasted image 20261023112527.png|500]]

**Formato dell'intestazione usata nei messaggi sullo stato dei collegamenti OSPF:** l'intestazione dello stato dei collegamenti usa uno dei quattro possibili formati per descrivere i collegamenti del router ad una certa area, a una rete specifica, alle reti fisiche di una rete IP suddivisa in sottoreti ed infine a reti di altri siti.

![[images/slide-052.png|500]]

> [!example] OSPF: esempio
> ![[images/Pasted image 20261023112607.png|500]]

> [!example] OSPF: esempio di configurazione
> Router Matt:
> ```
> hostname Matt
> !
> interface serial 1
>  ip address 10.0.0.2 255.0.0.0
>  ip ospf network point-to-multipoint
>  encapsulation frame-relay
>  frame-relay map ip 10.0.0.1 201 broadcast
>  frame-relay map ip 10.0.0.3 202 broadcast
>  frame-relay map ip 10.0.0.4 203 broadcast
> !
> router ospf 1
>  network 10.0.0.0 0.0.0.255 area 0
> ```
> Router Wayne:
> ```
> hostname Wayne
> !
> interface serial 0
>  ip address 10.0.0.1 255.0.0.0
>  ip ospf network point-to-multipoint
>  encapsulation frame-relay
>  frame-relay map ip 10.0.0.2 101 broadcast
>  frame-relay map ip 10.0.0.4 102 broadcast
> !
> router ospf 1
>  network 10.0.0.0 0.0.0.255 area 0
> ```
> Router Robin:
> ```
> hostname Robin
> !
> interface serial 3
>  ip address 10.0.0.4 255.0.0.0
>  ip ospf network point-to-multipoint
>  encapsulation frame-relay
>  clockrate 1000000
>  frame-relay map ip 10.0.0.1 401 broadcast
>  frame-relay map ip 10.0.0.2 402 broadcast
> !
> router ospf 1
>  network 10.0.0.0 0.0.0.255 area 0
> ```
> Router Ben:
> ```
> hostname Ben
> !
> interface serial 2
>  ip address 10.0.0.3 255.0.0.0
>  ip ospf network point-to-multipoint
>  encapsulation frame-relay
>  clockrate 2000000
>  frame-relay map ip 10.0.0.2 301 broadcast
> !
> router ospf 1
>  network 10.0.0.0 0.0.0.255 area 0
> ```

## RIP

RIP è un popolare algoritmo di routing, definito negli RFC 1058 e 1023. È implementato dal programma `routed`. Si basa sull'algoritmo di Bellman-Ford, detto anche *vettore-distanza*.
- RIP ha il limite di 15 hops: reti più distanti sono considerate irraggiungibili
- RIP v1 non supporta subnet variabili
- Un router che implementa RIP invia tutta la routing table o una porzione di essa ai router vicini (neighbor) (distanti 1 hop) ad intervalli di tempo regolari

**Due forme di RIP:**
- *Attiva* — forma usata dai router: invia in broadcast periodicamente aggiornamenti di routing, usa i messaggi in arrivo per aggiornare la routing table
- *Passiva* — forma usata dagli host: usa i messaggi in arrivo per aggiornare la routing table, non invia aggiornamenti

Ogni router invia update ogni 30 secondi. Gli aggiornamenti contengono coppie di valori del tipo: (destination address, distance). La distanza di 16 è infinita (non viene fatto routing).

- RIP converge meno rapidamente di OSPF: ciò lo rende più fragile per quanto attiene la possibilità di generare routing loops
- RIP ha bisogno di meno risorse di OSPF, in quanto l'algoritmo è più leggero
- RIP è disponibile per default sui sistemi Unix/Linux (daemon `routed`)
- È più semplice da implementare e gestire rispetto a OSPF
- RIP distingue i router tra attivi (coloro che trasmettono le istruzioni di routing) e passivi (ricevono i messaggi e aggiornano la loro routing table): solo un router può essere attivo (un host è passivo)

*Routing updates:* RIP invia questi messaggi a intervalli regolari o quando cambia la topologia della rete ai router confinanti. *RIP timers:* RIP mantiene i timer routing-update timer (30 sec, in genere), route timeout, route-flush timer. RIP mantiene solo le informazioni relative a best routes. RIP usa il protocollo [[Lezione 6-UDP e TCP e routing|UDP]] e la porta 520.

> [!example] RIP packet format
> ![[images/Pasted image 20261023115154.png|500]]

> [!example] RIP 2 packet format
> ![[images/Pasted image 20261023115218.png|500]]

Campi del RIP 2 packet format:
- *Command:* indica se il pacchetto è un comando oppure una risposta
- *Version number:* identifica la versione del software RIP usato
- *Unused:* valore posto a zero
- *Address-Family-Identifier:* identifica la famiglia di protocolli utilizzata. RIP è concepito per trasportare informazioni relative a diversi protocolli. La famiglia di indirizzi per l'IP è 2
- *Route tag:* fornisce un metodo per distinguere fra routing interno ed esterno (appreso da altri protocolli)
- *IP Address:* specifica l'IP address relativa all'informazione di routing
- *Subnet-Mask:* specifica la subnet mask relativa all'informazione di routing
- *Next-Hop:* specifica il next-hop al quale deve essere indirizzata l'informazione di routing
- *metric:* indica quanti router intermedi devono essere attraversati fino alla rete di destinazione. Questo valore va da 1 a 15. Un valore uguale o maggiore di 16 indica network unreachable

Per evitare oscillazioni tra percorsi di costo uguale, RIP specifica che gli istradamenti esistenti dovrebbero essere mantenuti sino a che uno nuovo non abbia un costo rigorosamente più basso (applica l'isteresi, cioè un meccanismo che reagisce in ritardo alle sollecitazioni e dove lo stato attuale dipende anche dallo stato precedente). Quando un router si guasta gli altri router annulleranno le informazioni di routing relative allo scadere dei timer associati all'istruzione di route. RIP deve gestire tre errori causati dall'algoritmo sottostante: in primo luogo poiché non rileva i routing loop; inoltre per evitare instabilità deve usare un numero basso (16 in genere) come distanza massima presa in esame in termini di routers; infine l'algoritmo genera problemi di convergenza lenta.

Per evitare i problemi di convergenza lenta i router adottano alcune tecniche:
- *split horizon update:* il router non propaga informazioni su una route al router che ha generato tale aggiornamento
- *hold down:* costringe un router a ignorare aggiornamenti inerenti una rete per un certo tempo (60 sec in genere), una volta che ha ricevuto un messaggio di rete irraggiungibile
- *poison reverse:* quando un collegamento scompare, il router che effettuava l'annuncio continua ad annunciarlo ancora per un certo tempo assegnandogli una distanza infinita. Questo va accompagnato al *triggered update*, che obbliga i router ad annunciare la scomparsa di route immediatamente senza attendere che i timer si azzerino

> [!example]
> ![[images/Pasted image 20261023115246.png|500]]

**RIP: schema di indirizzamento**

![[images/Pasted image 20261023115307.png|500]]

> [!example] Esempio di configurazione
> ![[images/Pasted image 20261023115329.png|500]]

**Inserimento di una dorsale OSPF in RIP**

> [!example] Esempio di configurazione
> ![[images/Pasted image 20261023115352.png|500]]

> [!example] Esempio di configurazione (Router A)
> ```
> router rip
>  passive-interface serial 0
>  passive-interface serial 1
> ```
> Ridistribuzione — alle informazioni OSPF propagate via RIP viene assegnata la metric 10:
> ```
> router ospf 109
>  redistribute rip subnets
> !
> router rip
>  redistribute ospf 109 match internal external 1 external 2
>  default-metric 10
> ```
> Alternativa:
> ```
> router ospf 109
>  redistribute rip subnet
>  distribute-list 11 out rip
> access-list 11 permit 130.10.8.0 0.0.7.255
> access-list 11 deny 0.0.0.0 255.255.255.255
> ```

**Unicast updates:** è possibile in RIP 2 ridurre le informazioni di routing mediante invio di routing update a selezionati router (neighbor) invece che in modalità broadcast:

```
router rip
 network 10.109.0.0
 passive-interface ethernet 1
 neighbor 10.109.20.4
```

**Modifica delle informazioni di routing:** è possibile alterare localmente le informazioni di routing apprese tramite RIP o da propagare all'esterno, in modo da alterarne volutamente l'effetto:

```
offset-list [acl_num|name] {in|out} offset [type_number]
```

**Timers**

![[images/Pasted image 20261023115733.png|500]]

**Autenticazione (RIP 2)**

![[images/Pasted image 20261023115751.png|500]]

Esempio di autenticazione MD5 tra i router RA e RB. Entrambi usano la key chain `ka1`, la chiave 1 con stringa `234` e abilitano l'autenticazione RIP sull'interfaccia seriale:

```text
router RA                                      router RB
key chain ka1                                   key chain ka1
 key 1                                          key 1
  key-string 234                                 key-string 234
interface loopback0                             interface loopback0
 ip address 70.70.70.70 255.255.255.255         ip address 80.80.80.1 255.255.255.0
interface serial0                               interface serial0
 ip address 141.108.0.10 255.255.255.252        ip address 141.108.0.9 255.255.255.252
 ip rip authentication mode md5                 ip rip authentication mode md5
 ip rip authentication key-chain ka1            ip rip authentication key-chain ka1
router rip                                      router rip
 version 2                                      version 2
 network 141.108.0.0                            network 141.108.0.0
 network 70.0.0.0                               network 80.0.0.0
```

## Border Gateway Protocol

I router di Internet devono essere divisi in gruppi per 3 motivi:
- Se ogni organizzazione fosse costituita da una singola rete, non esisterebbe un protocollo di routing in grado di scambiare informazioni di routing in modo efficiente: se il numero di router è grande il traffico diventa insostenibile
- Poiché non condividono una rete comune, i router di Internet non possono comunicare direttamente
- In una grande rete Internet, le reti e i router non possono essere gestiti tutti da una singola entità e non sono sempre scelti i percorsi più brevi. Poiché le reti sono possedute e gestite da organizzazioni commerciali indipendenti, queste devono poter scegliere politiche differenti

Un'architettura d'instradamento deve fornire un modo perché ciascun gruppo controlli indipendentemente l'istradamento e l'accesso. Due sono i problemi che impattano sulla capacità dei router di scambiarsi efficientemente le informazioni di routing:
- *Il ritardo:* il tempo che occorre affinché le informazioni aggiornate si propaghino dipende dal numero di router coinvolti, N. Per questo N deve essere mantenuto piccolo
- *L'overhead:* poiché ogni router deve inviare messaggi per aggiornare le informazioni, maggiore è il numero di router coinvolti, maggiore è il traffico. Siccome i messaggi contengono l'elenco delle possibili destinazioni, anche le dimensioni aumentano al crescere del numero di router

**Topologia tra Autonomous System:** lo schema rappresenta i router di confine e le sessioni BGP usate per scambiare informazioni di raggiungibilità tra AS.

![[images/slide-084.png|500]]

![[images/Pasted image 20261023115826.png|500]]

Se un router esterno ad un gruppo (R3) sceglie un router partecipante ad un gruppo (R1) come default router si generano inefficienze: R3 invierà a R1 anche il traffico destinato alla rete 2 invece che inviare i pacchetti direttamente a R2 (problema del salto extra). ICMP non aiuta perché tali info non possono essere scambiate con i router intermedi, ma solo alla sorgente.

![[images/Pasted image 20261023115846.png|500]]

I router R1 e R2 sono peer BGP uno dell'altro e sono detti router di confine dei rispettivi Autonomous System. I router R1 e R2, attraverso BGP, annunciano la raggiungibilità delle reti dei propri AS all'esterno.

**Caratteristiche di BGP:**
- Comunicazione tra AS
- Coordinamento tra più router BGP (iBGP)
- Diffusione delle informazioni di raggiungibilità
- Paradigma del salto successivo
- Supporto delle politiche di routing
- Trasporto affidabile
- Informazioni d'instradamento
- Aggiornamenti incrementali
- Supporto per l'indirizzamento senza classi
- Aggregazione di routes
- Autenticazione

I peer che eseguono il protocollo BGP eseguono tre funzioni di base:
1. Innanzitutto i peer si autenticano l'un l'altro e si scambiano un insieme di messaggi per stabilire la correttezza delle operazioni e se entrambi sono disponibili a comunicare
2. Successivamente avviene la fase principale del BGP: ciascuno invia all'altro le informazioni relative alle reti raggiungibili, fornendo i dati del salto successivo, o non più raggiungibili
3. La terza funzione permette di verificare che i peer e la connessione di rete stanno funzionando correttamente

Per eseguire queste tre funzioni, il protocollo BGP definisce un insieme di 5 messaggi: Open, Update, Notification, Keepalive, Refresh.

Diversi sono i documenti RFC relativi a BGP, tra i quali:
- RFC 1771 — descrive BGP4, la versione corrente di BGP
- RFC 1654 — descrive la prima specifica di BGP4
- RFC 1105, RFC 1163, e RFC 1267 — descrivono le versioni precedenti di BGP rispetto a BGP4

BGP effettua interdomain routing in reti TCP/IP. È un Exterior Gateway Protocol (EGP) usato per la comunicazione tra AS. Si basa su un algoritmo vettore-distanza evoluto. Si occupa del transito di dati di terze parti su una certa rete. Le reti vengono suddivise in:
- reti stub (unica connessione al grafo BGP)
- reti multiconnesse (usate per il traffico in transito)
- reti di transito (sono disponibili al transito di traffico di terze parti, sono spesso reti di tipo backbone)

![[images/Pasted image 20261023115921.png|500]]

**BGP effettua inter-autonomous system routing:**
- Avviene tra due o più router BGP appartenenti ad AS diversi
- Router vicini (peers, o neighbors) usano BGP per mantenere una vista omogenea della topologia della rete
- Internet usa questo tipo di routing, essendo costituita da entità che appartengono a diversi AS
- BGP è utilizzato in questi casi per calcolare il percorso che fornisca il routing migliore attraverso Internet

**Intra-autonomous system routing:**
- Avviene tra due o più router BGP appartenenti allo stesso AS (iBGP)
- Router vicini usano BGP per mantenere una vista omogenea della topologia del sistema
- BGP identifica quale router serve da punto di connessione ottimale per l'interconnessione con specifici AS esterni
- Internet usa questo tipo di routing per consentire ad un'organizzazione di usare BGP per fornire il routing ottimale tra i suoi AS
- BGP può fornire servizi di routing sia inter- che intra- autonomous system

**Pass-through autonomous system routing:**
- Avviene tra due o più router BGP che scambiano traffico attraverso un AS che non esegue BGP
- In un ambiente pass-through il traffico BGP non origina dentro l'AS in questione e non è destinato a nessun nodo interno dell'AS stesso

![[images/Pasted image 20261023115949.png|500]]

BGP usa la porta TCP 179. Due router BGP formano tra loro una connessione TCP (peer o neighbor routers), si autenticano reciprocamente e scambiano messaggi per aprire e confermare i parametri di connessione. I due neighbor all'inizio si scambiano tutta la loro routing table, comunicando per ciascuna rete (in formato Classless Inter Domain Router (CIDR), cioè indirizzo IP/bit subnet mask) il prossimo hop. Successivamente vengono scambiati messaggi contenenti gli aggiornamenti sui percorsi modificati. BGP verifica continuamente che i partner e le reti stiano funzionando correttamente.

**BGP routing:**
- BGP mantiene le routing tables, trasmette routing update e basa le decisioni di routing sulla base delle routing metric
- Le funzioni primarie sono lo scambio di informazioni network reachability, inclusa la lista dei percorsi per gli AS con altri sistemi BGP
- Ogni router BGP mantiene una lista di tutti i percorsi fattibili verso una particolare rete. Il router non aggiorna le tabelle fino a che non riceve un aggiornamento incrementale

I dispositivi BGP scambiano informazioni di routing sulla base di uno scambio iniziale e successivi aggiornamenti. Quando un router si collega per la prima volta riceve l'intera tabella di routing. Similmente quando le informazioni cambiano, vengono spedite in forma di insieme di aggiornamenti periodici. L'aggiornamento propaga solo il routing ottimale per una certa rete.

BGP mantiene un numero di versione della routing table che deve essere lo stesso per il rispettivo peer BGP. Il numero di versione cambia ogni volta che BGP aggiorna la routing table attraverso aggiornamenti. Pacchetti di tipo keepalive sono inviati per verificare l'integrità della sessione BGP tra i peers. Pacchetti di tipo notification sono inviati in risposta a condizioni di errore o in situazioni speciali.

BGP usa una routing metric singola, che consiste in un numero in unità arbitrarie che specifica il grado di preferenza per quel dato link. Viene assegnato dal Network Administrator ad ogni link. Il numero assegnato può basarsi su ogni tipo di criterio possibile, incluso il numero di AS che devono essere attraversati, la scalabilità, la velocità, il ritardo della comunicazione, il costo.

**BGP: tipi di messaggi** — l'RFC 1771, A Border Gateway Protocol 4 (BGP-4), definisce 5 tipi di messaggio:
- *open message:* apre una sessione BGP tra peers ed è il primo messaggio inviato da ciascuna parte dopo l'attivazione della sessione TCP. Questo messaggio è confermato da un messaggio keep-alive del peer e deve essere confermato prima che abbia luogo lo scambio di messaggi ordinario
- *update message:* è usato per effettuare l'aggiornamento del routing ad ogni sistema BGP, consentendo ai router di effettuare un disegno consistente della topologia di rete. Gli aggiornamenti sono inviati usando TCP per ragioni di affidabilità. Il messaggio di update può cancellare route irraggiungibili dalla routing table
- *notification message:* è inviato quando si evidenzia una condizione di errore. Il messaggio notification è utilizzato per chiudere una sessione attiva e per avvisare i router connessi del perché la sessione viene chiusa
- *keep-alive message:* informa ogni sistema peer BGP che un dispositivo è attivo. I messaggi keep-alive sono inviati con una frequenza tale da prevenire che la sessione BGP si esaurisca
- *refresh message:* richiede il reinvio delle informazioni di routing per una rete da parte di un peer

## BGP: formato dei pacchetti ed esempi

**Header:** ciascun pacchetto BGP contiene un header la cui funzione principale è quella di identificare lo scopo del pacchetto in questione. Contiene un valore riconosciuto da entrambi i peers per contrassegnare l'inizio del messaggio (importante per la sincronizzazione e l'autenticazione, se attiva), la lunghezza del messaggio in bytes (min 19B, max 4096B), il tipo di messaggio (Open, Update, Notification, Keep-alive, Refresh) e il campo Data.

> [!example] BGP: formato dei pacchetti - Header
> ![[images/slide-095.png|500]]

**Open message:** un open message BGP è costituito da un header e da:
- *BGP version number*
- *AS number* del mittente
- Numero max di secondi di attesa senza ricevimento di messaggi dal trasmettitore
- Identificativo BGP del mittente (IP address), identico per tutti i peer BGP
- Lunghezza del campo parametri opzionali (se presente)
- Lista dei parametri opzionali: attualmente è definito solo il parametro authentication information

Un messaggio OPEN è confermato dal ricevimento di un messaggio KEEPALIVE.

> [!example] BGP: Open message
> ![[images/slide-096.png|500]]

**Update message:** un update message BGP è costituito da un header e da:
- *Lunghezza del campo withdrawn routes:* indica la lunghezza del campo
- Lista di IP riferiti a route irrangiungibili
- Lunghezza del campo Path Attribute
- Descrive le caratteristiche del percorso annunciato: Origin, AS path, Next Hop, Multi Exit Disc, Local Pref, Atomic aggregate, Aggregator
- Contiene la lista di prefissi IP riferiti alle route annunciate

> [!example] BGP: Update message
> ![[images/slide-097.png|500]]

**Notification message:** un notification message BGP è costituito da un header e da:
- Indica il tipo di errore: Message Header Error, Open Message Error, Update Message Error, Hold Time Expired, Finite State Machine Error, Cease
- Fornisce ulteriori informazioni sulla natura dell'errore riportato
- Contiene dati relativi all'errore e ai sottocodici di errore. È un campo usato per diagnosticare la ragione del messaggio

> [!example] BGP: Notification message
> ![[images/slide-098.png|500]]

**eBGP e iBGP:** si può distinguere tra eBGP (peers appartenenti ad AS diversi) e iBGP (peers appartenenti allo stesso AS).

> [!example] eBGP e iBGP
> ![[images/slide-099.png|500]]

**Esempio:** tre router RTA, RTB e RTC configurati con BGP:

```
RTA#
router bgp 100
 neighbor 129.213.1.1 remote-as 200

RTB#
router bgp 200
 neighbor 129.213.1.2 remote-as 100
 neighbor 175.220.1.2 remote-as 200

RTC#
router bgp 200
 neighbor 175.220.212.1 remote-as 200
```

> [!example] BGP: esempio
> ![[images/slide-100.png|500]]

Output di `show ip bgp neighbors`:

```
#show ip bgp neighbors
  BGP neighbor is 129.213.1.1, remote AS 200, external link
  BGP version 4, remote router ID 175.220.12.1
  BGP state = Established, table version = 3, up for 0:10:59
  Last read 0:00:29, hold time is 180, keepalive interval is 60 seconds
  Minimum time between advertisement runs is 30 seconds
  Received 2828 messages, 0 notifications, 0 in queue
  Sent 2826 messages, 0 notifications, 0 in queue
  Connections established 11; dropped 10
```

> [!example] BGP: esempio
> ![[images/slide-101.png|500]]

**Esempio con loopback interf.:**

```
RTA#
 router bgp 100
 neighbor 190.225.11.1 remote-as 100
 neighbor 190.225.11.1 update-source int loopback 1

RTB#
 router bgp 100
 neighbor 150.212.1.1 remote-as 100
```

> [!example] BGP: esempio con loopback interf.
> ![[images/slide-102.png|500]]

**eBGP multihop:**

```
RTA#
 router bgp 100
 neighbor 180.225.11.1 remote-as 300
 neighbor 180.225.11.1 ebgp-multihop

RTB#
 router bgp 300
 neighbor 129.213.1.2 remote-as 100
```

> [!example] eBGP multihop
> ![[images/slide-103.png|500]]

**Esempio su router Cisco** — `show ip bgp summary`:

```
gw>sh ip bgp summary
BGP router identifier 194.143.143.15, local AS number 9209
BGP table version is 16505373, main routing table version 16505373
123080 network entries and 244183 paths using 21706080 bytes of memory
67847 BGP path attribute entries using 4078320 bytes of memory
60703 BGP AS-PATH entries using 2019624 bytes of memory
0 BGP route-map cache entries using 0 bytes of memory
0 BGP filter-list cache entries using 0 bytes of memory
BGP activity 886376/6976543 prefixes, 3005036/2760853 paths, scan interval 60 s.

Neighbor         V     AS MsgRcvd MsgSent   TblVer   InQ OutQ Up/Down   State/PfxRcd
151.99.49.1      4   6664 5402219 568616 16505003      0    0 3w0d        122224
192.94.212.209   4   1267 3035284 4825672 16505003     0    0 15w0d       121958
```

> [!example] Esempio su router Cisco
> ![[images/slide-104.png|500]]

`show ip bgp neighbors` su router reale:

```
gw> sh bgp neighbors
BGP neighbor is 151.99.49.1, remote AS 6664, external link
 Description: INTERBUSINESS
  BGP version 4, remote router ID 151.99.49.5
  BGP state = Established, up for 3w0d
  Last read 00:00:07, hold time is 180, keepalive interval is 60 seconds
  Neighbor capabilities:
    Route refresh: advertised and received(old & new)
    Address family IPv4 Unicast: advertised and received
  Received 5399978 messages, 0 notifications, 0 in queue
  Sent 568441 messages, 4 notifications, 0 in queue
  Default minimum time between advertisement runs is 30 seconds
For address family: IPv4 Unicast
 BGP table version 16498361, neighbor version 16498339
 Index 1, Offset 0, Mask 0x2
 Route refresh request: received 0, sent 0
 122382 accepted prefixes consume 4895280 bytes
 Prefix advertised 778940, suppressed 0, withdrawn 678934
  Connections established 5; dropped 4
  Last reset 3w0d, due to BGP Notification sent, hold time expired
  External BGP neighbor may be up to 4 hops away.
Connection state is ESTAB, I/O status: 1, unread input bytes: 0
Local host: 194.143.128.3, Local port: 12275
Foreign host: 151.99.49.1, Foreign port: 179
Enqueued packets for retransmit: 0, input: 0   mis-ordered: 0 (0 bytes)
```

> [!example] Esempio su router Cisco (i)
> ![[images/slide-105.png|500]]

Continuazione dell'output (connection details):

```
Event Timers (current time is 0x21F0442EC):
Timer          Starts    Wakeups            Next
Retrans         89727        865             0x0
TimeWait            0          0             0x0
AckHold        150348      75280             0x0
SendWnd             0          0             0x0
KeepAlive           0          0             0x0
GiveUp              0          0             0x0
PmtuAger            0          0             0x0
DeadWait            0          0             0x0

iss: 3215576441   snduna: 3221188905   sndnxt: 3221188905      sndwnd:   16163
irs: 3508386839   rcvnxt: 3563173331   rcvwnd:      16249   delrcvwnd:     135

SRTT: 332 ms, RTTO: 527 ms, RTV: 195 ms, KRTT: 0 ms
minRTT: 20 ms, maxRTT: 1828 ms, ACK hold: 200 ms
Flags: higher precedence, nagle

Datagrams (max data segment is 536 bytes):
Rcvd: 279978 (out of order: 2), with data: 193154, total data bytes: 54786491
Sent: 246410 (retransmit: 865, fastretransmit: 0), with data: 89340, total data
   bytes: 5612463
```

> [!example] Esempio su router Cisco (ii)
> ![[images/slide-106.png|500]]

**Internet routing table** — `show ip route`:

```
gw>sh ip route
Codes: C - connected, S - static, I - IGRP, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2, E - EGP
       i - IS-IS, L1 - IS-IS level-1, L2 - IS-IS level-2, ia - IS-IS inter area
       * - candidate default, U - per-user static route, o - ODR
       P - periodic downloaded static route
Gateway of last resort is 194.143.128.34 to network 0.0.0.0
B   216.102.190.0/24 [20/0] via 151.99.49.1, 3w0d
B   208.221.13.0/24 [20/0] via 151.99.49.1, 3w0d
B   206.51.253.0/24 [20/0] via 151.99.49.1, 3w0d
B   205.204.1.0/24 [20/0] via 151.99.49.1, 3w0d
B   204.255.51.0/24 [20/0] via 151.99.49.1, 08:18:22
B   204.238.34.0/24 [20/0] via 151.99.49.1, 3w0d
B   204.153.85.0/24 [20/0] via 151.99.49.1, 2w6d
B   204.17.221.0/24 [20/0] via 151.99.49.1, 3w0d
B   203.238.37.0/24 [20/0] via 151.99.49.1, 3w0d
B   203.34.233.0/24 [20/0] via 151.99.49.1, 3w0d
B   200.68.140.0/24 [20/0] via 151.99.49.1, 3w0d
B   198.17.215.0/24 [20/0] via 151.99.49.1, 3w0d
B   192.68.132.0/24 [20/0] via 151.99.49.1, 10:08:06
    170.170.0.0/16 is variably subnetted, 3 subnets, 3 masks
B      170.170.0.0/19 [20/0] via 151.99.49.1, 3w0d
B      170.170.224.0/20 [20/0] via 151.99.49.1, 3w0d
B      170.170.254.0/24 [20/0] via 151.99.49.1, 3w0d
B   216.239.54.0/24 [20/0] via 151.99.49.1, 2w0d
B   216.103.190.0/24 [20/0] via 151.99.49.1, 3w0d
B   213.239.59.0/24 [20/0] via 151.99.49.1, 3w0d
B   212.205.24.0/24 [20/0] via 151.99.49.1, 3w0d
B   205.152.84.0/24 [20/0] via 151.99.49.1, 3w0d
B   203.254.52.0/24 [20/0] via 151.99.49.1, 3w0d
B   203.1.203.0/24 [20/0] via 151.99.49.1, 3w0d
B   202.1.202.0/24 [20/0] via 151.99.49.1, 3w0d
B   198.205.10.0/24 [20/0] via 151.99.49.1, 3w0d
B   198.69.130.0/24 [20/0] via 151.99.49.1, 14:43:27
B   192.35.226.0/24 [20/0] via 151.99.49.1, 5d22h
    170.171.0.0/16 is variably subnetted, 4 subnets, 2 masks
B      170.171.0.0/16 [20/0] via 151.99.49.1, 3w0d
B      170.171.251.0/24 [20/0] via 151.99.49.1, 3w0d
```

> [!example] Internet routing table
> ![[images/slide-107.png|500]]

> [!info] Sintesi:
> - AS: dominio di routing di una stessa organizzazione; ASN (asplain/asdot) identifica univocamente gli AS, divisi in multihomed, stub e transit
> - IGP all'interno dell'AS (OSPF, RIP), EGP tra AS (BGP)
> - OSPF: link-state con LSA, aree e backbone (area 0), Dijkstra, tipi di router e pacchetti Hello/DB description/LS update
> - RIP: distance-vector Bellman-Ford, massimo 15 hop, update ogni 30s su UDP 520, tecniche anti-loop (split horizon, hold down, poison reverse, triggered update)
> - BGP: EGP tra AS sulla porta TCP 179, politiche di routing, 5 messaggi (Open, Update, Notification, Keep-alive, Refresh), eBGP e iBGP
