# Node.js e NPM

## Node.js
*Definizione:* `Node.js` è un ambiente di esecuzione che permette di eseguire [[Lezione 10-Strutture di controllo in JavaScript|JavaScript]] sul lato server.
- Consente l'esecuzione di codice asincrono e basato su eventi
- È costruito sull'engine open source di Google `V8`, scritto in `C++`

| Node.js nel server | JavaScript nel client |
|---|---|
| Ambiente lato server che permette l'esecuzione di JavaScript | Viene eseguito come linguaggio di scripting lato client |
| Ha accesso a API specifiche del sistema operativo (file system, reti, processi) | Accede principalmente a API web come DOM e Web Storage |
| Usato per applicazioni server-side, gestione di API e operazioni IO intensive | Focalizzato su interazioni dinamiche nelle pagine web, manipolazione del DOM e comunicazioni |

## Node Package Manager (NPM)
*Definizione:* `NPM` è il gestore di pacchetti ufficiale per `Node.js`.
- Con `NPM`, è possibile installare i moduli necessari per un progetto con un singolo comando
- Facilita l'installazione, l'aggiornamento e la gestione di librerie e moduli in un progetto
- Utilizza un vasto registro online che contiene migliaia di pacchetti disponibili gratuitamente

## Primo Script Node.js
- Creare un nuovo file con estensione `.js` (es: `app.js`)
- Scrivere un semplice script, ad esempio `` `console.log("Ciao, mondo!");` ``
- Per eseguire lo script:
  - aprire il terminale
  - navigare alla directory che contiene il file `app.js`
  - eseguire il comando `` `node app.js` ``

## Analisi del frammento `process.stdin.on(...)`
- `` `process` `` è un oggetto globale in `Node.js` che gestisce il processo corrente
- `` `stdin` `` è uno dei flussi predefiniti accessibili tramite `` `process` `` (input utente da tastiera)
- `` `on()` `` è un metodo usato per ascoltare eventi su un oggetto. In questo caso, stiamo ascoltando l'evento `` `data` `` su `` `process.stdin` ``
- L'evento `data` viene emesso ogni volta che l'utente inserisce dati e preme invio
- Quando ciò accade, i dati inseriti dall'utente vengono passati come argomento alla funzione di callback `` `function (input) {...}` ``

## Moduli
Un modulo è un blocco di codice isolabile che serve a:
- mantenere il codice organizzato
- riutilizzare il codice in diverse parti del programma senza riscriverlo
- incapsulare la logica e i dati, mantenendo il codice privato e protetto da interferenze esterne

`Node.js` supporta sia moduli nativi (es. `fs`, `http`) sia moduli personalizzati creati dall'utente

## Pacchetti
- Un pacchetto è una directory che contiene uno o più moduli insieme a un file `package.json` che definisce vari metadati, come dipendenze, script, versione
- I pacchetti sono usati per distribuire e installare moduli e possono essere installati in un progetto `Node.js` tramite `npm`
- I pacchetti possono essere caricati e utilizzati tramite la funzione `require()`

## NPM - Installare Pacchetti
- Installazione locale — `npm install`
  - Scarica il modulo nella directory corrente da cui si esegue il comando
  - Utilizzabile solo dalla directory del progetto via `require()`
  - Servono da "librerie" (`Express`, `Mongoose`, …)
- Installazione globale — `npm install -g`
  - Scarica il modulo all'interno di una directory di sistema
  - Utilizzabile da qualsiasi directory, ma solo da console
  - Servono come "strumenti" (`Nodemon`, `Vite`, …)

## NPM - Funzionalità
- elenco dei pacchetti installati — `npm list`
- aggiornare un pacchetto — `npm update`
- rimuovere un pacchetto — `npm uninstall`
- verifica della sicurezza dei pacchetti — `npm audit`
- pulizia delle dipendenze non utilizzate — `npm prune`

## package.json
Gestisce le dipendenze di un progetto, ad esempio:

```json
{
  "name": "my-project",
  "version": "1.0.0",
  "description": "A simple Node.js project",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "Your Name",
  "license": "MIT",
  "dependencies": {
    "express": "^4.17.1"
  },
  "devDependencies": {
    "nodemon": "^2.0.7"
  }
}
```

