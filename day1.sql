CREATE TABLE input_data (
  value INTEGER NOT NULL,
  elf_id INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE input (
  value INTEGER
);

CREATE TRIGGER input_trigger AFTER INSERT ON input
BEGIN
  SELECT RAISE(IGNORE) WHERE NEW.value == '';
  INSERT INTO input_data(value, elf_id) VALUES(NEW.value, (
    SELECT COUNT(value) FROM input WHERE value == '')
  );
END;

CREATE VIEW answer AS
SELECT SUM(value) as value FROM input_data GROUP BY elf_id ORDER BY value DESC;

CREATE VIEW answer2 AS
SELECT value from answer ORDER BY value DESC LIMIT 3;

.import src/day1_part_1.txt input -v --csv
.print
SELECT "Part1=", MAX(value) from answer;
SELECT "Part2=", SUM(value) from answer2;