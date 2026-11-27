# Multiplazione, modem e interfacce di collegamento

## Multiplazione

Per **multiplazione** si intende una tecnica che prevede l'utilizzo di uno stesso canale per più comunicazioni separate. Ne esistono tre tipi:

- FDM, *Frequency Division Multiplexing*
- WDM, *Wavelength Division Multiplexing*
- TDM, *Time Division Multiplexing*

### FDM — Frequency Division Multiplexing

Nella FDM le comunicazioni vengono *shiftate* (spostate ad una frequenza superiore, ognuna con un determinato gap) e inviate contemporaneamente. A destinazione si provvede a ripristinare la frequenza originale di ogni comunicazione. La tecnica FDM è ancora largamente utilizzata nella rete telefonica, specie per collegamenti a grandi distanze.

![[Pasted image 20261127185228.png|500]]

Considerando per la banda fonica una larghezza lorda B = 4 kHz (per la comunicazione vera e propria sono utilizzate le frequenze da 300 Hz a 3400 Hz), ciascun canale multiplato occuperà sul mezzo trasmissivo una banda di 4 kHz, distinta dalle bande relative agli altri canali. Il numero N di canali multiplabili dipende dalla capacità del mezzo trasmissivo di trasferire senza distorsioni un segnale complessivo con larghezza di banda:

$$B_T = N \cdot B = N \cdot 4\text{ kHz}$$

Il processo di traslazione della banda fonica (banda base) per ottenere N bande traslate è realizzato generalmente mediante modulazione di ampiezza di N portanti, dette anche frequenze vettori, con trasmissione della sola banda laterale superiore o inferiore (SSB).

In ricezione il segnale dovrà essere demultiplato: occorre filtrare le bande relative a ciascun canale e demodulare l'onda risultante per estrarre i segnali in banda base trasmessi. Nel sistema telefonico le frequenze delle varie portanti sono scelte con criteri che consentono, attraverso modulazioni e multiplazioni successive, di multiplare da un minimo di 12 fino a 2700 e anche 10800 canali telefonici. Il segnale multicanale FDM è un segnale di tipo analogico e quindi sensibile alle distorsioni e alle degradazioni dovute al rumore.

Lo schema di principio illustra la multiplazione di 12 canali telefonici: i segnali di ciascun canale vengono traslati in frequenza, modulati con portanti distanziate di 4 kHz (64, 68, …, 108 kHz). La banda del segnale trasmesso ha una larghezza BT = 12 × 4 kHz = 48 kHz.

![[slide_ret9-06.png|500]]

> [!info] In altre parole:
> La FDM sposta ogni conversazione su una propria sotto-banda di frequenza, così molti segnali viaggiano contemporaneamente sullo stesso mezzo senza sovrapporsi.

### WDM — Wavelength Division Multiplexing

Il **WDM** è utilizzato per i segnali ottici, poiché usare fibra ottica per una singola trasmissione significherebbe uno spreco enorme di larghezza di banda. Si modula la lunghezza d'onda del raggio luminoso, così da inviare diversi raggi contemporaneamente. Solo dal 1999 sono stati introdotti sistemi che potessero veramente valorizzare questa divisione di lunghezze d'onda.

![[Pasted image 20261127185313.png|500]]

### D-WDM — Dense Wavelength Division Multiplexing

Il **DWDM** è capace di modulare 16 lunghezze d'onda alla distanza di 0,8 nm; tali lunghezze d'onda sono modulate con flussi TDM e raggiungono la velocità di 1 Tb/s (cioè 10^12 bit/s).

![[Pasted image 20261127185335.png|500]]

### EDFA

Gli amplificatori in fibra drogata (DFA) sono amplificatori ottici che usano direttamente un tratto di fibra ottica drogata di lunghezza L come mezzo attivo per l'amplificazione di un segnale ottico. Il segnale utile che si vuole amplificare e un segnale ottico di pompa vengono multiplati in una fibra drogata ed il segnale ottico utile risulta amplificato per effetto dell'emissione stimolata di fotoni grazie all'interazione del segnale ottico di pompa con gli ioni del drogante.

![[Pasted image 20261127185356.png|500]]

### C-WDM — Coarse Wavelength Division Multiplexing

