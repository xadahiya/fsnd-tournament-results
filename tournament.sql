DROP DATABASE IF EXISTS tournament;
-- Create Database
CREATE DATABASE tournament;

-- Connect to database
\c tournament;

-- Create table player
CREATE TABLE players (
  "id" serial NOT NULL PRIMARY KEY,
  "name" varchar(512) NOT NULL
);

-- Create standings table
CREATE TABLE matches (
  "winner" integer REFERENCES players(id),
  "loser" integer REFERENCES players(id),
  PRIMARY KEY (winner, loser)
);

-- Create a view that tallies total matches per player
CREATE OR REPLACE VIEW games_view AS
SELECT players.id, COUNT(matches.*) AS games
FROM players LEFT JOIN matches
ON players.id = matches.winner OR players.id = matches.loser
GROUP BY players.id;
