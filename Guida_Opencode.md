# Guida a OpenCode in questo Vault

◀️ *Back to:* [[00_Uni_Index]]

Come usare l'assistente OpenCode dentro questo vault: quali agent esistono, come invocarli, e cosa possono fare.

---

## Avvio

OpenCode si avvia **dalla radice del vault**, non da una sottocartella:

```bash
cd ~/Uni/material-repos/Obsidian_notes
opencode
```

Lavorare da una sottocartella e' il modo piu' comune di farsi bloccare: la root del progetto viene risolta risalendo fino alla radice git, ma se la sessione parte altrove il confine `external_directory` puo` tagliare fuori parti del vault che ti servono.

Dopo aver modificato `opencode.json` o un file in `.opencode/`, **riavvia OpenCode**: la configurazione e` letta solo all'avvio e non viene ricaricata a caldo.

---

## Gli agent

Un agent e' un profilo di lavoro con prompt e permessi propri. Si invocano in tre modi: con `Tab` per lo switcher, scrivendo `@nome` per il mention, o dall'interno di un altro agent.

| Agent | Si invoca con | Serve per |
|---|---|---|
| `vault` | `Tab` | default. Modifiche minori, wikilink, e instradamento verso gli altri |
| `appunti` | `Tab` o `@appunti` | Appunti grezzi o trascrizioni -> nota definitiva |
| `materiale` | `Tab` o `@materiale` | Solo slide o PDF -> nota definitiva |
| `lettore` | `@lettore` | Estrazione di testo da PDF e slide. Sola lettura |
| `indici` | `@indici` | Manutenzione dei 19 indici di corso e degli hub annuali |
| `revisore` | `Tab` o `@revisore` | Revisione qualitativa. Non modifica nulla |

Gli agent `lettore` e `indici` sono passi interni di un flusso: normalmente non li scegli dalla barra, li chiama `vault` o i writer. Gli altri sono entry point e compaiono nello switcher.

**Lo `snapshot` e` attivo.** Prima di ogni modifica opencode salva un commit di sicurezza, quindi `git diff` mostra esattamente cosa ha scritto l'agent. E il modo piu' rapido per controllare il lavoro e per tornare indietro con `git checkout`.

---

## I command

Si invocano con `/` seguito dal nome.

### `/lezione`

Il comando principale: trasforma appunti o slide in una nota completa, e registra la nota nell'indice.

```
/lezione appunti 3° Anno/Programmazione Web/lezioni/raw_notes/28_09_26.txt
/lezione materiale 3° Anno/Cybersec
```

Il primo argomento dice da dove si parte: `appunti` se ci sono bozze o trascrizioni tue, `materiale` se c'e` solo il materiale del docente. Se lo ometti, opencode lo deduce dal contenuto.

Il comando esegue tre passi in sequenza: recupera il materiale se l'appunto ha dei placeholder, delega la stesura, poi aggiorna l'indice del corso. Non tocca mai i file in `raw_notes/`.

### `/revisione`

Audit strutturale deterministico.

```
/revisione                          # tutto il vault
/revisione 3° Anno/Cybersec         # solo un corso
```

Verifica link rotti, immagini, frontmatter, tag canonici, indici disallineati, callout malformate e caratteri vietati. Gira uno script (`.opencode/scripts/vault-audit.py`) e riporta il suo output diviso per gravita`: `ERROR` da sistemare, `WARN` da valutare, `INFO` da tenere a mente. Non modifica nulla.

Se un corso e' molto esteso e vuoi un audit completo in tempi ragionevoli, il tempo scala con i file, non con i corsi: passare un corso alla volta e` il modo piu' rapido per ottenere lo stesso risultato.

### `/rivedi`

Revisione qualitativa, con giudizio umano invece che conteggio.

```
/rivedi 3° Anno/Cybersec/lezioni    # un insieme di note
/rivedi diff                        # solo le modifiche non committate
/rivedi                             # chiede cosa rivedere
```

Valuta prosa, registro, struttura, callout, terminologia e formule, e verifica che la nota corrisponda al materiale del docente. E' l'unico controllo che dica se una nota e' *buona*, mentre `/revisione` dice solo se e' *corretta*.

### `/slide`

Lookup puntuale in una pagina di PDF. Serve a verificare con i propri occhi cosa dice il materiale, per esempio quando un placeholder non viene risolto come ti aspetti.

```
/slide 153 "3° Anno/Cybersec/materiale/intro_reti-http-ftp-dns-posta.ppt"
```

---

## I placeholder `//`

La convenzione piu' utile del tuo sistema di appunti: dentro i file in `raw_notes/`, `// ... //` serve a delegare all'assistente due cose diverse.

**Recupero dal materiale.** Scrivendo `// slide 28 //` o `// def apertura //` stai dicendo "il docente ha tirato avanti, trova tu cosa c'era". Il comando `/lezione` chiama `@lettore`, che estrae la pagina dal PDF e la integra nella nota.

