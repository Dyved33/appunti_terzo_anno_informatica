# IP Security

## IP Security Overview
RFC 1636, *"Security in the Internet Architecture"*, è stato emesso nel 1994 dall'Internet Architecture Board (IAB). Identifica le aree chiave per i meccanismi di sicurezza:

- necessità di proteggere l'infrastruttura di rete da monitoraggio e controllo non autorizzato del traffico;
- necessità di proteggere il traffico end-user-to-end-user usando meccanismi di autenticazione e cifratura.

L'IAB ha incluso autenticazione e cifratura come funzionalità necessarie nella prossima generazione di IP (IPv6). La specifica IPsec esiste ora come un insieme di standard Internet.

IPsec permette al sistema di scegliere i protocolli di sicurezza, gli algoritmi per i servizi richiesti e le chiavi crittografiche necessarie. I servizi elencati da RFC 4301 sono controllo degli accessi, integrità senza connessione, autenticazione dell'origine, rifiuto dei pacchetti ripetuti (integrità parziale della sequenza), confidenzialità e confidenzialità limitata del flusso di traffico.

## Documenti IPsec
L'architettura IPsec è descritta da RFC 4301; AH da RFC 4302; ESP da RFC 4303. I documenti IKE descrivono la gestione delle chiavi; la specifica principale citata nelle slide è RFC 7296 per IKEv2. Altri documenti definiscono gli algoritmi crittografici, le funzioni pseudocasuali (PRF), lo scambio di chiavi e aspetti di policy, gestione e MIB.

## Applicazioni di IPsec
IPsec fornisce la capacità di proteggere le comunicazioni attraverso LAN, WAN private e pubbliche, e Internet.

Esempi:
- connettività sicura tra sedi aziendali su Internet;
- accesso remoto sicuro su Internet;
- connettività extranet e intranet con partner;
- sicurezza del commercio elettronico.

*Caratteristica principale di IPsec:* può cifrare e/o autenticare tutto il traffico a livello IP. Così tutte le applicazioni distribuite (remote logon, client/server, e-mail, file transfer, Web access) possono essere protette.

## Vantaggi e uso nel routing
Se IPsec è implementato su un firewall o router, può proteggere tutto il traffico che attraversa il perimetro. Il traffico interno all'azienda non subisce l'elaborazione aggiuntiva. Se il firewall è l'unico accesso da Internet e tutto il traffico esterno usa IP, l'applicazione di IPsec sul firewall è difficile da aggirare.

IPsec opera sotto il livello di trasporto ed è trasparente alle applicazioni e agli utenti: non richiede modifiche al software dei client o dei server, formazione degli utenti né distribuzione di chiavi per singolo utente. Può anche proteggere utenti singoli, ad esempio lavoratori remoti o sottoreti virtuali per applicazioni sensibili.

Nel routing, IPsec può autenticare gli annunci dei router, verificare l'identità dei router con cui si stabilisce o mantiene una relazione di vicinato, autenticare i messaggi di redirect e impedire la contraffazione degli aggiornamenti di routing.

## Quali strumenti usa IPsec
IPsec garantisce segretezza, autenticazione e integrità.

Per farlo si serve di tre protocolli:

- **Authentication Header (AH):** integrità e autenticazione dell'origine dei dati.
- **Encapsulating Security Payload (ESP):** cifratura, segretezza e opzionalmente integrità e autenticazione.
- **Internet Key Exchange (IKE):** scambio delle chiavi.

E di tre strutture:

1. **Security Policy Database (SPD):** al suo interno vanno elencate le regole di sicurezza relative al flusso di dati IP (in uscita o in entrata).
2. **Security Association Database (SAD):** memorizza tutte le connessioni stipulate con altre macchine.
3. **Security Association (SA):** connessione orientata e univocamente determinata da IP destinazione – parametro – ID tipo protocollo sicuro.

## Security Association (SA)
*Definizione:* una SA è una connessione logica unidirezionale tra un mittente e un ricevitore che fornisce servizi di sicurezza al traffico trasportato su di essa.

