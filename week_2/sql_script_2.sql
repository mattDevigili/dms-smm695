--- Lecture two, SQL script

-- set-up

CREATE DATABASE mydb;

CREATE SCHEMA people;

--- 1. Create a table with constraints

CREATE TABLE people.person (
    id INT,
    name VARCHAR(20) NOT NULL,
    gender VARCHAR(7),
 	date_of_birth DATE NOT NULL,
	email VARCHAR(100)
);

-- 1.1 NOT NULL constraint

INSERT INTO people.person (
    id, name, gender, date_of_birth, email)
VALUES (1, 'john', 'Male', '1999-01-01', 'john@gmail.com')

-- This script will rise an error due to
-- the not null constraint applied to the
-- column name:
-- INSERT INTO people.person (
--    id, gender, date_of_birth, email)
--    VALUES (1, 'Male', '1999-01-01', 'john@gmail.com')


-- This script will rise an error due to
-- the not null constraint applied to the
-- column date_of_birth:
-- INSERT INTO people.person (
--    id, name, gender, email)
--    VALUES (1, 'john', 'Male', 'john@gmail.com')


INSERT INTO people.person (
    id, name, gender, date_of_birth)
VALUES (2, 'john', 'Male', '1999-01-01')

-- 1.2 UNIQUE

-- alter table to add a uniqie constraint on email column:

ALTER TABLE people.person ADD CONSTRAINT unique_email  UNIQUE (email);

-- Let's insert some data:

INSERT INTO people.person (
    id, name, gender, date_of_birth, email)
VALUES (3, 'sarah', 'Female', '1996-03-09', 'sarah@yahoo.com')


-- This script will rise an error due to
-- the unique constraint applied to the
-- column email:
-- INSERT INTO people.person (
--    id, name, gender, date_of_birth, email)
--    VALUES (4, 'sarah', 'Female', '1997-03-09', 'sarah@yahoo.com');


INSERT INTO people.person (
    id, name, gender, date_of_birth, email)
VALUES (4, 'sarah', 'Female', '1997-03-09', 'sarah2@yahoo.com');

-- 1.2 Primary Columns

-- alter table to add a primary key constraint:

ALTER TABLE people.person ADD CONSTRAINT pk_id  UNIQUE (id);

-- Let's insert some values: 

INSERT INTO people.person (
    id, name, gender, date_of_birth, email)
VALUES (5, 'layla', 'Female', '1970-01-10', 'layla@hotmail.com')


-- This script will rise an error due to
-- the primary key constraint applied to the
-- column id:
-- INSERT INTO people.person (
--    id, name, gender, date_of_birth, email)
--    VALUES (5, 'matt', 'Male', '1980-01-01', 'matt@hotmail.com');

INSERT INTO people.person (
    id, name, gender, date_of_birth, email)
VALUES (6, 'matt', 'Male', '1980-01-01', 'matt@hotmail.com')


-- 1.3 Check constraint

-- alter table to add a check constraint:

ALTER TABLE people.person ADD CONSTRAINT check_gender 
CHECK (gender = 'Female' OR gender = 'Male' OR gender = 'Other');


-- This script will rise an error due to
-- the check constraint applied to the
-- column gender:
-- INSERT INTO people.person (
--    id, name, gender, date_of_birth, email)
-- VALUES (7, 'david', 'Mate', '1990-01-01', 'david@google.com')


INSERT INTO people.person (
    id, name, gender, date_of_birth, email)
VALUES (7, 'david', 'Male', '1990-01-01', 'david@google.com');


-- This script will rise an error due to
-- the check constraint applied to the
-- column gender:
-- INSERT INTO people.person (
--    id, name, gender, date_of_birth, email)
-- VALUES (8, 'simon', 'male', '1990-01-01', 'simon @google.com')

--- 2. Import data

-- to inspect the sql database from your command line:

-- less /YOUR/PATH/TO/DATA/person_0.sql
-- vim  /YOUR/PATH/TO/DATA/person_0.sql
-- nvim /YOUR/PATH/TO/DATA/person_0.sql

-- 2.1 \i with psql

-- the following commands should be run inside psql not pgAdmin4
-- \c mydb
DROP TABLE people.person;
-- \i '/YOUR/PATH/TO/DATA/person_0.sql' 
-- \d people.person

-- 2.2 COPY FROM pgAdmin4

-- move the file to a directory that PostgreSQL can access
-- for example, if you are on mac, type in your command line:
-- cp /YOUR/PATH/TO/DATA/person_0.sql /tmp

-- NB ---
-- if you are on a Windows machine, you can load data
-- directly from your Desktop

COPY people.person(first_name, last_name, email, gender, dob) FROM 
'/PATH/TO/NEW/FOLDER/person_1.csv' DELIMITER ',' CSV HEADER;

-- 2.3 \copy with psql

-- the following commands should be run inside psql not pgAdmin4
-- \c mydb
-- \copy people.person(first_name, last_name, email, gender, dob) FROM '/PATH/TO/NEW/FOLDER/person_2.csv' DELIMITER ',' CSV HEADER;


--- 3. SQL - Basics

-- Select some columns

SELECT first_name FROM people.person;

SELECT first_name, id FROM people.person;

SELECT * FROM people.person;

-- Limit & OFFSET

SELECT * FROM people.person LIMIT 5;

SELECT * FROM people.person LIMIT 5 OFFSET 5;

-- SELECT FROM WHERE

SELECT * FROM people.person  WHERE gender = 'Female';

