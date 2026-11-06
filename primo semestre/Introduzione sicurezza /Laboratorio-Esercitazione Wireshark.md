# Esercitazione Wireshark

## Cos'è Wireshark

**Wireshark** è un *network analyzer* (analizzatore di rete), specificamente un **packet sniffer**: permette di catturare e ispezionare pacchetti di rete, sia su interfacce live che su file di cattura salvati.

- Simile a `tcpdump` ma con **interfaccia grafica (GUI)**.
- **Open source** (licenza GPL).
- Supporta centinaia di protocolli con dissector dedicati.
- Funziona su Linux, Windows, macOS.

> [!info] Modalità di cattura
> - **Live capture**: interfaccia di rete in *modalità promiscua* (riceve tutto il traffico che passa sull'interfaccia, non solo quello indirizzato all'host).
> - **File capture**: analisi di file `.pcap` / `.pcapng` generati precedentemente (da Wireshark, tcpdump, altri tool).

## Utilizzi principali

- **Troubleshooting di rete**: amministratori individuano e risolvono problemi di prestazioni, connettività, configurazione.
- **Security auditing**: esame di problemi di sicurezza, *data leak*, traffico anomalo o sospetto.
- **Debug di protocolli**: sviluppatori verificano implementazioni, sequenze di handshake, errori a livello applicativo.
- **Analisi forense**: post-incidente, ricostruzione di come un attaccante è entrato, quali dati ha esfiltrato.

## Funzionalità chiave (Features)

- **Live capture** da interfaccia di rete con visualizzazione GUI dettagliata per pacchetto (header per layer, payload, timing).
- **Import/export** formati cattura: pcap, pcapng, snoop, Sun snoop, Microsoft Network Monitor, Accellent, HP-UX nettl, ecc.
- **Filtri di cattura (*capture filters*)** e **filtri di visualizzazione (*display filters*)** — due sistemi distinti.
- **Ricostruzione conversazioni** (*Follow TCP/UDP/HTTP Stream*): riassembla il flusso logico applicativo (es. richiesta HTTP + risposta) in una finestra leggibile.
- **Estrazione oggetti** (*Export Objects → HTTP, SMB, TFTP, ecc.*): salva file trasferiti dentro la cattura (immagini, eseguibili, documenti).
- **Decifratura HTTPS/SSL/TLS** quando si possiedono le chiavi (file `sslkeys.log` da browser, chiave privata server, o *pre-master secret* loggato).

> [!warning] Cosa NON è Wireshark
> - **Non è uno strumento di difesa attiva**: non è un firewall, non è un IDS/IPS.
> - **Non modifica il traffico di rete**: è passivo, solo osservazione. Non inietta, non blocca, non altera pacchetti.

## Filtri: cattura vs visualizzazione

| Tipo | Quando agisce | Scopo | Sintassi |
|------|---------------|-------|----------|
| **Capture filter** | Durante la cattura (kernel/BPF) | Ridurre volume dati salvati, evitare overhead | *Berkeley Packet Filter (BPF)* syntax |
| **Display filter** | Dopo la cattura, in GUI | Selezionare cosa mostrare nell'elenco pacchetti | *Wireshark display filter syntax* |

> [!important] Differenza cruciale
> Un *capture filter* scarta i pacchetti **prima** che arrivino a Wireshark (non li vedi mai, non li salvi). Un *display filter* li nasconde solo dalla vista: i pacchetti restano nel file e puoi rimuovere il filtro per rivederli.

### Sintassi base (Display Filter)

```
campo operatore valore
```

Esempio: `ip.addr == 192.168.1.10`

**Campi comuni:**
- `ip.addr`, `ip.src`, `ip.dst` — indirizzi IPv4
- `ipv6.addr`, `ipv6.src`, `ipv6.dst` — IPv6
- `tcp.port`, `tcp.srcport`, `tcp.dstport` — porte TCP
- `udp.port`, `udp.srcport`, `udp.dstport` — porte UDP
- `http.host`, `http.request.uri`, `http.response.code` — HTTP
- `dns.qry.name`, `dns.flags.response` — DNS
- `frame.number`, `frame.time`, `frame.len` — metadati frame
- `eth.addr`, `eth.src`, `eth.dst` — MAC address

**Operatori:**
- Confronto: `==` (uguale), `!=` (diverso), `>` (maggiore), `<` (minore), `>=`, `<=`
- Logici: `and` / `&&`, `or` / `||`, `not` / `!`
- Appartenenza: `contains` (stringa contiene), `matches` (regex PCRE), `in {val1, val2, ...}`
- Bitwise: `&` (AND bit a bit), `|` (OR bit a bit), `^` (XOR)

> [!tip] Esempi pratici
> - `tcp.port == 80` — solo traffico HTTP (porta 80)
> - `ip.addr == 192.168.1.0/24` — traffico da/per subnet (CIDR supportato)
> - `http.request.method == "POST"` — solo richieste POST
> - `tcp.flags.syn == 1 and tcp.flags.ack == 0` — solo pacchetti SYN (inizio connessione)
> - `dns.flags.response == 0` — solo query DNS (non risposte)
> - `frame.len > 1500` — frame jumbo / frammentati

### Capture Filter (BPF syntax)

