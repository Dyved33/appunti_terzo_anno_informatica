# SSH — Secure Shell

## Cos'è?
**SSH** (Secure Shell) è un protocollo di rete per effettuare login remoto ed eseguire comandi (eseguire una shell) su una macchina remota.

Utilizza alcune funzioni crittografiche per garantire la sicurezza.

È nato per rimpiazzare sia telnet che i remote unix shell protocols, ovvero protocolli/comandi come rcp, rlogin, rexec, rsh, che mancavano di qualsiasi forma di crittografia a proteggere le comunicazioni.

Il problema nella pratica era proprio che Telnet e remote shell (rsh) mandavano pure le credenziali di autenticazione in chiaro nella rete quando c'era bisogno di fare login.

Il principale client/server per SSH è **OpenSSH**, un progetto open source mantenuto dagli sviluppatori di OpenBSD.

## SSH server setup

```sh
sudo apt update
sudo apt install openssh-server
sudo systemctl enable --now ssh
```

## Funzionalità dello stack SSH
Oltre a rimpiazzare telnet, il protocollo SSH viene usato anche per altri scopi:

- **Port Forwarding** (Local, Remote, Dynamic)
- **X11 Forwarding** (esecuzione di applicazioni GUI remote, tipo anche VSCode)
- **SFTP** (File Transfer Protocol)
- **SCP** (Copy Protocol)

## Fasi di una connessione SSH

1. **Inizializzazione e apertura connessione TCP**
   - Il client apre una connessione TCP verso il server sulla porta 22 (solitamente).
   - Si fa handshake TCP.
2. **Negoziazione del protocollo e algoritmi**
   - Client e server si scambiano le versioni del protocollo SSH.
   - Il client invia la lista di metodi di cifratura (sia simmetrica che asimmetrica), MAC e compressione supportati.
   - Il server risponde con i metodi che può usare e viene scelto un algoritmo supportato da entrambi.
3. **Autenticazione del server.**
4. **Autenticazione del client.**
5. **Apertura del canale e utilizzo della sessione.**

## Autenticazione del server verso il client
Il protocollo SSH usa la crittografia a chiave pubblica per l'autenticazione del server e del client, oltre che per stabilire la chiave simmetrica da usare per cifrare la comunicazione successiva (come nel TLS).

La verifica dell'autenticazione solitamente non è necessariamente affidata a delle CA (come nel TLS) ma più spesso si trova un approccio **TOFU** (*Trust on First Use*).

TOFU consiste nel fatto che, quando ci connettiamo da client per la prima volta a un server OpenSSH, il server ci manda la sua chiave pubblica. Il nostro client OpenSSH verifica se abbiamo già questa chiave pubblica salvata in locale (in `~/.ssh/known_hosts`); se sì, continuiamo. Altrimenti, se non abbiamo salvato la chiave pubblica del server in locale, ci dà una schermata in cui ci dice che non riesce a verificare l'autenticità del server, e ci chiede se vogliamo aggiungere la chiave pubblica del server tra quelle verificate.

## Autenticazione del client verso il server
Un client si può autenticare in tre principali modi al server:

1. **Password based authentication:** il client specifica username e password come un normale login. Non c'è nessun controllo di chiavi crittografiche.
2. **Public Key authentication:** il server ha una cartella in locale (`~/.ssh/authorized_keys`), con la lista delle chiavi pubbliche dei client autorizzati. Il server manda una *challenge* (un numero random) al client che la deve cifrare con la sua chiave privata. Il client risponde e il server così può verificare l'autenticità del client.
3. **Host based:** più raro. Suppone che su un host ci siano vari utenti e che quindi, invece di creare account diversi per ogni utente, l'autenticazione è dell'host e non degli utenti dell'host.

## Public Key authentication
Sul client, generiamo coppia di chiavi:

```sh
ssh-keygen -t rsa -b 4096 -C "commentoTestBho"   # (-t ed25519 più moderno)
```

Ci chiederà il path dove salvare la coppia di chiavi e una password (opzionale) di cifratura per la chiave.

Sul server, dovremo aggiungere la chiave pubblica del client nella directory `~/.ssh/authorized_keys` del server. Usiamo l'utility fatta apposta (va bene qualsiasi modo):

