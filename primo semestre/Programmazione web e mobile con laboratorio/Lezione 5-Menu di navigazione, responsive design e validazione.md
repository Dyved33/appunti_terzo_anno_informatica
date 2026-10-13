# Menu di navigazione, responsive design e validazione

## Menu di navigazione
Il menu di navigazione è l'elemento chiave di un sito web che consente agli utenti di spostarsi facilmente tra le diverse sezioni e pagine. Buone pratiche:
- Indicare la sezione attiva
- Assicurarsi che il menu sia navigabile tramite tastiera (con `Tab`)
- Adattare il menu per funzionare su dispositivi di diverse dimensioni (responsive)
- Mantenere uno stile coerente con il resto del sito

**Tipi di menu:** orizzontali, verticali, dropdown e burger.

<div style="display: flex; gap: 10px; text-align: center;">
  <div style="flex: 1;">
    <img src="Pasted image 20261013164620.png" alt="Menu orizzontale" style="width: 100%;" />
    <p>Orizzontali</p>
  </div>
  <div style="flex: 1;">
    <img src="Pasted image 20261013164639.png" alt="Menu verticale" style="width: 100%;" />
    <p>Verticali</p>
  </div>
  <div style="flex: 1;">
    <img src="Pasted image 20261013164700.png" alt="Menu dropdown" style="width: 100%;" />
    <p>Dropdown</p>
  </div>
  <div style="flex: 1;">
    <img src="Pasted image 20261013164717.png" alt="Menu burger" style="width: 100%;" />
    <p>Burger</p>
  </div>
</div>

**Affordance:** semplicità di capire come funziona uno strumento, un sito o un menu; un'affordance alta si capisce subito.

**Progettare il menu:**
- Usare nomi brevi e descrittivi per le ancore, per far capire i contenuti
- La navigazione deve trovarsi dove gli utenti se l'aspettano (di solito in alto o a lato della pagina)
- I link devono avere un aspetto riconoscibile, in modo che gli utenti capiscano che sono interattivi
- I link devono essere facilmente distinguibili e separati tra loro

> [!tip] Ricorda
> Più padding su un link significa un'area cliccabile più grande, quindi un link più facile da premere.

## Esercizio: menu con flexbox
L'esercizio costruisce un menu orizzontale con una lista di link e lo stila con flexbox.

```html
<nav>
  <ul>
    <li><a href="#home">Home</a></li>
    <li><a href="#about">Chi Siamo</a></li>
    <li><a href="#services">Servizi</a></li>
    <li><a href="#portfolio">Portfolio</a></li>
    <li><a href="#contact">Contatti</a></li>
  </ul>
</nav>
```

```css
nav {
  font-family: sans-serif;
  background-color: #333;
}
nav ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  display: flex;
}
nav ul li {
  padding: 1em;
}
nav ul li a {
  color: #fff;
  text-decoration: none;
}
nav ul li a:hover {
  color: #FFD700;
}
```

> [!info] In altre parole:
> `:hover` è la pseudo-classe che si attiva quando il puntatore passa sopra l'elemento: nel CSS serve a cambiare una proprietà in quel momento (qui il colore del link).

> [!tip] Ricorda
> Il gradiente lineare (*linear gradient*) si ottiene scegliendo un colore di inizio e uno di fine: il browser disegna la transizione tra i due.

Un esempio affine è in [[esercizi/menuResponsive.html|menuResponsive]].

## Menu secondari
La navigazione primaria non deve mai cambiare in tutto il sito, la secondaria invece cambia a seconda della pagina corrente.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261013165542.png" style="width: 100%;">
</div>

## Responsive design
Approccio alla progettazione web che permette a un sito di adattarsi automaticamente a diverse dimensioni e risoluzioni dello schermo, come desktop, tablet e smartphone. L'obiettivo è garantire che il contenuto sia leggibile e facilmente navigabile, indipendentemente dal dispositivo utilizzato. Il layout deve modificarsi in base alle dimensioni dello schermo per fornire un'esperienza utente coerente su tutte le piattaforme.

