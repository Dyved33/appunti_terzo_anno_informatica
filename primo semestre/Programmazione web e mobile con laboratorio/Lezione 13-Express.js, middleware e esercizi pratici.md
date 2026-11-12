## Esercizio 2 — servire pagine HTML diverse

*Testo dall'esercizio:* creare un server web utilizzando Express.js che serva pagine HTML diverse in base alla richiesta dell'utente.

Rotte da implementare:
- `/`: `index.html`
- `/about`: `about.html`
- `/contact`: `contact.html`

```js
const express = require('express');

const app = express();
const PORT = 3000;

app.get('/', (req, res) => res.sendFile(__dirname + '/index.html'));
app.get('/about', (req, res) => res.sendFile(__dirname + '/about.html'));
app.get('/contact', (req, res) => res.sendFile(__dirname + '/contact.html'));

app.listen(PORT, () => {
    console.log(`Server in ascolto su http://localhost:${PORT}`);
});
```

`__dirname` è una variabile globale di Node.js che rappresenta il percorso assoluto della cartella in cui si trova il file attualmente in esecuzione. `res.sendFile(path)` invia il file specificato al client.

### Middleware 404 e middleware di logging

*Testo dall'esercizio:* estendere l'esempio precedente aggiungendo un middleware custom per gestire gli errori 404; aggiungere un middleware che, ad ogni richiesta ricevuta dal server, stampa il metodo `HTTP`, l'URL della richiesta e la durata dell'operazione.

Middleware 404 (dichiarato **dopo** le rotte):

```js
app.use((req, res) => {
    res.status(404).sendFile(__dirname + '/404.html');
});
```

Middleware di logging (dichiarato **prima** delle altre rotte, altrimenti non verrebbe eseguito per le richieste già gestite):

```js
app.use((req, res, next) => {
    const start = Date.now(); // Tempo di inizio
    res.on('finish', () => { // Eseguito quando la risposta viene inviata
        const duration = Date.now() - start;
        console.log(`${req.method} ${req.url} - ${duration}ms`);
    });
    next();
});
```

Un middleware ha accesso a `req` (richiesta), `res` (risposta) e `next` (funzione che passa il controllo al middleware successivo). `res.on('finish', ...)` ascolta l'evento di fine invio della risposta per calcolare la durata.

> [!tip] Ordine dei middleware
> 1. Middleware di logging (prima delle rotte): vede ogni richiesta in entrata.
> 2. Route vere e proprie.
> 3. Middleware 404 (dopo le rotte): gestisce ciò che nessuna rotta ha intercettato.

## Esercizio 3 — file statici con `express.static()`

*Testo dall'esercizio:* invece di gestire ogni rotta manualmente con `res.sendFile()`, usare `express.static()` per gestire i file statici. Express.js cercherà i file direttamente nella cartella `public/` senza bisogno di dichiarare ogni route.

```js
const express = require('express');

const app = express();
const PORT = 3000;

app.use(express.static(__dirname + '/public'));

app.use((req, res) => {
    res.status(404).sendFile(__dirname + '/public/404.html');
});

