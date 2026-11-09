# Servizi Google

## Perché Google
- Affidabilità e scalabilità
- API con documentazione e supporto community
- Interattività avanzata
- Personalizzazione per adattarsi a progetti specifici
- Integrazione semplice con altri servizi Google

Google Charts: libreria gratuita di strumenti JavaScript per creare grafici e visualizzazioni interattive in pagine web.

![[Pasted image 20261102144354.png|300]]

## Google Charts — creazione di un grafico

**Step 1: carica le librerie:** caricare l'API di visualizzazione e il pacchetto corechart per accedere alle funzionalità di grafici e visualizzazioni avanzate.

```html
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script src="script/script.js"></script>
```

- Imposta una callback per eseguire una funzione quando l'API di visualizzazione viene caricata.

```javascript
google.charts.load('current', {'packages':['corechart']}); google.charts.setOnLoadCallback(drawChart);
```

**Step 2: contenitore:** creare nel body un contenitore vuoto per ospitare il chart.

```html
<div id="chart_div"></div>
```

Lo script renderizzerà il chart nell'elemento HTML con l'ID che specificheremo.

> [!info] In altre parole:
> Tutto ciò che è contenuto in questo elemento sarà sostituito dal grafico quando verrà disegnato.

**Step 3: preparare i dati:** i Google Chart richiedono il wrapping dei dati in una DataTable, una tabella bidimensionale in cui ogni colonna ha un tipo di dati e un'etichetta.

```javascript
function drawChart() {
  var data = new google.visualization.DataTable();
  data.addColumn("string", "Condimento");
  data.addColumn("number", "Pezzi");
  data.addRows([
    ["Mushrooms", 3],
    ["Onions", 1],
    ["Olives", 1],
    ["Zucchini", 1],
    ["Pepperoni", 2]
  ]);
  // ...
}
```

**Step 4: personalizzazione:** varie opzioni possono essere personalizzate, ad esempio: titolo, assi, legenda, colori, font, dimensioni, interattività, tipo di grafico.

```javascript
function drawChart() {
  // ...
  var options = {
    "title": "Pizza per la festa",
    colors: ["#e0440e", "#e6693e", "#ec8f6e", "#f3b49f", "#f6c7b6"],
    is3D: true
  };
  // ...
}
```

**Step 5: disegno:** ogni tipo di grafico è basato su una classe diversa (il grafico a torta si basa sulla classe PieChart, il grafico a barre sulla classe BarChart); bisogna trasmettere al grafico un riferimento al contenitore HTML.

```javascript
function drawChart() {
  // ...
  var chart = new google.visualization.PieChart(document.getElementById("chart_div"));
  chart.draw(data, options);
}
```

## Tipi di grafici
- Elenco completo: https://developers.google.com/chart/interactive/docs/gallery?hl=it
- Per ogni tipo di grafico va:
  1. caricato il pacchetto corretto con google.charts.load
  2. specificato il tipo quando si istanzia google.visualization

**GeoChart:**

```javascript
google.charts.load("current", {packages: ["geochart"]}); google.charts.setOnLoadCallback(drawGeoChart);
function drawGeoChart() {
  var data = google.visualization.arrayToDataTable([
    ["Regione", "Popolazione"],
    ["Lazio", 5865544],
    ["Lombardia", 10060674]
    // ...
  ]);
  var options = {
    region: "IT",
    // Italia
    resolution: "provinces",
    // ...
  };
  var chart = new google.visualization.GeoChart(document.getElementById("chart_div"));
  chart.draw(data, options);
}
```

![[Pasted image 20261102144912.png|300]]

Tutte le opzioni: https://developers.google.com/chart/interactive/docs/gallery/geochart#configuration-options

**ColumnChart:**

```javascript
google.charts.load("current", {"packages":["corechart"]}); google.charts.setOnLoadCallback(drawColumnChart);
function drawColumnChart() {
  var data = google.visualization.arrayToDataTable([
    ["Elemento", "Densità", {role: "style"}],
    ["Rame", 8.94, "color: #b87333"],
    ["Argento", 10.49, "color: #c0c0c0"],
    ["Oro", 19.30, "color: #fdd702"],
    ["Platino", 21.45, "color: #e5e4e2"]
  ]);
  var options = {
    title: "Densità dei metalli preziosi (g/cm^3)",
    legend: {position: "none"}
  };
  var chart = new google.visualization.ColumnChart(document.getElementById("chart_div"));
  chart.draw(data, options);
}
```

![[Pasted image 20261102145005.png|300]]

**Gauge:**

