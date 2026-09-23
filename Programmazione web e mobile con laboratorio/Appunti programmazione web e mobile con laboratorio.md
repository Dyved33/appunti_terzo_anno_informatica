---
date: 2026-09-21
tags:
  - programmazione-web-e-mobile
  - architettura-web
  - protocollo-http
  - dns
  - browser
  - lezione
type: lezione
---
# Architettura del Web e Fondamenti del Protocollo HTTP

## 1. Il World Wide Web (WWW) e gli Standard di Rete

Il **World Wide Web (WWW)** è un servizio informativo distribuito operante su infrastruttura Internet che permette agli utenti di navigare ed usufruire di contenuti eterogenei. Il Web connette i nodi della rete (computer, server, dispositivi mobili) mediante una struttura **ipertestuale**, ovvero un sistema di documenti contenenti rimandi e collegamenti bidirezionali (*hyperlink*) ad altre risorse.

L'ecosistema web poggia su tre standard cardine:
* **HTML (HyperText Markup Language):** linguaggio di markup preposto alla strutturazione semantica dei documenti e dei contenuti delle pagine web.
* **HTTP (HyperText Transfer Protocol):** protocollo applicativo che governa lo scambio e il trasferimento delle risorse informative tra client e server.
* **URL (Uniform Resource Locator):** schema standard di identificazione e localizzazione univoca delle risorse sul Web.

### 1.1 Il Linguaggio HTML
**HTML** (*HyperText Markup Language*) definisce la sintassi e la struttura formale delle pagine web secondo le specifiche standardizzate dal W3C. Viene impiegato per convenzione globale come linguaggio universale per descrivere l'albero degli elementi di un ipertesto.

## 2. Architettura Client-Server e il Browser

### 2.1 Il Modello Client-Server
Il Web è interamente imperniato sul modello architetturale **Client-Server**:
* **Client:** nodi richiedenti che interrogano il sistema e fruiscono delle risorse.
* **Server:** nodi centralizzati che ospitano, gestiscono, erogano e regolano gli accessi alle risorse condivise.

Le reti locali (LAN), i servizi internet e la quasi totalità dei sistemi informatici distribuiti adottano questo schema di cooperazione.

### 2.2 Il Ruolo del Browser
Il **browser** è un'applicazione software lato client specializzata nell'acquisizione, interpretazione, presentazione grafica e navigazione delle risorse presenti sul Web (pagine HTML, fogli di stile, script, contenuti multimediali). Il browser implementa nativamente le funzionalità di client per il protocollo HTTP, coordinando il download delle risorse remote a partire dal loro indirizzo URL.

## 3. Il Protocollo HTTP (HyperText Transfer Protocol)

**HTTP** è un protocollo di livello applicativo appartenente alla suite TCP/IP (corrispondente al livello applicativo della pila ISO/OSI). La comunicazione segue un pattern asimmetrico **Request-Response**, in cui ogni interazione ha origine da una richiesta esplicita del client (il browser) verso il server erogatore del servizio.

Al livello di trasporto sottostante, HTTP si appoggia su **TCP (Transmission Control Protocol)** per instaurare una connessione affidabile tra i due host, garantendo la consegna ordinata, integra e senza perdite dei pacchetti di rete.

> [!NOTE] Sicurezza del Canale di Comunicazione (TLS)
> L'estensione di sicurezza **TLS (Transport Layer Security)**, alla base del protocollo HTTPS, interpone un livello crittografico tra il trasporto TCP e l'applicazione HTTP. Ciò garantisce la cifratura end-to-end e l'integrità dei dati scambiati, neutralizzando il rischio di intercettazioni e attacchi di tipo *Man-in-the-Middle* (MitM).

