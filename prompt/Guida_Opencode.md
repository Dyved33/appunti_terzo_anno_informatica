# Guida a OpenCode in questo vault

## Avvio

OpenCode va avviato dalla cartella generale degli appunti, quella che contiene `opencode.json`:

```bash
cd percorso/della/cartella/appunti
opencode
```

OpenCode 2 rilegge automaticamente `opencode.json` e i file in `.opencode/` quando cambiano; se un agent, un command o un plugin non si aggiorna, usa `/reload` oppure riavvia.

## Come è organizzato

| File | A cosa serve |
|---|---|
| `AGENTS.md` | le poche regole che valgono sempre. Viene letto a ogni sessione |
| `.opencode/stile.md` | come vanno scritte le note. Viene caricato a ogni sessione |
| `.opencode/regole.md` | sintesi delle due skill di scrittura, caricata a ogni sessione |
| `.opencode/agents/` | `appunti` per scrittura e `revisore` selezionabile come primario o invocabile come subagent |
| `.opencode/plugins/free-model-router/` | abilita tutti i modelli gratuiti, disabilita quelli a pagamento e sceglie il default; non invia richieste di prova |
| `.opencode/commands/` | i 7 command |
| `.opencode/scripts/` | i 5 script: lettura slide, lettura libri, controllo strutturale, controllo perdite, divisione dei file unici |
| `.opencode/dcp.jsonc` | come il plugin DCP pota il contesto della sessione |
| `~/.config/opencode/rate-limit-fallback.json` | unica catena dei modelli di riserva, condivisa tra i progetti |
| `opencode.json` | modelli, plugin, permessi, server MCP e compattazione del contesto |
| `prompt_chat.md` | prompt da usare fuori da OpenCode (Antigravity, chat web) |
| `libri/` | i libri di testo, un PDF per corso (`libri/<Nome corso>.pdf`); si leggono con `libri.py` (command `/libro`); complemento, non fonte di default |
| `<Corso>/esercizi/` | il codice scritto da te (input): l'agent non lo tocca |
| `rollback/`, `.review/` | non sono note: i vecchi file monolitici e i lavori di revisione. Le ricerche vanno fatte in `primo semestre/` |

Per cambiare lo stile delle note si modifica solo `.opencode/stile.md`.

## I modelli

Non c'è un modello fisso in `opencode.json`: il plugin locale abilita tutti i modelli gratuiti del catalogo corrente e disabilita quelli a pagamento. La lista `preferred` in `.opencode/plugins/free-model-router/index.ts` serve solo a scegliere il default: non è più una whitelist. Il plugin non invia richieste di prova. Il catalogo non espone crediti residui o stato di salute in tempo reale: questi errori dipendono dal fallback.
I modelli free senza supporto ai tool restano visibili, ma non vengono scelti come default.

| Modello | A che cosa serve |
|---|---|
| `opencode/nemotron-3.5-super-vl-free` | default: scrive e rivede le note; supporta anche immagini e documenti |
| `opencode/nemotron-3-ultra-free` | seconda scelta, disciplinata nell'uso dei tool; compattazione del contesto |
| `opencode/glm-5.3-flash-free` | titolo della sessione e agent `plan`; modello flash, adatto ai compiti brevi |
| `openrouter/*:free` | 21 modelli OpenRouter `:free`, tutti visibili e selezionabili |
| `ollama/*` | 15 modelli locali, ultima risorsa offline e senza quota (GPU GTX 1050) |

Il free tier di OpenCode non chiede credenziali. OpenRouter ne chiede una (già salvata). Gli altri provider gratuiti si possono aggiungere con `bash ~/.config/opencode/scripts/connect-free-providers.sh`: per ogni provider il comando stampa il link per creare la key e poi la chiede.

I modelli gratuiti e i relativi limiti cambiano. Nemotron 3.5 Super VL Free è temporaneamente gratuito e il suo endpoint NVIDIA può registrare le richieste per migliorare i modelli: non inviare dati personali o riservati.

Il default vale per le nuove sessioni. Puoi cambiare modello con `/models` per la sessione corrente; il plugin riapplica il default alla successiva. Con tutti i free visibili puoi scegliere anche un modello fuori dalla catena di fallback.

## Skill native (caricate on-demand)

