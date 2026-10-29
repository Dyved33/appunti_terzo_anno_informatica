Strutture di controllo 
`if, else if, else`: Eseguono blocchi di codice in base a condizioni specifiche

```javascript
let x = 10; if(x > 5) { console.log("x è maggiore di 5"); } else if(x > 2) { console.log("x è compreso tra 3 e 5"); } else { console.log("x è 2 o inferiore"); }
```

`switch`: Alternativa ad una serie di if…else per valutare più valori di una stessa variabile

```javascript
let giorno = "Lunedi"; switch (giorno) { case "Lunedi": console.log("Inizio delle lezioni"); break; case "Venerdi": console.log("Fine delle lezioni"); break; default: console.log("Giorno ordinario"); }
```

`for, for…in, for…of`: 
- `for`: esegue un blocco di codice un numero specifico di volte
```js
for (let i = 0; i < 5; i++) { console.log(i); }
```

- `for...in`: itera sulle proprietà di un oggetto
```js
let persona = { nome: "Luca", età: 25 }; for (let chiave in persona) { console.log(chiave, persona[chiave]); }
```

- `for...of`: itera su array o altre strutture iterable
```js
let arr = [1, 2, 3]; for (let numero of arr) { console.log(numero); }
```

`while, do...while`:
- `while`: esegue il blocco di codice finché la condizione specificata è vera
```js
let i = 0; while (i < 5) { console.log(i); i++; }
```

- `do...while`: esegue il codice almeno una volta
```js
let i = 8; do { console.log(i); i++; } while (i < 5);
```

Array
- Struttura di dati che permette di memorizzare una sequenza di valori (numeri, stringhe, oggetti e altri array) 
- Gli array sono oggetti 
- Ogni valore in un array ha un indice numerico (a partire da 0) 
- Possono contenere valori dello stesso tipo o di tipi diversi
- Gli array sono dinamici, quindi possono crescere o ridursi durante l'esecuzione del programma

Creazione di un array:
- Sintassi letterale: `let array1 = [1, 2, 3, 4, 5];`
- Con costruttore: `let array2 = new Array("apple", 1, true, null);`
- Vuoto con una lunghezza predefinita: `let array3 = new Array(10);`

Accesso agli elementi:
- Accedere al primo elemento: `let el = array[0];`
- Accedere all'ultimo elemento: `let el = array[array.length - 1]`. Senza il `-1` andrebbe fuori dai bound dell'array
- Modificare un elemento: `let el = array[indice] = newVal`

Metodi utili - manipolazione:
- `push(el)`: aggiunge uno o più elementi alla fine dell'array
- `pop()`: rimuove e restituisce l'ultimo elemento dell’array
- `unshift(el)`: aggiunge uno o più elementi all'inizio dell'array 
- `shift()`: rimuove e restituisce il primo elemento dell'array

Metodi utili - ricerca:
- `indexOf(el)`: restituisce l’indice della prima occorrenza di un elemento (o -1 se non presente) 
- `includes(el)`: restituisce true se l'elemento esiste nell’array 
- `find(callback)`: restituisce il primo elemento che soddisfa la condizione definita nella callback (altrimenti undefined)

> [!example]
> ```js
> let i = arr.indexOf("C") // 2 
> let check = arr.includes("B") // true 
> let risultato = arr.find(el => el > "C"); // D
> ```
> ![[Pasted image 20261029120809.png|500]]

Metodi utili - ordinamento:
- `sort()`: ordina gli elementi in ordine alfabetico o personalizzato con una funzione di confronto 
- `reverse()`: inverte l’ordine degli elementi dell'array

> [!example]
> ```js
> let arr = ["L","E","T","T","E","R","E"]; 
> arr.sort() // ['E', 'E', 'E', 'L', 'R', 'T', ’T’] 
> arr.reverse(); // ['T', 'T', 'R', 'L', 'E', 'E', ’E’]
> ```
> ```js
> let arr2 = [2,4,1,6,4,5,5,9,22,0,3,-8,14,7]; 
> arr2.sort() // [-8, 0, 1, 14, 2, 22, 3, 4, 4, 5, 5, 6, 7, 9]
> arr2.sort((a, b) => a - b); // [-8, 0, 1, 2, 3, 4, 4, 5, 5, 6, 7, 9, 14, 22]
> ```

