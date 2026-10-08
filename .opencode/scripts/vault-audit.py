#!/usr/bin/env python3
"""Controllo strutturale delle note. Non modifica nulla.

Uso:
  vault-audit.py                 tutto il vault
  vault-audit.py PERCORSO ...    solo quei file o quelle cartelle
  vault-audit.py --breve ...     solo ERROR e WARN

ERROR  la nota è rotta (link, immagine, LaTeX, blocco non chiuso)
WARN   viola le convenzioni di .opencode/stile.md
INFO   da tenere d'occhio (todo aperti, paragrafi lunghi)
"""
import os
import re
import sys

CALLOUT_AMMESSI = {"example", "info", "important", "warning", "tip", "todo"}
ESTENSIONI_IMG = {".png", ".jpg", ".jpeg", ".gif", ".svg", ".webp", ".bmp"}
CARTELLE_ESCLUSE = {".git", ".obsidian", ".opencode", ".trash", "node_modules", "images", "esercizi", "rollback"}
PREFISSI_ESCLUSI = (".opencode-backup",)
FILE_ESCLUSI = {"AGENTS.md", "Guida_Opencode.md", "Opencode_Guide.md", "prompt_chat.md", "README.md", "LEGGIMI.md"}
PARAGRAFO_LUNGO = 150  # parole

FRASI_IA = [
    "in questa lezione", "in questa nota", "in questa sezione", "in questa guida",
    "esploreremo", "approfondiremo", "andremo a vedere",
    "è importante notare", "è importante sottolineare", "è fondamentale notare",
    "è fondamentale sottolineare", "è essenziale notare", "è bene ricordare che",
    "vale la pena", "in conclusione", "in definitiva", "per riassumere", "ricapitolando",
    "nel panorama", "gioca un ruolo", "svolge un ruolo", "riveste un ruolo",
    "nota del prof",
]
TITOLI_VIETATI = {"conclusioni", "conclusione", "concetti chiave", "riepilogo", "riassunto", "introduzione"}

RE_DATA = re.compile(r"\b(\d{1,2}[/.\-_]\d{1,2}[/.\-_]\d{2,4}|\d{4}[/.\-_]\d{1,2}[/.\-_]\d{1,2})\b")
RE_WIKILINK = re.compile(r"(!?)\[\[([^\]\|#\n]*)(#[^\]\|\n]*)?(\|[^\]\n]*)?\]\]")
RE_IMG_HTML = re.compile(r"<img\b[^>]*?\bsrc\s*=\s*[\"']([^\"']+)[\"']", re.I)
RE_CALLOUT = re.compile(r"^\s*(?:[-*]\s+|\d+\.\s+)?(?:>\s*)+\[!([^\]]*)\]")
RE_HEADING = re.compile(r"^(#{1,6})\s+(.*\S)\s*$")
RE_SEGNAPOSTO = re.compile(r"(?<![:/\w])//[^/\n]{1,200}?//(?!/)")
RE_TAG = re.compile(r"(?:^|\s)#([A-Za-zÀ-ÿ][\w/\-]*)")
RE_URL = re.compile(r"https?://\S+")


def trova_radice():
    d = os.getcwd()
    while True:
        if os.path.exists(os.path.join(d, "opencode.json")) or os.path.isdir(os.path.join(d, ".obsidian")):
            return d
        su = os.path.dirname(d)
        if su == d:
            return os.getcwd()
        d = su


def cartella_esclusa(nome, escluse):
    return nome in escluse or nome.startswith(PREFISSI_ESCLUSI)


def scansiona(radice):
    """Tutti i file del vault: basename minuscolo -> lista di percorsi."""
    per_nome = {}
    for base, dirs, files in os.walk(radice):
        dirs[:] = [d for d in dirs if not cartella_esclusa(d, {".git", ".obsidian", ".trash", "node_modules", "rollback"})]
        for f in files:
            per_nome.setdefault(f.lower(), []).append(os.path.join(base, f))
    return per_nome


def note_da_controllare(percorsi):
    out = []
    for p in percorsi:
        if os.path.isfile(p):
            if p.lower().endswith(".md"):
                out.append(p)
            continue
        if not os.path.isdir(p):
            print(f"ERROR {p}: percorso inesistente")
            continue
        for base, dirs, files in os.walk(p):
            dirs[:] = sorted(d for d in dirs if not cartella_esclusa(d, CARTELLE_ESCLUSE))
            for f in sorted(files):
                if f.lower().endswith(".md") and f not in FILE_ESCLUSI:
                    out.append(os.path.join(base, f))
    return out


