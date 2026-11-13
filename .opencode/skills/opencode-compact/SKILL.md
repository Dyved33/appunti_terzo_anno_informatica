---
name: opencode-compact
description: Compressione semantica di testo lungo, appunti o trascrizioni senza perdita informativa
license: MIT
compatibility: opencode
metadata:
  audience: scrittura-note
  workflow: ottimizzazione-token
---

# opencode-compact — Compressione e Ottimizzazione Contesto

Usa questa skill quando devi elaborare testi molto lunghi, appunti grezzi, trascrizioni o contesti estesi prima di inserirli o sintetizzarli, al fine di ridurre l'uso di token e massimizzare la chiarezza.

## Obiettivi
1. Ridurre il volume di testo dal 30% al 60% eliminando ridondanze sintattiche.
2. Preservare al 100% l'accuratezza tecnica: termini, formule, comandi, elenchi, definizioni e dati numerici.

## Regole di Compressione
- **No chiacchiere introduttive/conclusive:** Rimuovere qualsiasi convenevole ("In questa sezione...", "Come detto in precedenza...").
- **Elimina proposizioni subordinate inutili:** Trasforma periodi complessi in elenchi puntati con frasi telegrafiche (Soggetto - Azione/Proprietà).
- **Densità informativa:** Se un concetto è ripetuto più volte con perifrasi diverse, unificalo in un unico punto sintetico.
- **Formattazione telegrafica:** Usa grassetti sui termini operativi e frecce concettuali (`→`) per causazione o transizioni logiche.
