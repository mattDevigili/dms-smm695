/*
Tutorial _1: PostgreSQL JSON data type

The _1.json contains 10 json documents from tate data, that we will import
into PostgreSQL and then work with them. For this tutorial, I'm working
within psql (you can replicate everything within pgAdmin4).

Topics:
0. Set up
1. Basic JSON queries
2. JSON functions
3. JSON path query
*/

-- ###################
-- #### 0. SET UP ####
-- ###################

-- Let's create a database and a table:
CREATE DATABASE t_1;

\c t_1;

CREATE TABLE raw_json (artists json);

-- Let's now load data:
\copy raw_json (artists) FROM '/YOUR/PATH/TO/_1.json';

-- Let's inspect all documents:
SELECT * FROM raw_json;

-- ###############################
-- #### 1. Basic JSON queries ####
-- ###############################

/* To query json fields, we have two methods:
 1. -> Get JSON object field by key
 2. ->> Get JSON object field as text

Structure:
 SELECT column_name -> 'field_name' FROM table_name; */

SELECT artists->'mda' AS name FROM raw_json;

/* OUTPUT:
              name
----------------------------------
 "Reid, Sir Norman"
 "Rhodes, Lis"
 "Rhodes, Carol"
 "Rombaux, Egide"
 "Reid, Clunie"
 "Reynolds-Stephens, Sir William"
 "Rickey, George"
 "Ridley, Matthew White"
 "Reynolds, Sir Joshua"
 "Ruff, Thomas"
(10 rows)  */


SELECT artists->>'mda' AS name FROM raw_json;

/* OUTPUT:
              name
--------------------------------
 Reid, Sir Norman
 Rhodes, Lis
 Rhodes, Carol
 Rombaux, Egide
 Reid, Clunie
 Reynolds-Stephens, Sir William
 Rickey, George
 Ridley, Matthew White
 Reynolds, Sir Joshua
 Ruff, Thomas
(10 rows) */

-- Let's query a field with a nested JSON document:
SELECT artists->'birth' AS birth FROM raw_json;

/* OUTPUT
                                                                            birth
-------------------------------------------------------------------------------------------------------------------------------------------------------------
 {"place": {"name": "Edinburgh, United Kingdom", "placeName": "Edinburgh", "placeType": "inhabited_place"}, "time": {"startYear": 1915}}
 {"place": {"name": "London, United Kingdom", "placeName": "London", "placeType": "inhabited_place"}, "time": {"startYear": 1942}}
 {"place": {"name": "Edinburgh, United Kingdom", "placeName": "Edinburgh", "placeType": "inhabited_place"}, "time": {"startYear": 1959}}
 {"place": {"name": "Belgiu00eb", "placeName": "Belgiu00eb", "placeType": "nation"}, "time": {"startYear": 1865}}
 {"place": {"name": "Pembury, United Kingdom", "placeName": "Pembury", "placeType": "inhabited_place"}, "time": {"startYear": 1971}}
 {"place": {"name": "Detroit, United States", "placeName": "Detroit", "placeType": "inhabited_place"}, "time": {"startYear": 1862}}
 {"place": {"name": "South Bend, United States", "placeName": "South Bend", "placeType": "inhabited_place"}, "time": {"startYear": 1907}}
 {"place": {"name": "Newcastle upon Tyne, United Kingdom", "placeName": "Newcastle upon Tyne", "placeType": "inhabited_place"}, "time": {"startYear": 1837}}
 {"place": {"name": "Plympton, United Kingdom", "placeName": "Plympton", "placeType": "inhabited_place"}, "time": {"startYear": 1723}}
 {"place": {"name": "Zell am Harmersbach, Deutschland", "placeName": "Zell am Harmersbach", "placeType": "inhabited_place"}, "time": {"startYear": 1958}}
(10 rows) */

-- Let's now get the birth year:
SELECT artists->'birth'->'time'->>'startYear' as dob FROM raw_json;

/* OUTPUT:
dob
------
 1915
 1942
 1959
 1865
 1971
 1862
 1907
 1837
 1723
 1958
(10 rows) */

-- Let's order years:
SELECT artists->'birth'->'time'->>'startYear' as dob 
FROM raw_json
ORDER BY CAST(artists->'birth'->'time'->>'startYear' AS int) DESC;

/* OUTPUT
 dob
------
 1971
 1959
 1958
 1942
 1915
 1907
 1865
 1862
 1837
 1723
(10 rows) */

-- Let's select only artists with 'dob' BETWEEN 1940 AND 1960
SELECT artists->>'mda' AS name, artists->'birth'->'time'->>'startYear' as dob
FROM raw_json 
WHERE CAST(artists->'birth'->'time'->>'startYear' AS int) BETWEEN 1940 AND 1960;

/* OUTPUT:
     name      | dob
---------------+------
 Rhodes, Lis   | 1942
 Rhodes, Carol | 1959
 Ruff, Thomas  | 1958
(3 rows) */

-- Let's perform an aggregation:
SELECT artists->>'gender' AS gender, COUNT(*) , ROUND(AVG(CAST(artists->'birth'->'time'->>'startYear' AS int)), 2) AS avg_dob
FROM raw_json
GROUP BY  artists->>'gender';

/* OUTPUT:
 gender | count | avg_dob
--------+-------+---------
 Female |     3 | 1957.33
 Male   |     7 | 1866.71
(2 rows) */

-- ###########################
-- #### 2. JSON FUNCTIONS ####
-- ###########################

