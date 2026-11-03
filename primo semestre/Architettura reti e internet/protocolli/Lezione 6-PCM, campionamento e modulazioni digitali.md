# PCM, campionamento e modulazioni digitali

## Codifica PCM

Per realizzare la tecnica PCM si effettuano tre operazioni a partire dal segnale microfonico di partenza:

- Campionamento
- Quantizzazione
- Codifica

> [!example] Schema del PCM telefonico europeo a 32 canali
> ![[parte_6-04.png|500]]
> 
> Partendo dal teorema di Shannon, si definisce la minima frequenza necessaria per campionare un segnale senza perdere informazione, ovvero frequenza di Nyquist o cadenza di Nyquist. La minima frequenza di campionamento è pari al doppio della banda. Il segnale telefonico viene dunque per prima cosa campionato, poi viene sostituito dalla sequenza di impulsi PAM, ottenuti come in figura.

### Campionamento

*Teorema:* in base al teorema di Shannon, un segnale a banda limitata, compresa fra le frequenze f1 ed f2 (f2 > f1) può essere rappresentato mediante una successione di campioni prelevati con una frequenza pari almeno a 2f2.

In telefonia, ossia in rete PSTN (*Public Switched Telephone Network*), si assume come frequenza di campionamento il valore di:

$$f_c = 8\text{ kHz}$$

valore superiore di 1,2 kHz al valore minimo 2f2 = 6,8 kHz stabilito dal teorema di Shannon. Il periodo di campionamento corrisponde all'inverso della frequenza di campionamento:

$$T_c = \frac{1}{f_c}$$

Collegamento con quanto visto a lezione: il teorema di Nyquist-Shannon e il multiplexing (FDM, TDM, WDM, CDM) sono già stati introdotti in [[Lezione 1-Fondamenti di networking, teoria della comunicazione e standard|Lezione 1]].

### Quantizzazione

*Definizione:* affinché un dato possa essere trasmesso, deve essere quantizzato: bisogna cioè far in modo che possa assumere solo determinati valori discreti finiti. Si definisce inizialmente un minimo e un massimo, poi si passa a dividere l'intervallo così creato.

Nel caso della quantizzazione uniforme ogni sotto-intervallo è uguale a ogni altro sotto-intervallo. Detto n il numero di bit utilizzati:

- il suo numero di livelli sarà $M = 2^n$
- l'ampiezza di ogni livello sarà $q = Vpp / M$
- la varianza sarà $q^2 / 12$

Nella realtà, l'ampiezza dei livelli segue una funzione logaritmica.

Considerando che la quantizzazione è un processo irreversibile, occorre tenere conto che nello svolgerla si compie un errore, definito appunto **errore di quantizzazione**. Com'è intuibile, il segnale vocale può assumere infiniti valori, mentre la sua discretizzazione no. Tuttavia è provato che utilizzando 256 livelli di discretizzazione, l'equivalente di 8 bit, l'orecchio umano non percepisce sostanziali differenze.

> [!info] In altre parole:
> La quantizzazione approssima ogni campione al livello discreto più vicino. L'errore introdotto è tanto più piccolo quanti più bit si usano; con 8 bit (256 livelli) l'orecchio umano non distingue più la differenza.

### Codifica

Terza ed ultima fase è la codifica. In questa fase gli impulsi, campionati e quantizzati, vengono trasformati in sequenze di bit, cioè la loro ampiezza viene trasformata in una sequenza di bit secondo un codice binario. Ad esempio se l'ampiezza del primo impulso è 5 V, verrà rappresentata dalla sequenza binaria 101.

Nel PCM europeo occorrono 8 bit (256 livelli). Tra una sequenza di 8 bit e l'altra, ce ne sono 31 di 8 bit, dirette ognuna ad un canale telefonico.

Esempio: se vengono spediti 96 impulsi, il n. 0, il n. 32, il n. 64 saranno da vedersi consequenziali, come il 5, il 37 ed il 69; di questi 32 impulsi il n. 0 serve per dettare il sincronismo, mentre il n. 16 per il controllo della bontà di trasmissione degli altri canali. I canali “vocali” utili sono quindi 30, 2 sono di servizio. Vengono trasmessi 32 canali con 8000 campioni al secondo: ogni canale contiene 8 bit, ogni secondo quindi vengono trasmessi:

