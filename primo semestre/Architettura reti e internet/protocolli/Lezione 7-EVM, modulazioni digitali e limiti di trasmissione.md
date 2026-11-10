# EVM, modulazioni digitali e limiti di trasmissione

Il teorema di Nyquist-Shannon e il multiplexing (FDM, TDM, WDM, CDM) sono già stati introdotti in [[Lezione 1-Fondamenti di networking, teoria della comunicazione e standard|Lezione 1]]. La codifica PCM e le modulazioni digitali di base sono state trattate in [[Lezione 6-PCM, campionamento e modulazioni digitali|Lezione 6]].

## EVM

*Definizione:* il Bel è definito come il logaritmo del rapporto tra una grandezza X e il suo valore di riferimento X0. 1 Decibel è pari a 1/10 di Bel e il decibel relativo a una grandezza X generica viene espresso nella forma:

$$dB_x = 10 \log_{10}\left(\frac{X}{X_0}\right)$$

osservando che:
- quando $x \to 0 \Rightarrow$ logaritmo $= -\infty$
- quando $x = 1 \Rightarrow$ logaritmo $= 0$
- quando $x =$ valore della base $\Rightarrow$ logaritmo $= 1$

E ricordando le proprietà dei logaritmi:
- $\log_a(A/B) = \log_a(A) - \log_a(B)$
- $\log_a(A^b) = b \cdot \log_a(A)$

È facile intuire come valori sempre più negativi di EVM siano migliori.

<div style="text-align: center;">
  <img src="parte_7-slide-02.png" width="500" alt="Immagine" />
  <p>Definizione del decibel e proprietà del logaritmo applicate all'EVM.</p>
</div>

Con quale strumento si misura l'EVM? Sul mercato esistono numerose soluzioni, identificate con nomi anche diversi: analizzatore di segnali, analizzatore di modulazione, analizzatore vettoriale e così via. Molto comune è anche la versione software, in pratica un applicativo che viene utilizzato su analizzatori di spettro, digitalizzatori od oscilloscopi.

Il principio di funzionamento degli strumenti che misurano l'EVM è però simile: il segnale viene demodulato, dai dati demodulati lo strumento ricostruisce via software il segnale ideale che avrebbe dovuto essere ricevuto, dopodiché per differenza è in grado di ottenere il "segnale errore", la cui elaborazione matematica porta al risultato EVM cercato.

A seconda dello strumento, l'EVM può essere riportato in forma sintetica tabellare, in valore percentuale o in dB, oppure come grafico della sua evoluzione nel dominio del tempo al quale è associato il valore dell'EVM di ogni simbolo. Inoltre, alcuni strumenti riportano solo informazioni sul modulo del vettore errore, mentre altri sono in grado di analizzare anche la fase del vettore errore. Gli strumenti più sofisticati presentano spesso l'analisi dell'EVM insieme ad altri "domini" per comprendere meglio i fenomeni di modulazione.

<div style="text-align: center;">
  <img src="parte_7-slide-05.png" width="500" alt="Immagine" />
  <p>Strumenti di misura dell'EVM e principio di funzionamento.</p>
</div>

## Modulazione differenziale DPSK

Per evitare le enormi complicazioni che sarebbero necessarie per ottenere una fase di riferimento assoluta ($0^\circ$) nel ricevitore, di norma si utilizza una modulazione differenziale, ovvero sono i salti di fase che codificano i bit di informazione e non i valori assoluti.

*Definizione:* nella modulazione a spostamento di fase differenziale, in sigla DPSK, si fa corrispondere ai due livelli binari rispettivamente nessuna variazione di fase o variazione di $180^\circ$ rispetto alla segnalazione precedente. Il problema di individuare il valore della prima cifra ricevuta è facilmente risolto dall'invio di una sequenza prestabilita prima della comunicazione vera e propria.

