# Design dei contenuti web: composizione visiva, metafore e organizzazione

## Audience

Quando scrivo un applicativo devo capire per chi lo sto sviluppando.

## Composizione visiva

**Sezione aurea:**
- è basata sul numero aureo 1,618, da cui il nome: la proporzione aurea è il rapporto 1 : 1,618;
- si ottiene dividendo un segmento in modo che il rapporto tra la parte maggiore e quella minore sia uguale al rapporto tra l'intero segmento e la parte maggiore;
- è considerata esteticamente armoniosa e si trova in natura.

> [!tip] Sezione aurea nel web
> 1. Dimensionare colonne e sezioni in base al rapporto aureo
> 2. Definire le dimensioni dei caratteri seguendo la progressione aurea (es: 1em, 1.618em, 2.618em, …)

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019145753.png" width="30%">
</div>

*La figura:* a sinistra la pagina con il rapporto aureo (la sidebar stretta è il quadrato più piccolo della costruzione classica, visibile nell'angolo in alto a sinistra), a destra la stessa pagina con le due aree divise a metà.

**Regola dei terzi:**
- divide l'immagine in una griglia di 3 x 3 (9 riquadri uguali);
- i soggetti principali vengono posizionati lungo le linee o nei punti di intersezione, per migliorare il bilanciamento e la dinamicità della composizione;
- è una semplificazione della sezione aurea, più intuitiva e facile da applicare.

> [!tip] Regole dei terzi nel web
> 1. Posizionare il titolo nei terzi verticali, preferibilmente a sinistra
> 2. Inserire immagini o elementi visivi nel terzo destro, per bilanciare il testo
> 3. I pulsanti di call-to-action dovrebbero trovarsi vicino ai punti di intersezione inferiori della griglia

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019145839.png" width="30%">
</div>

*La figura:* la griglia 3 x 3 con i quattro punti di intersezione segnati in arancio e la percentuale di sguardo su ciascuno: 41% in alto a sinistra, 20% in alto a destra, 25% in basso a sinistra, 14% in basso a destra.

## Metafora visiva

Gli utenti del web hanno un'attenzione più breve rispetto ai lettori di stampa: le metafore aiutano a velocizzare la scansione delle pagine.

Si usano immagini e simboli per rappresentare concetti, e così l'interpretazione dei contenuti ne facilita la comprensione.

> [!example]
> Icone di cartella per rappresentare documenti, nuvole per i servizi cloud
> ![[Pasted image 20261019150012.png|300]]

*La figura:* un set di icone monocrome che indicano strumenti diversi (penna, gomma, pennelli, temperino): la forma dell'icona comunica il concetto prima ancora del testo.

*Definizione:* l'affordance è la qualità fisica di un oggetto che suggerisce a un essere umano le azioni appropriate per manipolarlo.

## Errori da evitare

- usare pdf per la lettura online;
- non cambiare il colore per i link visitati (`:visited`);
- scrivere testo non scansionabile;
- avere caratteri a larghezza a dimensione fissa;
- inserire elementi che sembrano pubblicità (es. il bottone deve sembrare un bottone);
- ignorare gli standard.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019151745.png" width="30%">
</div>

*La figura:* il grafico delle caratteristiche e del loro posizionamento nei 500 siti di marketing osservati.

I colori distinguono le tre categorie della legenda (Confusion, Convention, Standard): quasi tutte le pratiche sono in Confusion, tranne il popup, che è uno Standard.

- più diffuse: logo in alto a sinistra (93%) e navigazione principale nell'header (90%);
- diffuse: menu a tendina (58%), contatto in alto a destra (55%), value proposition in alto nella pagina (54%), ricerca nell'header (53%);
- medie: contenuti in homepage (43%), slideshow in homepage (42%), call to action (33%), evidenze in homepage (28%);
- rare: video in homepage (18%), icone social nell'header (13%), chat in basso a destra (11%), popup in homepage (6%).

## Organizzazione dei contenuti

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019151835.png" width="30%">
</div>

*La figura:* la struttura gerarchica di un sito: dalla home page si scende alle categorie, poi alle sottocategorie e infine alle sotto-sottocategorie.

**Passi da seguire:**
1. identificare e raccogliere tutti i contenuti (testi, immagini, …);
2. determinare quali contenuti appartengono a ciascuna pagina;
3. scegliere nomi chiari e descrittivi per le voci del menu;
4. creare una struttura logica e coerente in ogni pagina, per guidare gli utenti nella navigazione e nella ricerca dei contenuti.

## Gerarchia visiva

- **Dimensione:** elementi più grandi attirano maggiormente l'attenzione;
- **Colore:** colori vivaci e contrastanti evidenziano informazioni importanti (cfr. [[Lezione 6-Font, icone e teoria del colore|teoria del colore]]);
- **Posizione:** contenuti collocati in alto o al centro ricevono più attenzione;
- **Spaziatura:** margini e spazi tra gli elementi influenzano la leggibilità e la percezione.

<div style="display: flex; justify-content: center;">
  <img src="Pasted image 20261019154220.png" width="30%">
</div>

*La figura:* il mockup di una pagina con i sei elementi in ordine di attenzione:
- 1 la foto del profilo in un cerchio;
- 2 una scheda con un'immagine circolare e due righe di testo;
- 3 una scheda con un'immagine grande;
- 4 un elenco di righe;
- 5 il blocco largo di contenuto principale;
- 6 un altro elenco di righe.

Le frecce indicano il percorso di lettura (1 → 2 → 3, 1 → 4, 4 → 5, 4 → 6).

> [!info] Sintesi:
> - L'audience viene prima di tutto: decide cosa scrivere e come.
> - Composizione: sezione aurea (numero aureo 1,618) per dimensionare colonne e caratteri, regola dei terzi (griglia 3 x 3) per posizionare i soggetti.
> - Metafore visive e affordance fanno capire un contenuto prima del testo, perché sul web l'attenzione è più breve che sulla stampa.
> - Errori da evitare: pdf per la lettura online, colore dei link visitati, testo non scansionabile, caratteri a dimensione fissa, elementi che sembrano pubblicità, ignoranza degli standard.
> - Organizzazione: raccogliere i contenuti, assegnarli alle pagine, nominare bene le voci di menu, dare a ogni pagina una struttura logica.
> - Gerarchia visiva: dimensione, colore, posizione e spaziatura guidano lo sguardo.
