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

![[Pasted image 20260925163437.png]]
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

---

# Lezione 3: Box Model CSS, Selettori Avanzati, Tabelle e Form HTML5

## 1. Il Box Model in CSS

Nel motore di rendering dei browser, ogni singolo elemento presente all'interno del Document Object Model (DOM) viene rappresentato graficamente come una **scatola rettangolare astratta** (*box*). Il **CSS Box Model** governa la geometria, il dimensionamento e la spaziatura di tale scatola attraverso quattro livelli concentrici:

```
┌────────────────────────────────────────────────────────┐
│                        MARGIN                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │                     BORDER                       │  │
│  │  ┌────────────────────────────────────────────┐  │  │
│  │  │                  PADDING                   │  │  │
│  │  │  ┌──────────────────────────────────────┐  │  │  │
│  │  │  │                                      │  │  │  │
│  │  │  │               CONTENT                │  │  │  │
│  │  │  │         (width × height)             │  │  │  │
│  │  │  │                                      │  │  │  │
│  │  │  └──────────────────────────────────────┘  │  │  │
│  │  └────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────┘
```

### 1.1 Componenti del Box Model
1. **Content (Area dei Contenuti):** L'area centrale in cui risiede il contenuto effettivo dell'elemento (testo, immagini o elementi figli). Le sue dimensioni sono determinate dalle proprietà `width` e `height`.
2. **Padding (Spaziatura Interna):** Lo spazio trasparente interposto tra il perimetro del contenuto e il bordo interno dell'elemento. Viene gestito mediante la proprietà `padding`.
3. **Border (Bordo):** La linea perimetrale che avvolge il padding e il contenuto. Può essere personalizzata in spessore, stile e colore tramite la proprietà `border`.
4. **Margin (Margine Esterno):** Lo spazio vuoto esterno al bordo che separa l'elemento da tutti gli altri elementi adiacenti nel flusso della pagina. Viene controllato dalla proprietà `margin`.

### 1.2 Regole di Notazione Shorthand e Senso Orario
Le proprietà `padding` e `margin` consentono di specificare i valori per i quattro lati secondo una convenzione rigorosa che procede **in senso orario partendo dall'alto** (*Top $\rightarrow$ Right $\rightarrow$ Bottom $\rightarrow$ Left*):

```css
/* 4 Valori: Top | Right | Bottom | Left */
padding: 10px 20px 15px 5px;

/* 3 Valori: Top | Horizontal (Left & Right) | Bottom */
padding: 10px 20px 15px;

/* 2 Valori: Vertical (Top & Bottom) | Horizontal (Left & Right) */
padding: 10px 20px;

/* 1 Valore: applicato uniformemente a tutti e 4 i lati */
padding: 10px;
```

È possibile dichiarare puntualmente le singole direzioni con le proprietà estese: `padding-top`, `padding-right`, `padding-bottom`, `padding-left` (e analogamente per `margin-*`).

### 1.3 Personalizzazione di Bordo e Raggio di Curvatura (`border-radius`)
* **Proprietà `border`:** Funge da proprietà *shorthand* che raggruppa larghezza, stile di tratto e colore:
  ```css
  border: 1px solid #333333;
  ```
* **Proprietà `border-radius`:** Consente di arrotondare gli angoli del perimetro esterno. I valori vengono interpretati in senso orario partendo dall'angolo **in alto a sinistra**:
  ```css
  /* In alto a sx | In alto a dx | In basso a dx | In basso a sx */
  border-radius: 8px 8px 0 0;
  ```

> [!NOTE] Nota del Prof: Percezione Visiva dei Bottoni e Psicologia UI
> In fase di progettazione delle interfacce utente è prassi consolidata rimuovere i bordi netti o applicare bordi arrotondati ai bottoni (`button`). Gli angoli vivi e le forme spigolose trasmettono all'utente una sensazione inconscia di spigolosità, rigidità o allarme; al contrario, pulsanti con angoli stondati risultano visivamente morbidi, moderni e più rassicuranti all'interazione.

