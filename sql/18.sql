/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
WITH film_rev AS (
  SELECT
    f.title,
    COALESCE(SUM(p.amount), 0.00)::numeric(10,2) AS revenue
  FROM film f
  LEFT JOIN inventory i ON i.film_id = f.film_id
  LEFT JOIN rental r ON i.inventory_id = r.inventory_id
  LEFT JOIN payment p ON r.rental_id = p.rental_id
  GROUP BY f.title
),
ranked AS (
  SELECT
    title,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS rank
  FROM film_rev
),
cumulative AS (
  SELECT
    rank,
    title,
    revenue,
    SUM(revenue) OVER (ORDER BY rank) AS cumulative_revenue,
    SUM(revenue) OVER () AS overall_revenue
  FROM ranked
)
SELECT
  rank,
  title,
  revenue,
  cumulative_revenue AS "total revenue",
  to_char(100 * cumulative_revenue / overall_revenue, 'FM900.00') AS "percent revenue"
FROM cumulative
ORDER BY rank, title;
