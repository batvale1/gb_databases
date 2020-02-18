-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

-- сделаем БД
drop database if exists test_db;
create database test_db;
use test_db;

create table dates(
	id serial primary key,
	created_at datetime DEFAULT current_timestamp()
);

insert into dates(created_at) values
('2018-08-01'),
('2018-08-02'),
('2018-08-03'),
('2018-08-04'),
('2018-08-05'),
('2018-08-06'),
('2018-08-07'),
('2018-08-08'),
('2018-08-09'),
('2018-08-10'),
('2018-08-11'),
('2018-08-12'),
('2018-08-13'),
('2018-08-14');

-- само задание.
-- создаем запрос на выборку пяти последних записей.
create or replace view last_five_records_from_dates as select created_at from dates order by created_at desc limit 5;
-- удаляем все записи, которое содержит наше представление
delete from dates where created_at not in (select * from last_five_records_from_dates);
-- ну и результат
select * from dates;