Naturalmente un segnale DPSK, avendo lo stesso andamento di un segnale PSK, conserva le stesse caratteristiche spettrali di quest'ultimo. Quindi (nel caso a 4 fasi) si può associare la codifica dei due bit come segue:

- $00 =$ nessun salto di fase ($0^\circ$)
- $01 = 90^\circ$
- $10 = 180^\circ$
- $11 = -90^\circ$ (o $+270^\circ$)

<div style="text-align: center;">
  <img src="parte_7-slide-07.png" width="500" alt="Immagine" />
  <p>Confronto tra PSK e DPSK: salti di fase vs valori assoluti.</p>
</div>

## Modulazione QAM

Combinando la modulazione ASK e la PSK, si ottiene la modulazione di ampiezza in quadratura, chiamata così perché si può ottenere modulando in ampiezza due portanti della stessa frequenza, sommate in quadratura di fase (cioè sfasate di $90^\circ$); permettendo una codifica multilivello molto spinta, è utilizzata per trasmissioni veloci.

<div style="text-align: center;">
  <img src="parte_7-slide-08.png" width="500" alt="Immagine" />
  <p>Rappresentazione dell'EVM su diversi domini di analisi.</p>
</div>

## Modulazione 16-QAM

Nella modulazione 16-QAM (QAM a 16 livelli) i dati da trasmettere sono divisi in gruppi di quattro bit (quadribit).

Per effettuare una modulazione 16-QAM si fa variare la fase della portante (con la regola della 8-DPSK) a seconda dei tre ultimi bit componenti il quadribit, mentre il primo lo si utilizza per operare una modulazione di ampiezza sul segnale già modulato in fase. Così facendo si ottengono $2^3 = 8$ salti di fase, ad ognuno dei quali può essere associata un'ampiezza corrispondente all'uno o allo zero logico del primo bit.

L'ampiezza relativa al segnale modulato nelle varie fasi è descritta nelle raccomandazioni V.29 del C.C.I.T.T. e riportata nella tabella della prossima pagina.

<div style="text-align: center;">
  <img src="parte_7-slide-10.png" width="500" alt="Immagine" />
  <p>Definizione di modulazione QAM come combinazione di ASK e PSK.</p>
</div>

<div style="text-align: center;">
  <img src="parte_7-slide-11.png" width="500" alt="Immagine" />
  <p>Diagrammi temporali di codifica 16-QAM: variazione di ampiezza e fase.</p>
</div>

Il primo diagramma temporale rappresenta la codifica 0010 0011. Il primo quadribit differisce dal secondo solamente per l'ampiezza della portante mentre la fase, indicata dal punto rosso, rimane la stessa. Il secondo diagramma temporale rappresenta la codifica 0010 0000 0001. Le ampiezze dei quadribit sono rispettivamente 3, 5, 2, 3 V mentre le fasi sono 0° e 45°.

## Modulazione 64-QAM

È anch'essa una modulazione bidimensionale, che risulta dalla combinazione di due PAM modulate con portanti seno e coseno (ortogonali fra di loro). La 64-QAM è usata nell'ADSL.

<div style="text-align: center;">
  <img src="parte_7-slide-12.png" width="500" alt="Immagine" />
  <p>Definizione di modulazione 64-QAM.</p>
</div>

<div style="text-align: center;">
  <img src="parte_7-slide-13.png" width="500" alt="Immagine" />
  <p>Schema della modulazione 64-QAM.</p>
</div>

## Codifica Trellis

La modulazione binaria con memoria può essere rappresentata come una macchina a due stati $S_0$ e $S_1$; allo stato $S_0$ è associato il livello $-A$, mentre allo stato $S_1$ è associato il livello $+A$ (supponendo di avere un segnale PAM). Il bit 0 non fa cambiare stato, mentre il bit 1 fa cambiare stato. L'andamento temporale del segnale può essere rappresentato con un diagramma a "traliccio" (in inglese, trellis).

