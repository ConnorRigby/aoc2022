CREATE TABLE Sacks(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  contents TEXT NOT NULL
);

CREATE TABLE Input(line TEXT NOT NULL);

CREATE TRIGGER InputTrigger AFTER INSERT ON Input
BEGIN
  INSERT INTO Sacks(contents) VALUES(NEW.line);
END;


CREATE VIEW SackGroupID AS
SELECT DISTINCT SID.id-2 as s3, SID.id-1 as s2, SID.ID as s1 FROM Sacks as SID INNER JOIN Sacks on SID.id % 3 == 0; 

CREATE VIEW SackGroups AS
SELECT SS1.contents as S1, SS2.contents as S2, SS3.contents as S3 FROM SackGroupID
INNER JOIN Sacks as SS1 ON SS1.id = SackGroupID.s1
INNER JOIN Sacks as SS2 ON SS2.id = SackGroupID.s2
INNER JOIN Sacks AS SS3 ON SS3.id = SackGroupID.s3;

CREATE TABLE Results(
  x INTEGER,
  y INTEGER,
  z INTEGER
);

CREATE TABLE ResultCheck(char TEXT NOT NULL, priority INTEGER NOT NULL);
CREATE TRIGGER ResultCheckTrigger AFTER INSERT ON ResultCheck
BEGIN
  INSERT INTO Results(x,y,z) VALUES(
    (SELECT INSTR(S1, NEW.char), INSTR(S2, NEW.char), INSTR(S3, NEW.char) FROM SackGroups)
  );
END;

.import src/day3_part_1_sample.txt Input -v --csv
.print

-- SELECT SUM(Score) FROM Score;
INSERT INTO ResultCheck(char, priority) VALUES('a', 1);

SELECT * FROM Results;