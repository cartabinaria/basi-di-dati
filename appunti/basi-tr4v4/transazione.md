---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 25-09-2025 22:17:45
links:
  - "[[lecture-25092025151622|Lecture 25092025151622]]"
  - "[[lecture-26092025151541|Lecture 26092025151541]]"
  - "[[lecture-16102025151651|Lecture 16102025151651]]"
---
# Transazione
---
## Introduzione
> Una **transazione** in un [[database|database]] è un _elenco non decomponibile/distaccabile di operazioni che devono essere eseguite atomicamente in un sistema concorrente_[^1].
> In altri termini, rappresentiamo le transazioni come l'_esecuzione di un programma utente in un [[dbms|DBMS]] che include una o piu' operazioni di lettura/scrittura_.

Se implementate bene, ovviamente, risolvono le [[race-condition|race condition]] che si potrebbero verificare su accessi concorrenti al database.

Per esempio la _prenotazione contemporanea da parte di 2 persone su uno stesso posto su un treno deve essere gestita in modo da non generare 2 biglietti uguali_.

Inoltre, l'effetto delle transazioni dev'essere permanente: il _risultato finale dev'essere loggato e tracciato_ (anche se contiene un errore).

### Azioni
In particolare, ogni transazione deve specificare l'azione finale compiuta:
- **commit** - la transazione è andata a buon fine e il sistema di logging ha aggiornato lo stato del database;
- **abort** - la transazione è stata abortita, il sistema di crash recovery ha fatto il rollback per far tornare il database in uno stato consistente.

## Problemi
Se volessimo riassumere, i problemi principali delle transazioni da affrontare sono:
- **[[controllo-della-concorrenza-nei-dbms|esecuzione concorrente]]** - vogliamo eseguire piu' transazioni contemporaneamente, in modo concorrente, per tenere la CPU occupata
- **[[crash-recovery-nei-dbms|crash recovery]]** - un crash del sistema (anche fisico) potrebbe interrompere una transazione, lasciando il database in uno _stato inconsistente_

Ovviamente, quindi, si vuole fare in modo che questi _problemi siano risolti in modo trasparente rispetto all'utente_.

Si fa riferimento alle proprieta' [[acid|ACID]].

### Casi di aborto
Le transazioni possono abortire in casi di
- **anomalia interna**
- **condizioni di eccezione**
- **crash di sistema**

## Parametri
I parametri di una transazione sono:
- `ACCESS MODE` - imposta i permessi per modificare le tabelle usate nella transazione
	- `READ ONLY`
	- `READ WRITE`
- `STATEMENT MODE` - specifica le azioni da prendere quando le transazioni terminano
- `ISOLATION LEVEL` - specifica in che modo trattare le transazioni che modificano il database, e vanno da un livello di isolamento basso ad uno alto
	- `READ UNCOMMITTED` - le transazioni richiedono dei lock per la scrittura, e nessuno per la lettura;
	- `READ COMMITTED` - le transazioni richiedono dei lock per la scrittura e dei lock condivisi per la lettura; questo già garantisce che ogni dato letto è committato al momento in cui è letto;
	- `REPEATABLE READS` - le transazioni richiedono dei lock sia per scrivere che per leggere ogni oggetto del database, e li rilasciano solo dopo che hanno committato;
	- `SERIALIZABLE` - è come il precedente, ma in più ci sono dei lock per la scannerizzazione al livello di tabella;

![[conflitti-e-livelli-di-isolamento.png]]

## Referenze
- [[acid|ACID]]
- [[schedule-di-un-dbms|Schedule di un DBMS]]

[^1]: letteralmente un'[[azione-atomica|azione atomica]]
