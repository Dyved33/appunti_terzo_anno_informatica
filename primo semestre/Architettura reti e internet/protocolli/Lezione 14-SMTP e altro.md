# Posta elettronica: SMTP, POP3, IMAP e PGP

## SMTP — Simple Mail Transfer Protocol

Il trasporto dei messaggi di posta elettronica avviene utilizzando il Simple Mail Transfer Protocol (SMTP), definito nell'RFC 821. Il suo obiettivo è trasferire i messaggi di posta elettronica in modo affidabile e efficiente.

Caratteristica dell'SMTP è la capacità di trasportare mail attraverso diversi ambienti di servizi di trasporto. Un servizio di trasporto fornisce un interprocess communication environment (IPCE). L'invio di messaggi di posta elettronica avviene indipendentemente dal tipo di rete: consiste nello scambio di dati tra due IPCE.

Come risultato di una richiesta di posta dell'utente viene attivato un canale di comunicazione bidirezionale (sul port number 25) tra il server SMTP trasmettitore ed il server SMTP ricevente. Il server SMTP ricevente può essere il destinatario finale o un server intermedio. I comandi SMTP sono generati dal server SMTP trasmettitore ed inviati al server SMTP ricevente. Le risposte SMTP sono generate dal ricevente in risposta ai comandi SMTP ed inviate al trasmettitore.

![[slide_prot14-35.png|500]]

Una volta attivato il canale trasmissivo, l'SMTP-sender invia il comando MAIL indicando colui che invia il mail. Se il ricevente può ricevere mail risponde con OK. Il sender invia il comando RCPT identificando il recipient del mail; se il ricevente può ricevere mail per quel recipient risponde con OK, altrimenti risponde con un codice di reject del recipient (non della sessione mail). I due SMTP server possono scambiarsi diversi recipient. Il server SMTP invia i dati del mail, terminando con una sequenza speciale. Se il receiver interpreta correttamente i dati, risponde con OK. Il dialogo è volutamente a passi bloccanti, uno alla volta.

L'argomento del comando MAIL indica chi manda il mail (crea un reverse-path implementando una return route, sulla quale verranno istradati eventuali messaggi di errore). L'argomento del comando RCPT indica invece chi è il destinatario del mail (crea un forward-path implementando una source route). Quando un messaggio è inviato a più utenti, viene inviata una sola copia per tutti i destinatari di uno stesso host. I comandi di mail hanno una sintassi rigida, così come i codici di errore.

### Comandi SMTP

| Comando | Sintassi |
|:---|:---|
| HELO | `HELO <SP> <domain> <CRLF>` |
| MAIL | `MAIL <SP> FROM:<reverse-path> <CRLF>` |
| RCPT | `RCPT <SP> TO:<forward-path> <CRLF>` |
| DATA | `DATA <CRLF>` |
| RSET | `RSET <CRLF>` |
| SEND | `SEND <SP> FROM:<reverse-path> <CRLF>` |
| SOML | `SOML <SP> FROM:<reverse-path> <CRLF>` |
| SAML | `SAML <SP> FROM:<reverse-path> <CRLF>` |
| VRFY | `VRFY <SP> <string> <CRLF>` |
| EXPN | `EXPN <SP> <string> <CRLF>` |
| HELP | `HELP [<SP> <string>] <CRLF>` |
| NOOP | `NOOP <CRLF>` |
| QUIT | `QUIT <CRLF>` |
| TURN | `TURN <CRLF>` |

![[slide_prot14-38.png|500]]

### Risposte SMTP

| Codice | Significato |
|:---|:---|
| 500 | Syntax error, command unrecognized [This may include errors such as command line too long] |
| 501 | Syntax error in parameters or arguments |
| 502 | Command not implemented |
| 503 | Bad sequence of commands |
| 504 | Command parameter not implemented |
| 211 | System status, or system help reply |
| 214 | Help message [Information on how to use the receiver or the meaning of a particular non-standard command; this reply is useful only to the human user] |
| 220 | Service ready |
| 221 | Service closing transmission channel |
| 421 | Service not available, closing transmission channel [This may be a reply to any command if the service knows it must shut down] |
| 250 | Requested mail action okay, completed |
| 251 | User not local; will forward to |
| 450 | Requested mail action not taken: mailbox unavailable [E.g., mailbox busy] |
| 550 | Requested action not taken: mailbox unavailable [E.g., mailbox not found, no access] |
| 451 | Requested action aborted: error in processing |
| 551 | User not local; please try |
| 452 | Requested action not taken: insufficient system storage |
| 552 | Requested mail action aborted: exceeded storage allocation |
| 553 | Requested action not taken: mailbox name not allowed [E.g., mailbox syntax incorrect] |
| 354 | Start mail input; end with . |
| 554 | Transaction failed |

