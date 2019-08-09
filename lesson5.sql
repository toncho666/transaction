#_________________________________________________________________________________________
/* Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине. */

truncate table orders; # очищаем таблицу заказов.
insert into orders values  # вставляем подопытные заказы.
		(default, 1, default, default),
		(default, 7, default, default),
		(default, 4, default, default),
		(default, 3, default, default);

# формируем список пользователей, кто совершил хотя бы один заказ.
select users.name, orders.id as 'номер заказа', orders.created_at as 'Дата формирования' 
from users right join orders 
on users.id=orders.user_id;


#_________________________________________________________________________________________
/* Выведите список товаров products и разделов catalogs, который соответствует товару. */

truncate table catalogs; # очищаем таблицу каталогов.
insert into catalogs values  # вставляем калатоги.
		(default, 'Принтеры'),
		(default, 'Мониторы'),
		(default, 'Процессоры'),
		(default, 'Мат.платы');

truncate table products; # очищаем продуктовую линейку.
insert into products values  # вставляем продукты.
		(default, 'LaserJet6758', 'Цветной принтер', 860, 1, default, default),
		(default, 'Lexmark', 'Цветной принтер hd', 800, 1, default, default),
		(default, 'Samsung', 'Монитор hd', 1500, 2, default, default),
		(default, 'NEC', 'МОнитор fullHD', 2400, 2, default, default),
		(default, 'LG', 'Цветной монитор повышенной мониторности', 1980, 2, default, default),
		(default, 'SHARP', 'Классика', 1999, 2, default, default),
		(default, 'Core i3', 'Процессор для офиса', 3400, 3, default, default),
		(default, 'Core i5', 'Процессор для работы', 1409, 3, default, default),
		(default, 'Core i7', 'Процессор для игр', 4500, 3, default, default),
		(default, 'Мат.плата 1', 'Хорошая материнская плата', 860, 4, default, default),
		(default, 'Мат.плата 2', 'Средняя материнская плата', 870, 4, default, default),
		(default, 'Мат.плата 3', 'То, что нужно!', 1000, 4, default, default),
		(default, 'Apple', 'Цветной монитор', 5000, 2, default, default),
		(default, 'Xiaomi', 'Цветной принтер из поднебесной', 890, 1, default, default),
		(default, 'Samsung', 'Хороший принтер', 790, 1, default, default),
		(default, 'LaserJet6689', 'Принтер с картриджем в комплекте', 880, 1, default, default);

# подтягиваем к каждому продукту соответствующую ему категорию в каталоге.
select products.name as 'Название', catalogs.name as 'каталог'  #выбираем поля
from products join catalogs # из объединения.
on products.catalog_id=catalogs.id # где ключи совпадают.
order by catalogs.name, products.name; # и сортируем вначале по каталогу, после по продукту в рамках каталога.


#_________________________________________________________________________________________
/* (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. 
 * Выведите список рейсов flights с русскими названиями городов.*/

drop table if exists flights;
create table flights(
		id INT unsigned NOT NULL AUTO_INCREMENT,
		city_from Varchar(100),
		city_to Varchar(100),
		PRIMARY KEY (`id`),
		UNIQUE KEY `id` (`id`)
		);

insert into flights values  # наполняем таблицу flights.
		(default, 'moscow', 'omsk'),
		(default, 'novgorod', 'kazan'),
		(default, 'irkutsk', 'moscow'),
		(default, 'omsk', 'irkutsk'),
		(default, 'moscow', 'kazan');

drop table if exists cities;
create table cities(
		lable Varchar(100),
		name Varchar(100)
		);

insert into cities values  # наполняем таблицу flights.
		('moscow', 'Москва'),
		('irkutsk', 'Иркутск'),
		('novgorod', 'Новгород'),
		('kazan', 'Казань'),
		('omsk', 'Омск');

# фомируем таблицу вылетов на русском
drop table if exists city_from;
create table city_from select flights.id, cities.name as out_fly from flights left join cities on flights.city_from = cities.lable;
# фомируем таблицуприлетеов на русском
drop table if exists city_to;
create table city_to select flights.id, cities.name as in_fly from flights left join cities on flights.city_to = cities.lable;
#объединяем эти две таблицы
select city_from.out_fly, city_to.in_fly from city_from left join city_to on city_from.id = city_to.id order by city_to.id;
