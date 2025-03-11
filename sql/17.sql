/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */
WITH ranked_films AS (
  SELECT
    RANK() OVER (ORDER BY COALESCE(SUM(amount), 0.00) DESC) AS rank,
    title,
    COALESCE(SUM(amount), 0.00) AS revenue
  FROM film
  LEFT JOIN inventory USING (film_id)
  LEFT JOIN rental USING (inventory_id)
  LEFT JOIN payment USING (rental_id)
  GROUP BY title
)
SELECT
  r1.rank,
  r1.title,
  r1.revenue,
  SUM(r2.revenue) AS "total revenue"
FROM ranked_films r1
JOIN ranked_films r2 ON r2.rank <= r1.rank
GROUP BY r1.rank, r1.title, r1.revenue
ORDER BY r1.rank, r1.title;
