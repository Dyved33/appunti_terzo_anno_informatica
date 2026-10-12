#!/usr/bin/env python3
"""Gestione dei libri di testo in libri/.

Un libro sta in libri/<Nome corso>.pdf. Uso:
  libri.py elenco                     libri presenti e corso associato
  libri.py info FILE                  titolo, pagine, corso del libro
  libri.py indice FILE                sommario del PDF (dai segnalibri)
  libri.py pagina FILE 28             testo della pagina 28 (oppure 19-21)
  libri.py cerca FILE "testo"         pagine in cui compare il testo

Le pagine si leggono con lo stesso motore di leggi-slide.py (pdftotext, con
fallback Docling sulle pagine immagine). Non scrive nulla nel vault.
"""
import importlib.util
import os
import sys

QUI = os.path.dirname(os.path.abspath(__file__))
RADICE = os.path.dirname(os.path.dirname(QUI))
LIBRI = os.path.join(RADICE, "libri")
CORSI = os.path.join(RADICE, "primo semestre")


def _carica_leggi_slide():
    percorso = os.path.join(QUI, "leggi-slide.py")
    spec = importlib.util.spec_from_file_location("leggi_slide", percorso)
    modulo = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(modulo)
    return modulo


def esci(msg):
    print(f"ERRORE: {msg}")
    sys.exit(1)


def normalizza(s):
    return " ".join(s.split()).lower()


def libri_presenti():
    if not os.path.isdir(LIBRI):
        return []
    return sorted(f for f in os.listdir(LIBRI) if f.lower().endswith(".pdf"))


def corsi_presenti():
    if not os.path.isdir(CORSI):
        return []
    return sorted(
        x for x in os.listdir(CORSI)
        if os.path.isdir(os.path.join(CORSI, x)) and not x.startswith(".")
    )


def corso_del_libro(nome_file):
    base = normalizza(os.path.splitext(nome_file)[0])
    for corso in corsi_presenti():
        if normalizza(corso) == base:
            return corso
    return None


def risolvi(argomento):
    if os.sep in argomento or os.path.isfile(argomento):
        percorso = argomento
        if not os.path.isfile(percorso):
            esci(f"file non trovato: {argomento}")
        return percorso
    candidato = os.path.join(LIBRI, argomento)
    if os.path.isfile(candidato):
        return candidato
    if not candidato.lower().endswith(".pdf") and os.path.isfile(candidato + ".pdf"):
        return candidato + ".pdf"
    esci(f"libro non trovato: {argomento} (cerca in libri/)")


def comando_elenco():
    libri = libri_presenti()
    if not libri:
        print(f"nessun libro in {os.path.relpath(LIBRI, RADICE)}/")
        return
    print(f"Libri in {os.path.relpath(LIBRI, RADICE)}/:")
    for nome in libri:
        corso = corso_del_libro(nome)
        stato = f"corso: {corso}" if corso else "NESSUN CORSO CORRISPONDENTE"
        print(f"  {nome}  ->  {stato}")
    orfani = [
        c for c in corsi_presenti()
        if normalizza(c) not in {normalizza(os.path.splitext(n)[0]) for n in libri}
    ]
    if orfani:
        print("Corsi senza libro:")
        for c in orfani:
            print(f"  {c}")


def comando_info(percorso):
    from pypdf import PdfReader
    r = PdfReader(percorso)
    nome = os.path.basename(percorso)
    corso = corso_del_libro(nome) or "nessuno"
    titolo = (r.metadata.title if r.metadata else None) or "(senza titolo)"
    print(f"File:    {nome}")
    print(f"Titolo:  {titolo}")
    print(f"Pagine:  {len(r.pages)}")
    print(f"Corso:   {corso}")
    print(f"Segnalibri: {_conta_segnalibri(r.outline) if r.outline else 0}")


def _conta_segnalibri(items):
    n = 0
    for it in items:
        if isinstance(it, list):
            n += _conta_segnalibri(it)
        else:
            n += 1
    return n


def comando_indice(percorso):
    from pypdf import PdfReader
    r = PdfReader(percorso)
    if not r.outline:
        print("Questo PDF non ha un sommario (segnalibri). Usa 'pagina FILE N' o 'cerca FILE \"testo\"'.")
        return
    print(f"Sommario di {os.path.basename(percorso)}:")

    def cammina(items, livello):
        for it in items:
            if isinstance(it, list):
                cammina(it, livello + 1)
                continue
            titolo = (getattr(it, "title", "") or "").strip().replace("\n", " ")
            try:
                pagina = r.get_destination_page_number(it) + 1
            except Exception:
                pagina = "?"
            print(f"{'  ' * livello}{titolo}  (p. {pagina})")

    cammina(r.outline, 0)


def comando_pagina(percorso, argomento):
    import re
    leggi = _carica_leggi_slide()
    pagine = leggi.carica(percorso)
    tot = len(pagine)
    m = re.fullmatch(r"(\d+)(?:-(\d+))?", argomento)
    if not m:
        esci(f"pagina non valida: {argomento} (usa 28 oppure 19-21)")
    a = int(m.group(1))
    b = int(m.group(2) or a)
    if a < 1 or b > tot or a > b:
        esci(f"intervallo fuori dal libro: il libro ha {tot} pagine")
    leggi.stampa(pagine, a, b)
    vuote = sum(1 for p in pagine if not p.strip())
    if vuote > tot / 2:
        print(f"ATTENZIONE: {vuote} pagine su {tot} sono senza testo. Se il file e' di immagini, il fallback Docling lo legge a mano.")


def comando_cerca(percorso, ago):
    leggi = _carica_leggi_slide()
    pagine = leggi.carica(percorso)
    ago_norm = leggi.normalizza(ago)
    trovate = 0
    for i, pagina in enumerate(pagine, 1):
        for riga in pagina.splitlines():
            if ago_norm in leggi.normalizza(riga):
                print(f"p. {i}: {' '.join(riga.split())[:140]}")
                trovate += 1
                if trovate >= 40:
                    print("... (altri risultati omessi: restringi la ricerca)")
                    return
    if not trovate:
        print(f'"{ago}" non compare in nessuna pagina')


def main():
    args = sys.argv[1:]
    if not args or args[0] in ("-h", "--help"):
        print(__doc__.strip())
        return
    comando = args[0]
    if comando == "elenco":
        comando_elenco()
    elif comando == "info":
        if len(args) < 2:
            esci("manca il libro: info FILE")
        comando_info(risolvi(args[1]))
    elif comando == "indice":
        if len(args) < 2:
            esci("manca il libro: indice FILE")
        comando_indice(risolvi(args[1]))
    elif comando == "pagina":
        if len(args) < 3:
            esci('manca una pagina: pagina FILE 28')
        comando_pagina(risolvi(args[1]), args[2])
    elif comando == "cerca":
        if len(args) < 3:
            esci('manca il testo da cercare: cerca FILE "testo"')
        comando_cerca(risolvi(args[1]), " ".join(args[2:]))
    else:
        esci(f"comando sconosciuto: {comando} (elenco, info, indice, pagina, cerca)")


if __name__ == "__main__":
    main()
