-- 1. �������� ���� ������������� ������� ����� ������ � ���� ������ shop. ������� ������������ shop_read ������ ���� �������� 
-- ������ ������� �� ������ ������, ������� ������������ shop � ����� �������� � �������� ���� ������ shop.

-- ������� ����
drop database if exists shop;
create database shop;

use shop;

create table products (
	id serial primary key,
	name varchar(255)
);

drop user if exists user1;
drop user if exists user2;
create user if not exists user1 identified with sha256_password by '123';
create user if not exists user2 identified with sha256_password by '321';

GRANT SELECT ON shop.* TO 'user1'@'%' WITH GRANT OPTION;
GRANT ALL ON shop.* to 'user2'@'%' WITH GRANT OPTION;

select * from mysql.user;
