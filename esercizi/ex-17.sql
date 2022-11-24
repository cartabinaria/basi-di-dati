SELECT F.Title
FROM FILM AS F
WHERE 500 <= (SELECT MIN(S.Profits)
              FROM SCREENING AS S
              WHERE F.Code = S.Film)
