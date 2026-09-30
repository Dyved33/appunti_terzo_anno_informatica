# Lezione 1
Touring nel 1950 si chiedeva se una macchina potesse interagire con l'umano nel linguaggio dell'umano (e che pensano) 

L'IA generativa $\subseteq$ deep learning $\subseteq$ machine learning $\subseteq$ intelligenza artificiale

Per il machine learning il processo richiede dati e risposte attese (con esempi). Questi si danno in pasto all'algoritmo di apprendimento e da questo si ricava il modello

Addestrare = cercare i valori dei parametri che riducono l'errore sugli esempi e funzionano anche sui casi nuovi

N.B. Si tratta di un algoritmo iterativo quindi prima o poi termina (magari perché ha effettivamente finito oppure perché non vede che migliora)

Ricorda: non posso fare test sui dati che ho dato io (il training lo faccio sui dati assegnati) perché non si tratta di memorizzazione

Ricorda: per problema difficile addestro un grande modello con molti dati

Il modello da una probabilità a ogni risposta possibile; l'addestramento alza quella della risposta attesa 

A ogni passo un LLM fa una classificazione, in cui le "classi" sono le parole del vocabolario.

| Classificatore                                   | Pre-addestramento                             | Personalizzazione                                 |
| ------------------------------------------------ | --------------------------------------------- | ------------------------------------------------- |
| Una persona (l'"oracolo") etichetta ogni esempio | Nessuno: è la parola che segue, già nel testo | Di nuovo persone: esempi di risposte e preferenze |
Il principio è quello del classificatore, solo auto-supervisionato; le persone intervengono dopo, per personalizzare il modello.

Tipi di IA generativa:
- LLM: testo ->testo
- VLM: immagine + testo -> testo
- VLA: immagine + testo -> azioni
- Immagini: testo -> immagine

**Foundation model**: Un modello di base, adattato a molti compiti: così nascono anche molti VLM e VLA.

**Sistemi agentici**: Il modello pianifica e usa strumenti in più passi

![[Pasted image 20260930174136.png]]

La loss: è un numero che misura l'errore. Si rappresenta come una curva che scende e rappresenta l'apprendimento e tendenzialmente converge a 0. $$loss = -\ln(P)$$
Con P = la probabilità data alla risposta attesa

![[Pasted image 20260930175214.png]]

N.B. Ogni punto nello spazio della loss corrisponde ad un modello 

L'andamento di un ciclo di addestramento è: previsione su degli esempi, loss (confronto con risposte attese), gradiente (quanto cambiare i parametri), aggiornamento => poi i parametri restano fissi

N.B. Le reti neurali hanno la stessa idea dietro ma usano molti più parametri 

Dal testo ai numeri
Il testo diventa una sequenza di token e ogni token diventa un vettore di numeri, appreso in addestramento. La geometria dei vettori può codificare relazioni di significato.

Le parole simili in un certo contesto appaiono simili nello spazio vettoriale

Architettura Transformer
Dal 2017 ogni posizione può usare contemporaneamente tutte le precedenti, senza scorrere la sequenza parola per parola. 

In addestramento le posizioni si elaborano in parallelo: sono diventati possibili modelli e dati molto grandi 

![[Pasted image 20260930181234.png]]

A ogni passo, una distribuzione sul token successivo. Sempre il più probabile, come un classificatore: in linea di principio, stesso testo. Campionando, due esecuzioni possono divergere. La fluidità nasce da questo calcolo ripetuto: da sola non basta per attribuirgli affidabilità e facoltà umane.

Cambiando il modello e con la sua evoluzione:
- RESTA: Si apprende dai dati riducendo una loss, con la discesa del gradiente. 
- CAMBIA: La scala di dati, parametri e calcolo, le architetture (il Transformer), obiettivi e procedure di addestramento, i modi d’uso: istruzioni, documenti, strumenti

N.B. Più parametri: più capacità di rappresentare e generalizzare. Non un archivio di risposte, anche se alcuni dati restano memorizzati.

N.B. Leggere la fonte rende la risposta controllabile e, qui, anche più completa

![[Pasted image 20260930182802.png]]

Conta chi decide i passi: un sistema con documenti non è per forza un agente.