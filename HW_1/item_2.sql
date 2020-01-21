DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
	name VARCHAR(255)
);
INSERT INTO users (name) VALUES ('Josh');
INSERT INTO users (name) VALUES ('Claud');
INSERT INTO users (name) VALUES ('Rena');
SELECT * FROM users;