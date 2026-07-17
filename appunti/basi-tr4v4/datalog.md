---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 13-10-2025 12:56:16
links:
  - "[[lecture-09102025151427|Lecture 09102025151427]]"
---
# Datalog
---
## Introduzione
> **Datalog** è un linguaggio per le query su [[database|database]], ispirato a [[prolog|Prolog]].

I predicati sono divisi in:
- _predicati estensionali_ - relazioni delle basi di dati;
- _predicati intensionali_ - corrispondono alle [[viste|viste]];

I predicati intensionali sono definiti mediante regole con la seguente sintassi:
$$head \leftarrow body$$
dove:
- $head$ è un _predicato atomico_ (intensionale);
- $body$ è una _congiunzione di predicati atomici_;

Le query sono specificato usando il prefisso $?$.

### Esempi
La query
$$?EMPLOYEE(Number: m, Name: n, Age: 30, Wage: w)$$
restituisce tutti i dipendenti con età pari a 30.

La query
$$RICHER(Number: m, Name: n, Age: a, Wage: w) \leftarrow EMPLOYEE(Number: m, Name: n, Age: a, Wage: w), w > 40$$
$$? RICHER(Number: m, Name: n, Age: a, Wage: w)$$
restituisce i dipendenti che guadagnano più di 40 soldi.

## Query ricorsive
Consente di fare le query ricorsive, realizzando la [[chiusura-transitiva|chiusura transitiva]]. Prendiamo l'esempio della relazione `SUPERVISOR`. Vogliamo per ogni dipendente trovare tutti i suoi supervisori, allora definiamo i predicati in modo [[ricorsione-strutturale|ricorsivo strutturale]]:
- caso base - $$HIGHGRADE(Employee: e, SuperChief: c) \leftarrow SUPERVISOR(Employee: e, Chief: c)$$
- caso induttivo - $$HIGHGRADE(Employee: e, SuperChief: c) \leftarrow SUPERVISOR(Employee: e, Chief: c'), HIGHGRADE(Employee: c', SuperChief: c)$$

## Potere espressivo
Valgono le seguenti equivalenze:
- Datalog non ricorsivo senza negazione è espressiva quanto il [[calcolo-relazionale|calcolo]] senza negazione e senza quantificatori universali;
- Datalog non ricorsivo con negazione è espressivo quanto il calcolo e l'[[algebra-relazionale|algebra]];
- non possiamo comparare Datalog ricorsivo senza negazione e il calcolo;
- _Datalog ricorsivo con negazione è più espressivo del calcolo e dell'algebra_ --> proprio per le query ricorsive.

## Referenze