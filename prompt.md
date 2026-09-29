# Regole del vault Appunti (Obsidian)

Questo repository è un vault Obsidian di appunti universitari. Ogni sottocartella di primo livello è una materia (es. `3° Anno/Programmazione`, `3° Anno/Base di Dati`, `2° Anno/Sistemi Operativi`, `2° Anno/Linguaggi Formali`, `2° Anno/Diritto dell'Informatica e Data Protection`, `Erasmus/...`).

Qui si lavora in **modalità agente**: si modificano o si creano direttamente i file nel vault. Non si restituisce la nota come blocco di codice in chat.

---

## 0. Modalità di lavoro (stabiliscila PRIMA di iniziare)

| Modalità | Quando | Fonte primaria |
|---|---|---|
| **A. Sistemazione appunti** | Esiste un file di appunti grezzi (`.md`, `.txt`, trascrizione) da sistemare | L'appunto originale (§2), integrato con `_materiale/` |
| **B. Nota da materiale** | Non ci sono appunti personali e va creata una nota da slide/PDF/dispense | Il materiale didattico (§3) |

- Se la richiesta non chiarisce la modalità (es. il file target non esiste e non è indicato il materiale), chiedi con `question`.
- In entrambe le modalità valgono le regole su fonti (§4), formato (§6), permessi (§7) e indici (§8).

### Workflow sintetico
1. Individua la materia e la cartella del corso (§1).
2. Leggi le note esistenti, il `00_Index_<Materia>.md` e il contenuto di `_materiale/`.
3. Elabora la nota secondo la modalità (§2 o §3), risolvendo i placeholder (§5).
4. Applica il formato (§6).
5. Aggiorna l'indice (§8).
6. Invoca `@revisore` sulla nota.
7. Scrivi il resoconto finale in chat (§9).

---

## 1. Rilevamento del contesto e della cartella
- Identifica la materia/corso di riferimento e lavora solo nella sua cartella.
- Prima di scrivere, controlla nella cartella:
  - il file indice del corso (`00_Index_<Materia>.md`);
  - la convenzione di numerazione e naming (`01_Nome_Argomento.md`, `02_...`);
  - lo stile di numerazione dei capitoli usato nelle altre note (`## I.` oppure `## 1.`);
  - il tag della materia già usato dalle altre note.
- Per una nuova nota (modalità B), usa il primo numero libero della sequenza e il naming della cartella.

---

## 2. Modalità A: l'appunto originale è la fonte primaria
- Il testo esistente è la base. Si riordina, si corregge e si amplia; non si riscrive da zero.
- Non eliminare MAI un concetto, un esempio o una nota del docente presente nell'originale. Se è ridondante, lo si fonde; se è sbagliato, lo si corregge.
- Mantieni la struttura già impostata (numerazione dei capitoli, naming dei file, callout già presenti) salvo che sia palesemente incoerente con il resto della cartella.
- Ampliare significa completare definizioni, passaggi, formule, esempi DELL'ARGOMENTO TRATTATO. Non aggiungere argomenti che la lezione non tocca.
- Allinea la terminologia a quella del materiale ufficiale e sostituisci abbreviazioni rapide con la formulazione completa.
- Conserva ed evidenzia esempi a voce, analogie e riflessioni del docente che non compaiono nelle slide: sono il valore aggiunto degli appunti.

---

## 3. Modalità B: rielaborazione del materiale didattico
- **Dalle slide telegrafiche alla nota coesa:** trasforma elenchi puntati scarni e frasi tronche in prosa tecnica fluida e auto-esplicativa. Esplicita i nessi causa-effetto e la funzione di ogni elemento, senza produrre un copia-incolla dell'elenco.
- **Estrazione completa:** riporta tutte le definizioni formali, teoremi, architetture, passaggi algoritmici, elenchi completi e parametri presenti nel materiale, senza tralasciare dettagli tecnici rilevanti.
- **Nessuna invenzione:** esplicita solo ciò che nelle slide è accennato o implicito. Non aggiungere contenuti che il materiale non contiene né argomenti che non tratta.
- Segui l'ordine logico del materiale. Aggiungi una sezione solo se esiste nel materiale.
- Conserva intatte la nomenclatura tecnica e le definizioni formali.

---

