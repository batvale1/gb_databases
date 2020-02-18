-- 1. �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", 
-- � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".
drop function if exists hello;

DELIMITER $$
create function hello()
returns varchar(255) deterministic
begin
	DECLARE cur_time int;
	set cur_time = date_format(now(), '%k');
	if (cur_time > 6 and cur_time <= 12) then 
		return '������ ����';
	elseif (cur_time > 12 and cur_time <= 18) then 
		return '������ ����';
	elseif (cur_time > 18 and cur_time <= 24) then 
		return '������ �����';
	elseif (cur_time >= 00 and cur_time <= 6) then  
		return '������ ���� 1';
	else
		return '���-�� �� ���...';
	end if;
end$$

DELIMITER ;

select hello();
