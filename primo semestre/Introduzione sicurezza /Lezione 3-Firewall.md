# Firewall

Il firewall aiuta ed è necessario, ma non rende una macchina necessariamente sicura. <u>Non è un componente della rete, ma un insieme di componenti che cooperano tra loro:</u>

- firewall e Intrusion Detection System (IDS);
- scanner di contenuti di posta e web per virus e codice malevolo (worms);
- personal firewall.

*Osservazione:* il firewall è l'ultima linea di difesa, a completamento dei livelli di difesa di [[Lezione 1-Fondamenti di sicurezza informatica e protezione dei sistemi|Lezione 1]].

*Definizione:* i firewall di rete sono apparecchiature o sistemi che controllano il flusso del traffico di rete tra due reti con livelli di sicurezza differenti (*different security postures*, NIST).

## La necessità dei firewall

L'evoluzione dei sistemi informativi aziendali è passata da mainframe centralizzati a LAN, reti locali, WAN private e infine connettività Internet. La connettività Internet non è più opzionale: informazioni e servizi sono essenziali, ma espongono la rete locale a minacce esterne.

Equipaggiare ogni workstation e server con funzioni di sicurezza (intrusion protection) può non essere sufficiente né cost-effective: in una rete con centinaia di sistemi eterogenei, quando si scopre una falla ogni sistema potenzialmente affetto va aggiornato, richiedendo gestione configurazioni scalabile e patching aggressivo.

Il firewall si inserisce tra la rete locale e Internet per stabilire un collegamento controllato e erigere un perimetro di sicurezza esterno (*outer security wall*). L'obiettivo è proteggere la rete da attacchi basati su Internet e fornire un **single choke point** dove imporre sicurezza e auditing. Il firewall può essere un singolo sistema o un insieme di sistemi che cooperano.

> [!info] Defense in depth
> Il firewall fornisce un ulteriore strato di difesa, isolando i sistemi interni dalle reti esterne. Segue la dottrina militare classica della *difesa in profondità*, applicabile alla sicurezza IT.

## Obiettivi di progettazione e politica di accesso

Secondo [BELL94b], tre obiettivi per un firewall:

1. **Tutto il traffico** (interno→esterno e viceversa) deve passare attraverso il firewall — realizzato bloccando fisicamente ogni accesso alla rete locale eccetto via firewall.
2. **Solo traffico autorizzato** passa, come definito dalla security policy locale — i vari tipi di firewall implementano varie policy.
3. **Il firewall stesso è immune a penetrazione** — richiede sistema indurito (*hardened*) con SO sicuro; sistemi *trusted* sono adatti e spesso richiesti in ambito governativo.

La **firewall access policy** elenca i tipi di traffico autorizzati (range indirizzi, protocolli, applicazioni, tipi di contenuto), derivata dal risk assessment e dalla policy di sicurezza dell'organizzazione.

SP 800-41-1 elenca caratteristiche usabili per filtrare:
- **IP Address and Protocol Values**: sorgente/destinazione, porte, direzione, caratteristiche rete/trasporto (packet filter e stateful inspection).
- **Application Protocol**: dati protocolli applicativi autorizzati (application-level gateway, es. controllo SMTP per spam, HTTP per siti autorizzati).
- **User Identity**: identità utente, tipicamente utenti interni con autenticazione forte (IPSec).
- **Network Activity**: ora della richiesta, rate limiting per rilevare scanning, pattern di attività.

### Capacità dei firewall

1. **Single choke point**: tiene fuori utenti non autorizzati, proibisce servizi vulnerabili, protegge da IP spoofing e routing attacks; semplifica la gestione sicurezza.
2. **Monitoraggio eventi security**: audit e allarmi implementabili sul firewall.
3. **Piattaforma per funzioni Internet non security**: NAT (mappa indirizzi locali a Internet), funzioni di network management (audit/log usage).
4. **Piattaforma per IPsec / VPN**: tunnel mode per virtual private networks.

### Limiti dei firewall

