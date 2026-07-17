---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 25-09-2025 22:33:58
links:
  - "[[lecture-25092025151622|Lecture 25092025151622]]"
  - "[[lecture-05112025093510|Lecture 05112025093510]]"
  - "[[lecture-12112025093402|Lecture 12112025093402]]"
  - "[[lecture-13112025153905|Lecture 13112025153905]]"
---
# Modellizzazione concettuale
---
## Introduzione
> Per **modellizzazione concettuale**, nei [[database|database]], si intende la _rappresentazione concettuale dei dati che cerca di modellizzare una situazione del mondo reale_. E' completamente indipendente dalle specifiche del sistema, di fatto appartiene alla fase preparatoria di un progetto.

La parte di design di un database appartiene a quella di design di un **IS** (Information System). Bisogna infatti tener conto dell'**Information System's life cycle**.

Nel contesto del [[modello-a-cascata|modello a cascata]], la parte di modellizzazione concettuale del sistema si colloca proprio nella fase di _analisi dei requisiti_ e _design_, con particolare attenzione alla prima.
![[database-design-and-analysis.png]]
![[database-design-fasi.png]]

Il più diffuso modello concettuale è il [[modello-er|modello ER]].

## Requisiti
La modellizzazione concettuale parte tutta dai requisiti. Questi si ricavano dalle seguenti risorse:
- persone e utenti (attraverso interviste);
- documentazione già esistente;

Di solito, si parte con i requisiti piu' superficiali, poi attraverso le interviste si vanno ad approfondire.

Regole generali:
- costruire un glossario dei termini;
- sinonimi e omonimi devono unificarsi in un unico termine;
- chiarire le relazioni tra i termini;
- ordinare le sentenze per concetti;

In generale dobbiamo **riorganizzare i requisiti dividendoli per gruppi omogenei di sentenze**.

Per ognuno di questi termini dobbiamo capire che costruttore del modello ER associarvi:
- _entita'_ se e' rilevante e descrive oggetti stand-alone;
- _attributo_ se e' semplice e senza alcuna specificazione ulteriore;
- _associazione_ se un termine si relaziona con altri;
- _generalizzazione_ se un termine e' un caso generale di un altro.

### Operazioni
#### Reificazione
L'operazione piu' comune del passaggio dal glossario dei requisiti al modello ER e' quella della **reificazione**: consiste nel prendere l'essenza delle parole. E' l'operazione piu' importante, e si puo' fare sugli attributi, sulle entita', sulle relazioni, ecc...

Per esempio:
![[modello-er-reificazione-attributi.png]]

#### Part-of
Oppure ci sono associazioni che rappresentano l'aggregazione o la composizione:
![[modello-er-aggregazione-composizione.png]]

<u>Nota bene</u>: notare il ruolo delle chiavi nel caso dell'aggregazione e della composizione!

#### Instance-of
![[modello-er-instance-of.png]]

#### Storicizzazione
A volte un pattern tipico e' quello di storicizzare certe entita':
![[modello-er-storicizzazione.png]]

### Strategie
- _top-down_
	- dai requisiti si produce una bozza di schema
	- si raffina lo schema
	- si ottiene lo schema finale
- _bottom-up_
	- più adatta quando i requisiti sono tanti e si vogliono dividere tra più persone
	- si spezzettano i requisiti in sottopezzi
	- ogni sottopezzo produce il suo schemino
	- si uniscono gli schemini per produrre lo schema finale
- _inside-out_
	- si parte da un'entità e poi ci si allarga modellando l'intero schema

La strategia migliore, pero', consiste nel **combinare tutte le strategie**.

Le misure di qualita' di uno schema ER sono:
- correttezza
- completezza
- chiarezza
- minimalità

## Referenze