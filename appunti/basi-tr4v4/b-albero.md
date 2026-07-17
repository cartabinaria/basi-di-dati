---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 26-11-2025 17:30:37
links:
  - "[[lecture-21112025151717|Lecture 21112025151717]]"
---
# B+ albero
---
## Introduzione
> Un **B+ albero** è una versione del [[b-albero|B-albero]] che consiste nel mantenere i [[puntatore|puntatori]] ai _data file_ (ossia ai record del [[database|database]]) solo nei nodi foglia. Quindi le search key nei nodi foglia sono delle copie delle chiavi dei data file, e tali search key sono distribuite per tutte le foglie in modo ordinato, da sinistra a destra.

In particolare, si ha che:
- nella **root** ci sono almeno 2 puntatori usati che puntano a dei blocchi di indice di livello inferiore;
- in un **nodo interiore** tutti i puntatori puntano a blocchi del livello inferiore, e almeno $\lceil \frac{n+1}{2} \rceil$ devono essere occupati (più della metà);
- in una **foglia** l'ultimo puntatore punta al blocco foglia successivo, sulla destra, mentre almeno $\lfloor \frac{n+1}{2} \rfloor$ sono usati e puntano a data file.

![[b-trees-nodi-interiori-e-foglie.png]]

Un esempio completo di B+ albero è il seguente:
![[b-trees-esempio.png]]

## Operazioni
### Ricerca di uguaglianza
Assumiamo di aver costruito il B+ albero correttamente, e di voler a questo punto cercare i data record che hanno search key $K = 40$. E' sufficiente scorrere l'albero come se fosse una sorta di generalizzazione di un [[albero-binario-di-ricerca|albero binario di ricerca]]!
![[b-trees-ricerca-1.png]]
![[b-trees-ricerca-2.png]]

### Ricerca di range
L'efficienza dei B alberi si ottiene nella ricerca di un certo range di chiavi! Per esempio, assumiamo di voler cercare tutti i data record con search key $K > 40$.
![[b-trees-ricerca-1.png]]
Come prima procediamo fino a un blocco foglia, lo scansioniamo alla ricerca di una search key maggiore di 40, e poi usiamo l'ultimo puntatore per passare al blocco foglia successivo, che per costruzione avrà sempre search key maggiori di 40!
![[b-trees-ricerca-3.png]]

### Inserimento
Se ora vogliamo aggiungere una nuova chiave[^1]? Il procedimento è [[ricorsione|ricorsivo]]:
- troviamo il blocco foglia corretto a cui aggiungere la chiave;
- se c'è spazio lo aggiungiamo;
- altrimenti dividiamo la foglia in due, e dividiamo le chiavi tra questi due nuovi nodi foglia in modo che ognuno sia pieno a metà o poco più;
	- in tal caso, però, _il nuovo nodo foglia dovrà essere puntato da un puntatore di un blocco del livello superiore_!
	- per cui banalmente ripetiamo il procedimento al livello superiore, andando a inserire il puntatore con search key della nuova chiave inserita;
		- <u>nota bene</u>: **nei nodi interiori se facciamo lo split NON andiamo a inserire la search key, ma propaghiamo il suo inserimento alla radice**;
	- si risale fino alla root, qualora ogni nodo della gerarchia non avesse sufficiente spazio per aggiungere semplicemente la chiave, e in tal caso, _se anche la root non ha spazio bisogna dividerla e creare una nuova root di livello superiore_!

Prendiamo in esempio l'inserimento della search key $K = 40$.
![[b-trees-ricerca-1.png]]

Identifichiamo quindi il blocco foglia in cui aggiungerla:
![[b-trees-inserimento-1.png]]

Dividiamo il blocco foglia:
![[b-trees-inserimento-2.png]]

Avendo diviso il nodo foglia in due nuovi, bisogna aggiungere la search key anche al blocco del livello superiore!
![[b-trees-inserimento-3.png]]

In questo caso tale blocco è pieno, quindi lo dividiamo in due blocchi _senza inserire 40_:
![[b-trees-inserimento-4.png]]

Ricorsivamente, avendo creato un nuovo blocco, dobbiamo inserire la search key al blocco del livello superiore, in questo caso root. Ora sì che inseriamo la search key effettivamente:
![[b-trees-inserimento-5.png]]

Se la root fosse stata piena, avremmo dovuto dividerla e creare una nuova root di livello superiore in cui effettivamente inserire la search key 40.

### Rimozione
Anche la rimozione di una chiave è ricorsiva:
- cerchiamo il blocco foglia che contiene la chiave e la eliminiamo;
	- <u>nota bene</u>: **non dobbiamo rimuovere la foglia dai nodi intermedi**! non è necessario...
- se la foglia ha il numero minimo di chiavi/puntatori allora abbiamo finito;
- altrimenti:
	- guardiamo i nodi vicini, a destra e a sinistra, e se almeno uno dei due ha PIU' del minimo numero di chiavi, possiamo spostare un indice (coppia `<chiave, puntatore>`) lì; chiaramente questo comporta l'aggiornamento delle chiavi nei rispettivi nodi genitori;
	- in caso contrario, significa che entrambi i nodi adiacenti hanno esattamente il numero minimo di chiavi, e quindi possono essere fusi; chiaramente anche qui dobbiamo aggiornare i valori delle chiavi nei rispettivi nodi genitori, e se questi sono pieni abbastanza, siamo a posto; altrimenti applichiamo l'algoritmo ricorsivamente;

Prendiamo in esempio il seguente caso, in cui vogliamo eliminare la chiave $K = 7$.
![[b-trees-rimozione-1.png]]

Troviamo il blocco foglia ed eliminiamo l'indice:
![[b-trees-rimozione-2.png]]

In tal caso avviene che il blocco foglia "vittima" ha solo 1 indice, e quindi non rispetta il vincolo dei blocchi foglia. Allora guardiamo i blocchi fratelli, in questo caso quello di sinistra, e spostiamo l'indice 5 lì:
![[b-trees-rimozione-3.png]]

Ora bisogna aggiornare l'indice del blocco superiore, sostituendo 5 al 7:
![[b-trees-rimozione-4.png]]

Ora, assumiamo di voler eliminare anche la chiave 11. Arriviamo al blocco foglia ed eliminiamo l'indice:
![[b-trees-rimozione-5.png]]

In questo caso, non possiamo prendere un nodo dalla foglia di sinistra, e neanche da quella di destra (violerebbe la divisione delle chiavi a partire dalla radice!). Allora facciamo il merge delle due prime foglie:
![[b-trees-rimozione-6.png]]

E infine aggiustiamo i valori delle chiavi in modo da ribilanciare l'albero:
![[b-trees-rimozione-7.png]]

## Complessità
Se volessimo analizzare la [[complessita-computazionale|complessità computazionale]] dei B+ alberi, in particolare dell'operazione di ricerca (`search`), otteniamo facilmente che _questa dipende dalla loro altezza_ $L$. Se assumiamo di avere $N$ foglie, e in media $\frac{n}{2}$ puntatori per foglia, l'altezza del B+ albero sarebbe
$$\log_{\frac{n}{2}} N \leq L \leq \log_{\frac{n}{2}} N + 1$$

## Referenze

[^1]: ricordandosi che di fatto avviene ogni qualvolta viene creato un nuovo record dello schema su cui si è creato un indice!
