# Prerequisiti

npm install -g opencode-ai@latest                             #per installare l'ultima versione di opencode
opencode plugin opencode-parser -g                            #per installare il parser che permette di scattare foto di documenti
sudo apt install tesseract-ocr tesseract-ocr-ita              # per installare il lettore di foto

opencode plugin @franlol/opencode-md-table-formatter@latest   # riallinea le tabelle Markdown dopo ogni risposta
opencode plugin @tarquinen/opencode-dcp@latest                # riduce i token potando output vecchi e chiamate duplicate
opencode plugin @zenobius/opencode-skillful                   # carica le skill on-demand invece di tenerle tutte in contesto
opencode plugin @plannotator/opencode@latest                  # revisione interattiva del piano, con annotazioni
opencode plugin opencode-websearch-cited@1.2.0                # web search con citazioni; da tenere per ultimo nell'elenco plugin

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

**Lo stile è preso dai tuoi appunti** Le prime sezioni di entrambi i file ("Compilatori e interpreti", "Evoluzione hardware e multiprogrammazione") hanno Maiuscole Su Ogni Parola, `[!NOTE] Nota del Prof`, grassetto ovunque, titoli come "Il Motore dell'Infinito": è lo stile IA che vuoi evitare. Più avanti lo stile cambia: `*Definizione:*`, etichette `**Argomento:**` a inizio paragrafo, elenchi con `-`, glosse con ` = `, `<u>` per la frase chiave, callout in minuscolo. `stile.md` codifica questo secondo stile e mette il primo fra le cose da non fare. Non me l'hai né confermato né corretto: se ho letto male, è `stile.md` il file da cambiare.

**Niente di ciò che ha detto il docente si perde.** È la regola 2 di `AGENTS.md` e l'apertura di `stile.md`: l'agent sistema la forma, corregge e aggiunge; toglie solo parole. Nella prima versione la regola proteggeva solo alcune categorie (definizioni, teoremi, formule) e per le slide diceva "un esempio per concetto, salta le slide di contorno": lasciava al modello la scelta di cosa fosse secondario. Ora non la lascia più. In più c'è `controlla-perdite.py`: l'agent salva una copia prima di modificare e alla fine lo script elenca formule, codice, immagini, numeri, righe e pagine di slide che non ritrova. È un confronto di parole, quindi riduce il rischio ma non lo azzera: sulle note importanti resta utile guardare `git diff`.

**Due agent invece di sei.** Con un modello gratuito ogni subagent è una sessione nuova che deve rileggersi tutto. Ho tenuto la sola separazione che serve: chi scrive e chi controlla. Il revisore lavora in un contesto pulito, quindi non è influenzato da ciò che ha appena scritto l'altro. `vault`, `materiale` e `indici` sono diventati casi dentro `appunti`. `lettore` è diventato uno script.

**Il revisore passa una volta sola, a lezione conclusa.** Parte con `/lezione` e con `/rivedi`. Dopo una modifica qualsiasi l'agent aggiorna solo l'indice ed esegue il controllo strutturale.

**`/rivedi` modifica.** Fa revisionare e applica. Con `solo report` non tocca nulla. Regola fissa: non toglie mai definizioni, teoremi, dimostrazioni, formule, codice, esempi, immagini.

**La divisione dei vecchi file la fa uno script, non il modello.** Un modello che ricopia 180 KB di appunti in 20 file ne perde dei pezzi. `dividi-appunti.py` copia il testo identico; il modello interviene dopo, con `/rivedi`, una nota alla volta.

**`stile.md` è sempre caricato** (campo `instructions` di `opencode.json`): un modello debole a volte salta la lettura, e lo stile è proprio la parte che non deve saltare.

**Tolti:** tabella dei tag, anni e Erasmus, frontmatter, footer di navigazione, `raw_notes/`, `attachments/`, numerazione `NN_`, divieto dei caratteri non ASCII, callout `[!NOTE]` e `[!LAW]`, modelli di esempio dei vecchi prompt.

