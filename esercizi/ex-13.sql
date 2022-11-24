SELECT F.Director, F.Title
FROM FILM AS F
WHERE 6 > (SELECT COUNT(*)
           FROM RECITAL AS R
           WHERE F.Code = R.Film)
