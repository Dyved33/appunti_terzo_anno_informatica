---
name: note-sintesi
description: Sintesi finale densa e obbligatoria per ogni nota; niente introduzioni né chiusure
license: MIT
compatibility: opencode
metadata:
  audience: scrittura-note
  workflow: scrivi-rivedi
---

# note-sintesi — densità e sintesi delle note

## Obbligatorio in fondo a ogni nota

La nota si chiude sempre con un callout `> [!info] Sintesi:` di 3-6 punti, una riga ciascuno, con ciò che della lezione va ricordato. È l'ultima cosa della nota e ce n'è una sola. Niente frasi nuove, niente formule lunghe, niente ripetizioni di ciò che è già detto sopra.

## Cosa non scrivere

- Introduzioni: "In questa lezione vedremo", "Qui parliamo di", "Introduzione a".
- Chiusure: "In conclusione", "In sintesi", "Riassumendo", "Come abbiamo visto", "Abbiamo visto che".
- Sezioni "Concetti chiave", "Riepilogo", "Riassunto".
- La stessa informazione detta due volte con parole diverse (sinonimi ciclici).
- Elenchi in cui ogni punto è "**Etichetta:** frase generica".

## Come scrivere

- Un'idea per paragrafo, frase breve, verbi attivi.
- Nomi, numeri, meccanismi concreti invece di astratti.
- Se un contenuto non è sicuro: `[!todo]`, non inventare.
- Il callout `> [!info] Sintesi:` non ripete il testo che lo precede: contiene solo i punti chiave da ricordare per l'esame.

## Verifica

Applica anche la skill `note-quality` prima di chiudere: il callout di sintesi va presente, senza frontmatter, senza tag, senza date nel nome del file né nella nota.
