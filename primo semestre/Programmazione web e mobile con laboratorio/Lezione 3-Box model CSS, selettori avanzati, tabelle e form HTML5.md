# Box model CSS, selettori avanzati, tabelle e form HTML5

## Il box model

Nel motore di rendering ogni elemento del DOM viene rappresentato come una **scatola rettangolare astratta** (*box*): il **CSS Box Model** ne governa geometria, dimensionamento e spaziatura attraverso quattro livelli concentrici.

```
┌────────────────────────────────────────────────────────┐
│                        MARGIN                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │                     BORDER                       │  │
│  │  ┌────────────────────────────────────────────┐  │  │
│  │  │                  PADDING                   │  │  │
│  │  │  ┌──────────────────────────────────────┐  │  │  │
│  │  │  │               CONTENT                │  │  │  │
│  │  │  │         (width × height)             │  │  │  │
│  │  │  └──────────────────────────────────────┘  │  │  │
│  │  └────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────┘
```

- **Content:** area centrale con il contenuto effettivo (testo, immagini, elementi figli); le dimensioni sono date da `width` e `height`, che con il modello predefinito `box-sizing: content-box` misurano **solo il contenuto**, escludendo padding e bordo. Dichiarando `box-sizing: border-box` le stesse proprietà misurano invece l'ingombro totale, bordo compreso.
- **Padding:** spazio trasparente fra contenuto e bordo interno.
- **Border:** linea perimetrale che avvolge padding e contenuto.
- **Margin:** spazio esterno al bordo, che separa l'elemento dagli elementi adiacenti.

**Notazione shorthand:** `padding` e `margin` accettano i valori dei quattro lati in senso orario partendo dall'alto:

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

Le proprietà estese permettono di dichiarare una singola direzione: `padding-top`, `padding-right`, `padding-bottom`, `padding-left` e analogamente per `margin-*`.

**Bordo e raggio di curvatura:** `border` è una proprietà *shorthand* che raggruppa spessore, stile di tratto e colore; `border-radius` arrotonda gli angoli con valori interpretati in senso orario a partire dall'angolo in alto a sinistra.

```css
border: 1px solid #333333;

/* In alto a sx | In alto a dx | In basso a dx | In basso a sx */
border-radius: 8px 8px 0 0;
```

> [!info] Percezione visiva dei bottoni:
> Nella progettazione delle interfacce è prassi rimuovere i bordi netti o arrotondare gli angoli dei bottoni (`button`). Gli angoli vivi e le forme spigolose trasmettono una sensazione inconscia di spigolosità, rigidità o allarme; i pulsanti con angoli stondati risultano visivamente morbidi, moderni e più rassicuranti all'interazione.

**Margin collapsing:** nei layout a flusso normale, quando due margini verticali di elementi a blocco entrano in contatto diretto essi **si fondono**: lo spazio effettivo tra i due elementi non è la somma aritmetica dei margini, ma il **valore massimo** tra i due.

> [!important] Vincoli di dimensionamento (valori calcolati con il modello predefinito `content-box`):
> - **Orizzontale:** la somma di larghezze, padding, bordi e margini non deve superare mai il $100\%$ della viewport, altrimenti compare lo **scorrimento orizzontale** (*horizontal scrollbar*), considerato un grave difetto di usabilità.
> - **Verticale:** non sussistono limiti rigidi, perché lo scorrimento verso il basso è il naturale pattern di navigazione.
> - **Unità:** riservare i pixel (`px`) quasi solo allo spessore dei bordi; per margini, padding e dimensioni del layout preferire unità percentuali (`%`) o relative (`rem`, `em`, `vw`, `vh`), così da garantire fluidità e responsività.

## I selettori CSS

- **Selettore di tipo (tag):** seleziona tutti gli elementi di un dato tag (`p`, `h1`, `div`).
- **Selettore di ID (`#id`):** l'attributo `id` identifica in modo **univoco** un elemento nell'intero documento.
- **Selettore di classe (`.classe`):** l'attributo `class` associa uno o più elementi alla stessa categoria stilistica.

```css
#header-principale {
  background-color: #002b49;
}

.evidenziato {
  color: #d9534f;
  font-weight: bold;
}
```

Tag e identificatori si combinano per aumentare la specificità: `p#quote` seleziona solo il `<p>` con ID `quote`, `div.quote` tutti i `<div>` con classe `quote`, `p.quote, div.quote` applica la stessa regola a entrambi.

**I combinatori** definiscono la relazione gerarchica o posizionale fra due o più selettori.

