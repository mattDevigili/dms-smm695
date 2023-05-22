/*
Tutorial _0: PostgreSQL Indexes

For this tutorial I'm working within psql (you can replicate everything
within pgAdmin4). As first, we are going to import a csv on Digital Music
directly from a url - available thanks to Jianmo Ni and Julian McAuley
 - and then we will explore indexing.

Topics:
0. Set up
1. Indexing
  1.1 Numeric data (WHERE), B-tree and Hash
  1.2 Textual data (WHERE), B-tree and Hash
  1.3 BETWEEN (WHERE), B-tree
  1.4 ORDER BY, B-tree
  1.5 Multi-columns Index (WHERE), B-tree
  1.6 Index only scan (WHERE), B-tree
*/

-- ###################
-- #### 0. SET UP ####
-- ###################

-- let's create a new database
CREATE DATABASE t_0;
-- connect to t_0
\c t_0;
-- we need to create a table before importing data
CREATE TABLE music (
    id bigserial,
    item_code text,
    user_code text,
    rating numeric,
    timestamp numeric);
-- let's import data leveraging on `curl`
\copy public.music(item_code, user_code, rating, timestamp) FROM PROGRAM 'curl "http://deepyeti.ucsd.edu/jianmo/amazon/categoryFilesSmall/Digital_Music.csv"' CSV DELIMITER ',';
-- exploring the first 10 observations
SELECT * FROM public.music LIMIT 10;

 /*
 id | item_code  |   user_code    | rating | timestamp
----+------------+----------------+--------+------------
  1 | 0001388703 | A1ZCPG3D3HGRSS |    5.0 | 1387670400
  2 | 0001388703 | AC2PL52NKPL29  |    5.0 | 1378857600
  3 | 0001388703 | A1SUZXBDZSDQ3A |    5.0 | 1362182400
  4 | 0001388703 | A3A0W7FZXM0IZW |    5.0 | 1354406400
  5 | 0001388703 | A12R54MKO17TW0 |    5.0 | 1325894400
  6 | 0001388703 | A25ZT87OMIPLNX |    5.0 | 1247011200
  7 | 0001388703 | A3NVGWKHLULDHR |    1.0 | 1242259200
  8 | 0001388703 | AT7OB43GHKIUA  |    5.0 | 1209859200
  9 | 0001388703 | A1H3X1TW6Y7HD8 |    5.0 | 1442534400
 10 | 0001388703 | AZ3T21W6CW0MW  |    1.0 | 1431648000
 */

-- let's insert a new column to store timestamp
ALTER TABLE public.music ADD COLUMN date timestamp with time zone;
-- using `WITH AS` we update the new columns value with timestamp data
WITH split_query AS (
    SELECT id, user_code, to_timestamp(timestamp)::timestamp AS date FROM
    public.music )
UPDATE public.music
SET
    date  = split_query.date
    FROM split_query
    WHERE public.music.id = split_query.id AND public.music.user_code = split_query.user_code;
-- exploring some lines
SELECT * FROM public.music LIMIT 10;

/*
 id  | item_code  |   user_code    | rating | timestamp  |          date
-----+------------+----------------+--------+------------+------------------------
  60 | 0001527134 | A10CSSGW3ESBCA |    5.0 | 1421452800 | 2015-01-17 00:00:00+00
  96 | 0001377647 | A38XIRUW0J36KQ |    5.0 | 1413763200 | 2014-10-20 01:00:00+01
  99 | 0001377647 | A2SH1KUPIWHLSR |    5.0 | 1404432000 | 2014-07-04 01:00:00+01
 114 | 0006935257 | A1P4A10YRAHMJ0 |    5.0 | 1411862400 | 2014-09-28 01:00:00+01
 140 | 0006920055 | ASNQC8BDKY3RM  |    5.0 | 1354492800 | 2012-12-03 00:00:00+00
 198 | 0966484525 | A2RUR2Y3N1YZZG |    4.0 | 1144713600 | 2006-04-11 01:00:00+01
 219 | 1584591641 | A3JXGGAST5JI1Y |    5.0 | 1381276800 | 2013-10-09 01:00:00+01
 240 | 1882513274 | A1HRVC0CXX2HJR |    5.0 | 1267747200 | 2010-03-05 00:00:00+00
 291 | 1932192077 | A1NWDZ235UWCMT |    5.0 | 1406505600 | 2014-07-28 01:00:00+01
 299 | 1932192077 | A12VOP5IA8ZZH  |    5.0 | 1391040000 | 2014-01-30 00:00:00+00
 */

