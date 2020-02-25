/*1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается 
время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.*/

-- сделаем тестовую БД
drop database if exists test_db;
create database test_db;
use test_db;

-- создадим таблицу логов
drop table if exists logs;

create table logs (
	created_at datetime,
	table_name varchar(100),
	table_id bigint,
	name varchar(200)
) engine=archive;

-- создадим таблицы пользователей, продуктов и категорий
drop table if exists users;
create table users(
	id serial primary key,
	name varchar(200)
);

drop table if exists products;
create table products(
	id serial primary key,
	name varchar(200)
);
drop table if exists catalogs;
create table catalogs(
	id serial primary key,
	name varchar(200)
);

-- создадим триггеры на успешую запись в наши таблицы с добавлением записи в таблицу logs
drop trigger if exists users_after_add;
drop trigger if exists products_after_add;
drop trigger if exists catalogs_after_add;

delimiter $$
create trigger users_after_add 
after insert 
on users for each row
	begin 
		insert into logs(created_at, table_name, table_id, name) values
		(CURRENT_TIMESTAMP, 'users', new.id, new.name);
	end$$
	
create trigger products_after_add 
after insert 
on products for each row
	begin 
		insert into logs(created_at, table_name, table_id, name) values
		(CURRENT_TIMESTAMP, 'products', new.id, new.name);
	end$$
	
create trigger catalogs_after_add 
after insert 
on catalogs for each row
	begin 
		insert into logs(created_at, table_name, table_id, name) values
		(CURRENT_TIMESTAMP, 'catalogs', new.id, new.name);
	end$$
	
delimiter ;

-- вставим тестовые данные
insert into users(name) values
('josh'),
('lisa');

insert into products(name) values
('product 1'),
('product 2');

insert into catalogs(name) values
('category 1'),
('category 1');

-- ну и проверим
select * from logs;
