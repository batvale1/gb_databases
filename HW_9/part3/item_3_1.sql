-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
drop function if exists hello;

DELIMITER $$
create function hello()
returns varchar(255) deterministic
begin
	DECLARE cur_time int;
	set cur_time = date_format(now(), '%k');
	if (cur_time > 6 and cur_time <= 12) then 
		return 'Доброе утро';
	elseif (cur_time > 12 and cur_time <= 18) then 
		return 'Добрый день';
	elseif (cur_time > 18 and cur_time <= 24) then 
		return 'Добрый вечер';
	elseif (cur_time >= 00 and cur_time <= 6) then  
		return 'Доброе утро 1';
	else
		return 'Что-то не так...';
	end if;
end$$

DELIMITER ;

select hello();
