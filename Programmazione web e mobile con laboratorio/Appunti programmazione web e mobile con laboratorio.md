# Lezione 1: Architettura del Web e Fondamenti del Protocollo HTTP

## 1. Il World Wide Web (WWW) e gli Standard di Rete

Il **World Wide Web (WWW)** è un servizio informativo distribuito operante su infrastruttura Internet che permette agli utenti di navigare ed usufruire di contenuti eterogenei. Il Web connette i nodi della rete (computer, server, dispositivi mobili) mediante una struttura **ipertestuale**, ovvero un sistema di documenti contenenti rimandi e collegamenti bidirezionali (*hyperlink*) ad altre risorse.

L'ecosistema web poggia su tre standard cardine:
* **HTML (HyperText Markup Language):** linguaggio di markup preposto alla strutturazione semantica dei documenti e dei contenuti delle pagine web.
* **HTTP (HyperText Transfer Protocol):** protocollo applicativo che governa lo scambio e il trasferimento delle risorse informative tra client e server.
* **URL (Uniform Resource Locator):** schema standard di identificazione e localizzazione univoca delle risorse sul Web.

### 1.1 Il Linguaggio HTML
**HTML** (*HyperText Markup Language*) definisce la sintassi e la struttura formale delle pagine web secondo le specifiche standardizzate dal W3C. Viene impiegato per convenzione globale come linguaggio universale per descrivere l'albero degli elementi di un ipertesto.

## 2. Architettura Client-Server e il Browser

### 2.1 Il Modello Client-Server
Il Web è interamente imperniato sul modello architetturale **Client-Server**:
* **Client:** nodi richiedenti che interrogano il sistema e fruiscono delle risorse.
* **Server:** nodi centralizzati che ospitano, gestiscono, erogano e regolano gli accessi alle risorse condivise.

Le reti locali (LAN), i servizi internet e la quasi totalità dei sistemi informatici distribuiti adottano questo schema di cooperazione.

### 2.2 Il Ruolo del Browser
Il **browser** è un'applicazione software lato client specializzata nell'acquisizione, interpretazione, presentazione grafica e navigazione delle risorse presenti sul Web (pagine HTML, fogli di stile, script, contenuti multimediali). Il browser implementa nativamente le funzionalità di client per il protocollo HTTP, coordinando il download delle risorse remote a partire dal loro indirizzo URL.

## 3. Il Protocollo HTTP (HyperText Transfer Protocol)

**HTTP** è un protocollo di livello applicativo appartenente alla suite TCP/IP (corrispondente al livello applicativo della pila ISO/OSI). La comunicazione segue un pattern asimmetrico **Request-Response**, in cui ogni interazione ha origine da una richiesta esplicita del client (il browser) verso il server erogatore del servizio.

Al livello di trasporto sottostante, HTTP si appoggia su **TCP (Transmission Control Protocol)** per instaurare una connessione affidabile tra i due host, garantendo la consegna ordinata, integra e senza perdite dei pacchetti di rete.

> [!NOTE] Sicurezza del Canale di Comunicazione (TLS)
> L'estensione di sicurezza **TLS (Transport Layer Security)**, alla base del protocollo HTTPS, interpone un livello crittografico tra il trasporto TCP e l'applicazione HTTP. Ciò garantisce la cifratura end-to-end e l'integrità dei dati scambiati, neutralizzando il rischio di intercettazioni e attacchi di tipo *Man-in-the-Middle* (MitM).

### 3.1 Funzionalità Abilitate dal Protocollo HTTP
* **Caching:** memorizzazione locale temporanea delle risorse per minimizzare latenze e consumo di banda.
* **CORS (Cross-Origin Resource Sharing):** meccanismo di sicurezza basato su intestazioni HTTP che regola l'accesso alle risorse residenti su domini differenti da quello di origine.
* **Autenticazione:** intestazioni dedicate per la trasmissione sicura di credenziali o token di autorizzazione.
* **Proxying:** supporto per intermediari di rete (proxy e reverse proxy) dedicati a instradamento, bilanciamento del carico e sicurezza.
* **Gestione delle Sessioni:** conservazione logica dello stato applicativo dell'utente nel corso della navigazione.

