------------------------
----------------
-- 0 ------- CREATE AND LOAD
----------------
------------------------

/*
You can download the target csv via:

wget "https://raw.githubusercontent.com/tategallery/collection/master/artwork_data.csv"

*/

-- create a database and connect
CREATE DATABASE tate;

\c tate

-- The following structure will rise an error:
CREATE TABLE artworks (
    id bigint,
    accession_number text,
    artist text,
    artistRole text,
    artistId int,
    title text,
    dateText text,
    medium text,
    creditLine text,
    year numeric,
    acquisitionYear numeric,
    dimensions text,
    width text,
    height text,
    depth numeric,
    units text,
    inscription text,
    thumbnailCopyright text,
    thumbnailUrl text,
    url text);

-- This will rise an error:
\copy artworks FROM '/tmp/artwork_data.csv' DELIMITER ',' CSV HEADER;

-- Mixed data type can create problems, let's use text for the column year:
ALTER TABLE artworks ALTER COLUMN year SET DATA TYPE text;

\d artworks

\copy artworks FROM '/tmp/artwork_data.csv' DELIMITER ',' CSV HEADER;

-- Let's clean the year column:
SELECT DISTINCT year FROM artworks ORDER BY year DESC;

UPDATE artworks
SET year = null
WHERE
	year = 'no date';

UPDATE artworks
SET year = 1997
WHERE
	year = 'c.1997-9';

ALTER TABLE artworks ALTER COLUMN year SET DATA TYPE int USING year::integer;

-- Let's spot some other problems within data
WITH subquery AS
(SELECT DISTINCT creditline, acquisitionyear FROM artworks)
 SELECT creditline, COUNT(*) FROM subquery GROUP BY creditline ORDER BY COUNT(*) DESC;

SELECT DISTINCT creditline, acquisitionyear FROM artworks WHERE creditline = 'Purchased 2001';

------------------------
----------------
-- 1 ------- CREATE TABLE ARTISTS
----------------
------------------------

-- Create a table for artists:
CREATE TABLE artists AS SELECT DISTINCT artistID, artist FROM artworks ORDER BY artistID;

SELECT * FROM artists ;

-- Split artist name
ALTER TABLE artists 
ADD COLUMN last_name text,
ADD COLUMN title_name text,
ADD COLUMN first_name text,
ADD COLUMN second_name text;

-- Insert data
WITH split_query AS (
SELECT artist, split_part(artist::text, ',', 1) AS last_name,
split_part(split_part(artist, ', ', 2), ' ', 1) AS title,
split_part(split_part(artist, ', ', 2), ' ', 2) AS first_name,
split_part(split_part(artist, ', ', 2), ' ', 3) AS second_name
FROM artists
WHERE split_part(split_part(artist, ', ', 2), ' ', 1) ILIKE 'sir%'
OR split_part(split_part(artist, ', ', 2), ' ', 1) ILIKE 'obe%'
OR split_part(split_part(artist, ', ', 2), ' ', 1) ILIKE 'rev.%'
OR split_part(split_part(artist, ', ', 2), ' ', 1) ILIKE 'prof.%'
OR split_part(split_part(artist, ', ', 2), ' ', 1) ILIKE 'dr.%'
)
UPDATE artists
SET 
last_name  = split_query.last_name,
title_name  = split_query.title,
first_name = split_query.first_name,
second_name = split_query.second_name
FROM split_query
WHERE artists.artist = split_query.artist;


WITH split_query AS (
SELECT artist, split_part(artist::text, ',', 1) AS last_name,
split_part(split_part(artist, ', ', 2), ' ', 1) AS first_name,
split_part(split_part(artist, ', ', 2), ' ', 2) AS second_name
FROM artists
WHERE split_part(split_part(artist, ', ', 2), ' ', 1) NOT ILIKE 'sir%'
AND split_part(split_part(artist, ', ', 2), ' ', 1) NOT ILIKE 'obe%'
AND split_part(split_part(artist, ', ', 2), ' ', 1) NOT ILIKE 'rev.%'
AND split_part(split_part(artist, ', ', 2), ' ', 1) NOT ILIKE 'prof.%'
AND split_part(split_part(artist, ', ', 2), ' ', 1) NOT ILIKE 'dr.%'
)
UPDATE artists
SET 
last_name  = split_query.last_name,
first_name = split_query.first_name,
second_name = split_query.second_name
FROM split_query
WHERE artists.artist = split_query.artist;


-- Delete artist column from artworks:
ALTER TABLE artworks DROP COLUMN artist;

-- Let's inspect some data
SELECT * FROM artists;
SELECT * FROM artists WHERE title_name IS NOT NULL;
SELECT title_name, COUNT(*) as n
FROM artists GROUP BY title_name ORDER BY n;

------------------------
----------------
-- 2 ------- CREATE TABLE ROLES
----------------
------------------------


-- Create a table for artists' roles:
CREATE TABLE roles AS SELECT DISTINCT artistRole FROM artworks ORDER BY artistRole;

ALTER TABLE roles ADD COLUMN role_id serial;

