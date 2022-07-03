use sakila;
-- 1
-- How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT COUNT(inventory_id) as number_of_copies, f.title 
FROM sakila.film f
JOIN sakila.inventory i USING (film_id)
WHERE f.title='Hunchback Impossible';

-- 2
-- List all films whose length is longer than the average of all the films.

SELECT AVG(length) FROM film;

SELECT title, film_id, length FROM film
WHERE length > (
		SELECT AVG(length)
		FROM film);

-- 3
-- Use subqueries to display all actors who appear in the film Alone Trip.

select CONCAT(first_name,' ',last_name) as 'Actors in Alone Trip'
from actor
where actor_id in 
	(select actor_id from film_actor where film_id = 
	(select film_id from film where title = 'Alone Trip'));

-- 4
-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

select f.title as 'Movie Title'
	from film as f
	join film_category as fc on fc.film_id = f.film_id
	join category as c on c.category_id = fc.category_id
	where c.name = 'Family';

-- 5 
-- Get name and email from customers from Canada using subqueries. Do the same with joins.
# subqueries


# joins
select concat(c.first_name,' ',c.last_name) as 'Name', c.email as 'E-mail'
	from customer as c
	join address as a on c.address_id = a.address_id
	join city as cy on a.city_id = cy.city_id
	join country as ct on ct.country_id = cy.country_id
	where ct.country = 'Canada';

-- 6 
-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 

SELECT act.first_name, act.last_name FROM actor act
JOIN film_actor film_act USING (actor_id)
GROUP BY act.actor_id, act.first_name, act.last_name
LIMIT 1;


-- 7
-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments




-- 8
-- Customers who spent more than the average payments.

SELECT * FROM customer;
SELECT * FROM payment;

SELECT CONCAT(first_name, " " , last_name) AS NAME 
    FROM customer
    WHERE customer_id IN (
        SELECT customer_id
        FROM payment
        GROUP BY customer_id
        ORDER BY AVG(amount) DESC);
        
