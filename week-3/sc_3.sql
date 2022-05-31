--- 1. SET UP

-- Delete observations
DELETE FROM people.person WHERE id > 5; 
DELETE FROM people.location WHERE id > 10;
DELETE FROM people.car WHERE id > 3;
-- Add a new column to link tables
ALTER TABLE people.person ADD COLUMN car_id bigint;
ALTER TABLE people.location ADD COLUMN person_id bigint;

--- 2. FOREIGN KEY

-- Add a Foreign Key constraint
ALTER TABLE people.person ADD CONSTRAINT car_fk 
FOREIGN KEY (car_id) REFERENCES people.car(id);

ALTER TABLE people.location ADD CONSTRAINT person_fk  
FOREIGN KEY (person_id) REFERENCES people.person(id)
ON DELETE SET NULL;

-- Modify data in our person table
UPDATE people.person SET car_id = 3 WHERE id = 1;
UPDATE people.person SET car_id = 2 WHERE id = 2;
UPDATE people.person SET car_id = 1 WHERE id = 3; 
-- Try to see what happens if you insert a car that does not exist: UPDATE people.person SET car_id = 4 WHERE id = 3;
-- Try to see what happens if you delete a referenced car: DELETE FROM people.car WHERE id = 3;

-- Modify data in our location table
UPDATE people.location SET person_id = 4 WHERE id = 1;
UPDATE people.location SET person_id = 3 WHERE id = 2;
UPDATE people.location SET person_id = 2 WHERE id = 5;
-- Try to see what happens if you delete a referenced individual: DELETE FROM people.person WHERE id = 4;

--- 3. Joins

--- 3.1 INNER JOIN

-- Joining two tables 
SELECT first_name, last_name, country, city FROM people.person
INNER JOIN people.location ON people.location.person_id = people.person.id;
-- Let's use alias on tables to reduce the complexity
SELECT first_name, last_name, country, city FROM people.person pp
INNER JOIN people.location pl ON pl.person_id = pp.id;
-- Joining three tables
SELECT first_name, last_name, country, city, car_make, car_model FROM people.person pp
INNER JOIN people.location pl ON pl.person_id = pp.id
INNER JOIN people.car pc ON pc.id = pp.car_id;

--- 3.2 Left/Right and FULL OUTER Join

-- Left join
SELECT first_name, last_name, car_make FROM people.person pp
LEFT JOIN people.car pc ON pc.id = pp.car_id;
-- RIGHT join
SELECT first_name, last_name, country FROM people.person pp
RIGHT JOIN people.location pl ON pl.person_id = pp.id;
-- FULL (OUTER)
SELECT first_name, last_name, country FROM people.person pp
FULL OUTER JOIN people.location pl ON pl.person_id = pp.id;

--- 3.3 CROSS Join

-- Create a new table
CREATE TABLE people.letters (
	let varchar(1));
-- Insert multiple values in the table
INSERT INTO people.letters (let)
VALUES ('a'),
		('b'),
		('c');
-- Create another  table
CREATE TABLE people.numbers (
	num int);
-- Insert multiple values in the table
INSERT INTO people.numbers (num)
VALUES (1),
		(2),
		(3);
-- cross join tables:
SELECT num, let FROM people.numbers
CROSS JOIN people.letters

-- 4. EXPORT 

COPY (SELECT * FROM people.letters CROSS JOIN people.numbers)
TO '/tmp/cross_join.csv' DELIMITER ',' CSV HEADER; -- remember to insert the path to a folder that PgAmin can access!