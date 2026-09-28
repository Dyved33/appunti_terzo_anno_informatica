# box model
 è una scatola astratta che rappresenta ogni elemento contenuto nella pagina. 
 - Content (area blu) = larghezza e altezza del contenuto del componente. area in cui viene visualizzato il contenuto dell'elemento
 - Padding = spazio tra contenuto e bordo dell'elemento utilizzato per creare spazio interno attorno al contenuto (proprietà padding)
 - Border = linea che circonda oil padding (se esiste) e il contenuto. personalizzato in termini di larghezza, stile e colore (proprietà border)
 - Margin = spazio esterno all'elemento che separa l'elemento da altri elementi circostanti (proprietà margin). 
 
 N.B. i margini si fondono
 
- per modificare content si usano width e heigth
- per modificare padding si usa la proprietà padding. posso voler modificare il padding solo in alcuni lati (non tutti) => do delle misure di padding a partire dall'alto andando in senso orario 
- per modificare border si usa la proprietà border. questa è un endler per la larghezza, lo stile e il colore del border (da mettere obbligatoriamente). esiste una proprietà border-radius che mi permette di fare il border arrotondato. anche qui posso definire quanto stondare gli angoli (partendo dall'angolo in alto a sinistra in senso orario)
- per modificare margin si usa la proprietà margin. Questo spazio aiuta a controllare la disposizione degli elementi nella pagina. anche qui si può gestire il margin con più valori relativi alla stessa proprietà dall'alto in senso orario

 N.B. una buona norma è usare i pixel SOLO per i bordi 
 N.B. di solito si tolgono i bordi ai bottoni. questo perché le punte mettono in allarme e danno una sensazione di pericolo (meglio arrotondato)
 N.B. per il margin è buona norma fare in modo che non esista lo scorrimento orizzontale (la somma di tutti gli elementi deve essere 100%). non ho vincoli in verticale
 
 selettore di id = ogni tag dentro al body può avere un ID (univoco) -> id = "ID" e lo richiamo con #ID
 classe = posso specificare una classe per più componenti e dare delle specifiche per tutti gli elementi appartenenti alla classe -> class ="CLASS" e si richiama con .CLASS
 
 N.B. posso mettere dentro ad una classe sia div che p e in tal caso si richiama p#quote div.quote
 N.B. posso apportare delle modifiche a delle p (per esempio) specificatamente dentro ad un div con div p{}

guarda la tabella sui combinatori nelle slide

# stile delle liste 
di solito voglio modificare il pallino o numero del list item
- list-style = proprietà shorthand per impostare il tipo di marker,l'immagine e la posizione
- list-style-type = specifica il tipo di marker per gli elementi di lista
- list-style-image = permette di utilizzare un'immagine come marker per la lista
- list-style-position = determina se il marker è posizionato all'interno o all'esterno del contenitore della lista

Ricorda: per q posso scegliere le virgolette 

# tabelle
usate per organizzare i dati in righe e colonne. il tag principale è <table>. questo si usa congiuntamente a <tr> (table raw), <th> (table head = intestazione / nome colonna), <td> (table data). se do la proprietà border alla table ottengo solo il border esterno e se la applico alle celle ottengo dei doppi bordi => nella table si aggiunge border-collapse: collapse;

N.B. la prima riga della tabella viene renderizzata in grassetto
N.B. ogni riga ha lo stesso numero di celle
N.B. NON si usano per allineare elementi all'interno della pagina

posso unire delle celle tramite 2 attributi:
- colspan: permette a una cella di occupare più colonne (celle su due colonne adiacenti): <th colspan="2">...</th>
- rowspan: permette ad una cella di occupare più righe (una sopra e una sotto): <th rowspan="2">...</th>

N.B. no. di righe e di colonne = massimo no. di righe o di colonne presenti (in caso ci siano righe o colonne unite) 
N.B. quando faccio un rowspan NON metto i td relativi alle celle sottostanti al rowspan (lo stesso vale per il colspan con le colonne a destra)

# form
si usa il tag <form> e prende 2 attributi obbligatori: 
- method = definisce il metodo HTTP usato (GET o POST)
- action = specifica dove vengono inviati i dati del form 

poi ci sono i tag label e input che sono elementi della form. 
- input = richiedono l'imput dell'utente. hanno un type: text, password, date, color, number al quale posso specificare min e max (considera step), range, email, tel, url, time, file, search, hidden (fa si che io abbia un input nascosto e mi permette di inoltrare al server un form anche se l'utente clicca solo l'immagine). è anche presente un name che è il nome del campo che viene passato con la richiesta HTTP (che dato sto passando con il protocollo HTTP)
- label = specificano le etichette che compaiono come degli span (non vanno a capo, ma sono in linea). in questo tag c'è un mapping tra ciò che gli passo come for="" e l'id che passo nell'input (messo proprio per assegnare le label)

N.B. submit è il tipo in input di sottomissione (con value=invia). da un punto di vista grafico questo è identico ad usare un button, ma così sarebbe sbagliato (no standard anche se funziona)
label indica la label del form, input indica il tipo, l'id e il name relativo alla label

altri tipi di input:
- checkbox (multi select). tutti gli input devono avere lo stesso name, ma value diversi
- radio button (uni select). tutti gli input devono avere lo stesso name, ma value diversi
- submit appare come bottone ma è associato ad un form
- reset svuota la form 

N.B. se clicco sulla label il browser mi spunta la casella corrispondente
N.B. best practice è se clicco su reset devo mandare un messaggio di conferma

- select apre un menù a tendina e prende id e name. dentro ha delle <option> che hanno un valore. presenta una preselezione
- optgroup riguarda elementi in relazione tra loro (usato quando ho molti elementi da considerare)
- button prende un tipo (che può essere un submit). ha anche un campo onclick
- textarea pensata per inserire un commento o delle note che

N.B.tutti questi elementi possono avere un tag placeholder che mi indica cosa mi aspetto 

- datalist è un contenitore invisibile per menù a tendina
- fieldset serve a raggruppare logicamente elementi correlati all'interno di un modulo (form), disegnando una cornice visiva intorno a essi per migliorarne l'organizzazione. 

Esercizio: realizzare una pagina web su un tema a scelta (e.g. bar sotto casa). in cui ci devo mettere una pagina home (con informazioni essenziali), una pagina con tabella e qualche immagine e una terza pagina di form (prendere un layout tra i 4 che sono alla fine della terza presentazione)

Ricorda: 
- background color = linear gradient
- required per obbligare un campo ad essere compilato 