-- Let's get all keys:
SELECT DISTINCT(json_object_keys(artists)) FROM raw_json;

/* OUTPUT
 json_object_keys
------------------
 death
 url
 gender
 birth
 mda
 totalWorks
 movNames
 activePlaces
 movements
 activePlaceCount
(10 rows) */

SELECT DISTINCT(json_object_keys(artists->'birth')) AS "sub-fields" FROM raw_json;

/* OUTPUT:
sub-fields
------------
 place
 time
(2 rows) */

--Let's get data type for a field:
SELECT DISTINCT(json_typeof(artists->'mda')) AS mda_type FROM raw_json;

/* OUTPUT:
 mda_type
----------
 string
(1 row) */

-- Let's pretty print the first document:
SELECT jsonb_pretty(CAST(artists AS jsonb)) FROM raw_json LIMIT 1;

/* OUTPUT:
                             jsonb_pretty
-----------------------------------------------------------------------
 {                                                                    +
     "mda": "Reid, Sir Norman",                                       +
     "url": "http://www.tate.org.uk/art/artists/sir-norman-reid-1824",+
     "birth": {                                                       +
         "time": {                                                    +
             "startYear": 1915                                        +
         },                                                           +
         "place": {                                                   +
             "name": "Edinburgh, United Kingdom",                     +
             "placeName": "Edinburgh",                                +
             "placeType": "inhabited_place"                           +
         }                                                            +
     },                                                               +
     "death": {                                                       +
         "time": {                                                    +
             "startYear": 2007                                        +
         },                                                           +
         "place": {                                                   +
             "name": "London, United Kingdom",                        +
             "placeName": "London",                                   +
             "placeType": "inhabited_place"                           +
         }                                                            +
     },                                                               +
     "gender": "Male",                                                +
     "movNames": [                                                    +
     ],                                                               +
     "movements": [                                                   +
     ],                                                               +
     "totalWorks": 3,                                                 +
     "activePlaceCount": 0                                            +
 }
(1 row) */

-- Let's output data in a table:
SELECT x.* FROM raw_json, json_to_record(artists) AS x(mda text, gender text, "activePlaceCount" int, "totalWorks" int, "movNames" text[]);

/* OUTPUT
             mda               | gender | activePlaceCount | totalWorks |             movNames
--------------------------------+--------+------------------+------------+----------------------------------
 Reid, Sir Norman               | Male   |                0 |          3 | {}
 Rhodes, Lis                    | Female |                1 |          1 | {}
 Rhodes, Carol                  | Female |                0 |          2 | {}
 Rombaux, Egide                 | Male   |                0 |          1 | {}
 Reid, Clunie                   | Female |                0 |          1 | {}
 Reynolds-Stephens, Sir William | Male   |                0 |          1 | {}
 Rickey, George                 | Male   |                0 |          2 | {}
 Ridley, Matthew White          | Male   |                0 |          1 | {}
 Reynolds, Sir Joshua           | Male   |                0 |         44 | {"Fancy Picture","Grand Manner"}
 Ruff, Thomas                   | Male   |                0 |          5 | {}
(10 rows) */



-- ############################
-- #### 3. JSON PATH QUERY ####
-- ############################

-- Let's change data type to jsonb:
ALTER TABLE raw_json
ALTER COLUMN artists SET DATA TYPE jsonb
USING artists::jsonb;

-- Let's use JSON path to query data:
SELECT jsonb_path_query(artists, '$.mda') AS name FROM raw_json;

/* OUTPUT:
               name
----------------------------------
 "Reid, Sir Norman"
 "Rhodes, Lis"
 "Rhodes, Carol"
 "Rombaux, Egide"
 "Reid, Clunie"
 "Reynolds-Stephens, Sir William"
 "Rickey, George"
 "Ridley, Matthew White"
 "Reynolds, Sir Joshua"
 "Ruff, Thomas"
(10 rows) */

SELECT jsonb_path_query(artists, '$.birth.place.name') AS Location FROM raw_json;

/* OUTPUT:
               location
---------------------------------------
 "Edinburgh, United Kingdom"
 "London, United Kingdom"
 "Edinburgh, United Kingdom"
 "Belgiu00eb"
 "Pembury, United Kingdom"
 "Detroit, United States"
 "South Bend, United States"
 "Newcastle upon Tyne, United Kingdom"
 "Plympton, United Kingdom"
 "Zell am Harmersbach, Deutschland"
(10 rows) */

-- Let's query with a condition (use ? to pass a condition):
SELECT jsonb_path_query(artists, '$.birth.time.startYear ? (@>1950)') AS size FROM raw_json;

/* OUTPUT:
 size
------
 1959
 1971
 1958
(3 rows) */


-- Let's get the size of an array field:
SELECT jsonb_path_query(artists, '$.movNames.size()') AS size FROM raw_json;

/* OUTPUT:
 size
------
 0
 0
 0
 0
 0
 0
 0
 0
 2
 0
(10 rows) */

-- Let's query an array field:
SELECT jsonb_path_query(artists, '$.movNames[*]') AS name FROM raw_json;

/* OUTPUT:
     name
-----------------
 "Fancy Picture"
 "Grand Manner"
(2 rows) */

SELECT jsonb_path_query(artists, '$.movNames[0]') AS name FROM raw_json;

/* OUTPUT:
    name
-----------------
 "Fancy Picture"
(1 row) */

SELECT jsonb_path_query(artists, '$.movNames[1]') AS name FROM raw_json;

/* OUTPUT:
    name
----------------
 "Grand Manner"
(1 row) */