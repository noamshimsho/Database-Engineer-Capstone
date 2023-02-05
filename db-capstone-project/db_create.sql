-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `contact_num` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `contact_number` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(10) NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `table_number` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `booking_slot` TIME NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `customer-fk_idx` (`customer_id` ASC) VISIBLE,
  INDEX `employee-fk_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `customer-fk`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`Customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employee-fk`
    FOREIGN KEY (`employee_id`)
    REFERENCES `LittleLemonDB`.`Employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`item_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `menu_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `cuisine` VARCHAR(45) NOT NULL,
  INDEX `item-fk_idx` (`item_id` ASC) VISIBLE,
  PRIMARY KEY (`menu_id`, `item_id`),
  CONSTRAINT `item-fk`
    FOREIGN KEY (`item_id`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`item_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `booking_id` INT NOT NULL,
  `time` TIME NOT NULL,
  `menu_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `cost` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `booking-fk_idx` (`booking_id` ASC) VISIBLE,
  INDEX `menu-fk_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `booking-fk`
    FOREIGN KEY (`booking_id`)
    REFERENCES `LittleLemonDB`.`Bookings` (`booking_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `menu-fk`
    FOREIGN KEY (`menu_id`)
    REFERENCES `LittleLemonDB`.`Menu` (`menu_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderStatus` (
  `orderstatus_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `time` TIME NOT NULL,
  PRIMARY KEY (`orderstatus_id`),
  INDEX `order-fk_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `order-fk`
    FOREIGN KEY (`order_id`)
    REFERENCES `LittleLemonDB`.`Orders` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
