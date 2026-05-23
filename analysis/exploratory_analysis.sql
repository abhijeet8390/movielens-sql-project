USE movielens_db;

SELECT gender, COUNT(*) AS total_users
FROM users
GROUP BY gender;

SELECT age, COUNT(*) AS total_users
FROM users
GROUP BY age
ORDER BY age;

SELECT m.title, COUNT(r.rating) AS total_ratings
FROM ratings r
JOIN movies m ON r.movie_id = m.movie_id
GROUP BY m.movie_id, m.title
ORDER BY total_ratings DESC
LIMIT 10;

SELECT m.title, ROUND(AVG(r.rating), 2) AS avg_rating,
COUNT(r.rating) AS total_ratings
FROM ratings r
JOIN movies m ON r.movie_id = m.movie_id
GROUP BY m.movie_id, m.title
HAVING COUNT(r.rating) >= 100
ORDER BY avg_rating DESC
LIMIT 10;

SELECT g.genre_name, COUNT(r.rating) AS total_ratings,
ROUND(AVG(r.rating), 2) AS avg_rating
FROM ratings r
JOIN movie_genres mg ON r.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
GROUP BY g.genre_name
ORDER BY total_ratings DESC;

SELECT 
    CASE 
        WHEN total_ratings >= 500 THEN 'Power User'
        WHEN total_ratings >= 200 THEN 'Active User'
        WHEN total_ratings >= 50  THEN 'Casual User'
        ELSE 'Ghost User'
    END AS user_segment,
    COUNT(*) AS total_users
FROM (
    SELECT user_id, COUNT(rating) AS total_ratings
    FROM ratings
    GROUP BY user_id
) AS user_activity
GROUP BY user_segment
ORDER BY total_users DESC;

SELECT YEAR(rated_at) AS rating_year,
COUNT(*) AS total_ratings,
COUNT(DISTINCT user_id) AS active_users
FROM ratings
GROUP BY rating_year
ORDER BY rating_year;

SELECT MONTH(rated_at) AS rating_month,
COUNT(*) AS total_ratings
FROM ratings
WHERE YEAR(rated_at) = 2000
GROUP BY rating_month
ORDER BY rating_month;