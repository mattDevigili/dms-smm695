/*
Tutorial _2: PostgreSQL Array data type

The _2.csv contains 112 observations from tate data, that we will import
into PostgreSQL and then work with them. For this tutorial, I'm working
within psql (you can replicate everything within pgAdmin4).

Topics:
0. Set up
1. Basic array queries
2. Array functions
3. Miscellaneous
*/

-- ###################
-- #### 0. SET UP ####
-- ###################


-- Let's create a database and a table:
CREATE DATABASE t_2;
-- connect to t_2
\c t_2;

/* You can create an array field from any data type (also user generated one).
For example you can have text[], int[], numeric[] and so on. We are now going
    to work with text[], but you can replicate similar tasks with other data types
 */

-- Let's create a new table
CREATE TABLE table_array (
    id serial PRIMARY KEY,
    gender text,
    mda text,
    movNames text[]
);

-- Let's now load data:
\copy table_array(gender, mda, movNames) FROM '/PATH/TO/YOUR/_2.csv' CSV HEADER DELIMITER';';


-- Let's inspect some documents:
SELECT * FROM table_array LIMIT 10;

/* OUTPUT:
 id | gender |          mda           |                                           movnames
----+--------+------------------------+-----------------------------------------------------------------------------------------------
  1 | Female | Riley, Bridget         | {"Optical Art"}
  2 | Male   | Rubens, Peter Paul     | {Baroque,"Early Stuart"}
  3 | Male   | Roussel, Théodore      | {"Aesthetic Movement","New English Art Club"}
  4 | Male   | Ruscha, Edward         | {"Conceptual Art","Pop Art"}
  5 | Male   | Nicol, Erskine         | {Victorian/Genre}
  6 | Male   | Nauman, Bruce          | {"Body Art","Conceptual Art"}
  7 | Female | Guerrilla Girls        | {"Feminist Art"}
  8 | Male   | Graham, Dan            | {"Conceptual Art"}
  9 | Male   | Gabo, Naum             | {Abstraction-Création,"British Constructivism",Constructivism,"Kinetic Art","St Ives School"}
 10 | Male   | Gaudier-Brzeska, Henri | {"Direct Carving","London Group",Vorticism}
(10 rows) */

-- #############################
-- #### 1. Basic Array query ####
-- #############################

-- Let's say that we want to get the movement name at position 1:
SELECT gender, mda, movNames[1] FROM table_array LIMIT 10; -- PostgreSQL is not zero-based

/* OUTCOME:
 gender |          mda           |       movnames
--------+------------------------+----------------------
 Female | Riley, Bridget         | Optical Art
 Male   | Rubens, Peter Paul     | Baroque
 Male   | Roussel, Théodore      | Aesthetic Movement
 Male   | Ruscha, Edward         | Conceptual Art
 Male   | Nicol, Erskine         | Victorian/Genre
 Male   | Nauman, Bruce          | Body Art
 Female | Guerrilla Girls        | Feminist Art
 Male   | Graham, Dan            | Conceptual Art
 Male   | Gabo, Naum             | Abstraction-Création
 Male   | Gaudier-Brzeska, Henri | Direct Carving
(10 rows) */

-- Let's now query for movement name at position 2:
SELECT gender, mda, movNames[2] FROM table_array LIMIT 10;

/* OUTCOME:
 gender |          mda           |        movnames
--------+------------------------+------------------------
 Female | Riley, Bridget         |
 Male   | Rubens, Peter Paul     | Early Stuart
 Male   | Roussel, Théodore      | New English Art Club
 Male   | Ruscha, Edward         | Pop Art
 Male   | Nicol, Erskine         |
 Male   | Nauman, Bruce          | Conceptual Art
 Female | Guerrilla Girls        |
 Male   | Graham, Dan            |
 Male   | Gabo, Naum             | British Constructivism
 Male   | Gaudier-Brzeska, Henri | London Group
(10 rows) */

-- Let's apply some filtering on the first element:
SELECT *  FROM table_array WHERE movNames[1] iLIKE '%art%' LIMIT 10;

/*OUTPUT:
 gender |       mda       |                          movnames
--------+-----------------+------------------------------------------------------------
 Female | Riley, Bridget  | {"Optical Art"}
 Male   | Ruscha, Edward  | {"Conceptual Art","Pop Art"}
 Male   | Nauman, Bruce   | {"Body Art","Conceptual Art"}
 Female | Guerrilla Girls | {"Feminist Art"}
 Male   | Graham, Dan     | {"Conceptual Art"}
 Male   | Toren, Amikam   | {"Conceptual Art"}
 Male   | Siberechts, Jan | {"Later Stuart","Netherlands-trained, working in Britain"}
 Male   | Almond, Darren  | {"Young British Artists (YBA)"}
 Male   | Fabro, Luciano  | {"Arte Povera","Conceptual Art"}
 Male   | Olson, Eric     | {"Optical Art"}
(10 rows) */

-- Let's apply matching on any element:
SELECT * FROM table_array WHERE 'Conceptual Art' = ANY (movNames);

