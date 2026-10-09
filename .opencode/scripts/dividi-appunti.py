#!/usr/bin/env python3
"""Divide un file unico di appunti in un file per lezione. Il testo non viene modificato.

Uso:
  dividi-appunti.py FILE                    mostra il piano, non scrive nulla
  dividi-appunti.py FILE --scrivi           crea i file nella cartella di FILE
  dividi-appunti.py FILE --scrivi --dest CARTELLA
  dividi-appunti.py FILE --per-sezione      un file per sezione invece che per gruppo

Come ragiona: ogni titolo di primo livello del file è una sezione. Per raggruppare le
sezioni in una lezione usa la data nascosta nei nomi delle immagini ("Screenshot From
2026-03-05 ..." e "Pasted image 20260305..." la contengono): le sezioni senza immagini
prendono la data della sezione precedente, e sezioni consecutive con la stessa data
formano una lezione. La data non finisce mai nel nome del file né nell'indice.

Il file di partenza non viene toccato. Nessun file esistente viene sovrascritto.
"""
import os
import re
import sys

RE_HEADING = re.compile(r"^(#{1,6})\s+(.*\S)\s*$")
RE_DATA_IMG = re.compile(r"(?:Screenshot From (\d{4})-(\d{2})-(\d{2})|Pasted image (\d{4})(\d{2})(\d{2}))")
RE_WIKILINK = re.compile(r"\[\[([^\]\|#\n]*)")
VIETATI = r'[\\/:*?"<>|#^\[\]]'


def esci(msg):
    print(f"ERRORE: {msg}")
    sys.exit(1)


def pulisci_titolo(t):
    t = re.sub(r"[*_`]", "", t).strip().rstrip(":").strip()
    return re.sub(r"\s+", " ", t)


def nome_file(titolo):
    return re.sub(r"\s+", " ", re.sub(VIETATI, " ", titolo)).strip()


def leggi_sezioni(righe):
    """Divide il file sui titoli del livello più alto presente, ignorando i blocchi di codice."""
    in_fence = False
    titoli = []
    for i, riga in enumerate(righe):
        if re.match(r"^\s*(?:>\s*)*(```|~~~)", riga):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        m = RE_HEADING.match(riga)
        if m:
            titoli.append((i, len(m.group(1)), m.group(2)))
    if not titoli:
        esci("il file non ha titoli: non so dove dividerlo")
    livello = min(l for _i, l, _t in titoli)
    inizi = [(i, t) for i, l, t in titoli if l == livello]
    sezioni = []
    if "".join(righe[: inizi[0][0]]).strip():
        sezioni.append({"titolo": "Premessa", "inizio": 0, "fine": inizi[0][0], "corpo_da": 0})
    for n, (i, t) in enumerate(inizi):
        fine = inizi[n + 1][0] if n + 1 < len(inizi) else len(righe)
        sezioni.append({"titolo": pulisci_titolo(t), "inizio": i, "fine": fine, "corpo_da": i + 1})
    annidati = {i: l for i, l, _t in titoli if l > livello}
    return sezioni, livello, annidati


def assegna_date(sezioni, righe):
    precedente = None
    for s in sezioni:
        s["dedotta"] = False
        s["data"] = None
        for riga in righe[s["inizio"]: s["fine"]]:
            m = RE_DATA_IMG.search(riga)
            if m:
                g = [x for x in m.groups() if x]
                s["data"] = "-".join(g)
                break
        if s["data"] is None and precedente:
            s["data"], s["dedotta"] = precedente, True
        precedente = s["data"] or precedente


def raggruppa(sezioni, per_sezione):
    lezioni = []
    for s in sezioni:
        if (not per_sezione and lezioni and s["data"] is not None
                and lezioni[-1]["data"] == s["data"]):
            lezioni[-1]["sezioni"].append(s)
        else:
            lezioni.append({"data": s["data"], "sezioni": [s]})
    for lez in lezioni:
        titoli = [s["titolo"] for s in lez["sezioni"]]
        titolo = ", ".join(titoli[:3]) + (" ecc" if len(titoli) > 3 else "")
        lez["titolo"] = titolo
        base = nome_file(titolo)
        lez["file"] = base + ".md"
        lez["righe"] = sum(s["fine"] - s["inizio"] for s in lez["sezioni"])
        lez["dedotta"] = all(s["dedotta"] for s in lez["sezioni"])
    visti = {}
    for lez in lezioni:
        chiave = lez["file"].lower()
        visti[chiave] = visti.get(chiave, 0) + 1
        if visti[chiave] > 1:
            lez["file"] = lez["file"][:-3] + f" ({visti[chiave]}).md"
    return lezioni


