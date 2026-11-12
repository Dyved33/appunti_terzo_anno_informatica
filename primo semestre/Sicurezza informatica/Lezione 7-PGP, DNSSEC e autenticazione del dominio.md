# PGP, DNSSEC e autenticazione del dominio (SPF, DMARC)

## Installare S/MIME in Thunderbird

Per usare S/MIME con Thunderbird occorre disporre di un certificato S/MIME personale, rilasciato da un ente certificatore (CA) dopo aver verificato l'identità del richiedente e l'indirizzo email da certificare. Il certificato associa l'email a una coppia di chiavi pubblica/privata: la chiave privata resta installata sul client di posta del titolare, mentre il certificato con la chiave pubblica viene condiviso con i destinatari per verificare le firme e cifrare i messaggi diretti.

In Thunderbird si procede così:

1. Si ottiene il certificato S/MIME da una CA (esistono anche certificati gratuiti, per esempio tramite il portale di Actalis) e si scarica il file del certificato, solitamente in formato `.p12` o `.pfx`, che contiene sia la chiave privata sia il certificato.
2. Si apre Thunderbird, si va in *Impostazioni* → *Privacy e sicurezza* → *Certificati* → *Visualizza certificati*.
3. Nella scheda *I tuoi certificati* si importa il file `.p12`/`.pfx`, inserendo la password di protezione della chiave privata scelta al momento del rilascio.
4. Una volta importato, il certificato risulta disponibile per la firma e la cifratura dei messaggi in uscita.
5. Nella composizione di un nuovo messaggio si attivano le opzioni di sicurezza (firma digitale e/o cifratura) dal menu di sicurezza del messaggio; per cifrare un messaggio verso un destinatario è necessario disporre in precedenza del suo certificato pubblico, ottenuto per esempio da un messaggio già firmato da quel destinatario.

La chiave privata deve essere protetta con cura: se viene compromessa, un attaccante può firmare e decifrare messaggi a nome del titolare. Il certificato pubblico, invece, può essere distribuito liberamente ai destinatari.

## Pretty Good Privacy (PGP)

**PGP** (Pretty Good Privacy) è un protocollo di sicurezza per la posta elettronica alternativo a S/MIME, con funzionalità essenzialmente equivalenti (firma digitale e cifratura dei messaggi). È stato creato da Phil Zimmerman e implementato come prodotto rilasciato per la prima volta nel 1991, reso disponibile gratuitamente e divenuto popolare per l'uso personale. Il protocollo PGP iniziale era proprietario e usava alcuni algoritmi di cifratura con restrizioni di proprietà intellettuale.

Le due differenze significative tra S/MIME e OpenPGP riguardano la **certificazione delle chiavi** e la **distribuzione delle chiavi**. S/MIME si affida al sistema delle Certification Authority (CA) e ai certificati X.509; PGP adotta invece un modello di *web of trust*, in cui gli utenti firmano le chiavi pubbliche degli altri utenti che conoscono personalmente, creando una rete di fiducia decentralizzata.

## DNS

Il **DNS** (Domain Name System) è un servizio di lookup directory che fornisce il mapping tra il nome di un host su Internet e il suo indirizzo numerico IP. È essenziale al funzionamento di Internet ed è usato dai MUA e dagli MTA per trovare l'indirizzo del server dell'hop successivo per la consegna della posta.

Il DNS si compone di quattro elementi:

- **Domain name space:** il DNS usa uno spazio dei nomi a struttura ad albero per identificare le risorse su Internet.
- **DNS database:** concettualmente, ogni nodo e foglia nella struttura ad albero dello spazio dei nomi denomina un insieme di informazioni contenute in *resource record* (RR); la collezione di tutti i RR è organizzata in un database distribuito.
- **Name servers:** sono programmi server che detengono informazioni su una porzione della struttura ad albero del dominio e sui RR associati.
- **Resolvers:** sono programmi che estraggono informazioni dai name server in risposta a richieste dei client. Una richiesta tipica del client è per un indirizzo IP corrispondente a un dato nome di dominio.

