# Strutture di controllo in JavaScript

## Strutture di controllo

**if, else if, else:** eseguono blocchi di codice in base a condizioni specifiche.

```javascript
let x = 10;
if (x > 5) {
  console.log("x è maggiore di 5");
} else if (x > 2) {
  console.log("x è compreso tra 3 e 5");
} else {
  console.log("x è 2 o inferiore");
}
```

**switch:** alternativa a una serie di if…else per valutare più valori di una stessa variabile.

```javascript
let giorno = "Lunedì";
switch (giorno) {
  case "Lunedì":
    console.log("Inizio delle lezioni");
    break;
  case "Venerdì":
    console.log("Fine delle lezioni");
    break;
  default:
    console.log("Giorno ordinario");
}
```

**for, for…in, for…of:**

- `for`: esegue un blocco di codice un numero specifico di volte.
```js
for (let i = 0; i < 5; i++) { console.log(i); }
```
- `for...in`: itera sulle proprietà di un oggetto.
```js
let persona = { nome: "Luca", età: 25 };
for (let chiave in persona) { console.log(chiave, persona[chiave]); }
```
- `for...of`: itera su array o altre strutture iterable.
```js
let arr = [1, 2, 3];
for (let numero of arr) { console.log(numero); }
```

**while, do…while:**

- `while`: esegue il blocco finché la condizione è vera.
```js
let i = 0;
while (i < 5) { console.log(i); i++; }
```
- `do...while`: esegue il codice almeno una volta.
```js
let i = 8;
do { console.log(i); i++; } while (i < 5);
```

## Array

Struttura di dati che memorizza una sequenza di valori (numeri, stringhe, oggetti e altri array).
- Gli array sono oggetti.
- Ogni valore ha un indice numerico (a partire da 0).
- Possono contenere valori dello stesso tipo o di tipi diversi.
- Sono dinamici: crescono o riducono durante l'esecuzione.

Creazione:
- Sintassi letterale: `let array1 = [1, 2, 3, 4, 5];`
- Con costruttore: `let array2 = new Array("apple", 1, true, null);`
- Vuoto con lunghezza predefinita: `let array3 = new Array(10);`

Accesso agli elementi:
- Primo elemento: `let el = array[0];`
- Ultimo elemento: `let el = array[array.length - 1]`. Accedere a `array[array.length]` restituisce `undefined`, non solleva un errore out-of-bounds.
- Modificare un elemento: `array[indice] = newVal;`

Metodi utili - manipolazione:
- `push(el)`: aggiunge uno o più elementi alla fine.
- `pop()`: rimuove e restituisce l'ultimo elemento.
- `unshift(el)`: aggiunge uno o più elementi all'inizio.
- `shift()`: rimuove e restituisce il primo elemento.

Metodi utili - ricerca:
- `indexOf(el)`: indice della prima occorrenza (o -1 se non presente).
- `includes(el)`: true se l'elemento esiste.
- `find(callback)`: primo elemento che soddisfa la condizione (altrimenti undefined).

> [!example]
> ```js
> let i = arr.indexOf("C"); // 2
> let check = arr.includes("B"); // true
> let risultato = arr.find(el => el > "C"); // D
> ```

> [!example]
> ![[Pasted image 20261029120809.png|500]]

Metodi utili - ordinamento:
- `sort()`: ordina alfabeticamente o con funzione di confronto personalizzata.
- `reverse()`: inverte l'ordine degli elementi.

> [!example]
> ```js
> let arr = ["L","E","T","T","E","R","E"];
> arr.sort(); // ['E', 'E', 'E', 'L', 'R', 'T', 'T']
> arr.reverse(); // ['T', 'T', 'R', 'L', 'E', 'E', 'E']
> ```
> ```js
> let arr2 = [2,4,1,6,4,5,5,9,22,0,3,-8,14,7];
> arr2.sort(); // [-8, 0, 1, 14, 2, 22, 3, 4, 4, 5, 5, 6, 7, 9]
> arr2.sort((a, b) => a - b); // [-8, 0, 1, 2, 3, 4, 4, 5, 5, 6, 7, 9, 14, 22]
> ```

Metodi utili - iterazione:
- `forEach(callback)`: esegue una funzione per ogni elemento.
```js
const frutta = ["mela", "banana", "arancia"];
frutta.forEach((frutto) => { console.log(frutto); });
```
- `map(callback)`: crea un nuovo array con il risultato della callback.
```js
const fruttaMaiuscola = frutta.map((frutto) => frutto.toUpperCase());
```
- `filter(callback)`: crea un nuovo array con gli elementi che soddisfano la condizione.
```js
const numeri = [5, 12, 8, 130, 44];
const numeriGrandi = numeri.filter((numero) => numero > 10);
```

## Oggetti

Collezioni di proprietà identificate da coppie chiave-valore.
- Gli oggetti usano come indici i nomi delle proprietà.
- Gli array sono oggetti con indici numerici.

