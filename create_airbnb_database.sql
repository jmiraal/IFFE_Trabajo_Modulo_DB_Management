-- MySQL Script generated by MySQL Workbench
-- Thu May 21 22:31:43 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `airbnb` DEFAULT CHARACTER SET utf8 ;
USE `airbnb` ;

-- -----------------------------------------------------
-- Table `airbnb`.`dim_signup_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_signup_method` (
  `id_signup_method` INT NOT NULL,
  `signup_method` VARCHAR(45) NULL,
  PRIMARY KEY (`id_signup_method`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_affiliate_channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_affiliate_channel` (
  `id_affiliate_channel` INT NOT NULL,
  `affiliate_channel` VARCHAR(45) NULL,
  PRIMARY KEY (`id_affiliate_channel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_affiliate_provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_affiliate_provider` (
  `id_affiliate_provider` INT NOT NULL,
  `affiliate_provider` VARCHAR(45) NULL,
  PRIMARY KEY (`id_affiliate_provider`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_language` (
  `id_language` INT NOT NULL,
  `language` VARCHAR(45) NULL,
  PRIMARY KEY (`id_language`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_country` (
  `id_country` INT NOT NULL,
  `id_language` INT NULL,
  `country` VARCHAR(10) NULL,
  `km2` DOUBLE NULL,
  `latitude` DOUBLE NULL,
  `longitude` DOUBLE NULL,
  `distance_km` DOUBLE NULL,
  `language_levenshtein_distance` DOUBLE NULL,
  PRIMARY KEY (`id_country`),
  INDEX `fk_language_idx` (`id_language` ASC) VISIBLE,
  CONSTRAINT `fk_destination_language`
    FOREIGN KEY (`id_language`)
    REFERENCES `airbnb`.`dim_language` (`id_language`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_first_affiliate_tracked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_first_affiliate_tracked` (
  `id_first_affiliate_tracked` INT NOT NULL,
  `first_affiliate_tracked` VARCHAR(45) NULL,
  PRIMARY KEY (`id_first_affiliate_tracked`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_first_browser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_first_browser` (
  `id_first_browser` INT NOT NULL,
  `first_browser` VARCHAR(45) NULL,
  PRIMARY KEY (`id_first_browser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_first_device_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_first_device_type` (
  `id_first_device_type` INT NOT NULL,
  `first_device_type` VARCHAR(45) NULL,
  PRIMARY KEY (`id_first_device_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_signup_app`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_signup_app` (
  `id_signup_app` INT NOT NULL,
  `signup_app` VARCHAR(45) NULL,
  PRIMARY KEY (`id_signup_app`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_signup_flow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_signup_flow` (
  `id_signup_flow` INT NOT NULL,
  `signup_flow` INT NULL,
  PRIMARY KEY (`id_signup_flow`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_date` (
  `id_date` INT NOT NULL,
  `date` DATE NULL,
  `year` INT NULL,
  `month` INT NULL,
  `day` INT NULL,
  PRIMARY KEY (`id_date`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_gender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_gender` (
  `id_gender` INT NOT NULL,
  `gender` VARCHAR(15) NULL,
  PRIMARY KEY (`id_gender`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`dim_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`dim_user` (
  `id_user` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `id_gender` INT NULL,
  `id_language` INT NULL,
  `age` INT NULL,
  PRIMARY KEY (`id_user`),
  INDEX `fk_gender_idx` (`id_gender` ASC) VISIBLE,
  INDEX `fk_language_idx` (`id_language` ASC) VISIBLE,
  CONSTRAINT `fk_user_gender`
    FOREIGN KEY (`id_gender`)
    REFERENCES `airbnb`.`dim_gender` (`id_gender`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_language`
    FOREIGN KEY (`id_language`)
    REFERENCES `airbnb`.`dim_language` (`id_language`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`fact_user_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`fact_user_data` (
  `id` INT NOT NULL,
  `id_user` INT NULL,
  `id_signup_method` INT NULL,
  `id_signup_flow` INT NULL,
  `id_date_account_created` INT NULL,
  `id_affiliate_channel` INT NULL,
  `id_affiliate_provider` INT NULL,
  `id_first_affiliate_tracked` INT NULL,
  `id_signup_app` INT NULL,
  `id_first_device_type` INT NULL,
  `id_first_browser` INT NULL,
  `id_country_destination` INT NULL,
  `id_date_first_booking` INT NULL,
  `timestamp_first_active` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_affiliate_channel_idx` (`id_affiliate_channel` ASC) VISIBLE,
  INDEX `fk_affiliate_provider_idx` (`id_affiliate_provider` ASC) VISIBLE,
  INDEX `fk_country_idx` (`id_country_destination` ASC) VISIBLE,
  INDEX `fk_first_affiliate_tracked_idx` (`id_first_affiliate_tracked` ASC) VISIBLE,
  INDEX `fk_first_browser_idx` (`id_first_browser` ASC) VISIBLE,
  INDEX `fk_first_device_type_idx` (`id_first_device_type` ASC) VISIBLE,
  INDEX `fk_signup_app_idx` (`id_signup_app` ASC) VISIBLE,
  INDEX `fk_signup_flow_idx` (`id_signup_flow` ASC) VISIBLE,
  INDEX `fk_date_account_created_idx` (`id_date_account_created` ASC) VISIBLE,
  INDEX `fk_date_first_booking_idx` (`id_date_first_booking` ASC) VISIBLE,
  INDEX `fk_signup_method_idx` (`id_signup_method` ASC) VISIBLE,
  INDEX `fk_user_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_signup_method`
    FOREIGN KEY (`id_signup_method`)
    REFERENCES `airbnb`.`dim_signup_method` (`id_signup_method`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_affiliate_channel`
    FOREIGN KEY (`id_affiliate_channel`)
    REFERENCES `airbnb`.`dim_affiliate_channel` (`id_affiliate_channel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_affiliate_provider`
    FOREIGN KEY (`id_affiliate_provider`)
    REFERENCES `airbnb`.`dim_affiliate_provider` (`id_affiliate_provider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_country`
    FOREIGN KEY (`id_country_destination`)
    REFERENCES `airbnb`.`dim_country` (`id_country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_first_affiliate_tracked`
    FOREIGN KEY (`id_first_affiliate_tracked`)
    REFERENCES `airbnb`.`dim_first_affiliate_tracked` (`id_first_affiliate_tracked`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_first_browser`
    FOREIGN KEY (`id_first_browser`)
    REFERENCES `airbnb`.`dim_first_browser` (`id_first_browser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_first_device_type`
    FOREIGN KEY (`id_first_device_type`)
    REFERENCES `airbnb`.`dim_first_device_type` (`id_first_device_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_signup_app`
    FOREIGN KEY (`id_signup_app`)
    REFERENCES `airbnb`.`dim_signup_app` (`id_signup_app`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_signup_flow`
    FOREIGN KEY (`id_signup_flow`)
    REFERENCES `airbnb`.`dim_signup_flow` (`id_signup_flow`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_date_account_created`
    FOREIGN KEY (`id_date_account_created`)
    REFERENCES `airbnb`.`dim_date` (`id_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_date_first_booking`
    FOREIGN KEY (`id_date_first_booking`)
    REFERENCES `airbnb`.`dim_date` (`id_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `airbnb`.`dim_user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