### 3.1 Funzionalità Abilitate dal Protocollo HTTP
* **Caching:** memorizzazione locale temporanea delle risorse per minimizzare latenze e consumo di banda.
* **CORS (Cross-Origin Resource Sharing):** meccanismo di sicurezza basato su intestazioni HTTP che regola l'accesso alle risorse residenti su domini differenti da quello di origine.
* **Autenticazione:** intestazioni dedicate per la trasmissione sicura di credenziali o token di autorizzazione.
* **Proxying:** supporto per intermediari di rete (proxy e reverse proxy) dedicati a instradamento, bilanciamento del carico e sicurezza.
* **Gestione delle Sessioni:** conservazione logica dello stato applicativo dell'utente nel corso della navigazione.

### 3.2 La Natura Stateless e l'Uso dei Cookie
HTTP è un protocollo **stateless** (privo di stato): ciascuna transazione di richiesta/risposta è totalmente autonoma e isolata da quelle precedenti. Il server non trattiene alcuna memoria delle interazioni pregresse.

Per ovviare a questo vincolo e mantenere la continuità operativa (ad esempio per evitare di reintrodurre le credenziali a ogni cambio di pagina o per mantenere un carrello acquisti), si adottano i **Cookie**: stringhe di dati generate dal server, salvate in locale dal client e ritrasmesse automaticamente nelle successive richieste HTTP verso il medesimo dominio.

> [!INFO] Standardizzazione
> Anche HTTP è uno standard formale aperto, le cui specifiche tecniche sono definite e mantenute dall'IETF (Internet Engineering Task Force) mediante documenti RFC (*Request for Comments*).

### 3.3 Anatomia di una Richiesta HTTP
Una richiesta inoltrata dal client si compone di:
1. **Metodo (Verbo HTTP):** specifica l'operazione semantica da eseguire sulla risorsa (es. `GET`, `POST`, `PUT`, `DELETE`, `PATCH`, `HEAD`, `OPTIONS`).
2. **Path / URI:** il percorso gerarchico di rete indicante l'esatta risorsa target da recuperare o elaborare.
3. **Header (Intestazioni):** metadati ausiliari associati alla richiesta (es. formati accettati con `Accept`, informazioni sul client con `User-Agent`, cookie di sessione).
4. **Body (Payload):** corpo del messaggio (opzionale), impiegato nei metodi come `POST` o `PUT` per inviare dati strutturati (es. form o documenti JSON) al server.

```http
GET /api/v1/users/42 HTTP/1.1
Host: www.example.com
User-Agent: Mozilla/5.0
Accept: application/json
```

> [!IMPORTANT] Il Concetto di Idempotenza
> Un metodo HTTP è definito **idempotente** se l'esecuzione ripetuta della medesima richiesta produce il medesimo effetto collaterale sullo stato del server rispetto a una singola esecuzione. I metodi `GET`, `PUT` e `DELETE` sono idempotenti, mentre `POST` non è idempotente (richieste duplicate generano risorse duplicate).

### 3.4 Anatomia di una Risposta HTTP
La risposta restituita dal server si articola in:
1. **Status Code e Status Message:** codice numerico a tre cifre indicante l'esito dell'operazione, accompagnato da un testo descrittivo:
   * `2xx` (Successo, es. `200 OK`, `201 Created`).
   * `3xx` (Reindirizzamento, es. `301 Moved Permanently`).
   * `4xx` (Errori del Client, es. `400 Bad Request`, `401 Unauthorized`, `404 Not Found`).
   * `5xx` (Errori del Server, es. `500 Internal Server Error`).
2. **Header di Risposta:** informazioni relative al formato dei dati restituiti (`Content-Type`), alla lunghezza (`Content-Length`) e a direttive di memorizzazione (`Cache-Control`, `Set-Cookie`).
3. **Body (Payload):** corpo informativo opzionale contenente la rappresentazione della risorsa recuperata (es. file HTML, payload JSON, foglio CSS o asset binario).

```http
HTTP/1.1 200 OK
Date: Mon, 21 Sep 2026 12:00:00 GMT
Content-Type: application/json; charset=UTF-8
Content-Length: 48

{"id": 42, "name": "David", "status": "active"}
```

