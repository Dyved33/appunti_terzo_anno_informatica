È un servizio di rete di emulazione di un terminale a carattere (ASCII).  È definito da RFC 8545 e RFC 855. Effettua l'astrazione del terminale consentendo l'accesso remoto attraverso la rete

Client:
- Invocato dall'utente
- Realizza la connessione col server remoto
- Passa i caratteri digitati dalla tastiera dall'utente al server e visualizza il risultato del comando eseguito nel server sulla finestra dell'utente

Server:
- Accetta connessioni di rete
- Passa i caratteri digitati dall'utente al sistema operativo, come se fossero digitati in una tastiera locale
- Invia l'output sulla connessione del client

Servizio di emulazione di terminale attraverso la rete. Si basa su protocollo TCP -> connessione affidabile. Essendo strutturato secondo il paradigma client/server: 
- Client telnet, si connette con un server telnet in esecuzione su un altro ghost in ascolto sulla porta 23
- Appena connesso l'utente può eseguire comandi come se il terminale fosse locale

//immagine//

Questo servizio si basa su 3 aspetti:
1. Network virtual terminal (NVT): terminale virtuale con caratteristiche generali; ogni server o client traduce i controlli nativi in quelli del NVT; permette di eliminare l'uso di specifici strumenti client //manca//
2. //manca//
3. //manca//

//Immagine//

Funzioni di controllo standard:
- Essendo un servizio funzionante su sistemi eterogenei , i client e server possono essere implementati in modo diverso
- Sono state standardizzate le definizione di 7 funzionalità di controllo (interrupt process, abort output, break, erase character, erase line, synchronize, are you there)

//immagine//

//immagine//

Rlogin
Inventato per i sistemi BSD Unix. Include delle facilitazioni specifiche per Unix. Permette all'amministratore di configurare una serie di macchine un modo tale che se un utente ha uno stesso identificativo in queste macchine, l'accesso avvenga senza digitare la password. Questa soluzione molto comoda perché facilita la considerazione di ambienti distribuiti, porta con sé forti problematiche di sicurezza. Permette altre forme di autenticazione

Port forwarding
È una nuova funzionalità implementata da ssh (secure shell). È simile al Network Address Translation (NAT). Permette di instradare connessioni TCP in un canale cifrato.

Remote desktop
Disegnato per sistemi che consentono un accesso di tipo grafico (GUI) a finestre. Permette ad utenti remoti di visualizzare lo schermo grafico di un computer e di usare mouse e tastiera. Esempi: //mancano gli esempi//

Obsolescenza di telnet
//manca il contenuto di questa slide//

FTP (file transport protocol)
//manca il contenuto di questa e delle successive slide relative a questo argomento//

Encryption technology
//manca//

Vai avanti con il contenuto delle slide fino al DNS, poi salta il DNS e riprendi dal NIS