Il database DNS è gerarchico e distribuito:

- **Variabile profondità della gerarchia dei nomi:** il DNS consente essenzialmente livelli illimitati e usa il punto (.) come delimitatore di livello nei nomi stampati.
- **Database distribuito:** il database risiede in server DNS sparsi su tutta Internet.
- **Distribuzione controllata dal database:** il database DNS è diviso in migliaia di zone gestite separatamente, ciascuna amministrata da amministratori distinti.

Il processo di risoluzione dei nomi prevede query ricorsive e iterative tra il programma utente, il resolver della macchina locale, i name server primari e secondari, con cache e referral. Un solo resolver può interrogare più server per risalire all'autoritativo che detiene il record richiesto.

![[slide-44-44.png|300]]

Lo schema mostra i componenti coinvolti nel flusso DNS: *zone file*, server master e slave, *caching forwarder* e resolver; indica anche gli aggiornamenti dinamici.

<div style="display: flex; justify-content: center;">
  <img src="slide-43-43.png" width="500">
</div>

<div style="display: flex; justify-content: center;">
  <img src="slide-45-45.png" width="500">
</div>

> [!example] Vulnerabilità del DNS:
> Il DNS è soggetto ad attacchi come corruzione dei dati, usurpazione del server master, usurpazione della cache, inquinamento della cache (*cache pollution*) e data spoofing, aggiornamenti non autorizzati e alterazione dei dati di zona. Questi attacchi motivano l'introduzione di DNSSEC.

## DNSSEC

**DNSSEC** (*DNS Security Extensions*) crea un sistema di nomi di dominio sicuro aggiungendo firme crittografiche ai record DNS esistenti. Queste firme digitali vengono memorizzate nei name server DNS insieme a tipi di record più comuni, come A, AAAA, MX, CNAME, ecc. Controllando la firma associata, è possibile verificare che il record DNS richiesto provenga dal suo name server autoritativo e che non sia stato modificato durante il percorso, a differenza di un record falso iniettato in un attacco man-in-the-middle.

DNSSEC:

- fornisce protezione end-to-end attraverso l'uso di firme digitali create dagli amministratori di zona che rispondono e verificate dal software resolver del destinatario;
- evita la necessità di fidarsi dei server di nome intermedi e dei resolver che memorizzano in cache o instradano i record DNS originati dall'amministratore di zona rispondente prima che raggiungano l'origine della query;
- consiste in un insieme di nuovi tipi di resource record e modifiche al protocollo DNS esistente;
- è definito nelle RFC 4033, 4034 e 4035.

Per facilitare la convalida della firma, DNSSEC aggiunge nuovi tipi di record DNS:

- **RRSIG:** contiene una firma crittografica.
- **DNSKEY:** contiene una chiave di firma pubblica.
- **DS:** contiene l'hash di un record DNSKEY.
- **NSEC e NSEC3:** per il denial-of-existence esplicito di un record DNS.
- **CDNSKEY e CDS:** per una zona figlio che richiede aggiornamenti ai record DS nella zona genitore.

Più in dettaglio: RRSIG contiene la firma crittografica calcolata sull'RRSet con la chiave privata della zona; DNSKEY contiene la chiave pubblica usata per verificare la firma; DS (*Delegation Signer*) è il puntatore che permette di costruire la catena di autenticazione dalla zona genitore a quella figlia; NSEC indica il nome successivo nella zona per dimostrare l'assenza di un record.

Il primo passo per proteggere una zona con DNSSEC consiste nel raggruppare tutti i record dello stesso tipo in un insieme di dati detto **RRSet** (*Resource Record Set*). È l'intero RRSet che viene firmato digitalmente, non i singoli record DNS.

