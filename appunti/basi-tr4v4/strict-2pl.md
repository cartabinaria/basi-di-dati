---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 19-10-2025 20:51:10
links:
  - "[[lecture-16102025151651|Lecture 16102025151651]]"
---
# Strict 2PL
---
## Introduzione
> La tecnica **Strict 2PL** (**Strict 2-Phase Locking**) e' realizzata per gestire il [[controllo-della-concorrenza-nei-dbms|controllo della concorrenza]] delle [[transazione|transazioni]] nei [[dbms|DBMS]] in modo _restrittivo_.

## Funzionamento
Se una transazione vuole fare una _read/write_ su un oggetto del [[database|database]], deve ottenere l'accesso esclusivo, mediante un lock; dopo averlo rilasciato, pero', non puo' richiederne di nuovi; e la transazione rilascia tutti i suoi lock quando ha fatto il _commit_.

Quindi fondamentalmente **ogni transazione avanza prendendo delle risorse**; poi **le rilascia tutte solo dopo che ha terminato la sua esecuzione**.

Il Lock manager traccia gli accessi esclusivi agli oggetti del database in una **lock table**.

Si chiama "2-Phase Locking" perche' il locking avviene seguendo 2 fasi:
- _fase di acquisizione_;
- _fase di rilascio_;

![[strict-2pl-fasi.png]]

## Garanzie
Questa tecnica **garantisce l'esistenza di [[schedule-di-un-dbms-schedule-serializzabile|schedule serializzabili]]**! In particolare:
- se le transazioni accedono ad oggetti differenti, possono eseguirsi parallelamente senza problemi;
- se le transazioni devono accedere a uno stesso oggetto, e almeno una lo vuole modificare, allora si eseguono serialmente;

### Esempio
Potremmo implementare lo strict 2PL nella seguente maniera:
- _shared lock_ per leggere $A$;
- _exclusive lock_ per scrivere su $A$.

Quindi:
- se una transazione vuole leggere $A$, prima deve ottenere lo shared lock;
- se una transazione vuole scrivere $A$, prima deve ottenere l'exclusive lock;
- uno shared lock rifiuta richieste di exclusive lock ma non blocca richieste di shared lock da altre transazioni;
- un exclusive lock rifiuta ogni richiesta di lock;
- tutti i lock sono rilasciati a seguito del commit.

## Referenze