def e_indice(path):
    return os.path.basename(path).startswith("00")


def maschera(righe):
    """Restituisce le righe con codice e formule sostituiti da spazi, più i problemi di chiusura."""
    problemi = []
    solo_testo = []      # senza codice, con formule
    senza_formule = []   # senza codice e senza formule
    in_fence = False
    riga_fence = 0
    in_blocco_math = False
    riga_math = 0
    for n, riga in enumerate(righe, 1):
        pulita = re.sub(r"^\s*(?:>\s*)+", "", riga)
        if re.match(r"^\s*(```|~~~)", pulita):
            if not in_fence:
                in_fence, riga_fence = True, n
            else:
                in_fence = False
            solo_testo.append("")
            senza_formule.append("")
            continue
        if in_fence:
            solo_testo.append("")
            senza_formule.append("")
            continue
        t = re.sub(r"`[^`\n]*`", lambda m: " " * len(m.group()), riga)
        solo_testo.append(t)

        t = t.replace("\\$", "  ")
        parti = t.split("$$")
        ricostruita = []
        for i, parte in enumerate(parti):
            if i > 0:
                in_blocco_math = not in_blocco_math
                if in_blocco_math:
                    riga_math = n
            ricostruita.append(" " * len(parte) if in_blocco_math else parte)
        t = "  ".join(ricostruita)
        if not in_blocco_math and t.count("$") % 2 == 1:
            problemi.append(("ERROR", n, "formula $...$ non chiusa sulla riga"))
        t = re.sub(r"\$[^$\n]*\$", lambda m: " " * len(m.group()), t)
        senza_formule.append(t)
    if in_fence:
        problemi.append(("ERROR", riga_fence, "blocco di codice ``` non chiuso"))
    if in_blocco_math:
        problemi.append(("ERROR", riga_math, "formula $$...$$ non chiusa"))
    return solo_testo, senza_formule, problemi


def titolo_case(testo):
    parole = [p for p in re.split(r"[\s/]+", re.sub(r"[*_`$():,]", " ", testo)) if p]
    if len(parole) < 4:
        return False
    maiuscole = [p for p in parole[1:] if len(p) > 3 and p[0].isupper() and not p.isupper()]
    return len(maiuscole) >= 3 and len(maiuscole) >= len(parole[1:]) / 2


def risolvi_nota(target, per_nome, cartella, radice):
    target = target.strip()
    if not target:
        return True
    nome = os.path.basename(target)
    if not os.path.splitext(nome)[1]:
        nome += ".md"
    candidati = per_nome.get(nome.lower(), [])
    if "/" in target:
        suff = (target if target.lower().endswith(".md") else target + ".md").lower()
        candidati = [c for c in candidati if c.lower().replace(os.sep, "/").endswith(suff)]
    return candidati[0] if candidati else None


def risolvi_file(src, per_nome, cartella, radice):
    src = src.strip()
    if re.match(r"^(https?:|data:|app:|file:)", src):
        return True
    src = re.sub(r"%20", " ", src)
    for base in (cartella, radice, os.path.join(cartella, "images")):
        if os.path.isfile(os.path.join(base, src)):
            return True
    return bool(per_nome.get(os.path.basename(src).lower()))


def intestazioni(path, cache={}):
    if path not in cache:
        try:
            with open(path, encoding="utf-8") as f:
                cache[path] = {
                    re.sub(r"[*_`]", "", m.group(2)).strip().lower()
                    for m in (RE_HEADING.match(r) for r in f) if m
                }
        except OSError:
            cache[path] = set()
    return cache[path]


