/*(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')*/
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

-- ну сделаем выборку через IN
SELECT * from users WHERE mounth_of_birthday in ('may', 'august');