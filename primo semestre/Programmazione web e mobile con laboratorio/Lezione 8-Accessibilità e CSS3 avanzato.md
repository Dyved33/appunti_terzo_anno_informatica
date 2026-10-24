# Accessibilità e CSS3 avanzato (ombre, gradienti, transform, transition, animation)

## Leggibilità

- User Experience: testi facili da leggere migliorano l'esperienza utente e aumentano la comprensione
- Accessibilità: contenuti leggibili permettono a un pubblico più ampio di accedere alle informazioni, compresi gli utenti con disabilità visive o cognitive
- Customer retention: una buona leggibilità mantiene l'attenzione dell'utente, aumentando la possibilità che resti sul sito e interagisca con i contenuti
- SEO: testi chiari e ben strutturati aiutano i motori di ricerca a interpretare meglio il contenuto e dare visibilità al sito

**Creare testi leggibili:**

- Utilizzare titoli, sottotitoli e paragrafi brevi per facilitare la scansione del testo
- Evidenziare parole chiave o concetti per facilitare la lettura a colpo d'occhio
- Optare per font non complessi e con dimensioni adeguate (1 em minimo per il corpo)
- Scegliere colori che aumentino il contrasto e risultino chiari su schermo
- Aggiungere spazio tra i paragrafi per evitare confusione

<div style="display: flex; justify-content: center;">
  <img src="slide-03.png" width="30%">
</div>

*La figura: struttura di una pagina Wikipedia come esempio di gerarchia visiva, navigazione laterale, contenuto principale e footer.*

<div style="display: flex; justify-content: center;">
  <img src="slide-04.png" width="30%">
</div>

*La figura: dettaglio della pagina Wikipedia con indice, strumenti, lingue e metadati della voce.*

## Accessibilità

- Assicurare un contrasto elevato tra testo e sfondo
- Aggiungere descrizioni alle immagini e contenuti multimediali per i lettori di schermo
- Ottimizzare l'interazione senza mouse
- Usare dimensioni e unita relative per permettere agli utenti di regolare il testo

<div style="display: flex; justify-content: center;">
  <img src="slide-07.png" width="30%">
</div>

*La figura: esempio visivo di principi di accessibilità applicati a una pagina web.*

**Tag HTML per struttura accessibile:**

- `<label>`: associa delle etichette agli input tramite attributo `for`
- `<header>`, `<nav>`, `<main>`, `<footer>`: organizzano la struttura della pagina per gli screen reader

**Attributi:**

- `alt`: per descrivere immagini
- `tabindex`: determina l'ordine in cui gli elementi interattivi vengono selezionati quando un utente naviga usando il tasto Tab

```html
<img src="logo.png" alt="Logo dell'azienda: uccello stilizzato azzurro">

<a href="#contenuto" tabindex="1">Vai al contenuto</a>
<button tabindex="0">Pulsante accessibile</button>
<div tabindex="-1">Focus programmabile ma non da tastiera</div>
```

- `role`: specifica il ruolo di un elemento per le tecnologie assistive

```html
<div role="alert">Messaggio di errore importante</div>
<nav role="navigation">Menu principale</nav>
<button role="button">Elemento che si comporta come bottone</button>
```

`:focus`:

- Pseudo-classe CSS
- Si applica a un elemento quando riceve il focus (click o Tab)
- Evidenzia gli elementi attivi

```css
a:focus, button:focus, input:focus {
  outline: 3px solid #0066cc;
  outline-offset: 2px;
}
```

**ARIA:**

- Accessible Rich Internet Applications
- Standard del W3C
- Insieme di attributi per migliorare l'accessibilità dove HTML non basta

```html
<button aria-label="Chiudi finestra" aria-expanded="false">×</button>
<input type="text" aria-labelledby="label-nome" aria-describedby="help-nome">
<div id="label-nome">Nome utente</div>
<div id="help-nome" role="tooltip">Inserisci il tuo nome completo</div>
<nav aria-label="Navigazione principale">
  <ul role="menubar">...</ul>
</nav>
```

**Soluzioni per gestire il daltonismo:**

<div style="display: flex; justify-content: center;">
  <img src="slide-14.png" width="30%">
</div>

*La figura: confronto tra un form che usa solo il colore per indicare errori (sinistra) e la stessa vista simulata per deuteranopia (destra), dove i campi rossi diventano indistinguibili.*

