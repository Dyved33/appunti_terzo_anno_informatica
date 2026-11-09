# La posta elettronica: SMTP, MIME, S/MIME, PEC e DKIM

## Invio di un messaggio: il percorso SMTP

Un messaggio di posta segue questa catena:

**MUA** (Message User Agent, il client di posta dell'utente) invia il messaggio al **MSA** (Mail Submission Agent) tramite SMTP (submission, solitamente porta 587). L'MSA lo passa a un **MTA** (Message Transfer Agent), che può inoltrarlo attraverso altri MTA via SMTP finché non raggiunge l'MTA del destinatario. L'MTA finale consegna il messaggio al **MDA** (Mail Delivery Agent), che lo deposita nella message store; il destinatario lo legge con il proprio MUA tramite IMAP o POP.

**Protocolli di accesso:** POP3 (*Post Office Protocol*, TCP 110) è semplice: l'utente si autentica con username e password e può scaricare (*retrieve*) e cancellare (*delete*) i messaggi. IMAP (*Internet Message Access Protocol*, TCP 143) è più complesso, offre un'autenticazione più forte e funzioni aggiuntive.

![[slide-04-04.png|300]]

L'architettura della posta Internet è definita da **RFC 5598** (*Internet Mail Architecture*) e si basa su due mondi: il *user world* (i MUA degli utenti) e il *transfer world* (il *Message Handling Service*, MHS, composto dagli MTA). Il MHS accetta un messaggio da un utente e lo consegna a uno o più altri utenti, creando un ambiente virtuale di scambio MUA-to-MUA. Ogni dominio amministrativo di posta (*Administrative Management Domain*, ADMD) — per esempio un dipartimento con un mail relay locale, l'IT di un'azienda o un ISP — può avere politiche operative e decisioni basate sulla fiducia diverse.

<div style="display: flex; justify-content: center;">
  <img src="slide-03-03.png" width="500">
</div>

*Osservazione:* SMTP si occupa solo del trasporto tra server; non definisce come il messaggio è strutturato internamente (compito di MIME) né come viene autenticato o protetto (compito di S/MIME, DKIM, PEC).

SMTP (*Simple Mail Transfer Protocol*, RFC 821 del 1982, oggi RFC 5321) incapsula un messaggio di posta in una busta e lo inoltra attraverso molti MTA da origine a destinazione. È un protocollo client-server basato su testo: il client (mittente) contatta il server (next-hop recipient), invia una serie di comandi ASCII per descrivere il messaggio da inviare e poi trasmette il messaggio stesso; il server risponde con un codice di ritorno per ogni comando.

![[slide-07-07.png|300]]

Nell'esempio, il client apre la sessione con `HELO`, indica mittente e destinatari con `MAIL FROM` e `RCPT TO`, poi invia il messaggio con `DATA`. Il server rifiuta `Green` con `550 No such user here`, ma accetta `Jones` e `Brown` con `250 OK`. Il corpo termina con `<CRLF>.<CRLF>` e la sessione con `QUIT`.

## MIME

**MIME** (Multipurpose Internet Mail Extensions) consente di allegare al messaggio contenuti non testuali: immagini, GIF, audio, video, applicativi binari, e messaggi composti da più parti (formato *mixed*). Senza MIME la posta elettronica trasporterebbe solo testo ASCII puro.

MIME estende il framework RFC 5322 ed è definito dalle RFC 2045-2049. Un messaggio di posta si considera composto da una *busta* (le informazioni necessarie alla trasmissione e alla consegna) e dai *contenuti* (l'oggetto da consegnare al destinatario); lo standard RFC 5322 si applica solo ai contenuti. La specifica MIME include:

- cinque nuovi campi di intestazione che possono essere inclusi nell'header RFC 5322, fornendo informazioni sul corpo del messaggio;
- una serie di formati di contenuto che standardizzano rappresentazioni per la posta elettronica multimediale;
- *transfer encodings*, cioè trasformazioni che convertono qualsiasi formato di contenuto in una forma protetta da alterazioni da parte del sistema di posta.

I cinque campi di intestazione MIME sono:

- **MIME-Version:** indica che il messaggio è conforme alle RFC 2045 e 2046.
- **Content-Type:** descrive i dati contenuti nel corpo con sufficiente dettaglio perché l'agente utente del destinatario possa scegliere l'agente o il meccanismo appropriato per rappresentarli.
- **Content-Transfer-Encoding:** indica il tipo di trasformazione usata per rappresentare il corpo del messaggio in modo accettabile per il trasporto postale.
- **Content-ID:** identifica univocamente le entità MIME in contesti multipli.
- **Content-Description:** una descrizione testuale dell'oggetto contenuto nel corpo.

I formati di contenuto MIME (tabella 8.1 del libro) distinguono tra *content type* e *content subtype* (per esempio `text/plain`, `text/html`, `image/jpeg`, `application/pdf`, `audio/basic`, `video/mpeg`, `message/rfc822`, `multipart/mixed`). I *transfer encodings* (tabella 8.2 del libro) permettono di rappresentare dati binari in ASCII stampabile: *7-bit*, *quoted-printable* e *base64* (ogni gruppo di tre ottetti di dati binari è mappato in quattro caratteri ASCII).

**Forme canonica e nativa:** molti sistemi di posta accettano solo blocchi di testo ASCII. S/MIME (e in generale MIME) offrono il servizio di convertire un flusso binario grezzo a 8 bit in un flusso di caratteri ASCII stampabili attraverso la *7-bit encoding*, tipicamente basata su Base64.

Un messaggio MIME ha due possibili forme di rappresentazione. La *canonical form* è il formato standardizzato per l'uso tra sistemi: l'intero corpo, incluso il contenuto out-of-band come le lunghezze dei record e gli attributi dei file, viene convertito in una forma canonica universale, e la conversione può riguardare il set di caratteri, l'audio o la compressione. La *native form* è invece il formato peculiare del sistema locale: il corpo è creato nel formato nativo, con il set di caratteri nativo e le convenzioni locali di fine riga.

<div style="display: flex; justify-content: center;">
  <img src="slide-14-14.png" width="500">
</div>

> [!example] Esempio di messaggio MIME multipart:
> Un messaggio `multipart/mixed` usa un *boundary* univoco per separare le parti: una parte `text/plain` (testo semplice), una parte `image/jpeg` (immagine binaria codificata in base64) e, opzionalmente, una parte `message/rfc822` (un messaggio inoltrato). Il preambolo prima del primo boundary è ignorato dai lettori che comprendono il formato multipart.

## Minacce alla posta elettronica

La posta elettronica è esposta a diverse minacce (tabella 8.3 del libro):

- **Alterazione dei dati:** un messaggio viene modificato durante il transito.
- **Usurpazione di identità:** un mittente si finge un altro (spoofing dell'indirizzo `Da:`).
- **Inquinamento della cache:** inserimento di record falsi nei server DNS o di posta.
- **Aggiornamenti non autorizzati:** modifica non autorizzata dei file di zona o dei dati di posta.

Le minacce si classificano in quattro categorie: *authenticity-related* (accesso non autorizzato al sistema di posta), *integrity-related* (modifica non autorizzata del contenuto), *confidentiality-related* (divulgazione non autorizzata di informazioni sensibili) e *availability-related* (impedimento dell'invio e della ricezione).

Le contromisure combinano STARTTLS (che cifra la connessione SMTP), cifratura, firme digitali, autenticazione del dominio (SPF, DKIM, DMARC) e protezione dell'infrastruttura DNS (DNSSEC, DANE).

## S/MIME

**S/MIME** (Secure/Multipurpose Internet Mail Extensions) è un protocollo di sicurezza per la posta elettronica che aggiunge firma digitale e cifratura ai messaggi MIME. Si basa sulla crittografia a chiave pubblica e su certificati rilasciati da un ente certificatore (CA).

**Firma digitale:** il mittente calcola l'hash del testo del messaggio e lo cifra con la propria chiave privata. Il destinatario verifica la firma con la chiave pubblica del mittente, contenuta nel certificato. Se la verifica riesce, il destinatario è sicuro dell'identità del mittente e dell'integrità del messaggio (non ripudio).

Nella pratica (slide del libro), l'autenticazione è fornita tramite firma digitale: si usa più comunemente RSA con SHA-256. Il mittente genera un messaggio, SHA-256 produce un digest di 256 bit, il digest viene cifrato con RSA usando la chiave privata del mittente e allegato al messaggio insieme alle informazioni identificative del firmatario. Il destinatario usa RSA con la chiave pubblica del mittente per decifrare e recuperare il digest, genera un nuovo digest del messaggio e li confronta: se coincidono, il messaggio è accettato come autentico.

**Cifratura:** il messaggio viene cifrato con una chiave simmetrica casuale (*content-encryption key*) usata una sola volta per quel messaggio; la chiave stessa viene cifrata con la chiave pubblica RSA del destinatario e allegata al messaggio. Il destinatario usa la propria chiave privata per recuperare la content-encryption key e decifrare il messaggio. Più comunemente si usa AES con chiave a 128 bit in modalità CBC.

**Compatibilità:** per rispettare la restrizione dei sistemi di posta che accettano solo blocchi ASCII, S/MIME converte il flusso binario a 8 bit in caratteri ASCII stampabili tramite 7-bit encoding (tipicamente Base64).

**Compressione:** S/MIME offre la possibilità di comprimere un messaggio, risparmiando spazio in trasmissione e archiviazione. La compressione può essere applicata in qualsiasi ordine rispetto a firma e cifratura, con le linee guida RFC 5751: la compressione di dati binari cifrati è scoraggiata (non comprimerebbero significativamente), mentre i dati cifrati in Base64 potrebbero trarne beneficio; se si usa un algoritmo di compressione lossy con firma, occorre comprimere prima e firmare dopo.

**Content type S/MIME:**
- *envelopedData:* si genera una chiave di sessione pseudorandom per un algoritmo simmetrico (RC2/40 o triple DES), per ogni destinatario si cifrava la chiave di sessione con la chiave pubblica RSA del destinatario, si prepara un blocco *RecipientInfo* con l'identificatore del certificato della chiave pubblica del destinatario, si cifrava il contenuto del messaggio con la chiave di sessione.
- *signedData:* si seleziona un algoritmo di digest del messaggio (SHA o MD5), si calcola il digest del contenuto da firmare, si cifra il digest con la chiave privata del firmatario e si prepara un blocco *SignerInfo* che contiene il certificato della chiave pubblica del firmatario, l'identificatore dell'algoritmo di digest, l'identificatore dell'algoritmo usato per cifrare il digest e il digest cifrato.

I content type sono definiti nella RFC 5652 (*Cryptographic Message Syntax*): *Data* (il contenuto MIME interno, che può essere incapsulato in SignedData, EnvelopedData o CompressedData), *SignedData*, *EnvelopedData* e *CompressedData* (per la compressione).

<div style="display: flex; justify-content: center;">
  <img src="slide-24-24.png" width="500">
</div>

Il flusso illustrato è: il mittente firma e poi cifra il messaggio; il destinatario prima lo decifra con la propria chiave privata, poi verifica la firma con la chiave pubblica del mittente.

**Certificato S/MIME:** associa l'indirizzo email del titolare a una coppia di chiavi pubblica/privata. Viene rilasciato da un ente certificatore dopo aver verificato l'identità del richiedente. La chiave privata resta sul client del mittente (concetto analogo alle *chiavi SSH private e pubbliche* [[Approfondimento chiavi SSH private e pubbliche|chiavi SSH]]); la chiave pubblica (nel certificato) viene distribuita ai destinatari.

La gestione delle chiavi S/MIME richiede all'utente di: generare coppie di chiavi (Diffie-Hellman, DSS e, preferibilmente, RSA con lunghezza 768-1024 bit, mai inferiore a 512 bit), registrare la propria chiave presso una CA per ottenere un certificato X.509, e mantenere un elenco locale di certificati per verificare le firme in ingresso e cifrare i messaggi in uscita.

**Servizi S/MIME avanzati (RFC 2634):** oltre a digital signature e message encryption, S/MIME offre compressione e servizi avanzati come le ricevute firmate (*signed receipts*, prova di consegna), le etichette di sicurezza (*security labels*, informazioni sulla sensibilità del contenuto per il controllo degli accessi), il *secure mailing list* (una mailing list agent applica la cifratura per destinatario) e i *signing certificates* (legano il certificato del mittente alla firma tramite l'attributo signing certificate).

**Servizi S/MIME:**
- Digital signature
- Message encryption
- Compression

> [!info] Flusso S/MIME semplificato:
> Il client del mittente (MUA) firma il messaggio con la chiave privata S/MIME e lo passa all'MTA di invio. L'MTA può aggiungere una firma DKIM con la propria chiave privata. Il messaggio viaggia via SMTP fino all'MTA del destinatario, che lo consegna al MDA. Il MUA del destinatario verifica la firma S/MIME con la chiave pubblica del mittente e, se il messaggio è cifrato, lo decifra con la propria chiave privata.

## PEC

**PEC** (Posta Elettronica Certificata) è un sistema solo italiano che garantisce l'integrità del messaggio, l'autenticazione del mittente e la ricevuta di consegna con valore legale (equiparata a una raccomandata con ricevuta di ritorno).

La PEC non garantisce a priori l'integrità del contenuto scritto dal mittente: garantisce che l'email inviata non venga alterata durante il trasferimento da provider a provider, ma non garantisce che l'email scritta dal mittente non sia stata alterata nel percorso tra il mittente e il provider del mittente.

**Confronto con S/MIME:**
- S/MIME richiede un certificato da un ente certificatore e garantisce confidenzialità (cifratura) oltre che autenticità e integrità.
- PEC garantisce integrità, autenticazione e prova di consegna con valore legale, ma non offre necessariamente cifratura end-to-end del contenuto.
- S/MIME è uno standard internazionale; PEC è un servizio nazionale italiano.

> [!important] All'esame: ricordare che PEC ha valore legale di ricevuta di consegna, mentre S/MIME è uno standard tecnico di sicurezza basato su certificati e chiavi pubblica/privata. Secondo l'Art. 21 del D.Lgs n°82 del 7 marzo 2005, il documento informatico sottoscritto con firma digitale qualificata ha efficacia legale: un'email firmata digitalmente con S/MIME può essere utilizzata in tribunale.

## DKIM

**DKIM** (DomainKeys Identified Mail) è un protocollo di autenticazione delle email (Internet Standard proposto, RFC 6376). Il server di posta del mittente firma ogni messaggio in uscita con una chiave privata associata al dominio. La chiave pubblica corrispondente viene pubblicata nel DNS del dominio come record TXT. Il server del destinatario recupera la chiave pubblica dal DNS e verifica la firma: se è valida, il messaggio è davvero inviato da quel dominio e non è stato alterato durante il trasporto.

DKIM è progettato per essere trasparente all'utente finale: il messaggio è firmato con la chiave privata del dominio amministrativo da cui ha origine (non con la chiave privata del singolo mittente, come invece fa S/MIME). La firma copre tutto il contenuto del messaggio e alcune intestazioni RFC 5322. DKIM non è implementato nei programmi client (MUA), quindi l'utente non deve compiere alcuna azione e si applica a tutta la posta dei domini che collaborano. Permette ai mittenti corretti di provare di aver inviato un dato messaggio e impedisce ai falsari di spacciarsi per mittenti validi.

DKIM firma il corpo dell'email e un insieme di intestazioni importanti (es. il campo `Da:`), impedendo lo spoofing dell'indirizzo del mittente. A differenza di S/MIME, che firma il contenuto con la chiave dell'origine, DKIM valida il *domain name* piuttosto che l'indirizzo IP da cui il messaggio proviene.

*Collegamento:* la firma DKIM si aggiunge al messaggio insieme alla firma S/MIME: il messaggio può essere sia firmato S/MIME (con la chiave privata del mittente) che firmato DKIM (con la chiave privata del dominio di invio).

La RFC 4686 (*E-mail Threats*) distingue tre livelli di minaccia: finanziariamente motivati (frode), spam professionale o di massa (imprese commerciali che inviano per conto terzi) e basso livello (invio di email indesiderate).

## Come si ottiene un certificato S/MIME?

Si richiede a un ente certificatore (CA) fornendo i propri dati e l'indirizzo email da certificare. La CA verifica l'identità del richiedente e rilascia un certificato che associa l'email a una coppia di chiavi pubblica/privata. La chiave privata viene installata sul client di posta del titolare (o su *ssh-agent*/portachiavi di sistema); il certificato con la chiave pubblica viene condiviso con i destinatari per verificare le firme e cifrare i messaggi diretti.

Esistono certificati S/MIME gratuiti, per esempio tramite il portale di Actalis (`extrassl.actalis.it`).

> [!warning] Attenzione: non confondere S/MIME con PEC. S/MIME protegge il contenuto del messaggio (firma e cifratura), PEC certifica l'avvenuta consegna con valore legale.

## Complementi dal libro di testo

Il capitolo 8 del libro di testo (*Electronic Mail Security*) copre l'architettura della posta Internet (RFC 5598, *user world* e *transfer world*, ADMD), i formati MIME (RFC 5322 per i contenuti, RFC 2045-2049 per MIME, i cinque campi di intestazione, i content type e i transfer encoding), le minacce e le mitigazioni, S/MIME e PGP. S/MIME si basa sulla *Cryptographic Message Syntax* (RFC 5652) con i content type Data, SignedData, EnvelopedData e CompressedData; usa RSA con SHA-256 per la firma e AES-128 CBC per la cifratura, con la content-encryption key cifrata con la chiave pubblica del destinatario; gestisce i certificati X.509 tramite CA e offre servizi avanzati come le ricevute firmate, le etichette di sicurezza, le mailing list sicure e i signing certificates (RFC 2634). PGP offre funzionalità equivalenti ma si differenzia per la certificazione delle chiavi (web of trust invece delle CA) e per la distribuzione delle chiavi. SP 800-177 raccomanda S/MIME piuttosto che PGP per la maggiore fiducia nel sistema CA di verifica delle chiavi pubbliche.