Una SA è univocamente identificata da tre parametri:

- **Security Parameters Index (SPI):** un intero senza segno a 32 bit assegnato a questa SA, di significato solo locale.
- **IP Destination:** indirizzo dell'endpoint di destinazione della SA, che può essere un sistema utente finale o un sistema di rete come un firewall o un router.
- **Security protocol identifier:** indica se l'associazione è un'associazione di sicurezza AH o ESP.

In qualsiasi pacchetto IP, la SA è univocamente identificata dall'Indirizzo di Destinazione nell'intestazione IPv4 o IPv6 e dallo SPI nell'intestazione di estensione racchiusa (AH o ESP).

![[Pasted image 20261116101715.png|500]]

<div style="text-align: center;">
  <img src="Pasted image 20261116112033.png" width="500">
  <p>Figura 9.2: architettura IPsec.</p>
</div>

## Security Association Database (SAD)
Definisce i parametri associati a ciascuna SA. Normalmente definita dai seguenti parametri in una voce SAD:

- Security Parameter Index
- Sequence number counter
- Sequence counter overflow
- Anti-replay window
- AH/ESP information (enc/auth algorithm, keys, Initialization values, lifetime)
- Lifetime of this security association
- IPsec protocol mode (tunnel/transport)
- Path MTU

## Security Policy Database (SPD)
Lo strumento mediante il quale il traffico IP è correlato a specifiche SA. Contiene voci, ciascuna delle quali definisce un sottoinsieme di traffico IP e punta a una SA per quel traffico.

In ambienti più complessi, possono esserci molte voci che potenzialmente si riferiscono a una singola SA, o multiple SA associate a una singola voce SPD.

Ogni voce SPD è definita da un insieme di valori di campi IP e di protocolli superiori chiamati selectors. Questi sono usati per filtrare il traffico in uscita al fine di mappare in una particolare SA.

### SPD Entries
I seguenti selectors determinano una voce SPD:

- Remote IP address: può essere un singolo indirizzo IP, un elenco enumerato o un intervallo di indirizzi, o un indirizzo jolly (mask). Gli ultimi due sono richiesti per supportare più di un sistema di destinazione che condivide la stessa SA.
- Local IP address: può essere un singolo indirizzo IP, un elenco enumerato o un intervallo di indirizzi, o un indirizzo jolly (mask). Gli ultimi due sono richiesti per supportare più di un sistema sorgente che condivide la stessa SA.
- Next layer protocol: un identificatore utente dal sistema operativo. L'IP protocol header include un field che designa il protocollo operativo over IP, ma è disponibile se IPsec è running sullo stesso sistema operativo dell'utente.
- Local and remote ports: questi possono essere valori di porta TCP o UDP individuali, un elenco enumerato di porte, o una porta jolly. Non è un field nell'IP o negli header upper-layer.

![[Pasted image 20261116101735.png|500]]

## ESP (Encapsulating Security Payload)
Fornisce:

- Confidenzialità
- Data origin authentication
- Connection-less integrity
- Anti-replay service (partial sequence integrity)
- Traffic flow confidentiality

### ESP — formato
Parte dell'SA: serve a selezionare l'SA in un SAD.

Padding (riempimento): necessario per certi tipi di crypto.

L'header ESP contiene SPI e numero di sequenza; il trailer contiene Pad Length e Next Header. L'Authenticator (ICV) è il MAC calcolato sul pacchetto ESP. Il numero di sequenza è a 32 bit e appartiene alla SA.

### Encapsulating Security Payload (ESP)
Usato per cifrare il Payload Data, Padding, Pad Length e Next Header fields. Se l'algoritmo richiede dati di sincronizzazione crittografica, questi dati possono essere trasportati esplicitamente all'inizio del campo Payload Data.