Un *resource record* ha la forma `Name TTL class type rdata`: per esempio `www.example.net. 7200 IN A 192.168.10.3`. Un *RRSet* raggruppa i record con lo stesso nome, classe e tipo: per esempio tre record A con indirizzi 192.168.10.3, 10.0.0.3 e 172.25.215.2. DNSSEC firma l'intero RRSet, non i singoli record.

**Autenticità e integrità dei dati:** la crittografia asimmetrica risponde a due esigenze, verificare l'integrità e l'autenticità dei dati tramite le firme e verificare l'autenticità delle firme. L'integrità e l'autenticità dei record si ottengono firmando gli RRSet con la chiave privata della zona; la chiave pubblica DNSKEY serve a verificare i RRSIG. I nodi figlio firmano le proprie zone con la propria chiave privata, mentre l'autenticità della chiave è stabilita dal genitore attraverso la coppia firma/checksum.

La verifica dell'autenticità di un record DNS procede così:

1. si ottiene la *Key Signing Key* (KSK) pubblica della zona con una query DNS (record DNSKEY KSK);
2. si ottiene la firma della *Zone Signing Key* (ZSK) pubblica con una query DNS (record RRSIG DNSKEY ZSK);
3. si verifica la firma dello ZSK con la chiave pubblica dello KSK;
4. dalla chiave pubblica dello KSK si costruisce l'hash che genera il record DS;
5. si ottiene il record DS dalla zona superiore con una query DNS;
6. si confronta il DS contenuto nella zona superiore con l'hash: devono coincidere.

<div style="display: flex; justify-content: center;">
  <img src="slide-50-50.png" width="500">
</div>

Strumenti utili per test e verifica: dnssec-analyzer.verisignlabs.com, zonemaster.iis.se, bind9.net/dns-tools.

## DANE

**DANE** (*DNS-based Authentication of Named Entities*) è un protocollo per vincolare i certificati X.509, comunemente usati per TLS, ai nomi DNS usando DNSSEC. È proposto nella RFC 6698 come modo per autenticare entità client e server TLS senza una Certification Authority (CA). Lo scopo di DANE è sostituire la fiducia nel sistema CA con la fiducia nella sicurezza fornita da DNSSEC. DANE definisce un nuovo tipo di record DNS, **TLSA**, che può essere usato per un metodo sicuro di autenticazione dei certificati SSL/TLS.

## SPF

**SPF** (*Sender Policy Framework*) è il modo standardizzato per un dominio mittente di identificare e affermare i mittenti di posta per un dato dominio. Risolve il problema di qualsiasi host che può usare qualsiasi nome di dominio per i vari identificatori nell'intestazione della posta, non solo per il dominio in cui si trova l'host. È definito nella RFC 7208.

SPF funziona controllando l'indirizzo IP del mittente rispetto alla policy codificata in un qualsiasi record SPF trovato presso il dominio mittente. Il proprietario del dominio crea record DNS che associano il nome di dominio a uno specifico intervallo di indirizzi IP di mittenti autorizzati. È semplice per i destinatari controllare il record TXT SPF nel DNS per confermare che il presunto mittente di un messaggio sia autorizzato a usare quell'indirizzo sorgente e rifiutare la posta che non proviene da un indirizzo IP autorizzato.

Esempio di record SPF per `unipg.it` (query tipo TXT):

```
v=spf1 include:spf.protection.outlook.com include:_spf.cineca.it
 ip4:141.250.196.0/22 ip4:90.147.160.68/32 ip4:141.250.1.0/24
 ip4:141.250.249.224/27 ip4:95.172.90.156 ip4:31.186.254.152
 ip4:141.250.84.198/31 ip4:141.250.84.200/32 ip4:95.172.90.143
 ip4:130.186.7.110 mx -all
```

SPF previene la falsificazione designando un pugno di indirizzi IP da cui le email possono originare per il tuo dominio. Un controllo SPF fallisce se uno spammer invia un messaggio falsificato dal proprio IP, permettendo ai server di trattarlo come spam. È molto facile falsificare l'indirizzo email del mittente ma molto difficile falsificare un indirizzo IP: questo rende SPF molto efficace nel contrastare le falsificazioni di email. SPF controlla il valore `MAIL FROM` nella conversazione della busta SMTP; non controlla l'intestazione `From` nel messaggio effettivo.

