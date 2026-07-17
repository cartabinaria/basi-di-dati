---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 13-10-2025 14:37:35
links:
  - "[[lecture-09102025151427|Lecture 09102025151427]]"
  - "[[lecture-17102025151336|Lecture 17102025151336]]"
  - "[[lecture-22102025094240|Lecture 22102025094240]]"
  - "[[lecture-23102025151606|Lecture 23102025151606]]"
  - "[[lecture-05112025093510|Lecture 05112025093510]]"
---
# SQL
---
## Introduzione
> **SQL** (**Structured Query Language**) è un [[linguaggio-di-programmazione-dichiarativo|linguaggio dichiarativo]] per le query in un [[database|database]].

Implementa sia [[ddl|DDL]] che [[dml|DML]].

## DDL
- `CREATE DATABASE db_name`
- `CREATE SCHEMA schema_name`
- in entrambi i comandi sopra, sia il database che lo schema creati apparterranno all'utente che li ha creati
- infatti si può fare `CREATE SCHEMA schema_name AUTHORIZATION 'user_name'` per specificare l'autorizzazione a un certo utente
- `CREATE TABLE`
	- attributi
		- basic
			- Character-string
			- Numeric
			- DATE, TIME, INTERVAL
			- Boolean
			- BLOB/CLOB
		- custom
			- `CREATE DOMAIN`
			- esempio:
				- `CREATE DOMAIN Grade AS SMALLINT DEFAULT NULL CHECK ( value >= 18 AND value <= 30 )`
	- vincoli delle relazioni
		- `NOT NULL`
		- `UNIQUE` per definire delle chiavi
		- `PRIMARY KEY`
		- `CHECK`
		- `REFERENCES` e `FOREIGN KEY` sono per i vincoli di integrità referenziali
			- c'è una sintassi diversa a seconda che si usi un unico attributo, oppure su più
			- ci sono anche le azioni triggerabili da fare quando un'operazione è rifiutata (rompe i vincoli referenziali)
				- `ON <DELETE | UPDATE> <CASCADE | SET NULL | SET DEFAULT | NO ACTION>`
- statement per modificare gli schema
	- `ALTER DOMAIN`
	- `ALTER TABLE`
	- `DROP DOMAIN`
	- `DROP TABLE`

