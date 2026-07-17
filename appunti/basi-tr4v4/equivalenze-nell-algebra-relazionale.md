---
tags:
  - category/note
  - status/finished
  - topic/basi-di-dati
date: 04-10-2025 19:33:08
links:
---
# Equivalenze nell'algebra relazionale
---
## Introduzione
> Due espressioni $E_{1}$ ed $E_{2}$ dell'[[algebra-relazionale|algebra relazionale]] sono **equivalenti** se restituiscono lo stesso risultato indipendentemente dallo stato del [[database|database]], ma che potrebbe dipendere dallo schema.

Le regole di equivalenza sono importantissime perché i moderni [[dbms|DBMS]] provano a **riscrivere le query in espressioni equivalenti ma più efficienti**.

## Espressioni equivalenti
### Combinazione a cascata di selezioni
$$\sigma_{C_{1} \land C_{2}} (R) = \sigma_{C_{1}}(\sigma_{C_{2}}(R))$$

### Idempotenza della proiezione
$X$ e $Y$ appartengono allo schema di $R$:
$$\pi_{X}(R) = \pi_{X}(\pi_{XY}(R))$$

### Ordine di selezione e proiezione
$$\pi_{XY}(\sigma_{X}(R)) = \sigma_{X}(\pi_{XY}(R))$$
(in questo caso per $\sigma_{X}$ si intende una condizione che lavora sugli attributi in $X$).

### Push-down della selezione
$$\sigma_{C}(R_{1} \Join R_{2}) = R_{1} \Join \sigma_{C}(R_{2})$$

### Push-down della proiezione
$$\pi_{X_{1}Y_{2}}(R_{1} \Join R_{2}) = R_{1} \Join \pi_{Y_{2}}(R_{2})$$
dove:
- $R_{1}$ ha schema $X_{1}$ e $R_{2}$ ha schema $X_{2}$;
- $Y_{2} \subseteq X_{1} \cap X_{2}$.

Infatti avviene che gli attributi in $X_{2} \setminus Y_{2}$ non sono considerati nella join, per cui l'equivalenza vale.

### Distributività di select su union
$$\sigma_{C}(R_{1} \cup R_{2}) = \sigma_{C}(R_{1}) \cup \sigma_{C}(R_{2})$$

### Distributività di select su difference
$$\sigma_{C}(R_{1} \setminus R_{2}) = \sigma_{C}(R_{1}) \setminus \sigma_{C}(R_{2})$$

### Distributività di projection su union
$$\pi_{X}(R_{1} \cup R_{2}) = \pi_{X}(R_{1}) \cup \pi_{X}(R_{2})$$

### Legame tra select e union
$$\sigma_{C_{1} \lor C_{2}}(R) = \sigma_{C_{1}}(R) \cup \sigma_{C_{2}}(R)$$

### Legame tra select e intersect
$$\sigma_{C_{1} \land C_{2}}(R) = \sigma_{C_{1}}(R) \cap \sigma_{C_{2}}(R)$$

### Legame tra select e difference
$$\sigma_{C_{1} \land \neg C_{2}}(R) = \sigma_{C_{1}}(R) \setminus \sigma_{C_{2}}(R)$$

### Distributività della join su union
$$R_{1} \Join (R_{2} \cup R_{3}) = (R_{1} \Join R_{2}) \cup (R_{1} \Join R_{3})$$


## Referenze