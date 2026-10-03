---
description: Divide un file unico di appunti in un file per lezione. Uso - /dividi "percorso/Appunti corso.md" (aggiungi --per-sezione per un file per sezione)
agent: appunti
---

Questo è il piano per dividere il file in una nota per lezione. Lo script non ha ancora scritto nulla:

!`python3 .opencode/scripts/dividi-appunti.py $ARGUMENTS`

Procedimento:

1. Mostra il piano così com'è e chiedi conferma. Le date vengono dai nomi delle immagini e sono indicative: segnala i file senza data e quelli con la data presa dalla sezione precedente.
2. Dopo la conferma esegui lo stesso comando con `--scrivi` in fondo. Il testo lo copia lo script: non riscrivere e non copiare tu le note.
3. Esegui `python3 .opencode/scripts/vault-audit.py --breve` sulla cartella e riporta solo i conteggi.
4. Non asciugare ora le note. Chiudi dicendo che il passo successivo è `/rivedi` su una nota alla volta, e che il file di partenza va archiviato o cancellato dall'utente.
