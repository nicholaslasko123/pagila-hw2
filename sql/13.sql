/*
 * Create a report that shows the total number of rentals per year and month.
 *
 * HINT:
 * The ROLLUP clause is a convenient syntactic sugar for complicated combinations of GROUP BY and UNION clauses.
 * Although we won't cover this syntax in class, there is a great tutorial at
 * <https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rollup/>.
 * The tutorial is based off of the pagila database's rental table,
 * and contains a query that almost solves this problem.
 */
WITH RentalData AS (
    SELECT rental_id,
           EXTRACT(YEAR FROM rental_date) AS year,
           EXTRACT(MONTH FROM rental_date) AS month
    FROM rental
)
SELECT year AS "Year",
       month AS "Month",
       COUNT(rental_id) AS "Total Rentals"
FROM RentalData
GROUP BY ROLLUP (year, month)
ORDER BY "Year", "Month";
