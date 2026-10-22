Network analyzer cosa è

Wireshark:
- è un packet sniffer = permette di sniffare pacchetti di rete e locali 
- Simile a tcpdump ma con GUI
- Molte funzionalità interessanti come la conversione dei dai in file
- Possiamo usarlo sia per analizzare file di cattura ma anche per catturare in live con la cheda di rete messa in modalità promiscua
- Open source

Utilizzi
- Amministratori di rete lo possono utilizzare per localizzare e risolvere problemi di rete
- Amministratori di rete possono usarlo per esaminare porblemi di sicurezza ed eventuali 'leak' all'interno della rerte
- Debuggare un protocollo
- Analisi forense (es post incidente, capire deove sono entrati)

Features
- Catturare paccheitti live da un interfaccia di rete mostrare in GUI informazioni molto dettagliate su pacchetti
- Importare ed esportare dati da altri programmi di cattura
- Filtri di cattura e visualizzazione
- Ricostruszione delle conversazioni (follow stream)
- Estrazione di oggetti dalle catture (es file)
- Anali traffico HTTPS quando si possiedono le chiavi

NON è
- Uno strumento di difesa, ne firewall ne IDS
- Non modifica il traffico di rete

Filtri di cattura e filtri visualizzazione
In wireshark i filtri poissono essere si a idi cattura, che filtrano quale traffico acquisisre, che di visualizzazione, che semplicemente filtrano quale traffico mostrare in GUI

Sintassi di base: campo operatore valore. Es ip.addr == 192.168.1.10

Gli operatori sono: `==, !=, <, >, and, or, //manca//`

Statistiche: analissi delle metriche e dei nodi di rete in wireshark, permettono di vedere quali sono indirizzi sospetti e dove vanno

Follow tcp stream: analisi dell'intero flusso di comunicazione tra client e server 