### 1.4 Fenomeno del Margin Collapsing (Fusione dei Margini)
Nei layout a flusso normale, quando due margini verticali di elementi a livello di blocco entrano in contatto diretto, essi **si fondono** (*margin collapsing*): lo spazio effettivo risultante tra i due elementi non equivale alla somma aritmetica dei margini, bensì al **valore massimo** tra i due.

> [!IMPORTANT] Vincoli di Dimensionamento Orizzontale vs Verticale
> * **Vincolo Orizzontale:** È una regola d'oro del web design assicurarsi che la somma delle larghezze orizzontali, padding e margini non superi mai il $100\%$ della viewport per evitare la comparsa dello **scorrimento orizzontale (*horizontal scrollbar*)**, considerato un grave difetto di usabilità.
> * **Vincolo Verticale:** Non sussistono limitazioni rigide per la dimensione verticale, in quanto lo scorrimento verso il basso costituisce il naturale pattern di navigazione dell'utente.
> * **Best Practice sulle Unità:** Riservare l'uso dei pixel (`px`) quasi esclusivamente per lo spessore dei bordi (`border`); per margini, padding e dimensioni del layout preferire unità percentuali (`%`) o relative (`rem`, `em`, `vw`, `vh`) per assicurare fluidità e piena responsività.

---

## 2. Selettori Avanzati, ID, Classi e Combinatori CSS

### 2.1 Tipologie Fondamentali di Selettori
* **Selettore di Tipo (Tag):** Seleziona tutti gli elementi HTML di un dato tag (es. `p`, `h1`, `div`).
* **Selettore di ID (`#id`):** L'attributo `id` identifica in modo **univoco e singolare** un elemento all'interno dell'intero documento. Nel CSS viene richiamato con il prefisso `#`:
  ```css
  #header-principale {
    background-color: #002b49;
  }
  ```
* **Selettore di Classe (`.classe`):** L'attributo `class` associa uno o più elementi a una medesima categoria stilistica. Nel CSS si richiama con il prefisso `.`:
  ```css
  .evidenziato {
    color: #d9534f;
    font-weight: bold;
  }
  ```

### 2.2 Selettori Composti e Specificità
È possibile combinare tag e identificatori per aumentare la specificità della selezione:
* `p#quote`: seleziona esclusivamente l'elemento paragrafo `<p>` avente ID `quote`.
* `div.quote`: seleziona tutti i tag `<div>` appartenenti alla classe `quote`.
* `p.quote, div.quote`: applica la medesima regola sia ai paragrafi sia ai div dotati della classe `quote`.

### 2.3 Combinatori CSS
I combinatori definiscono la relazione gerarchica o posizionale tra due o più selettori:

| Combinatore | Sintassi | Nome Tecnico | Descrizione della Selezione |
| :--- | :--- | :--- | :--- |
| **Spazio** | `A B` | Discendente (*Descendant*) | Seleziona qualsiasi elemento `B` annidato all'interno di `A` a qualunque livello di profondità. |
| **Maggiore** | `A > B` | Figlio Diretto (*Child*) | Seleziona esclusivamente gli elementi `B` che sono figli immediati (di primo livello) di `A`. |
| **Più** | `A + B` | Fratello Adiacente (*Adjacent Sibling*) | Seleziona il primo elemento `B` posizionato immediatamente dopo `A` e avente lo stesso genitore. |
| **Tilde** | `A ~ B` | Fratello Generale (*General Sibling*) | Seleziona tutti gli elementi `B` posizionati dopo `A` che condividono lo stesso genitore. |

```css
/* Seleziona tutti i paragrafi all'interno di un div (a qualsiasi livello) */
div p {
  line-height: 1.6;
}

/* Seleziona solo i paragrafi figli diretti di un contenitore */
section.main-content > p {
  font-size: 1.1rem;
}
```

---

## 3. Stile delle Liste e Gestione delle Citazioni

### 3.1 Proprietà di Stile per le Liste (`list-style`)
La resa grafica dei marcatori delle liste (`<ul>` e `<ol>`) viene controllata tramite la famiglia di proprietà `list-style`:

