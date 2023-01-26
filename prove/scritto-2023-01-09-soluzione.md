# Soluzione scritto 2023-01-09

## Esercizio 1

1. b
2. d
3. c
4. b
5. a
6. c

## Esercizio 2

## Interrogazione 1

$$ \sigma\_{Atleta.nazione = 'Austria'}(Atleta) $$

$$ \bowtie\_{Atleta.codice = Partecipazione.atleta} $$

$$ \sigma\_{Partecipazione.piazzamento \leq 3}(Partecipazione) $$

$$ \bowtie\_{Gara.codice = Partecipazione.gara} $$

$$
\sigma_{Gara.data \geq 1-01-2005 \and Gara.data \leq 31-12-2010 \and
Gara.disciplina = 'slalom speciale'}(Gara)
$$

## Interrogazione 2

$$ \pi*{Gara.luogo}(Gara - (\pi*{Gara.\*}( $$

$$
\sigma_{Gara.luogo = Atleta.nazione \and Partecipazione.piazzamentento = 1}(
$$

Gara \bowtie*{Gara.codice = Partecipazione.gara} Partecipazione
\bowtie*{Partecipazione.atleta = Atleta.codice} Atleta $$

$$ ) $$

$$ ))) $$
