# Prerequisiti

npm install -g opencode-ai@latest                             # per installare l'ultima versione di opencode
opencode plugin opencode-parser -g                            # per installare il parser che permette di scattare foto di documenti
sudo apt install tesseract-ocr tesseract-ocr-ita              # per installare il lettore di foto

opencode plugin @tarquinen/opencode-dcp@latest                # riduce i token potando output vecchi e chiamate duplicate
opencode plugin @plannotator/opencode@latest                  # revisione interattiva del piano, con annotazioni
opencode plugin @azumag/opencode-rate-limit-fallback          # fallback automatico su modello secondario in caso di rate limit (429)

# Ollama (ultima risorsa offline: gira sulla GPU NVIDIA GTX 1050, pochi secondi per risposta con i modelli piccoli)
ollama pull qwen2.5:3b                                        # modello bilanciato (~2 GB, entra nei 4 GB di VRAM)
ollama pull qwen2.5-coder:3b                                  # variante per il codice (~2 GB, entra nei 4 GB di VRAM)

# Collegare altri provider gratuiti: stampa il link di signup e chiede la key, uno alla volta
bash ~/.config/opencode/scripts/connect-free-providers.sh

pip install --user --break-system-packages docling "obsidian-mcp-search[server]" pypdf
                                                              # OCR delle slide immagine, ricerca semantica delle note, lettura dei libri

## Cosa c'è

| File | Sostituisce | Note |
|---|---|---|
| `AGENTS.md` | `AGENTS.md` | da 84 a 38 righe: struttura, 9 regole, strumenti |
| `.opencode/stile.md` | i due prompt e `div style.txt` | unica fonte per lo stile, caricata a ogni sessione |
| `.opencode/regole.md` | nuovo | sintesi di `no-ai-slop` e `i-have-adhd` in 530 token, caricata a ogni sessione |
| `.opencode/dcp.jsonc` | nuovo | taratura del plugin che pota il contesto |
| `~/.agents/skills/no-ai-slop/SKILL.md` | — | niente testo di riempimento: letta a ogni sessione che scrive |
| `~/.config/opencode/vendor/i-have-adhd/skills/i-have-adhd/SKILL.md` | — | impaginazione (un'idea per blocco, elenchi invece della prosa): letta a ogni sessione che scrive |
| `.opencode/agents/appunti.md` | `vault`, `appunti`, `materiale`, `indici` | un solo agent che scrive |
| `.opencode/agents/revisore.md` | `revisore` | controlla correttezza e verbosità, non modifica |
| `.opencode/commands/` | i 4 command | `/lezione`, `/rivedi`, `/revisione`, `/slide`, `/dividi`, `/libro` |
| `.opencode/scripts/vault-audit.py` | il vecchio script | riscritto: niente tag, frontmatter, indici annuali |
| `.opencode/scripts/leggi-slide.py` | l'agent `lettore` | legge PDF, PPTX e PPT una pagina alla volta; le pagine immagine con Docling e OCR Tesseract (ita) |
| `.opencode/scripts/libri.py` | nuovo | legge i libri di `libri/`: elenco, indice, pagina, ricerca |
| `.opencode/scripts/dividi-appunti.py` | nuovo | divide un file unico in una nota per lezione |
| `.opencode/scripts/controlla-perdite.py` | nuovo | verifica che nella nota non si sia perso nulla rispetto alla fonte |
| `opencode.json` | `opencode.json` | modelli free di default, catena di fallback, permessi shell, server MCP |
| `~/.config/opencode/rate-limit-fallback.json` | — | stessa catena di fallback, valida in ogni progetto |
| `~/.config/opencode/scripts/connect-free-providers.sh` | nuovo | collega in un colpo solo i provider gratuiti con key |
| `Guida_Opencode.md` | `Guida_Opencode.md` | riscritta sulla nuova struttura |
| `prompt_chat.md` | `prompt_appunti.md`, `prompt_materiale.md` | prompt brevi per Antigravity e chat web |

## I modelli: solo free, nessun server

Nessun modello a pagamento, nessun processo da tenere acceso.

| Ruolo | Modello | Perché |
|---|---|---|
| default | `opencode/nemotron-3-ultra-free` | il più disciplinato: 4 chiamate di strumento dove `minimax` ne fa 22, scrittura pulita, non scrive file se non richiesto |
| titolo sessione | `opencode/minimax-m3.1-flash-free` | 5 s, il più veloce |
| compattazione | `opencode/nemotron-3-ultra-free` | finestra da 1M token, riassume senza perdere i dettagli della nota |
| ultima risorsa | `ollama/qwen2.5:3b`, `ollama/qwen2.5-coder:3b` | offline e senza quota, gira sulla GPU GTX 1050 |

**Catena di fallback** (`rate-limit-fallback.json`, 9 modelli): su quota esaurita o errore transitorio l'agent passa al successivo, tenendo l'agente attivo, e torna indietro dopo il cooldown. L'ordine completo è nella guida; ogni modello è stato provato su quattro compiti prima di entrare nella catena, e chi ha fallito è stato tolto.

**Provider usati**: il free tier di OpenCode (45 modelli, nessuna key) e OpenRouter (modelli `:free`, una key). Gli altri provider gratuiti si collegano con `connect-free-providers.sh`; ogni key serve per un account separato, non c'è modo di aggirarlo.

**OmniRoute è in pausa.** Il plugin `@omniroute/opencode-plugin` (0.2.1) esporta la forma dei plugin di OpenCode 1.x (`{ id, server }`); OpenCode 2.x accetta solo `{ id, effect }` o `{ id, setup }` e rifiuta il caricamento con *"Plugin must export a default definition with an id and an effect or setup function"*. Il plugin è quindi incompatibile finché upstream non pubblica una 0.3.x, ed è stato tolto da `opencode.json`. Il pacchetto resta installato e il servizio `omniroute` non serve più: il suo archivio non contiene nessuna connessione a provider, quindi non darebbe modelli comunque.

## Token: dove vanno e come sono ridotti

Una richiesta porta con sé tutto il contesto statico, e quel blocco viene reinviato a ogni turno: è la spesa più invisibile.

| | Prima | Adesso |
|---|---|---|
| blocco statico in contesto (regole, stile, prompt agente) | ~11,9k token | ~6,8k token |
| richiesta completa misurata (blocco statico + schema dei tool) | 22.748 token di input | 19.049 token di input |
| sessione da 157 messaggi | 13M token processati | la cronologia viene potata a 120k |

Le leve usate:

- **`.opencode/regole.md`**: le due skill (`no-ai-slop`, `i-have-adhd`) costavano 4,5k token a ogni richiesta e a ogni subagente; ora in `instructions` c'è una sintesi di 530 token e i file completi restano da leggere solo quando si scrive una nota (il prompt dell'agente lo dice già).
- **DCP tarato** (`.opencode/dcp.jsonc`): pota anche nelle sessioni dei subagenti (`allowSubAgents`), lascia intatti gli ultimi 3 turni (`turnProtection`), e avvisa il modello prima che entri in un ciclo (`iterationNudgeThreshold` 10 invece di 15).
- **`compaction.keep.tokens: 30000`**: dopo la compattazione resta il contesto utile invece di ricominciare da zero.
- **Il modello più disciplinato**: i token crescono col numero di chiamate di strumento, e i modelli free non sono uguali (vedi la guida).