Un campo ICV (Integrity Check Value) è presente solo se il servizio di integrità è selezionato ed è fornito da un algoritmo di integrità separato o da un algoritmo di modalità combinata che usa un ICV. L'ICV è calcolato dopo la cifratura. Questo ordine riduce l'impatto degli attacchi DoS. Poiché l'ICV non è protetto dalla cifratura, per calcolarlo si deve usare un algoritmo di integrità con chiave.

Il campo Padding serve a diversi scopi:

- Se un algoritmo di cifratura richiede che il plaintext sia un multiplo di un certo numero di byte, il campo Padding è usato per espandere il plaintext alla lunghezza richiesta.
- Usato per assicurare l'allineamento dei campi Pad Length e Next Header.
- Ulteriore padding può essere aggiunto per fornire parziale confidenzialità del traffico nascondendo l'effettiva lunghezza del payload.

![[Pasted image 20261116101807.png|500]]

## Transport e Tunnel Mode
**Transport Mode:** fornisce protezione principalmente per i protocolli di livello superiore. Esempi includono un segmento TCP o UDP o un pacchetto ICMP. Tipicamente usato per comunicazione end-to-end tra due host. ESP in transport mode cifra e opzionalmente autentica il payload IP ma non l'intestazione IP. AH in transport mode autentica il payload IP e porzioni selezionate dell'intestazione IP.

**Tunnel Mode:** fornisce protezione all'intero pacchetto IP. Usato quando uno o entrambi gli estremi di un'associazione di sicurezza (SA) sono un security gateway. Un numero di host su reti dietro firewall possono impegnarsi in comunicazioni sicure senza implementare IPsec. ESP in tunnel mode cifra e opzionalmente autentica l'intero pacchetto IP interno, includendo l'intestazione IP interna. AH in tunnel mode autentica l'intero pacchetto IP interno e l'intestazione IP esterna.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261116111844.png" width="500">
</div>

![[Pasted image 20261116104938.png|500]]

## Table 9.1 — Tunnel Mode e Transport Mode: Funzionalità
(Confronto delle due modalità)

## Prevenzione dei replay attack
I pacchetti, anche se autenticati, non possono essere replicati grazie al campo Sequence Number dell'ESP. Il mittente inserisce valori da 0 a 2^32-1. Se ha bisogno di altri pacchetti, deve negoziare una nuova SA. Il ricevente deve scartare i pacchetti vecchi o ripetuti o falsificati.

1. Il ricevente accetta una "finestra" di dimensione W (tipicamente W=64) di numeri di sequenza. N sia il massimo numero nella finestra.
2. Se il numero di un pacchetto in arrivo rientra nella finestra, il pacchetto non è presente ed è autenticato mediante MAC, viene marcata la posizione relativa.
3. Se il numero di un pacchetto in arrivo è M > N, il pacchetto non è presente ed è autenticato mediante MAC, viene estesa la finestra dalla destra fino a M.
4. Se il numero di un pacchetto in arrivo è M ≤ N - W, oppure il pacchetto è già presente, oppure non è autenticato dalla MAC, viene segnalata un'anomalia.

![[Pasted image 20261116104955.png|500]]

## Modalità transport e tunnel (rappresentazione grafica)
Nella modalità transport l'autenticazione viene applicata al testo cifrato. Nella modalità tunnel l'intero pacchetto IP originale viene incapsulato in un nuovo pacchetto IP.

![[Pasted image 20261116110953.png|500]]

## Combinazione di Security Associations
Un singolo SA può implementare il protocollo AH o ESP ma non entrambi.

*Security association bundle:* si riferisce a una sequenza di SAs attraverso cui il traffico deve essere processato per fornire un set desiderato di servizi IPsec. Le SA in un bundle possono terminare a endpoint diversi o allo stesso endpoint.

Le SA possono essere combinate in bundle in due modi:

- **Transport adjacency:** si riferisce all'applicazione di più di un protocollo di sicurezza allo stesso pacchetto IP senza invocare il tunneling. Questo approccio permette solo un livello di combinazione.
- **Iterated tunneling:** si riferisce all'applicazione di multiple livelli di protocolli di sicurezza effettuati attraverso IP tunneling. Questo approccio permette multiple livelli di nidificazione.