`package.json`:
- Elenca le dipendenze e consente l'installazione con `npm install`
- Specifica le versioni dei pacchetti
- Contiene script personalizzati per avviare il server, eseguire test, ecc
- Fornisce metadati sul progetto come nome, versione, autore, ecc
- Facilita la condivisione del progetto con altri sviluppatori
- È necessario per la pubblicazione di pacchetti su `npm`
- Viene creato e aggiornato automaticamente da `npm install`
- Creazione manuale di un file `package.json`:
  - `npm init`
  - `npm init -y`

## Creare un Modulo
1. Creare una nuova directory per modulo, es: "mio-modulo"
2. Dentro la directory del modulo, eseguire il comando `npm init`
3. Creare il file principale del modulo, solitamente: "index.js", es:

```js
function saluta(nome) {
  return "Ciao, " + nome + "!";
}

module.exports = { saluta };
```

4. Utilizzare il modulo

```js
const mioModulo = require("./mio-modulo");
console.log(mioModulo.saluta('Giorgio'));
```

## Modulo http
- È un modulo core (preinstallato)
- Fornisce funzionalità per la gestione di server e client `HTTP`
- Utile per costruire applicazioni web e API RESTful
- La funzione `createServer`:
  - Consente di creare un server che può rispondere a richieste `HTTP`
  - Fornisce metodi per gestire le richieste `HTTP` in entrata (`req`)
  - Impostare le intestazioni e il corpo delle risposte `HTTP` (`res`)

| Classe | Significato | Esempi |
|---|---|---|
| 1xx - Informativi | Il server ha ricevuto la richiesta e il client può continuare | 100 Continue, 101 Switching Protocols |
| 2xx - Successo | La richiesta è andata a buon fine | 200 OK, 201 Created |
| 3xx - Reindirizzamenti | La risorsa è stata spostata | 301 Moved Permanently, 304 Not Modified |
| 4xx - Errori del client | Richiesta errata o malformata | 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 408 Request Timeout |
| 5xx - Errori del server | Errore generico del server | 500 Internal Server Error, 502 Bad Gateway, 504 Gateway Timeout |

## Avviare il server
- Opzione 1: lanciare il comando `node app.js`
- Opzione 2: lanciare il comando `npm start`
  - In questo caso, assicurarsi che nella sezione `scripts` del file `package.json` sia presente il comando che esegue lo script di avvio, es:

```json
{
  ...,
  "scripts": {
    "start": "node app.js"
  },
  ...
}
```

## Esempio pratico: server HTTP con le rotte di `esercizi/app.js`

Il file `esercizi/app.js` contiene un server completo costruito con il modulo `http`: mappa ogni URL a un file HTML (`/`, `/about`, `/contact`) e restituisce il contenuto di `404.html` con codice `200` per tutto il resto, in ascolto sulla porta 3000.

```js
const http = require('http');
const fs = require('fs');
const server = http.createServer((req, res) => {
    let filePath = '';
    if (req.url === '/') {
        filePath = 'index.html';
    } else if (req.url === '/about') {
        filePath = 'about.html';
    } else if (req.url === '/contact') {
        filePath = 'contact.html';
    } else {
        filePath = '404.html';
    }
    fs.readFile(filePath, (err, content) => {
        if (err) {
            res.writeHead(500, { 'Content-Type': 'text/plain' });
            res.end('Errore interno del server');
        } else {
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(content);
        }
    });
});
server.listen(3000, () => {
    console.log('Server in ascolto su http://localhost:3000');
});
```

`fs.readFile` legge il file in modo asincrono: non blocca l'esecuzione e passa il contenuto (o l'errore) alla callback. Il server risponde con `200` e il contenuto HTML se la lettura riesce, altrimenti con `500`.

## Riavvio automatico
- Installare il pacchetto `nodemon` `` `npm install --save-dev nodemon` ``
- Aggiornare `package.json`

```json
{
  ...,
  "scripts": {
    "start": "node app.js",
    "dev": "nodemon index.js"
  },
  ...
}
```

- Avviare il progetto con il comando `npm run dev`

## Modulo fs (File System)
- Serve per interagire con il file system del computer per leggere, scrivere, modificare ed eliminare file e directory
- È un modulo core, quindi non serve installarlo
- Può operare in modo sincrono (bloccante) o asincrono (non bloccante)

