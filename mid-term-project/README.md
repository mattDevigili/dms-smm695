# Mid-term Project

<img src="https://upload.wikimedia.org/wikipedia/commons/6/69/IMDB_Logo_2016.svg" width="100">

> [IMDb](https://www.imdb.com) is the world's most popular and authoritative source for movie, TV and celebrity content. 

## Data
For the mid-term project (mtp), you are required to handle a 7 GB dataset. In
particular, you will work with the subsets of IMDb data available at
[datasets-imdbws](https://datasets.imdbws.com/). This data are publicly
available and refreshed daily.

IMDb provides a detailed description of the files available
[here](https://www.imdb.com/interfaces/).  In particular, you can access the
following files:

* [title.akas.tsv.gz](https://datasets.imdbws.com/title.akas.tsv.gz)
* [title.basics.tsv.gz](https://datasets.imdbws.com/title.basics.tsv.gz)
* [title.crew.tsv.gz](https://datasets.imdbws.com/title.crew.tsv.gz)
* [title.episode.tsv.gz](https://datasets.imdbws.com/title.episode.tsv.gz)
* [title.principals.tsv.gz](https://datasets.imdbws.com/title.principals.tsv.gz)
* [title.ratings.tsv.gz](https://datasets.imdbws.com/title.ratings.tsv.gz)
* [name.basics.tsv.gz](https://datasets.imdbws.com/name.basics.tsv.gz)

All these files are `gzipped` and in `tsv` (tab-separated-values) format.

## Tasks

For the **MTP** you are required to:

1. Import the above tables into your `localhost`<a href="#note2" id="note2ref"><sup>1</sup></a>
   via SQL (psql, PgAdmin4) and/or python (psycopg2).
2. Set appropriate data types and constraints<a href="#note2" id="note2ref"><sup>1</sup></a> per
   each column (_n.b._: you may also modify columns with postgre built-in
   functions) -- use `SQL` only;
3. Propose at least 3 _meaningful_ views ([CREATE
   VIEW](https://www.postgresql.org/docs/13/sql-createview.html)) leveraging on
   [JOINs](https://www.postgresql.org/docs/13/tutorial-join.html) and/or
   [Aggregations](https://www.postgresql.org/docs/13/tutorial-agg.html) -- use
   `SQL` only;    
4. [Optional] Apply indexes to enhance the performance of your queries (use
   [EXPLAIN ANALYZE](https://www.postgresql.org/docs/13/sql-explain.html) to
   show performance improvements) -- use `SQL` only.

## Some useful references

- [Fast ways to load data into PostgreSQL via python](https://hakibenita.com/fast-load-data-python-postgresql)
- [PostgreSQL Indexing](https://youtu.be/clrtT_4WBAw)

## Deliverables

By June 18th (8:00 PM, London time), groups are required to upload:

* SQL or Python scripts;
* Entity-Relationship Diagram (accepted format: .png); 
* Supporting documentation (accepted format: .md, .docx, or .pdf generated via LaTeX) containing:
  * a detailed justification of your design choices;
  * a clear and concise description of the view insights;
  * [optional] a concise description of the indexing benefits.
    
The supporting documentation should not exceed 1,500 words.

-----------------------------------------------------------------------------------------------------------------------

### Notes

<a id="#note1" href="#note1ref">1</a>: To speed up the process, you may look at [COPY
FROM PROGRAM](https://www.postgresql.org/docs/13/sql-copy.html) combined with
[wget](https://en.wikipedia.org/wiki/Wget) && [gzip
-dc](https://www.gnu.org/software/gzip/manual/gzip.html). Or via psycopg2, you
may be interested in
[execute_batch](https://www.psycopg.org/docs/extras.html).

<a id="note2" href="#note2ref">2</a>: Being a subset of the IMDb data, you may encounter
**missing** values in some fields you want to set as a reference for a _Foreign
Key_.  To solve these issues ("quick-and-dirty" solution), you may delete
non-matched inserts.  Given the number of lines involved (>12M and in one 
case >40M), you may speed up the process using indexes.