## DMARC

**DMARC** (*Domain-based Message Authentication, Reporting, and Conformance*) permette ai mittenti di posta di specificare la policy su come la loro posta dovrebbe essere gestita, i tipi di report che i destinatari possono inviare indietro e la frequenza con cui tali report dovrebbero essere inviati. È definito nella RFC 7489 (marzo 2015) e lavora insieme a SPF e DKIM.

DMARC standardizza come i destinatari di posta eseguono l'autenticazione della posta usando i meccanismi SPF e DKIM. L'autenticazione DMARC si occupa del dominio `From` nell'intestazione del messaggio, come definito nella RFC 5322. DMARC richiede che l'indirizzo `From` corrisponda (sia allineato) con un Identificatore Autenticato da DKIM o da SPF.

Un'email in entrata è considerata "DMARC Aligned" se il nome di dominio dell'intestazione `From` corrisponde al nome di dominio del valore `MAIL FROM` nella busta. Inoltre, controlla se il dominio specificato nell'intestazione `From` corrisponde al nome di dominio specificato nella firma DKIM. Oltre al controllo di alignment, che previene la falsificazione, DMARC fornisce anche un meccanismo per cui i server di posta segnalano le loro scoperte ad altri server su Internet: per esempio, i server di gmail.com e yahoo.com inviano report una volta al giorno spiegando come hanno trattato i messaggi provenienti da un dato dominio.