Non è stato fatto, per non perdere qualità: troncare gli output degli strumenti (`tool_output`), togliere `stile.md` dalle `instructions` (il DCP potrebbe comprimerlo via), rinunciare al server MCP `obsidian-search` o al plugin `parse`.

## Le scelte, e perché

**Lo stile è preso dai tuoi appunti** Le prime sezioni di entrambi i file ("Compilatori e interpreti", "Evoluzione hardware e multiprogrammazione") hanno Maiuscole Su Ogni Parola, `[!NOTE] Nota del Prof`, grassetto ovunque, titoli come "Il Motore dell'Infinito": è lo stile IA che vuoi evitare. Più avanti lo stile cambia: `*Definizione:*`, etichette `**Argomento:**` a inizio paragrafo, elenchi con `-`, glosse con ` = `, `<u>` per la frase chiave, callout in minuscolo. `stile.md` codifica questo secondo stile e mette il primo fra le cose da non fare. Non me l'hai né confermato né corretto: se ho letto male, è `stile.md` il file da cambiare.

**Niente di ciò che ha detto il docente si perde.** È la regola 2 di `AGENTS.md` e l'apertura di `stile.md`: l'agent sistema la forma, corregge e aggiunge; toglie solo parole. Nella prima versione la regola proteggeva solo alcune categorie (definizioni, teoremi, formule) e per le slide diceva "un esempio per concetto, salta le slide di contorno": lasciava al modello la scelta di cosa fosse secondario. Ora non la lascia più. In più c'è `controlla-perdite.py`: l'agent salva una copia prima di modificare e alla fine lo script elenca formule, codice, immagini, numeri, righe e pagine di slide che non ritrova. È un confronto di parole, quindi riduce il rischio ma non lo azzera: sulle note importanti resta utile guardare `git diff`.