![[slide_prot14-39.png|500]]

### Ordine dei comandi

Il primo comando deve essere HELO, tale comando può essere riimmesso anche successivamente. Se l'argomento non è accettabile viene ritornato un errore 501 failure. I comandi NOOP, HELP, EXPN, VRFY possono essere utilizzati ovunque nella sessione. I comandi MAIL, SEND, SOML o SAML iniziano una transazione di mail, per l'invio del messaggio. Deve essere seguito da uno o più comandi RCPT e dal comando DATA, nell'ordine. Dopo l'immissione del testo del messaggio deve seguire la sequenza `<CRLF>.<CRLF>`. Una transazione può essere abortita col comando RSET. L'ultimo comando è QUIT, che non può essere usato in nessun altro momento della sessione.

**Esempio di apertura:**
```
R: 220 BBN-UNIX.ARPA Simple Mail Transfer Service Ready
S: HELO USC-ISIF.ARPA
R: 250 BBN-UNIX.ARPA
```

**Esempio di chiusura:**
```
S: QUIT
R: 221 BBN-UNIX.ARPA Service closing transmission channel
```

**Esempio di transazione:**
```
S: MAIL FROM:<Smith@Alpha.ARPA>
R: 250 OK
S: RCPT TO:<Jones@Beta.ARPA>
R: 250 OK
S: RCPT TO:<Green@Beta.ARPA>
R: 550 No such user here
S: RCPT TO:<Brown@Beta.ARPA>
R: 250 OK
S: DATA
R: 354 Start mail input; end with <CRLF>.<CRLF>
S: Blah blah blah...
S: ...etc. etc. etc.
S: <CRLF>.<CRLF>
R: 250 OK
```

**Esempio di inoltro (`SMTP forward session`):**
```
S: MAIL FROM:<Smith@Alpha.ARPA>
R: 250 OK
S: RCPT TO:<Jones@Beta.ARPA>
R: 250 OK
S: RCPT TO:<Postel@USC-ISI.ARPA>
R: 251 User not local; will forward to <Postel@USC-ISIF.ARPA>
S: RCPT TO:<Paul@USC-ISIB.ARPA>
R: 551 User not local; please try <Mockapetris@USC-ISIF.ARPA>
S: DATA
R: 354 Start mail input; end with <CRLF>.<CRLF>
S: Blah blah blah...
S: ...etc. etc. etc.
S: <CRLF>.<CRLF>
R: 250 OK
```

**Esempi di verifica (`SMTP verify examples` — `VRFY`):**
```
S: VRFY Smith
R: 251 User not local; will forward to <Smith@USC-ISIQ.ARPA>

S: VRFY Jones
R: 550 String does not match anything.

S: VRFY Jones
R: 551 User not local; please try <Jones@USC-ISIQ.ARPA>

S: VRFY Gourzenkyinplatz
R: 553 User ambigous.
```

**Esempio di espansione di mailing list / alias (`EXPN`):**
```
S: EXPN Example-People
R: 250-Jon Postel <Postel@USC-ISIF.ARPA>
R: 250-Fred Fonebone <Fonebone@USC-ISIQ.ARPA>
R: 250-Sam Q. Smith <SQSmith@USC-ISIQ.ARPA>
R: 250-Quincy Smith <@USC-ISIF.ARPA:Q-Smith@ISI-VAXA.ARPA>
R: 250-<joe@foo-unix.ARPA>
R: 250 <xyz@bar-unix.ARPA>
S: EXPN Executive-Washroom-List
R: 550 Access Denied to You.
```

