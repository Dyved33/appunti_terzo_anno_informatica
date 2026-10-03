#!/usr/bin/env python3
"""Controlla che in una nota non si siano perse informazioni rispetto alla fonte.

Uso:
  controlla-perdite.py NOTA --salva         salva una copia della nota PRIMA di modificarla
  controlla-perdite.py NOTA                 confronta la nota con la copia salvata
                                            (se non c'è, con l'ultimo commit git)
  controlla-perdite.py NOTA --con FILE      confronta la nota con appunti grezzi (.txt, .md)
                                            o con il materiale del docente (.pdf, .pptx, .ppt)

Cosa cerca nella fonte e non trova più nella nota: formule, righe di codice, immagini,
numeri, e le righe (o le slide) che non ritrova.

È un controllo sulle parole, non sul significato: ogni voce è "da controllare", non un
errore certo. Una frase riscritta con altre parole può essere segnalata; una frase
segnalata va riletta nella fonte e, se l'informazione manca davvero, rimessa nella nota.
Le copie salvate stanno in .opencode/originali/.
"""
import os
import re
import subprocess
import sys
import unicodedata

QUI = os.path.dirname(os.path.abspath(__file__))
ORIGINALI = os.path.join(os.path.dirname(QUI), "originali")
SOGLIA_RIGA = 0.6     # sotto questa quota di parole ritrovate nello stesso punto la riga è segnalata
SOGLIA_SLIDE = 0.4
MAX_VOCI = 60

STOP = set("""
alla alle allo agli anche ancora avere aveva base bene caso come cosa cose cosi cioe con cui
dalla dalle dallo dagli degli della delle dello dentro deve devono dopo dove dunque ecco
essa esse essere esso fare fatto fino formato fra hanno infatti inoltre loro meno mentre
molto nella nelle nello negli ogni oppure ossia parte perche pero piu poi possono prima
proprio puo quale quali quando quanto quella quelle quelli quello questa queste questi
questo quindi sara sempre senza sia sono solo sopra sotto stata stato stessa stesso sua
sue sugli sulla sulle sullo suo suoi tale tali tanto tipo tra tutta tutte tutti tutto
una uno viene vengono verso volta
""".split())


def esci(msg):
    print(f"ERRORE: {msg}")
    sys.exit(1)


def senza_accenti(s):
    s = unicodedata.normalize("NFD", s.lower())
    return "".join(c for c in s if unicodedata.category(c) != "Mn")


def parole(testo):
    """Parole di contenuto, ridotte alle prime 5 lettere per reggere plurali e coniugazioni."""
    out = set()
    for p in re.findall(r"[a-z]{4,}", senza_accenti(testo)):
        if p not in STOP:
            out.add(p[:5])
    return out


def numeri(testo):
    return set(re.findall(r"(?<![\w.])\d+(?:[.,]\d+)?(?![\w])", testo))


def formule(testo):
    out = set()
    for f in re.findall(r"\$\$(.+?)\$\$", testo, re.S) + re.findall(r"(?<!\$)\$([^$\n]+)\$(?!\$)", testo):
        f = re.sub(r"\s+", "", f)
        if len(f) > 2:
            out.add(f)
    return out


def blocchi_codice(righe):
    """Righe dentro i blocchi ```; restituisce (righe di codice, righe fuori dal codice)."""
    codice, fuori = [], []
    dentro = False
    for n, riga in enumerate(righe, 1):
        nuda = re.sub(r"^\s*(?:>\s*)+", "", riga)
        if re.match(r"^\s*(```|~~~)", nuda):
            dentro = not dentro
            continue
        (codice if dentro else fuori).append((n, riga))
    return codice, fuori


def immagini(testo):
    nomi = set(re.findall(r"!\[\[([^\]\|#\n]+)", testo))
    nomi |= set(re.findall(r"<img\b[^>]*?\bsrc\s*=\s*[\"']([^\"']+)[\"']", testo, re.I))
    return {os.path.basename(n.strip()).lower() for n in nomi}