| Combinatore | Sintassi | Nome tecnico | Selezione |
| :--- | :--- | :--- | :--- |
| **Spazio** | `A B` | Discendente (*Descendant*) | Qualunque elemento `B` annidato in `A`, a qualunque profondità. |
| **Maggiore** | `A > B` | Figlio Diretto (*Child*) | Solo gli elementi `B` figli immediati di `A`. |
| **Più** | `A + B` | Fratello Adiacente (*Adjacent Sibling*) | Il primo `B` immediatamente dopo `A`, con lo stesso genitore. |
| **Tilde** | `A ~ B` | Fratello Generale (*General Sibling*) | Tutti gli elementi `B` dopo `A` con lo stesso genitore. |

```css
/* Tutti i paragrafi dentro un div, a qualsiasi livello */
div p {
  line-height: 1.6;
}

/* Solo i paragrafi figli diretti del contenitore */
section.main-content > p {
  font-size: 1.1rem;
}
```

**Stile delle liste:** la famiglia `list-style` controlla i marcatori di `<ul>` e `<ol>`.

- `list-style-type`: forma del marcatore. Per le liste non ordinate `disc` (pallino pieno), `circle` (pallino vuoto), `square` (quadrato), `none`; per quelle ordinate `decimal`, `lower-alpha`, `upper-roman`.
- `list-style-image`: sostituisce il marcatore con una grafica personalizzata.
- `list-style-position`: `outside` (default) allinea il marcatore all'esterno del testo, `inside` lo fa rientrare nel flusso.
- `list-style`: *shorthand* per tipo, posizione e immagine.

```css
ul.custom-check {
  list-style-image: url('images/check.png');
}

ul {
  list-style: square inside none;
}
```

**Citazioni brevi:** il browser applica automaticamente le virgolette a `<q>`; i glifi si personalizzano con la proprietà `quotes`.

```css
q {
  quotes: "«" "»" "“" "”";
}
```

## Le tabelle HTML5

Le tabelle organizzano insiemi di dati complessi in una matrice di righe e colonne.

- `<table>`: elemento radice che delimita la struttura tabellare.
- `<tr>` (*table row*): una riga.
- `<th>` (*table header*): cella di intestazione di righe o colonne; il testo viene reso **in grassetto e centrato**.
- `<td>` (*table data*): cella con i dati informativi.

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

**Gestione dei bordi:** un bordo assegnato solo a `table` traccia soltanto la cornice perimetrale esterna; se lo si applica anche a `td` e `th` il browser genera un doppio bordo per ciascuna cella. `border-collapse: collapse` unifica le linee di divisione in un unico tratto compatto.

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

> [!warning] Regola fondamentale sull'uso delle tabelle:
> Le tabelle HTML **non devono mai essere impiegate per impaginazione grafica o layout di pagina**, compito demandato a Flexbox e CSS Grid. Vanno usate unicamente per esporre dati strutturati tabulari.

**Unione di celle:** `colspan="N"` espande la cella orizzontalmente su $N$ colonne adiacenti, `rowspan="N"` verticalmente su $N$ righe sottostanti.

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

> [!important] Regole operative per `rowspan` e `colspan`:
> 1. **Coerenza del numero di celle:** ogni riga logica deve avere lo stesso numero complessivo di celle, computando la somma di celle singole e span.
> 2. **Omissione dei `<td>` eccedenti:** dove c'è un `rowspan="2"` nelle righe sottostanti non si inseriscono i `<td>` per quella colonna, perché lo spazio è già occupato; analogamente con `colspan="2"` si omette la cella adiacente a destra nella stessa riga.

## I form HTML5

I **form** sono il meccanismo primario con cui gli utenti inseriscono dati destinati all'elaborazione da parte di un server web.

**Il tag `<form>`** usa tre attributi principali:

- `action`: l'URI o endpoint lato server verso cui inoltrare i dati (`/api/login`, `process.php`).
- `method`: il metodo di trasmissione HTTP. `GET` concatena i dati all'URL come *query string* (`?chiave=valore&...`) ed è indicato per ricerche e operazioni idempotenti, mai per password o dati sensibili; `POST` incapsula i dati nel *body* della richiesta ed è indicato per creazione, modifica o invio di dati riservati.
- `enctype`: la codifica dei dati inviati; va impostato a `multipart/form-data` quando il form invia file (per esempio con `<input type="file">`).

**Le etichette `<label>`** sono tag inline che definiscono la didascalia di un controllo: l'attributo `for` della label deve corrispondere al valore dell'attributo `id` del controllo. Cliccando sul testo dell'etichetta il browser sposta il focus sul campo o attiva e disattiva la relativa casella di spunta, con un vantaggio di usabilità e accessibilità.

```html
<label for="campo-email">Indirizzo Email:</label>
<input type="email" id="campo-email" name="user_email" required placeholder="mario.rossi@example.com">
```

**L'elemento `<input>`** è un tag vuoto governato dall'attributo `type`:

