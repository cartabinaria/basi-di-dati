---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 04-10-2025 18:29:42
links:
  - "[[lecture-02102025151515|Lecture 02102025151515]]"
  - "[[lecture-08102025101345|Lecture 08102025101345]]"
---
# Algebra relazionale
---
## Introduzione
> L'**algebra relazionale** è un'[[algebra|algebra]] usata per modellare le query a un [[database|database]]. Lavora su insiemi di [[modello-relazionale-dei-dati|relazioni]] (prende relazioni in input e le restituisce in output) e si compone dei seguenti operatori:
> - _unione, intersezione, differenza_
> - _rinomina_
> - _select_
> - _proietta_
> - _join_ --> più importante
> 	- _natural join_
> 	- _prodotto cartesiano_
> 	- _$\theta$-join_

<u>Nota bene</u>: gli operatori di _unione, intersezione e differenza devono essere applicati su relazioni che hanno lo stesso schema_.

## Operatori
### Union
E' un'unione insiemistica, quindi _se ci sono record uguali tra i due operandi, questi verranno uniti nel risultato_.

### Intersection
L'intersezione è anch'essa insiemistica.

### Difference
Dalla prima tabella si tolgono gli elementi che sono anche nella seconda.

### Renaming
E' un'operatore _unario_: _rinomina un attributo dello schema della relazione messa in ingresso_.
La sintassi è la seguente:
$$\rho_{NewName \ \ \leftarrow \ \ OldName}(RELATION)$$

E' molto utile in quanto consente di fare per esempio delle union su tabelle "incompatibili" per via dello schema.

### Select
Anch'esso unario: come risultato produce una relazione con lo stesso schema di quella in input, ma con un _sottoinsieme di tuple che soddisfano un qualche predicato_.
La sintassi è:
$$\sigma_{predicate}(RELATION)$$

Il predicato è un'espressione booleana sulle tuple della relazione.

#### Valori `NULL`
Una select su una tabella che come condizione fa riferimento a valori che appaiono come nulli nelle tuple, _non considera tali tuple_.
Per esempio, la select
$$\sigma_{Age > 40}(PEOPLE)$$
considera solo le tuple cui campo $Age$ è non-`NULL`.

Ci sono allora degli statement specifici per fare riferimento ai valori nulli:
- `IS NULL`;
- `IS NOT NULL`;

### Projection
Sempre unario, restituisce in output la _stessa relazione posta in input ma con uno schema che è un sottoinsieme dello schema dell'input_. Quindi l'output contiene tutte le tuple, ma sono definite solo su un sottoschema.
La sintassi è:
$$\pi_{AttributeList}(RELATION)$$

La [[cardinalita|cardinalità]] della proiezione è interessante: _l'output contiene al più lo stesso numero delle tuple in input_. Non tutte per forza! Questo avviene perché se si restringe a un sottoinsieme di attributi, più tuple potrebbero ripetersi e quindi collassare: _gli attributi della proiezione potrebbero non formare una [[superchiave|superchiave]]_!

Di fatto vale il seguente teorema:
> Se $X$ è una superchiave di $R$, allora $\pi_{X}(R)$ contiene lo stesso numero di tuple di $R$.

#### Relazione con select
La selezione e la proiezione sono operatori ortogonali:
- la selezione filtra orizzontalmente, sulle righe;
- la proiezione filtra verticalmente, sulle colonne;

_Combinandole_ possiamo estrarre da una relazione _solo le informazioni che ci servono_!
Per esempio:
$$\pi_{Number, Surname}(\sigma_{Salary > 50}(EMPLOYEE))$$

I limiti sono ovvi: _possiamo estrarre informazioni solo da una singola relazione_ $\implies$ non possiamo né fare correlazioni inter-relazionali, né correlazioni intra-relazionali.

### Join
Quest'operatore realizza proprio la correlazione tra tuple in relazioni diverse. E' un'operazione di _congiunzione_.

Ne esistono varie varianti:
- _natural join_;
- _prodotto cartesiano_;
- _$\theta$-join_.

#### Natural join
E' un operatore binario (generalizzabile a più tabelle attraverso l'associatività), che fornisce la _congiunzione delle due tabelle sulla base di due attributi che hanno lo stesso nome_. In particolare:
- lo schema della relazione risultante sarà l'unione degli attributi dei due schemi;
- ogni tupla è prodotta combinando due tuple, una per ogni relazione;