def controlla(path, per_nome, radice):
    out = []
    try:
        with open(path, encoding="utf-8") as f:
            righe = f.read().split("\n")
    except (OSError, UnicodeDecodeError) as e:
        return [("ERROR", 0, f"file illeggibile: {e}")], 0
    cartella = os.path.dirname(path)
    indice = e_indice(path)
    solo_testo, senza_formule, problemi = maschera(righe)
    out += problemi

    if righe and righe[0].strip() == "---":
        out.append(("WARN", 1, "frontmatter presente (le note non lo usano)"))

    # titoli
    h1 = []
    for n, riga in enumerate(solo_testo, 1):
        m = RE_HEADING.match(riga)
        if not m:
            continue
        livello, testo = len(m.group(1)), m.group(2)
        if livello == 1:
            h1.append((n, testo))
        if livello > 3:
            out.append(("WARN", n, f"titolo di livello {livello}: fermati a ###"))
        nudo = re.sub(r"[*_`]", "", testo).strip()
        if "**" in testo:
            out.append(("WARN", n, "titolo in grassetto"))
        if re.match(r"^([IVX]+\.|\d+[.)])\s", nudo):
            out.append(("WARN", n, "titolo numerato"))
        if re.search(r"[\U0001F300-\U0001FAFF☀-➿]", nudo):
            out.append(("WARN", n, "emoji nel titolo"))
        if nudo.rstrip(":").lower() in TITOLI_VIETATI:
            out.append(("WARN", n, f'sezione "{nudo}" da stile IA'))
        if livello > 1 and titolo_case(nudo):
            out.append(("WARN", n, "titolo con Maiuscole Su Ogni Parola"))
    if not h1:
        out.append(("WARN", 1, "manca il titolo # in testa"))
    elif len(h1) > 1:
        out.append(("WARN", h1[1][0], "più di un titolo #: ne serve uno solo"))
    if not indice and not RE_DATA.search(os.path.basename(path)):
        out.append(("WARN", 0, "il nome del file non contiene la data della lezione (AAAA-MM-GG Titolo.md)"))

    # riga per riga
    div_aperti = 0
    for n, (riga, nofx) in enumerate(zip(solo_testo, senza_formule), 1):
        m = RE_CALLOUT.match(riga)
        if m:
            tipo = m.group(1).rstrip("+-").strip()
            if tipo.lower() not in CALLOUT_AMMESSI:
                out.append(("WARN", n, f"callout [!{tipo}] non previsto (ammessi: {', '.join(sorted(CALLOUT_AMMESSI))})"))
            elif tipo != tipo.lower():
                out.append(("WARN", n, f"callout [!{tipo}] va in minuscolo"))
            if tipo.lower() == "todo":
                testo = riga.split("]", 1)[1].strip() or "(senza testo)"
                out.append(("INFO", n, f"todo aperto: {testo[:90]}"))
        elif re.search(r"\[![A-Za-z]+\]", nofx):
            out.append(("ERROR", n, "callout malformato: [!tipo] deve stare subito dopo >"))

        for emb, target, ancora, _alias in RE_WIKILINK.findall(nofx):
            est = os.path.splitext(target.strip())[1].lower()
            if emb and est in ESTENSIONI_IMG:
                if not risolvi_file(target, per_nome, cartella, radice):
                    out.append(("ERROR", n, f"immagine mancante: {target.strip()}"))
            elif est and est != ".md":
                if not risolvi_file(target, per_nome, cartella, radice):
                    out.append(("ERROR", n, f"file collegato mancante: {target.strip()}"))
            else:
                dest = risolvi_nota(target, per_nome, cartella, radice)
                if dest is None:
                    out.append(("ERROR", n, f"link rotto: [[{target.strip()}]]"))
                elif ancora and not ancora.startswith("#^"):
                    file_dest = path if dest is True else dest
                    if ancora[1:].strip().lower() not in intestazioni(file_dest):
                        out.append(("WARN", n, f"sezione inesistente nel link: [[{target.strip()}{ancora}]]"))

        for src in RE_IMG_HTML.findall(riga):
            if not risolvi_file(src, per_nome, cartella, radice):
                out.append(("ERROR", n, f"immagine mancante: {src}"))
        div_aperti += len(re.findall(r"<div\b", riga, re.I)) - len(re.findall(r"</div>", riga, re.I))

        senza_url = RE_URL.sub("", nofx)
        for m in RE_SEGNAPOSTO.finditer(senza_url):
            out.append(("WARN", n, f"segnaposto non risolto: {m.group().strip()[:70]}"))

        senza_link = re.sub(r"<[^>]+>", " ", RE_WIKILINK.sub(" ", senza_url))
        if not RE_HEADING.match(riga):
            m = RE_TAG.search(senza_link)
            if m:
                out.append(("WARN", n, f"tag #{m.group(1)} (le note non usano tag)"))

        basso = nofx.lower()
        for frase in FRASI_IA:
            if frase in basso:
                out.append(("WARN", n, f'formula da stile IA: "{frase}"'))
        if "—" in nofx:
            out.append(("INFO", n, "trattino lungo —"))
        m = re.match(r"^\s*\*\*([^*]+)\*\*:?\s*$", riga)
        if m and titolo_case(m.group(1)):
            out.append(("WARN", n, "etichetta con Maiuscole Su Ogni Parola"))

        parole = len(nofx.split())
        if parole > PARAGRAFO_LUNGO and not riga.lstrip().startswith("|"):
            out.append(("INFO", n, f"paragrafo di {parole} parole: spezzalo o asciugalo"))

    if div_aperti != 0:
        out.append(("ERROR", len(righe), f"<div> e </div> non bilanciati (differenza {div_aperti})"))

    parole_tot = sum(len(r.split()) for r in solo_testo)
    if not indice and parole_tot > 50:
        # la nota deve chiudersi con il callout [!info] Sintesi
        ultimo = None
        for n, riga in enumerate(solo_testo, 1):
            if RE_CALLOUT.match(riga):
                ultimo = n
        chiude = False
        if ultimo:
            testa = solo_testo[ultimo - 1]
            tipo = RE_CALLOUT.match(testa).group(1).strip().lower()
            titolo = re.sub(r"[*_]", "", testa.split("]", 1)[1]).strip().lower()
            resto = [r for r in solo_testo[ultimo:] if r.strip() and not r.lstrip().startswith(">")]
            chiude = tipo == "info" and titolo.startswith("sintesi") and not resto
        if not chiude:
            out.append(("WARN", 0, "la nota non si chiude con il callout [!info] Sintesi:"))
    return out, parole_tot


