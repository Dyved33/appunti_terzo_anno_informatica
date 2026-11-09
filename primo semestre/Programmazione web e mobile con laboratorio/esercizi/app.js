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
//    ProcessingInstruction.stdin.on("data", function (input) {//.on è un listner
//        const guess = parseInt(input);
//
//        if (guess === randomNumber) {
//            console.log("Congrats! You guessed right\n");
//            process.exit(); 
//        } else if (guess < randomNumber) {
//            console.log("Too low, try again\n");
//        } else if (guess > randomNumber) {
//            console.log("Too low, try again\n");
//        } else {
//            console.log("Please enter a valid number\n");
//        }
//    });
//}

const http = require('http');
const fs = require('fs');
const server = http.createServer((req, res) => {
    let filePath = '';
    // Mappa dei percorsi
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

s.readFile('file.txt', 'utf8', (err, data) => {
    if (err) {
        console.error('Errore nella lettura:', err);
        return;
    }
    console.log(data);
});