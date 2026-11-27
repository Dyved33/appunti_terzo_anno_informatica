# Traduzione del modello ER/EER in schemi relazionali

## Traduzione delle entità forti

*Definizione:* **Entità forte:** un tipo di entità che possiede una chiave primaria propria e non dipende da altre entità per essere identificato.

Per ogni tipo di entità (forte) E nello schema ER, si definisce una relazione R contenente gli attributi semplici di E. Si sceglie quale attributo chiave di E sarà la chiave primaria di R; se la chiave scelta è composta, l'insieme degli attributi semplici che la compongono formerà la chiave primaria di R.

*Esempio:* dallo schema ER si costruiscono le relazioni IMPIEGATO, DIPARTIMENTO e PROGETTO, con chiavi primarie rispettivamente SSN, NUMERO D e NUM D.

![[bd-esempio-er-09.png|500]]

![[Pasted image 20261127162723.png|500]]

## Traduzione delle entità deboli

*Definizione:* **Entità debole:** un tipo di entità che non dispone di una chiave primaria propria e deve fare riferimento all'entità proprietaria per essere identificata.

Per ogni entità debole W con entità proprietaria E, si definisce una relazione R inserendone gli attributi semplici (o le componenti semplici degli attributi composti). Si inseriscono come attributi di chiave esterna di R gli attributi di chiave primaria della relazione che rappresenta l'entità proprietaria. La chiave primaria di R è data dalla combinazione delle chiavi primarie delle proprietarie e dalla chiave parziale di W.

