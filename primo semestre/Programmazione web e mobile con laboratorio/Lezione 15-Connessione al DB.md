# Connessione al DB — mysql2, pool di connessioni e transazioni

## DB e Node.js
*Definizione:* Per connettersi a un database in [[Lezione 12-Node.js e NPM|Node.js e NPM]] si usa una libreria specifica per il db.

Il processo è simile per la maggior parte dei casi:
1. Installare la libreria adatta (mysql2, pg, mongoose, …)
2. Configurare la connessione fornendo le credenziali (host, porta, utente, password, nome db)
3. Aprire la connessione tramite un metodo fornito dalla libreria
4. Eseguire le query sul database
5. Gestire gli errori e, se necessario, chiudere la connessione

## I database più comuni
*Definizione:* I database si distinguono per tipo di modello dati, schema, supporto JSON, transazioni, scalabilità e conformità SQL.

| | MySQL | PostgreSQL | MongoDB |
|---|---|---|---|
| Tipo | Relazionale (SQL) | Relazionale avanzato (SQL) | NoSQL documentale (JSON-like) |
| Schema | Rigidamente definito | Rigidamente definito ma estendibile | Flessibile (schema-less) |
| Supporto JSON | Parziale | Nativo e potente | Nativo (BSON) |
| Transazioni | ACID (Atomicità, Coerenza, Isolamento, Durabilità) | ACID completo | Limitate (transazioni multi-doc recenti) |
| Scalabilità | Verticale | Orizzontale (sharding) | Orizzontale (sharding) |
| Prestazioni | Buone | Ottime anche su query complesse | Ottime su grandi volumi e scritture |
| Conformità SQL | Media | Elevata | N/D (usa query JSON-like) |
| Caso d'uso tipico | Web app, CMS, ecommerce | App complesse, analytics, Business Intelligence | App distribuite, IoT, prototipi rapidi |

*Osservazione:* MySQL è il database usato negli esempi della lezione, attraverso la libreria mysql2 per Node.js.

## Operazioni CRUD
*Definizione:* Le operazioni CRUD sono le quattro operazioni di base che si possono eseguire su qualsiasi data store.
- **Create**: inserimento di nuovi dati nel sistema
- **Read**: recupero dei dati esistenti per visualizzarli o analizzarli
- **Update**: modifica di dati esistenti per correggerli o aggiornarli
- **Delete**: rimozione di dati che non sono più necessari

*Osservazione:* Si applicano a database e alle API per interagire con le risorse.

## MySQL su Ubuntu
- Installare MySQL: `sudo apt-get install mysql-server`
- Verificare la versione: `mysql --version`
- Avviare il servizio: `sudo systemctl start mysql`
- Verificare lo stato: `sudo systemctl status mysql`
- Sicurezza: `sudo mysql_secure_installation`
- Accedere alla shell MySQL: `sudo mysql -u root -p`

## Creare database e tabelle
1. `CREATE DATABASE mio_db;`
2. `SHOW DATABASES;`
3. `USE mio_db;`
4.
```sql
CREATE TABLE utenti (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   email VARCHAR(100) NOT NULL
);
```
5. `SHOW TABLES;` / `DESCRIBE utenti;`

Esempio di output di `DESCRIBE utenti`:
| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| id | int | NO | PRI | NULL | auto_increment |
| nome | varchar(100) | NO | | NULL | |
| email | varchar(100) | NO | | NULL | |

## Nuovo utente e permessi
1. `CREATE USER 'user1'@'localhost' IDENTIFIED BY 'pass1';`
2. `SELECT user, host FROM mysql.user;`
3. `GRANT ALL PRIVILEGES ON mio_db.* TO 'user1'@'localhost';`
4. `FLUSH PRIVILEGES;`
5. `SHOW GRANTS FOR 'user1'@'localhost';`

## mysql2
*Definizione:* mysql2 è una libreria Node.js che fornisce un'interfaccia a MySQL.

*Caratteristiche:*
- Compatibile con MySQL 5.5+ e MariaDB
- Interfaccia asincrona: promises, async/await e callback
- Supporta gestione pool e connessioni persistenti

*Installazione:* `npm install mysql2`

## Connessione al database
*Definizione:* `mysql.createConnection()` crea una connessione al db; il metodo `.connect()` apre la connessione al db.

```js
const connection = mysql.createConnection({
    host: "localhost",
    user: "user1",
    password: "pass1",
    database: "mio_db"
});

connection.connect((err) => {
    if (err) {
        console.error("Errore nella connessione al database: " + err.stack);
        return;
    }
    console.log("Connesso al database con ID " + connection.threadId);
});
```

## Esecuzione della query
- `connection.execute()` esegue una query parametrizzata
- `query` è una stringa SQL con placeholder `?`
- `[nome, email]` è l'array dei valori da usare nei placeholder

```js
const query = "INSERT INTO utenti (nome, email) VALUES (?, ?)";

connection.execute(query, [nome, email], (err, results) => {
    if (err) { // Internal Server Error
        console.error("Errore: " + err.stack);
        return res.status(500).json({ success: false, message: "Errore!" });
    }
    return res.json({ success: true, message: "Successo!" });
});
```

