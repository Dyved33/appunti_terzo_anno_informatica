---
description: Chiudi una nota: controllo perdite, struttura e revisore in un unico flusso. Report-only, non modifica nulla.
agent: appunti
---

Chiudi nota: $ARGUMENTS

- Il primo argomento è la nota da chiudere. Gli eventuali altri percorsi sono il materiale del docente; se non ce ne sono, cercali nella stessa cartella.
- Il command non modifica nessun file: restituisce un report unificato. Se vuoi applicare le correzioni, usa poi `/rivedi`.

Procedimento:

1. Salva la copia di sicurezza: `python3 .opencode/scripts/controlla-perdite.py "nota" --salva`
2. Esegui `python3 .opencode/scripts/controlla-perdite.py "nota"` e riporta le voci di perdita (formule, righe di codice, immagini, numeri, righe del materiale non ritrovate).
3. Esegui `python3 .opencode/scripts/vault-audit.py "nota" --breve` e riporta ERROR e WARN.
4. Chiama il subagent `revisore` sulla nota e sul materiale, e riporta il suo elenco [ERRORE], [MANCA], [TAGLIA], [STILE], [FORMA].
5. Chiudi con una riga di giudizio: `Nota corretta` / `Da correggere: N errori` / `Da completare: N perdite`, e indica se la nota è pronta per essere chiusa.
