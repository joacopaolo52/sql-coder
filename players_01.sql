DROP SCHEMA IF EXISTS players_01;
CREATE SCHEMA IF NOT EXISTS players_01 ;
USE players_01 ;


-- TABLE PLAYERS --

DROP TABLE IF EXISTS PLAYERS;
CREATE TABLE IF NOT EXISTS `PLAYERS` (
`player_id` INT NOT NULL,
`player_name` VARCHAR(20),
`player_lastname` VARCHAR(20),
`birthdate` DATE NOT NULL,
`player_age` INT NOT NULL,
`team_id` INT,
`player_position` VARCHAR(4),
`country_id` INT,
`value_id` INT,
`national_id` INT,
PRIMARY KEY (`player_id`) ,
KEY  `team_id` (`team_id`),
KEY `country_id` (`country_id`)
 ) ;
 
 ALTER TABLE PLAYERS ADD CONSTRAINT fk_team FOREIGN KEY (`team_id`) REFERENCES `TEAMS` (`team_id`) , 
 ADD CONSTRAINT fk_country FOREIGN KEY (`country_id`) REFERENCES `COUNTRY` (`country_id`),
 ADD CONSTRAINT fk_player_value FOREIGN KEY (`value_id`) REFERENCES VALUE (`value_id`),
 ADD CONSTRAINT fk_national FOREIGN KEY (`national_id`) REFERENCES NATIONAL (`national_id`) ;
 
 
-- TABLE TEAMS --

DROP TABLE IF EXISTS TEAMS;
CREATE TABLE IF NOT EXISTS `TEAMS` (
`team_id` INT NOT NULL,
`team_name` VARCHAR(20),
`team_country` VARCHAR(20),
`confederation_id` INT ,
`tournament_id` INT,
PRIMARY KEY (`team_id`) 
 ) ;  
 
ALTER TABLE TEAMS ADD CONSTRAINT fk_team_confederation FOREIGN KEY (`confederation_id`) REFERENCES `confederations`(`confederation_id`) ,
ADD CONSTRAINT fk_team_tournament FOREIGN KEY (`tournament_id`) REFERENCES `TOURNAMENTS`(`tournament_id`) ;
 
 
-- TABLE NATIONAL TEAM --
 
DROP TABLE IF EXISTS  NATIONAL;
CREATE TABLE IF NOT EXISTS `NATIONAL` (
`national_id` INT NOT NULL,
`national_name` VARCHAR(20),
`confederation_id` INT,
`tournament_id` INT ,
`national_ranking` INT,
PRIMARY KEY (`national_id`) 
);

ALTER TABLE NATIONAL ADD CONSTRAINT fk_national_confederation FOREIGN KEY (`confederation_id`) REFERENCES `confederations`(`confederation_id`) , 
ADD CONSTRAINT fk_national_tournament FOREIGN KEY (`tournament_id`) REFERENCES `TOURNAMENTS`(`tournament_id`) ;


-- TABLE TOURNAMENTS --

DROP TABLE IF EXISTS  TOURNAMENTS;
CREATE TABLE `TOURNAMENTS` ( 
`tournament_id` INT NOT NULL,
`tournament_name` VARCHAR(20),
`confederation_id` INT,
`age_limit` BOOLEAN,
`max_age` INT DEFAULT NULL ,
PRIMARY KEY (`tournament_id`)
);

ALTER TABLE TOURNAMENTS ADD CONSTRAINT fk_tournament_confederation FOREIGN KEY (`confederation_id`) REFERENCES `confederations`(`confederation_id`) ;


-- TABLE CONFEDERATIONS --

DROP TABLE IF EXISTS  CONFEDERATIONS;
CREATE TABLE IF NOT EXISTS `CONFEDERATIONS` (
`confederation_id` INT NOT NULL,
`confederation_name` VARCHAR(20),
`continent` VARCHAR(20),
PRIMARY KEY (`confederation_id`)
);

-- TABLE COUNTRY --

DROP TABLE IF EXISTS  COUNTRY;
CREATE TABLE IF NOT EXISTS `COUNTRY` (
`country_id` INT NOT NULL,
`country_name` VARCHAR(20),
`continent` VARCHAR(20),
`confederation_id` INT,
PRIMARY KEY (`country_id`)

);

ALTER TABLE COUNTRY ADD CONSTRAINT fk_country_confederation FOREIGN KEY (`confederation_id`) REFERENCES `confederations`(`confederation_id`) ;



-- TABLE VALUE --

DROP TABLE IF EXISTS  VALUE;
CREATE TABLE `VALUE` (
`value_id` INT NOT NULL,
`market_value` INT ,
`team_value`  INT,
`clause` BOOLEAN ,
`clause_value` INT DEFAULT NULL,
`salary` DECIMAL ,
`player_id` INT,
`team_id` INT,
PRIMARY KEY (`value_id`)
) ;  

ALTER TABLE VALUE ADD CONSTRAINT fk_value_player FOREIGN KEY (`player_id`) REFERENCES `PLAYERS` (`player_id`),
ADD CONSTRAINT fk_team_value FOREIGN KEY (`team_id`) REFERENCES `TEAMS` (`team_id`) ;


-- TABLE STATISTICS --

DROP TABLE IF EXISTS  STATISTICS;
CREATE TABLE `STATISTICS` (	
`statistics_id` INT NOT NULL,
`goals` INT ,
`assists` INT ,
`minutes_played` INT ,
`red_cards` INT ,
`yellow_cards` INT ,
`player_id` INT,

PRIMARY KEY (`statistics_id`)
);

ALTER TABLE STATISTICS ADD CONSTRAINT fk_statistics_players FOREIGN KEY (`player_id`) REFERENCES `PLAYERS` (`player_id`) ;
