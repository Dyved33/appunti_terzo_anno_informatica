# Posta elettronica

## Architettura del servizio e componenti

*Definizione:* il servizio di posta elettronica (o *e-mail*) è un'infrastruttura asincrona di scambio messaggi basata sulla cooperazione tra due moduli software distinti: il Mail User Agent e il programma di trasporto.

<u>La gestione dei messaggi è ripartita tra l'interfaccia client lato utente e il demone di trasporto in esecuzione sui server</u>:
- **Mail User Agent (MUA):** programma applicativo (es. Thunderbird, Pine, Elm, Eudora, Outlook) che costituisce l'interfaccia verso l'utente finale:
  - *Composizione:* creazione del messaggio conforme alla sintassi RFC 822 / RFC 5322 tramite editor di testo; gestione della rubrica e dell'indirizzario; compilazione automatica delle intestazioni (*Subject*, destinatario in risposta).
  - *Visualizzazione:* separazione dell'intestazione (*header*) dal corpo (*body*); interpretazione e salvataggio degli allegati; invocazione di visualizzatori di sistema per formati specifici (PDF, Postscript, PNG); archiviazione e catalogazione in cartelle.
  - *Eliminazione:* rimozione manuale o automatica tramite filtri dei messaggi per evitare il superamento delle quote disco sulla *mailbox*.
- **Mail Transfer Agent (MTA) / Programma di trasporto:** demone di sistema (es. Sendmail, Postfix, Qmail, MMDF) trasparente all'utente finale:
  - *Trasferimento:* riceve il messaggio dal MUA, interpreta l'indirizzo di destinazione e apre una sessione verso l'host remoto di destinazione o verso un nodo intermedio (*Mail Relay*).
  - *Ricezione e instradamento:* ascolta e scambia posta tramite il protocollo Simple Mail Transfer Protocol (SMTP, RFC 821).
  - *Gestione alias:* risoluzione di sinonimi locali per mappare un indirizzo virtuale su un utente reale o su un insieme di destinatari (mailing list prototipali).
  - *Notifica di errore:* generazione automatica di avvisi al mittente in caso di mancato recapito per congestione, host irraggiungibile o errori sintattici (*bounce message*).

*Formato degli indirizzi:* sintassi nella forma `user@host.domain` oppure `user@domain`. Nel secondo caso il recapito presuppone la risoluzione nel [[Lezione 9-DNS|DNS]] del record **MX (Mail Exchange)** associato al dominio, con definizione di priorità numeriche per configurare server primari e host di backup secondari geograficamente distribuiti.

### Mail Relay e abuso antispam

*Definizione:* il Mail Relay = funzione che consente a un server MTA di accettare e inoltrare temporaneamente messaggi destinati a un dominio terzo gestito da un altro host.

- Se il server di posta primario è sovraccarico o temporaneamente disconnesso, un gestore secondario designato memorizza i messaggi in transito (*spool*) e li inoltra non appena il nodo principale torna operativo.
- Nelle prime versioni di Sendmail (fino alla v8) il relaying era aperto indiscriminatamente (*open relay*), consentendo agli *spammer* di iniettare messaggi contraffatti mascherando l'IP di origine. Dalla versione 9 gli host autorizzati al relay devono essere espressamente dichiarati nelle tabelle di configurazione.

### Configurazione di Sendmail

La configurazione nativa di Sendmail è storicamente gestita tramite il preprocessore macro **M4** nel file `/etc/mail/sendmail.mc`:

