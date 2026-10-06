# Codifica dei dati, flussi trasmissivi e valutazione delle prestazioni

## La codifica dell'informazione

Nel sistema elaborativo il **carattere** può essere associato al singolo bit: le sequenze significative di caratteri diventano quindi collezioni di bit dentro strutture di codifica dette **codici**, fra cui BCD (*Binary Decimal Code*), AIKEN, Gray, EBCDIC, ASCII e UNICODE.

A seconda della ==natura dell'informazione== si associano **diverse quantità di bit** a ogni singolo elemento. Un'immagine, per esempio, è una matrice di pixel: se la sequenza di bit deve rappresentare un pixel e il suo colore, un'immagine a colori richiede più bit per pixel di una in bianco e nero, dove un solo bit basta.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1;">
    <img src="codifica_pixels_immagine.jpg" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1.5;">
  I bit per elemento non sono una proprietà del dato in astratto, ma della sua natura: più l'insieme dei valori distinguibili è ampio, più bit servono. È la stessa logica dei codici testuali, dove l'ampiezza in bit è determinata dal numero di simboli distinti da rappresentare.
  </div>
</div>

| Codice | Estensione | Note |
| :--- | :--- | :--- |
| ASCII (*American Standard Code for Information Interchange*) | 7 bit | codice di base |
| ASCII extended | 8 bit | introduce i caratteri accentati |
| EBCDIC | 8 bit | |
| Unicode (per esempio UTF-8) | | |

**ASCII:**

<div style="display: flex; justify-content: center;">
  <img src="codice_ascii.jpg" width="420">
</div>

**ASCII extended:**

<div style="display: flex; justify-content: center;">
  <img src="codice_ascii_extended.jpg" width="240">
</div>

**EBCDIC:**

<div style="display: flex; justify-content: center;">
  <img src="codice_ebcdic.jpg" width="420">
</div>

## I flussi trasmissivi

Il **flusso trasmissivo** fra mittente e destinatario si istituisce secondo tre modalità, distinte per il grado di bidirezionalità consentito.

| Tipo            |                     Schema                     | Comportamento                                                                                               | Esempio       |
| :-------------- | :--------------------------------------------: | :---------------------------------------------------------------------------------------------------------- | :------------ |
| **Simplex**     |   <img src="flusso_simplex.jpg" width="140">   | solo uno dei dispositivi può spedire informazione, l'altro può solo ricevere                                | radio         |
| **Half duplex** | <img src="flusso_half_duplex.jpg" width="140"> | ogni dispositivo può trasmettere e ricevere, ma non contemporaneamente                                      | walkie-talkie |
| **Full duplex** | <img src="flusso_full_duplex.jpg" width="140"> | entrambi possono spedire e ricevere contemporaneamente, con bidirezionalità tramite due collegamenti fisici |               |

La progressione è netta: il *simplex* azzera la bidirezionalità, l'*half duplex* la rende possibile ma mutuamente esclusiva, il *full duplex* la rende simultanea su due collegamenti fisici distinti.

## Gli apparecchi della comunicazione: DTE, DCE e CPE

Il ruolo di ciascun apparato lungo il canale è definito da una classe di sigle specifica:

- **DTE** (*Data Terminal Equipment*): il dispositivo informatico che permette la comunicazione dati, per esempio un computer, e nel quale risiede l'applicazione utente.
- **DCE** (*Data Circuit Terminating Equipment*, anche *Data Communication Equipment*): per connettersi alla linea serve un DCE, che converte i segnali nella forma migliore per l'invio sul canale, per esempio un modem.
- **CPE** (*Customer Premises Equipment*): quando serve un dispositivo di pertinenza dell'utente, di solito inserito nella sua abitazione, per esempio reti ISDN, wireless o *voice over IP*, si parla di CPE.

**La rete di comunicazione:** il percorso fra due DTE non è l'unico elemento in gioco. La rete di comunicazione si interpone fra i due DTE e ne media il collegamento, ed è il DCE l'apparato che adatta il segnale alla forma migliore per l'invio su di essa.