*Esempio:* si costruisce la relazione PERSONA A CARICO, corrispondente al tipo di entità debole PERSONA A CARICO. SSN (chiave primaria dell'entità proprietaria IMPIEGATO) diventa chiave esterna di PERSONA A CARICO (rinominata SSN I, Impiegato, anche se non strettamente necessario). La chiave primaria di PERSONA A CARICO è la combinazione {SSN I, NOME PERSONA A CARICO}.

## Traduzione delle associazioni binarie 1:1

Per ogni associazione binaria R di tipo 1:1 nello schema ER, si individuano le relazioni S e T corrispondenti alle entità che partecipano ad R. Esistono tre approcci possibili.

1. **Basato su chiavi esterne:** si sceglie una delle due relazioni (es. S) e si inserisce in S come chiave esterna la chiave primaria di T.
   *Esempio:* l'associazione 1:1 DIRIGE viene mappata inserendo in DIPARTIMENTO la chiave primaria di IMPIEGATO (SSN, ridenominata SSN DIR) quale chiave esterna.

2. **Basato su unica relazione (fusione):** si fondono i due tipi di entità e l'associazione in un'unica relazione. Approccio adeguato quando entrambe le partecipazioni sono totali.

3. **Basato su relazione associazione:** si crea una terza relazione R allo scopo di definire un riferimento incrociato tra le chiavi primarie di S e T.

## Traduzione delle associazioni binarie 1:N

Per ogni tipo di associazione R binaria 1:N, si individuano la relazione S al lato N e la relazione T al lato 1. Si inserisce in S come chiave esterna la chiave primaria di T. Si inseriscono fra gli attributi di S gli attributi semplici (o componenti semplici di attributi composti) di R.

*Esempio:* con riferimento all'esempio, si traducono le associazioni 1:N LAVORA PER, CONTROLLA e SUPERVISIONE. Per l'associazione 1:N LAVORA PER si inserisce la chiave primaria NUMERO D di DIPARTIMENTO come chiave esterna di IMPIEGATO (rinominata N D).

## Traduzione delle associazioni binarie M:N

Per ogni associazione R binaria M:N, si costruisce una nuova relazione S che rappresenta R. Si inseriscono come attributi di chiave esterna di S le chiavi primarie delle relazioni che rappresentano le entità partecipanti (e determinano la chiave primaria di S). Si inseriscono fra gli attributi di S gli attributi semplici di R.

*Esempio:* si traduce l'associazione M:N LAVORA SU. Le chiavi primarie di PROGETTO e IMPIEGATO diventano chiavi esterne di LAVORA SU (e determinano la chiave primaria di S). Si inserisce un attributo ORE in LAVORA SU per rappresentare l'attributo corrispondente dell'associazione M:N.

## Traduzione degli attributi multivalore

Per ogni attributo multivalore A, si definisce una relazione R. R comprenderà un attributo corrispondente ad A, più l'attributo di chiave primaria K (come chiave esterna di R) della relazione che rappresenta l'entità o l'associazione di cui A è attributo. La chiave primaria di R è la combinazione di A e K. Se l'attributo è composto si considerano le componenti semplici.

*Esempio:* si costruisce la relazione SEDI DIP. SEDE D rappresenta l'attributo multivalore SEDI di DIPARTIMENTO; NUMERO D corrisponde a chiave primaria di DIPARTIMENTO. La chiave primaria di SEDI DIP è {NUMERO D, SEDE D}.

## Traduzione delle associazioni n-arie

Per ogni associazione n-aria R, n ≥ 2, si definisce una relazione S per rappresentare R. Si inserisce in S come attributi di chiavi esterne le chiavi primarie delle relazioni che rappresentano le entità partecipanti. Si inseriscono come attributi di S anche gli attributi semplici del tipo di associazione n-aria (o componenti semplici di attributi composti). La chiave primaria di S è di solito la combinazione di tutte le chiavi esterne che riferiscono le relazioni che rappresentano le entità partecipanti. Se E partecipa ad R con vincolo di cardinalità 1, la chiave primaria di S non deve comprendere l'attributo di chiave esterna referente la relazione corrispondente ad E.

> [!example]
> ![[Pasted image 20261127184949.png|500]]

## Riepilogo della corrispondenza tra modello ER e modello relazionale

| Costrutto ER | Costrutto relazionale |
|:---|:---|
| Entity type | Entity relation |
| 1:1 o 1:N relationship type | Foreign key (o *relationship relation*) |
| M:N relationship type | *Relationship relation* e due foreign key |
| *n*-ary relationship type | *Relationship relation* e *n* foreign key |
| Simple attribute | Attribute |
| Composite attribute | Insieme di attributi componenti semplici |
| Multivalued attribute | Relation e foreign key |
| Value set | Domain |
| Key attribute | Primary (o secondary) key |

## Mapping di specializzazione/generalizzazione

Si trasforma ogni specializzazione con m sottoclassi {S₁, …, Sₘ} e superclasse C (dotata di attributi {k, c₁, …, cₙ}, k chiave primaria) in schemi di relazione, usando una delle quattro opzioni seguenti:

- **8A – Relazioni multiple – superclasse e sottoclasse:** si costruisce una relazione L per C con attributi Attr(L) = {k, a₁, …, aₙ} e chiave primaria k. Si costruisce una relazione Lᵢ per ogni sottoclasse Sᵢ, con attributi Attr(Lᵢ) = {k} ∪ Attr(Sᵢ) e chiave primaria k. L'opzione si adatta a tutti i tipi di specializzazione.
- **8B – Relazioni multiple – solo relazioni di sottoclasse:** per ogni sottoclasse Sᵢ, si definisce relazione Lᵢ con attributi Attr(Lᵢ) = {k, a₁, …, aₙ} ∪ Attr(Sᵢ), chiave primaria k. Solo per specializzazioni con sottoclassi totali. Se la specializzazione è sovrapposta, un'entità può essere duplicata in più relazioni.
- **8C – Singola relazione con un attributo tipo:** si costruisce una singola relazione L con attributi Attr(L) = {k, a₁, …, aₙ} ∪ Attr(S₁) ∪ … ∪ Attr(Sₘ) ∪ t e chiave primaria k. L'attributo t è detto attributo tipo, indica la sottoclasse di appartenenza di ciascuna tupla, se specificata. L'opzione si adatta a specializzazioni con classi disgiunte, può generare molti valori nulli se nelle sottoclassi esistono molti valori specifici.
- **8D – Singola relazione con molti attributi tipo:** si costruisce una singola relazione L con attributi Attr(L) = {k, a₁, …, aₙ} ∪ Attr(S₁) ∪ … ∪ Attr(Sₘ) ∪ {t₁, …, tₘ} e chiave primaria k. Per ogni 1 ≤ i ≤ m, tᵢ è un attributo tipo booleano, che indica se una tupla appartiene alla sottoclasse Sᵢ. Opzione pensata per specializzazioni sovrapposte (si adatta anche a specializzazioni disgiunte).

**Esempio opzione 8A:** specializzazione definita dall'attributo `Job_type` su `EMPLOYEE` con sottoclassi disgiunte `SECRETARY`, `TECHNICIAN` ed `ENGINEER`. Si ottiene una relazione per `EMPLOYEE` e tre relazioni per le sottoclassi, ciascuna con chiave primaria e chiave esterna `Ssn` verso `EMPLOYEE`.

![[bd16-slide-58.png|500]]

![[bd16-slide-59.png|500]]

**Esempio opzione 8B:** generalizzazione totale e disgiunta di `CAR` e `TRUCK` nella superclasse `VEHICLE`. Poiché la partecipazione è totale, si mappano solo le relazioni di sottoclasse `CAR` e `TRUCK` includendo in entrambe gli attributi della superclasse (`Vehicle_id`, `License_plate_no`, `Price`).

![[bd16-slide-60.png|500]]

![[bd16-slide-61.png|500]]

**Esempio opzione 8C:** la stessa specializzazione disgiunta di `EMPLOYEE` (Figura 4.4 sopra) viene tradotta in un'unica relazione `EMPLOYEE` che raccoglie gli attributi comuni, l'attributo tipo `Job_type` e gli attributi specifici `Typing_speed`, `Tgrade` ed `Eng_type`.

![[bd16-slide-70.png|500]]

**Esempio opzione 8D:** specializzazione sovrapposta (`o`) di `PART` in `MANUFACTURED_PART` e `PURCHASED_PART`. Si costruisce un'unica relazione `PART` con gli attributi comuni, i due flag booleani `Mflag` e `Pflag` e gli attributi specifici di entrambe le sottoclassi (`Drawing_no`, `Manufacture_date`, `Batch_no`, `Supplier_name`, `List_price`).

![[bd16-slide-71.png|500]]

![[bd16-slide-72.png|500]]

## Gestione dell'ereditarietà multipla

Una sottoclasse condivisa come `STUDENTE ASSISTENTE` (`STUDENT_ASSISTANT`) è una sottoclasse di più superclassi (ereditarietà multipla). Ad una sottoclasse condivisa è possibile applicare una qualsiasi delle opzioni esaminate al passo 8.

*Esempio:* mapping del reticolo EER `UNIVERSITA` (Figura 4.8) mediante combinazione di più opzioni (Figura 7.6): `PERSON` ha sottoclassi sovrapposte `EMPLOYEE`, `ALUMNUS` (con attributo multivalore composto `Degrees` tradotto nella relazione `ALUMNUS_DEGREES`) e `STUDENT`; `EMPLOYEE` usa l'opzione 8C con `Employee_type` (includendo `Ra_flag` e `Ta_flag` per le sottoclassi di `STUDENT_ASSISTANT`), mentre `STUDENT` usa l'opzione 8D con i flag booleani `Grad_flag`, `Undergrad_flag` e `Student_assist_flag`.

![[bd16-slide-77.png|500]]

![[bd16-slide-78.png|500]]

