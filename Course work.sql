	DROP DATABASE IF EXISTS CENTRAL_HEATING;
	CREATE DATABASE CENTRAL_HEATING;
	USE CENTRAL_HEATING;
	
	
	CREATE TABLE buildings (
		id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	    postal_code VARCHAR(50),
	    adress VARCHAR(50) COMMENT 'Адрес',
	    number_of_users VARCHAR(100),
	 	comercial_square_meters BIGINT UNSIGNED NOT NULL,
		object_of_cultural_heritage ENUM('yes', 'no'),
		social_area ENUM('yes', 'no'),
		
		INDEX buildings_postal_code_adress_idx(postal_code, adress)
	) COMMENT 'Дома';
	
	
	CREATE TABLE metering_devices (
		id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		brand VARCHAR(20),
	    model VARCHAR(50),
	    owner BIGINT UNSIGNED NOT NULL,
	    installation_date DATE,
		verification_date DATETIME,
	    verification_interval VARCHAR(2)
	)COMMENT 'Приборы учета тепловой энергии';
	
	
	   
	CREATE TABLE service_company (
		id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(200),
		CEO_name VARCHAR(200),
		CEO_last_name VARCHAR(200),
	    status ENUM('sighned', 'not sighned'),
		requested_at DATETIME DEFAULT NOW(),
		updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
		building_id BIGINT UNSIGNED NOT NULL,
		
		foreign key (building_id) references buildings(id)
	)COMMENT 'Управляющая компания';
	
	ALTER TABLE metering_devices ADD
		FOREIGN KEY (owner) REFERENCES service_company(id)
		ON UPDATE CASCADE 
	    ON DELETE RESTRICT;
	
	
	CREATE TABLE measurements (
		id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		recieved_calories BIGINT,
	    device_id BIGINT UNSIGNED NOT NULL,
	    measured_at DATETIME DEFAULT NOW(),
	    
	    FOREIGN KEY (device_id) REFERENCES metering_devices(id)
	)COMMENT 'Количество полученых гигакалорий';
	
	
	CREATE TABLE prefecture(
		id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(150),
		directors_firest_name VARCHAR(150),
		directors_last_name VARCHAR(150),
		INDEX prefecture_name_idx(name)
	)COMMENT 'Органы местного управления';
	
	
	CREATE TABLE district(
		id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(150),
		prefecture_id BIGINT UNSIGNED NOT NULL,
		foreign key (prefecture_id) references prefecture(id)
			
	)COMMENT 'Админимтративный округ';
	
	
	
	CREATE TABLE brigade(
		id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name_of_brigadier VARCHAR(150),
		name_of_engineer VARCHAR(150),
		name_of_worker_1 VARCHAR(150),
		name_of_worker_2 VARCHAR(150),
		name_of_driver VARCHAR(150),
		service_company_id BIGINT UNSIGNED NOT NULL,
		
		foreign key (service_company_id) references service_company(id)	
	)COMMENT 'Бригада';
	
	CREATE TABLE heating_company(
		id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(150),
		CEO_name VARCHAR(200),
		CEO_last_name VARCHAR(200),
		given_calories BIGINT
		
	) COMMENT 'Ресурсо-снабжающая компания';
	
	CREATE TABLE heating_point(
		id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(150),
		given_calories BIGINT,
		building_id BIGINT UNSIGNED NOT NULL,
		district_id BIGINT UNSIGNED NOT NULL,
		heating_company_id BIGINT UNSIGNED NOT NULL,
		
		foreign key (building_id) references buildings(id),
		foreign key (district_id) references district(id),
		foreign key (heating_company_id) references heating_company(id)
	)COMMENT 'Центральный тепловой пункт';
	
	
	CREATE TABLE consumer(
		id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name VARCHAR(150),
		last_name VARCHAR(150),
		financial_account BIGINT,
		phone_number BIGINT,
		bill BIGINT,
		building_id BIGINT UNSIGNED NOT NULL,
				
		foreign key (building_id) references buildings(id),
		INDEX consumer_name_last_name_idx(name, last_name)
	) COMMENT 'Потребители';
	
	