/* OUTPUT:
 id | gender |      mda       |             movnames
----+--------+----------------+-----------------------------------
  4 | Male   | Ruscha, Edward | {"Conceptual Art","Pop Art"}
  6 | Male   | Nauman, Bruce  | {"Body Art","Conceptual Art"}
  8 | Male   | Graham, Dan    | {"Conceptual Art"}
 19 | Male   | Toren, Amikam  | {"Conceptual Art"}
 32 | Male   | Fabro, Luciano | {"Arte Povera","Conceptual Art"}
 51 | Male   | Haacke, Hans   | {"Conceptual Art"}
 65 | Female | Calle, Sophie  | {"Conceptual Art"}
 94 | Female | Kelly, Mary    | {"Conceptual Art","Feminist Art"}
(8 rows) */

-- Let's apply matching on all elements:
SELECT * FROM table_array WHERE 'Conceptual Art' = ALL (movNames);

/* OUTPUT
 id | gender |      mda      |      movnames
----+--------+---------------+--------------------
  8 | Male   | Graham, Dan   | {"Conceptual Art"}
 19 | Male   | Toren, Amikam | {"Conceptual Art"}
 51 | Male   | Haacke, Hans  | {"Conceptual Art"}
 65 | Female | Calle, Sophie | {"Conceptual Art"}
(4 rows) */

-- Let's GROUP on the basis of the whole array:
SELECT movNames, COUNT(*) FROM table_array GROUP BY movNames ORDER BY COUNT(*) DESC LIMIT 10;

/* OUTCOME:
                                                     movnames                                                      | count
-------------------------------------------------------------------------------------------------------------------+-------
 {Victorian/Genre}                                                                                                 |     5
 {Neo-Classicism}                                                                                                  |     5
 {Surrealism}                                                                                                      |     5
 {"Young British Artists (YBA)"}                                                                                   |     4
 {"Conceptual Art"}                                                                                                |     4
 {Impressionism}                                                                                                   |     3
 {"Arte Povera"}                                                                                                   |     3
 {"Abstract Expressionism"}                                                                                        |     3
 {Baroque,"Civil War and Commonwealth",Court,"Later Stuart","Netherlands-trained, working in Britain",Restoration} |     2
 {Romanticism}                                                                                                     |     2
(10 rows) */

-- Let's GROUP on the basis of a single element:
SELECT movNames[1], COUNT(*) FROM table_array GROUP BY movNames[1] ORDER BY COUNT(*) DESC LIMIT 10;

/* OUTCOME:
         movnames           | count
-----------------------------+-------
 Conceptual Art              |     6
 Victorian/Genre             |     5
 Surrealism                  |     5
 Baroque                     |     5
 Arte Povera                 |     5
 Neo-Classicism              |     5
 Young British Artists (YBA) |     4
 Cubism                      |     4
 Abstract Expressionism      |     3
 Camden Town Group           |     3
(10 rows) */

-- ############################
-- #### 2. ARRAY FUNCTIONS ####
-- ############################

-- Let's ask the array size:
SELECT *, array_length(movNames, 1) AS Count FROM table_array ORDER BY Count DESC LIMIT 10;

/* OUTCOME:
 id  | gender |            mda            |                                                     movnames                                                      | count
-----+--------+---------------------------+-------------------------------------------------------------------------------------------------------------------+-------
 100 | Male   | Lely, Sir Peter           | {Baroque,"Civil War and Commonwealth",Court,"Later Stuart","Netherlands-trained, working in Britain",Restoration} |     6
  24 | Male   | Soest, Gilbert            | {Baroque,"Civil War and Commonwealth",Court,"Later Stuart","Netherlands-trained, working in Britain",Restoration} |     6
   9 | Male   | Gabo, Naum                | {Abstraction-Création,"British Constructivism",Constructivism,"Kinetic Art","St Ives School"}                     |     5
  23 | Male   | Schwitters, Kurt          | {Constructivism,Dada,Expressionism,Merz}                                                                          |     4
  15 | Male   | Gennari, Benedetto        | {Court,"Italian-trained, working in Britain","Later Stuart"}                                                      |     3
  54 | Male   | Mondrian, Piet            | {Cubism,"De Stijl",Neo-Plasticism}                                                                                |     3
  56 | Male   | Mytens, Daniel, the Elder | {Court,"Early Stuart","Netherlands-trained, working in Britain"}                                                  |     3
  10 | Male   | Gaudier-Brzeska, Henri    | {"Direct Carving","London Group",Vorticism}                                                                       |     3
  13 | Male   | Gheeraerts, Marcus, II    | {Court,"Early Stuart",Tudor}                                                                                      |     3
  14 | Male   | Gainsborough, Thomas      | {"Fancy Picture",Picturesque,Rococo}                                                                              |     3
(10 rows) */

-- Let's check the position of the element 'Conceptual Art':
SELECT *, array_position(movNames, 'Conceptual Art') AS Position FROM table_array LIMIT 10;

