# Prompt per lavorare fuori da OpenCode

Lo stile non è ripetuto qui: sta solo in `.opencode/stile.md`, così non esistono due versioni da tenere allineate.

## Antigravity (o un altro agente che vede il vault)

Controllo di una nota, senza modifiche:

```
Leggi AGENTS.md e .opencode/stile.md e rispettali.
Controlla la nota [PERCORSO] confrontandola con il materiale del docente che trovi nella stessa cartella. Non modificare nessun file.
Restituisci un elenco, dal più grave al meno grave, una voce per riga:
[ERRORE] contenuto sbagliato o impreciso, con il riferimento alla pagina del materiale
[MANCA] definizioni, teoremi, passaggi, esempi, punti di elenco, numeri del materiale assenti nella nota
[TAGLIA] parole che non portano informazione (mai un contenuto del docente o mio, nemmeno se sembra secondario)
[STILE] ciò che viola .opencode/stile.md
Non proporre di riscrivere ciò che è corretto e chiaro. Niente premesse.
```

Lavoro su una nota:

```
Leggi AGENTS.md e .opencode/stile.md e rispettali.
Lavora sulla nota [PERCORSO]. Esegui i segnaposto // ... //, correggi gli errori e aggiungi ciò che manca usando il materiale del docente nella stessa cartella. Il testo già corretto e chiaro resta com'è e nessuna informazione va tolta. Chiudi la nota con il callout [!info] Sintesi. Non creare altri file.
Prima di modificare esegui python3 .opencode/scripts/controlla-perdite.py "[PERCORSO]" --salva. Alla fine esegui lo stesso comando senza --salva, rimetti ciò che risulta perso, poi esegui python3 .opencode/scripts/vault-audit.py "[PERCORSO]" e chiudi con un riepilogo di 5 righe al massimo.
```

## Chat web (ChatGPT, Claude, Gemini)

Allega `.opencode/stile.md`, gli appunti e il materiale del docente, poi incolla:

```
In allegato trovi stile.md, i miei appunti e il materiale del docente.

Compito: [scegline uno]
- integra i miei appunti: esegui i segnaposto // ... //, correggi gli errori e aggiungi ciò che manca rispetto al materiale. Il testo già corretto e chiaro resta com'è, parola per parola.
- scrivi la nota da zero dal materiale del docente: appunti da studente, non una dispensa. Ogni slide di contenuto va coperta per intero: definizioni, teoremi, algoritmi, tutti gli esempi, tutti i punti degli elenchi.
- asciuga questa nota togliendo solo parole: nessuna informazione va persa.

Regole:
- segui stile.md alla lettera; se i miei appunti e stile.md dicono cose diverse, valgono i miei appunti;
- all'esame devo riportare ciò che ha detto il docente: tutto ciò che sta nei miei appunti e nel materiale deve restare nella nota. Puoi sistemare la forma, correggere e aggiungere; puoi togliere solo parole che non portano informazione. Nel dubbio, tieni;
- se non sei sicuro di un contenuto non inventare: lascia > [!todo] con cosa manca;
- i nomi dei file delle immagini vanno copiati identici.

Rispondi solo con la nota in un blocco markdown, seguita da un riepilogo di 5 righe al massimo: cosa hai aggiunto, corretto, tolto, e i todo lasciati.

Titolo della lezione: [TITOLO]
```
