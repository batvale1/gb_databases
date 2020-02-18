/*2. (по желанию) ѕусть имеетс€ таблица accounts содержаща€ три столбца
 id, name, password, содержащие первичный ключ, им€ пользовател€ и его пароль. 
 —оздайте представление username таблицы accounts, предоставл€ющий доступ к столбца id и name. 
 —оздайте пользовател€ user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать 
 записи из представлени€ username.*/

-- сделаем базу
drop database if exists shop;
create database shop;

use shop;

create table accounts (
	id serial primary key,
	name varchar(255),
	pass varchar(255)
);

-- сделаем тестовую запись.
insert into accounts(name, pass) values ('some name', 'some pass');
-- сделаем представление
create or replace view username(id, name) as select id, name from accounts;

-- ну и создадим пользовател€ и раздадим права.
drop user if exists user_read;
create user user_read identified with sha256_password by '123';
grant select on username to 'user_read'@'%' with grant option;

