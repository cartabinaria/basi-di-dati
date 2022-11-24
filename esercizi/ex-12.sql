SELECT F.Director, A.Name,
       COUNT(*) AS NumMovies
FROM ACTOR AS A, RECITAL AS R FILM AS F
WHERE A.Id = R.Actor AND
      R.Film = F.Code
GROUP BY F.Director, A.Id, A.Name
