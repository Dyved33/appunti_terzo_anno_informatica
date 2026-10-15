RETI MESH
Il mezzo di trasmissione radio è soggetoo ad altissimo tasso di errore, rendendo necessario lo sviluppo di protocolli di routing ottimizzati per il mondo wireless. La maglia realizzata tra i wirelesso reotere e gli access points forma il wireless backhaul multihop, sistema di comunicazione che fornisce ad ogni utente mobile servici a bassoi costo di interconnessione multi hop a banda larga co un numero limitaot id punti di accesso ad Internet. Backhaul network = rete di comprendente di communicazione wireless in mobilità e a larga banda

Mesh risolve le seguenti esigenze:
- Trasmissione in movimento a oltre 400 km/h
- Trasmissione simmetrica (tra uplink e downlink)
- Limiti della banda in strutture ad albero
- Reti ad-hoc senza infrastruttura
- Configurazione automatica
- Radiolocalizzazione senza GPS
- Resistenza alle interferenze
- 100% degli IP utilizzabili (opposizione alle reti con IP specifici deputati a funzioni di broadcast o altro)
- Sicurezza nelle comunicazioni 

Nelle reti wifi un guasto di un nodo di rete implica indisponibilità del servizio per tutti gli utenti sotto al nodo: invece nelle reti Mesh si ah amggiore torlleranza ai guastim maggiore flessibilità //Manca il contenuto della slide//

Il colloquio tra 2 DTE o DCE è governato da un insieme di regole che vanno sotto ilnome di protocolli. Il compito dei protocolli è:
- Gestire il flusso dei dati e i loro scambi
- Controllare gli errori di trasmissione e provvedere alle correzioni
- Provvedere alla sicnrinzzazione tra 2 DTE
- Dare una struttura formale ai dati trasmessi che permetta di distinguerli da quelli di controllo

A seconda che la relazione tra stazione DTE remote sia di tipo primario/secondario, alla pari o un ibrido tra le due, è possibile dividere in ambito primario/secondario
- Polling/selecting
- BSC
- HDLC
- SNRM
- RTS/CTS
- Xon/Xoff
- Stop and Wait
- Arq

Ambito delle relazioni ibride
- HDLC
- PPP
- MPLS

Ambito delle relazioni peer to peer
- TDM 
- FDM
- SDH

Request-to-send/Clear-to-send si basa su interfaccia RS-232 (interfaccia seriale): una stazione che vuole trasmettere //manca il resto del contenuto della slide segnata come 83//

//Foto alla slide 84//

//contenuto slide 85//

//Foto alla slide 86//

Automatic repeat request altrimenti noto come automatic repeat query è un protocollo full duplex. Utilizzando il concetto di finestra (scorrevole) piò migliorare l'efficienza della trasmissione, cioè sfruttare meglio il canale. Il messagio spedito viene diviso in sequenze di frame: i protocollo preveded di spedire più frames prima di ricevere un qualsiasi riscontro. Quest'ultimo potrebbe essere costituito da due numeri di sequenza (0 e 1), poiché è sufficiente distinguere solo un frfame da quello successivo. Nel caso di più frames inviati contemporaneamente, occorrono m bit che permettono di distinguere fino a 2^m sequenze (da 0 a 2^m-1)

La finestra del mittente specifica i frame che il mittente può spedire in quel momento, di controo la finestra del destinatario specifica i frame che il destinataio puòricevere nel dato momento. Nelle metodologie id gestione dell'errore, è possibile adottare:
- Metodo Go-back.N: un frame danneggiato implica ritrasmissione di N frame
- Metodo selettivo: vengono ritrasmessi solo i frames danneggiati

//foto mi pare alla slide 90//

La principale funzione dello strato fisico è quello di trasportre dati. Per fare ciò i segnali devono essere in qualche modo adattati al trasporto . Si ricorda prima di tutto che i segnali possono essere sia analogici che digitali
- Analogico è un segnale inteso come una rappresentazione continua nel tempo
- Digitale  //manca//

//manca il resto della slide 91//

Il trattamento cui sottoporre questi dati è di 2 tipi:
1. Conversione in un differente tipo di segnale digitale
2. Converisone in un segnale analogico (modulazione)

Come i dati che rappresentan, anch i segnali possono eessre sia anlogici che digitali:
- Un segnale analogico //manca//

//manca il resto della slide 92//

//foto a slide 93 con a lato il testo nella slide: un segnale sinusoidale è un segnale che varia nel tempo secondo una legge del tipo: dove t è il tempo trascorso, w è la velocità angolare e il fi è il cosiddetto sfasamento o fase. La curva descritta dal segnale nel temp oprende il nome di sinusoide//

//slide 94 con immagine e il testo presente nella slide a lato// CONTROLLA IL NUMERO

//slide 96 con immagine e il testo presente nella slide a lato//

//slide 97 con immagine e il testo presente nella slide a lato//

//da capire 98 e poi 99//