* `list-style-type`: Specifica la forma geometrica o il sistema di numerazione del marcatore:
  * Liste non ordinate: `disc` (pallino pieno), `circle` (pallino vuoto), `square` (quadrato), `none` (rimozione del marcatore).
  * Liste ordinate: `decimal` (1, 2, 3), `lower-alpha` (a, b, c), `upper-roman` (I, II, III).
* `list-style-image`: Consente di sostituire il marcatore nativo con una grafica personalizzata:
  ```css
  ul.custom-check {
    list-style-image: url('images/check.png');
  }
  ```
* `list-style-position`: Stabilisce se il marcatore deve risiedere all'interno o all'esterno della scatola di testo dell'elemento `<li>`:
  * `outside` (default): il marcatore è allineato all'esterno del blocco di testo.
  * `inside`: il marcatore rientra all'interno del flusso del testo.
* `list-style`: Proprietà *shorthand* per impostare simultaneamente tipo, posizione e immagine:
  ```css
  ul {
    list-style: square inside none;
  }
  ```

### 3.2 Personalizzazione delle Virgolature con `<q>`
Per l'elemento di citazione breve `<q>`, il browser applica automaticamente i caratteri di virgolettatura tipografica. È possibile personalizzare i glifi di apertura e chiusura mediante la proprietà CSS `quotes`:

```css
q {
  quotes: "«" "»" "“" "”";
}
```

---

## 4. Tabelle in HTML5 (`<table>`)

Le tabelle HTML consentono di organizzare insiemi di dati complessi in una matrice strutturata di righe e colonne.

### 4.1 Tag Fondamentali
* `<table>`: Elemento radice che definisce l'inizio e la fine della struttura tabellare.
* `<tr>` (*Table Row*): Definisce una riga della tabella.
* `<th>` (*Table Header*): Cella di intestazione per righe o colonne; il testo viene renderizzato di default **in grassetto e centrato**.
* `<td>` (*Table Data*): Cella standard contenente i dati informativi.

```html
<table>
  <tr>
    <th>Matricola</th>
    <th>Cognome</th>
    <th>Voto</th>
  </tr>
  <tr>
    <td>37891</td>
    <td>Rossi</td>
    <td>30</td>
  </tr>
</table>
```

### 4.2 Gestione dei Bordi e `border-collapse`
Se si assegna una regola di bordo al solo elemento `table`, viene tracciata unicamente la cornice perimetrale esterna. Se la si applica congiuntamente alle celle `td` e `th`, il browser genera un doppio bordo separato per ciascuna cella.

Per unificare le linee di divisione in un unico tratto compatto si impiega la direttiva CSS:
```css
table {
  border-collapse: collapse;
  width: 100%;
}

th, td {
  border: 1px solid #cccccc;
  padding: 8px 12px;
}
```

> [!WARNING] Regola Fondamentale sull'Uso delle Tabelle
> Le tabelle HTML **non devono mai essere impiegate per scopi di impaginazione grafica o layout di pagina** (compito demandato a Flexbox e CSS Grid). Vanno utilizzate unicamente per esporre dati strutturati tabulari.

### 4.3 Unione di Celle: `colspan` e `rowspan`
È possibile aggregare più celle contigue mediante due attributi specifici:
* **`colspan="N"` (*Column Span*):** Espande una cella orizzontalmente su $N$ colonne adiacenti.
* **`rowspan="N"` (*Row Span*):** Espande una cella verticalmente su $N$ righe sottostanti.

```html
<table border="1">
  <tr>
    <th colspan="2">Dati Anagrafici</th>
    <th>Esito</th>
  </tr>
  <tr>
    <td rowspan="2">Mario Rossi</td>
    <td>Modulo 1</td>
    <td>Superato</td>
  </tr>
  <tr>
    <td>Modulo 2</td>
    <td>In attesa</td>
  </tr>
</table>
```