**Esempio di notifica di mancata consegna (`Undeliverable mail notification message`):**
```
S: MAIL FROM:<>
R: 250 ok
S: RCPT TO:<@HOSTX.ARPA:JOE@HOSTW.ARPA>
R: 250 ok
S: DATA
R: 354 send the mail data, end with .
S: Date: 23 Oct 81 11:22:33
S: From: SMTP@HOSTY.ARPA
S: To: JOE@HOSTW.ARPA
S: Subject: Mail System Problem
S:
S: Sorry JOE, your message to SAM@HOSTZ.ARPA Lost
S: HOSTZ.ARPA said this:
S: "550 No Such User"
S: .
R: 250 ok
```

### Return Path e Received Time Stamps

```
Return-Path:<@GHI.ARPA,@DEF.ARPA,@ABC.ARPA:JOE@ABC.ARPA>
Received: from GHI.ARPA by JKL.ARPA ; 27 Oct 81 15:27:39 PST
Received: from DEF.ARPA by GHI.ARPA ; 27 Oct 81 15:15:13 PST
Received: from ABC.ARPA by DEF.ARPA ; 27 Oct 81 15:01:59 PST
Date: 27 Oct 81 15:01:01 PST
From: JOE@ABC.ARPA
Subject: Improved Mailing System Installed
To: SAM@JKL.ARPA This is to inform you that ...
```

## Autenticazione server mail

L'aumento incredibile e terribile di attacchi spam e di bounce mail ha portato all'attivazione di meccanismi di autenticazione molto forti dei server email.

**SPF** (*Sender Policy Framework*), **DKIM** (*Domain Keys Identified Mail*) e **DMARC** (*Domain-based Message Authentication*) sono dei metodi di autenticazione email per dimostrare agli ISP e ai servizi di posta che i mittenti sono veramente autorizzati a inviare email da un particolare dominio e, sono un modo per verificare che il server di invio email stia inviando email attraverso il corretto dominio.

Con queste tecniche, che richiedono l'impostazione di determinati parametri attraverso il record TXT del DNS relativo al dominio in oggetto, si ottiene la certificazione che l'operazione di invio email è autentica.

- **SPF:** l'autenticazione SPF funziona specificando il numero di IP consentiti che possono inviare e-mail da un certo dominio. Il gestore del dominio può aggiungere un file o un record sul server che dice al server ricevente quali domini sono effettivamente autorizzati a inviare e-mail.
- **DKIM:** la chiave DKIM viene aggiunta come un record TXT allo zone file DNS. Si assicura che nessun messaggio che va da server a server sia manomesso e che i messaggi possano essere identificati.
- **DMARC:** si basa su SPF e DKIM per convalidare ulteriormente le e-mail abbinando la validità dei record SPF e DKIM. Ciò consente di impostare le politiche e di ottenere segnalazioni generate nel caso in cui la convalida DMARC fallisca.

## POP3 — Post Office Protocol

La diffusione dei PC sia nell'ambiente di lavoro che per uso domestico ha reso popolare l'accesso a server di posta elettronica remoti, mediante un opportuno protocollo che gestisca la comunicazione tra server e client. Post Office Protocol, noto come POP3, definito nell'RFC 1225 realizza questa funzione.

È un'applicazione client-server che consente al client di ricevere nuovi messaggi, cancellare i messaggi presenti sul server SMTP, mentre l'invio di posta avviene via SMTP.

L'interazione del client avviene con il server POP3, il quale dialoga con il server SMTP (chiamato Message Transport System, MTS). Il server è in ascolto sulla porta 110.

Quando un client chiede il servizio, apre una connessione TCP/IP. A connessione avvenuta il server invia un messaggio di benvenuto. Client e server si scambiano comandi e risposte, rispettivamente, fino alla chiusura della sessione. I comandi sono composti da una keyword e da un eventuale argomento e terminano con un doppio CRLF.

Le risposte sono caratterizzate da indicatori di stato e da keyword eventualmente seguite da ulteriori informazioni, terminanti con un doppio CRLF. Ci sono due indicatori: positivo ("+OK") e negativo ("-ERR").

La sessione attraversa diversi stadi:

1. Dopo il messaggio di benvenuto, la sessione entra nella fase di **AUTHORIZATION**, nella quale il client fornisce login e password (in chiaro!).
2. Superata positivamente questa fase si passa ad una fase di **TRANSACTION** nella quale il client richiede azioni al server.
3. Alla fine, la sessione entra nella fase **UPDATE**, nella quale vengono rilasciate le risorse acquisite e la sessione si chiude.

**Comandi TRANSACTION:**

