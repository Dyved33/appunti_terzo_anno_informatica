# Gestione login (JWT e autenticazione)

## Cookies vs sessioni

*Definizione:* Cookie e sessione sono due meccanismi per mantenere lo stato di un utente tra richieste HTTP, che per natura è un protocollo senza stato.

| Aspetto | Cookie | Sessione |
|---|---|---|
| Dove è memorizzato | Sul client (browser, nei dati locali) | Sul server (in memoria, le, DB, ecc.) |
| Chi lo gestisce | Il browser, ma può essere letto/scritto dal server | Gestito dal server, spesso con un identificatore salvato nel cookie |
| Persistenza | Può essere persistente (es. `expires=...`) | Di solito temporanea (finché la sessione non scade) |
| Sicurezza | Il contenuto è visibile/modificabile dal client (se non firmato o criptato) | Sicura: i dati sensibili restano sul server |
| Usi tipici | Ricordare preferenze, token, dati non critici | Tracciare login utente, carrello, autenticazioni |
| Limiti | Max 4KB per cookie, max 20 cookie per dominio circa | Nessun limite pratico salvo risorse di sistema |

*Osservazione:* il cookie è solo un contenitore dell'identificatore, mentre i dati della sessione sono sul server.

## Per il login

*Sessione:* il server crea una sessione (con un ID) quando l'utente fa login e salva nella sessione i dati dell'utente (es. `userId`, `ruolo`).

*Cookie:* il server invia un cookie contenente il session ID; il session ID viene rinviato dal browser ad ogni richiesta.

## JSON Web Token (JWT)

