# Firewall

Il firewall aiuta ed è necessario, ma non rende una macchina necessariamente sicura. <u>Non è un componente della rete, ma un insieme di componenti che cooperano tra loro:</u>

- firewall e Intrusion Detection System (IDS);
- scanner di contenuti di posta e web per virus e codice malevolo (worms);
- personal firewall.

*Osservazione:* il firewall è l'ultima linea di difesa, a completamento dei livelli di difesa di [[Lezione 1-Fondamenti di sicurezza informatica e protezione dei sistemi|Lezione 1]].

*Definizione:* i firewall di rete sono apparecchiature o sistemi che controllano il flusso del traffico di rete tra due reti con livelli di sicurezza differenti (*different security postures*, NIST).

## Cosa può fare un firewall

- Schermare alcune reti interne e nasconderle alle altre.
- Bloccare alcuni accessi a servizi o a utenti.
- Monitorare il traffico (*log function*).
- Realizzare VPN (*virtual private network*), cioè la crittazione automatica dei dati tra i siti: garantisce la confidenzialità dei dati scambiati tra i due gateway.

> [!warning] Limiti dei firewall:
> - Non proteggono le singole macchine.
> - Le macchine vanno configurate e protette come se il firewall non esistesse.
> - Non difendono da bug nuovi non ancora documentati nei protocolli.
> - I filtri sono difficili da impostare e da mantenere (compromesso tra libertà e sicurezza).
> - Possono degradare la performance della rete.

## Politiche di filtraggio e difesa perimetrale

Due filosofie opposte:

- *Default deny:* tutto ciò che non è espressamente ammesso è proibito.
- *Default permit:* tutto ciò che non è espressamente proibito è ammesso.

*Principio:* difesa perimetrale. Si proteggono tutti i cammini di ingresso alla rete privata, riducendoli a una sola porta di ingresso; all'interno della rete gli host si fidano tra loro.

**Servizi add-on:** funzioni aggiuntive che il firewall può integrare.

- NAT (*static e hiding translation*): traduce gli indirizzi privati della rete interna in un indirizzo pubblico, così gli host interni non restano visibili direttamente dall'esterno.
- DHCP: assegna automaticamente gli indirizzi IP e gli altri parametri di rete agli host interni.
- Funzionalità di cifratura (VPN): cifra il traffico tra due gateway, garantendo confidenzialità e integrità dei dati scambiati.
- Filtraggio del contenuto applicativo (*application content filtering*): esamina i dati applicativi (allegati di posta, pagine web) per bloccare virus e codice malevolo.

## Tipi di firewall

- **Packet-filtering firewall:** decide su ogni pacchetto in base ai campi delle intestazioni (indirizzi e porte sorgente/destinazione, protocollo), applicando un insieme di regole in ordine. È semplice, trasparente agli utenti e veloce, ma non esamina i dati applicativi.
- **Stateful inspection firewall:** oltre ai campi dei pacchetti mantiene una tabella delle connessioni aperte e lascia passare solo il traffico che corrisponde a una connessione stabilita; alcuni tracciano anche i numeri di sequenza TCP per contrastare dirottamenti di sessione.
- **Application-level gateway (proxy applicativo):** fa da relè a livello applicativo: l'utente contatta il gateway, che si collega per lui al server remoto e inoltra i dati applicativi. È più sicuro perché esamina i comandi applicativi, ma introduce overhead su ogni connessione.
- **Circuit-level gateway (proxy di circuito):** stabilisce due connessioni TCP, una verso l'host interno e una verso l'host esterno, e si limita a inoltrare i segmenti senza esaminarne il contenuto, decidendo solo quali connessioni ammettere.

> [!info] Sintesi:
> - Il firewall controlla il flusso di traffico tra reti con livelli di sicurezza diversi, ma è l'ultima linea di difesa e non protegge le singole macchine.
> - È un insieme di componenti (firewall, IDS, scanner antivirus, personal firewall) e può offrire servizi add-on come NAT, DHCP, VPN e filtraggio di contenuto.
> - La difesa perimetrale concentra gli ingressi in un'unica porta e si basa su una politica *default deny* o *default permit*.
> - I tipi principali sono packet-filtering, stateful inspection, application-level gateway e circuit-level gateway.