| Comando | Descrizione |
|:---|:---|
| STAT | fornisce numero di msg e dimensione in byte |
| LIST [msg] | elenca msgid e dimensione dei(l) msg |
| RETR msg | riceve msg |
| DELE msg | marca msg come cancellato |
| NOOP | non fa nulla |
| LAST | indica il più alto msgid acceduto |
| RSET | se ci sono msg marcati per essere cancellati, viene tolta detta marcatura |

**Comandi UPDATE:**

| Comando | Descrizione |
|:---|:---|
| QUIT | chiude la connessione |

**Esempio di AUTHENTICATION:**
```
C: USER mrose
S: +OK mrose is a real hoopy frood
C: PASS secret
S: +OK mrose's maildrop has 2 messages (320 octets) ...
C: USER mrose
S: +OK mrose is a real hoopy frood
C: PASS secret
S: -ERR unable to lock mrose's maildrop, file already locked
```

**Esempio di TRANSACTION:**
```
C: LIST
S: +OK 2 messages (320 octets)
S: 1 120
S: 2 200
S: . ...
C: LIST 2
S: +OK 2 200 ...
C: LIST 3
S: -ERR no such message, only 2 messages in maildrop
```

```
C: STAT
S: +OK 4 320
C: LAST
S: +OK 1
C: RETR 3
S: +OK 120 octets
S: <the POP3 server sends the entire message here>
S: .
C: LAST
S: +OK 3
C: DELE 2
S: +OK message 2 deleted
C: LAST
S: +OK 3
C: RSET
S: +OK
C: LAST
S: +OK 1
```

## IMAP

L'IMAP è definito (v2) nell'RFC 1064 e poi (v4) nell'RFC 2060. È un metodo per l'accesso dinamico alle mailbox ed alle news di server centrali, da parte di PC e stazioni mobili. IMAP4 è molto più efficiente di POP3 quando più client accedono al server per la stessa mailbox.

IMAP è stato sviluppato nel 1986 presso Stanford University, ma solo dopo una decade ha attratto l'interesse delle Software House. Il servizio IMAP usa la porta 143 del TCP/IP. È dotato di potenti strumenti di ricerca delle informazioni e di gestione delle informazioni multimediali (MIME).

IMAP associa ai messaggi dei *System flag*, che ne definiscono alcuni attributi:

| Flag | Significato |
|:---|:---|
| `\Seen` | Message has been read |
| `\Answered` | Message has been answered |
| `\Flagged` | Message is "flagged" for urgent/special attention |
| `\Deleted` | Message is "deleted" for removal by later EXPUNGE |
| `\Draft` | Message has not completed composition (marked as a draft) |
| `\Recent` | Message is "recently" arrived in this mailbox. Questa sessione è la prima ad esserne stata notificata; le sessioni successive non vedranno `\Recent` impostato per questo messaggio. Il flag non può essere alterato dal client. Se non è possibile determinare se la sessione è la prima ad essere notificata, il messaggio SHOULD essere considerato recent. Se più connessioni hanno la stessa mailbox selezionata simultaneamente, è indefinito quali vedranno il flag `\Recent` impostato e quali no. |

![[slide_prot14-60.png|500]]

**Esempio di autenticazione IMAP (Kerberos V4):**
```
S: * OK KerberosV4 IMAP4rev1 Server
C: A001 AUTHENTICATE KERBEROS_V4
S: + AmFYig==
C: BAcAQU5EUkVXLkNNVS5FRFUAOCAsho84kLN3/IJmrMG+25a4DT
  +nZImJjnTNHJUtxAA+o0KPKfHEcAFs9a3CL5Oebe/ydHJUwYFd
  WwuQ1MWiy6IesKvjL5rL9WjXUb9MwT9bpObYLGOKi1Qh
S: + or//EoAADZI=
C: DiAF5A4gA+oOIALuBkAAmw==
S: A001 OK Kerberos V4 authentication successful
```

**Comandi di ricerca IMAP:**