### 3.2 La Natura Stateless e l'Uso dei Cookie
HTTP è un protocollo **stateless** (privo di stato): ciascuna transazione di richiesta/risposta è totalmente autonoma e isolata da quelle precedenti. Il server non trattiene alcuna memoria delle interazioni pregresse.

Per ovviare a questo vincolo e mantenere la continuità operativa (ad esempio per evitare di reintrodurre le credenziali a ogni cambio di pagina o per mantenere un carrello acquisti), si adottano i **Cookie**: stringhe di dati generate dal server, salvate in locale dal client e ritrasmesse automaticamente nelle successive richieste HTTP verso il medesimo dominio.

> [!INFO] Standardizzazione
> Anche HTTP è uno standard formale aperto, le cui specifiche tecniche sono definite e mantenute dall'IETF (Internet Engineering Task Force) mediante documenti RFC (*Request for Comments*).

### 3.3 Anatomia di una Richiesta HTTP
Una richiesta inoltrata dal client si compone di:
1. **Metodo (Verbo HTTP):** specifica l'operazione semantica da eseguire sulla risorsa (es. `GET`, `POST`, `PUT`, `DELETE`, `PATCH`, `HEAD`, `OPTIONS`).
2. **Path / URI:** il percorso gerarchico di rete indicante l'esatta risorsa target da recuperare o elaborare.
3. **Header (Intestazioni):** metadati ausiliari associati alla richiesta (es. formati accettati con `Accept`, informazioni sul client con `User-Agent`, cookie di sessione).
4. **Body (Payload):** corpo del messaggio (opzionale), impiegato nei metodi come `POST` o `PUT` per inviare dati strutturati (es. form o documenti JSON) al server.

```http
GET /api/v1/users/42 HTTP/1.1
Host: www.example.com
User-Agent: Mozilla/5.0
Accept: application/json
```

> [!IMPORTANT] Il Concetto di Idempotenza
> Un metodo HTTP è definito **idempotente** se l'esecuzione ripetuta della medesima richiesta produce il medesimo effetto collaterale sullo stato del server rispetto a una singola esecuzione. I metodi `GET`, `PUT` e `DELETE` sono idempotenti, mentre `POST` non è idempotente (richieste duplicate generano risorse duplicate).

### 3.4 Anatomia di una Risposta HTTP
La risposta restituita dal server si articola in:
1. **Status Code e Status Message:** codice numerico a tre cifre indicante l'esito dell'operazione, accompagnato da un testo descrittivo:
   * `2xx` (Successo, es. `200 OK`, `201 Created`).
   * `3xx` (Reindirizzamento, es. `301 Moved Permanently`).
   * `4xx` (Errori del Client, es. `400 Bad Request`, `401 Unauthorized`, `404 Not Found`).
   * `5xx` (Errori del Server, es. `500 Internal Server Error`).
2. **Header di Risposta:** informazioni relative al formato dei dati restituiti (`Content-Type`), alla lunghezza (`Content-Length`) e a direttive di memorizzazione (`Cache-Control`, `Set-Cookie`).
3. **Body (Payload):** corpo informativo opzionale contenente la rappresentazione della risorsa recuperata (es. file HTML, payload JSON, foglio CSS o asset binario).

```http
HTTP/1.1 200 OK
Date: Mon, 21 Sep 2026 12:00:00 GMT
Content-Type: application/json; charset=UTF-8
Content-Length: 48

{"id": 42, "name": "David", "status": "active"}
```

## 4. Struttura dell'URL e Risoluzione DNS

L'**URL** (*Uniform Resource Locator*) rappresenta la coordinata formale che individua univocamente una risorsa all'interno del Web.

