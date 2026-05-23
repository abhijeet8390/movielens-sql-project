

CREATE DATABASE IF NOT EXISTS movielens_db;
USE movielens_db;

CREATE TABLE users (
    user_id    INT PRIMARY KEY,
    gender     CHAR(1),
    age        INT,
    occupation INT,
    zip_code   VARCHAR(10)
);

CREATE TABLE occupations (
    occupation_id   INT PRIMARY KEY,
    occupation_name VARCHAR(50)
);

CREATE TABLE movies (
    movie_id     INT PRIMARY KEY,
    title        VARCHAR(200),
    release_year INT
);

CREATE TABLE genres (
    genre_id   INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE movie_genres (
    movie_id  INT,
    genre_id  INT,
    PRIMARY KEY (movie_id, genre_id)
);

CREATE TABLE ratings (
    user_id  INT,
    movie_id INT,
    rating   TINYINT,
    rated_at DATETIME,
    PRIMARY KEY (user_id, movie_id)
);