Quasi ogni dispositivo smart ha un qualche tipo di browser. La navigazione web avviene per la maggior parte da dispositivi mobili. Il web è una tecnologia cross-platform.

**Varie risoluzioni:** le tecniche usate sono
- Unità di misura relative (%, em)
- Layout flessibile (flex, grid)
- Media query, per stili diversi su schermi diversi

```css
@media (max-width: 768px) {
  #container {
    flex-direction: column;
  }
}
```

> [!info] In altre parole:
> La media query con `max-width` si applica solo se lo schermo è largo al massimo fino a quella dimensione.

### Media query
Regole CSS per applicare stili diversi in base a condizioni come:
- Larghezza massima: `max-width`
- Larghezza minima: `min-width`
- Orientamento: `orientation: portrait` / `landscape`
- Tipo di media: `screen`, `print`

```css
@media screen and (min-width: 600px) and (max-width: 1200px) and (orientation: landscape) {
  /* stili applicati quando: media screen, larghezza >= 600px e <= 1200px, orientamento landscape */
}
```

> [!info] In altre parole:
> Il browser, interagendo con l'hardware, sa se il dispositivo è orizzontale o verticale.

**Tagli standard:**

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261013172803.png" style="width: 100%;">
</div>

> [!tip] Ricorda
> Per il corso meno di 1000 px significa smartphone, più di 1000 px significa pc.

### Viewport
È l'area visibile di una pagina web in un browser. Determina come il contenuto si adatta a schermi di diverse dimensioni. È cruciale per il design responsivo e l'ottimizzazione mobile. Per controllare le dimensioni e la scala del viewport si usa il meta tag:

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

> [!info] In altre parole:
> Conviene usare unità di misura scalabili come % e em invece dei pixel. Con `flex-direction: row` il layout resta orizzontale (pc), con `column` diventa verticale (smartphone).

## Nascondere un elemento
Tre proprietà CSS nascondono un elemento ma con effetti diversi:

| Proprietà | Effetto | Occupa spazio nel layout |
|---|---|---|
| `display: none` | Rimuove l'elemento dal layout, come se non esistesse | No |
| `visibility: hidden` | Nasconde l'elemento (valore booleano `hidden` / `visible`) | Sì |
| `opacity: 0` | Rende l'elemento trasparente (valore da 0 a 1) | Sì |

## Validazione
Garantisce che le pagine web siano conformi agli standard del World Wide Web Consortium (W3C).

Svantaggi del codice HTML non conforme:
- Problemi di visualizzazione (rendering incoerente e possibili elementi mancanti)
- Accessibilità compromessa (difficoltà per utenti con disabilità nell'interagire con il sito)
- Impatto negativo sulla SEO (indicizzazione inefficiente e potenziali classifiche inferiori)
- Manutenzione difficile (maggiore complessità nel debugging e nella collaborazione)
- Compatibilità limitata (difficoltà ad adattarsi a nuovi standard e aggiornamenti)
- Esperienza utente negativa (frustrazione degli utenti e impressione negativa del brand)

Esempi di validatori:
- HTML5: https://validator.w3.org/
- CSS3: https://jigsaw.w3.org/css-validator/

> [!info] Sintesi:
> - Il menu di navigazione sposta tra le sezioni del sito: deve indicare la sezione attiva, essere navigabile da tastiera, responsive e coerente.
> - Il responsive design adatta il layout a dimensioni e risoluzioni diverse usando unità relative, layout flessibile e media query.
> - Le media query applicano stili in base a condizioni: `max-width`/`min-width`, orientamento e tipo di media (`screen`, `print`).
> - Il meta viewport controlla dimensioni e scala dell'area visibile, con unità scalabili come % ed em.
> - La validazione W3C garantisce la conformità; il codice non conforme causa problemi di rendering, accessibilità, SEO e manutenzione.