<div style="display: flex; justify-content: center;">
  <img src="slide-15.png" width="30%">
</div>

*La figura: versione accessibile con icone (✓/✗), bordi rossi e messaggi testuali "enter valid email address" - comprensibile anche senza distinguere i colori.*

- Utilizzare combinazioni di colori che garantiscano una chiara distinzione tra testo e sfondo
- Evitare di utilizzare il colore come unico mezzo per trasmettere informazioni
- Combinare colori con descrizioni testuali o icone per migliorare la comprensione
- Testare il design del sito con strumenti che simulano diverse forme di daltonismo per garantire l'accessibilità

**Tool online:**

- https://color.adobe.com/it/create/color-contrast-analyzer
- https://color.adobe.com/it/create/color-accessibility
- Lighthouse per Chrome

## Altre proprietà CSS3

**box-shadow:**

- Aggiunge un'ombra a un elemento
- Valori:
  - h-offset: spostamento orizzontale
  - v-offset: spostamento verticale
  - blur-radius: raggio di sfocatura
  - spread-radius: espansione
  - color: colore dell'ombra

```css
.box {
  box-shadow: 4px 4px 8px rgba(0, 0, 0, 0.3);
}

.multiple {
  box-shadow: 2px 2px 4px #aaa, -2px -2px 4px #fff;
}
```

**text-shadow:**

- Aggiunge un'ombra al testo
- Valori:
  - h-offset: spostamento orizzontale
  - v-offset: spostamento verticale
  - blur-radius: raggio di sfocatura
  - color: colore dell'ombra

```css
h1 {
  text-shadow: 2px 2px 4px #000;
}

.multi {
  text-shadow: 1px 1px 0 #fff, 2px 2px 0 #000;
}
```

> [!info] N.B.
> Posso dare più ombre separate da virgola: la prima sta in alto, le successive sotto.

**Gradiente:**

- Crea transizioni di colore fluide e sfumate
- Utilizzati per sfondi e pulsanti
- Tipi di gradienti:
  - Lineare
  - Radiale
- Tool online: https://uigradients.com

```css
.linear {
  background: linear-gradient(to right, #ff7fa7, #b5460b);
}

.linear-angles {
  background: linear-gradient(45deg, #1e3c72, #2a5298);
}

.radial {
  background: radial-gradient(circle, #ff7fa7, #b5460b);
}

.radial-ellipse {
  background: radial-gradient(ellipse at center, #1e3c72 0%, #2a5298 100%);
}
```

<div style="display: flex; justify-content: center;">
  <img src="slide-23.png" width="30%">
</div>

*La figura: esempi di gradienti lineari, radiali, diagonali e con sovrapposizione immagine.*

<div style="display: flex; justify-content: center;">
  <img src="slide-24.png" width="30%">
</div>

*La figura: stati di un bottone (Normal, Hover, Active) con gradienti e ombre differenti.*

> [!info] N.B.
> `:active` definisce lo stile mentre l'utente preme il mouse/tocco senza rilasciare.

> [!warning]
> - `:active`: comportamento al click
> - `:focus`: comportamento per navigazione con `Tab` 

**transform:**

- Applica trasformazioni 2D o 3D a un elemento
- Funzioni chiave:
  - `translate`: sposta un elemento dalla sua posizione attuale
  - `rotate`: ruota un elemento attorno a un punto fisso
  - `scale`: ridimensiona un elemento
  - `skew`: inclina un elemento lungo gli assi X e/o Y

```css
.combinato {
  transform: translate(1em, 1em) rotate(5deg) scale(0.8) skew(4deg, 2deg);
}

.transform3d {
  transform: rotateX(35deg);
}
```

