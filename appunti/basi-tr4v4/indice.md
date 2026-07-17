---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 20-10-2025 13:05:32
links:
  - "[[lecture-17102025151336|Lecture 17102025151336]]"
  - "[[lecture-21112025151717|Lecture 21112025151717]]"
---
# Indice
---
## Introduzione
> Un'**indice** in [[sql|SQL]] e' uno _strumento potente per rendere piu' veloce l'esecuzione delle query_. Formalmente sono una [[coppia-ordinata|coppia]] `<chiave, valore>`, che usiamo chiedendo da una chiave $k$ il suo valore associato. Fondamentalmente, quindi, si tratta di un'implementazione del [[dizionario|dizionario]].

Si realizzano per mezzo di [[funzione-hash|hashing]] e altre [[struttura-dati|strutture dati]] (come gli [[albero|alberi]]).

<u>Nota bene</u>: sono definiti a livello fisico del [[dbms|DBMS]] (guardare [[architettura-di-un-dbms|architettura di un DBMS]]), non logico! Nonostante cio', gli sviluppatori di SQL _hanno pensato che fosse meglio dare la possibilita' ai programmatori di specificare al livello logico la presenza di indici_. In questo modo puo' favorire l'accesso su certi dati.

### Chiave
La chiave è anche detta **search key**, ed è associata ad un attributo di una qualche tabella. Non sono chiavi primarie, vale a dire che **per una stessa chiave possono corrispondere più valori**.

### Valore
Un valore, anche detto **label**, può essere:
1. _un record stesso del database_;
2. _un RID (Record Identifier), ossia un puntatore a un record del database_;
3. _una lista di RID_;

![[indici-valori.png]]

#### Osservazioni
- **usando la prima rappresentazione, puoi avere al massimo 1 indice per dato** --> se volessi creare un altro indice che ha chiave associata all'attributo nome, avrei 2 indici contenenti lo stesso record duplicato (spreco memoria)!
- **usando la prima rappresentazione, la grandezza dell'indice è la stessa del record**;
- **la terza rappresentazione è quella più compatta, ma la lista dei valori ha grandezza variabile**;

## Classificazioni
Assumiamo di avere un semplice _sequential file index_:
- c'è un **index file** contenente chiavi e puntatori ai record del database, raggruppati in **database file**;
- le **chiavi sono le chiavi primarie** della relazione a cui punta.

Quando ora ci riferiamo a indice, in realtà stiamo parlando dell'index file, ossia dell'insieme di indici!

![[indice-sequential-file-index.png]]

Ora, gli indici (index file) possono essere classificati in:
- **primario**, se include una chiave primaria e i dati sono ordinati su tale attributo (altrimenti **secondario**);
- **denso**, se include almeno una search key per ogni [[chiave|chiave]] dei dati (altrimenti **sparso**);
- **clustered**, se l'ordine dei record riflette quello dei valori (altrimenti **unclustered**);

![[indici-sparso-clustered.png]]
![[indici-secondario-denso-unclustered.png]]

Un _index file unclustered è poco efficiente_! Infatti come possiamo notare dall'esempio avviene che per recuperare tutti i record che come chiave (search key) hanno valore 20, dobbiamo accedere a 3 blocchi di dati differenti!

Ovviamente, possiamo definire su una stessa relazione più indici!
![[indici-multipli.png]]

<u>Nota bene</u>: **un indice sparso DEVE essere clustered**. Questo perché arrivato al file dei dati puntato da un indice sparso, non ho i riferimenti magari ai file successivi (altrimenti sarebbe denso), e quindi devo esplorarli uno a uno. Se questi fossero anche unclustered, non avrei un criterio di ordinamento e sarei costretto a navigare tutti i file!

Gli indici sparsi comunque non sono da buttare: **servono infatti a ridurre semplicemente il numero di indici nell'index file a discapito di un po' di tempo di calcolo in più**.

Il fatto di poter creare index files di index files, porta alla nascita dei [[b-albero|B-tree]].

## Sintassi
Fondamentalmente funzionano creando degli indici da associare a dei campi di alcune tabelle/relazioni. Una volta che e' stato creato l'indice, **il tempo di risposta per l'attivita' di ricerca dei dati diminuisce notevolmente**.
```SQL
CREATE [UNIQUE] INDEX IndexName ON TableName(AttributeList);
DROP INDEX IndexName;
```

<u>Attenzione</u>: **rimane comunque da considerare il tempo di creazione dell'indice**! Anche se si tratta di una cosa che si fa _una tantum_...

## Realta'
Oggi, in realta', **molti DBMS costruiscono in fase di ottimizzazione delle query degli indici automaticamente**.

## Referenze
- [[indice-basato-su-hash|Indice basato su hash]]