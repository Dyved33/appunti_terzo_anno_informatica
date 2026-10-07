# Tipi di connessione e topologie di rete

## Tipi di connessione
- point-to-point = collegamento tra due [[Lezione 2-Codifica dei dati, flussi trasmissivi e valutazione delle prestazioni|DTE]] (pc) ottenuto tramite linea telefonica o dedicata
- multi-punto = collegamento condiviso tra più DTE: l'intera capacità del canale va condivisa fra tutti i DTE, e la condivisione può avvenire
  - *temporalmente*, se l'accesso al mezzo trasmissivo è esclusivo (a turni)
  - condivisione dello spazio del canale, qualora sia ammesso uso simultaneo

## Classificazione fisica delle reti
Le reti sono classificate in base alla dimensione fisica:
- Reti geografiche o WAN (Wide Area Network)
- Reti locali o LAN (Local Area Network)
- Reti metropolitane o MAN (Metropolitan Area Network)
- Reti per applicazioni mobili (wireless).

<div style="display: flex; justify-content: center;">
  <img src="slide-04.png" width="300">
</div>

## Reti wan
le reti wan hanno le caratteristiche:
- grandi senza limitazioni 
- i DTE possono essere molto distanti tra di loro 
- uso di linea telefonica 
- velocità da 1200 bit/sec ai Tbit/sec

## Reti lan
le reti LAN hanno le caratteristiche:
- tipicamente non superano 1 o 2 Km di estensione 
- solitamente ad uso privato 
- allocata in un singolo ufficio 
- velocità da qualche Mbps a migliaia di Mbps (Gbps) 
- spesso vengono progettate per condividere risorse (stampanti, dischi, software, ecc.) 
- è possibile che ci siano DTE che fungono da server 
- solitamente una LAN utilizza un solo tipo di mezzo trasmissivo.

## Reti wlan
le reti WLAN sono LAN wireless (senza fili):
- Reti locali da interno o interconnessione di edifici 
- Copertura di aree pubbliche tramite uso di hotspot 
- Lo spettro radio sostituisce il cavo 
- Velocità dipende dallo [[Lezione 1-Fondamenti di networking, teoria della comunicazione e standard|standard]] usato. 
- Wi-Fi 5 (802.11ac) può raggiungere teoricamente 3,5 Gbps 
- Wi-Fi 6 (802.11ax) fino a 9,6 Gbps

La banda a 2,4 GHz offre una copertura più ampia ma è più lenta; la banda a 5 GHz è più veloce ma ha una copertura ridotta.

<div style="display: flex; justify-content: center;">
  <img src="slide-07.png" width="300">
</div>

## Reti man
Le reti MAN sono reti a livello cittadino: 
- solitamente fibra ottica 
- Vengono utilizzate come reti ad alta velocità per interconnettere centrali tra differenti quartieri

