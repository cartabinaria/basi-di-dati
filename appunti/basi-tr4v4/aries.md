---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 20-10-2025 11:55:59
links:
  - "[[lecture-16102025151651|Lecture 16102025151651]]"
---
# ARIES
---
## Introduzione
> L'[[algoritmo|algoritmo]] **ARIES** (**Advanced Recovery and Integrated Extraction System**) e' eseguito dal _logging and recovery manager di un [[dbms|DBMS]]_ in caso di system failure come meccanismo di [[crash-recovery-nei-dbms|crash recovery]].

## File di log
Proprio in ARIES, il file di log e' lo strumento cardine per fare il rollback in caso di crash. Vediamo come funzionano.

Tracciano tutte le azioni performate dal DBMS, e vengono salvati sottoforma di record in _speciali storage_, in grado di sopravvivere crashes e failures (o almeno cosi' si assume).

Tali record sono ordinati secondo un `id` univoco, chiamato **Log Sequence Number** ([[lsn|LSN]]). La _tail_ (parte piu' recente) di un file di log e' mantenuta in un buffer di log e salvato periodicamente negli storage speciali.

Abbiamo la **Dirty Page Table** che mantiene un record di tutti gli `id` delle pagine che sono state modificate ma non ancora scritte nello storage speciale, e anche il primo LSN che ha reso tale pagina dirty.

La **Transaction Table** invece mantiene un record di tutti gli `id` delle transazioni che sono correntemente in esecuzione, e l'LSN dell'ultimo log che hanno provocato.

Quindi, un record di un file di log si presenta nel seguente modo:
$$<LSN, Transaction ID, Page ID, Redo, Undo, PreviousLSN>$$
dove:
- $Transaction ID, Page ID$ identificano rispettivamente la transazione e la pagina coinvolta dal log;
- $Redo, Undo$ mantengono informazioni riguardo ai cambiamenti salvati dal log e come farne l'undo;
- $Previous LSN$ punta al record precedente che e' stato creato per la stessa transazione, e permette di fare il rollback delle transazioni abortite.

### Creazione
Ma quando viene creato un record all'interno di un file di log? Per ognuno di questi eventi:
- **page update**
- **commit**
- **abort**
- **end**
- **undoing operation**

## Checkpoint
E' uno snapshot dello stato del database. Questi riducono il _recovery time_, perche' **non si deve fare il redo di tutti i file di log, ma solo dal checkpoint in poi**.

I checkpoint sono creati in ARIES in 3 step:
1. _begin-checkpoint_ scritto sul file di log;
2. _end-checkpoint_, contenente la dirty page table e la transaction table, scritto sul file di log;
3. _master record_ scritto sullo storage speciale (non buffer), contenente l'LSN del begin-checkpoint, dopo che l'end-checkpoint e' stato scritto sullo storage speciale.

Questo viene chiamato **fuzzy checkpoint** ed e' estremamente efficiente: non interrompe le normali operazioni del DBMS e non richiede di scrivere le pagine sul buffer.

## Funzionamento
Si compone di 3 fasi:
1. **fase di analisi** - identifica le [[paginazione|pagine]] _dirty_ del buffer (quelle non ancora scritte sul disco) e le [[transazione|transazioni]] attive al momento del crash --> usa la Dirty Page Table e la Transaction Table;
2. **fase di redo** - da un checkpoint del file di log (gestito dal Log manager), ripete tutte le operazioni riportanto il DB nello stato in cui era al momento del crash; nel dettaglio controlla la dirty page table e identifica il minimo LSN (ultimo) di una pagina dirty; da li' rifa' tutte le operazioni fino al crash;
3. **fase di undo** - cancella tutte le operazioni delle transazioni che erano attive al momento del crash ma che non avevano ancora committato, in ordine chiaramente inverso.

## Principi
I principi di ARIES sono:
- **write-ahead logging** - ogni cambiamento a un oggetto del [[database|database]] dev'essere scritto sul file di log; successivamente, questo, dev'essere scritto nella memoria secondaria; infine, la corrispondente pagina modificata dev'essere updatata (nella memoria secondaria);
	- questa cosa e' fondamentale per la fase di redo, perche' qualora il crash fosse avvenuto prima della modifica della pagina, durante il redo si legge il log e si fanno tutte le modifiche;
- **repeating history during redo** - il sistema dopo il crash sia riportato allo stato subito precedente al crash, e che le operazioni delle transizioni attive sono cancellate in ordine inverso;
- **logging changes during undo** - le modifiche fatte al database durante il rollback sono esse stesse loggate per assicurare che non siano ripetute in caso di crash continui.

## Referenze