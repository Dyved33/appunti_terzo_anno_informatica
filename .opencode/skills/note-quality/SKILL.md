---
name: note-quality
description: Checklist di qualità da applicare a ogni nota prima di chiudere il lavoro
license: MIT
compatibility: opencode
metadata:
  audience: scrittura-note
  workflow: scrivi-rivedi
---

# note-quality — checklist qualità note

Applica questa checklist a ogni nota prima di considerarla conclusa. Ogni voce va verificata contro il materiale del docente e gli appunti grezzi.

## Contenuto

- [ ] Tutte le definizioni del materiale sono presenti nella nota, con la notazione del docente.
- [ ] Tutti i teoremi, le proposizioni e i lemmi sono presenti, con enunciato completo.
- [ ] Tutte le formule del materiale sono riportate, senza conversioni o semplificazioni non autorizzate.
- [ ] Tutti gli algoritmi e i passaggi procedurale sono presenti, nell'ordine del docente.
- [ ] Tutti gli esempi del docente sono riportati (nessuno saltato per "secondario").
- [ ] Tutti i punti degli elenchi del materiale sono presenti.
- [ ] Tutti i numeri e i casi particolari del materiale sono presenti.
- [ ] Le osservazioni e le precisazioni fatte a voce dal docente sono riportate.

## Stile (stile.md + no-ai-slop + i-have-adhd)

- [ ] Non ci sono parole vietate da `no-ai-slop`.
- [ ] Non ci sono formule vuote da tagliare.
- [ ] Non ci sono introduzioni ("In questa lezione vedremo") o chiusure ("In conclusione").
- [ ] Non ci sono sezioni vietate: "Introduzione", "Conclusioni", "Concetti chiave", "Riepilogo", "Riassunto".
- [ ] I titoli non hanno Maiuscole Su Ogni Parola, non sono in grassetto, non hanno emoji, non sono numerati.
- [ ] C'è un solo titolo `#` in testa alla nota.
- [ ] I sotto-argomenti usano etichette in grassetto a inizio paragrafo, non titoli `###` a meno che non servano davvero.
- [ ] C'è `> [!info] Sintesi:` in fondo alla nota, con 3-6 punti, una riga ciascuno.
- [ ] Non c'è frontmatter `---`.
- [ ] Non ci sono tag `#`.
- [ ] Non c'è la data nel nome del file né nella nota.
- [ ] Le immagini hanno il layout corretto (`[[x.png]]`, `[[x.png|300]]`, testo sotto/lato).
- [ ] I wikilink puntano a note esistenti e usano il formato `[[Nome del file|testo]]`.
- [ ] Il codice che serve alla teoria resta nella nota; gli esercizi completi stanno in `esercizi/`.

## Segnaposto e todo

- [ ] Tutti i segnaposto `// ... //` sono risolti o sostituiti con `[!todo]`.
- [ ] Ogni `[!todo]` è concreto e dice cosa manca.
- [ ] I `[!todo]` aperti alla fine sono elencati nel riepilogo.

## Verifica automatica

- [ ] `python3 .opencode/scripts/vault-audit.py <nota>` → zero ERROR, zero WARN dipendenti da te.
- [ ] `python3 .opencode/scripts/controlla-perdite.py <nota>` → zero voci di perdita rispetto alle fonti.
