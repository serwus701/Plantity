DROP DATABASE plants;
CREATE DATABASE plants;

DROP USER 'user'@'localhost';
DROP USER 'expert'@'localhost';
DROP USER 'admin'@'localhost';
DROP USER 'login_manager'@'localhost';

USE plants;

CREATE TABLE admins (
	worker_id integer(10) NOT NULL AUTO_INCREMENT,
    firstname varchar(20) NOT NULL,
    lastname varchar(20) NOT NULL,
    admin_login varchar(20) UNIQUE NOT NULL,
    admin_password varchar(64) NOT NULL,
    PRIMARY KEY (worker_id)
);

CREATE TABLE users (
	user_id integer(10) NOT NULL AUTO_INCREMENT,
    firstname varchar(20) NOT NULL,
    lastname varchar(20) NOT NULL,
    user_login varchar(20) UNIQUE NOT NULL,
    user_password varchar(64) NOT NULL,
    is_expert bit NOT NULL,
    worker_id integer(10),
    PRIMARY KEY (user_id),
    FOREIGN KEY (worker_id) REFERENCES admins(worker_id)
);

CREATE TABLE libraries (
	library_id integer(10) NOT NULL AUTO_INCREMENT,
    user_id integer(10) NOT NULL,
    amount_of_plants integer(3) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    PRIMARY KEY (library_id)
);

CREATE TABLE encyclopedia (
	species_id integer(10) NOT NULL AUTO_INCREMENT,
    photo_id varchar(20) UNIQUE,
    species_name varchar(20) UNIQUE NOT NULL,
    species_description varchar(500),
    how_often_to_water integer(1),
    amount_of_sun integer(1),
    amount_of_water integer(1),
    difficulty integer(1),
    PRIMARY KEY (species_id)
);

CREATE TABLE plants (
	plant_id integer(10) NOT NULL AUTO_INCREMENT,
    plant_name varchar(20) ,
    species_id integer(10) NOT NULL,
    library_id integer(10) NOT NULL,
    FOREIGN KEY (species_id) REFERENCES encyclopedia(species_id),
    FOREIGN KEY (library_id) REFERENCES libraries(library_id),
	PRIMARY KEY (plant_id)
);


CREATE TRIGGER create_library   
AFTER INSERT  
ON users FOR EACH ROW  
INSERT INTO libraries (user_id, amount_of_plants)
VALUES (new.user_id, 0);

CREATE TRIGGER delete_library   
AFTER DELETE  
ON users FOR EACH ROW  
DELETE from libraries WHERE old.user_id = 0;

CREATE TRIGGER add_plant
AFTER INSERT
ON plants FOR EACH ROW
UPDATE libraries
SET amount_of_plants = amount_of_plants + 1
WHERE library_id = new.library_id;

CREATE TRIGGER delete_plant
AFTER DELETE
ON plants FOR EACH ROW
UPDATE libraries
SET amount_of_plants = amount_of_plants - 1
WHERE library_id = old.library_id;



DELIMITER //
CREATE PROCEDURE SelectAllCustomers
(
library_id integer(10)
)
BEGIN
	SELECT *  FROM plants
     WHERE plants.library_id = library_id;
END //

CREATE PROCEDURE SelectEasyPlants
(
difficulty integer(1)
)
BEGIN
	SELECT * FROM encyclopedia
    WHERE encyclopedia.difficulty <= difficulty;
END //
DELIMITER ;



INSERT INTO admins (firstname, lastname, admin_login, admin_password)
VALUES ("Jan", "Kowalski", "kowal_jan123", "47625ed74cab8fbc0a8348f3df1feb07f87601e34d62bd12eb0d51616566fab5");

INSERT INTO admins (firstname, lastname, admin_login, admin_password)
VALUES ("Arek", "Frytka", "Mistknnn", "47625ed74cab8fbc0a8348f3df1feb07f87601e34d62bd12eb0d51616566fab5");



INSERT INTO users (firstname, lastname, user_login, user_password, is_expert, worker_id)
VALUES ("Darek", "Gnieciak", "slaby_gracz", "47625ed74cab8fbc0a8348f3df1feb07f87601e34d62bd12eb0d51616566fab5", true, 1);

