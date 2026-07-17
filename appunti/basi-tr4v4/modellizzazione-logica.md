---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 25-09-2025 22:36:21
links:
  - "[[lecture-25092025151622|Lecture 25092025151622]]"
  - "[[lecture-20112025151524|Lecture 20112025151524]]"
  - "[[lecture-03122025094244|Lecture 03122025094244]]"
---
# Modellizzazione logica
---
## Introduzione
> Per **modellizzazione logica**, nei [[database|database]], si intendono i _modelli con cui effettivamente un [[dbms|DBMS]] organizza i dati_.

Questi modelli **realizzano l'indipendenza logica da quella fisica**: non importa il modo in cui una tabella, per esempio, viene salvata nel database fisicamente, perché sarà comunque vista dall'esterno come una tabella.

Esempi di questi modelli sono proprio i modelli:
- [[modello-reticolare-dei-dati|reticolari]];
- [[modello-gerarchico-dei-dati|gerarchici]];
- [[modello-relazionale-dei-dati|relazionali]].

Qui non ci preoccupiamo di "cosa" modellare, ma di "come" modellarlo.

Questa fase segue quella della [[modellizzazione-concettuale|modellizzazione concettuale]]. Se assumiamo, ed e' quasi sempre cosi', che l'output della progettazione concettuale sia un [[modello-er|modello ER]], allora _nella fase di progettazione logica vogliamo trasformare tale modello in un modello logico tipicamente relazionale, ossia in schemi e tabelle_. **Non si tratta di una semplice traduzione**: vogliamo **rappresentare i dati**, si', ma **in modo efficiente**.

### Input e output
- input
	- schema concettuale
	- informazioni sul carico di lavoro del database
- output
	- schema logico
	- documentazione associata

## Performance
Come gia' detto ci interessa rappresentare i dati in modo efficiente. Teniamo allora conto di:
- **spazio** - il numero di istanze salvate aspettate
- **tempo** - il numero di istanze visitate durante un'operazione

Per lo spazio di solito si fa riferimento ad una **tabella dei volumi**. Questa contiene _il numero approssimato di istanze per ogni entita'/associazione_, ricavato dai requisiti. Sulla base di questi valori, **si struttura il database per garantire la massima efficienza**: se questi valori cambiano il sistema continua a funzionare, ma non e' ottimizzato.

Per il tempo si utilizza la **tabella degli accessi**. Questa e' associata a una query, e si costruisce "navigando" nel modello ER per vedere a quante entita'/associazioni si accede per completarla. Consentono quindi di **determinare il carico di lavoro di ogni query**.
![[tabella-degli-accessi-1.png]]

## Fasi
- **ristrutturazione dello schema ER**
- **traduzione nel modello logico**

### Ristrutturazione
#### Analisi delle ridondanze
Una ridondanza in un modello ER e' un'informazione rilevante che puo' essere derivata da altre. In questa fase dobbiamo decidere se tenerle oppure no. Infatti:
- pro
	- semplificano le query
- contro
	- gli update impiegano più tempo
	- occupazione di memoria maggiore

Di solito le ridondanze possono essere di 2 tipi:
1. attributi derivabili da altri attributi all'interno della stessa entità/associazione o da attributi da altre entità/associazioni
	- ![[modello-er-ridondanze-attributi.png]]
	- ![[modello-er-ridondanze-associazioni.png]]
2. associazioni derivata dalla composizione di altre associazioni --> si hanno dei cicli di associazioni
	- ![[modello-er-ridondanze-cicliche.png]]

E' fondamentale notare che **non sempre le ridondanze sono una cosa negativa**! Dipende dal contesto...

#### Eliminazione delle generalizzazioni
Il modello relazionale non supporta le generalizzazioni! E' necessario trasformarle in qualche maniera, e ci sono 3 modi:
- **parent embedding** - _embedding delle entità figlie nell'entità genitore_, si preferisce quando l'accesso ai figli e al padre viene fatto contemporaneamente;
- **children embedding** - _embedding dell'entità genitore in quelle figlie_, si preferisce quando facciamo accessi indipendenti ai figli;
- **association** - _rimpiazzare la generalizzazione con un'associazione_, si preferisce quando le figlie sono accedute in modo indipendente dal padre;

Quando ci sono piu' livelli di gerarchia, si utilizzano delle soluzioni ibride.

