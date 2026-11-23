# IP Security

## Vulnerabilità di Diffie-Hellmann e man-in-the-middle

Diffie-Hellmann presenta alcune vulnerabilità:

- Nessuna forma di autenticazione
- Possibile attacco man-in-the-middle
- È computazionalmente costoso, quindi si presta bene per DoS sul ricevente (calcolare K = Ya^Xb mod β è costoso)

### Man-in-the-middle su Diffie-Hellmann

1. A → B : Ya    (intercettato da C)
   C(A) → B : Yc
2. B → A : Yb    (intercettato da C)
   C(B) → A : Yc

A calcola K1 = Yc^Xa mod β
B calcola K2 = Yc^Xb mod β
C calcola K1 = Ya^Xc mod β                  K2 = Yb^Xc mod β

## Oakley risolve le vulnerabilità di Diffie-Hellmann

Oakley risolve le vulnerabilità perché:

- Ambedue i messaggi sono autenticati (firma digitale, oppure codifica con la chiave privata del mittente, oppure codifica con chiave simmetrica negoziata diversamente)
- Appropriato uso di nonce
- Complicazione dell'accesso mediante cookie

### Protocollo Oakley

```
A → B : Ca, {A, B, Na, Ya}SKa
B → A : Cb, Ca, {B, A, Nb, Na, Yb, Ya}SKb
A → B : Ca, Cb, {A, B, Na, Nb, Ya, Yb}SKa
```

- Autenticazione. No man-in-the-middle.
- B esegue l'esponenziazione solo quando A si è impegnata fino al passo 3.

## ISAKMP/Oakley

Combinazione dei due protocolli a livello applicazione (porta UDP 500). Si studia il contenuto (payload) dei pacchetti, tralasciandone il formato completo, e si studia il funzionamento di base.

### ISAKMP — alcuni payload

- **SA:** l'associazione che si sta negoziando
- **Proposta (Proposal):** quale protocollo usare per questa SA, se AH, ESP o ESP con autenticazione. No combinazioni di protocolli: una SA per protocollo.
- **Trasformazione (Transform):** quali hash usare per il MAC
- **Hash:** per autenticare e garantire l'integrità del pacchetto

### ISAKMP — funzionamento di base

- **Scambio base:** simile a Oakley ma semplificato dei meccanismi di firma e arricchito con la negoziazione della SA completa di protocollo e trasformazione
- **Scambio con protezione dell'identità:** come il precedente più i meccanismi di firma e scambio dei certificati relativi
- **Scambio solo autentica:** per mutua autenticazione ma senza scambio chiavi
- **Scambio aggressivo:** semplifica al massimo i messaggi (anche rispetto a 1) perdendo protezione dell'identità
- **Scambio informativo:** per gestione di SA esistenti (notifica d'errore, cancellazione)

## Table 9.3 — IKE Payload Types

| Tipo | Payload | Descrizione |
|---|---|---|
| 0 | Riservato | — |
| 1 | SA | Security Association |
| 2 | Proposal | Proposta di protocollo e trasformazioni per una SA |
| 3 | Transform | Trasformazione crittografica (algoritmo per il MAC) |
| 4 | Key Exchange | Scambio chiavi (es. Diffie-Hellman) |
| 5 | Identification | Identificazione delle entità comunicanti |
| 6 | Certificate | Certificato digitale |
| 7 | Certificate Request | Richiesta di certificato |
| 8 | Hash | Hash per autenticazione e integrità |
| 9 | Signature | Firma digitale |
| 10 | Nonce | Numero casuale per prevenire replay |
| 11 | Notification | Notifica di errore o stato |
| 12 | Delete | Cancellazione di una SA |
| 13 | Vendor ID | Identificativo del produttore |

> [!info] La Table 9.4 si trova a pagina 318 del libro di testo.

## ESP Encryption Algorithms

| Name | Status | AEAD | Comment |
|---|---|---|---|
| ENCR_NULL | MUST | No | [RFC2410] |
| ENCR_AES_CBC | MUST | No | [RFC3602] |
| ENCR_AES_CCM_8 | SHOULD | Yes | [RFC4309] (IoT) |
| ENCR_AES_GCM_16 | MUST | Yes | [RFC4106] |
| ENCR_CHACHA20_POLY1305 | SHOULD | Yes | [RFC7634] |

## ESP Authentication Algorithms

| Name | Status | Comment |
|---|---|---|
| AUTH_NONE | MUST / MUST NOT | [RFC7296][RFC5282] — AEAD-only |
| AUTH_HMAC_SHA1_96 | MUST- | [RFC2404][RFC7296] |
| AUTH_AES_XCBC_96 | SHOULD / MAY | [RFC3566][RFC7296] — (IoT) |
| AUTH_AES_128_GMAC | MAY | [RFC4543] |
| AUTH_AES_256_GMAC | MAY | [RFC4543] |
| AUTH_HMAC_SHA2_256_128 | MUST | [RFC4868] |
| AUTH_HMAC_SHA2_512_256 | SHOULD | [RFC4868] |

## ESP Compression Algorithms

| Name | Status | Comment |
|---|---|---|
| IPCOMP_DEFLATE | MAY | [RFC3173] |
| IPCOMP_LZS | MAY | [RFC2395] |
| IPCOMP_LZJH | MAY | [RFC3051] |


