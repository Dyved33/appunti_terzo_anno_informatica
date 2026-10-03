# Risposta

Questa cartella ha la stessa forma della radice del vault: per installarla si copia il contenuto (compresa la cartella nascosta `.opencode/`) nella cartella generale degli appunti. `LEGGIMI.md` non serve nel vault.

```bash
cp -r risposta/.opencode risposta/AGENTS.md risposta/opencode.json risposta/Guida_Opencode.md risposta/prompt_chat.md /percorso/cartella/appunti/
```

Nel vault vanno poi eliminati: `prompt_appunti.md`, `prompt_materiale.md`, `div style.txt`, e le vecchie cartelle `.opencode/agent/` e `.opencode/command/` se esistono (ora sono `agents/` e `commands/`).

## Cosa c'è

| File | Sostituisce | Note |
|---|---|---|
| `AGENTS.md` | `AGENTS.md` | da 84 a 38 righe: struttura, 9 regole, strumenti |
| `.opencode/stile.md` | i due prompt e `div style.txt` | unica fonte per lo stile, caricata a ogni sessione |
| `.opencode/agents/appunti.md` | `vault`, `appunti`, `materiale`, `indici` | un solo agent che scrive |
| `.opencode/agents/revisore.md` | `revisore` | controlla correttezza e verbosità, non modifica |
| `.opencode/commands/` | i 4 command | `/lezione`, `/rivedi`, `/revisione`, `/slide`, più `/dividi` |
| `.opencode/scripts/vault-audit.py` | il vecchio script | riscritto: niente tag, frontmatter, indici annuali |
| `.opencode/scripts/leggi-slide.py` | l'agent `lettore` | legge PDF, PPTX e PPT una pagina alla volta |
| `.opencode/scripts/dividi-appunti.py` | nuovo | divide un file unico in una nota per lezione |
| `.opencode/scripts/controlla-perdite.py` | nuovo | verifica che nella nota non si sia perso nulla rispetto alla fonte |
| `opencode.json` | `opencode.json` | permessi aggiornati |
| `Guida_Opencode.md` | `Guida_Opencode.md` | riscritta sulla nuova struttura |
| `prompt_chat.md` | `prompt_appunti.md`, `prompt_materiale.md` | prompt brevi per Antigravity e chat web |

## Le scelte, e perché

**Lo stile è preso dalla seconda parte dei tuoi appunti, non dalla prima.** Le prime sezioni di entrambi i file ("Compilatori e interpreti", "Evoluzione hardware e multiprogrammazione") hanno Maiuscole Su Ogni Parola, `[!NOTE] Nota del Prof`, grassetto ovunque, titoli come "Il Motore dell'Infinito": è lo stile IA che vuoi evitare. Più avanti lo stile cambia: `*Definizione:*`, etichette `**Argomento:**` a inizio paragrafo, elenchi con `-`, glosse con ` = `, `<u>` per la frase chiave, callout in minuscolo. `stile.md` codifica questo secondo stile e mette il primo fra le cose da non fare. Non me l'hai né confermato né corretto: se ho letto male, è `stile.md` il file da cambiare.

**Niente di ciò che ha detto il docente si perde.** È la regola 2 di `AGENTS.md` e l'apertura di `stile.md`: l'agent sistema la forma, corregge e aggiunge; toglie solo parole. Nella prima versione la regola proteggeva solo alcune categorie (definizioni, teoremi, formule) e per le slide diceva "un esempio per concetto, salta le slide di contorno": lasciava al modello la scelta di cosa fosse secondario. Ora non la lascia più. In più c'è `controlla-perdite.py`: l'agent salva una copia prima di modificare e alla fine lo script elenca formule, codice, immagini, numeri, righe e pagine di slide che non ritrova. È un confronto di parole, quindi riduce il rischio ma non lo azzera: sulle note importanti resta utile guardare `git diff`.

**Due agent invece di sei.** Con un modello gratuito ogni subagent è una sessione nuova che deve rileggersi tutto. Ho tenuto la sola separazione che serve: chi scrive e chi controlla. Il revisore lavora in un contesto pulito, quindi non è influenzato da ciò che ha appena scritto l'altro. `vault`, `materiale` e `indici` sono diventati casi dentro `appunti`. `lettore` è diventato uno script.

**Il revisore passa una volta sola, a lezione conclusa.** Parte con `/lezione` e con `/rivedi`. Dopo una modifica qualsiasi l'agent aggiorna solo l'indice ed esegue il controllo strutturale.

**`/rivedi` modifica.** Fa revisionare e applica. Con `solo report` non tocca nulla. Regola fissa: non toglie mai definizioni, teoremi, dimostrazioni, formule, codice, esempi, immagini.

**La divisione dei vecchi file la fa uno script, non il modello.** Un modello che ricopia 180 KB di appunti in 20 file ne perde dei pezzi. `dividi-appunti.py` copia il testo identico; il modello interviene dopo, con `/rivedi`, una nota alla volta.

**`stile.md` è sempre caricato** (campo `instructions` di `opencode.json`): un modello debole a volte salta la lettura, e lo stile è proprio la parte che non deve saltare.

**Tolti:** tabella dei tag, anni e Erasmus, frontmatter, footer di navigazione, `raw_notes/`, `attachments/`, numerazione `NN_`, divieto dei caratteri non ASCII, callout `[!NOTE]` e `[!LAW]`, modelli di esempio dei vecchi prompt.

**Permessi.** L'agent non può modificare `AGENTS.md` né `.opencode/`. Tolti `find`, `head`, `tail`, `sed`, `unzip`, `file`. Chiedono conferma `pdftoppm` (crea immagini) e `dividi-appunti.py --scrivi` (crea note).

