SELECT title, description
FROM boards
WHERE is_private = false;

SELECT u.username, c.text, c.created_at
FROM comments c
JOIN users u ON c.user_id = u.user_id
WHERE c.pin_id = 2;

UPDATE boards
SET description = 'Оновлені приватні замітки на літо',
    is_private = false
WHERE board_id = 3;

UPDATE comments
SET text = 'Чотко!'
WHERE comment_id = 1;

INSERT INTO users (username, email, password_hash)
VALUES ('negev', 'negev_epstein@gmail.com', 'pass_hash_4');

INSERT INTO boards (title, is_private, description, user_id)
VALUES ('Знаменитості', true, 'Всі хто був', 4);

DELETE FROM comments
WHERE comment_id = 3;
