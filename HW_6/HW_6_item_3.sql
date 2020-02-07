-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

-- Снова задача без использования соединений.
-- выбираем пол из таблицы profiles на каждую запись таблицы likes
-- превращаем представление данных из id в удобное для чтение нам
-- суммируем записи с группировкой по полу
-- сортируем по убыванию и получаем кто и сколько налайкал в порядке убывания по полу

USE vk;
SELECT
	COUNT(1) AS how_many_likes,
	CASE
		(
		SELECT
			gender
		FROM
			profiles p
		WHERE
			user_id = likes.user_id)
		WHEN 0 THEN 'female'
		WHEN 1 THEN 'male'
		ELSE 'animal' END AS gender
	FROM
		likes
	GROUP BY
		gender
	ORDER by how_many_likes desc
	LIMIT 1;