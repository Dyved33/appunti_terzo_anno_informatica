# Risposte - Primo compitino di Basi di dati

## Esercizio 1

### 1.1 Chiavi primarie e chiavi esterne

Assumo che `CodiceFiscale` identifichi una persona, che `Nome` identifichi una città e che ogni relazione storica possa contenere più periodi per la stessa coppia di entità. Per distinguere periodi diversi uso `DaAnno` nella chiave. Gli anni sono rappresentati come interi.

- **Persona**(`CodiceFiscale`, Nome, Cognome, Eta) — PK: `CodiceFiscale`.
- **Citta**(`Nome`, NumeroAbitanti) — PK: `Nome`.
- **HaAbitato**(`Persona`, `Citta`, `DaAnno`, AdAnno) — PK: (`Persona`, `Citta`, `DaAnno`); FK `Persona` → `Persona(CodiceFiscale)`; FK `Citta` → `Citta(Nome)`.
- **Ditta**(`PIVA`, NumeroImpiegati, CapitaleSociale) — PK: `PIVA`.
- **HaAvutoSede**(`Ditta`, `Citta`, `DaAnno`, AdAnno) — PK: (`Ditta`, `Citta`, `DaAnno`); FK `Ditta` → `Ditta(PIVA)`; FK `Citta` → `Citta(Nome)`.
- **HaLavorato**(`Persona`, `Ditta`, `DaAnno`, AdAnno) — PK: (`Persona`, `Ditta`, `DaAnno`); FK `Persona` → `Persona(CodiceFiscale)`; FK `Ditta` → `Ditta(PIVA)`.

La chiave composta consente di registrare più periodi distinti per la stessa persona e città, ditta e città, o persona e ditta, purché abbiano anni iniziali diversi. Il testo non specifica ulteriori vincoli sui periodi, per esempio che non si sovrappongano.

### 1.2 DDL per Persona, Citta e HaAbitato

Scelgo `ON DELETE CASCADE` e `ON UPDATE CASCADE` per `HaAbitato`: se si elimina o cambia il codice di una persona o il nome di una città, le righe storiche che li referenziano vengono eliminate o aggiornate insieme. Le colonne della chiave primaria e le chiavi esterne sono `NOT NULL`; `NumeroAbitanti` ed `Eta` non possono essere negative.

```sql
CREATE TABLE Persona (
    CodiceFiscale CHAR(16) PRIMARY KEY,
    Nome VARCHAR(60) NOT NULL,
    Cognome VARCHAR(60) NOT NULL,
    Eta INTEGER CHECK (Eta >= 0)
);

CREATE TABLE Citta (
    Nome VARCHAR(100) PRIMARY KEY,
    NumeroAbitanti INTEGER NOT NULL CHECK (NumeroAbitanti >= 0)
);

CREATE TABLE HaAbitato (
    Persona CHAR(16) NOT NULL,
    Citta VARCHAR(100) NOT NULL,
    DaAnno INTEGER NOT NULL,
    AdAnno INTEGER NOT NULL,
    PRIMARY KEY (Persona, Citta, DaAnno),
    FOREIGN KEY (Persona) REFERENCES Persona (CodiceFiscale)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Citta) REFERENCES Citta (Nome)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (AdAnno >= DaAnno)
);
```

Le politiche di reazione fanno rispettare l’integrità referenziale durante cancellazioni e aggiornamenti. Il `CHECK` sugli anni ammette intervalli con estremi uguali.

## Esercizio 2

Le query usano lo schema dell'esercizio 1. Qui le tuple temporali vengono lette così: `DaAnno` e `AdAnno` descrivono un periodo associato a una riga.

### 2.1 Algebra relazionale

#### 2.1.1 Ditte con più di 10000 impiegati

```text
σ NumeroImpiegati > 10000 (Ditta)
```

`σ` è la selezione: guarda ogni riga di `Ditta` e conserva quelle in cui `NumeroImpiegati > 10000` è vera. La selezione non cambia le colonne, quindi il risultato contiene tutte le informazioni delle ditte selezionate.

