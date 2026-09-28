# Fondamenti di Sicurezza Informatica e Protezione dei Sistemi

> [!INFO] Informazioni sul Corso ed Esami
> - **Testo di riferimento:** William Stallings, *Network Security Essentials: Applications and Standards*.
> - **Modalità d'esame:** Prova orale vertente sugli argomenti trattati a lezione e sui capitoli corrispondenti del testo di riferimento.

## 1. Definizioni e Concetti Fondamentali

La **sicurezza** in senso generale è definibile come l'assenza di rischio, pericolo o minaccia. In ambito informatico, tale concetto si specializza nella protezione attiva e preventiva delle risorse digitali.

* **Sicurezza Informatica:** L'insieme delle misure, delle tecnologie e delle procedure volte a prevenire o proteggere le risorse hardware, software e le informazioni da accessi non autorizzati, alterazioni, sottrazioni o distruzione.
* **Definizione Formale di Computer Sicuro:**
  Un sistema di elaborazione si definisce sicuro se e solo se è accessibile ed utilizzabile esclusivamente da entità legittimamente autorizzate:
  $$\text{Computer Sicuro} \iff \text{Accessibile solo a soggetti autorizzati}$$
  In altri termini, un computer è sicuro quando esegue fedelmente e unicamente ciò per cui è stato progettato, consentendone l'operatività solo a chi ne ha il diritto.

> [!IMPORTANT] Il Principio di Non-Assolutezza della Sicurezza
> Un sistema informatico **non è mai sicuro al 100% in senso permanente**. La sicurezza è un processo dinamico e contingente: un sistema considerato inattaccabile ieri può risultare vulnerabile oggi o domani a causa della scoperta di nuove vulnerabilità (es. exploit *zero-day*), dell'evoluzione delle tecniche di attacco o dell'aumento della potenza di calcolo a disposizione degli attaccanti.

