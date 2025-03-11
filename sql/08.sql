/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */
SELECT f.title
FROM film f
WHERE f.rating = 'G'
  AND EXISTS (
    SELECT 1
    FROM unnest(f.special_features) AS feature
    WHERE feature = 'Trailers'
  )
ORDER BY f.title;