-- Create a role_id column in artworks and pass values:
ALTER TABLE artworks ADD COLUMN role_id int;

UPDATE artworks 
SET role_id = roles.role_id 
FROM roles 
WHERE artworks.artistRole = roles.artistRole;

ALTER TABLE artworks DROP COLUMN artistRole;

SELECT * FROM artworks;

------------------------
-----------------
-- 3 ------- CREATE TABLES CHARACT. and MEDIUM 
-----------------
------------------------


-- To handle problems with null values
UPDATE artworks
SET medium = 'Not known'
WHERE
	medium IS NULL;

UPDATE artworks
SET dimensions = 'Not known'
WHERE
	dimensions IS NULL;

-- Create a table to store medium, dimensions, width, height, units depth
CREATE TABLE characteristics AS SELECT DISTINCT medium, dimensions, width, height, units, depth FROM artworks ORDER BY medium;

ALTER TABLE characteristics ADD COLUMN char_id serial;

SELECT * FROM characteristics;

-- Create a char_id column in artworks and pass values:
ALTER TABLE artworks ADD COLUMN char_id int;

UPDATE artworks 
SET char_id = characteristics.char_id 
FROM  characteristics
WHERE artworks.medium = characteristics.medium AND artworks.dimensions = characteristics.dimensions;

ALTER TABLE artworks 
DROP COLUMN medium,
DROP COLUMN dimensions, 
DROP COLUMN width, 
DROP COLUMN height, 
DROP COLUMN units,
DROP COLUMN depth;

-- Create a table to store medium values
CREATE TABLE medium AS SELECT DISTINCT medium FROM characteristics;

ALTER TABLE medium ADD COLUMN medium_id serial;

-- Create a medium_id column in characteristics
ALTER TABLE characteristics ADD COLUMN medium_id int;

UPDATE characteristics
SET medium_id = medium.medium_id 
FROM  medium
WHERE characteristics.medium = medium.medium;

ALTER TABLE characteristics 
DROP COLUMN medium;

-- Let's inspect what we have
SELECT * FROM medium;
SELECT * FROM characteristics;

------------------------
----------------
-- 4 ------- CREATE TABLE CREDIT
----------------
------------------------


-- To handle problems with null values
UPDATE artworks
SET creditline = 'Not known'
WHERE
	creditline IS NULL;

UPDATE artworks
SET acquisitionyear = 9999
WHERE
	acquisitionyear IS NULL;

-- Create a new table for credit
CREATE TABLE credit AS SELECT DISTINCT creditline, acquisitionyear FROM artworks;

ALTER TABLE credit ADD COLUMN credit_id serial;

-- Create a credit_id column in artworks and pass values:
ALTER TABLE artworks ADD COLUMN credit_id int;

UPDATE artworks 
SET credit_id = credit.credit_id
FROM credit
WHERE artworks.creditline = credit.creditline AND artworks.acquisitionyear = credit.acquisitionyear;

ALTER TABLE artworks 
DROP COLUMN creditline,
DROP COLUMN acquisitionyear;

------------------------
----------------
-- 5 ------- CREATE TABLE TCPR
----------------
------------------------


-- To handle problems with null values
UPDATE artworks
SET thumbnailcopyright = 'Not known'
WHERE
	thumbnailcopyright IS NULL;

-- Create a new table for thumbnailcopyright
CREATE TABLE tcpr AS SELECT DISTINCT thumbnailcopyright FROM artworks;

ALTER TABLE tcpr ADD COLUMN tcpr_id serial;

-- Create a tcpr_id column in artworks and pass values:
ALTER TABLE artworks ADD COLUMN tcpr_id int;

UPDATE artworks 
SET tcpr_id = tcpr.tcpr_id
FROM tcpr
WHERE artworks.thumbnailcopyright = tcpr.thumbnailcopyright;

ALTER TABLE artworks DROP COLUMN thumbnailcopyright;

------------------------
----------------
-- 6 ------- CREATE TABLE INSCRIPTION
----------------
------------------------

-- Create a table for inscription
CREATE TABLE inscription (inscr_id int, inscription text);

INSERT INTO inscription 
VALUES (0, 'no inscription'),
(1, 'date incribed');

ALTER TABLE artworks ADD COLUMN inscr_id int;

UPDATE artworks 
SET inscr_id = 0
WHERE inscription IS NULL;

UPDATE artworks 
SET inscr_id = 1
WHERE inscription IS NOT NULL;

ALTER TABLE artworks DROP COLUMN inscription;

------------------------
----------------
-- 7 ------- CREATE TABLE ARTWORKS_ID
----------------
------------------------

-- Let's create the joining table and clean artworks
CREATE TABLE artworks_id AS SELECT accession_number, artistid, role_id, char_id, credit_id, tcpr_id, inscr_id FROM artworks;

ALTER TABLE artworks
DROP COLUMN id,
DROP COLUMN artistid, 
DROP COLUMN role_id, 
DROP COLUMN char_id, 
DROP COLUMN credit_id, 
DROP COLUMN tcpr_id, 
DROP COLUMN inscr_id;

------------------------
----------------
-- 8 ------- SET PRIMARY KEYS
----------------
------------------------

