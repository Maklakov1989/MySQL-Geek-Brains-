DROP TABLE IF EXISTS videos;
CREATE TABLE videos(
	id SERIAL,
	name varchar(255) DEFAULT NULL,
	`user_id` BIGINT UNSIGNED DEFAULT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS citys;
CREATE TABLE citys(
	id SERIAL,
	city VARCHAR(150),
	`user_id` BIGINT UNSIGNED DEFAULT NULL,
	
	INDEX city_idx(city),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS education;
CREATE TABLE education(
	id SERIAL,
	school_name varchar(255) DEFAULT NULL,
	city_id BIGINT UNSIGNED NOT NULL,
	end_year YEAR,
	user_id BIGINT UNSIGNED DEFAULT NULL,
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (city_id) REFERENCES citys(id)
);


