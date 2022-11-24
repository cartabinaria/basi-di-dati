SELECT F.Title
FROM FILM AS F
WHERE F.Genre = "Sci-fi" AND
      (F.Country = "Japan" AND F.Year > 1990 OR
      F.Country = "France")
