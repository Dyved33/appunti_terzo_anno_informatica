# IDS, ambienti di rete, configurazioni dei firewall e TLS

## Ambienti di rete: IDS

I *network-based IDS* monitorano il traffico di rete cercando delle "tracce" (*attack signature*) che indicano un attacco in corso: sono più efficaci di un host-based IDS, perché un solo IDS monitorizza più macchine.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019100622.png" width="30%">
</div>

*La figura:* le sonde Network IDS sono ai confini delle due DMZ; nella interior protected network ci sono solo host IDS, sui server esposti.

L'IDS notifica (ed in alcuni casi previene) l'accesso a sistemi di rete e interagisce con i firewall: se riconosce un attacco DoS, il firewall blocca quell'accesso.

**Numerazione degli ambienti:** 5 = IDS, 6 = DNS, 7 = server (gli ambienti 1-4 sono in [[Lezione 4-Packet filter, proxy gateway, ambienti di rete e IDS|Lezione 4]]).

**C'è un IDS per ogni sottorete.** Se si avesse un solo IDS, dove sarebbe meglio metterlo? Tutte e tre le risposte sono giusse, se motivate:

- **Nell'internal network:** i server più importanti sono lì, e la sonda controlla il traffico che li raggiunge dopo il main firewall ma prima dell'internal firewall;
- **Nell'interior protected network:** è l'ultima rete prima dei sistemi più sensibili: la sonda vede il traffico esterno già filtrato e quello interno, e intercetta la propagazione laterale fra server;
- **Nell'external DMZ network:** si beccano tutti i pacchetti che arrivano da fuori, al primo controllo; in compenso non si vede il traffico interno.

*Svantaggi:*
- non riescono a riassemblare signature distribuite su più pacchetti;
- necessitano switch con *port mirroring*;
- le interfacce in *promiscuous mode* sono facilmente localizzabili e attaccabili con grossi quantitativi di traffico inutile;
- sono spesso essi stessi oggetto dell'attacco che dovrebbero monitorare (DoS).

## Ambienti di rete: DNS

Il DNS è un servizio critico per ogni ambiente che fa uso di internet.

- **Split DNS:** separare su due server DNS la gestione dei nomi interni da quella dei nomi esterni;
- **UDP:** user lookup;
- **TCP:** zone transfer (solo dai secondari).

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019101854.png" width="30%">
</div>

*La figura:* il DNS esterno sta nell'external DMZ, quello interno nell'internal DMZ: è lo split DNS.

## Ambienti di rete: server

**Dove?**
- Chi deve accedervi?
- Quanto sono importanti i dati contenuti?

**Regole generali:**
- i server esterni sono protetti da un packet filter router;
- nessun server accessibile dall'esterno sulla rete interna;
- i server interni (al di qua del firewall interno) vanno protetti se l'importanza dei dati lo richiede: server su una *service leg* separata, cfr. [[Lezione 4-Packet filter, proxy gateway, ambienti di rete e IDS#DMZ e service leg|DMZ e service leg]];
- isolare i server: un attacco non deve impattare sul resto della rete.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019102144.png" width="30%">
</div>

*La figura:* gli ambienti con i dispositivi al loro posto: dial-in server e main firewall con VPN server nell'external DMZ, web proxy server e DNS interni nell'internal DMZ, host nella rete interna.

**Server esterni su external DMZ:**
- DNS, web, directory server;
- eventualmente su più DMZ, per isolare i server;
- VPN e dial-in server: per controllare il traffico prima che sia *encrypted*.

**Server interni su internal DMZ:**
- DNS, web, directory server;
- protetti anche da attacchi interni;
- mail server: se richiesto accesso dall'esterno, tramite ssl proxy sul firewall.

## La security policy del firewall

La firewall policy è distinta dalla information security policy: descrive come sarà implementata la information security policy, le regole per gestire il traffico (web, email, …) e come il firewall è gestito e aggiornato.

**Risk analysis:**
- quali applicazioni?
- chi e da dove saranno usate?
- costi/benefici di ogni singola messa in sicurezza di macchina/servizio;
- creazione della matrice del traffico;
- dalla matrice, le regole da implementare sui vari firewall.