```
schema://[sottodominio.]dominio.tld[:porta]/percorso/risorsa[?parametri][#ancora]
```

* **Schema/Protocollo:** specifica il canale di trasporto utilizzato (es. `http`, `https`).
* **Struttura di Dominio:** sequenza gerarchica composta da sottodominio, dominio di secondo livello e **Top Level Domain** (TLD, es. `.it`, `.com`, `.org`).
* **Porta di Rete:** identificatore numerico della porta di ascolto del servizio (opzionale; standardizzato a porta `80` per HTTP e porta `443` per HTTPS).
* **Path:** percorso logico della risorsa sul file system o nel router del server.
* **Query String:** parametri addizionali passati in formato chiave-valore per filtrare o arricchire la richiesta.
* **Fragment (Ancora):** puntatore a una coordinata interna o sezione specifica del documento target.

### 4.1 Processo di Risoluzione: da URL a Indirizzo IP
Affinché il browser possa aprire il socket di rete, il nome simbolico dell'host deve essere tradotto in un indirizzo IP numerico tramite il **DNS (Domain Name System)** attraverso la seguente trafila:

1. **Controllo della Cache Locale:** il browser interroga preliminarmente la propria cache e quella del sistema operativo alla ricerca della corrispondenza IP.
2. **Interrogazione al Server TLD:** in caso di assenza locale, il resolver contatta i server di competenza del rispettivo TLD (es. per `.it`).
3. **Risposta con Delegazione Autoritativa:** il server TLD risponde con l'indirizzo di rete del server DNS autoritativo responsabile di quel dominio.
4. **Interrogazione al Server DNS Autoritativo:** viene inoltrata la query specifica per l'intero record (comprensivo di domini secondari e sottodomini).
5. **Restituzione dell'Indirizzo IP:** il server autoritativo restituisce la stringa IP associata al nodo target.
6. **Apertura del Canale di Connessione:** il browser utilizza l'IP per instaurare la connessione TCP (con eventuale handshake TLS su porta 443) verso il server web.

## 5. Pipeline di Rendering nel Browser e la Triade del Web

Una volta ricevuta la risposta HTTP dal server, il motore del browser avvia la pipeline di elaborazione e render:
* **Costruzione del DOM (Document Object Model):** il browser scarica ed effettua il parsing sequenziale dell'HTML (che può essere statico o generato a run-time lato server, es. tramite PHP/Node.js), convertendo i tag in un grafo ad albero in memoria.
* **Costruzione del CSSOM:** scarica i file CSS, calcola le regole di stile e genera l'albero degli stili associato ai nodi per produrre il *Render Tree*.
* **Esecuzione di JavaScript:** il motore di script client-side esegue il codice per:
  * Manipolare dinamicamente i nodi dell'albero DOM e aggiornare in tempo reale la UI.
  * Gestire gli eventi utente ed effettuare chiamate asincrone in background verso le API del server (es. pattern AJAX / Fetch API).

> [!IMPORTANT] Principio di Separazione delle Responsabilità
> L'architettura del frontend moderno poggia sulla rigida separazione di tre livelli indipendenti:
> * **HTML:** governa esclusivamente la *struttura* logica e il *significato semantico* dei contenuti.
> * **CSS:** governa la *presentazione visuale*, il layout e la resa grafica.
> * **JavaScript:** governa il *comportamento dinamico* e la *logica applicativa*.
> 
> Mantenere questi tre ambiti disaccoppiati è fondamentale per garantire manutenibilità, modularità e pulizia del codice.

---

# Lezione 2: Struttura HTML5, Tag Semantici e Fondamenti di CSS3

## 1. Lo Standard HTML5

**HTML5** è la quinta revisione del linguaggio standard per la strutturazione dei documenti sul Web, sviluppata e mantenuta congiuntamente dal **W3C** (*World Wide Web Consortium*) e dal **WHATWG** (*Web Hypertext Application Technology Working Group*).

