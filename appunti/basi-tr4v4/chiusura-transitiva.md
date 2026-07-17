---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 13-10-2025 12:33:06
links:
  - "[[lecture-09102025151427|Lecture 09102025151427]]"
---
# Chiusura transitiva
---
## Introduzione
> In [[database|database]] [[modello-relazionale-dei-dati|relazionali]], la **chiusura transitiva** è un calcolo su una relazione $R$ su un insieme di attributi $X$ che _restituisce la più piccola relazione su $X$ che contiene $R$ ed è [[transitivita-di-una-relazione|transitiva]]_.

Formalmente, data $R$ una relazione su $A \times A$ (dove $A$ è l'insieme di attributi), la chiusura transitiva è la relazione $R^{+}$ tale che
$$R^{+} = \{<x, y> | \exists y_{1}, \cdots, y_{n} \in A, n \geq 2, y_{1}=x, y_{n}=y, <y_{i}, y_{i+1}> \in R, i=1, \cdots, n-1\}$$

### Esempio
Per esempio, se $X$ è l'insieme di aereoporti e $x \ R \ y$ significa che c'è un volo diretto tra $x$ e $y$, la chiusura transitiva $x \ R^{+} \ y$ significa che è possibile volare da $x$ a $y$ in uno o più voli.

Guardiamo la seguente tabella:
![[chiusura-transitiva-1.png]]

Vogliamo una query che ci restituisce per ogni dipendente tutti i suoi superiori, compresi i superiori dei suoi superiori, per tutta la scala gerarchica. Per intenderci, il risultato sarebbe:
![[chiusura-transitiva-2.png]]

Infatti `Rossi` ha come capo `Lupi`, che a sua volta ha come capo `Falchi`: quindi `Rossi` ha come capo anche `Falchi`.

## Referenze