**Da bloccare:**
- traffico in ingresso da sorgenti esterne non autenticate (eccezione: proxy-email esterne, e solo porta 25);
- pacchetti in ingresso che mostrano la rete interna come sorgente;
- ICMP in ingresso (*firewalking*);
- SNMP da sorgenti non autenticate (*probing*);
- pacchetti RFC 1918-privati in ingresso e in uscita (10.0.0.0-10.255.255.255, 172.16.0.0-172.16.255.255, 192.168.0.0-192.168.255.255);
- pacchetti con 127.0.0.1 o 0.0.0.0, in ingresso e in uscita: sono attacchi verso il firewall;
- traffico in ingresso con informazioni di IP source routing;
- pacchetti con *directed broadcast address*, in ingresso e in uscita: attacchi con risposta a un *source address* diverso (DoS);
- se possibile: usare *user authentication* e raccogliere quanto log possibile.

**Testing:** quasi mai effettuato. Un controllo fra quello che si voleva e quello che è stato implementato, oppure tool o gruppi di specialisti (*tiger-group*) che provano a fare ciò che la policy vieta: *penetration analysis*, *seeded* o *blind*.

**Implementazione:**
- *appliance-based:* scatole dedicate a questo scopo, più stabili e sicure e più performanti, perché usano hardware specifico;
- *OS based:* scalabili, ma soffrono delle vulnerabilità del sistema operativo.

**Gestione e manutenzione:**
- CLI: veloce, ma errori di battitura se non ci sono controlli sintattici;
- GUI: usabile anche da un novizio, con gli stessi rischi.

## Configurazioni dei firewall

Oltre alla semplice configurazione con un unico sistema (single packet filtering router or single gateway), sono possibili configurazioni più complicate. Tre tipiche:
1. screened host firewall system (single-homed bastion host);
2. screened host firewall system (dual-homed bastion host);
3. screened-subnet firewall system.

**Bastion host:** un sistema identificato dal firewall administrator come un punto cruciale per la sicurezza della rete; serve come piattaforma per un application-level o circuit-level gateway.

### Screened host firewall system (single-homed bastion host)

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019102408.png" width="30%">
</div>

*La figura:* il packet-filtering router è l'unico ingresso dalla rete pubblica; il bastion host, con una sola interfaccia, è collegato al router e agli host della rete privata. L'information server si raggiunge solo passando dal bastion host.

Il firewall consiste di due sistemi:
- un packet-filtering router;
- un bastion host.

**Configurazione del packet-filtering router:**
- solo i pacchetti da e per il bastion host sono permessi;
- il bastion host effettua funzioni di authentication and proxy (eventualmente caching).

**Più sicuro di una configurazione con una sola macchina:**
- implementa sia packet-level che application-level filtering (flessibilità nel definire una security policy);
- un intruder deve generalmente penetrare due sistemi separati.

### Screened host firewall system (dual-homed bastion host)

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019102503.png" width="30%">
</div>

*La figura:* il bastion host ha due interfacce, una verso il packet-filtering router e l'altra verso la rete privata: il traffico fra internet e gli host della rete privata deve fisicamente passare attraverso il bastion host.

La differenza rispetto a single-homed:
- il bastion host non è più un host qualunque della rete privata, ma il separatore fra zona esterna e zona interna;
- il router non instrada il traffico interno, quindi nessun pacchetto raggiunge la rete privata senza attraversarlo.

### Screened-subnet firewall system

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019102540.png" width="30%">
</div>

*La figura:* due packet-filtering router, uno esterno e uno interno, con il bastion host nella subnet isolata fra i due; il modem è il punto di accesso per il collegamento dial-in.

- è la più sicura delle tre configurazioni;
- usati due packet-filtering routers;
- creazione di una sub-network isolata.

**Vantaggi:**
- tre livelli di difesa verso gli intruders;
- la rete interna è *invisible* all'Internet.

**Svantaggi:**
- i sistemi sulla rete interna non possono costruire cammini diretti verso l'esterno.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019102637.png" width="30%">
</div>

*La figura:* la rete con l'indirizzamento: border router 192.168.1.1, main firewall con VPN gateway 192.168.1.2, internal firewall 192.168.1.3, server HTTP 192.168.1.4 e SMTP 192.168.1.5.