Le innovazioni cardine introdotte con HTML5 includono:
* **Tag Semantici Avanzati:** introduzione di elementi specifici per descrivere la struttura del documento in modo significativo per macchine e motori di ricerca.
* **Supporto Multimediale Nativo:** integrazione diretta di audio e video (tramite i tag `<audio>` e `<video>`) senza necessità di plugin proprietari esterni (es. Flash, Silverlight).
* **Progettazione Mobile-First:** architettura ottimizzata per garantire piena compatibilità con dispositivi mobili, schermi ad alta densità di pixel e interfacce basate su input touch.

## 2. Tassonomia e Tipologie di Tag HTML

Gli elementi HTML si classificano in base al loro comportamento sintattico e al loro posizionamento nel flusso del documento:

### 2.1 Tag Contenitori vs Tag Vuoti
* **Tag Contenitori (*Container / Paired Tags*):**
  Racchiudono del contenuto testuale o altri elementi annidati; richiedono obbligatoriamente sia il tag di apertura che quello di chiusura (`<tag>...</tag>`).
  * `<div>`: contenitore generico a livello di blocco privo di valore semantico proprio.
  * `<p>`: paragrafo destinato esclusivamente a blocchi di testo.
  * `<section>`: sezione tematica e logica di una pagina web, solitamente correlata da un'intestazione (`<h1>`-`<h6>`), contenuti dedicati ed elementi di separazione.
  
  > [!NOTE] Nota del Prof: Semantica e Indicizzazione SEO
  > Sebbene a livello visivo elementi come `<div>`, `<p>` e `<section>` possano apparire simili o assolvere funzioni visive analoghe, la differenza essenziale risiede nel loro **significato semantico**. I crawler e motori di ricerca (incluso Google) analizzano minuziosamente la struttura semantica: una marcatura scorretta o priva di gerarchia logica può penalizzare l'accessibilità e compromettere l'indicizzazione o la corretta resa della pagina.

* **Tag Vuoti / Auto-chiudenti (*Void / Empty Tags*):**
  Elementi che non racchiudono contenuti interni e non possiedono un tag di chiusura esplicito. Il loro comportamento è governato dagli attributi:
  * `<img>`: inclusione di immagini. Richiede gli attributi obbligatori:
    * `src`: percorso (*path*) del file immagine (relativo o assoluto).
    * `alt`: testo alternativo descrittivo, fondamentale per l'accessibilità (screen reader) e per l'ottimizzazione SEO.
    ```html
    <img src="fiore.jpg" alt="Girasole in campo">
    ```
  * `<input>`: elemento impiegato all'interno dei moduli di acquisizione (*form*) in cui l'utente digita o seleziona dati.
  * `<hr>`: linea orizzontale di separazione tematica (*horizontal rule*).

### 2.2 Tag di Blocco vs Tag di Linea
* **Tag di Blocco (*Block-Level Elements*):**
  Occupano l'intera larghezza orizzontale disponibile nel contenitore genitore e generano automaticamente un'interruzione di riga prima e dopo l'elemento. Possono contenere elementi inline e altri elementi di blocco.
  * Esempi: `<div>`, titoli `<h1>`–`<h6>`, `<p>`, `<section>`.
* **Tag di Linea / Inline (*Inline Elements*):**
  Non generano un ritorno a capo e occupano unicamente lo spazio orizzontale strettamente indispensabile al loro contenuto.
  * `<span>`: contenitore inline generico e privo di semantica, impiegato per isolare porzioni di testo al fine di applicare stili CSS mirati.
  * `<a>`: definisce un collegamento ipertestuale verso altre pagine o ancore interne mediante l'attributo `href`.
  * `<img>`: si comporta di default come elemento inline, posizionandosi lungo il flusso del testo senza forzare l'a capo.

## 3. Struttura Fondamentale di un Documento HTML5

Ogni pagina HTML5 valida rispetta uno scheletro di base rigoroso:

```html
<!DOCTYPE html>
<html lang="it">
  <head>
    <meta charset="utf-8">
    <title>Titolo della Pagina</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <h1>Intestazione Principale</h1>
    <p>Contenuto visibile all'interno della pagina web.</p>
  </body>
</html>
```

* `<!DOCTYPE html>`: definisce il tipo di documento comunicando al motore di rendering del browser che la pagina segue lo standard HTML5.
* `<html lang="it">`: elemento radice (*root*) dell'intero albero DOM, con parametro `lang` che specifica la lingua principale del testo.
* `<head>`: raccoglie metadati tecnici, codifiche, titoli e collegamenti a risorse esterne non visibili direttamente nella viewport.
* `<title>`: testo mostrato nella scheda o etichetta (*tab label*) della finestra del browser e utilizzato come titolo nei motori di ricerca.
* `<meta charset="utf-8">`: specifica la codifica dei caratteri; il parametro `charset` è obbligatorio e lo standard `utf-8` garantisce la corretta visualizzazione di caratteri speciali e accentati.
* `<body>`: contiene tutti gli elementi grafici e testuali effettivamente renderizzati a schermo per l'utente finale.

## 4. Attributi e Formattazione del Testo

### 4.1 Gli Attributi HTML
Gli attributi forniscono informazioni e configurazioni addizionali per un elemento HTML, alterandone il comportamento o l'aspetto.
* Si esprimono nella sintassi `nome="valore"` all'interno del tag di apertura.
* **Separazione dei Compiti (*Separation of Concerns*):** Sebbene HTML consenta l'inserimento di attributi di stile inline (es. `style="..."`), tale pratica è scorretta; le direttive di stile vanno allocate unicamente nei file CSS e gli script nei file JavaScript.

### 4.2 Elementi Semantici di Testo e Citazioni
* **`<strong>`:** indica che il testo racchiuso possiede una forte rilevanza semantica (i browser moderni ne enfatizzano la resa applicando il grassetto).
* **`<q>`:** elemento inline impiegato per **citazioni brevi**; il browser inserisce automaticamente le virgolette tipografiche attorno al testo senza mandare a capo.
* **`<blockquote>`:** elemento a livello di blocco impiegato per **citazioni lunghe o integrali**; viene renderizzato con un rientro laterale (*indentation*) e può ricevere la sorgente informativa tramite l'attributo `cite`.
* **`<br>`:** inserisce un'interruzione di riga forzata.

> [!WARNING] Regola d'Uso del Tag `<br>`
> Il tag `<br>` non deve mai essere impiegato per generare spaziatura verticale o impaginazione grafica tra paragrafi (compito demandato a margini e padding in CSS). Va utilizzato esclusivamente quando l'interruzione di riga costituisce parte integrante del contenuto informativo (ad esempio nei versi di una poesia o nella formattazione di indirizzi fisici).

## 5. Le Liste in HTML

Le liste consentono di organizzare insiemi di dati in modo coerente e strutturato:

1. **Liste Ordinate (`<ol>` - Ordered List):** I singoli elementi `<li>` (*list item*) sono contrassegnati da una sequenza numerata progressiva (1, 2, 3...).
2. **Liste Non Ordinate (`<ul>` - Unordered List):** I singoli elementi `<li>` sono preceduti da un marcatore grafico a punto (*bullet point*).
3. **Liste di Descrizione (`<dl>` - Description List):** Strutturate in coppie di termini (`<dt>`) e relative descrizioni (`<dd>`).

### Annidamento delle Liste (*Nesting*)
È possibile inserire una lista all'interno di un'altra: i browser differenziano graficamente la gerarchia applicando marcatori distinti ai vari livelli di profondità (ad esempio, pallino pieno per il livello radice e pallino vuoto o quadrato per i livelli annidati).

```html
<ul>
  <li>Primo Elemento</li>
  <li>Secondo Elemento con sotto-lista:
    <ul>
      <li>Sotto-elemento A</li>
      <li>Sotto-elemento B</li>
    </ul>
  </li>
</ul>
```