Prendiamo in esempio:
![[modello-er-generalizzazione-1.png]]

##### Parent embedding
![[modello-er-parent-embedding.png]]

##### Children embedding
![[modell-er-children-embedding.png]]

##### Association
![[modello-er-association-embedding.png]]

#### Partizionamento/raggruppamento di entita' e associazioni
Ristrutturare gli attributi serve per ridurre banalmente il numero di accessi. Di solito si raggruppano per diminuire il costo di accesso ad attributi separati.

Tale ristrutturazione puo' avvenire in 4 modi:
1. **partizionamento verticale delle entita'** (reificazione) - significa semplicemente tagliare l'entità in 2, e lo si fa quando ci sono tanti (troppi) attributi;
2. **ristrutturazione di attributi multi-valore** - basta creare un'entità esterna e associarla alla prima;
3. **raggruppamento di entità** - è l'opposto della partizione verticale;
4. **partizionamento orizzontale delle associazioni** (storicizzazione) - spezzi un'associazione in due associazioni, utile per separare per esempio associazioni passate da quelle correnti.

#### Identificazione delle chiavi primarie
Sembra una cosa facile, ma non lo e'. Si tratta di un'attivita' obbligatoria, necessaria, per la traduzione al modello relazionale.

I criteri da seguire sono questi:
- _devono contenere informazioni obbligatorie_;
- _devono essere semplici_;
- _devono essere usate nelle operazioni piu' frequenti_.

Se nessuno di questi criteri viene rispettato da una chiave (primaria), allora e' **bene introdurre un codice (ID) univoco**, come nuovo attributo: questo identifichera' in modo univoco le tuple.

### Traduzione
> Le regole sono semplicemente queste:
> - **le entità diventano tabelle**, cui schema corrisponde agli attributi dell'entità;
> - **le relazioni diventano anch'esse tabelle**, cui schema corrisponde agli attributi dell'associazione, più gli identificatori esterni per le entità coinvolte.

#### Associazione many-to-many
![[modello-er-a-modello-relazionale.png]]

Questa traduzione ha seguito alla lettera le prime 2 regole, e infatti e' corretta. E' importante notare che **con il modello relazionale non siamo in grado di catturare i minimi delle cardinalita' delle associazioni**! Neanche usando `CHECK` complessi...

#### Associazione ricorsiva
![[modello-er-a-modello-relazionale-ricorsivo.png]]

Lo stesso principio si applica in casi ricorsivi...

#### Associazione one-to-many
![[modello-er-a-modello-relazionale-one-to-many.png]]

Potremmo applicare la seconda regola anche per le associazioni one-to-many. Ed effettivamente funziona... Tuttavia trattandosi di relazioni 1 a N, tendenzialmente, ha piu' senso che si inglobi l'associazione nell'entita' che ha cardinalita' 1 nell'associazione!

In questo caso il Player non puo' giocare in piu' Team. Quindi se facessimo una tabella Agreement avremmo per ogni giocatore 1 solo Team associato: sarebbe uno spreco. Conviene inserire l'Agreement all'interno di Player:
![[modello-er-a-modello-relazionale-one-to-many-migliore.png]]

<u>Nota bene</u>: **se la cardinalita' minima del Player nell'associazione dovesse essere 0 (e non 1), allora la chiave esterna per Team dovrebbe ammettere valori `NULL`**! E viceversa, **se la cardinalita' minima e' 1, allora la chiave esterna NON deve ammettere valori `NULL`**.

#### Associazione one-to-one
![[modello-er-a-modello-relazionale-one-to-one.png]]

Anche in questo caso, non ha senso creare una tabella Supervision che contiene le coppie di Head e Department, anche perche' appunto, senza vincoli ulteriori (come `CHECK`) rischia di violare le cardinalita' 1-1!

Per questo ci viene data la possibilita' di inserire l'associazione dentro una o dentro l'altra entita'.

Chiaramente, se scegliessimo la prima opzione, e mettessimo la cardinalita' minima di Head a 0, allora dovremmo permettere alla FK Department di essere `NULL`.

#### CASE
Con schemi molto grandi, fare questa traduzione manualmente diventa complesso. Per questo esistono gli strumenti **[[case|CASE]]** (_Computer-Aided Software Engineering_).

## Referenze