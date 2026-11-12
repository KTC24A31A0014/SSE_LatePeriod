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
    
)