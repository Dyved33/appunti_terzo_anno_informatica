# 📝 Obsidian Material Transmutation Prompt & Agent Instructions

Questo file contiene le istruzioni e i prompt ottimizzati per trasformare materiale didattico ufficiale (slide, presentazioni, PDF, dispense, capitoli di testo) in note Markdown per Obsidian perfettamente strutturate, esaustive e coerenti con la convenzione del vault, **in assenza di appunti personali presi a lezione**.

---

## 🤖 Istruzioni per Antigravity / AI Agent (Modalità Agente)

Se stai operando come agente autonomo (es. **Antigravity**) all'interno di questo repository, segui questo workflow quando ti viene chiesto di elaborare o creare una nuova nota partendo esclusivamente dal materiale di studio:

### 1. Rilevamento del Contesto e della Cartella
1. Identifica la materia/corso di riferimento (es. `3° Anno/Programmazione`, `3° Anno/Base di Dati`, `2° Anno/Sistemi Operativi`, `2° Anno/Linguaggi Formali`, `2° Anno/Diritto dell'Informatica e Data Protection`, `Erasmus/...`, ecc.).
2. Esamina i file già presenti nella cartella del corso e controlla:
   - Il file indice del corso (es. `00_Index_<Materia>.md`).
   - La convenzione di numerazione e naming (es. `01_Nome_Argomento.md`, `02_...`).
   - **Regola Unico Tag per File:** Per garantire un grafo Obsidian pulito e clusterizzato per materia senza nodi ridondanti, assegna sempre e solo **un singolo tag** per file (il tag della materia in formato kebab-case o standard, es. `programmazione-web`, `base-di-dati`, `sistemi-operativi`).

### 2. Elaborazione e Sintesi del Contenuto
1. **Rielaborazione Attiva del Materiale (Da slide telegrafiche a nota di studio coesa)**:
   - **Superamento della frammentarietà:** Le slide sono spesso scritte per punti elenco scarni o frasi tronche. L'AI deve trasformare questi concetti in **prosa tecnica fluida, coesa e auto-esplicativa**, collegando logicamente i passaggi causali senza inventare contenuti ma esplicitando ciò che nelle slide è solo accennato per parole chiave.
   - **Estrazione Completa ed Esaustiva:** Estrai tutte le definizioni formali, teoremi, architetture, passaggi algoritmici, elenchi completi e parametri illustrati nel materiale, senza tralasciare dettagli tecnici rilevanti.
2. **Generazione Strategica dei Callout Obsidian**:
   - Arricchisci e organizza la nota inserendo strategicamente **Callout Obsidian** (`> [!INFO]`, `> [!NOTE]`, `> [!EXAMPLE]`, `> [!IMPORTANT]`, `> [!WARNING]`, `> [!LAW]`):
     - `> [!IMPORTANT]`: Definizioni cardine, proprietà fondamentali, vincoli e regole d'oro evidenziate nel materiale.
     - `> [!EXAMPLE]`: Casi d'uso, walkthrough di algoritmi, frammenti applicativi ed esempi pratici presenti nelle slide.
     - `> [!INFO]` o `> [!NOTE]`: Dettagli tecnici, approfondimenti di implementazione o note architetturali secondarie.
     - `> [!WARNING]`: Limitazioni di protocolli/linguaggi, casi limite, trabocchetti concettuali o errori tipici.
     - `> [!LAW]`: Articoli del codice, norme, sentenze o GDPR per corsi giuridici.
3. **Formule, Codice e Schemi**:
   - Usa blocchi LaTeX per formule matematiche/formali (`$formula$` inline o `$$...$$` per blocchi).
   - Usa blocchi di codice con sintassi evidenziata (es. ````c`, ````java`, ````python`, ````bash`, ````http`, ````html`).
   - Usa tabelle Markdown pulite o schemi concettuali per sintetizzare flussi e confronti.
4. **Gestione Immagini e Layout Visivo (HTML/CSS & Obsidian)**:
   - Quando inserisci immagini o schemi (collegati a `images/<Materia>/` o estratti dal materiale), adotta i seguenti layout HTML/CSS in base alle esigenze grafiche:
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
   - Mantieni uno stile **autentico, accademico e pragmatico**, da ottimo studente universitario di informatica/ingegneria che ha rielaborato e studiato le slide creando la nota definitiva.
   - **Zero "stile AI / fluff":** Evita categoricamente introduzioni retoriche ("Nel dinamico panorama odierno...", "È essenziale notare che..."), aggettivi enfatici superflui o conclusioni prolisse e ripetitive.
   - Il testo deve risultare naturale, denso di concetti tecnici spiegati chiaramente, con definizioni asciutte e frasi lineari.