```sh
ssh-copy-id -i ~/.ssh/id_rsa.pub osboxes@192.168.1.58
```

Facciamo login SSH specificando il percorso in locale della chiave privata:

```sh
ssh -i ~/.ssh/id_rsa osboxes@192.168.1.58
```

## Port forwarding

### Local Port Forwarding
Il **Local port forwarding** è una tecnica usata per inoltrare una porta dalla macchina client alla macchina server. Praticamente il client SSH sta in ascolto sulla porta in locale e ciò che riceve lo inoltra tunnelato (sfruttando il collegamento SSH sicuro) al server SSH.

Lo scopo è usare il server SSH come una macchina per fare le richieste al posto nostro.

Esempio: un database MSSQL è accessibile solo dalla rete interna, di cui fa parte il server SSH. Noi nel nostro computer setupiamo SSH con local port forwarding per contattare il server SSH:

```sh
ssh -N -L PORTA_LOCALE:DESTINAZIONE:PORTA_DESTINAZIONE utente@server_ssh
```

Esempio:

```sh
ssh -L localhost:1433:intranet.mssql_server.com:1433 sshUser@exposed_ssh_server.com
```

Poi sulla nostra macchina possiamo runnare MSSQL su `localhost` e ci reindirizza a quella nella rete interna.

La destinazione può anche essere sul server stesso: `ssh -N -L 8080:127.0.0.1:80 utente@server`. Tutte le richieste che arrivano alla nostra macchina nella porta che abbiamo scelto verranno inoltrate alla destinazione tramite il server SSH.

### Remote Port Forwarding
Il **Remote port forwarding** è l'opposto del local port forwarding: questa volta tutto ciò che il server riceve a una determinata porta verrà forwardato a una porta nel nostro client.

Uno scenario tipico è quando vogliamo temporaneamente esporre all'esterno un servizio che è visibile solo in locale e possediamo un server che si interfaccia con l'esterno (es. stiamo sviluppando un sito web ma non sulla macchina con IP pubblico e vogliamo farlo provare a qualcuno non in rete locale).

```sh
ssh -N -R PORTA_REMOTA:DESTINAZIONE:PORTA_DESTINAZIONE utente@server_ssh
```

Esempio: `ssh -R 0.0.0.0:8080:server:8080 sshUser@public_facing_srv`.

Si può usare per esporre sia servizi in locale (sulla nostra stessa macchina) che per esporre l'accesso a una macchina raggiungibile da noi, es. in rete locale.

### Remote port forwarding con Ngrok
Dato che non abbiamo un server interfacciato con l'esterno, se vogliamo testare l'utilità del remote port forwarding usiamo **ngrok**.

Ngrok è un servizio di remote port forwarding che ci assegna temporaneamente un dominio pubblico e ce lo forwarda a una porta sulla nostra macchina remota.

Con questo comando stiamo dicendo a ngrok di forwardare traffico HTTP alla nostra port 456 locale. Quindi ad esempio eseguiamo un server HTTP (una pagina web semplice) e facciamola girare sulla port 456 locale. Ngrok ci darà un link per contattarlo da rete esterna.

### Dynamic Port Forwarding
Il **Dynamic port forwarding** è simile al local port forwarding, ovvero ci permette di raggiungere altre destinazioni tramite il server specificato, tuttavia ci permette di scegliere una destinazione diversa per ogni connessione, senza specificarla nel comando.

- Local port forwarding: `ssh -N -L 8080:servizio.interno:80 utente@server`
- Dynamic port forwarding: `ssh -N -D 127.0.0.1:1080 utente@server`

Praticamente la porta locale 1080 diventa un proxy SOCKS5 e un programma la usa.

## X11 forwarding
**X11** è un protocollo usato su Linux/Unix per interfacce grafiche.

Facendo X11 forwarding, il server SSH invia al client SSH la finestra GUI al client. È molto utile per eseguire applicazioni GUI sul server remoto ma avere la GUI nel client locale.

Ad esempio vogliamo sviluppare/compilare su una certa macchina che ha tutto setupato ma vogliamo forwardare Visual Studio Code sulla nostra macchina così possiamo scrivere codice comodamente.

[[Approfondimento chiavi SSH private e pubbliche|Chiavi SSH private e pubbliche]]