- Non proteggono da attacchi che **bypassano** il firewall (dial-out, modem pool per dial-in).
- Non proteggono pienamente da **minacce interne** (dipendente infedele, cooperazione inconsapevole con attaccante esterno).
- WLAN non sicure accessibili dall'esterno; firewall interni non bloccano comunicazioni wireless tra sistemi da lati diversi.
- Laptop/PDA/device portatili infettati fuori rete aziendale e poi usati internamente.

> [!warning] Limiti operativi (riassunto):
> - Non proteggono le singole macchine.
> - Le macchine vanno configurate e protette come se il firewall non esistesse.
> - Non difendono da bug nuovi non ancora documentati nei protocolli.
> - I filtri sono difficili da impostare e da mantenere (compromesso tra libertà e sicurezza).
> - Possono degradare la performance della rete.

## Politiche di filtraggio e difesa perimetrale

Due filosofie opposte:

- **Default deny** (*default = discard*): tutto ciò che non è espressamente ammesso è proibito. Più conservativo, preferito da aziende e governi. Inizialmente tutto bloccato, servizi aggiunti case-by-case.
- **Default permit** (*default = forward*): tutto ciò che non è espressamente proibito è ammesso. Più facile per utenti finali ma sicurezza ridotta; l'amministratore deve reagire a ogni nuova minaccia.

*Principio:* **difesa perimetrale**. Si proteggono tutti i cammini di ingresso alla rete privata, riducendoli a una sola porta di ingresso; all'interno della rete gli host si fidano tra loro.

**Servizi add-on** — funzioni aggiuntive integrabili nel firewall:

- **NAT** (*static e hiding translation*): traduce più indirizzi privati interni in un unico indirizzo pubblico, nascondendo gli host interni.
- **DHCP**: assegna automaticamente IP e parametri di rete agli host interni.
- **Funzionalità di cifratura (VPN)**: cifra traffico tra due gateway, garantendo confidenzialità e integrità.
- **Filtraggio contenuto applicativo** (*application content filtering*): esamina dati applicativi (allegati posta, pagine web) per bloccare virus e codice malevolo.

## Tipi di firewall

Un firewall può monitorare traffico a vari livelli: pacchetti di rete singoli o come flusso, intero traffico in una connessione di trasporto, dettagli protocolli applicativi. La scelta dipende dalla access policy desiderata. Può operare come *positive filter* (passa solo ciò che incontra criteri) o *negative filter* (rifiuta ciò che incontra certi criteri).

### Packet Filtering Firewall

Applica un set di regole a ogni pacchetto IP in entrata/uscita e lo inoltra o scarta. Filtra tipicamente in entrambe le direzioni. Le regole si basano su informazioni nel pacchetto di rete:

- Source IP address
- Destination IP address
- Source/destination transport-level address (porte TCP/UDP, es. SNMP, Telnet)
- IP protocol field (definisce protocollo di trasporto)
- Interface: per firewall con 3+ porte, quale interfaccia ha ricevuto o deve inviare il pacchetto

Il packet filter è tipicamente una lista di regole basate su match nei campi header IP/TCP. Se c'è match, la regola determina forward/discard. Se nessun match, azione di default (deny o permit).

> [!example] Ruleset esempio per SMTP (Tabella 12.1 Stallings)
> | Rule | Direction | Source Addr | Dest Addr | Protocol | Dest Port | Action |
> |------|-----------|-------------|-----------|----------|-----------|--------|
> | A    | In        | External    | Internal  | TCP      | 25        | Permit |
> | B    | Out       | Internal    | External  | TCP      | >1023     | Permit |
> | C    | Out       | Internal    | External  | TCP      | 25        | Permit |
> | D    | In        | External    | Internal  | TCP      | >1023     | Permit |
> | E    | Either    | Any         | Any       | Any      | Any       | Deny   |
>
> Problemi: Regola D permette traffico esterno verso qualsiasi porta >1023. Un attaccante può aprire connessione dalla sua porta 5150 a un web proxy interno su 8080. Contromisura: aggiungere campo *source port* (25 per B e D, >1023 per A e C).
>
> Vulnerabilità residua: regole C e D permettono a qualsiasi host interno di inviare posta fuori. Un attaccante esterno può spoofare source port 25 per accedere a macchine interne. Contromisura: aggiungere campo **ACK flag** — regola D richiede ACK flag impostato (TCP imposta ACK dopo che la connessione è stabilita).

