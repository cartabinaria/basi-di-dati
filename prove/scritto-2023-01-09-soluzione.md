# Soluzione scritto 2023-01-09

## Esercizio 1

### L’informazione incompleta nel modello relazionale

A) non è ammessa

B) viene codificata con un valore non appartenente al dominio

C) viene codificata con valori speciali di dominio

D) non prevede l’imposizione di restrizioni sulla presenza di valori nulli

Soluzione b

### I vincoli di integrità

A) sono esprimibili solo su singole relazioni

B) non contribuiscono alla qualità dei dati

C) non interessano i valori nulli

D) consiste in un predicato che associa ad ogni istanza il valore vero o falso

Soluzione d

### Una vista materializzata

A) alleggerisce l’aggiornamento della base di dati

B) sono supportate da tutti i DBMS

C) viene memorizzata nella base di dati

D) se interrogará richiede un ricalcolo della vista

Soluzione c

### Nelle interrogazioni nidificate

A) non si può omettere un nome di variabile

B) non è possibile fare riferimenti a variabili definite in blocchi interni

C) non è possibile fare riferimenti a variabili definite in blocchi esterni

D) nessuna delle precedenti

Soluzione b

### In una base di dati, un privilegio è caratterizzato da

A) una risorsa, un’azione, gli utenti che concedono e ricevono e la trasmissibilità

B) una tabella, un’azione, gli utenti che concedono il grant e quelli che ricevono il revoke

C) una tabella, un’azione, l’amministratore e la trasmissibilità

D) una tabella, diritti di insert, gli utenti che concedono e ricevono

Soluzione a

### La creazione di un indice

A) implica sempre l’uso della chiave primaria

B) è un’attività unica per ogni tabella del DBMS

C) può impiegare una struttura gerarchica

D) non prevede mai l’uso di liste

Soluzione c

## Esercizio 2

### Interrogazione 1

$$ \pi_{Atleta.nome}( $$

$$ \sigma_{Atleta.nazione = 'Austria'}(Atleta) $$

$$ \bowtie_{Atleta.codice = Partecipazione.atleta} $$

$$ \sigma_{Partecipazione.piazzamento \leq 3}(Partecipazione) $$

$$ \bowtie_{Gara.codice = Partecipazione.gara} $$

$$
\sigma_{Gara.data \geq 1-01-2005 \land Gara.data \leq 31-12-2010 \land
Gara.disciplina = 'slalom speciale'}(Gara)
$$

$$ ) $$

### Interrogazione 2

$$ \pi_{Gara.luogo}(Gara - (\pi_{Gara.\ast}( $$

$$
\sigma_{Gara.luogo = Atleta.nazione \land Partecipazione.piazzamentento = 1}(
$$

$$
Gara \bowtie_{Gara.codice = Partecipazione.gara} Partecipazione
\bowtie_{Partecipazione.atleta = Atleta.codice} Atleta
$$

$$ ) $$

$$ ))) $$

### Interrogazione 3

```sql
SELECT DISTINCT Atleta.nome, Atleta.data
FROM Atleta
WHERE Atleta.codice NOT IN(
  SELECT Atleta.codice
  FROM Atleta JOIN Partecipazione ON Atleta.codice = Partecipazione.atleta
  JOIN Gara ON Partecipazione.gara = Gara.codice
  WHERE Gara.disciplina = 'discesa libera'
)
```

### Interrogazione 4

```sql
-- Crea una vista per selezionare gli atleti nati dopo il 1996 e che abbiano partecipato ad almeno 10 gare di sci di fondo
CREATE VIEW V AS
SELECT a.*
FROM Atleta a
JOIN Partecipazione p ON a.codice = p.atleta
JOIN Gara g ON p.gara = g.codice
WHERE a.data >= 01/01/1997 AND g.disciplina = "sci di fondo"
GROUP BY a.codice
HAVING COUNT(g.codice) >= 10

SELECT DISTINCT V.nazione
FROM V
GROUP BY V.nazione
HAVING COUNT(V.codice) >= 5
```

## Esercizio 3

![image](https://user-images.githubusercontent.com/58698974/215279145-6ca445d7-8860-49a2-a8c5-96773f4fe29a.png)
- Lo stato può essere: assente giustificato, assente ingiustificato, presente 
 
- Il gruppo sanguigno può essere: A+, A-, B+, B-, AB+, AB-, 0+, 0- 
 
- I valori di pressione massima e minima devono essere entrambi interi positivi
 
- L'emoglobina deve avere un valore compreso tra 10.0 e 20.0
 
- La quantità di sangue deve essere un valore intero positivo corrispondente al numero di cc donati
 
- Il peso deve essere un valore decimale
 
- Per ogni giornata di donazione deve essere assegnato almeno un medico
 
- Per ogni giornata di donazione devono essere assegnati almeno tre infermieri

- Solo a presenze nello stato "presente" possono essere associate donazioni

## Esercizio 4

### 4.1

C'è un conflitto tra $w_1(A)$ e $w_2(A)$. Si tratta di un conflitto Lost Update (Write-Write) e per risolverlo occorre adottare il meccanismo delle Repeatable Reads.

### 4.2

Sono presenti 3 conflitti: tra $w_4(C)$ e $r_3(C)$ (Dirty Read), tra $w_4(C)$ e $w_3(C)$ (Lost Update) e tra $r_4(C)$ e $w_3(C)$ (Lost Update). Per risolverli con il livello di isolamento minimo occorre adottare il meccanismo delle Repeatable Reads.

### 4.3

C'è un conflitto tra $r_2(A)$ e $w_1(A)$. Si tratta di un conflitto Unrepeatable Read (Read-Write) e per risolverlo occorre adottare il meccanismo delle Repeatable Reads.