$$32 \times 8000 \times 8 = 2\,048\,000\text{ bit al secondo} = 2,048\text{ Mbit/s}$$

È possibile anche raggruppare più canali. Ad esempio raggruppando 4 gruppi da 30 e trasmettendo così 120 canali, costituendo un supergruppo del primo ordine. Si può operare similmente con gruppi da 480, 1920, 7680 canali.

## Modulazioni digitali

Si intendono tecniche che modulano segnali digitali, ossia 0 e 1 oppure −1 e +1.

**Modulazione per modem in banda base:** quando si parla di collegamenti tra due DTE, si parla non propriamente di modulazione, ma in maniera più esatta di codifica volta ad eliminare segnali di bassa frequenza e segnali in componente continua; il segnale rimane in digitale, ma con delle modifiche fatte alla portante rispetto al segnale modulante.

La modulazione è già stata introdotta come operazione reversibile in [[Lezione 5-Serie di Fourier, filtri e modulazione|Lezione 5]]: un segnale, definito portante, viene modificato in uno dei suoi parametri essenziali (frequenza, ampiezza o fase) in accordo al segnale informativo d'ingresso, chiamato modulante.

I principali tipi di modulazione digitale sono:

- **ASK** (*Amplitude-Shift Keying*), modulazione digitale di ampiezza
- **FSK** (*Frequency-Shift Keying*), modulazione digitale a spostamento di frequenza
- **PSK** (*Phase-Shift Keying*), modulazione digitale di fase
- **BPSK** (*BiPolar-Shift Keying*), modulazione digitale (bipolare) di fase
- **DPSK** (*Differential Phase-Shift Keying*), modulazione digitale (differenziale) di fase
- **QAM** (*Quadrature Amplitude Modulation*), modulazione di ampiezza in quadratura
- **Trellis**

### ASK (Amplitude-Shift Keying)

Nella modulazione ASK l'ampiezza della portante sinusoidale viene fatta variare in correlazione al segnale digitale modulante. Nel caso più semplice e più comune, in corrispondenza dello zero logico il segnale modulato ha ampiezza zero ed in corrispondenza dell'uno logico ha ampiezza pari a quella della portante non modulata. In questo caso si parla di modulazione **OOK** (*On-Off Keying*).

<div style="display: flex; justify-content: center;">
  <img src="parte_6-12.png" width="500">
</div>

Questo tipo di modulazione, derivato in maniera diretta dall'AM, è abbastanza semplice da realizzare ma non molto utilizzato per le trasmissioni dati a grande distanza a causa della sua notevole sensibilità al rumore.

Questo tipo di modulazione, di facile realizzazione sia nei modulatori che nei demodulatori, è stata usata sempre nelle telescriventi e in qualche tipo di ponte radio a breve distanza.

### FSK (Frequency-Shift Keying)

Nella modulazione digitale di frequenza FSK ad ogni simbolo logico viene assegnata una frequenza di valore compreso all'interno della banda passante del mezzo trasmissivo.

<div style="display: flex; justify-content: center;">
  <img src="parte_6-14.png" width="500">
</div>

Ad esempio all'uno logico può essere assegnata una frequenza fA mentre allo zero una frequenza fB che solitamente è di valore maggiore rispetto a fA.

La scelta delle due frequenze deve essere fatta in modo da realizzare il migliore compromesso tra quattro diverse esigenze:

- limitare l'occupazione della banda;
- ottenere una sufficiente separazione tra le due frequenze in modo da evitare l'interferenza intersimbolica;
- mantenere il periodo relativo alle due sinusoidi minore o uguale alla frequenza di bit dell'informazione digitale;
- mantenere una continuità di fase nelle variazioni di stato.

Quest'ultima condizione, assolutamente necessaria, è richiesta per il corretto funzionamento del circuito di demodulazione, il quale, essendo solitamente costituito da un rivelatore di passaggio per lo zero, deve essere in grado di identificare con massima precisione il salto di frequenza.

