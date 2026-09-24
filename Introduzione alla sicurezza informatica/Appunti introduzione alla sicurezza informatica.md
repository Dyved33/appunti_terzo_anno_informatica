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