### Lettura di un file
- Sincrona: blocca l'esecuzione fino a quando il file è letto

```js
const data = fs.readFileSync('file.txt', 'utf8');
console.log(data);
```

- Asincrona: non blocca l'esecuzione e usa una callback

```js
fs.readFile('file.txt', 'utf8', (err, data) => {
  if (err) {
    console.error('Errore nella lettura:', err);
    return;
  }
  console.log(data);
});
```

### Scrittura di un file
- Sincrona: blocca l'esecuzione fino a quando il file è scritto

```js
fs.writeFileSync('file.txt', 'Ciao, mondo!');
```

- Asincrona: non blocca l'esecuzione e usa una callback

```js
fs.writeFile('file.txt', 'Ciao, mondo!', err => {
  if (err) {
    console.error('Errore nella scrittura:', err);
  } else {
    console.log('Scrittura completata!');
  }
});
```

### Altri metodi
- Append: aggiungere contenuto senza sovrascrivere

```js
fs.appendFile('file.txt', '\nNuova riga!', err => {
  if (err) throw err;
  console.log('Testo aggiunto!');
});
```

- Creare/eliminare una cartella

```js
// Sincrono
fs.mkdirSync('nuova_cartella');
// Asincrono
fs.mkdir('nuova_cartella', err => {
  if (err) console.error(err);
});

// Sincrono
fs.rmdirSync('nuova_cartella');
// Asincrono
fs.rmdir('nuova_cartella', err => {
  if (err) console.error(err);
});
```

## Esempio pratico: scrittura e lettura di un file da `esercizi/app.js`

Il file `esercizi/app.js` scrive un file con `fs.writeFile` e lo legge subito dopo con `fs.readFile`, entrambe in modo asincrono.

```js
fs.writeFile('file.txt', 'Ciao, mondo!', err => {
    if (err) {
        console.error('Errore nella scrittura:', err);
    } else {
        console.log('Scrittura completata!');
    }
});

fs.readFile('file.txt', 'utf8', (err, data) => {
    if (err) {
        console.error('Errore nella lettura:', err);
        return;
    }
    console.log(data);
});
```

Nota: nel file originale di esercizio appare `s.readFile` per refuso di battitura; la forma corretta è `fs.readFile`, come mostrato sopra.

## Express.js
*Definizione:* `[[Lezione 13-Express.js, middleware e esercizi pratici|Express.js]]` è un framework web per `Node.js`.
- Progettato per creare applicazioni web e API
- Consente di aggiungere funzionalità (logging, autenticazione, …) tramite middleware
- Supporta un sistema di routing per gestire le richieste `HTTP` in base a vari percorsi e metodi (`GET`, `POST`, `PUT`, `DELETE`, …)
- Integrabile con vari motori di template (`Pug`, `EJS`, …) per generare pagine HTML dinamiche

## Application Programming Interface (API)
*Definizione:* insieme di protocolli che permettono a diverse applicazioni di comunicare tra loro.
- Tipi di API: di Sistema, di Libreria, Web
- API Web: permettono la comunicazione tra server e client, ad es. tramite `HTTP`
- Componenti di un'API Web:
  - Endpoint (URL ai quali le richieste possono essere inviate)
  - Metodi `HTTP` (`GET`, `POST`, `PUT`, `DELETE`)
  - Headers (informazioni aggiuntive inviate con una richiesta o una risposta `HTTP`)
  - Body (contenuto della richiesta o risposta, solitamente in formato `JSON` o `XML`)

## Representational State Transfer (REST)
- Stateless: ogni richiesta deve contenere tutte le informazioni necessarie, senza che il server mantenga lo stato tra le richieste
- Client-Server: il client gestisce l'interfaccia utente, mentre il server si occupa dell'archiviazione e della logica di business
- Cacheable: le risposte possono essere memorizzate nella cache per ridurre le chiamate al server e migliorare le prestazioni
- Uniform Interface: le API RESTful usano metodi `HTTP` standard (`GET`, `POST`, `PUT`, `DELETE`) per operare sulle risorse in modo uniforme
- Layered System: l'architettura può avere più livelli (proxy, bilanciatori di carico) senza che il client ne sia consapevole

![[Pasted image 20261109164418.png]]

