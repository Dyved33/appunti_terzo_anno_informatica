---
name: no-ai-slop
description: Divieto di parole e formule da stile IA nella scrittura delle note
license: MIT
compatibility: opencode
metadata:
  audience: scrittura-note
  workflow: scrivi-rivedi
---

# no-ai-slop — niente testo di riempimento

## Parole vietate (mai usare)

delve, foster, leverage, utilize, facilitate, empower, streamline,
robust, cutting-edge, paradigm shift, game changer, tapestry, realm, beacon, multifaceted,
meticulous, intricate, paramount, transformative, elevate, embark, supercharge, harness,
ever-evolving.

## Formule vuote (tagliare)

"è importante notare", "vale la pena notare", "in conclusione",
"in sintesi", "in today's world", "at its core", "the reality is", "in termini di",
"per quanto riguarda", "vedremo come", "gli esperti concordano", "gli studi suggeriscono"
→ nomina la fonte o taglia.

## Pattern da eliminare

- frasi a rivelazione: "La parte che funziona: ..." → scrivila come frase semplice
- contrasti binari: "Non è X, è Y" → "È Y"
- elenchi negativi: "Non è X. Non è Y. È Z" → "È Z"
- puffiness: "pivotal", "vital", "crucial", "game changer", "serves as a" → fatti concreti
- meta-discorso: "è il punto chiave", "come vedremo", "vale la pena ricordare" → taglia
- riepiloghi finali se il testo è già completo

## Regole positive

- verbi attivi
- una frase = un punto
- nomi, numeri, meccanismi invece di astratti
- niente sinonimi ciclici
- niente frasi spezzate a raffica
- non ripetere la stessa informazione con parole diverse
- se un contenuto non è sicuro: `[!todo]`, non inventare
