SELECT R.Name, SUM(S.Profits)
FROM ROOM AS R, SCREENING AS S
WHERE R.Code = S.Room AND
      R.City = "Rome" AND
      2005-01-01 < S.Date AND
      S.Date < 2005-01-31
GROUP BY R.Code, R.Name
HAVING SUM(S.Profits) > 20000
