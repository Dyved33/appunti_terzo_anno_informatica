---
description: Fa revisionare una nota (correttezza, completezza, verbosità) e applica le correzioni. Con "solo report" non modifica nulla
agent: appunti
---

Rivedi: $ARGUMENTS

- Se l'argomento è una nota o una cartella, lavora su quelle note. Se è `diff`, lavora sulle note modificate secondo `git status` e `git diff`. Se è vuoto, chiedi cosa rivedere.
- Se sono più note, lavora una nota alla volta e fermati dopo ognuna con il riepilogo, chiedendo se continuare con la successiva.

Procedimento:

1. Salva la copia della nota: `python3 .opencode/scripts/controlla-perdite.py "nota" --salva`. Poi chiama il subagent `revisore` sulla nota e sul materiale del docente che trovi nella stessa cartella.
2. Se negli argomenti c'è `solo report`, fermati qui e riporta il suo elenco senza modificare nulla.
3. Altrimenti applica le correzioni: prima gli `[ERRORE]` e i `[MANCA]`, poi i `[TAGLIA]` e gli `[STILE]`. Asciuga secondo il tuo caso D: si tolgono parole, mai informazioni. Se manca, aggiungi la sintesi finale.
4. Esegui `python3 .opencode/scripts/controlla-perdite.py "nota"`. Per ogni voce segnalata rileggi la copia salvata: se l'informazione nella nota manca, rimettila.
5. Esegui `python3 .opencode/scripts/vault-audit.py` sulla nota e sistema ciò che dipende da te.
6. Riepilogo in 5 righe al massimo: parole prima e dopo, cosa hai tolto e perché, esito del controllo perdite.
