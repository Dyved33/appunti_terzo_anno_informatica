# Guida a OpenCode in questo vault

## Avvio

OpenCode va avviato dalla cartella generale degli appunti, quella che contiene `opencode.json`:

```bash
cd percorso/della/cartella/appunti
opencode
```

Dopo ogni modifica a `opencode.json` o a un file in `.opencode/` va riavviato: la configurazione viene letta solo all'avvio.

## Come è organizzato

| File | A cosa serve |
|---|---|
| `AGENTS.md` | le poche regole che valgono sempre. Viene letto a ogni sessione |
| `.opencode/stile.md` | come vanno scritte le note. Viene caricato a ogni sessione |
| `.opencode/agents/` | i 2 agent |
| `.opencode/commands/` | i 5 command |
| `.opencode/scripts/` | i 4 script: lettura slide, controllo strutturale, controllo perdite, divisione dei file unici |
| `opencode.json` | permessi |
| `prompt_chat.md` | prompt da usare fuori da OpenCode (Antigravity, chat web) |

Per cambiare lo stile delle note si modifica solo `.opencode/stile.md`.

## Il flusso di una lezione

1. Crei tu la nota, con la data nel nome: `2026-10-02 Automi a pila.md`. Nella stessa cartella metti gli appunti grezzi (`.txt`, uno per lezione), le slide e, in `images/`, le immagini.
2. Scrivi nella nota quello che hai, con i segnaposto `// ... //` dove serve.
3. Durante il lavoro puoi chiedere modifiche a parole: l'agent scrive, aggiorna l'indice e controlla la struttura. Non chiama il revisore.
4. A lezione conclusa lanci `/lezione`: completa la nota, scrive la sintesi finale, fa passare il revisore una volta e applica le correzioni.

## Niente si perde

All'esame va riportato ciò che ha detto il docente, quindi la regola è: tutto ciò che sta nei tuoi appunti, negli appunti grezzi e nelle slide resta nella nota. L'agent può sistemare la forma, correggere e aggiungere; può togliere solo parole (riempitivi, la stessa informazione scritta due volte).

Una regola scritta però non è una garanzia, perché un modello può sbagliare. Per questo c'è un controllo fatto da uno script, non dal modello:

1. prima di modificare una nota l'agent ne salva una copia in `.opencode/originali/`;
2. alla fine `controlla-perdite.py` confronta la nota con la copia, con gli appunti grezzi e con le slide, ed elenca ciò che non ritrova: formule, righe di codice, immagini, numeri, righe di testo, pagine delle slide;
3. per ogni voce l'agent rilegge la fonte e rimette ciò che manca.

Lo script confronta parole, non significati: una frase riscritta bene può essere segnalata, e una frase stravolta mantenendo le stesse parole no. Le slide fatte di sole immagini non sono controllabili. Dopo `/rivedi` conviene quindi lanciarlo anche a mano, e guardare `git diff` sulle note importanti.

## Gli agent

| Agent | Cosa fa | Come si usa |
|---|---|---|
| `appunti` | scrive e modifica le note. È quello attivo all'avvio | basta scrivere la richiesta |
| `revisore` | controlla una nota (correttezza, completezza, verbosità) e restituisce l'elenco delle correzioni. Non modifica nulla | parte da solo con `/lezione` e `/rivedi`; a mano con `@revisore` |

## I command

**`/lezione`** chiude la nota di una lezione. Il primo percorso è la nota, gli altri sono appunti grezzi o materiale; se mancano li cerca nella stessa cartella.

```
/lezione "Primo semestre/Linguaggi/2026-10-02 Automi a pila.md"
/lezione "Primo semestre/Linguaggi/2026-10-02 Automi a pila.md" "Primo semestre/Linguaggi/automi.pdf"
```

