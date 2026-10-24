# Fondamenti di sicurezza informatica e protezione dei sistemi

> [!info] Informazioni sul corso:
> - **Testo di riferimento:** William Stallings, *Network Security Essentials: Applications and Standards*.
> - **Modalità d'esame:** prova orale vertente sugli argomenti trattati a lezione e sui capitoli corrispondenti del testo di riferimento.

## Definizioni e concetti fondamentali

<u>La **sicurezza** in senso generale è definibile come l'assenza di rischio, pericolo o minaccia. In ambito informatico il concetto si specializza nella protezione attiva e preventiva delle risorse digitali.</u>

*Sicurezza informatica:* l'insieme delle misure, delle tecnologie e delle procedure volte a prevenire o proteggere le risorse hardware, software e le informazioni da accessi non autorizzati, alterazioni, sottrazioni o distruzione.

*Definizione formale di computer sicuro:* un sistema di elaborazione si definisce sicuro se e solo se è accessibile ed utilizzabile esclusivamente da entità legittimamente autorizzate:

$$\text{Computer Sicuro} \iff \text{Accessibile solo a soggetti autorizzati}$$

In altri termini un computer è sicuro quando esegue fedelmente e unicamente ciò per cui è stato progettato, consentendone l'operatività solo a chi ne ha il diritto.

> [!important] Il principio di non-assolutezza della sicurezza:
> Un sistema informatico **non è mai sicuro al 100% in senso permanente**. La sicurezza è un processo dinamico e contingente: un sistema considerato inattaccabile ieri può risultare vulnerabile oggi o domani a causa della scoperta di nuove vulnerabilità (es. exploit *zero-day*), dell'evoluzione delle tecniche di attacco o dell'aumento della potenza di calcolo a disposizione degli attaccanti.

> [!info] Ridisegno architetturale e sicurezza:
> La sicurezza non è un componente applicabile a posteriori (*add-on*), ma una proprietà trasversale che coinvolge tutti i livelli architetturali, dall'hardware al software applicativo fino alle procedure umane. Per rendere un sistema intrinsecamente sicuro sarebbe spesso necessario un **completo ridisegno architetturale**, operazione complessa e raramente praticabile a causa dei vincoli di retrocompatibilità, dei costi e dei tempi di sviluppo.

## Le proprietà di sicurezza

La sicurezza informatica si articola storicamente attorno alla **Triade CIA**, a cui la moderna teoria della sicurezza affianca ulteriori dimensioni critiche.

**Triade CIA:**

1. **Confidenzialità (*Confidentiality*):** solo soggetti autorizzati possono accedere ai dati, alle comunicazioni e alle risorse di sistema.
2. **Integrità (*Integrity*):** informazioni, software e configurazioni restano corretti e completi; alterazioni, manomissioni e cancellazioni non autorizzate vengono impedite.
3. **Disponibilità (*Availability*):** sistemi, reti e informazioni sono accessibili e operativi quando un utente o servizio autorizzato ne ha bisogno.

**Proprietà estese:**

- **Autenticità (*Authenticity*):** capacità di verificare e accertare con certezza la genuinità di una comunicazione, di un documento o l'identità dichiarata da un'entità mittente.
- **Tracciabilità e imputabilità (*Accountability / Non-Repudiation*):** capacità di correlare in modo univoco e non contestabile ogni singola operazione compiuta nel sistema al soggetto specifico che l'ha eseguita, impedendo a chiunque di negare le proprie azioni.
- **Possesso o controllo (*Possession / Control*):** capacità del legittimo proprietario di esercitare il pieno controllo logico e fisico sui propri dati e sulle infrastrutture.
- **Utilità (*Utility*):** garanzia che le informazioni conservino la loro forma utile e fruibile: dati cifrati la cui chiave di decifratura è andata perduta rimangono confidenziali e integri, ma perdono totalmente la loro utilità.

## Il modello IAAA

Il controllo degli accessi poggia su quattro pilastri logici distinti ma interconnessi:

1. **Autenticazione (*Authentication*):** verifica delle credenziali o delle prove fornite da un'entità. Può usare username e password, certificati digitali, token OTP o dati biometrici.
2. **Identificazione (*Identification*):** associazione di un account all'identità reale della persona. Può avvenire, per esempio, tramite documento, SPID o verifica notarile.
3. **Autorizzazione (*Authorization*):** definizione dei privilegi dell'utente autenticato. Stabilisce quali risorse può leggere, modificare o eseguire.
4. **Tracciabilità e accounting (*Auditing & Accountability*):** registrazione delle azioni degli utenti, per *verificare chi fa cosa*, tramite registri di audit e log immutabili.

```
[ Identificazione / Anagrafica ] 
              ↓
  [ Autenticazione (Credenziali) ] → [ Autorizzazione (Policy & ACL) ] → [ Accounting (Log & Audit) ]
```

> [!info] Autenticazione vs identificazione:
> Nei sistemi informatici l'**autenticazione** precede la verifica operativa dei permessi: un utente fornisce credenziali, come username e password o un token, per autenticare la propria sessione prima che il sistema ne verifichi i diritti o ne colleghi formalmente l'identità.

> [!example] Autenticazione senza identificazione
> Esistono molteplici scenari pratici in cui un sistema effettua un'autenticazione valida senza procedere all'identificazione nominale della persona fisica:
> - **Blockchain e criptovalute:** le transazioni vengono autenticate mediante firma crittografica con chiave privata senza richiedere l'identità anagrafica del firmatario, garantendo pseudoanonimato.
> - **Badge e token di accesso fisico anonimi:** biglietti elettronici, gettoni o badge numerati validano il diritto di ingresso, autenticando il titolo, senza identificare l'individuo.
> - **Credenziali anonime e Zero-Knowledge Proofs (ZKP):** protocolli che consentono di dimostrare di possedere un attributo valido, per esempio essere maggiorenne o iscritto a un servizio, senza rivelare la propria identità.

## Ambiti di difesa e fasi del piano di sicurezza

La protezione di un'organizzazione o infrastruttura richiede un approccio difensivo su molteplici livelli.

**I livelli di protezione:**

- **Physical security (sicurezza fisica):** barriere e controlli per regolare e impedire l'accesso fisico non autorizzato a locali server, rack, cablaggi e postazioni di lavoro.
- **Operational / procedural security (sicurezza operativa e procedurale):** definizione e adozione di policy aziendali, standard operativi, procedure di gestione degli incidenti e piani di continuità del business (*business continuity*).
- **Personnel security (sicurezza del personale):** formazione e sensibilizzazione degli utenti contro attacchi di ingegneria sociale (*phishing*, *pretexting*), controllo delle referenze e gestione delle deleghe.
- **System security (sicurezza di sistema):** applicazione del principio del minimo privilegio, gestione rigorosa delle Access Control List (ACL), disabilitazione dei servizi superflui (*hardening*) e analisi dei log.
- **Network security (sicurezza di rete):** firewall, apparati IDS/IPS, segmentazione del traffico, routing sicuro e filtraggio dei pacchetti.

**Le fasi del piano di sicurezza:** un piano di sicurezza organico struttura la difesa in cinque stadi temporali e operativi.

1. **Risk avoidance (evitamento del rischio):** scelte architetturali o di business che eliminano l'esposizione al rischio. Per esempio, si può scollegare da Internet un sistema industriale SCADA che non necessita di una connessione permanente.
2. **Deterrence (deterrenza):** rendere visibili le misure difensive, il monitoraggio e le sanzioni previste, per scoraggiare i potenziali attaccanti.
3. **Prevention (prevenzione):** bloccare i tentativi di intrusione con firewall, cifratura, autenticazione forte e antivirus.
4. **Detection (rilevamento):** individuare violazioni o anomalie in corso tramite IDS (*Intrusion Detection System*), SIEM e monitoraggio del traffico.
5. **Reaction (reazione e ripristino):** avviare le procedure di risposta all'incidente (*incident response*), contenere la minaccia e ripristinare i servizi da backup integri (*disaster recovery*). Comprende anche la conservazione delle prove digitali per eventuali procedimenti legali (*digital forensics*).

## Soluzioni tecnologiche e contromisure

1. **Pianificazione e segmentazione della rete:**
   - utilizzo di apparati di rete adeguati (router, switch layer 3/gestiti);
   - suddivisione della rete in zone con differenti livelli di fiducia e sicurezza, per esempio VLAN separate e creazione di una **DMZ, *demilitarized zone*,** per isolare i server pubblici dalla rete interna.
