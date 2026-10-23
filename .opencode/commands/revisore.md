---
description: Lancia il revisore su una nota (correttezza, completezza, verbosità) senza modificare nulla. Skill richiamabile, report-only
agent: revisore
---

Rivedi: $ARGUMENTS

- Il primo argomento è la nota. Gli eventuali altri percorsi sono il materiale del docente; se non ce ne sono, cercali nella stessa cartella.
- Il revisore non modifica nessun file: restituisce un elenco di correzioni, dal più grave al meno grave, una voce per riga: [ERRORE], [MANCA], [TAGLIA], [STILE], [FORMA].
- Chiudi con una riga di giudizio: `Nota corretta` / `Da correggere: N errori` e la stima di quanto è tagliabile.
- Non applicare le correzioni: spetta all'utente farlo, o tramite /rivedi, o chiedendo all'agent appunti.