Capisce da solo in quale caso si trova:
- la nota ha già del testo: la integra (segnaposto, errori, parti mancanti) senza riscriverla;
- la nota è vuota e c'è un `.txt`: la scrive dagli appunti grezzi;
- la nota è vuota e c'è solo il materiale: la scrive dalle slide.

**`/rivedi`** fa revisionare una nota e applica le correzioni: errori, parti mancanti, tagli. È il comando per asciugare le note verbose: toglie parole, non contenuti, e non ha un limite di lunghezza da raggiungere. Su una cartella lavora una nota alla volta e si ferma dopo ognuna.

```
/rivedi "Primo semestre/SO/2026-03-19 Semafori, Messaggi.md"
/rivedi "Primo semestre/SO/2026-03-19 Semafori, Messaggi.md" solo report     # non modifica nulla
/rivedi diff                                            # le note modificate e non ancora in un commit
```

**`/revisione`** esegue il controllo strutturale e ne riporta il risultato. Non modifica nulla.

```
/revisione                              # tutto il vault
/revisione "Primo semestre/Linguaggi"   # un corso
```

Trova: link rotti, immagini mancanti, formule e blocchi di codice non chiusi, `<div>` non bilanciati, callout sbagliati, segnaposto non risolti, lezioni che mancano nell'indice, nome del file senza data, sintesi finale mancante, frontmatter e tag, titoli fuori convenzione, frasi tipiche da IA, `[!todo]` aperti, paragrafi molto lunghi.

**`/slide`** mostra il testo di una pagina del materiale, per controllare con i propri occhi.

```
/slide "Primo semestre/Linguaggi/automi.pdf" 28
/slide "Primo semestre/Linguaggi/automi.pdf" 19-21
/slide "Primo semestre/Linguaggi/automi.pptx" --cerca "pila vuota"
```

**`/dividi`** divide un file unico di appunti in una nota per lezione. Serve una volta sola, per gli appunti scritti finora.

```
/dividi "Primo semestre/SO/Appunti teoria SO.md"
/dividi "Primo semestre/SO/Appunti teoria SO.md" --per-sezione
```

Mostra prima il piano e scrive solo dopo la tua conferma. Vedi sotto.

I percorsi con spazi vanno sempre tra virgolette.

## Passare i vecchi appunti al nuovo formato

1. `/dividi "percorso/Appunti corso.md"`. Lo script taglia il file sui titoli `###`, ricava la data di ogni sezione dal nome della sua prima immagine e mette nella stessa nota le sezioni consecutive con la stessa data. Il testo viene copiato identico, non passa dal modello.
2. Controlla il piano. Le date sono quelle degli screenshot, quindi indicative. Le prime sezioni di solito non hanno immagini e restano senza data: va aggiunta a mano al nome del file.
3. Conferma: crea le note e l'indice nella stessa cartella. Il file unico resta intatto: archivialo o cancellalo tu quando hai controllato.
4. Se una data o un titolo è sbagliato, rinomina il file da Obsidian: i link dell'indice si aggiornano da soli.
5. `/rivedi` su una nota alla volta. Ogni passata asciuga, aggiunge la sintesi finale e riporta le parole prima e dopo.

## Cosa scrivere nelle note

**Segnaposto.** Fuori dai blocchi di codice, `// ... //` è un'istruzione per l'agent, da eseguire in quel punto:

```
// slide 28 //                         riporta qui il contenuto della slide 28
// def automa a pila //                cerca la definizione nel materiale
// approfondire con un esempio //      qualsiasi altra richiesta
```

Il segnaposto sparisce quando è stato eseguito. Se l'agent non ci riesce lo sostituisce con un `[!todo]`.

**Immagini.** Dopo l'immagine si indica il layout:

```
![[x.png]]                        ridimensionata a 300
![[x.png]] // adatta //           adattata alla larghezza della pagina
![[x.png]] // sotto: testo //     con scritta sotto
![[x.png]] // lato: testo //      con testo a lato
![[x.png]] // lato //             a lato va il paragrafo che segue
```