## TLS

TLS è una suite di protocolli, non un protocollo singolo: due strati, il *record protocol* e i protocolli di livello superiore che lo usa (capitolo 6 del libro, *Transport-Level Security*).

**Record protocol:** garantisce riservatezza (il payload viene cifrato) e integrità (il MAC è calcolato prima della cifratura).

L'autenticazione non è compito suo: sta nel protocollo di handshake, che autentica sempre il server col suo certificato e il client solo se il server lo richiede (con Anonymous Diffie-Hellman non c'è autenticazione).

**Flusso di un record TLS:**
1. frammentazione dei dati applicativi in frammenti al massimo $2^{14}$ byte;
2. compressione (in TLS 1.2 il default è *null*);
3. calcolo del MAC (message authentication code, non un indirizzo fisico): HMAC della chiave di scrittura, del numero di sequenza, del tipo, della versione e della lunghezza del frammento compresso;
4. cifratura del messaggio compresso più il MAC con la chiave simmetrica (AES, 3DES o RC4);
5. aggiunta dell'header TLS.

L'HMAC è $HMAC_{K^+}(M) = H[(K^+ \oplus opad) \cdot H[(K^+ \oplus ipad) \cdot M]]$, con:
- $H$: la funzione di hash (MD5 o SHA-1);
- $K^+$: la chiave completata con zeri a sinistra fino alla lunghezza del blocco (512 bit);
- $ipad = 36$ e $opad = 5C$, ripetuti 64 volte.

**Header TLS:**
- *content type* (8 bit): il protocollo di livello superiore che processa il frammento;
- *major version* e *minor version* (8 bit ciascuna): 3 e 1 per TLS 1.2;
- *compressed length* (16 bit).

I content type definiti sono quattro: change_cipher_spec, alert, handshake, application_data.

> [!info] In altre parole:
> La chiave simmetrica cifra i dati: la si ricava dal master secret durante l'handshake e costa poco. La chiave asimmetrica serve solo alla negoziazione (RSA o Diffie-Hellman), per scambiare il master secret e autenticare il server: le operazioni a chiave pubblica sono costose, ma si fanno durante l'handshake, non a ogni record.

**Connessione TLS:** un trasporto che fornisce un servizio adatto, una relazione peer-to-peer e transitoria; ogni connessione è associata a una sola sessione.

**Sessione TLS:** un'associazione fra client e server, creata dal protocollo di handshake, che definisce i parametri crittografici di sicurezza condivisi fra più connessioni: serve a non negoziarli a ogni connessione.

**Parametri di una sessione:**
- *session identifier:* sequenza di byte scelta dal server per identificare uno stato di sessione attivo o riprendibile;
- *peer certificate:* certificato X.509v3 del peer (può essere null);
- *compression method:* algoritmo usato per comprimere i dati prima della cifratura;
- *cipher spec:* algoritmo di cifratura dei dati (AES, 3DES, ecc.) e hash per il MAC, più attributi crittografici come l'hash size;
- *master secret:* segreto di 48 byte condiviso fra client e server;
- *is resumable:* se la sessione può iniziare nuove connessioni.

**Parametri di una connessione:**
- *server and client random:* sequenze di byte scelte dal server e dal client per ogni connessione;
- *server write MAC secret:* chiave per le operazioni MAC sui dati inviati dal server;
- *client write MAC secret:* chiave simmetrica per le operazioni MAC sui dati inviati dal client;
- *server write key:* chiave di cifratura dei dati cifrati dal server e decifrati dal client;
- *client write key:* chiave di cifratura dei dati cifrati dal client e decifrati dal server;
- *initialization vectors:* con un cifrario a blocchi in CBC si mantiene un IV per ogni chiave, inizializzato dall'handshake; poi il blocco di cifratura finale di ogni record è l'IV del record successivo;
- *sequence numbers:* numeri di sequenza separati per i messaggi inviati e ricevuti; quando una parte invia o riceve un change cipher spec, il numero è azzerato.

