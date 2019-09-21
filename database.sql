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
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Squalo', 4715.34, 9874.98, 89.69, 'Mar Mediterraneo', 'The Squalo is a very good fish! It is short and can be very heavy-weight champion!! It costs only 4715.34 € and is very good for cooking rice! It was caught in Mar Mediterraneo.', '/static/images/phishes/shark.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Squalo Bianco', 2040.12, 8742.95, 155.36, 'Mar Mediterraneo', 'The Squalo Bianco is a very good fish! It is long and can be very heavy-weight champion!! It costs only 2040.12 € and is very good for cooking salads! It was caught in Mar Mediterraneo.', '/static/images/phishes/shark_white.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Grande Squalo Bianco', 2034.75, 6566.63, 101.84, 'Mar Mediterraneo', 'The Grande Squalo Bianco is a very good fish! It is long and can be very heavy-weight champion!! It costs only 2034.75 € and is very good for cooking lasagna! It was caught in Mar Mediterraneo.', '/static/images/phishes/shark_great_white.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Delfino', 4357.83, 286.17, 41.55, 'Oceano Atlantico', 'The Delfino is a very good fish! It is short and can be very thin and light!! It costs only 4357.83 € and is very good for cooking soups! It was caught in Oceano Atlantico.', '/static/images/phishes/dolphin.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Orca Assassina', 4105.92, 8675.42, 193.06, 'Oceano Atlantico', 'The Orca Assassina is a very good fish! It is long and can be very heavy-weight champion!! It costs only 4105.92 € and is very good for cooking hamburgers! It was caught in Oceano Atlantico.', '/static/images/phishes/orca.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesci Gialli', 2915.05, 7833.67, 82.68, 'Oceano Indiano', 'The Pesci Gialli is a very good fish! It is short and can be very heavy-weight champion!! It costs only 2915.05 € and is very good for cooking spaghetti! It was caught in Oceano Indiano.', '/static/images/phishes/gialli.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Pagliaccio', 2330.95, 8065.85, 63.16, 'Oceano Pacifico', 'The Pesce Pagliaccio is a very good fish! It is short and can be very heavy-weight champion!! It costs only 2330.95 € and is very good for cooking pasta! It was caught in Oceano Pacifico.', '/static/images/phishes/nemo.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Chirurgo', 2304.68, 3874.92, 150.57, 'Mar Mediterraneo', 'The Pesce Chirurgo is a very good fish! It is long and can be very thin and light!! It costs only 2304.68 € and is very good for cooking sandwich! It was caught in Mar Mediterraneo.', '/static/images/phishes/dory.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Palla', 4467.84, 423.12, 8.26, 'Oceano Pacifico', 'The Pesce Palla is a very good fish! It is short and can be very thin and light!! It costs only 4467.84 € and is very good for cooking salads! It was caught in Oceano Pacifico.', '/static/images/phishes/palla.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Koi', 4139.63, 2153.75, 124.44, 'Mar Adriatico', 'The Pesce Koi is a very good fish! It is long and can be very thin and light!! It costs only 4139.63 € and is very good for cooking spaghetti! It was caught in Mar Adriatico.', '/static/images/phishes/koi.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Manta', 769.21, 7906.3, 64.07, 'Oceano Pacifico', 'The Manta is a very good fish! It is short and can be very heavy-weight champion!! It costs only 769.21 € and is very good for cooking tartare! It was caught in Oceano Pacifico.', '/static/images/phishes/manta.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Tonno Bianco', 4928.66, 4818.23, 188.18, 'Mar Mediterraneo', 'The Tonno Bianco is a very good fish! It is long and can be very thin and light!! It costs only 4928.66 € and is very good for cooking hamburgers! It was caught in Mar Mediterraneo.', '/static/images/phishes/tonno_bianco.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Balena Azzurra', 2995.61, 200.64, 20.53, 'Mar Tirreno', 'The Balena Azzurra is a very good fish! It is short and can be very thin and light!! It costs only 2995.61 € and is very good for cooking tartare! It was caught in Mar Tirreno.', '/static/images/phishes/balena_azzurra.svg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Balena', 3324.77, 5368.17, 84.19, 'Mar Tirreno', 'The Balena is a very good fish! It is short and can be very heavy-weight champion!! It costs only 3324.77 € and is very good for cooking all kinds of stuff! It was caught in Mar Tirreno.', '/static/images/phishes/balena.svg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Oro', 761.8, 5320.7, 93.05, 'Oceano Indiano', 'The Pesce Oro is a very good fish! It is short and can be very heavy-weight champion!! It costs only 761.8 € and is very good for cooking sandwich! It was caught in Oceano Indiano.', '/static/images/phishes/goldfish.svg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Cavalluccio Marino', 4749.17, 2551.29, 177.45, 'Mar Adriatico', 'The Cavalluccio Marino is a very good fish! It is long and can be very thin and light!! It costs only 4749.17 € and is very good for cooking lasagna! It was caught in Mar Adriatico.', '/static/images/phishes/horse.svg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Tonno', 2600.72, 8298.69, 56.39, 'Mar Adriatico', 'The Tonno is a very good fish! It is short and can be very heavy-weight champion!! It costs only 2600.72 € and is very good for cooking sandwich! It was caught in Mar Adriatico.', '/static/images/phishes/tuna.svg');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Salmone', 396.53, 3231.64, 8.8, 'Mar Mediterraneo', 'The Salmone is a very good fish! It is short and can be very thin and light!! It costs only 396.53 € and is very good for cooking pasta! It was caught in Mar Mediterraneo.', '/static/images/phishes/salmone.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Branzino', 2426.16, 2537.85, 56.71, 'Oceano Pacifico', 'The Branzino is a very good fish! It is short and can be very thin and light!! It costs only 2426.16 € and is very good for cooking spaghetti! It was caught in Oceano Pacifico.', '/static/images/phishes/branzino.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Spigola', 4660.22, 6187.54, 123.2, 'Oceano Indiano', 'The Spigola is a very good fish! It is long and can be very heavy-weight champion!! It costs only 4660.22 € and is very good for cooking salads! It was caught in Oceano Indiano.', '/static/images/phishes/spigola.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Carpa', 2863.87, 6312.98, 40.07, 'Oceano Indiano', 'The Carpa is a very good fish! It is short and can be very heavy-weight champion!! It costs only 2863.87 € and is very good for cooking sandwich! It was caught in Oceano Indiano.', '/static/images/phishes/carpa.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Balestra', 2886.32, 3463.03, 87.15, 'Oceano Indiano', 'The Pesce Balestra is a very good fish! It is short and can be very thin and light!! It costs only 2886.32 € and is very good for cooking hamburgers! It was caught in Oceano Indiano.', '/static/images/phishes/balestra.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Pesce Damigella', 3475.64, 9813.66, 27.51, 'Oceano Indiano', 'The Pesce Damigella is a very good fish! It is short and can be very heavy-weight champion!! It costs only 3475.64 € and is very good for cooking soups! It was caught in Oceano Indiano.', '/static/images/phishes/damigella.png');
INSERT INTO FISHES (NAME, PRICE, WEIGHT, LENGTH, SEA, DESCRIPTION, IMAGE_URL) VALUES ('Trota', 264.28, 2352.81, 111.43, 'Mar Adriatico', 'The Trota is a very good fish! It is long and can be very thin and light!! It costs only 264.28 € and is very good for cooking tartare! It was caught in Mar Adriatico.', '/static/images/phishes/trota.png');



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
