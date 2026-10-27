# Introduzione a JavaScript

## JavaScript
Linguaggio di programmazione usato per aggiungere interattività alle pagine web.
- funziona principalmente lato client (nel browser dell’utente)
- modifica il contenuto HTML e CSS in tempo reale
- esegue azioni in risposta ad eventi (click, input, …)

Usi comuni:
1. Manipolazione del DOM per accedere e modificare elementi della pagina
2. Aggiornamento in tempo reale di contenuti, pop-up di finestre modali, transizioni animate
3. Gestione di eventi utente come click, scroll o input
4. Richieste asincrone (AJAX) per comunicare con il server, reperire e presentare informazioni senza ricaricare la pagina

## Elementi principali
- Variabili e funzioni
- Manipolazione del DOM e gestione degli eventi
- Operatori e strutture di controllo (`if`, `else`, `while`, `for`, `switch`)
- Array e oggetti

## Differenze con gli altri linguaggi
| Aspetto | JavaScript | Java | C++ |
|---|---|---|---|
| Esecuzione | Interpretato | Compilato in bytecode, eseguito su JVM | Compilato in codice macchina |
| Tipizzazione | Dinamica e debole | Statica e forte | Statica e forte |
| Gestione della memoria | Garbage collection | Garbage collection | Manuale |
| Oggetti | Basati su prototipi | Basati su classi | Basati su classi |
| Concorrenza | Modello event-driven, normalmente eseguito su un solo thread per contesto | Supporta il multithreading | Supporta il multithreading |
| Uso principale | Interattività web, frontend e backend | Applicazioni enterprise e app Android | Programmazione di sistema e giochi |

> [!example]
> ```HTML
> <img id="luce-img" src="immagini/luce-off.png" alt="luce-off">
> <button id="bott-luce" onclick="accendiLuce()">Accendi la luce</button>
> ```
> ```Javascript
> function accendiLuce() { 
> 	document.getElementById("luce-img").src = "immagini/luce-on.png"; 
> }
> ```

## Dove inserire il codice JavaScript

<table>
  <tr>
    <td><b>Posizione del JavaScript</b></td>
    <td><b>Vantaggi</b></td>
    <td><b>Svantaggi</b></td>
  </tr>
  <tr>
    <td>Nel tag <code>&lt;head&gt;</code></td>
    <td>Esecuzione rapida, prima del contenuto. Utile per script di inizializzazione o librerie.</td>
    <td>Blocca il rendering della pagina. Rallenta il caricamento. Può causare blocchi nella parte successiva del contenuto.</td>
  </tr>
  <tr>
    <td>In mezzo al tag <code>&lt;body&gt;</code></td>
    <td>Utile quando lo script dipende da una parte specifica del contenuto.</td>
    <td>Richiede maggiore attenzione alla gestione del flusso di esecuzione, per evitare problemi di timing.</td>
  </tr>
  <tr>
    <td>Fine del tag <code>&lt;body&gt;</code></td>
    <td>Evita il blocco del rendering e permette allo script di trovare il DOM già caricato.</td>
    <td>Non utile per inizializzazioni rapide o per script da eseguire all'inizio. Ritardi nei contenuti interattivi.</td>
  </tr>
  <tr>
    <td>File esterno</td>
    <td>Separa HTML e JavaScript, permette il caching e consente di riutilizzare lo script su più pagine.</td>
          <td>Se caricato nell'<code>head</code> senza <code>async</code> o <code>defer</code>, può bloccare il parsing. Richiede una richiesta HTTP per il file esterno.</td>
  </tr>
</table>

La lezione usa un file esterno, collegato nell'head:

```HTML
<script src="script/luce.js"></script>
```

## Dichiarazione di variabili
- `var`: ambito globale o di funzione; è la forma più vecchia e in genere sconsigliata.
- `let`: ambito di blocco, per esempio all'interno di un ciclo `for`.
- `const`: il binding non può essere riassegnato dopo la dichiarazione. Se contiene un oggetto, le sue proprietà possono comunque cambiare.

```javascript
var y = 20;
let x = 10;
const pi = 3.14159;
```

## Funzioni
Eseguono blocchi di codice e possono ritornare un risultato.
Tipi di funzione:
- funzioni dichiarate: `function somma(a, b) { return a + b; }`
- funzioni anonime: `let somma = function(a, b) { return a + b; };`
- arrow function: `let somma = (a, b) => a + b;`

