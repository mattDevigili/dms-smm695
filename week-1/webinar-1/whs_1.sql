--to run in psql with \i /PATH/TO/YOUR/FILE

--to list databases
\l

--create a smm695 database

CREATE DATABASE smm695;

--connect to smm695

\c smm695

--create the homework1 schema

CREATE SCHEMA homework1;

--create the employee table

CREATE TABLE homework1.employee (
    id serial PRIMARY KEY, 
    first_name  varchar(20),
    last_name varchar(20),
    email varchar(80),
    salary numeric);

--create a person table

CREATE TABLE homework1.personalinfo (
    id serial PRIMARY KEY,
    country varchar(20),
    postal_code text,
    dob date);

--inserting values into employee

INSERT INTO homework1.employee (first_name, last_name, email, salary)
    VALUES ('Dave', 'Alstom', 'davealstom@google.com', 50000),
    ('Hunter', 'Reese', 'reese1998@hotmail.nl', 37000),
    ('Kerys', 'Mcclure', 'mcclure@gmail.com', 28000);

--inserting values into person

INSERT INTO homework1.personalinfo (country, postal_code, dob)
    VALUES ('Italy', '04929', '1995-06-18'),
    ('United Kingdom',  'E2 9AD',  '1980-05-13'),
    ('China', '100023', '1994-09-12');


--to list schemas for smm695
\dn

--to have some info on tables
\d homework1.employee

--displaying data
SELECT * FROM homework1.employee;
SELECT * FROM homework1.personalinfo;

--Join
SELECT * FROM homework1.employee he
JOIN homework1.personalinfo hp ON he.id = hp.id;