La sintassi è, dati $R_{1}(X_{1})$ e $R_{2}(X_{2})$[^1]:
$$R_{1} \Join R_{2}$$
che produce una relazione sullo schema $X_{1}X_{2}$ (l'unione degli schemi in input).

Semanticamente:
$$R_{1} \Join R_{2} = \{t \text{ su } X_{1}X_{2} | \exists t_{1} \in R_{1} \land \exists t_{2} \in R_{2} \text{ con } t[X_{1}] = t_{1} \land t[X_{2}] = t_{2}\}$$

A seconda dei risultati della join, si classifica la natural join in:
- full join
- not-full join
- empty join
- max join

##### Full join
Avviene quando c'è una completa associazione tra le due relazioni, vale a dire che nessuna tupla è lasciata fuori dalla relazione finale.
![[full-join.png]]

##### Not-full join
E' il caso speculare della full-join:
![[not-full-join.png]]

##### Empty join
Quando nessuna tupla contribuisce alla relazione in output, e quindi la relazione è vuota.

##### Max join
E' il caso in cui la relazione finale è letteralmente il [[prodotto-cartesiano|prodotto cartesiano]]. E' un caso speciale della full join, in cui ogni tupla della prima relazione combacia con ogni altra tupla della seconda.

##### Cardinalità
In generale, valgono i seguenti risultati sulle cardinalità delle join.

La join tra le relazioni $R_{1}$ e $R_{2}$ hanno una cardinalità:

$$0 \leq |R_{1} \Join R_{2}| \leq |R_{1}| \times |R_{2}|$$

Se la join coinvolge una [[chiave|chiave]] di $R_{2}$, allora la cardinalità delle join è
$$0 \leq |R_{1} \Join R_{2}| \leq |R_{1}|$$

Se la join infine coinvolge una chiave di $R_{2}$ e ha un [[vincoli-di-integrita-referenziale|vincolo di integrità referenziale]], il numero delle tuple è:
$$|R_{1} \Join R_{2}| = |R_{1}|$$

##### Aspetti critici
Nelle not-full join il fatto che certi record di una o dell'altra relazione rimangano esclusi dalla relazione risultante, _potrebbe costituire un problema_. Per questo nascono le _outer join_:
- _left outer join_ - mantiene tutte le tuple del primo operando, anche se non ci sono tuple che matchano nel secondo e in tal caso queste sono rimpiazzate con valori `NULL`;
- _right outer join_ - speculare della left;
- _full outer join_ - unisce la left con la right.

#### Prodotto cartesiano
Il [[prodotto-cartesiano|prodotto cartesiano]] è un caso particolare di join, in cui _le due relazioni hanno intersezione degli schemi vuota_. In tal caso nessun campo collassa e viene congiunto, per cui il risultato della join è il prodotto cartesiano delle tuple della prima relazione con quelle della seconda.

<u>Nota bene</u>: la cardinalità è la stessa della max join, ma è il caso fondamentalmente opposto! Infatti nella max join c'è un insieme di attributi cui tuple coincidono esattamente nelle due relazioni; nel prodotto cartesiano è l'opposto.

E' utile solo se seguito da una select.

#### $\theta$-join
La $\theta$-join è la _combinazione del prodotto cartesiano con una select_. Si scrive così
$$R_{1} \Join_{condition} R_{2}$$
e corrisponde a
$$\sigma_{condition}(R_{1} \Join R_{2})$$

Può essere utile quando la condizione esprime una relazione binaria, come nel caso della _equi-join_:
![[equi-join-1.png]]

In tal caso, infatti, collassa in una join con rinominazione! Nell'esempio precedente, infatti, si ha che
$$EMPLOYEE \Join_{Dept = Code} DEPARTMENT \ \ \ = \ \ \ EMPLOYEE \Join \rho_{Dept \ \ \leftarrow \ \ Code} (DEPARTMENT)$$

### Regole non scritte
Una questione delicata della natural join riguarda le **assunzioni che fa sui nomi degli attributi uguali**: potrebbe associare attributi con il nome uguale che non vogliamo associare! Per questo di solito si ignora, e piuttosto si usa la equi-join, disambiguando campi uguali con `RELATION.Attribute`. E qualora questo non bastasse (se si devono fare join di una relazione con se stessa) possiamo dare delle definizioni a dei nomi di relazioni, creando nuovi pseudonimi per le tabelle.
Tendenzialmente quindi cerchiamo di **rimandare il più possibile l'operazione di renaming**, da usare solo per le union.

## Referenze
- [[equivalenze-nell-algebra-relazionale|Equivalenze nell'algebra relazionale]]
- [[viste|Viste]]

[^1]: $X_1$ e $X_2$ sono rispettivamente gli schemi di $R_1$ e $R_2$
