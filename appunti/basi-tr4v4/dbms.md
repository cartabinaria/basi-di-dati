---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 25-09-2025 12:37:23
links:
  - "[[lecture-24092025091104|Lecture 24092025091104]]"
  - "[[lecture-25092025151622|Lecture 25092025151622]]"
  - "[[lecture-26092025151541|Lecture 26092025151541]]"
  - "[[lecture-02102025151515|Lecture 02102025151515]]"
  - "[[lecture-16102025151651|Lecture 16102025151651]]"
---
# DBMS
---
## Introduzione
> Un **DBMS** (**DataBase Management System**) è un qualunque sistema che gestisce [[database|database]], e quindi collezioni di dati solitamente:
> - _grandi_;
> - _persistenti_;
> - _condivisi_.
> 
> Deve anche assicurare:
> - _privacy_;
> - _affidabilità_;
> - _efficienza_ (diversa a seconda del contesto);
> - _efficacia_;

## Problemi
I problemi principali che un DBMS deve risolvere sono:
- _ridondanza_ -> può causare inconsistenza;
- _[[race-condition|race condition]]_ -> il database condiviso è acceduto da più utenti/processi contemporaneamente, bisogna quindi integrare meccanismi di permessi e un check sulla coerenza;
- _privacy_ -> ogni utente deve poter accedere a certi dati, ma magari non a tutti;
- _affidabilità_ -> sulla base del tipo di dato, questo deve rimanere salvato nel database per una certa quantità di tempo;
- _efficienza_;
- _efficacia_.

### Confronto con file system
Per sistemi semplici, piccoli e che non richiedono meccanismi di transazione né di protezione, il [[file-system|file system]] del [[sistema-operativo|sistema operativo]] è più che sufficiente.

### Pros & Cons
Pros:
- dati come risorsa condivisa;
- scalabilità;
- servizi integrati;
- riduzione ridondanza e inconsistenza;
- indipendenza dei dati;

Cons:
- costi di produzione;
- funzionalità non "detachable", sempre presenti anche se non utilizzate;

## Aspetti
### Schema e istanza
In ogni database esiste:
- uno **schema** - parte invariante, che descrive la struttura dei dati, ovvero il loro _aspetto intensionale_;
- l'**istanza** - parte variante, l'_aspetto estensionale_ dei dati.

### Modellizzazione
Nella progettazione di un database si tiene conto di 2 tipi di modellizzazioni:
- [[modellizzazione-concettuale|modellizzazione concettuale]];
- [[modellizzazione-logica|modellizzazione logica]].

## Architettura
Un modo semplificato di vedere i DBMS è il seguente:
![[dbms-architettura.png]]

dove:
- lo _schema logico_ è come i dati sono visti dall'utente --> per esempio, nel caso del modello relazionale con delle tabelle (noi vedremo prevalentemente lo schema logico);
- lo _schema interno/fisico_ è come i dati sono realmente salvati --> per esempio in file, record, puntatori, ecc...

Nella realtà l'architettura è più complessa:
![[dbms-architettura-standard.png]]

dove si aggiungono:
- gli _schemi esterni_ - sovrastano gli schemi logici, in poche parole differenziandosi per ogni tipologia di utente sulla base dei loro permessi e/o interessi;

Gli schemi esterni, chiamati di solito **viste** sono fondamentalmente un modo per scremare il blocco di informazioni unico dello schema logico in più parti a seconda del tipo di utente che deve interagire con il DBMS. Risolvono il problema dell'_information overloading_.

### Indipendenza
Dallo schema precedente si possono individuare due livelli distinti di indipendenza:
- **indipendenza fisica** - i livelli esterni e logici hanno una rappresentazione indipendente dal livello fisico;
- **indipendenza logica** - il livello esterno è indipendente da quello logico, ovvero le modifiche alle viste non richiedono alcuna modifica agli schemi logici.

## Linguaggio
Per accedere ai dati gestiti da un DBMS si possono usare i seguenti modi:
- [[sql|SQL]] - linguaggio testuale interattivo;
- statement SQL iniettati in un linguaggio host;
- statement SQL iniettati in linguaggi _ad hoc_ con altre feature (stampa di tabelle) (noi vedremo PL/SQL);
- interfaccia user-friendly.

Formalmente i linguaggi per la gestione e l'accesso ai database sono internamente divisi in:
- **[[ddl|DDL]]**;
- **[[dml|DML]]**;

Invece, i linguaggi per le query sono:
- _[[algebra-relazionale|algebra relazionale]]_ - procedurale
- _[[calcolo-relazionale|calcolo relazionale]]_ - dichiarativo, teorico, non implementato
- _[[sql|SQL]]_ - parzialmene dichiarativo
- _[[qbe|QBE]]_ - dichiarativo

## Attori e utenti
Gli attori e utenti di un DBMS sono:
- DBMS designers e developers
- database designer e developers
- admins (DBA)
- software designer e developers di applicazioni
- utenti
	- finali - usano operazioni (transazioni) predefinite (accedendo per esempio al sito)
	- casuali - usano operazioni non definite a-priori, usando linguaggi interattivi

## Storia
![[dbms-history-1.png]]
![[dbms-history-2.png]]
![[dbms-history-3.png]]
![[dbms-history-4.png]]
![[dbms-history-6.png]]

## Referenze
- [[transazione|Transazione]]