Le regole di scrittura sono divise su due livelli:

- **`.opencode/regole.md`** (530 token): sintesi operativa, caricata a ogni sessione nel contesto statico. Va letta e applicata sempre.
- **`.opencode/skills/`**: skill complete, caricate solo quando servono con il tool `skill`. Non pesano sul contesto statico.

| Skill | File | Quando si usa |
|---|---|---|
| `no-ai-slop` | `.opencode/skills/no-ai-slop/SKILL.md` | prima di scrivere o rivedere una nota, per evitare parole e formule da stile IA |
| `i-have-adhd` | `.opencode/skills/i-have-adhd/SKILL.md` | prima di scrivere o rivedere una nota, per l'impaginazione (un'idea per blocco, elenchi invece della prosa) |
| `note-quality` | `.opencode/skills/note-quality/SKILL.md` | prima di chiudere una nota, per verificare che nulla del docente sia perso e che lo stile sia corretto |

Le due skill già presenti in `~/.agents/skills/` e `~/.config/opencode/vendor/` restano valide come riferimento globale; quelle in `.opencode/skills/` sono la versione di progetto.

## Per-agent MCP tools

Il server MCP `obsidian-search` non è più globale: il suo schema tool viene inviato solo agli agenti che ne hanno bisogno (`appunti` e `revisore`). Negli altri turni il contesto statico è più leggero. Se un altro agente ha bisogno della ricerca semantica, chiedi di aggiungerlo alla sezione `agent` di `opencode.json`.

## Nuovi plugin

| Plugin | Scopo | Stato |
|---|---|---|
| `opencode-parser` | OCR e parsing di immagini e documenti | già installato |
| `@tarquinen/opencode-dcp` | Potatura del contesto e deduplica chiamate | già installato, tarato in `.opencode/dcp.jsonc` |
| `@plannotator/opencode` | Piano interattivo con Plannotator | già installato |
| `@azumag/opencode-rate-limit-fallback` | Fallback automatico su modello secondario | già installato, versione 2.1.1 |
Per installare un plugin mancante:

```bash
opencode plugin add <nome-plugin>
```

Poi riavvia OpenCode.

## Il fallback automatico

Per gli errori riconosciuti dal plugin (429, quota esaurita, errori transitori), la richiesta prova il modello successivo della catena. Quando finisce la catena si ferma, senza ripartire in ciclo (`fallbackMode: "stop"`). Un `504 Gateway Timeout` generico non è garantito che venga riconosciuto: il timeout limita l'attesa, ma non assicura il passaggio al fallback. La configurazione unica è `~/.config/opencode/rate-limit-fallback.json`; non creare copie nel vault:

```
opencode/nemotron-3.5-super-vl-free
opencode/nemotron-3-ultra-free
opencode/nemotron-3.5-lightning-free
opencode/deepseek-v4.1-flash-free
opencode/mimo-v2.6-flash-free
opencode/glm-5.3-flash-free
openrouter/thinkingmachines/inkling:free
openrouter/nvidia/nemotron-3-ultra-550b-a55b:free
openrouter/nvidia/nemotron-3-super-120b-a12b:free
openrouter/openrouter/free
ollama/qwen2.5:3b
```

Il passaggio conserva l'agente attivo, la sessione e il contesto e segue l'ordine statico qui sopra. Dopo un passaggio completo senza un modello utilizzabile, la richiesta si ferma: non riparte in ciclo e non resta in attesa fino a un'ora. I modelli scelti manualmente ma assenti dalla catena vengono ritentati sullo stesso modello dopo il cooldown (`otherModels: "wait"`, 30 secondi, con backoff crescente).

`openrouter/openrouter/free` è il router gratuito di OpenRouter: sceglie un modello gratuito compatibile solo dentro OpenRouter. La classifica del plugin è una preferenza curata, non una misura di qualità o quota corrente; i modelli locali sono in fondo perché possono essere più lenti. La catena è gestita dal plugin `@azumag/opencode-rate-limit-fallback@2.1.1`.

## Token e contesto