<div style="text-align: center;">
  <img src="parte_7-slide-14.png" width="500" alt="Immagine" />
  <p>Macchina a due stati e diagramma traliccio (Trellis) della codifica binaria con memoria.</p>
</div>

## Alterazione del segnale

Con alterazione del segnale si intendono tutti i processi di modifica del suddetto che lo portano a differenziarsi dal segnale originale. Le principali cause di deterioramento sono:

- Attenuazione
- Distorsione
- Rumore
- Interferenza

## Attenuazione

*Definizione:* per attenuazione si intende una perdita di energia del segnale, problema che può essere superato utilizzando dispositivi quali amplificatori; l'attenuazione (o la variazione in genere) del segnale è misurata in decibel, secondo:

$$dB = 10 \log_{10}\left(\frac{P_1}{P_2}\right)$$

dove $P_1$ rappresenta la potenza di output, mentre $P_2$ rappresenta la potenza di input.

Similmente è possibile ottenere la legge che governa la definizione di decibel per la tensione:

$$dB = 20 \log_{10}\left(\frac{V_1}{V_2}\right)$$

dove $V_1$ è la tensione iniziale del mezzo trasmissivo, mentre $V_2$ quella finale.

<div style="text-align: center;">
  <img src="parte_7-slide-17.png" width="500" alt="Immagine" />
  <p>Tabella di interpretazione dei valori di attenuazione su ADSL classica.</p>
</div>

Esempio di interpretazione: attenuazione su ADSL "classica" (fino a 8 Mbps in download):
- fino a 20 dB: perfetto, non si può ottenere di meglio
- 20 – 30 dB: eccellente
- 30 – 40 dB: molto buono
- 40 – 50 dB: buono/discreto
- 50 – 60 dB: appena sufficiente, possibili disconnessioni
- oltre 60 dB: pessimo, disconnessioni frequenti

<div style="text-align: center;">
  <img src="parte_7-slide-18.png" width="500" alt="Immagine" />
  <p>Attenuazione e rigenerazione del segnale.</p>
</div>

## Distorsione

*Definizione:* la distorsione è un cambiamento della forma del segnale, ed è tipica di un segnale costituito da varie frequenze. Ogni componente di un segnale può avere un suo ritardo all'arrivo, perciò si possono creare notevoli differenze tra la forma del segnale inviato e la forma del segnale giunto a destinazione. Essendo un disturbo intrinseco al sistema, svanisce quando questo è spento.

<div style="text-align: center;">
  <img src="parte_7-slide-19.png" width="500" alt="Immagine" />
  <p>Definizione di distorsione del segnale.</p>
</div>

<div style="text-align: center;">
  <img src="parte_7-slide-20.png" width="500" alt="Immagine" />
  <p>Interpretazione del segnale ricevuto con distorsione e soglia di riconoscimento.</p>
</div>

## Rumore

*Definizione:* il rumore è considerato l'insieme di segnali indesiderati che si sovrappongono al segnale utile: generalmente causati da processi naturali interni e/o esterni al sistema; la causa più comune della creazione del rumore è il rumore termico causato dai componenti elettronici del sistema.

Spesso viene utilizzato il rapporto segnale/rumore definito SNR (Signal to Noise Ratio) o S/N: è la grandezza che mette in relazione la potenza del segnale utile rispetto a quella del rumore:

$$SNR = \frac{P_{\text{segnale}}}{P_{\text{rumore}}}$$

<div style="text-align: center;">
  <img src="parte_7-slide-22.png" width="500" alt="Immagine" />
  <p>Tabella di interpretazione dei valori di SNR su ADSL classica.</p>
</div>

Esempio di interpretazione dei valori di SNR su ADSL "classica" (fino a 8 Mbps in download):
- fino a 6 dB: segnale assente/intermittente
- 7 – 10 dB: pessima qualità, connessione instabile
- 11 – 15 dB: segnale sulla soglia, controllare impianto e filtri
- 16 – 20 dB: segnale pulito, nessuna anomalia
- 20 – 28 dB: segnale ottimo
- oltre 28 dB: eccellente, molto vicini alla centrale

