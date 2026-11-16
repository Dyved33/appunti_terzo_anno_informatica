# IP Security

## IP Security Overview
RFC 1636, *"Security in the Internet Architecture"*, è stato emesso nel 1994 dall'Internet Architecture Board (IAB). Identifica le aree chiave per i meccanismi di sicurezza:

- necessità di proteggere l'infrastruttura di rete da monitoraggio e controllo non autorizzato del traffico;
- necessità di proteggere il traffico end-user-to-end-user usando meccanismi di autenticazione e cifratura.

L'IAB ha incluso autenticazione e cifratura come funzionalità necessarie nella prossima generazione di IP (IPv6). La specifica IPsec esiste ora come un insieme di standard Internet.

## Applicazioni di IPsec
IPsec fornisce la capacità di proteggere le comunicazioni attraverso LAN, WAN private e pubbliche, e Internet.

Esempi:
- connettività sicura tra succedanei su Internet;
- accesso remoto sicuro su Internet;
- connettività extranet e intranet con partner;
- sicurezza del commercio elettronico.

*Caratteristica principale di IPsec:* può cifrare e/o autenticare tutto il traffico a livello IP. Così tutte le applicazioni distribuite (remote logon, client/server, e-mail, file transfer, Web access) possono essere protette.

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

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261116112033.png" width="500">
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

Header ESP, Trailer ESP, Authenticator ESP: MAC del pacchetto contenente questo AH, lunghezza del padding, 24 (numero di sequenza dell'AH all'interno dell'SA).

### Encapsulating Security Payload (ESP)
Usato per cifrare il Payload Data, Padding, Pad Length e Next Header fields. Se l'algoritmo richiede dati di sincronizzazione crittografica, questi dati possono essere trasportati esplicitamente all'inizio del campo Payload Data.

Un campo ICG (Integrity Check Value) è presente solo se il servizio di integrità è selezionato ed è fornito da un algoritmo di integrità separato o da un algoritmo di modalità combinata che usa un ICV. L'ICV è computato dopo che la cifratura è stata eseguita. Questo ordine di elaborazione facilita la riduzione dell'impatto di attacchi DoS. Poiché l'ICV non è protetto dalla cifratura, un algoritmo di integrità con chiave deve essere impiegato per computare l'ICV.

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

1. Impiega un meccanismo noto come *cookies* per contrastare attacchi di clogging (DoS). Lo scambio di cookie richiede che ogni parte invii un ack. Un oppositore può solo forzare un utente a generare un ack ma non a fare costosi calcoli (esponenziazione modulare Diffie-Hellman). Il cookie deve dipendere dalla parte specifica (per evitare mascheramento). I cookie sono connessi a qualche informazione segreta locale. La generazione e verifica dei cookie devono essere veloci.
2. Permette alle due parti di negoziare un "group"; questo, in sostanza, specifica i parametri globali dello scambio chiavi Diffie-Hellman. L'uso di una veloce hash (MD5) su IP e UDP sorgente e destinazione e un nonce segreto locale.
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

![[Lezione 7-PGP, DNSSEC e autenticazione del dominio|Lezione 7]]

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


