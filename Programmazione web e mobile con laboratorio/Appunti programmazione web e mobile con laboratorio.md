# Lezione 1
**Www** = worldwide web. è un servizio di internet che permette di navigare ed usufruire di contenuti. Connette nodi (computer/dispositivi) della rete. è un sistema ipertestuale, cioè testo con rimandi ad altri testi

Standard web: 
- **Html:** linguaggio di markup (definisce come voglio voglio scritta una pagina web) 
- **Http:** protocollo di rete che opera a livello applicazione della pila ISO/OSI
- **URL:** schema di identificazione dei contenuti e dei servizi sul web

### Html
Significa **H**iper** T**ext **M**arkup **L**anguage (sintassi stabilita dal World Wide Web). Definisce la struttura delle pagine web. Si usa per convenzione.

### Browser
Si tratta di un'applicazione per l'acquisizione, la presentazione e la navigazione di risorse sul web (pagine html). Implementa funzionalità di client per il protocollo HTTP, che regola il download delle risorse dai server web a partire dal loro indirizzo URL

### Client-server
è un'architettura nella quale i client condividono risorse e e il server gestisce (e limita) gli accessi a queste risorse. Le LAN, il Web, e molti sistemi informatici sono organizzati in forma di client-server. 

### HTTP
Sta per Hyper Text Transfer Protocol per il quale il richiesta parte del client (browser) verso il server che fornisce le risorse. In questo contesto il Transmission Control Protocol (TCP) connette 2 host che assicura che i pacchetti arrivino nello stesso ordine in cui vengono inviati. 

> [!note]
> Il Transport Layer Security (TLS) fa si che nessun altro possa intromettersi nella comunicazione tra i due  hosts (man in the middle)

HTTP è abilitato a:
- Cache
- Abilita a CORS
- Autenticazione
- Proxy
- Sessioni

HTTP è **stateless**, ovvero non c'è collegamento tra due richieste consecutive => soluzione = Cookie (senza ogni volta che consulto una risorsa che richiede una autenticazione dovrei immettere le mie credenziali perché http non si ricorda)

> [!note]
> Anche HTTP è uno standard

#### Richieste HTTP
Si tratta di metodi che definiscono l'operazione da eseguire. Necessitano di un path, ovvero la posizione in rete della risorsa da recuperare. Inoltre sono presenti ci sono un header, riguarda informazioni aggiuntive da inoltrare con la richiesta, e un body (opzionale) che contiene una risorsa da invitare. Un concetto da ricorda è quello dell'idempotenza: ci sono dei metodi HTTP che, pur venendo chiamati/applicati più volte, danno la stessa risposta/risultato 

METTICI LA FOTO

#### Risposta HTTP 
Viene dal server e questa è composta da:
- Status code/message: indica se la richiesta ha avuto successo (200) oppure no e perché
- Body: (opzionale) contiene la risorsa richiesta 

### URL 
Sta per Uniform Resource Locator e identifica univocamente l'indirizzo di una risorsa in rete. Il nomero di porta è opzionale e alcuni  protocolli ne hanno uno riservato (es. HTTP = 80). La risoluzione dell'URL in indirizzo Internet Protocol (IP) avviene tramite Domain Name System (DNS) 

> [!note]
> Dopo il protocollo ci sono: subdomain, domain e top level domain (es .it, .com,...). Dopodiché c'è il path per la risorsa possiamo inserire anche in che punto andare della pagina (ancora)

METTI IMMAGINE

Da URL a IP: inserisco l'URL
1. Si controlla prima la cache locale
2. Se l'IP non è in cache, si contatta un DNS pubblico per il TLD (.it) 
3. Il server TLD risponde con l'indirizzo del DNS autoritativo 
4. Al server DNS autoritativo viene richiesto l'IP associato al dominio
5. Il server autoritativo restituisce l'IP associato a dominio, dominio secondario e sottodominio
6. Il browser utilizza l'IP per stabilire la connessione con il server

Dopodiché il browser:
- Scarica e analizza l'HTML, eventualmente generato lato server tramita PHP, per costruire Document Object Model (DOM)
- Scarica e applica il CSS per formattare il layout e lo stile
- Esegue JavaScript per:
	- Manipolare il DOM e aggiornare dinamicamente la pagina
	- Interagire con il server (es. Via AJAX)

> [!note]
> Si usano HTML, CSS e JavaScript vengono usati per convenzione. Bisogna ricordare che le componenti di questi 3 elementi vanno tenute separate in quanto indipendenti 
