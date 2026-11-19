CREATE USER IF NOT EXISTS 'data_user'@'localhost' IDENTIFIED BY 'data';
GRANT ALL PRIVILEGES ON * . * TO 'data_user'@'localhost';

CREATE USER IF NOT EXISTS 'data_user'@'%' IDENTIFIED BY 'data';
GRANT ALL PRIVILEGES ON * . * TO 'data_user'@'%';
alter user 'data_user'@'%' identified with mysql_native_password by 'data';

DROP DATABASE IF EXISTS lecture_db;
CREATE DATABASE IF NOT EXISTS lecture_db;

use lecture_db;

DROP TABLE IF EXISTS items;
CREATE TABLE IF NOT EXISTS items
(
    item_id INT PRIMARY KEY,
    item_name VARCHAR(255),
    item_image VARCHAR(255),
    attack INT DEFAULT 0,
    defence INT DEFAULT 0
);

insert into items (item_id, item_name, item_image, attack, defence) values (1, '最上級クラスアイテム', 'f048.png', 100, 100);
insert into items (item_id, item_name, item_image, attack, defence) values (2, '上級クラスアイテム', 'f042.png', 50, 50);
insert into items (item_id, item_name, item_image, attack, defence) values (3, '中級クラスアイテム', 'f041.png', 20, 20);
insert into items (item_id, item_name, item_image, attack, defence) values (4, '下級クラスアイテム', 'f040.png', 10, 10);
insert into items (item_id, item_name, item_image, attack, defence) values (5, 'ゴミクラスアイテム', 'f039.png', 1, 1);

DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users
(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS uesr_items;
CREATE TABLE IF NOT EXISTS uesr_items
(
    user_item_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    item_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS craft_recipes;
CREATE TABLE IF NOT EXISTS craft_recipes
(
    recipe_id INT PRIMARY KEY AUTO_INCREMENT,
    target_item_id INT NOT NULL,
    material_item_id INT NOT NULL,
    material_count INT DEFAULT 1,
    UNIQUE (target_item_id, material_item_id),
    FOREIGN KEY (target_item_id) REFERENCES items(item_id),
    FOREIGN KEY (material_item_id) REFERENCES item(item_id)
);

INSERT INTO craft_recipes (target_item_id, material_item_id, material_count) VALUES (1, 2, 1);
INSERT INTO craft_recipes (target_item_id, material_item_id, material_count) VALUES (2, 3, 1);
INSERT INTO craft_recipes (target_item_id, material_item_id, material_count) VALUES (3, 4, 1);
INSERT INTO craft_recipes (target_item_id, material_item_id, material_count) VALUES (4, 5, 1);

DROP TABLE IF EXISTS gacha_items;
CREATE TABLE IF NOT EXISTS gacha_items
(
    gacha_id INT,
    item_id INT,
    weight INT,
    PRIMARY KEY (gacha_id, item_id)
);

insert into gacha_items (gacha_id, item_id, weight) values (1, 5, 400);
insert into gacha_items (gacha_id, item_id, weight) values (1, 4, 300);
insert into gacha_items (gacha_id, item_id, weight) values (1, 3, 200);
insert into gacha_items (gacha_id, item_id, weight) values (1, 2, 90);
insert into gacha_items (gacha_id, item_id, weight) values (1, 1, 10);

DROP TABLE IF EXISTS user_gacha_histories;
CREATE TABLE IF NOT EXISTS user_gacha_histories
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    history_id INT,
    gacha_id INT,
    item_id INT,
    user_id INT,
    INDEX idx_user_gacha (user_id, gacha_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS battle_histories;
CREATE TABLE IF NOT EXISTS battle_histories
(
    battle_histories_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    opponent_user_id INT NOT NULL,
    result ENUM('win', 'lose', 'draw') NOT NULL,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (opponent_user_id) REFERENCES users(user_id) ON DELETE CASCADE
)

DROP TABLE IF EXISTS battle_summaries;
CREATE TABLE IF NOT EXISTS battle_summaries
(
    uesr_id INT PRIMARY KEY,
    win_count INT NOT NULL DEFAULT 0,
    lose_count INT NOT NULL DEFAULT 0,
    draw_count INT NOT NULL DEFAULT 0,
    total_battles INT NOT NULL DEFAULT 0,
    win_rate DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
    `rank` INT NOT NULL DEFAULT 0,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);