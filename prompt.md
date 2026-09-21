# 📝 Obsidian Notes Transmutation Prompt & Agent Instructions

Questo file contiene le istruzioni e i prompt ottimizzati per trasformare appunti grezzi (file `.txt`, note veloci, trascrizioni) e materiale didattico (slide, PDF, dispense) in note Markdown per Obsidian perfettamente strutturate, coerenti con la convenzione del vault.

---

## 🤖 Istruzioni per Antigravity / AI Agent (Modalità Agente)

Se stai operando come agente autonomo (es. **Antigravity**) all'interno di questo repository, segui questo workflow quando ti viene chiesto di convertire o creare una nuova nota:

### 1. Rilevamento del Contesto e della Cartella
1. Identifica la materia/corso di riferimento (es. `2° Anno/Sistemi Operativi`, `2° Anno/Linguaggi Formali`, `2° Anno/Diritto dell'Informatica e Data Protection`, `Erasmus/...`, ecc.).
2. Esamina i file già presenti nella cartella del corso e controlla:
   - Il file indice del corso (es. `00_Index_<Materia>.md`).
   - La convenzione di numerazione e naming (es. `01_Nome_Argomento.md`, `02_...`).
   - I tag specifici usati abitualmente nel corso.

### 2. Elaborazione e Sintesi del Contenuto
1. **Fusione Note + Materiale**:
   - Mappa i riferimenti delle slide presenti negli appunti (es. slide di inizio/fine).
   - Usa il materiale ufficiale per correggere imprecisioni, completare definizioni o formule omesse e verificare la terminologia tecnica.
   - Preserva gli approfondimenti a voce del docente, esempi pratici ed eccezioni.
2. **Conversione dei Simboli Speciali (`//`)**:
   - Trasforma ogni annotazione contrassegnata da `//` o note a margine nel relativo **Callout Obsidian** (`> [!INFO]`, `> [!NOTE] Nota del Prof`, `> [!EXAMPLE]`, `> [!WARNING]`, `> [!LAW]`, `> [!IMPORTANT]`). Inseriscilo contestualmente subito dopo il paragrafo rilevante.
3. **Formule, Codice e Schemi**:
   - Usa blocchi LaTeX per formule matematiche/formali (`$formula$` inline o `$$...$$` per blocchi).
   - Usa blocchi di codice con sintassi evidenziata (es. ````c`, ````java`, ````python`, ````bash`).
   - Gestisci immagini con sintassi Obsidian `![[nome_immagine.png]]` collegate alla cartella `images/<Materia>/`.

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

1. FRONTMATTER YAML:
   Inizia la nota rigorosamente con il frontmatter YAML:
   ---
   date: {{DATA o YYYY-MM-DD}}
   tags:
     - {{materia}}
     - {{tag-argomento-specifico}}
     - lezione
   type: lezione
   ---

2. TITOLO E GERARCHIA:
   - Titolo H1 (#) chiaro, formale e sintetico dell'argomento.
   - Struttura gerarchica ordinata con numerazione logica per i capitoli (es. ## I. Introduzione, ## II. ..., oppure ## 1. ..., ## 2. ...) e sottosezioni con H3 (###).
   - Non creare sezioni riassuntive superflue ("Conclusioni", "Concetti chiave") a meno che non siano esplicitamente richieste o presenti nel testo originale.

3. SIMBOLO SPECIALI // E CALLOUT OBSIDIAN:
   Ogni volta che negli appunti trovi il simbolo "//" (o note a margine/precisazioni del docente a voce), trasformalo in un Callout Obsidian inserito CONTESTUALMENTE (subito sotto il concetto a cui si riferisce):
   - Approfondimenti generici/note: > [!INFO] o > [!NOTE] Nota del Prof
   - Esempi pratici: > [!EXAMPLE] Titolo Esempio
   - Concetti critici o definizioni chiave: > [!IMPORTANT]
   - Normative, articoli di legge o sanzioni: > [!LAW] o > [!WARNING]

4. CODICE, FORMULE E LINGUAGGIO TECNICO:
   - Formule matematiche, logiche e grammatiche formali in LaTeX ($...$ inline o $$...$$ a blocco).
   - Codice sorgente racchiuso in blocchi di codice specificando il linguaggio (es. ```c, ```java, ```bash).
   - Usa il grassetto per evidenziare definizioni e termini chiave.
   - Usa wikilink [[Nome Concetto]] per termini centrali suscettibili di avere una nota dedicata o per riferimenti interni.

5. FUSIONE CON MATERIALE UFFICIALE (se fornito):
   - Se indico slide/capitoli di riferimento, allinea la trattazione al materiale del docente.
   - Correggi imprecisioni ed errori presenti negli appunti usando le definizioni rigorose delle slide.
   - Integra i punti salienti del materiale ufficiale senza perdere esempi, metafore o spiegazioni a voce presenti negli appunti.

6. NAVIGAZIONE:
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
  - teoriaSO
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
  - compilatori
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
  - Diritto
  - Privacy
  - GDPR
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
