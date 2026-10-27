# Chiavi SSH private e pubbliche

*Definizione:* una coppia di chiavi SSH è composta da una **chiave privata**, che resta sul client, e una **chiave pubblica**, che viene copiata sul server (in `~/.ssh/authorized_keys`).

**Chiave privata:** resta sul client e firma la sfida di autenticazione inviata dal server. Non va mai condivisa né inviata al server. Può essere protetta da una passphrase; *ssh-agent* la tiene decrittata in memoria durante la sessione.

**Chiave pubblica:** va sul server e serve a verificare la firma prodotta con la chiave privata. Se la verifica riesce, l'accesso è concesso senza password.

In SSH client-server, al primo contatto il server invia una sfida crittografica; il client la firma con la chiave privata e il server verifica con la chiave pubblica. Copiando solo la chiave pubblica sul server (es. con `ssh-copy-id`) si abilita l'accesso senza password, più sicuro perché evita gli attacchi brute-force.

> [!info] Sintesi:
> - Chiave privata: resta sul client, firma la sfida di autenticazione, mai condivisa
> - Chiave pubblica: va sul server in authorized_keys, verifica la firma del client
> - L'autenticazione a chiave evita gli attacchi brute-force sulle password