> [!IMPORTANT] Regole Operative per `rowspan` e `colspan`
> 1. **Coerenza del Numero di Celle:** Ogni riga logica della tabella deve avere il medesimo numero complessivo di celle (computando la somma di celle singole e span).
> 2. **Omissione dei `<td>` Eccedenti:** Quando si inserisce un attributo `rowspan="2"`, nelle righe sottostanti interessate dallo span **non devono essere inseriti i tag `<td>` per quella colonna**, poiché lo spazio è già occupato dall'espansione verticale. Analogamente, in presenza di `colspan="2"`, si omette la cella adiacente a destra nella medesima riga.

---

## 5. Moduli di Acquisizione Dati: Form HTML5 (`<form>`)

I moduli interattivi (**form**) costituiscono il meccanismo primario attraverso cui gli utenti inseriscono dati destinati all'elaborazione da parte di un server web.

### 5.1 Il Tag `<form>` e gli Attributi Obbligatori
L'elemento contenitore `<form>` richiede due attributi fondamentali:
* **`action`:** Specifica l'URI/endpoint lato server verso cui inoltrare i dati raccolti (es. `/api/login` o `process.php`).
* **`method`:** Specifica il metodo di trasmissione HTTP:
  * `GET`: I dati vengono concatenati all'URL sotto forma di *query string* (`?chiave=valore&...`). Indicato per ricerche e operazioni idempotenti; mai da usare per password o dati sensibili.
  * `POST`: I dati vengono incapsulati all'interno del *Body* (payload) della richiesta HTTP. Indicato per operazioni di creazione, modifica o invio di dati riservati.

### 5.2 Il Ruolo delle Etichette (`<label>`) e Associazione `for`/`id`
L'elemento `<label>` è un tag **inline** preposto a definire la didascalia testuale di un controllo. 
* L'attributo `for` della label deve corrispondere esattamente al valore dell'attributo `id` del controllo di input corrispondente.
* **Vantaggio di Usabilità e Accessibilità:** Cliccando con il cursore sul testo dell'etichetta, il browser sposta automaticamente il focus sul rispettivo campo o attiva/disattiva la relativa casella di spunta (*checkbox* o *radio button*).

```html
<label for="campo-email">Indirizzo Email:</label>
<input type="email" id="campo-email" name="user_email" required placeholder="mario.rossi@example.com">
```

### 5.3 L'Elemento `<input>` e le sue Tipologie
L'elemento `<input>` è un tag vuoto (*void tag*) governato dall'attributo `type`:

* **Campi Testuali e Specializzati:**
  * `type="text"`: campo testuale monoriga generico.
  * `type="password"`: campo con oscuramento automatico dei caratteri digitati.
  * `type="email"`: campo con validazione sintattica dell'indirizzo email conforme alle specifiche RFC.
  * `type="tel"`: campo dedicato a recapiti telefonici.
  * `type="url"`: campo per l'inserimento di percorsi web con validazione del protocollo.
  * `type="search"`: campo ottimizzato per query di ricerca interna.
* **Campi Numerici e Temporali:**
  * `type="number"`: accetta valori numerici; supporta gli attributi `min`, `max` e `step` per regolare gli incrementi ammessi.
  * `type="range"`: controllo visuale a cursore scorrevole (*slider*) per selezioni numeriche approssimate.
  * `type="date"`, `type="time"`: selettori visuali di date e orari con calendario nativo integrato.
* **Campi Speciali e di Selezione:**
  * `type="color"`: selettore visuale per la scelta di un codice colore esadecimale.
  * `type="file"`: consente all'utente di selezionare uno o più file dal proprio file system locale per l'upload.
  * `type="hidden"`: campo invisibile all'utente a schermo; viene impiegato dagli sviluppatori per trasmettere parametri di stato o token al server (ad esempio per tracciare un identificativo articolo quando l'utente clicca su un banner).

### 5.4 Selezione Multipla e Singola: Checkbox e Radio Button
* **Checkbox (`type="checkbox"`):** Consente selezioni multiple e indipendenti. Tutti gli elementi appartenenti allo stesso gruppo logico devono condividere lo stesso attributo `name`, possedendo valori `value` distinti.
* **Radio Button (`type="radio"`):** Impone una scelta mutuamente esclusiva all'interno di un gruppo. Condividono il medesimo `name`, ma solo un'opzione per volta può essere attiva.

