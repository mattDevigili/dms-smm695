# Webinar Structure
Here you can find the structure for the first webinar. In particular, we will
discuss:

* module organization and functioning;
* basics of the relational model;
* SQL create, delete, and insert.

| **Week (date)** | **Agenda**                                       |
|-----------------|--------------------------------------------------|
| 1 (17-05)       | Introduction to SMM695                           |
|                 | [PostgreSQL vs MongoDB](https://www.mongodb.com/compare/mongodb-postgresql) |
|                 | _Q&A_                                            |
|                 | Relational model                                 |
|                 | ER diagrams                                      |
|                 | Group discussion                                 |
|                 | _psql_                                           |
|                 | Homework solutions                               |
|                 | Loading the _Pagila_ example                     |

During the _group discussion_, you will be provided with a small random sample of 
the _artworks_data.csv_ retrieved at the [Tate](https://github.com/tategallery/collection#usage) GitHub repo. 

No preparation is required to attend this webinar.

# Materials
Webinar materials:
* _homeworkScript.sql_: solutions for the _homework_1.md_;
* _artworkRandomSample.csv_: a small and simplified version of the [artworks_data.csv](https://github.com/tategallery/collection/blob/master/artwork_data.csv);
* _exampleArtworks.png_: an entity relation diagram obtained with [PgAdmin 4](https://www.pgadmin.org/docs/pgadmin4/5.2/erd_tool.html).

## Pagila
To load the [Pagila](https://github.com/devrimgunduz/pagila) example, please do the following:

* Open psql;
* Create a new database and connect:
  * CREATE DATABASE pagila;
  * \c pagila
* Use \i to run the SQL script:
  * \i /PATH/TO/**pagila-schema.sql**
  * \i /PATH/TO/**pagila-data.sql**