//ES 0
//console.log("Ciao mondo!");

//ES 1
//function generateRandomNumber() {
//    return Math.floor(Math.random() * 10) + 1;
//}
//
//let randomNumber = generateRandomNumber();
//console.log("Il numero casuale generato è: " + randomNumber);

//ES 2
//function guessRandomNumber() {
//    const r = Math.floor(Math.random() * 10) + 1;
//
//    console.log("Guess the number among 1 and 10:\n")
//
//    ProcessingInstruction.stdin.on("data", function (input) {//.on è un listener
//        const guess = parseInt(input);
//
//        if (guess === randomNumber) {
//            console.log("Congrats! You guessed right\n");
//            process.exit(); 
//        } else if (guess < randomNumber) {
//            console.log("Too low, try again\n");
//        } else if (guess > randomNumber) {
//            console.log("Too high, try again\n");
//        } else {
//            console.log("Please enter a valid number\n");
//        }
//    });
//}

const http = require('http'); //per creare il server
const fs = require('fs'); //per leggere e scrivere file

const server = http.createServer((req, res) => {// req è la risposta del client e res è la risposta del server
    let filePath = '';
    // Mappa dei percorsi per il routing manuale
    if (req.url === '/') {
        filePath = 'index.html';
    } else if (req.url === '/about') {
        filePath = 'about.html';
    } else if (req.url === '/contact') {
        filePath = 'contact.html';
    } else {
        filePath = '404.html';
    }
    // Leggi il file e restituiscilo come risposta
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
// Avvia il server sulla porta 3000
server.listen(3000, () => {
    console.log('Server in ascolto su http://localhost:3000');
});

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

//Server con Express
//const express = require('express');
//const app = express();
//const PORT = 3000;
//app.get('/', (req, res) => res.sendFile(__dirname + '/index.html'));
//app.get('/about', (req, res) => res.sendFile(__dirname + '/about.html'));
//app.get('/contact', (req, res) => res.sendFile(__dirname + '/contact.html'));
//
//// Middleware per gestire errori 404 (pagina non trovata)
//app.use((req, res) => {
//    res.status(404).sendFile(__dirname + '/404.html');
//});
//app.listen(PORT, () => {
//    console.log(`Server in ascolto su http://localhost:${PORT}`);
//});


//Aggiungere un middleware che, ad ogni richiesta ricevuta dal server, stampa il metodo HTTP, l'URL della richiesta e la durata 
//dell’operazione. Questo middleware deve essere dichiarato prima delle altre route, altrimenti non verrebbe eseguito per le 
//richieste già gestite. Altri middleware (ad esempio quello per gli errori 404) devono esseredichiarati dopo le route per gestire 
//ciò che non è stato intercettato prima
// Middleware per loggare il metodo HTTP, l'URL e la durata della richiesta
//app.use((req, res, next) => {
//    const start = Date.now(); // Tempo di inizio
//    res.on('finish', () => { // Eseguito quando la risposta viene inviata
//        const duration = Date.now() - start;
//        console.log(`${req.method} ${req.url} - ${duration}ms`);
//    });
//    next();
//});


//Invece di gestire ogni rotta manualmente con res.sendFile(), usare express.static() per gestire i file statici. 
//Express.js cercherà i file direttamente nella cartella public/ senza bisogno di dichiarare ogni route
//const express = require('express');
//const app = express();
//const PORT = 3000;
//app.use(express.static(__dirname + '/public'));
//app.use((req, res) => {
//    res.status(404).sendFile(__dirname + '/public/404.html');
//});
//app.listen(PORT, () => {
//    console.log(`Server in ascolto su http://localhost:${PORT}`);
//});

