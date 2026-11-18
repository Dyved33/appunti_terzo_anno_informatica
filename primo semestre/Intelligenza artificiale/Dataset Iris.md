# Dataset Iris (Scikit-learn)

Il **dataset Iris** è un dataset utilizzato frequentemente per studiare gli algoritmi di Machine Learning, in particolare i problemi di **classificazione supervisionata (Supervised Learning)**.

Contiene informazioni relative a 150 fiori appartenenti a tre specie:

- Iris Setosa
- Iris Versicolor
- Iris Virginica

## Caratteristiche del dataset

|Caratteristica|Valore|
|---|---|
|Samples (osservazioni)|150|
|Features (variabili indipendenti)|4|
|Target (variabile dipendente)|1|
|Classi|3|
|Osservazioni per classe|50|
|Valori mancanti|Nessuno|
|Tipo di problema|Classificazione multiclasse|

## Features (X)

Ogni fiore è descritto attraverso quattro misurazioni numeriche, espresse in centimetri:

1. `sepal length (cm)`: lunghezza del sepalo.
2. `sepal width (cm)`: larghezza del sepalo.
3. `petal length (cm)`: lunghezza del petalo.
4. `petal width (cm)`: larghezza del petalo.

Queste rappresentano le **variabili indipendenti (input)** utilizzate dal modello per effettuare la classificazione.

## Target (y)

La variabile target rappresenta la specie del fiore da prevedere:

|Valore|Classe|
|---|---|
|0|Setosa|
|1|Versicolor|
|2|Virginica|

Si tratta di un problema di **classificazione multiclasse**, poiché il modello deve assegnare ogni osservazione a una delle tre categorie.

## Caricamento con Scikit-learn

```
from sklearn.datasets import load_iris

iris = load_iris()

X = iris.data
y = iris.target
```

La funzione `load_iris()` restituisce un oggetto di tipo `Bunch`, simile a un dizionario, contenente:

- `iris.data`: matrice delle feature (150 × 4).
- `iris.target`: vettore delle etichette (150 elementi).
- `iris.feature_names`: nomi delle feature.
- `iris.target_names`: nomi delle classi.
- `iris.DESCR`: descrizione completa del dataset.

Per ottenere direttamente un DataFrame Pandas:

```
iris = load_iris(as_frame=True)

X = iris.data
y = iris.target
df = iris.frame
```

## Splitting del dataset (Train/Test Split)

Prima di addestrare un modello di Machine Learning, è necessario dividere il dataset in due sottoinsiemi:

- **Training set**: insieme di dati utilizzato per addestrare il modello, permettendogli di apprendere le relazioni tra features e target.
- **Test set**: insieme di dati utilizzato per valutare le prestazioni del modello su osservazioni che non ha mai incontrato durante l'addestramento.

La suddivisione permette di verificare la capacità di **generalizzazione** del modello, ovvero la sua capacità di effettuare previsioni corrette su nuovi dati.

### Esempio pratico

Una suddivisione comune è 80% training e 20% test.

Nel caso del dataset Iris:

|Sottoinsieme|Osservazioni|
|---|---|
|Training set (80%)|120|
|Test set (20%)|30|
|Totale|150|

Utilizziamo `train_test_split()` di Scikit-learn:

```
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(
    X, y,
    test_size=0.2,
    random_state=42,
    stratify=y
)
```

**Parametri principali:**

- `X`, `y`: rispettivamente features e target originali.
- `test_size=0.2`: assegna il 20% dei dati al test set.
- `random_state=42`: rende riproducibile la suddivisione casuale.
- `stratify=y`: mantiene nei due sottoinsiemi proporzioni simili delle tre classi.

**Risultato:**

- `X_train` e `y_train`: dati utilizzati per l'addestramento.
- `X_test` e `y_test`: dati utilizzati per la valutazione.

**Attenzione:** il test set non deve essere utilizzato durante l'addestramento. In caso contrario, la valutazione potrebbe risultare poco attendibile, perché il modello avrebbe già avuto accesso ai dati con cui viene valutato.

## Concetto fondamentale

Il modello riceve 4 misurazioni numeriche (X) e deve imparare a prevedere la specie del fiore (y).

Il dataset viene quindi suddiviso in training e test set: il primo serve per apprendere, il secondo per verificare quanto il modello sia effettivamente capace di classificare nuovi dati.

Fonte: [Documentazione ufficiale Scikit-learn – load_iris](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_iris.html)