2. **Integrità applicativa e hardening:**
   - adozione di metodologie di sviluppo sicuro per ridurre al minimo i bug nel codice sorgente (*secure coding*, analisi statica e dinamica del codice);
   - verifica puntuale e hardening delle configurazioni dei sistemi operativi e dei server.
3. **Controllo e filtraggio dei flussi di traffico:**
   - utilizzo di apparati firewall (*packet filter*, *stateful inspection*, *application firewall*) e *router screening* per ispezionare, filtrare e bloccare il traffico anomalo da e verso l'esterno.
4. **Crittografia e canali sicuri:**
   - applicazione di algoritmi e protocolli crittografici per cifrare i dati prima della loro trasmissione su canali non protetti: **SSH** per l'amministrazione remota sicura, **TLS/SSL** per il traffico web, **PGP/GPG** per email e file, **VPN** con IPsec/OpenVPN per tunnel cifrati.

## Le funzioni hash

Una **funzione hash** $h$ trasforma un messaggio di lunghezza arbitraria in una stringa di lunghezza fissa, il **digest**. Le proprietà richieste sono: la resistenza alla preimmagine (*one-way*: da $h(m)$ non si ricava $m$), la resistenza alla seconda preimmagine e la resistenza alle collisioni (due messaggi diversi non devono produrre lo stesso digest).

Non serve una chiave: per questo l'hash non è cifratura, non è reversibile e non fornisce riservatezza. Nelle password l'hash non basta, perché l'attaccante può risalire al valore originale provando tutti gli input possibili: si usa quindi un **salt**, stringa casuale unica per utente che si antepone alla password nel calcolo dell'hash e rende inutili le tabelle di hash precomputate (*rainbow tables*).

L'**HMAC** (RFC 2104) combina una funzione hash con una chiave segreta e garantisce autenticità e integrità nello stesso tempo.

## La crittografia simmetrica e asimmetrica

**Cifratura simmetrica:** la stessa chiave segreta, o chiave condivisa, cifra e decifra. Offre prestazioni elevate ed è adatta a grossi volumi di dati, ma soffre del **problema della distribuzione delle chiavi**: ogni coppia di comunicanti deve condividere una chiave senza che questa viaggi in chiaro.

| | Simmetrica | Asimmetrica |
| :--- | :--- | :--- |
| Chiavi | una sola, segreta e condivisa | coppia: pubblica e privata |
| Velocità | molto elevata | molto più lenta |
| Uso tipico | cifrare i dati, le chiavi di sessione | scambio chiavi, firme digitali |
| Problema | distribuzione delle chiavi | costo computazionale |

**Cifratura asimmetrica:** si cifra con una chiave pubblica e si decifra con la corrispondente chiave privata, che resta segreta al possessore. Ogni utente genera la propria coppia: risolve la distribuzione delle chiavi, perché basta pubblicare la chiave pubblica su un canale che non richiede riservatezza.

Il protocollo **TLS** usato da HTTPS combina le due: un cifrario asimmetrico autentica il server e concorda la chiave di sessione, poi il traffico vero e proprio è cifrato con un cifrario simmetrico.

## La firma digitale e la PKI

La **firma digitale** realizza l'autenticità, l'integrità e la non ripudiabilità senza cifrare nulla. Il mittente calcola l'hash del documento e lo cifra con la propria chiave privata; il destinatario la decifra con la chiave pubblica del mittente e ricalcola l'hash: se i due digest coincidono, il documento è integro e la firma non può essere stata prodotta da altri.

La **PKI** (*public key infrastructure*) è l'infrastruttura che distribuisce e certifica le chiavi pubbliche, evitando che ogni utente debba fidarsi direttamente di ogni altro:

- la **CA** (*certification authority*) è l'autorità di certificazione che emette e firma i certificati;
- il **certificato X.509** lega una chiave pubblica ai dati di identità del titolare (soggetto, emittente, validità, uso previsto) ed è firmato dalla CA;
- la **catena di fiducia** collega un certificato, emesso da un'*authority* subordinate, alla CA radice, che è considerata attendibile a priori perché installata nel sistema;
- la **revoca** tramite **CRL** (*certificate revocation list*) o **OCSP** dichiara non più valido un certificato prima della scadenza.

