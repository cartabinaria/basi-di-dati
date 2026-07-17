---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 12-10-2025 23:43:17
links:
  - "[[lecture-08102025101345|Lecture 08102025101345]]"
---
# Calcolo relazionale sui domini
---
## Sintassi
La sintassi del calcolo relazionale sui domini per fare le interrogazioni è la seguente:
$$\{A_{1}:x_{1}, \cdots, A_{k}:x_{k} | f\}$$
dove:
- $A_{1}, \cdots, A_{k}$ sono degli _attributi_;
- $x_{1}, \cdots, x_{k}$ sono le _[[variabile|variabili]] associate agli attributi_;
- $f$ è una _formula logica_, con operatori booleani e [[quantificatori|quantificatori]].

La semantica è la seguente: _il risultato è una relazione sugli attributi $A_{1}, \cdots, A_{k}$ che contiene delle tuple di valori per $x_{1}, \cdots, x_{k}$ che soddisfano $f$_.

### Esempi
Facciamo il confronto con l'[[algebra-relazionale|algebra relazionale]]. Abbiamo che
$$\sigma_{Wage > 40}(EMPLOYEE)$$
diventa
$$\{Number: m, Name: n, Age: a, Wage: w | EMPLOYEE(Number: m, Name: n, Age: a, Wage: w) \land w > 40\}$$

Oppure che
$$\pi_{Number, Name, Age}(EMPLOYEE)$$
diventa
$$\{Number: m, Name: n, Age: a | \exists w (EMPLOYEE(Number: m, Name: n, Age: a, Wage: w))\}$$
o semplicemente, senza l'esistenziale $\exists w$
$$\{Number: m, Name: n, Age: a | EMPLOYEE(Number: m, Name: n, Age: a, Wage: w)\}$$

E infine
$$\pi_{Chief}(SUPERVISOR \Join_{Employee = Number} \sigma_{Wage > 40}(EMPLOYEE))$$
diventa
$$\{Chief: c | SUPERVISOR(Chief: c, Employee: e) \land EMPLOYEE(Number: e, Name: n, Age: a, Wage: w) \land w > 40\}$$

## Proprietà
Valgono le proprietà sulle operazioni booleani e sui quantificatori universali, per cui:
- $\neg(A \land B) = \neg A \lor \neg B$
- $\neg(A \lor B) = \neg A \land \neg B$
- $\neg \forall x. A = \exists x. \neg A$
- $\neg \exists x. A = \forall x. \neg A$
- $\forall x. A = \neg \exists x. \neg A$
- $\exists x. A = \neg \forall x. \neg A$
- $\neg A \lor B = A \implies B$ (bonus)

## Limiti
Pros:
- è dichiarativo;

Cons:
- è molto verboso;
- ci consente di scrivere espressioni insensate, in particolari quelle **dipendenti dal dominio**;

Esempi di espressioni dipendenti dal dominio:
$$\{A: x | \neg R(A: x)\}$$
$$\{A: x, B: y | R(A: x)\}$$

Fatto sta che è equivalente all'algebra relazionale.

## Referenze