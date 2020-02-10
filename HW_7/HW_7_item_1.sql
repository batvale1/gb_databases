-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

-- создадим БД под задание
drop database if exists test_base;
CREATE database test_base;
use test_base;
-- юзеры
create table users  (
	id serial primary key,
	name varchar(200) null
);
INSERT into users (name) values 
('Marta'),
('Josh'),
('Claud'),
('Sandra'),
('Victoria'),
('Josh'),
('Josh'),
('Josh');

-- заказы
CREATE table orders (
	id serial primary key,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at datetime DEFAULT current_timestamp(),
	FOREIGN KEY (user_id) REFERENCES users(id) 
);

INSERT into orders (user_id) values
(3), 
(3),
(2);

-- сам запрос
SELECT DISTINCT name
FROM orders
LEFT JOIN users on orders.user_id = users.id;





