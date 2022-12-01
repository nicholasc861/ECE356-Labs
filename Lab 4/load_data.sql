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

