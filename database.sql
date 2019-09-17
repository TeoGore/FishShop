-- run only to reset the DB
-- DROP DATABASE FISHSHOP;

CREATE DATABASE IF NOT EXISTS FISHSHOP CHARACTER SET utf32;
CREATE USER IF NOT EXISTS 'user'@'localhost' IDENTIFIED BY 'password';
GRANT INSERT, SELECT, DELETE ON `FISHSHOP`.* TO 'user'@'localhost';

DROP SCHEMA IF EXISTS FISHSHOP;
CREATE SCHEMA FISHSHOP;

USE FISHSHOP;

CREATE TABLE USERS
(
    USER_ID INT PRIMARY KEY NOT NULL auto_increment,
	USERNAME VARCHAR(30) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	PASSWORD VARCHAR(30) NOT NULL
	-- SETTINGS VARCHAR(32500) usato spesso per mettere feature future ceh richiederebbero altre table (o di cambiare questa table)
	-- RANK INT usato per dare ruoli agli utenti es: moderatore... o anche livelli in base a quanto hanno fatto sul sito (es: videogioco)
);

INSERT INTO USERS (USERNAME, EMAIL, PASSWORD) VALUES('admin', 'admin@admin.com', 'admin');
INSERT INTO USERS (USERNAME, EMAIL, PASSWORD) VALUES('teo', 'supergo@live.it', 'teo');
INSERT INTO USERS (USERNAME, EMAIL, PASSWORD) VALUES('test', 'test@test.test', 'test');

CREATE TABLE FISHES
(
    FISH_ID INT PRIMARY KEY NOT NULL auto_increment,
	NAME VARCHAR(50) NOT NULL,
	PRICE DOUBLE NOT NULL,
	WEIGHT DOUBLE,
	LENGTH DOUBLE,
	SEA VARCHAR(50),
	DESCRIPTION VARCHAR(500) NOT NULL,
	IMAGE_URL VARCHAR(500) NOT NULL
);

INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Tuna', 20.30, 40.7, 10.4, 'Mar Adriatico', 'Bel pesce, ottimo per il sushi e per fare la pasta!', '/static/images/phishes/tuna.jpeg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Salmon', 15.65, 50.44, 15.6, 'Mar Tirreno', 'Ottimo pesce per una tartare o un hamburger!', '/static/images/phishes/salmon.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Great White Shark', 143.66, 200.61, 130.7, 'Oceano Atlantico', 'Pesce assassino, sente una goccia di sangue in mezzo a 1.000.000 di gocce di acqua!', '/static/images/phishes/white_shark.jpeg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Blue Whale', 260.21, 344.12, 300.4, 'Oceano Atlantico', 'Pesce lungo e lento ma non vuoi capitarle vicino, te lo assicuro!', '/static/images/phishes/blue_whale.jpeg');

CREATE TABLE CART
(
    USER INT NOT NULL REFERENCES USERS(USER_ID),
    FISH INT NOT NULL REFERENCES FISHES(FISH_ID),
    QUANTITY INT NOT NULL,
    PRIMARY KEY (USER, FISH)
);

INSERT INTO CART VALUES (2, 1, 3);

CREATE TABLE WISHLIST
(
    USER INT NOT NULL REFERENCES USERS(USER_ID),
    FISH INT NOT NULL REFERENCES FISHES(FISH_ID),
    PRIMARY KEY (USER, FISH)
);

INSERT INTO WISHLIST VALUES (1, 1);