**Vantaggi:** semplicità, trasparenza per utenti/applicazioni, velocità elevata.

**Debolezze (SP 800-41-1):**
- Non esamina upper-layer data → non previene attacchi che usano vulnerabilità/funzioni specifiche dell'applicazione (es. non può bloccare comandi applicativi specifici).
- Logging limitato: solo info usate per access control (source/dest address, traffic type).
- Non supporta avanzati schemi di user authentication (mancanza funzionalità upper-layer).
- Vulnerabile ad attacchi che sfruttano problemi TCP/IP (IP spoofing layer 3); molti non rilevano addressing alterato.
- Susceptible a breach da configurazioni improprie (poche variabili decisionali → facile permettere traffico che andrebbe negato).

**Attacchi tipici e contromisure:**
- **IP address spoofing**: pacchetti da fuori con source IP di host interno. Contromisura: scartare pacchetti con source address interno se arrivano su interfaccia esterna (spesso implementato su router esterno al firewall).
- **Source routing attacks**: source station specifica route per bypassare security. Contromisura: scartare tutti i pacchetti con source routing.
- **Tiny fragment attacks**: frammentazione IP per forzare TCP header in fragment separato, circumventando regole basate su TCP header. Contromisura: richiedere che primo fragment contenga quantità minima predefinita di transport header; se primo fragment rifiutato, ricordare pacchetto e scartare tutti i successivi.

### Stateful Inspection Firewall

Un packet filter tradizionale decide su base pacchetto-per-pacchetto senza contesto higher-layer. La maggior parte delle applicazioni TCP standard usa modello client/server (es. SMTP: client invia mail a server, TCP server port 25, client port 1024–65535).

Un packet filter semplice deve permettere traffico inbound su tutte le porte alte per connessioni TCP-based → vulnerabilità sfruttabile.

Lo **stateful inspection packet firewall** stringe le regole TCP creando una *directory* delle connessioni TCP outbound stabilite (Tabella 12.2). C'è un entry per ogni connessione attualmente stabilita. Il filter ora permette traffico inbound su porte alte **solo** per pacchetti che matchano il profilo di un entry nella directory.

| Source Address | Source Port | Dest Address | Dest Port | Connection State |
|----------------|-------------|--------------|-----------|------------------|
| 192.168.1.100  | 1030        | 210.22.88.29 | 80        | Established      |
| 192.168.1.102  | 1031        | 216.32.42.123| 80        | Established      |
| ...            | ...         | ...          | ...       | ...              |

Rivede stesse info del packet filter + registra info su connessioni TCP. Alcuni tracciano anche **TCP sequence numbers** per prevenire session hijacking. Alcuni ispezionano quantità limitate di dati applicativi per protocolli noti (FTP, IM, SIP) per identificare/tracciare connessioni correlate.

Al termine sessione o dopo timeout, la voce viene eliminata dalla tabella.

### Application-level gateway (proxy applicativo)

Agisce come relè di traffico application-level. L'utente contatta il gateway via applicazione TCP/IP (Telnet, FTP), il gateway chiede il remote host, l'utente fornisce user ID e autenticazione valida, il gateway contatta l'applicazione sul remote host e rilancia segmenti TCP contenenti dati applicativi tra i due endpoint.

Se il gateway non implementa il proxy code per un'applicazione specifica, il servizio non è supportato e non può attraversare il firewall. Il gateway può essere configurato per supportare solo feature specifiche di un'applicazione che l'amministratore considera accettabili, negando tutte le altre.

**Vantaggi:**
- Sicurezza nettamente superiore ai packet filter: deve scrutare solo poche applicazioni permesse invece di gestire innumerevoli combinazioni TCP/IP.
- Facile logging e auditing approfondito del traffico in entrata a livello applicativo.

**Svantaggi:**
- Significativo **processing overhead** su ogni connessione: due connessioni splice con il gateway al punto di splice, che deve esaminare e inoltrare tutto il traffico in entrambe le direzioni.
- Supporto limitato alle sole applicazioni espressamente implementate nel gateway.