#### 2.1.2 Per ogni ditta, città in cui ha avuto sede per il minor numero di anni

Interpreto la domanda come il tempo totale trascorso da ciascuna ditta in ciascuna città. Se ci sono più periodi di sede nella stessa città, ne sommo le durate. Assumo intervalli non sovrapposti e calcolo la durata come `AdAnno - DaAnno`; il testo non specifica se gli estremi siano inclusivi. Con estremi inclusivi la durata sarebbe `AdAnno - DaAnno + 1`.

```text
DuratePeriodi(Ditta, Citta, Anni) ←
    per ogni tupla h di HaAvutoSede:
    (h.Ditta, h.Citta, h.AdAnno - h.DaAnno)

DurateCitta(Ditta, Citta, TotAnni) ←
    {Ditta, Citta} ℱ_{SUM(Anni)→TotAnni}(DuratePeriodi)

Minimi(Ditta, MinAnni) ←
    {Ditta} ℱ_{MIN(TotAnni)→MinAnni}(DurateCitta)

MinimiRinominati(DittaMin, MinAnni) ←
    ρ_{Ditta→DittaMin}(Minimi)

Combinazioni ← DurateCitta × MinimiRinominati

Risultato ←
    π Ditta, Citta, TotAnni (
        σ Ditta = DittaMin ∧ TotAnni = MinAnni (Combinazioni)
    )
```

La prima definizione è una scorciatoia descrittiva: crea, per ogni riga di sede, il valore derivato `Anni = AdAnno - DaAnno`. Da lì si procede così:

1. **Sommo per coppia ditta-città.** `DurateCitta` raggruppa le righe con gli stessi valori di `Ditta` e `Citta`; `SUM(Anni)` somma le durate di tutti i periodi registrati per quella coppia. Per esempio, due periodi di 3 e 4 anni per la stessa ditta e città danno 7 anni.
2. **Trovo il minimo per ditta.** `Minimi` raggruppa `DurateCitta` per `Ditta` e calcola il minimo tra i totali delle sue città. Non si calcola un unico minimo globale: ogni ditta ha il proprio.
3. **Abbino ogni totale al minimo della stessa ditta.** Rinomino `Ditta` in `DittaMin` nella relazione dei minimi, così il prodotto cartesiano può tenere distinte le due colonne omonime. La selezione impone sia che la ditta coincida sia che il totale della città sia uguale al minimo.
4. **Restituisco ditta, città e anni.** Se più città raggiungono il minimo, la query le conserva tutte.

Nella notazione di lezione, `{Ditta, Citta} ℱ_{SUM(Anni)}` significa: forma un gruppo per ogni coppia di valori uguali in `Ditta` e `Citta`, poi applica `SUM` a ogni gruppo. `{Ditta} ℱ_{MIN(TotAnni)}` ripete il procedimento raggruppando soltanto per ditta.

#### 2.1.3 Coppie di persone che hanno abitato nella stessa città, ma non hanno mai lavorato per la stessa ditta

Non si confrontano i periodi: è sufficiente che le due persone abbiano abitato nella stessa città in qualunque momento. Si escludono invece le coppie che abbiano mai lavorato entrambe per la stessa ditta, anche se in periodi diversi.

```text
A1(Persona1, Citta1) ←
    ρ_{Persona→Persona1, Citta→Citta1}
      (π Persona, Citta (HaAbitato))

A2(Persona2, Citta2) ←
    ρ_{Persona→Persona2, Citta→Citta2}
      (π Persona, Citta (HaAbitato))

StessaCitta(Persona1, Persona2) ←
    π Persona1, Persona2 (
        σ Persona1 < Persona2 ∧ Citta1 = Citta2 (A1 × A2)
    )

L1(Persona1, Ditta1) ←
    ρ_{Persona→Persona1, Ditta→Ditta1}
      (π Persona, Ditta (HaLavorato))

L2(Persona2, Ditta2) ←
    ρ_{Persona→Persona2, Ditta→Ditta2}
      (π Persona, Ditta (HaLavorato))

StessaDitta(Persona1, Persona2) ←
    π Persona1, Persona2 (
        σ Persona1 < Persona2 ∧ Ditta1 = Ditta2 (L1 × L2)
    )

Risultato(Persona1, Persona2) ←
    StessaCitta \ StessaDitta
```