| Chiave | Significato |
|:---|:---|
| `<message set>` | Messages with message sequence numbers corresponding to the specified message sequence number set |
| `ALL` | All messages in the mailbox; the default initial key for ANDing |
| `ANSWERED` | Messages with the `\Answered` flag set |
| `BCC <string>` | Messages that contain the specified string in the envelope structure's BCC field |
| `BEFORE <date>` | Messages whose internal date is earlier than the specified date |
| `BODY <string>` | Messages that contain the specified string in the body of the message |
| `CC <string>` | Messages that contain the specified string in the envelope structure's CC field |
| `DELETED` | Messages with the `\Deleted` flag set |
| `DRAFT` | Messages with the `\Draft` flag set |
| `FLAGGED` | Messages with the `\Flagged` flag set |
| `FROM <string>` | Messages that contain the specified string in the envelope structure's FROM field |
| `HEADER <field-name> <string>` | Messages that have a header with the specified field-name (as defined in RFC-822) containing the specified string in the field-body |
| `KEYWORD <flag>` | Messages with the specified keyword set |
| `LARGER <n>` | Messages with an RFC-822 size larger than the specified number of octets |
| `NEW` | Messages that have the `\Recent` flag set but not the `\Seen` flag (funzionalmente equivalente a `(RECENT UNSEEN)`) |
| `NOT <search-key>` | Messages that do not match the specified search key |
| `OLD` | Messages that do not have the `\Recent` flag set (funzionalmente equivalente a `NOT RECENT`, diverso da `NOT NEW`) |
| `ON <date>` | Messages whose internal date is within the specified date |
| `OR <search-key1> <search-key2>` | Messages that match either search key |
| `RECENT` | Messages that have the `\Recent` flag set |
| `SEEN` | Messages that have the `\Seen` flag set |
| `SENTBEFORE <date>` | Messages whose RFC-822 `Date:` header is earlier than the specified date |
| `SENTON <date>` | Messages whose RFC-822 `Date:` header is within the specified date |
| `SENTSINCE <date>` | Messages whose RFC-822 `Date:` header is within or later than the specified date |
| `SINCE <date>` | Messages whose internal date is within or later than the specified date |
| `SMALLER <n>` | Messages with an RFC-822 size smaller than the specified number of octets |
| `SUBJECT <string>` | Messages that contain the specified string in the envelope structure's SUBJECT field |
| `TEXT <string>` | Messages that contain the specified string in the header or body of the message |
| `TO <string>` | Messages that contain the specified string in the envelope structure's TO field |
| `UID <message set>` | Messages with unique identifiers corresponding to the specified unique identifier set |
| `UNANSWERED` | Messages that do not have the `\Answered` flag set |
| `UNDELETED` | Messages that do not have the `\Deleted` flag set |
| `UNDRAFT` | Messages that do not have the `\Draft` flag set |
| `UNFLAGGED` | Messages that do not have the `\Flagged` flag set |
| `UNKEYWORD <flag>` | Messages that do not have the specified keyword set |
| `UNSEEN` | Messages that do not have the `\Seen` flag set |

**Esempio di sessione IMAP:**
```
S: * OK SUMEX-AIM.Stanford.EDU Interim Mail Access Protocol II Service 6.1(349) at Thu, 9 Jun 88 14:58:30 PDT
U: a001 login crispin secret
S: a002 OK User CRISPIN logged in at Thu, 9 Jun 88 14:58:42 PDT, job 76
U: a002 select inbox
S: * FLAGS (Bugs SF Party Skating Meeting Flames Request AI Question Note \XXXX \YYYY \Answered \Flagged \Deleted \Seen)
S: * 16 EXISTS
S: * 0 RECENT
S: a002 OK Select complete
U: a003 fetch 16 all
S: * 16 Fetch (Flags (\Seen) InternalDate " 9-Jun-88 12:55: RFC822.Size 637 Envelope ("Sat, 4 Jun 88 13:27:11 PDT" "INFO-MAC Mail Message" (("Larry Fagan" NIL "FAGAN" "SUMEX-AIM.Stanford.EDU")) (("Larry Fagan" NIL "FAGAN" "SUMEX-AIM.Stanford.EDU")) (("Larry Fagan" NIL "FAGAN" "SUMEX-AIM.Stanford.EDU")) ((NIL NIL "rindflEISCH" "SUMEX-AIM.Stanford.EDU")) NIL NIL NIL "<12403828905.13.FAGAN@SUMEX-AIM.Stanford.EDU>"))
S: a003 OK Fetch completed
U: a004 fetch 16 rfc822
S: * 16 Fetch (RFC822 {637}
S: Mail-From: RINDFLEISCH created at 9-Jun-88 12:55:43
S: Mail-From: FAGAN created at 4-Jun-88 13:27:12
S: Date: Sat, 4 Jun 88 13:27:11 PDT
S: From: Larry Fagan <FAGAN@SUMEX-AIM.Stanford.EDU>
S: To: rindflEISCH@SUMEX-AIM.Stanford.EDU
S: Subject: INFO-MAC Mail Message
S: Message-ID: <12403828905.13.FAGAN@SUMEX-AIM.Stanford.EDU>
S: ReSent-Date: Thu, 9 Jun 88 12:55:43 PDT
S: ReSent-From: TC Rindfleisch <Rindfleisch@SUMEX-AIM.Stanford.EDU>
S: ReSent-To: Yeager@SUMEX-AIM.Stanford.EDU, Crispin@SUMEX-AIM.Stanford.EDU
S: ReSent-Message-ID: <12405133897.80.RINDFLEISCH@SUMEX-AIM.Stanford.EDU>
S:
S: The file is <info-mac>usenetv4-55.arc ...
S: Larry
S: -------
S: )
S: pa004 OK Fetch completed
U: a005 logout S: * BYE DEC-20 IMAP II server terminating connection
S: a005 OK SUMEX-AIM.Stanford.EDU Interim Mail Access Protocol Service logout
```