<div style="display: flex; align-items: flex-start; gap: 20px;">
  <div style="flex: 1.5;">
    <img src="schema_dte_dce.jpg" style="width: 100%; border-radius: 8px;">
  </div>
  <div style="flex: 1;">
  La distinzione DTE/DCE è ciò che permette all'applicazione utente, ospitata nel DTE, di dialogare attraverso la rete: il DCE si colloca fra il terminale e la rete e adatta il segnale al canale.
  </div>
</div>

## Le reti e il loro mondo

==Si parla di **rete** intendendo un insieme di dispositivi connessi da canali di comunicazione.== Una rete presenta uno o più **nodi** capaci di inviare o ricevere dati, generati o ricevuti, da altri dispositivi o da altri nodi.

L'organizzazione delle funzioni computazionali si articola in due modelli:

- **Reti ad elaborazione concentrata:** è il modello nativo per le reti telematiche; un potente DTE viene messo a disposizione di uno o più DTE che ne sfruttano le capacità di calcolo (es client-server)
- **Reti ad elaborazione distribuita:** invece di essere un solo DTE a svolgere un compito, questo viene diviso in varie parti, ognuna svolta da un nodo della rete (es internet)

**Le tre procedure di colloquio**, possibili in entrambi i modelli per il trasferimento dell'informazione fra DTE:

1. *Inquiry:* interrogazione di uno o più servizi messi a disposizione dal sistema elaborativo.
2. *Conversazionale:* applicazione che permette al DTE di inviare tutte e sole le applicazioni previste, secondo regole e formati d'immissione preimpostati.
3. *Interattivo:* risponde ad applicazioni flessibili; il DTE può inviare tutte le applicazioni che consentono il pieno sfruttamento di tutte le risorse elaborative.

Le tre procedure si differenziano per la flessibilità concessa al terminale, che va dall'interrogazione di servizi prestabiliti allo sfruttamento indiscriminato delle risorse.

## Gli aspetti di valutazione di una rete

La bontà di una rete si valuta su tre aspetti: ==affidabilità, sicurezza e prestazioni.==

**Affidabilità:** capacità della rete di consegnare l'informazione priva di errori, porre rimedio ai malfunzionamenti e restare robusta nelle situazioni critiche.

**Sicurezza:** protezione dei dati gestiti nella rete, in modo da impedire accesso non autorizzato, modifiche non autorizzate e perdita di dati.

**Prestazioni:**

| Metrica | Definizione |
| :--- | :--- |
| **Ritardo** | tempo di transito dei dati, cioè il tempo necessario a un messaggio per raggiungere la destinazione partendo dalla sorgente |
| **Tempo di risposta** | tempo fra il momento della richiesta e il momento in cui arriva la risposta |
| **Throughput** | quantità effettiva di dati spediti nell'unità di tempo |

> [!info] In altre parole:
> Il ritardo è riferito al tempo di transito di un singolo messaggio, il tempo di risposta all'intervallo fra una richiesta e la risposta a essa corrispondente.

Le prestazioni dipendono anche da fattori strutturali e non solo dalle misure stesse: il numero di DTE presenti sulla rete, la tipologia dei mezzi trasmissivi utilizzati e l'efficienza del software che gestisce la comunicazione.

**La banda:** banda passante di frequenze utilizzabile per la trasmissione di segnale su un canale. Essendo legata alla quantità d'informazione inviabile nell'unità di tempo, si può definire come ==la velocità massima alla quale è possibile trasmettere informazioni==. Da qui i due termini:

- **Broadband:** tecnologie che forniscono collegamenti di velocità notevolmente superiore alla normale linea telefonica.
- **Digital divide:** la disparità fra zone che dispongono o meno di accesso alla banda larga.

## Gli strumenti di valutazione della velocità

**`ping`:** indica se un host remoto può essere raggiunto e riporta statistiche sui pacchetti persi e sul tempo di spedizione. Usa l'*echo message* del protocollo **ICMP** (*Internet Control Message Protocol*) per forzare un host remoto a rispedire indietro all'host locale il pacchetto ricevuto.