**Come si forma `StessaCitta`:** `HaAbitato` viene proiettata su persona e città, perché gli anni non servono per verificare se la città è la stessa. Ne faccio due copie con `ρ`, rinominando gli attributi: `Persona1` e `Citta1` nella prima, `Persona2` e `Citta2` nella seconda. Il prodotto `A1 × A2` forma tutte le coppie possibili di registrazioni; la selezione tiene solo righe con la stessa città e persone diverse. La condizione `Persona1 < Persona2` sceglie una sola rappresentazione della coppia: così (P1,P2) compare, ma non anche (P2,P1). La proiezione elimina eventuali ripetizioni causate da più periodi nella stessa città.

**Come si forma `StessaDitta`:** si applica lo stesso procedimento a `HaLavorato`, proiettando persona e ditta. L'uguaglianza `Ditta1 = Ditta2` trova le coppie che hanno lavorato entrambe per almeno una ditta. Anche qui le date vengono ignorate: “non hanno mai lavorato per la stessa ditta” significa che non deve esistere alcuna ditta in comune, non che i periodi lavorativi debbano sovrapporsi.

**Perché si usa la differenza:** `StessaCitta \ StessaDitta` tiene le coppie presenti tra chi condivide una città e assenti tra chi condivide una ditta. I due operandi hanno lo stesso schema (`Persona1, Persona2`), requisito necessario per la differenza. In breve: prima si costruiscono le coppie che soddisfano la parte positiva del quesito, poi si sottraggono quelle che violano la parte “ma non”.

#### 2.1.4 Ditte con sede in tutte le città registrate

```text
π Ditta, Citta (HaAvutoSede)
    ÷
ρ_{Nome→Citta}(π Nome (Citta))
```

La divisione `R(X,Y) ÷ S(Y)` restituisce i valori di `X` associati, in `R`, a **tutti** i valori di `Y` presenti in `S`. Qui:

- a sinistra, `π Ditta, Citta (HaAvutoSede)` elenca le coppie ditta-città per cui è registrata una sede;
- a destra, `π Nome (Citta)` elenca tutte le città della base di dati; rinomino `Nome` in `Citta` perché l'attributo deve corrispondere a quello del primo operando;
- la divisione restituisce l'attributo rimasto, `Ditta`, per le ditte abbinate a ogni città del secondo operando.

Esempio: se le città registrate sono Roma e Bari, una ditta deve comparire nella relazione di sinistra sia con Roma sia con Bari. Aver sede solo a Roma non basta.

### 2.2 Calcolo relazionale su tuple

La forma `{ T | C }` si legge: «restituisci i valori di `T` per le assegnazioni di tuple che rendono vera la condizione `C`». `R(t)` significa che la variabile `t` rappresenta una tupla di `R`. Le variabili nel risultato (`T`) devono restare libere; quelle introdotte da `∃` o `∀` sono legate e servono solo a verificare la condizione.

#### 2.2.1 Ditte con più di 10000 impiegati

```text
{ d.PIVA |
  Ditta(d) ∧ d.NumeroImpiegati > 10000
}
```

`Ditta(d)` limita `d` alle righe della relazione `Ditta`. La congiunzione richiede anche che il numero degli impiegati superi 10000. Dato che la target list contiene solo `d.PIVA`, il risultato mostra le partite IVA delle ditte che soddisfano il filtro.

#### 2.2.3 Coppie di persone con una città abitata in comune e senza una ditta in comune

