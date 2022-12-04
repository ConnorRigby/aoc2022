CREATE TABLE RangePair(
  a_start INTEGER NOT NULL,
  a_end   INTEGER NOT NULL,
  b_start INTEGER NOT NULL,
  b_end   INTEGER NOT NULL
);

CREATE TABLE Input(a TEXT NOT NULL, b TEXT NOT NULL);

CREATE TRIGGER InputTrigger AFTER INSERT ON Input
BEGIN
  INSERT INTO RangePair(a_start, a_end, b_start, b_end) VALUES(
    CAST(SUBSTR(NEW.a, 0, INSTR(NEW.a, "-")) AS INTEGER),
    CAST(SUBSTR(NEW.a, INSTR(NEW.a, "-")+1, length(NEW.a)) AS INTEGER),

    CAST(SUBSTR(NEW.b, 0, INSTR(NEW.b, "-")) AS INTEGER),
    CAST(SUBSTR(NEW.b, INSTR(NEW.b, "-")+1, length(NEW.b)) AS INTEGER)
  );
END;

.import src/day4_part_1.txt Input -v --csv
-- .import src/day4_part_1_sample.txt Input -v --csv
.print

SELECT COUNT(*) from RangePair
WHERE (RangePair.a_start BETWEEN RangePair.b_start AND RangePair.b_end)
OR    (RangePair.a_end   BETWEEN RangePair.b_start AND RangePair.b_end)
OR    (RangePair.b_start BETWEEN RangePair.a_start AND RangePair.a_end)
OR    (RangePair.b_end   BETWEEN RangePair.a_start AND RangePair.a_end);
