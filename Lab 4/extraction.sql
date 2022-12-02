-- Task A
SELECT A.playerID,
        COALESCE(A.gamesBatted, 0) as gamesBatted,
        COALESCE(A.rbi, 0) as totalRBI,
        COALESCE(A.hr, 0) as totalHR,
        COALESCE(A.atBats, 0) as atBats,
        COALESCE(B.gamesPitched, 0) as gamesPitched,
        COALESCE(B.pitchingER, 0) as pitchingER,
        COALESCE(B.pitchingERA, 0) as pitchingERA,
        COALESCE(B.baopp, 0) as opponentBattingAvg,
        COALESCE(C.gamesFielded, 0) as gamesFielded,
        COALESCE(C.po, 0) as totalPutOut,
        COALESCE(D.totalGames, 0) as totalGames,
        COALESCE(D.years, 0) as totalSeasons,
        COALESCE(F.managerWins, 0) as managerWins,
        COALESCE(E.awardsWon, 0) as awardsWon,
        COALESCE(G.allStar,0) as allstartappearences,
        COALESCE(H.porportionalsal, 1) as porportionalsal,
        IF (A.playerID IN (SELECT DISTINCT playerID FROM HallOfFame), 1, 0) AS nominated
FROM
(
    SELECT pe.playerID, SUM(B.G) as gamesBatted, SUM(B.AB) as atBats, SUM(B.RBI) as rbi, SUM(B.HR) as hr
    FROM People pe
    LEFT JOIN Batting B on pe.playerID = B.playerID
    GROUP BY pe.playerID) as A
JOIN (
    SELECT pe.playerID, SUM(P.G) as gamesPitched, SUM(P.ER) as pitchingER, AVG(P.ERA) as pitchingERA, AVG(P.BAOpp) as baopp
    FROM People pe
    LEFT JOIN Pitching P on pe.playerID = P.playerID
    GROUP BY pe.playerID) as B
ON A.playerID = B.playerID
JOIN (
    SELECT pe.playerID, SUM(F.G) as gamesFielded, SUM(F.PO) as po
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
ON A.playerID = F.playerID
LEFT JOIN (
    SELECT pe.playerID, COUNT(*) as allStar
    FROM People pe
    INNER JOIN AllstarFull a on pe.playerID = a.playerID
    GROUP BY pe.playerID) as G
ON A.playerID = G.playerID
LEFT JOIN (
    SELECT s1.playerID, AVG(s1.salary/s2.avg_sal) as porportionalsal
    FROM  Salaries as s1 JOIN (SELECT yearID, AVG(salary) as avg_sal FROM Salaries
    GROUP BY yearID) as s2
    on s1.yearID = s2.yearID
    GROUP BY s1.playerID
)as H
on A.playerID = H.playerID

