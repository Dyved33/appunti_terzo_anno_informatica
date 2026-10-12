Protocolli del livelli di trasporto in internet
- TCP: affidabile, consegne nell'ordine origianrio
	- Controllo di congetione
	- Controllo di flusso
	- Setuop della connessione
- UDP: inaffidabile, consegne senza ordine
	- Estensione senza fornzoli del servizio di consegna a massimo sforzo
- Servizi non disponibili
	- Manca

UDP
Usato spesso nelle applicazionei multimediali. Tollera piccole perdite ed è sensibile alla frequenza

TCP 
![[Pasted image 20261012095425.png]]
//spiega il contenuto a lato//

Multiplexing e demultiplexing

Approcci al controllo della congestione: punto a punto e assistito dalla rete 

Livello di rete
Ha il compito dell'instradamento. 
- Il livello di rete prende i segmenti dal livello di trasporto nell'host mittente
- Sul lato mittente incapsula i segmenti in datagrammi
- Sul lato destinatario consegna i segmenti al livello di trasporto
- Protocolli del livello di rete in ogni host, router
- Il router esamina i campi intestazione in tutti i datagrammi IP che lo attraversano

Indirizzamento IPv 4
Indirizzo ip: ogni intefaccia di host e router di Internet ha un indirizzo IP globalmente univoco

Interfaccia: è il confine tra host e collegamento fisico
- I router devono necessariamente essere connessi ad almeno due collegamenti
- Un host in genere ha un 'interfaccia
- A ciascun interfaccia sono associati indirizzi IP

Sottorete: una rete isolata i cui punti terminali sono //manca//

Frammentazione dei datagrammi ip: 
Al'unità massima di trasmissione (MTU) p la massima quantità di dati che un frama a livello di collegamtnteo piò trasportare  (diversi link = diversi MTU). Datagrammmi ip grandi venfono farammentati in datagrammi ip più piccoli
- Datagramma frammentato
- I frammento saranno riassemblati solo una volta raggiunta la destinazione
- //MANCA//

Formato datagrammi
![[Pasted image 20261012100855.png]]

Protocollo per la risoluzione degli indirizzi (ARP): ogni nodo IP (host router) nella lan ha una tabella ARP che contiene la corrispondenza tra indirizzi IP e MAC: <indirizzo IP, indirizzo MAC, TTL>. TTL (tempo di vita): valore che indica quando bisognerà eliminare una data cove nella tabella (tempo tipico è 20 minuti)

> [!note]
> Topologia a stella con al centro un hub o switch

=======================================================================================
Firewall
Aiuta ed è necessario, ma non rende una macchina necessariamente sicura
Non è un componente della rete ma un insieme di componenti che cooperano tra loro
- Firewall e intruison detection system (IDS)
- Email/web content scanners per virus e malicious code (worms)
- Personal firewalls

N.B. Il firewall è l'ultima linea di difesa

Definizione: Network firewalls are devices or system that control the flow of network traffic between networks employing different security postures (NIST) = Firewall di rete sono apparecchiature o sistemi ch controllano il flusso del traffico di rete tra due reti con differente livelli di sicurezza

Cosa può fare:
- Può schermare alcune reti interne e nasconderle agli altri 
- Bloccare alcuni accessi a servizi o ad utenti
- Monitorare (log function)
- Virtual private networks (VPN) = crittazione automatica dei dati tra i siti. Fornisc confidenzialità dei dati inviati tr i due gateway. 

> [!note]
> I firewalls non proteggono le singole macchine
> Le macchine vanno configurate e protette come se non esistesse il firewall
> Non difende da nuovi bug non ancora documentati nei protocolli
> I filtri sono difficili da settare e da mantenere (compromesso tra libertà e sicurezza)
> Può degradare la performance della rete

2 filosofie:
- Default deny = tutto quello che non è espressamente ammesso è proibito
- Default permit = tutto quello che non è espressamente proibito è ammesso

Principio: difesa perimetrale
Proteggi tutti i cammini di ingresso allla rete privata (una sola porta di ingresso)
All'interno della rete gli host si fidano tra loro 

Servizi add-on
- NAT = static e hiding translation
- DHCP
- Encryption funzionality (VPNs)
- Application content filtering

Tipi di firewall:
- Packet-filtering firewalls 
- //manca//

