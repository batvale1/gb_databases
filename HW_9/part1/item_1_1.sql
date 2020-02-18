-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

-- сделаем БД shop
drop database if exists shop;
create database shop;

use shop;

create table users (
	id serial primary key,
	name varchar(100)
);

insert into users (name) values
('Josh'),
('Lisa');

-- сделаем БД sample
drop database if exists sample;
create database sample;

use sample;
create table users (
	id serial primary key,
	name varchar(100)
);

-- выполнение самого упражнения
start transaction;

insert into sample.users
select u.id, u.name from shop.users u where u.id = 1;

commit;

select * from sample.users;
