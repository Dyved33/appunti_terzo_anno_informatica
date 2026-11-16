# Ajax — chiamate asincrone e fetch

## Pagine dinamiche
Esistono due approcci per generare contenuti dinamicamente. Differiscono per dove e quando vengono generate le pagine e i dati.

![[Pasted image 20261116125428.png|500]]

*Definizione:* **Generazione delle pagine lato backend**: il server crea l'intera pagina HTML con i dati già inclusi e il client riceve la pagina già pronta. Esempi: PHP, EJS, Pug.

*Vantaggi:* meno richieste al server, funziona anche senza JavaScript nel browser.

*Svantaggi:* ogni modifica richiede un refresh della pagina.

*Definizione:* **Fetch lato client**: il server invia solo i dati e il client costruisce la pagina dinamicamente. Esempio: JavaScript + API REST. È l'opzione che prediligiamo.

*Vantaggi:* il client non ricarica tutta la pagina, ma aggiorna solo le parti necessarie.

*Svantaggi:* dipende da JavaScript, gestione più complessa (separata per frontend e backend).

## Ajax
*Definizione:* **Ajax** (Asynchronous JavaScript And XML) è una tecnica di sviluppo web che consente di inviare e ricevere dati da un server in modo asincrono. Oggi al posto di XML si usa quasi sempre JSON.

Permette di creare pagine dinamiche aggiornando solo porzioni specifiche del contenuto (come elenchi o tabelle) senza dover ricaricare l'intera pagina.

## Flusso di una richiesta AJAX
1. L'utente compie un'azione (ad esempio clicca un bottone) che fa scattare una richiesta AJAX.
2. La richiesta viene inviata da JavaScript al server in modo asincrono, cioè senza bloccare l'esecuzione del resto della pagina.
3. Il server riceve la richiesta e la elabora, magari interrogando un database.
4. Quando il server ha completato l'elaborazione, invia una risposta al client in formato JSON.
5. JavaScript riceve la risposta e la elabora, aggiornando il DOM senza fare un refresh completo.
## Esempio con fetch
Il server espone un endpoint JSON e il client lo chiama con `fetch`.

**Node.js (Express)**

```js
const express = require("express");

const app = express();
const port = 3000;

app.use(express.static("public"));

app.get("/api/message", (req, res) => {
    res.json({ message: "Questo messaggio è stato inviato dal server!" });
});

app.listen(port, () => {
    console.log("Server attivo su http://localhost:" + port);
});
```

**HTML**

```html
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8" />
    <title>AJAX</title>
    <script src="script/script.js"></script>
</head>
<body>
    <h1>Richiesta AJAX</h1>
    <button id="sendBtn">Invia richiesta</button>
    <p id="response"></p>
</body>
</html>
```

**JavaScript**

```js
window.onload = function () {
    const btn = document.getElementById("sendBtn");
    const responseP = document.getElementById("response");

    btn.addEventListener("click", async () => {
        try {
            const res = await fetch("/api/message");
            if (!res.ok) {
                throw new Error("Errore nella risposta");
            }
            const data = await res.json();
            responseP.textContent = data.message;
        }
        catch (err) {
            console.error("Errore:", err);
            responseP.textContent = "Errore nella richiesta";
        }
    });
};
```

## Async e await
*Definizione:* `async` indica che una funzione restituisce una **promise**: un oggetto che rappresenta il risultato futuro di un'operazione asincrona (stati: `pending`, `fulfilled`, `rejected`).

*Definizione:* `await` sospende l'esecuzione fino a quando la promise è risolta. Può essere usato solo dentro una funzione `async`, non blocca tutto il programma ma solo la funzione corrente, ed è zucchero sintattico per `.then()`.

Nell'esempio sopra, `await fetch("/api/message")` aspetta che la richiesta HTTP sia completata e arrivi la risposta, mentre `await res.json()` aspetta che il corpo della risposta venga letto e decodificato.

## express.json()
*Definizione:* `express.json()` è un **built-in middleware** di Express.js che consente di leggere e interpretare il corpo delle richieste HTTP (ad esempio i dati inviati da una form). Senza di esso, Express non può accedere direttamente a `req.body`.

Alternativa: `express.urlencoded()` per `application/x-www-form-urlencoded` (il formato predefinito per le form).

Altri built-in: `express.urlencoded()`.

## Parametri della fetch
- `method`: `"POST"` specifica il metodo HTTP utilizzato nella richiesta.
- `headers`: `{"Content-Type": "application/json"}` imposta l'intestazione per indicare che i dati sono in formato JSON.
- `body`: `JSON.stringify(data)` converte i dati in una stringa JSON da inviare nel corpo della richiesta.

## E i framework?
I framework più popolari come React e Vue utilizzano il **Virtual DOM**: una rappresentazione basata su JavaScript dell'interfaccia utente reale che aiuta a determinare quali parti devono essere aggiornate quando i dati cambiano.

In molti casi, l'overhead introdotto da questi strumenti supera i benefici. Secondo Lighthouse, una pagina HTML grezza può avere un tempo di First Meaningful Paint migliore di una pagina React renderizzata lato client.

## Casi reali
- GitHub ha rimosso jQuery dall'applicazione web, preferendo metodi nativi del browser e componenti personalizzati.
- Netflix ha eliminato React dal caricamento frontend predefinito, utilizzando JS vanilla per il codice lato client e riducendo i tempi di caricamento del 50%.
- Airbnb ha ridotto il peso delle pagine e introdotto l'uso efficiente di risorse e il lazy loading delle immagini.

## Alcune buone pratiche
- Prediligere siti statici o architetture serverless quando possibile.
- Usare tecnologie semplici (JS, HTML e CSS vanilla) quando possibile, senza framework pesanti.
- Non includere librerie solo per funzionalità minime.
- Ridurre peso e numero di risorse, caricando solo ciò che serve.
- Evitare tracciamenti e analytics superflui.

## Esercizio
Il PDF della lezione propone un esercizio con due funzionalità:
1. **Invio colore**: l'utente specifica un colore in una form; il colore viene inviato al server tramite POST e il server lo appende a un file di testo.
2. **Recupero ultimo colore**: l'utente clicca un bottone che invia una richiesta GET al server; il server restituisce l'ultimo colore salvato e il client lo usa per ricolorare lo sfondo della pagina.

Lo svolgimento completo è in `[[esercizi/eserciziAJAX.js|eserciziAJAX.js]]`.


