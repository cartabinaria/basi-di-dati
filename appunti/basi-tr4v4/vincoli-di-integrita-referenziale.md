---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 04-10-2025 18:02:39
links:
  - "[[lecture-01102025093247|Lecture 01102025093247]]"
---
# Vincoli di integrita' referenziale
---
## Introduzione
> I **vincoli di integrita' referenziale** (anche detti **vincoli inter-relazionali**), sono quei [[vincoli-di-integrita|vincoli di integrita']] che rappresentano i vincoli tra due o più tabelle.
> Formalmente gli $FK$ (_foreign keys_) tra gli attributi $X$ di una relazione $R_{1}$ e un'altra $R_{2}$, assicurano che i valori di $X$ in $R_{1}$ appaiano come [[chiave-primaria|chiavi primarie]] in $R_{2}$.
> Quindi, un attributo $A$ in $R_{1}$ è una $FK$ che fa riferimento a $R_{2}$ se soddisfa le seguenti regole:
> 1. l'attributo $A$ ha lo stesso dominio della chiave primaria di $R_{2}$;
> 2. un valore di $A$ in una tupla $t_{1}$ di $R_{1}$ o ha valore `NULL` oppure appare come valore di una tupla $t_{2}$ di $R_{2}$ tale che $$t_{1}[A] = t_{2}[PK]$$.

Hanno un ruolo fondamentale nei _modelli value-based_, come quello [[modello-relazionale-dei-dati|relazionale]].

<u>Nota bene</u>: se compare il `NULL` nelle chiavi, allora i vincoli possono essere "rilassati".

<u>Nota bene</u>: ci possono anche essere $FK$ composte da più attributi. Questo avviene quando la chiave primaria dell'altra relazione è composta da più attributi.

## Violazione dei vincoli
In caso di violazione dei vincoli, possiamo specificare al [[dbms|DBMS]] di intraprendere una serie di azioni per evitare possibili _side-effects_ che potrebbero corrompere le informazioni dell'applicazione.

Immaginiamo infatti di eliminare un record in una relazione $R_{2}$, legata da un vincolo di integrità referenziale ad un record in $R_{1}$: **il record di $R_{1}$ avrà come $FK$ non più esistente in $R_{2}$**!
In altri termini il vincolo di integrità è violato. In tal caso possiamo definire una serie di politiche:
- _non accettare l'eliminazione_ (anche no);
- _rimozione a cascata_;
- _introduzione di valori nulli_;
- _introduzione di valori di default_.

## Referenze