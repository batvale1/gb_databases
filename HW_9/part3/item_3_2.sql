-- 2. � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. ��������� ����������� ����� ����� ��� ���� �� ���. 
-- ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. 
-- ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.

-- �������� �������� ����
drop database if exists test_db;
create database test_db;

drop table if exists products;
create table products(
	id serial primary key,
	name varchar(255),
	description text
);

-- ���� �������

-- ������� �� ��������
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


-- ������� �� ����������
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

-- �����
-- insert into products(name, description) values (null, null); -- ������� � �������
insert into products(name, description) values (null, 'test'); -- ������ ����

-- update products set description = null where id = 1; -- ������ � �������
update products set name = 'test 2', description = null where id = 1; -- ������ ����

select * from products;