-- let's remove the timestamp column
ALTER TABLE public.music DROP COLUMN timestamp;
-- inspect table properties
\d public.music;

/*
                                      Table "public.music"
  Column   |           Type           | Collation | Nullable |              Default
-----------+--------------------------+-----------+----------+-----------------------------------
 id        | bigint                   |           | not null | nextval('music_id_seq'::regclass)
 item_code | text                     |           |          |
 user_code | text                     |           |          |
 rating    | numeric                  |           |          |
 date      | timestamp with time zone |           |          |
*/

-- #####################
-- #### 1. Indexing ####
-- #####################

/*
"An index allows the database server to find and retrieve specific rows much faster than it could do without an index.
But indexes also add overhead to the database system as a whole, so they should be used sensibly. [...] Indexes can also
benefit UPDATE and DELETE commands with search conditions [not only filtering via WHERE]. Indexes can moreover be used
in join searches. Thus, an index defined on a column that is part of a join condition can also significantly speed up
queries with joins" (Postgre 13 Documentation, chapter 11).

In the following lines of code, we will explore two index types: B-tree and Hash.

* B-tree is suited for >, <, =, >=, and <= operations (hence, also: BETWEEN, IN, IS NULL, IS NOT NULL, ORDER BY);
* Hash is only suited for = operations.

All index types:
1. B-tree,
2. Hash,
3. GiST,
4. SP-GiST,
5. GIN,
6. BRIN.
*/

--
-- ### 1.1 Numeric data ###
--

-- let's run the following query
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE id = 695;

/*
The output of the "explain analyze" is the following:

                                                      QUERY PLAN
-----------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..40392.20 rows=1 width=54) (actual time=224.952..231.777 rows=1 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on music  (cost=0.00..39392.10 rows=1 width=54) (actual time=134.428..164.443 rows=0 loops=3)
         Filter: (id = 695)
         Rows Removed by Filter: 528027
 Planning Time: 0.085 ms
 Execution Time: 231.798 ms
 */

 -- Let's inspect the size:
 SELECT pg_size_pretty(pg_total_relation_size('music')) as relation, pg_size_pretty(pg_indexes_size('music')) as index;

/*
 relation       | index
----------------+----------------
 243 MB         | 0 bytes
 */

-- We can now crete a B-tree index over id, and display its cost (in MB)
CREATE INDEX id_music_idx ON public.music(id);
SELECT pg_size_pretty(pg_total_relation_size('music')) as relation, pg_size_pretty(pg_indexes_size('music')) as index;

/*
We added an extra 34 MB of data to create this index:

 relation       | index
----------------+----------------
 277 MB         | 34 MB
 */

-- let's run the query again:
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE id = 695;

/*
If we compare the Execution time, this is a great improvement!

                                                     QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
 Index Scan using id_music_idx on music  (cost=0.43..8.45 rows=1 width=54) (actual time=0.017..0.019 rows=1 loops=1)
   Index Cond: (id = 695)
 Planning Time: 0.863 ms
 Execution Time: 0.038 ms
(4 rows)
 */

-- Let's try to do the same, but with HASH. As first we want to drop the initial index
DROP INDEX id_music_idx;
CREATE INDEX id_music_idx ON public.music USING HASH (id);
SELECT pg_size_pretty(pg_total_relation_size('music')) as relation, pg_size_pretty(pg_indexes_size('music')) as table;

