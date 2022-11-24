SELECT M.Name
FROM MUSEUM AS M
WHERE M.City = "London" AND
      NOT EXISTS (SELECT W.Code
                  FROM WORK AS W
                  WHERE W.NameA = "Tiziano" AND M.Name = W.NameM)
