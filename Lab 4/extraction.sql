-- Task A
SELECT A.playerID, A.gamesBatted, B.gamesPitched, C.gamesFielded, A.rbi FROM
(
    SELECT pe.playerID, SUM(B.G) as gamesBatted, AVG(B.RBI) as rbi, COUNT(*) as years
    FROM People pe
    LEFT JOIN Batting B on pe.playerID = B.playerID
    WHERE pe.playerID in (SELECT DISTINCT h.playerID
                        FROM HallOfFame h)
    GROUP BY pe.playerID) as A
JOIN (
    SELECT pe.playerID, SUM(P.G) as gamesPitched, COUNT(*) as years
    FROM People pe
    LEFT JOIN Pitching P on pe.playerID = P.playerID
    WHERE pe.playerID in (SELECT DISTINCT h.playerID
                        FROM HallOfFame h)
    GROUP BY pe.playerID) as B
ON A.playerID = B.playerID
JOIN (
    SELECT pe.playerID, SUM(F.G) as gamesFielded, COUNT(*) as years
    FROM People pe
    LEFT JOIN Fielding F on pe.playerID = F.playerID
    WHERE pe.playerID in (SELECT DISTINCT h.playerID
                        FROM HallOfFame h)
    GROUP BY pe.playerID) as C
ON A.playerID = C.playerID;