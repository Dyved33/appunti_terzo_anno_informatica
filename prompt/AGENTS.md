# AGENTS.md

Vault Obsidian di appunti universitari. Una nota = una lezione.

## Struttura

```
Primo semestre/
  <Corso>/                     un corso (o <Corso>/<Modulo>/ se il corso ha più moduli)
    00 Indice - <Corso>.md     indice: una riga per lezione, con data e titolo
    AAAA-MM-GG Titolo.md       una nota per lezione, creata dall'utente
    *.txt                      appunti grezzi, uno per lezione (input)
    *.pdf, *.ppt, *.pptx       materiale del docente (input)
    images/                    immagini delle note (input)
```

## Regole che valgono sempre

1. **Stile.** Le regole di scrittura sono in `.opencode/stile.md`. OpenCode le carica da solo; con altri strumenti leggile prima di scrivere.
2. **Non si perde nulla.** Ogni informazione che sta negli appunti dell'utente, negli appunti grezzi o nel materiale del docente deve stare nella nota finale: all'esame va riportato ciò che ha detto il docente. Puoi sistemare lo stile, riordinare, correggere e aggiungere. Puoi togliere solo parole: riempitivi e ripetizioni della stessa informazione. Nel dubbio, tieni.
3. **Il testo dell'utente comanda.** In una nota esistente modifica solo ciò che è sbagliato, poco chiaro, mancante o indicato da un segnaposto. Non riscrivere ciò che funziona.
4. **Non creare file.** Le note delle lezioni le crea l'utente, tu le riempi. Puoi creare solo l'indice del corso, se manca.
5. **Gli input non si toccano.** Mai modificare, rinominare, spostare o cancellare `.txt`, PDF, slide e immagini.
6. **Niente frontmatter e niente tag.** La data sta solo nel nome del file.
7. **Fonti.** Prima il materiale del docente, poi il web per completare. Se si contraddicono vale il docente e lasci un `[!todo]`.
8. **Git in sola lettura.** Commit e push li fa l'utente.
9. **Riepilogo finale.** Chiudi ogni lavoro con al massimo 5 righe: file toccati, cosa hai aggiunto, corretto e tolto, `[!todo]` lasciati.

## Strumenti

| Cosa | Come |
|---|---|
| Leggere slide e PDF | `python3 .opencode/scripts/leggi-slide.py FILE [pagine]` |
| Controllo strutturale | `python3 .opencode/scripts/vault-audit.py [percorso]` |
| Controllo che non si sia perso nulla | `python3 .opencode/scripts/controlla-perdite.py NOTA [--salva] [--con FONTE]` |
| Dividere un file unico in lezioni | `python3 .opencode/scripts/dividi-appunti.py FILE` |
| Scrivere e integrare note | agent `appunti` |
| Verifica di correttezza e stile | agent `revisore`: non modifica nulla, una passata a lezione conclusa |
