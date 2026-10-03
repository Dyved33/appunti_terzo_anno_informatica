# Stile degli appunti

Unica fonte per lo stile. Vale per ogni nota di lezione. Se una regola qui e una nota scritta dall'utente dicono cose diverse, vale la nota dell'utente.

## Principio

Sono appunti di uno studente che ha capito la lezione, non una dispensa. Servono a studiare per l'esame, dove va riportato ciò che ha detto il docente.

Per questo il contenuto non si perde mai. Tutto ciò che sta negli appunti dell'utente, negli appunti grezzi e nel materiale del docente resta nella nota: definizioni, teoremi, dimostrazioni, formule, codice, immagini, ma anche esempi, elenchi completi, numeri, casi particolari, osservazioni e precisazioni fatte a voce. Non decidi tu cosa è secondario. Il tuo lavoro è sistemare la forma, correggere gli errori e aggiungere ciò che manca.

Si tolgono solo le parole che non portano informazione. Se togliendo una frase non si perde nessuna informazione, la frase va tolta; se si perde anche solo un dettaglio, la frase resta e al massimo si accorcia. Nel dubbio, tieni.

La lunghezza non ha un limite: la decide il contenuto. Una lezione lunga o un concetto difficile producono una nota lunga, ed è giusto così. Quello che conta è la densità:

- la stessa informazione si scrive una volta sola, nel punto in cui serve: se è ripetuta identica in due punti tieni la versione più completa;
- un concetto difficile merita tutta la spiegazione che serve per capirlo; uno semplice una riga;
- gli esempi del docente e dell'utente restano tutti; di tuo ne aggiungi al massimo uno per concetto, e solo se aiuta;
- se un paragrafo si può dire in metà delle parole senza perdere informazioni, va detto in metà delle parole.

Per accorciare si tolgono parole, mai contenuti.

Tre tipi di testo, e solo questi:

- **Definizione asciutta**: una frase, formale, con la notazione del docente.
- **Spiegazione discorsiva**: dice *perché* o *come* funziona un passaggio, con parole semplici e anche in prima persona ("se mi trovo in $q_0$ e leggo $a$..."). Non ripete la definizione con altre parole.
- **Callout**: esempi, note, avvertimenti. Stanno fuori dal flusso del testo.

## Cosa non scrivere

- Introduzioni e chiusure: "In questa lezione vedremo", "In conclusione", "Come abbiamo visto".
- Sezioni "Introduzione", "Conclusioni", "Concetti chiave", "Riepilogo".
- Enfasi vuota: "è importante notare che", "fondamentale", "cruciale", "estremamente", "strettamente".
- Titoli a effetto ("Il motore dell'infinito"): il titolo dice l'argomento e basta.
- Maiuscole Su Ogni Parola nei titoli e nelle etichette.
- Grassetto a pioggia: va solo sul termine che viene definito, la prima volta.
- Elenchi in cui ogni punto è "**Etichetta:** frase generica". Un elenco serve quando gli elementi sono davvero paralleli.
- Callout con titoli come "Nota del Prof", "Approfondimento", "Contesto storico".
- La stessa cosa detta due volte. L'unico riassunto ammesso è la sintesi in fondo alla nota.

## Struttura della nota

```markdown
# Titolo della lezione

## Argomento principale
Testo.

**Sotto-argomento:** testo che continua sulla stessa riga.

> [!info] Sintesi:
> - punto chiave
> - punto chiave
```

- Un solo `#`, con il titolo. La data sta solo nel nome del file (`2026-05-07 Automi a pila.md`), mai nel testo. Niente frontmatter, niente tag.
- `##` per gli argomenti della lezione. `###` solo se un argomento è davvero lungo. Mai `####`.
- Dentro una sezione, per separare i sotto-argomenti usa l'etichetta in grassetto a inizio paragrafo (`**Grafo di un automa:**`), non un titolo.
- Titoli senza numeri, senza grassetto, senza emoji, con la sola iniziale maiuscola.
- Niente righe `---` tra le sezioni e niente sezione di navigazione in fondo.
- La nota si chiude sempre con un callout `> [!info] Sintesi:`: da 3 a 6 punti, una riga ciascuno, con ciò che della lezione va ricordato. Niente frasi nuove e niente formule lunghe. È l'ultima cosa della nota e ce n'è una sola.

