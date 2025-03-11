/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT DISTINCT mov.title
FROM film AS mov
JOIN inventory AS inv ON mov.film_id = inv.film_id
LEFT JOIN (
    SELECT DISTINCT mov2.film_id AS us_film
    FROM film AS mov2
    JOIN inventory AS inv2 ON mov2.film_id = inv2.film_id
    JOIN rental AS r ON inv2.inventory_id = r.inventory_id
    JOIN customer AS cust ON r.customer_id = cust.customer_id
    JOIN address AS addr ON cust.address_id = addr.address_id
    JOIN city AS ct ON addr.city_id = ct.city_id
    JOIN country AS cntry ON ct.country_id = cntry.country_id
    WHERE cntry.country = 'United States'
) AS us_rentals ON mov.film_id = us_rentals.us_film
WHERE us_rentals.us_film IS NULL
ORDER BY mov.title;
