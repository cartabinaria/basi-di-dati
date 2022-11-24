SELECT DISTINCT F.Title, F.Genre
FROM FILM AS F, SCREENING AS S, ROOM AS R
WHERE S.Date = 2018-12-25 AND
      R.City = "London" AND
      F.Code = S.Film AND
      S.Room = R.Code