Creazione:
- Notazione letterale:
```js
let persona = { nome: "Lorena", età: 30, occupazione: "Insegnante" };
```
- Con costruttore `Object()`:
```js
let persona = new Object();
persona.nome = "Lorena";
persona.età = 30;
persona.occupazione = "Insegnante";
```

Accesso alle proprietà:
- Notazione con parentesi quadre (array o chiave dinamica):
```js
let nome = persona["nome"];
```
- Notazione a punto:
```js
let nome = persona.nome;
```
- Aggiunta, modifica, rimozione:
```js
persona.indirizzo = "Via Roma 1";
persona["email"] = "marco@example.com";
delete persona.occupazione;
```

Metodi: funzioni associate a un oggetto.
```js
let auto = {
  marca: "Fiat",
  modello: "Panda",
  anno: 2020,
  saluta: function() {
    console.log("Ciao, sono una " + this.marca + " " + this.modello);
  }
};
```
- `this` fa riferimento all'oggetto stesso.

## Eventi

Sono azioni che si verificano all'interno del browser e rispondono alle interazioni dell'utente.
Tipi comuni:
- click, mouseover, mouseout
- keydown, keyup
- submit, focus
- load, resize

Aggiungere eventi: tre approcci possibili.
1. HTML inline: mescola HTML e JS, un solo gestore per evento: `<button onclick="alert('Ciao!')">Clicca</button>`
2. Proprietà JS: separa HTML e JS, un solo gestore per evento: `bottone.onclick = function() { alert("Ciao!"); };`
3. Listener: più codice, ma più gestori per evento (accodati): `bottone.addEventListener("click", function() { alert("Ciao!"); });`

Noi useremo il terzo metodo per il progetto.

Proprietà evento:

| Proprietà (JS) | Nome evento | Descrizione |
|---|---|---|
| `onclick` | click | Click con il tasto sinistro del mouse |
| `ondblclick` | dblclick | Doppio click |
| `onmousedown` | mousedown | Tasto del mouse premuto |
| `onmouseup` | mouseup | Tasto del mouse rilasciato |
| `onmousemove` | mousemove | Movimento del mouse sull'elemento |
| `onmouseover` | mouseover | Mouse entra in elemento o suo figlio |
| `onmouseout` | mouseout | Mouse esce da elemento o suo figlio |
| `onmouseenter` | mouseenter | Mouse entra in elemento |
| `onmouseleave` | mouseleave | Mouse esce da elemento |
| — | contextmenu | Click destro |
| `onsubmit` | submit | Invio di una form |
| `onreset` | reset | Reset di una form |
| `onchange` | change | Modifica di un campo avvenuta |
| `oninput` | input | Ogni volta che l'input cambia |
| `onfocus` | focus | Elemento messo a fuoco |
| `onblur` | blur | Perdita del focus |
| — | focusin | Focus su un figlio |
| — | focusout | Uscita del focus da un figlio |
| `onkeydown` | keydown | Tasto premuto |
| `onkeyup` | keyup | Tasto rilasciato |
| `onload` | load | La pagina o un'immagine è caricata |
| — | beforeunload | Prima di uscire dalla pagina |
| `onresize` | resize | Cambio di dimensione della finestra |
| `onscroll` | scroll | Scroll della finestra o di un div |
| — | error | Errore durante il caricamento |

## `window.onload`

Il codice JS viene eseguito immediatamente al caricamento dello script. Se il DOM non è caricato completamente, lo script potrebbe non avere accesso ad alcuni elementi della pagina. Soluzione: usare `window.onload`.

```js
window.onload = function() {
  console.log("La pagina e tutte le risorse sono state caricate!");
};
```

## `preventDefault()`

Impedisce il comportamento predefinito di un evento.

```js
document.querySelector("form").addEventListener("submit", function(evento) {
  evento.preventDefault();
  console.log("Invio bloccato. Qui puoi gestire i dati.");
});
```

Esempi:
- Evita che una form ricarichi la pagina all'invio.
- Impedisce la navigazione verso un URL quando si clicca su un'ancora.
- Blocca il menu standard del browser al click destro.
- Inibisce tasti speciali come backspace, F5 e tab.

> [!info] Sintesi:
> - Le strutture di controllo (`if`, `switch`, `for`, `while`) guidano il flusso del programma in base a condizioni.
> - Gli array sono oggetti dinamici con indici numerici e metodi di manipolazione, ricerca, ordinamento e iterazione.
> - Gli oggetti memorizzano coppie chiave-valore; `this` punta all'oggetto stesso.
> - Gli eventi si gestiscono preferibilmente con `addEventListener`; `window.onload` aspetta il caricamento completo, `preventDefault()` blocca il comportamento predefinito.
> - Le proprietà evento JS (`onclick`, `onsubmit`, `onload`, …) mappano ai nomi evento (`click`, `submit`, `load`, …).