Dentro un callout l'immagine resta `![[x.png|300]]`. Il modello non vede le immagini: il testo da mettere sotto o a lato lo scrivi tu.

**Todo.** `> [!todo] cosa va rivisto` segna un punto da controllare. L'agent prova a chiuderli a ogni passata e ne lascia di nuovi quando non è sicuro di qualcosa. `/revisione` li elenca tutti.

**Sintesi.** Ogni nota si chiude con `> [!info] Sintesi:`, da 3 a 6 punti. La scrive l'agent con `/lezione` e `/rivedi`.

## Cosa OpenCode può fare e cosa no

- Scrive solo file `.md`. Non può modificare `AGENTS.md` né i file in `.opencode/`.
- Non crea note: le crei tu e lui le riempie. Può creare solo l'indice del corso. L'unica eccezione è `/dividi`, che chiede conferma.
- Non tocca `.txt`, PDF, slide e immagini.
- Non esce dal vault.
- Nel terminale può eseguire solo i quattro script, `ls`, `grep`, `rg`, `wc`, `pdfinfo`, `pdftotext` e i comandi git di sola lettura. Per `pdftoppm` (che crea immagini) chiede conferma.
- Può cercare sul web.
- Non fa commit né push: restano a te.

## Gli script, anche a mano

```bash
python3 .opencode/scripts/leggi-slide.py FILE              # elenco delle pagine
python3 .opencode/scripts/leggi-slide.py FILE 28           # una pagina
python3 .opencode/scripts/leggi-slide.py FILE --cerca "x"  # dove compare x
python3 .opencode/scripts/vault-audit.py "Primo semestre/Linguaggi"
python3 .opencode/scripts/vault-audit.py --breve           # solo ERROR e WARN
python3 .opencode/scripts/controlla-perdite.py NOTA --salva       # copia prima di modificare
python3 .opencode/scripts/controlla-perdite.py NOTA               # cosa si è perso rispetto alla copia
python3 .opencode/scripts/controlla-perdite.py NOTA --con FONTE   # rispetto a un .txt o alle slide
python3 .opencode/scripts/dividi-appunti.py FILE           # piano di divisione
python3 .opencode/scripts/dividi-appunti.py FILE --scrivi  # crea le note
```

`leggi-slide.py` legge PDF, PPTX e PPT (i PPT li converte con LibreOffice in una cartella temporanea). Se un file è fatto di sole immagini lo dice: in quel caso il contenuto va letto a mano.

## Il plugin opencode-parser

Aggiunge il tool `parse`, che estrae il testo da PDF, Word, PowerPoint e, con l'OCR, dalle immagini. Non crea e non inserisce immagini. Qui serve per una cosa sola: leggere il testo dentro uno screenshot (`parse` con OCR in italiano). Per slide e PDF l'agent usa `leggi-slide.py`, perché `parse` restituisce il documento dall'inizio e non una pagina precisa.

## Quando qualcosa va storto

- **Agent o command non compaiono:** riavvia OpenCode.
- **OpenCode non parte per un errore di configurazione:** `OPENCODE_DISABLE_PROJECT_CONFIG=1 opencode`, correggi e riavvia. Per vedere la configurazione che OpenCode ha davvero caricato: `opencode debug config`.
- **L'agent ha scritto troppo o ha rovinato una nota:** `git diff` mostra cosa è cambiato, `git restore "percorso"` riporta la nota all'ultimo commit. Senza git, la versione di prima è in `.opencode/originali/`. Conviene fare un commit prima di `/rivedi` e di `/dividi`.
- **Un'immagine in un `<div>` non si vede:** controlla che il nome in `src` sia identico a quello del file. Se è giusto e non si vede lo stesso, vedi `LEGGIMI.md`.
- **Richieste vaghe:** "migliora la nota" produce una riscrittura a caso. Meglio "la sezione sui semafori è troppo lunga, asciugala" oppure un segnaposto nel punto giusto.
