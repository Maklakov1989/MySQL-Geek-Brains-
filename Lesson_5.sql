use shop;
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными
UPDATE storehouses_products
SET created_at = CURRENT_TIMESTAMP;
UPDATE storehouses_products
SET updated_at = CURRENT_TIMESTAMP;

-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
ALTER TABLE users MODIFY created_at DATETIME 
DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users MODIFY updated_at DATETIME 
DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
SELECT * FROM storehouses_products 
ORDER by CASE WHEN value = 0 THEN TRUE ELSE FALSE END, value;

-- Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае
SELECT * FROM users  
WHERE (birthday_at LIKE '%08%' OR birthday_at LIKE '%05%');

-- Подсчитайте средний возраст пользователей в таблице users.

-- alter  table  users ADD age INT NOT NULL;

UPDATE users
SET age = TIMESTAMPDIFF(YEAR, birthday_at, NOW());

SELECT round(AVG(age))  FROM users;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.


-- Подсчитайте произведение чисел в столбце таблицы.
-- CREATE TABLE cat (id SERIAL PRIMARY KEY, value INT NULL );

INSERT INTO cat (value) 
VALUES 
(1),
(2),
(3), 
(4), 
(5);
SELECT exp(SUM(ln(value))) summ FROM cat;

