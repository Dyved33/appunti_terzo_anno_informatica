# Packet filter, proxy gateway, ambienti di rete e IDS

I firewall operano con velocità molto elevata per non fare da collo di bottiglia alle comunicazioni di rete. Il loro comportamento dipende strettamente dal livello della pila [[Lezione 2-Architettura delle reti, stack TCP-IP e protocolli applicativi|TCP/IP]] su cui prendono le decisioni di filtraggio.

## Packet filter firewall

Un *packet filter* decide se un pacchetto può passare o meno basandosi esclusivamente sulle informazioni presenti nelle intestazioni dei protocolli fino al livello di trasporto.

### Filtri a livello 3 e boundary router

Operano tipicamente sui router di confine (*boundary router*) esaminando:

- *Source address* del pacchetto (indirizzo IP sorgente);
- *Destination address* del pacchetto (indirizzo IP destinazione);
- tipo di traffico (protocolli di livello 3 come IP, ICMP, IPX, oppure protocolli di livello 2);
- caratteristiche del livello 4 (porta sorgente e porta destinazione TCP/UDP);
- informazioni interne al router (interfaccia fisica di ingresso e di uscita del pacchetto, utile per router con più interfacce di rete).

*Vantaggi:*
- semplicità di implementazione;
- trasparenza per l'utente e per le applicazioni;
- altissima velocità di elaborazione.

*Svantaggi:*
- nessun controllo per filtrare comandi o funzioni ai livelli più alti (mancanza di *user authentication*);
- funzioni di log praticamente inefficaci a fini di sicurezza applicativa;
- difficoltà nella formulazione e manutenzione di buone regole prive di falle.

### Regole e azioni del packet filter

Un ruleset di packet filtering definisce l'azione da intraprendere su ciascun pacchetto:

- *Accept:* il pacchetto è conforme alla regola e viene inoltrato;
- *Deny:* il pacchetto viene bloccato e viene inviata una notifica ICMP di errore all'host mittente;
- *Discard:* il pacchetto viene eliminato silenziosamente senza alcuna notifica (*black hole* = il firewall risulta trasparente all'esterno, non rivelando la propria presenza all'attaccante).

Una generica regola di chiusura (politica di *default deny*) si scrive impostando ogni campo a `Any` e l'azione su `Deny`, in modo da bloccare tutto il traffico non esplicitamente autorizzato dalle regole precedenti.

> [!tip] Ricorda
> Le prime 1023 porte sono le *well-known ports*, riservate a servizi di rete prestabiliti (come HTTP 80 o Telnet 23). Quando un client contatta un servizio remoto, alloca dinamicamente una porta con numero $> 1023$ a cui il server invierà le risposte. Una volta che la porta non è più necessaria, questa viene chiusa.

### Limite dei filtri statici e stateful inspection

In una connessione client-server (ad esempio Telnet verso la porta 23), il client $A$ invia pacchetti con porta sorgente $x > 1023$ e porta destinazione 23; il server $B$ risponde con porta sorgente 23 e porta destinazione $x$. Per consentire al client di ricevere la risposta con un filtro statico, bisognerebbe aprire tutte le porte alte verso la rete interna:

| Source address | Source port | Destination address | Destination port | Action |
| --- | --- | --- | --- | --- |
| Any | Any | 192.168.1.0/24 | > 1023 | Allow |

Questa regola espone la rete a rischi gravi: un attaccante esterno può fare spoofing (inviando pacchetti con porta sorgente 80 o 23) per penetrare indisturbato verso le porte superiori a 1023 degli host interni.

Per superare questo limite, gli **stateful inspection firewall** incorporano controlli a livello 4 e costruiscono dinamicamente una *state table* per validare il traffico di ritorno (*inbound*):

| Source address | Source port | Destination address | Destination port | Action |
| --- | --- | --- | --- | --- |
| 192.168.1.100 | 1030 | 210.9.88.29 | 80 | Established |

Quando un client interno avvia una connessione verso l'esterno, il firewall memorizza temporaneamente la quadrupla (indirizzi e porte). Quando arriva un pacchetto dall'esterno, il firewall lo lascia passare solo se appartiene a una sessione già registrata nella tabella come stabilita (*Established*). Al termine della sessione o dopo un timeout, la voce viene eliminata.

## Application-proxy gateway

Un *application-proxy gateway* (o proxy applicativo) opera a livello applicativo (livello 7) fungendo da relè completo tra l'host esterno e l'host interno:

$$\text{Outside host} \longleftrightarrow \text{Outside connection} \longleftrightarrow \text{Application gateway} \longleftrightarrow \text{Inside connection} \longleftrightarrow \text{Inside host}$$

