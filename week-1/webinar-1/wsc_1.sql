--+ Possible solution to the Artworks case
--to run in psql with \i

--create a database 
CREATE DATABASE tate;

--connect to db
\c tate

--create tables

CREATE TABLE artworks (
    artwork_id int PRIMARY KEY,
    title text,
    year numeric,
    acquisitionYear numeric,
    thumbnailUrl text UNIQUE,
    url text UNIQUE);

CREATE TABLE artworks_info (
    artwork_id bigserial PRIMARY KEY,
    artist_id int,
    role_id int,
    dimension_id int,
    creditline_id int,
    inscription_id int,
    copyright_id int);

CREATE TABLE artist (
    artist_id serial PRIMARY KEY,
    artist text);

CREATE TABLE role (
    role_id serial PRIMARY KEY,
    artistRole text);

CREATE TABLE dimension (
    dimension_id serial PRIMARY KEY,
    medium_id int,
    dimensions text,
    width int,
    height numeric,
    depth numeric,
    units varchar(2));

CREATE TABLE medium (
    medium_id serial PRIMARY KEY,
    medium text);

CREATE TABLE creditline (
    creditline_id serial PRIMARY KEY,
    creditline text);

CREATE TABLE inscription (
    inscription_id smallserial PRIMARY KEY,
    inscription text);

CREATE TABLE copyright (
    copyright_id serial PRIMARY KEY,
    copyright text);

--foreign keys
ALTER TABLE artworks ADD CONSTRAINT artwork_fk FOREIGN KEY (artwork_id) REFERENCES artworks_info (artwork_id);

ALTER TABLE artworks_info ADD CONSTRAINT artist_fk FOREIGN KEY (artist_id) REFERENCES artist (artist_id);

ALTER TABLE artworks_info ADD CONSTRAINT role_fk FOREIGN KEY (role_id) REFERENCES role (role_id);

ALTER TABLE artworks_info ADD CONSTRAINT dimension_fk FOREIGN KEY (dimension_id) REFERENCES dimension (dimension_id);

ALTER TABLE artworks_info ADD CONSTRAINT credit_fk FOREIGN KEY (creditline_id) REFERENCES creditline (creditline_id);

ALTER TABLE artworks_info ADD CONSTRAINT inscription_fk FOREIGN KEY (inscription_id) REFERENCES inscription (inscription_id);

ALTER TABLE artworks_info ADD CONSTRAINT copyright_fk FOREIGN KEY (copyright_id) REFERENCES copyright (copyright_id);

ALTER TABLE dimension ADD CONSTRAINT dimension_fk FOREIGN KEY (medium_id) REFERENCES medium (medium_id);
