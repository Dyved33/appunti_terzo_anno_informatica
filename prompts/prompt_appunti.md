# 📝 Obsidian Notes Transmutation Prompt & Agent Instructions

Questo file contiene le istruzioni e i prompt ottimizzati per trasformare appunti grezzi (file `.txt`, note veloci, trascrizioni) e materiale didattico (slide, PDF, dispense) in note Markdown per Obsidian perfettamente strutturate, coerenti con la convenzione del vault.

---

## 🤖 Istruzioni per Antigravity / AI Agent (Modalità Agente)

Se stai operando come agente autonomo (es. **Antigravity**) all'interno di questo repository, segui questo workflow quando ti viene chiesto di convertire o creare una nuova nota:

### 1. Rilevamento del Contesto e della Cartella
1. Identifica la materia/corso di riferimento (es. `3° Anno/Programmazione`, `3° Anno/Base di Dati`, `2° Anno/Sistemi Operativi`, `2° Anno/Linguaggi Formali`, `2° Anno/Diritto dell'Informatica e Data Protection`, `Erasmus/...`, ecc.).
2. Esamina i file già presenti nella cartella del corso e controlla:
   - Il file indice del corso (es. `00_Index_<Materia>.md`).
   - La convenzione di numerazione e naming (es. `01_Nome_Argomento.md`, `02_...`).
   - **Regola Unico Tag per File:** Per garantire un grafo Obsidian pulito e clusterizzato per materia senza nodi ridondanti, assegna sempre e solo **un singolo tag** per file (il tag della materia in formato kebab-case o standard, es. `programmazione-web`, `base-di-dati`, `sistemi-operativi`).

### 2. Elaborazione e Sintesi del Contenuto
1. **Fusione Note + Materiale e Risoluzione dei Placeholder (`// ... //`)**:
   - **Direttive di Recupero ed Espansione Materiale (`// slide X //`, `// def XYZ //`, `// tabella XYZ //`, `// passaggi slide Y //`)**:
     - Spesso durante le lezioni veloci l'utente inserisce tra `// ... //` indicazioni sintetiche per delegare all'AI il recupero di definizioni formali, tabelle, passaggi, elenchi o concetti illustrati nelle slide.
     - L'AI **deve eseguire un vero e proprio check/lookup attivo** nel materiale di riferimento (slide, PDF, dispense), localizzare la sezione/slide indicata, estrarre i contenuti tecnici completi e integrarli approfonditamente nel corpo della nota.
   - **Correzione e Completamento**:
     - Usa il materiale ufficiale per correggere imprecisioni, completare definizioni o formule omesse e verificare la terminologia tecnica.
2. **Conversione dei Simboli Speciali (`//`) in Callout Obsidian**:
   - Quando `// ... //` racchiude annotazioni a voce del docente, precisazioni a margine, avvisi, eccezioni o esempi pratici spiegati oralmente, trasformalo nel relativo **Callout Obsidian** (`> [!INFO]`, `> [!NOTE] Nota del Prof`, `> [!EXAMPLE]`, `> [!WARNING]`, `> [!LAW]`, `> [!IMPORTANT]`), posizionato contestualmente subito dopo il concetto a cui si riferisce.
3. **Formule, Codice e Schemi**:
   - Usa blocchi LaTeX per formule matematiche/formali (`$formula$` inline o `$$...$$` per blocchi).
   - Usa blocchi di codice con sintassi evidenziata (es. ````c`, ````java`, ````python`, ````bash`, ````http`, ````html`).
   - Usa tabelle Markdown pulite o schemi concettuali per sintetizzare flussi e confronti.