def controlla_indici(note, radice):
    out = []
    per_cartella = {}
    for p in note:
        per_cartella.setdefault(os.path.dirname(p) or ".", []).append(os.path.join(os.path.dirname(p) or ".", os.path.basename(p)))
    for cartella, files in sorted(per_cartella.items()):
        tutte = [os.path.join(cartella, f) for f in sorted(os.listdir(cartella))
                 if f.lower().endswith(".md") and f not in FILE_ESCLUSI]
        indici = [f for f in tutte if e_indice(f)]
        lezioni = [f for f in tutte if not e_indice(f)]
        if not indici:
            if len(lezioni) >= 2:
                out.append((cartella, "INFO", 0, f"{len(lezioni)} note e nessun indice (file che inizia con 00)"))
            continue
        try:
            with open(indici[0], encoding="utf-8") as f:
                collegati = {os.path.basename(t.strip()).lower().removesuffix(".md")
                             for _e, t, _a, _al in RE_WIKILINK.findall(f.read())}
        except OSError:
            continue
        for lez in lezioni:
            nome = os.path.basename(lez)[:-3]
            if nome.lower() not in collegati:
                out.append((indici[0], "WARN", 0, f"lezione non elencata nell'indice: {nome}"))
    return out


def main():
    args = sys.argv[1:]
    if "-h" in args or "--help" in args:
        print(__doc__.strip())
        return
    breve = "--breve" in args
    percorsi = [a for a in args if not a.startswith("--")] or ["."]
    radice = trova_radice()
    per_nome = scansiona(radice)
    note = note_da_controllare(percorsi)
    if not note:
        print("Nessuna nota .md da controllare nei percorsi indicati.")
        return

    conteggio = {"ERROR": 0, "WARN": 0, "INFO": 0}
    risultati = []
    for p in note:
        problemi, parole = controlla(p, per_nome, radice)
        risultati.append((p, problemi, parole))
    extra = {}
    for file, grav, n, msg in controlla_indici(note, radice):
        extra.setdefault(file, []).append((grav, n, msg))
    for file, voci in extra.items():
        for i, (p, problemi, parole) in enumerate(risultati):
            if os.path.abspath(p) == os.path.abspath(file):
                risultati[i] = (p, problemi + voci, parole)
                break
        else:
            risultati.append((file, voci, 0))

    ordine = {"ERROR": 0, "WARN": 1, "INFO": 2}
    if breve:
        risultati = [(p, [x for x in pr if x[0] != "INFO"], w) for p, pr, w in risultati]
    for p, problemi, parole in risultati:
        for g, _n, _m in problemi:
            conteggio[g] += 1
        if not problemi:
            continue
        rel = os.path.relpath(p)
        print(f"\n{rel}" + (f"  ({parole} parole)" if parole else ""))
        for grav, n, msg in sorted(problemi, key=lambda x: (ordine[x[0]], x[1])):
            dove = f"riga {n}" if n else "-"
            print(f"  {grav:<5} {dove:<9} {msg}")

    controllate = {os.path.abspath(n) for n in note}
    puliti = len(note) - sum(1 for p, pr, _w in risultati if pr and os.path.abspath(p) in controllate)
    print(f"\n{len(note)} note controllate, {puliti} senza segnalazioni: "
          f"{conteggio['ERROR']} ERROR, {conteggio['WARN']} WARN, {conteggio['INFO']} INFO")


if __name__ == "__main__":
    main()
