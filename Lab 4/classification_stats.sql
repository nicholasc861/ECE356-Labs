-- Task A Classification Distribution
WITH c1 as (SELECT COUNT(DISTINCT h.playerID) as numTrueClass FROM HallOfFame h),
     c2 as (SELECT COUNT(DISTINCT p.playerID) as totalPlayers FROM People p)
SELECT c2.totalPlayers,
       c1.numTrueClass,
       c2.totalPlayers - c1.numTrueClass as numFalseClass,
       c1.numTrueClass / c2.totalPlayers as trueClassProportion,
       ((c2.totalPlayers - c1.numTrueClass) / c2.totalPlayers) as falseClassProportion
FROM c1, c2;

-- Task B Classification Distribution
WITH c1 as (SELECT COUNT(DISTINCT h.playerID) as numTrueClass FROM HallOfFame h WHERE inducted = 'Y'),
     c2 as (SELECT COUNT(DISTINCT p.playerID) as totalNominatedPlayers FROM HallOfFame p)
SELECT c2.totalNominatedPlayers,
       c1.numTrueClass,
       c2.totalNominatedPlayers - c1.numTrueClass as numFalseClass,
       c1.numTrueClass / c2.totalNominatedPlayers as trueClassProportion,
       ((c2.totalNominatedPlayers - c1.numTrueClass) / c2.totalNominatedPlayers) as falseClassProportion
FROM c1, c2