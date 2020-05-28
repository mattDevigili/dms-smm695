-- Pagila dataset

-- 1. Some examples:

-- Exploring Address Table

SELECT * FROM address;

SELECT DISTINCT address2 FROM address;

ALTER TABLE address DROP COLUMN address2;

SELECT * FROM address WHERE district IN ('California', 'Georgia');

SELECT district, COUNT(*) AS count_d FROM address 
GROUP BY district ORDER BY count_d DESC;

SELECT district, COUNT(*) AS count_d FROM address 
GROUP BY district HAVING COUNT(*) > 5 ORDER BY count_d DESC;

SELECT address_id, address, postal_code, address.city_id, city 
FROM address, city 
WHERE address.city_id = city.city_id;

-- Exploring Film Table

SELECT * FROM film;

SELECT DISTINCT original_language_id FROM film;

ALTER TABLE film DROP COLUMN original_language_id;

SELECT rating, COUNT(*) FROM film GROUP BY rating;

SELECT rental_duration, ROUND(AVG(length), 2) AS avg_leng FROM film 
GROUP BY rental_duration ORDER BY avg_leng;

SELECT 
	rental_duration, 
	ROUND(AVG(length), 2) AS avg_leng, 
	ROUND(AVG(rental_rate), 2) AS avg_rate
FROM film 
GROUP BY rental_duration 
ORDER BY rental_duration;

SELECT 
	rental_duration,
	COUNT(*) AS count_films,
	ROUND(AVG(length), 2) AS avg_leng, 
	ROUND(AVG(rental_rate), 2) AS avg_rate
FROM film 
WHERE rating IN ('PG', 'PG-13')
GROUP BY rental_duration 
HAVING COUNT(*) = 89
ORDER BY rental_duration;

SELECT 
	rental_duration,
	COUNT(*) AS count_films,
	ROUND(AVG(length), 2) AS avg_leng,
	ROUND(stddev(length), 2) AS std_len,
	ROUND(AVG(rental_rate), 2) AS avg_rate,
	ROUND(stddev(rental_rate), 2) AS std_rate
FROM film 
WHERE rating IN ('PG', 'PG-13')
GROUP BY rental_duration 
ORDER BY rental_duration;

SELECT 
	rental_duration,
	COUNT(*) AS count_films,
	ROUND(AVG(length), 2) AS avg_leng,
	ROUND(stddev(length), 2) AS std_len,
	ROUND(stddev(length)/AVG(length),2) AS nsd_len,
	ROUND(AVG(rental_rate), 2) AS avg_rate,
	ROUND(stddev(rental_rate), 2) AS std_rate,
	ROUND(stddev(rental_rate)/AVG(rental_rate),2) AS nsd_rate
FROM film 
WHERE rating IN ('PG', 'PG-13')
GROUP BY rental_duration 
HAVING stddev(rental_rate)/AVG(rental_rate) BETWEEN 0.45 AND 0.55
ORDER BY rental_duration;

SELECT film.film_id, title, film_category.category_id, name
FROM film, film_category, category
WHERE 
film.film_id = film_category.film_id 
AND 
film_category.category_id = category.category_id;

-- 2.1 Some STRING FUNCTIONS:

-- lenght:
SELECT district, LENGTH(district) AS length FROM address;

SELECT district, LENGTH(district) AS length FROM address ORDER BY length DESC;

-- split:
SELECT
	address,
    split_part(address::TEXT,' ', 1) AS street_number
FROM
    address;

-- concat (and lower):
SELECT CONCAT (address, ', ' , district) AS full_address FROM address;

SELECT LOWER(CONCAT (address, ', ' , district)) AS full_address FROM address;


-- 2.2 Some Date Functions

-- extract:

SELECT EXTRACT(YEAR FROM last_update) FROM address;

-- current date:

SELECT NOW();

-- age:

SELECT last_update, AGE(NOW(), last_update) FROM address;

SELECT last_update, AGE(last_update) FROM address;

-- 3. Subquery Update

ALTER TABLE address 
ADD COLUMN street_number numeric;

WITH split_query AS (
    SELECT address_id, CAST(split_part(address::TEXT,' ', 1) AS numeric) AS street_number
FROM
    address  
)
UPDATE address
SET 
    street_number  = split_query.street_number
FROM split_query
WHERE address.address_id = split_query.address_id;