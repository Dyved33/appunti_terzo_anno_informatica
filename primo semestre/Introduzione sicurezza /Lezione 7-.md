# La posta elettronica: SMTP, MIME, S/MIME, PEC e DKIM

## Invio di un messaggio: il percorso SMTP

Un messaggio di posta segue questa catena:

**MUA** (Message User Agent, il client di posta dell'utente) invia il messaggio al **MSA** (Mail Submission Agent) tramite SMTP (submission, solitamente porta 587). L'MSA lo passa a un **MTA** (Message Transfer Agent), che può inoltrarlo attraverso altri MTA via SMTP finché non raggiunge l'MTA del destinatario. L'MTA finale consegna il messaggio al **MDA** (Mail Delivery Agent), che lo deposita nella message store; il destinatario lo legge con il proprio MUA tramite IMAP o POP.

```text
MUA -> MSA (SMTP submission) -> MTA -> ... -> MTA -> SMTP local -> MDA -> message store -> MUA (IMAP/POP)
```

*Osservazione:* SMTP si occupa solo del trasporto tra server; non definisce come il messaggio è strutturato internamente (compito di MIME) né come viene autenticato o protetto (compito di S/MIME, DKIM, PEC).

## MIME

**MIME** (Multipurpose Internet Mail Extensions) consente di allegare al messaggio contenuti non testuali: immagini, GIF, audio, video, applicativi binari, e messaggi composti da più parti (formato *mixed*). Senza MIME la posta elettronica trasporterebbe solo testo ASCII puro.

## S/MIME

**S/MIME** (Secure/Multipurpose Internet Mail Extensions) è un protocollo di sicurezza per la posta elettronica che aggiunge firma digitale e cifratura ai messaggi MIME. Si basa sulla crittografia a chiave pubblica e su certificati rilasciati da un ente certificatore (CA).

**Firma digitale:** il mittente calcola l'hash del testo del messaggio e lo cifra con la propria chiave privata. Il destinatario verifica la firma con la chiave pubblica del mittente, contenuta nel certificato. Se la verifica riesce, il destinatario è sicuro dell'identità del mittente e dell'integrità del messaggio (non ripudio).

**Cifratura:** il messaggio viene cifrato con la chiave pubblica del destinatario; solo il destinatario, con la propria chiave privata, può decifrarlo. Garantisce confidenzialità end-to-end.

**Certificato S/MIME:** associa l'indirizzo email del titolare a una coppia di chiavi pubblica/privata. Viene rilasciato da un ente certificatore dopo aver verificato l'identità del richiedente. La chiave privata resta sul client del mittente (concetto analogo alle *chiavi SSH private e pubbliche* [[Approfondimento chiavi SSH private e pubbliche|chiavi SSH]]); la chiave pubblica (nel certificato) viene distribuita ai destinatari.

**Servizi S/MIME:**
- Digital signature
- Message encryption
- Compression

> [!info] Flusso S/MIME semplificato:
> Il client del mittente (MUA) firma il messaggio con la chiave privata S/MIME e lo passa all'MTA di invio. L'MTA può aggiungere una firma DKIM con la propria chiave privata. Il messaggio viaggia via SMTP fino all'MTA del destinatario, che lo consegna al MDA. Il MUA del destinatario verifica la firma S/MIME con la chiave pubblica del mittente e, se il messaggio è cifrato, lo decifra con la propria chiave privata.

## PEC

**PEC** (Posta Elettronica Certificata) è un sistema solo italiano che garantisce l'integrità del messaggio, l'autenticazione del mittente e la ricevuta di consegna con valore legale (equiparata a una raccomandata con ricevuta di ritorno).

**Confronto con S/MIME:**
- S/MIME richiede un certificato da un ente certificatore e garantisce confidenzialità (cifratura) oltre che autenticità e integrità.
- PEC garantisce integrità, autenticazione e prova di consegna con valore legale, ma non offre necessariamente cifratura end-to-end del contenuto.
- S/MIME è uno standard internazionale; PEC è un servizio nazionale italiano.

> [!important] All'esame: ricordare che PEC ha valore legale di ricevuta di consegna, mentre S/MIME è uno standard tecnico di sicurezza basato su certificati e chiavi pubblica/privata.

## DKIM

**DKIM** (DomainKeys Identified Mail) è un protocollo di autenticazione delle email. Il server di posta del mittente firma ogni messaggio in uscita con una chiave privata associata al dominio. La chiave pubblica corrispondente viene pubblicata nel DNS del dominio come record TXT. Il server del destinatario recupera la chiave pubblica dal DNS e verifica la firma: se è valida, il messaggio è davvero inviato da quel dominio e non è stato alterato durante il trasporto.

DKIM firma il corpo dell'email e un insieme di intestazioni importanti (es. il campo `Da:`), impedendo lo spoofing dell'indirizzo del mittente.

*Collegamento:* la firma DKIM si aggiunge al messaggio insieme alla firma S/MIME: il messaggio può essere sia firmato S/MIME (con la chiave privata del mittente) che firmato DKIM (con la chiave privata del dominio di invio).

## Come si ottiene un certificato S/MIME?

Si richiede a un ente certificatore (CA) fornendo i propri dati e l'indirizzo email da certificare. La CA verifica l'identità del richiedente e rilascia un certificato che associa l'email a una coppia di chiavi pubblica/privata. La chiave privata viene installata sul client di posta del titolare (o su *ssh-agent*/portachiavi di sistema); il certificato con la chiave pubblica viene condiviso con i destinatari per verificare le firme e cifrare i messaggi diretti.

> [!warning] Attenzione: non confondere S/MIME con PEC. S/MIME protegge il contenuto del messaggio (firma e cifratura), PEC certifica l'avvenuta consegna con valore legale.

> [!info] Sintesi:
> - SMTP trasporta il messaggio da MUA a MDA attraverso MSA e uno o più MTA.
> - MIME permette di allegare file e comporre messaggi multipart oltre al testo puro.
> - S/MIME aggiunge firma digitale (chiave privata del mittente) e cifratura (chiave pubblica del destinatario) tramite certificati CA.
> - PEC è il servizio italiano con valore legale di ricevuta di consegna; S/MIME è lo standard internazionale di sicurezza per email.
> - DKIM autentica il dominio di invio tramite una firma digitale verificabile via record DNS TXT.
