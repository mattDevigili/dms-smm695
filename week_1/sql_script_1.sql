--- Lecture One, SQL commands

--- 1. Create a Database

CREATE DATABASE learning; -- this command cannot run inside a transaction block

--- 2. Create a Schema

CREATE SCHEMA weather;

--- 3. Create Table

-- The following example is taken from the 
-- PosgreSQL Documentation Section I 
-- Chapter 2 pages 7-9

CREATE TABLE weather.us_weather (
id bigserial,
city varchar(80),
temp_lo int, -- low temperature
temp_hi int, -- high temperature
prcp real, -- precipitation
date date);

--- 4. Insert Data

-- Simple insert specifying both columns and values

INSERT INTO weather.us_weather (
id, city, temp_lo, temp_hi, prcp, date)
VALUES (1, 'San Francisco', 46, 50, 0.25, '1994-11-27');

-- As id is a bigserial (auto incremented value), we can 
-- avoid specifying its value

INSERT INTO weather.us_weather (
city, temp_lo, temp_hi, prcp, date)
VALUES ('San Francisco', 43, 57, 0.0, '1994-11-29');

-- We can insert values in different orders

INSERT INTO weather.us_weather (
temp_lo, temp_hi, city, date, prcp)
VALUES (44, 58, 'San Francisco',  '1994-12-01', 0.1);

-- We can insert values without writing down column names

INSERT INTO weather.us_weather 
VALUES (4, 'San Francisco',  43, 54, 0.3, '1994-12-03');

--- 5. Data Types

-- Let's create a schema to collect our tables 

CREATE SCHEMA data_types;

-- Let's create some tables to experiment with
-- different data types

CREATE TABLE data_types.small_int (
id serial,
sm_int smallint);

CREATE TABLE data_types.real (
id serial,
real real);

CREATE TABLE data_types.money (
id bigserial,
money_d money);

CREATE TABLE data_types.textual (
id smallserial,
var_char varchar(5),
fx_char char(2));

CREATE TABLE data_types.times (
id bigserial,
time time with time zone,
date date,
tmstp_tz timestamp with time zone,
tmstp_ntz timestamp);

-- Let's see what does it happen inserting 
-- different values in our column for which
-- data type specified is small integers

INSERT INTO data_types.small_int (sm_int)
VALUES (100);

-- this is out of range:
-- INSERT INTO data_types.small_int (sm_int)
-- VALUES (1000000);

-- Let's see what does it happen inserting 
-- different values in our column for which
-- data type specified is real

INSERT INTO data_types.real (real)
VALUES (0.202);

INSERT INTO data_types.real (real)
VALUES (0.20202029892);

SELECT * FROM data_types.real; -- to see what data have been stored

-- Let's see what does it happen inserting 
-- different values in our column for which
-- data type specified is money

INSERT INTO data_types.money (money_d)
VALUES ('$1,000.00');

INSERT INTO data_types.money (money_d)
VALUES ('1000.00');

INSERT INTO data_types.money (money_d)
VALUES ('1000.00$');

-- Let's see what does it happen inserting 
-- different values in our columns for which
-- data type specified is character varaying
-- and character 

INSERT INTO data_types.textual  (var_char, fx_char)
VALUES ('Baden', 'No');

-- this will rise an error:
-- INSERT INTO data_types.textual  (var_char, fx_char)
-- VALUES ('Matteo', 'No');

INSERT INTO data_types.textual  (var_char, fx_char)
VALUES ('Matt', 'No');

-- this will rise an error:
-- INSERT INTO data_types.textual  (var_char, fx_char)
-- VALUES ('Matt', 'Yes');

INSERT INTO data_types.textual  (var_char, fx_char)
VALUES ('Matt', 'Y');

-- Let's see what does it happen inserting 
-- different values in our columns for which
-- data type specified is time with time zone,
-- date, timestamp with time zone, and timestamp

INSERT INTO data_types.times(
	"time", date, tmstp_tz, tmstp_ntz)
	VALUES ('20:01:10+01', '2020-01-12',  '2020-01-12 20:01:10+01',  '2020-01-12 20:01:10');

INSERT INTO data_types.times(
	"time", date, tmstp_tz, tmstp_ntz)
	VALUES ('2020-01-13 20:01:10+01', '2020-01-13 20:01:10+01',  '2020-01-13 20:01:10+01',  '2020-01-13 20:01:10+01');

-- 6. DROP TABLE

-- Let's see how to drop a table

DROP TABLE data_types.money;

DROP TABLE data_types.real;

-- Let's see how to drop a schema 
-- with CASCADE option

-- this will rise an error:
-- DROP SCHEMA data_types:

DROP SCHEMA data_types CASCADE;

DROP SCHEMA weather CASCADE;

-- Let's see how to drop a database

DROP DATABASE learning; -- cannot run inside a transaction block
