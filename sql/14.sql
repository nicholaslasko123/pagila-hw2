/*
 * Create a report that shows the total revenue per month and year.
 *
 * HINT:
 * This query is very similar to the previous problem,
 * but requires an additional JOIN.
 */
WITH RevenueData AS (
  SELECT
    EXTRACT(YEAR FROM r.rental_date) AS rental_year,
    EXTRACT(MONTH FROM r.rental_date) AS rental_month,
    p.amount
  FROM rental AS r
  JOIN payment AS p ON r.rental_id = p.rental_id
)
SELECT
  rental_year AS "Year",
  rental_month AS "Month",
  SUM(amount) AS "Total Revenue"
FROM RevenueData
GROUP BY ROLLUP(rental_year, rental_month)
ORDER BY "Year", "Month";
