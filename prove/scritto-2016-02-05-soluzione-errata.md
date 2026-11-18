# Errata: Query 2 del 5 febbraio 2016

Nota integrativa non ufficiale, preparata con assistenza IA. Testo e traccia
originali: [Esame di Basi di Dati del 5 febbraio 2016](scritto-2016-02-05-soluzione.pdf),
conservato senza modifiche. Segnalazione di
[CaffeLatteIV nell'issue #8](https://github.com/cartabinaria/basi-di-dati/issues/8).
Questa proposta non è una soluzione approvata dal docente.

La richiesta a pagina 5 riguarda **tutti gli attributi dei movimenti** dei concerti
scritti dopo il 1720 e con più di tre movimenti. A pagina 11 la Query 2 seleziona
invece gli attributi dei concerti e manca la condizione di associazione nel `JOIN`.
Una possibile correzione, limitata a questa query, è:

```sql
SELECT M.*
FROM Movimenti AS M
JOIN Concerti AS C ON C.RV = M.RV
WHERE C.Data > 1720
  AND M.RV IN (
      SELECT RV
      FROM Movimenti
      GROUP BY RV
      HAVING COUNT(*) > 3
  );
```

`M.*` restituisce `RV`, `Numero`, `Tempo` e `Durata` (in secondi); il `JOIN`
associa ogni movimento al proprio concerto. `COUNT(*)` esprime direttamente la
cardinalità dei movimenti dello stesso `RV`; con numerazione consecutiva da 1,
`MAX(Numero)` darebbe lo stesso conteggio.
Il confronto `> 1720` esclude i concerti del 1720. Le altre risposte della prova
non sono oggetto di questa nota.