### ESP with Authentication Option
In questo approccio, il primo utente applica ESP ai dati da proteggere e poi aggiunge il campo di dati di autenticazione.

- Transport mode ESP: autenticazione e cifratura applicano al payload IP consegnato all'host, ma l'intestazione IP non è protetta.
- Tunnel mode ESP: autenticazione applica all'intero pacchetto IP consegnato all'indirizzo di destinazione IP esterno e l'autenticazione è eseguita a quella destinazione. L'intero pacchetto IP interno è protetto dal meccanismo di privacy per la consegna all'indirizzo IP interno di destinazione.

In entrambi i casi l'autenticazione si applica al ciphertext piuttosto che al plaintext.

### Transport Adjacency
Un altro modo per applicare l'autenticazione dopo la cifratura è usare due SA di transport in bundle, con l'interna che è un SA ESP e l'esterna che è un SA AH. In questo caso ESP è usato senza la sua opzione di autenticazione. La cifratura è applicata al payload IP. AH è poi applicato in transport mode. Vantaggio: l'autenticazione copre più campi. Svantaggio: overhead di due SA contro una.

### Transport-Tunnel Bundle
L'uso dell'autenticazione prima della cifratura potrebbe essere preferibile per diversi motivi:

- È impossibile per chiunque intercettare il messaggio e alterare i dati di autenticazione senza essere rilevato.
- Può essere desiderabile memorizzare le informazioni di autenticazione con il messaggio a destinazione per riferimento futuro.

Un approccio è usare un bundle costituito da un SA AH transport interno e un SA ESP tunnel esterno. L'autenticazione è applicata al payload IP più l'intestazione IP. Il pacchetto IP risultante è poi processato in tunnel mode da ESP. Il risultato è che l'intero pacchetto interno autenticato è cifrato e viene aggiunta una nuova intestazione IP esterna.

![[Pasted image 20261116111026.png|500]]

## Combinazioni di SA
Non ha senso combinare più di due modalità di trasporto: ESP in trasporto; eventualmente AH ed ESP in cascata (deprecato).

Può servire combinare (sovrapporre) molteplici tunnel. Ogni tunnel può avere propri nodi di inizio e fine. Ogni nodo compatibile IPsec deve supportare 4 tipi di combinazioni SA.

- **Tipo 1 di combinazioni SA: sicurezza punto-punto.** 1. ESP in trasporto. 2. Eventualmente AH ed ESP in cascata (deprecato).
- **Tipo 2 di combinazioni SA: sicurezza fra intermediari.** 1. ESP in tunnel.
- **Tipo 3/4 di combinazioni SA: tipo 1 & tipo 2.** Combinazione di tipo 1 punto-punto e combinazione di tipo 2 fra intermediari.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261116111900.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261116111943.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261116111954.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261116112010.png" width="500">
</div>

![[Pasted image 20261116111624.png|500]]

## Internet Key Exchange (IKE)
La gestione delle chiavi di IPsec implica la determinazione e distribuzione delle chiavi segrete. Un requisito tipico è quattro chiavi per comunicazione tra due applicazioni (coppie trasmissione/ricezione per integrità e confidenzialità).

Il documento IPsec Architecture impone il supporto per due tipi di gestione delle chiavi:

- **Manual:** un amministratore di sistema configura manualmente ogni sistema con le proprie chiavi e le chiavi degli altri sistemi comunicanti. Pratico per ambienti piccoli e relativamente statici.
- **Automated:** abilita la creazione su richiesta di chiavi per le SA e facilita l'uso di chiavi in un sistema distribuito ampio con configurazione in evoluzione.

![[Pasted image 20261116111733.png|500]]

### IKE1: ISAKMP/Oakley
Il protocollo predefinito di gestione automatizzata delle chiavi di IPsec. Consiste di:

- **Oakley Key Determination Protocol:** un protocollo di scambio chiavi basato sull'algoritmo Diffie-Hellman ma che fornisce sicurezza aggiuntiva. È generico nel senso che non detta formati specifici.
- **Internet Security Association and Key Management Protocol (ISAKMP):** fornisce un framework per la gestione delle chiavi Internet e fornisce il supporto specifico del protocollo, inclusi i formati, per la negoziazione degli attributi di sicurezza. Consiste di un insieme di tipi di messaggio che consentono l'uso di una varietà di algoritmi di scambio chiavi.

### Caratteristiche della determinazione delle chiavi IKE2
L'algoritmo è caratterizzato da cinque importanti caratteristiche:

1. Impiega *cookie* per contrastare gli attacchi di clogging (DoS). Lo scambio richiede che ciascuna parte invii un riscontro: un oppositore può costringere il sistema a generare il riscontro, ma non a eseguire subito i costosi calcoli dell'esponenziazione modulare Diffie-Hellman. Il cookie dipende dalla parte specifica e da informazioni segrete locali; generarlo e verificarlo deve essere veloce. La slide descrive il calcolo con un hash rapido (MD5) sugli indirizzi IP e sulle porte UDP sorgente e destinazione, insieme a un nonce segreto locale.
2. Permette alle due parti di negoziare un *group*, che specifica i parametri globali dello scambio chiavi Diffie-Hellman.
3. Usa *nonces* per garantire contro attacchi di replay.
4. Permette lo scambio dei valori di chiave pubblica Diffie-Hellman.
5. Autentica lo scambio Diffie-Hellman per contrastare attacchi man-in-the-middle.

![[Pasted image 20261116111754.png|500]]

### IKE groups per generazione chiavi e metodi di autenticazione
- **Groups:** esponenziazione modulare con moduli 768-bit, 1024-bit o 1536-bit; curve ellittiche su 2^155 o 2^185; uso di nonces (per evitare attacchi di replay).
- **3 diversi metodi di autenticazione:** digital signatures, public key encryption, symmetric encryption.

![[Pasted image 20261116111758.png|500]]

## Protocollo Diffie-Hellman
A e B concordano i parametri pubblici α e β.

- A inventa Xa a caso, crea Ya = α^Xa mod β.
- B inventa Xb a caso, crea Yb = α^Xb mod β.
- 1. A → B: Ya
- 2. B → A: Yb
- A calcola K = Yb^Xa mod β
- B calcola K = Ya^Xb mod β

![[Pasted image 20261116111817.png|500]]

[[Lezione 7-PGP, DNSSEC e autenticazione del dominio|Lezione 7]]

## Capitolo finale dal libro — IP Security (Capitolo 9)

Il libro di testo tratta IPsec nel Capitolo 9 ("IP Security"). Di seguito i contenuti rilevanti per questa lezione.

### IPsec: overview e servizi
IPsec fornisce la capacità di proteggere le comunicazioni attraverso LAN, WAN private e pubbliche e Internet, cifrando e/o autenticando tutto il traffico a livello IP. Così tutte le applicazioni distribuite (remote logon, client/server, e-mail, file transfer, Web access) possono essere protette senza modificare il software su host o server.

I servizi IPsec elencati nel libro sono:
- Access control
- Connectionless integrity
- Data origin authentication
- Rejection of replayed packets (una forma di integrità parziale della sequenza)
- Confidentiality (cifratura)
- Limited traffic flow confidentiality

### Security Policy Database (SPD), Security Association Database (SAD) e Security Association (SA)
Il modello di elaborazione IPsec distingue outbound e inbound:

**Pacchetti in uscita:** IPsec cerca una corrispondenza nello SPD. Se non c'è match, il pacchetto viene scartato. Se c'è match:
- `DISCARD`: il pacchetto viene scartato.
- `BYPASS`: il pacchetto viene inoltrato senza elaborazione IPsec.
- `PROTECT`: si cerca nel SAD una SA corrispondente. Se non esiste, si invoca IKE per crearne una. La SA determina cifratura, autenticazione o entrambi, e transport o tunnel mode.