## DQL
- `SELECT` - corrisponde all'operatore di _proiezione_
- `FROM` - a partire da quale/i tabella/e devo fare l'interrogazione?
- `WHERE` - corrisponde all'operatore di _selezione_
- `AS` - sulle tabelle è un'alias per la query, invece sui campi diventa l'operatore di _rinominazione_
- `LIKE` - per fare un filtro su una sorta di [[espressione-regolare|regex]] (per esempio `LIKE 'J_m%'` significa che quel campo deve cominciare con `J` e che la terza lettera dev'essere `m`);
- `IS NULL` - condizione per vedere se un valore è nullo

Di base la sintassi e' quindi:
```SQL
SELECT <AttributeList>
FROM <TableList>
[ WHERE <Condition> ]
```
che ricorda molto il [[calcolo-relazionale-su-tuple-con-dichiarazioni-del-range|calcolo relazionale su tuple]]! Non per niente _SQL e' implementato proprio tramite questo calcolo_...

### `DISTINCT`
Di norma sappiamo che quando facciamo l'operatore di proiezione $\pi$ con l'[[algebra-relazionale|algebra relazionale]], **due tuple che risultano uguali questi collassano per via della stessa definizione insiemistica di relazione**. Questo in SQL non e' direttamente implementato! Vale a dire che una query del tipo
```SQL
SELECT Surname, Agency
FROM EMPLOYEE
```
sulla tabella

| Number | Surname | Agency | Age |
| ------ | ------- | ------ | --- |
| 7309   | Neri    | Naples | 55  |
| 5998   | Neri    | Milan  | 64  |
| 9553   | Rossi   | Rome   | 44  |
| 5698   | Rossi   | Rome   | 64  |

restituisce la tabella

| Surname | Agency |
| ------- | ------ |
| Neri    | Naples |
| Neri    | Milan  |
| Rossi   | Rome   |
| Rossi   | Rome   |

Per fare in modo che le tuple uguali collassino, bisogna segnalarlo con la keyword `DISTINCT` dopo la `SELECT`, ovvero fare la query:
```SQL
SELECT DISTINCT Surname, Agency
FROM EMPLOYEE
```

Questo viene fatto per motivi di efficienza.

### `JOIN`
Le _join_ in SQL possono essere:
- _implicite_ - basta elencare le tabelle nella clausola `FROM` e poi in `WHERE` porre la condizione ($\theta$-[[algebra-relazionale-theta-join|join]]); di base significa che la join produce il [[prodotto-cartesiano|prodotto cartesiano]], e poi specificando la condizione $\theta$ si ottiene la natural join (come nel caso della equi-join);
- _esplicite_ - andando proprio a specificare la congiunzione con l'operatore `JOIN`.

Il secondo caso si fa con la sintassi seguente:
```SQL
SELECT ...
FROM A JOIN B ON condition
```

Di norma, esplicitare la join e' meglio: ci sono degli algoritmi efficienti per la loro risoluzione.

Esiste anche il costrutto `NATURAL JOIN`, cosi' come `LEFT/RIGHT/FULL [OUTER] JOIN`. Infatti le join di base sono sempre _inner_: se si vogliono mantenere le tuple di una o di entrambe le tabelle che non hanno una corrispondenza con l'altra tabella nella condizione della join, allora si usano le _outer_ join.

Per ricapitolare, questo e' lo schema delle join in SQL:
![[sql-joins.png]]

### Espressioni
All'interno delle `SELECT` possiamo anche scrivere delle vere e proprie espressioni, come nell'esempio seguente:
```SQL
SELECT Income/2 as halvedIncome
FROM PEOPLE
WHERE Name = 'Louis'
```

Questo ci suggerisce una cosa importante: **SQL ha piu' [[potere-espressivo|potere espressivo]] dell'algebra relazionale** (ricordiamo infatti i [[limiti-del-calcolo-e-dell-algebra-relazionale|limiti dell'algebra e del calcolo relazionale]]).

### `ORDER BY`
E' possibile stabilire un ordinamento delle tuple sulla base di uno o piu' attributi della relazione risultante, nel seguente modo:
```SQL
SELECT Name, Income
FROM People
WHERE Age < 30
ORDER BY Name ASC
```

Sintassi: `ORDER BY ... ASC/DESC`.

### `UNION`
L'operatore di unione, come sappiamo _non e' direttamente implementabile dal calcolo su tuple_. Tuttavia, tramite un algoritmo a parte, SQL implementa anche quello.
La sintassi e'
```SQL
SELECT ...
UNION [ALL]
SELECT ...
```

L'operazione di `UNION` e' insiemistica, per cui di base le tuple risultanti sono uniche. Se si usa l'opzione `ALL` vengono catturati anche i doppioni[^1].

Bisogna fare estremamente attenzione, nel caso delle `UNION` alla _notazione posizionale_: l'operatore **`UNION` considera solo e unicamente le posizioni degli attributi**, non i loro nomi; la **tabella risultante avra' i nomi dello schema del primo operando**.

### `EXCEPT`
E' l'operatore di differenza:
```SQL
SELECT ...
EXCEPT
SELECT ...
```

### `INTERSECT`
E' l'operatore di intersezione:
```SQL
SELECT ...
INTERSECT
SELECT ...
```

Notare l'equivalenza con le join! Per esempio, la query
```SQL
SELECT Name
FROM Employee
INTERSECT
SELECT Surname as Name
FROM Employee
```
e' equivalente a
```SQL
SELECT E1.Name
FROM Employee AS E1, Employee AS E2
WHERE E1.Name = E2.Surname
```

### Query nestate
In SQL e' possibile anche **definire all'interno di predicati dei confronti con dei risultati di sub-query**.
Per esempio, la query
```SQL
SELECT Name, Income
FROM People, Fatherhood
WHERE Name=Father AND Child='Frank'
```
puo' essere riscritta usando le query nestate come
```SQL
SELECT Name, Income
FROM People
WHERE Name=(SELECT Father
			FROM Fatherhood
			WHERE Child='Frank')
```

Notare che la clausola `WHERE` e' _vera quando l'attributo `Name` di `People` e' uguale al risultato della query nestata, che in quanto tale dev'essere unico_!

Le query nestate sono meno dichiarative (si distaccano un po' dalla "purezza" dell'algebra relazionale), ma rendono certe query piu' leggibili e rispettano il principio [[divide-et-impera|divide et impera]].

Gli **operatori di confronto** (uguaglianza, maggiore, minore, ecc...) **funzionano solo se il risultato della subquery e' singolo**: in caso contrario, ossia in cui **la subquery restituisce una relazione, entrano in gioco `ANY` e `ALL`**. Questi sono il corrispondente dei [[quantificatori|quantificatori]] $\exists, \forall$.
La sintassi e: `Attribute op ANY/ALL(Expr)`.

Inoltre, per semplificare le cose, sono stati introdotti gli operatori `IN` e `NOT IN`, per i quali valgono le seguenti equivalenze:
- `A IN(Expr)` $\equiv$ `A = ANY(Expr)`
- `A NOT IN(Expr)` $\equiv$ `A != ALL(Expr)`

<u>Nota bene</u>: le query si possono annidare in `WHERE`, ma anche in `FROM` e addirittura in `SELECT`!

#### Visibilita'
Ogni sub-query ha un suo grado di visibilita', letteralmente un suo [[scope|scope]]:
- puo' vedere e riferirsi alle variabili della sup-query;
- non puo' vedere ne' fare riferimento alle variabili della sub-query.

Valgono in poche parole le regole dei [[blocco|blocchi]]. Infatti esiste anche lo [[shadowing|shadowing]] delle variabili!
![[sql-query-nestate-visibilita.png]]

#### Semantica
La semantica delle query nestate e' quella che **ognuna di loro viene calcolata per ogni tupla della sup-query**: estremamente inefficiente. Per evitare cio' possiamo utilizzare le [[viste|viste]].

### `EXISTS`
E' un operatore in stretta relazione con le query nestate, che funge da quantificatore esistenziale $\exists$. La sintassi e: `EXISTS(Expr)`.
Accanto al `WHERE`, il predicato diventa `true` se esiste almeno una tupla nella query posta in `Expr` (tipicamente una query nestata).
Per esempio la query seguente seleziona tutti i genitori di almeno un figlio:
```SQL
SELECT *
FROM People
WHERE EXISTS (SELECT *
			  FROM Fatherhood
			  WHERE Father=Name)
	  OR
	  EXISTS (SELECT *
			  FROM Motherhood
			  WHERE Mother=Name)
```
Notare che _`Name` e' preso da `People` della sup-query_!

### Funzioni di aggregazione
Sono delle funzioni poste nella _target list_ (dopo `SELECT`) che lavorano su degli attributi o sulle intere tuple come risultati della query. Sono:
- `COUNT`
	- sintassi: `SELECT COUNT([DISTINCT] */Attribute)`
- `AVG`
- `MAX`
- `MIN`
- `SUM`
- ...

I campi `NULL` non vengono considerati, in quanto _non valori contabili_. E' fondamentale che la _target list contenga tutti i tipi di attributi uguali_: non si puo' fare
```SQL
SELECT Name, MAX(Income)
FROM People
```

Perche' `Name` e' multiplo mentre `MAX(Income)`, essendo il risultato di un'aggregazione, e' singolo! Per ottenere quello che la query chiedeva si possono usare le query annidate:
```SQL
SELECT Name, Income
FROM People
WHERE Income=(SELECT MAX(Income)
			  FROM People)
```

#### `GROUP BY`
Questi _operatori di aggregazione possono funzionare in combinazione con un'operatore di raggruppamento_ ($\neq$ aggregazione!): il `GROUP BY`. Questo ci **consente di applicare le funzioni di aggregazione a sottogruppi di tuple della relazione**.
Sintassi: `GROUP BY AttrList`.
Semantica:
1. _prima esegui la query normale_;
2. _poi esegui il `GROUP BY` raggruppando in base ai valori uguali dell'attributo specificato_;
3. _poi applica l'operatore di aggregazione sui sottogruppi_.

Esempio:
```SQL
SELECT Father, COUNT(*) AS NumberOfChildren
FROM Fatherhood
GROUP BY Father
```

E' importante che ci sia una _corrispondenza diretta tra la target list e gli attributi raggruppati_: **nella target list devono comparire solo e solamente gli attributi raggruppati, ed eventualmente gli operatori di aggregazione**.

#### `HAVING`
L'operatore `HAVING` e' letteralmente un `WHERE` per i risultati raggruppati dal `GROUP BY`: **serve per porre delle condizioni sui valori dei raggruppamenti**.
Esempio:
```SQL
SELECT Father, AVG(C.Income)
FROM People AS C JOIN Fatherhood ON C.Name=Child
GROUP BY Father
HAVING AVG(C.Income) > 25
```
che e' diversa da
```SQL
SELECT Father, AVG(C.Income)
FROM People AS C JOIN Fatherhood ON C.Name=Child
WHERE C.Age < 30
GROUP BY Father
HAVING AVG(C.Income) > 25
```

## DML
Le operazioni di manipolazione, e quindi di update delle relazioni, sono:
- `INSERT`
- `DELETE`
- `UPDATE`

### `INSERT`
Sintassi:
- `INSERT INTO Table [(AttList)] VALUES (Vals)` - classico;
- `INSERT INTO Table [(AttList)] SELECT ...` - inseriamo in `Table` il risultato della `SELECT`;

L'ordine e il valore degli attributi e' rilevante, e le cardinalita' di `AttList` (se messa) e `Vals` deve coincidere.

### `DELETE`
Sintassi: `DELETE FROM Table [WHERE Condition]`.
**Attenzione ai [[vincoli-di-integrita-referenziale|vincoli di integrita' referenziale]]**! Se per esempio un certo attributo e' una [[chiave|chiave]] esterna, e durante la definizione della tabella e' stata inserita su di esso la clausola `ON DELETE CASCADE`, allora alla sua cancellazione viene eliminata la tupla corrispondente anche in un'altra tabella.

### `UPDATE`
Sintassi: `UPDATE Table SET Attribute = <Expr | SELECT ... | NULL | DEFAULT> [WHERE Condition]`.

## Avanzato
### `CHECK`
Serve per specificare i [[vincoli-di-integrita|vincoli di integrita']] sulle tuple.
Sintassi: `CHECK (Predicate)`.

Per esempio:
```SQL
create table EMPLOYEE (
	Number integer primary key,
	Surname character(20),
	Name character(20),
	Gender character not null CHECK (Gender in ('M','F')),
	Salary integer CHECK (Salary >= 0),
	Supervisor integer,
	CHECK (Salary <= (select Salary
					  from EMPLOYEE J
					  where Supervisor = J.Number))
);
```

### Asserzioni
Un'asserzione e' un modo _per definire dinamicamente dei vincoli di integrita'_. Infatti sono dei vincoli che vengono aggiunti dopo, non in fase di creazione della tabella: **questo consente di scrivere vincoli che non potrebbero essere soddisfatti se non dopo aver fatto qualche operazione di inserimento**.
Sintassi: `CREATE ASSERTION Name CHECK (Predicate)`.
Un esempio puo' essere:
```SQL
CREATE ASSERTION AtLeastOneEmployee CHECK (1 <= (SELECT COUNT(*)
												 FROM EMPLOYEE))
```

### Viste
In SQL le viste si creano mediante la seguente sintassi: `CREATE VIEW ViewName [(AttList)] AS SELECT ... [WITH [LOCAL | CASCADED] CHECK OPTION]`.

Si ricorda che **gli aggiornamenti sulle viste sono consentiti solo se queste fanno riferimento a una sola tabella**. Inoltre, la clausola `WITH CHECK OPTION` ci permette di aggiornare la vista ma solo se la tupla inserita appartiene alla vista:
- `LOCAL` - caso di viste costruite sopra altre viste, l'aggiornamento delle tuple dev'essere eseguito solo sull'ultimo livello della vista;
- `CASCADED` - caso opposto a `LOCAL`, l'aggiornamento delle tuple è propagato a cascata sulle viste e relazioni su cui è basata quella vista.

Per esempio la vista
```SQL
CREATE VIEW PoorAdminEmployees AS
	SELECT *
	FROM AdminEmployees
	WHERE Salary < 50
WITH CHECK OPTION
```
consente di fare un'update sulla vista ma solo se la tupla inserita (o aggiornata) appartiene alla vista, e quindi solo se l'admin ha un salario minore di 50 in questo caso.

Le viste consentono anche di scrivere delle query complesse che richiederebbero di porre **query annidate dopo la clausola `HAVING`**, il che non e' sempre supportato dalle implementazioni di SQL. Lo stesso caso si ritrova nei casi in cui si devono **annidare funzioni di aggregazione, che non e' consentito**!

### Query ricorsive
La sintassi e' simile a quella del [[datalog|Datalog]]:
```SQL
with recursive ANCESTORS(Ancestor, Descendant) as (
	select Father, Son
	from FATHERHOOD
		union all
	select Ancestor, Son
	from ANCESTORS, FATHERHOOD
	where Descendant = Father
)
select *
from ANCESTORS;
```

### Funzioni scalari
- `current_date()`
- `extract(yearExpression)`
- `char_length()`
- `lower()`
- `cast()`
- `coalesce()` - restituisce il primo elemento di una lista di attributi non nullo --> sfruttabile per ottenere dei valori di default in una `SELECT`;
- `nullif()` - restituisce `NULL` se il primo argomento non è uguale al secondo;
- `case` - espressione condizionale;

### Sicurezza
SQL permette di definire dei privilegi (permessi) per certi utenti su certe tabelle o sull'intero database. I privilegi possono essere assegnati alle relazioni, attributi, viste o addirittura domini. Esiste almeno un admin, `_system`, che ha tutti i privilegi garantiti.

Un privilegio e' descritto da:
- **una risorsa specifica**
- **l'utente che lo garantisce**
- **l'utente a cui è garantito il privilegio**
- **un'operazione specifica**
- **se l'utente può propagare il privilegio o meno**

e puo' essere di tipo:
- _insert_
- _update_
- _delete_
- _select_
- _references_
- _usage_

Per assegnare un privilegio si usa il comando `GRANT`.
Sintassi: `GRANT <Privileges | ALL PRIVILEGES> ON Resource TO Users [WITH GRANT OPTION]`.
L'opzione `WITH GRANT OPTION` serve proprio per _permettere di propagare il privilegio ad altri utenti_.

Per revocare un privilegio, si usa `REVOKE`.
Sintassi: `REVOKE Privileges ON Resource FROM Users [RESTRICT | CASCADE]`, dove
- `RESTRICT` segnala che _lo tolgo solamente all'utente selezionato_;
- `CASCADE` segnala che _lo tolgo a cascata all'utente e a tutte le persone a cui l'utente ha garantito i privilegi_ --> e' pericoloso!

#### Modello RBAC
SQL, dalla versione 3.0, consente di **non dare piu' i permessi precisi agli utenti, ma bensi' di assegnare loro dei ruoli, ossia insiemi di privilegi**. In questo modo, si ha che ogni utente ha:
- dei privilegi individuali;
- dei privilegi "ereditati" dal ruolo a cui appartiene.

Per creare il ruolo si scrive: `CREATE ROLE Name`;
Per assegnarlo all'utente corrente si scrive: `SET ROLE Name`; invece per assegnarlo a un'utente diverso si scrive: `GRANT Name TO User`. Per aggiungere un privilegio a un ruolo si scrive: `GRANT ... TO Name`; per revocarlo: `REVOKE ... FROM Name`.

### Transazioni
SQL fornisce anche dei meccanismi al supporto delle [[transazione|transazioni]]:
```SQL
START TRANSACTION
	...
COMMIT [WORK] | ROLLBACK [WORK];
```
dove:
- `COMMIT [WORK]` e' per salvare le operazioni;
- `ROLLBACK [WORK]` e' per scartare le operazioni e ripristinare il database in uno stato consistente.

Molti RDBMS hanno `AUTOCOMMIT`, ossia tali che ogni statement viene trattato come una transazione univoca.

## Referenze
- [[indice|Indice]]

[^1]: e' il contrario di `DISTINCT` nella `SELECT`
