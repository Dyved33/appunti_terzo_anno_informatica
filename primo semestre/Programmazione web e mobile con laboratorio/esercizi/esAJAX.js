const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();
const port = 3000;
const fileColori = path.join(__dirname, "colori.txt");

app.use(express.json());
app.use(express.static("public"));

app.post("/api/colore", (req, res) => {
    const { colore } = req.body;
    if (!colore) {
        return res.status(400).json({ errore: "Colore non specificato" });
    }
    fs.appendFileSync(fileColori, colore + "\n");
    res.json({ messaggio: "Colore salvato", colore });
});

app.get("/api/colore", (req, res) => {
    let ultimo = null;
    if (fs.existsSync(fileColori)) {
        const righe = fs.readFileSync(fileColori, "utf-8").split("\n").filter(Boolean);
        ultimo = righe[righe.length - 1];
    }
    res.json({ colore: ultimo });
});

app.listen(port, () => {
    console.log("Server attivo su http://localhost:" + port);
});