-- AND, OR, NOT

SELECT * FROM people.person  WHERE gender = 'Female' AND NOT email IS NULL;

SELECT * FROM people.person  WHERE gender = 'Male' AND NOT email IS NULL;

SELECT * FROM people.person  WHERE first_name = 'Stuart' OR first_name = 'Arnold';


--- 4. SQL - Basics, Part two


CREATE TABLE people.car (
    id bigserial PRIMARY KEY,
    car_make varchar(50),
    car_model varchar(50),
    car_year int,
    price numeric
);

CREATE TABLE people.location (
    id bigserial PRIMARY KEY,
    country varchar(50),
    city varchar(50),
    street_name varchar(50),
    street_number int,
    postal_code varchar(50)
);

-- I leave the import of data from location.csv and car.csv, see section 2
-- for guidance


-- DISTINCT

SELECT DISTINCT country FROM people.location;

SELECT DISTINCT country, city FROM people.location;

-- ORDER BY

SELECT DISTINCT country FROM people.location ORDER BY country DESC;

SELECT * FROM people.car ORDER BY car_year;

-- LIKE

SELECT * FROM people.person WHERE email LIKE '%amazon%';

SELECT * FROM people.person WHERE email LIKE '%google%';

SELECT * FROM people.person WHERE first_name LIKE 'R%';

SELECT * FROM people.person WHERE first_name LIKE 'r%'; -- the LIKE operator is case-sensitive

-- iLIKE

SELECT * FROM people.person WHERE first_name iLIKE 'r%'; 

-- BETWEEN

SELECT * FROM people.person WHERE dob BETWEEN '1999-01-01' AND '1999-12-31';

SELECT * FROM people.person WHERE dob BETWEEN '1999-01-01' AND '1999-06-30';

-- EXTRACT 

SELECT EXTRACT(YEAR FROM dob) FROM people.person; -- to extract the year

SELECT EXTRACT(MONTH FROM dob) FROM people.person; -- to extract the month

SELECT EXTRACT(DAY FROM dob) FROM people.person; -- to extract the day

-- Alias with columns

SELECT EXTRACT(YEAR FROM dob) AS dob_year FROM people.person;

SELECT *, EXTRACT(YEAR FROM dob) AS dob_year FROM people.person;

SELECT *, EXTRACT(YEAR FROM dob) AS dob_year, EXTRACT(MONTH FROM dob) AS dob_month FROM people.person;

SELECT *, EXTRACT(YEAR FROM dob) AS dob_year FROM people.person
WHERE EXTRACT(YEAR FROM dob) BETWEEN 1996 AND 2000;

--- 5. Aggregate Functions

CREATE TABLE people.aggregate (
    numbers int);

INSERT INTO people.aggregate (numbers)
VALUES (1),
(2),
(2),
(2),
(3),
(4);

-- Count

SELECT COUNT(numbers) FROM people.aggregate; --ALL

SELECT COUNT(DISTINCT numbers) FROM people.aggregate; --Distinct

-- SUM

SELECT SUM(numbers) FROM people.aggregate; --ALL

SELECT SUM(DISTINCT numbers) FROM people.aggregate; --Distinct

-- AVG

SELECT AVG(numbers) FROM people.aggregate; --ALL

SELECT AVG(DISTINCT numbers) FROM people.aggregate; --Distinct

-- ROUND

SELECT ROUND(AVG(DISTINCT numbers), 2) FROM people.aggregate;

-- MIN

SELECT MIN(numbers) FROM people.aggregate;

-- MAX

SELECT MAX(numbers) FROM people.aggregate;

--- 6. GROUP BY

-- Group by on a single column

SELECT car_make, COUNT(*) FROM people.car
GROUP BY car_make;

SELECT car_make, COUNT(*) FROM people.car
GROUP BY car_make ORDER BY COUNT(*) DESC;

SELECT car_make, COUNT(DISTINCT car_model) FROM people.car
GROUP BY car_make ORDER BY COUNT(DISTINCT car_model) DESC;

-- Group by on two columns

SELECT car_make, car_model, AVG(price) FROM people.car
GROUP BY car_make, car_model;

SELECT car_make, car_model, ROUND(AVG(price), 2) FROM people.car
GROUP BY car_make, car_model;

SELECT car_make, car_model, ROUND(AVG(price), 2) FROM people.car
GROUP BY car_make, car_model ORDER BY car_make, car_model;

SELECT car_make, car_model, MAX(price) FROM people.car
GROUP BY car_make, car_model ORDER BY car_make, car_model;

-- HAVING

SELECT car_make, car_model, AVG(price) FROM people.car
GROUP BY car_make, car_model HAVING AVG(price) < 100000;

SELECT car_make, car_model, ROUND(AVG(price), 2) FROM people.car
GROUP BY car_make, car_model HAVING AVG(price) < 100000;

SELECT car_make, car_model, ROUND(AVG(price), 2) FROM people.car
GROUP BY car_make, car_model HAVING AVG(price) < 100000
ORDER BY car_make, car_model;

-- HAVING vs WHERE

SELECT car_make, COUNT(*) FROM people.car WHERE car_year > 2000
GROUP BY car_make;

SELECT car_make, COUNT(*) FROM people.car WHERE car_year > 2000
GROUP BY car_make HAVING COUNT(*) > 100;

SELECT car_make, COUNT(*) FROM people.car WHERE car_year > 2000
GROUP BY car_make HAVING COUNT(*) BETWEEN 50 AND 100;
