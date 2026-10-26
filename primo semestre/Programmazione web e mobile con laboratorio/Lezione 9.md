# Introduzione a JavaScript

Linguaggio di programmazione usato per aggiungere interattività alle pagine web • Caratteristiche principali: 
- funziona principalmente lato client (nel browser dell’utente) 
- modifica il contenuto HTML e CSS in tempo reale 
- esegue azioni in risposta ad eventi (click, input, …)

Usi comuni:
1. Manipolazione del DOM per accedere e modificare elementi della pagina 
2. Aggiornamento in tempo reale di contenuti, pop-up di finestre modali, transizioni animate 
3. Gestione di eventi utente come click, scroll o input 
4. Richieste asincrone (AJAX) per comunicare con il server, reperire e presentare informazioni senza ricaricare la pagina

Differenza con altri linguaggi
![[Pasted image 20261026145528.png]]

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

Dove inserire js?
![[Pasted image 20261026150054.png]]

Noi useremo l'ultima opzione e per fare ciò si aggiunge nell'head:

```HTML
<script src="script/luce.js"></script>
```

Dichiarazione di variabili 
1. var: ambito di visibilità globale o di funzione (più vecchia, sbagliata perché deprecata) 
2. let: ambito di blocco, ad esempio all'interno di un ciclo for (più moderna e sicura rispetto a var) 
3. const: non possono essere riassegnate dopo la dichiarazione

Funzioni 
- Eseguono blocchi di codice ed possono ritornare un risultato 
- Tipi di funzione: 
	- funzioni dichiarate: `function somma(a, b) { return a + b; }`
	- funzioni anonime: `let somma = function(a, b) { return a + b; };`
	- arrow function: `let somma = (a, b) => a + b;`

> [!example] Esempi da spiegare
> ```javascript
> function somma(a, b) {
> 
> let s = a + b;
> 
> console.log(s);
> 
> }
> 
>   
> 
> function somma(a, b) {
> 
> let s = a + b;
> 
> console.log(s);
> 
> window.alert(s);
> 
> }
> 
>   
> 
> function somma(a, b) {
> 
> let s = a + b;
> 
> console.log(s);
> 
> window.alert(s)
> 
> document.getElementById("ris").innerHTML = s;
> 
> }
> ```

Selezione degli elementi 
- `document.getElementById("id")`: ritorna l'elemento del DOM con un determinato id 
- `document.getElementsByTagName("tag")`: ritorna tutti gli elementi con un determinato tag sotto forma di HTMLCollection 
- `document.querySelector("selettore")`: seleziona il primo elemento che corrisponde al selettore CSS specificato (id, classe o tag) 
- `document.querySelectorAll("selettore")`: ritorna tutti gli elementi che corrispondono al selettore sotto forma di NodeList

NodeList e HTMLCollection 
- HTMLCollection: raccolta di soli nodi di tipo Element (tag contenitori HTML) 
- Le HTMLCollection generate con getElementsByTagName sono dinamiche 
- Non supportano .forEach() e devono essere scorse in un ciclo for 
- NodeList: elenco di nodi DOM che può contenere nodi Element, testi e commenti 
- Le NodeList create con querySelectorAll sono statiche: non si aggiornano automaticamente se il DOM cambia 
- Possono essere scorse con .forEach()

Genitori, figli e fratelli
![[Pasted image 20261026155343.png]]

Creare elementi HTML 
- document.createElement() con a parametro una stringa che rappresenta il nome del tag HTML 
-  innerHTML è una proprietà degli elementi HTML 
	- elemento.innerHTML ritorna il contenuto di elemento 
	- elemento.innerHTML = `"<p>CIao!</p>"` sostituisce il contenuto di elemento con `<p>CIao!</p>`

> [!warning]
> innerHTML comporta rischi di attacchi di cross-site scripting (XSS) quando si inietta HTML malevolo

Modifica delle Proprietà 
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

Proprietà .value 
- Utilizzata per leggere o impostare il valore di un input 
- document.getElementById(“nome”).value: restituisce il contenuto dell’input con id="input" 
- document.getElementById(“nome”).value = “Marco”: inserisce il testo specificato come valore