> [!example] Esempi da spiegare
>
> HTML della pagina:
>
> ```HTML
> <button onclick="somma(2,5)">Somma</button>
> <p id="ris"></p>
> ```
>
> JavaScript:
>
> ```Javascript
> function somma(a, b) {
>   let s = a + b;
>   console.log(s);
>   window.alert(s);
>   document.getElementById("ris").innerHTML = s;
> }
> ```
>
> Dove compare `s`? In tre posti, in quest'ordine:
> 1. nella console del browser (`console.log`);
> 2. in una finestra di avviso (`window.alert`);
> 3. dentro il paragrafo con `id="ris"` (`innerHTML`).

## Selezione degli elementi
- `document.getElementById("id")`: ritorna l'elemento del DOM con un determinato id
- `document.getElementsByTagName("tag")`: ritorna tutti gli elementi con un determinato tag sotto forma di HTMLCollection
- `document.querySelector("selettore")`: seleziona il primo elemento che corrisponde al selettore CSS specificato (id, classe o tag)
- `document.querySelectorAll("selettore")`: ritorna tutti gli elementi che corrispondono al selettore sotto forma di NodeList

Esempio che mostra la differenza tra HTMLCollection dinamica e NodeList statica:

```javascript
function provaSelezione() {
    const parByTagName = document.getElementsByTagName("p");
    const parQuerySelector = document.querySelectorAll("p");

    console.log("Prima - getElementsByTagName:", parByTagName);
    console.log("Prima - querySelectorAll:", parQuerySelector);

    const newP = document.createElement("p");
    newP.textContent = "Ciao, sono un altro paragrafo!";
    document.body.appendChild(newP);

    console.log("Dopo - getElementsByTagName:", parByTagName);
    console.log("Dopo - querySelectorAll:", parQuerySelector);
}
```

Vedi la sezione HTMLCollection e NodeList per la differenza tra collezione dinamica ed elenco statico.

## HTMLCollection e NodeList
- `HTMLCollection`: raccolta di elementi DOM. Quella restituita da `getElementsByTagName()` è dinamica: riflette le modifiche successive al DOM.
- `NodeList`: può contenere diversi tipi di nodi. Quella restituita da `querySelectorAll()` è statica: conserva gli elementi trovati al momento della selezione.
- Una `NodeList` supporta `forEach()`; una `HTMLCollection` può essere percorsa con un ciclo `for`.

La raccolta ottenuta con `querySelectorAll()` contiene solo elementi, anche se `NodeList` in generale può contenere nodi di altri tipi.

## Relazioni tra i nodi: genitori, figli e fratelli

<table>
  <tr>
    <td><b>Accesso</b></td>
    <td><b>Nodi Element</b></td>
    <td><b>Tutti i nodi</b></td>
  </tr>
  <tr>
    <td>Figli</td>
    <td>children</td>
    <td>childNodes</td>
  </tr>
  <tr>
    <td>Primo figlio</td>
    <td>firstElementChild</td>
    <td>firstChild</td>
  </tr>
  <tr>
    <td>Ultimo figlio</td>
    <td>lastElementChild</td>
    <td>lastChild</td>
  </tr>
  <tr>
    <td>Fratello successivo</td>
    <td>nextElementSibling</td>
    <td>nextSibling</td>
  </tr>
  <tr>
    <td>Fratello precedente</td>
    <td>previousElementSibling</td>
    <td>previousSibling</td>
  </tr>
  <tr>
    <td>Genitore</td>
    <td>parentElement</td>
    <td>parentNode</td>
  </tr>
</table>

La colonna "Nodi Element" contiene solo elementi HTML; la colonna "Tutti i nodi" include anche testi e commenti.

## Creare e modificare elementi HTML
- `document.createElement()` con un parametro stringa che rappresenta il nome del tag HTML
- `innerHTML` è una proprietà degli elementi HTML
  - `elemento.innerHTML` ritorna il contenuto di elemento
  - `elemento.innerHTML = "<p>Ciao!</p>"` sostituisce il contenuto di elemento con `<p>Ciao!</p>`

> [!warning]
> innerHTML comporta rischi di attacchi di cross-site scripting (XSS) quando si inietta HTML malevolo

## Modifica delle proprietà
- textContent: consente di ottenere o impostare il testo all'interno di un elemento HTML. Non interpreta eventuali tag HTML

```javascript
const elemento = document.getElementById("testoA"); console.log("Testo prima:", elemento.textContent); elemento.textContent = "La bella addormentata"; console.log("Testo dopo:", elemento.textContent);
```

- className: consente di ottenere o impostare il valore dell'attributo class di un elemento HTML. Sovrascrive le classi esistenti

