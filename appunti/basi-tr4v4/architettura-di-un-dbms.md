---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 18-10-2025 15:35:57
links:
  - "[[lecture-16102025151651|Lecture 16102025151651]]"
---
# Architettura di un DBMS
---
## Introduzione
L'architettura di un [[dbms|DBMS]], [[modello-relazionale-dei-dati|relazionale]] almeno, si presenta nel seguente modo:
![[architettura-dbms-relazionale.png]]

## Componenti
### Query processor
> Il **query processor** è il componente che più condiziona le performance del DBMS.

Si compone a sua volta di:
- _query compiler_
- _execution engine_

#### Query compiler
Questo traduce ogni query in un "piano" di query, facendo:
- _[[parser|parsing]]_, in modo particolare producendo l'[[albero-sintattico|albero sintattico]];
- _preprocessing_, che controlla la semantica;
- _optimization_, che trasforma la query originale nella miglior sequenza di operazioni, seguendo le [[equivalenze-nell-algebra-relazionale|equivalenze nell'algebra relazionale]];

Per esempio, trasforma la query [[sql|SQL]]:
```sql
SELECT A, B
FROM R1, R2
WHERE C = D AND C = 'c'
```
diventa prima
$$\pi_{A, B}(\sigma_{C=D}(\sigma_{C='c'}(R1) \Join R2))$$
e poi la sequenza
$$\sigma_{C='c'}(R1), \ \ \ \Join R2, \ \ \ \sigma_{C=D}, \ \ \ \pi_{A, B}$$

#### Execution engine
Questo invece esegue tutti gli step dell'espressione in [[algebra-relazionale|algebra relazionale]] presa dal query compiler, _interfacciandosi con il manager delle risorse per recuperare le informazioni_.

### Manager delle risorse
Si deve capire che i dati, in un database, sono _sempre su una memoria secondaria_. Il manager delle risorse sa precisamente dove sono questi dati e come ottenerli velocemente. Include:
- _index/file/record manager_ che conosce lo schema del [[database|database]];
- _buffer manager_ che partiziona la memoria principale in buffer dentro i quali possiamo trasferire dei blocchi di disco (fa da [[cache|cache]]);
- _storage manager_ che tiene traccia delle locazioni dei file sul disco, e ottiene i blocchi.

Quindi si interfaccia direttamente con la memoria secondaria.

### Manager delle transazioni
Sappiamo che in un database acceduto contemporaneamente da più utenti è necessario introdurre il meccanismo delle [[transazione|transazioni]]. Ognuna di queste è isolata dalle altre, e secondo la legge di **durabilità di un DBMS**, _il lavoro di una transazione non sarà mai perso_.

Il manager delle transazioni, allora, gestisce:
- _[[crash-recovery-nei-dbms|logging and recovery]]_
- _[[controllo-della-concorrenza-nei-dbms|concurrency control]]_

#### Logging and recovery
Si compone di:
- _manager dei log_ --> segna su un file separato tutte le operazioni svolte dal database (e quindi le transazioni); inizialmente le scrive sul buffer, e poi negozia con il buffer manager per assicurarsi che tali log siano scritti anche sul disco;
- _manager del recovery_ --> esamina i log changes e in caso di system failure ripristinano il database a uno stato consistente.

## Referenze
- [[implementazione-della-join|Implementazione della join]]