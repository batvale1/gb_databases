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
INSERT into users (name, date_of_birth) values ('Josh', '1906-11-08'); -- sun for 2020
INSERT into users (name, date_of_birth) values ('Marta', '1946-03-20'); -- fri for 2020
INSERT into users (name, date_of_birth) values ('Josh', '1987-11-25'); -- wed for 2020
INSERT into users (name, date_of_birth) values ('Claud', '2005-04-14'); -- tue for 2020
INSERT into users (name, date_of_birth) values ('Sandra', '1997-11-11'); -- wed for 2020
INSERT into users (name, date_of_birth) values ('Victoria', '1986-03-03'); -- tue for 2020

/*Допущение: я не рассматриваю дни рождения в високосные года, ибо в этом случае надо будет через if сделать проверку на деление на 4, 100, 400, чтобы убедиться в том, что год високосный
и тогда решить, что делать с 29 февраля, либо относить его на 28.02 или на 01.03.
Суть: берем год от текущей даты "2020", добавляем к нем месяц и день от дня рождения "04-14", определяем что это за день недели. Ну и группируем по 1, чтобы подсчет произвести.*/

SELECT
	DATE_FORMAT( str_to_date( CONCAT(DATE_FORMAT(CURRENT_DATE(), '%Y') , '-', DATE_FORMAT(date_of_birth, '%m-%d')) , '%Y-%m-%d'), '%a') dayweek,
	COUNT(1) number_of_users
FROM
	users
GROUP BY
	dayweek;