*Definizione:* un JWT è un token compatto, firmato e auto-contenuto che rappresenta in modo sicuro delle informazioni (ad esempio l'identità di un utente). Viene spesso usato per gestire autenticazione stateless ed è un'alternativa più adatta per architetture RESTful.

## Struttura di un JWT

Un JWT è una stringa divisa in tre parti separate da punti:

`HEADER.PAYLOAD.SIGNATURE`

Un esempio reale può somigliare a:

`eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMywicm9sZSI6InVzZXIifQ.KZ3bqTD5qE6u9TxqRnk8eE3I1xIXKn8jx0M78D-Tm_Q`

## JWT Header

È un oggetto JSON che descrive come è firmato il token:

```json
{
    "alg": "HS256",
    "typ": "JWT"
}
```

- `alg`: l'algoritmo di firma
- `typ`: tipo di token

Viene codificato con base64url in una stringa compatibile con le URL.

## JWT Payload

Contiene le informazioni da trasmettere:

```json
{
    "userId": 123,
    "role": "admin",
    "exp": 1716103600
}
```

- `exp`: timestamp di scadenza
- Anche questo è base64url encoded

> [!info] In altre parole: il payload non è criptato, solo codificato. Chiunque legga il token può decodificarlo e vedere i dati. Non inserire mai dati sensibili nel payload.

## JWT Signature

Serve a verificare che il token non sia stato modificato. Si calcola così:

```
HMACSHA256(
    base64urlEncode(header) + "." +
    base64urlEncode(payload),
    secret
)
```

- Il server firma il token con una chiave segreta
- Se il token viene modificato, la firma non combacerà e sarà considerato non valido

## Sessioni vs JWT

| Caratteristica | Sessione (cookie-based) | JWT (token-based) |
|---|---|---|
| Stato lato server | Sì (memorizzata in RAM/Redis/DB) | No (stateless, il server non conserva nulla) |
| Scalabilità | Richiede session store centralizzato | Scalabile orizzontalmente |
| Autenticazione RESTful | Non aderente al principio stateless REST | Compatibile con REST API |
| Verifica lato server | Sessione trovata via ID in cookie | JWT verificato tramite firma |
| Trasmissione credenziali | Cookie (automatico nei browser) | Header `Authorization: Bearer <token>` |
| Client non browser (es. app mobile) | Cookie da gestire manualmente | Semplice: header standard |
| Gestione logout | Facile: distruggi la sessione | Difficile: serve blacklist o short expiry |
| Durata credenziali | Controllata dal server | Controllata da `exp` nel token |

## Creazione di un token

HS256 è un algoritmo di firma simmetrica.

```js
const jwt = require("jsonwebtoken");

const JWT_SECRET = "mia_chiave_super_segreta";

const payload = {
    userId: "user1",
    email: "user1@email.com",
};

const token = jwt.sign(payload, JWT_SECRET, {
    algorithm: "HS256",
    expiresIn: "1h"
});
```

## Funzione di login

```js
app.post("/api/login", async (req, res) => {
    const { email, password } = req.body;
    const query = "SELECT id, nome FROM utenti WHERE email = ? AND password = ?";
    try {
         const [righe, colonne] = await pool.promise().execute(query, [email, password]);
         const user = righe[0];
         const payload = {
             userId: user.id,
             userName: user.nome,
         };
         const token = jwt.sign(payload, JWT_SECRET, {
             algorithm: "HS256",
             expiresIn: "1h"
         });
         res.cookie("token", token, {
             httpOnly: true,
             secure: true,
             maxAge: 3600000,
             sameSite: "Strict"
        });
         return res.json({
             success: true,
             message: "Login riuscito"
         });
    }
    ...
});
```

- const payload = … prepara il payload da inserire nel JWT
- `jwt.sign(payload, JWT_SECRET, {…})` genera il token
	- Firmato con la chiave JWT_SECRET
	- Usando algoritmo e altri parametri specificati
- `res.cookie()` imposta un cookie con il token

## Accesso a pagine protette

- Utente con token valido: accede ai le nella cartella `/private`
- Utente senza token o token invalido/scaduto: `redirect`

```js
function authenticateToken(req, res, next) {
    const token = req.cookies.token;
    if (!token) {
        return res.redirect(302, "/index.html");
    }
    try {
         const payload = jwt.verify(token, JWT_SECRET);
         req.user = payload;
         next();
    }
    catch (err) {
        return res.redirect(302, "/index.html");
    }
}

app.use("/private", authenticateToken, express.static("private"));
```

`authenticateToken` verifica se l'utente è autenticato.

## Logout

- `authenticateToken` veri ca se l’utente è autenticato
- `res.clearCookie("token")` cancella il cookie token dal browser: equivale a fare logout, poiché senza token il client non potrà più accedere alle risorse protette.

```js
app.post("/api/logout", authenticateToken, (req, res) => {
    res.clearCookie("token");
    res.json({
        success: true,
        message: "Logout effettuato"
    });
});
```

## Problemi di sicurezza

### Furto del JWT

Se il token è accessibile via JavaScript (es. `localStorage`), può essere rubato tramite attacchi XSS.

- Usare `HttpOnly` cookies, in modo che JavaScript non possa leggere il token
- Usare `Secure: true` in produzione per trasmettere solo su HTTPS

### Cross-site scripting (XSS)

L'attaccante inietta codice JS malevolo che accede a dati sensibili.

- Sanitizzare sempre input e output HTML
- Usare Content-Security-Policy lato server per limitare JS esterno
- Usare `HttpOnly` per cookie critici (come il token JWT)

### Cross-site request forgery (CSRF)

Un sito esterno induce un browser autenticato a eseguire richieste non volute verso il tuo server.

- Attivare CSRF protection (es. token anti-CSRF)
- Impostare i cookie con `SameSite=Lax` o `SameSite=Strict` per limitarne l'invio

### Token leakage

Un token può finire nei log, in URL, ecc.

- Non mettere JWT nei parametri URL
- Usa cookie `HttpOnly` oppure `Authorization` header

### Token replay

Un token rubato viene riutilizzato per impersonare l'utente.

- Aggiungere scadenze brevi (`expiresIn: "1h"`)
- Considerare blacklist con log-out lato server

### Manomissione token

Se la chiave di firma è debole o compromessa, un attaccante può firmare token falsi.

- Usare chiavi lunghe e segrete per HS256
- Valutare RS256 per firmare con chiave privata (più sicuro per ambienti distribuiti)