-- Выведите список товаров products и разделов catalogs, который соответствует товару.

-- создадим БД под задание
drop database if exists test_base;
CREATE database test_base;
use test_base;

-- категории
CREATE table categories (
	id serial primary key,
	category_name varchar(200) null
);

INSERT into categories (category_name) values
('category 1'), 
('category 2'), 
('category 3');

-- товары
create table products  (
	id serial primary key,
	product_name varchar(200) null,
	category_id  BIGINT UNSIGNED NOT NULL,
	foreign key (category_id) references categories(id)
);

INSERT into products (product_name, category_id) values 
('product 1', 2),
('product 2', 2),
('product 3', 3);

-- сам запрос
SELECT product_name, category_name
FROM products
left join categories on products.category_id = categories.id;







