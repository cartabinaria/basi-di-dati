SELECT FILM.Title
FROM RATING
JOIN FILM
ON RATING.FilmID = FILM.FilmID
WHERE FILM.Year >= 1990 AND FILM.Year <= 2000
GROUP BY FILM.FilmID, FILM.Title
HAVING ARG(RATING.Rating) >= 7