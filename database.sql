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
	PASSWORD VARCHAR(30) NOT NULL,
	CREDIT DOUBLE NOT NULL
	-- SETTINGS VARCHAR(32500) usato spesso per mettere feature future ceh richiederebbero altre table (o di cambiare questa table)
	-- RANK INT usato per dare ruoli agli utenti es: moderatore... o anche livelli in base a quanto hanno fatto sul sito (es: videogioco)
);

INSERT INTO USERS (USERNAME, EMAIL, PASSWORD, CREDIT) VALUES('admin', 'admin@admin.com', 'admin', 300.00);
INSERT INTO USERS (USERNAME, EMAIL, PASSWORD, CREDIT) VALUES('teo', 'supergo@live.it', 'teo', 1000000000.00);
INSERT INTO USERS (USERNAME, EMAIL, PASSWORD, CREDIT) VALUES('test', 'test@test.test', 'test', 20.0);
INSERT INTO USERS (USERNAME, EMAIL, PASSWORD, CREDIT) VALUES('user', 'user@user.user', 'user', 10.0);


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

-- Old manual insert
-- INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Tuna', 20.34, 40.7, 10.4, 'Mar Adriatico', 'Bel pesce, ottimo per il sushi e per fare la pasta!', '/static/images/phishes/tuna.jpeg');
-- INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Salmon', 15.65, 50.44, 15.6, 'Mar Tirreno', 'Ottimo pesce per una tartare o un hamburger!', '/static/images/phishes/salmon.png');
-- INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Great White Shark', 143.66, 200.61, 130.7, 'Oceano Atlantico', 'Pesce assassino, sente una goccia di sangue in mezzo a 1.000.000 di gocce di acqua!', '/static/images/phishes/white_shark.jpeg');
-- INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Blue Whale', 260.21, 344.12, 300.4, 'Oceano Atlantico', 'Pesce lungo e lento ma non vuoi capitarle vicino, te lo assicuro!', '/static/images/phishes/blue_whale.jpeg');

