-- 3. �� �������) ����� ������� ������� � ����������� ����� created_at. � ��� ��������� ���������� ����������� ������ �� ������ 2018 ���� '2018-08-01', '2016-08-04', '2018-08-16' � 2018-08-17. 
-- ��������� ������, ������� ������� ������ ������ ��� �� ������, ��������� � �������� ���� �������� 1, ���� ���� ������������ � �������� ������� � 0, ���� ��� �����������.

-- ������� ��
drop database if exists test_db;
create database test_db;
use test_db;

create table catalogs(
	id serial primary key,
	cat_name varchar(100),
	created_at datetime DEFAULT current_timestamp()
);

insert into catalogs(cat_name, created_at) values
('videocards', '2018-08-01'),
('motherboards', '2018-08-04'),
('ssds', '2018-08-04'),
('processors', '2018-08-17');


-- ���� �������.

set @mindate = (select min(created_at) from catalogs); -- ����������� ���� �������
set @mindate_of_month = date_add(@mindate,interval - DAY(@mindate)+ 1 DAY); -- ������ ������ ����������� ����
set @maxdate_of_month = last_day((select max(created_at) from catalogs)); -- ��������� ���� ������, � ������� ���� ����.

-- ������� ���. ������� � ������� ����� ���, ��� �� ���� ����. ���������:
-- 1) ������� ������� � ������� ����������� ������, ����� ����� ����� �� ��� ������ ��� �������� ������������ ������� �����������.
-- 2) ��� ������ ���� ������ ��� ����������� ��������.
-- 3) ��� ������ ����� �� �������� ���� ���������� �������.
drop temporary table if exists dates;
create temporary table dates
SELECT ADDDATE(@mindate_of_month, INTERVAL @i:=@i+1 DAY) AS day 
FROM (
SELECT a.a
FROM (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
CROSS JOIN (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
CROSS JOIN (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS c
) a
JOIN (SELECT @i := -1) r1
WHERE 
@i < DATEDIFF(@maxdate_of_month, @mindate_of_month);

-- ��������� ��� ������� � �������� ���������� created_at. ������ �����������, ����� ���������� �� ��������.
select `day`, max(if(isnull(c.created_at), 0, 1)) as has_record
from dates
left join catalogs c on c.created_at = dates.day
group by `day`
order by `day`;

drop temporary table dates;