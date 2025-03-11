/*
 * Compute the total revenue for each film.
 */
WITH FilmRevenues AS (
    SELECT i.film_id,
           SUM(COALESCE(p.amount, 0)) AS total_revenue
    FROM inventory i
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY i.film_id
)
SELECT f.title,
       COALESCE(fr.total_revenue, 0)::numeric(10,2) AS revenue
FROM film f
LEFT JOIN FilmRevenues fr ON f.film_id = fr.film_id
ORDER BY revenue DESC, f.title ASC;
