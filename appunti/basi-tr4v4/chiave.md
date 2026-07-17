---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 04-10-2025 17:56:55
links:
  - "[[lecture-01102025093247|Lecture 01102025093247]]"
---
# Chiave
---
## Introduzione
> Una **chiave** in un [[database|database]] [[modello-relazionale-dei-dati|relazionale]] e' una _[[superchiave|superchiave]] minimale di una certa relazione_, ossia una superchiave che al suo interno non contiene un'altra superchiave.

<u>Nota bene</u>: possono esistere due chiavi!

## Proprieta'
> Ogni relazione non puo' contenere tuple con stessi valori $\implies$ ogni relazione ha una superchiave che e' l'insieme di tutti gli attributi $\implies$ ogni relazione ha almeno una chiave.

Inoltre, l'uso dei valori nulli sulle chiavi e' proibito.

## Importanza
Le chiavi sono fondamentali: _consentono di accede sempre ad ogni tupla del database_, e anche di _correlare tuple di tabelle diverse_, in modo _minimale_!

## Referenze