def componi(lez, righe, livello, annidati):
    """Testo della nota: # titolo, poi le sezioni. I titoli annidati scalano di conseguenza."""
    singola = len(lez["sezioni"]) == 1
    out = [f"# {lez['titolo']}\n", "\n"]
    for s in lez["sezioni"]:
        if not singola:
            out.append(f"## {s['titolo']}\n")
        for i in range(s["corpo_da"], s["fine"]):
            riga = righe[i]
            if i in annidati:
                m = RE_HEADING.match(riga)
                nuovo = min(annidati[i] - livello + (1 if singola else 2), 6)
                riga = f"{'#' * nuovo} {m.group(2)}\n"
            out.append(riga)
        if out and out[-1].strip():
            out.append("\n")
    testo = "".join(out)
    return testo if testo.endswith("\n") else testo + "\n"


def riga_indice(lez):
    nome = lez["file"][:-3]
    return f"- [[{nome}|{lez['titolo']}]]\n"


def main():
    args = sys.argv[1:]
    if not args or "-h" in args or "--help" in args:
        print(__doc__.strip())
        return
    scrivi = "--scrivi" in args
    per_sezione = "--per-sezione" in args
    dest = None
    if "--dest" in args:
        i = args.index("--dest")
        if i + 1 >= len(args):
            esci("manca la cartella dopo --dest")
        dest = args[i + 1]
        del args[i: i + 2]
    posizionali = [a for a in args if not a.startswith("--")]
    if len(posizionali) != 1:
        esci("indica un solo file da dividere")
    sorgente = posizionali[0]
    if not os.path.isfile(sorgente):
        esci(f"file non trovato: {sorgente}")
    dest = dest or os.path.dirname(sorgente) or "."

    with open(sorgente, encoding="utf-8") as f:
        righe = f.readlines()
    sezioni, livello, annidati = leggi_sezioni(righe)
    assegna_date(sezioni, righe)
    lezioni = raggruppa(sezioni, per_sezione)

    print(f"{os.path.basename(sorgente)}: {len(righe)} righe, {len(sezioni)} sezioni -> {len(lezioni)} file in {dest}/\n")
    for lez in lezioni:
        nota = ""
        if lez["data"] is None:
            nota = "   <- nessuna immagine: gruppo a sé, uniscilo a mano se serve"
        elif lez["dedotta"]:
            nota = "   <- raggruppata con la sezione precedente"
        print(f"{lez['righe']:>5} righe  {lez['file']}{nota}")

    esistenti = [lez["file"] for lez in lezioni if os.path.exists(os.path.join(dest, lez["file"]))]
    if not scrivi:
        print("\nNon ho scritto nulla. I gruppi seguono le immagini di ogni sezione: controllali.")
        if esistenti:
            print(f"ATTENZIONE: {len(esistenti)} di questi file esistono già: con --scrivi mi fermerei senza creare nulla.")
        print("Per creare i file: aggiungi --scrivi. Per un file per sezione: --per-sezione.")
        return

    if esistenti:
        esci("questi file esistono già, non sovrascrivo nulla: " + "; ".join(esistenti))
    os.makedirs(dest, exist_ok=True)
    for lez in lezioni:
        with open(os.path.join(dest, lez["file"]), "x", encoding="utf-8") as f:
            f.write(componi(lez, righe, livello, annidati))

    cartella = os.path.basename(os.path.abspath(dest))
    indici = sorted(f for f in os.listdir(dest) if f.startswith("00") and f.lower().endswith(".md"))
    if indici:
        indice = os.path.join(dest, indici[0])
        with open(indice, encoding="utf-8") as f:
            contenuto = f.read()
        presenti = {os.path.basename(t.strip()).lower() for t in RE_WIKILINK.findall(contenuto)}
        nuove = [riga_indice(l) for l in lezioni if l["file"][:-3].lower() not in presenti]
        if nuove:
            with open(indice, "a", encoding="utf-8") as f:
                f.write(("" if contenuto.endswith("\n") else "\n") + "".join(nuove))
        print(f"\nIndice aggiornato: {indici[0]} (+{len(nuove)} righe)")
    else:
        indice = os.path.join(dest, f"00 Indice - {cartella}.md")
        with open(indice, "x", encoding="utf-8") as f:
            f.write(f"# Indice - {cartella}\n\n" + "".join(riga_indice(l) for l in lezioni))
        print(f"\nIndice creato: {os.path.basename(indice)}")

    print(f"Creati {len(lezioni)} file. Il file di partenza è intatto: quando hai controllato, archivialo o cancellalo tu.")
    print("Se un titolo o un nome non ti va, rinomina il file da Obsidian: i link dell'indice si aggiornano da soli.")


if __name__ == "__main__":
    main()
