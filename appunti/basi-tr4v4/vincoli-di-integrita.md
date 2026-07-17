---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 04-10-2025 17:48:41
links:
  - "[[lecture-01102025093247|Lecture 01102025093247]]"
---
# Vincoli di integrita'
---
## Introduzione
> I **vincoli di integrita'** rappresentano per i [[database|database]] delle _proprieta' che devono essere mantenute nelle tuple delle relazioni per poter rappresentare correttamente le informazioni dell'applicazione_. Di fatto si applicano nei [[modello-relazionale-dei-dati|modelli relazionali]].
> Sono interpretate formalmente come dei _predicati booleani_, che associano ad ogni istanza di database un valore booleano:
> - `true` - se rispetta i vincoli di integrità;
> - `false` - altrimenti.

Infatti, alcune istanze di database, anche se _sintatticamente corrette, possono non rappresentare alcuna informazione corretta per l'applicazione_.

Per esempio:
- associare in un'istanza di voti universitari, la lode a un 27;
- due studenti con nome e cognome diversi, ma che hanno la stessa matricola;

Sono importantissimi, perche' consentono di modellare con maggiore accuratezza il mondo reale. Non tutti i [[dbms|DBMS]] supportano tutti i tipi di vincoli, e in tal caso e' compito del programmatore codificarli al di fuori del DBMS. Vincoli non rappresentabili automaticamente sono per esempio i _vincoli temporali_.

## Tipi
I vincoli si dividono in:
- _vincoli intra-relazionali_ - all'interno di una singola tabella;
	- sui _domini_ - per esempio 32 come voto nell'attributo voto;
	- sulle _tuple_ - per esempio 27 con lode (la lode è un altro attributo);
- _vincoli inter-relazionali_ - tra una tabella e l'altra.

Ogni schema ha un suo insieme di vincoli.

## Referenze