```html
<!-- Selezione Singola Esclusiva -->
<p>Seleziona il corso di laurea:</p>
<input type="radio" id="inf" name="corso" value="informatica">
<label for="inf">Informatica</label>

<input type="radio" id="ing" name="corso" value="ingegneria">
<label for="ing">Ingegneria</label>
```

### 5.5 Pulsanti di Sottomissione (`submit`), Ripristino (`reset`) e Confronto con `<button>`
* `<input type="submit" value="Invia Dati">`: Inoltra formalmente i dati del form all'endpoint designato.
* `<input type="reset" value="Annulla">`: Ripristina tutti i campi del modulo ai loro valori iniziali di default.

> [!NOTE] Best Practice UX: Conferma su Reset
> È buona prassi di usabilità associare un messaggio o modale di conferma all'azione di reset, per evitare che un clic accidentale dell'utente cancelli moduli lunghi o complessi già compilati.

* **`<button>` vs `<input type="submit">`:** L'elemento `<button type="submit">...</button>` è un tag contenitore che consente di annidare all'interno del pulsante icone, immagini o marcature HTML complesse, risultando preferibile rispetto a `<input type="submit">` nei contesti di interfaccia moderna.

### 5.6 Menu a Tendina (`<select>`, `<option>`, `<optgroup>`) e Datalist (`<datalist>`)
* **Menu `<select>`:** Genera una tendina a discesa; i singoli elementi sono definiti da tag `<option value="...">`. È possibile raggruppare visivamente categorie correlate tramite il tag `<optgroup label="...">`.
* **`<datalist>`:** Definisce un insieme invisibile di suggerimenti di completamento automatico collegati a un normale campo `<input>` mediante l'attributo `list="id_datalist"`. A differenza di `<select>`, l'utente mantiene la libertà di digitare un valore personalizzato non compreso nell'elenco.

```html
<label for="citta">Seleziona o digita una città:</label>
<input list="elenco-citta" id="citta" name="citta">

<datalist id="elenco-citta">
  <option value="Perugia">
  <option value="Roma">
  <option value="Firenze">
  <option value="Milano">
</datalist>
```

### 5.7 Raggruppamento Semantico: `<fieldset>` e `<legend>`
L'elemento `<fieldset>` consente di raggruppare logicamente blocchi di campi correlati (es. "Dati di Spedizione", "Dati di Fatturazione"), tracciando una cornice visiva attorno alla sezione. Il tag `<legend>` inserito come primo elemento interno definisce il titolo o la didascalia della cornice.

```html
<fieldset>
  <legend>Credenziali di Accesso</legend>
  <label for="user">Username:</label>
  <input type="text" id="user" name="username" required>
  
  <label for="pwd">Password:</label>
  <input type="password" id="pwd" name="password" required>
</fieldset>
```

### 5.8 Campi di Testo Multilinea (`<textarea>`)
Per acquisire testi estesi (recensioni, note, messaggi) si impiega il tag contenitore `<textarea>`:
```html
<textarea id="messaggio" name="messaggio" rows="4" cols="50" placeholder="Inserisci qui le tue osservazioni..."></textarea>
```

### 5.9 Attributi di Validazione e Stile Visivo (Gradienti)
* `required`: Forza il browser a bloccare l'invio del form qualora il campo sia vuoto.
* `placeholder`: Fornisce un testo guida temporaneo all'interno del campo.
* **Sfondi Sfumati con CSS:** La proprietà `background: linear-gradient(...)` consente di applicare transizioni di colore eleganti agli elementi dei form e ai contenitori:
  ```css
  button.submit-btn {
    background: linear-gradient(135deg, #007bff, #0056b3);
    color: #ffffff;
    border: none;
    border-radius: 6px;
    padding: 10px 24px;
    cursor: pointer;
  }
  ```

---