## Etichette

In corsivo, a inizio paragrafo, seguite dai due punti:

`*Definizione:*` `*Teorema:*` `*Lemma:*` `*Proposizione:*` `*Dimostrazione:*` `*Osservazione:*` `*Vantaggi:*` `*Svantaggi:*`

Altre abitudini da mantenere:

- Elenchi con `-`. Elenchi numerati solo per passi in sequenza.
- La glossa con ` = ` dopo un termine formale: `$Q$ è l'insieme degli stati = tutte le configurazioni che il dispositivo può assumere`.
- `<u>...</u>` per la frase chiave di un paragrafo. Al massimo una per sezione.
- Corsivo per i termini inglesi e per il termine tecnico citato (*busy-waiting*, *semWait*).
- Frecce, puntini e simboli sono liberi: `->`, `=>`, `→`, `…` vanno tutti bene.

## Callout

Solo questi tipi, sempre in minuscolo:

| Tipo | Uso |
|---|---|
| `[!example]` | esempio, esercizio svolto, immagine di un caso concreto. Di solito senza titolo. |
| `[!info]` | spiegazione a parole di un passaggio formale (`In altre parole:`, `N.B.`) e sintesi finale della nota (`Sintesi:`) |
| `[!important]` | la cosa che all'esame non si può sbagliare. Raro. |
| `[!warning]` | errore tipico, caso limite. Titolo tipico: `Attenzione:` |
| `[!tip]` | promemoria. Titolo tipico: `Ricorda` |
| `[!todo]` | punto da rivedere. Vedi sotto. |

Un callout non ripete il testo che lo precede. `[!info] Sintesi:` è riservato alla chiusura della nota; per spiegare a parole un passaggio formale difficile usa `[!info] In altre parole:`, in poche righe.

## Formule e codice

- `$...$` nel testo. `$$...$$` su righe proprie per le formule lunghe o che meritano risalto.
- Nelle formule segui la notazione già usata nella nota e dal docente. Non convertire le formule esistenti.
- Codice e pseudocodice sempre in un blocco ` ``` `. L'etichetta dopo i tre apici è quella che mette l'utente: il linguaggio (`c`, `java`) oppure un nome (`Algoritmo_di_Dekker`). Non cambiarla. Nei blocchi nuovi metti il linguaggio se è codice vero, altrimenti un nome senza spazi.
- Nomi di funzioni e variabili nel testo tra apici singoli: `` `fork()` ``.
- Tabelle solo per confronti con almeno due colonne di dati.

## Immagini

Le immagini le inserisce l'utente e stanno nella cartella `images/` accanto alla nota. Non rinominarle, non spostarle, non inventarne. In `src` va il solo nome del file, copiato identico a come l'ha scritto l'utente, senza `images/` davanti.

Non puoi vedere le immagini: non descrivere cosa mostrano se non te lo dice il testo dell'utente.

Fuori dai callout ogni immagine usa uno di questi layout. Quale usare lo dice il segnaposto che l'utente scrive dopo l'immagine:

| L'utente scrive | Layout |
|---|---|
| `![[x.png]]` | ridimensionata a 300 |
| `![[x.png]] // adatta //` | adattata alla larghezza della pagina |
| `![[x.png]] // sotto: testo //` | con scritta sotto |
| `![[x.png]] // lato: testo //` | con testo a lato. Con `// lato //` senza testo, a lato va il paragrafo che segue |

Ridimensionata:

```html
<div style="display: flex; justify-content: center;">
  <img src="x.png" width="300">
</div>
```

Adattata alla pagina:

```html
<div style="display: flex; justify-content: center;">
  <img src="x.png" style="width: 100%;">
</div>
```

Con scritta sotto:

```html
<div style="text-align: center;">
  <img src="x.png" alt="Immagine" />
  <p>Testo</p>
</div>
```

Con testo a lato:

```html
<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="x.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Testo
  </div>
</div>
```

Dentro un `<div>` il Markdown non funziona: corsivo con `<i>`, grassetto con `<b>`, niente `$...$`. Se il testo a lato ha formule, usa il layout ridimensionato e metti il testo sotto, fuori dal div.

Dentro un callout l'immagine resta `![[x.png|300]]`. Le immagini già in un `<div>` non si toccano.

## Segnaposto dell'utente

Fuori dai blocchi di codice, `// ... //` è un'istruzione per te, da eseguire in quel punto:

| Segnaposto | Cosa fare |
|---|---|
| `// slide 28 //`, `// slide 19-21 //` | leggi quelle pagine del materiale e integra qui il contenuto |
| `// def X //`, `// tabella X //`, `// passaggi X //` | cerca X nel materiale e riportalo qui |
| qualsiasi altro testo | è una richiesta: approfondisci, correggi, aggiungi un esempio, ecc. |

Il segnaposto sparisce solo quando è stato eseguito. Se non riesci a eseguirlo, sostituiscilo con un `[!todo]` che dice cosa manca.

## Todo

```markdown
> [!todo] slide 28 non trovata in automi.pdf
```

Lascia un `[!todo]` quando: un segnaposto non si risolve, il materiale e gli appunti si contraddicono e non sai chi ha ragione, un passaggio ti sembra sbagliato ma non puoi verificarlo. Una riga, concreta. A ogni passata prova a chiudere i `[!todo]` già presenti.

## Collegamenti

Collega con un wikilink le lezioni dello stesso corso quando un concetto è spiegato in un'altra nota: `[[Nome del file|testo]]`, oppure `[[Nome del file#Sezione|testo]]`. Solo verso note che esistono (controlla prima), solo alla prima occorrenza nella sezione, e senza cambiare il testo per far posto al link.

## Esempio

Così no:

```markdown
### **Il Time-Sharing: Una Rivoluzione Interattiva**
Il **Time-sharing** (condivisione del tempo) è un paradigma fondamentale sviluppato per supportare la gestione di più lavori interattivi. È importante notare che:
* **Condivisione fluida:** Il processore viene condiviso in modo fluido tra tutti gli utenti attivi.
* **Accesso simultaneo:** L'accesso avviene simultaneamente attraverso l'uso di terminali.

> [!NOTE] Nota del Prof
> Il time-sharing permette quindi a più utenti di usare contemporaneamente la stessa macchina.
```

Così sì:

```markdown
## Time-sharing
Il processore viene condiviso fra più utenti collegati da terminale: il SO assegna a turno a ogni programma un *quanto di elaborazione*. L'obiettivo non è più massimizzare l'uso della CPU (multiprogrammazione) ma minimizzare il tempo di risposta.
```

E questo è il registro giusto per definizione, spiegazione e callout insieme:

```markdown
## Semafori
Meccanismo per sincronizzare l'accesso alle sezioni critiche. Un semaforo è formato da una variabile intera, una coda e tre operazioni:
- Inizializzazione a un valore non negativo
- *semWait:* decrementa il valore. Se diventa negativo, il processo è sospeso e messo in coda
- *semSignal:* incrementa il valore. Se non diventa positivo, uno dei processi in coda è riattivato

> [!info] In altre parole:
> Quando il valore è positivo dice quanti processi possono ancora entrare, quando è negativo dice quanti sono in coda.

*Osservazione:* il processo non può sapere in anticipo se con *semWait* sarà sospeso.
```
