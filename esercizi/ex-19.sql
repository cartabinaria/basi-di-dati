SELECT M.Name
FROM MUSEUM AS M
WHERE M.City = "London" AND
      "TIZIANO" = ALL (SELECT W.NameA
                       FROM WORK AS W
                       WHERE M.Name = W.NameM)
