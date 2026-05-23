USE movielens_db;

SELECT 
    SUM(CASE WHEN user_id    IS NULL THEN 1 ELSE 0 END) AS null_user_id,
    SUM(CASE WHEN gender     IS NULL THEN 1 ELSE 0 END) AS null_gender,
    SUM(CASE WHEN age        IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN occupation IS NULL THEN 1 ELSE 0 END) AS null_occupation,
    SUM(CASE WHEN zip_code   IS NULL THEN 1 ELSE 0 END) AS null_zip_code
FROM users;

SELECT
    SUM(CASE WHEN movie_id     IS NULL THEN 1 ELSE 0 END) AS null_movie_id,
    SUM(CASE WHEN title        IS NULL THEN 1 ELSE 0 END) AS null_title,
    SUM(CASE WHEN release_year IS NULL THEN 1 ELSE 0 END) AS null_release_year
FROM movies;

SELECT
    SUM(CASE WHEN user_id  IS NULL THEN 1 ELSE 0 END) AS null_user_id,
    SUM(CASE WHEN movie_id IS NULL THEN 1 ELSE 0 END) AS null_movie_id,
    SUM(CASE WHEN rating   IS NULL THEN 1 ELSE 0 END) AS null_rating,
    SUM(CASE WHEN rated_at IS NULL THEN 1 ELSE 0 END) AS null_rated_at
FROM ratings;

SELECT 
    user_id, 
    movie_id, 
    COUNT(*) AS count
FROM ratings
GROUP BY user_id, movie_id
HAVING COUNT(*) > 1;

SELECT DISTINCT rating 
FROM ratings
ORDER BY rating;