```javascript
google.charts.load("current", {"packages":["gauge"]}); google.charts.setOnLoadCallback(drawGauge);
function drawGauge() {
  var data = google.visualization.arrayToDataTable([
    ["Etichetta", "Valore"],
    ["RAM", 80],
    ["CPU", 55],
    ["Rete", 68]
  ]);
  var options = {
    redFrom: 90,
    redTo: 100,
    yellowFrom: 75,
    yellowTo: 90,
    minorTicks: 5
  };
  var chart = new google.visualization.Gauge(document.getElementById("chart_div"));
  chart.draw(data, options);
}
```

![[Pasted image 20261102145041.png|300]]

**Timeline:**

```javascript
google.charts.load("current", {packages:["timeline"]}); google.charts.setOnLoadCallback(drawTimeline);
function drawTimeline() {
  var data = new google.visualization.DataTable();
  data.addColumn("string", "Numero");
  data.addColumn("string", "Nome");
  data.addColumn("date", "Inizio");
  data.addColumn("date", "Fine");
  data.addRows([
    ["1", "Enrico De Nicola", new Date(1946, 6, 1), new Date(1948, 4, 12)],
    ["2", "Luigi Einaudi", new Date(1948, 4, 12), new Date(1955, 4, 11)]
    // ...
  ]);
  var options = {
    backgroundColor: "#fffde5",
    alternatingRowStyle: false
  };
  var chart = new google.visualization.Timeline(document.getElementById("chart_div"));
  chart.draw(data, options);
}
```

![[Pasted image 20261102145109.png|300]]

## Interazione con il grafico
Tutti i grafici generano alcuni tipi di eventi che possono essere ascoltati:
- ready, quando viene disegnato sulla pagina
- select, quando un utente seleziona qualcosa sul grafico facendo clic
- onmouseover e onmouseout, quando l'utente passa il mouse sopra un elemento specifico
- error, quando il formato DataTable è errato

**Ascoltare gli eventi:** chiamare `google.visualization.events.addListener()` passando un handle al grafico, il nome dell'evento da rilevare e il nome di un gestore.

```js
function drawChart() {
  // ...
  function selectHandler() {
    var selectedItem = chart.getSelection()[0];
    if (selectedItem) {
      var value = data.getValue(selectedItem.row, 0);
      alert("Hai selezionato: " + value);
    }
  }
  google.visualization.events.addListener(chart, "select", selectHandler);
}
```

## Google Maps
- Servizio di Google che permette di incorporare mappe interattive in pagine web.
- Tipi di mappe: Roadmap, Satellite, Hybrid, Terrain.
- Funzionalità:
  - Creazione di marker per indicare punti specifici
  - Disegno di percorsi tra due o più punti
  - Autocomplete per campi di ricerca
  - Supporto per eventi come clic, trascinamento e zoom

**Maps JavaScript API:** documentazione qui: https://developers.google.com/maps/documentation/javascript?hl=it
- PRO: personalizzazione e interazione avanzata.
- CON: necessario account Google Cloud per ottenere API Key.
- Alternativa: embedding.

**Incorporare una mappa:**
1. Andare su http://www.google.com/maps
2. Cercare un luogo/indirizzo
3. Cliccare il bottone "Condividi"
4. Selezionare la voce "Incorpora una mappa"
5. Copiare l'iframe e incollarlo nel body
6. Eliminare gli attributi relativi allo stile

```html
<iframe src="https://www.google.com/maps/embed?..." width="600" height="450" style="border:0;"></iframe>
```

7. Gestire lo stile dal CSS.

**Calendar JavaScript API:** documentazione qui: https://developers.google.com/calendar?hl=it
- PRO: personalizzazione e interazione avanzata.
- CON: necessario abilitare Google Calendar API su Google Cloud Console.
- Alternativa: embedding.

**Incorporare un calendario:**
1. Andare su https://calendar.google.com
2. Accedere alle impostazioni (simbolo ingranaggio)
3. Selezionare il calendario desiderato
4. Consentire l'accesso pubblico
5. Copiare l'iframe e incollarlo nel body
6. Eliminare gli attributi relativi allo stile

```html
<iframe src="https://calendar.google.com/calendar/embed?..." style="border: 0" width="800" height="600"></iframe>
```

7. Gestire lo stile dal CSS.

## Altri Servizi Google
- Google Analytics: analisi del traffico
- Google Custom Search: ricerca personalizzata
- Google Sign-In: login con Google
- Google AdSense: pubblicità online
- Google Drive API: archiviazione file
- Dialogflow: chatbot AI
- Google Pay API: pagamenti digitali
- reCAPTCHA: protezione spam