La variante *coarse WDM* (CWDM) è per reti metropolitane a basso costo (distanze tipiche di 60 km per segnali a 2,5 Gbps). CWDM utilizza maggiori spaziature tra i canali, con risparmio a livello economico: in CWDM la spaziatura tra bande è di circa 20 nm, con 20 frequenze da 1310 nm a 1610 nm. Con Ethernet 10GBase-LX4 si usano 4 di queste frequenze, ognuna capace di offrire 3,125 Gbps.

![[Pasted image 20261127185421.png|500]]

### TDM — Time Division Multiplexing

Il **TDM** prevede la temporizzazione dei segnali differenti: ciò è possibile solo se l'intervallo è trascurabile rispetto alla comunicazione in atto.

![[Pasted image 20261127185506.png|500]]

TDM può essere sincrono oppure statistico:

- In **TDM sincrono** gli intervalli vengono scelti indipendentemente dalla presenza di dati da spedire.
- In **TDM statistico** gli intervalli vengono allocati solo quando ci sono dati da spedire.

Pertanto un segmento/frame da inviare è diviso in un numero di parti uguali al numero di canali logici che possono essere usati. Nel TDM statistico non c'è sempre corrispondenza fra dato e canale i-esimo, cosa che invece avviene sempre nel caso del TDM sincrono; inoltre in quello statistico la velocità complessiva è solitamente minore della somma delle velocità dei canali.

![[slide_ret9-13.png|500]]

## Modem

**Modem** è la contrazione di modulatore/demodulatore. Il modem è un dispositivo che converte i segnali che arrivano dal DTE in segnali adatti alla trasmissione, solitamente linea telefonica. Proprio per questo motivo si parla di *modem fonici*, cioè nel range di frequenze 300 − 3400 Hz.

Un modem fonico svolge le seguenti funzioni:

- trasforma un segnale numerico dal DTE in segnale analogico per la linea telefonica;
- trasforma un segnale analogico proveniente dalla linea telefonica in segnale numerico adatto al DTE;
- gestisce i circuiti di comando e controlla l'interfaccia;
- corregge gli errori e analizza/comprende i dati che riceve.

![[Pasted image 20261127185544.png|500]]

Oltre ai modem fonici si considerano anche altri tipi di modem:

- modem ISDN (128 kbps)
- modem xDSL (da 640 kbps a 100 Mbps)
- modem per PLC — *Power Line Communications*, su linea elettrica (640 kbps − 200 Mbps)
- modem GPRS/UMTS/HSDPA/LTE, spesso integrati nei cellulari o come PC Card (56 kbps − 7,2 Mbps − 100 Mbps)
- modem in banda base, collega direttamente due utenti su doppino telefonico

Ognuno dei modem visti può essere interno o esterno, con gli svantaggi e i vantaggi del caso.

I modem (DCE) si suddividono in modem interni ed esterni. In base al tipo di collegamento al DTE:

**Modem esterni:**
- modem seriali (si collegano con cavo seriale alla COM1 o COM2)
- modem paralleli (si collegano con cavo parallelo alla LPT1 o LPT2)
- modem USB (si collegano con cavo USB ad una interfaccia USB)

In base al tipo di collegamento al DTE i modem interni sono:
- modem interni PCI (lavorano sul BUS PCI — *Peripheral Component Interconnect* — e sfruttano un driver software per la loro gestione)
- modem interni PCMCIA o PC Card o le più recenti ExpressCard (sviluppati dalla *Personal Computer Memory Card International Association*, vengono utilizzati solo nei PC portatili)

![[Pasted image 20261127185700.png|500]]

### Modem in banda fonica

![[Pasted image 20261127185949.png|500]]

Il modem fonico è l'apparecchio di interfacciamento tra DTE e linea telefonica. La banda disponibile è 4 kHz, per cui il segnale digitale (banda larga) non può essere efficientemente trasmesso (distorsione per attenuazione delle alte frequenze, bassissima velocità di trasmissione).

Il modem fonico opera una modulazione digitale allo scopo di comprimere la banda del segnale.

Velocità e modulazione:

