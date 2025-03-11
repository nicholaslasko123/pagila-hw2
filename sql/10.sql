/*
 * Management is planning on purchasing new inventory.
 * Films with special features cost more to purchase than films without special features,
 * and so management wants to know if the addition of special features impacts revenue from movies.
 *
 * Write a query that for each special_feature, calculates the total profit of all movies rented with that special feature.
 *
 * HINT:
 * Start with the query you created in pagila-hw1 problem 16, but add the special_features column to the output.
 * Use this query as a subquery in a select statement similar to answer to the previous problem.
 */
WITH FeatureProfit AS (
  SELECT unnest(f.special_features) AS special_feature,
         p.amount AS revenue
  FROM film AS f
  JOIN inventory AS i ON f.film_id = i.film_id
  JOIN rental AS r ON i.inventory_id = r.inventory_id
  JOIN payment AS p ON r.rental_id = p.rental_id
)
SELECT special_feature, SUM(revenue) AS profit
FROM FeatureProfit
GROUP BY special_feature
ORDER BY special_feature ASC;