/*
We are spending 16 MB more:

 relation       | index
----------------+----------------
 294 MB         | 50 MB
(1 row)
*/

-- Let's run the query again
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE id = 695;

/*
                                                     QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
 Index Scan using id_music_idx on music  (cost=0.00..8.02 rows=1 width=54) (actual time=0.014..0.016 rows=1 loops=1)
   Index Cond: (id = 695)
 Planning Time: 0.062 ms
 Execution Time: 0.031 ms
(4 rows)
*/

-- let's drop the index
DROP INDEX id_music_idx;


--
-- ### 1.2 Textual data ###
--

-- let's run the following query
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE user_code='A38XIRUW0J36KQ';

/*
                                                      QUERY PLAN
-----------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..40387.13 rows=7 width=54) (actual time=0.523..253.575 rows=1 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on music  (cost=0.00..39386.43 rows=3 width=54) (actual time=121.245..204.517 rows=0 loops=3)
         Filter: (user_code = 'A38XIRUW0J36KQ'::text)
         Rows Removed by Filter: 528027
 Planning Time: 0.078 ms
 Execution Time: 253.608 ms
(8 rows)
*/

-- we want to create a B-tree index and display its cost
CREATE INDEX user_music_idx ON public.music(user_code);
SELECT pg_size_pretty(pg_total_relation_size('music')) as relation, pg_size_pretty(pg_indexes_size('music')) as index;

/*
 relation       | index
----------------+----------------
 276 MB         | 33 MB
(1 row)
*/

-- let's run the query again
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE user_code='A38XIRUW0J36KQ';

/*
                                                       QUERY PLAN
------------------------------------------------------------------------------------------------------------------------
 Index Scan using user_music_idx on music  (cost=0.43..32.55 rows=7 width=54) (actual time=0.028..0.029 rows=1 loops=1)
   Index Cond: (user_code = 'A38XIRUW0J36KQ'::text)
 Planning Time: 0.186 ms
 Execution Time: 0.042 ms
(4 rows)
*/

-- let's try using Hash
DROP INDEX user_music_idx;
CREATE INDEX user_music_idx ON public.music USING HASH (user_code);
SELECT pg_size_pretty(pg_total_relation_size('music')) as relation, pg_size_pretty(pg_indexes_size('music')) as index;

/*
 relation       | index
----------------+----------------
 296 MB         | 53 MB
(1 row)
*/

-- let's run this query again
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE user_code='A38XIRUW0J36KQ';

/*
                                                       QUERY PLAN
------------------------------------------------------------------------------------------------------------------------
 Index Scan using user_music_idx on music  (cost=0.00..32.12 rows=7 width=54) (actual time=0.015..0.016 rows=1 loops=1)
   Index Cond: (user_code = 'A38XIRUW0J36KQ'::text)
 Planning Time: 0.605 ms
 Execution Time: 0.042 ms
(4 rows)
*/

-- let's drop this index
DROP INDEX user_music_idx;

/*
If you want further information on why and how to use Hash more than B-tree, check out the following references:

- Are Hash Indexes Faster than Btree Indexes in Postgres? by Amit Kapila ("https://www.enterprisedb.com/postgres-tutorials/are-hash-indexes-faster-btree-indexes-postgres")
- Re-Introducing Hash Indexes in PostgreSQL by Haki Benita ("https://hakibenita.com/postgresql-hash-index")
*/


--
-- ### 1.3 BETWEEN ###
--

-- let's run the following query
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE id BETWEEN 695 AND 700;

/*
                                                      QUERY PLAN
----------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..42037.01 rows=5 width=54) (actual time=0.242..212.259 rows=6 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on music  (cost=0.00..41036.51 rows=2 width=54) (actual time=19.616..160.621 rows=2 loops=3)
         Filter: ((id >= 695) AND (id <= 700))
         Rows Removed by Filter: 528025
 Planning Time: 0.081 ms
 Execution Time: 212.275 ms
(8 rows)
*/

