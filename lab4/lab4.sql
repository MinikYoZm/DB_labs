SELECT COUNT(*) AS total_pins -- 1 COUNT
FROM pins;

SELECT
    MIN(created_at) AS first_user_registered_at, -- 2 MIN
    MAX(created_at) AS newest_user_registered_at -- 3 MAX
FROM users;

SELECT user_id, COUNT(*) AS boards_count
FROM boards
GROUP BY user_id; -- 4 GROUP BY

SELECT u.username, COUNT(b.board_id) AS boards_count
FROM users u
INNER JOIN boards b ON u.user_id = b.user_id -- 5 INNER JOIN
GROUP BY u.username
HAVING COUNT(b.board_id) > 1; -- 6 HAVING

SELECT b.title AS board_title, p.title AS pin_title
FROM boards b
LEFT JOIN pins p ON b.board_id = p.board_id; -- 7 LEFT JOIN

SELECT t.name AS tag_name, COUNT(pt.pin_id) AS usage_count
FROM pin_tags pt
RIGHT JOIN tags t ON pt.tag_id = t.tag_id -- 8 RIGHT JOIN
GROUP BY t.name;

SELECT u.username, t.name AS tag_name
FROM users u
CROSS JOIN tags t; -- 9 CROSS JOIN

SELECT title, context_text
FROM pins
WHERE board_id IN (
    SELECT board_id FROM boards WHERE is_private = TRUE -- 10 Підзапит у WHERE
);

SELECT
    username,
    (SELECT COUNT(*) FROM comments c WHERE c.user_id = u.user_id) AS total_comments -- 11 Підзапит у SELECT
FROM users u;

SELECT p.title, COUNT(c.comment_id) AS comments_count
FROM pins p
INNER JOIN comments c ON p.pin_id = c.pin_id
GROUP BY p.pin_id, p.title
HAVING COUNT(c.comment_id) >= (
    SELECT COUNT(*) FROM comments WHERE pin_id = 1
); -- 12 Підзапит у HAVING
