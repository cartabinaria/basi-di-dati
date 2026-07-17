---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 13-10-2025 00:00:28
links:
  - "[[lecture-08102025101345|Lecture 08102025101345]]"
---
# Calcolo relazionale su tuple con dichiarazioni del range
---
## Introduzione
Questo calcolo nasce per risolvere i problemi di quello [[calcolo-relazionale-sui-domini|relazionale sui domini]]. Infatti quest'ultimo _consente di scrivere espressioni dipendenti dal dominio_, e quindi insensate per l'[[algebra-relazionale|algebra relazionale]]. Il calcolo su tuple con dichiarazioni del range _cerca quindi di ridurre il numero di variabili, usando le tuple e associando una sola variabile per tupla_.

La sintassi è
$$\{TargetList | RangeList | Formula\}$$
dove:
- $TargetList$ ha elementi del tipo $Y: x.Z$ (o anche solo $x.Z$ o $x.*$), dove $Y$ è una relazione e $x$ è la tupla associata ad essa;
- $RangeList$ contiene le [[variabile-libera|variabili libere]] del campo $Formula$ specificando da che relazione vengono;
- $Formula$ contiene comparazioni tra "atomi", connettivi logici e [[quantificatori|quantificatori]];

### Esempi
$$\sigma_{Wage > 40}(EMPLOYEE)$$
diventa
$$\{e.* | e(EMPLOYEE) | e.Wage > 40\}$$

$$\pi_{Number, Name, Age}(EMPLOYEE)$$
diventa
$$\{e.(Number, Name, Age) | e(EMPLOYEE) |\}$$

$$\pi_{Chief}(SUPERVISOR \Join_{Employee = Number} \sigma_{Wage > 40}(EMPLOYEE))$$
diventa
$$\{s.Chief | e(EMPLOYEE), s(SUPERVISOR) | e.Number=s.Employee \land e.Wage> 40\}$$

## Limiti
Nonostante i notevoli vantaggi, con tale calcolo _rimangono comunque dei limiti_. Per esempio, non si possono esprimere delle interrogazioni che richiedono l'unione di due altre relazioni:
$$R_{1}(AB) \cup R_{2}(AB)$$

Tuttavia intersezioni e differenze le possiamo esprimere. Dato che si tratta del calcolo realmente implementato per [[sql|SQL]], questo ha un'operatore di unione esplicito, implementato da sé.

## Referenze