# Reti mesh, protocolli e segnali

## Reti mesh

Il mezzo di trasmissione radio è soggetto ad altissimo tasso di errore, quindi servono protocolli di routing ottimizzati per il mondo wireless. La maglia realizzata tra i *wireless router* e gli *access point* forma il *wireless backhaul multihop*, sistema di comunicazione che fornisce a ogni utente mobile servizi a basso costo di interconnessione multi-hop a banda larga con un numero limitato di punti di accesso a Internet. *Backhaul network* = rete dei nodi intermedi tra dorsale e nodi periferici. Mesh indica quindi una tecnologia nata per fornire una soluzione di comunicazione wireless in mobilità e a larga banda.

Mesh risolve le seguenti esigenze:
- Trasmissione in movimento a oltre 400 km/h
- Trasmissione simmetrica (fra uplink e downlink)
- Limiti della banda in strutture ad albero
- Reti ad-hoc senza infrastruttura
- Configurazione automatica
- Radiolocalizzazione senza GPS
- Resistenza alle interferenze
- 100% degli IP utilizzabili (in opposizione alle reti con IP specifici deputati a funzioni di broadcast o altro)
- Sicurezza nelle comunicazioni

**Wi-Fi vs mesh:** nelle reti Wi-Fi un guasto di un nodo di rete implica l'indisponibilità del servizio per tutti gli utenti sotto a quel nodo; nelle reti mesh si ha invece maggiore tolleranza ai guasti e maggiore flessibilità nella pianificazione e realizzazione. Di fatto l'infrastruttura mesh è una soluzione attraente dal punto di vista economico per realizzare reti wireless stabili broadband su larga scala. La maglia è la stessa topologia della [[Lezione 3-Tipi di connessione e topologie di rete|rete a maglia]].

## I protocolli

Il colloquio tra due [[Lezione 2-Codifica dei dati, flussi trasmissivi e valutazione delle prestazioni|DTE]] o DCE è governato da un insieme di regole che vanno sotto il nome di *protocolli*. Il compito dei protocolli è:
- gestire il flusso dei dati e i loro scambi
- controllare gli errori di trasmissione e provvedere alle correzioni
- provvedere alla sincronizzazione tra due DTE
- dare una struttura formale ai dati trasmessi che permetta di distinguerli da quelli di controllo

A seconda che la relazione tra stazioni DTE remote sia di tipo primario/secondario, alla pari o un ibrido tra le due, è possibile dividere i protocolli in:

**Ambito primario/secondario:**
- Polling/Selecting
- BSC
- HDLC
- SNRM
- RTS/CTS
- Xon/Xoff
- Stop and Wait
- ARQ

**Ambito delle relazioni ibride:**
- HDLC
- PPP
- MPLS

**Ambito delle relazioni peer to peer:**
- TDM, *Time Division Multiplexing*
- FDM, *Frequency Division Multiplexing*
- SDH, *Synchronous Digital Hierarchy*

## RTS-CTS

*Request-to-Send/Clear-to-Send* si basa sull'interfaccia RS-232 (interfaccia seriale): una stazione che vuole trasmettere invia un'apposita richiesta alla stazione master (attivando il segnale RTS); se il master può servire tale richiesta, autorizza la stazione a trasmettere (risposta CTS) sia il suo primo messaggio sia quelli successivi. Questa procedura, che si basa sulla rispondenza tra segnali con corretta temporizzazione, è chiamata *handshake*. Durante la trasmissione il master conserva la possibilità di interrompere il flusso per una qualsiasi ragione, rimuovendo lo stato RTS.

<div style="display: flex; justify-content: center;">
  <img src="slide-75.png" style="width: 50%;">
</div>

> [!note]
> Lo stato  ACK sta per acknowledgment e si tratta di  un'informazione dal ricevente al mittente dopo una recezione di dati con successo
## Xon-Xoff