```text
{ p1.CodiceFiscale, p2.CodiceFiscale |
  Persona(p1) ∧ Persona(p2) ∧
  p1.CodiceFiscale < p2.CodiceFiscale ∧
  ∃ a1 ∃ a2 (
      HaAbitato(a1) ∧ HaAbitato(a2) ∧
      a1.Persona = p1.CodiceFiscale ∧
      a2.Persona = p2.CodiceFiscale ∧
      a1.Citta = a2.Citta
  ) ∧
  ¬∃ h1 ∃ h2 (
      HaLavorato(h1) ∧ HaLavorato(h2) ∧
      h1.Persona = p1.CodiceFiscale ∧
      h2.Persona = p2.CodiceFiscale ∧
      h1.Ditta = h2.Ditta
  )
}
```

Si leggono le condizioni nell'ordine:

1. `p1` e `p2` sono persone registrate e distinte. L'ordinamento `<` fa apparire la coppia una volta sola.
2. `∃ a1 ∃ a2 (...)` dice che esistono due righe di `HaAbitato`, una per ciascuna persona, con lo stesso valore `Citta`. Non c'è alcun confronto tra `DaAnno` e `AdAnno`, quindi le persone possono aver abitato lì in periodi diversi.
3. `¬∃ h1 ∃ h2 (...)` dice che non esistono due righe di `HaLavorato`, una per ciascuna persona, con la stessa `Ditta`. La negazione si applica all'intera condizione tra parentesi: se anche una sola ditta fosse comune, la coppia sarebbe esclusa.

La differenza rispetto all'algebra è solo nel modo di esprimere la richiesta: l'algebra costruisce gli insiemi e poi li sottrae; il calcolo descrive direttamente le proprietà che le tuple della risposta devono avere.

#### 2.2.4 Ditte con sede in tutte le città registrate

Nelle lezioni le formule si costruiscono con `∧`, `∨`, `¬`, `∃` e `∀`. Scrivo quindi «per ogni città registrata» usando l'equivalenza `P → Q` = `¬P ∨ Q`.

```text
{ d.PIVA |
  Ditta(d) ∧
  ∀ c (
      ¬Citta(c) ∨
      ∃ s (
          HaAvutoSede(s) ∧
          s.Ditta = d.PIVA ∧
          s.Citta = c.Nome
      )
  )
}
```

`∀ c` considera le possibili tuple `c`. Se `c` non appartiene alla relazione `Citta`, `¬Citta(c)` rende vera la disgiunzione e quella tupla non impone condizioni. Se `c` è una città registrata, la prima parte è falsa, quindi deve valere la seconda: deve esistere una riga `s` in `HaAvutoSede` che leghi quella città alla ditta `d`. Questo controllo si ripete per ogni città registrata.

La divisione del punto 2.1.4 e questa formula esprimono la stessa condizione universale: entrambe richiedono una sede della ditta in ogni città della relazione `Citta`.

## Esercizio 3

Si assume che `A → S(B)` indichi un vincolo di integrità referenziale da `R(A)` a `S(B)`, come nella notazione delle lezioni.

| Affermazione | Esito | Motivazione |
|---|---|---|
| **3.1** Se `A → S(B)` è un vincolo di integrità referenziale, `B` è una chiave candidata. | **Vera** | Gli attributi referenziati in `S` identificano le tuple della relazione di destinazione; nella notazione del corso sono una chiave candidata. |
| **3.2** Se `A → S(B)` è un vincolo di integrità referenziale, `A` è una chiave candidata. | **Falsa** | `A` è una chiave esterna, ma può ripetersi in più tuple di `R`; il vincolo non impone che identifichi una tupla di `R`. |
| **3.3** `X` è una chiave candidata di `R`. | **Falsa** | `X` è una superchiave, ma può contenere attributi ridondanti se un suo sottoinsieme è già una superchiave. |
| **3.4** `X` è una superchiave di `R`. | **Vera** | L’insieme di tutti gli attributi identifica una tupla; due tuple distinte non possono coincidere su tutti gli attributi. |
| **3.5** Se `Y` è una superchiave e `Z` è una chiave candidata, allora `Y ⊇ Z`. | **Falsa** | Una superchiave contiene almeno una chiave candidata, ma non necessariamente la chiave candidata `Z` scelta nell’affermazione. |
| **3.6** Se `Y` è una superchiave e `Z` è una chiave candidata, allora `|Z| ≤ |Y|`. | **Falsa** | Chiavi candidate diverse possono avere cardinalità diverse. Per esempio, `A` e `{B,C}` possono essere entrambe chiavi candidate; `Y={A}` è una superchiave e `Z={B,C}` è una chiave candidata, ma `|Z|>|Y|`. |

