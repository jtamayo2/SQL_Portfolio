/*
Case Study:
Exploratory Analysis of a fictitious Movie Rental store.

Using the following:
Simple Select Statements
Aggregate Functions
Inner and Left Joins

Questions:
Need a list of all staff members (first name, last name, email and iD#)
Need separate counts of inventory items held at each of your two stores
Need a count of active customers for each of your stores--separately
Need to provide a count of all customer email addresses in the database
*/

-- Pulling a list of all staff members (first name, last name, email and iD#)
SELECT
	first_name,
	last_name,
	email,
	staff_id
FROM staff;

-- Pulling seperate counts of inventory items held at each of the two stores.
SELECT
	store_id,
	COUNT(inventory_id) AS inventory_items
FROM inventory
GROUP BY
	store_id;

-- A count of active customers for each of your stores--separately.
SELECT
	store_id,
	COUNT(active) AS total_active_customers
FROM customer
WHERE active = 1
GROUP BY
	store_id;

-- Need to provide a count of all customer email addresses in the database.
SELECT
	COUNT(email) AS total_customer_emails
FROM customer;

-- Count of unique (distinct) film titles at each store
SELECT
	store_id,
	COUNT(DISTINCT film_id) AS unique_films
FROM inventory
GROUP BY
	store_id;

-- Count unique(distinct) categories of films we provide. 
SELECT
	COUNT(DISTINCT name) AS unique_categories
FROM category;

-- Minimum, maximum, and average replacement cost.
SELECT
	MIN(replacement_cost) AS lowest_replacement_cost,
	MAX(replacement_cost) AS most_expensive_replacement_cost,
	AVG(replacement_cost) AS avg_replacement_cost
FROM film;

-- Customer rentals ordered by highest amount of rentals. 
SELECT
	customer_id,
	COUNT(rental_id) AS rental_total
FROM rental
GROUP BY
	customer_id
ORDER BY
	COUNT(rental_id) DESC;

-- Film title, description, store_id, inventory_id.
SELECT
	film.title,
	film.description,
	inventory.store_id,
	inventory.inventory_id
FROM film
INNER JOIN inventory
ON film.film_id = inventory.film_id
LIMIT 5000;

SELECT DISTINCT
	inventory.inventory_id, -- tableName.column name
	rental.inventory_id -- tableName.column nanme
FROM inventory
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
LIMIT 5000;

-- Pull list with all titles and and how many actors are associated with each title
SELECT
	film.title,
	COUNT(film_actor.actor_id) AS number_of_actors
FROM film
LEFT JOIN film_actor
ON film_actor.film_id = film.film_id
GROUP BY film.title;

-- List of all actors with each film title that appear in.
SELECT
	actor.first_name,
	actor.last_name,
	film.title
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id

-- List of all unique titles and their description. 
SELECT DISTINCT
film.title,
film.description
FROM film
INNER JOIN inventory
ON film.film_id = inventory.film_id
AND store_id = 2



