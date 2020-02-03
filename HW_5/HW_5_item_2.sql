/*Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения 
 * в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.*/
-- сделаем базу под упражнение
drop database if exists test_base;
CREATE database test_base;
use test_base;
create table users  (
	id serial primary key,
	name varchar(200) null,
	created_at varchar(200) null,
	updated_at varchar(200) null
);
-- наполним ее тестовыми данными
INSERT into users (name, created_at, updated_at) values ('Josh', '20.10.2017 8:10', '20.07.2016 8:10');
INSERT into users (name, created_at, updated_at) values ('Lisa', '04.07.2014 8:40', '20.10.2017 8:10');

-- переименовываем изначальные поля
ALTER table users rename column created_at to created_at_initial, RENAME COLUMN updated_at to updated_at_initial; 
-- создаем поля с правильным типом 
ALTER table users add created_at datetime, ADD updated_at datetime;
-- заполняем вновь созданные поля по шаблону
UPDATE users set 
created_at = STR_TO_DATE(created_at_initial, '%d.%m.%Y %h:%i'),
updated_at = STR_TO_DATE(updated_at_initial, '%d.%m.%Y %h:%i');
-- удаляем изначальные колонки
ALTER table users drop created_at_initial, DROP COLUMN updated_at_initial;

SELECT * FROM users;
