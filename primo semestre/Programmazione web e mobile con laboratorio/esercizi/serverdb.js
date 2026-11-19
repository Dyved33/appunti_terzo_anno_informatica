const express = require("express");
const mysql = require("mysql2");

const app = express();

app.use(express.static("public"));
app.use(express.json());

// Creo la connessione al db
const connection = mysql.createConnection({
    host: "localhost",
    user: "user1",
    password: "pass1",
    database: "mio_db"
});

// Mi connetto al db
connection.connect((err) => {
    if (err) {
        console.error("Errore nella connessione al database: " + err.stack);
        return;
    }
    console.log("Connesso al database con ID " + connection.threadId);
});

// API per aggiungere un utente
app.post("/add-user", (req, res) => {

    const { nome, email } = req.body;

    if (!nome || !email) { // Bad Request
        return res.status(400).json({ success: false, message: "Nome ed email sono obbligatori!" });
    }

    // Preparo la query di inserimento
    const query = "INSERT INTO utenti (nome, email) VALUES (?, ?)";

    connection.execute(query, [nome, email], (err, results) => {
        if (err) { // Internal Server Error
            console.error("Errore nell\'inserimento: " + err.stack);
            return res.status(500).json({ success: false, message: "Errore nell\'inserimento nel database" });
        }
        return res.json({ success: true, message: "Utente aggiunto con successo!" });
    });

});

// API per recuperare la lista utenti
app.get("/users", (req, res) => {
    const query = "SELECT * FROM utenti";
    connection.execute(query, (err, results) => {
        if (err) {
            console.error("Errore nel recupero degli utenti: " + err.stack);
            return res.status(500).json({ success: false, message: "Errore nel recupero degli utenti" });
        }
        res.json(results);
    });
});

app.listen(3000, () => {
    console.log("Server in ascolto sulla porta 3000");
});