---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 19-10-2025 20:41:19
links:
  - "[[lecture-16102025151651|Lecture 16102025151651]]"
---
# Controllo della concorrenza nei DBMS
---
## Introduzione
Anche se le [[transazione|transazioni]] di un [[dbms|DBMS]] appunto sono eseguite in "isolamento", _nella realtà non sono eseguite in sequenza_! Si cerca di parallelizzare il più possibile tali transazioni, ma per farlo nella maniera più corretta sono necessari dei meccanismi di **controllo delle concorrenze**.

In particolare, si vuole assicurare che:
> L'**ordine di esecuzione delle transazioni, detta [[schedule-di-un-dbms|schedule]], sia scelto in modo tale che l'effetto sia lo stesso del caso di esecuzione sequenziale** (una alla volta).

## Approcci
Ci sono 3 approcci:
- **restrictive** - guarda [[schedule-di-un-dbms-schedule-serializzabile|schedule serializzabili]] che evitano i conflitti attraverso _protocolli di data-locking_;
- **optimistic** - esegue tutte le transazioni in concorrenza, _controllando la presenza di conflitti prima di committare_;
- **timestamping** - assegna dei timestamps alle transazioni che hanno scritto o letto degli oggetti del [[database|database]] e confronta questi valori per determinare l'ordine delle operazioni nello scheduling.

### Restrictive
Ci si vuole fondamentalmente assicurare l'assenza di qualunque conflitto, letteralmente **[[race-condition|race condition]] data da scheduling non serializzabile**, e di fare rollback di transazioni abortite.

Questa proprietà si può ottenere usando un meccanismo di **lock**: _quando due query accedono alla stessa tabella, viene creato un lucchetto che fa passare una transizione alla volta_. Tuttavia, questo può portare addirittura a casi di [[deadlock|deadlock]]!

La tecnica principe si chiama [[strict-2pl|Strict 2PL]].

#### Deadlock
Queste metodologie si basano appunti sul locking, e abbiamo anticipato che **un qualunque meccanismo di locking che risolve l'accesso concorrente agli oggetti del database, puo' causare deadlock**.
![[Drawing 2025-10-19 17.21.48.excalidraw|800]]

In tal caso, il manager delle transazioni ha il compito di intervenire e fare il **rollback** o l'**abort** di una o piu' transazioni per sbloccare il deadlock, consentendo alle altre di procedere.

##### Prevention
Una tecnica di [[deadlock-prevention|deadlock prevention]] e' la seguente. Si sfrutta il fatto che di solito, i DBMS, assegnano una _priorita' ad ogni transazione sulla base della timestamp_. Il lock manager, se la transazione $T_{i}$ richiede un lock posseduto da $T_{j}$, puo' agire nei 2 seguenti modi:
- **Wait-Die** - se $T_{i}$ e' piu' vecchia di $T_{j}$ allora aspetta; altrimenti viene fatta ripartire dopo un _random delay_ ma con lo stesso timestamp (per aumentarne la priorita');
- **Wound-Wait** (ortogonale alla precedente) - se $T_{i}$ e' piu' vecchia, allora $T_{j}$ viene fatta ripartire con un _random delay_ ma con lo stesso timestamp; altrimenti aspetta.

##### Detection
Ci possono essere anche tecniche di [[deadlock-detection|deadlock detection]]. Infatti, se i deadlock sono rari, il DBMS puo' lasciarli avvenire, identificarli e poi risolverli. Gli approcci per la detection sono:
- [[grafo-wait-for|grafo wait-for]] (versione del [[grafo-di-holt|grafo di Holt]]);
- _timeout_ - se la transazione aspetta un periodo maggiore di un certo timeout, viene assunto che e' in deadlock e l'abortisce.

### Optimistic
Il sistema **validation** consiste nel consentire alle **transazioni di accedere ai dati senza locks**, e di **verificare che queste si siano comportate secondo uno schedule serializzabile**.

Le transazioni sono eseguite in 3 fasi:
1. **read** - la transazione e' eseguita leggendo i dati dal DBMS e scrivendoli in un'area privata;
2. **validation** - prima del commit, il DBMS fa tale check, verificando se ci sono state race condition, e nel caso abortisce la transazione e la fa ripartire;
3. **write** - se la fase di validazione ha successo, i dati scritti nell'area privata sono copiati nel DBMS.

### Timestamping
E' sempre un controllo di concorrenza ottimistico... L'idea appunto e' quella di assegnare una timestamp $TS$ ad ogni transazione all'inizio della sua esecuzione. Quindi, per ogni operazione $a_{i}$ eseguita da $T_{i}$:
- se l'operazione $a_{i}$ fa conflitto con l'operazione $a_{j}$ eseguita da $T_{j}$ e $TS_{i} < TS_{j}$, allora $a_{i}$ dev'essere eseguita prima di $a_{j}$;
- se un'operazione eseguita da $T$ viola l'ordine, la transazione $T$ e' abortita e restartata con un $TS$ piu' grande.

## Referenze