## 4. Fonti e onestà
- Se nella cartella della materia esiste `_materiale/` (slide, PDF convertiti in .md/.txt, dispense), è la fonte di verità per correzioni, completamenti e placeholder.
- Se ci sono placeholder `// ... //` o affermazioni da verificare, delega la ricerca al subagente `@materiale`, passandogli la cartella della materia e l'elenco puntuale di cosa cercare.
- Se il materiale non c'è o la slide non si trova, NON inventare: lascia il contenuto dove sta e inserisci
  `> [!TODO] Da completare: <cosa manca> (fonte non trovata)`.
- Quando correggi o ampli usando solo conoscenza generale (senza fonte nel vault), il contenuto deve essere standard e verificabile. Se non sei sicuro, chiedi (§7) invece di scrivere.
- Invoca `@revisore` sulla nota modificata. Correggi le violazioni che non richiedono permesso; quelle che lo richiedono vanno tra i dubbi aperti.

---

## 5. Il simbolo `// ... //`
Negli appunti veloci `// ... //` ha due usi distinti.

### a) Direttiva di recupero ed espansione
Esempi: `// slide 12 //`, `// def XYZ //`, `// tabella metodi //`, `// passaggi slide 19-21 //`.
- Serve a delegare il recupero di contenuti che il docente ha mostrato troppo velocemente.
- Fai un **check attivo** in `_materiale/` (tramite `@materiale`): localizza la slide o la sezione indicata, estrai definizioni formali, tabelle complete, passaggi o schemi.
- Integra il contenuto nel corpo del testo, sviluppato e collegato al resto, al posto del placeholder.
- Se non trovi la fonte, applica la regola `[!TODO]` del §4.

### b) Nota a voce / annotazione contestuale
Esempi: `// precisazione del prof: ... //`, eccezioni, esempi orali, avvertenze.
- Trasformala nel callout opportuno (§6), posizionato **subito sotto il concetto** a cui si riferisce.

### Come distinguerle
- Riferimento a slide, definizione, tabella, passaggi o numero di pagina → **recupero**.
- Contenuto già scritto per esteso (una frase, un esempio, un commento) → **callout**.
- Se è ambiguo, trattalo come callout mantenendo il testo originale e segnalalo tra i dubbi aperti.

---

## 6. Formato delle note

### Frontmatter (UN SOLO TAG)
Obbligatorio, con un solo tag: quello della materia, in kebab-case, uguale a quello delle altre note della cartella. Un tag per file mantiene il grafo di Obsidian pulito e raggruppato per materia.
```yaml
---
date: YYYY-MM-DD
tags:
  - nome-materia
type: lezione
---
```

### Titolo e gerarchia
- Un solo H1 (`#`): titolo chiaro, formale e sintetico dell'argomento.
- Capitoli H2 numerati coerentemente con le altre note della materia (`## I. ...` oppure `## 1. ...`); sottosezioni H3.
- Niente sezioni "Conclusioni"/"Concetti chiave" se non presenti nell'originale o nel materiale.

### Callout Obsidian
| Callout | Uso |
|---|---|
| `> [!IMPORTANT] Titolo` | Definizioni cardine, proprietà fondamentali, vincoli, regole d'oro |
| `> [!EXAMPLE] Titolo` | Casi d'uso, walkthrough di algoritmi, frammenti di codice, esempi pratici |
| `> [!NOTE] Nota del Prof` | Commenti e precisazioni a voce del docente |
| `> [!INFO]` | Dettagli tecnici, approfondimenti di implementazione, note architetturali |
| `> [!WARNING]` | Limitazioni, casi limite, trabocchetti concettuali, errori tipici |
| `> [!LAW] Titolo` | Articoli di legge, norme, sentenze, GDPR (corsi giuridici) |
| `> [!TODO]` | Contenuto da completare perché la fonte non è stata trovata |

Non trasformare in callout interi paragrafi di teoria: il callout evidenzia, il corpo del testo spiega.