- bassa velocità: fino a 1200 bit/s ⇒ modulazione FSK
- media velocità: fino a 4800 bit/s ⇒ modulazione PSK o DPSK
- alta velocità: oltre 9600 bit/s ⇒ modulazione QAM

Influenzano la velocità di trasmissione:

- il tipo d'esercizio (*simplex*, *half-duplex*, *full-duplex*): su due fili l'*half-duplex* dispone di 4 kHz di banda mentre il *full-duplex* dispone della metà;
- il tipo di trasmissione (*asincrona*, *sincrona*).

Lo standard delle tecniche di interfacciamento viene convenzionalmente stabilito dalla normativa internazionale dell'ITU (*International Telecommunication Union*), che fino al 1992 si chiamava CCITT (*Comité Consultatif International Téléphonique et Télégraphique*), nella quale ad ogni sigla corrisponde una precisa specifica di progetto.


![[Pasted image 20261127190041.png|500]]
### Standard per modem fonici

- **FSK V.21:** modem storico, primo nel mondo nella trasmissione dati, nei primi anni '80; successivamente si è passati al V.23, V.26, V.29…
- **QAM V.29:** trasmette usando una codifica multilivello su quattro bit (impacchettamento a quadribit) per una rete dedicata composta di 4 fili (2 linee telefoniche); lo spettro usato è di circa 2400 Hz, con portante di 1700 (±1) Hz.
- **QAM V.32:** trasmette in modalità sincrona con collegamenti punto-a-punto e *full-duplex*. Modulazione QAM, 2400 baud, codice quadribit su 16 livelli; velocità di trasmissione: 9600 bit/s. Il V.32, rispetto al V.29, implementa: *Codifica Trellis* e *Soppressione eco*.

#### Codifica Trellis

La codifica Trellis assicura una più alta immunità al rumore e un minor tasso d'errore: si aumenta la ridondanza della trasmissione, aggiungendo ai (ad esempio) quattro bit usati un quinto bit ridondante. Si ottiene una modulazione definita *TCM* (*Trellis Coded Modulation*) con una costellazione di 32 livelli, essendo 32 = 2^(4+1).

Caratteristica peculiare di questo sistema è il passaggio da una costellazione di una trasmissione non codificata ad una costellazione di cardinalità superiore. Rispetto alla classica QAM differisce nell'uso della codifica convoluzionale che compensa l'aumento della probabilità di errore dovuto all'aumentare del numero di stati di modulazione. Questo fa sì che in fase di decodifica sia possibile correggere le sequenze di simboli ricevute, così che gli errori possano essere eliminati.

![[Pasted image 20261127190129.png|500]]

La correzione degli errori viene attuata utilizzando *EVM* (*Error Vector Magnitude*) per il calcolo del codice corretto.

#### Soppressione dell'eco

La soppressione d'eco si realizza inviando in modalità *full-duplex* il segnale e una replica del segnale invertita: i modem possono così utilizzare la stessa portante e la stessa tecnica di modulazione.

#### Modem V.34

Il modem V.34 è utilizzato per collegamenti in cui entrambe le terminazioni alla linea sono analogiche.

- Velocità di 28800 bit/s (fino a 33600 bit/s in V.34bis)
- Utilizza:
  - codifica non lineare, per contrastare distorsione armonica e d'ampiezza;
  - codifica multidimensionale, tecnica che fa uso di più di un bit di ridondanza;
  - completo sfruttamento della banda disponibile, utilizzando le porzioni laterali della banda per avere decisivi aumenti della velocità di trasmissione.

#### Modem V.90

Il modem V.90 migliora le prestazioni del V.34 ponendo l'attenzione su tre tematiche:

- il flusso di dati verso la rete è minore che verso l'utente;
- il segnale verso l'utente è di tipo digitale (PCM), non affetto da rumore di quantizzazione nella conversione D/A;
- i modem V.34 non sfruttano pienamente la banda su connessioni parzialmente digitali (lato ISP).

Si è così riusciti a creare modem asimmetrici, con velocità di ricezione (56 kbps) notevolmente maggiore di quella di trasmissione (33,6 kbps).

#### Modem V.92

