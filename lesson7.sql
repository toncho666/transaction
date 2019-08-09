#------------------------------------------------------------------------------------------------
/* Создайте двух пользователей которые имеют доступ к базе данных shop. 
 * Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
 * второму пользователю shop — любые операции в пределах базы данных shop.*/

use shop;

create user 'user1'@'localhost';
grant select on * to user1; # доступны только запросы на чтение данных

create user 'user2'@'localhost';
grant usage on * to user2; # любые операции в пределах базы данных shop


#------------------------------------------------------------------------------------------------
/* (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
 * Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
 * Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.*/

use shop;
drop table if exists accounts;
create table accounts(
			id bigint(20) unsigned not null auto_increment,
			name Varchar(50),
			pass Varchar(50),
			primary key (id),
			unique key id (id)
			
);

insert into accounts values 
		(default, 'ivan', 'qw452er'),
		(default, 'semen', '453g5t'),
		(default, 'jack', '474hyte'),
		(default, 'donald', 'h476h4e'),
		(default, 'vladimir', 'h766eh'),
		(default, 'tereza', 'w345'),
		(default, 'kim', '567h5y'),
		(default, 'isbusallahabdulmahan', 'j647e6tyh'),
		(default, 'gref', 'h764eadrwt');

drop view if exists username; # удаляем представление, если оно существовало
create view username as select id, name from accounts; # создаем представление 'username'
select * from username; # и выводим представление на экран


create user 'user_read'@'localhost'; 
grant select on shop.username to 'user_read'@'localhost'; # доступны только запросы на чтение данных из представления



