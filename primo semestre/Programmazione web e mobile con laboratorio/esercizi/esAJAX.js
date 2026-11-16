const express = require("express");
const fs = require("fs");
const app = express();
const port = 3000;

const file = "colori.txt";

app.use(express.static("public"));
app.use(express.json());

// Route per salvare un colore
app.post("/write-color", (req, res) => {
    const { colore } = req.body;
    fs.appendFile(file, colore + "\n", err => {
        if (err) return res.status(500).send("Errore nel salvataggio");
        res.status(200).send("Colore salvato");
    });
});

// Route GET per recuperare l'ultimo colore
app.get("/read-color", (req, res) => {
    fs.readFile(file, "utf-8", (err, data) => {
        if (err) return res.status(500).send("Errore nella lettura");
        const righe = data.trim().split("\n");
        const ultimo = righe[righe.length - 1];
        res.json({ colore: ultimo });
    });
});

app.listen(port, () => {
    console.log("Server in ascolto su http://localhost:" + port);
});