Il modem V.92 ha portato l'upstream a 48 kbps; introduce anche migliorie quali il *Quick Connect* (10 secondi per completare la connessione), la funzione *Modem-on-Hold*, che mantiene connessioni attive fino a 16 minuti, e modulazione a codifica adattativa (se la trasmissione risulta disturbata, si può modificare in tempo reale la codifica utilizzata).

A questa tecnica è possibile associare la codifica di canale sulle due varianti di correzione errore *FEC* (*Forward Error Correction*) e *ARQ* (*Automatic Repeat reQuest*). Di conseguenza gli utenti più vicini, avendo un valore più elevato di SNR (ovvero minore rumore rispetto al segnale) potranno fare ricorso a modulazioni più efficienti (16-QAM o 64-QAM), mentre utenti più lontani con SNR basso si dovranno accontentare di modulazioni meno efficienti (BPSK e QPSK).

## ADSL — Asymmetrical Digital Subscriber Line

Il doppino telefonico possiede una discreta banda passante che per le applicazioni di fonia viene limitata ai soli 4 kHz. Potendo "saltare" il filtraggio delle centrali telefoniche si disporrebbe di una grande banda.

Si fronteggiano due tecniche per modulare il segnale:

- la tecnologia CAP (*Carrierless Amplitude Phase*), che è una versione più sofisticata della classica QAM;
- il DMT (*Discrete MultiTone*).

![[Pasted image 20261127190213.png|500]]

Tale tecnologia (DMT) prevede di modulare opportunamente un insieme di 256 sottoportanti distanti 4,3125 kHz una dall'altra (32 o 64 per l'upstream) in modo da avere un segnale composito collocato nella banda 26 kHz–1,1 MHz.

![[Pasted image 20261127190232.png|500]]

In questo modo si può suddividere la banda del doppino in tre zone:

- una bassa fino a 4 kHz per la normale telefonia (POTS, non interessata al trasferimento dati);
- una media per l'upstream;
- una alta per il *downstream*.

![[Pasted image 20261127190256.png|500]]

Le velocità teoriche ottenibili (ADSL1) sono dell'ordine degli 8 Mbit/s dalla rete all'utente (*downstream*), e 800 kbit/s dall'utente alla rete (*upstream*), ma per il vecchio stato delle linee e per la bassa qualità del doppino già esistente il rateo può abbassarsi a circa 1,5 Mbit/s (download) e 256 kbit/s (upload).

Inizialmente questa tecnologia non era totalmente standardizzata e ogni costruttore proponeva la propria variante. Le linee guida sono dettate dallo standard ANSI T1.413 Issue 1, categorie 1 e 2 (comprensiva di codifica di Trellis e cancellazione d'eco). Lo standard ANSI T1.413 Issue 2 risolve le ambiguità della Issue 1 ammettendo la sola modulazione DMT, ed aggiunge la modalità di adattamento di rateo e la connessione a livello *internetworking* con reti ATM. L'ATM Forum ha riconosciuto ADSL come protocollo di livello 1 su doppino di rame UTP.

## Interfacce di collegamento

### Interfaccia Centronics (parallela)

È una interfaccia parallela ad 8 bit di tipo asincrona usata soprattutto per collegare un computer ad una stampante parallela. Il flusso di dati è tipicamente monodirezionale e va, naturalmente, dal computer alla stampante. Recentemente, grazie alla evoluzione della interfaccia, è possibile anche inviare sulle stesse linee dati che vanno dal dispositivo periferico al computer e ciò consente l'utilizzo di tale interfaccia anche per il collegamento di dispositivi di input come, ad esempio, lo scanner o la webcam.

Il connettore sul retro del computer è di tipo D a 25 poli femmina (DB-25).

![[Pasted image 20261127190347.png|500]]

Su un PC possono prendere posto fino a 3 interfacce parallele denominate LPT1, LPT2 e LPT3 (*Line Printer Terminal*). Ciascuna delle 3 LPT presenta 3 indirizzi contigui destinati alle periferiche di I/O. Alla LPT1 viene riservato l'interrupt IRQ7:

- Il registro base di indirizzo 888, denominato registro dati, contiene 8 bit di uscita dal PC.
- Il registro di indirizzo successivo 889, noto come registro di stato, è accessibile solo dall'esterno e solamente per 5 dei suoi 8 bit (occupata, carta esaurita, errore, ecc.).
- Il registro di indirizzo 890, noto come registro di controllo, rende disponibili 4 bit di uscita.

![[Pasted image 20261127190411.png|500]]

### Interfaccia RS232

Sul DTE (computer, ad esempio) si trova la spina (connettore maschio) mentre sul DCE (modem) si trova la presa (connettore femmina). In alcuni DCE (ad esempio, il mouse seriale) manca la presa esterna poiché il cavo di collegamento entra direttamente nell'apparecchiatura.

I tipici dispositivi periferici che si possono collegare ad un computer via RS-232 sono: stampante, modem, mouse, ecc.

In figura si mostra il connettore a 25 poli per la RS-232C le cui caratteristiche meccaniche sono normalizzate secondo lo standard ISO 2110 della *International Organization for Standardization*. In molte applicazioni pratiche non si utilizzano tutte le linee ma solo una piccola parte di esse. In tal caso si fa uso di un connettore ridotto a 9 poli. Connettore per la RS-232C: a) di tipo a 25 poli (DB-25); b) di tipo a 9 poli (DE-9 / DB-9).