```javascript
const elemento = document.getElementById("bello1");
elemento.className = "bott-bello-bis";
```

- classList: è un'interfaccia per manipolare le classi di un elemento HTML. Metodi: add(), remove(), toggle(), contains()

```javascript
const elemento = document.getElementById("bello2");
elemento.classList.toggle("bott-bello-bis");
```

- setAttribute: imposta il valore di un attributo specificato di un elemento

```javascript
const img = document.getElementById("paese"); img.setAttribute("src", "immagini/imm2.jpg");
```

- getAttribute: ottiene il valore di un attributo

```javascript
const img = document.getElementById("paese"); img.getAttribute("src");
```

## Proprietà .value
- Utilizzata per leggere o impostare il valore di un input
- `document.getElementById("nome").value`: restituisce il contenuto dell'input con id="nome"
- `document.getElementById("nome").value = "Marco"`: inserisce il testo specificato come valore

## Modifica degli stili
- Utile per effetti dinamici
- Meno performante rispetto alla gestione tramite CSS
- `elemento.style.property = "valore"`: cambia lo stile in linea di un elemento

```javascript
let elemento = document.getElementById("mio-div"); elemento.style.backgroundColor = "#c00083"; elemento.style.fontSize = "2em";
```

- setAttribute e classList: per manipolare style e le classi

## Inserimento nel DOM
- el.appendChild(node): inserisce node come ultimo figlio di el
- el.prepend(node): inserisce node come primo figlio di el
- el.insertBefore(node, refNode): inserisce newNode prima di refNode
- el.replaceChild(newNode, oldNode): sostituisce oldNode con newNode

> [!example] Esercizio — inserimento nel DOM (slide 30)
>
> HTML:
>
> ```HTML
> <body>
>   <h1>Supereroi</h1>
>   <p id="el">I supereroi sono personaggi con poteri straordinari.</p>
>   <h2>Supereroi Famosi</h2>
>   <p id="par">Superman, Batman, Spider-Man: eroi che ispirano milioni di persone.</p>
> </body>
> ```
>
> JavaScript:
>
> ```javascript
> let el = document.getElementById("el");
> let nodo = document.createElement("p");
> nodo.textContent = "Molti supereroi volano";
> ```
>
> Se uso `document.body`, il punto di inserimento cambia:
> - `appendChild(nodo)`: come ultimo figlio del body (dopo l'ultimo paragrafo)
> - `prepend(nodo)`: come primo figlio del body (prima dell'h1)
> - `insertBefore(nodo, par)`: prima di `par`, cioè dopo l'h2 "Supereroi Famosi"
> - `replaceChild(nodo, el)`: al posto di `el`, cioè sostituisce il paragrafo con id="el"

> [!example] Esercizio — form testo e colore (slide 32)
>
> Creare una pagina con una form che chiede all'utente di inserire un testo e un colore. A click del bottone di submit, viene aggiunto alla pagina un paragrafo con il testo e il colore specificati.

## Rimozione dal DOM
- el.innerHTML = "": elimina tutti gli elementi figli di el
- el.removeChild(node): elimina node dal genitore el
- el.remove(): elimina el direttamente

## Operatori
Simboli speciali utilizzati per eseguire operazioni su valori e variabili.
- Operatori aritmetici: calcoli matematici di base (+, -, *, /, %)
- Operatori di assegnazione: assegnano valori a variabili (=, +=, -=)
- Operatori di confronto: confrontano due valori e restituiscono un valore booleano (==, !=, ===, <, >)
- Operatori logici: utilizzati per espressioni condizionali (&&, ||, !)
- Operatori bitwise: operano sui singoli bit di un numero (&, |, ^, ~)

## Comportamenti inaspettati
![[Pasted image 20261026223134.png]]

> [!info] Sintesi:
> - JavaScript è un linguaggio lato client che modifica HTML e CSS in tempo reale e gestisce eventi e richieste AJAX
> - Si collega un file esterno con `<script src="..."></script>`; metterlo in fondo al body evita di bloccare il rendering
> - `var` ha ambito globale o di funzione; `let` ha ambito di blocco e `const` impedisce la riassegnazione del binding
> - Le basi comprendono funzioni, DOM, operatori, strutture di controllo, array, oggetti ed eventi
> - Gli elementi si selezionano con `getElementById`, `getElementsByTagName`, `querySelector` e `querySelectorAll`, e si modificano con le operazioni sul DOM
> -  `NaN` non è uguale a sé stesso e un array vuoto è truthy
