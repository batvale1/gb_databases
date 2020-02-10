-- Выведите список товаров products и разделов catalogs, который соответствует товару.

-- создадим БД под задание
drop database if exists test_base;
CREATE database test_base;
use test_base;

-- cities
CREATE table cities (
	label char(200) primary key not null unique,
	name char(200)
);

INSERT into cities (label, name) values
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новогород'),
('kazan', 'Казань'),
('omsk', 'Омск');

-- flights

CREATE table flights (
	id serial primary key,
	`from` char(200),
	`to` char(200),
	foreign key (`from`) references cities(label),
	foreign key (`to`) references cities(label)
);

INSERT into flights(`from`, `to`) values
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan');

-- сам запрос
SELECT 
	flights.id, 
	cities.name as `from`,
	table_to.to as `to`
FROM flights
left join cities on flights.from = cities.label

left JOIN (SELECT 
	flights.id, 
	cities.name as `to`
FROM flights
left join cities on flights.to = cities.label) as table_to on table_to.id = flights.id

order by id;