![[slide_ret9-40.png|500]]

Il significato delle linee dell'interfaccia RS-232 / ITU V.24 (per connettori a 25 e 9 poli) è descritto in tabella:

| Pin 25 | Pin 9 | V.24 | RS-232 | Descrizione |
|:---:|:---:|:---:|:---|:---|
| 1 | — | C101 | FG | Frame Ground (Massa protez.) |
| 2 | 3 | C103 | TxD | Transmitted Data (Dati Tx) |
| 3 | 2 | C104 | RxD | Received Data (Dati Rx) |
| 4 | 7 | C105 | RTS | Request To Send (Richiesta Tx) |
| 5 | 8 | C106 | CTS | Clear To Send (Pronto a Tx) |
| 6 | 6 | C107 | DSR | Data Set Ready (DCE pronto) |
| 7 | 5 | C102 | GND | Ground (Massa dei segnali) |
| 8 | 1 | C109 | DCD | Data Carrier Detect (Portante) |
| 9 | — | — | — | Riservato per collaudo |
| 10 | — | — | — | Riservato per collaudo |
| 11 | — | C126 | CK | Scelta frequenza in Tx |
| 12 | — | C122 | SCF | Segnale Rx canale ausiliario |
| 13 | — | C121 | SCB | Pronto Tx canale ausiliario |
| 14 | — | C118 | SBA | Dati Tx canale ausiliario |
| 15 | — | C114 | TC | Transmit Clock (dal modem) |
| 16 | — | C119 | SBB | Dati Rx canale ausiliario |
| 17 | — | C115 | RC | Received Clock (Clock Rx) |
| 18 | — | — | — | Non connesso |
| 19 | — | C120 | SCA | Richiesta Tx can. ausiliario |
| 20 | 4 | C108 | DTR | Data Terminal Ready (DTE pronto) |
| 21 | — | C110 | CG | Rivelatore qualità segnale |
| 22 | 9 | C125 | RI | Ring Indicator (Chiamata) |
| 23 | — | C111 | CI | Selezione velocità da DTE |
| 24 | — | C113 | DA | Clock di Tx da DTE |
| 25 | — | — | — | Non connesso |
| 18–25 | — | — | — | GND (Massa di riferimento, 0V) |

Si descrivono le caratteristiche funzionali delle linee (circuiti) dell'interfaccia V.24 esaminate nella precedente tabella. Nella trasmissione dati tra un DTE e un DCE il numero di linee utilizzate dipende dal tipo di collegamento e dai modem impiegati.