INSERT INTO users (firstname, lastname, user_login, user_password, is_expert, worker_id)
VALUES ("Aleksander", "Kacper", "kaleks", "47625ed74cab8fbc0a8348f3df1feb07f87601e34d62bd12eb0d51616566fab5", false, 1);

INSERT INTO users (firstname, lastname, user_login, user_password, is_expert, worker_id)
VALUES ("Ludwik", "Szymkiewicz", "Palega", "47625ed74cab8fbc0a8348f3df1feb07f87601e34d62bd12eb0d51616566fab5", false, 2);

INSERT INTO users (firstname, lastname, user_login, user_password, is_expert, worker_id)
VALUES ("Mr", "Adamones", "Mr_Adamones", "47625ed74cab8fbc0a8348f3df1feb07f87601e34d62bd12eb0d51616566fab5", false, 2);



INSERT INTO encyclopedia (photo_id, species_name, species_description, how_often_to_water, amount_of_sun, amount_of_water, difficulty)
VALUES ('peperomia','Peperomia', 'Peperomia, sometimes called radiator plants, are most commonly found in South and Central America. No more than a foot high, peperomia feature large, rounded, waxy leaves that are sturdy and super-smooth. A mostly hardy house plant, peperomia aren’t super picky about their environment', 1, 3, 2, 1);

INSERT INTO encyclopedia (photo_id, species_name, species_description, how_often_to_water, amount_of_sun, amount_of_water, difficulty)
VALUES ('lucky_bamboo','Lucky Bamboo', 'Despite its association with China and Japan, Dracaena sanderiana, or Lucky Bamboo, hails from Central Africa and is thought to bring wealth and prosperity to its home. With its hardy roots, Lucky Bamboo can grow in both soil and a cup of plain water, and can even be trained and shaped. If you opt to grow your lucky bamboo in water, change it at least once every week. The roots will be a lovely red when healthy. Pro tip: always water your Lucky Bamboo with distilled or dechlorinated water', 1, 4, 3, 2);

INSERT INTO encyclopedia (photo_id, species_name, species_description, how_often_to_water, amount_of_sun, amount_of_water, difficulty)
VALUES ('zebra_plant','Zebra Plant', 'The little Zebra Plant, originally found in Brazil, is perfect for plant lovers with limited space. Formally known as Haworthiopsis Fasciata, these spiky green plants rarely grow taller than one foot. The upward-growing leaves have white bands, which provide it with its name and unique look', 1, 4, 1, 1);



INSERT INTO plants (plant_name, species_id, library_id)
VALUES ("Boczek", 1, 1);

INSERT INTO plants (plant_name, species_id, library_id)
VALUES ("Stefan", 1, 2);

INSERT INTO plants (plant_name, species_id, library_id)
VALUES ("Gruby", 1, 2);



CREATE USER 'user'@'localhost' IDENTIFIED BY '123password';
GRANT ALL PRIVILEGES ON plants.plants TO 'user'@'localhost';
GRANT SELECT ON plants.encyclopedia TO 'user'@'localhost';

CREATE USER 'expert'@'localhost' IDENTIFIED BY '456password';
GRANT ALL PRIVILEGES ON plants.plants TO 'expert'@'localhost';
GRANT INSERT, UPDATE, SELECT ON plants.encyclopedia TO 'expert'@'localhost';

CREATE USER 'admin'@'localhost' IDENTIFIED BY '789password';
GRANT SELECT, UPDATE ON plants.admins TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON plants.users TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON plants.plants TO 'admin'@'localhost';
GRANT INSERT, DELETE,SELECT ON plants.encyclopedia TO 'admin'@'localhost';
GRANT SELECT, DELETE ON plants.libraries TO 'admin'@'localhost';

CREATE USER 'login_manager'@'localhost' IDENTIFIED BY 'loginpassword123';
GRANT SELECT, UPDATE, INSERT ON plants.users TO 'login_manager'@'localhost';
GRANT SELECT, UPDATE ON plants.admins TO 'login_manager'@'localhost';
GRANT SELECT ON plants.libraries TO 'login_manager'@'localhost';
