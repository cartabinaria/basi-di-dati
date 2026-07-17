---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 19-10-2025 19:53:16
links:
  - "[[lecture-16102025151651|Lecture 16102025151651]]"
---
# Schedule di un DBMS
---
## Introduzione
> In un [[dbms|DBMS]] una **schedule** $S$ è una sequenza di azioni (read, write, commit e abort) prese da un'insieme di [[transazione|transazioni]].

L'ordine dello schedule è lo stesso delle transazioni corrispondenti: _segue comunque i passi cronologici delle transazioni_.

Per esempio, se abbiamo le seguenti due transazioni sulle tabelle $A, B, C$:
- $T_{1}: read_{1}(A), write_{1}(A), read_{1}(C), write_{1}(C)$
- $T_{2}: read_{2}(B), write_{2}(B)$

allora una possibile schedule $S$ potrebbe essere:
$$S: read_{1}(A), write_{1}(A), read_{2}(B), write_{2}(B), read_{1}(C), write_{1}(C)$$

## Proprietà
Una schedule può essere:
- **completa** - ossia include le operazioni di _commit_ e di _abort_ per ogni transazione (altrimenti solo _read_ e _write_);
- **seriale** - per ogni transazione, tutte le sue operazioni sono eseguite consecutivamente, ossia c'è solo una transazione in atto alla volta.

<u>Nota bene</u>: non sono proprietà ortogonali!

### Schedule serializzabile
> Una **schedule serializzabile** è una schedule cui effetto su un'istanza di database (consistente) è _garantito essere identica a quello di una schedule completa e seriale_.

Di base, quindi, **quello che cerchiamo sono proprio degli schedule serializzabili**! Vogliamo cercare di schedulare le transazioni in modo da _diminuire il più possibile la "serialità"_ (esecuzione una dopo l'altra) e _aumentare quindi il grado di "parallelismo"_, ma **garantendo che l'effetto della sua esecuzione sia lo stesso di una seriale**.

## Conflitti
Il problema è che questo è difficile da ottenere... L'esecuzione di anche solo 2 transazioni $T_{1}, T_{2}$ in parallelo (secondo una schedule) può generare 3 tipi di conflitti:
- **conflitto write-read** - $T_{2}$ legge un oggetto scritto da $T_{1}$ ma $T_{1}$ non ha ancora committato (non ha ancora finito la sua esecuzione);
- **conflitto read-write** - $T_{2}$ scrive un oggetto letto da $T_{1}$ ma $T_{1}$ non ha ancora committato;
- **conflitto write-write** - $T_{2}$ scrive un oggetto scritto da $T_{1}$, ma $T_{1}$ non ha ancora committato.

In generale si possono anche presentare le cosiddette **anomalie fantasma**: quando una transazione legge una tabella in due momenti diversi e trova delle differenze (un'altra transazione l'ha modificata).

Un altro enorme problema si presenta quando, in casi di _interleaving_ (ossia di [[multiprogramming|parallelismo apparente]]), avviene un aborto di una transazione:
![[aborto-transazione-1.png]]

In questo caso, un conflitto write-read fa leggere a $T_{2}$ il valore di $A$ scritto da $T_{1}$, e già è un problema... Ma inoltre, $T_{1}$ abortisce alla fine, per cui **tutte le sue operazioni dovrebbero essere cancellate** (**rollback**). Per fare ciò dovremmo anche far abortire $T_{2}$! Tuttavia questo viola la **proprietà di durabilità delle transazioni** ([[acid|ACID]]).

Tutti questi conflitti sono risolti usando i meccanismi di [[controllo-della-concorrenza-nei-dbms|controllo della concorrenza]] dei DBMS.

## Referenze