## Modalità di connessione
**Connessione globale:** `mysql.createConnection()` crea una singola connessione persistente tra Node.js e MySQL. Rimane aperta finché non viene chiusa esplicitamente con `connection.end()`. Non va bene per servire più richieste HTTP perché può andare in timeout e chiudersi da sola, e può causare problemi di concorrenza.

**Connessione isolata:** `createConnection()` e `.execute()` dentro ogni route GET/POST.
- Vantaggio: sicura per la concorrenza: ogni richiesta ha la sua connessione.
- Svantaggio: costi elevati per gestire apertura e chiusura della connessione ad ogni richiesta.

**Connessione condivisa:** `createConnection()` globale e solo `.execute()` dentro ogni route GET/POST.
- Vantaggi: solo apparenti.
- Svantaggi: gli stessi problemi della connessione globale.

## Connection pool
*Definizione:* Un connection pool è un insieme di connessioni mantenute attive e riutilizzate per le richieste concorrenti.

Il pool gestisce:
- richieste concorrenti
- riuso e chiusura delle connessioni
- rilascio automatico della connessione al termine della query

Esempio di pool:
```js
const pool = mysql.createPool({
    host: "localhost",
    user: "user1",
    password: "pass1",
    database: "mio_db",
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

app.get("/users", async (req, res) => {
    const query = "SELECT * FROM utenti";
    const connection = await pool.promise().getConnection();
    try {
        const [righe, colonne] = await connection.execute(query);
        res.json(righe);
    }
    catch (err) {
        console.error("Errore durante l'esecuzione della query:", err);
        res.status(500).json({success: false, message: "Errore" });
    }
    finally {
        connection.release();
    }
});
```

**Configurazione del pool:**
- `createPool()` crea un pool di connessioni al db
- `waitForConnections` decide se le richieste devono aspettare una connessione libera quando il pool è pieno
- `connectionLimit` imposta un massimo di connessioni simultanee nel pool
- `queueLimit` imposta un numero massimo di richieste in attesa
- `.promise()` serve per usare `await` con `.execute()`
- `.release()` rilascia la connessione

## Transazioni
*Definizione:* Una transazione è un'unità di lavoro atomica che raggruppa una o più operazioni di db in un'unica operazione logica.

Le transazioni garantiscono che tutte le operazioni siano eseguite con successo o nessuna di esse venga applicata in caso di errore.

*Esempio pratico:* trasferimento di denaro tra due conti bancari: addebito sul primo conto e accredito sul secondo. Se una di queste operazioni fallisce, la transazione garantisce che nessuna delle operazioni venga applicata.

Esempio di transaction:
```js
app.post("/registration", async (req, res) => {
    const { nome, email, evento_id, posto_id, importo } = req.body;
    const connection = await pool.promise().getConnection();
    try {
        await connection.beginTransaction();

        // 1. Inserisco l'utente come partecipante
        const insertPart = "INSERT INTO partecipanti (nome, evento_id) VALUES (?, ?)";
        await connection.execute(insertPart, [nome, evento_id]);

        // 2. Segno il posto come prenotato
        const insertPrenot = "INSERT INTO posti (evento_id, posto_id, nome) VALUES (?, ?, ?)";
        await connection.execute(insertPrenot, [evento_id, posto_id, nome]);

        // 3. Registro il pagamento
        const insertIncasso = "INSERT INTO incassi (evento_id, nome, importo) VALUES (?, ?, ?)";
        await connection.execute(insertIncasso, [evento_id, nome, importo]);
        await connection.commit();
        console.log("Transazione completata con successo");
        return res.json({ success: true, message: "Successo!" });
    }
    catch (err) {
        await connection.rollback();
        console.error("Errore nella transazione, rollback:", err);
        return res.status(500).json({ success: false, message: "Errore!" });
    }
    finally {
        connection.release();
    }
});
```

**Metodi per transaction:**
- `await pool.promise().getConnection()` ottiene una connessione dal pool
- `await connection.beginTransaction()` avvia una transazione in modo asincrono
- `await connection.execute()` esegue una singola query in modo asincrono
- `await connection.commit()` rende permanenti le modifiche una volta che tutte le operazioni della transazione sono state completate con successo
- `await connection.rollback()` annulla tutte le modifiche effettuate se si verifica un errore durante la transazione
- `connection.release()` rilascia la connessione al termine della transazione e la restituisce al pool

> [!info] Sintesi:
> - Per connettersi a un db in Node.js si installa la libreria specifica (mysql2 per MySQL), si configurano le credenziali, si apre la connessione e si eseguono le query.
> - `mysql.createConnection()` apre una singola connessione persistente; `connection.execute()` esegue query parametrizzate con placeholder `?`.
> - La connessione globale va bene per pochi casi, quella isolata è sicura per la concorrenza ma costosa, quella condivisa ha solo apparenti vantaggi.
> - Il connection pool mantiene connessioni attive e riutilizzabili; si configura con `waitForConnections`, `connectionLimit`, `queueLimit`, si usa `.promise()` con `await` e si rilascia con `.release()`.
> - Una transazione raggruppa più operazioni in un'unità atomica: `beginTransaction`, `execute`, `commit` o `rollback`, poi `release`.