Sintassi più limitata, classica `tcpdump`-style:
- `host 192.168.1.10` — IP sorgente o destinazione
- `src host 192.168.1.10` / `dst host ...`
- `port 80` — porta sorgente o destinazione
- `src port 80` / `dst port 80`
- `tcp` / `udp` / `icmp` / `arp`
- `net 192.168.1.0/24` — rete
- Combinazioni: `and`, `or`, `not`

Esempio: `tcp port 80 and host 192.168.1.10`

## Statistiche e analisi metriche

Menu **Statistics** → varie voci per analisi aggregate:

- **Conversations** (`Statistics → Conversations`): tabella flussi (IP/TCP/UDP) con byte, pacchetti, durata, rate. Ordinabile per volume → individua *top talkers*.
- **Endpoints** (`Statistics → Endpoints`): indirizzi attivi (IP, MAC, TCP, UDP) con contatori.
- **Protocol Hierarchy** (`Statistics → Protocol Hierarchy`): breakdown percentuale protocolli nella cattura.
- **IO Graphs** (`Statistics → IO Graphs`): grafici throughput/tempo (bit/s, pacchetti/s) con filtri display applicabili.
- **Flow Graph** (`Statistics → Flow Graph`): diagramma a frecce tipo sequence diagram per flussi TCP.
- **Expert Information** (`Analyze → Expert Information`): avvisi/warning/errori rilevati automaticamente (retransmission, zero window, malformed packet, checksum error, ecc.).

> [!tip] Individuare indirizzi sospetti
> Ordina *Conversations* per *Bytes* decrescente: i flussi anomali (es. esfiltrazione dati, beaconing C2, scansioni) spiccano per volume o pattern temporali.

## Follow TCP Stream

**Analyze → Follow → TCP Stream** (o tasto destro su pacchetto TCP → *Follow → TCP Stream*).

Ricostruisce l'intero flusso di comunicazione bidirezionale tra client e server:
- Riassembla segmenti TCP in ordine (gestisce retransmission, out-of-order).
- Mostra dati in vari formati: *ASCII*, *EBCDIC*, *Hex*, *Raw*, *C Arrays*.
- Utile per: HTTP (vedi richiesta/risposta completa), SMTP, FTP, Telnet, protocolli custom testuali.
- Per flussi binari (es. TLS, SSH, protocolli proprietari) usa *Raw* o *Hex* e salva su file per analisi esterna.

## Estrazione oggetti (Export Objects)

**File → Export Objects → HTTP / SMB / TFTP / DICOM / FITS / IMAP / POP / SMB / ...**

Elenca gli oggetti (file) trasferiti dentro i flussi del protocollo selezionato. Permette di salvare singoli oggetti o tutti. Utile per recuperare:
- File scaricati via HTTP (immagini, PDF, eseguibili, malware).
- Allegati email (SMTP/IMAP/POP).
- File trasferiti via SMB/TFTP/FTP.

## Analisi traffico HTTPS/TLS

Wireshark può decifrare TLS se hai le chiavi:

1. **Browser key log** (metodo più comune): imposta variabile d'ambiente `SSLKEYLOGFILE=/path/sslkeys.log` prima di lanciare Firefox/Chrome. Il browser scrive *Client Random* + *Master Secret* per ogni sessione. In Wireshark: *Preferences → Protocols → TLS → (Pre)-Master-Secret log filename* → seleziona file.
2. **Chiave privata server** (solo RSA key exchange, non Forward Secrecy): *Preferences → TLS → RSA keys list* → IP, porta, protocollo, file chiave PEM.
3. **Pre-Master Secret** loggato lato applicazione (es. Java `javax.net.debug=ssl:keymanager`).

> [!warning] Limiti decifratura
> - Cifrari con *Forward Secrecy* (DHE, ECDHE) **non** decifrabili con sola chiave privata server → serve *sslkeys.log* client.
> - TLS 1.3 usa solo (EC)DHE → chiave privata server **mai** sufficiente.

## Sintesi

> [!info] Sintesi:
> - Wireshark = packet sniffer con GUI, open source, live capture (promiscuous mode) + analisi file pcap.
> - Usi: troubleshooting rete, security auditing, debug protocolli, analisi forense post-incidente.
> - Feature: import/export formati, capture/display filters, Follow Stream (ricostruzione flusso), Export Objects (estrazione file), decifratura TLS con chiavi.
> - **Capture filter** (BPF) = scarta durante cattura, meno overhead; **Display filter** (sintassi Wireshark) = nasconde in GUI, dati restano nel file.
> - Operatori display filter: `== != > < >= <=`, `and/or/not`, `contains`, `matches`, `in {...}`.
> - Statistics: Conversations (top talkers), Endpoints, Protocol Hierarchy, IO Graphs, Flow Graph, Expert Info.
> - Follow TCP Stream = riassembla flusso applicativo bidirezionale (ASCII/Hex/Raw).
> - Export Objects = salva file da HTTP, SMB, SMTP, ecc.
> - HTTPS decifrabile con `SSLKEYLOGFILE` (browser) o chiave privata server (solo RSA, no FS).
> - Wireshark è **passivo**: non blocca, non modifica, non è firewall/IDS.