<div style="text-align: center;">
  <img src="parte_7-slide-23.png" width="500" alt="Immagine" />
  <p>Effetti del rumore e della distorsione sul segnale di partenza.</p>
</div>

## Interferenza

*Definizione:* l'interferenza è la sovrapposizione di informazioni non desiderate che crea disturbo nella corretta interpretazione di informazione; solitamente per interferenza si intende la contaminazione da parte di segnali esterni.

<div style="text-align: center;">
  <img src="parte_7-slide-24.png" width="500" alt="Immagine" />
  <p>Definizione di interferenza.</p>
</div>

L'Interferenza ISI (Inter Symbol Interference) o Intersimbolica è invece causata dalle limitazioni della banda, e provoca un arrotondamento dei segnali rettangolari emessi da un DTE.

<div style="text-align: center;">
  <img src="parte_7-slide-25.png" width="500" alt="Immagine" />
  <p>Interferenza intersimbolica (ISI) e arrotondamento dei segnali.</p>
</div>

## Limiti di velocità nel trasferimento

Un parametro molto usato in comunicazione dati è la velocità di trasferimento espressa in bit/sec. Supposto di lavorare su canali telefonici, si definiscono:

- canali perfetti: ossia senza distorsioni o ritardi nella propagazione del segnale;
- canali ideali: con solo un ritardo costante nella propagazione;
- canali reali: con attenuazioni e ritardi in funzione della frequenza dei segnali.

*Teorema di Nyquist:* Nyquist ha espresso un teorema che lega la larghezza di banda di un canale alla quantità di informazione trasportabile:

$$C_{\max} = 2B \cdot \log_2(V)$$

dove $B$ è la larghezza di banda del segnale e $V$ il numero di livelli di tensione differenti presenti nel segnale.

In teoria, aumentando $V$ si potrebbe aumentare il data rate, ma nella pratica aumentando i livelli si riduce l'affidabilità della comunicazione.

<div style="text-align: center;">
  <img src="parte_7-slide-27.png" width="500" alt="Immagine" />
  <p>Teorema di Nyquist sul massimo data rate.</p>
</div>

*Teorema di Shannon:* Shannon tiene conto anche del rumore:

$$C = B \cdot \log_2\left(1 + \frac{S}{N}\right)$$

dove $B$ è ancora una volta la larghezza di banda, $S$ e $N$ rispettivamente la potenza del segnale e la potenza del rumore.

Nella pratica si utilizza prima Shannon per valutare il Massimo Data Rate, che poi viene sostituito nella formula di Nyquist per ricavare il numero opportuno di livelli ($V$) da usare in un canale telefonico.

## Esempio numerico

Supponiamo di considerare un canale telefonico con banda da 300 a 3400 Hz ($B = 3100$ Hz).

**Canale privo di rumore (Nyquist):** usando una codifica multilivello, la massima velocità teorica è:

$$C_{\max} = 2B \log_2(V) = 2(3400 - 300) \log_2(V) = 6200 \cdot \log_2(V) \text{ b/s}$$

**Canale rumoroso (Shannon) con SNR = 36 dB:**

$$SNR = 36 \text{ dB} = 10 \log_{10}\left(\frac{S}{N}\right) \Rightarrow \frac{S}{N} = 10^{36/10} = 10^{3.6} \approx 3981$$

$$C_{\text{rum,max}} = B \log_2\left(1 + \frac{S}{N}\right) = 3100 \cdot \log_2(1 + 3981) \approx 37073 \text{ bit/s}$$

**Numero di livelli necessari** ($C_{\text{rum,max}} = C_{\max}$):

$$37073 = 6200 \cdot \log_2(V) \Rightarrow \log_2(V) = \frac{37073}{6200} \approx 6 \Rightarrow V \approx 2^6 = 64 \text{ livelli}$$
