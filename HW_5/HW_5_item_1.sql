/*Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.*/
-- сделаем базу под упражнение
drop database if exists test_base;
CREATE database test_base;
use test_base;
create table users  (
	id serial primary key,
	name varchar(200) null,
	created_at datetime null,
	updated_at datetime null
);

-- наполним ее тестовыми данными
INSERT into users (name) values ('Josh');
INSERT into users (name) values ('Lisa');

UPDATE users SET created_at = now(), 
updated_at = now() 
WHERE created_at is null and updated_at is null;

SELECT * FROM users;