## Come ho applicato le tue risposte

| | Risposta | Dove |
|---|---|---|
| 1 | data solo nel nome del file | il titolo `#` non ha la data; l'audit segnala i file senza data nel nome; formato consigliato `2026-05-07 Automi a pila.md` |
| 2, 3 | indice e moduli | `00 Indice - <Corso>.md` in ogni cartella di corso o di modulo |
| 4 | un `.txt` per lezione | l'agent cerca il `.txt` con lo stesso nome o la stessa data della nota, altrimenti chiede |
| 5 | git da terminale | la guida usa `git diff` e `git restore` |
| 6 | dividere i file unici | script `dividi-appunti.py` e command `/dividi`, vedi sotto |
| 7 | `// adatta //` | sostituisce `// 400 //`: immagine a larghezza piena |
| 9 | immagini nei callout | restano `![[x.png|300]]` |
| 11 | `→` nelle formule | nessuna conversione, nessun controllo |
| 12 | solo `// ... //` | tolto `%% ... %%` ovunque |
| 13, 14 | trattino lungo, fonti web | solo INFO nell'audit; nessuna fonte citata |
| 15 | sintesi a fine lezione | ogni nota si chiude con `> [!info] Sintesi:` (3-6 punti); l'audit segnala se manca |
| 16 | lunghezza | nessun limite di righe: `stile.md` chiede densità (ogni concetto una volta, spiegazione proporzionata alla difficoltà, tagliare parole e non contenuti). L'audit non segnala la lunghezza della nota, solo i singoli paragrafi oltre le 150 parole, come INFO |
| 18, 20 | configurazione e creazione dei file | l'agent non modifica la configurazione e non crea note |
| 19 | revisore | una passata, solo con `/lezione` e `/rivedi` |

## Le tre cose che mi hai chiesto di verificare

**Il plugin `opencode-parser`** (versione 2.0.1, ho letto il sorgente nella cache di OpenCode). Aggiunge un tool `parse` che estrae il testo da PDF, Word, Excel, PowerPoint e, con l'OCR, dalle immagini. Non crea e non inserisce immagini nelle note. Due limiti: non sa restituire una pagina precisa (solo il documento dall'inizio), e con l'opzione `save` scrive un file `.md` accanto all'originale saltando i permessi di scrittura. Per questo l'agent lo usa solo per l'OCR di uno screenshot e mai con `save`; per slide e PDF resta `leggi-slide.py`.

**Il modello.** Nella tua installazione è selezionato Big Pickle (`opencode/big-pickle`), il modello gratuito di OpenCode: 200 mila token di contesto, solo testo. Il contesto basta per una lezione con le sue slide. Non vede le immagini: non può descrivere uno screenshot né decidere cosa scrivere a lato. Per questo il testo di `// sotto: //` e `// lato: //` lo scrivi tu.

**`<img src>` con le immagini in `images/`.** Non sono riuscito a verificarlo fino in fondo. Obsidian mostra i tag `<img>` con percorso relativo dalla versione 1.8.1 (gennaio 2025), ma il changelog non dice come risolve un nome senza cartella. I tuoi appunti usano già il solo nome, quindi ho lasciato così. La prova richiede dieci secondi: metti un'immagine in `images/`, scrivi `<img src="nome.png" width="300">` in una nota e guarda se compare. Se non compare, in `stile.md` va cambiata una riga (sezione Immagini: "In `src` va il solo nome del file") in "In `src` va `images/` seguito dal nome del file".

## Passare i vecchi appunti al nuovo formato

`/dividi "percorso/Appunti corso.md"` mostra il piano e scrive solo dopo la conferma. Lo script taglia sui titoli `###`, ricava la data di ogni sezione dal nome della sua prima immagine e unisce le sezioni consecutive con la stessa data. Sui tuoi due file il piano è questo:

- **SO:** 23 sezioni diventano 14 note. Una senza data ("Evoluzione hardware e multiprogrammazione").
- **Linguaggi:** 26 sezioni diventano 23 note. Le prime 6 sezioni non hanno immagini e restano senza data, ognuna in un file suo: sono corte (da 8 a 105 righe), conviene unirle a mano in una o due lezioni.

Le date sono quelle degli screenshot, quindi indicative: in Linguaggi alcune sono fuori ordine (per esempio "Analisi lessicale" 11/04 prima di "Grammatiche regolari" 09/04). Si correggono rinominando il file da Obsidian. Poi `/rivedi` una nota alla volta: asciuga, aggiunge la sintesi e riporta le parole prima e dopo. Fai un commit prima di cominciare.

## Cosa ho verificato e cosa no

- `opencode debug config` e `opencode debug agent` sulla tua installazione (1.18.34): i 2 agent, i 5 command, i permessi e `instructions` vengono caricati come previsto.
- `vault-audit.py` sui tuoi due file e su un vault di prova con errori messi apposta: trova gli errori e non dà falsi allarmi su formule, tag e segnaposto.
- `leggi-slide.py` su un PDF, un PPTX e un PPT di prova.
- `controlla-perdite.py` su una tua lezione: tolte apposta sei cose (una riga di codice, un'immagine, un numero, tre righe di testo) le ha trovate tutte e sei, e non ha segnalato una frase riscritta con altre parole.
- `dividi-appunti.py` su entrambi i tuoi file, in una cartella temporanea: crea le note e l'indice, e si rifiuta di sovrascrivere.
- **Non ho provato una sessione vera con il modello.** Quanto bene Big Pickle segua `stile.md` si vede solo su una lezione reale. Se scrive ancora troppo, il punto da stringere è la sezione "Cosa non scrivere" di `stile.md`.