Tipicamente usato tra computer e terminali posti vicini tra loro: i codici Xon e Xoff corrispondono a due distinte configurazioni del [[Lezione 2-Codifica dei dati, flussi trasmissivi e valutazione delle prestazioni|codice ASCII]] usato dalle stazioni.

La stazione primaria invia dati a un terminale, che li memorizza per poterli utilizzare; se la memoria del terminale si riempie, il terminale invia il carattere XOFF, che impedisce l'emissione di nuovi blocchi; appena il DTE torna in grado di memorizzare, invia il carattere XON e la stazione primaria riprende a trasmettere.

<div style="display: flex; justify-content: center;">
  <img src="slide-77.png" style="width: 50%;">
</div>

## ARQ

*Automatic Repeat ReQuest*, noto anche come *Automatic Repeat Query*, è un protocollo full duplex. Utilizzando il concetto di finestra (scorrevole) può migliorare l'efficienza della trasmissione, cioè sfruttare meglio il canale. Il messaggio spedito viene diviso in sequenze di frame: il protocollo prevede di spedire più frame prima di ricevere un qualsiasi riscontro. Quest'ultimo può essere costituito da due numeri di sequenza (0 e 1), poiché è sufficiente distinguere un frame da quello successivo. Nel caso di più frame inviati contemporaneamente occorrono $m$ bit, che permettono di distinguere fino a $2^m$ sequenze (da 0 a $2^m - 1$).

La finestra del mittente specifica i frame che il mittente può spedire in quel momento; la finestra del destinatario specifica i frame che il destinatario può ricevere nel dato momento. Nelle metodologie di gestione dell'errore è possibile adottare:
- **Go-Back-N**: Il mittente invia una finestra di dimensione N; in caso di errore o perdita di un pacchetto, deve **ritrasmettere tutti i pacchetti** dalla posizione dell'errore in poi. Il ricevitore scarta i pacchetti fuori sequenza.
- **Selective Repeat (SR)**: Il mittente e il ricevitore mantengono finestre di dimensione W. Il ricevitore accetta e memorizza i pacchetti fuori sequenza; in caso di errore, il mittente ritrasmette **solo il pacchetto specifico** perso.
- **Stop and Wait**: Considerato il caso base con finestra di dimensione **1**, dove si attende l'ACK prima di inviare il frame successivo.

<div style="display: flex; justify-content: center;">
  <img src="slide-80.png" style="width: 50%;">
</div>

<div style="display: flex; justify-content: center;">
  <img src="slide-81.png" style="width: 50%;">
</div>

## La trasmissione dati

La principale funzione dello strato fisico è quella di trasportare dati; perché questo avvenga, i segnali devono essere in qualche modo adattati al trasporto. I segnali possono essere sia analogici che digitali:
- un segnale *analogico* è inteso come una rappresentazione continua nel tempo
- un segnale *digitale* si riferisce a una rappresentazione discreta

Ogni tipo di dato può essere rappresentato nei due modi, ma nei DTE si usa una rappresentazione digitale: ogni dato viene trascritto sotto forma di sequenze di 0 e di 1.

Il trattamento cui sottoporre questi dati è di due tipi:
1. conversione in un differente tipo di segnale digitale
2. conversione in un segnale analogico (modulazione)

Come i dati che rappresentano, anche i segnali possono essere sia analogici che digitali:
- un segnale analogico avrà per definizione infiniti livelli di intensità
- un segnale digitale avrà solo i livelli 0 e 1

## Segnali sinusoidali

Un segnale sinusoidale è un segnale che varia nel tempo secondo una legge del tipo:

$$u = U \sin(\omega t + \varphi)$$

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-84.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  dove t è il tempo trascorso, ω è la velocità angolare e φ è il cosiddetto sfasamento o fase. La curva descritta dal segnale nel tempo prende il nome di sinusoide.
  </div>
</div>