Ogni richiesta porta con sé il contesto statico (regole, stile, prompt dell'agente) e lo reinvia a ogni turno; la parte che cresce è la conversazione. I numeri di questo vault:

- contesto statico: ~6,8k token per richiesta (era ~11,9k: le due skill sono state sostituite da `.opencode/regole.md`, 530 token);
- una sessione lunga (157 messaggi) aveva processato 13M token: adesso il plugin DCP pota la cronologia sopra 120k token e lascia intatti gli ultimi 3 turni.

Regole pratiche:

1. **Una sessione per lezione.** La cronologia è la spesa principale: `/compact` o una sessione nuova taglia più di qualunque altra impostazione.
2. **Il modello più disciplinato è anche il più economico.** Il default fa 4 chiamate di strumento dove un altro ne fa 22: i token crescono con le chiamate.
3. **`title` e `compaction` usano modelli free dedicati.** Il titolo usa `glm-5.3-flash-free`, la compattazione `nemotron-3-ultra-free`. Ollama resta l'ultima risorsa: su questa macchina `qwen2.5:3b` risponde in pochi secondi con la GPU GTX 1050, ma i modelli locali sono più lenti dei free hosted.

## I cicli

Un ciclo è l'agente che ripete la stessa cosa e consuma token senza progredire. Tre difese:

- `doom_loop` è negato in `opencode.json`: dopo tre chiamate identiche OpenCode blocca la ripetizione;
- la regola 10 di `AGENTS.md` impone di fermarsi dopo due tentativi equivalenti e di chiedere, invece di riprovare;
- DCP avvisa il modello prima che il contesto si riempia (`iterationNudgeThreshold`), e deduplica le chiamate identiche già fatte.

Nella pratica i modelli free non sono andati in loop: zero chiamate identiche ripetute in tutti i test. Il problema reale è un altro: il modello che ripete una ricerca con parole diverse (per esempio il vecchio `minimax-m3.1-flash-free` faceva 22 chiamate per una ricerca che `nemotron` fa in 4; non è più nel catalogo) spende token senza aggiungere nulla. Se lo vedi, scegli il modello più disciplinato per quel task.

## Come si comportano i modelli free

Misurati sugli stessi compiti, i modelli free non sono intercambiabili:

| Modello | Strumenti usati | Qualità | A cosa fare attenzione |
|---|---|---|---|
| `opencode/nemotron-3-ultra-free` | 4 | buona, disciplinata | cerca bene, non inventa |
| `opencode/deepseek-v4.1-flash-free` | 9 | buona | cerca nelle cartelle sbagliate |
| `opencode/glm-5.3-flash-free` | 10 | discreta | si contraddice, ripete un path |
| `openrouter/thinkingmachines/inkling:free` | 4 | discreta | dice di aver fatto cose che non ha fatto |

`minimax-m3.1-flash-free` non è più nel catalogo: era usato nei primi test e resta citato solo come termine di paragone. I modelli aggiunti dopo (`nemotron-3.5-super-vl-free`, `nemotron-3.5-lightning-free`, i Nemotron free di OpenRouter) non hanno ancora una riga in questa tabella.

Una cosa da tenere presente quando scrivi le richieste: **se chiedi "scrivi il testo di X" a un modello free, può interpretarlo come "scrivi X nel file"**. Il default non lo fa, ma se succede: `git diff` e `git restore "percorso"` per annullare, come al solito.

## Il flusso di una lezione

1. Crei tu la nota nella cartella del corso (es. `Lezione 3-Automi a pila.md`). Nella stessa cartella metti gli appunti grezzi (`.txt`, uno per lezione), le slide e, in `images/`, le immagini.
2. Scrivi nella nota quello che hai, con i segnaposto `// ... //` dove serve.
3. Per pianificare senza modifiche seleziona `plan`: Plannotator mostra il piano e l'agente non può modificare le note. Dopo l'approvazione passa ad `appunti` per eseguire il lavoro. Per le richieste normali `appunti` non apre Plannotator.
4. A lezione conclusa lanci `/lezione`: completa la nota, ti chiede se integrare il libro di testo di `libri/` come complemento, scrive la sintesi finale, fa passare il revisore una volta e applica le correzioni.

## Niente si perde

La regola è la 2 di `AGENTS.md`: tutto ciò che sta nei tuoi appunti, negli appunti grezzi e nelle slide resta nella nota; l'agent toglie solo parole. Una regola scritta però non basta, perché un modello può sbagliare: per questo il controllo lo fa uno script.

1. prima di modificare una nota l'agent ne salva una copia in `.opencode/originali/`;
2. alla fine `controlla-perdite.py` confronta la nota con la copia, con gli appunti grezzi e con le slide, ed elenca ciò che non ritrova: formule, righe di codice, immagini, numeri, righe di testo, pagine delle slide. Anche il codice collegato da un wikilink (in `esercizi/`) conta come parte della nota;
3. per ogni voce l'agent rilegge la fonte e rimette ciò che manca.

Lo script confronta parole, non significati, e non controlla le slide fatte di sole immagini: dopo `/rivedi` conviene lanciarlo anche a mano e guardare `git diff` sulle note importanti.

## Gli agent

| Agent | Cosa fa | Come si usa |
|---|---|---|
| `appunti` | scrive e modifica le note. È quello attivo all'avvio | basta scrivere la richiesta |
| `revisore` | controlla una nota (correttezza, completezza, verbosità) e restituisce l'elenco delle correzioni. Non modifica nulla | primario selezionabile e subagent; parte con `/lezione`, oppure a mano con `@revisore` o `/revisore` |

## I command

**`/lezione`** chiude la nota di una lezione. Il primo percorso è la nota, gli altri sono appunti grezzi o materiale; se mancano li cerca nella stessa cartella.

```
/lezione "Primo semestre/Linguaggi/Lezione 3-Automi a pila.md"
/lezione "Primo semestre/Linguaggi/Lezione 3-Automi a pila.md" "Primo semestre/Linguaggi/automi.pdf"
```

Capisce da solo in quale caso si trova:
- la nota ha già del testo: la integra (segnaposto, errori, parti mancanti) senza riscriverla;
- la nota è vuota e c'è un `.txt`: la scrive dagli appunti grezzi;
- la nota è vuota e c'è solo il materiale: la scrive dalle slide.

**`/rivedi`** fa revisionare una nota e applica le correzioni: errori, parti mancanti, tagli. È il comando per asciugare le note verbose: toglie parole, non contenuti, e non ha un limite di lunghezza da raggiungere. Su una cartella lavora una nota alla volta e si ferma dopo ognuna.

```
/rivedi "Primo semestre/SO/Lezione 5-Semafori, Messaggi.md"
/rivedi "Primo semestre/SO/Lezione 5-Semafori, Messaggi.md" solo report     # non modifica nulla
/rivedi diff                                            # le note modificate e non ancora in un commit
```

**`/revisore`** lancia il revisore su una nota senza modificarla: restituisce l'elenco delle correzioni (report-only). Utile per far controllare una nota in qualsiasi momento.

```
/revisore "Primo semestre/SO/Lezione 5-Semafori, Messaggi.md"
```

**`/revisione`** esegue il controllo strutturale e ne riporta il risultato. Non modifica nulla.

```
/revisione                              # tutto il vault
/revisione "Primo semestre/Linguaggi"   # un corso
```

Trova: link rotti, immagini mancanti, formule e blocchi di codice non chiusi, `<div>` non bilanciati, callout sbagliati, segnaposto non risolti, lezioni che mancano nell'indice, sintesi finale mancante, frontmatter e tag, titoli fuori convenzione, frasi tipiche da IA, `[!todo]` aperti, paragrafi molto lunghi.

**`/chiudi-nota`** esegue in sequenza controllo perdite, controllo strutturale e revisore su una singola nota, restituendo un report unificato. Non modifica nulla: se qualcosa va sistemato, usa poi `/rivedi`.

```
/chiudi-nota "Primo semestre/SO/Lezione 5-Semafori, Messaggi.md"
/chiudi-nota "Primo semestre/SO/Lezione 5-Semafori, Messaggi.md" "Primo semestre/SO/semafori.pdf"
```

Cosa fa, in ordine:

1. Salva una copia di sicurezza della nota in `.opencode/originali/`;
2. Esegue `controlla-perdite.py` e segnala formule, codice, immagini, numeri e righe del materiale non ritrovate nella nota;
3. Esegue `vault-audit.py --breve` e segnala ERROR e WARN;
4. Chiama il subagent `revisore` e segnala [ERRORE], [MANCA], [TAGLIA], [STILE], [FORMA];
5. Chiude con un giudizio: `Nota corretta` / `Da correggere: N errori` / `Da completare: N perdite`.

Usalo quando hai finito di scrivere una nota e vuoi verificare che nulla sia stato perso prima di considerarla chiusa.

**`/slide`** mostra il testo di una pagina del materiale, per controllare con i propri occhi.

```
/slide "Primo semestre/Linguaggi/automi.pdf" 28
/slide "Primo semestre/Linguaggi/automi.pdf" 19-21
/slide "Primo semestre/Linguaggi/automi.pptx" --cerca "pila vuota"
```

**`/libro`** legge un libro di testo di `libri/`: elenco dei libri, sommario, una pagina o la ricerca di un testo. Il libro resta un complemento della nota, da usare solo col tuo consenso (regola 11 di `AGENTS.md`).

```
/libro elenco
/libro "libri/Introduzione sicurezza.pdf" indice
/libro "libri/Introduzione sicurezza.pdf" pagina 28
/libro "libri/Introduzione sicurezza.pdf" cerca "firewall"
```

**`/dividi`** divide un file unico di appunti in una nota per lezione. Serve una volta sola, per gli appunti scritti finora.

```
/dividi "Primo semestre/SO/Appunti teoria SO.md"
/dividi "Primo semestre/SO/Appunti teoria SO.md" --per-sezione
```

Mostra prima il piano e scrive solo dopo la tua conferma. Vedi sotto.

I percorsi con spazi vanno sempre tra virgolette.

## Passare i vecchi appunti al nuovo formato

1. `/dividi "percorso/Appunti corso.md"`. Lo script taglia il file sui titoli `###` e usa la data nascosta nei nomi delle immagini solo per raggruppare le sezioni consecutive: la data non finisce nei nomi dei file né nell'indice. Il testo viene copiato identico, non passa dal modello.
2. Controlla il piano. I gruppi seguono le immagini, quindi sono indicativi: le sezioni senza immagini restano gruppi a sé e vanno unite a mano se serve.
3. Conferma: crea le note e l'indice nella stessa cartella. Il file unico resta intatto: archivialo o cancellalo tu quando hai controllato.
4. Se un titolo o un nome non ti va, rinomina il file da Obsidian: i link dell'indice si aggiornano da soli.
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
![[x.png]]                        senza segnaposto: l'agent chiede (ridimensionata a 300 se non ti importa)
![[x.png]] // adatta //           adattata alla larghezza della pagina
![[x.png]] // sotto: testo //     con scritta sotto
![[x.png]] // lato: testo //      con testo a lato
![[x.png]] // lato //             a lato va il paragrafo che segue
```

Se non scrivi un segnaposto, l'agent ti chiede quale layout usare, una domanda per immagine. Il testo per la scritta sotto o per il testo a lato viene dall'OCR o te lo chiede lui, e se non lo scrivi ripiega su un ridimensionamento.

Dentro un callout l'immagine resta `![[x.png|300]]`. Il modello non vede le immagini: non descrive mai cosa mostrano, a meno che non lo dica il tuo testo o l'OCR.

**Todo.** `> [!todo] cosa va rivisto` segna un punto da controllare. L'agent prova a chiuderli a ogni passata e ne lascia di nuovi quando non è sicuro di qualcosa. `/revisione` li elenca tutti.

**Sintesi.** Ogni nota si chiude con `> [!info] Sintesi:`, da 3 a 6 punti. La scrive l'agent con `/lezione` e `/rivedi`.

**Codice.** Lo snippet che serve alla teoria resta nella nota, in un blocco ```` ``` ````. Gli esercizi e le soluzioni complete stanno in `esercizi/`, col nome che dai tu: nella nota resta solo il pezzo rilevante con il wikilink `[[esercizi/es3.py|es3]]`. I file di `esercizi/` sono tuoi: l'agent non li apre in scrittura e, se gli chiedi un esercizio, te lo dà nella risposta e lo salvi tu.

## Cosa OpenCode può fare e cosa no

- Scrive solo file `.md`. Non può modificare `AGENTS.md`, i file in `.opencode/` né nulla in `esercizi/`.
- Non crea note: le crei tu e lui le riempie. Può creare solo l'indice del corso. L'unica eccezione è `/dividi`, che chiede conferma.
- Non tocca `.txt`, PDF, slide, immagini e i file in `esercizi/`. Non esegue codice.
- Non esce dal vault.
- Nel terminale può eseguire solo i cinque script (anche `libri.py`), `ls`, `grep`, `rg`, `wc`, `pdfinfo`, `pdftotext`, i comandi git di sola lettura e i comandi di stato del server `obsidian-mcp-search`. Per `pdftoppm` (che crea immagini) chiede conferma. La lettura delle slide immagine con Docling avviene dentro `leggi-slide.py`.
- Può cercare sul web.
- Non fa commit né push: restano a te.

Queste restrizioni non sono solo scritte: sono imposte dal blocco `permissions` di `opencode.json`. `edit` nega tutto tranne i `.md`, con diniego esplicito per `AGENTS.md`, `.opencode/**`, `esercizi/`, `opencode.json`, `CONFIG-CHANGES.md` e i due file di `prompt/`; `bash` nega tutto tranne i comandi in allowlist qui sopra; `external_directory` gli impedisce di uscire dal vault.

## Gli script, anche a mano

```bash
python3 .opencode/scripts/leggi-slide.py FILE              # elenco delle pagine
python3 .opencode/scripts/leggi-slide.py FILE 28           # una pagina
python3 .opencode/scripts/leggi-slide.py FILE --cerca "x"  # dove compare x
python3 .opencode/scripts/libri.py elenco                  # libri presenti e corso associato
python3 .opencode/scripts/libri.py indice FILE             # sommario del libro
python3 .opencode/scripts/libri.py pagina FILE 28          # una pagina del libro
python3 .opencode/scripts/libri.py cerca FILE "x"          # dove compare x nel libro
python3 .opencode/scripts/vault-audit.py "Primo semestre/Linguaggi"
python3 .opencode/scripts/vault-audit.py --breve           # solo ERROR e WARN
python3 .opencode/scripts/controlla-perdite.py NOTA --salva       # copia prima di modificare
python3 .opencode/scripts/controlla-perdite.py NOTA               # cosa si è perso rispetto alla copia
python3 .opencode/scripts/controlla-perdite.py NOTA --con FONTE   # rispetto a un .txt o alle slide
python3 .opencode/scripts/dividi-appunti.py FILE           # piano di divisione
python3 .opencode/scripts/dividi-appunti.py FILE --scrivi  # crea le note
```

`leggi-slide.py` legge PDF, PPTX e PPT (i PPT li converte con LibreOffice in una cartella temporanea). Se un PDF è fatto di pagine immagine, il testo viene letto automaticamente con Docling (OCR); sui file lunghi il fallback viene saltato, per non impiegare troppo tempo, e lo script lo segnala: in quel caso la pagina si guarda come foto. Con `LEGGI_SLIDE_DOCLING_FORZA=1` si forza Docling anche sui file lunghi.

## Il plugin opencode-parser

Aggiunge il tool `parse`, che estrae il testo da PDF, Word, PowerPoint e, con l'OCR, dalle immagini. È installato globalmente come `opencode-parser@2.0.1`, compatibile con OpenCode 2; non crea né inserisce immagini. Qui serve per leggere il testo dentro uno screenshot (`parse` con OCR in italiano). Per slide e PDF l'agent usa `leggi-slide.py`, perché `parse` restituisce il documento dall'inizio e non una pagina precisa.

## La ricerca semantica (server obsidian-search)

Nelle note c'è anche una ricerca per significato, non solo per parola esatta: chiedendo "dove si parla di protezione del traffico" trova la lezione sui firewall anche se la parola "firewall" non è nella domanda. La fa il server MCP `obsidian-search` (`opencode.json`, sezione `mcp`), che indicizza le note di `primo semestre/` con un modello di embedding multilingua e le cerca su `http://127.0.0.1:8848/mcp`. Espone quattro tool: `list_vaults`, `search`, `read_note`, `reindex`.

Il server è un servizio systemd utente (`~/.config/systemd/user/obsidian-mcp-search.service`), quindi parte da solo all'avvio. Comandi utili:

```bash
systemctl --user status obsidian-mcp-search     # stato
systemctl --user restart obsidian-mcp-search    # riavvio (ricarica l'indice)
obsidian-mcp-search status                      # note e blocchi indicizzati
```

L'indice si aggiorna da solo quando una nota cambia (watcher). Il modello e le note indicizzate sono nella cartella di cache in `~/.cache/obsidian-mcp-search/`. L'agente lo usa solo per trovare le lezioni collegate, non per leggere il file da modificare.

## La compattazione del contesto

Quando la conversazione si allunga, OpenCode riassume da solo le parti vecchie per liberare spazio nella finestra di contesto del modello. In `opencode.json` la sezione `compaction` imposta:

- `auto: true` — compatta automaticamente quando il contesto è pieno (default: `true`);
- `keep.tokens: 12000` — conserva un riassunto più compatto, riducendo il contesto reinviato nei turni successivi.

Ci sono anche `reserved` (token di riserva per la compattazione) e `preserve_recent_tokens` (token recenti da conservare). Non esiste una cadenza fissa "ogni N messaggi": la compattazione parte quando il contesto si riempie, e un riassunto a intervalli richiederebbe un plugin che chiami `session.summarize`.

Il riassunto lo fa il modello indicato in `agents.compaction` (`opencode/nemotron-3-ultra-free`, finestra da 1M token): il modello deve poter tenere la nota in testa, non risumerla a pezzi.

A questo si aggiunge il plugin DCP, che pota il contesto mentre la sessione prosegue invece di aspettare la compattazione. È tarato in `.opencode/dcp.jsonc`: pota anche nelle sessioni dei subagenti, lascia intatti gli ultimi 3 turni, avvisa il modello prima che il contesto si riempia e deduplica le chiamate identiche. I suoi valori hanno la precedenza su quelli globali in `~/.config/opencode/dcp.jsonc`.

## Quando qualcosa va storto

- **Un plugin non si carica:** controlla la versione di OpenCode e la forma del plugin. I plugin di OpenCode 1.x (forma `{ id, server }`) non si caricano sulla 2.x (che accetta `{ id, effect }` o `{ id, setup }`): è il caso di `@omniroute/opencode-plugin`, tolto da `opencode.json` in attesa della 0.3.x.
- **Un provider risponde 401 "Missing Authentication header":** la credenziale salvata non è quella giusta. Controlla con `opencode auth list` e ricollega con `opencode auth login <provider>`.
- **Il 429 non passa al modello successivo:** guarda la catena in `rate-limit-fallback.json`; se il modello che fallisce non è in catena, con `otherModels: "wait"` il plugin lo ritenta sullo stesso modello dopo il cooldown, non passa a un altro.
- **Un comando con la pipe viene negato:** OpenCode controlla i permessi per ogni comando della catena, anche `| head`. Le regole che mancano si aggiungono in `opencode.json`, sezione `permissions`, come `shell` + `allow`, dopo la regola `deny` generica.
- **Agent o command non compaiono:** esegui `/reload`; se non basta, riavvia OpenCode.
- **OpenCode non parte per un errore di configurazione:** `OPENCODE_DISABLE_PROJECT_CONFIG=1 opencode`, correggi e riavvia. Per vedere la configurazione che OpenCode ha davvero caricato: `opencode debug config`.
- **L'agent ha scritto troppo o ha rovinato una nota:** `git diff` mostra cosa è cambiato, `git restore "percorso"` riporta la nota all'ultimo commit. Senza git, la versione di prima è in `.opencode/originali/`. Conviene fare un commit prima di `/rivedi` e di `/dividi`.
- **Un'immagine in un `<div>` non si vede:** controlla che il nome in `src` sia identico a quello del file. Se è giusto e non si vede lo stesso, vedi `LEGGIMI.md`.
- **Richieste vaghe:** "migliora la nota" produce una riscrittura a caso. Meglio "la sezione sui semafori è troppo lunga, asciugala" oppure un segnaposto nel punto giusto.
- **Ollama:** su questa macchina c'è una GPU NVIDIA GTX 1050; i modelli piccoli (`qwen2.5:3b`, `qwen2.5:1.5b`) rispondono in pochi secondi. Non usare i modelli 7b per compiti frequenti: non entrano nei 4 GB di VRAM e restano su CPU.
