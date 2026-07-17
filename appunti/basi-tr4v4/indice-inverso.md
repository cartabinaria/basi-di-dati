---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 09-12-2025 19:43:23
links:
  - "[[lecture-28112025151549|Lecture 28112025151549]]"
---
# Indice inverso
---
## Introduzione
Gli **indici inversi** servono per il _document retrieval_: per esempio prendere tutti i documenti, in un certo set di dati, che contengono 3 volte la parola "cuore" e "amore".

L'idea e' di usare quindi una forma di [[indice|indice]], che funziona efficientemente per prendere record di [[database|database]], in modo da usarli "alla rovescia": query di testo!

In particolare le query che ci interessano sono:
- tutti i documenti che contengono un certo insieme di keywords
- tutti i documenti che contengono una sequenza di keywords

## Costruzione
Per costruire un indice inverso a partire da un documento e' sufficiente comporre una tabella cui righe contengono le parole del testo e la posizione delle loro occorrenze. A questo punto si uniscono tali tabelle in un unico indice inverso, per poter fare query su piu' documenti: tutte le parole di tutti i documenti, associati al documento in cui appaiono e alla posizione all'interno di esso.

## Query
A questo punto possiamo fare query come:
![[inverted-index-1png.png]]
![[inverted-index-2.png]]
![[inverted-index-3.png]]

## Preprocessing
Per velocizzare e ottimizzare il processo di creazione degli indici inversi, si usano tecniche quali:
- _token normalization_
- _stemming_
- _stop words_

## Referenze