DROP TABLE IF EXISTS pin_tags, comments, pins, tags, boards, users CASCADE;
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL CHECK (email LIKE '%@%'),
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE boards (
    board_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    is_private BOOLEAN DEFAULT FALSE,
    description TEXT,
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE pins (
    pin_id SERIAL PRIMARY KEY,
    image_url TEXT NOT NULL CHECK (image_url LIKE 'http%'),
    title VARCHAR(255) NOT NULL,
    context_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    board_id INTEGER NOT NULL REFERENCES boards(board_id) ON DELETE CASCADE
);

CREATE TABLE comments (
    comment_id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    pin_id INTEGER NOT NULL REFERENCES pins(pin_id) ON DELETE CASCADE
);

CREATE TABLE tags (
    tag_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE pin_tags (
    pin_id INTEGER REFERENCES pins(pin_id) ON DELETE CASCADE,
    tag_id INTEGER REFERENCES tags(tag_id) ON DELETE CASCADE,
    PRIMARY KEY (pin_id, tag_id)
);

INSERT INTO users (username, email, password_hash) VALUES
('v_semenyuk', 'semenyuk@lll.kpi.ua', 'pass_hash_1'),
('v_savych', 'savych@lll.kpi.ua', 'pass_hash_2'),
('m_ivanov', 'iv4345@gmail.com', 'pass_hash_3'),
('j_545h', 'kolovaf@lll.kpi.ua', 'pass_hash_4'),
('eboms', 'sawage123@gmail.com', 'pass_hash_5');

INSERT INTO boards (title, is_private, description, user_id) VALUES
('Інтер’єр', false, 'Ідеї для ремонту', 1),
('Програмування', false, 'гайд по SQL', 2),
('Особисте', true, 'Приватні замітки', 1),
('Ігри', false, 'Корисні розкидки на дасті', 4),
('Подорожі', true, 'Де я був', 5);

INSERT INTO pins (image_url, title, context_text, board_id) VALUES
('https://img.com/y456ym.jpg', 'Скандинавський стиль', 'Світлі кольори', 1),
('https://img.com/6yu3l.png', 'PostgreSQL Join', 'Схема роботи джоїнів', 2),
('https://img.com/r456643.jpg', 'PostgreSQL Insert', 'Інсерти', 2),
('https://img.com/rrghfg.jpg', 'Плани на завтра', 'погуляти', 3),
('https://img.com/r457ghm.jpg', 'Плани на завтра', 'поїсти', 3),
('https://img.com/yutyu.jpg', 'Сіті', 'перед банкою', 4),
('https://img.com/r78u5yh6m.jpg', 'Шорт', 'із спавну', 4),
('https://img.com/p456g4.jpg', 'Карпати', 'Говерла', 5);

INSERT INTO comments (text, user_id, pin_id) VALUES
('Дуже затишно!', 2, 1),
('Це саме те, що я шукав!', 1, 2),
('Цікава думка', 3, 2);

INSERT INTO tags (name) VALUES
('Дизайн'), ('IT'), ('Навчання'), ('Ігри'), ('Гайди');

INSERT INTO pin_tags (pin_id, tag_id) VALUES
(1, 1),
(2, 2),
(2, 3),
(2, 4),
(3, 2),
(3, 3),
(3, 4),
(6, 3),
(6, 4),
(7, 3),
(7, 4);