## Metodi `HTTP` principali
- `GET`:
  - Utilizzato per leggere o recuperare dati, es. ottenere un elenco di prodotti
  - I dati vengono passati in chiaro nell'URL
  - È idempotente (chiamate ripetute restituiscono lo stesso risultato)
- `POST`:
  - Utilizzato per inviare dati e creare nuove risorse, es. creare un nuovo prodotto
  - I dati vengono inviati nel corpo della richiesta `HTTP` (non visibili direttamente)
  - Non è idempotente (chiamate ripetute possono causare effetti collaterali)

> [!example] Esempio con `Express.js`
> ```js
> const express = require('express');
> const app = express();
> const port = 3000;
>
> app.get('/', (req, res) => {
>   res.send('Benvenuto nella home page');
> });
>
> app.get('/time', (req, res) => {
>   res.send(`Ora corrente: ${new Date().toLocaleTimeString()}`);
> });
>
> app.get('/contact', (req, res) => {
>   res.send('Contatto: email@example.com');
> });
>
> app.use((req, res) => {
>   res.status(404).send('404 - Risorsa non trovata');
> });
>
> app.listen(port, () => {
>   console.log(`Server avviato su http://127.0.0.1:${port}/`);
> });
> ```

> [!info] `` `app.use` `` mi dice che sto usando un middleware

> [!example] Esempio senza `Express.js`
> ```js
> const http = require('http');
> const hostname = '127.0.0.1';
> const port = 3000;
>
> const server = http.createServer((req, res) => {
>   res.statusCode = 200;
>   res.setHeader('Content-Type', 'text/plain');
>
>   if (req.url === '/') {
>     console.log(req.method);
>     res.end('Benvenuto nella home page');
>   } else if (req.url === '/time') {
>     res.end(`Ora corrente: ${new Date().toLocaleTimeString()}`);
>   } else if (req.url === '/contact') {
>     res.end('Contatto: email@example.com');
>   } else {
>     res.statusCode = 404;
>     res.end('404 - Risorsa non trovata');
>   }
> });
>
> server.listen(port, hostname, () => {
>   console.log(`Server running at http://${hostname}:${port}/`);
> });
> ```
> - Codice meno leggibile
> - Gestione delle rotte meno chiara
> - No middleware per errore 404
> - No gestione automatica per header e status code

## `res` in `Express.js`
- `res.status(code)`: imposta il codice di stato della risposta `HTTP`
- `res.send(body)`: invia una risposta `HTTP` con il corpo specificato
- `res.json(obj)`: invia una risposta `JSON`
- `res.sendFile(path, [options], [callback])`: invia il file specificato al client
- `res.on(event, callback)`: ascolta eventi sulla risposta `HTTP`
- `res.cookie(name, value, [options])`: imposta un cookie
- `res.clearCookie(name, [options])`: rimuove un cookie

> [!info] `res.cookie`, `res.clearCookie` e `req.cookies` richiedono il middleware `cookie-parser` (vedi [[Lezione 13-Express.js, middleware e esercizi pratici|lezione 13]]).

## `req.params` vs `req.query`
La differenza principale tra `req.params` e `req.query` in `Express.js` riguarda il modo in cui i dati vengono passati nell'URL.

| | `req.params` | `req.query` |
|---|---|---|
| Dove si trova | Parte del percorso (`/greet/:name`) | Dopo il `?` nell'URL (`/greet?name=...`) |
| Obbligatorio | Sì, fa parte della route | No, è opzionale |
| Tipico utilizzo | ID di utente, prodotto, post, paginazione | Ricerca, filtri, paginazione |

## `req` in `Express.js`
- `req.params`: parametri dell'URL (es. `/users/:id` → `req.params.id`)
- `req.query`: parametri della query (es. `?name=John` → `req.query.name`)
- `req.body`: contiene il corpo della richiesta `HTTP`
- `req.headers`: contiene gli header della richiesta `HTTP`
- `req.cookies`: contiene i cookie inviati dal client
- `req.method`: restituisce il metodo `HTTP` della richiesta
- `req.ip`: restituisce l'indirizzo IP del client

> [!info]
> `__dirname` è una variabile globale in Node.js che rappresenta il percorso assoluto della cartella in cui si trova il file attualmente in esecuzione

