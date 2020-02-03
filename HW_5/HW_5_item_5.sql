/*(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.*/
-- сделаем базу под упражнение
drop database if exists test_base;
CREATE database test_base;
use test_base;
create table users  (
	id serial primary key,
	name varchar(200) null,
	mounth_of_birthday enum ('january','february','march','april', 'may', 'june', 'july', 'august') default null
);
-- наполним ее тестовыми данными
INSERT into users (name, mounth_of_birthday) values ('Josh', 'june');
INSERT into users (name, mounth_of_birthday) values ('Marta', 'march');
INSERT into users (name, mounth_of_birthday) values ('Josh', 'may');
INSERT into users (name, mounth_of_birthday) values ('Claud', 'july');
INSERT into users (name, mounth_of_birthday) values ('Sandra', 'august');
INSERT into users (name, mounth_of_birthday) values ('Victoria', 'february');

-- сделаем выборку через IN и упорядочим выборку через field
SELECT * from users WHERE id in (5, 1, 2) order by field(id, 5, 1, 2);