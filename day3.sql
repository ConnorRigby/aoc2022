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
  value TEXT NOT NULL
);

CREATE TABLE Priority(i TEXT NOT NULL, value INTEGER NOT NULL);

CREATE TRIGGER PriorityCalculation AFTER INSERT ON Results
BEGIN
  INSERT INTO Priority(i, value) VALUES(NEW.value, CASE
    WHEN unicode(NEW.value) > 95 THEN unicode(NEW.value) - 96
    ELSE (unicode(NEW.value) - 64) + 26
  END);
  
END;

.import src/day3_part_1.txt Input -v --csv
-- .import src/day3_part_1_sample.txt Input -v --csv
.print

INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'a') AS x, INSTR(S2, 'a') AS y, INSTR(S3, 'a') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'b') AS x, INSTR(S2, 'b') AS y, INSTR(S3, 'b') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'c') AS x, INSTR(S2, 'c') AS y, INSTR(S3, 'c') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'd') AS x, INSTR(S2, 'd') AS y, INSTR(S3, 'd') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'e') AS x, INSTR(S2, 'e') AS y, INSTR(S3, 'e') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'f') AS x, INSTR(S2, 'f') AS y, INSTR(S3, 'f') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'g') AS x, INSTR(S2, 'g') AS y, INSTR(S3, 'g') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'h') AS x, INSTR(S2, 'h') AS y, INSTR(S3, 'h') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'i') AS x, INSTR(S2, 'i') AS y, INSTR(S3, 'i') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'j') AS x, INSTR(S2, 'j') AS y, INSTR(S3, 'j') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'k') AS x, INSTR(S2, 'k') AS y, INSTR(S3, 'k') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'l') AS x, INSTR(S2, 'l') AS y, INSTR(S3, 'l') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'm') AS x, INSTR(S2, 'm') AS y, INSTR(S3, 'm') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'n') AS x, INSTR(S2, 'n') AS y, INSTR(S3, 'n') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'o') AS x, INSTR(S2, 'o') AS y, INSTR(S3, 'o') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'p') AS x, INSTR(S2, 'p') AS y, INSTR(S3, 'p') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'q') AS x, INSTR(S2, 'q') AS y, INSTR(S3, 'q') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'r') AS x, INSTR(S2, 'r') AS y, INSTR(S3, 'r') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 's') AS x, INSTR(S2, 's') AS y, INSTR(S3, 's') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 't') AS x, INSTR(S2, 't') AS y, INSTR(S3, 't') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'u') AS x, INSTR(S2, 'u') AS y, INSTR(S3, 'u') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'v') AS x, INSTR(S2, 'v') AS y, INSTR(S3, 'v') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'w') AS x, INSTR(S2, 'w') AS y, INSTR(S3, 'w') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'x') AS x, INSTR(S2, 'x') AS y, INSTR(S3, 'x') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'y') AS x, INSTR(S2, 'y') AS y, INSTR(S3, 'y') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'z') AS x, INSTR(S2, 'z') AS y, INSTR(S3, 'z') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);

-- uppercase

INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'A') AS x, INSTR(S2, 'A') AS y, INSTR(S3, 'A') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'B') AS x, INSTR(S2, 'B') AS y, INSTR(S3, 'B') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'C') AS x, INSTR(S2, 'C') AS y, INSTR(S3, 'C') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'D') AS x, INSTR(S2, 'D') AS y, INSTR(S3, 'D') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'E') AS x, INSTR(S2, 'E') AS y, INSTR(S3, 'E') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'F') AS x, INSTR(S2, 'F') AS y, INSTR(S3, 'F') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'G') AS x, INSTR(S2, 'G') AS y, INSTR(S3, 'G') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'H') AS x, INSTR(S2, 'H') AS y, INSTR(S3, 'H') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'I') AS x, INSTR(S2, 'I') AS y, INSTR(S3, 'I') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'J') AS x, INSTR(S2, 'J') AS y, INSTR(S3, 'J') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'K') AS x, INSTR(S2, 'K') AS y, INSTR(S3, 'K') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'L') AS x, INSTR(S2, 'L') AS y, INSTR(S3, 'L') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'M') AS x, INSTR(S2, 'M') AS y, INSTR(S3, 'M') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'N') AS x, INSTR(S2, 'N') AS y, INSTR(S3, 'N') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'O') AS x, INSTR(S2, 'O') AS y, INSTR(S3, 'O') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'P') AS x, INSTR(S2, 'P') AS y, INSTR(S3, 'P') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'Q') AS x, INSTR(S2, 'Q') AS y, INSTR(S3, 'Q') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'R') AS x, INSTR(S2, 'R') AS y, INSTR(S3, 'R') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'S') AS x, INSTR(S2, 'S') AS y, INSTR(S3, 'S') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'T') AS x, INSTR(S2, 'T') AS y, INSTR(S3, 'T') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'U') AS x, INSTR(S2, 'U') AS y, INSTR(S3, 'U') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'V') AS x, INSTR(S2, 'V') AS y, INSTR(S3, 'V') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'W') AS x, INSTR(S2, 'W') AS y, INSTR(S3, 'W') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'X') AS x, INSTR(S2, 'X') AS y, INSTR(S3, 'X') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'Y') AS x, INSTR(S2, 'Y') AS y, INSTR(S3, 'Y') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);
INSERT INTO Results(value) VALUES(
  (SELECT SUBSTR(S1, x, 1) FROM (SELECT S1, INSTR(S1, 'Z') AS x, INSTR(S2, 'Z') AS y, INSTR(S3, 'Z') as z FROM SackGroups) WHERE x > 0 AND y > 0 AND z > 0)
);

SELECT "Priority", SUM(value) FROM Priority;