**Pacchetti in entrata:** IPsec esamina il campo IP Protocol / Next Header per capire se il pacchetto è protetto (ESP/AH) o meno. Se non protetto, si applica la policy SPD. Se protetto, si cerca nel SAD e si applica ESP o AH.

*Definizione:* una SA è una connessione logica unidirezionale tra mittente e ricevitore che fornisce servizi di sicurezza al trasportato. È identificata da Security Parameters Index (SPI), IP Destination e Security protocol identifier (AH o ESP).

### Encapsulating Security Payload (ESP)
ESP fornisce confidentiality, data origin authentication, connection-less integrity, anti-replay service e (limitata) traffic flow confidentiality. Il set di servizi dipende dalle opzioni selezionate al momento della creazione della SA.

**Formato del pacchetto ESP:** Security Parameters Index (32 bit), Sequence Number (32 bit, anti-replay), Payload Data, Padding, Pad Length, Next Header, Integrity Check Value (ICV). Possono essere presenti anche Initialization Value (IV) e TFC padding.

**Anti-replay:** il sender inizializza un contatore di sequenza a 0 e lo incrementa per ogni pacchetto. Il ricevente implementa una finestra di dimensione W (default 64). Pacchetti fuori finestra o non autenticati vengono scartati.

**Transport mode:** ESP protegge il payload IP (segmento TCP/UDP o pacchetto ICMP), ma non l'intestazione IP. Usato per comunicazione end-to-end tra due host.

**Tunnel mode:** ESP protegge l'intero pacchetto IP (inclusa l'intestazione IP interna), aggiungendo una nuova intestazione IP esterna. Usato quando uno o entrambi gli estremi della SA sono security gateway (firewall/router).

### Combinazione di Security Associations
Una singola SA può implementare AH o ESP ma non entrambi. Per combinare entrambi i servizi si usano **Security Association bundle**:
- **Transport adjacency:** più di un protocollo di sicurezza sullo stesso pacchetto IP senza tunneling (un solo livello di combinazione).
- **Iterated tunneling:** multiple livelli di protocolli di sicurezza attraverso IP tunneling (multiple livelli di nidificazione).

**ESP with Authentication Option:** si applica ESP e poi si aggiunge il campo di autenticazione. L'autenticazione si applica al ciphertext, non al plaintext.

**Transport-Tunnel Bundle:** un SA AH transport interno e un SA ESP tunnel esterno. L'autenticazione copre payload IP più intestazione IP; poi l'intero pacchetto viene cifrato in tunnel mode.

Il libro elenca quattro combinazioni di base (Case 1-4) che i nodi IPsec conformi devono supportare, dalla sicurezza end-to-end tra host alla sicurezza solo tra gateway (VPN).

### Internet Key Exchange (IKE)
La gestione delle chiavi IPsec prevede due tipi:
- **Manual:** amministratore configura manualmente chiavi su ogni sistema. Pratico per ambienti piccoli e statici.
- **Automated:** creazione su richiesta di chiavi per le SA, adatto a sistemi distribuiti ampi.

Il protocollo predefinito automatizzato è ISAKMP/Oakley (IKEv1), composto da:
- **Oakley Key Determination Protocol:** basato su Diffie-Hellman con sicurezza aggiunta, generico nei formati.
- **Internet Security Association and Key Management Protocol (ISAKMP):** framework per la gestione chiavi Internet con supporto per negoziare attributi di sicurezza.

IKEv2 definisce scambi iniziali (4 messaggi per stabilire la prima SA), CREATE_CHILD_SA (per SA aggiuntive) e Informational exchange (gestione, errori, notifiche).

### Suite crittografiche
RFC 4308 definisce due suite: VPN-A (3DES-CBC, HMAC-SHA1-96, gruppo DH 1024-bit MODP) e VPN-B (AES-CBC 128-bit, AES-XCBC-MAC-96, gruppo DH 2048-bit MODP). RFC 6379 definisce la NSA Suite B con AES-GCM, HMAC-SHA-256/384 e gruppi ECP.