### Circuit-level gateway (proxy di circuito)

Può essere un sistema stand-alone o una funzione specializzata di un application-level gateway per alcune applicazioni. Non crea una connessione TCP end-to-end: il gateway apre due connessioni separate, una con l'host interno e una con quello esterno.

Una volta stabilite, inoltra i segmenti TCP da una connessione all'altra **senza esaminarne il contenuto**. La protezione consiste nel decidere quali connessioni ammettere.

Uso tipico: amministratore si fida degli utenti interni. Gateway configurato per application-level/proxy service su connessioni inbound e circuit-level per outbound → overhead di esame dati applicativi in entrata per funzioni proibite, ma non su dati in uscita.

**Esempio: SOCKS** (RFC 1928, v5). Framework per applicazioni client-server in domini TCP e UDP. Fornisce accesso conveniente e sicuro a network-level firewall. Occupa thin layer tra applicazione e TCP/UDP, non fornisce routing network-level (es. forwarding ICMP).

Componenti SOCKS:
- SOCKS server (spesso su firewall UNIX-based, anche Windows).
- SOCKS client library (su host interni protetti).
- Versioni SOCKS-ified di client standard (FTP, Telnet) — richiede ricompilazione/relink o librerie dinamiche alternate.

Quando client TCP-based vuole connettersi a oggetto raggiungibile solo via firewall, apre connessione TCP a porta SOCKS appropriata (1080) su SOCKS server. Se richiesta ha successo: negoziazione metodo autenticazione → autenticazione → relay request. SOCKS server valuta e stabilisce connessione appropriata o nega. UDP gestito similmente: connessione TCP per autenticare utente a inviare/ricevere segmenti UDP, segmenti UDP inoltrati finché connessione TCP resta aperta.

## Firewall Basing

Comune basare firewall su macchina stand-alone con OS comune (UNIX/Linux). Funzionalità firewall anche come modulo software in router o LAN switch.

### Bastion Host

Sistema identificato dall'amministratore firewall come **critical strong point** nella sicurezza della rete. Serve come piattaforma per application-level o circuit-level gateway.

Caratteristiche comuni:
- Hardware platform esegue versione sicura del SO → **hardened system**.
- Solo servizi considerati essenziali installati (proxy per DNS, FTP, HTTP, SMTP).
- Può richiedere autenticazione aggiuntiva prima di concedere accesso ai proxy; ogni proxy può richiedere propria autenticazione.
- Ogni proxy configurato per supportare solo subset del command set standard dell'applicazione.
- Ogni proxy permette accesso solo a specifici host system (command set limitato applicato solo a subset di sistemi protetti).
- Ogni proxy mantiene **detailed audit information** (log tutto traffico, ogni connessione, durata) — essenziale per scoprire/terminare attacchi.
- Ogni proxy module = piccolo package software specifico per network security (più facile verificare security flaws: tipico mail UNIX 20.000+ linee, mail proxy <1000).
- Ogni proxy **indipendente** dagli altri: se problema o futura vulnerabilità, si disinstalla senza affettare gli altri; facile installare nuovo proxy per nuovo servizio.
- Proxy generalmente **no disk access** eccetto lettura configuration file iniziale → porzioni filesystem con codice eseguibile rese read-only → difficile per intruder installare Trojan horse sniffers.
- Ogni proxy gira come **utente non privilegiato** in directory privata e sicura sul bastion host.

### Host-Based Firewalls

Modulo software per sicurezzare singolo host. Disponibile in molti OS o come add-on. Posizione comune: server. Vantaggi:
- Regole di filtering tailor-made per l'ambiente host; policy corporate specifiche per server implementabili con filtri diversi per server per applicazioni diverse.
- Protezione indipendente da topologia: attacchi interni ed esterni devono passare attraverso il firewall.
- Insieme a stand-alone firewall fornisce **additional layer of protection**; nuovo tipo di server aggiungibile con suo firewall senza alterare configurazione network firewall.

### Personal Firewall