- **C101** = Massa di protezione (FG): linea collegata alla massa dei segnali C102 all'interno del modem.
- **C102** = Massa dei segnali (GND): linea comune di riferimento per tutti i circuiti di interfaccia.
- **C103** = Dati in trasmissione (TxD, DTE → DCE): i dati binari in forma seriale generati dal DTE viaggiano verso il DCE. In assenza di trasmissione tale linea è nello stato MARK (tensione negativa).
- **C104** = Dati in ricezione (RxD, DCE → DTE): i dati binari in forma seriale generati dal DCE viaggiano verso il DTE.
- **C105** = Richiesta di trasmissione (RTS, DTE → DCE): tale segnale obbliga il modem a trasmettere la portante in linea entro 2 ms. Se la linea è nello stato di riposo il modem interrompe la trasmissione entro 2 ms.
- **C106** = Pronto a trasmettere (CTS, DCE → DTE): tale segnale indica che il DCE è pronto a trasmettere in linea e rappresenta la risposta alla linea C105 purché il modem sia connesso alla linea telefonica. Il tempo di risposta in corrispondenza della prima richiesta di trasmettere è compreso tra 750 e 1400 ms ed è compreso tra 22 e 40 ms nelle successive richieste di trasmissione.
- **C107** = Modem pronto (DSR, DCE → DTE): questo segnale indica al DTE che il modem è collegato alla linea telefonica e che non è in prova. Nei modem in banda base tale linea è sempre attiva.
- **C108** = DTE pronto (DTR, DTE → DCE): l'attivazione di questa linea provoca il collegamento del modem alla linea telefonica qualunque sia la condizione delle altre linee. Questa linea, inoltre, indica che il DTE è pronto sia a trasmettere che a ricevere dati.
- **C109** = Portante in ricezione (DCD, DCE → DTE): il DCE informa il DTE che la portante in linea è ad un livello superiore alla soglia di ricezione.
- **C110** = Rivelatore della qualità del segnale (CG, DCE → DTE): il DCE informa il DTE che non ci sono ragioni per credere che i dati ricevuti siano errati.
- **C111** = Selezione di velocità (CI, DTE → DCE): l'attivazione di tale linea obbliga il modem a scegliere la velocità più elevata. Il livello logico opposto imposta la velocità più bassa (per modem 1200 bps/600 bps).
- **C112** = Selezione velocità (DCE → DTE): se la scelta della velocità è fatta dal modem, quest'ultimo avverte il DTE della velocità selezionata: lo stato ON sceglie la velocità più alta, lo stato OFF quella più bassa. Questa linea utilizza lo stesso pin del C111 ed è ad esso alternativa.
- **C113** = Clock di trasmissione da DTE (DA, DTE → DCE): questa linea rappresenta il clock generato dal DTE. Le transizioni ON-OFF devono coincidere con la posizione centrale su ciascun bit della linea C103.
- **C114** = Clock di trasmissione da DCE (TC, DCE → DTE): questa linea rappresenta il clock generato dal DCE. Durante le transizioni OFF-ON il DTE deve generare il bit successivo su C103.
- **C115** = Clock in ricezione (RC, DCE → DTE): questa linea rappresenta il clock per i dati che il DTE riceve su C104. La forma d'onda è quadra e la transizione ON-OFF indica il centro del bit ricevuto su C104.
- **C118** = Trasmissione dati sul supervisore (SBA, DTE → DCE): questa linea svolge le stesse funzioni del C103 ma si riferisce al canale supervisore (ausiliario). Per i modem a 1200 bps il canale supervisore è a 75 bps.
- **C119** = Ricezione dati sul supervisore (SBB, DCE → DTE): questa linea svolge le stesse funzioni del C104 ma si riferisce al canale supervisore. Per i modem a 1200 bps il canale supervisore è a 75 bps.
- **C120** = Richiesta di trasmissione sul canale supervisore (SCA, DTE → DCE): questa linea svolge le stesse funzioni del C105 ma si riferisce al canale supervisore.
- **C121** = Pronto a trasmettere sul canale supervisore (SCB, DCE → DTE): questa linea svolge le stesse funzioni del C106 ma si riferisce al canale supervisore.
- **C122** = Rivelatore segnale di linea dati supervisore (SCF, DCE → DTE): questa linea svolge le stesse funzioni del C109 ma si riferisce al canale supervisore.
- **C123** = Rivelazione qualità segnale supervisore (DCE → DTE): questa linea svolge le stesse funzioni del C110 ma si riferisce al canale supervisore.
- **C125** = Chiamata in arrivo (RI, DCE → DTE): l'attivazione di questa linea indica al DTE che il modem ha ricevuto una chiamata telefonica. La risposta del DTE sulla linea C108 provoca la connessione del modem alla linea (risposta automatica).
- **C126** = Scelta della frequenza in trasmissione (CK, DTE → DCE): linea che serve alla scelta della frequenza del modem quando questo prevede due canali.