> [!info] N.B.
> Posso combinare più trasformazioni in un solo `transform` (altrimenti viene applicato solo l'ultimo).

**Prospettiva:**

La proprietà `perspective` sull'elemento padre dà profondità alle trasformazioni 3D dei figli.

<div style="display: flex; justify-content: center;">
  <img src="slide-27.png" width="30%">
</div>

*La figura: "Cosa manca?" - senza `perspective` la rotazione `rotateX(35deg)` appare piatta.*

<div style="display: flex; justify-content: center;">
  <img src="slide-28.png" width="30%">
</div>

*La figura: codice con `perspective: 15em` sul contenitore e `transform: rotateX(35deg)` sul contenuto per creare l'effetto 3D.*

```css
#contenitore {
  border: 1px solid #222;
  width: 10em;
  text-align: center;
  font-family: sans-serif;
  perspective: 15em;
}

#contenuto {
  transform: rotateX(35deg);
  background: #ff7fa7;
  padding: 2em;
  color: #fff;
}
```

**transition:**

- Consente di animare le modifiche delle proprietà CSS
- Crea un effetto fluido quando un elemento cambia stato
- Funzioni chiave:
  - `transition-duration`: durata dell'animazione
  - `transition-timing-function`: curva di accelerazione
  - `transition-delay`: ritardo
  - `transition-property`: proprietà da animare

```css
/* Sintesi breve */
.box {
  transition: background 0.3s ease, transform 0.2s ease-in;
}

/* Più transizioni con ordini e ritardi diversi */
.esercizio1 {
  transition: 0.5s ease-in 0.1s background, 0.3s ease-in 0s box-shadow;
}
```

> [!example] Esercizio 1: ordine delle transizioni
> ```css
> transition: 0.5s ease-in 0.1s background, 0.3s ease-in 0s box-shadow;
> ```
> All'hover: prima parte `box-shadow` (0.3s, nessun ritardo), poi `background` (0.5s con 0.1s ritardo). Le due animazioni corrono in parallelo ma con tempi diversi.

**Esercizio 2: Flip card con perspective**

*La figura: struttura HTML/CSS per una carta che si gira su hover - il contenitore ha `perspective`, la carta ruota di 180° sull'asse Y e cambia immagine di sfondo (l'immagine sul retro è specchiata).*

*La figura: risultato visivo - la carta gira mostrando il retro con immagine diversa.*

```html
<div id="contenitore">
  <div id="carta"></div>
</div>
```

```css
#contenitore {
  perspective: 100em;
  width: fit-content;
}

#carta {
  background-image: url(../immagini/serra_angel.jpg);
  width: 20em;
  aspect-ratio: 5 / 7;
  border-radius: 1em;
  background-size: cover;
  transition: 1s linear transform, 0s linear 0.5s background;
}

#contenitore:hover #carta {
  transform: rotateY(180deg);
  background-image: url(../immagini/back_reverse.jpg);
}
```

**animation:**

- Permette di creare animazioni complesse per gli elementi
- I `@keyframes` descrivono le transizioni tra le proprietà CSS nel tempo
- Funzioni chiave:
  - `animation-name`: nome dell'animazione
  - `animation-duration`: durata totale dell'animazione
  - `animation-timing-function`: curva di accelerazione
  - `animation-delay`: ritardo
  - `animation-iteration-count`: numero di ripetizioni

```css
@keyframes hoverAnimation {
  0% {
    transform: scale(1);
    background-color: #b5460b;
  }
  50% {
    transform: scale(1.1);
    background-color: #d9540e;
  }
  100% {
    transform: scale(1);
    background-color: #b5460b;
  }
}

#button1 {
  margin: 1em;
  padding: 1em 2em;
  font-size: 1.2em;
  background-color: #b5460b;
  color: #fff;
  border: none;
  border-radius: 0.2em;
  cursor: pointer;
}

#button1:hover {
  animation: hoverAnimation 0.5s ease-in 0s 1;
}
```

*La figura: esempio completo di `@keyframes` con scalata e cambio colore, applicato all'hover di un bottone.*

> [!info] Sintesi:
> - Leggibilità: titoli, paragrafi brevi, font ≥1em, contrasto, spazio tra paragrafi.
> - Accessibilità: struttura semantica (`<header>`, `<nav>`, `<main>`, `<footer>`, `<label>`), attributi `alt`, `tabindex`, `role`, `:focus`, ARIA (`aria-label`, `aria-labelledby`, `aria-describedby`); daltonismo: non usare solo il colore, aggiungere icone/testo, testare con simulatori.
> - Ombre: `box-shadow` e `text-shadow` con offset, blur, spread, color; multiple ombre separate da virgola.
> - Gradient: `linear-gradient(direction, color-stop...)` e `radial-gradient(shape at position, color-stop...)`.
> - Transform: `translate`, `rotate`, `scale`, `skew` in un'unica proprietà; `perspective` sul padre per 3D.
> - Transition / Animation: `transition` per animare cambi di proprietà (duration, timing, delay); `@keyframes` + `animation` per animazioni complesse a step.