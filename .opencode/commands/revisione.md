---
description: Controllo strutturale di una nota, di un corso o di tutto il vault (link, immagini, LaTeX, callout, segnaposto, todo). Non modifica nulla
---

Questo è il risultato del controllo strutturale su: $ARGUMENTS (se vuoto, tutto il vault).

!`python3 .opencode/scripts/vault-audit.py $ARGUMENTS`

Non modificare nessun file. Riporta il risultato così:

1. Gli ERROR, raggruppati per file, con la riga.
2. I WARN, raggruppati per tipo, con quante volte compaiono e in quali file.
3. Gli INFO in una riga sola: quanti todo aperti e quanti paragrafi lunghi.

Chiudi dicendo quali problemi puoi sistemare tu se l'utente te lo chiede e quali richiedono lui (per esempio le immagini mancanti).
