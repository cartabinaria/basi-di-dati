# Soluzione della simulazione di esame del 14 dicembre 2022

Queste soluzioni sono quelle mostrate dal tutor durante la correzione, e sono
quindi da considerarsi affidabili.

## Esercizio 1

1. a
1. d
1. c
1. b (`GROUP BY` conta come operatore aggregato secondo il tutor, sennò sarebbe
   la d)
1. c
1. a

## Esercizio 2

### Parte 1

```sql
SELECT AVG(Valutazione.prezzo), Marca.marchio
FROM Valutazione
JOIN Modello
  ON Valutazione.idModello = Modello.idModello
JOIN Marca
  ON Modello.idMarca = Marca.idMarca
WHERE Marca."nazionalità" = "Italia"
GROUP BY Modello.idModello, Marca.marchio
```

### Parte 2

```sql
SELECT Valutazione.anno, COUNT(*)
FROM Valutazione
JOIN Modello
  ON Valutazione.idModello = Modello.idModello
JOIN Marca
  ON Modello.idMarca = Marca.idMarca
WHERE Marca."nazionalità" = "Germania" AND
      Modello.categoria = "Berlina" AND
      Valutazione.anno >= 2000 AND
      Valutazione.anno <= 3000 AND
      Valutazione.prezzo >= 3000
GROUP BY Valutazione.anno
```

### Parte 3

```math
\pi_{idModello, nome}(\sigma_{categoria = "Berlina" \wedge nazionalità =
"Francia"}(Modello \bowtie MARCA)

-

(\pi_{idModello}(\sigma_{anno = 2007}(Modello \bowtie Valutazione)) \bowtie
Valutazione)
```

### Parte 4

```math
\sigma_{prezzo > 15000 \wedge anno >= 2005 \wedge anno <= 2009}(Valutazione)

\bowtie

(Marca - \sigma_{nazionalità = "Italia"}(Marca))

\bowtie

\sigma_{categoria = "Utilitaria"}(Modello)

```

## Esercizio 3

![Diagramma ER che risolve l'esercizio 3](scritto-2021-12-14-soluzione-es3.jpeg)

Vincoli non esprimibili:

- per ciascuna bolletta, la somma dei rimborsi ad essa associati deve essere
  strettamente minore del costo totale della bolletta stessa.

## Esercizio 4

![Diagramma ER che risolve l'esercizio 3](scritto-2021-12-14-soluzione-es4.jpeg)

- cerco la chiave 8 e scopro che è effettivamente presente nella foglia
  centrale (in altro a sinistra);
- rimuovo dalla foglia centrale la chiave 8 (in alto a destra);
- siccome la foglia di sinistra ha una chiave in eccesso, può regalare quella
  massima alla foglia che ne ha appena perso una (in basso a destra);
- siccome la chiave minima della foglia centrale è cambiata, anche la chiave
  analoga del suo genitore viene aggiornata (in basso a sinistra).
