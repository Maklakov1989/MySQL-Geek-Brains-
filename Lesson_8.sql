USE vk;

-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT 
u.id,
u.firstname,
u.lastname,
m.to_user_id ,
COUNT(*) AS total_messages
FROM users u  
JOIN friend_requests fr ON (u.id = fr.initiator_user_id OR u.id = fr.target_user_id) 
JOIN messages m ON u.id = m.from_user_id
WHERE u.id = 1 AND status = 'approved'
GROUP BY u.id 
ORDER BY total_messages;

-- Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.

SELECT 
COUNT(*) AS likes
FROM likes l  
JOIN profiles p ON l.user_id = p.user_id AND timestampdiff(YEAR, p.birthday, now())<11
ORDER BY likes;

-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT 
p.gender,
COUNT(*) AS likes
FROM likes l  
JOIN profiles p ON l.user_id = p.user_id
GROUP BY p.gender;
