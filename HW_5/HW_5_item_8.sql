/*(по желанию) Подсчитайте произведение чисел в столбце таблицы*/
-- сделаем базу под упражнение
drop database if exists test_base;
CREATE database test_base;
use test_base;
create table numbers  (
	id serial primary key,
	number_value int not null
);
-- наполним ее тестовыми данными
INSERT into numbers (number_value) values (1);
INSERT into numbers (number_value) values (2);
INSERT into numbers (number_value) values (3);
INSERT into numbers (number_value) values (4);
INSERT into numbers (number_value) values (5);

-- это задание вообще мало относится mysql, больше к алгебре.
-- произведение чисел есть экспонента от суммы логарифмов складываемых чисел.
select exp(sum(ln(number_value))) from numbers;