**`esercizi/` è tuo.** La cartella `esercizi/` di ogni corso contiene il codice scritto da te (`.py`, `.html`, `.sql`, sottocartelle per l'esame). È un input quanto le slide: l'agent la legge per collegarla dalle note ma non la modifica, e non esegue codice. Se gli chiedi un esercizio te lo dà nella risposta e lo salvi tu. `vault-audit.py` salta la cartella (i `.md` lì dentro non sono note) e `controlla-perdite.py` legge i file collegati dalla nota, così il codice spostato in `esercizi/` non risulta perso.

**Permessi.** L'agent non può modificare `AGENTS.md` né `.opencode/`, né nulla dentro `esercizi/` (`"*/esercizi/*": "deny"`, dopo `*.md` perché vinca l'ultima regola che combina). Tolti `find`, `head`, `tail`, `sed`, `unzip`, `file`. Chiedono conferma `pdftoppm` (crea immagini) e `dividi-appunti.py --scrivi` (crea note).

## Particolari implementativi

| 1 | niente data nella nota | il titolo `#` e il nome del file non hanno la data; nome consigliato `Lezione 3-Automi a pila.md` |
| 2 | indice e moduli | `00 Indice - <Corso>.md` in ogni cartella di corso o di modulo |
| 4 | un `.txt` per lezione | l'agent cerca il `.txt` con lo stesso nome o la stessa data della nota, altrimenti chiede |
| 5 | git da terminale | la guida usa `git diff` e `git restore` |
| 6 | dividere i file unici | script `dividi-appunti.py` e command `/dividi`, vedi sotto |
| 7 | `// adatta //` | sostituisce `// 400 //`: immagine a larghezza piena |
| 7b | layout di un'immagine senza segnaposto | l'agent fa una domanda `question` per ogni immagine (ridimensionata / adatta / scritta sotto / testo a lato / lascia com'è), testo dall'OCR se disponibile |
| 9 | immagini nei callout | restano `![[x.png|300]]` |
| 10 | `→` nelle formule | nessuna conversione, nessun controllo |
| 11 | solo `// ... //` | tolto `%% ... %%` ovunque |
| 12 | trattino lungo, fonti web | solo INFO nell'audit; nessuna fonte citata |
| 13 | sintesi a fine lezione | ogni nota si chiude con `> [!info] Sintesi:` (3-6 punti); l'audit segnala se manca |
| 14 | lunghezza | nessun limite di righe: `stile.md` chiede densità (ogni concetto una volta, spiegazione proporzionata alla difficoltà, tagliare parole e non contenuti). L'audit non segnala la lunghezza della nota, solo i singoli paragrafi oltre le 150 parole, come INFO |
| 15 | configurazione e creazione dei file | l'agent non modifica la configurazione e non crea note |
| 16 | revisore | una passata, solo con `/lezione` e `/rivedi` |

## Passare i vecchi appunti al nuovo formato (da file unico a file multipli)

Si noti che con un sistema multi-agentico è conveniente avere file più piccoli (garantisce anche un consistente risparmio di token) 

`/dividi "percorso/Appunti corso.md"` mostra il piano e scrive solo dopo la conferma. Lo script taglia sui titoli `###`, ricava la data di ogni sezione dal nome della sua prima immagine e unisce le sezioni consecutive con la stessa data. Sui tuoi due file il piano è questo:

- **SO:** 23 sezioni diventano 14 note. Una senza data ("Evoluzione hardware e multiprogrammazione").
- **Linguaggi:** 26 sezioni diventano 23 note. Le prime 6 sezioni non hanno immagini e restano senza data, ognuna in un file suo: sono corte (da 8 a 105 righe), conviene unirle a mano in una o due lezioni.

Le date sono quelle degli screenshot, quindi indicative: in Linguaggi alcune sono fuori ordine (per esempio "Analisi lessicale" 11/04 prima di "Grammatiche regolari" 09/04). Si correggono rinominando il file da Obsidian. Poi `/rivedi` una nota alla volta: asciuga, aggiunge la sintesi e riporta le parole prima e dopo. Fai un commit prima di cominciare.

