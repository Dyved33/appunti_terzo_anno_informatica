# AGENTS.md - Istruzioni Operative per OpenCode

Vault Obsidian con appunti universitari di Informatica. Questo file e' il router: dichiara le invarianti valide ovunque nel vault e dice quale agent specializzato usare per ogni tipo di lavoro. I workflow dettagliati vivono in `.opencode/agent/`.

---

## Agent disponibili

| Agent | Serve per |
|---|---|
| `@vault` | default. Modifiche minori, wikilink, navigazione, instradamento. |
| `@lettore` | Estrazione di testo da PDF e slide, risoluzione dei placeholder `// slide N //`. Sola lettura. |
| `@appunti` | Appunti grezzi, bozze, trascrizioni con materiale del docente -> nota definitiva. |
| `@materiale` | Solo slide/PDF/dispense, senza appunti personali -> nota definitiva. |
| `@indici` | Manutenzione dei 19 `00_Index_*.md` e degli hub annuali. |
| `@revisore` | Audit del vault: frontmatter, tag, link, immagini, caratteri, fluff. Non modifica nulla. |

Command: `/lezione` (pipeline completa), `/revisione` (audit), `/slide N file.pdf` (lookup puntuale).

---

## Invarianti del vault

### Tag canonici

Ogni nota porta il tag gia in uso per il proprio corso. Non introdurre stili nuovi, non normalizzare i file esistenti.

| Cartella | Tag |
|---|---|
| `1° Anno/Analisi` | `Analisi` |
| `1° Anno/OOP` | `OOP` |
| `1° Anno/PRP` | `ProceduralProgramming` |
| `2° Anno/Algoritmi` | `Algoritmi` |
| `2° Anno/Diritto dell'Informatica e Data Protection` | `Diritto` |
| `2° Anno/Ingegneria Software` | `IngegneriaSoftware` |
| `2° Anno/Linguaggi Formali` | `linguaggi-formali` |
| `2° Anno/Sistemi Operativi` | `sistemi-operativi` + `teoriaSO` (mod_1_teoria) o `labSO` (mod_2_lab) |
| `3° Anno/Base di Dati` | `base-di-dati` |
| `3° Anno/Cybersec` | `sicurezza-informatica` |
| `3° Anno/Introduzione AI` | `intelligenza-artificiale` |
| `3° Anno/Programmazione Web` | `programmazione-web` |
| `3° Anno/Reti` | `reti` |
| `Erasmus_Spagna/*` | tag del corso in PascalCase + `Erasmus` |

Il nome della cartella e il tag possono divergere: `Cybersec` produce `sicurezza-informatica`, `PRP` produce `ProceduralProgramming`.

### Layout

- Note: `lezioni/`, oppure `mod_N/lezioni/`, `mod_N_teoria/lezioni/`, `mod_N_lab/lezioni/`.
- Materiale del docente: `materiale/`, con `professorale/`, `slide/`, `esami/`, `riassuntivo/`.
- Appunti grezzi e trascrizioni: `lezioni/raw_notes/` con nome `DD_MM_YY.txt`. Sono **input**: non modificarli mai.
- Allegati: cartella radice `attachments/`.

### Convenzioni sui file

- Numerazione note: `NN_Titolo_Case_Con_Underscore.md`, `NN` a due cifre, riparte per modulo.
- Frontmatter note: `date: YYYY-MM-DD`, `tags:` (un solo tag canonico), `type: lezione`.
- Frontmatter indici: **solo** `tags:`. Nessun `date`, nessun `type`.
- Navigazione note italiane 2°/3° anno: chiude con `## ⏭️ Navigazione Lezioni` e il link all'indice.
- Navigazione Erasmus e 1° anno: back-link `◀️ *Back to:*` in testa al file, senza footer.
- I tre nomi abbreviati `00_Index_OS`, `00_Index_Diritto`, `00_Index_Cybersecurity` sono intenzionali. Non correggerli.
- I file in `Erasmus_Spagna/` restano in inglese o spagnolo e senza prefisso `NN_`.

### Immagini

Tre layout disponibili, dalla specifica `prompts/div style.txt`: immagine affiancata al testo con flexbox, immagine centrata e ridimensionata, immagine con didascalia centrata. La sintassi `![[file.png]]` e `![[file.png|300]]` va bene per i casi semplici.

Prima di referenziare un'immagine, **verifica che il file esista**. La maggior parte dei PNG in `materiale/images/` non e` referenziata da nessuna nota, e la loro presenza non prova nulla.

### Caratteri e registro

Punteggiatura solo ASCII: niente trattini lunghi, virgolette intelligenti, ellissi, frecce o checkmark Unicode. Emoji ammessi solo dove sono convenzione di note (per esempio il footer di navigazione).

Italiano accademico, diretto, denso. Vietati "In questa guida esploreremo", "Nel dinamico panorama odierno", "In conclusione", e sezioni "Conclusioni" o "Concetti chiave" non richieste.

### Comandi git

Mai eseguire comandi git che scrivono. Solo `git status`, `git diff`, `git log`, `git show`, `git ls-files`, `git blame`. La cronologia e` gestita da Obsidian Git e dall'utente.

---

## Ambito

Il file `opencode.json` di progetto vieta ogni accesso fuori dal vault (`external_directory: deny`) e limita la scrittura ai soli file `.md`. Non tentare di aggirare questi limiti.
