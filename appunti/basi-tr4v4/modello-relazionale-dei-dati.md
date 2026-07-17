---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 25-09-2025 22:26:04
links:
  - "[[lecture-25092025151622|Lecture 25092025151622]]"
  - "[[lecture-26092025151541|Lecture 26092025151541]]"
  - "[[lecture-01102025093247|Lecture 01102025093247]]"
---
# Modello relazionale dei dati
---
## Introduzione
> Il **modello relazionale dei [[dato|dati]]** è il [[modellizzazione-logica|modello logico]] di rappresentazione più comune, diffuso, di dati all'interno dei [[dbms|DBMS]].

Infatti, i modelli [[modello-reticolare-dei-dati|reticolari]] e [[modello-gerarchico-dei-dati|gerarchici]] dei dati prevedono la _ricerca posizionale_: si accede ai dati usando un indirizzo (_[[url|URL]]_ nel primo caso, _path_ nel secondo).

Nei modelli relazionali, invece, l'**accesso ai dati non è fatto per posizione, ma per contenuto**!

## Definizioni
Il modello relazionale è basato sulla definizione logica della [[relazione|relazione]]. Tutte le **relazioni sono rappresentate mediante tabelle**.

### Relazione logica
Sappiamo cos'è una relazione logica $r$ su $n$ domini:
$$r \subseteq D_{1} \times \cdots \times D_{n}$$
Quindi una relazione è un [[insieme|insieme]]:
- in cui non c'è ordine tra le tuple;
- le tuple sono distinte;
- ogni $n$-tupla è ordinata, ossia l'$i$-esimo valore appartiene all'$i$-esimo dominio ($D_{i}$).

### Struttura posizionale
Un esempio di relazione logica è il seguente:
$$\text{Matches} \subseteq \text{string} \times \text{string} \times \text{int} \times \text{int}$$
e la tabella corrispondente potrebbe essere:
![[relazione-logica-posizionale.png]]

Questa relazione logica si dice essere **posizionale**: la prima colonna si distingue dalla seconda solo sulla base della posizione, dell'ordine in cui appare. In altri termini **i domini si distinguono per posizione**.

Ergo, se inverto la prima colonna con la seconda, cambia la semantica della tabella (chi ha vinto diventa perdente, e viceversa!).

Questo avviene perché _stiamo dividendo i domini per il loro [[tipi-di-dato|tipo]]_!

### Struttura non-posizionale
Se associamo invece un nome univoco a ogni dominio, ecco che la posizione diventa irrilevante:
![[relazione-logica-non-posizionale.png]]

Qui possiamo infatti _invertire le prime due colonne, ma la semantica non cambia_!

## Implementazione
Lo schema, quindi, è rappresentato nel modello relazionale dall'_intestazione della tabella_; mentre l'istanza dal _corpo della tabella_. Ogni **tabella è una relazione**, dove:
- _ogni riga può assumere una qualunque posizione_;
- _ogni colonna può assumere una qualunque posizione_;
- _le righe devono essere tutte diverse_;
- _gli header delle colonne devono essere distinti_ (nomi dei domini);
- _i valori di una colonna devono essere omogenei_.

### Legami tra relazioni/tabelle
Per legare una relazione con un'altra, si _aggiungono dei campi nelle tuple_ (nuovi domini).
![[relazione-legami.png]]

#### Pointer vs. value-based
Nelle strutture pointer-based il legame avviene mediante [[puntatore|puntatori]], nel seguente modo:
![[relazione-legami-pointer-based.png]]

Nelle value-based, invece, è l'_equivalenza dei valori che crea il legame_!

Questo ha molti vantaggi:
- indipendenza dalla struttura fisica, che potrebbe cambiare dinamicamente;
- i puntatori sono direzionali, i valori no;

## Schema e istanze
### Definizioni
#### Schema di una relazione
> E' una relazione $R$ con un insieme di attributi $A_{1}, \cdots, A_{n}$ (domini), indicato con $R(A_{1}, \cdots, A_{n})$.

#### Schema di un database
> E' un insieme di schemi di relazione $R = \{R_{1}(X_{1}), \cdots, R_{k}(X_{k})\}$.

#### Tupla
> Su un insieme di attributi $X$, è una mappa da ogni attributo $A \in X$ ad un valore in $\text{dom}(A)$.
> Si ha che $t[A]$ esprime il valore della tupla $t$ sull'attributo $A$.

#### Istanza di relazione
> E' un insieme finito di tuple che ha come schema di relazione $R(X)$, con $X$ insieme di attributi.

#### Istanza di un database relazionale
> E' l'insieme di istanze di relazioni $r = \{r_{1}, \cdots, r_{n}\}$ su uno schema di database $R = \{R_{1}(X_{1}), \cdots, R_{n}(X_{n})\}$ dove $r_{i}$ è l'istanza di relazione sullo schema di relazione $R_{i}$.

### Informazione parziale
Se viene inserita una _tupla in una relazione che non corrisponde allo schema atteso_, parliamo di **informazione parziale**.

Per modellare tali record dobbiamo tenere conto delle seguenti cose:
- non dobbiamo inserire valori appartenenti al dominio (ovvio);
- potrebbero non esistere valori non usati, nel dominio, e comunque nel tempo potrebbero diventare utili;
- dobbiamo trovare dei valori "non rappresentabili" nel software, per catturare il significato.

Per questo si introduce un valore standard ad ogni dominio, detto `NULL`[^1]. A questo punto la tupla $t[A]$ mappa per ogni attributo $A$:
- o in un valore di $\text{dom}(A)$;
- oppure in `NULL`.

Ci sono dei casi, pero', in cui il valore `NULL` non e' proprio ammesso: per esempio nelle chiavi!

### Osservazioni
Ha senso uno schema di relazione con un solo attributo? Sì: soprattutto se fa riferimento a qualcos'altro.
![[relazione-un-attributo.png]]

## Referenze
- [[vincoli-di-integrita|Vincoli di integrita']]
- [[superchiave|Superchiave]]
- [[chiave|Chiave]]
- [[chiave-primaria|Chiave primaria]]
- [[vincoli-di-integrita-referenziale|Vincoli di integrita' referenziale]]

[^1]: i domini diventano allora [[tipo-somma|tipi somma]]
