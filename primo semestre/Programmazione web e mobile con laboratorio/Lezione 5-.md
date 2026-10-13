Menu di navigazione 
Elemento chiave di un sito web che consente agli utenti di spostarsi facilmente tra le diverse sezioni e pagine. Buone Pratiche: 
- Indicare la sezione attiva 
- Assicurarsi che il menu sia navigabile tramite tastiera (tab) 
- Adattare il menu per funzionare su dispositivi di diverse dimensioni (responsive) 
- Mantenere uno stile coerente con il resto del sito

Tipi di menù:
- Orizzontali ![[Pasted image 20261013164620.png]]
- Verticali ![[Pasted image 20261013164639.png]]
- Dropdown ![[Pasted image 20261013164700.png]]
- Burger ![[Pasted image 20261013164717.png]]

> [!note]
> Affordance = semplicità di capire come funziona uno strumeno/sito/menù (alta si capisce subito bene)

Progettare il menù:
- Usare nomi brevi e descrittivi per le ancore (capire i contenuti) 
- La navigazione deve trovarsi dove gli utenti se lo aspettano (di solito in alto o a lato della pagina) 
- I link devono avere un aspetto riconoscibile, in modo che gli utenti capiscano che sono interattivi 
- I link devono essere facilmente distinguibili e separati tra loro

Esercizio
![[Pasted image 20261013165215.png]]

![[Pasted image 20261013170759.png]]

> [!note]
> :hover = quando passo sopra qualcosa (indicato nel css) cambia una qualche minima proprietà

> [!note]
> Linear gradient = scelgo colore di inizio e di fine e vedo il gradiente che cambia

Menu secondari 
La navigazione primaria non deve mai cambiare in tutto il sito, la secondaria si, a seconda della pagina corrente

![[Pasted image 20261013165542.png]]

Responsive design 
È un approccio alla progettazione web che permette a un sito di adattarsi automaticamente a diverse dimensioni e risoluzioni dello schermo, come desktop, tablet e smartphone. L'obiettivo è garantire che il contenuto sia leggibile e facilmente navigabile, indipendentemente dal dispositivo utilizzato dall'utente. Il layout deve modificarsi in base alle dimensioni dello schermo per fornire un'esperienza utente coerente e ottimale su tutte le piattaforme

Quasi ogni dispositivo smart ha un qualche tipo di browser. La navigazione web avviene per la maggior parte da dispositivi mobili. Il web è una tecnologia cross-platform

Varie risoluzioni
- Unità di misura relative (%, em) 
- Layout flessibile (flex, grid) 
- Media query (stili diversi per schermi diversi) ![[Pasted image 20261013172554.png]]

> [!note]
> Applica solo se lo schermo è grande al massimo fino a quella dimensione

Media query = Regole CSS per applicare stili diversi in base a condizioni come: 
- Larghezza massima: max-width 
- Larghezza minima: min-width 
- Orientamento: orientation: portrait/landscape 
- Tipo di media: screen, print

![[Pasted image 20261013172727.png]]

> [!note]
> Il browser, interagendo con l'hardware, sa se il dispositivo è orizzontale o verticale

Tagli standard
![[Pasted image 20261013172803.png]]

> [!note]
> Per il corso <1000 px è smartphone e >1000 px è pc

Viewport
È l'area visibile di una pagina web in un browser. Determina come il contenuto si adatta a schermi di diverse dimensioni. È cruciale per il design responsivo e l'ottimizzazione mobile. Per controllare le dimensioni e la scala del viewport, si usa il meta tag

![[Pasted image 20261013172845.png]]

> [!note]
> Usare unità di misura scalabili come % e em (no pixel)
> Flex-direction: row per pc e column per smarphone (?)

Validazione
Garantisce che le pagine web siano conformi agli standard del World Wide Web Consortium (W3C).

Svantaggi del codice HTML non conforme: 
- Problemi di visualizzazione (rendering incoerente e possibili elementi mancanti) 
- Accessibilità compromessa (difficoltà per utenti con disabilità nell'interagire con il sito) 
- Impatto negativo sulla SEO (indicizzazione inefficiente e potenziali classifiche inferiori) 
- Manutenzione difficile (maggiore complessità nel debugging e nella collaborazione) 
- Compatibilità limitata (difficoltà ad adattarsi a nuovi standard e aggiornamenti) 
- Esperienza utente negativa (frustrazione degli utenti e impressione negativa del brand)

Es. Validatore HTML5 https://validator.w3.org/

Es. Validatore CSS3 https://jigsaw.w3.org/css-validator/

//differenza tra visibility: hidden (booleano) / opacity:0 (valore tra 0 e 1) e display: none//

//ancore più grandi = più cliccabili => più padding//