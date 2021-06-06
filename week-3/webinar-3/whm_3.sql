-- 1. Get info on rental date by customer:
SELECT first_name, last_name, rental_date FROM customer c
JOIN rental r ON r.customer_id = c.customer_id;

-- 2. Join Actors and Film table:
SELECT first_name, last_name, title FROM film_actor fa
JOIN actor a ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id 
LIMIT 3;

-- 3. Count the number of films per each actor:
SELECT first_name, last_name, COUNT(title) FROM film_actor fa
JOIN actor a ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id 
GROUP BY first_name, last_name ORDER BY last_name;

--4. Get customer (first_name and last_name), rental_date, and film title:
SELECT first_name, last_name, rental_date, title  FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id;

--5.Get customer (first_name and last_name), rental_date, and category name:
SELECT first_name, last_name, rental_date, name  FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film_category fc ON fc.film_id = i.film_id
JOIN category ct ON fc.category_id = ct.category_id;

--6. Get customer (first_name and last_name), category name, and count of occurrencies:
SELECT first_name, last_name, name, COUNT(*)  FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film_category fc ON fc.film_id = i.film_id
JOIN category ct ON fc.category_id = ct.category_id
GROUP BY first_name, last_name, name ORDER BY last_name, name;