ALTER TABLE artists ADD CONSTRAINT artistid_pk PRIMARY KEY (artistID);

ALTER TABLE artworks ADD CONSTRAINT accnumb_pk PRIMARY KEY (accession_number);

ALTER TABLE characteristics ADD CONSTRAINT char_pk PRIMARY KEY (char_id);

ALTER TABLE credit ADD CONSTRAINT credit_pk PRIMARY KEY (credit_id);

ALTER TABLE inscription ADD CONSTRAINT inscr_pk PRIMARY KEY (inscr_id);

ALTER TABLE medium ADD CONSTRAINT medium_pk PRIMARY KEY (medium_id);

ALTER TABLE roles ADD CONSTRAINT roleid_pk PRIMARY KEY (role_id);

ALTER TABLE tcpr ADD CONSTRAINT tcpr_pk PRIMARY KEY (tcpr_id);

------------------------
----------------
-- 9 ------- SET FOREIGN KEYS
----------------
------------------------

ALTER TABLE artworks_id ADD CONSTRAINT accnumb_fk FOREIGN KEY (accession_number) REFERENCES artworks (accession_number);

ALTER TABLE artworks_id ADD CONSTRAINT artist_fk FOREIGN KEY (artistID) REFERENCES artists (artistID);

ALTER TABLE artworks_id ADD CONSTRAINT char_fk FOREIGN KEY (char_id) REFERENCES characteristics (char_id);

ALTER TABLE artworks_id ADD CONSTRAINT credit_fk FOREIGN KEY (credit_id) REFERENCES credit (credit_id);

ALTER TABLE artworks_id ADD CONSTRAINT inscr_fk FOREIGN KEY (inscr_id) REFERENCES inscription (inscr_id);

ALTER TABLE artworks_id ADD CONSTRAINT role_fk FOREIGN KEY (role_id) REFERENCES roles (role_id);

ALTER TABLE artworks_id ADD CONSTRAINT tcpr_fk FOREIGN KEY (tcpr_id) REFERENCES tcpr (tcpr_id);

ALTER TABLE characteristics ADD CONSTRAINT medium_fk FOREIGN KEY (medium_id) REFERENCES medium (medium_id);


------------------------
----------------
-- 10 ------- Indexing
----------------
------------------------

/* 
Check tutorial _0 folder if you want further examples/insights on indexes
*/

-- Example query
EXPLAIN ANALYSE
SELECT * FROM artworks WHERE year=1828;

-- Let's see an example
CREATE INDEX year_artworks_idx ON artworks(year);

-- Let's see if we have any improvement
EXPLAIN ANALYSE
SELECT * FROM artworks WHERE year=1828;

-- Pay attention to:
EXPLAIN ANALYSE
SELECT * FROM artworks WHERE accession_number='A0001';

------------------------
----------------
-- 10 ------- CREATE SOME VIEWs
----------------
------------------------
/*
"CREATE VIEW defines a view of a query. The view is not physically materialized. 
Instead, the query is run every time the view is referenced in a query".
(PostgreSQL, 14)
*/

-- Joining artist and creditline:
CREATE VIEW artist_creditline AS
SELECT DISTINCT artist, creditline FROM artworks_id ai
JOIN artists a ON ai.artistid = a.artistid
JOIN credit c ON c.credit_id = ai.credit_id
ORDER BY artist;

-- Re-join the table:
CREATE VIEW tate_original AS
SELECT ai.accession_number, title, artist, artistrole, medium, datetext, year, creditline, acquisitionyear, 
dimensions, width, height, units, depth, inscription, thumbnailcopyright, 
thumbnailurl, url
FROM artworks_id ai
JOIN artists ats ON ats.artistid = ai.artistid
JOIN artworks aws ON aws.accession_number = ai.accession_number
JOIN characteristics cht ON cht.char_id = ai.char_id
JOIN medium med ON med.medium_id = cht.medium_id
JOIN credit cl ON cl.credit_id = ai.credit_id
JOIN inscription ins ON ins.inscr_id = ai.inscr_id
JOIN roles rl ON rl.role_id = ai.role_id
JOIN tcpr ON tcpr.tcpr_id = ai.tcpr_id
ORDER BY accession_number;

------------------------
----------------
-- 11 ------- TEMPORARY TABLE
----------------
------------------------

/*
If specified, the table is created as a temporary table. Temporary tables are automatically 
dropped at the end of a session, or optionally at the end of the current transaction".
*/

-- Create a temporary table and pass data
CREATE TEMP TABLE temp_artw (
	id numeric,
	accession_number text,
    artist text,
    artistRole text,
    artistId int,
    title text,
	dateText text,
    medium text,
    creditLine text,
    year text,
    acquisitionYear numeric,
    dimensions text,
    width text,
    height text,
    depth numeric,
    units text,
    inscription text,
    thumbnailCopyright text,
    thumbnailUrl text,
    url text
);

COPY temp_artw FROM '/tmp/artwork_data.csv' CSV DELIMITER ',' HEADER;

-- let's inspect the content
SELECT * FROM temp_artw;