Controlla traffico tra personal computer/workstation e Internet/enterprise network. Uso in ambiente domestico e corporate intranet. Tipicamente modulo software sul PC. In ambiente domestico multi-computer, funzionalità firewall anche in router che collega tutti i computer a DSL/cable modem/altra interfaccia Internet.

Tipicamente **molto meno complessi** di server-based o stand-alone firewall. Ruolo primario: negare accesso remoto non autorizzato al computer. Può monitorare outgoing activity per rilevare/bloccare worm e malware.

Capacità personal firewall (netfilter Linux, pf BSD/Mac OS X): configurabili CLI o GUI frontend. Quando abilitato, tutte le connessioni inbound di solito negate eccetto quelle esplicitamente permesse dall'utente. Outbound di solito permesse. Servizi inbound riattivabili selettivamente (file sharing 548/427, Windows sharing 139, Web sharing 80/427, SSH 22, FTP 20–21 + 1024–65535, printer sharing 631/515, iChat 5297/5298, iTunes 3869, CVS 2401, Gnutella 6346, ICQ 4000, IRC 194, MSN 6891–6900, Network Time 123, Retrospect 497, SMB 445, Timbuktu 407, VNC 5900–5902, WebSTAR Admin 1080/1443).

Quando FTP abilitato, porte 20/21 aperte; se altri connettono da porte 20/21, porte 1024–65535 aperte.

Feature avanzate: *stealth mode* (nasconde sistema su Internet droppando pacchetti unsolicited, appare inesistente); blocco UDP (traffico solo TCP su porte aperte); logging per controllare unwanted activity; solo applicazioni selezionate o firmate da CA valida possono fornire servizi accessibili dalla rete.

## Firewall Location and Configurations

Il firewall si posiziona come barriera protettiva tra sorgente esterna potenzialmente non trusted e rete interna. L'amministratore deve decidere location e numero di firewall.

### DMZ Networks

Distinzione comune: **external firewall** (al bordo della rete locale/enterprise, appena dentro boundary router verso Internet/WAN) e **internal firewall** (proteggono bulk della rete enterprise). Tra i due: **DMZ** (demilitarized zone) — sistemi accessibili esternamente ma che necessitano protezione (Web server corporate, email server, DNS server).

External firewall: access control e protezione per sistemi DMZ coerente con loro necessità di connettività esterna; protezione base per resto rete enterprise.

Internal firewall (tre scopi):
1. Filtering più stringente vs external firewall per proteggere server/workstation enterprise da attacchi esterni.
2. Protezione **two-way** rispetto a DMZ: protegge rete interna da attacchi lanciati da sistemi DMZ (worm, rootkit, bot, malware in DMZ); protegge sistemi DMZ da attacchi da rete interna protetta.
3. Multiple internal firewalls per proteggere porzioni di rete interna l'una dall'altra (es. server interni protetti da workstation interne e viceversa). Pratica comune: DMZ su diversa network interface dell'external firewall rispetto a quella usata per accedere alle reti interne.

### Virtual Private Networks (VPN)

In ambienti distributed computing, VPN = insieme di computer interconnessi via rete relativamente insicura (Internet) che usano cifratura e protocolli speciali per sicurezza. A ogni sito corporate, workstation/server/database linkati da LAN. Internet/WAN pubblica interconnette siti → cost savings vs private network, offloading WAN management a provider pubblico. Stessa rete pubblica dà accesso a telecommuters/mobile employees per logon a sistemi corporate da siti remoti.

Requisito fondamentale: **security**. Rete pubblica espone traffico corporate a eavesdropping e entry point per utenti non autorizzati. VPN usa cifratura e autenticazione nei lower protocol layers per connessione sicura attraverso rete altrimenti insicura. Più economiche di vere private network ma richiedono stesso sistema cifratura/autenticazione a entrambi i capi. Cifratura eseguita da firewall software o router. Protocollo comune: **IPsec** a livello IP.

IPSec implementabile nel firewall (Fig 12.3). Se IPSec in box separato dietro (interno al) firewall, traffico VPN passa attraverso firewall in entrambe le direzioni **cifrato** → firewall non può fare filtering, logging, virus scanning. IPSec nel boundary router (fuori firewall) → device meno sicuro del firewall, meno desiderabile come piattaforma IPSec.

