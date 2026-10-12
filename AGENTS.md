# AGENTS.md

Vault Obsidian di appunti universitari. Una nota = una lezione.

## Struttura

```
libri/                         libri di testo, un PDF per corso (input)
Primo semestre/
  <Corso>/                     un corso (o <Corso>/<Modulo>/ se il corso ha più moduli)
    00 Indice - <Corso>.md     indice: una riga per lezione, con titolo
    Titolo.md                  una nota per lezione, creata dall'utente
    *.txt                      appunti grezzi, uno per lezione (input)
    *.pdf, *.ppt, *.pptx       materiale del docente (input)
    images/                    immagini delle note (input)
    esercizi/                  codice scritto dall'utente (input), anche in sottocartelle
```

## Regole che valgono sempre

1. **Stile.** Le regole di scrittura sono in `.opencode/stile.md`. OpenCode le carica da solo; con altri strumenti leggile prima di scrivere.
2. **Non si perde nulla.** Ogni informazione che sta negli appunti dell'utente, negli appunti grezzi o nel materiale del docente deve stare nella nota finale: all'esame va riportato ciò che ha detto il docente. Puoi sistemare lo stile, riordinare, correggere e aggiungere. Puoi togliere solo parole: riempitivi e ripetizioni della stessa informazione. Nel dubbio, tieni.
3. **Il testo dell'utente comanda.** In una nota esistente modifica solo ciò che è sbagliato, poco chiaro, mancante o indicato da un segnaposto. Non riscrivere ciò che funziona.
4. **Non creare file.** Le note delle lezioni le crea l'utente, tu le riempi: né note né codice. Unica eccezione l'indice del corso, se manca, e le foto delle slide che l'utente ha chiesto (tabella Strumenti). Se ti chiedono di scrivere un esercizio, il codice va nella risposta, in un blocco con l'etichetta del linguaggio, con il percorso `esercizi/` in cui salvarlo: tu non aprire quei file in scrittura.
5. **Gli input non si toccano.** Mai modificare, rinominare, spostare o cancellare `.txt`, PDF, slide, immagini, i libri in `libri/` e i file in `esercizi/`.
6. **Niente frontmatter e niente tag.**
7. **Fonti.** Prima il materiale del docente, poi il web per completare. Se si contraddicono vale il docente e lasci un `[!todo]`.
8. **Git in sola lettura.** Commit e push li fa l'utente.
9. **Riepilogo finale.** Chiudi ogni lavoro con al massimo 5 righe: file toccati, cosa hai aggiunto, corretto e tolto, `[!todo]` lasciati.
10. **Stop sui cicli.** Se la stessa azione fallisce dopo due tentativi equivalenti (anche con input diverso) o non porta progressi o dopo un timeout, fermati e chiedi all'utente invece di riprovare. Un altro tentativo aggiunge costo, non certezza. Niente tesseract in parallelo.
11. **Libri di testo.** I libri stanno in `libri/<Nome corso>.pdf`, uno per corso, e si leggono con `python3 .opencode/scripts/libri.py` (command `/libro`). Una nota è completa senza il libro: è un complemento, non una fonte di default. Non prendere nulla dal libro senza il consenso dell'utente: a lezione conclusa chiedi una volta, con il tool `question`, se integrarlo come complemento; se dice no, il libro resta fuori. Quando lo usi valgono la regola 2 e la regola 7.

## Strumenti

| Cosa | Come |
|---|---|
| Leggere slide e PDF | `python3 .opencode/scripts/leggi-slide.py FILE [pagine]` (le pagine immagine vengono lette con Docling/OCR) |
| Leggere un libro di testo | `python3 .opencode/scripts/libri.py` con `elenco`, `info FILE`, `indice FILE`, `pagina FILE 28`, `cerca FILE "testo"` (command `/libro`) |
| Cercare una lezione per argomento | server MCP `obsidian-search` (tool `search`), oppure `python3 .opencode/scripts/vault-audit.py` per la struttura |
| Foto di una slide | chiedi all'utente se farla (`pdftoppm*` chiede conferma); se sì: `pdftoppm -png -r 150 -f N -l N "FILE" "images/slide"` e leggi la descrizione con `tesseract "images/slide-NN.png" stdout -l it`; se no: vai oltre |
| Controllo strutturale | `python3 .opencode/scripts/vault-audit.py [percorso]` |
| Controllo che non si sia perso nulla | `python3 .opencode/scripts/controlla-perdite.py NOTA [--salva] [--con FONTE]` |
| Dividere un file unico in lezioni | `python3 .opencode/scripts/dividi-appunti.py FILE` |
| Scrivere e integrare note | agent `appunti` |
| Verifica di correttezza e stile | agent `revisore`: non modifica nulla, una passata a lezione conclusa |
