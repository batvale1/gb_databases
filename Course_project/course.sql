drop database if exists civilization;
create database civilization;

use civilization;

-- 1) тип местности ячейки игровой карты мира
create table terrain_types(
	id serial primary key,
	terrain_type varchar(100)
);

-- 2) игровая карта мира
CREATE table game_field(
	id serial primary key,
	x bigint,
	y bigint,
	id_tt BIGINT UNSIGNED NOT NULL,
	index (id_tt),
	foreign KEY (id_tt) references terrain_types(id) on UPDATE cascade on DELETE CASCADE
);


-- 3) улучшения ячеек игровой карты мира
create table terrain_upgrades_types (
	id serial primary key,
	terrain_upgrade_type varchar(100)
);

-- 4) таблица соответствий того, каким образом тип территорий можно улучишить. 
-- Например, можно построить рудник в горах или на холмах, но нельзя построить ферму в горах.
create table terrain_types_possible_upgrades (
id_tt BIGINT UNSIGNED NOT NULL,
id_tup BIGINT UNSIGNED NOT NULL,
index (id_tt),
index (id_tup),
foreign key (id_tt) references terrain_types(id) on UPDATE cascade on DELETE CASCADE,
foreign key (id_tup) references terrain_upgrades_types(id) on UPDATE cascade on DELETE CASCADE
);

-- 5) таблица наций
CREATE table nations(
	id serial primary key,
	nation_name varchar(150) -- не будем делать индекс, по имени никогда ничего искать не будем
);

-- 6) таблица городов, которыми владеет нация
create table cities(
	id serial primary key,
	city_name varchar(150),
	nation_id bigint unsigned,
	index (nation_id),
	foreign key (nation_id) references nations(id) on UPDATE cascade on DELETE CASCADE
);

-- 7) статусы отношений наций друг с другом
CREATE TABLE relation_statuses(
	id serial primary key,
	status_description varchar(100) -- не будем делать индекс, поиск и связки по описанию делать не будем.
);

-- 7) отношения наций друг с другом
CREATE table relations(
	first_side_nation bigint unsigned,
	second_side_nation bigint unsigned,
	relation_status_id bigint unsigned,
	index (first_side_nation, second_side_nation), -- всегда будем искать в двух полях нацию как одну из сторон, поэтому одиночные индексы не нужны.
	index (second_side_nation, first_side_nation),
	index (relation_status_id),
	foreign key (first_side_nation) references nations(id) on UPDATE cascade on DELETE CASCADE,
	foreign key (second_side_nation) references nations(id) on UPDATE cascade on DELETE CASCADE,
	foreign key (relation_status_id) references relation_statuses(id) on UPDATE cascade on DELETE CASCADE
);

-- 9) типы юнитов
CREATE table unit_types(
	id serial primary key,
	type_name varchar(100) -- не будем делать индекс, никогда по имени ничего не ищем и не связываем
);

-- 10) юниты (возможные варианты)
CREATE table units(
	id serial primary key,
	unit_name varchar(150),
	unit_type_id bigint unsigned,
	index (unit_type_id),
	foreign key(unit_type_id) references unit_types(id) on UPDATE cascade on DELETE CASCADE
);

-- 11) юниты, которыми владеет нация
create table nation_units(
	id serial primary key,
	unit_id bigint unsigned,
	nation_id bigint unsigned,
	dead bit,
	index (unit_id),
	index (nation_id),
	index (dead),
	foreign key(unit_id) references units(id) on UPDATE cascade on DELETE CASCADE,
	foreign key(nation_id) references nations(id) on UPDATE cascade on DELETE CASCADE
);

-- 12) координаты юнитов на игровой карте
create table unit_positions(
	cell_id bigint unsigned,
	unit_id bigint unsigned,
	index (cell_id),
	index (unit_id),
	foreign key(cell_id) references game_field(id) on UPDATE cascade on DELETE CASCADE,
	foreign key(unit_id) references units(id) on UPDATE cascade on DELETE CASCADE
);

-- ну и дальше можно продолжать расширять БД технологиями, традициями, культурой и т.д., но для этого нужно время и для учебной курсовой хватит)

-- наполнение данными
use civilization;
SET FOREIGN_KEY_CHECKS = 0;

truncate table terrain_types;

INSERT into terrain_types(terrain_type) values
('plain'),
('meadows'),
('mountain'),
('hill'),
('sea'),
('ocean');