> [!example]
> ```bash
> ping 141.250.5.2
> PING 141.250.5.2 (141.250.5.2): 56 data bytes
> 64 bytes from 141.250.5.2: icmp_seq=0 ttl=64 time=0.352 ms
> 64 bytes from 141.250.5.2: icmp_seq=1 ttl=64 time=0.474 ms
> ^C
> --- 141.250.5.2 ping statistics ---
> 2 packets transmitted, 2 packets received, 0% packet loss
> round-trip min/avg/max/stddev = 0.352/0.413/0.474/0.061 ms
> ```
>
> Il tempo è riportato in millisecondi; il comando si interrompe da solo oppure con `Ctrl + c` o `Ctrl + z`.

Il comportamento cambia in funzione dello stato dell'host di destinazione: se l'host è su una rete inesistente si ottiene subito un errore, mentre se l'host esiste ma non risponde il pacchetto resta in attesa fino all'interruzione.

```bash
ping 26.40.0.17
sendto: Network is unreachable
```

```bash
ping 141.250.233.1
PING 141.250.233.1 (141.250.233.1): 56 data bytes
^C
--- 141.250.233.1 ping statistics ---
131 packets transmitted, 0 packets received, 100% packet loss
```

**I due parametri da controllare** nel ping che funziona:

- ***Packet loss*:** dovrebbe essere sempre zero. Altrimenti c'è un problema alla connessione oppure, più probabilmente, il sito contattato è congestionato o disconnesso dalla rete.
- ***Round trip time*:** per una buona connessione Internet deve essere dell'ordine di qualche millisecondo. Se assume valori a tre cifre c'è un problema della connessione o della rete.

**`traceroute`** (o `tracert`): dice quale instradamento prendono i pacchetti in uscita dal sistema verso un sistema remoto. Mostra i dispositivi attraversati, con nome e indirizzo tra parentesi, e dà la misura della *distanza* in termini di dispositivi attraversati (*hops*).

> [!example]
> ```bash
> traceroute 141.250.1.3
> traceroute to 141.250.1.3 (141.250.1.3), 64 hops max, 40 byte packets
>  1  gw25.dipmat.unipg.it (141.250.25.3)   2.556 ms  3.264 ms  4.534 ms
>  2  141.250.115.77 (141.250.115.77)       4.220 ms  2.844 ms  2.996 ms
>  3  fe.r.unipg.it (141.250.253.1)         3.856 ms 17.168 ms  3.464 ms
>  4  sw-cs.r.unipg.it (141.250.253.21)     3.758 ms  2.281 ms  3.709 ms
> ```
>
> Ogni riga è un *hop*: il numero di righe fino a destinazione è il numero di dispositivi attraversati e ciascun valore è il round trip verso quel dispositivo.

**Speed test:** per verificare la velocità effettiva della connessione si usa il sito **www.speedtest.net**. Sul territorio italiano sono sparsi vari server di test: ne viene scelto uno, il più vicino, e si avvia la prova, che in un minuto restituisce ping, velocità in download e in upload. Il server può anche essere scelto automaticamente in base al ping, scegliendo direttamente quello migliore.

> [!info] Sintesi:
> - Il numero di bit per elemento dipende dalla natura del dato: un'immagine a colori ne richiede più di una in bianco e nero.
> - I codici più usati sono ASCII a 7 bit, ASCII extended ed EBCDIC a 8 bit e Unicode.
> - I flussi trasmissivi sono simplex, half duplex e full duplex, secondo il grado di bidirezionalità consentito.
> - DTE è il terminale, DCE l'apparato che adatta il segnale al canale, CPE l'apparato di pertinenza dell'utente.
> - Una rete si valuta su affidabilità, sicurezza e prestazioni; ritardo, tempo di risposta e throughput misurano le prestazioni.
> - `ping` verifica la raggiungibilità e il packet loss, `traceroute` mostra il cammino dei pacchetti, speed test misura la velocità reale.