## 6. Fondamenti di CSS3 (Cascading Style Sheets Level 3)

**CSS3** è lo standard per la definizione dello stile e della resa visiva dei documenti strutturati in HTML.

* **Finalità:** elevare l'esperienza visiva dell'utente (UX/UI), snellire e modulare la scrittura del codice di presentazione e garantire layout responsive capaci di adattarsi dinamicamente a display di dimensioni e risoluzioni differenti.
* **Collegamento al documento HTML:** all'interno della sezione `<head>` si inserisce il tag:
  ```html
  <link rel="stylesheet" href="stile.css">
  ```
  dove `rel` specifica il tipo di relazione (`stylesheet`) e `href` indica il path del file sorgente CSS.

### 6.1 Anatomia di una Regola CSS
Una regola CSS si compone di un **selettore** e di un **blocco di dichiarazione**:

```css
selettore {
  proprieta: valore;
  altra-proprieta: valore;
}
```

* **Selettore:** individua i nodi del DOM a cui applicare le direttive (es. `h1` seleziona tutti i titoli di primo livello della pagina).
* **Blocco di Dichiarazione:** racchiuso tra parentesi graffe `{ ... }`, contiene una sequenza di coppie `proprietà: valore;` tassativamente terminate dal punto e virgola `;`.

## 7. Proprietà di Testo, Tipografia e Unità di Misura

### 7.1 Gestione dei Colori
La proprietà `color` determina il colore del testo di un elemento e supporta molteplici notazioni:
* **Esadecimale:** prefissato da cancelletto (es. `#ff0000` o forma abbreviata `#f00`).
* **Notazione RGB / RGBA:** `rgb(255, 0, 0)` o con canale alfa di trasparenza `rgba(255, 0, 0, 0.8)`.
* **Keyword Nominali:** nomi standard dei colori (es. `red`, `blue`, `black`).

### 7.2 Tipografia e Font
* `font-family`: specifica la famiglia di caratteri da applicare. Si distinguono le macro-famiglie generiche:
  * `serif`: font dotati di grazie/terminali sui tratti.
  * `sans-serif`: font lineari privi di grazie.
  * `monospace`: font a spaziatura fissa in cui ogni carattere occupa la medesima larghezza.
* `font-style`: definisce lo stile del testo (`normal`, `italic`, `oblique`).
* `font-size`: imposta la dimensione del carattere (espressa in pixel `px`, `em`, `%`, `rem`).
* `font-weight`: imposta lo spessore del tratto del font (valori numerici da `100` a `900` a passi di 100, oppure keyword come `normal`, `bold`).

> [!NOTE] Nota del Prof: Fallback dei Font
> Non tutti i font supportano nativamente l'intera gamma di varianti e pesi tipografici. Qualora una specifica combinazione non sia presente nel file font, il browser adotta un meccanismo di fallback adattando la resa alla variante disponibile più vicina.

### 7.3 Allineamento e Decorazione
* `text-align`: allineamento orizzontale del testo (`left`, `center`, `right`, `justify`).
* `text-decoration`: decorazioni di linea (`underline`, `overline`, `line-through`, `none`).
* `text-transform`: trasformazione del maiuscolo/minuscolo (`uppercase`, `lowercase`, `capitalize`, `none`).

### 7.4 Unità di Misura
* **Pixel (`px`):** unità di misura **assoluta** a dimensione fissa. Assicura precisione millimetrica ma è priva di scalabilità automatica rispetto alle preferenze utente o ai display ad alta densità.
* **`em`:** unità di misura **relativa** calcolata rispetto al `font-size` dell'elemento corrente o del genitore immediato. Offre grande flessibilità ma in strutture con molti livelli di annidamento può causare un effetto moltiplicativo esponenziale.
* **Percentuale (`%`):** unità di misura **relativa** calcolata direttamente sul valore della proprietà dell'elemento genitore, garantendo un rapporto proporzionale diretto e intuitivo.

