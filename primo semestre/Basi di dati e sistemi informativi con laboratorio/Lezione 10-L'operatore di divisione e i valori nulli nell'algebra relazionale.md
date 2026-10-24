# L'operatore di divisione e i valori nulli nell'algebra relazionale

## L'operatore di divisione

La divisione (cfr. [[Lezione 7-Algebra relazionale|Algebra relazionale]]):
- è un operatore derivato dell'algebra relazionale;
- è un operatore binario;
- viene indicato con il simbolo $\div$;
- è la controparte algebrica della quantificazione universale.

*Definizione:* siano $R(X)$, $S(Y)$ due schemi di relazione tali che $Y \subset X$, e siano $r$, $s$ due istanze di $R$, $S$.

L'operazione di divisione $r \div s$ produce una relazione le cui tuple, se estese con una qualunque tupla del secondo operando, producono una tupla del primo operando:

$$
r \div s = \{t \mid \forall t_0 \in s : t \cup t_0 \in r\} = \{t \mid \{t\} \times s \subseteq r\}
$$

La divisione $r \div s$ è dunque definita sugli attributi $X \setminus Y$.

> [!info] In altre parole:
> Il risultato sono i valori del primo operando che valgono per tutte le combinazioni richieste dal secondo.

*Esempio proprio:* si hanno le relazioni Fornisce(F#, P#) e Prodotto(P#):

| F# | P# |
| --- | --- |
| F1 | P1 |
| F1 | P2 |
| F2 | P1 |
| F3 | P3 |

| P# |
| --- |
| P1 |
| P2 |

Con $X = \{F\#, P\#\}$ e $Y = \{P\#\}$, la divisione è definita su $X \setminus Y = \{F\#\}$: restituisce i fornitori che forniscono tutti i prodotti elencati in $s$.

- il risultato è $\{F1\}$: F1 fornisce P1 e P2;
- F2 fornisce solo P1, F3 solo P3: nessuno dei due va bene.

### Derivazione della divisione

La divisione si deriva dagli operatori dell'algebra relazionale di base:
- proietto su $Z = X \setminus Y$ il primo operando: $T_1(Z) \leftarrow \pi_Z(R)$;
- costruisco l'universo $U$: $U(X) \leftarrow T_1 \times S$;
- individuo le tuple da non ammettere nel risultato: $T_2(Z) \leftarrow \pi_Z(U \setminus R)$;
- ottengo il risultato: $Ris(Z) \leftarrow T_1 \setminus T_2$.

Il passaggio chiave è la costruzione dell'universo $U$: si mettono in fila tutte le combinazioni possibili fra i valori del primo operando e le tuple del secondo, e si tolgono quelle che non compaiono in $r$.

I valori superstiti sono proprio quelli che ammettono ogni coppia.

*Sull'esempio:*
- $T_1 = \{F1, F2, F3\}$;
- $U = T_1 \times s$: tutte e sei le coppie (F1,P1), (F1,P2), (F2,P1), (F2,P2), (F3,P1), (F3,P2);
- $U \setminus r$: (F2,P2), (F3,P1), (F3,P2), da cui $T_2 = \{F2, F3\}$;
- risultato: $T_1 \setminus T_2 = \{F1\}$.

## I valori nulli nell'algebra relazionale

La presenza di valori nulli richiede un'estensione della semantica degli operatori. L'approccio tradizionale, usato nei DBMS relazionali e in SQL, è una logica a tre valori per valutare le formule proposizionali, e quindi selezione e join.

**Proiezione, unione, intersezione e differenza:** non risentono dei valori nulli. L'uguaglianza fra null è a livello sintattico e due tuple sono uguali anche se ci sono valori nulli: il null è qui un valore come un altro.

*Esempio:* siano $r = \{(1, a, ?), (2, b, 3)\}$ e $s = \{(1, a, ?)\}$. L'unione $r \cup s$ contiene due tuple, l'intersezione $r \cap s$ ne contiene una, la differenza $r \setminus s$ contiene $(2, b, 3)$.

La distinzione è essenziale: l'uguaglianza usata da $\cup$, $\cap$ e $\setminus$ è sintattica, mentre il predicato $x = y$ valutato in una selezione o in un join dà ? se uno dei due valori è null.

### Selezione e valori nulli

Per la selezione il problema è stabilire se, in presenza di null, un predicato è vero oppure meno per una data tupla: per valutare questi predicati si introducono i tre valori Vero (V), Falso (F) e Indefinito (?).

I confronti d'uguaglianza con un valore null danno ?:

Nelle tabelle seguenti le righe sono il valore di $x$, le colonne il valore di $y$.

| $x = y$ | V | F | ? |
| --- | --- | --- | --- |
| **V** | V | F | ? |
| **F** | F | V | ? |
| **?** | ? | ? | ? |

Gli ordinamenti si comportano come l'uguaglianza: il confronto $x \theta y$ è ? se $x$ è ? oppure $y$ è ?. Vale per ogni ordinamento definito sul dominio $D$ ($<$, $>$, $\leq$, $\geq$).

Sugli operatori booleani la logica a tre valori dà:

| $\wedge$ | V | F | ? |
| --- | --- | --- | --- |
| **V** | V | F | ? |
| **F** | F | F | F |
| **?** | ? | F | ? |

| $\vee$ | V | F | ? |
| --- | --- | --- | --- |
| **V** | V | V | V |
| **F** | V | F | ? |
| **?** | V | ? | ? |

La negazione è $\neg V = F$, $\neg F = V$, $\neg ? = ?$.

> [!warning] Attenzione:
> Con ∨ una formula può essere ? anche quando nessuna delle due parti è falsa: ? non è F, quindi una parte falsa non basta a escludere la tupla. Con ∧ invece F ∧ ? = F, e la tupla viene esclusa.

La selezione $\sigma_F$ produce le sole tuple per cui la condizione $F$ risulta vera (V): quelle con $F = ?$ e con $F = F$ vengono scartate.

Per lavorare esplicitamente con i null si introducono le condizioni atomiche `a IS NULL` e `a IS NOT NULL`.

*Esempio:* sulla relazione Impiegati(Matricola, Cognome, Città, Stipendio):

| Matricola | Cognome | Città | Stipendio |
| --- | --- | --- | --- |
| 1 | Rossi | Milano | 2000 |
| 2 | Bianchi | ? | 2500 |
| 3 | Verdi | Roma | ? |
| 4 | Neri | ? | ? |

- $\sigma_{\text{Città} = \text{Milano}}$ dà solo la tupla 1: per la 2 la condizione è ?, non V;
- $\sigma_{\text{Stipendio} > 2200}$ dà la tupla 2: per la 3 il confronto è ? perché lo stipendio è null;
- $\sigma_{\text{Città} \text{ IS NULL}}$ dà le tuple 2 e 4, $\sigma_{\text{Stipendio} \text{ IS NOT NULL}}$ dà le tuple 1 e 2;
- $\sigma_{\text{Città} = \text{Milano} \vee \text{Stipendio} > 2200}$ dà le tuple 1 e 2: per la tupla 1 vale V $\vee$ F = V, per la 2 ? $\vee$ V = V, per la 3 F $\vee$ ? = ? e per la 4 ? $\vee$ ? = ?, quindi 3 e 4 restano fuori.

> [!example] Condizioni complesse con `IS NULL`
> Sulla stessa tabella `Impiegati`, consideriamo:
> - $\sigma_{\text{Città IS NULL} \wedge \text{Stipendio IS NOT NULL}}$ → tuple 2 (Bianchi): ? $\wedge$ V = ? per la 2? No: Città IS NULL è V per 2 e 4, Stipendio IS NOT NULL è V per 1 e 2. Quindi V $\wedge$ V = V solo per la 2.
> - $\sigma_{\text{Città = Milano} \vee \text{Stipendio IS NULL}}$ → tuple 1, 3, 4: per 1 V $\vee$ F = V; per 2 ? $\vee$ F = ?; per 3 F $\vee$ V = V; per 4 ? $\vee$ V = V.
> - $\sigma_{\neg(\text{Stipendio} > 2000)}$ → tuple 3, 4: per 1 $\neg$V = F; per 2 $\neg$V = F; per 3 $\neg$? = ? (scartata); per 4 $\neg$? = ? (scartata). *Attenzione:* $\neg$? = ?, non V, quindi le tuple con stipendio null non passano nemmeno la negazione.

### Concatenazione e valori 3. nulli

Per il $\theta$-join valgono le stesse regole per la valutazione della condizione di join $F$ secondo la logica a tre valori. Il join naturale non combina due tuple se queste hanno entrambe valore nullo su un attributo in comune.

*Esempio:* su un'altra relazione, Dipendenti(Matricola, Cognome, CodiceSede, Stipendio), e su Sedi(CodiceSede, Città, Direttore):

| Matricola | Cognome | CodiceSede | Stipendio |
| --- | --- | --- | --- |
| 1 | Rossi | S1 | 2000 |
| 2 | Bianchi | ? | 2500 |
| 3 | Verdi | S2 | ? |

| CodiceSede | Città | Direttore |
| --- | --- | --- |
| S1 | Milano | Rossi |
| ? | Roma | Verdi |
| S2 | Napoli | Neri |

- la tupla 1 si accoppia con la sede S1: (1, Rossi, S1, 2000, Milano, Rossi);
- la tupla 3 si accoppia con la sede S2: (3, Verdi, S2, ?, Napoli, Neri);
- la tupla 2 non si accoppia a nulla: il confronto sul valore null è ?, e la condizione di join non risulta vera;
- nel join naturale, la coppia (2, Bianchi, ?, 2500) con (?, Roma, Verdi) non viene combinata: entrambe hanno null su un attributo in comune.

> [!example] Esempio aggiuntivo: θ-join con confronto su null
> Consideriamo un θ-join tra `Dipendenti` e `Sedi` sulla condizione `Dipendenti.Stipendio > Sedi.CodiceSede` (assurdo ma illustra il punto):
> - Tupla (1, Rossi, S1, 2000) con S1: confronto `2000 > 'S1'` → errore di tipo, ma se fosse numerico `2000 > 1` = V → si unisce.
> - Tupla (3, Verdi, S2, ?) con S2: confronto `? > 2` = ? → **non** si unisce (la condizione non è V).
> - Tupla (2, Bianchi, ?, 2500) con qualunque sede: `2500 > ?` = ? → mai vero.
>
> In generale: **qualsiasi confronto θ (<, >, ≤, ≥, =, ≠) dove uno degli operandi è null restituisce ?**, e la tupla viene esclusa dal join perché la condizione non risulta vera.

> [!info] Sintesi:
> - La divisione $\div$ è derivata e binaria, la controparte della quantificazione universale: dà le tuple del primo operando valide per tutte le tuple del secondo, ed è definita su $X \setminus Y$.
> - Derivazione: proiezione su $Z$, universo $U = T_1 \times S$, esclusione delle tuple da non ammettere $T_2 = \pi_Z(U \setminus R)$, risultato $T_1 \setminus T_2$.
> - Proiezione, unione, intersezione e differenza ignorano i null; l'uguaglianza fra null è puramente sintattica.
> - Selezione e join usano una logica a tre valori (V, F, ?): un predicato con null dà ? e la tupla è scartata, perché $\sigma_F$ tiene solo le tuple con $F = V$; `IS NULL` e `IS NOT NULL` servono a lavorare sui null.
> - Nel join naturale due tuple con null su un attributo in comune non vengono combinate: la condizione di join non risulta vera.