4. **Gestione Immagini e Layout Visivo (HTML/CSS & Obsidian)**:
   - Quando inserisci immagini o schemi (collegati a `images/<Materia>/` o incollati), adotta i seguenti layout HTML/CSS in base alle esigenze grafiche:
     * **Immagine con testo a destra (Flexbox affiancato):** per diagrammi o figure che necessitano di spiegazione immediata a lato.
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
     * **Immagine ridimensionata e centrata:** per schemi, grafi o screenshot isolati.
       ```html
       <div style="display: flex; justify-content: center;">
         <img src="nome_immagine.png" width="300">
       </div>
       ```
     * **Immagine con didascalia centrata sotto:** per figure con annotazione o didascalia esplicativa.
       ```html
       <div style="text-align: center;">
         <img src="nome_immagine.png" alt="Descrizione" />
         <p>Didascalia o commento esplicativo</p>
       </div>
       ```
     * È sempre valida anche la sintassi Obsidian nativa `![[nome_immagine.png]]` o `![[nome_immagine.png|300]]` per inserimenti standard.
5. **Registro Linguistico e Tono di Voce (Umano, Diretto e Tecnico)**:
   - Mantieni uno stile **autentico, accademico e pragmatico**, da ottimo studente universitario di informatica/ingegneria.
   - **Zero "stile AI / fluff":** Evita categoricamente introduzioni retoriche ("Nel dinamico panorama odierno...", "È essenziale notare che..."), aggettivi enfatici superflui o conclusioni prolisse e ripetitive.
   - Il testo deve risultare naturale, denso di concetti tecnici spiegati chiaramente, con definizioni asciutte e frasi lineari. Ricorda che lo scopo primario è riorganizzare e completare fedelmente gli appunti di lezione dell'utente.

### 3. Creazione del File e Aggiornamento Indici
1. Crea il file `.md` nella directory corretta con il relativo frontmatter YAML.
2. Aggiungi il link di navigazione in calce (`## ⏭️ Navigazione Lezioni` con il wikilink a `[[00_Index_<Materia>]]`).
3. Aggiorna il file `00_Index_<Materia>.md` aggiungendo la nuova nota nella sezione opportuna (es. Teoria, Laboratorio, Note).

---

## 📋 Prompt per Chat LLM (Copia e Incolla)

Usa il seguente prompt quando interagisci con qualsiasi modello LLM in modalità conversazionale (ChatGPT, Claude, Gemini Web, ecc.).

```markdown
Agisci come un esperto di Personal Knowledge Management (PKM) e redattore tecnico accademico specializzato in Obsidian.

IL TUO COMPITO:
Trasforma i miei appunti grezzi (ed eventuale materiale del docente allegato) in una nota Markdown (.md) professionale, impeccabile e pronta per essere inserita nel mio vault Obsidian.

REGOLE DI FORMATTAZIONE ED ELABORAZIONE:

1. FRONTMATTER YAML (UN SOLO TAG PER FILE):
   Inizia la nota rigorosamente con il frontmatter YAML.
   **REGOLA IMPORTANTE SUI TAG:** Inserisci **UN SOLO TAG per file** (il tag identificativo della materia in kebab-case/minuscolo, es. `programmazione-web`, `sistemi-operativi`, `base-di-dati`, `linguaggi-formali`), così da mantenere il grafo di Obsidian pulito, leggibile e privo di frammentazione:
   ---
   date: {{DATA o YYYY-MM-DD}}
   tags:
     - {{tag-materia}}
   type: lezione
   ---

2. TITOLO E GERARCHIA:
   - Titolo H1 (#) chiaro, formale e sintetico dell'argomento.
   - Struttura gerarchica ordinata con numerazione logica per i capitoli (es. ## I. Introduzione, ## II. ..., oppure ## 1. ..., ## 2. ...) e sottosezioni con H3 (###).
   - Non creare sezioni riassuntive superflue ("Conclusioni", "Concetti chiave") a meno che non siano esplicitamente richieste o presenti nel testo originale.

3. GESTIONE DEL SIMBOLO SPECIALE // (PLACEHOLDER DI RECUPERO VS CALLOUT):
   Nei miei appunti veloci uso i doppi slash `// ... //` per due scopi distinti:
   a) **DIRETTIVA DI RECUPERO ED ESPANSIONE (es. `// slide 12 //`, `// def XYZ //`, `// tabella metodi //`, `// passaggi slide 19-21 //`):**
      - Quando il docente procede velocemente, inserisco questi placeholder per delegarti il compito di cercare e prelevare il contenuto dal materiale allegato.
      - **DEVI EFFETTUARE UN CHECK ATTIVO NEL MATERIALE:** individua la slide/sezione indicata, estrai definizioni formali, tabelle complete, passaggi o schemi e sviluppali in modo chiaro, approfondito e integrato nel corpo del testo.
   b) **NOTE A VOCE / CALLOUT CONTESTUALI (es. `// precisazione del prof: ... //` o note a margine):**
      - Trasformale in un opportuno **Callout Obsidian** inserito CONTESTUALMENTE subito sotto il concetto correlato:
        * Approfondimenti/Note: `> [!INFO]` o `> [!NOTE] Nota del Prof`
        * Esempi pratici: `> [!EXAMPLE] Titolo Esempio`
        * Concetti critici/regole d'oro: `> [!IMPORTANT]`
        * Normative o avvisi: `> [!LAW]` o `> [!WARNING]`