def pulisci_markdown(riga):
    riga = re.sub(r"<[^>]+>", " ", riga)
    riga = re.sub(r"!?\[\[([^\]\|]*\|)?([^\]]*)\]\]", r"\2", riga)
    riga = re.sub(r"^\s*(?:>\s*)+(\[![^\]]*\])?", "", riga)
    return re.sub(r"[*_`#|]", " ", riga)


def chiave(nota):
    return os.path.relpath(os.path.abspath(nota)).replace(os.sep, "__")


def versione_git(nota):
    try:
        rel = os.path.basename(nota)
        r = subprocess.run(["git", "show", f"HEAD:./{rel}"], capture_output=True,
                           cwd=os.path.dirname(os.path.abspath(nota)) or ".")
        if r.returncode == 0:
            return r.stdout.decode("utf-8", errors="replace")
    except OSError:
        pass
    return None


def pagine_materiale(path):
    r = subprocess.run([sys.executable, os.path.join(QUI, "leggi-slide.py"), path, "tutto"],
                       capture_output=True)
    testo = r.stdout.decode("utf-8", errors="replace")
    if testo.startswith("ERRORE"):
        esci(testo.strip()[8:])
    pagine = []
    for blocco in re.split(r"^=== pagina (\d+)/\d+ ===$", testo, flags=re.M)[1:]:
        pagine.append(blocco)
    return [(int(pagine[i]), pagine[i + 1]) for i in range(0, len(pagine) - 1, 2)]


def mostra(titolo, voci):
    if not voci:
        return 0
    print(f"\n{titolo} ({len(voci)})")
    for v in voci[:MAX_VOCI]:
        print(f"  {v}")
    if len(voci) > MAX_VOCI:
        print(f"  ... e altre {len(voci) - MAX_VOCI}")
    return len(voci)


def confronta_testo(fonte, nota_testo, etichetta):
    righe_fonte = fonte.split("\n")
    righe_nota = nota_testo.split("\n")
    codice_f, fuori_f = blocchi_codice(righe_fonte)
    codice_n, _ = blocchi_codice(righe_nota)
    numeri_nota = numeri(nota_testo)
    # ogni riga della fonte va ritrovata in un punto preciso della nota (finestra di 3 righe),
    # non nel vocabolario di tutta la nota: così una riga tolta si vede anche se le sue
    # parole compaiono altrove
    per_riga = [parole(pulisci_markdown(r)) for r in righe_nota]
    finestre = [per_riga[i] | (per_riga[i + 1] if i + 1 < len(per_riga) else set())
                | (per_riga[i + 2] if i + 2 < len(per_riga) else set()) for i in range(len(per_riga))]
    tot = 0

    perse = sorted(formule(fonte) - formule(nota_testo), key=len, reverse=True)
    tot += mostra("Formule che non trovo più", [f"${f[:110]}$" for f in perse])

    codice_nota = {re.sub(r"\s+", "", r) for _n, r in codice_n}
    perse = [f"riga {n}: {r.strip()[:110]}" for n, r in codice_f
             if len(re.sub(r"\s+", "", r)) > 3 and re.sub(r"\s+", "", r) not in codice_nota]
    tot += mostra("Righe di codice che non trovo più", perse)

    perse = sorted(immagini(fonte) - immagini(nota_testo))
    tot += mostra("Immagini che non trovo più", perse)

    voci_numeri, voci_righe = [], []
    for n, riga in fuori_f:
        pulita = pulisci_markdown(riga)
        senza_formule = re.sub(r"\$[^$]*\$", " ", pulita)
        mancanti = sorted(numeri(senza_formule) - numeri_nota)
        if mancanti:
            voci_numeri.append(f"riga {n}: {', '.join(mancanti)}  <- {pulita.strip()[:90]}")
        p = parole(senza_formule)
        if len(p) >= 3:
            quota = max((len(p & f) / len(p) for f in finestre), default=0)
            if quota < SOGLIA_RIGA:
                voci_righe.append(f"riga {n} ({int(quota * 100)}% ritrovato): {pulita.strip()[:120]}")
    tot += mostra("Numeri che non trovo più", voci_numeri)
    tot += mostra(f"Righe di {etichetta} che non ritrovo nella nota", voci_righe)
    return tot