![[slide_prot14-65.png|500]]

## Posta elettronica privata

Per molte applicazioni è necessario garantire a priori la segretezza dei messaggi di posta elettronica. La crittografia e i certificati digitali consentono di fornire questa possibilità. Vecchi norme restrittive sulla possibilità di esportare algoritmi di crittografia stanno progressivamente venendo meno.

**GnuPG** è il prodotto Open Source che permette di gestire la crittografia nei messaggi e la firma digitale. Storicamente il prodotto che per primo ha dato una importante risposta alla domanda di applicativi per posta elettronica cifrata è stato Pretty Good Privacy (PGP).

GnuPG è un'implementazione completa e libera dello standard OpenPGP definito dall'RFC 4880 (noto anche come PGP). Permette di crittografare e firmare digitalmente messaggi e dati, gestire le chiavi e gestire l'accesso ai repository di chiavi pubbliche (PKI, *Public Key Infrastructure*). GnuPG, noto anche come GPG è un applicativo che si usa da linea di comando ed è interfacciato a moltissime applicazioni. Sono infatti disponibili una vasta gamma di applicazioni e librerie. La versione 2 fornisce supporto per S/MIME e Secure Shell (ssh).

**Frontend e client compatibili con GnuPG:**
- **GUI Frontends:** Cryptophane, GnuPG Shell, GPA, Jaro Mail, KGpg, Seahorse, wija, XAP
- **Chat Programs:** Gabber, Gajim, Miranda ICQ, PSI, Tkabber, wija
- **Network Related:** Privaria
- **MUA Frontends:** Claws Mail, Enigmail, EudoraGPG, Evolution, exmh, ez-pine-gpg, GNU Anubis, GNUmail.app, gpg_mail, GPGOE, GpgOL, GPGrelay, KMail, kuvert, MagicPGP, Mailcrypt, Mew, Mutt, OpenPGP Webmail, PGG, pgpenvelope, Scribe, Squirrelmail Plugin, Sylpheed, Topal, XFmail

![[slide_prot14-70.png|500]]

**Autodifesa email (`EmailSelfDefense.FSF.org`):**
- La password che protegge un account email è soltanto uno strato sottile di sicurezza: ogni messaggio in chiaro passa attraverso diversi sistemi computerizzati prima di arrivare a destinazione, esponendo mittente e destinatari alla sorveglianza di massa.
- **Chiave pubblica:** viene depositata online in una cartella pubblica perché chiunque possa scaricarla e usarla con GnuPG per cifrare le email destinate a te.
- **Chiave privata:** va custodita sul proprio computer; serve a GnuPG per decodificare le email cifrate ricevute. Una mail cifrata intercettata risulta illeggibile senza la chiave privata del destinatario.
- **Software libero:** GnuPG è rilasciato sotto licenza libera (codice sorgente trasparente e verificabile, a differenza del software proprietario).

![[slide_prot14-71.png|500]]

![[slide_prot14-72.png|500]]

![[slide_prot14-73.png|500]]

![[slide_prot14-74.png|500]]

