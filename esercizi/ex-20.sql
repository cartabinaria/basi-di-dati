SELECT W.NameM AS Museum
FROM WORK AS W, ARTIST AS A
WHERE W.NameA = A.Nome AND
      A.Nationality = "Italy"
GROUP BY W.NameM
HAVING COUNT(*) >= 20
