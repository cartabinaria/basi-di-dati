---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 08-11-2025 11:46:33
links:
  - "[[lecture-05112025093510|Lecture 05112025093510]]"
  - "[[lecture-06112025151932|Lecture 06112025151932]]"
  - "[[lecture-12112025093402|Lecture 12112025093402]]"
---
# Modello ER
---
## Introduzione
> Il **modello ER** (**Entity-Relationship**) e' il [[modellizzazione-concettuale|modello concettuale]] per il design concettuale di un [[database|database]] piu' diffuso e utilizzato.

Il motivo del suo successo e' dato dalla sua _capacita' di ridurre l'[[entropia|entropia]] dei requisiti_.

## Costruttori
I costruttori del modello ER sono:
- _entita'_
- _associazione_
- _attributo_
- _attributo chiave_
- _generalizzazione_

### Entita'
> Per entita' si intende una _classe di oggetti che appartengono alla realta' di interesse, condividono delle proprieta' comuni e hanno un'esistenza autonoma_.

Di un entita' se ne definisce:
- _schema_ - rappresenta una classe di oggetti che hanno caratteristiche uniformi;
- _istanza_ - un elemento appartenente allo schema.

![[modello-er-entita.png]]

### Associazione
> Un'associazione stabilisce un collegamento tra due o piu' entita'.

![[modello-er-relazioni-entita.png]]

Bisogna distinguere adeguatamente anche in questo caso gli schemi e le istanze:
![[modello-er-schemi-e-istanze-associazioni.png]]

Vale sempre che **non ci possono essere istanze ripetute all'interno di un'associazione**! Questo e' perfettamente in linea con la definizione di [[insieme|insieme]]. A volte, **quando ci si accorge proprio che c'e' la necessita' per un'associazione tra due istanze di due entita' di essere ripetuta, si promuove l'associazione a entita'**.

Prendiamo in esempio il caso sopra: _nel modello precedente, infatti, non e' previsto che uno studente dia piu' esami per uno stesso corso_. Se volessimo includere questa casistica, dovremmo promuovere `Exam` a entita':
![[modello-er-associazioni-promosse.png]]
![[modello-er-associazioni-promosse-istanze.png]]

#### $n$-arie
Di solito le associazioni si presentano come **binarie**, ovvero tra 2 entita'. Tuttavia si possono definire su $n$ entita' diverse!

#### Multiple
Per due stesse entita' potrebbero essere presenti piu' associazioni.

#### Ricorsive
Si possono anche definire delle associazioni [[ricorsione|ricorsive]], ossia che mettono in relazione un'entita' con se stessa. Di solito si definiscono i nomi dei "ruoli" con cui quell'associazione viene coinvolta.
![[modello-er-associazioni-ricorsive.png]]

### Attributo
> Un attributo e' una _proprieta' che appartiene all'entita' o all'associazione_.

Fondamentalmente serve per mettere in relazione ciascuna entita'/associazione a un valore appartenente a un _insieme dominio_.
![[modello-er-attributi.png]]

#### Composti
Gli attributi possono anche essere raggruppati insieme in **attributi composti** se mostrano delle similarita' semantiche. Per esempio l'attributo `Indirizzo` potrebbe essere composto da:
- `Via`
- `Numero`
- `Codice postale`

![[modello-er-attributi-composti.png]]

### Cardinalita'
> La [[cardinalita|cardinalita']] e' (chiaramente in questo contesto) una coppia di valori riguardanti le due entita' coinvolte in un'associazione. Piu' precisamente **specifica il numero minimo e massimo di occorrenze dell'associazione a cui un'istanza di entita' puo' partecipare**.

![[modello-er-cardinalita.png]]
In questo caso le cardinalita' significano:
- _ogni dipendente ha almeno 1 lavoro e al massimo 5_;
- _ad ogni job ci possono essere da 0 a 50 dipendenti_;

Di solito, per semplicita', le cardinalita' si esprimono sempre in termini di 3 numeri:
- `0` - opzionale;
- `1` - obbligatorio;
- `N` - obbligatorio, indica un numero arbitrario.

#### Classificazioni
Sulla base delle cardinalita', si classificano le associazioni in:
- _uno-a-uno_ ![[modello-er-associazioni-one-to-one.png]]
- _uno-a-molti_ ![[modello-er-associazioni-one-to-many.png]]
- _molti-a-molti_ ![[modello-er-associazioni-many-to-many.png]]

Attenzione al caso in cui le cardinalita' sono della forma _mandatory-to-mandatory_: si verificano quando, per esempio, la **cardinalita' minima e' `1` per entrambe le entita'**! Questo impone un _vincolo di inserimento parallelo di due istanze separate delle due entita' per rispettare le cardinalita' sulla relazione_!

#### Attributi
Si possono assegnare anche delle cardinalita' agli attributi...

### Chiave/identificatore
> Una chiave/identificatore e' un modo univoco per identificare le occorrenze/istanze di un'entita'. Si compongono di:
> - attributi dell'identita' - _internal identifier_ ![[modello-er-identificatore-interno.png]]
> - attributi esterni raggiungibili dalle associazioni in cui e' coinvolta l'entita' - _external identifier_ ![[modello-er-identificatore-esterno.png]]

Ci si potrebbe chiedere perche' non ci sono gli identificatori sulle associazioni... Ma il punto e' che **per identificare un'istanza di un'associazione e' sufficiente identificare univocamente le entita' di riferimento**!

### Generalizzazione
> La generalizzazione consente di generalizzare una certa entita' con altre entita'. E' letteralmente il concetto di [[sottotipaggio|sottotipaggio]] con [[ereditarieta|ereditarieta']].

#### Totale vs. parziale
Una generalizzazione e':
- **totale** se ogni istanza del padre lo e' di almeno una delle entita' figlie;
- **parziale** se non totale;

#### Disjoint vs. overlapping
Una generalizzazione e':
- **disjoint** se ogni istanza del padre lo e' di al massimo una delle entita' figlie;
- **overlapping** se non disjoint;

Di solito **sono sempre disjoint con distinzione tra totale (se il padre in realta' e' astratto) e parziale (se un'entita' del padre potrebbe esistere senza concretizzarsi in un figlio)**.

#### Sottoinsieme
Una generalizzazione con solo un'entita' figlia e' chiamata _[[definizione-di-essere-sottoinsieme|sottoinsieme]]_.

## Potenza espressiva
Possiamo esprimere attraverso questo modello tutte le cose che interessano in un database? La risposta e' **no**!

Ci sono infatti una **serie di vincoli che non sono esprimibili direttamente col modello ER**! Sara' necessaria una struttura che consente di specificare tali vincoli.

### Data dictionary
Si tratta di una struttura a [[dizionario|dizionario]] che tiene conto di quali dati sono rilevanti per il dominio di lavoro: tendenzialmente entita' e associazioni.

E' importante per il semplice fatto che di solito, di entita' e associazioni, ce ne sono a migliaia: con un dizionario _si cerca direttamente il nome dell'entita'/associazione e si trovano tutte le informazioni ad esso associato_.

Attraverso di esso possiamo anche specificare proprio i vincoli non esprimibili tramite il modello ER:
![[modello-er-vincoli.png]]

## UML
Questo modello e' stato incorporato all'interno di [[uml|UML]]. Di fatto **e' possibile trasmutare ogni modello ER in un [[diagramma-delle-classi|diagramma delle classi]]**, e viceversa. Sono di fatto la stessa cosa.

## Referenze

[^1]: e quindi vale il [[principio-di-sostituzione-di-liskov|principio di sostituzione di Liskov]]
