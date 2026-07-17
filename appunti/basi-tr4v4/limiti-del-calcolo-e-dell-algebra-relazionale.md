---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 13-10-2025 12:20:42
links:
  - "[[lecture-09102025151427|Lecture 09102025151427]]"
---
# Limiti del calcolo e dell'algebra relazionale
---
## Introduzione
Sia l'[[algebra-relazionale|algebra relazionale]] che il [[calcolo-relazionale|calcolo relazionale]] hanno dei **limiti forti**. Sono equivalenti, ma query potenzialmente utili non possono essere espresse:
- **non possiamo computare nuovi valori dalle query**, ma solo estrarli;
- **non possiamo computare query ricorsive, come la [[chiusura-transitiva|chiusura transitiva]]**;

In particolare per quest'ultima cosa, è impossibile da fare in quanto **ci vorrebbe un numero arbitrario di join**, una per ogni livello di [[transitivita-di-una-relazione|transitività]].

E' per questa ragione che è nato [[datalog|Datalog]], un linguaggio ispirato a [[prolog|Prolog]] che consente di scrivere query ricorsive.

## Referenze