### 3. Creazione del File e Aggiornamento Indici
1. Crea il file `.md` nella directory corretta con il relativo frontmatter YAML.
2. Aggiungi il link di navigazione in calce (`## ⏭️ Navigazione Lezioni` con il wikilink a `[[00_Index_<Materia>]]`).
3. Aggiorna il file `00_Index_<Materia>.md` aggiungendo la nuova nota nella sezione opportuna (es. Teoria, Laboratorio, Note).

---

## 📋 Prompt per Chat LLM (Copia e Incolla)

Usa il seguente prompt quando interagisci con qualsiasi modello LLM in modalità conversazionale (ChatGPT, Claude, Gemini Web, ecc.) per generare note partendo unicamente dal materiale del corso.

```markdown
Agisci come un esperto di Personal Knowledge Management (PKM) e redattore tecnico accademico specializzato in Obsidian.

IL TUO COMPITO:
Trasforma il materiale didattico allegato (slide, PDF, dispense, testo del docente) in una nota Markdown (.md) universitaria professionale, esaustiva, fluida e pronta per essere inserita nel mio vault Obsidian, colmando la tipica frammentarietà delle slide senza inventare informazioni non presenti o non implicite nel materiale.

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
   - Titolo H1 (#) chiaro, formale e sintetico dell'argomento principale.
   - Struttura gerarchica ordinata con numerazione logica per i capitoli (es. ## I. Introduzione, ## II. ..., oppure ## 1. ..., ## 2. ...) e sottosezioni con H3 (###).
   - Non creare sezioni riassuntive superflue ("Conclusioni", "Concetti chiave") a meno che non siano esplicitamente richieste o presenti nella struttura originale delle slide.

3. RIELABORAZIONE ATTIVA DEL MATERIALE (DALLE SLIDE ALLA NOTA DISCORSIVA):
   - Le slide contengono spesso elenchi puntati telegrafici e frasi sintetiche: trasformali in **spiegazioni tecniche complete, fluide e logico-deduttive**.
   - Non fare un mero "copia-incolla" dell'elenco puntato: esplicita i nessi di causa-effetto, chiarisci la funzione di ciascun elemento ed evita la sensazione di testo spezzettato.
   - Mantieni il massimo rigore terminologico: conserva intatte le definizioni formali, la nomenclatura tecnica e tutti i dettagli architetturali o teorici presenti.

4. CALLOUT OBSIDIAN STRATEGICI:
   Arricchisci la struttura visiva della nota organizzando i passaggi chiave nei relativi **Callout Obsidian**:
   - Definizioni centrali e regole d'oro: `> [!IMPORTANT] Titolo Definizione`
   - Esempi pratici, casi d'uso e walkthrough di codice: `> [!EXAMPLE] Titolo Esempio`
   - Approfondimenti, dettagli architetturali o note tecniche: `> [!INFO]` o `> [!NOTE]`
   - Limitazioni, avvertenze, trabocchetti o casi limite: `> [!WARNING]`
   - Normative, articoli di legge, direttive (per corsi giuridici): `> [!LAW]`

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

6. CODICE, FORMULE E LINGUAGGIO TECNICO:
   - Formule matematiche, logiche e grammatiche formali in LaTeX ($...$ inline o $$...$$ a blocco).
   - Codice sorgente racchiuso in blocchi con evidenziazione del linguaggio (es. ```c, ```java, ```bash, ```http, ```html).
   - Usa il grassetto per evidenziare definizioni e termini chiave al loro primo utilizzo.
   - Usa tabelle Markdown per sintetizzare confronti, tassonomie, parametri o tabelle di verità presenti nel materiale.
   - Usa wikilink [[Nome Concetto]] per concetti centrali suscettibili di avere una nota dedicata nel vault.

7. STILE DI SCRITTURA E REGISTRO (UMANO, DIRETTO, TECNICO E SENZA FLUFF AI):
   - Adotta il registro linguistico naturale di un brillante studente universitario di informatica/ingegneria: rigoroso, chiaro, pragmatico e compatto.
   - **Zero cliché da AI:** Evita formule artificiali, giri di parole pomposi, aggettivi altisonanti e frasi di apertura/chiusura stereotipate (es. *"In questa guida esploreremo...", "È fondamentale sottolineare...", "In conclusione..."*).
   - Privilegia definizioni asciutte, spiegazioni logico-causali dirette, elenchi ben strutturati e frammenti di codice pertinenti. Il risultato finale deve sembrare un'eccellente nota di studio rielaborata da una persona reale.

