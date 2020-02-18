-- 3. (�� �������) �������� �������� ������� ��� ���������� ������������� ����� ���������. ������� ��������� ���������� ������������������
-- � ������� ����� ����� ����� ���� ���������� �����. ����� ������� FIBONACCI(10) ������ ���������� ����� 55.

-- ���������, ��� �� �������������� ��������. ��� ���? ������ �� �������������� � ��������� � ���������??? ����� ���� ����� � �����.
-- �������� ������ �� �����

drop function if exists FIBONACCI;

DELIMITER $$
create function FIBONACCI(number_to_get int)
returns int deterministic
begin
	declare i int default 0;
	declare fib_sum int default 0;
	declare fib1 int default 1;
	declare fib2 int default 1;

	-- ����������� ������
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