Non esiste mai una connessione diretta a livello di trasporto tra l'host esterno e quello interno: il client stabilisce una connessione TCP con il gateway proxy, il quale analizza i dati a livello applicativo e, se autorizzati, instaura una seconda connessione distinta verso la destinazione finale inoltrando le richieste per conto del client.

### Filtri a livello 7

- Il routing tra le due interfacce di rete è effettuato a livello applicativo dal software del firewall: in caso di malfunzionamento o arresto del software, il routing è disabilitato (comportamento sicuro per default).
- Possibilità di autenticazione dell'utente (*user authentication*): credenziali utente (username e password), token hardware/software, autenticazione biometrica (remota solo come fattore supplementare).
- Filtri su specifici comandi del protocollo applicativo (ad esempio permettendo comandi `GET` in HTTP ma bloccando `PUT` o `DELETE`).

*Vantaggi:*
- sicurezza nettamente superiore ai packet filter;
- controllo mirato su un numero circoscritto di applicazioni (HTTP, FTP, posta elettronica);
- facilità di registrazione nei log e auditing approfondito del traffico.

*Svantaggi:*
- significativo sovraccarico di elaborazione (*processing overhead*) su ogni singola connessione;
- supporto limitato alle sole applicazioni espressamente implementate nel gateway.

### Proxy server dedicati

Sono server proxy specializzati per singole applicazioni che affiancano il gateway principale nell'ispezione dei contenuti (*content inspection*):

- scansione antivirus centralizzata;
- blocco di codice malevolo (*malicious code*, come applet Java, controlli ActiveX, codice JavaScript ostile, macro di documenti Word);
- gestione efficiente delle connessioni in uscita (*outbound*), come *web cache proxy* (per ridurre latenza e consumo di banda) ed *email proxy*.

I **personal firewall** proteggono invece esclusivamente la singola macchina su cui sono installati (come il firewall di Windows XP o ZoneAlarm), risultando essenziali per utenti mobili che si collegano da reti esterne non fidate.

## Ambienti di configurazione dei firewall

Nella progettazione delle architetture di sicurezza perimetrale si applicano alcune linee guida fondamentali:

- principio *KISS* (*Keep It Simple, Stupid!*): architetture semplici riducono gli errori di configurazione;
- utilizzo dei dispositivi di rete secondo il loro scopo naturale;
- sicurezza a più livelli (*defense in depth*): se è possibile impiegare più firewall in cascata o con ruoli differenziati, è sempre opportuno usarli;
- monitoraggio costante delle minacce provenienti dall'interno della rete stessa.

### DMZ e service leg

La *DeMilitarized Zone* (DMZ) è una sottorete cuscinetto interposta tra la rete pubblica esterna (Internet) e la rete interna protetta. Serve a ospitare i server che devono erogare servizi all'esterno (come Web server pubblici e server DNS):