## 4. Struttura dell'URL e Risoluzione DNS

L'**URL** (*Uniform Resource Locator*) rappresenta la coordinata formale che individua univocamente una risorsa all'interno del Web.

```
schema://[sottodominio.]dominio.tld[:porta]/percorso/risorsa[?parametri][#ancora]
```

* **Schema/Protocollo:** specifica il canale di trasporto utilizzato (es. `http`, `https`).
* **Struttura di Dominio:** sequenza gerarchica composta da sottodominio, dominio di secondo livello e **Top Level Domain** (TLD, es. `.it`, `.com`, `.org`).
* **Porta di Rete:** identificatore numerico della porta di ascolto del servizio (opzionale; standardizzato a porta `80` per HTTP e porta `443` per HTTPS).
* **Path:** percorso logico della risorsa sul file system o nel router del server.
* **Query String:** parametri addizionali passati in formato chiave-valore per filtrare o arricchire la richiesta.
* **Fragment (Ancora):** puntatore a una coordinata interna o sezione specifica del documento target.

### 4.1 Processo di Risoluzione: da URL a Indirizzo IP
Affinché il browser possa aprire il socket di rete, il nome simbolico dell'host deve essere tradotto in un indirizzo IP numerico tramite il **DNS (Domain Name System)** attraverso la seguente trafila:

1. **Controllo della Cache Locale:** il browser interroga preliminarmente la propria cache e quella del sistema operativo alla ricerca della corrispondenza IP.
2. **Interrogazione al Server TLD:** in caso di assenza locale, il resolver contatta i server di competenza del rispettivo TLD (es. per `.it`).
3. **Risposta con Delegazione Autoritativa:** il server TLD risponde con l'indirizzo di rete del server DNS autoritativo responsabile di quel dominio.
4. **Interrogazione al Server DNS Autoritativo:** viene inoltrata la query specifica per l'intero record (comprensivo di domini secondari e sottodomini).
5. **Restituzione dell'Indirizzo IP:** il server autoritativo restituisce la stringa IP associata al nodo target.
6. **Apertura del Canale di Connessione:** il browser utilizza l'IP per instaurare la connessione TCP (con eventuale handshake TLS su porta 443) verso il server web.

## 5. Pipeline di Rendering nel Browser e la Triade del Web

Una volta ricevuta la risposta HTTP dal server, il motore del browser avvia la pipeline di elaborazione e render:
* **Costruzione del DOM (Document Object Model):** il browser scarica ed effettua il parsing sequenziale dell'HTML (che può essere statico o generato a run-time lato server, es. tramite PHP/Node.js), convertendo i tag in un grafo ad albero in memoria.
* **Costruzione del CSSOM:** scarica i file CSS, calcola le regole di stile e genera l'albero degli stili associato ai nodi per produrre il *Render Tree*.
* **Esecuzione di JavaScript:** il motore di script client-side esegue il codice per:
  * Manipolare dinamicamente i nodi dell'albero DOM e aggiornare in tempo reale la UI.
  * Gestire gli eventi utente ed effettuare chiamate asincrone in background verso le API del server (es. pattern AJAX / Fetch API).

> [!IMPORTANT] Principio di Separazione delle Responsabilità
> L'architettura del frontend moderno poggia sulla rigida separazione di tre livelli indipendenti:
> * **HTML:** governa esclusivamente la *struttura* logica e il *significato semantico* dei contenuti.
> * **CSS:** governa la *presentazione visuale*, il layout e la resa grafica.
> * **JavaScript:** governa il *comportamento dinamico* e la *logica applicativa*.
> 
> Mantenere questi tre ambiti disaccoppiati è fondamentale per garantire manutenibilità, modularità e pulizia del codice.

---
## ⏭️ Navigazione Lezioni
- **Index Corso :** [[00_Index_Programmazione_Web_e_Mobile]]