Questo tipo di modulazione è stata usata nei primi modem, V21 e V23 molto lenti rispetto a quelli odierni, ed è tuttora usata nei ponti radio e nelle trasmissioni fra cellulari del tipo GSM.

> [!example] FSK Full Duplex su una linea telefonica
> <div style="display: flex; justify-content: center;">
>   <img src="parte_6-17.png" width="500">
> </div>
> FSK Full Duplex su una linea telefonica: spettri dei segnali trasmessi in direzioni opposte su una linea voce (rame), con frequenze 1070, 1270, 2025, 2225 Hz.

### PSK (Phase-Shift Keying)

La modulazione PSK è una modulazione digitale di fase direttamente derivante dalla PM analogica. Nella PSK la portante è trasmessa con valori di frequenza e ampiezza costanti, mentre ciò che viene variato in relazione all'informazione digitale modulante è il valore della fase.

La modulazione digitale di fase può essere applicata in vari modi: il più semplice è quello denominato 2-PSK (o B-PSK – bipolar PSK), ma si utilizzano molto spesso anche la 2-DPSK, la 4-PSK, la 4-DPSK, la 8-PSK e la 8-DPSK, ognuna delle quali può essere realizzata a sua volta con diverse modalità.

### BPSK (2-PSK)

Nella modulazione 2-PSK la portante mantiene valori costanti per ampiezza e frequenza, ma assume due valori di fase a seconda del valore logico del bit del segnale modulante. Per garantire la massima protezione dal rumore e dalle interferenze vengono scelti i due valori di fase estremi 0° e 180°.

L'assegnazione di questi valori si può effettuare, ad esempio, in questo modo:

| Bit | Fase Φ |
|:---:|:---:|
| 1   | 0°     |
| 0   | 180°   |

<div style="display: flex; justify-content: center;">
  <img src="parte_6-19.png" width="500">
  <img src="parte_6-20.png" width="500">
</div>

La modulazione BPSK viene realizzata mediante il modulatore bilanciato con modulante numerica binaria: in tale modulatore quando il segnale modulante cambia stato (transizione 0-1 o 1-0) il segnale modulato cambia fase.

### 4-PSK (QPSK)

Nella modulazione digitale a quattro fasi (denominata anche QPSK, quadrature PSK) i bit del segnale dati vengono riuniti in coppie (dibit) utilizzate per modulare in fase la portante sinusoidale.

<div style="display: flex; justify-content: center;">
  <img src="parte_6-21.png" width="500">
</div>

Nei modulatori il flusso di dati in ingresso viene suddiviso in dibit da un convertitore seriale/parallelo (registro); i due bit di ogni coppia generano due flussi separati, a velocità dimezzata rispetto a quella del segnale dati originario, che costituiscono i segnali modulanti inviati in ingresso a due modulatori bilanciati. Le due portanti di modulazione hanno medesima frequenza ma le loro fasi differiscono di 90° (per questo vengono dette in quadratura). In pratica la fase del segnale in uscita dal primo modulatore può assumere i valori 0° e 180°, mentre quella del segnale in uscita dal secondo assume i valori 90° e 270°. Infine le due portanti vengono sommate originando un segnale che può assumere quattro fasi diverse (45°, 135°, 225°, 315°).

Il circuito sfasatore ha il compito di sfasare di 90° il segnale portante. Al blocco di separazione è applicato in ingresso il segnale modulante Vi che viene separato in bit pari e bit dispari; i bit di ordine pari P vengono inviati al moltiplicatore 1, mentre quelli di ordine dispari D vengono inviati al moltiplicatore 2. Il separatore inoltre associa allo stato logico basso il valore +1 e a quello alto il valore −1. In questo modo in uscita di ogni moltiplicatore otteniamo un segnale in fase con quello di entrata se il bit è al livello basso e sfasato di 180° se il bit è al livello alto.

### Diagrammi a costellazione

