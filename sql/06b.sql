/*
 * This problem is the same as 06.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT f.title
FROM film AS f
LEFT JOIN inventory AS inv ON f.film_id = inv.film_id
WHERE inv.film_id IS NULL
ORDER BY f.title;