GnuPG usa la crittografia a chiave pubblica, la stessa di SSH. L'utente per usare il software deve generare una coppia di chiavi, una pubblica che va condivisa con ogni mezzo, l'altra da tenere segreta. Il problema è come poter condividere le chiavi pubbliche in modo efficiente. A tale scopo è stato costruito il *Web of Trust*, una rete che permette la condivisione di chiavi, le quali possono essere firmate digitalmente da altre persone per provarne l'affidabilità.

La firma digitale di un messaggio di posta elettronica, o di qualsiasi file, si ottiene da un algoritmo che combina chiave privata e testo, che può essere verificata accedendo alla chiave pubblica.

Per usare GnuPG nel proprio ambiente, occorre usare un Mail User Agent, Thunderbird o SeaMonkey, e configurarlo per questo scopo installando il plugin Enigmail. Una volta generate le chiavi va caricata la chiave pubblica su un server Web of Trust (si usa il default). Per fare un test si può usare l'indirizzo edward-it@fsf.org.

![[slide_prot14-76.png|500]]

## PGP — Pretty Good Privacy

**Pretty Good Privacy** (public key encryption for the masses, `https://www.symantec.com/products/encryption`). Esiste la versione open source: OpenPGP (`http://openpgp.org`). GnuPG (`http://www.gnupg.org`) è sviluppato nell'ambito del progetto GNU e soggetto nella licenza GPL.

PGP è un software disponibile in una forma free ed in una versione commerciale (PGP Inc) che consente la cifratura, la firma digitale e la compressione dei messaggi di posta elettronica. L'inventore è Phil Zimmermann. È multipiattaforma (DOS/Windows, Unix, Macintosh). È stato il software che più duramente osteggiato le restrizioni nell'esportazione degli algoritmi di cifratura da parte del governo degli Stati Uniti. È stato accusato di violazione del brevetto dell'RSA.

PGP si basa su una coppia di chiavi, denominate pubblica e privata. La chiave privata deve rimanere nascosta e protetta. Per scambiare posta cifrata occorre conoscere la chiave pubblica del destinatario. È un sistema di cifratura ibrida. Usa algoritmi di crittografia esistenti: RSA, IDEA, MD5.

**Invio del messaggio:**
- PGP sintetizza il messaggio con MD5
- PGP crea una session key, una chiave privata che ha validità per la sola sessione (one-time-only secret key) dato da un numero generato in maniera random (es. in base al movimento del mouse)
- Il testo in chiaro viene cifrato usando la session key con un algoritmo di cifratura a chiave privata
- La session key viene a sua volta crittografata usando la chiave pubblica del destinatario e aggiunta al testo cifrato in trasmissione verso il destinatario

**Ricezione del messaggio:**
- Si effettuano le operazioni in maniera inversa all'invio
- Utilizzando la propria chiave privata il destinatario può decifrare la session key e di conseguenza riottenere il testo del messaggio in chiaro

Anche se qualcuno intercettasse il messaggio e conoscesse la chiave pubblica del mittente, la sintesi MD5 protegge la sicurezza del messaggio stesso. Sintesi e messaggio cifrato sono concatenati e compressi con un algoritmo di ZIP di Ziv-Lempel. Il messaggio viene poi cifrato con IDEA, utilizzando la chiave pubblica del destinatario (l'operazione inversa lato destinatario, avrà bisogno della sua chiave privata). Il risultato è codificato in base64, secondo lo standard MIME. PGP è efficiente anche solo per la firma digitale dei messaggi.

Le chiavi utilizzate per la cifratura e la firma digitale sono la parte fondamentale del PGP. Il sistema consente di mantenere queste chiavi in due file chiamati:

- **pubring:** l'insieme delle chiavi pubbliche delle persone con cui si vuole corrispondere
- **privring:** le chiavi private associate ciascuna ad un indirizzo email

Il servizio di condivisione delle chiave pubbliche è chiamato *PKI infrastructure*.

### PGP: aspetti politici e legali

Alcuni paesi hanno recentemente siglato un accordo internazionale che va sotto il nome di *accordo di Wassenaar* che impegna i sottoscrittori a inibire nei propri paesi l'uso della crittografia (es: la Francia).

**Echelon**, meglio noto come il Grande Fratello: l'infrastruttura anglo-americana per l'intercettazione di tutte le comunicazioni.