> [!info] In altre parole:
> SPF verifica che il messaggio provenga da un IP autorizzato per il dominio (controlla la busta SMTP, `MAIL FROM`). DKIM verifica che il messaggio sia firmato dal dominio (controlla la firma crittografica e l'integrità del corpo). DMARC sta sopra entrambi: richiede che il dominio visibile nell'intestazione `From` sia allineato con almeno uno dei due, e aggiunge un sistema di report per monitorare l'efficacia delle policy.

## Argomenti del capitolo 8

Il capitolo 8 del libro di testo (*Electronic Mail Security*) copre l'architettura della posta Internet, i formati MIME, le minacce e le mitigazioni, S/MIME, Pretty Good Privacy (PGP), DNS, DNSSEC, DANE, SPF, DKIM e DMARC. S/MIME e PGP offrono funzionalità essenzialmente equivalenti e si differenziano per certificazione e distribuzione delle chiavi. DNSSEC protegge i record DNS con firme digitali (RRSIG, DNSKEY, DS, NSEC/NSEC3), DANE vincola i certificati X.509 ai nomi DNS senza bisogno di una CA, SPF autorizza gli IP di invio dei messaggi, DKIM firma crittograficamente i messaggi a livello di dominio e DMARC allinea il dominio `From` con SPF/DKIM aggiungendo un sistema di report. Tutte queste estensioni provvedono alla protezione dei trasferimenti su Internet con dati firmati con chiavi pubbliche e all'autenticazione dei messaggi tra name server e resolver.

## Estensioni di sicurezza del DNS

Le estensioni di sicurezza del DNS proteggono i trasferimenti su Internet firmando i dati con chiavi pubbliche: i record DNSSEC sono DNSKEY (chiave pubblica di zona), RRSIG (firma crittografica), DS (Delegation Signer per la catena di autenticazione) e NSEC/NSEC3 (denial-of-existence). La PKI distribuisce chiavi pubbliche per altri protocolli di sicurezza e diversi tipi di certificati.

## Complementi dal libro di testo

Il capitolo 8 del libro di testo (*Electronic Mail Security*) dedica ampio spazio proprio agli argomenti di questa lezione: PGP, DNSSEC, DANE, SPF, DKIM e DMARC. Di seguito si riporta ciò che il libro aggiunge rispetto a quanto già presente negli appunti sopra.

**PGP e il web of trust:** PGP, creato da Phil Zimmerman nel 1991 e oggi standardizzato come OpenPGP (RFC 4880), offre le stesse funzionalità di S/MIME (firma e cifratura) ma si differenzia in due punti. Per la certificazione delle chiavi, S/MIME usa certificati X.509 rilasciati da Certification Authority, mentre in PGP gli utenti firmano le chiavi pubbliche dei contatti che conoscono personalmente, costruendo una rete di fiducia decentralizzata chiamata *web of trust*. Per la distribuzione, PGP non allega la chiave pubblica del mittente a ogni messaggio: il destinatario deve ottenerla separatamente, per esempio dai *key server* pubblici, che però non fanno alcun controllo (non c'è *vetting*), quindi spetta al web of trust decidere se fidarsi di una chiave. Per questo SP 800-177 raccomanda S/MIME piuttosto che PGP, per la maggiore fiducia nel sistema CA di verifica delle chiavi pubbliche.

**DNSSEC:** il libro ricorda che il DNS si compone di quattro elementi — *domain name space*, database, name server e resolver — e che gli MTA lo usano per trovare il server MX del destinatario. DNSSEC protegge i record DNS con firme digitali (RRSIG, DNSKEY, DS, NSEC/NSEC3, CDNSKEY/CDS; RFC 4033-4035), firmando l'intero RRSet anziché i singoli record.

**DANE:** DANE (RFC 6698) vincola i certificati X.509 ai nomi DNS usando il record TLSA, che definisce quattro *usage models*: PKIX-TA (si fida di una CA specifica per autenticare il certificato del servizio), PKIX-EE (si fida di un certificato entità specifico), DANE-TA (il dominio dichiara una propria CA come trust anchor) e DANE-EE (il dominio emette certificati senza coinvolgere una CA esterna). Il campo Selector indica se confrontare l'intero certificato o solo la chiave pubblica, mentre il Matching Type specifica se il confronto è esatto o tramite hash SHA-256/SHA-512. DANE si usa con SMTP su STARTTLS per impedire il downgrade della connessione cifrata, e per S/MIME tramite il record SMIMEA, che associa i certificati ai nomi di dominio.

**SPF, DKIM e DMARC:** SPF (RFC 7208) permette a un dominio di dichiarare, tramite un record TXT DNS, quali IP sono autorizzati a inviare posta per suo conto; il destinatario controlla il record e applica tre regole: se non c'è nessun record SPF si accetta, se il record ha errori di formattazione si accetta, altrimenti si usano i meccanismi e i modificatori del record per decidere. DKIM (RFC 6376) firma crittograficamente il messaggio a nome del dominio firmatario, pubblicando la chiave pubblica nel DNS. DMARC (RFC 7489) sta sopra SPF e DKIM: standardizza come il destinatario esegue l'autenticazione, richiede che il dominio `From` dell'intestazione (RFC 5322) sia allineato con il dominio firmato da DKIM o con il dominio autenticato da SPF, e aggiunge un sistema di report perché SPF e DKIM da soli non dicono al mittente se le sue policy funzionano né se un messaggio senza firma DKIM è autentico o contraffatto.

> [!info] Sintesi:
> - PGP offre firma e cifratura come S/MIME ma usa il web of trust per certificare le chiavi e key server senza vetting per distribuirle.
> - DNSSEC firma gli RRSet DNS (RRSIG, DNSKEY, DS, NSEC/NSEC3) per garantire autenticità e integrità dei record.
> - DANE (TLSA) lega certificati X.509 ai nomi DNS con quattro usage models, evitando il downgrade su STARTTLS.
> - SPF (record TXT) dichiara gli IP autorizzati a inviare posta per un dominio; DKIM (RFC 6376) firma il messaggio a livello di dominio.
> - DMARC (RFC 7489) allinea il dominio From con SPF/DKIM e aggiunge un sistema di report sull'efficacia delle policy.
