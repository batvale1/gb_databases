/*В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.*/
-- сделаем базу под упражнение
drop database if exists test_base;
CREATE database test_base;
use test_base;
create table storehouses_products  (
	id serial primary key,
	description varchar(200) null,
	quantity int not null default 0
);
-- наполним ее тестовыми данными
INSERT into storehouses_products (description, quantity) values ('product 1', 4);
INSERT into storehouses_products (description, quantity) values ('product 2', 3);
INSERT into storehouses_products (description, quantity) values ('product 3', 7);
INSERT into storehouses_products (description, quantity) values ('product 4', 40);
INSERT into storehouses_products (description, quantity) values ('product 5', 0);
INSERT into storehouses_products (description, quantity) values ('product 6', 0);

-- выберем само количество, а также сделаем вычисляемое поле, в котором будем хранить 1, если остаток вообще есть и 0, если его нет
-- после выборки сортируем сначала то, что вообще есть, а потом выводим то, чего вообще нет.
SELECT 
	if (quantity > 0, 1, 0) as is_in_stock,
	quantity
from storehouses_products
order by is_in_stock desc, quantity;
