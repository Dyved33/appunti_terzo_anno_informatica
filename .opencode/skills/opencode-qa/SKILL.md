---
name: opencode-qa
description: Generazione di domande e risposte di autoverifica (Q&A) per la preparazione dell'esame
license: MIT
compatibility: opencode
metadata:
  audience: studio-esame
  workflow: revisione-approfondimento
---

# opencode-qa — Domande e Risposte di Verifica per l'Esame

Usa questa skill per generare blocchi di autoverifica (flashcard / Q&A) basati rigorosamente sul contenuto della lezione e sulle nozioni del docente.

## Quando si applica
- Durante la revisione finale di una lezione su richiesta o come sezione di autovalutazione.
- Per prepararsi a domande tipiche di prova orale o scritta.

## Struttura del Blocco Q&A
- Formula da 3 a 5 domande mirate sui nodi centrali della lezione (definizioni, differenze architetturali, passaggi chiave).
- Le risposte devono essere concise, precise e prive di riempitivi, puntando ai criteri di valutazione d'esame.
- Utilizza i callout Obsidian:
  ```markdown
  > [!question] Domanda d'esame: <Quesito>?
  > > [!check]- Risposta
  > > Spiegazione essenziale con parole chiave e riferimenti puntuali.
  ```
