#
# ECE356 - Lab 4
# Fall 2022
# Group 60
#

DROP TABLE IF EXISTS AllstarFull;
DROP TABLE IF EXISTS HallOfFame;
DROP TABLE IF EXISTS Batting;
DROP TABLE IF EXISTS Fielding;
DROP TABLE IF EXISTS Pitching;
DROP TABLE IF EXISTS People;

# Create all tables
# Create HallOfFame
CREATE TABLE HallOfFame
(
    playerID    text null,
    yearID      int  null,
    votedBy     text null,
    ballots     int  null,
    needed      int  null,
    votes       int  null,
    inducted    text null,
    category    text null,
    needed_note text null
);

# Create Batting
CREATE TABLE Batting
(
    playerID text null,
    yearID   int  null,
    stint    int  null,
    teamID   text null,
    lgID     text null,
    G        int  null,
    AB       int  null,
    R        int  null,
    H        int  null,
    `2B`     int  null,
    `3B`     int  null,
    HR       int  null,
    RBI      int  null,
    SB       int  null,
    CS       int  null,
    BB       int  null,
    SO       int  null,
    IBB      text null,
    HBP      text null,
    SH       text null,
    SF       text null,
    GIDP     int  null
);

CREATE TABLE People (
    playerID     text    null,
    birthYear    int     null,
    birthMonth   int     null,
    birthDay     int     null,
    birthCountry text    null,
    birthState   text    null,
    birthCity    text    null,
    deathYear    int     null,
    deathMonth   int     null,
    deathDay     int     null,
    deathCountry text    null,
    deathState   text    null,
    deathCity    text    null,
    nameFirst    text    null,
    nameLast     text    null,
    nameGiven    text    null,
    weight       int     null,
    height       int     null,
    bats         int     null,
    throws       int     null,
    debut        text    null,
    finalGame    text    null,
    retroID      text    null,
    bbrefID      text    null
);

CREATE TABLE Pitching (
    playerID text null,
    yearID int null,
    stint int null,
    teamID text null,
    lgID text null,
    W int null,
    L int null,
    G int null,
    GS int null,
    CG int null,
    SHO int null,
    SV int null,
    IPouts int null,
    H int null,
    ER int null,
    HR int null,
    BB int null,
    SO int null,
    BAOpp int null,
    ERA float null,
    IBB int null,
    WP int null,
    HBP int null,
    BK int null,
    BFP int null,
    GF int null,
    R int null,
    SH int null,
    SF int null,
    GIDP int null
);

CREATE TABLE Fielding (
    playerID text null,
    yearID int null,
    stint int null,
    teamID text null,
    lgID text null,
    POS text null,
    G int null,
    GS int null,
    InnOuts int null,
    PO int null,
    A int null,
    E int null,
    DP int null,
    PB int null,
    WP int null,
    SB int null,
    CS int null,
    ZR int null
);
-- Import People.csv
LOAD DATA LOCAL INFILE "./baseball_data/People.csv"
INTO TABLE People
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Import HallOfFame.csv
LOAD DATA LOCAL INFILE "./baseball_data/HallOfFame.csv"
INTO TABLE HallOfFame
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Import Batting.csv
LOAD DATA LOCAL INFILE "./baseball_data/Batting.csv"
INTO TABLE Batting
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Import Pitching.csv
LOAD DATA LOCAL INFILE "./baseball_data/Pitching.csv"
INTO TABLE Pitching
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Import Fielding.csv
LOAD DATA LOCAL INFILE "./baseball_data/Fielding.csv"
INTO TABLE Fielding
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