Metodi utili - iterazione:
- `forEach(callback)`: esegue una funzione per ogni elemento
```js
const frutta = ["mela", "banana", "arancia"]; frutta.forEach((frutto) => {console.log(frutto);});
```

- `map(callback)`: crea un nuovo array con il risultato della callback su ogni elemento
```js
const fruttaMaiuscola = frutta.map((frutto) => { return frutto.toUpperCase(); });
```

- `filter(callback)`: crea un nuovo array con tutti gli elementi che soddisfano la condizione specificata nella callback
```js
const numeri = [5, 12, 8, 130, 44]; const numeriGrandi = numeri.filter((numero) => numero > 10);
```

Oggetti
- Collezioni di proprietà identificate da coppie chiave-valore 
- Gli oggetti usano come indici i nomi delle proprietà 
- Gli array sono oggetti con indici numerici

Creazione di un oggetto
- Notazione letterale
```js
let persona = { nome: "Lorena", età: 30, occupazione: "Insegnante" };
```

- Con il costruttore `Object()`
```js
let persona = new Object(); persona.nome = "Lorena"; persona.età = 30; persona.occupazione = "Insegnante";
```

Accesso alle proprietà
- Notazione con parentesi quadre (utilizzata per gli array o quando la chiave è dinamica) 
```js
let nome = persona["nome"];
```

- Notazione a punto 
```js
let nome = persona.nome;
```

- Aggiunta, modifica e rimozione
```js
persona.indirizzo = "Via Roma 1"; persona["email"] = " marco@example.com "; delete persona.occupazione;
```

Metodi
- sono funzioni associate ad un oggetto 
```js
let auto = { marca: "Fiat", modello: "Panda", anno: 2020, saluta: function() { console.log("Ciao, sono una " + this.marca + " " + this.modello); } };
```
- this fa riferimento all'oggetto stesso e permette di accedere alle sue proprietà

Eventi
- Sono azioni che si verificano all'interno del browser 
- Rispondono alle interazioni dell’utente 
- Tipi comuni: 
	- click, mouseover, mouseout 
	- keydown, keyup 
	- submit, focus 
	- load, resize

Aggiungere eventi:
- Tre approcci possibili:
	1. HTML inline: mescola HTML e JS, un solo gestore per evento: `<button onclick="alert('Ciao!')">Clicca</button>`
	2. Proprietà JS: separa HTML e JS, un solo gestore per evento: `bottone.onclick = function() { alert("Ciao!"); };`
	3. Listener: più codice, ma più gestori per evento (accodati): `bottone.addEventListener("click", function() { alert("Ciao!"); });`

Noi useremo il terzo metodo per il progetto

Proprietà evento
![[Pasted image 20261029123416.png]]

`window.onload `
- Il codice JS viene eseguito immediatamente al caricamento dello script 
- Se il DOM non è caricato completamente, lo script potrebbe non avere accesso ad alcuni elementi della pagina 
- Soluzione: usare `window.onload` 

```js
window.onload = function() { console.log("La pagina e tutte le risorse sono state caricate!"); };
```

Listner evento
![[Pasted image 20261029123531.png]]

`preventDefault()` 
Impedisce il comportamento predefinito di un evento. 
```js
document.querySelector("form").addEventListener("submit", function(evento) { evento.preventDefault(); console.log("Invio bloccato. Qui puoi gestire i dati."); });
```

Esempi: 
- Evita che una form ricarichi la pagina all’invio 
- Impedisce la navigazione verso un URL quando si clicca su un’ancora 
- Blocca il menu standard del browser al click destro 
- Inibisce tasti speciali come backspace, F5 e tab  

