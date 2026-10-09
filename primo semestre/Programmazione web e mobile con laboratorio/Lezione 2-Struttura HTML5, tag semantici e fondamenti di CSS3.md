# Struttura HTML5, tag semantici e fondamenti di CSS3

## Lo standard HTML5

**HTML5** è la quinta revisione del linguaggio standard per la strutturazione dei documenti sul Web, nata nel **WHATWG** (*web hypertext application technology working group*) e poi adottata dal **W3C** (*world wide web consortium*); oggi è mantenuta come *HTML Living Standard* dal WHATWG, che dal 2019 ha ripreso in carico l'attività di standardizzazione. Le innovazioni cardine sono:

- **Tag semantici avanzati:** elementi specifici per descrivere la struttura del documento in modo significativo per macchine e motori di ricerca.
- **Supporto multimediale nativo:** integrazione diretta di audio e video tramite i tag `<audio>` e `<video>`, senza plugin proprietari esterni come Flash o Silverlight.
- **Progettazione mobile-first:** architettura ottimizzata per la compatibilità con dispositivi mobili, schermi ad alta densità di pixel e interfacce basate su input touch.

## La tassonomia dei tag HTML

Gli elementi HTML si classificano in base al loro comportamento sintattico e al loro posizionamento nel flusso del documento.

**Tag contenitori** (*container*, *paired tags*): racchiudono contenuto testuale o altri elementi annidati e richiedono di norma sia il tag di apertura sia quello di chiusura, `<tag>...</tag>` (per alcuni elementi, come `<p>`, il tag di chiusura può però essere omesso).

- `<div>`: contenitore generico a livello di blocco, privo di valore semantico proprio.
- `<p>`: paragrafo destinato esclusivamente a blocchi di testo.
- `<section>`: sezione tematica e logica di una pagina web, solitamente corredata da un'intestazione (`<h1>`-`<h6>`), contenuti dedicati ed elementi di separazione.

> [!info] Semantica e indicizzazione SEO:
> Sebbene a livello visivo elementi come `<div>`, `<p>` e `<section>` possano apparire simili o assolvere funzioni visive analoghe, la differenza essenziale risiede nel loro **significato semantico**. Crawler e motori di ricerca, incluso Google, analizzano minuziosamente la struttura semantica: una marcatura scorretta o priva di gerarchia logica può penalizzare l'accessibilità e compromettere l'indicizzazione o la corretta resa della pagina.

**Tag vuoti o auto-chiudenti** (*void*, *empty tags*): elementi che non racchiudono contenuti interni e non possiedono un tag di chiusura esplicito; il loro comportamento è governato dagli attributi.

- `<img>`: inclusione di immagini. Richiede gli attributi obbligatori `src`, il percorso relativo o assoluto del file immagine, e `alt`, testo alternativo descrittivo, fondamentale per l'accessibilità (screen reader) e per l'ottimizzazione SEO.

```html
<img src="fiore.jpg" alt="Girasole in campo">
```

- `<input>`: elemento impiegato all'interno dei moduli di acquisizione (*form*) in cui l'utente digita o seleziona dati.
- `<hr>`: linea orizzontale di separazione tematica (*horizontal rule*).

**Tag di blocco** (*block-level elements*): occupano l'intera larghezza orizzontale disponibile nel contenitore genitore e generano automaticamente un'interruzione di riga prima e dopo l'elemento; possono contenere elementi inline e altri elementi di blocco, con le eccezioni del content model (per esempio `<p>` non può contenere elementi di blocco). Esempi: `<div>`, titoli `<h1>`-`<h6>`, `<p>`, `<section>`.

**Tag di linea** (*inline elements*): non generano un ritorno a capo e occupano unicamente lo spazio orizzontale strettamente indispensabile al loro contenuto.

