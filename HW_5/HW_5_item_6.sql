/*Подсчитайте средний возраст пользователей в таблице users*/
-- сделаем базу под упражнение
drop database if exists test_base;
CREATE database test_base;
use test_base;
create table users  (
	id serial primary key,
	name varchar(200) null,
	date_of_birth date default null
);
-- наполним ее тестовыми данными
INSERT into users (name, date_of_birth) values ('Josh', '1906-11-08');
INSERT into users (name, date_of_birth) values ('Marta', '1946-03-20');
INSERT into users (name, date_of_birth) values ('Josh', '1987-11-25');
INSERT into users (name, date_of_birth) values ('Claud', '2005-04-14');
INSERT into users (name, date_of_birth) values ('Sandra', '1997-11-11');
INSERT into users (name, date_of_birth) values ('Victoria', '1986-03-03');

-- юзаем простую функцию, показывающую разность дат в нужно разрезе, берем среднее из выборки, округляем до 2 знаков.
SELECT round(avg(TIMESTAMPDIFF(YEAR, date_of_birth, current_date())), 2) FROM users;