- il *boundary router* (con filtri a pacchetto) riceve il traffico dall'ISP e lo convoglia verso la rete DMZ esterna;
- il *Main Firewall* controlla l'accesso pubblico e instrada le richieste verso l'External Web Server in DMZ;
- un secondo firewall (*Internal Firewall*) separa rigidamente la DMZ dalla rete interna protetta (*Interior Protected Network*), dove risiedono i server critici (come l'Internal Email Server e i database);
- la DMZ non può mai iniziare connessioni verso la rete interna: è la rete interna che può accedere alla DMZ. Se un server pubblico in DMZ viene compromesso, l'attaccante si trova confinato nella DMZ e bloccato dal firewall interno.

Nella variante **service leg**, il firewall dispone di una terza interfaccia dedicata ("gamba di servizio") a cui è collegata la DMZ, gestendo con un unico apparato la separazione tra traffico esterno, DMZ e LAN protetta.

### VPN e segmentazione Intranet/Extranet

- **VPN:** protocolli come IPSec, PPTP (sviluppato da Microsoft) e L2TP consentono di stabilire tunnel cifrati sicuri attraverso reti pubbliche. È possibile integrare le funzioni di terminazione VPN direttamente nel firewall, ma le operazioni crittografiche comportano un pesante impatto prestazionale sull'apparato.
- **Intranet ed Extranet:** i firewall vengono utilizzati per segmentare le reti interne (*Intranet*), isolando reparti critici, oppure per connettere in modo controllato partner commerciali e sedi distaccate (*Extranet*).

### Hub, switch e isolamento del traffico

- Gli **hub** sono dispositivi di livello 1 che replicano il traffico in *broadcast* su tutte le porte: ogni macchina collegata può intercettare (*sniffing*) tutto il traffico in transito.
- Gli **switch** sono apparati di livello 2 (bridge multiporta) che instradano i frame solo verso la specifica porta a cui è collegato il dispositivo destinatario in base al MAC address. Non consentono lo sniffing passivo tra porte diverse, rendendo l'ambiente sicuro per DMZ e sottoreti protette.
- *Attenzione con gli IDS:* l'isolamento del traffico operato dagli switch impedisce a una sonda IDS collegata a una normale porta di osservare il traffico delle altre porte. Per consentire il monitoraggio è necessario configurare una porta di *port mirroring* (SPAN), sulla quale lo switch inoltra una copia di tutti i frame transitanti.

## Intrusion Detection System (IDS)

I sistemi IDS rilevano e notificano (e nei sistemi di prevenzione IPS bloccano) tentativi di accesso non autorizzati o attività malevole sui sistemi di rete.

Gli IDS interagiscono direttamente con i firewall: quando la sonda IDS rileva un attacco (come un tentativo di DoS o una scansione aggressiva delle porte), istruisce dinamicamente il firewall per bloccare tempestivamente l'indirizzo IP dell'attaccante.

### Host-based IDS (HIDS)

Installato sulla singola macchina da proteggere, analizza log di sistema, chiamate di sistema e integrità dei file locali. È strettamente dipendente dal sistema operativo dell'host.

*Punti negativi:*
- impatto diretto sulle prestazioni e sulle risorse di calcolo della macchina;
- difficoltà nel riconoscere e mitigare attacchi di tipo DoS che saturano la rete;
- potenziale impatto sulla stabilità del sistema operativo ospitante.

### Network-based IDS (NIDS)

Dislocato in punti strategici della rete, monitora i pacchetti in transito analizzandoli alla ricerca di firme di attacco (*attack signatures*). Un singolo NIDS è in grado di monitorare molteplici macchine e intere sottoreti senza gravare sui singoli host.

*Punti negativi:*
- incapacità tipica di riassemblare e correlare firme di attacco distribuite o frammentate su più pacchetti TCP/IP distinti;
- necessità di collegarsi a switch dotati di funzionalità di *port mirroring*;
- le interfacce configurate in *promiscuous mode* (indispensabili per catturare tutto il traffico) sono facilmente individuabili in rete e possono essere rese bersaglio di attacchi DoS mediante invio massiccio di traffico inutile per saturarne la capacità di analisi.

## Complementi dal libro di testo

> [!info]
> Il libro di testo approfondisce il rilevamento delle intrusioni e alcune varianti architetturali dei firewall:
> - **Tecniche di rilevamento delle intrusioni:**
>   - *Statistical anomaly detection:* raccoglie dati sul comportamento normale degli utenti e costruisce un profilo statistico; un'attività che devia dal profilo è segnalata. Le metriche includono contatori, gauge (misure puntuali), interval timer e utilizzo delle risorse; i test includono media e deviazione standard, multivariato, processo di Markov, serie temporali e operazionale.
>   - *Rule-based detection:* confronta il comportamento osservato con regole che descrivono attacchi noti (*penetration/signature identification*) o comportamenti anomali (*anomaly detection*).
> - **Distributed intrusion detection:** architettura con un gestore centrale e più agenti locali (HIDS/NIDS) che gli inviano segnalazioni.
> - **Honeypot:** sistemi esca (*decoy*) progettati per attirare gli attaccanti lontano dai sistemi critici; non hanno valore produttivo, quindi qualsiasi interazione con essi è sospetta. Si collocano fuori dal firewall esterno (individuano attacchi esterni), in DMZ (protetta dal firewall interno) o all'interno (individuano attacchi interni, ma se compromessi possono attaccare la rete interna).
> - **Bastion host:** piattaforma irrobustita (*hardened*) individuata dall'amministratore come punto critico della sicurezza, su cui ospitare un gateway applicativo; esegue una versione sicura del SO, solo i servizi necessari, proxy indipendenti l'uno dall'altro e autenticazione aggiuntiva richiesta agli utenti.
> - **Configurazioni con bastion host:** single bastion inline/T e double bastion inline/T (DMZ tra due bastion firewall).

> [!info] Sintesi:
> - I packet filter controllano indirizzi IP, porte e flag di livello 3 e 4: sono veloci e trasparenti ma privi di autenticazione utente.
> - Gli stateful inspection firewall mantengono una tabella di stato per autorizzare solo i pacchetti in risposta a connessioni già aperte.
> - Gli application-proxy gateway operano a livello 7 interrompendo la connessione diretta end-to-end ed eseguendo ispezione granulare sui comandi.
> - La DMZ isola i server esposti a Internet dalla rete interna protetta, impedendo accessi diretti verso la LAN in caso di compromissione.
> - Gli switch isolano il traffico di livello 2, richiedendo il port mirroring per consentire il monitoraggio da parte dei Network IDS.
> - Gli IDS cooperano con i firewall per bloccare attacchi in tempo reale, distinguendosi in HIDS (sull'host) e NIDS (sulla rete).