-- generated with create_fish_db.py
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Squalo', 43.07, 2329.77, 195.93, 'Mar Tirreno', 'The Squalo is a very good fish! It is long and can be very thin and light!! It costs only 43.07 and is very good for cooking soups! It was caught in Mar Tirreno.', '/static/images/phishes/shark.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Squalo Bianco', 2479.17, 3475.46, 62.52, 'Oceano Indiano', 'The Squalo Bianco is a very good fish! It is short and can be very thin and light!! It costs only 2479.17 and is very good for cooking PASTA! It was caught in Oceano Indiano.', '/static/images/phishes/shark_white.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Grande Squalo Bianco', 3600.91, 6036.86, 143.9, 'Oceano Atlantico', 'The Grande Squalo Bianco is a very good fish! It is long and can be very heavy-weight champion!! It costs only 3600.91 and is very good for cooking soups! It was caught in Oceano Atlantico.', '/static/images/phishes/shark_great_white.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Delfino', 2922.01, 9122.19, 161.41, 'Oceano Atlantico', 'The Delfino is a very good fish! It is long and can be very heavy-weight champion!! It costs only 2922.01 and is very good for cooking PASTA! It was caught in Oceano Atlantico.', '/static/images/phishes/dolphin.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Orca Assassina', 817.22, 7117.99, 146.37, 'Oceano Indiano', 'The Orca Assassina is a very good fish! It is long and can be very heavy-weight champion!! It costs only 817.22 and is very good for cooking PASTA! It was caught in Oceano Indiano.', '/static/images/phishes/orca.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesci Gialli', 1859.59, 3357.46, 121.47, 'Oceano Pacifico', 'The Pesci Gialli is a very good fish! It is long and can be very thin and light!! It costs only 1859.59 and is very good for cooking lasagna! It was caught in Oceano Pacifico.', '/static/images/phishes/gialli.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Pagliaccio', 298.56, 7847.42, 7.26, 'Oceano Atlantico', 'The Pesce Pagliaccio is a very good fish! It is short and can be very heavy-weight champion!! It costs only 298.56 and is very good for cooking PASTA! It was caught in Oceano Atlantico.', '/static/images/phishes/nemo.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Chirurgo', 4330.09, 3609.42, 165.59, 'Oceano Pacifico', 'The Pesce Chirurgo is a very good fish! It is long and can be very thin and light!! It costs only 4330.09 and is very good for cooking soups! It was caught in Oceano Pacifico.', '/static/images/phishes/dory.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Palla', 4452.24, 3682.39, 11.09, 'Mar Tirreno', 'The Pesce Palla is a very good fish! It is short and can be very thin and light!! It costs only 4452.24 and is very good for cooking rice! It was caught in Mar Tirreno.', '/static/images/phishes/palla.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Koi', 3153.03, 8875.2, 61.92, 'Mar Tirreno', 'The Pesce Koi is a very good fish! It is short and can be very heavy-weight champion!! It costs only 3153.03 and is very good for cooking lasagna! It was caught in Mar Tirreno.', '/static/images/phishes/koi.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Manta', 4563.15, 5349.26, 5.13, 'Mar Adriatico', 'The Manta is a very good fish! It is short and can be very heavy-weight champion!! It costs only 4563.15 and is very good for cooking rice! It was caught in Mar Adriatico.', '/static/images/phishes/manta.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Tonno Bianco', 3140.51, 220.52, 91.45, 'Oceano Pacifico', 'The Tonno Bianco is a very good fish! It is short and can be very thin and light!! It costs only 3140.51 and is very good for cooking lasagna! It was caught in Oceano Pacifico.', '/static/images/phishes/tonno_bianco.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Balena Azzurra', 4364.86, 8757.74, 190.84, 'Mar Adriatico', 'The Balena Azzurra is a very good fish! It is long and can be very heavy-weight champion!! It costs only 4364.86 and is very good for cooking salads! It was caught in Mar Adriatico.', '/static/images/phishes/balena_azzurra.svg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Balena', 188.97, 8758.18, 24.02, 'Oceano Indiano', 'The Balena is a very good fish! It is short and can be very heavy-weight champion!! It costs only 188.97 and is very good for cooking sandwich! It was caught in Oceano Indiano.', '/static/images/phishes/balena.svg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Oro', 3566.56, 131.0, 39.58, 'Mar Mediterraneo', 'The Pesce Oro is a very good fish! It is short and can be very thin and light!! It costs only 3566.56 and is very good for cooking PASTA! It was caught in Mar Mediterraneo.', '/static/images/phishes/goldfish.svg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Cavalluccio Marino', 3391.87, 9695.87, 158.07, 'Mar Mediterraneo', 'The Cavalluccio Marino is a very good fish! It is long and can be very heavy-weight champion!! It costs only 3391.87 and is very good for cooking lasagna! It was caught in Mar Mediterraneo.', '/static/images/phishes/horse.svg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Tonno', 230.7, 8483.27, 61.91, 'Mar Mediterraneo', 'The Tonno is a very good fish! It is short and can be very heavy-weight champion!! It costs only 230.7 and is very good for cooking rice! It was caught in Mar Mediterraneo.', '/static/images/phishes/tuna.svg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Salmone', 1372.69, 7536.86, 168.82, 'Oceano Atlantico', 'The Salmone is a very good fish! It is long and can be very heavy-weight champion!! It costs only 1372.69 and is very good for cooking sandwich! It was caught in Oceano Atlantico.', '/static/images/phishes/salmone.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Branzino', 2284.85, 8452.29, 29.47, 'Oceano Atlantico', 'The Branzino is a very good fish! It is short and can be very heavy-weight champion!! It costs only 2284.85 and is very good for cooking rice! It was caught in Oceano Atlantico.', '/static/images/phishes/branzino.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Spigola', 94.35, 9261.77, 146.72, 'Oceano Indiano', 'The Spigola is a very good fish! It is long and can be very heavy-weight champion!! It costs only 94.35 and is very good for cooking PASTA! It was caught in Oceano Indiano.', '/static/images/phishes/spigola.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Carpa', 861.63, 8823.29, 165.78, 'Oceano Pacifico', 'The Carpa is a very good fish! It is long and can be very heavy-weight champion!! It costs only 861.63 and is very good for cooking salads! It was caught in Oceano Pacifico.', '/static/images/phishes/carpa.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Balestra', 759.35, 7485.89, 51.47, 'Oceano Pacifico', 'The Pesce Balestra is a very good fish! It is short and can be very heavy-weight champion!! It costs only 759.35 and is very good for cooking all kinds of stuff! It was caught in Oceano Pacifico.', '/static/images/phishes/balestra.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Damigella', 2339.63, 7912.3, 92.91, 'Mar Mediterraneo', 'The Pesce Damigella is a very good fish! It is short and can be very heavy-weight champion!! It costs only 2339.63 and is very good for cooking rice! It was caught in Mar Mediterraneo.', '/static/images/phishes/damigella.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Trota', 2122.78, 7401.67, 67.59, 'Mar Tirreno', 'The Trota is a very good fish! It is short and can be very heavy-weight champion!! It costs only 2122.78 and is very good for cooking soups! It was caught in Mar Tirreno.', '/static/images/phishes/trota.png');




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