app.listen(PORT, () => {
    console.log(`Server in ascolto su http://localhost:${PORT}`);
});
```

`express.static()` è un **built-in middleware** già incluso in Express.js. Altri built-in sono `express.json()` (elabora richieste con corpo JSON) e `express.urlencoded()` (elabora dati dei form).

## HTML statico vs HTML dinamico

| | `/mia_pagina` (dinamico) | `/mia_pagina.html` (statico) |
|---|---|---|
| Cosa restituisce | HTML generato dal server | un file HTML statico |
| Vantaggi | URL più puliti e leggibili; permette di modificare il formato della risposta (HTML, JSON, …) senza cambiare l'URL | È chiaro che si tratta di un file HTML statico; il server lo restituisce direttamente senza elaborazione |
| Svantaggi | Il server deve sapere che `/mia_pagina` restituisce una pagina HTML; può generare confusione con le API (`/mia_pagina` potrebbe essere un endpoint JSON) | Se cambia il formato (es. da HTML a JSON) bisogna cambiare l'URL; meno flessibile per applicazioni dinamiche |

Noi faremo riferimento ad HTML statico

## Middleware `cookie-parser`

`cookie-parser` è un **third-party middleware** (modulo npm esterno) per Express.js che permette di leggere e gestire i cookie nelle richieste `HTTP`. Va installato:

```sh
npm install cookie-parser
```

```js
const cookieParser = require('cookie-parser');
app.use(cookieParser());
```

Il cookie viene impostato con `res.cookie(name, value, options)`. `cookie-parser` popola l'oggetto `req.cookies` per consentirne l'utilizzo: solo `req.cookies` richiede `cookie-parser` (mentre `res.cookie` e `res.clearCookie` no).

- `maxAge`: definisce per quanto tempo il cookie sarà valido in millisecondi prima di essere eliminato automaticamente dal browser. In alternativa si può usare `expires`, che imposta una data di scadenza precisa.
- `httpOnly: true`: rende il cookie accessibile solo tramite il server e non modificabile da JavaScript lato client. Previene attacchi XSS (Cross-Site Scripting), dato che script malevoli non possono leggere il cookie.
- `JSON.stringify(req.cookies)` converte i cookie ricevuti in una stringa JSON più leggibile.

> [!important] `res.cookie`, `res.clearCookie` e `req.cookies` richiedono il middleware `cookie-parser` (vedi [[Lezione 12-Node.js e NPM|Lezione 12]]).

## Esercizio 4 — gestione dei cookie

*Testo dall'esercizio:* creare un server Express.js che gestisca i cookie utilizzando il middleware `cookie-parser`. Il server dovrà avere tre route:
- `/set-cookie`: imposta un cookie
- `/get-cookie`: legge il cookie
- `/clear-cookie`: cancella un cookie

Il cookie deve avere un tempo di scadenza (`maxAge`) ed essere accessibile solo tramite HTTP (`httpOnly`).

```js
const express = require('express');
const cookieParser = require('cookie-parser');

const app = express();
const PORT = 3000;

app.use(cookieParser());

// Imposta un cookie
app.get('/set-cookie', (req, res) => {
    res.cookie('username', 'Alice', { maxAge: 900000, httpOnly: true });
    res.send('Cookie impostato!');
});

// Legge i cookie
app.get('/get-cookie', (req, res) => {
    res.send(`Cookie ricevuti: ${JSON.stringify(req.cookies)}`);
});

// Cancella un cookie
app.get('/clear-cookie', (req, res) => {
    res.clearCookie('username');
    res.send('Cookie cancellato!');
});

app.listen(PORT, () => {
    console.log(`Server in ascolto su http://localhost:${PORT}`);
});
```

`res.clearCookie('username')` rimuove il cookie `username` dal browser.

## Esercizio 5 — pagine pubbliche e private protette da cookie

*Testo dall'esercizio:* creare un server Express.js che distribuisce due categorie di pagine: pubbliche e private. Le pagine private sono distribuite solamente previa verifica di un cookie.

Route da prevedere:
- `/login`: imposta un cookie
- `/logout`: elimina il cookie
- `/restricted`: controlla il cookie e restituisce la pagina privata

Lo svolgimento completo è in `[[esercizi/es5server.js|es5server.js]]`:

```js
const express = require("express");
const cookieParser = require("cookie-parser");

const app = express();
const port = 3000;

app.use(cookieParser());
app.use(express.static("public")); // Serve tutti i file statici da public/

// Login - imposta il cookie
app.get("/login", (req, res) => {
    res.cookie("auth", "true", { maxAge: 600000, httpOnly: true, secure: true });
    res.redirect("/restricted.html"); // reindirizza all'area riservata
});

// Logout - cancella il cookie
app.get("/logout", (req, res) => {
    res.clearCookie("auth");
    res.redirect("/");
});

// Accesso all'area riservata
app.get("/restricted.html", (req, res) => {
    if (req.cookies.auth === "true") {
        res.sendFile(__dirname + "/private/restricted.html");
    }
    else {
        res.redirect("/denied.html");
    }
});

app.listen(port, () => {
    console.log("Server in ascolto su http://localhost:" + port);
});
```

Come funziona:
1. Il client chiede `/login`; il server imposta il cookie `auth` con `maxAge` (10 minuti), `httpOnly` e `secure`, poi reindirizza a `/restricted.html`.
2. `/logout` cancella il cookie `auth` e riporta alla home.
3. `/restricted.html` legge `req.cookies.auth` (grazie a `cookie-parser`): se vale `"true"` invia la pagina privata, altrimenti reindirizza a `/denied.html`.
4. `express.static("public")` serve i file statici dalla cartella `public/` (pagine pubbliche), senza dichiarare ogni route.
