I firewall sono molto veloci 

Packet filter firewall: decide se un'informazione può passare o meno (in base al layer)

Filtri a livello 3
- Source address del pacchetto (IP address)
- Destination address del pacchetto (IP address)
- Tipo del traffico (IP,ICMP,IPX se a livello 3 o anche protocolli di livello 2)
- Possibilmente alcune caratteristiche del livello 4 (porta, sorgente e destinazione)
- Talvolta informazioni interne al router (quali informazioni circa le interfacce sorgente e di destinazione del pacchetto, utile per routers con più interfacce)

Vantaggi:
- Semplicità
- Trasparente per l'utente
- Alta velocità

Svantaggi:
- Nessun controllo per filtrare comandi/funzioni ai livelli più alti (mancanza di user authentication)
- Funzioni di log praticamente inefficaci
- Difficoltà nel creare buone regole

Packet filter ruleset
- Accept
- Deny
- Discard 
	- Black hole = trasparente all'esterno

Come scrivere una generica regola del firewall es. Tutto any tranne action che viene messo a deny = blocca tutto

> [!note]
> Ricorda che le prime 1023 porte sono le well-known quindi riguardano servizi prestabiliti => quando vado su un sito il dispositivo comunica con una porta più grande di 1023

Per evitare una regola del tipo

| Source address | Source port | Destination port | Destination port | Action |
| -------------- | ----------- | ---------------- | ---------------- | ------ |
| Any            | Any         | 192.168.1.0      | > 1023           | Allow  |

Si fa in modo che il pc, quando si connette ad uno specifico servizio, crei dinamicamente una "stable table" per validare inbound traffic (incorpora alcuni controlli a livello 4)

| Source address | Source port | Destination port | Destination port | Action      |
| -------------- | ----------- | ---------------- | ---------------- | ----------- |
| 192.168.1.100  | 1030        | 210.9.88.29      | 80               | Established |

Quindi quando arriva un certo indirizzo memorizzo dinamicamente l'indirizzo che mi serve per ricevere la risposta (quando non mi serve più lo scarto)

Application-proxy gateways: for specific application
Outside host <-> outside connection to application-level gateway (telnet, ftp, smtp, http) <->inside connnection to inside host

//non ho proprio capito cosa fa e come//

Filtri a livello 7
- Routing tra le due interfacce effettuato a livello applicazione dal software del firewall
	- In caso di malfunzionamento de sw, il routing è disabilitato
- Possibilità di authentication
	- UserId and password
	- HW/SW token authentication
	- Biometric authentication (remota? Solo in aggiunta ad altri strumenti)
- Filtri su specifici comandi (es. Permetto GET ma non PUT)

Proxi
Vantaggi:
Più sicuri dei packet filters
Deve solo controllare un numero limitato di applicazioni (http, ftp, posta)
Facile il log e il controllo del traffico

Svantaggi 
Processi in overhead su ogni connessione
Può solo controllare un numero limitato di applicazioni (http, ftp,posta)

Personal firewalls
Proteggono solo la macchina dove sono istallate

Firewall enviroments
environment 1:dmz

//ha parlato di web server e main server ma non ho capito nulla//

ISP connesso con external DMZ Network a Main firewall e external network. Il main firewall è connesso all'internal firewall e a qualcosa con le mail credo e ad altro che non ho capito

Environment 2: VPN

Environment 3: intranet/extranet

Environment 4: Hubs/switches
- Hub
	- Devices a layer 1
	- Broadcast traffic
- Switches
	- Devices a layer 2
	- Essentially multiport bridges
	- No possibilità di snif/eavesdrop tra porta e porta (ok per dmz e firewall environment)
	- Isolamento delle subnet da tenere di conto nell'uso di IDS

Environment 5: IDSs
- Per notificare (in alcuni casi prevenire) accesso a sistemi di rete
- Interazione con firewalls 