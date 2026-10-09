# Media embeddati, ipertesti, layout CSS e tag semantici
## I media embeddati: `<video>` e `<audio>`

HTML5 introduce nativamente l'incorporamento di contenuti multimediali, eliminando la necessità di plugin esterni (Flash, Silverlight). I due elementi sono `<video>` e `<audio>` e condividono il medesimo set di attributi.

### Gli attributi comuni

- **`src`:** percorso del file multimediale. Se il file è omesso è possibile elencare più sorgenti alternative tramite tag `<source>` annidati.
- **`type` (dichiarato su `<source>`, non sul media):** formato del media dichiarato come MIME type (es. `video/mp4`, `video/webm`, `audio/mpeg`). Consente al browser di saltare immediatamente le sorgenti non supportate senza scaricarle.
- **`controls`:** visualizza la barra di controllo nativa (play/pausa, volume, linea temporale, schermo intero).
- **`autoplay`:** avvia la riproduzione appena il file è pronto.
- **`loop`:** al termine della riproduzione ricomincia da capo.
- **`muted`:** avvia la riproduzione con audio disattivato.

```html
<video src="presentazione.mp4" controls autoplay loop muted width="640"></video>

<audio src="brano.mp3" controls loop></audio>
```

> [!important] Politiche di autoplay dei browser
> I browser moderni **bloccano l'avvio automatico** di un media se questo emette audio: `autoplay` viene applicato solo in combinazione con `muted`. Inoltre, su dispositivi mobili è necessario `playsinline` per impedire che il video passi forzatamente al lettore a schermo intero. L'ordine delle dichiarazioni non è influente: `muted` può precedere `autoplay`.

### Le sorgenti multiple e il fallback

L'elemento `<source>` elenca le varianti disponibili: il browser seleziona la prima sorgente con un `type` supportato, evitando conversioni e codec proprietari.

```html
<video controls poster="locandina.jpg">
  <source src="video.webm" type="video/webm">
  <source src="video.mp4" type="video/mp4">
  <!-- Fallback mostrato solo da browser senza supporto HTML5 -->
  Il tuo browser non supporta i video HTML5.
</video>
```

- **`poster` (solo `<video>`):** immagine mostrata prima dell'avvio della riproduzione.
- **`preload`:** comportamento del precaricamento (`auto`, `metadata`, `none`).
- **`width` / `height` (solo `<video>`):** dimensioni intrinseche del player; non applicabili ad `<audio>`.

## Ipertesti: il tag `<a>`

Il tag `<a>` definisce un collegamento ipertestuale verso un'altra pagina, una risorsa esterna o una sezione interna della stessa pagina.

### Gli attributi fondamentali

- **`href`:** URL o identificatore di ancoraggio della destinazione. Se assente, `<a>` non funziona come link ma conserva la semantica di elemento di riserva per la creazione del collegamento.
- **`target`:** contesto di apertura del documento di destinazione:
  - `_self` (default): stessa scheda o finestra corrente.
  - `_blank`: nuova scheda o finestra.
  - `_parent` e `_top`: salgono rispettivamente di un livello e alla finestra più esterna della gerarchia di frame.
- **`title`:** tooltip mostrato al passaggio del mouse.
- **`download`:** forza il download della risorsa indicata in `href` invece della sua visualizzazione.

### I link interni e le ancore

I collegamenti interni sfruttano il **fragment identifier**: il valore di `href` preceduto dal cancelletto `#` punta all'`id` di un elemento della pagina corrente.

```html
<a href="#sezione1">Vai alla sezione 1</a>

<section id="sezione1">
  <h2>Contenuto della sezione 1</h2>
</section>
```

Il fragment può anche puntare a un elemento di una pagina diversa, accodandosi al nome del file: `href="capitolo2.html#sezione1"`.

> [!info] Perché servono gli `id`
> La navigazione tramite fragment richiede un `id`, perché l'attributo `id` è univoco all'interno del documento, mentre la classe `class` può essere assegnata a più elementi: il fragment non potrebbe sapere quale dei molteplici elementi con la stessa classe deve attivare.

