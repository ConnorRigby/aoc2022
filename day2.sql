-- [rock: 65, paper: 66, scissors: 67]
-- [loss: 88, draw: 89, win: 90]

-- used to calculate score baed on a given input + action 
CREATE TABLE GameActionScore(
  input INTEGER NOT NULL,
  action INTEGER NOT NULL,
  score INTEGER NOT NULL
);

-- rock - loss - Scissors score = 3
INSERT INTO GameActionScore(input, action, score) VALUES (65, 88, 3);
-- rock - draw - rock score = 1
INSERT INTO GameActionScore(input, action, score) VALUES (65, 89, 1);
-- rock - win - Paper score = 2
INSERT INTO GameActionScore(input, action, score) VALUES (65, 90, 2);

-- paper - loss - rock score = 1
INSERT INTO GameActionScore(input, action, score) VALUES (66, 88, 1);
-- paper - draw - paper score = 2
INSERT INTO GameActionScore(input, action, score) VALUES (66, 89, 2);
-- paper - win - scissors score = 3
INSERT INTO GameActionScore(input, action, score) VALUES (66, 90, 3);

-- scissors - loss - paper score = 2
INSERT INTO GameActionScore(input, action, score) VALUES (67, 88, 2);
-- scissors - draw - scisors score = 3
INSERT INTO GameActionScore(input, action, score) VALUES (67, 89, 3);
-- scissors - win - rock score = 1
INSERT INTO GameActionScore(input, action, score) VALUES (67, 90, 1);

-- Used to store the score of a game based on a win, loss or draw
CREATE TABLE GameResultScore(input INTEGER NOT NULL, score INTEGER NOT NULL);

-- Loss
INSERT INTO GameResultScore(input, score) VALUES (88, 0);
-- Draw
INSERT INTO GameResultScore(input, score) VALUES (89, 3);
-- Win
INSERT INTO GameResultScore(input, score) VALUES (90, 6);

-- Each line in the input will get parsed into this table
CREATE TABLE Round(play INTEGER, action INTEGER);

-- Raw input from 
CREATE TABLE Input(line TEXT);

-- Every line gets triggered here
CREATE TRIGGER InputTrigger AFTER INSERT ON Input
BEGIN
  -- split the entire line:
  -- first character will be 65,66,67
  -- second character will be 20 (discarded)
  -- third character will be 88,89,90
  INSERT INTO Round(play, action) VALUES(
    (SELECT UNICODE(SUBSTR(NEW.line, 1, 1))),
    (SELECT UNICODE(SUBSTR(NEW.line, 3, 1)))
  );
END;

-- Score is a simple query now of looking up each 
-- Rounds opposing play and and score
CREATE VIEW Score AS
SELECT 
  Round.play, Round.action, (GameActionScore.score + GameResultScore.score) as score
FROM Round
INNER JOIN GameActionScore ON Round.play = GameActionScore.input AND Round.action = GameActionScore.action
INNER JOIN GameResultScore ON Round.action = GameResultScore.input;

.import src/day2_part_1.txt Input -v --csv
.print

SELECT SUM(Score) FROM Score;