```m4
VERSIONID(`@(#)version.m4 8.9.1.1 (Berkeley) 7/2/98')
OSTYPE(linux)
MASQUERADE_AS(`miodominio.it')
define(`confCONNECTION_RATE_THROTTLE', `2')
define(`confMAX_DAEMON_CHILDREN', `200')
define(`confMAX_MESSAGE_SIZE', `5000000')
define(`confMIN_FREE_BLOCKS', `100')
FEATURE(`smrsh')
FEATURE(`use_cw_file')
FEATURE(`always_add_domain')
FEATURE(`relay_entire_domain')
FEATURE(`relay_based_on_MX')
FEATURE(`access_db', `hash /etc/mail/access')
```

I parametri e i file di supporto regolano l'instradamento e le policy di sicurezza:
- `/etc/mail/access`: tabella di controllo accessi indicizzata ad hash per filtrare accessi da domini, indirizzi o sottoreti IP:
  ```text
  cyberspammer.com   550 We don't accept mail from spammers
  spammer@aol.com    550 We don't accept mail from spammers
  150.10.1.13        REJECT
  151.20.0.0         OK
  193.133.108.0      OK
  210.205.1.2        550 We don't accept mail from spammers
  ```
- `/etc/mail/relay-domains`: elenco dei domini per cui il server accetta di eseguire il relaying (dominio principale, host secondari come `193.12.12.212`, domini per l'accesso POP3 come `libero.it`, `iol.it`, `tiscalinet.it`, `tin.it`, `tim.it`, `email.it`, e virtual host `vhost1.it`, `vhost2.it`).
- `/etc/mail/sendmail.cw`: elenco dei domini e virtual host locali per cui la macchina accetta la posta in ingresso considerandosi destinazione finale (`miodominio.it`, `vhost1.it`, `vhost2.it`).
- `/etc/aliases`: tabella di corrispondenza per gli alias di sistema gestiti dal comando `newaliases`:
  - `nobody: /dev/null`: scarto dei messaggi.
  - `MAILER-DAEMON: postmaster@mydom.it`: alias obbligatorio per notifiche di sistema.
  - `postmaster`, `abuse`, `cert`, `netman`: indirizzi amministrativi standard previsti da RFC 822.
  - `staff: joe@mydom.it, charlie@mydom.it, jane@mydom.it`: lista di distribuzione ad aggregazione di indirizzi.

## Posta Elettronica Certificata (PEC)

*Definizione:* sistema di trasmissione telematica che fornisce valore legale equiparato alla raccomandata con ricevuta di ritorno.

*Quadro normativo italiano:*
- DPR 11 febbraio 2005 n. 68 (regole generali per la formazione, trasmissione e validazione temporale della PEC) e Circolare CNIPA 24 novembre 2005 n. 49.
- Codice dell'Amministrazione Digitale (CAD, D.Lgs. 82/2005 modificato e integrato dal D.Lgs. 235/2010).
- D.Lgs. 185/2008 convertito in Legge 2/2009 (art. 16): obbligo di comunicazione della PEC al registro delle imprese per le nuove società, entro un anno per i professionisti iscritti a un ordine, entro tre anni per le società già costituite e per tutte le Pubbliche Amministrazioni.
- Ambiti d'uso raccomandati: trasmissione di atti verso la PA, gare d'appalto, convocazione di giunte e consigli societari, comunicazioni ufficiali intra-aziendali e invio dei cedolini dello stipendio ai lavoratori dipendenti.

<u>Una comunicazione ha valore legale di posta certificata solo se entrambe le caselle (mittente e destinatario) sono abilitate PEC</u>. Se una delle due parti usa una casella tradizionale, il sistema degrada fornendo certificazioni parziali e omettendo la ricevuta di avvenuta consegna.

*Obblighi e garanzie dei gestori:*
- **Conservazione dei log:** obbligo di registrazione e conservazione di tutti gli eventi di trasmissione per un periodo minimo di **30 mesi**, opponibili a terzi in giudizio.
- **Riferimento temporale certo:** marcatura oraria sincronizzata costantemente con gli istituti ufficiali che garantiscono l'ora esatta.
- **Canali cifrati obbligatori:** accesso e trasporto vincolati esclusivamente a protocolli crittografati sicuri (`HTTPS` per webmail, `SMTPS`, `SMTP STARTTLS`, `POP3S`, `IMAPS`).
- **Autenticazione forte del mittente:** credenziali verificate o certificati digitali per impedire lo spoofing dell'identità.

*Flusso di trasmissione e ricevute:*
1. **Accettazione:** il mittente invia il messaggio al proprio provider PEC. Il provider valida l'identità e rilascia la *ricevuta di accettazione* (firmata digitalmente dal gestore in formato testo e XML), che attesta data, ora e destinatari.
2. **Busta di trasporto:** il provider del mittente incapsula il messaggio originale, gli allegati e i metadati di spedizione all'interno di una *busta di trasporto* firmata digitalmente con la propria chiave privata per garantirne l'integrità.
3. **Inoltro tra gestori:** la busta di trasporto viene trasferita in modo sicuro al provider PEC del destinatario.
4. **Consegna:** il provider del destinatario deposita la busta di trasporto nella casella dell'utente e genera istantaneamente la *ricevuta di avvenuta consegna*.
5. **Ricevuta di consegna:** inviata al mittente, firmata dal provider del destinatario; contiene l'orario esatto di immissione nella casella e l'intero messaggio recapitato in allegato, costituendo prova legale sia del recapito temporale che dell'intero contenuto trasmesso.

## Formato dei messaggi e standard MIME

### RFC 822 e RFC 5322

La struttura originaria di un messaggio email (RFC 822, aggiornato da RFC 5322) prevede una netta separazione tra intestazione (*header*) e corpo del testo (*body*), separati da una riga vuota (`<CRLF>`):
- **Intestazioni standard obbligatorie e opzionali:**
  - `Received:` catena di tracciamento inserita in testa da ogni MTA attraversato (server, indirizzo IP, timestamp).
  - `Message-ID:` stringa alfanumerica globalmente univoca generata dal primo MTA (es. `<B00002222000@mailhost.dom.it>`).
  - `Date:` marca temporale di composizione conforme a RFC (es. `Wed, 23 Oct 2000 10:22:00 +0100`).
  - `From:` indirizzo di posta dell'utente mittente.
  - `To:` destinatario primario.
  - `Cc:` copia conoscenza (*Carbon Copy*).
  - `Bcc:` copia conoscenza nascosta (*Blind Carbon Copy*, rimossa dall'header prima dell'invio ai destinatari ordinari).
  - `Subject:` oggetto sintetico del messaggio.

*Limiti strutturali di RFC 822:* il formato nativo imponeva l'uso esclusivo di caratteri ASCII a 7 bit (standard ANSI X3.4) e una lunghezza massima per riga di 1000 caratteri. Questo impediva il trasporto diretto di caratteri accentati (italiano, francese, tedesco), alfabeti non latini (greco, cirillico, ebraico), scritture ideografiche (cinese, giapponese) e file binari non strutturati a record (immagini, audio, eseguibili).

### Standard MIME

*Definizione:* estensione MIME (*Multipurpose Internet Mail Extensions*, RFC 1341, RFC 1521, RFC 2045-2049) del formato dei messaggi che consente il trasporto di dati arbitrari e multimediali senza alterare il funzionamento dei server di trasporto SMTP.

L'adozione di MIME ha richiesto modifiche solo al software MUA (client), lasciando inalterati i protocolli di trasporto intermedi:
- `MIME-Version:` indica la versione dello standard supportata (tipicamente `1.0`).
- `Content-Description:` descrizione testuale in chiaro della natura del contenuto.
- `Content-ID:` identificatore univoco del segmento MIME.
- `Content-Transfer-Encoding:` meccanismo di codifica impiegato per mappare i dati negli intervalli accettati dal trasporto.
- `Content-Type:` tipologia del contenuto strutturata nella forma `tipo/sottotipo`.

*Meccanismi di codifica dei dati:*
- **7bit / 8bit / binary:** flusso non modificato, applicabile dove il canale garantisce la trasparenza binaria senza filtri a 7 bit.
- **Quoted-Printable (RFC 2045):** ottimizzata per messaggi prevalentemente testuali con rari caratteri speciali o accentati:
  - I caratteri ASCII compresi tra 33 e 126 restano invariati.
  - I caratteri con codice superiore a 127 vengono rappresentati dal carattere `=` seguito da due cifre esadecimali (es. la lettera `è` in ISO-8859-1 diventa `=E8`).
  - Righe limitate a un massimo di 76 caratteri; le interruzioni di riga fittizie sono segnalate con un `=` a fine riga (*soft line break*).
- **Base64 (RFC 2045):** impiegata per allegati e file binari:
  - Divide il flusso binario in gruppi di 24 bit (3 byte) e li ricodifica in 4 caratteri da 6 bit ciascuno.
  - L'alfabeto di codifica è composto da 64 caratteri sicuri: `A-Z`, `a-z`, `0-9`, `+`, `/`, con il carattere `=` impiegato come *padding* di coda per completare i gruppi di 3 byte.
  - Produce righe troncate a massimo 76 caratteri. Introduce un sovraccarico (*overhead*) di dimensione pari a circa il **33%** (rapporto 4:3).

### Classificazione MIME-Types

| Tipo principale | Sottotipi notevoli | Significato e riferimenti RFC |
|---|---|---|
| `text` | `plain`, `richtext`, `html`, `xml`, `sgml` | Informazioni testuali formattate o grezze (RFC 2046, RFC 2854, RFC 3023) |
| `image` | `gif`, `jpeg`, `png` | Immagini raster statiche (RFC 2045, RFC 2046) |
| `audio` | `basic`, `mpeg` | Flussi audio digitali |
| `video` | `mpeg`, `quicktime` | Flussi video multimediali |
| `application` | `octet-stream`, `postscript`, `pdf` | Dati binari generici da salvare su disco o passare a programmi esterni |
| `message` | `rfc822`, `partial`, `external-body` | Messaggio email incapsulato o frammentato |
| `multipart` | `mixed`, `alternative`, `parallel`, `digest` | Contenitore di parti multiple delimitate da una stringa sentinella (*boundary*) |

## Protocollo SMTP

*Definizione:* SMTP (*Simple Mail Transfer Protocol*, standardizzato da RFC 821, RFC 2821 e RFC 5321) è il protocollo applicativo per il trasferimento affidabile ed efficiente di messaggi di posta elettronica su connessioni di trasporto [[Lezione 6-UDP e TCP e routing|TCP]] orientate alla connessione (porta server standard **25**, porta di *submission* client **587**).

<u>Il protocollo opera secondo un modello *push* a passi rigorosamente bloccanti</u>: il mittente (*SMTP-sender*) invia un comando testuale per volta e resta in attesa del codice numerico di risposta del ricevente (*SMTP-receiver*) prima di emettere il passo successivo.

### Comandi SMTP fondamentali

| Comando | Sintassi | Descrizione operativa |
|---|---|---|
| `HELO` / `EHLO` | `HELO <domain>` | Apertura iniziale della sessione; identifica l'host mittente (`EHLO` abilita le estensioni ESMTP) |
| `MAIL FROM:` | `MAIL FROM:<reverse-path>` | Inizia una transazione; specifica il mittente e definisce la rotta di ritorno per gli errori |
| `RCPT TO:` | `RCPT TO:<forward-path>` | Specifica il destinatario del messaggio; ripetibile per destinatari multipli |
| `DATA` | `DATA` | Richiede l'invio del corpo e delle intestazioni del messaggio; termina con `<CRLF>.<CRLF>` |
| `RSET` | `RSET` | Aborta la transazione in corso ripristinando lo stato neutro senza chiudere la sessione |
| `VRFY` | `VRFY <string>` | Verifica l'esistenza di una casella locale senza trasmettere posta |
| `EXPN` | `EXPN <string>` | Espande un alias o una mailing list restituendo gli indirizzi dei singoli membri |
| `NOOP` | `NOOP` | Operazione nulla; impiegata per verificare che la connessione sia attiva e azzerare i timer |
| `HELP` | `HELP [<topic>]` | Richiede al server informazioni sui comandi implementati |
| `QUIT` | `QUIT` | Notifica la chiusura della sessione; chiude il canale TCP |

### Codici di risposta numerici

Le risposte del server sono composte da un codice a 3 cifre seguito da una stringa descrittiva:
- **Codici 2xx (Successo):**
  - `211`: stato del sistema o risposta al comando di aiuto.
  - `214`: messaggio di aiuto per l'operatore umano.
  - `220`: servizio pronto (*Service ready*), inviato subito dopo l'apertura della connessione TCP.
  - `221`: chiusura del canale di trasmissione in corso.
  - `250`: azione richiesta completata con successo (*OK*).
  - `251`: utente non locale; il messaggio verrà inoltrato all'indirizzo forward specificato.
- **Codici 3xx (Azione intermedia):**
  - `354`: autorizzazione all'invio dei dati del messaggio (*Start mail input; end with `<CRLF>.<CRLF>`*).
- **Codici 4xx (Errore temporaneo / transitorio - il client deve ritentare più tardi):**
  - `421`: servizio non disponibile; chiusura immediata del canale.
  - `450`: azione non eseguita; mailbox temporaneamente occupata (*busy*).
  - `451`: azione interrotta per errore locale di elaborazione.
  - `452`: memoria di sistema insufficiente; quota disco o spazio di spool esaurito.
- **Codici 5xx (Errore permanente / fatale - il messaggio non può essere consegnato):**
  - `500`: errore sintattico nel comando; comando non riconosciuto o riga troppo lunga.
  - `501`: errore sintattico nei parametri o negli argomenti del comando.
  - `502`: comando valido ma non implementato dal server.
  - `503`: sequenza errata dei comandi (es. invocare `DATA` prima di `MAIL FROM:` e `RCPT TO:`).
  - `504`: parametro del comando non implementato.
  - `550`: mailbox inesistente, non trovata o accesso negato per policy antispam.
  - `551`: utente non locale; tentativo di inoltro rifiutato.
  - `552`: invio abortito per superamento della dimensione massima allocata al messaggio.
  - `553`: nome della casella non valido o non consentito (errore sintattico nell'indirizzo).
  - `554`: transazione fallita in modo irreversibile.

### Esempi di sessioni SMTP

*1. Transazione completa di invio:*
```text
R: 220 mail.unipg.it Simple Mail Transfer Service Ready
S: HELO alpha.ing.unipg.it
R: 250 mail.unipg.it
S: MAIL FROM:<studente@alpha.ing.unipg.it>
R: 250 OK
S: RCPT TO:<docente@unipg.it>
R: 250 OK
S: DATA
R: 354 Start mail input; end with <CRLF>.<CRLF>
S: From: studente@alpha.ing.unipg.it
S: To: docente@unipg.it
S: Subject: Ricevimento
S:
S: Buongiorno professore, confermo la presenza al ricevimento.
S: <CRLF>.<CRLF>
R: 250 OK
S: QUIT
R: 221 mail.unipg.it Service closing transmission channel
```

*2. Notifica di mancato recapito generata dal server (Bounce):*
In caso di errore irreversibile (`550 No Such User`), il server genera un nuovo messaggio inserendo mittente nullo `MAIL FROM:<>` per prevenire loop infiniti di errore tra server:
```text
S: MAIL FROM:<>
R: 250 OK
S: RCPT TO:<utente@mittente.it>
R: 250 OK
S: DATA
R: 354 Start mail input; end with <CRLF>.<CRLF>
S: Subject: Mail System Problem - Undeliverable Mail
S:
S: Impossibile consegnare il messaggio a destinatario@remoto.it:
S: 550 No such user here.
S: <CRLF>.<CRLF>
R: 250 OK
```

*3. Verifica utente (VRFY):*
```text
S: VRFY Smith
R: 251 User not local; will forward to <Smith@USC-ISIQ.ARPA>
S: VRFY Jones
R: 550 String does not match anything.
S: VRFY Jones
R: 551 User not local; please try <Jones@USC-ISIQ.ARPA>
S: VRFY Gourzenkyinplatz
R: 553 User ambiguous.
```

*4. Espansione mailing list e alias (EXPN):*
```text
S: EXPN Example-People
R: 250-Jon Postel <Postel@USC-ISIF.ARPA>
R: 250-Fred Fonebone <Fonebone@USC-ISIQ.ARPA>
R: 250 Sam Q. Smith <SQSmith@USC-ISIQ.ARPA>
S: EXPN Executive-Washroom-List
R: 550 Access Denied to You.
```

*5. Intestazioni Return-Path e tracciamento Received:*
Nel corpo della busta consegnata ogni server intermedio aggiunge in cima una riga `Received:` con timestamp locale; il server di destinazione finale sintetizza il `Return-Path:` prelevandolo dall'argomento specificato nel comando `MAIL FROM:`:
```text
Return-Path: <studente@alpha.ing.unipg.it>
Received: from mx.unipg.it by imap.unipg.it; 27 Oct 2024 15:27:39 +0100
Received: from alpha.ing.unipg.it by mx.unipg.it; 27 Oct 2024 15:15:13 +0100
Date: 27 Oct 2024 15:14:00 +0100
From: studente@alpha.ing.unipg.it
To: docente@unipg.it
Subject: Progetto
```

## Meccanismi di autenticazione del server e contrasto allo spoofing

Il protocollo SMTP originario non prevede alcuna autenticazione del campo `MAIL FROM:` o delle intestazioni, consentendo a qualunque client di falsificare l'identità del mittente. L'autenticazione dell'origine viene demandata a record speciali pubblicati nel [[Lezione 9-DNS|DNS]]:
- **Sender Policy Framework (SPF):** record `TXT` nel DNS del dominio mittente che elenca gli indirizzi IP o i blocchi di rete autorizzati a spedire email per conto di quel dominio. Il server ricevente verifica che l'indirizzo IP del socket TCP corrisponda a quelli autorizzati nel record SPF.
- **DomainKeys Identified Mail (DKIM):** il server mittente firma crittograficamente con chiave privata un hash dell'header e del corpo del messaggio, inserendo la firma nell'header `DKIM-Signature`. Il server ricevente scarica la corrispondente chiave pubblica dal record `TXT` del DNS ed esegue la verifica crittografica di integrità e provenienza.
- **DMARC (Domain-based Message Authentication, Reporting and Conformance):** unifica e coordina SPF e DKIM imponendo l'allineamento dei domini (*domain alignment*) e specificando al server ricevente la politica da applicare in caso di fallimento (`none`, `quarantine`, `reject`), generando report periodici di telemetria per il dominio titolare.

## Protocolli di accesso alla casella di posta: POP3 e IMAP

Per consultare e prelevare i messaggi memorizzati sullo spool del server sono impiegati due protocolli applicativi dedicati: Post Office Protocol versione 3 (POP3) e Internet Message Access Protocol versione 4 (IMAP4).

### Protocollo POP3

*Definizione:* POP3 (*Post Office Protocol version 3*, RFC 1225, RFC 1939) è un protocollo applicativo client-server in ascolto sulla porta standard **TCP 110** (o **995** per POP3S con crittografia SSL/TLS), progettato per prelevare i messaggi dal Message Transport System (MTS) e scaricarli sulla macchina locale dell'utente.

*Macchina a stati della sessione POP3:*
1. **AUTHORIZATION:** dopo il banner di benvenuto del server, il client si autentica scambiando credenziali:
   - `USER <nomeutente>`: specifica l'account.
   - `PASS <password>`: invia la parola chiave associata (in chiaro nella configurazione base).
2. **TRANSACTION:** il client interroga la casella ed esegue le operazioni di lettura:
   - `STAT`: restituisce il numero totale di messaggi presenti e la loro dimensione complessiva in ottetti.
   - `LIST [msg]`: elenca l'identificatore progressivo e la dimensione dei singoli messaggi.
   - `RETR <msg>`: richiede il trasferimento dell'intero messaggio contrassegnato dal numero specificato.
   - `DELE <msg>`: marca un messaggio come cancellato sul server.
   - `LAST`: riporta il numero dell'ultimo messaggio a cui si è fatto accesso.
   - `NOOP`: comando nullo di test.
   - `RSET`: rimuove le marcature di cancellazione applicate durante la sessione corrente.
3. **UPDATE:** attivata dal comando `QUIT`: il server elimina fisicamente dalla casella i messaggi marcati con `DELE`, rilascia il blocco (*lock*) sul file della mailbox e chiude la connessione TCP.

```text
C: USER mrose
S: +OK mrose is a real hoopy frood
C: PASS secret
S: +OK mrose's maildrop has 2 messages (320 octets)
C: STAT
S: +OK 2 320
C: LIST
S: +OK 2 messages (320 octets)
S: 1 120
S: 2 200
S: .
C: RETR 1
S: +OK 120 octets
<... corpo del messaggio ...>
S: .
C: DELE 1
S: +OK message 1 deleted
C: QUIT
S: +OK maildrop server closing connection
```

### Protocollo IMAP4

*Definizione:* IMAP4 (*Internet Message Access Protocol version 4*, RFC 1064 per v2, RFC 2060 / RFC 3501 per IMAP4rev1) è un protocollo applicativo in ascolto sulla porta standard **TCP 143** (o **993** per IMAPS), sviluppato nel 1986 presso la Stanford University per consentire l'accesso dinamico e interattivo a mailbox remote centralizzate.

<u>A differenza di POP3, IMAP4 sincronizza lo stato della mailbox mantenendo i messaggi archiviati sul server</u>, supportando accessi concorrenti da parte di molteplici postazioni e client mobili.

*Macchina a stati della sessione IMAP:*
1. **Non-Authenticated State:** connessione TCP aperta con saluto iniziale del server (`OK greeting`). Il client deve autenticarsi tramite comando `LOGIN` o `AUTHENTICATE`. Se il server rifiuta la connessione invia `BYE` e chiude; se la connessione è pre-autenticata a livello di trasporto entra direttamente nello stato Authenticated con banner `PREAUTH`.
2. **Authenticated State:** utente riconosciuto. Il client seleziona una specifica cartella (*mailbox*) con il comando `SELECT` oppure `EXAMINE` (modalità in sola lettura).
3. **Selected State:** cartella attiva. Il client esegue lettura, ricerche e manipolazione dei flag. Il comando `CLOSE` o un comando `SELECT`/`EXAMINE` fallito riporta la sessione allo stato Authenticated.
4. **Logout State:** comando `LOGOUT`, chiusura della connessione o arresto del server (`BYE`).

*Autenticazione avanzata (es. Kerberos V4):*
```text
S: * OK KerberosV4 IMAP4rev1 Server
C: A001 AUTHENTICATE KERBEROS_V4
S: + AmFYig==
C: BAcAQU5EUkVXLkNNVS5FRFUAOCAsho84kLN3/IJmrMG+...
S: + or//EoAADZI=
C: DiAF5A4gA+oOIALuBkAAmw==
S: A001 OK Kerberos V4 authentication successful
```

- **Flag di sistema associati ai messaggi:**
  - `\Seen`: messaggio visualizzato o letto dall'utente.
  - `\Answered`: messaggio a cui è stata inviata una risposta.
  - `\Flagged`: messaggio contrassegnato per attenzione urgente o speciale.
  - `\Deleted`: messaggio marcato per la cancellazione definitiva, che avverrà all'esecuzione del comando `EXPUNGE`.
  - `\Draft`: messaggio salvato come bozza incompleta.
  - `\Recent`: messaggio recapitato di recente nella casella; la prima sessione che lo visualizza trova il flag attivo, le sessioni successive no.
- **Capacità avanzate di ricerca e prelievo mirato:**
  - Download selettivo: prelievo dei soli header (`FETCH 16 RFC822.HEADER`) o di singoli rami di allegati MIME senza scaricare l'intero messaggio.
  - Comandi di ricerca lato server: `ALL`, `ANSWERED`, `UNANSWERED`, `DELETED`, `UNDELETED`, `DRAFT`, `UNDRAFT`, `FLAGGED`, `UNFLAGGED`, `RECENT`, `SEEN`, `UNSEEN`, `NEW` (equivalente a `RECENT UNSEEN`), `OLD` (equivalente a `NOT RECENT`), `BEFORE <data>`, `ON <data>`, `SINCE <data>`, `SENTBEFORE`, `SENTON`, `SENTSINCE`, `FROM <str>`, `TO <str>`, `CC <str>`, `BCC <str>`, `SUBJECT <str>`, `BODY <str>`, `TEXT <str>`, `HEADER <field> <str>`, `LARGER <n>`, `SMALLER <n>`, `UID <set>`, `NOT <key>`, `OR <key1> <key2>`.

### Confronto architetturale: POP3 vs IMAP4

| Proprietà | POP3 | IMAP4 |
|---|---|---|
| **Porta di ascolto TCP** | 110 (POP3), 995 (POP3S) | 143 (IMAP4), 993 (IMAPS) |
| **Modello operativo** | Scarica e rimuove dal server (*Store and Download*) | Manipolazione e sincronizzazione sul server (*Store and Remote View*) |
| **Accesso multi-dispositivo** | Inefficiente; rischia conflitti di lock e disallineamento | Nativo ed efficiente con sincronizzazione dei flag di lettura |
| **Organizzazione cartelle** | Monolitica (solo casella di arrivo locale) | Gerarchica su server (creazione, rinomina, spostamento cartelle) |
| **Uso della banda** | Scarica sempre l'intero messaggio e gli allegati | Download modulare on-demand di header o singoli allegati MIME |

## Sicurezza della posta elettronica: PGP e GnuPG

*Definizione:* Pretty Good Privacy (PGP, ideato nel 1991 da Phil Zimmermann) e la sua implementazione standard libera **GnuPG** (GNU Privacy Guard, conforme a OpenPGP, RFC 4880) forniscono servizi crittografici end-to-end per confidenzialità, autenticazione dell'origine e non ripudio delle comunicazioni email.

### Modello a crittografia ibrida

Per coniugare la sicurezza degli algoritmi a chiave pubblica con l'efficienza computazionale della crittografia simmetrica, PGP adotta un'architettura ibrida:
- **Cifratura del messaggio:**
  1. Il mittente calcola l'impronta crittografica del testo in chiaro tramite funzione di hash (**MD5** o SHA).
  2. Genera una chiave simmetrica monouso valida solo per la transazione corrente (*session key*), prodotta da un generatore pseudo-casuale basato su eventi fisici (es. movimenti del mouse, intervalli di digitazione).
  3. Il testo del messaggio viene compresso tramite algoritmo ZIP (Ziv-Lempel) e cifrato con algoritmo a chiave simmetrica (es. **IDEA** o AES) usando la *session key*.
  4. La *session key* viene a sua volta cifrata usando la **chiave pubblica del destinatario** (algoritmo RSA).
  5. Il pacchetto risultante (messaggio cifrato simmetricamente + chiave di sessione cifrata) viene codificato in formato testuale Base64 per la trasmissione su canali di posta conformi a MIME.
- **Decifratura da parte del destinatario:**
  1. Il destinatario riceve il blocco e usa la propria **chiave privata** per decifrare la *session key*.
  2. Con la *session key* in chiaro ottenuta decifra il corpo del messaggio.
  3. Decomprime il testo ed esegue la verifica dell'hash per accertarsi che il contenuto non sia stato manomesso.
- **Firma digitale:** il mittente calcola l'hash del messaggio, lo cifra con la propria **chiave privata** e lo allega. Chiunque sia in possesso della chiave pubblica del mittente può decifrare la firma e confrontarla con l'hash ricalcolato, verificando l'autenticità della provenienza.

### Gestione dei portachiavi e Web of Trust

Le chiavi crittografiche sono memorizzate localmente in due file distinti:
- `pubring`: anello delle chiavi pubbliche (*public keyring*) appartenenti ai corrispondenti noti.
- `privring`: anello delle chiavi private (*private keyring*) dell'utente, ciascuna protetta da una *passphrase*.

*Web of Trust (Rete di fiducia):* a differenza delle infrastrutture a chiave pubblica tradizionali (PKI) basate su Autorità di Certificazione (CA) gerarchiche centralizzate, OpenPGP utilizza un modello di fiducia distribuito. Gli utenti firmano reciprocamente le rispettive chiavi pubbliche per certificarne l'associazione all'identità reale del proprietario, scambiando le chiavi tramite server pubblici (*keyserver*).

*Integrazione nei client:*
- Configurazione nei MUA (es. Thunderbird o SeaMonkey) storicamente mediante plugin dedicati come **Enigmail**.
- Una volta generate le chiavi, la chiave pubblica viene caricata su un keyserver pubblico; per verificare la corretta configurazione e la risposta del sistema si utilizzano indirizzi di test automatici (es. `edward-it@fsf.org` della Free Software Foundation).

*Varianti software e licenze:*
- Versione commerciale: distribuita inizialmente da PGP Inc e successivamente da Symantec.
- Standard aperto e implementazione libera: **OpenPGP** (standard aperto IETF, RFC 4880) e **GnuPG** (sviluppato nell'ambito del progetto GNU sotto licenza libera GNU GPL).

*Contesto storico e profili legali:*
- Agli inizi degli anni '90 il governo degli Stati Uniti avviò un'indagine giudiziaria contro Phil Zimmermann per presunta violazione delle restrizioni sull'esportazione di materiale bellico (a causa della robustezza delle chiavi crittografiche a livello militare), contestando inoltre l'uso dell'algoritmo RSA protetto all'epoca da brevetto commerciale.
- **Accordo di Wassenaar:** trattato internazionale siglato da diversi paesi che impone restrizioni sull'esportazione di tecnologie dual-use e crittografia forte (con restrizioni severe adottate in passato da vari stati, tra cui la Francia).
- **Progetto Echelon:** infrastruttura di sorveglianza e intercettazione globale di comunicazioni radio ed elettroniche gestita dall'alleanza anglo-americana (NSA, GCHQ), che ha storicamente accelerato la diffusione popolare della crittografia forte a difesa della riservatezza individuale.

> [!info] Sintesi:
> - Il servizio email separa il client utente (MUA: composizione, visualizzazione, cancellazione) dal server di trasporto (MTA/Sendmail: instradamento, relaying, gestione alias e bounce).
> - La PEC fornisce valore legale tramite ricevute firmate dai gestori (accettazione e avvenuta consegna con messaggio allegato), conservazione trentennale dei log e obbligo di canali sicuri.
> - Lo standard MIME supera i limiti di RFC 822 (testo ASCII a 7 bit) introducendo intestazioni dedicate (`Content-Type`, `Content-Transfer-Encoding`) e codifiche per allegati binari (*base64*, overhead +33%) e testi accentati (*quoted-printable*).
> - SMTP (TCP porta 25/587) è un protocollo *push* a comandi rigidi bloccanti (`HELO`, `MAIL FROM:`, `RCPT TO:`, `DATA`), risposte numeriche (2xx successo, 4xx errore temporaneo, 5xx errore fatale) e autenticazione d'origine via DNS (SPF, DKIM, DMARC).
> - POP3 (porta 110) scarica e svuota la casella locale attraversando le fasi di *Authorization*, *Transaction* e *Update*; IMAP4 (porta 143) gestisce la posta sul server con sincronizzazione concorrente e flag di stato (`\Seen`, `\Answered`, `\Flagged`, `\Deleted`).
> - PGP/GnuPG realizza la posta cifrata tramite crittografia ibrida: compressione, cifratura simmetrica del messaggio con *session key* monouso, cifratura asimmetrica della *session key* con chiave pubblica del destinatario e modello decentralizzato *Web of Trust*.