- `<span>`: contenitore inline generico e privo di semantica, impiegato per isolare porzioni di testo al fine di applicare stili CSS mirati.
- `<a>`: definisce un collegamento ipertestuale verso altre pagine o ancore interne mediante l'attributo `href`.
- `<img>`: si comporta di default come elemento inline, posizionandosi lungo il flusso del testo senza forzare il ritorno a capo.

## La struttura di un documento HTML5

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

- `<!DOCTYPE html>`: definisce il tipo di documento, comunicando al motore di rendering che la pagina segue lo standard HTML5.
- `<html lang="it">`: elemento radice (*root*) dell'intero albero DOM, con il parametro `lang` che specifica la lingua principale del testo.
- `<head>`: raccoglie metadati tecnici, codifiche, titoli e collegamenti a risorse esterne, non visibili direttamente nella viewport.
- `<title>`: testo mostrato nella scheda o etichetta (*tab label*) della finestra del browser e usato come titolo nei motori di ricerca.
- `<meta charset="utf-8">`: specifica la codifica dei caratteri; `charset` è obbligatorio e lo standard `utf-8` garantisce la corretta visualizzazione di caratteri speciali e accentati.
- `<body>`: contiene tutti gli elementi grafici e testuali effettivamente renderizzati a schermo per l'utente finale.

## Attributi, testo e citazioni

Gli attributi forniscono informazioni e configurazioni addizionali per un elemento HTML, alterandone il comportamento o l'aspetto. Si esprimono nella sintassi `nome="valore"` all'interno del tag di apertura. **Separazione dei compiti** (*separation of concerns*): sebbene HTML consenta attributi di stile inline come `style="..."`, la pratica è scorretta; le direttive di stile vanno nei file CSS e gli script nei file JavaScript.

- `<strong>`: indica che il testo racchiuso possiede una forte rilevanza semantica; i browser moderni ne enfatizzano la resa applicando il grassetto.
- `<q>`: elemento inline per **citazioni brevi**; il browser inserisce automaticamente le virgolette tipografiche attorno al testo senza mandare a capo.
- `<blockquote>`: elemento a livello di blocco per **citazioni lunghe o integrali**, reso con un rientro laterale (*indentation*) e con la sorgente informativa nell'attributo `cite`.
- `<br>`: inserisce un'interruzione di riga forzata.

> [!warning] Attenzione:
> Il tag `<br>` non deve mai essere impiegato per generare spaziatura verticale o impaginazione grafica tra paragrafi, compito demandato a margini e padding in CSS. Va usato esclusivamente quando l'interruzione di riga costituisce parte integrante del contenuto informativo, per esempio nei versi di una poesia o nella formattazione di indirizzi fisici.

## Le liste

1. **Liste ordinate (`<ol>`, *ordered list*):** gli elementi `<li>` (*list item*) sono contrassegnati da una sequenza numerata progressiva (1, 2, 3...).
2. **Liste non ordinate (`<ul>`, *unordered list*):** gli elementi `<li>` sono preceduti da un marcatore grafico a punto (*bullet point*).
3. **Liste di descrizione (`<dl>`, *description list*):** strutturate in coppie di termini (`<dt>`) e relative descrizioni (`<dd>`).

È possibile annidare una lista all'interno di un'altra (*nesting*): i browser differenziano graficamente la gerarchia applicando marcatori distinti ai vari livelli di profondità, per esempio pallino pieno per il livello radice e pallino vuoto o quadrato per i livelli annidati.

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

## I fondamenti di CSS3

**CSS3** (*cascading style sheets level 3*) è lo standard per la definizione dello stile e della resa visiva dei documenti strutturati in HTML. La sua finalità è elevare l'esperienza visiva dell'utente (UX/UI), snellire e modulare la scrittura del codice di presentazione e garantire layout *responsive* capaci di adattarsi a display di dimensioni e risoluzioni differenti. Il collegamento al documento avviene nella sezione `<head>` con il tag:

```html
<link rel="stylesheet" href="stile.css">
```

dove `rel` specifica il tipo di relazione (`stylesheet`) e `href` indica il path del file sorgente CSS.