> [!warning] Apertura in nuova scheda e reverse tabnabbing
> Quando si usa `target="_blank"`, la nuova scheda ottiene un riferimento al documento di origine tramite l'oggetto `window.opener`. Una pagina malevola può redirigerla con `window.opener.location` sostituendo la scheda originale con una pagina di phishing. Il rimedio è l'attributo `rel="noopener noreferrer"`, che inoltre impedisce l'invio del referrer.

```html
<a href="documentazione.pdf" target="_blank" rel="noopener noreferrer">Apri la documentazione</a>
```

## `<div>` e `<span>`

- **`<div>` (block):** contenitore generico di blocco, occupa l'intera larghezza disponibile e genera un'interruzione di riga. Usato per raggruppare e strutturare blocchi di contenuto.
- **`<span>` (inline):** contenitore generico inline, privo di semantica propria, dimensionato sul proprio contenuto. Usato per applicare stili mirati a porzioni di testo identificate da `id` o `class`.

Di conseguenza, due `<div>` consecutivi nel flusso si dispongono **in colonna** (uno sotto l'altro), mentre due elementi inline affiancati si dispongono **orizzontalmente** sulla stessa riga.

> [!warning] div, span e modello di box
> `<div>` e `<span>` non sono scelte puramente estetiche: se un insieme di elementi funziona in orizzontale ma si deve visualizzare in verticale, il problema risiede nel modello di box (`display`), non nel tag utilizzato. Sostituire `<div>` con `<span>` non modifica il comportamento del layout.

## Il layout a colonne multiple

La proprietà `column-count` (o l'alias `columns`) suddivide il contenuto di un blocco in più colonne verticali, con le seguenti direttive correlate:

| Proprietà | Funzione |
| :--- | :--- |
| `column-count` | Numero fisso di colonne in cui viene frammentato il contenuto. |
| `column-width` | Larghezza **minima** desiderata per una colonna: il browser calcola il numero effettivo di colonne che riesce a ricavare dalla larghezza disponibile. |
| `column-gap` | Spazio orizzontale (gutter) fra colonne adiacenti. |
| `column-rule` | Tratto di confine fra le colonne; accetta le stesse proprietà di `border`. |
| `column-span` | Consente a un elemento di estendersi su tutte le colonne (`all` o `none`). |

```css
.articolo {
  column-count: 3;
  column-gap: 24px;
  column-rule: 1px solid #cccccc;
}

.titolo-evidenza {
  column-span: all;
}
```

## Float: galleggiamento e clear

La proprietà `float` stacca un elemento dal normale flusso verticale e lo allinea a sinistra o a destra del contenitore; **il testo circostante si avvolge attorno ad esso**. Opera su qualunque elemento (un elemento inline flottato diventa di blocco) e ammette i valori `left`, `right` e `none`.

```css
.immagine-destra {
  float: right;
  width: 300px;
  margin: 0 0 10px 15px;
}

.articolo::after { /*CSS crea un elemento virtuale alla fine del contenuto di .articolo*/
  content: "";/*elemento creato vuoto*/
  display: block;/*pseudo-elemento si comporta come un blocco*/
  clear: both;/*elemento viene posto sotto ad eventuali elementi flottanti e non affiancato*/
}
```

> [!important] Condizioni di funzionamento del float
> Il float produce effetti visibili solo se all'elemento galleggiante è assegnata una **larghezza inferiore al 100%** del contenitore: un elemento flottante largo quanto il contenitore occuperebbe l'intera area e non lascerebbe spazio al testo, vanificando l'avvolgimento. Inoltre la larghezza è necessaria perché il wrapping si disponga correttamente attorno a una forma rettangolare nota.

La proprietà `clear` (`left`, `right`, `both`) ha il compito di **interrompere l'avvolgimento**: l'elemento che la imposta scende sotto l'ultimo float flottato. Il trucco del pseudo-elemento `::after` con `content: ""` e `clear: both` permette di chiudere il contenitore in modo che i blocchi successivi non gli scorrano attorno.

> [!info] Float e modelli moderni
> Il galleggiamento è un meccanismo pensato per i layout a due colonne dei primi anni del Web e resta sensibile a problemi di altezza contenitore contenuta nei figli flottanti. Per la strutturazione di pagine moderne è preferibile ricorrere a Flexbox e CSS Grid, che distribuiscono lo spazio senza dipendere dall'avvolgimento del testo.

## `position`: i cinque schemi di posizionamento

La proprietà `position` determina il metodo di posizionamento di un elemento rispetto al flusso del documento. Gli offset `top`, `right`, `bottom` e `left` agiscono solo se l'elemento è posizionato con `relative`, `absolute`, `fixed` o `sticky`.

| Valore | Riferimento di Coordinate | Flusso Normale | Comportamento |
| :--- | :--- | :--- | :--- |
| `static` | Nessuno | Rimane nel flusso | Valore predefinito. Gli offset `top`/`bottom`/`left`/`right` sono ignorati. |
| `relative` | La propria posizione nel flusso | Rimane nel flusso | Sposta l'elemento rispetto alla sua posizione originale **lasciando lo spazio occupato invariato**; funge da contenitore di riferimento per i discendenti `absolute`. |
| `absolute` | Il primo antenato posizionato (*containing block*) | Esce dal flusso | Viene rimosso dal flusso e sovrapposto agli altri elementi; non occupa spazio e non influenza il layout dei fratelli. |
| `fixed` | Il viewport (finestra del browser) | Esce dal flusso | Resta fisso durante lo scorrimento della pagina. |
| `sticky` | Il normale flusso, poi il contenitore di scorrimento | Condizionale | Si comporta come `relative` finché la sua soglia (definita da `top`/`bottom`/`left`/`right`) non viene superata; da quel momento si "incolla" al bordo del contenitore di scorrimento più vicino. |

> [!important] Contenitore di riferimento dell'absolute
> Il riferimento geometrico di un elemento `absolute` non è necessariamente il `body`: è **l'antenato posizionato più vicino** (quello che ha `position` diversa da `static`), e in sua assenza la pagina intera. Di conseguenza un contenitore con `position: relative` funge da "scatola di contenimento" per i figli `absolute`, permettendo di ancorarli ai propri bordi interni anziché alla pagina.

```css
.contenitore-riferimento {
  position: relative;
  height: 300px;
}

.etichetta {
  position: absolute;
  top: 10px;
  left: 10px;
}

.barra-sticky {
  position: sticky;
  top: 0;
}
```

La proprietà `z-index` stabilisce l'ordine di impilamento degli elementi sovrapposti, imponendo un contesto di impilamento per ciascun positioned element e per i suoi discendenti.
## La proprietà `display` e i suoi valori

La proprietà `display` determina come il motore di rendering genera la scatola dell'elemento e il suo posizionamento nel flusso.

| Valore                             | Caratteristiche                                                                                                                              | Occupa Riga Intera | Accetta `width`/`height`                   |
| :--------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------- | :----------------- | :----------------------------------------- |
| `block`                            | Occupa la larghezza disponibile e inizia su una nuova riga; accetta `margin`, `padding` e dimensioni.                                        | Si                 | Si                                         |
| `inline`                           | Si affianca al testo sulla stessa riga e non interrompe il flusso.                                                                           | No                 | No (solo elementi sostituiti come `<img>`) |
| `inline-block`                     | Unione di `inline` e `block`: si comporta come inline nel flusso ma dimensiona la propria scatola come un blocco.                            | No                 | Si                                         |
| `none`                             | L'elemento è rimosso dal layout: non genera scatola e non è visibile, diversamente da `visibility: hidden`, che conserva lo spazio occupato. | No                 | No                                         |
| `list-item`                        | Genera il marcatore di lista.                                                                                                                | Si                 | Si                                         |
| `flex` / `inline-flex`             | Il contenitore stabilisce un contesto di layout flessibile per i figli.                                                                      | Si / No            | Si                                         |
| `grid` / `inline-grid`             | Il contenitore stabilisce un contesto di layout a griglia per i figli.                                                                       | Si / No            | Si                                         |
| `table`, `table-row`, `table-cell` | Riproduce il comportamento delle tabelle HTML con elementi generici.                                                                         | Si                 | Si                                         |

> [!info] Limiti di larghezza sugli elementi inline
> Sui elementi inline non sostituiti le dichiarazioni `width` e `height` sono **ignorate**: la dimensione orizzontale è determinata dal contenuto e quella verticale da `line-height` e dal `font-size`. Per ottenere una scatola dimensionabile serve `inline-block`.

## Centrare gli elementi

### La centratura orizzontale

- **Contenuto inline:** `text-align: center` sul contenitore; allinea testo, immagini e link in linea.
- **Elemento di blocco:** assegnare una `width` esplicita e impostare `margin-left` e `margin-right` automatici, che assorbono lo spazio residuo.
  ```css
  .contenitore-bloccante {
    width: 60%;
    margin: 0 auto;
  }
  ```
- **Contenitore flessibile o a griglia:** `justify-content: center` (Flexbox) oppure `place-items: center` (Grid).

### La centratura verticale

- **Testo e immagini inline:** `vertical-align: middle` allinea il contenuto al centro rispetto alla linea di base degli elementi circostanti; per il solo testo in un paragrafo si usa `line-height` uguale all'altezza del contenitore.
- **Elementi di blocco:** il classico `margin: auto` non ha effetto in verticale, perché l'altezza del contenitore non è determinata in anticipo. Si ricorre a Flexbox o a Grid:
  ```css
  .contenitore-centrato {
    display: flex;
    justify-content: center;  /* asse orizzontale */
    align-items: center;      /* asse verticale */
    height: 300px;
  }
  ```
  In Grid la stessa operazione si esprime in un'unica dichiarazione: `place-items: center`.

## `display: table`, `table-row` e `table-cell`

I valori `table`, `table-row` e `table-cell` riproducono in CSS il comportamento delle tabelle HTML, permettendo di trasformare elementi generici (tipicamente `<div>`) in righe e celle tramite l'attribuzione di classi specializzate.

```html
<div class="tabella">
  <div class="riga">
    <div class="cella">Matricola</div>
    <div class="cella">Cognome</div>
  </div>
  <div class="riga">
    <div class="cella">37891</div>
    <div class="cella">Rossi</div>
  </div>
</div>
```

```css
.tabella {
  display: table;
  width: 100%;
  border-collapse: collapse;
}

.riga {
  display: table-row;
}

.cella {
  display: table-cell;
  border: 1px solid #cccccc;
  padding: 8px 12px;
}
```

In un `table` CSS valgono le stesse proprietà delle tabelle HTML, inclusi `border-collapse`, la larghezza automatica delle colonne e l'allineamento verticale delle celle.

> [!info] Contenitori Anonimi
> Un elemento con `display: table` genera automaticamente contenitori anonimi di tipo `table-row` e `table-cell` per i figli non classificati, che vengono declassati a blocchi anonimi. È il motivo perché, all'interno di un `table` CSS, i figli diretti devono essere `table-row` (o `table-cell` raggruppati in righe esplicite).

## Flexbox: layout unidimensionale

Flexbox (`display: flex` sul contenitore) distribuisce i figli lungo un **asse principale** (*main axis*) e un **asse trasversale** (*cross axis*) perpendicolare al primo. La direzione dell'asse principale è determinata da `flex-direction`; di conseguenza concettualmente le due direzioni non coincidono mai con "orizzontale" e "verticale" in senso assoluto.

| Proprietà | Asse su cui agisce | Valori principali | Funzione |
| :--- | :--- | :--- | :--- |
| `flex-direction` | Main axis | `row`, `row-reverse`, `column`, `column-reverse` | Definisce la disposizione degli elementi e quindi il verso dell'asse principale. |
| `flex-wrap` | - | `nowrap` (default), `wrap`, `wrap-reverse` | Consente il wrapping su più righe quando gli elementi non entrano nel contenitore. |
| `justify-content` | Main axis | `flex-start`, `center`, `flex-end`, `space-between`, `space-around`, `space-evenly` | Distribuisce lo spazio libero lungo l'asse principale. |
| `align-items` | Cross axis | `stretch` (default), `flex-start`, `center`, `flex-end`, `baseline` | Allinea i figli lungo l'asse trasversale; `stretch` estende ciascun figlio per riempire l'altezza della riga. |
| `align-content` | Tra le righe | `stretch`, `flex-start`, `center`, `space-between` | Gestisce la distribuzione dello spazio tra più righe, opera solo se `flex-wrap` è attivo. |
| `gap` | Entrambi | lunghezza | Spaziatura minima tra i figli, senza ricorrere a `margin`. |
| `flex` | Flessibilità dei figli | `flex: <grow> <shrink> <basis>` | Fattore di crescita, fattore di compressione e dimensione di base del singolo figlio. |

```css
.contenitore {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  gap: 16px;
}

.voce {
  flex: 1 1 200px;  /* cresce, si comprime, base 200px */
}
```

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261007092448.png" width="300">
</div>

## CSS Grid: layout bidimensionale

La griglia (`display: grid`) organizza i figli su righe e colonne contemporaneamente, con due assi di dimensionamento indipendenti. Le tracce (*grid track*, cioè lo spazio fra due linee adiacenti della griglia) sono definite esplicitamente o generate automaticamente.

| Proprietà | Funzione |
| :--- | :--- |
| `grid-template-columns` | Definizione delle colonne come elenco di tracce (dimensioni fisse, percentuali, `fr` o funzioni come `minmax()`). |
| `grid-template-rows` | Definizione delle righe con la stessa sintassi. |
| `gap` (alias `grid-gap`) | Spaziatura fra le tracce; accetta un valore per entrambe le direzioni o due valori (righe, colonne). |
| `grid-column` / `grid-row` | Posizionamento esplicito di un elemento: linea di inizio / linea di fine / span. |
| `grid-area` | Assegnazione dell'elemento a una zona denominata o a un'intera area. |
| `place-items` | Scorciatoia per `align-items` e `justify-items`. |

```css
.griglia {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: auto 200px;
  gap: 12px;
}

.elemento-a {
  grid-column: 1 / 3;
  grid-row: 2;
}
```

La funzione `repeat(n, valore)` evita di elencare `n` tracce identiche; l'unità `fr` (frazione) distribuisce lo spazio libero in proporzioni relative. Le tracce dichiarate ma non occupate sono *piste esplicite vuote*, mentre quelle generate automaticamente dal posizionamento degli elementi sono *piste implicite*.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261007092543.png" width="300">
</div>

## Il confronto fra table, Flexbox e Grid

| Caratteristica | `display: table` | Flexbox | Grid |
| :--- | :--- | :--- | :--- |
| **Dimensioni** | Una sola (righe e celle) | Una sola (main axis) | Due (righe e colonne) |
| **Governo delle dimensioni** | Le dimensioni delle celle si adattano al contenuto | Il contenitore è dimensionato dal contenuto, i figli si adattano al contenitore | Il contenitore definisce esplicitamente tracce, i figli si adattano alla griglia |
| **Allineamento** | Verticale sulle celle, limitato | Sull'asse principale e su quello trasversale | Sulla riga e sulla colonna, con controllo indipendente |
| **Distribuzione dello spazio** | Implicita | `justify-content`, `align-items`, `space-between` | `fr`, `space-between`, `justify-items` |
| **Comportamento a runtime** | Le celle si adattano dinamicamente al contenuto | I figli crescono e si comprimono in base allo spazio disponibile | Le tracce restano dimensionalmente stabili |
| **Casi d'uso** | Impostazione allineata di contenuti eterogenei (form, menu) | Distribuzione di componenti su una riga o colonna, toolbar, navigazione | Layout di pagina complessi con zone e aree definite a priori |

### Media query e layout responsive

Il layout *responsive* adatta la pagina alla dimensione dello schermo senza cambiare il documento HTML. Il presupposto è il tag `<meta name="viewport" content="width=device-width, initial-scale=1">`, senza il quale il browser mobile assume una larghezza fittizia di circa 980 pixel e scala l'intera pagina.

Le **media query** applicano un blocco di dichiarazioni solo quando la condizione è soddisfatta:

```css
/* mobile first: stile base per lo schermo piccolo */
.layout { display: grid; grid-template-columns: 1fr; gap: 16px; }

@media (min-width: 768px) {
  .layout { grid-template-columns: 2fr 1fr; }
}
```

L'approccio **mobile first** scrive le regole di base per lo schermo più stretto e aggiunge i miglioramenti nei breakpoint successivi: le regole valide restano valide anche quando non si applicano, quindi ogni breakpoint deve poter essere rimosso senza rompere la pagina.

| Tecnica | A cosa serve |
| :--- | :--- |
| `rem`, `%`, `vw`, `vh` | dimensioni relative a radice, contenitore o viewport, al posto dei pixel fissi |
| `clamp(min, preferita, max)` | vincola un valore fra un minimo e un massimo senza media query |
| `max-width` con `margin: auto` | limita la larghezza del contenuto sui monitor grandi |
| `@media (prefers-color-scheme: dark)` | applica uno stile diverso secondo la preferenza di tema del sistema |
| `@media (prefers-reduced-motion: reduce)` | riduce o disattiva le animazioni per chi lo ha richiesto nel sistema |

## I tag semantici di sezione

Gli elementi di sezione non hanno funzione di layout (il loro posizionamento è governato dal CSS) ma attribuiscono **significato strutturale** al documento: rendono il codice leggibile per lo sviluppatore, interpretabile per i crawler e accessibile per le tecnologie assistive.

- **`<main>`:** contenuto primario e univoco della pagina; ce n'è uno solo per documento.
- **`<header>`:** intestazione di una pagina o di una sezione. Contiene tipicamente titolo, logo, barra di navigazione e informazioni introduttive.
- **`<nav>`:** sezione dedicata alla navigazione, con i link principali del sito. Se ne inseriscono quanti necessari (tipicamente uno per area di navigazione: principale, secondaria, di pagina).
- **`<section>`:** sezione tematica di contenuto. Dovrebbe essere accompagnata da un titolo (`<h1>`-`<h6>`) che ne descriva il tema.
- **`<article>`:** contenuto autonomo e autosufficiente (post di blog, articolo di notizie, commento), destinato a essere distribuito o riutilizzato al di fuori del contesto originale.
- **`<aside>`:** contenuto secondario o supplementare rispetto al flusso principale, spesso collocato lateralmente (barre laterali, note, pubblicità, glossario).
- **`<address>`:** informazioni di contatto dell'autore o dell'entità più vicina (indirizzo fisico, telefono, email). Non va usato per l'indirizzo di citazione di un'opera, per il quale esiste `<cite>`.
- **`<footer>`:** informazioni di chiusura di una pagina o di una sezione: copyright, autore, link di contatto e di navigazione secondaria.

```html
<body>
  <header>
    <h1>Titolo del sito</h1>
    <nav>
      <a href="#home">Home</a>
      <a href="#servizi">Servizi</a>
    </nav>
  </header>

  <main>
    <article>
      <h2>Titolo dell'articolo</h2>
      <section>
        <h3>Contenuto della sezione</h3>
        <p>Testo dell'articolo.</p>
      </section>
      <aside>Nota correlata al contenuto.</aside>
    </article>
  </main>

  <footer>
    <address>Via Roma 1, Perugia - info@example.com</address>
  </footer>
</body>
```

> [!important] Vincoli di utilizzo
> * `<header>` e `<footer>` possono comparire più volte: una per la pagina e una per ciascun `<article>` o `<section>`.
> * `<section>` priva di intestazione propria non introduce un confine tematico riconoscibile: è preferibile usare `<div>`.
> * `<address>` non va usato per l'indirizzo di una persona citata: in quel caso si usa `<cite>`.
> * I tag di sezione non sostituiscono `<main>`, che delimita il contenuto primario e univoco della pagina.

> [!info] Sintesi:
> - `<video>` e `<audio>` condividono `src`, `controls`, `autoplay`, `loop` e `muted` (`poster`, `width` e `height` sono propri di `<video>`); il MIME type si dichiara su `<source>`, l'autoplay con audio è bloccato senza `muted` e su mobile serve `playsinline`. `<source>` dà sorgenti alternative con fallback e `preload` governa il precaricamento.
> - `<a>` usa `href`, `target`, `title` e `download`; i fragment puntano agli `id` e `target="_blank"` va protetto da `rel="noopener noreferrer"`.
> - `<div>` è block e `<span>` inline, ma il layout si governa con `display`, non con il tag.
> - `column-*` crea colonne, `float` avvolge il testo e `clear` interrompe l'avvolgimento; `position` distingue `static`, `relative`, `absolute`, `fixed` e `sticky`, con `z-index` per l'impilamento; `table`, Flexbox e Grid si distinguono per numero di assi e governo delle dimensioni, e `place-items`/`justify-content`/`align-items` centrano il contenuto.
> - Il layout responsive si ottiene con `<meta name="viewport">` e media query, con approccio mobile first e `rem`, `%`, `vw` e `clamp()` al posto dei pixel fissi.
> - I tag semantici di sezione (`header`, `nav`, `main`, `section`, `article`, `aside`, `address`, `footer`) danno struttura a crawler e tecnologie assistive.
