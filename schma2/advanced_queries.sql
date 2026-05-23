USE movielens_db;

WITH genre_gender AS (
    SELECT u.gender, g.genre_name,
    COUNT(*) AS total_ratings,
    ROUND(AVG(r.rating),2) AS avg_rating
    FROM ratings r
    JOIN users u ON r.user_id = u.user_id
    JOIN movie_genres mg ON r.movie_id = mg.movie_id
    JOIN genres g ON mg.genre_id = g.genre_id
    GROUP BY u.gender, g.genre_name
)
SELECT * FROM genre_gender
ORDER BY gender, total_ratings DESC;

SELECT m.title,
COUNT(r.rating) AS total_ratings,
ROW_NUMBER() OVER (ORDER BY COUNT(r.rating) DESC) AS row_num,
RANK() OVER (ORDER BY COUNT(r.rating) DESC) AS rnk,
DENSE_RANK() OVER (ORDER BY COUNT(r.rating) DESC) AS dense_rnk
FROM ratings r
JOIN movies m ON r.movie_id = m.movie_id
GROUP BY m.movie_id, m.title
ORDER BY rnk
LIMIT 10;

CREATE VIEW user_engagement AS
SELECT u.user_id, u.gender, u.age,
COUNT(r.rating) AS total_ratings,
ROUND(AVG(r.rating),2) AS avg_rating,
CASE 
    WHEN COUNT(r.rating) >= 500 THEN 'Power User'
    WHEN COUNT(r.rating) >= 200 THEN 'Active User'
    WHEN COUNT(r.rating) >= 50  THEN 'Casual User'
    ELSE 'Ghost User'
END AS user_segment
FROM users u
JOIN ratings r ON u.user_id = r.user_id
GROUP BY u.user_id, u.gender, u.age;

DELIMITER //
CREATE PROCEDURE GetMoviesByGenre(IN genre_input VARCHAR(50))
BEGIN
    SELECT m.title, m.release_year,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(r.rating) AS total_ratings
    FROM movies m
    JOIN movie_genres mg ON m.movie_id = mg.movie_id
    JOIN genres g ON mg.genre_id = g.genre_id
    JOIN ratings r ON m.movie_id = r.movie_id
    WHERE g.genre_name = genre_input
    GROUP BY m.movie_id, m.title, m.release_year
    ORDER BY avg_rating DESC
    LIMIT 10;
END //
DELIMITER ;