-- let's create a B-tree index
CREATE INDEX id_music_idx ON public.music(id); -- this will create an index of 34 MB

-- let's run the following query again
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE id BETWEEN 695 AND 700;

/*
                                                      QUERY PLAN
----------------------------------------------------------------------------------------------------------------------
 Index Scan using id_music_idx on music  (cost=0.43..24.51 rows=5 width=54) (actual time=0.018..0.055 rows=6 loops=1)
   Index Cond: ((id >= 695) AND (id <= 700))
 Planning Time: 0.741 ms
 Execution Time: 0.071 ms
(4 rows)
*/

-- drop the B-tree index
DROP INDEX id_music_idx;


--
-- ### 1.4 ORDER BY ###
--

-- let's run the following query
EXPLAIN ANALYZE
SELECT * FROM music
ORDER BY rating;

/*
                                                            QUERY PLAN
-------------------------------------------------------------------------------------------------------------------------------------
 Gather Merge  (cost=123046.45..277396.26 rows=1322906 width=46) (actual time=601.333..1269.933 rows=1584082 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Sort  (cost=122046.43..123700.06 rows=661453 width=46) (actual time=566.326..712.758 rows=528027 loops=3)
         Sort Key: rating
         Sort Method: external merge  Disk: 31192kB
         Worker 0:  Sort Method: external merge  Disk: 29416kB
         Worker 1:  Sort Method: external merge  Disk: 29496kB
         ->  Parallel Seq Scan on music  (cost=0.00..37750.53 rows=661453 width=46) (actual time=7.974..162.539 rows=528027 loops=3)
 Planning Time: 0.226 ms
  JIT:
   Functions: 6
   Options: Inlining false, Optimization false, Expressions true, Deforming true
   Timing: Generation 3.736 ms, Inlining 0.000 ms, Optimization 1.869 ms, Emission 20.883 ms, Total 26.488 ms
 Execution Time: 1388.195 ms
(15 rows)
*/

-- we can now create a B-tree index on rating
CREATE INDEX rating_music_idx ON public.music(rating); -- this will create an index of 34 MB

-- let's re-run the explain analyze
EXPLAIN ANALYZE
SELECT * FROM music
ORDER BY rating;

/*
                                                                 QUERY PLAN
--------------------------------------------------------------------------------------------------------------------------------------------
 Index Scan using rating_music_idx on music  (cost=0.43..124767.13 rows=1584082 width=46) (actual time=4.855..613.676 rows=1584082 loops=1)
 Planning Time: 0.435 ms
 JIT:
   Functions: 2
   Options: Inlining false, Optimization false, Expressions true, Deforming true
   Timing: Generation 1.661 ms, Inlining 0.000 ms, Optimization 0.394 ms, Emission 4.074 ms, Total 6.129 ms
 Execution Time: 726.593 ms
(7 rows)
*/

-- drop the index
DROP INDEX rating_music_idx;


--
-- ### 1.5 Multi-columns index ###
--

-- let's run this query
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE item_code = '0006920055' AND rating < 5;

/*
                                                      QUERY PLAN
----------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..42037.01 rows=5 width=54) (actual time=31.661..308.659 rows=3 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on music  (cost=0.00..41036.51 rows=2 width=54) (actual time=92.235..259.753 rows=1 loops=3)
         Filter: ((rating < '5'::numeric) AND (item_code = '0006920055'::text))
         Rows Removed by Filter: 528026
 Planning Time: 0.104 ms
 Execution Time: 308.674 ms
(8 rows)
*/

-- let's pass independent indexes on the two columns
CREATE INDEX item_idx ON public.music(item_code);
CREATE INDEX rating_idx ON public.music(rating);
SELECT pg_size_pretty(pg_total_relation_size('music')) as relation, pg_size_pretty(pg_indexes_size('music')) as index;

/*
 relation       | index
----------------+----------------
 300 MB         | 57 MB
(1 row)
*/

-- let's try to re-run the initial query
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE item_code = '0006920055' AND rating < 5;

