# Config-Changes — log delle modifiche al setup OpenCode

## v2 — allineamento a OpenCode v2 (2026-10-29)

### Permessi
- Togliuto `edit deny` su `opencode.json`: il file può essere modificato per aggiornare la configurazione.
- Togliuto `edit deny` su `.opencode/**` e sostituito con `edit deny` specifico su `.opencode/stile.md`: si possono creare skill, agent e modificare `dcp.jsonc`, ma lo stile rimane protetto.
- Togliuto `edit deny` su `prompt/Guida_Opencode.md`: la guida può essere aggiornata.
- Togliuto `edit deny` su `CONFIG-CHANGES.md`: questo file può essere aggiornato.
- Mantenuti `edit deny` su: `AGENTS.md`, `.opencode/stile.md`, `prompt/prompt_chat.md`, `prompt/README.md`.

### opencode.json
- `"@azumag/opencode-rate-limit-fallback@2.1.0"` → `"@azumag/opencode-rate-limit-fallback@2.1.1"`.
- Aggiunto `"protocol": "auto"` al server MCP `obsidian-search`.
- Aggiunto blocco `"tools": { "obsidian-search*": "deny" }` a livello globale.
- Aggiunto blocco `"agent"` con per-agent MCP tools: `obsidian-search*` allowed solo per `appunti` e `revisore`.
- `"@opencode-ai/plugin": "1.18.34"` → `"@opencode/cli": "latest"` in `.opencode/package.json`.
- `opencode-obsidian-vault` NON installato: ridondante con il server MCP `obsidian-search` già presente.

## Da fare (non ancora applicato)

- Valutare `piagentsync` (sincronizzazione configurazione tra vault). `echoes-vault-opencode` NON aggiunto: non ottimizza i token, anzi aggiunge contesto persistente.