## Approfondimento su chiavi e vincoli

Questa sezione riprende le assunzioni sulle chiavi e spiega il ragionamento dei vero/falso.

### Esercizio 1: perché queste chiavi

Una chiave deve distinguere una riga da tutte le altre. `CodiceFiscale`, `Nome` e `PIVA` sono assunti identificativi rispettivamente di persona, città e ditta. Nelle relazioni storiche, invece, una coppia di entità potrebbe ricomparire in periodi distinti. Per esempio, una persona può abitare a Roma, trasferirsi e tornarci: la coppia (`Persona`, `Citta`) da sola non distinguerebbe i due periodi. Aggiungere `DaAnno` permette di registrarli entrambi, se iniziano in anni diversi.

Gli attributi `Persona` e `Citta` in `HaAbitato` sono chiavi esterne: ciascun valore non nullo deve trovare una riga corrispondente nelle relazioni `Persona` e `Citta`. Non sono chiavi candidate di `HaAbitato` da soli, perché molte righe possono riferirsi alla stessa persona o città.

Nel DDL, `PRIMARY KEY` impone unicità e non nullità. `FOREIGN KEY ... REFERENCES` impone il riferimento valido. `ON DELETE CASCADE` significa che la cancellazione della riga referenziata si propaga alle righe figlie; `ON UPDATE CASCADE` propaga analogamente il cambiamento della chiave. `CHECK` controlla una condizione sui valori della singola riga, qui la non negatività e l'ordine degli anni. Il testo non specifica l'azione richiesta in caso di violazione: la cascata è una scelta esplicita tra le politiche viste a lezione.

### Esercizio 3: superchiave e chiave candidata

Una superchiave identifica le righe; una chiave candidata è una superchiave minimale. Minimalità vuol dire che togliendo anche un solo attributo non si ottiene più una superchiave.

- In 3.3, l'insieme completo `X` è certamente una superchiave, ma non si può garantire che sia minimale: se una sola colonna di `X` identificasse già le righe, `X` non sarebbe candidata. Perciò l'affermazione non è vera in generale.
- In 3.4, usando la definizione insiemistica di relazione, due tuple distinte non possono coincidere su tutti gli attributi. Quindi `X` è superchiave.
- In 3.5, una superchiave contiene almeno una chiave candidata, ma potrebbe contenerne una diversa da `Z`. Le chiavi candidate alternative non devono contenersi a vicenda.
- In 3.6, una superchiave può essere piccola se contiene una chiave candidata piccola, mentre un'altra chiave candidata può avere più attributi. Esempio: `A` e `{B,C}` sono entrambe candidate; `{A}` è una superchiave, quindi scegliendo `Y={A}` e `Z={B,C}` si ha `|Z|=2` e `|Y|=1`.

Per 3.1, il riferimento deve puntare ad attributi univoci nella relazione di destinazione: altrimenti un valore della chiave esterna potrebbe corrispondere a più righe. Nella notazione delle lezioni, gli attributi referenziati costituiscono una chiave candidata. Per 3.2, invece, il vincolo non impone unicità nella relazione che contiene la chiave esterna: più righe possono riferirsi alla stessa riga bersaglio.
