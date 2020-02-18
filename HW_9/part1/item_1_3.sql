-- 3. по желанию) ѕусть имеетс€ таблица с календарным полем created_at. ¬ ней размещены разр€женые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
-- —оставьте запрос, который выводит полный список дат за август, выставл€€ в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

-- сделаем Ѕƒ
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


-- само задание.

set @mindate = (select min(created_at) from catalogs); -- минимальна€ дата таблицы
set @mindate_of_month = date_add(@mindate,interval - DAY(@mindate)+ 1 DAY); -- начало мес€ца минимальной даты
set @maxdate_of_month = last_day((select max(created_at) from catalogs)); -- последний день мес€ца, в котором есть даты.

-- таблица дат. ”сложил в учебных цел€х тем, что не юзаю цикл. ѕолучение:
-- 1) —оздаем таблицу с большим количеством данных, чтобы потом юзать ее как данные дл€ итераций элементарным послным соединением.
-- 2) ѕри выборе даты каждый раз увеличиваем итератор.
-- 3)  ак только дошли до конечной даты прекращаем выборку.
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

-- св€зываем эту таблицу с таблицей содержащей created_at. ƒелаем группировку, чтобы избавитьс€ от дубл€жей.
select `day`, max(if(isnull(c.created_at), 0, 1)) as has_record
from dates
left join catalogs c on c.created_at = dates.day
group by `day`
order by `day`;

drop temporary table dates;