truncate table game_field;
INSERT into game_field(x, y, id_tt) values
(1, 1, 1),
(1, 2, 1),
(1, 3, 2),
(1, 4, 1),
(1, 5, 1),
(1, 6, 1),
(1, 7, 3),
(1, 8, 1),
(1, 9, 4),
(1, 10, 1),
(2, 1, 1),
(2, 2, 4),
(2, 3, 2),
(2, 4, 1),
(2, 5, 1),
(2, 6, 1),
(2, 7, 1),
(2, 8, 3),
(2, 9, 5),
(2, 10, 5),
(3, 1, 5),
(3, 2, 1),
(3, 3, 1),
(3, 4, 1),
(3, 5, 2),
(3, 6, 1),
(3, 7, 3),
(3, 8, 1),
(3, 9, 4),
(3, 10, 5),
(4, 1, 2),
(4, 2, 3),
(4, 3, 3),
(4, 4, 3),
(4, 5, 3),
(4, 6, 1),
(4, 7, 1),
(4, 8, 1),
(4, 9, 1),
(4, 10, 1),
(5, 1, 1),
(5, 2, 1),
(5, 3, 2),
(5, 4, 1),
(5, 5, 4),
(5, 6, 3),
(5, 7, 1),
(5, 8, 2),
(5, 9, 4),
(5, 10, 5),
(6, 1, 2),
(6, 2, 5),
(6, 3, 1),
(6, 4, 2),
(6, 5, 1),
(6, 6, 1),
(6, 7, 1),
(6, 8, 1),
(6, 9, 1),
(6, 10, 1),
(7, 1, 1),
(7, 2, 1),
(7, 3, 1),
(7, 4, 1),
(7, 5, 1),
(7, 6, 1),
(7, 7, 1),
(7, 8, 1),
(7, 9, 1),
(7, 10, 1),
(8, 1, 1),
(8, 2, 1),
(8, 3, 1),
(8, 4, 1),
(8, 5, 1),
(8, 6, 1),
(8, 7, 1),
(8, 8, 1),
(8, 9, 1),
(8, 10, 1),
(9, 1, 1),
(9, 2, 1),
(9, 3, 1),
(9, 4, 1),
(9, 5, 1),
(9, 6, 1),
(9, 7, 1),
(9, 8, 1),
(9, 9, 1),
(9, 10, 1),
(10, 1, 1),
(10, 2, 1),
(10, 3, 1),
(10, 4, 1),
(10, 5, 1),
(10, 6, 1),
(10, 7, 1),
(10, 8, 1),
(10, 9, 1),
(10, 10, 1);

truncate table terrain_upgrades_types;
INSERT into terrain_upgrades_types(terrain_upgrade_type) values
('farm'),
('mine');

truncate table terrain_types_possible_upgrades;
INSERT into terrain_types_possible_upgrades(id_tt, id_tup) values
(1, 1),
(2, 1),
(4, 2);

truncate table nations;
INSERT into nations(nation_name) values
('Mongolia'),
('Persia'),
('Rom'),
('Greece');

truncate table cities;
INSERT into cities(city_name, nation_id) values
('Ulaanbaatar', 1),
('Teheran', 2),
('Rom', 3),
('Athens', 4),
('Thessaloniki', 4);

truncate table relation_statuses;
INSERT into relation_statuses(status_description) values
('peace'),
('war'),
('alliance');

truncate table relations;
INSERT into relations(first_side_nation, second_side_nation, relation_status_id) values
(1, 2, 2),
(1, 3, 2),
(1, 4, 1),
(2, 3, 1),
(2, 4, 3),
(3, 4, 1);

truncate table unit_types;
INSERT into unit_types(type_name) values
('military'),
('civilian');

truncate table units;
INSERT into units(unit_name, unit_type_id) values
('Warrior', 1),
('Crusader', 1),
('Knight', 1),
('Worker', 2),
('Explorer', 2);

truncate table nation_units;
INSERT into nation_units(unit_id, nation_id, dead) values
(1, 2, 0),
(1, 2, 0),
(1, 2, 0),
(1, 2, 1),
(2, 2, 0),
(2, 2, 0),
(2, 3, 0),
(3, 4, 0),
(4, 4, 0);


truncate table unit_positions;
INSERT into unit_positions(cell_id, unit_id) values
(5, 1),
(10, 2),
(15, 4),
(20, 5),
(25, 6),
(30, 7);

SET FOREIGN_KEY_CHECKS = 1;

-- несколько функций и хранимок
-- 1) Проверка на то, находятся ли стороны в состоянии войны
DROP FUNCTION IF EXISTS is_at_war;
DELIMITER $$
CREATE FUNCTION is_at_war(who_id bigint, with_whom_id bigint)
RETURNS BIT READS SQL DATA
BEGIN
   	set @at_war = (
		select count(*) FROM relations r 
		where ((r.first_side_nation = who_id AND r.second_side_nation = with_whom_id) OR
			  (r.first_side_nation = with_whom_id AND r.second_side_nation = who_id)) AND
			  r.relation_status_id = 2
			  );
	if @at_war = 0 THEN
	 	return 0;
	else
		return 1;
	end if;
