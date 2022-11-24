SELECT F.Title
FROM FILM AS F
WHERE NOT EXIST (SELECT S.Code
                 FROM SCREENING AS S, ROOM AS R
                 WHERE R.City = "Berlin" AND
                 F.Code = S.Film AND
                 S.Room = R.Code)
