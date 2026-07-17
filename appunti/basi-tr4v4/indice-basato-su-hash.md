---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 08-12-2025 18:41:32
links:
  - "[[lecture-28112025151549|Lecture 28112025151549]]"
---
# Indice basato su hash
---
## Introduzione
> Un **indice basato su hash** e' un'implementazione della [[struttura-dati|struttura dati]] [[indice|indice]] all'interno dei [[database|database]] mediante l'[[funzione-hash|hashing]].

L'intuizione e' quella di creare un index che mappi direttamente la _search key_ all'_ID_ della pagina (**PID**) contenente i dati associati.

Chiaramente, indici di questo tipo funzionano bene quando si cerca l'uguaglianza sulle chiavi di ricerca. Non supportano, viceversa, una ricerca sui range di chiavi efficiente.

## Tecniche
Gli indici basati su hash possono essere implementati in modo:
- **statico** - i dati sono immutabili in valore e dimensione;
- **dinamico** - i dati sono mutabili in valore e dimensione.

Cosi' come nei [[b-albero|B alberi]] per la memoria secondaria, gli indici basati su hash usano blocchi di memoria per tenere i cosiddetti **buckets**: sono i nomi con cui sono chiamati i blocchi di tali indici.

### Hashing statico
Nell'hashing statico, si hanno $N$ buckets, e una funzione hash che mappa la _search key_ tra $0$ e $N-1$.

La funzione di hash in questione e' $H_{i}$, che restituisce i primi $i$ bits della search key (in binario). A questo punto la regola e' facile: **se il record ha la search key $K$, salviamo tale record nel bucket $H(K)$ numerato**.

#### Ricerca
![[static-hashing.png]]

In questo esempio abbiamo 2 buckets ($0$ e $1$), ognuno contenente 2 indici. Vogliamo cercare il valore (**PID**) associato alla search key $1100$ (in binario):
1. la funzione hash $H_{1}$ per $1100$ restituisce $H_{1}(1100) = 1$;
2. cerchiamo nel bucket $1$ la search key;
3. se la troviamo restituiamo il bucket che contiene il **PID**.

#### Inserimento
Lo static hashing non puo' modificare il numero di buckets $N$, ma puo' modificare la loro lunghezza attraverso una **catena di overflow dei blocchi**:
![[static-hashing-insertion.png]]

#### Rimozione
Piu' catene lunghe ci sono, peggio performa l'indice. Quindi nella fase di rimozione **si cerca sempre di comprimere al minimo il numero di blocchi di overflow**:
![[static-hashing-deletion.png]]

#### Efficienza
L'ideale sarebbe che non ci fossero overflow... Questo avviene _se il numero di buckets $N$ e' almeno tanto quanto il numero di blocchi_. In tal caso, infatti, la ricerca richiederebbe 1 solo accesso al disco.

Un numero elevato di blocchi di overflow degrada di molto le prestazioni.

### Hashing estendibile
Per risolvere il problema della tipologia di hashing precedente, un'idea potrebbe essere quella di **modificare la funzione di hash dinamicamente**, in modo da _minimizzare il numero di blocchi di overflow_.

Questo hashing usa una **directory di puntatori ai blocchi**. Questa directory conterra' fondamentalmente i bucket in quel momento attivi, implementati come puntatori ai singoli blocchi.

La directory cresce in lunghezze che sono potenze del $2$. Se quindi raddoppia la lunghezza della directory, raddoppia il numero di bucket disponibili. Addirittura bucket diversi possono condividere stessi blocchi. **Non sono usati blocchi di overflow**, ma adatta la dimensione della directory e conseguentemente la funzione hash per adattarsi a un nuovo blocco.

Infatti la funzione $H_{i}$ e' la stessa del caso precedente, ma $i$ (_profondita' globale_) puo' variare a run-time. In piu' ogni blocco contiene un valore $j$ che indica quanti bit gli sono necessari per indicizzarlo (_profondita' locale_).

#### Ricerca
![[extendible-hashing-searching.png]]

#### Inserimento
![[extendible-hashing-insertion-1.png]]
In questo caso allora si guardano i valori di $i$ e $j$, coincidono. Allora:
- raddoppiamo la directory;
- incrementiamo $i$.

In questo modo possiamo indicizzare su $2$ bit.
![[extendible-hashing-insertion-2.png]]
Ora rientriamo nella prima casistica, in cui "il potenziale della directory c'e' ma per ora due bucket puntano allo stesso blocco", ossia $j < i$:
- dividiamo il secondo blocco in 2;
- distribuiamo le chiavi usando i loro primi $j+1$ bits;
- incrementiamo $j$ su entrambi i nuovi blocchi;
- spostiamo il secondo puntatore della directory sul secondo blocco.

![[extendible-hashing-insertion-3.png]]

#### Efficienza
Si tratta di uno schiacciamento di un [[trie|prefix-tree]].

Chiaramente _se usassi realmente un prefix-tree otterrei un minor utilizzo dello spazio_: **non vado ad allocare inutilmente memoria per bucket che puntano tutti allo stesso blocco**. Infatti si puo' immaginare il caso pessimo in cui vengano inseriti all'inizio $n$ indici tutti con chiave che comincia con $1$:
- nel prefix-tree avremmo solo un lungo ramo di $n/2$ blocchi;
- nel indice estendibile, avremmo sempre $n/2$ blocchi, ma $n$ indici nel dizionario, cui $n/2$ punterebbero inutilmente all'unico blocco vuoto delle chiavi che cominciano con $0$.

Tuttavia ci perderei in velocita', perche' per alberi molto profondi dovrei scorrere la sua altezza ($O(\log n)$) invece che fare un accesso costante ($O(1)$).

Infatti, facendolo in questo modo **la ricerca per uguaglianza di chiave provoca 1 o massimo 2 accessi al disco** (se si assume che la directory stia nella [[ram|memoria primaria]]).

Tuttavia il problema della crescita esponenziale del dizionario non e' da sottovalutare...

### Hashing lineare
L'idea e' questa volta quella di "schivare" l'idea della directory, gestendo i blocchi di overflow. Anche questa e' una tecnica dinamica, infatti il numero di buckets cresce, ma linearmente (uno a uno).

In particolare, viene aggiunto un bucket in uno dei 2 seguenti casi:
- viene creato un blocco di overflow;
- viene superato un threshold;

Tale threshold e' il **record-bucket ratio**, e rappresenta il load factor. Dobbiamo assicurarci di scegliere il numero di bucket $n$ tale che non ci siano piu' di $1.7 \times n$ record nel file.

#### Ricerca
La regola e' la seguente:
- se $H_{i}(k) = m < n$, allora la search key e' nel bucket $m$;
- se $H_{i}(k) = m \geq n$, allora la search key e' nel bucket $m - 2^{i-1}$;

#### Inserimento
Se il numero di record $r$, diviso il numero di bucket $n$, supera $1.7$, allora dividiamo un bucket in 2 e facciamo altre cose...

## Referenze