**Nota a voce.** Scrivendo `// precisazione del prof: ... //` stai registrando qualcosa che hai detto tu durante la lezione. Viene trasformato in un callout Obsidian e piazzato dove serve.

Una riga puo' contenere entrambi: `// Border -> //`. Il trattino e' prosa, i doppi slash sono markup.

Il placeholder non viene mai riportato nella nota finale, e non viene mai tolto senza essere stato prima risolto.

---

## Lettura del materiale

`@lettore` non ha un lettore di PDF integrato: usa `pdftotext` da shell, che e' gia` installato. Questo e` un vantaggio, perche' `-f` e `-l` permettono di estrarre una singola pagina invece di caricare l'intero documento.

```bash
pdfinfo "percorso.pdf"                                  # numero di pagine
pdftotext -f 28 -l 28 -layout "percorso.pdf" -           # solo la pagina 28
```

`-layout` va sempre usato: senza, tabelle e diagrammi vengono distrutti. `-f` e `-l` sono 1-based, e coincidono con il numero che trovi scritto negli appunti.

Le estensioni PowerPoint non si leggono con `pdftotext`. Per un `.pptx` l'agente estrae l'XML della slide e ne ricava il testo; se il deck contiene solo immagini, il messaggio che ti arriva e' che va convertito in PDF.

---

## Cosa OpenCode puo' e non puo' fare qui

I limiti sono in `opencode.json` e valgono per tutti gli agent.

**Non esce dal vault.** `external_directory` e' in `deny`: nessun tool puo' leggere o scrivere un file fuori da questa cartella, e non compare nessuna richiesta di conferma perche' l'accesso e' negato, non chiesto.

**Scrive solo file `.md`.** Non puo' modificare `.obsidian/`, `.gitignore`, i sorgenti delle slide, o i tuoi file in `raw_notes/`. Gli allegati li salva Obsidian, non l'assistente.

**Il shell e' in sola lettura.** Una allowlist fissa di comandi e` consentita: lettura di PDF, `ls`, `find`, `grep`, e i comandi `git` che non scrivono. Tutto il resto, incluso `python3` generico, e` negato. L'unica eccezione e' un comando percorso preciso, lo script di audit. Questa lista si allunga solo se l'aggiungi tu, deliberatamente.

**Non committa mai.** Nessun `git add`, `commit`, `checkout`, `restore`, `reset`, `stash`, `push`. La cronologia e` tua: la gestisce Obsidian Git insieme a te. OpenCode puo` solo mostrare il diff di quello che ha scritto.

**Non modifica i tuoi appunti grezzi.** I file in `raw_notes/` sono input del processo, non output.

---

## Quando qualcosa va storto

**Gli agent non compaiono nella barra.** La configurazione non e` ricaricata a caldo. Esci e riavvia OpenCode.

**OpenCode non parte e il config sembra sbagliato.** Avvialo ignorando la configurazione di progetto, cosi' entri e puoi ripararlo:

```bash
OPENCODE_DISABLE_PROJECT_CONFIG=1 opencode
```

Poi salva la correzione e riavvia normalmente.

**Il modello non ti piace.** Gli agent non hanno un modello fissato: ereditano quello della sessione. Cambiarlo cambia il comportamento di tutti in una volta.

**Il PDF non si lascia estrarre.** Se `pdftotext` restituisce spezzature di caratteri invece di testo, il PDF ha i caratteri come immagini o usa un font non standard. Non e' un problema dell'agente: va convertito.

---

## Cosa scrivere nelle richieste

L'assistente conosce la struttura del vault, quindi non serve descrivere i percorsi. Serve pero' essere concreto sull'intento:

- "trasforma la trascrizione del 28/09 in nota" funziona: sa dove cercare e a cosa serve.
- "questa sezione e' troppo generica, stringila sul modello di `03_Il_Modello_Relazionale.md`" funziona: hai dato un riferimento.
- "migliora la nota" non funziona: non ha un criterio di confronto, e produrra' una riscrittura casuale.

Il tag canonico di ogni corso, la convenzione sui nomi dei file e il layout delle cartelle sono in `AGENTS.md`, che l'assistente carica a ogni sessione. Non serve ricordarglieli.

---

## Manutenzione

| Cosa | Dove |
|---|---|
| Permessi e config | `opencode.json` |
| I 6 agent | `.opencode/agent/*.md` |
| I 4 command | `.opencode/command/*.md` |
| Script di audit | `.opencode/scripts/vault-audit.py` |
| Invarianti del vault | `AGENTS.md` |

Tutto quello che c'e` in `.opencode/` e` tracciato in git e salvato da Obsidian Git come il resto del vault.

Per aggiungere un agent, basta un file `.md` in `.opencode/agent/` con il frontmatter `description` e `mode`. Il `description` e` importante piu' di quanto sembri: e' l'unica cosa che l'altro agente legge per capire quando conviene delegarti. Deve dire **cosa** fai e **quando** usarti, non solo cosa fai.
