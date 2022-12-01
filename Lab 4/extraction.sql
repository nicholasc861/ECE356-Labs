-- Task A
SELECT A.playerID,
       COALESCE(A.gamesBatted, 0) as gamesBatted,
       COALESCE(B.gamesPitched, 0) as gamesPitched,
       COALESCE(C.gamesFielded, 0) as gamesFielded,
       COALESCE(D.totalGames, 0) as totalGames,
       COALESCE(D.years, 0) as totalYears,
       A.rbi,
       F.managerWins,
       COALESCE(E.awardsWon, 0) as awardsWon,
       IF (A.playerID IN (SELECT DISTINCT playerID FROM HallOfFame), 'Y', 'N') AS nominated
FROM
(
    SELECT pe.playerID, SUM(B.G) as gamesBatted, AVG(B.RBI) as rbi
    FROM People pe
    LEFT JOIN Batting B on pe.playerID = B.playerID
    GROUP BY pe.playerID) as A
JOIN (
    SELECT pe.playerID, SUM(P.G) as gamesPitched
    FROM People pe
    LEFT JOIN Pitching P on pe.playerID = P.playerID
    GROUP BY pe.playerID) as B
ON A.playerID = B.playerID
JOIN (
    SELECT pe.playerID, SUM(F.G) as gamesFielded
    FROM People pe
    LEFT JOIN Fielding F on pe.playerID = F.playerID
    GROUP BY pe.playerID) as C
ON A.playerID = C.playerID
JOIN (
    SELECT pe.playerID, SUM(a.G_all) as totalGames, COUNT(DISTINCT a.playerID, a.yearID) as years
    FROM People pe
    LEFT JOIN Appearances a on pe.playerID = a.playerID
    GROUP BY pe.playerID) as D
ON A.playerID = D.playerID
LEFT JOIN (
    SELECT pe.playerID, COUNT(*) as awardsWon
    FROM People pe
    INNER JOIN AwardsPlayers a on pe.playerID = a.playerID
    GROUP BY pe.playerID) as E
ON A.playerID = E.playerID
JOIN (
    SELECT pe.playerID, SUM(m.W) as managerWins
    FROM People pe
    LEFT JOIN Managers m on pe.playerID = m.playerID
    GROUP BY pe.playerID) as F
ON A.playerID = F.playerID;