use civilization;

-- ПРЕДСТАВЛЕНИЯ И ВЫБОРКИ
-- 1) посмотрим на то в каких отношениях находятся нации.
SELECT * from current_relation_statuses;

-- 2) Посмотрим у какой нации сколько юнитов.
SELECT * from current_nation_units;

-- 3) Посмотрим на типы местности и количество юнитов, которые занимают определенный тип местности
SELECT * from units_on_terrain_types;

-- ХРАНИМЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
-- 2) попробуем объявить войну союзнику (запрещено, союзники не могут объявить войну друг другу)

-- тут не получится объявить, он в союзе
call declare_war(2, 4, @tran_result);
SELECT @tran_result;
-- тоже не получится, они и так уже воюют
call declare_war(1, 2, @tran_result);
SELECT @tran_result;
-- а тут получится, они в мире
call declare_war(1, 4, @tran_result);
SELECT @tran_result;

-- ТРИГГЕРЫ

-- мы запретили удаление записей юнитов наций физически и условились выставлять им только dead-флаг. Попробуем удалить.
DELETE from nation_units;