/* OUTCOME:
 id | gender |          mda           |                                           movnames                                            | position
----+--------+------------------------+-----------------------------------------------------------------------------------------------+----------
  1 | Female | Riley, Bridget         | {"Optical Art"}                                                                               |
  2 | Male   | Rubens, Peter Paul     | {Baroque,"Early Stuart"}                                                                      |
  3 | Male   | Roussel, Théodore      | {"Aesthetic Movement","New English Art Club"}                                                 |
  4 | Male   | Ruscha, Edward         | {"Conceptual Art","Pop Art"}                                                                  |        1
  5 | Male   | Nicol, Erskine         | {Victorian/Genre}                                                                             |
  6 | Male   | Nauman, Bruce          | {"Body Art","Conceptual Art"}                                                                 |        2
  7 | Female | Guerrilla Girls        | {"Feminist Art"}                                                                              |
  8 | Male   | Graham, Dan            | {"Conceptual Art"}                                                                            |        1
  9 | Male   | Gabo, Naum             | {Abstraction-Création,"British Constructivism",Constructivism,"Kinetic Art","St Ives School"} |
 10 | Male   | Gaudier-Brzeska, Henri | {"Direct Carving","London Group",Vorticism}                                                   |
(10 rows) */

-- Let's unnest the array:
SELECT gender, mda, unnest(movNames) FROM table_array LIMIT 10;

/* OUTCOME:
 gender |        mda         |        unnest
--------+--------------------+----------------------
 Female | Riley, Bridget     | Optical Art
 Male   | Rubens, Peter Paul | Baroque
 Male   | Rubens, Peter Paul | Early Stuart
 Male   | Roussel, Théodore  | Aesthetic Movement
 Male   | Roussel, Théodore  | New English Art Club
 Male   | Ruscha, Edward     | Conceptual Art
 Male   | Ruscha, Edward     | Pop Art
 Male   | Nicol, Erskine     | Victorian/Genre
 Male   | Nauman, Bruce      | Body Art
 Male   | Nauman, Bruce      | Conceptual Art
(10 rows) */

-- Then, we can perform an aggregation:
SELECT movement, COUNT(*) FROM (SELECT unnest(movNames) AS movement FROM table_array) as a GROUP BY movement ORDER BY COUNT(*) DESC LIMIT 10;

/* OUTCOME:
                movement                 | count
-----------------------------------------+-------
 Surrealism                              |     9
 Conceptual Art                          |     8
 Neo-Classicism                          |     6
 Victorian/Genre                         |     6
 Constructivism                          |     5
 Netherlands-trained, working in Britain |     5
 Arte Povera                             |     5
 Baroque                                 |     5
 Later Stuart                            |     5
 Court                                   |     5
(10 rows) */

-- ############################
-- #### 3. MISCELLANEOUS ####
-- ############################

-- You can also create n-dimensional arrays 

-- Let's create a table:
CREATE TABLE table_array2 (
    one_dim int[],
    two_dim int[][]);

-- Let's insert some data:
INSERT INTO table_array2
VALUES (
    '{1, 2, 3, 4, 5, 6}', -- one-dimensional array of type integer
    '{{1, 2,3}, {4, 5, 6}}' -- two-dimensional array of type integer
);

-- Let's select all:
SELECT * FROM table_array2;

/* OUTCOME:
    one_dim    |      two_dim
---------------+-------------------
 {1,2,3,4,5,6} | {{1,2,3},{4,5,6}}
(1 row) */


/* We can access elements within the two-dimensional array
by writing [lower-bound:upper-bound] */

-- Let's select a single dimension:
SELECT *, two_dim[1:1] FROM table_array2;

/* OUTCOME:
    one_dim    |      two_dim      |  two_dim
---------------+-------------------+-----------
 {1,2,3,4,5,6} | {{1,2,3},{4,5,6}} | {{1,2,3}}
(1 row) */

-- Let's get the other:
SELECT *, two_dim[2:2] FROM table_array2;

/* OUTCOME:
    one_dim    |      two_dim      |  two_dim
---------------+-------------------+-----------
 {1,2,3,4,5,6} | {{1,2,3},{4,5,6}} | {{4,5,6}}
(1 row) */

-- Let's get for both dimensions only the first element:
SELECT *, two_dim[1:2][1:1] FROM table_array2;

/* OUTCOME
    one_dim    |      two_dim      |  two_dim
---------------+-------------------+-----------
 {1,2,3,4,5,6} | {{1,2,3},{4,5,6}} | {{1},{4}}
(1 row) */

-- Let's get for both dimensions only the third element:
SELECT *, two_dim[1:2][3:3] FROM table_array2;

/* OUTCOME:
    one_dim    |      two_dim      |  two_dim
---------------+-------------------+-----------
 {1,2,3,4,5,6} | {{1,2,3},{4,5,6}} | {{3},{6}}
(1 row) */

-- Let's get for both dimensions only the second and third element:
SELECT *, two_dim[1:2][2:3] FROM table_array2;

/* OUTCOME:
    one_dim    |      two_dim      |    two_dim
---------------+-------------------+---------------
 {1,2,3,4,5,6} | {{1,2,3},{4,5,6}} | {{2,3},{5,6}}
(1 row) */