END$$
	  
DELIMITER ;

-- 2) Проверка на то, являются ли стороны союзниками
DROP FUNCTION IF EXISTS is_at_alliance;
DELIMITER $$

CREATE FUNCTION is_at_alliance(who_id bigint, with_whom_id bigint)
RETURNS BIT READS SQL DATA
BEGIN
   	set @at_alliance = (
		select count(*) FROM relations r 
		where ((r.first_side_nation = who_id AND r.second_side_nation = with_whom_id) OR
			  (r.first_side_nation = with_whom_id AND r.second_side_nation = who_id)) AND
			  r.relation_status_id = 3
			  );
	if @at_alliance = 0 THEN
	 	return 0;
	else
		return 1;
	end if;
END$$
	  
DELIMITER ;

-- 3) объявление войны.
-- необходимое условие: стороны не должны находится в союзе на момент объявления войны и нельзя объявить войну, если уже воюем.
DROP PROCEDURE IF EXISTS `declare_war`;

DELIMITER $$

CREATE PROCEDURE `declare_war`(who_id bigint, towhom_id bigint, OUT tran_result varchar(200))
BEGIN
   DECLARE `_rollback` BOOL DEFAULT 0;
   DECLARE code varchar(100);
   DECLARE error_string varchar(100);

   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    begin
    	SET `_rollback` = 1;
	GET stacked DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
    	set tran_result := concat('Error occured. Code: ', code, '. Text: ', error_string);
    end;
		        
    START TRANSACTION;
   		set @at_war = is_at_war(who_id, towhom_id);
   		set @at_alliance = is_at_alliance(who_id, towhom_id);
   	
   		if @at_alliance THEN
		 	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The action is impossible when players are in an alliance';
		end if;
	
		if @at_war THEN
		 	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The action is impossible when players are in a war.';
		end if;
	
		update relations set relation_status_id  = 1 where first_side_nation in (who_id, towhom_id) AND second_side_nation in (who_id, towhom_id);
	
	    IF `_rollback` THEN
	       ROLLBACK;
	    ELSE
		set tran_result := 'ok';
	       COMMIT;
	    END IF;
END$$

DELIMITER ;

-- создадим пару представлений
-- 1) таблица показывающая текущее состояние отношений наций
CREATE or replace VIEW current_relation_statuses
AS 
	select fs_nations.nation_name as first_side_nation, 
		ss_nations.nation_name as second_side_nation, 
		relation_statuses.status_description as status 
	from relations
		left join relation_statuses on relation_statuses.id = relations.relation_status_id 
		left join nations fs_nations on fs_nations.id = relations.first_side_nation 
		left join nations ss_nations on ss_nations.id = relations.second_side_nation;
   				 
-- 2) таблица показывающая сколько и какие юниты есть у фракции
CREATE or replace VIEW current_nation_units
AS
	select units.unit_name as unit, 
		count(1) as quanity, 
		nations.nation_name as nation
	from nation_units
		left join nations on nations.id = nation_units.nation_id
		left join units on units.id = nation_units.unit_id
	Where nation_units.dead = 0
	GROUP by units.unit_name, nations.nation_name;

-- 3) таблица показывающая сколько юнитов располагается на определенном типе местности. (представление ради демонстрации вложенного запроса).
CREATE OR REPLACE
VIEW units_on_terrain_types AS
SELECT
	terrain_type,
	SUM(IF(ifnull(unit_id, 0) <> 0, 1, 0)) AS unit_quantity
FROM
	terrain_types
LEFT JOIN (
	SELECT
		unit_id,
		id_tt
	FROM
		game_field
	RIGHT JOIN unit_positions ON
		unit_positions.cell_id = game_field.id ) AS units_on_map ON
	units_on_map.id_tt = terrain_types.id
GROUP BY
	terrain_type;

-- триггер только ради того, чтобы просто поюзать. Я бы вообще от них отказался и ушел сугубо на транзакционные процедуры

-- 1) Запретим, к примеру, удаление юнитов наций. Удалять юниты мы будем только посредством выставления флага "dead" для конткретного юнита, поэтому запретим непосредственное удаление.
DELIMITER $$

CREATE TRIGGER before_delete_units
BEFORE DELETE
ON nation_units
FOR EACH ROW
BEGIN
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Недопустимо удаление юнитов, можно только выставить флаг dead';
END
$$

DELIMITER ;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	