### Formule, codice, tabelle
- Formule matematiche, logiche e grammatiche formali in LaTeX: `$...$` inline, `$$...$$` a blocco.
- Codice in blocchi con linguaggio dichiarato (```c, ```java, ```python, ```sql, ```bash, ```http, ```html).
- Tabelle Markdown per confronti, tassonomie, parametri, tabelle di verità.

### Enfasi e collegamenti
- Grassetto per definizioni e termini chiave al primo utilizzo.
- Wikilink `[[...]]` solo per concetti centrali o note esistenti nel vault.

### Immagini
- Non rinominare né spostare file immagine. Le immagini stanno in `images/<Materia>/`.
- Inserimento standard: sintassi nativa `![[img.png]]` o `![[img.png|300]]`.
- Layout HTML, secondo l'esigenza:

Immagine con testo a destra (diagrammi da spiegare a lato):
```html
<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="nome_immagine.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
    Spiegazione o testo correlato all'immagine...
  </div>
</div>
```

Immagine ridimensionata e centrata (schemi, grafi, screenshot isolati):
```html
<div style="display: flex; justify-content: center;">
  <img src="nome_immagine.png" width="300">
</div>
```

Immagine con didascalia centrata sotto:
```html
<div style="text-align: center;">
  <img src="nome_immagine.png" alt="Descrizione" />
  <p>Didascalia o commento esplicativo</p>
</div>
```

### Stile
- Registro da studente universitario brillante di informatica/ingegneria: rigoroso, chiaro, pragmatico, compatto.
- Frasi lineari, definizioni asciutte, spiegazioni logico-causali dirette.
- Zero fluff da AI: niente "In questa guida esploreremo...", "Nel dinamico panorama odierno...", "È fondamentale sottolineare...", "In conclusione...", né aggettivi enfatici superflui.
- Il risultato deve sembrare una nota di studio rielaborata da una persona reale.

### Navigazione
Ogni nota termina con:
```markdown
---
## ⏭️ Navigazione Lezioni
- **Index Corso :** [[00_Index_<Materia>]]
```

---

## 7. Cosa richiede il permesso esplicito (usa `question` PRIMA di farlo)
- Eliminare una sezione o un paragrafo dell'originale (anche se lo ritieni sbagliato o doppio).
- Correggere un'affermazione quando non hai una fonte in `_materiale/` e la correzione cambia il significato.
- Cambiare la numerazione/struttura dei capitoli di una nota o il naming dei file.
- Rinominare, spostare, dividere o unire file.
- Modificare più di un file in una sola richiesta, oltre alla nota target e al suo `00_Index_*.md`.
- Cambiare tag, frontmatter di note che non stai lavorando, o convenzioni della cartella.

Tutto il resto procedi senza chiedere: riordino locale, completamento, callout, formule, correzioni con fonte, creazione della nuova nota in modalità B (conta come nota target).

---

## 8. Indici
- Ogni file di appunti da sistemare va considerato una nuova lezione da aggiungere a quelle già esistenti.
- Aggiungi la nota al `00_Index_<Materia>.md` nella sezione opportuna (es. Teoria, Laboratorio, Note), seguendo il formato delle voci già presenti.
- Non riordinare l'indice se non richiesto.

---

## 9. Resoconto finale (in chat, non nella nota)
Alla fine di ogni lavoro elenca brevemente, in un elenco puntato facilmente leggibile:
1. Correzioni fatte (prima → dopo, e la fonte). In modalità B: "nessuna, nota nuova".
2. Ampliamenti aggiunti (in modalità B: slide/sezioni del materiale coperte).
3. Placeholder risolti e quelli rimasti `[!TODO]`.
4. Dubbi aperti (incluse le violazioni segnalate da `@revisore` che richiedono permesso).

---

## 10. Modello di riferimento
Esempio di nota conforme (materia informatica):

~~~markdown
---
date: 2026-03-04
tags:
  - sistemi-operativi
type: lezione
---
# Architettura del Sistema di Elaborazione

## 1. Unità Centrale (CPU) e Componenti
La **CPU** governa l'esecuzione delle istruzioni ed è composta da:
* **ALU (Arithmetic Logic Unit):** esegue le operazioni aritmetiche e logiche.
* **Control Unit (CU):** decodifica le istruzioni e genera i segnali di controllo.
* **Registri:** memorie ad accesso immediato per lo stato di esecuzione e gli operandi.

> [!IMPORTANT] Principio di Von Neumann
> Dati e istruzioni risiedono nello stesso spazio di memoria principale (*Stored Program Concept*).

> [!NOTE] Nota del Prof
> La cache sfrutta la località spaziale e temporale: per questo i cicli su array contigui sono più veloci.

### Ciclo Fetch-Execute
```c
while (running) {
    Instruction instr = fetch();
    decode(instr);
    execute(instr);
}
```

> [!TODO] Da completare: tabella dei registri speciali (slide 14 non trovata in _materiale/)

---
## ⏭️ Navigazione Lezioni
- **Index Corso :** [[00_Index_OS]]
~~~

Per le materie giuridiche vale lo stesso schema, con norme e articoli in `> [!LAW] Art. X ...`.