È una rappresentazione teorica del segnale, utilizzata solamente per una comprensione dello stato del segnale. Il segnale trasmesso in digitale è suddiviso in due segnali modulati che non interferiscono tra di loro perché in quadratura, denominati I e Q (*In-fase* e *Quadratura*). Si crea un diagramma con un piano cartesiano i cui assi saranno I e Q. A seconda dello schema di modulazione prescelto, i punti in cui il vettore si può trovare assumono la forma di una costellazione con punti più o meno fitti nel diagramma IQ.

<div style="display: flex; justify-content: center;">
  <img src="parte_6-24.png" width="500">
  <img src="parte_6-25.png" width="500">
</div>

Il problema è che, a causa del rumore o di altri fenomeni interferenti, nel momento della decisione da parte del ricevitore il vettore che rappresenta il segnale modulato ricevuto non si trova esattamente in uno dei punti della costellazione previsti teoricamente, ma un po' spostato da esso, tanto più spostato quanto più forti sono i disturbi o le non linearità della catena di trasmissione.

### Vettore errore

Il “vettore errore” rappresenta la differenza tra il punto teorico in cui si sarebbe dovuto trovare il segnale nel piano IQ nel momento della decisione del ricevitore e il punto reale in cui si trova quando viene visto dal ricevitore stesso.

<div style="display: flex; justify-content: center;">
  <img src="parte_6-26.png" width="500">
  <img src="parte_6-27.png" width="500">
</div>

Il vettore errore, come tutti i vettori, può essere descritto e caratterizzato dal suo modulo e dalla sua fase. Ripetendo la stessa osservazione per ogni simbolo trasmesso, si può ricavare un vettore errore per ogni simbolo trasmesso.

I vettori errore descrivono di quanto “balla” il segnale ricevuto nei dintorni del punto teorico nel quale dovrebbe trovarsi e, rappresentati sul diagramma IQ, formano una “nuvola” nei dintorni di ogni punto teorico della costellazione. Misurando tanti vettori errore, uno per ogni simbolo ricevuto, e prendendo in considerazione il valore quadratico medio del modulo degli stessi, si ricava il parametro che meglio descrive la qualità intrinseca della modulazione.

### EVM

Tale parametro si chiama **EVM** (*Error Vector Magnitude*) ed esprime in valore percentuale quanto è grande l'errore rispetto al segnale. Valori % più grandi di EVM indicano valori peggiori della qualità del segnale.

Attenzione, però, al fatto che l'EVM può essere definito, anziché come forma percentuale, anche come rapporto tra potenze. In tal caso, viene calcolato come rapporto espresso in dB tra il valore quadratico medio della potenza del vettore errore e il valore quadratico medio della potenza del segnale ideale di riferimento.

Sebbene anche in questo caso valori più grandi di EVM indichino valori peggiori della qualità del segnale, ricordatevi però che essendo i valori dell'EVM in generale piuttosto piccoli (l'errore nei sistemi reali è più piccolo del segnale utile, almeno si spera!), il rapporto espresso in dB diventa un numero negativo, tanto più negativo quanto migliore è il segnale.

Riassumendo:

- un valore EVM% di 0,10 (10%) rappresenta un segnale peggiore rispetto ad un altro con EVM% di 0,05 (5%);
- un valore EVM di −10 dB rappresenta un segnale peggiore rispetto ad un altro con EVM di −20 dB.

> [!info] Sintesi:
> - Il PCM si basa su tre fasi: campionamento (fc = 8 kHz in telefonia PSTN, sopra il minimo di Nyquist 2f2 = 6,8 kHz), quantizzazione (uniforme, $M = 2^n$ livelli, passo $q = Vpp/M$, errore varianza $q^2/12$) e codifica (8 bit per canale, 32 canali a 2,048 Mbit/s nel PCM europeo).
> - Le modulazioni digitali principali sono ASK (ampiezza, sensibile al rumore), FSK (frequenza, usata in V21/V23 e GSM), PSK (fase, con BPSK a 0°/180° e 4-PSK/QPSK a 4 fasi).
> - I diagrammi a costellazione rappresentano il segnale sul piano IQ; il vettore errore misura lo scostamento dal punto teorico e l'EVM ne esprime la qualità in percentuale o in dB (più negativo = migliore).
> - Nel PCM europeo 30 canali sono vocali utili e 2 sono di servizio (sincronismo e controllo).