/*
                                                    QUERY PLAN
-------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on music  (cost=4.61..98.97 rows=5 width=54) (actual time=0.046..1.130 rows=3 loops=1)
   Recheck Cond: (item_code = '0006920055'::text)
   Filter: (rating < '5'::numeric)
   Rows Removed by Filter: 35
   Heap Blocks: exact=27
   ->  Bitmap Index Scan on item_idx  (cost=0.00..4.61 rows=24 width=0) (actual time=0.027..0.027 rows=38 loops=1)
         Index Cond: (item_code = '0006920055'::text)
 Planning Time: 0.299 ms
 Execution Time: 1.152 ms
(9 rows)
*/

-- let's drop the independent indexes
DROP INDEX item_idx;
DROP INDEX rating_idx;

-- let's create an index over the two columns and check its cost
CREATE INDEX item_rating_idx ON public.music(item_code, rating);
SELECT pg_size_pretty(pg_total_relation_size('music')) as relation, pg_size_pretty(pg_indexes_size('music')) as index;

/*
 relation       | index
----------------+----------------
 291 MB         | 48 MB
(1 row)
*/

-- let's re-run the following query
EXPLAIN ANALYZE
SELECT * FROM public.music
WHERE item_code = '0006920055' AND rating < 5;

/*
                                                       QUERY PLAN
-------------------------------------------------------------------------------------------------------------------------
 Index Scan using item_rating_idx on music  (cost=0.43..24.52 rows=5 width=54) (actual time=0.039..0.052 rows=3 loops=1)
   Index Cond: ((item_code = '0006920055'::text) AND (rating < '5'::numeric))
 Planning Time: 0.602 ms
 Execution Time: 0.067 ms
(4 rows)
*/

-- drop the multi-column index
DROP INDEX item_rating_idx;


--
-- ### 1.6 Index only scan ###
--

-- let's run the following
EXPLAIN ANALYZE
SELECT COUNT(*) FROM public.music
WHERE item_code='0006920055';

/*
                                                            QUERY PLAN
----------------------------------------------------------------------------------------------------------------------------------
 Finalize Aggregate  (cost=40386.67..40386.68 rows=1 width=8) (actual time=220.502..223.673 rows=1 loops=1)
   ->  Gather  (cost=40386.45..40386.66 rows=2 width=8) (actual time=220.329..223.646 rows=3 loops=1)
         Workers Planned: 2
         Workers Launched: 2
         ->  Partial Aggregate  (cost=39386.45..39386.46 rows=1 width=8) (actual time=174.520..174.521 rows=1 loops=3)
               ->  Parallel Seq Scan on music  (cost=0.00..39386.43 rows=10 width=0) (actual time=6.303..174.494 rows=13 loops=3)
                     Filter: (item_code = '006920055'::text)
                     Rows Removed by Filter: 528015
 Planning Time: 0.149 ms
 Execution Time: 223.706 ms
(10 rows)0
*/

-- let's pass a B-tree index on item_code
CREATE INDEX item_idx ON public.music(item_code);
SELECT pg_size_pretty(pg_total_relation_size('music')), pg_size_pretty(pg_indexes_size('music'));

/*
 pg_size_pretty | pg_size_pretty
----------------+----------------
 266 MB         | 23 MB
(1 row)
*/

-- let's re-run
EXPLAIN ANALYZE
SELECT COUNT(*) FROM public.music
WHERE item_code='0006920055';

/*
                                                         QUERY PLAN
-----------------------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=4.91..4.92 rows=1 width=8) (actual time=0.025..0.025 rows=1 loops=1)
   ->  Index Only Scan using item_idx on music  (cost=0.43..4.85 rows=24 width=0) (actual time=0.014..0.018 rows=38 loops=1)
         Index Cond: (item_code = '0006920055'::text)
         Heap Fetches: 0
 Planning Time: 0.084 ms
 Execution Time: 0.043 ms
(6 rows)
*/

-- drop index
DROP INDEX item_idx;