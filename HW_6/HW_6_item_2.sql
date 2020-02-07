-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

-- без соединений задача лишь в том, чтобы найти всех пользователей младше 10 лет 
-- в таблице profiles и только для них
-- подсчитать количество записей в таблице likesю
use vk;
SELECT count(1),
user_id
from likes
WHERE user_id IN (
	SELECT user_id FROM profiles where TIMESTAMPDIFF(YEAR, birthday, current_date()) < 10
)
GROUP by user_id;
