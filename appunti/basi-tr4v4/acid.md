---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 19-10-2025 20:19:11
links:
  - "[[lecture-16102025151651|Lecture 16102025151651]]"
---
# ACID
---
## Introduzione
> Per **ACID** si intendono le proprietà che devono essere soddisfatte affinche' ci sia l'_esecuzione [[concorrenza|concorrente]] safe delle [[transazione|transazioni]] e un meccanismo di crash recovery_ all'interno di un [[dbms|DBMS]].

## Proprietà
Le proprieta', invarianti, sono:
- **Atomicity** - una transazione è un'[[azione-atomica|unità atomica di esecuzione]], non ci dev'essere uno stato nel database in cui una transazione e' stata eseguita parzialmente;
- **Consistency** - tutte le transazioni devono preservare la consistenza del database;
- **Isolation** - ogni transazione deve apparire come se nessun'altra transazione stia venendo eseguita nello stesso momento;
- **Durability** - una volta che la transazione è avvenuta, i cambiamenti devono essere commitati, e non devono essere mai persi per nessuna ragione.

### Consistenza
La _consistenza dev'essere assicurata dall'utente_: le sue query non devono porre il database in uno stato inconsistente, e talvolta i [[vincoli-di-integrita|vincoli di integrita']] non sono sufficienti a garantire cio'.

Di base, lo stato del database durante l'esecuzione di una transazione è il seguente:
1. **parte da uno stato consistente** - tutti i vincoli di integrità sono soddisfatti;
2. **passa, eventualmente, attraverso stati inconsistenti** intermedi - durante l'esecuzione della transazione;
3. **torna allo stato inconsistente** - i vincoli tornano ad essere soddisfatti.

![[consistenza-db.png]]

<u>Nota bene</u>: lo _stato di un database_ sono le tabelle e i dati che lo compongono.

Di fatto, in caso di aborto, faccio rollback, e quindi torno comunque in uno stato consistente $\implies$ **il database è sempre in uno stato consistente**.

### Isolamento
L'isolamento e' garantito dalla scelta di uno [[scheduling|scheduling]] "parallelo" tale che il suo effetto sia lo stesso dell'esecuzone sequenziale delle transazioni.

Il problema e' che il DBMS non puo' garantire che le transazioni siano eseguite in un ordine specifico.

### Atomicita'
E' garantita dal _sistema di logging_ implementato dal DBMS. Se avviene un caso di aborto di transazione, il DBMS controlla tali log e fa un **rollback** del database dell'ultimo stato consistente salvato, ossia prima dell'aborto della transazione.

### Durabilita'
Anche la durabilità è garantita dal _sistema di logging_.

## Referenze