Environment 5: IDS (network based IDS)
Monitorano il traffico di rete cercando delle "tracce" (attack signature) che indicano un attacco in corso. Più effettivo di un host-based IDS (un solo IDS monitorizza più macchine).

![[Pasted image 20261019100622.png]]
//spiega brevemente l'immagine//

C'è un IDS per ogni sottorete

Supponiamo che si abbia un solo IDS, dove è meglio metterlo? Nell'external DMZ network, nell'internal network, nell'interior protected network? 

Tutte risposte giuste a condizione di dare una buona motivazione:
- Nell'internal ci sono i server più importanti
- Nell'interior //manca motivazione//
- Nell'external becco tutti i pacchetti che arrivano da fuori

Punti Negativi
Usualmente non riescono a riassemblare delle signature distribuite su più pacchetti
Necessitano switches con particolari funzionalità (port mirroring)
Interfacce in promiscuous mode (necessarie ai network-based IDSs) sono facilmente localizzabili e possono poi essere attaccate inviando grossi quantitativi di traffico inutile
Spesso sono essi stessi oggetto dell’attacco che dovrebbero monitorare (DoS)  

Environment 6: DNS
Servizio critico per ogni ambiente che fa uso di internet. 

Split DNS: separare su die server DNS la gestione dei nomei interni da quella dei nomi esterni

Gestire traffico UDP/TCP separatamente:
- UDP: use lookup
- TCP: zone transfer (solo dai secondari)

![[Pasted image 20261019101854.png]]
//spiega meglio foto//

Environment 7: servers
Dove?
- Chi deve accedervi?
- Quanto sono importanti i dati contenuti?

Regole generali:
- Server estreni protetti da un packet filter router
- No srervere accessibili dall'esterno sulla rete interna
- Servers interni 8 al di qua dei firewall interno) se importanza dati lo richiede (tante service legs)
- Isolare i servers (un attacco non impatta sul resto della rete)

![[Pasted image 20261019102144.png]]
//spiega foto//

Server esterni su external DMZ
DNS, web, directory server
Eventualmente su più DMZs per isolare i server
VPN, Dial-In server
Per controllare traffico prima che sia encrypted!

![[Pasted image 20261019102209.png]]
//spiega foto//

Server interni su internal DMZ
DNS, web, directory server
Protetti anche da attacchi interni
Mail servers
Se richiesto accesso dall’esterno, tramite ssl proxy sul firewall

Configurazioni
In aggiunta alla semplice configurazione con un unico sistema (single packet filtering router or single gateway), sono possibili configurazioni più complicate
Tre tipiche configurazioni:
1. Screened host firewall system (single-homed bastion host)
2. Screened host firewall system (dual-homed bastion host)
3. Screened-subnet firewall system

Bastion Host
Un sistema identificato dal firewall administrator come un punto cruciale per la sicurezza della rete
il bastion host serve come a piattaform per un application-level o circuit-level gateway

Screened host firewall system (single-homed bastion host)

![[Pasted image 20261019102408.png]]

Screened host firewall, single-homed bastion configuration
Firewall considte di due sistemi:
un packet-filtering router
un bastion host

Configurazione del packet-filtering router:
Solo I pacchetti da e per il bastion host sono permessi
Il bastion host effettua funzioni di authentication and proxy (eventualmente caching)

Più sicurezza di una configurazione con una sola macchina:
Implementa sia packet-level che application-level filtering (flessibilità nel definire una security policy)
Un intruder deve generalmente penetrare due sistemi separati

Screened host firewall system (dual-homed bastion host)

![[Pasted image 20261019102503.png]]
//spiega foto soprattutto differenza con quella di prima//

Screened host firewall, dual-homed bastion configuration
Il traffico tra Internet e gli altri hosts sulla rete privata deve fisicamente passare attraverso il bastion host

Screened-subnet firewall system

![[Pasted image 20261019102540.png]]
//spiega foto soprattutto differenza con quella di prima//

Screened subnet firewall configuration
La più sicura delle tre configurazioni
Usati due packet-filtering routers
Creazione di una sub-network isolata

Vantaggi:
Tre livelli di difesa verso gli intruders
La rete interna è invisible all’Internet

Svantaggi:
I systemi sulla rete interna non possono costruire cammini diretti verso l’esterno

![[Pasted image 20261019102637.png]]

--- 

(capitolo 6 del libro)

TLS è una suite di protocolli:

Record protocol ha il compito di garantire confidenzialità, integrità e autenticità a non so chi

Il TLS, a partire dai application data, divide il pacchetto, lo comprime, aggiunge un indirizzo MAC, lo codifica (con chiave simmetrica usata da mittente e destinatario??) e append TLS record header 

(il prof ha detto che non si usa la chiave simmetrica perché è troppo costosa?)

> [!note] differenza tra chiave simmetrica e asimmetrica

TLS architecture
2 concetti TLS iportanti sono:

TLS connection:

TLS //manca//

Una sessione è definito dai seguenti parametri:
- Session identifier: una sequenza di byte scelta dal server per identicficare una session state resumable o active
- Peer certificate: un certificato del peer (può essere null)
- Compression method: algoritmo usato per comprimere i dati prima della criptazione
- Cipher spec
- Master secret
- Is resumable

//vanno spiegati tutti//

- Server and client random
- Server write MAC secret
- client write MAC secret
- Server write key
- Client write key
- Initialization vectors
- Sequence numbers

//spiegali tutti brevemente//

Altri protocolli: 
- Change cipher spec protocol
- Handshake protocol
- Alert protocol
- Other upper-layer protocol

//spiegali tutti brevemente//

Ssh
è il successore di telnet (sessione remota su un'altra macchina). Permette di creare dei tunnel tra due macchine. In questi tunnel possono essere inserito qualsiasi protocollo