> [!info] IPsec-v3 e IPsec-v2
> *IPsec-v3* è il nome usato dalla roadmap IETF per l'architettura di [RFC 4301](https://www.rfc-editor.org/rfc/rfc4301.html), che sostituisce IPsec-v2, definita da [RFC 2401](https://www.rfc-editor.org/rfc/rfc2401.html). Non è una nuova versione di IP né un singolo protocollo: IPsec è una famiglia di standard per AH, ESP, le SA e la gestione delle chiavi. RFC 4301 resta il documento base dell'architettura, aggiornato da RFC successive.
>
> La revisione incorpora l'esperienza d'implementazione e chiarisce punti ambigui o incompleti di IPsec-v2. La nuova architettura descrive in modo più preciso il trattamento del traffico e le interazioni fra le basi dati, per adattarsi a più scenari e semplificare l'implementazione.
>
> | IPsec-v2 (RFC 2401) | IPsec-v3 (RFC 4301 e documenti associati) |
> |---|---|
> | Modello di elaborazione meno dettagliato; la selezione delle policy era meno flessibile. | Modello di elaborazione rivisto; separa inoltro e selezione SPD, con cache SPD per alcuni flussi. |
> | SPD con selettori meno flessibili. | Selettori SPD più flessibili, inclusi intervalli di indirizzi e porte e tipi/codici ICMP. |
> | Non prevedeva la PAD nell'architettura. | Aggiunge la Peer Authorization Database (PAD), che collega autenticazione dei peer, gestione delle SA e SPD. |
> | AH obbligatorio da implementare. | AH facoltativo; ESP aggiunge algoritmi combinati di cifratura e integrità ed estende il formato/elaborazione per supportarli. |
> | Numeri di sequenza a 32 bit. | Aggiunge gli Extended Sequence Numbers (ESN) a 64 bit. |
>
> La transizione non sostituisce l'idea di IPsec: aggiorna l'architettura e i protocolli associati sulla base dell'esperienza, con policy più espressive, elaborazione più chiara e supporto migliore a nuovi scenari. [RFC 6071 §2.2](https://www.rfc-editor.org/rfc/rfc6071.html#section-2.2), [RFC 4301 §13](https://www.rfc-editor.org/rfc/rfc4301.html#section-13)

> [!info] IKEv1 e IKEv2
> Prima di IKEv2, IKEv1 era definito da tre documenti distinti: RFC 2407 (IPsec DOI), RFC 2408 (ISAKMP) e RFC 2409 (IKE). IKEv1 combinava la negoziazione di fase 1 e fase 2 e offriva più tipi di scambio, con dettagli distribuiti in documenti che potevano risultare ambigui o contraddittori.
>
> IKEv2 riunisce la specifica in un protocollo coerente e riduce gli scambi iniziali a un unico scambio di quattro messaggi (due andate/ritorni), che può negoziare anche una prima Child SA. Le richieste hanno risposte e numeri di sequenza; il responder può rimandare i calcoli costosi finché l'iniziatore non dimostra di poter ricevere i messaggi all'indirizzo dichiarato, riducendo l'esposizione ad attacchi di amplificazione e DoS. La revisione integra il supporto per NAT traversal, EAP e acquisizione di indirizzi, semplifica la negoziazione e corregge debolezze crittografiche. IKEv2 non è compatibile con IKEv1: i peer devono concordare una versione supportata.
>
> Oggi RFC 7296 è lo standard IKEv2, aggiornato da RFC successive; RFC 9395 ha spostato IKEv1 in stato *Historic* e ne documenta la deprecazione. [RFC 7296, Appendice A](https://www.rfc-editor.org/rfc/rfc7296.html#appendix-A), [RFC 9395](https://www.rfc-editor.org/rfc/rfc9395.html)

> [!info] *Nonce*
> Un *nonce* è un valore generato per uno scambio e non riutilizzato. I peer lo inseriscono nei messaggi e lo verificano per legarli allo scambio corrente e riconoscere messaggi riprodotti.
