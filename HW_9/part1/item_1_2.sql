-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

-- сделаем БД
drop database if exists test_db;
create database test_db;
use test_db;

create table catalogs(
	id serial primary key,
	cat_name varchar(100)
);

insert into catalogs(cat_name) values
('videocards'),
('motherboards');

create table products(
	id serial primary key,
	cat_id bigint unsigned  not null,
	prod_name varchar(100),
	foreign key (cat_id) references catalogs(id)
);

insert into products(cat_id, prod_name) values
(1, 'gtx 1080'),
(1, 'gtx 1080 ti'),
(2, 'asus motherboard'),
(2, 'zotac motherboard');

-- само упражнение
create view or replace view products_view as
select prod_name, cat_name from products left join catalogs on products.cat_id = catalogs.id;
select * from products_view;