> [!warning] Le credenziali memorizzate
> La sicurezza di una password dipende da come è conservata: nel database si salva sempre l'hash con salt, non la password in chiaro; l'autenticazione consiste nel ricalcolare l'hash e confrontarlo. Un database rubato che contiene solo hash con salt non permette il login diretto.

## Le principali minacce e i controlli associati

Le violazioni si classificano in due grandi famiglie: **attacchi passivi**, che tentano di ottenere informazioni senza alterare i dati, come l'intercettazione e il traffico analizzato (*traffic analysis*), e **attacchi attivi**, che modificano i dati o le risorse, come il mascheramento (*masquerading*), il replay e il *denial of service*.

| Minaccia | Meccanismo | Controllo tipico |
| :--- | :--- | :--- |
| Attacco passivo | ascolto del traffico, analisi del traffico | cifratura dei canali, TLS |
| Attacco attivo | inserimento o alterazione di messaggi | integrità con hash e firma digitale |
| Attacco a testo noto | ricostruzione della chiave da testo cifrato e noto | crittografia autenticata (AEAD), non ECB con chiave corta |
| Forza bruta su password | tentativi esaustivi su tutte le combinazioni | password lunghe, salt, limitazione dei tentativi, MFA |
| Phishing e ingegneria sociale | furto di credenziali tramite fiducia umana | formazione, verifica del dominio, MFA |
| Malware | virus, worm, trojan, ransomware, rootkit | antivirus, aggiornamenti, backup, principio del minimo privilegio |
| Denial of service | saturazione delle risorse | rate limiting, firewall, IDS/IPS |
| SQL injection | codice malevolo iniettato in una query SQL | query parametrizzate (cfr. [[Lezione 5-Il linguaggio SQL, il DDL e PostgreSQL]]) |
| Attacco man-in-the-middle | intercettazione e alterazione fra le due parti | autenticazione del certificato, TLS con pinning dove possibile |

## Computer security, cybersecurity e information assurance

La disciplina della protezione dei dati e dei sistemi si articola in tre definizioni complementari.

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

- **Computer security:** misure e controlli tecnici volti a garantire la confidenzialità, l'integrità e la disponibilità degli asset di un sistema di elaborazione, inclusi componenti hardware, software, firmware e informazioni durante l'elaborazione, la memorizzazione e la trasmissione.
- **Cybersecurity:** la capacità di proteggere, difendere e mitigare gli attacchi informatici condotti attraverso il ciberspazio (reti pubbliche, Internet e infrastrutture interconnesse).
- **Information assurance (IA):** insieme integrato di controlli tecnici, organizzativi e manageriali progettati per garantire la confidenzialità, il controllo del possesso, l'integrità, l'autenticità, la disponibilità e l'utilità delle informazioni e dei sistemi informativi lungo tutto il loro ciclo di vita.

> [!info] Sintesi:
> - Un computer è sicuro se è accessibile e utilizzabile solo a soggetti autorizzati, e nessun sistema è sicuro al 100% in senso permanente.
> - Le proprietà di sicurezza sono la triade CIA più autenticità, tracciabilità, possesso e utilità; il modello IAAA è autenticazione, identificazione, autorizzazione e accounting.
> - La difesa si articola su cinque livelli, dal fisico al network, e il piano di sicurezza segue avoidance, deterrence, prevention, detection e reaction.
> - L'hash è irreversibile e senza chiave: serve all'integrità, non alla riservatezza; per le password si usa con salt, e l'HMAC aggiunge autenticazione.
> - Simmetrica: una chiave condivisa, veloce, ma con problema della distribuzione. Asimmetrica: coppia pubblica/privata, lenta, risolve la distribuzione e permette firma digitale e PKI con certificati X.509 e revoca; il TLS le combina entrambe.
> - Ogni minaccia passiva o attiva ha un controllo associato, dalla cifratura dei canali alla firma dei dati, dal phishing alle query SQL parametrizzate.
> - Computer security, cybersecurity e information assurance sono tre definizioni complementari: la seconda dentro la terza, che comprende la prima.