8. NAVIGAZIONE:
   Concludi sempre la nota con la sezione:
   ---
   ## ⏭️ Navigazione Lezioni
   - **Index Corso :** [[00_Index_{{NOME_CORSO}}]]

VINCOLO DI OUTPUT:
Restituisci SOLO ED ESCLUSIVAMENTE il blocco di codice Markdown contenente la nota formattata (racchiusa tra ```markdown e ```), senza premesse, saluti o commenti discorsivi prima o dopo.

---

DATI DELLA NOTA:
- Materia: [INSERISCI MATERIA, es. Sistemi Operativi, Diritto dell'Informatica, Linguaggi Formali, Programmazione Web]
- Data: [INSERISCI DATA, es. YYYY-MM-DD o oggi]
- Index File: [es. 00_Index_OS, 00_Index_Diritto, 00_Index_Linguaggi_Formali, 00_Index_Programmazione_Web]

MATERIALE DIDATTICO / SLIDE / DISPENSE:
[INCOLLA O ALLEGA QUI IL TESTO DELLE SLIDE / PDF / DISPENSE]
```

---

## 📚 Modelli di Riferimento per Materia

### A. Materie Informatiche / Ingegneristiche (Sistemi Operativi, Software Eng, Reti, Programmazione)
```markdown
---
date: 2026-03-04
tags:
  - sistemi-operativi
type: lezione
---
# Architettura del Sistema di Elaborazione

## 1. Unità Centrale (CPU) e Componenti
L'unità centrale (CPU) è il componente primario che governa l'esecuzione delle istruzioni all'interno del sistema di elaborazione. È suddivisa strutturalmente in:
* **ALU (Arithmetic Logic Unit):** Esegue le operazioni aritmetiche e logiche fondamentali.
* **Control Unit (CU):** Decodifica le istruzioni e genera i segnali di controllo per gli altri componenti.
* **Registri:** Memorie ad accesso immediato utilizzate per mantenere lo stato di esecuzione e gli operandi correnti.

> [!IMPORTANT] Principio di Von Neumann
> L'architettura prevede che sia i dati sia le istruzioni di programma risiedano nel medesimo spazio di memoria principale (*Store Program Concept*).

> [!INFO] Memoria Cache
> Memoria ad altissima velocità e bassa latenza interposta tra CPU e RAM per ridurre i tempi medi di accesso ai dati sfruttando i principi di località spaziale e temporale.

### Ciclo Fetch-Execute
Il comportamento ciclico del processore può essere formalizzato tramite la seguente sequenza di fetch, decodifica ed esecuzione:
```c
// Modello logico del ciclo istruzione della CPU
while (running) {
    Instruction instr = fetch();
    decode(instr);
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

## I. Architettura di un Compilatore
Un compilatore moderno è strutturato secondo una pipeline sequenziale divisa in *Front-End* (indipendente dalla macchina target) e *Back-End* (target-dependent).

* **Grammatica formale:** $G = (V, \Sigma, R, S)$
* **Funzione di transizione:** $\delta: Q \times \Sigma \rightarrow Q$

> [!IMPORTANT] Definizione Formale di Automa a Stati Finiti Deterministico (DFA)
> Un DFA è una 5-tupla $M = (Q, \Sigma, \delta, q_0, F)$ dove $\delta$ è una funzione totale $Q \times \Sigma \rightarrow Q$.

> [!EXAMPLE] Albero Sintattico (AST)
> Per l'espressione aritmetica `position = initial + rate * 60`, il parser genera nodi operatore con figli operandi, garantendo la corretta precedenza degli operatori.

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

## I. Teoria Generale delle Fonti del Diritto
L'**Ordinamento Giuridico** rappresenta l'insieme ordinato e coerente delle norme che regolano una comunità, gerarchicamente subordinate alla **Costituzione della Repubblica Italiana**.

> [!LAW] Principio di Abrogazione (Art. 15 Preleggi)
> Le leggi non sono abrogate che da leggi posteriori per dichiarazione espressa del legislatore, o per incompatibilità tra le nuove disposizioni e le precedenti, o perché la nuova legge regola l'intera materia già regolata dalla legge anteriore (*lex posterior derogat priori*).

> [!IMPORTANT] Riserva di Legge
> Istituto con cui la Costituzione impone che una determinata materia (es. limitazione delle libertà personali o protezione dati) sia disciplinata esclusivamente da una norma primaria avente forza di legge.

---
## ⏭️ Navigazione Lezioni
- **Index Corso :** [[00_Index_Diritto]]
```