Applicando le proprie conoscenze di trigonometria si riconosce che tale curva rappresenta, istante per istante, il valore del seno dell'angolo descritto da un segmento che ruota con un estremo vincolato all'origine degli assi cartesiani, in senso antiorario e con velocità di rotazione angolare ω.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-85.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  U rappresenta l'ampiezza del segmento, quindi l'ampiezza massima del segnale. La quantità φ rappresenta lo sfasamento, cioè l'angolo che il segmento rotante forma con l'asse x all'istante 0. Questo valore determina quanto vale il segnale in quell'istante: all'istante t = 0 avremo
  </div>
</div>

$$u(0) = U \sin(\omega t + \varphi) = U \sin\varphi$$

Poiché il segmento ruota, ritornerà ad un certo punto nella posizione di partenza, per cui il segnale sinusoidale riassumerà gli stessi valori. La velocità di rotazione angolare determina quindi il numero di volte che in un secondo il segmento effettua un giro completo e il segnale si ripete identicamente. Il numero di volte che il segmento effettua un giro completo prende il nome di frequenza $f$ e la sua unità di misura, l'inverso del tempo, prende il nome di Hertz = 1/t.

Dire che un segnale ha una frequenza di un kilohertz significa ad esempio che il segmento che ne descrive il comportamento nel tempo percorrerà la circonferenza completa 1000 volte al secondo, e quindi il segnale sinusoidale si ripeterà 1000 volte al secondo.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-87.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Poiché un angolo completo è pari a 2π, la velocità con cui il segmento percorre la circonferenza è data da 2πf. L'intervallo di tempo che passa prima che il segnale si ripeta identicamente prende il nome di periodo.
  </div>
</div>

Chiaramente il numero di periodi è pari alla frequenza, per cui la durata di ogni periodo è data dall'unità di tempo diviso la frequenza, cioè:

$$T = \frac{1}{f}$$

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-88.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Ad esempio un segnale con frequenza pari ad 1 kHz ha periodo di 1/1000 secondi = 1 millisecondo. Altra caratteristica fondamentale di un segnale è la sua lunghezza d'onda λ, che mette in relazione la frequenza e la velocità di trasmissione, secondo:
  </div>
</div>

$$\lambda = \frac{c}{f}$$

dove $c$ è la velocità di propagazione del segnale (quella della luce è 300.000 km/sec).

Si può aggiungere che per un segnale elettrico si può anche parlare di spettro e di larghezza di banda. Lo spettro è l'insieme delle frequenze che il segnale contiene.

La larghezza di banda è l'intervallo delle frequenze contenute in un segnale composto. Se un segnale trasmette da 300 Hz a 3400 Hz, la sua larghezza di banda sarà 3400 − 300 = 3100 Hz.

> [!info] Sintesi:
> - Le reti mesh wireless sono auto-configuranti e multi-hop e tollerano i guasti meglio delle Wi-Fi: il guasto di un nodo non isola tutti gli utenti sotto di esso.
> - I protocolli governano il colloquio tra DTE/DCE: gestiscono il flusso e gli scambi, correggono gli errori, sincronizzano e danno struttura formale ai dati. Si dividono in ambito primario/secondario, ibrido e peer-to-peer.
> - RTS/CTS è un handshake basato sull'interfaccia RS-232; Xon/Xoff regola il flusso tra computer e terminale tramite due codici ASCII.
> - ARQ è full duplex e a finestra scorrevole: con Go-back-N un frame danneggiato fa ritrasmettere N frame, col metodo selettivo solo i frame danneggiati.
> - Lo strato fisico adatta i segnali al trasporto, convertendoli in un altro segnale digitale o in un segnale analogico (modulazione).
> - Un segnale sinusoidale segue $u = U\sin(\omega t + \varphi)$; frequenza $f$, periodo $T = 1/f$, lunghezza d'onda $\lambda = c/f$; spettro e larghezza di banda descrivono le frequenze contenute.
