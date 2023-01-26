# Soluzione scritto 2023-01-09

## Esercizio 1

1. b
2. d
3. c
4. b
5. a
6. c

## Esercizio 2

1. $$ \sigma_{Atleta.nazione = 'Austria'}(Atleta) \bowtie_{Atleta.codice = Partecipazione.atleta} \sigma_{Partecipazione.piazzamento \leq 3}(Partecipazione) \bowtie_{Gara.codice = Partecipazione.gara} \sigma_{Gara.data \geq 1-01-2005 \and Gara.data \leq 31-12-2010 \and Gara.disciplina = 'slalom speciale'}(Gara)$$
2. $$ \pi_{Gara.luogo}(Gara - (\pi_{Gara.\*}(\sigma_{Gara.luogo = Atleta.nazione \and Partecipazione.piazzamentento = 1}(Gara \bowtie_{Gara.codice = Partecipazione.gara} Partecipazione \bowtie_{Partecipazione.atleta = Atleta.codice} Atleta  ))))  $$