4. CODICE, FORMULE E LINGUAGGIO TECNICO:
   - Formule matematiche, logiche e grammatiche formali in LaTeX ($...$ inline o $$...$$ a blocco).
   - Codice sorgente racchiuso in blocchi di codice specificando il linguaggio (es. ```c, ```java, ```bash, ```http, ```html).
   - Usa il grassetto per evidenziare definizioni e termini chiave.
   - Usa wikilink [[Nome Concetto]] per termini centrali suscettibili di avere una nota dedicata o per riferimenti interni.

5. GESTIONE IMMAGINI E LAYOUT VISIVO (HTML / CSS):
   Quando sono presenti immagini, diagrammi o screenshot (estratti da slide, allegati o presenti nel vault), utilizza i blocchi HTML/CSS per una resa grafica elegante e ordinata:
   - **Immagine con testo a destra (Flexbox affiancato):**
     <div style="display: flex; align-items: flex-start; gap: 20px;">
       <div style="flex: 1;">
         <img src="nome_immagine.png" style="width: 100%; border-radius: 8px;">
       </div>
       <div style="flex: 1.5;">
         Testo / spiegazione correlata all'immagine...
       </div>
     </div>
   - **Immagine ridimensionata e centrata:**
     <div style="display: flex; justify-content: center;">
       <img src="nome_immagine.png" width="300">
     </div>
   - **Immagine con didascalia centrata sotto:**
     <div style="text-align: center;">
       <img src="nome_immagine.png" alt="Descrizione" />
       <p>Didascalia o annotazione esplicativa</p>
     </div>
   - In alternativa, per inserimenti semplici è valida la sintassi nativa `![[nome_immagine.png]]` o `![[nome_immagine.png|300]]`.

6. FUSIONE CON MATERIALE UFFICIALE ED ESPANSIONE:
   - Allinea rigorosamente la trattazione al materiale del docente allegato.
   - Sostituisci ogni omissione o abbreviazione rapida con la spiegazione formale ed esaustiva presente nelle slide.
   - Correggi imprecisioni ed errori presenti negli appunti grezzi usando la terminologia delle slide.
   - Mantieni ed evidenzia eventuali esempi a voce, analogie o riflessioni del docente non presenti sulle slide.

7. STILE DI SCRITTURA E REGISTRO (UMANO, DIRETTO, TECNICO E SENZA FLUFF AI):
   - Adotta il registro linguistico naturale di un brillante studente universitario o redattore tecnico: rigoroso, chiaro, pragmatico e compatto.
   - **Zero cliché da AI:** Evita formule artificiali, giri di parole pomposi, aggettivi altisonanti e frasi di apertura/chiusura stereotipate (es. *"In questa guida esploreremo...", "È fondamentale sottolineare...", "In conclusione..."*).
   - Privilegia definizioni asciutte, spiegazioni logico-causali dirette, elenchi ben strutturati e frammenti di codice pertinenti. Il risultato finale deve sembrare un'eccellente nota presa a mano e rielaborata da una persona reale.

8. NAVIGAZIONE:
   Concludi sempre la nota con la sezione:
   ---
   ## ⏭️ Navigazione Lezioni
   - **Index Corso :** [[00_Index_{{NOME_CORSO}}]]

VINCOLO DI OUTPUT:
Restituisci SOLO ED ESCLUSIVAMENTE il blocco di codice Markdown contenente la nota formattata (racchiusa tra ```markdown e ```), senza premesse, saluti o commenti discorsivi prima o dopo.

---

DATI DELLA NOTA:
- Materia: [INSERISCI MATERIA, es. Sistemi Operativi, Diritto dell'Informatica, Linguaggi Formali]
- Data: [INSERISCI DATA, es. YYYY-MM-DD o oggi]
- Index File: [es. 00_Index_OS, 00_Index_Diritto, 00_Index_Linguaggi_Formali]

APPUNTI GREZZI:
[INCOLLA QUI I TUOI APPUNTI]

MATERIALE AGGIUNTIVO / SLIDE (opzionale):
[INCOLLA O ALLEGA QUI IL TESTO DELLE SLIDE / DISPENSE]
```

---

## 📚 Modelli di Riferimento per Materia

### A. Materie Informatiche / Ingegneristiche (Sistemi Operativi, Software Eng, Reti, Algoritmi)
```markdown
---
date: 2026-03-04
tags:
  - sistemi-operativi
type: lezione
---
# Architettura del Sistema di Elaborazione

## 1. Unità Centrale (CPU) e Componenti
L'unità centrale (CPU) è il cuore del sistema di elaborazione...
* **Microprocessore:** Un processore realizzato su un singolo chip (*core*).
* **Multiprocessore:** Architetture che integrano più processori su un unico chip.

> [!INFO] Memoria Cache
> Memoria ad altissima velocità integrata nel processore per ridurre i tempi di accesso ai dati più frequenti.

### Ciclo Fetch-Execute
```c
// Esempio logico ciclo istruzione
while (running) {
    Instruction instr = fetch();
    execute(instr);
}
```

---
## ⏭️ Navigazione Lezioni
- **Index Corso :** [[00_Index_OS]]
```

### B. Linguaggi Formali e Compilatori / Matematica
```markdown
---
date: 2026-02-26
tags:
  - linguaggi-formali
type: lezione
---
# Compilatori e Fasi della Compilazione

## I. Fasi dell'Analisi Sintattica
L'analisi semantica statica verifica la coerenza dei tipi nell'**Abstract Syntax Tree (AST)**.

* **Grammatica formale:** $G = (V, \Sigma, R, S)$
* **Funzione di transizione:** $\delta: Q \times \Sigma \rightarrow Q$

> [!EXAMPLE] Albero Sintattico
> Per l'espressione `position = initial + rate * 60`, il parser genera nodi operatore con figli operandi.

---
## ⏭️ Navigazione Lezioni
- **Index Corso :** [[00_Index_Linguaggi_Formali]]
```

### C. Diritto dell'Informatica e Data Protection
```markdown
---
date: 2026-02-09
tags:
  - diritto-informatica
type: lezione
---
# Ordinamento Giuridico e Gerarchia delle Fonti

## I. Teoria Generale
L'**Ordinamento Giuridico** è un sistema vincolato al rispetto della **Costituzione**.

> [!LAW] Principio di Abrogazione (Art. 15 Preleggi)
> Se due norme di pari grado confliggono, la norma successiva abroga la precedente (*lex posterior derogat priori*).

> [!INFO] Garante Costituzionale
> Il Presidente della Repubblica agisce come garante supremo della conformità costituzionale delle leggi prima della promulgazione.

---
## ⏭️ Navigazione Lezioni
- **Index Corso :** [[00_Index_Diritto]]
```