### Distributed Firewalls

Configurazione **distributed firewall** = stand-alone firewall devices + host-based firewalls che lavorano insieme sotto controllo amministrativo centrale. Admin configura host-resident firewalls su centinaia di server/workstation + personal firewalls su sistemi utenti locali/remoti. Tool per policy setting e security monitoring across entire network. Proteggono da attacchi interni e forniscono protezione tailored a macchine/applicazioni specifiche. Stand-alone firewall forniscono protezione globale (internal + external firewall).

Con distributed firewall può aver senso **both internal and external DMZ**: Web server che necessitano meno protezione (meno info critiche) in external DMZ, fuori external firewall; protezione fornita da host-based firewall su quei server.

Aspetto importante: **security monitoring** — log aggregation e analisi, statistiche firewall, fine-grained remote monitoring host individuali se necessario.

### Riepilogo delle posizioni e topologie dei firewall

Spettro di location e topologie:

1. **Host-resident firewall**: personal firewall software + firewall software su server. Usabili soli o come parte di deployment firewall in-depth.
2. **Screening router**: singolo router tra rete interna ed esterna con stateless o full packet filtering. Tipico SOHO.
3. **Single bastion inline**: singolo firewall device tra router interno ed esterno (es. Fig 12.1a). Può implementare stateful filter e/o application proxy. Tipico firewall appliance per piccole-medie organizzazioni.
4. **Single bastion T**: simile a single bastion inline ma ha terza network interface su bastion verso DMZ con server esternamente visibili. Comune per medie-grandi organizzazioni.
5. **Double bastion inline**: Fig 12.2, DMZ sandwiched tra due bastion firewall. Comune per grandi aziende e governi.
6. **Double bastion T**: DMZ su separata network interface sul bastion firewall. Comune per grandi aziende/gov; richiesto per uso governo australiano (ACSI33).
7. **Distributed firewall configuration**: Fig 12.4. Usata da alcune grandi aziende e governi.

## Sintesi

> [!info] Sintesi:
> - Il firewall controlla il flusso di traffico tra reti con livelli di sicurezza diversi, ma è l'ultima linea di difesa e non protegge le singole macchine.
> - È un insieme di componenti (firewall, IDS, scanner antivirus, personal firewall) e può offrire servizi add-on come NAT, DHCP, VPN e filtraggio di contenuto.
> - La difesa perimetrale concentra gli ingressi in un'unica porta e si basa su una politica *default deny* (più sicura) o *default permit* (più usabile).
> - Quattro tipi principali:
>   - **Packet-filtering**: decide su header IP/TCP/UDP; veloce, semplice, trasparente; non esamina dati applicativi, logging limitato, vulnerabile a spoofing e misconfigurazioni.
>   - **Stateful inspection**: mantiene tabella connessioni TCP stabilite; permette traffico di ritorno solo per sessioni registrate; alcuni tracciano sequence numbers e ispezionano dati app limitati (FTP, SIP).
>   - **Application-level gateway (proxy)**: relè a livello 7; interrompe connessione end-to-end; esamina comandi applicativi, logging dettagliato; overhead significativo, supporta solo app implementate.
>   - **Circuit-level gateway (proxy di circuito)**: due connessioni TCP, rilancia segmenti senza esaminare contenuto; decide quali connessioni ammettere; overhead minore del proxy applicativo; esempio SOCKS v5 (porta 1080).
> - **Bastion host**: sistema indurito (hardened) che ospita proxy; SO sicuro, solo servizi essenziali, proxy indipendenti, audit dettagliato, esecuzione come utente non privilegiato, filesystem read-only.
> - **Host-based firewall**: su server/host per protezione tailored, indipendente da topologia, layer aggiuntivo.
> - **Personal firewall**: su workstation/PC; nega inbound non autorizzato, monitora outbound per malware; stealth mode, logging, filtro per applicazioni firmate.
> - **Architetture**: DMZ (external + internal firewall), VPN (IPsec su firewall o router), distributed firewall (stand-alone + host-based + central management).
> - Topologie: host-resident, screening router, single bastion inline/T, double bastion inline/T, distributed.
