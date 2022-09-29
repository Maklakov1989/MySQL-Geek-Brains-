use shop;
-- ����� � ������� users ���� created_at � updated_at ��������� ��������������
UPDATE storehouses_products
SET created_at = CURRENT_TIMESTAMP;
UPDATE storehouses_products
SET updated_at = CURRENT_TIMESTAMP;

-- ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
ALTER TABLE users MODIFY created_at DATETIME 
DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users MODIFY updated_at DATETIME 
DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
-- ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. 
SELECT * FROM storehouses_products 
ORDER by CASE WHEN value = 0 THEN TRUE ELSE FALSE END, value;

-- �� ������� users ���������� ������� �������������, ���������� � ������� � ���
SELECT * FROM users  
WHERE (birthday_at LIKE '%08%' OR birthday_at LIKE '%05%');

-- ����������� ������� ������� ������������� � ������� users.

-- alter  table  users ADD age INT NOT NULL;

UPDATE users
SET age = TIMESTAMPDIFF(YEAR, birthday_at, NOW());

SELECT round(AVG(age))  FROM users;

-- ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.


-- ����������� ������������ ����� � ������� �������.
-- CREATE TABLE cat (id SERIAL PRIMARY KEY, value INT NULL );

INSERT INTO cat (value) 
VALUES 
(1),
(2),
(3), 
(4), 
(5);
SELECT exp(SUM(ln(value))) summ FROM cat;

