# Data Management Systems

![dms-smm695](/docs/assets/images/dms-punk.png)

Databases are always there, even if you do not know. Searching for a product on
e-commerce, writing a message to a friend, or looking for a paper to cite in
your thesis, you are interacting with a database. For this reason, databases are
a fundamental component of the digital era, and this is also why it is worth
knowing their basic functioning.

Through the years, the world of databases has faced several developments with
always new approaches to structuring, storing, and interacting with data. From
the relational model to more flexible systems, the journey of databases is in
constant evolution.

## Instructor

**Name**: [Matteo Devigili](https://mattdevigili.github.io)

**Contacts**: <matteo.devigili.2@city.ac.uk>

**Webinar**: Friday --- 11:00 - 12:50 (Zoom)

**Office hours**: Friday --- 15:00 - 17:00 (Zoom)

## Module Overview

This module focuses on storing, querying, and manipulating data. In
particular, we will discuss [PostgreSQL](https://www.postgresql.org) (a
prominent, advanced, and open-source relational database) and
[MongoDB](https://www.mongodb.com) (a schema-free database especially useful
with evolving streams of data). In the last week, a more exploratory lecture
(not strictly required to complete the final coursework) will drive you through
[Apache Spark](https://spark.apache.org) (a cluster-computing framework that
can scale SQL, machine learning, and network analysis pipelines) leveraging
on [PySpark](https://spark.apache.org/docs/latest/api/python/index.html#).

## Materials & Readings

For this course, you do not have to buy any books, but you need to go through
the following:

* Lecture recordings (to be uploaded onto MS Streams weekly);
* Lecture slides (to be uploaded onto Github weekly);
* SQL/JS/Python scripts (to be uploaded onto Github weekly).

Furthermore, I will provide you with some _not mandatory and not rated homework_
to test your understanding of the lecture.

The following references concern additional material you may be interested in:

* PostgreSQL:
  * [PostgreSQL Documentation](https://www.postgresql.org/docs/16/index.html)
  * [PostgreSQL: Up and Running](http://shop.oreilly.com/product/0636920052715.do)
* MongoDB:
  * [MongoDB Manual](https://docs.mongodb.com/manual/)
  * [MongoDB: The Definitive Guide](http://shop.oreilly.com/product/0636920049531.do)
  * [MongoDB in Action](https://www.manning.com/books/mongodb-in-action-second-edition)
* PySpark:
  * [Learning PySpark](https://link.springer.com/book/10.1007%2F978-1-4842-4961-1)

## Learning Objectives and Assessment

At the end of the module, students should be able to:

* design a relational database with PostgreSQL
* design a schema-free database with MongoDB
* interact with and manipulate data in both PostgreSQL and MongoDB
* design and execute scripts providing useful insights into data

In terms of assessment, students are required to deliver one group-level
coursework project (so, _no final examination or individual assignments_).

The [final course project](https://mattdevigili.github.io/dms-smm695/final-course-project/)
will be launched in week 5, and submissions will be evaluated on a rolling-based
window and are due by July 19 (4:00 PM London Time). Students will be required
to deal with real-world data from scratch, thus implementing what learned during
this module.

The project will be evaluated along with the following criteria: i)
appropriate use of notions and frameworks discussed in class; ii) effectiveness
of the proposed answer or solution; iii) appropriate explanation of the proposed
solution; iv) organization and clarity of submitted materials. All criteria
carry out an equal weight in terms of the mark.

## Organization of the Module

The following table shows the schedule of the module. Based on students'
progress throughout the module, the topics included could suffer from some
**minor changes**.

All the _pre-recorded material_ is already available on the [course GitHub page](https://mattdevigili.github.io/dms-smm695/) or [GitHub repo](https://github.com/mattDevigili/dms-smm695).

An _interactive webinar_ will be held each **Friday** _from 11:00 to 12:50
London time_.  Students are expected to go through the weekly pre-recorded
material in advance. In the first part of the class, I will provide a recap of
the video recording and answer students' questions concerning the topics
covered. _Note_: students are invited to share their questions via email the day
before the webinar (by 8:00 PM London time). In the second part, I will discuss
some further applications of the topic covered.

To recap:

* _GitHub page_ or _GitHub repo_ is where you can find all relevant material
* _Zoom_ hosts webinar sessions and office hours

| Week (dd-mm) | Agenda         | Topics                                      | Material                                                               |
| ------------ | -------------- | ------------------------------------------- | ---------------------------------------------------------------------- |
| 1 (24-05)    | **PostgreSQL** | Introduction to RDMS                        | [Lecture](https://mattdevigili.github.io/dms-smm695/week-1)            |
|              |                | PostgreSQL (psql and pgAmin4)               | [Webinar](https://mattdevigili.github.io/dms-smm695/week-1/webinar-1/) |
|              |                | Installation                                |                                                                        |
|              |                | Create (Database, Schema, Table)            |                                                                        |
|              |                | Data types:                                 |                                                                        |
|              |                | --- Numeric                                 |                                                                        |
|              |                | --- Monetary                                |                                                                        |
|              |                | --- Character                               |                                                                        |
|              |                | --- Date and time                           |                                                                        |
|              |                | Drop (Database, Schema, Table)              |                                                                        |
| 2 (31-05)    |                | Constraints:                                | [Lecture](https://mattdevigili.github.io/dms-smm695/week-2)            |
|              |                | --- Not Null                                | [Webinar](https://mattdevigili.github.io/dms-smm695/week-2/webinar-2/) |
|              |                | --- Unique                                  |                                                                        |
|              |                | --- Primary Key                             |                                                                        |
|              |                | --- Check                                   |                                                                        |
|              |                | Import data                                 |                                                                        |
|              |                | Basic SQL                                   |                                                                        |
|              |                | Aggregate functions                         |                                                                        |
|              |                | Grouping                                    |                                                                        |
| 3 (07-06)    |                | Foreign Key                                 | [Lecture](https://mattdevigili.github.io/dms-smm695/week-3)            |
|              |                | Joins:                                      | [Webinar](https://mattdevigili.github.io/dms-smm695/week-3/webinar-3/) |
|              |                | --- Inner                                   |                                                                        |
|              |                | --- Left/Right/Full (Outer)                 |                                                                        |
|              |                | --- Cross                                   |                                                                        |
|              |                | Export data                                 |                                                                        |
| 4 (13-06)    | **MongoDB**    | Introduction to MongoDB                     | [Lecture](https://mattdevigili.github.io/dms-smm695/week-4)            |
|              |                | Installation                                | [Webinar](https://mattdevigili.github.io/dms-smm695/week-4/webinar-4/) |
|              |                | CRUD operations:                            |                                                                        |
|              |                | --- Insert                                  |                                                                        |
|              |                | --- Find                                    |                                                                        |
|              |                | --- Update (Replace)                        |                                                                        |
|              |                | --- Delete (Drop)                           |                                                                        |
| 5 (21-06)    |                | Load data                                   | [Lecture](https://mattdevigili.github.io/dms-smm695/week-5)            |
|              |                | Query and Projection Operators              | [Webinar](https://mattdevigili.github.io/dms-smm695/week-5/webinar-5/) |
|              |                | Introduction to the _Aggregation Framework_ |                                                                        |
|              |                | Data Export                                 |                                                                        |
| 6 (28-06)    | **PySpark**    | Introduction to PySpark                     | [Lecture](https://mattdevigili.github.io/dms-smm695/week-6)            |
|              |                | Connection to PostgreSQL and MongoDB        | [Webinar](https://mattdevigili.github.io/dms-smm695/week-6/webinar-6/) |
|              |                | Regression module                           |                                                                        |
|              |                | NLP examples                                |                                                                        |

## Software requirements

During the course, students will be guided to install:

* [psql](https://www.postgresql.org/docs/14/app-psql.html) and [pgAdmin4](https://www.pgadmin.org) to explore PostgreSQL;
* The [mongo shell](https://www.mongodb.com/download-center/community) and [MongoDB Compass](https://www.mongodb.com/products/compass) to explore MongoDB.

Check the [environment](https://mattdevigili.github.io/dms-smm695/environment) folder for further info.

We will also interact with [Amazon RDS](https://aws.amazon.com/rds/) and [MongoDB Atlas](https://www.mongodb.com/cloud/atlas),
so please be sure to have a stable internet connection.

To follow the lectures in _weeks 2, 4, 6_ and _webinars_, you need to run Python >= 3.7. The
easiest way to do that is to install [Anaconda](https://www.anaconda.com/products/individual).

## Jump to

| Lectures                                              | Webinars                                                        | Utils                                                                                   |
| ----------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| [1](https://mattdevigili.github.io/dms-smm695/week-1) | [1](https://mattdevigili.github.io/dms-smm695/week-1/webinar-1) | [Python environment set-up](https://mattdevigili.github.io/dms-smm695/environment)      |
| [2](https://mattdevigili.github.io/dms-smm695/week-2) | [2](https://mattdevigili.github.io/dms-smm695/week-2/webinar-2) | [Tutorials](https://mattdevigili.github.io/dms-smm695/tutorials)                        |
| [3](https://mattdevigili.github.io/dms-smm695/week-3) | [3](https://mattdevigili.github.io/dms-smm695/week-3/webinar-3) | [Past assignments](https://mattdevigili.github.io/dms-smm695/past-assignments)          |
| [4](https://mattdevigili.github.io/dms-smm695/week-4) | [4](https://mattdevigili.github.io/dms-smm695/week-4/webinar-4) | [Final-Course-Project](https://mattdevigili.github.io/dms-smm695/final-course-project/) |
| [5](https://mattdevigili.github.io/dms-smm695/week-5) | [5](https://mattdevigili.github.io/dms-smm695/week-5/webinar-5) |                                                                                         |
| [6](https://mattdevigili.github.io/dms-smm695/week-6) | [6](https://mattdevigili.github.io/dms-smm695/week-6/webinar-6) |                                                                                         |