**I protocolli sul record protocol:**
- *change cipher spec:* un solo messaggio di un byte (il valore 1), che copia lo stato pendente nello stato corrente aggiornando la cipher suite;
- *handshake:* la parte più complessa; autentica le parti e negozia algoritmi di cifratura, MAC e chiavi. Quattro fasi:
  1. capacità di sicurezza (*client_hello*, *server_hello*);
  2. autenticazione del server e scambio delle chiavi (*certificate*, *server_key_exchange*, *server_done*);
  3. autenticazione del client e scambio delle chiavi (*certificate*, *client_key_exchange*, *certificate_verify*);
  4. conclusione (*change_cipher_spec* e *finished*);
- *alert:* avvisi TLS al peer. Primo byte il livello (*warning* o *fatal*: un alert fatale termina subito la connessione, e sulla stessa sessione non si possono aprire nuove connessioni), secondo byte il codice (*close_notify*, *handshake_failure*, *bad_record_mac*, ecc.);
- *other upper-layer protocol:* i protocolli di applicazione che girano sopra TLS, per esempio HTTP: TLS non distingue le applicazioni che lo usano, per il suo contenuto è opaco.

**Metodi di scambio delle chiavi**, negoziati nell'handshake:
- *RSA:* il secret key è cifrato con la chiave pubblica RSA del destinatario, serve un certificato;
- *fixed Diffie-Hellman:* i parametri pubblici DH stanno nel certificato firmato dalla CA;
- *ephemeral Diffie-Hellman:* chiavi temporanee firmate con RSA o DSS, il caso più sicuro;
- *anonymous Diffie-Hellman:* nessuna autenticazione, quindi vulnerabile a *man-in-the-middle*.

Il master secret nasce dal pre-master secret (48 byte) e dai due random con la pseudo-random function: $master\_secret = PRF(pre\_master\_secret, "master secret", ClientHello.random \cdot ServerHello.random)$.

Dal master secret e dai random si deriva il *key block*: le chiavi e i segreti di scrittura usati dai due lati.

**Heartbeat (opzionale):** verifica che il peer sia ancora vivo e genera traffico nelle connessioni inattive, così un firewall non le chiude; è definito in un RFC separato (RFC 6250, 2012).

## SSH

SSH è il successore di telnet: una sessione remota su un'altra macchina, con autenticazione e cifratura che telnet non ha. Permette tunnel fra due macchine, e nei tunnel può essere inserito qualsiasi protocollo.

SSH1 forniva il login remoto sicuro al posto di telnet; SSH2 ne corregge i difetti di sicurezza (RFC 4250-4256) e aggiunge capacità client/server più generali, come il trasferimento di file e la posta.

**Tre protocolli, su TCP:**
- *transport layer:*
  - autentica il server e garantisce riservatezza, integrità e *forward secrecy* (una chiave compromessa non incrina le sessioni precedenti);
  - l'autenticazione usa la *host key* del server, che il client deve conoscere in anticipo: database locale nome-chiave, oppure CA fidata che certifica le host key;
- *user authentication:* autentica l'utente presso il server;
- *connection protocol:* suddivide il tunnel cifrato in più canali logici (*multiplexing*).

> [!info] Sintesi:
> - Il network-based IDS cerca firme d'attacco nel traffico: copre più macchine di un host-based IDS, ma non ricostruisce firme su più pacchetti, vuole il *port mirroring* ed è bersaglio di DoS.
> - Il DNS: split DNS (nomi interni ed esterni su due server), UDP per l'user lookup, TCP per lo zone transfer.
> - I server esterni stanno sulla external DMZ, quelli interni sulla internal DMZ, e vanno isolati perché un attacco non si propaghi.
> - La firewall policy nasce da una risk analysis e da una matrice del traffico; fra le regole, bloccare ICMP in ingresso, SNMP da sorgenti non autenticate, pacchetti RFC 1918 e *directed broadcast address*.
> - Le tre configurazioni: screened host single-homed, dual-homed (bastion con due interfacce, unico passaggio fra internet e rete privata) e screened subnet (due router, subnet isolata: la più sicura, con la rete interna invisibile).
> - TLS: record protocol (frammenta, comprime, MAC, cifra con chiave simmetrica, header) e handshake, che autentica e negozia il master secret. SSH sostituisce telnet e realizza tunnel.
