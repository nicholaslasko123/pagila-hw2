/*
 * A group of social scientists is studying American movie watching habits.
 * To help them, select the titles of all films that have never been rented by someone who lives in the United States.
 *
 * NOTE:
 * Not every film in the film table is available in the store's inventory,
 * and you should only return films in the inventory.
 *
 * NOTE:
 * This can be solved by either using a LEFT JOIN or by using the NOT IN clause and a subquery.
 * For this problem, you should use the NOT IN clause;
 * in problem 07b you will use the LEFT JOIN clause.
 *
 * NOTE:
 * This is the last problem that will require you to use a particular method to solve the query.
 * In future problems, you may choose whether to use the LEFT JOIN or NOT IN clause if they are more applicable.
 */
SELECT DISTINCT mov.title
FROM film AS mov
JOIN inventory AS inv ON mov.film_id = inv.film_id
WHERE mov.film_id NOT IN (
    SELECT mov2.film_id
    FROM film AS mov2
    JOIN inventory AS inv2 ON mov2.film_id = inv2.film_id
    JOIN rental AS r ON inv2.inventory_id = r.inventory_id
    JOIN customer AS cust ON r.customer_id = cust.customer_id
    JOIN address AS addr ON cust.address_id = addr.address_id
    JOIN city AS ct ON addr.city_id = ct.city_id
    JOIN country AS cntry ON ct.country_id = cntry.country_id
    WHERE cntry.country = 'United States'
)
ORDER BY mov.title;
