#!/usr/bin/env python3
"""Legge il testo del materiale del docente (PDF, PPTX, PPT) una pagina alla volta.

Uso:
  leggi-slide.py FILE                  elenco delle pagine con la prima riga di ognuna
  leggi-slide.py FILE 28               testo della pagina 28
  leggi-slide.py FILE 19-21            testo delle pagine da 19 a 21
  leggi-slide.py FILE tutto            testo di tutto il file
  leggi-slide.py FILE --cerca "testo"  pagine in cui compare il testo

Non scrive nulla nel vault. I .ppt vengono convertiti in una cartella temporanea.
"""
import hashlib
import os
import re
import shutil
import subprocess
import sys
import tempfile
import unicodedata
import zipfile
import xml.etree.ElementTree as ET

NS = {
    "a": "http://schemas.openxmlformats.org/drawingml/2006/main",
    "p": "http://schemas.openxmlformats.org/presentationml/2006/main",
    "r": "http://schemas.openxmlformats.org/officeDocument/2006/relationships",
    "rel": "http://schemas.openxmlformats.org/package/2006/relationships",
}


def esci(msg):
    print(f"ERRORE: {msg}")
    sys.exit(1)


def pagine_pdf(path):
    if not shutil.which("pdftotext"):
        esci("pdftotext non installato (pacchetto poppler-utils)")
    r = subprocess.run(["pdftotext", "-layout", path, "-"], capture_output=True)
    if r.returncode != 0:
        esci(f"pdftotext non riesce a leggere il file: {r.stderr.decode(errors='replace').strip()}")
    pagine = r.stdout.decode("utf-8", errors="replace").split("\f")
    if pagine and not pagine[-1].strip():
        pagine.pop()
    return pagine


def pagine_pptx(path):
    with zipfile.ZipFile(path) as z:
        nomi = set(z.namelist())
        ordine = []
        try:
            pres = ET.fromstring(z.read("ppt/presentation.xml"))
            rels = ET.fromstring(z.read("ppt/_rels/presentation.xml.rels"))
            mappa = {r.get("Id"): r.get("Target") for r in rels.findall("rel:Relationship", NS)}
            for sld in pres.findall("p:sldIdLst/p:sldId", NS):
                target = mappa.get(sld.get(f"{{{NS['r']}}}id"), "")
                nome = "ppt/" + target.lstrip("/").removeprefix("ppt/")
                if nome in nomi:
                    ordine.append(nome)
        except (KeyError, ET.ParseError):
            pass
        if not ordine:
            ordine = sorted(
                (n for n in nomi if re.fullmatch(r"ppt/slides/slide\d+\.xml", n)),
                key=lambda n: int(re.search(r"\d+", n.rsplit("/", 1)[1]).group()),
            )
        pagine = []
        for nome in ordine:
            radice = ET.fromstring(z.read(nome))
            righe = []
            for par in radice.iter(f"{{{NS['a']}}}p"):
                testo = "".join(t.text or "" for t in par.iter(f"{{{NS['a']}}}t")).strip()
                if testo:
                    righe.append(testo)
            pagine.append("\n".join(righe))
        return pagine


def pagine_ppt(path):
    soffice = shutil.which("soffice") or shutil.which("libreoffice")
    if not soffice:
        esci("i file .ppt richiedono LibreOffice: convertilo in PDF a mano")
    st = os.stat(path)
    chiave = hashlib.sha1(f"{os.path.abspath(path)}{st.st_mtime}{st.st_size}".encode()).hexdigest()[:16]
    cache = os.path.join(tempfile.gettempdir(), "leggi-slide-cache")
    os.makedirs(cache, exist_ok=True)
    pdf = os.path.join(cache, chiave + ".pdf")
    if not os.path.exists(pdf):
        with tempfile.TemporaryDirectory() as tmp:
            r = subprocess.run(
                [soffice, "--headless", "--convert-to", "pdf", "--outdir", tmp, path],
                capture_output=True,
            )
            prodotti = [f for f in os.listdir(tmp) if f.endswith(".pdf")]
            if r.returncode != 0 or not prodotti:
                esci("conversione del .ppt fallita: convertilo in PDF a mano")
            shutil.move(os.path.join(tmp, prodotti[0]), pdf)
    return pagine_pdf(pdf)


def carica(path):
    if not os.path.isfile(path):
        esci(f"file non trovato: {path}")
    ext = os.path.splitext(path)[1].lower()
    if ext == ".pdf":
        return pagine_pdf(path)
    if ext == ".pptx":
        return pagine_pptx(path)
    if ext == ".ppt":
        return pagine_ppt(path)
    esci(f"formato non supportato: {ext} (ammessi: .pdf, .pptx, .ppt)")


def normalizza(s):
    s = unicodedata.normalize("NFD", s.lower())
    return "".join(c for c in s if unicodedata.category(c) != "Mn")


def prima_riga(testo):
    for riga in testo.splitlines():
        if riga.strip():
            return " ".join(riga.split())[:80]
    return "(solo immagine, nessun testo)"


def stampa(pagine, a, b):
    tot = len(pagine)
    for n in range(a, b + 1):
        print(f"=== pagina {n}/{tot} ===")
        testo = pagine[n - 1].strip("\n")
        print(testo if testo.strip() else "(solo immagine, nessun testo: guardala a mano)")
        print()


def main():
    args = sys.argv[1:]
    if not args or args[0] in ("-h", "--help"):
        print(__doc__.strip())
        return
    path = args[0]
    pagine = carica(path)
    tot = len(pagine)
    if tot == 0:
        esci("nessuna pagina letta")
    vuote = sum(1 for p in pagine if not p.strip())

    if len(args) == 1:
        print(f"{os.path.basename(path)}: {tot} pagine")
        for i, p in enumerate(pagine, 1):
            print(f"{i:>4}  {prima_riga(p)}")
    elif args[1] == "--cerca":
        if len(args) < 3:
            esci('manca il testo da cercare: --cerca "testo"')
        ago = normalizza(" ".join(args[2:]))
        trovate = 0
        for i, p in enumerate(pagine, 1):
            for riga in p.splitlines():
                if ago in normalizza(riga):
                    print(f"p. {i}: {' '.join(riga.split())[:140]}")
                    trovate += 1
                    if trovate >= 40:
                        print("... (altri risultati omessi: restringi la ricerca)")
                        return
        if not trovate:
            print(f'"{" ".join(args[2:])}" non compare in nessuna pagina')
    elif args[1] == "tutto":
        stampa(pagine, 1, tot)
    else:
        m = re.fullmatch(r"(\d+)(?:-(\d+))?", args[1])
        if not m:
            esci(f"pagina non valida: {args[1]} (usa 28, 19-21 oppure tutto)")
        a = int(m.group(1))
        b = int(m.group(2) or a)
        if a < 1 or b > tot or a > b:
            esci(f"intervallo fuori dal file: il file ha {tot} pagine")
        stampa(pagine, a, b)

    if vuote > tot / 2:
        print(f"ATTENZIONE: {vuote} pagine su {tot} sono senza testo. Il file è fatto di immagini: il contenuto va letto a mano.")


if __name__ == "__main__":
    main()
