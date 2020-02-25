/*1. �������� ������� logs ���� Archive. ����� ��� ������ �������� ������ � �������� users, catalogs � products � ������� logs ���������� 
����� � ���� �������� ������, �������� �������, ������������� ���������� ����� � ���������� ���� name.*/

-- ������� �������� ��
drop database if exists test_db;
create database test_db;
use test_db;

-- �������� ������� �����
drop table if exists logs;

create table logs (
	created_at datetime,
	table_name varchar(100),
	table_id bigint,
	name varchar(200)
) engine=archive;

-- �������� ������� �������������, ��������� � ���������
drop table if exists users;
create table users(
	id serial primary key,
	name varchar(200)
);

drop table if exists products;
create table products(
	id serial primary key,
	name varchar(200)
);
drop table if exists catalogs;
create table catalogs(
	id serial primary key,
	name varchar(200)
);

-- �������� �������� �� ������� ������ � ���� ������� � ����������� ������ � ������� logs
drop trigger if exists users_after_add;
drop trigger if exists products_after_add;
drop trigger if exists catalogs_after_add;

delimiter $$
create trigger users_after_add 
after insert 
on users for each row
	begin 
		insert into logs(created_at, table_name, table_id, name) values
		(CURRENT_TIMESTAMP, 'users', new.id, new.name);
	end$$
	
create trigger products_after_add 
after insert 
on products for each row
	begin 
		insert into logs(created_at, table_name, table_id, name) values
		(CURRENT_TIMESTAMP, 'products', new.id, new.name);
	end$$
	
create trigger catalogs_after_add 
after insert 
on catalogs for each row
	begin 
		insert into logs(created_at, table_name, table_id, name) values
		(CURRENT_TIMESTAMP, 'catalogs', new.id, new.name);
	end$$
	
delimiter ;

-- ������� �������� ������
insert into users(name) values
('josh'),
('lisa');

insert into products(name) values
('product 1'),
('product 2');

insert into catalogs(name) values
('category 1'),
('category 1');

-- �� � ��������
select * from logs;
