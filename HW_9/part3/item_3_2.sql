-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

-- создадим тестовую базу
drop database if exists test_db;
create database test_db;

drop table if exists products;
create table products(
	id serial primary key,
	name varchar(255),
	description text
);

-- само задание

-- триггер на создание
drop trigger if exists before_insert_products;
delimiter $$
create trigger before_insert_products 
before insert 
	on products for each row
begin 
	if isnull(new.name) and isnull(new.description) then 
		signal sqlstate '45000' set message_text = 'insert. you are not allowed to have null value of both fields name and description';
	end if;
end$$
delimiter ;


-- триггер на обновление
drop trigger if exists before_update_products;
delimiter $$
create trigger before_update_products 
before update 
	on products for each row
begin 
	if new.name is null and new.description is null then 
		signal sqlstate '45000' set message_text = 'update. you are not allowed to have null value of both fields name and description';
	end if;
end$$
delimiter ;

-- тесты
-- insert into products(name, description) values (null, null); -- вставка с ошибкой
insert into products(name, description) values (null, 'test'); -- прошли тест

-- update products set description = null where id = 1; -- апдейт с ошибкой
update products set name = 'test 2', description = null where id = 1; -- прошли тест

select * from products;