## 8. Ereditarietà e Meccanismo della Cascata in CSS

### 8.1 Ereditarietà (*Inheritance*)
L'ereditarietà consente ad alcune proprietà di stile (in particolare quelle tipografiche e di colore) di propagarsi automaticamente dagli elementi genitore ai relativi elementi figli:
* Se un elemento figlio non dichiara uno stile esplicito, adotterà automaticamente quello ereditato dal genitore.
* Se l'elemento figlio definisce una propria regola, questa sovrascrive (*override*) il valore ereditato.

> [!EXAMPLE] Esempio di Calcolo con Unità Relative
> Se il tag `body` definisce una dimensione tipografica `font-size: 2em` e un paragrafo `<p>` figlio dichiara `font-size: 0.5em`, la dimensione calcolata effettiva del testo nel paragrafo sarà pari a:
> $$2\,\text{em} \times 0.5 = 1\,\text{em}$$
> calcolata rispetto alla dimensione base originaria della radice.

### 8.2 Ordine a Cascata e Sovrascrittura
I motori dei browser analizzano ed eseguono le regole CSS seguendo l'ordine sequenziale del codice sorgente:
* A parità di selettore e specificità, l'ultima regola dichiarata sovrascrive quelle antecedenti.
* *Esempio:* Se un paragrafo viene prima impostato con `p { color: red; }` e successivamente con `p { color: blue; }`, il browser applicherà il colore blu.

## 9. Gestione degli Sfondi (Background)

Il CSS mette a disposizione un set completo di proprietà per governare lo sfondo degli elementi:

* `background-color`: imposta il colore di sfondo uniforme dell'elemento (supporta gli stessi formati di `color`).
* `background-image`: imposta un'immagine come sfondo tramite la sintassi `url('percorso/immagine.png')`.
* `background-repeat`: stabilisce le modalità di ripetizione dell'immagine (`repeat`, `no-repeat`, `repeat-x`, `repeat-y`).
* `background-position`: definisce la coordinata di ancoraggio iniziale dell'immagine di sfondo (`top`, `bottom`, `left`, `right`, `center`, percentuali o pixel).
* `background-size`: controlla il dimensionamento dell'immagine:
  * `cover`: ridimensiona l'immagine affinché copra interamente la superficie del contenitore (ritagliando le parti eccedenti se le proporzioni differiscono).
  * `contain`: ridimensiona l'immagine per farla rientrare interamente nel contenitore senza ritagli o deformazioni.
* `background-attachment`: determina se lo sfondo scorre solidale con il resto della pagina (`scroll`) oppure rimane fisso rispetto alla viewport durante lo scrolling (`fixed`).

## 10. Confronto Tecnico: Tag `<img>` vs Proprietà CSS `background-image`

| Caratteristica | Tag `<img>` (HTML) | Proprietà `background-image` (CSS) |
| :--- | :--- | :--- |
| **Scopo Primario** | Parte integrante del contenuto semantico del documento | Scopo puramente decorativo ed estetico |
| **Accessibilità** | Elevata: supporta l'attributo `alt` letto dagli screen reader | Nulla: non accessibile alle tecnologie assistive |
| **Ottimizzazione SEO** | Rilevante: indicizzato e ricercabile sui motori di ricerca | Non rilevante: ignorato dai crawler di indicizzazione |
| **Dimensionamento** | Definito tramite attributi HTML (`width`, `height`) o CSS | Gestito interamente tramite `background-size` |
| **Posizionamento** | Segue il normale flusso strutturale del documento (inline) | Flessibile e posizionabile liberamente con `background-position` |
| **Ripetizione** | Non ripetibile (singola istanza nel DOM) | Configurabile e ripetibile tramite `background-repeat` |
| **Ruolo nel Layout** | Elemento fisico del DOM che occupa spazio nel flusso | Risiede sullo strato di sfondo, dietro a tutti i contenuti |
