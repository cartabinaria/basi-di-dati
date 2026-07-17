---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 19-10-2025 17:25:24
links:
  - "[[lecture-16102025151651|Lecture 16102025151651]]"
---
# Implementazione della join
---
## Introduzione
Si sa che l'operazione di [[algebra-relazionale|algebra relazionale]] della `join` ($\Join$) e' _parecchio dispendiosa in termini di tempo_. Si vogliono quindi cercare delle tecniche per performarla nel minor tempo possibile.

## Tecniche
Ne esistono principalmente 4:
- [[nested-loop-join|Nested-loop join]]
- [[single-loop-join|Single-loop join]]
- [[sort-merge-join|Sort-merge join]]
- [[hash-based-join|Hash-based join]]

## Referenze