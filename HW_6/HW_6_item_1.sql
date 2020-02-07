-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- Выбираем все сообщения от нашего пользователя кому-то одним запросом и считаем их количество (исходящие)
-- вторым запросом выбираем все сообщения нашему пользователю от кого-то и считаем их (входящие)
-- объединяем эти 2 запроса (получаем все сообщения и входящие, и исходящие)
-- и полученную выборку сворачиваем с суммированием количества сообщений
-- по пользователю с которым общался наш пользователь.
-- сортируем по убыванию кол-ва сообщение и берем id нужно нам пользователя из первой записи.
use vk;
SELECT sum(how_many_messages) as how_many_messages, who from (
	SELECT count(1) how_many_messages,
	to_user_id as who
	FROM messages m 
	WHERE from_user_id = 1
	group by to_user_id 
	
	UNION 
	
	SELECT count(1) as how_many_messages,
	from_user_id as who
	FROM messages m 
	WHERE to_user_id = 1
	group by from_user_id
) as records
GROUP by who
order by how_many_messages desc
limit 1;