## Reti wireless
Le reti wireless sono reti di comunicazione mobili private o reti di comunicazione mobili pubbliche. Comprendono: 
- WLAN ([[Lezione 1-Fondamenti di networking, teoria della comunicazione e standard|IEEE 802.11]] – Wireless LAN (Wi-Fi) 
- WiMax (Worldwide Interoperability for Microwave Access o IEEE 802.16x) 
- IEEE 802.20 per applicazioni nomadi 
- CDPD (Cellular Digital Packet Data) per accesso wireless al router di un ISP con i protocolli: 
	- HSPDA (High Speed Downlink Packet Access) 
	- HSUPA (High Speed Uplink Packet Access) 
	- LTE (Long Term Evolution)

<div style="display: flex; justify-content: center;">
  <img src="slide-10.png" width="300">
</div>

Nello schema  le tecnologie wireless sono riportate con le rispettive bande di frequenza: WAN a 400 e 800 MHz, IEEE 802.20 a 900 MHz, 2,5 e 3,6 GHz proposti, MAN, Wi-Fi mesh, WiMAX (802.16), MeshNetworks, wireless LAN Wi-Fi, Ethernet e UWB.

## Topologia delle reti
La topologia di una rete è la configurazione geometrica dei collegamenti fra i vari componenti della rete. Le varie topologie sono volte al conseguimento dei seguenti obiettivi: 
- massima stabilità 
- alto rendimento complessivo 
- minimizzazione costi

## Rete ad albero
<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-12.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Stazioni a vari livelli: livello centrale di massima importanza; fornisce struttura semplice ma vulnerabile.
  </div>
</div>

## Rete a dorsale
<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-13.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Collegamento multi punto, ambito LAN, rete broadcast su ethernet, caratterizzata da facilità di installazione. In pratica il cavo formava la spina dorsale fisica (<i>backbone</i>).
  </div>
</div>

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-14.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Esempio di vecchio schema di ethernet LAN con cavo 10BASE-2, dove 10 = 10 Mb/s, chiamato <i>thin-net</i>. Queste reti richiedevano anche che una speciale terminazione (una impedenza da 40 o 50 Ohm) fosse installata alla fine dei segmenti del cavo. Se questi attacchi venivano accidentalmente rimossi o si guastavano, quell'intero segmento di rete smetteva di funzionare. Queste tecnologie cablate richiedevano giunti metallici di discrete dimensioni denominati connettori BNC.
  </div>
</div>

## Rete a stella
<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-15.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Ogni nodo è connesso con un collegamento punto-a-punto ad un dispositivo centrale, è simile alla rete ad albero. Risulta più economica di quella a maglia completa (<i>mesh</i>). Se un collegamento si interrompe, solo il nodo collegato ne subisce le conseguenze.
  </div>
</div>

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-16.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Es.: Ethernet con topologia a stella - 100baseT e 1000baseT. Dove T indica l'introduzione del doppino ritorto non schermato UTP (Unshielded Twisted Pair) e cavi terminati con connettori plastici RJ45, l'hub divenne di fatto il nuovo backbone. Lavorare con i cavi di tipo UTP si dimostrò non solo molto più semplice ma talmente più produttivo, che l'UTP divenne ben presto lo standard indiscusso su tutte le nuove installazioni.
  </div>
</div>

## Rete ad anello
<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-17.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Molto utilizzata in passato in ambito LAN, come <i>token ring</i> IEEE802.5: ogni nodo ha un collegamento punto-a-punto con solo due altri nodi (precedente e successivo). Trasmissione unidirezionale: ogni nodo ha un ripetitore che rigenera segnale; di facile installazione e configurazione, con semplice isolamento guasti; tuttavia se il collegamento principale si interrompe, la rete diventa non utilizzabile. Si noti che si può ovviare a quest'ultima eventualità prevedendo un secondo anello interno.
  </div>
</div>

## Rete a maglia (mesh)
<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-18.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Tutti i nodi sono collegati tra di loro (maglia completa), con un fattore di costo pari a N(N-1)/2, poiché ogni nodo ha collegamento punto-a-punto con gli altri. Ogni apparato è allo stesso tempo in grado di trasmettere, ricevere e inoltrare dati.
  </div>
</div>

## Reti mesh
<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="slide-20.png" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  Reti realizzate con combinazione di nodi fissi e mobili interconnessi tra di loro con link wireless per formare una rete auto-configurante multi-hop. Le apparecchiature utente hanno una parte attiva, potendo operare da terminali ma anche come router per altri nodi, estendendo copertura di rete. Grande affidabilità dovuta alla capacità di gestire in maniera dinamica il malfunzionamento sia di collegamenti radio che di componenti hardware della rete. Monitoraggio in tempo reale dei percorsi disponibili per raggiungere una determinata stazione, selezionando in tempo reale il percorso ottimale per raggiungerla.
  </div>
</div>

> [!info] Sintesi:
> - Il collegamento point-to-point unisce due DTE su linea dedicata; in quello multi-punto il canale è condiviso fra più DTE, a turni o in uso simultaneo.
> - Secondo la dimensione fisica le reti sono WAN, LAN, MAN e wireless: la LAN non supera 1 o 2 Km e usa un solo mezzo trasmissivo, la WAN collega DTE lontani con velocità dai 1200 bit/sec ai Tbit/sec.
> - Le WLAN sono LAN senza fili che usano lo spettro radio al posto del cavo; la velocità dipende dallo standard (Wi-Fi 5 a 3,5 Gbps teorici, Wi-Fi 6 a 9,6 Gbps) e cambia fra banda 2,4 e 5 GHz.
> - Le topologie cercano massima stabilità, alto rendimento e minimizzazione dei costi: albero, dorsale, stella, anello e maglia completa.
> - Nella dorsale il cavo faceva da backbone con terminazioni da 40 o 50 Ohm e connettori BNC; nella stella il nodo centrale fa da backbone; nella maglia completa i collegamenti sono N(N-1)/2.
> - Le reti mesh wireless sono auto-configuranti multi-hop: i nodi inoltrano i dati e in tempo reale scelgono il percorso ottimale.
