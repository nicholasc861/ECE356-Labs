-- Task A Classification Distribution
WITH c1 as (SELECT COUNT(DISTINCT h.playerID) as numTrueClass
            FROM HallOfFame h
            WHERE h.playerID IN (
                SELECT F.playerID FROM
                    (SELECT pe.playerID, SUM(m.G) as managerGames
                    FROM People pe
                    LEFT JOIN Managers m on pe.playerID = m.playerID
                    GROUP BY pe.playerID) AS F
                    JOIN
                    (SELECT pe.playerID, SUM(a.G_all) as totalGames
                    FROM People pe
                    LEFT JOIN Appearances a on pe.playerID = a.playerID
                    GROUP BY pe.playerID) AS G
                    ON F.playerID = G.playerID
                WHERE (F.managerGames > 0 OR G.totalGames > 0))),
     c2 as (SELECT COUNT(DISTINCT p.playerID) as totalPlayers
            FROM People p
            WHERE p.playerID IN (
                SELECT F.playerID FROM
                    (SELECT pe.playerID, SUM(m.G) as managerGames
                    FROM People pe
                    LEFT JOIN Managers m on pe.playerID = m.playerID
                    GROUP BY pe.playerID) AS F
                    LEFT JOIN
                    (SELECT pe.playerID, SUM(a.G_all) as totalGames
                    FROM People pe
                    LEFT JOIN Appearances a on pe.playerID = a.playerID
                    GROUP BY pe.playerID) AS G
                    ON F.playerID = G.playerID
                WHERE F.managerGames > 0 OR G.totalGames > 0))
SELECT c2.totalPlayers,
       c1.numTrueClass,
       c2.totalPlayers - c1.numTrueClass as numFalseClass,
       c1.numTrueClass / c2.totalPlayers as trueClassProportion,
       ((c2.totalPlayers - c1.numTrueClass) / c2.totalPlayers) as falseClassProportion
FROM c1, c2;

-- Task B Classification Distribution
WITH c1 as (SELECT COUNT(DISTINCT h.playerID) as numTrueClass
            FROM HallOfFame h
            WHERE inducted = 'Y'
            AND h.playerID IN (
                SELECT F.playerID FROM (
                    (SELECT pe.playerID, SUM(m.G) as managerGames
                    FROM People pe
                    LEFT JOIN Managers m on pe.playerID = m.playerID
                    GROUP BY pe.playerID) AS F
                    LEFT JOIN
                    (SELECT pe.playerID, SUM(a.G_all) as totalGames
                    FROM People pe
                    LEFT JOIN Appearances a on pe.playerID = a.playerID
                    GROUP BY pe.playerID) AS G
                    ON F.playerID = G.playerID)
                WHERE F.managerGames > 0 OR G.totalGames > 0)),
     c2 as (SELECT COUNT(DISTINCT p.playerID) as totalNominatedPlayers
            FROM HallOfFame p
            WHERE p.playerID IN (
                SELECT F.playerID FROM (
                    (SELECT pe.playerID, SUM(m.G) as managerGames
                    FROM People pe
                    LEFT JOIN Managers m on pe.playerID = m.playerID
                    GROUP BY pe.playerID) AS F
                    LEFT JOIN
                    (SELECT pe.playerID, SUM(a.G_all) as totalGames
                    FROM People pe
                    LEFT JOIN Appearances a on pe.playerID = a.playerID
                    GROUP BY pe.playerID) AS G
                    ON F.playerID = G.playerID)
                WHERE F.managerGames > 0 OR G.totalGames > 0))
SELECT c2.totalNominatedPlayers,
       c1.numTrueClass,
       c2.totalNominatedPlayers - c1.numTrueClass as numFalseClass,
       c1.numTrueClass / c2.totalNominatedPlayers as trueClassProportion,
       ((c2.totalNominatedPlayers - c1.numTrueClass) / c2.totalNominatedPlayers) as falseClassProportion
FROM c1, c2