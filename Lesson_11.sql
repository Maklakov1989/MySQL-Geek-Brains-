USE `shop`;

drop table if exists `logs`;
create table `logs`(
create_at datetime DEFAULT NOW(), 
`table_name` varchar(45) NOT NULL, 
table_id INT UNSIGNED NOT NULL, 
name_value varchar(45)
) engine=ARCHIVE;

DELIMITER //
DROP TRIGGER IF EXISTS `shop`.`users_AFTER_INSERT` //
DELIMITER ;

DROP TRIGGER IF EXISTS `shop`.`creation_record _users`;

DELIMITER //


CREATE DEFINER=`root`@`localhost` TRIGGER `creation_record _users` AFTER INSERT ON `users` FOR EACH ROW BEGIN
insert into shop.logs (create_at,`table_name`, table_id, name_value)
values (now(), 'shop.users', new.id, new.name);

END//

DELIMITER ;

-- ������� catalogs
DROP TRIGGER IF EXISTS `shop`.`creation_record_catalogs`;

DELIMITER //
USE `shop`//
CREATE DEFINER = CURRENT_USER TRIGGER `creation_record_catalogs` AFTER INSERT ON `catalogs` FOR EACH ROW
BEGIN
insert into shop.logs (create_at,`table_name`, table_id, name_value)
values (now(), 'shop.catalogs', new.id, new.name);


END//
DELIMITER ;

-- ������� products

DROP TRIGGER IF EXISTS `shop`.`creation_record_products`;

DELIMITER //
USE `shop`//
CREATE DEFINER = CURRENT_USER TRIGGER `creation_record_products` AFTER INSERT ON `products` FOR EACH ROW
BEGIN

insert into shop.logs (create_at,`table_name`, table_id, name_value)
values (now(), 'shop.products', new.id, new.name);
END//
DELIMITER ;

-- ������� 2 

drop table if exists `test_users`;
create table `test_users`( 
name varchar(45) NOT NULL, 
birthday_at VARCHAR(10000)
) ;





DROP PROCEDURE IF EXISTS insert_into_users ;
delimiter //
CREATE PROCEDURE insert_into_users ()
BEGIN
	DECLARE i INT DEFAULT 100;
	DECLARE j INT DEFAULT 0;
	WHILE i > 0 Do
		INSERT INTO test_users(name, birthday_at) VALUES (CONCAT('user_', j), NOW()) ;
		SET j = j + 1 ;
		SET i = i - 1 ;
	END while ;
END //
delimiter ;


-- test
SELECT * FROM test_users;

CALL insert_into_users();

SELECT * FROM test_users LIMIT 300;