def confronta_slide(pagine, nota_testo):
    parole_nota = parole(pulisci_markdown(nota_testo))
    numeri_nota = numeri(nota_testo)
    voci, voci_numeri, vuote = [], [], 0
    for n, testo in pagine:
        p = parole(testo)
        if len(p) < 4:
            vuote += 1
            continue
        quota = len(p & parole_nota) / len(p)
        prima = next((" ".join(r.split()) for r in testo.splitlines() if r.strip()), "")
        if quota < SOGLIA_SLIDE:
            voci.append(f"pagina {n} ({int(quota * 100)}% ritrovato): {prima[:100]}")
        mancanti = sorted(x for x in numeri(testo) - numeri_nota if len(x) > 1)
        if mancanti and quota >= SOGLIA_SLIDE:
            voci_numeri.append(f"pagina {n}: {', '.join(mancanti[:12])}")
    tot = mostra("Pagine del materiale poco o per nulla presenti nella nota", voci)
    tot += mostra("Numeri del materiale che non trovo nella nota", voci_numeri)
    if vuote:
        print(f"\n{vuote} pagine con poco o nessun testo (titoli, immagini): non controllabili, guardale a mano.")
    return tot


def main():
    args = sys.argv[1:]
    if not args or "-h" in args or "--help" in args:
        print(__doc__.strip())
        return
    con = None
    if "--con" in args:
        i = args.index("--con")
        if i + 1 >= len(args):
            esci("manca il file dopo --con")
        con = args[i + 1]
        del args[i: i + 2]
    salva = "--salva" in args
    posizionali = [a for a in args if not a.startswith("--")]
    if len(posizionali) != 1:
        esci("indica una sola nota")
    nota = posizionali[0]
    if not os.path.isfile(nota):
        esci(f"nota non trovata: {nota}")
    with open(nota, encoding="utf-8") as f:
        nota_testo = f.read()
    copia = os.path.join(ORIGINALI, chiave(nota))

    if salva:
        os.makedirs(ORIGINALI, exist_ok=True)
        with open(copia, "w", encoding="utf-8") as f:
            f.write(nota_testo)
        print(f"Copia salvata: {len(nota_testo.split())} parole, {nota_testo.count(chr(10)) + 1} righe.")
        return

    if con:
        if not os.path.isfile(con):
            esci(f"file non trovato: {con}")
        est = os.path.splitext(con)[1].lower()
        print(f"Confronto: {os.path.basename(nota)}  <-  {os.path.basename(con)}")
        if est in (".pdf", ".pptx", ".ppt"):
            tot = confronta_slide(pagine_materiale(con), nota_testo)
        else:
            with open(con, encoding="utf-8", errors="replace") as f:
                tot = confronta_testo(f.read(), nota_testo, "appunti")
    else:
        if os.path.isfile(copia):
            with open(copia, encoding="utf-8") as f:
                fonte = f.read()
            origine = "copia salvata prima della modifica"
        else:
            fonte = versione_git(nota)
            origine = "ultimo commit git"
            if fonte is None:
                esci("non c'è una copia salvata né un commit git di questa nota: "
                     "prima di modificare esegui lo script con --salva")
        prima, dopo = len(fonte.split()), len(nota_testo.split())
        print(f"Confronto: {os.path.basename(nota)}  <-  {origine}")
        print(f"Parole: {prima} -> {dopo} ({(dopo - prima) / max(prima, 1) * 100:+.0f}%)")
        tot = confronta_testo(fonte, nota_testo, "testo")

    if tot == 0:
        print("\nNessuna perdita rilevata.")
    else:
        print(f"\n{tot} voci da controllare. Per ognuna: rileggi la fonte; se l'informazione manca "
              "nella nota, rimettila. Se c'è con altre parole, va bene così.")


if __name__ == "__main__":
    main()