**Due agent invece di sei.** Con un modello gratuito ogni subagent è una sessione nuova che deve rileggersi tutto. Ho tenuto la sola separazione che serve: chi scrive e chi controlla. Il revisore lavora in un contesto pulito, quindi non è influenzato da ciò che ha appena scritto l'altro. `vault`, `materiale` e `indici` sono diventati casi dentro `appunti`. `lettore` è diventato uno script.

**Il modello di default è il più disciplinato, non il più bravo.** I modelli free sono stati provati su quattro compiti (leggere un file e contare, scrivere ed eseguire Python, probabilità, documento da strutturare) e poi su due prove di comportamento. Risultati: `nemotron-3-ultra-free` risolve tutto e usa 4 strumenti dove `minimax-m3.1-flash-free` ne usa 22; nessuno dei due è andato in loop (zero chiamate identiche ripetute), ma `minimax` ha finito per scrivere dentro una nota vera quando gli era stato chiesto solo un testo, e aggiunge un "Riepilogo" finale; `deepseek-v4.1-flash-free` scrive bene ma cerca nelle cartelle sbagliate; `glm-5.3-flash-free` si contraddice; su OpenRouter `nemotron-3-super-120b:free` e `gemma-4-31b-it:free` hanno fallito tutti i compiti, `nemotron-3-ultra-550b:free` li risolve ma mette 12 minuti. Sul rispetto delle regole di scrittura sono tutti simili (zero parole vietate): sulla conformità alle regole ADHD solo `minimax` usa la lista numerata, e nessuno dei free inizia con l'azione. Da qui il default.

**La key OpenRouter era sbagliata.** In OpenCode era salvata la chiave locale di OmniRoute, non una chiave OpenRouter: le richieste finivano con un 401 "Missing Authentication header" e ogni modello OpenRouter era inutilizzabile. La chiave vera era già sulla macchina (`~/.aider/oauth-keys.env`) ed è stata ricollegata; le credenziali sbagliate sono state cancellate.

**Il revisore passa una volta sola, a lezione conclusa.** Parte con `/lezione` e con `/rivedi`. Dopo una modifica qualsiasi l'agent aggiorna solo l'indice ed esegue il controllo strutturale.

**`/rivedi` modifica.** Fa revisionare e applica. Con `solo report` non tocca nulla. Regola fissa: non toglie mai definizioni, teoremi, dimostrazioni, formule, codice, esempi, immagini.

**La divisione dei vecchi file la fa uno script, non il modello.** Un modello che ricopia 180 KB di appunti in 20 file ne perde dei pezzi. `dividi-appunti.py` copia il testo identico; il modello interviene dopo, con `/rivedi`, una nota alla volta.

**`stile.md` è sempre caricato** (campo `instructions` di `opencode.json`): un modello debole a volte salta la lettura, e lo stile è proprio la parte che non deve saltare.

**Le tre aggiunte.** *Libri:* i libri di `libri/<Nome corso>.pdf` si leggono con `libri.py` (elenco, sommario dai segnalibri, una pagina, ricerca) e col command `/libro`; restano un complemento, mai una fonte di default (regola 11). *Docling:* se un PDF non ha un livello di testo (pagine scansionate o slide esportate come immagini), `leggi-slide.py` lo legge da sé con Docling, che per l'OCR usa Tesseract in italiano e inglese; i modelli di layout si scaricano da HuggingFace in `~/.cache/huggingface` al primo uso, quindi la prima volta serve la rete; sui file lunghi salta, per non impiegare minuti, e lo segnala. *Ricerca semantica:* il server MCP `obsidian-search` indicizza le note di `primo semestre/` e le cerca per significato (modello multilingua `paraphrase-multilingual-MiniLM-L12-v2`, tenuto in `~/.cache/fastembed`), utile per ritrovare dove un argomento è trattato e per creare i wikilink. *Fallback & DCP:* `@tarquinen/opencode-dcp` ottimizza il contesto potando output ridondanti (tarato in `.opencode/dcp.jsonc`); `@azumag/opencode-rate-limit-fallback` evita blocchi passando in automatico a un modello secondario su quota esaurita (429), con catena di 9 modelli free. I modelli locali con Ollama sono l'ultima risorsa offline: su questa macchina c'è una GPU NVIDIA GTX 1050 (`nvidia-smi` funziona) e i modelli piccoli (`qwen2.5:3b`, `qwen2.5:1.5b`) rispondono in pochi secondi. I modelli 7b non entrano nei 4 GB di VRAM e restano su CPU, quindi non vanno usati per il titolo o per la compattazione.

