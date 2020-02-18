/*2. (�� �������) ����� ������� ������� accounts ���������� ��� �������
 id, name, password, ���������� ��������� ����, ��� ������������ � ��� ������. 
 �������� ������������� username ������� accounts, ��������������� ������ � ������� id � name. 
 �������� ������������ user_read, ������� �� �� ���� ������� � ������� accounts, ������, ��� �� ��������� 
 ������ �� ������������� username.*/

-- ������� ����
drop database if exists shop;
create database shop;

use shop;

create table accounts (
	id serial primary key,
	name varchar(255),
	pass varchar(255)
);

-- ������� �������� ������.
insert into accounts(name, pass) values ('some name', 'some pass');
-- ������� �������������
create or replace view username(id, name) as select id, name from accounts;

-- �� � �������� ������������ � �������� �����.
drop user if exists user_read;
create user user_read identified with sha256_password by '123';
grant select on username to 'user_read'@'%' with grant option;

