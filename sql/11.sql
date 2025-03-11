/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */
SELECT DISTINCT UPPER(CONCAT(a.first_name, ' ', a.last_name)) AS "Actor Name"
FROM public.actor a
JOIN public.film_actor fa ON a.actor_id = fa.actor_id
JOIN (
    SELECT f.film_id
    FROM public.film f, unnest(f.special_features) AS feature
    WHERE feature = 'Behind the Scenes'
) AS fs ON fa.film_id = fs.film_id
ORDER BY "Actor Name";