**Le tre fonti di stile valgono per ogni modello.** `stile.md`, `no-ai-slop` e `i-have-adhd` sono le tre regole di scrittura del vault: la prima sta in `.opencode/stile.md`, le altre due in `~/.agents/skills/` e `~/.config/opencode/vendor/`. In `instructions` ci sono `stile.md` e `.opencode/regole.md` (la sintesi delle due skill): costavano 4,5k token a ogni richiesta e a ogni subagente, e i modelli free non sono i più attenti. Le versioni complete delle due skill le legge l'agente quando deve scrivere, perché gliele chiede il prompt; i file restano fuori dal vault, così l'agente non può modificarli (`edit` nega `.opencode/**`). `stile.md` resta sempre in contesto: è la parte che non deve saltare.

**Tolti:** tabella dei tag, anni e Erasmus, frontmatter, footer di navigazione, `raw_notes/`, `attachments/`, numerazione `NN_`, divieto dei caratteri non ASCII, callout `[!NOTE]` e `[!LAW]`, modelli di esempio dei vecchi prompt.

**`esercizi/` è tuo.** La cartella `esercizi/` di ogni corso contiene il codice scritto da te (`.py`, `.html`, `.sql`, sottocartelle per l'esame). È un input quanto le slide: l'agent la legge per collegarla dalle note ma non la modifica, e non esegue codice. Se gli chiedi un esercizio te lo dà nella risposta e lo salvi tu. `vault-audit.py` salta la cartella (i `.md` lì dentro non sono note) e `controlla-perdite.py` legge i file collegati dalla nota, così il codice spostato in `esercizi/` non risulta perso.

**Permessi.** Il blocco `permissions` di `opencode.json` rende tecnico ciò che `AGENTS.md` chiede: `edit` nega tutto tranne i `.md`, con diniego esplicito per `AGENTS.md`, `.opencode/**`, `*/esercizi/*` (dopo `*.md`, perché vinca l'ultima regola che combina), `opencode.json`, `CONFIG-CHANGES.md` e i due file di `prompt/`; `bash` è in allowlist (i cinque script, `ls`, `grep`, `rg`, `wc`, `pdfinfo`, `pdftotext`, `tesseract`, git in lettura); `external_directory` impedisce di uscire dal vault. Chiedono conferma `pdftoppm` e `dividi-appunti.py --scrivi`.

**Il bash non si blocca più a metà catena.** OpenCode controlla i permessi comando per comando, anche in una pipe: `script.py | head -40` valuta `script.py` *e* `head -40`, e se il secondo non è in allowlist la catena intera viene negata. Per questo in allowlist ci sono anche i destinatari delle pipe e gli operatori di una catena (`head`, `tail`, `cat`, `sort`, `uniq`, `cut`, `tr`, `jq`, `diff`, `basename`, `dirname`, `cd`, `pwd`, `which`, `echo`, `find`). Il prezzo è che questi programmi possono scrivere, quindi ci sono tre scudi, messi dopo perche valga l'ultima regola che combacia: `echo*>*` (niente file creati con una redirezione), `find* -delete*` e `find* -exec*` (niente cancellazioni né comandi arbitrari), `*env*` (niente `cat .env`, `printenv`). `sed`, `awk`, `tee`, `xargs` restano fuori: scrivono o eseguono, e gli input del vault non si toccano.

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
| 17 | compattazione | `auto` e `keep.tokens: 30000` in `opencode.json`; il potatura continua la fa il plugin DCP |

## Passare i vecchi appunti al nuovo formato (da file unico a file multipli)

Si noti che con un sistema multi-agentico è conveniente avere file più piccoli (garantisce anche un consistente risparmio di token) 

`/dividi "percorso/Appunti corso.md"` mostra il piano e scrive solo dopo la conferma. Lo script taglia sui titoli `###`, ricava la data di ogni sezione dal nome della sua prima immagine e unisce le sezioni consecutive con la stessa data. Sui tuoi due file il piano è questo:

- **SO:** 23 sezioni diventano 14 note. Una senza data ("Evoluzione hardware e multiprogrammazione").
- **Linguaggi:** 26 sezioni diventano 23 note. Le prime 6 sezioni non hanno immagini e restano senza data, ognuna in un file suo: sono corte (da 8 a 105 righe), conviene unirle a mano in una o due lezioni.

Le date sono quelle degli screenshot, quindi indicative: in Linguaggi alcune sono fuori ordine (per esempio "Analisi lessicale" 11/04 prima di "Grammatiche regolari" 09/04). Si correggono rinominando il file da Obsidian. Poi `/rivedi` una nota alla volta: asciuga, aggiunge la sintesi e riporta le parole prima e dopo. Fai un commit prima di cominciare.

