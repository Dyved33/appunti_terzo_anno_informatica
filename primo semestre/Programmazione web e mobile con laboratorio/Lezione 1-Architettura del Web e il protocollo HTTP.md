# Architettura del Web e il protocollo HTTP

## Il World Wide Web e i suoi standard

Il **World Wide Web (WWW)** è un servizio informativo distribuito operante su infrastruttura Internet che permette agli utenti di navigare e usufruire di contenuti eterogenei. Il Web connette i nodi della rete (computer, server, dispositivi mobili) mediante una struttura **ipertestuale**, cioè un sistema di documenti contenenti rimandi e collegamenti bidirezionali (*hyperlink*) ad altre risorse.

L'ecosistema web poggia su tre standard cardine:

- **HTML** (*hypertext markup language*): linguaggio di markup preposto alla strutturazione semantica dei documenti e dei contenuti delle pagine web. Definisce la sintassi e la struttura formale delle pagine secondo le specifiche standardizzate dal W3C e viene impiegato come linguaggio universale per descrivere l'albero degli elementi di un ipertesto.
- **HTTP** (*hypertext transfer protocol*): protocollo applicativo che governa lo scambio e il trasferimento delle risorse informative tra client e server.
- **URL** (*uniform resource locator*): schema standard di identificazione e localizzazione univoca delle risorse sul Web.

## L'architettura client-server e il browser

Il Web è interamente imperniato sul modello architetturale **client-server**:

- **client:** nodi richiedenti che interrogano il sistema e fruiscono delle risorse;
- **server:** nodi centralizzati che ospitano, gestiscono, erogano e regolano gli accessi alle risorse condivise.

Le reti locali (LAN), i servizi internet e la quasi totalità dei sistemi informatici distribuiti adottano questo schema di cooperazione.

Il **browser** è un'applicazione software lato client specializzata nell'acquisizione, interpretazione, presentazione grafica e navigazione delle risorse presenti sul Web (pagine HTML, fogli di stile, script, contenuti multimediali). Implementa nativamente le funzionalità di client per il protocollo HTTP, coordinando il download delle risorse remote a partire dal loro indirizzo URL.

## Il protocollo HTTP

**HTTP** è un protocollo di livello applicativo appartenente alla suite TCP/IP, corrispondente al livello applicativo della pila ISO/OSI. La comunicazione segue un pattern asimmetrico **request-response**, in cui ogni interazione ha origine da una richiesta esplicita del client, il browser, verso il server erogatore del servizio. Al livello di trasporto sottostante HTTP si appoggia su **TCP** (*transmission control protocol*) per instaurare una connessione affidabile tra i due host, garantendo la consegna ordinata, integra e senza perdite dei pacchetti di rete.

> [!info] Sicurezza del canale:
> L'estensione di sicurezza **TLS** (*transport layer security*), alla base del protocollo HTTPS, interpone un livello crittografico tra il trasporto TCP e l'applicazione HTTP. Garantisce la cifratura end-to-end e l'integrità dei dati scambiati, neutralizzando il rischio di intercettazioni e attacchi di tipo *man-in-the-middle* (MitM).

**Funzionalità abilitate dal protocollo:**

- **Caching:** memorizzazione locale temporanea delle risorse per minimizzare latenze e consumo di banda.
- **CORS** (*cross-origin resource sharing*): meccanismo di sicurezza basato su intestazioni HTTP che regola l'accesso alle risorse residenti su domini differenti da quello di origine.
- **Autenticazione:** intestazioni dedicate per la trasmissione sicura di credenziali o token di autorizzazione.
- **Proxying:** supporto per intermediari di rete (proxy e reverse proxy) dedicati a instradamento, bilanciamento del carico e sicurezza.
- **Gestione delle sessioni:** conservazione logica dello stato applicativo dell'utente nel corso della navigazione.

Anche HTTP è uno standard formale aperto, le cui specifiche tecniche sono definite e mantenute dall'IETF (*internet engineering task force*) mediante documenti RFC (*request for comments*).

### La natura stateless e i cookie

HTTP è un protocollo **stateless**, privo di stato: ciascuna transazione di richiesta/risposta è totalmente autonoma e isolata da quelle precedenti, e il server non trattiene alcuna memoria delle interazioni pregresse. Per ovviare a questo vincolo e mantenere la continuità operativa, per evitare di reintrodurre le credenziali a ogni cambio di pagina o per mantenere un carrello acquisti, si adottano i **cookie**: stringhe di dati generate dal server, salvate in locale dal client e ritrasmesse automaticamente nelle successive richieste HTTP verso il medesimo dominio.

### L'anatomia di una richiesta

1. **Metodo (verbo HTTP):** specifica l'operazione semantica da eseguire sulla risorsa, per esempio `GET`, `POST`, `PUT`, `DELETE`, `PATCH`, `HEAD`, `OPTIONS`.
2. **Path o URI:** il percorso gerarchico di rete indicante l'esatta risorsa target da recuperare o elaborare.
3. **Header (intestazioni):** metadati ausiliari associati alla richiesta, come i formati accettati con `Accept`, le informazioni sul client con `User-Agent` o i cookie di sessione.
4. **Body (payload):** corpo del messaggio, opzionale, impiegato nei metodi come `POST` o `PUT` per inviare dati strutturati al server, per esempio un form o documenti JSON.

```http
GET /api/v1/users/42 HTTP/1.1
Host: www.example.com
User-Agent: Mozilla/5.0
Accept: application/json
```