Modifica degli Stili 
- Utile per effetti dinamici 
- Meno performante rispetto alla gestione tramite CSS 
- elemento.style.property = “valore”: cambia lo stile in linea di un elemento

```javascript
let elemento = document.getElementById("mio-div"); elemento.style.backgroundColor = "#c00083"; elemento.style.fontSize = "2em";
```

- setAttribute e classList: per manipolare style e le classi

Inserimento nel DOM
- el.appendChild(node): inserisce node come ultimo figlio di el 
- el.prepend(node): inserisce node come primo figlio di el 
- el.insertBefore(node, refNode): inserisce newNode prima di refNode 
- el.replaceChild(newNode, oldNode): sostituisce oldNode con newNode

> [!example] Esercizio — inserimento nel DOM (slide 30)
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
> ```javascript
> let el = document.getElementById("el");
> let nodo = document.createElement("p");
> nodo.textContent = "Molti supereroi volano";
> ```
> 
> Se uso `document.body`, `nodo` viene inserito come ultimo figlio del body. Dove finisce esattamente se uso:
> - `appendChild(nodo)`: come ultimo figlio dell'elemento su cui lo chiamo
> - `prepend(nodo)`: come primo figlio
> - `insertBefore(nodo, par)`: prima di `par`
> - `replaceChild(nodo, el)`: al posto di `el`


> [!example] Esercizio — form testo e colore (slide 32)
> 
> Creare una pagina con una form che chiede all'utente di inserire un testo e un colore. A click del bottone di submit, viene aggiunto alla pagina un paragrafo con il testo e il colore specificati.

Rimozione dal DOM
- el.innerHTML = "": elimina tutti gli elementi figli di el 
- el.removeChild(node): elimina node dal genitore el 
- el.remove(): elimina el direttamente

Operatori 
- Simboli speciali utilizzati per eseguire operazioni su valori e variabili 
- Operatori aritmetici: calcoli matematici di base (+, -, * , /, %) 
- Operatori di assegnazione: assegnano valori a variabili (=, +=, -=) 
- Operatori di confronto: confrontano due valori e restituiscono un valore booleano (==, !=, ===, <, >) 
- Operatori logici: utilizzati per espressioni condizionali (&&, ||, !) 
- Operatori bitwise: operano sui singoli bit di un numero (&, |, ^ , ~)

## Comportamenti inaspettati

**== vs ===:** l'operatore di uguaglianza debole `==` esegue una conversione implicita dei tipi prima di confrontare, mentre `===` confronta valore e tipo senza conversioni.
- `0 == false` → `true`
- `0 === false` → `false`
- `null == undefined` → `true`
- `null === undefined` → `false`
- `NaN == NaN` → `false`
- `NaN === NaN` → `false`

**Conversioni implicite:** JavaScript converte automaticamente i tipi in alcune espressioni.
- `5 + "5"` → `"55"` (il numero viene convertito in stringa e si concatena)
- `"5" - 5` → `0` (la stringa viene convertita in numero per la sottrazione)
- `isNaN(NaN)` → `true`

**Operatore `+` unario:** converte l'operando in numero.
- `+"5"` → `5`
- `+"hello"` → `NaN`

**Confronti particolari:**
- `[] == false` → `true`
- `[] == ""` → `true`

> [!info] In altre parole:
> Usa sempre `===` invece di `==` per evitare sorprese dalle conversioni implicite di tipo, e ricorda che `NaN` non è uguale a sé stesso.

> [!info] Sintesi:
> - JavaScript è un linguaggio lato client che modifica HTML e CSS in tempo reale e gestisce eventi e richieste AJAX
> - Si inserisce nell'head con `<script src="..."></script>` per eseguirlo dopo il caricamento della pagina
> - `var` è deprecata; si usano `let` (blocco) e `const` (non riassegnabile)
> - Si selezionano elementi con `getElementById`, `getElementsByTagName`, `querySelector` e `querySelectorAll`
> - Si inseriscono/rimuovono nodi nel DOM con `appendChild`, `prepend`, `insertBefore`, `replaceChild` e `remove`
> - Usa `===` invece di `==` e ricorda che `NaN` non è uguale a sé stesso

