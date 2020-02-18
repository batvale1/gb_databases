-- 1. � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.

-- ������� �� shop
drop database if exists shop;
create database shop;

use shop;

create table users (
	id serial primary key,
	name varchar(100)
);

insert into users (name) values
('Josh'),
('Lisa');

-- ������� �� sample
drop database if exists sample;
create database sample;

use sample;
create table users (
	id serial primary key,
	name varchar(100)
);

-- ���������� ������ ����������
start transaction;

insert into sample.users
select u.id, u.name from shop.users u where u.id = 1;

commit;

select * from sample.users;