**Anatomia di una regola CSS:** una regola si compone di un selettore e di un blocco di dichiarazione.

```css
selettore {
  proprieta: valore;
  altra-proprieta: valore;
}
```

Il **selettore** individua i nodi del DOM a cui applicare le direttive, per esempio `h1` seleziona tutti i titoli di primo livello della pagina. Il **blocco di dichiarazione**, racchiuso tra parentesi graffe `{ ... }`, contiene una sequenza di coppie `proprietà: valore;` terminate dal punto e virgola (facoltativo sull'ultima dichiarazione del blocco).

### Colori

La proprietà `color` determina il colore del testo di un elemento e supporta molteplici notazioni: esadecimale con prefissato da cancelletto (`#ff0000` o la forma abbreviata `#f00`), notazione RGB o RGBA (`rgb(255, 0, 0)` o con canale alfa di trasparenza `rgba(255, 0, 0, 0.8)`), keyword nominali come `red`, `blue`, `black`.

### Tipografia

- `font-family`: specifica la famiglia di caratteri da applicare. Le macro-famiglie generiche sono `serif` (font con grazie o terminali sui tratti), `sans-serif` (font lineari privi di grazie), `monospace` (font a spaziatura fissa, in cui ogni carattere occupa la medesima larghezza), `cursive` (font corsivi, con tratti simili alla scrittura a mano) e `fantasy` (font decorativi).
- `font-style`: stile del testo (`normal`, `italic`, `oblique`).
- `font-size`: dimensione del carattere, espressa in `px`, `em`, `%`, `rem`.
- `font-weight`: spessore del tratto, con valori numerici da `100` a `900` a passi di 100 oppure keyword come `normal` e `bold`.

> [!info] Fallback dei font:
> Non tutti i font supportano nativamente l'intera gamma di varianti e pesi tipografici. Qualora una specifica combinazione non sia presente nel file font, il browser adotta un meccanismo di fallback adattando la resa alla variante disponibile più vicina.

### Allineamento e decorazione

- `text-align`: allineamento orizzontale del testo (`left`, `center`, `right`, `justify`).
- `text-decoration`: decorazioni di linea (`underline`, `overline`, `line-through`, `none`).
- `text-transform`: trasformazione del maiuscolo e del minuscolo (`uppercase`, `lowercase`, `capitalize`, `none`).

### Le unità di misura

- **Pixel (`px`):** unità di lunghezza assoluta nel senso CSS, cioè un **pixel di riferimento**: non è un=device pixel e non è fisso in senso assoluto, perché il browser ne riscala il valore in base alla preferenza utente sulla dimensione del carattere e al fattore di zoom.
- **`em`:** unità **relativa** calcolata rispetto al `font-size` dell'elemento corrente o del genitore immediato; offre grande flessibilità, ma in strutture con molti livelli di annidamento può causare un effetto moltiplicativo esponenziale.
- **Percentuale (`%`):** unità **relativa** calcolata direttamente sul valore della proprietà dell'elemento genitore, con un rapporto proporzionale diretto e intuitivo.

## Ereditarietà e cascata

L'**ereditarietà** (*inheritance*) consente ad alcune proprietà di stile, in particolare quelle tipografiche e di colore, di propagarsi automaticamente dagli elementi genitore ai relativi elementi figli: se un elemento figlio non dichiara uno stile esplicito adotta quello ereditato dal genitore, mentre se definisce una propria regola questa sovrascrive (*override*) il valore ereditato.

> [!example] Calcolo con unità relative
> Se il tag `body` definisce `font-size: 2em` e un paragrafo `<p>` figlio dichiara `font-size: 0.5em`, la dimensione calcolata effettiva del testo nel paragrafo è:
> $$2\,\text{em} \times 0.5 = 1\,\text{em}$$
> ma il `0.5em` del paragrafo si risolve sul `font-size` del **genitore immediato**, non sulla radice: con `body { font-size: 2em }` il paragrafo computa `0.5 × 32px = 16px`, che coincide con `1rem` della radice solo per la scelta dei numeri.

I motori dei browser analizzano ed eseguono le regole CSS seguendo l'ordine sequenziale del codice sorgente: a parità di selettore e specificità, l'ultima regola dichiarata sovrascrive quelle antecedenti. Se un paragrafo viene prima impostato con `p { color: red; }` e successivamente con `p { color: blue; }`, il browser applicherà il colore blu.

## Gli sfondi

- `background-color`: colore di sfondo uniforme dell'elemento, con gli stessi formati di `color`.
- `background-image`: immagine di sfondo, con la sintassi `url('percorso/immagine.png')`.
- `background-repeat`: modalità di ripetizione dell'immagine (`repeat`, `no-repeat`, `repeat-x`, `repeat-y`).
- `background-position`: coordinata di ancoraggio iniziale dell'immagine (`top`, `bottom`, `left`, `right`, `center`, percentuali o pixel).
- `background-size`: dimensionamento dell'immagine: `cover` ridimensiona affinché copra interamente la superficie del contenitore, ritagliando le parti eccedenti se le proporzioni differiscono; `contain` ridimensiona l'immagine per farla rientrare interamente nel contenitore, senza ritagli o deformazioni.
- `background-attachment`: determina se lo sfondo scorre solidale con il resto della pagina (`scroll`) oppure rimane fisso rispetto alla viewport durante lo scrolling (`fixed`).

| Caratteristica | Tag `<img>` (HTML) | Proprietà `background-image` (CSS) |
| :--- | :--- | :--- |
| **Scopo primario** | Parte integrante del contenuto semantico del documento | Scopo puramente decorativo ed estetico |
| **Accessibilità** | Elevata: supporta l'attributo `alt` letto dagli screen reader | Nulla per impostazione predefinita: il contenuto dello sfondo non è esposto, ma può essere reso disponibile applicando `role="img"` e un `aria-label` all'elemento con lo sfondo |
| **Ottimizzazione SEO** | Rilevante: indicizzato e ricercabile sui motori di ricerca | Non rilevante: ignorato dai crawler di indicizzazione |
| **Dimensionamento** | Definito tramite attributi HTML (`width`, `height`) o CSS | Gestito interamente tramite `background-size` |
| **Posizionamento** | Segue il normale flusso strutturale del documento (inline) | Flessibile e posizionabile liberamente con `background-position` |
| **Ripetizione** | Non ripetibile (singola istanza nel DOM) | Configurabile e ripetibile tramite `background-repeat` |
| **Ruolo nel layout** | Elemento fisico del DOM che occupa spazio nel flusso | Risiede sullo strato di sfondo, dietro a tutti i contenuti |

> [!info] Sintesi:
> - HTML5 è oggi curato dal WHATWG e introduce tag semantici, multimedia nativo e progettazione mobile-first.
> - I tag sono contenitori (`<div>`, `<p>`, `<section>`) o vuoti (`<img>`, `<input>`, `<hr>`), di blocco o inline: conta il significato semantico più dell'aspetto.
> - Lo scheletro di una pagina è `<!DOCTYPE html>`, `<html lang>`, `<head>` con `charset`, `title` e `<link>`, e `<body>`.
> - Gli stili vanno nei file CSS: `<strong>`, `<q>`, `<blockquote>` e `<br>` hanno significati precisi e `<br>` non serve per impaginare.
> - Le liste sono `<ol>`, `<ul>` e `<dl>` e si annidano; una regola CSS è selettore più blocco di dichiarazioni.
> - Le unità `px` sono assolute, `em` e `%` relative; l'ereditarietà propaga le proprietà tipografiche e a parità di specificità vale l'ultima regola dichiarata.
> - Gli sfondi si governano con `background-*`; `<img>` è contenuto accessibile e indicizzabile, `background-image` è pura decorazione.