### Interfaccia USB

L'interfaccia USB (*Universal Serial Bus* — Bus seriale universale) fu creata nel 1995 da un consorzio di costruttori fra cui Intel, Compaq, Digital e Microsoft, con l'intento di sostituire le porte seriali e parallele per il collegamento di periferiche al PC.

La versione 1.0 / 1.1 raggiunge la velocità di 12 Mbps e si possono collegare fino a 127 periferiche in cascata. La versione 2.0 consente velocità fino a 480 Mbps. L'USB può fornire direttamente l'alimentazione alle periferiche a basso consumo (come tastiere e mouse). È inoltre completamente *Plug and Play*: le periferiche possono essere collegate "a caldo" (*hot-swap*, senza spegnere la macchina) e vengono automaticamente riconosciute.

Ciascuno dei due connettori disponibili sul retro del PC è a 4 poli. La massima corrente fornita dai due connettori è di 1 A (500 mA per porta in USB 2.0).

![[slide_ret9-50.png|500]]

In figura si mostra il cavo USB che collega la presa posta sul retro del PC al dispositivo periferico USB (a sinistra il terminale che si applica alla periferica, Tipo B; a destra quello che va al PC, Tipo A). Volendo collegare più dispositivi USB si può far uso di HUB a più porte, una specie di spina multipla che si collega al PC.

![[slide_ret9-51.png|500]]

La versione 3.0 porta la velocità di trasmissione a 5 Gbps, quindi è oltre 10 volte più veloce di USB 2.0. Le specifiche di USB 3.0 sono state rilasciate nel 2008 e i primi prodotti sono usciti nel 2010. I terminali dei cavi USB 3.0 sono del tipo mostrato in figura.

![[slide_ret9-52.png|500]]

### Interfaccia IEEE1394

Lo standard IEEE 1394 fu adottato nel 1995 dalle specifiche fornite da un gruppo di aziende elettroniche tra cui Apple, Compaq e Sony. Questo tipo di interfaccia, di tipo seriale e bidirezionale, fu concepita nel 1986 dalla Apple che la denominò "FireWire" per le sue particolari caratteristiche di velocità. Successivamente la Sony introdusse delle varianti denominando il collegamento "i.LINK". Lo standard IEEE 1394 comprende sia le specifiche "FireWire" che "i.LINK".

La principale limitazione della IEEE 1394a è nella portata, che è solo di qualche metro (4,5 m). Per superare tale limite è stato definito lo standard 1394b (*Long Reach*) che attua collegamenti fino a 100 m con velocità di 800 Mbit/s, 1,6 Gbit/s e fino a 3,2 Gbit/s.

Sono in commercio numerosi prodotti che si avvalgono dello standard IEEE 1394 per la trasmissione dei dati digitali: sistemi di elaborazione digitale video, videocamere digitali, riproduttori audio digitali, personal computer, hard-disk, stampanti, ecc. In figura si mostra il tipico collegamento tra vari dispositivi "FireWire" e i relativi connettori.

![[slide_ret9-54.png|500]]

Tra le principali caratteristiche ricordiamo:

- possibilità di collegamento e scollegamento fisico a caldo (*hot-plug*);
- capacità di miscelare su una singola linea dati in tempo reale sincroni (isocroni) ed asincroni;
- capacità di utilizzare simultaneamente dispositivi sia a bassa che ad alta velocità sulla stessa connessione fino ad un numero massimo pari a 63;
- i sistemi operativi Windows, Linux, macOS e Unix contengono nativamente i driver per la gestione dell'IEEE 1394.

Per i PC l'interfaccia IEEE 1394 è disponibile sotto forma di schede su bus PCI con connettori del seguente tipo:

- a 4 pin senza alimentazione: due coppie di cavi intrecciati, una per la trasmissione ed una per la ricezione;
- a 6 pin con alimentazione: i due pin in più forniscono la massa e l'alimentazione da 8 V a 30 V con capacità di pilotaggio in corrente fino a 1,5 A.

