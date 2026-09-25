# Lezione 1: Fondamenti di Networking, Teoria della Comunicazione e Standard

## 1. Introduzione al Networking e Convergenza Telematica

Il settore delle reti di calcolatori e dei sistemi telematici è caratterizzato da una crescita pervasiva ed esponenziale. Questa continua evoluzione tecnologica è trainata dalla convergenza di molteplici fattori abilitanti:

* **Sviluppo delle Telecomunicazioni:** espansione delle infrastrutture ad altissima capacità trasmissiva (dorsali in fibra ottica ad altissima velocità, tecnologie wireless cellulari e satellitari).
* **Sviluppo delle Micro e Nano-tecnologie:** avanzamento continuo della miniaturizzazione dei semiconduttori, che permette di integrare elevate capacità computazionali e interfacce di rete in chip compatti a bassissimo consumo energetico.
* **Sensori ad Elevata Efficienza:** disponibilità di sensori sempre più miniaturizzati, affidabili ed economici, volano primario per l'Internet of Things (IoT), i sistemi embedded e il monitoraggio ambientale e industriale continuo.
* **Sviluppo di Soluzioni Software Avanzate:** ingegnerizzazione di stack protocollari altamente performanti, architetture a microservizi e soluzioni di virtualizzazione delle funzioni di rete (*Software-Defined Networking* - SDN).
* **Convergenza e Soluzioni Hardware/Software Integrate:**
  * Capacità di gestire e trasferire simultaneamente **dati numerici, flussi audio/voce e flussi video ad alta definizione**.
  * Requisito stringente di erogazione e sincronizzazione in **tempo reale (*real-time*)**, essenziale per videoconferenze, telemedicina e sistemi di controllo critici.

La transizione tecnologica ha segnato il superamento definitivo dei modelli centralizzati (fondati sui grandi mainframe con terminali passivi) a favore dei **sistemi di elaborazione distribuita**, sostenuti da tecnologie in grado di instradare volumi massivi di dati tramite segnali fisici a frequenze elevatissime.

## 2. Il Processo di Comunicazione Dati

L'infrastruttura globale consente a sistemi eterogenei di interagire e scambiare informazioni su qualsiasi scala geografica (da reti locali LAN fino all'interconnessione planetaria su scala WAN e Internet).

### 2.1 La Triade Fondamentale della Comunicazione
Un processo comunicativo si realizza unicamente in presenza di tre elementi costitutivi irrinunciabili:
1. **Sorgente dell'Informazione (*Source / Trasmettitore*):** il dispositivo che genera i dati da trasmettere (es. personal computer, telecamera IP, sensore IoT).
2. **Mezzo Trasmissivo (*Transmission Medium / Cammino Fisico*):** il supporto o percorso fisico lungo il quale si propaga il segnale (mezzi guidati come rame e fibra ottica, o mezzi non guidati come lo spazio libero tramite onde elettromagnetiche).
3. **Destinatario (*Destination / Ricevitore*):** il dispositivo a cui è destinato il flusso informativo e che acquisisce il segnale (es. server, workstation, attuatore).

```
┌──────────┐           Mezzo Trasmissivo (Canale Fisico)          ┌─────────────┐
│ Sorgente ├─────────────────────────────────────────────────────►│ Destinatario │
└──────────┘                                                      └─────────────┘
```

### 2.2 Definizione di Comunicazione Dati e Sistema di Comunicazione
La **comunicazione dati** è lo scambio formale di informazioni tra due o più dispositivi realizzato attraverso un idoneo mezzo di trasmissione.

Affinché la comunicazione abbia luogo con successo, i singoli apparati devono integrarsi all'interno di un **sistema di comunicazione** coerente, strutturato in due componenti complementari:
* **Hardware:** le interfacce fisiche di rete (NIC - *Network Interface Card*), modem, amplificatori, antenne, commutatori (*switch*) e instradatori (*router*).
* **Software:** i driver di periferica, gli stack protocollari di sistema operativo (es. suite TCP/IP) e i programmi applicativi di rete.

## 3. Teoria dell'Informazione e Modello di Shannon-Weaver

### 3.1 Definizioni Fondamentali ed Etimologia

> [!NOTE] Definizioni di Informazione e Comunicazione
> * **Informazione:** L'insieme di dati, correlati e strutturati tra loro, attraverso cui un'idea, un concetto o un fatto assume forma intelligibile e può essere comunicato e compreso.
> * **Comunicazione:** Dal latino *cum* ("con", "insieme") e *munire* ("legare", "costruire"), e dal verbo *communico* ("mettere in comune", "rendere partecipe"). Indica il processo e l'insieme delle modalità attraverso cui un'informazione viene trasmessa da un soggetto a un altro (o da un luogo a un altro) tramite lo scambio di un messaggio codificato in accordo con un codice formale prestabilito.

### 3.2 Il Modello di Shannon-Weaver (1949)
Formulato originariamente da Claude Shannon e Warren Weaver nei Bell Laboratories, il modello descrive la trasmissione dell'informazione attraverso **7 elementi fondamentali**:

1. **Fonte / Sorgente (*Information Source*):** l'entità che concepisce e genera il messaggio originario.
2. **Codifica (*Encoding / Trasmettitore*):** l'operazione che converte il messaggio logico in segnali fisici (elettrici, ottici o radio) trasmissibili attraverso il canale.
3. **Messaggio:** la sequenza informativa strutturata prodotta dal processo di codifica.
4. **Mezzo Trasmissivo / Canale (*Channel*):** il mezzo fisico che sostiene la propagazione dei segnali.
5. **Rumore (*Noise Source*):** disturbi casuali, attenuazioni, dispersioni o interferenze esterne introdotte dal canale, suscettibili di degradare o alterare il segnale.
6. **Decodifica (*Decoding / Ricevitore*):** l'operazione inversa che ricostruisce il messaggio logico originario a partire dai segnali fisici ricevuti.
7. **Destinatario (*Destination*):** la persona o il sistema finale a cui è indirizzata l'informazione.

