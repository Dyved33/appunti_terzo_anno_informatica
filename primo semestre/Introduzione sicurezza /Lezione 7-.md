Strada percorsa da un messaggio: Invio di un messaggio (ESMTP submission) -> mail submission agent (MSA) -> SMTP -> message transfer agent (MTA) -> SMTP...->message transfer agent (MTA) -> SMTP ... -> message transfer agent (MTA) -> SMTP local -> mail delivery agent -> ESMPT submission -> message store (MS) -> IMAP,POP local-> message user agent MUA

MIME: mi da la possibilità di mandare immagini, GIF, audio, video, applicativi binari (?), messaggi comporti da più parti (un misto delle cose scritte prima)

Secure mime (S/MIME): posso comprimere il messaggio e posso codificare un campo che sia una digital signature (prendo il testo e faccio l'hash così chi riceve il testo è sicuro del mittente tramite hash). Posso mandare un messaggio che è testo cifrato (?)

PEC (solo italiana per assicurarsi che la mail sia arrivata): garantisce integrità, autenticazione (altro?). Confronto con S mime che richiede un certificato da un ente certificatore e garantisce confidenzialità

Msg + sender's S/MIME signing key (private key) = sendere MUA -> msg/sig -> sending MTA + MTA's DKIM signin key (private key) -> msg/sig/DKIM ????????????????????????? //S/MIME flow???//

S/MIME services:
- Digital signature
- Message encryption
- Compress
- Manca qualcosa

//Simplified S/MIME functional flow//

Come si ottiene un certificato S/MIME?