- *Campi testuali e specializzati:* `text` (monoriga generico), `password` (oscuramento dei caratteri), `email` (validazione sintattica conforme alle specifiche RFC), `tel` (recapiti telefonici), `url` (percorsi web con validazione del protocollo), `search` (query di ricerca interna).
- *Campi numerici e temporali:* `number`, che supporta `min`, `max` e `step` per regolare gli incrementi ammessi; `range`, cursore scorrevole (*slider*) per selezioni numeriche approssimate; `date` e `datetime-local`, che presentano un calendario nativo integrato; `time`, che presenta un campo orario con selettore a tendina sulle piattaforme che lo supportano.
- *Campi speciali e di selezione:* `color` (scelta di un codice colore esadecimale), `file` (selezione di un file dal file system locale; con l'attributo `multiple` se ne possono selezionare più di uno), `hidden` (invisibile a schermo, usato per trasmettere parametri di stato o token al server, per esempio l'identificativo dell'articolo quando l'utente clicca su un banner).

**Checkbox e radio button:** le checkbox consentono selezioni multiple e indipendenti e gli elementi dello stesso gruppo logico devono condividere l'attributo `name`, con valori `value` distinti; i radio button impongono una scelta mutuamente esclusiva, condividono il medesimo `name` e solo un'opzione per volta può essere attiva.

```html
<p>Seleziona il corso di laurea:</p>
<input type="radio" id="inf" name="corso" value="informatica">
<label for="inf">Informatica</label>

<input type="radio" id="ing" name="corso" value="ingegneria">
<label for="ing">Ingegneria</label>
```

**Pulsanti:** `<input type="submit" value="Invia Dati">` inoltra i dati del form all'endpoint designato, `<input type="reset" value="Annulla">` ripristina tutti i campi ai valori iniziali.

> [!tip] Conferma sul reset:
> È buona prassi di usabilità associare un messaggio o un modale di conferma all'azione di reset, per evitare che un clic accidentale cancelli moduli lunghi già compilati.

L'elemento `<button type="submit">...</button>` è un tag contenitore che consente di annidare icone, immagini o marcature HTML complesse dentro il pulsante, ed è preferibile a `<input type="submit">` nelle interfacce moderne.

**Menu a tendina e datalist:** `<select>` genera la tendina a discesa con i singoli elementi definiti da `<option value="...">`, e `<optgroup label="...">` raggruppa visivamente categorie correlate. `<datalist>` definisce un insieme invisibile di suggerimenti di completamento automatico collegati a un campo `<input>` tramite l'attributo `list="id_datalist"`; a differenza di `<select>` l'utente può digitare un valore personalizzato non compreso nell'elenco.

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

**Raggruppamento semantico:** `<fieldset>` raggruppa logicamente blocchi di campi correlati (per esempio "Dati di Spedizione" o "Dati di Fatturazione") e traccia una cornice visiva attorno alla sezione; `<legend>`, inserito come primo elemento interno, ne definisce il titolo.

```html
<fieldset>
  <legend>Credenziali di Accesso</legend>
  <label for="user">Username:</label>
  <input type="text" id="user" name="username" required>

  <label for="pwd">Password:</label>
  <input type="password" id="pwd" name="password" required>
</fieldset>
```

**Testi multilinea:** per acquisire testi estesi (recensioni, note, messaggi) si impiega il tag contenitore `<textarea>`.

```html
<textarea id="messaggio" name="messaggio" rows="4" cols="50" placeholder="Inserisci qui le tue osservazioni..."></textarea>
```

**Validazione e stile visivo:** `required` fa bloccare al browser l'invio del form se il campo è vuoto, `placeholder` fornisce un testo guida temporaneo. Gli sfondi sfumati si ottengono con `background: linear-gradient(...)`.

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

> [!info] Sintesi:
> - Il box model è content, padding, border e margin; `padding` e `margin` in shorthand si leggono in senso orario dall'alto e `border-radius` dall'angolo in alto a sinistra.
> - I margini verticali adiacenti si fondono nel maggiore dei due; in orizzontale la somma delle misure non deve superare la viewport, per evitare lo scroll orizzontale.
> - I selettori sono di tag, ID e classe; i combinatori sono discendente `A B`, figlio `A > B`, fratello adiacente `A + B` e fratello generale `A ~ B`; le liste si stilano con `list-style-*` e le virgolette di `<q>` con `quotes`.
> - Le tabelle sono solo per dati tabulari: `border-collapse: collapse` unifica i bordi, `colspan` e `rowspan` uniscono celle e le celle coperte da uno span non si ripetono.
> - `<form>` ha `action` e `method` (`GET` in query string, `POST` nel body); `<label for>` va collegato all'`id` del campo e le label cliccabili spostano il focus.
> - `<input type>` determina validazione e aspetto, `checkbox` e `radio` si raggruppano con `name`, `<button>` ammette contenuto annidato, `<select>`, `<datalist>`, `<fieldset>`/`<legend>` e `<textarea>` completano i controlli.
> - `required` e `placeholder` gestiscono la validazione, `linear-gradient` gli sfondi dei pulsanti.