> [!NOTE] Nota del Prof: Ridisegno Architetturale e Sicurezza
> La sicurezza non è un componente applicabile a posteriori (*add-on*), ma una proprietà trasversale che coinvolge tutti i livelli architetturali (dall'hardware al software applicativo, fino alle procedure umane). Per rendere un sistema intrinsecamente sicuro sarebbe spesso necessario un **completo ridisegno architetturale**, operazione complessa e raramente praticabile a causa dei vincoli di retrocompatibilità, dei costi e dei tempi di sviluppo.

## 2. Proprietà di Sicurezza: La Triade CIA e Dimensioni Estese

La sicurezza informatica si articola storicamente attorno alla **Triade CIA**, a cui la moderna teoria della sicurezza affianca ulteriori dimensioni critiche:

### 2.1 La Triade CIA Cardine
1. **Confidenzialità (*Confidentiality*):** Garanzia che i dati, le comunicazioni e le risorse di sistema siano accessibili e leggibili esclusivamente dai soggetti (utenti, processi) esplicitamente autorizzati.
2. **Integrità (*Integrity*):** Garanzia che le informazioni, il software e le configurazioni non subiscano alterazioni, manomissioni o cancellazioni non autorizzate, preservando la correttezza e la completezza del dato originale.
3. **Disponibilità (*Availability*):** Garanzia che i sistemi, le reti e le informazioni siano tempestivamente accessibili e pienamente operativi ogni qualvolta un utente o servizio autorizzato ne faccia richiesta.

### 2.2 Proprietà di Sicurezza Estese
* **Autenticità (*Authenticity*):** Capacità di verificare e accertare con certezza la genuinità di una comunicazione, di un documento o l'identità dichiarata da un'entità mittente.
* **Tracciabilità e Imputabilità (*Accountability / Non-Repudiation*):** Capacità di correlare in modo univoco e non contestabile ogni singola operazione compiuta nel sistema al soggetto specifico che l'ha eseguita, impedendo a chiunque di negare le proprie azioni.
* **Possesso o Controllo (*Possession / Control*):** Capacità del legittimo proprietario di esercitare il pieno controllo logico e fisico sui propri dati e sulle infrastrutture.
* **Utilità (*Utility*):** Garanzia che le informazioni conservino la loro forma utile e fruibile (es. dati cifrati la cui chiave di decifratura è andata perduta rimangono confidenziali e integri, ma perdono totalmente la loro utilità).

## 3. Il Modello IAAA: Autenticazione, Identificazione, Autorizzazione e Accounting

Il controllo degli accessi poggia su quattro pilastri logici distinti ma interconnessi:

1. **Autenticazione (*Authentication*):** Processo di validazione delle credenziali o delle evidenze fornite da un'entità per dimostrare di essere chi afferma di essere (es. inserimento di username e password, certificati digitali, token OTP, fattori biometrici).
2. **Identificazione (*Identification*):** Associazione formale tra un'entità logica o account e la reale identità civile/anagrafica nel mondo fisico (es. esibizione di un documento di riconoscimento, SPID, verifica notarile).
3. **Autorizzazione (*Authorization*):** Determinazione e attribuzione dei privilegi operativi e dei diritti di accesso a specifiche risorse (definizione puntuale di *cosa* l'utente autenticato ha il permesso di leggere, modificare o eseguire).
4. **Tracciabilità / Accounting (*Auditing & Accountability*):** Monitoraggio e registrazione continuativa delle azioni svolte dagli utenti all'interno del sistema (*verificare chi fa cosa* tramite registri di audit e log immutabili).

```
[ Identificazione / Anagrafica ] 
              ↓
  [ Autenticazione (Credenziali) ] → [ Autorizzazione (Policy & ACL) ] → [ Accounting (Log & Audit) ]
```

> [!NOTE] Nota del Prof: Autenticazione vs Identificazione
> Nei sistemi informatici l'**autenticazione** precede la verifica operativa dei permessi: un utente fornisce credenziali (es. username/password o token) per autenticare la propria sessione prima che il sistema ne verifichi i diritti o ne colleghi formalmente l'identità.

> [!EXAMPLE] Spunto di Riflessione: Autenticazione Senza Identificazione
> Esistono molteplici scenari pratici in cui un sistema effettua un'autenticazione valida senza procedere all'identificazione nominale della persona fisica:
> * **Blockchain e Criptovalute:** Le transazioni vengono autenticate mediante firma crittografica con chiave privata senza richiedere l'identità anagrafica del firmatario (garantendo pseudonimato).
> * **Badge e Token di Accesso Fisico Anonimi:** Biglietti elettronici, gettoni o badge numerati validano il diritto di ingresso (autenticazione del titolo) senza identificare l'individuo.
> * **Sistemi di Credenziali Anonime e Zero-Knowledge Proofs (ZKP):** Protocolli che consentono a un utente di dimostrare di possedere un attributo valido (es. essere maggiorenne o iscritto a un servizio) senza rivelare la propria identità.

## 4. Ambiti di Difesa e Fasi del Piano di Sicurezza

La protezione di un'organizzazione o infrastruttura richiede un approccio difensivo su molteplici livelli:

### 4.1 I Livelli di Protezione
* **Physical Security (Sicurezza Fisica):** Barriere e controlli per regolare e impedire l'accesso fisico non autorizzato a locali server, rack, cablaggi e postazioni di lavoro.
* **Operational / Procedural Security (Sicurezza Operativa e Procedurale):** Definizione e adozione di policy aziendali, standard operativi, procedure di gestione degli incidenti e piani di continuità del business (*Business Continuity*).
* **Personnel Security (Sicurezza del Personale):** Formazione e sensibilizzazione degli utenti contro attacchi di ingegneria sociale (*phishing*, *pretexting*), controllo delle referenze e gestione delle deleghe.
* **System Security (Sicurezza di Sistema):** Applicazione del principio del minimo privilegio, gestione rigorosa delle Access Control List (ACL), disabilitazione dei servizi superflui (*hardening*) e analisi dei log.
* **Network Security (Sicurezza di Rete):** Firewall, apparati IDS/IPS, segmentazione del traffico, routing sicuro e filtraggio dei pacchetti.

### 4.2 Le Fasi del Piano di Sicurezza
Un piano di sicurezza organico struttura la difesa in cinque stadi temporali e operativi:

1. **Risk Avoidance (Evitamento del Rischio):** Scelte architetturali e di business mirate a eliminare alla radice l'esposizione al rischio (es. disconnettere dalla rete pubblica un sistema industriale SCADA critico che non necessita di collegamento a Internet permanente).
2. **Deterrence (Deterrenza):** Pubblicizzazione visibile delle misure difensive adottate, dei sistemi di monitoraggio e delle sanzioni disciplinari/legali previste per scoraggiare potenziali malintenzionati.
3. **Prevention (Prevenzione):** Meccanismi attivi (firewall, cifratura, controlli di autenticazione forte, antivirus) volti a bloccare sul nascere i tentativi di intrusione.
4. **Detection (Rilevamento):** Individuazione tempestiva di violazioni o anomalie in corso tramite sistemi IDS (*Intrusion Detection System*), SIEM e monitoraggio del traffico.
5. **Reaction (Reazione e Ripristino):** Procedure di risposta all'incidente (*Incident Response*), contenimento della minaccia, ripristino dell'operatività da backup integri (*Disaster Recovery*) e conservazione delle prove digitali per il perseguimento legale (*Digital Forensics* e tribunale).

## 5. Soluzioni Tecnologiche e Contromisure contro gli Attacchi

Per contrastare efficacemente gli attacchi informatici si impiegano soluzioni tecniche integrate:

1. **Pianificazione e Segmentazione della Rete:**
   * Utilizzo di apparati di rete adeguati (router, switch layer 3/gestiti).
   * Suddivisione della rete in zone con differenti livelli di fiducia e sicurezza (es. VLAN separate, creazione di una **DMZ - Demilitarized Zone** per isolare i server pubblici dalla rete interna).
2. **Integrità Applicativa e Hardening:**
   * Adozione di metodologie di sviluppo sicuro per ridurre al minimo i bug nel codice sorgente (*Secure Coding*, analisi statica e dinamica del codice).
   * Verifica puntuale e hardening delle configurazioni dei sistemi operativi e dei server.
3. **Controllo e Filtraggio dei Flussi di Traffico:**
   * Utilizzo di apparati firewall (packet filter, stateful inspection, application firewall) e router screening per ispezionare, filtrare e bloccare il traffico anomalo da e verso l'esterno.
4. **Crittografia e Canali Sicuri:**
   * Applicazione di algoritmi e protocolli crittografici per cifrare i dati prima della loro trasmissione su canali non protetti (es. **SSH** per amministrazione remota sicura, **TLS/SSL** per il traffico web, **PGP/GPG** per email e file, **VPN** con IPsec/OpenVPN per tunnel cifrati).

## 6. Distinzione Terminologica: Computer Security, Cybersecurity e Information Assurance

La disciplina della protezione dei dati e dei sistemi si articola in tre definizioni complementari:

```
┌─────────────────────────────────────────────────────────┐
│                 Information Assurance                   │
│  (Governo del dato: CIA, Autenticità, Policy, Utilità) │
│  ┌───────────────────────────────────────────────────┐  │
│  │                   Cybersecurity                   │  │
│  │  (Difesa e protezione delle risorse nel ciberspazio)│  │
│  │  ┌─────────────────────────────────────────────┐  │  │
│  │  │              Computer Security              │  │  │
│  │  │  (Protezione fisica e logica di HW, SW,     │  │  │
│  │  │   firmware e dati memorizzati/trasmessi)    │  │  │
│  │  └─────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

* **Computer Security:** Misure e controlli tecnici volti a garantire la confidenzialità, l'integrità e la disponibilità degli asset di un sistema di elaborazione, inclusi componenti hardware, software, firmware e informazioni durante l'elaborazione, la memorizzazione e la trasmissione.
* **Cybersecurity:** La capacità di proteggere, difendere e mitigare gli attacchi informatici condotti attraverso il ciberspazio (reti pubbliche, Internet e infrastrutture interconnesse).
* **Information Assurance (IA):** Insieme integrato di controlli tecnici, organizzativi e manageriali progettati per garantire la confidenzialità, il controllo del possesso, l'integrità, l'autenticità, la disponibilità e l'utilità delle informazioni e dei sistemi informativi lungo tutto il loro ciclo di vita.

---

# Lezione 2: Architettura delle Reti, Stack Protocollare TCP/IP e Protocolli Applicativi

## 1. Architettura di Rete e lo Stack Protocollare TCP/IP

Nel paradigma di rete contemporaneo, Internet si configura come un'infrastruttura di comunicazione complessa ed eterogenea fondata sullo stack di protocolli **TCP/IP**. La comunicazione tra nodi remoti (modello **Client-Server**) viene mediata dai protocolli di trasporto che creano un canale logico virtuale (*end-to-end*) tra i sistemi terminali (*host*).

```
┌────────────────────────────────────────────────────────┐
│               Livello di Applicazione                  │  FTP, SMTP, HTTP, HTTPS, DNS
├────────────────────────────────────────────────────────┤
│                 Livello di Trasporto                   │  TCP (affidabile), UDP (best-effort)
├────────────────────────────────────────────────────────┤
│                   Livello di Rete                      │  IP (IPv4, IPv6), ICMP, Routing
├────────────────────────────────────────────────────────┤
│                 Livello di Data Link                   │  Ethernet (802.3), Wi-Fi (802.11)
├────────────────────────────────────────────────────────┤
│                    Livello Fisico                      │  Segnali elettrici, ottici, onde radio
└────────────────────────────────────────────────────────┘
```

### 1.1 Gerarchia dei Livelli e Unità Dati di Protocollo (PDU)
Il principio della stratificazione (*layering*) isola le responsabilità funzionali: ciascun livello aggiunge la propria intestazione (*header*) ai dati ricevuti dal livello superiore mediante il processo di **incapsulamento**.

| Livello Protocollare | Denominazione PDU (*Protocol Data Unit*) | Funzione Primaria e Protocolli Tipici |
| :--- | :--- | :--- |
| **Applicazione** | **Messaggio (*Message*)** | Supporto ai servizi e alle applicazioni di rete distribuite (HTTP, FTP, SMTP, DNS). |
| **Trasporto** | **Segmento (*Segment*)** / Datagramma UDP | Trasferimento logico dei messaggi tra processi applicativi; multiplexing/demultiplexing (TCP, UDP). |
| **Rete** | **Datagramma IP (*Datagram / Packet*)** | Instradamento (*routing*) e indirizzamento logico dei pacchetti dall'host sorgente all'host di destinazione (IP). |
| **Data Link** | **Frame (*Trama*)** | Trasferimento dati affidabile attraverso un singolo collegamento fisico (*hop-by-hop*) tra nodi adiacenti (Ethernet, Wi-Fi). |
| **Fisico** | **Bit** | Propagazione dei singoli bit mediante segnali fisici lungo il mezzo trasmissivo. |

---

## 2. Paradigma di Comunicazione e Concetto di Socket

### 2.1 La Primitiva Socket
Una **socket** costituisce l'interfaccia software (*Application Programming Interface*) e il punto di accesso logico che interpone il processo applicativo in esecuzione nello spazio utente (*user space*) con lo stack protocollare di trasporto gestito dal kernel del sistema operativo.

* **Identificatore Univoco (5-tupla):** Una sessione di comunicazione su rete TCP/IP è formalmente individuata dalla tupla:
  $$\langle \text{IP Sorgente}, \text{Porta Sorgente}, \text{IP Destinazione}, \text{Porta Destinazione}, \text{Protocollo} \rangle$$
* **Gestione delle Risorse:** Il socket mantiene strutture dati interne dedicate, tra cui i buffer di trasmissione e ricezione in memoria RAM, code di pacchetti e variabili di stato (es. numeri di sequenza e acknowledge in TCP).

```
   [ Processo Applicativo (User Space) ]
                     │
              (Socket / Porta)
                     ▼
┌──────────────────────────────────────────┐
│      Stack di Trasporto TCP / UDP        │
│   [Buffer Tx] ──► Canale ──► [Buffer Rx] │
└──────────────────────────────────────────┘
```

### 2.2 Classificazione delle Porte di Rete
Le porte logiche (rappresentate da un intero a 16 bit, da $0$ a $65535$) si suddividono in:
* **Well-Known Ports ($0 - 1023$):** Porte riservate e standardizzate da IANA (*Internet Assigned Numbers Authority*) per servizi di sistema e protocolli universali (es. `20/21` FTP, `22` SSH, `25` SMTP, `53` DNS, `80` HTTP, `110` POP3, `143` IMAP, `443` HTTPS). Richiedono privilegi di amministratore/root per il binding.
* **Registered Ports ($1024 - 49151$):** Assegnate a specifiche applicazioni commerciali o servizi registrati.
* **Dynamic / Private / Ephemeral Ports ($49152 - 65535$):** Porte temporanee allocate dinamicamente dal sistema operativo ai processi client per la durata della sessione.

---

## 3. Il Protocollo HTTP e l'Evoluzione verso HTTPS

### 3.1 Architettura e Modello di Comunicazione
Il protocollo **HTTP** (*HyperText Transfer Protocol*) è un protocollo di livello applicativo fondato sul modello Client-Server:
* **Client (Browser / User Agent):** Inoltra richieste (*Request*) per oggetti web specificati da indirizzi URL.
* **Server Web (Apache, Nginx):** Elabora la richiesta e invia la risposta (*Response*) contenente la risorsa informativa richiesta.

### 3.2 Anatomia dei Messaggi HTTP
I messaggi HTTP sono strutturati in formato testo ASCII leggibile:

#### I. Messaggio di Richiesta (*Request Message*)
1. **Request Line (Riga di Richiesta):** Include il metodo HTTP, l'URI della risorsa e la versione del protocollo.
2. **Header Lines (Righe di Intestazione):** Metadati ausiliari (es. `Host:`, `User-Agent:`, `Accept:`, `Connection:`).
3. **CRLF (`\r\n`):** Riga vuota che delimita tassativamente la fine degli header.
4. **Entity Body (Corpo opzionale):** Contenuto trasmesso (es. payload nei metodi `POST` o `PUT`).

```http
GET /somedir/page.html HTTP/1.1
Host: www.someschool.edu
User-Agent: Mozilla/5.0
Accept: text/html,application/xhtml+xml
Connection: keep-alive

```

#### Metodi HTTP Principali
* `GET`: Richiesta di recupero di una risorsa dal server.
* `POST`: Invio di dati strutturati (es. moduli web, payload JSON) al server per l'elaborazione.
* `PUT`: Caricamento o sovrascrittura integrale di una risorsa sul percorso specificato.
* `DELETE`: Richiesta di rimozione della risorsa identificata dal server.
* `HEAD`: Richiede al server di inviare **esclusivamente le righe di intestazione (header)**, omettendo totalmente il corpo (*body*) della risorsa.
  
  > [!NOTE] Utilità del Metodo `HEAD`
  > Il metodo `HEAD` viene impiegato dai crawler, dai proxy e dai tool di diagnostica per verificare la disponibilità di una risorsa, controllare la data di ultima modifica (`Last-Modified`) o ricavarne le dimensioni (`Content-Length`) senza sprecare banda nel download del payload.

#### II. Messaggio di Risposta (*Response Message*)
1. **Status Line (Riga di Stato):** Versione del protocollo, codice numerico di stato a 3 cifre e relativa frase descrittiva:
   * `200 OK`: Richiesta elaborata con successo.
   * `301 Moved Permanently`: Risorsa trasferita permanentemente a un nuovo URL.
   * `304 Not Modified`: La risorsa non ha subito modifiche rispetto alla copia in cache.
   * `400 Bad Request`: Errore sintattico nella richiesta inoltrata dal client.
   * `404 Not Found`: Risorsa inesistente sul server.
   * `500 Internal Server Error`: Errore o crash interno del server web.
2. **Header Lines:** Metadati descrittivi della risposta (`Date:`, `Content-Type:`, `Content-Length:`, `Set-Cookie:`).
3. **CRLF (`\r\n`):** Delimitatore di fine intestazioni.
4. **Entity Body:** I dati fisici restituiti (documento HTML, file binario, JSON).

```http
HTTP/1.1 200 OK
Date: Mon, 28 Sep 2026 12:00:00 GMT
Server: Apache/2.4.41 (Ubuntu)
Last-Modified: Sun, 27 Sep 2026 18:22:00 GMT
Content-Length: 6821
Content-Type: text/html; charset=UTF-8

<!DOCTYPE html>
<html>...</html>
```

### 3.3 HTTPS (HTTP Secure) e Sicurezza di Livello Applicativo
**HTTPS** incapsula il traffico HTTP all'interno di un canale crittografico protetto mediante il protocollo **TLS/SSL** operante su porta standard **`443`**:
* **Confidenzialità:** Cifratura simmetrica dei dati in transito contro intercettazioni (*sniffing*).
* **Integrità:** Controllo crittografico (MAC / HMAC) per rilevare ogni manomissione dei pacchetti.
* **Autenticazione:** Verifica dell'identità del server tramite certificati digitali X.509 emessi da Certification Authority (CA) fidate.

### 3.4 Web Caching (Proxy Server) e GET Condizionale
Un **Server Proxy / Web Cache** memorizza copie locali delle risorse web richieste di frequente, rispondendo direttamente alle richieste dei client senza interpellare il server di origine:
* **Vantaggi:** Riduzione drastica dei tempi di risposta (*latenza*) e abbattimento del traffico sui canali di accesso.
* **GET Condizionale:** Meccanismo con cui il proxy verifica la freschezza della copia locale inviando un header `If-Modified-Since: <data>`. Se la risorsa non è mutata, il server risponde con `304 Not Modified` senza inviare il payload.

```
[ Client ] ──(1. Richiesta HTTP)──► [ Web Cache (Proxy) ]
                                          │
                        (Se non presente o scaduto)
                                          ▼
                               [ Server di Origine ]
```

### 3.5 Mantenimento dello Stato tramite Cookie
HTTP è un protocollo intrinsecamente privo di stato (**stateless**). Per associare transazioni consecutive a una medesima sessione utente, i siti adottano i **Cookie**:
1. Il server invia un identificativo univoco nell'header di risposta: `Set-Cookie: session_id=abc123xyz`.
2. Il browser memorizza il cookie sul file system locale.
3. Nelle successive richieste verso lo stesso dominio, il browser include automaticamente l'header: `Cookie: session_id=abc123xyz`.

---

## 4. Il Protocollo FTP (File Transfer Protocol - RFC 959)

Il protocollo **FTP** consente il trasferimento bidirezionale di file tra un host locale e uno remoto.

```
┌────────────────────────────────────────────────────────┐
│                      Client FTP                        │
│   [Interfaccia Utente] ── [Controllo] ── [Dati]        │
└────────────┬───────────────────┬─────────────┬─────────┘
             │                   │             │
             │ Connessione di    │             │ Connessione Dati
             │ Controllo (TCP 21)│             │ (TCP 20)
             ▼                   ▼             ▼
┌────────────────────────────────────────────────────────┐
│                      Server FTP                        │
│   [File System Remoto] ── [Controllo] ── [Dati]        │
└────────────────────────────────────────────────────────┘
```

### 4.1 Architettura a Due Connessioni (*Out-of-Band*)
A differenza di HTTP che trasmette controlli e dati sul medesimo canale, FTP utilizza **due canali TCP paralleli e distinti**:
1. **Connessione di Controllo (Porta 21 TCP):** Canale persistente per l'intera durata della sessione, utilizzato per trasmettere comandi utente (`USER`, `PASS`, `LIST`, `RETR`, `STOR`) e ricevere i codici di stato di risposta. È una connessione *out-of-band* (fuori banda) che mantiene lo stato dell'utente e la directory corrente.
2. **Connessione Dati (Porta 20 TCP / Porta Dinamica):** Canale non persistente aperto *on-demand* esclusivamente per il trasferimento del contenuto di un file o l'elenco delle cartelle, e chiuso immediatamente al termine del singolo trasferimento.

---

## 5. Meccanismi di Controllo dell'Integrità nei Protocolli di Rete

Durante la propagazione attraverso i mezzi fisici, i segnali possono subire attenuazioni o interferenze che corrompono i bit trasmessi. I protocolli di rete implementano tecniche di controllo e rilevamento degli errori per garantire l'**integrità** dei dati:

1. **Bit di Parità (Pari / Dispari):**
   * Aggiunta di un bit di controllo a una sequenza di bit in modo che la somma totale dei bit a valore $1$ sia sempre pari (parità pari) o dispari (parità dispari).
   * Rileva errori singoli; inefficace in presenza di errori multipli pari.
2. **Internet Checksum (Somma di Controllo a Livello di Trasporto e Rete):**
   * Il mittente suddivide il segmento in parole a 16 bit e calcola la somma a complemento a 1 dei blocchi; il complemento a 1 della somma viene inserito nell'header (campo *Checksum*).
   * Il ricevitore somma tutti i blocchi a 16 bit includendo il campo checksum: se il risultato è una sequenza di soli $1$ (`0xFFFF`), il pacchetto è integro; in caso contrario viene scartato per avvenuta corruzione.

---

## 6. I Protocolli di Posta Elettronica: SMTP, MIME, POP3 e IMAP

L'infrastruttura della posta elettronica si articola su tre componenti architetturali: **User Agent (MUA)**, **Mail Server (MTA)** e **Protocolli di Comunicazione**.

```
[ MUA Alice ] ──(SMTP, porta 25)──► [ Mail Server Alice ]
                                            │
                                    (SMTP, porta 25)
                                            ▼
[ MUA Bob ] ◄──(POP3:110 / IMAP:143)── [ Mail Server Bob ]
```

### 6.1 SMTP (Simple Mail Transfer Protocol - RFC 2821 / RFC 5321)
* **Funzione:** Protocollo di trasmissione orientato all'invio (*push*) dei messaggi di posta elettronica da client a server o tra server di posta intermedi su connessione **TCP (porta 25)**.
* **Caratteristiche:**
  * Protocollo testuale basato su comandi ASCII a 7 bit (`HELO`/`EHLO`, `MAIL FROM:`, `RCPT TO:`, `DATA`, `QUIT`).
  * Utilizza connessioni persistenti: un unico canale TCP può inoltrare più messaggi consecutivi verso il medesimo mail server.
  * A differenza di HTTP (protocollo di tipo *pull*, in cui il ricevente richiede dati), SMTP è strettamente *push* (il mittente spinge i dati verso il destinatario).

### 6.2 Lo Standard MIME (Multipurpose Internet Mail Extensions)
Poiché il protocollo SMTP originale supportava unicamente testo puro codificato in ASCII a 7 bit, lo standard **MIME** (RFC 2045-2049) è stato introdotto per consentire il trasporto sicuro di:
* Testo con caratteri non ASCII (caratteri accentati, alfabeti non latini tramite UTF-8).
* Contenuti multimediali binari (immagini, documenti PDF, allegati audio e video).

#### Header MIME Fondamentali
* `MIME-Version: 1.0`: Dichiara la conformità allo standard.
* `Content-Type`: Specifica il tipo e sottotipo del dato (es. `text/html; charset=UTF-8`, `image/png`, `multipart/mixed`).
* `Content-Transfer-Encoding`: Definisce l'algoritmo impiegato per codificare i byte binari in caratteri ASCII stampabili:
  * **Base64:** Raggruppa blocchi di 3 byte binari (24 bit) e li mappa in 4 caratteri ASCII a 6 bit (espansione del $33\%$ in dimensione).
  * **Quoted-Printable:** Preserva i caratteri ASCII standard codificando solo i caratteri speciali nella forma `=XX` (dove `XX` è il valore esadecimale del byte).

### 6.3 Protocolli di Accesso e Ricezione della Posta (*Pull*)
Mentre l'invio e il routing inter-server avvengono sempre tramite SMTP, il client destinatario deve prelevare i messaggi dalla propria casella (*mailbox*) sul server mediante protocolli dedicati:
* **POP3 (Post Office Protocol v3 - Porta 110 TCP):**
  * Approccio semplice basato sulla modalità "scarica e cancella" (*download-and-delete*) o "scarica e mantieni".
  * *Stateless* tra sessioni distinte; non sincronizza le cartelle o lo stato di lettura tra dispositivi differenti.
* **IMAP (Internet Message Access Protocol - Porta 143 TCP):**
  * Mantiene tutti i messaggi archiviati centralmente sul server.
  * Consente la creazione di cartelle gerarchiche sul server, la sincronizzazione dello stato dei messaggi (*letto*, *risposto*, *bozza*) e l'accesso concorrente da postazioni eterogenee (smartphone, webmail, desktop).

---

## 7. Il Sistema dei Nomi di Dominio (DNS - Domain Name System)

Il **DNS** è un'infrastruttura fondamentale di Internet operante a livello applicativo su protocollo di trasporto **UDP (porta 53)** (con fallback su TCP per trasferimenti di zona o risposte superiori a 512 byte).

### 7.1 Architettura del Database Distribuito e Gerarchico
Il DNS converte i nomi simbolici mnemonici degli host (es. `www.unipg.it`) negli indirizzi IP numerici instradabili (es. `141.250.x.x`). La sua architettura è scalabile e distribuita gerarchicamente per evitare singoli punti di fallimento (*Single Point of Failure*):

```
                      [ Root DNS Servers (13 server logici) ]
                                         │
                 ┌───────────────────────┴───────────────────────┐
                 ▼                                               ▼
     [ TLD Server (.it) ]                            [ TLD Server (.com) ]
                 │                                               │
                 ▼                                               ▼
 [ Authoritative DNS (unipg.it) ]               [ Authoritative DNS (google.com) ]
```

1. **Root DNS Servers:** 13 indirizzi IP logici (replicati globalmente mediante *Anycast*) gestiti da organizzazioni internazionali; indirizzano le query verso i server TLD di competenza.
2. **Top-Level Domain (TLD) Servers:** Gestiscono i domini di primo livello generici (`.com`, `.org`, `.net`, `.edu`) e nazionali (*country code* ccTLD: `.it`, `.fr`, `.de`).
3. **Authoritative DNS Servers (Server Autoritativi):** Ospitano i record ufficiali di risoluzione per i domini di una specifica organizzazione o azienda.
4. **Local DNS Server (Default Resolver):** Server DNS fornito dall'ISP residenziale o aziendale a cui l'host inoltra direttamente tutte le query di risoluzione.

### 7.2 Tipologie di Risoluzione DNS: Iterativa vs Ricorsiva
* **Query Ricorsiva:** Il client delega interamente al server interrogato il compito di ottenere la risposta completa, attendendo il risultato finale.
* **Query Iterativa:** Il server interrogato risponde direttamente con l'indirizzo IP del server DNS di livello successivo da contattare, demandando al resolver locale l'onere di proseguire la catena di risoluzione.

### 7.3 Struttura dei Resource Record (RR)
I dati nel database DNS sono formalizzati come quartine `(Name, Value, Type, TTL)`:
* **Tipo `A`:** Associa un hostname al suo indirizzo IPv4: `(sito.com, 192.0.2.1, A, 3600)`.
* **Tipo `AAAA`:** Associa un hostname al suo indirizzo IPv6.
* **Tipo `NS` (*Name Server*):** Specifica il nome del server DNS autoritativo responsabile per il dominio specificato nel campo `Name`.
* **Tipo `CNAME` (*Canonical Name*):** Definisce un alias rispetto al nome canonico reale: `(www.server.com, server-principale.com, CNAME, 3600)`.
* **Tipo `MX` (*Mail Exchange*):** Specifica il server di posta elettronica di riferimento per il dominio.
* **TTL (*Time to Live*):** Tempo di persistenza in secondi del record all'interno della cache dei resolver prima della sua invalidazione.

---