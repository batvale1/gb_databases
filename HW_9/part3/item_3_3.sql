-- 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность
-- в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

-- обнаружил, что не поддерживается рекурсия. Это как? Вообще не поддерживается в триггерах и хранимках??? Дайте плиз ответ в ревью.
-- пришлось делать на цикле

drop function if exists FIBONACCI;

DELIMITER $$
create function FIBONACCI(number_to_get int)
returns int deterministic
begin
	declare i int default 0;
	declare fib_sum int default 0;
	declare fib1 int default 1;
	declare fib2 int default 1;

	-- вырожденные случаи
	if number_to_get = 1 or number_to_get = 2 then
		return 1;
	end if;

	while i < number_to_get - 2 do
		set fib_sum = fib1 + fib2;
		set fib1 = fib2;
		set fib2 = fib_sum;
		set i = i + 1;
	end while;
	return fib_sum;
end$$

DELIMITER ;

select FIBONACCI(10);