![[Pasted image 20260925115804.png|450]]

> [!NOTE] Il Modello di Shannon-Weaver
> Rappresentazione bidirezionale e ciclica del processo comunicativo: la fonte codifica il messaggio per il canale (soggetto a rumore ed errori di trasmissione); il destinatario decodifica il messaggio e, attraverso un meccanismo di retroazione (*feedback*), può assumere il ruolo di sorgente invertendo il flusso della comunicazione.

## 4. La Gerarchia della Conoscenza: La Piramide DIKW

La gestione e la trasformazione delle informazioni nei sistemi telematici e decisionali è formalizzata nel modello gerarchico **DIKW** (*Data, Information, Knowledge, Wisdom*):

![[Pasted image 20260925115953.png|450]]

> [!NOTE] La Piramide DIKW
> Struttura gerarchica dell'elaborazione conoscitiva: dai dati grezzi alla base fino alla saggezza apicale. Evidenzia la transizione continua tra le dimensioni empiriche di elevato volume e oggettività alla base, verso contesti di alto valore aggiunto, struttura e soggettività al vertice.

La piramide articola la conoscenza in quattro stadi ascendenti:

1. **Dati (*Data*):**
   * Elementi grezzi, simboli non contestualizzati, misurazioni o segnali binari privi di significato intrinseco (es. il valore `25`, la stringa `10101`).
   * *Proprietà:* massimi livelli di **oggettività**, **volume** e **completezza**, ma utilità operativa nulla in assenza di un contesto interpretativo.
2. **Informazione (*Information*):**
   * Dati organizzati, correlati e contestualizzati, a cui viene associato un significato semantico ben preciso.
   * Risponde alle interrogazioni empiriche: *chi?*, *cosa?*, *dove?*, *quando?*
   * *Esempio:* `"La temperatura registrata nella sala server alle 11:59 è di 25°C"`.
3. **Conoscenza (*Knowledge*):**
   * Comprensione contestuale derivata dall'assimilazione, dall'integrazione e dal confronto di informazioni mediante esperienza, regole inferenziali e modelli cognitivi.
   * Risponde alla domanda: *come?*
   * *Esempio:* `"Una temperatura costante di 25°C nella sala server supera la soglia raccomandata e rischia di innescare il thermal throttling delle CPU"`.
4. **Saggezza (*Wisdom*):**
   * Livello apicale della gerarchia: integra la conoscenza con il giudizio critico, la visione a lungo termine e le decisioni strategiche.
   * Risponde alla domanda: *perché?*
   * *Esempio:* Progettare una riconfigurazione dell'impianto di climatizzazione e delle policy di carico computazionale per garantire la continuità operativa ottimizzando al contempo l'impatto energetico complessivo.

| Livello della Piramide | Caratteristiche Distintive | Funzione nel Sistema Informativo |
| :--- | :--- | :--- |
| **Vertice: Saggezza e Conoscenza** | Soggettività, Alto Valore Aggiunto, Sintesi, Struttura | Supporto alle decisioni strategiche e comprensione di sistema |
| **Base: Informazione e Dati** | Oggettività, Elevato Volume, Completezza, Misurabilità | Rilevazione sensoriale, codifica, memorizzazione e trasporto di rete |

## 5. I Protocolli di Rete e gli Standard Internazionali

### 5.1 Il Concetto Fondamentale di Protocollo
Un **protocollo di rete** è un insieme formale di regole, formati e convenzioni condivise che stabiliscono le modalità con cui due o più entità devono comunicare.

Un protocollo specifica in modo deterministico:
* **Cosa si scambia (Sintassi e Semantica):**
  * *Sintassi:* la struttura del pacchetto, la disposizione dei bit e dei campi (header, payload, checksum) e i formati di codifica.
  * *Semantica:* il significato associato a ciascun pattern di bit o campo di controllo e le azioni da intraprendere alla ricezione di ciascun comando.
* **Come avviene lo scambio (Temporizzazione / *Timing*):**
  * La sincronizzazione temporale, l'ordine sequenziale dei messaggi e i meccanismi di regolazione della velocità trasmissiva (*flow control*).

> [!IMPORTANT] Necessità Ineludibile del Protocollo
> Due o più dispositivi possono essere fisicamente e correttamente collegati tramite cavi o onde radio, ma in assenza di un protocollo comune **non sono assolutamente in grado di comunicare**. Senza regole condivise, i segnali elettrici o ottici ricevuti risultano indecifrabili, analogamente a due individui collegati tramite una linea telefonica impeccabile che parlino due lingue del tutto sconosciute l'uno all'altro.

### 5.2 L'Importanza della Standardizzazione e l'Organizzazione ISO
Affinché apparati realizzati da produttori indipendenti e basati su architetture differenti possano interoperare senza frizioni su scala mondiale, i protocolli devono essere formalizzati come standard aperti.

![[Pasted image 20260925120233.png|180]]

> [!INFO] International Organization for Standardization (ISO)
> L'**ISO** è la massima organizzazione mondiale indipendente e non governativa per la standardizzazione tecnica internazionale. I suoi standard coprono un vasto spettro di settori industriali, svolgendo un ruolo di riferimento nell'architettura dei sistemi di comunicazione (incluso lo sviluppo del celebre modello di riferimento **ISO/OSI** a 7 livelli) e nelle normative per la sicurezza informatica e la gestione dei dati.
