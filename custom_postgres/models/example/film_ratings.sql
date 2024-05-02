WITH films_with_ratings AS (
    SELECT 
        film_id,
        title,
        release_date,
        price,
        rating,
        user_rating,
        CASE 
            WHEN rating >= 4.5 THEN 'Excellent'
            WHEN rating >= 4.0 THEN 'Good'
            WHEN rating >= 3.0 THEN 'Average'
            ELSE 'Poor'
        END AS rating_category
    FROM {{ ref('films') }}
),

films_with_actors AS (
    SELECT
        f.film_id,
        f.title,
        STRING_AGG(a.actor.name, ',') AS actors
    FROM {{ ref('films') }} f 
    LEFT JOIN {{ ref('film_actors') }} fa ON f.film_id = fa.film_id
    LEFT JOIN {{ ref('actors') }} a ON fa.actor_id = a.actor_id
    GROUP BY f.film_id, f.title  
)

SELECT 
    fwf.*,
    fwa.actors
FROM films_with_ratigs    