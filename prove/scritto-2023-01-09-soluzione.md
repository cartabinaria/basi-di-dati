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

## Interrogazione 1

$$ \pi\_{Atleta.nome}( $$

$$ \sigma\_{Atleta.nazione = 'Austria'}(Atleta) $$

$$ \bowtie\_{Atleta.codice = Partecipazione.atleta} $$

$$ \sigma\_{Partecipazione.piazzamento \leq 3}(Partecipazione) $$

$$ \bowtie\_{Gara.codice = Partecipazione.gara} $$

$$
\sigma_{Gara.data \geq 1-01-2005 \land Gara.data \leq 31-12-2010 \land
Gara.disciplina = 'slalom speciale'}(Gara)
$$

$$ ) $$

## Interrogazione 2

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

## Interrogazine 3

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

## Interrogazione 4

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