> [!important] Il concetto di idempotenza:
> Un metodo HTTP è **idempotente** se l'esecuzione ripetuta della medesima richiesta produce il medesimo effetto collaterale sullo stato del server rispetto a una singola esecuzione. I metodi `GET`, `PUT` e `DELETE` sono idempotenti, mentre `POST` non lo è: richieste duplicate generano risorse duplicate.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20260925163437.png" width="300">
</div>

### L'anatomia di una risposta

1. **Status code e status message:** codice numerico a tre cifre indicante l'esito dell'operazione, accompagnato da un testo descrittivo:
   - `2xx`: successo, per esempio `200 OK`, `201 Created`;
   - `3xx`: reindirizzamento, per esempio `301 Moved Permanently`;
   - `4xx`: errori del client, per esempio `400 Bad Request`, `401 Unauthorized`, `404 Not Found`;
   - `5xx`: errori del server, per esempio `500 Internal Server Error`.
2. **Header di risposta:** informazioni relative al formato dei dati restituiti (`Content-Type`), alla lunghezza (`Content-Length`) e a direttive di memorizzazione (`Cache-Control`, `Set-Cookie`).
3. **Body (payload):** corpo informativo opzionale contenente la rappresentazione della risorsa recuperata, per esempio file HTML, payload JSON, foglio CSS o asset binario.

```http
HTTP/1.1 200 OK
Date: Mon, 21 Sep 2026 12:00:00 GMT
Content-Type: application/json; charset=UTF-8
Content-Length: 47

{"id": 42, "name": "David", "status": "active"}
```

## L'URL e la risoluzione DNS

L'**URL** rappresenta la coordinata formale che individua univocamente una risorsa all'interno del Web:

```
schema://[sottodominio.]dominio.tld[:porta]/percorso/risorsa[?parametri][#ancora]
```

- **Schema o protocollo:** il canale di trasporto utilizzato, per esempio `http`, `https`.
- **Struttura di dominio:** sequenza gerarchica composta da sottodominio, dominio di secondo livello e **top level domain** (TLD, per esempio `.it`, `.com`, `.org`).
- **Porta di rete:** identificatore numerico della porta di ascolto del servizio; opzionale, standardizzato a `80` per HTTP e `443` per HTTPS.
- **Path:** percorso logico della risorsa sul file system o nel router del server.
- **Query string:** parametri addizionali passati in formato chiave-valore per filtrare o arricchire la richiesta.
- **Fragment (ancora):** puntatore a una coordinata interna o sezione specifica del documento target.

Affinché il browser possa aprire il socket di rete, il nome simbolico dell'host deve essere tradotto in un indirizzo IP numerico tramite il **DNS** (*domain name system*):

1. **Controllo della cache locale:** il browser interroga preliminarmente la propria cache e quella del sistema operativo alla ricerca della corrispondenza IP.
2. **Interrogazione al server TLD:** in caso di assenza locale, il resolver contatta i server di competenza del rispettivo TLD, per esempio quelli del `.it`.
3. **Risposta con delegazione autoritativa:** il server TLD risponde con l'indirizzo di rete del server DNS autoritativo responsabile di quel dominio.
4. **Interrogazione al server DNS autoritativo:** viene inoltrata la query specifica per l'intero record, comprensivo di domini secondari e sottodomini.
5. **Restituzione dell'indirizzo IP:** il server autoritativo restituisce la stringa IP associata al nodo target.
6. **Apertura del canale di connessione:** il browser utilizza l'IP per instaurare la connessione TCP, con eventuale handshake TLS su porta 443, verso il server web.

## La pipeline di rendering nel browser

Una volta ricevuta la risposta HTTP dal server, il motore del browser avvia la pipeline di elaborazione e render:

- **Costruzione del DOM** (*document object model*): il browser scarica ed effettua il parsing sequenziale dell'HTML, che può essere statico o generato a run-time lato server (per esempio tramite PHP o Node.js), convertendo i tag in un grafo ad albero in memoria.
- **Costruzione del CSSOM:** scarica i file CSS, calcola le regole di stile e genera l'albero degli stili associato ai nodi per produrre il *render tree*.
- **Esecuzione di JavaScript:** il motore di script client-side esegue il codice per manipolare dinamicamente i nodi dell'albero DOM e aggiornare in tempo reale la UI, e per gestire gli eventi utente ed effettuare chiamate asincrone in background verso le API del server (per esempio con il pattern AJAX o la Fetch API).

> [!important] Separazione delle responsabilità:
> L'architettura del frontend moderno poggia sulla rigida separazione di tre livelli indipendenti:
> - **HTML:** governa esclusivamente la *struttura* logica e il *significato semantico* dei contenuti.
> - **CSS:** governa la *presentazione visuale*, il layout e la resa grafica.
> - **JavaScript:** governa il *comportamento dinamico* e la *logica applicativa*.
>
> Mantenere i tre ambiti disaccoppiati è fondamentale per garantire manutenibilità, modularità e pulizia del codice.

> [!info] Sintesi:
> - Il WWW è un servizio informativo distribuito su Internet, costruito su HTML, HTTP e URL, con struttura ipertestuale.
> - Il Web è client-server: il browser è il client che implementa nativamente HTTP e gestisce il download delle risorse.
> - HTTP è stateless e gira su TCP; HTTPS aggiunge TLS con cifratura e integrità. Cookie e sessioni soprono il vincolo di statelessness.
> - La richiesta è metodo, path, header e body; la risposta è status code, header e body; `GET`, `PUT` e `DELETE` sono idempotenti, `POST` no.
> - L'URL è schema, dominio, porta, path, query string e fragment; il DNS traduce il nome dell'host in IP con cache locale, server TLD e server autoritativo.
> - Il rendering costruisce DOM, CSSOM e render tree, quindi esegue JavaScript; HTML, CSS e JavaScript restano tre responsabilità separate.