-- Nucleus Framework Database Schema
-- Basic database structure for the framework

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS `nucleus_core` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `nucleus_core`;

-- Players table
CREATE TABLE IF NOT EXISTS `nucleus_players` (
    `citizenid` varchar(50) NOT NULL,
    `license` varchar(50) NOT NULL,
    `name` varchar(50) NOT NULL,
    `money` text NOT NULL,
    `job` text NOT NULL,
    `position` text NOT NULL,
    `metadata` text NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`citizenid`),
    UNIQUE KEY `license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Vehicles table
CREATE TABLE IF NOT EXISTS `nucleus_vehicles` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) NOT NULL,
    `vehicle` varchar(50) NOT NULL,
    `plate` varchar(50) NOT NULL,
    `mods` text NOT NULL,
    `garage` varchar(50) DEFAULT 'pillboxgarage',
    `state` int(11) DEFAULT 1,
    `depotprice` int(11) DEFAULT 0,
    `drivingdistance` int(11) DEFAULT 0,
    `engine` float DEFAULT 1000,
    `body` float DEFAULT 1000,
    `fuel` int(11) DEFAULT 100,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `citizenid` (`citizenid`),
    KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Items table
CREATE TABLE IF NOT EXISTS `nucleus_items` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) NOT NULL,
    `item` varchar(50) NOT NULL,
    `amount` int(11) NOT NULL DEFAULT 1,
    `info` text DEFAULT NULL,
    `slot` int(11) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `citizenid` (`citizenid`),
    KEY `item` (`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Houses table
CREATE TABLE IF NOT EXISTS `nucleus_houses` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) NOT NULL,
    `coords` text NOT NULL,
    `owned` tinyint(1) NOT NULL DEFAULT 0,
    `price` int(11) NOT NULL DEFAULT 0,
    `locked` tinyint(1) NOT NULL DEFAULT 1,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Jobs table
CREATE TABLE IF NOT EXISTS `nucleus_jobs` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `label` varchar(50) NOT NULL,
    `grades` text NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default jobs
INSERT INTO `nucleus_jobs` (`name`, `label`, `grades`) VALUES
('unemployed', 'Unemployed', '{"0": {"name": "Unemployed", "payment": 0}}'),
('police', 'Police', '{"0": {"name": "Recruit", "payment": 50}, "1": {"name": "Officer", "payment": 75}, "2": {"name": "Sergeant", "payment": 100}, "3": {"name": "Lieutenant", "payment": 125}, "4": {"name": "Captain", "payment": 150}}'),
('ambulance', 'Ambulance', '{"0": {"name": "Recruit", "payment": 50}, "1": {"name": "Paramedic", "payment": 75}, "2": {"name": "Doctor", "payment": 100}, "3": {"name": "Surgeon", "payment": 125}, "4": {"name": "Chief", "payment": 150}}')
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`), `grades` = VALUES(`grades`);

-- Items table
CREATE TABLE IF NOT EXISTS `nucleus_items_data` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `label` varchar(50) NOT NULL,
    `weight` int(11) NOT NULL DEFAULT 1,
    `type` varchar(50) NOT NULL DEFAULT 'item',
    `image` varchar(50) DEFAULT NULL,
    `unique` tinyint(1) NOT NULL DEFAULT 0,
    `useable` tinyint(1) NOT NULL DEFAULT 0,
    `shouldClose` tinyint(1) NOT NULL DEFAULT 1,
    `combinable` text DEFAULT NULL,
    `description` text DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default items
INSERT INTO `nucleus_items_data` (`name`, `label`, `weight`, `type`, `image`, `unique`, `useable`, `shouldClose`, `description`) VALUES
('bread', 'Bread', 1, 'item', 'bread.png', 0, 1, 1, 'A loaf of bread'),
('water', 'Water', 1, 'item', 'water.png', 0, 1, 1, 'A bottle of water')
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`), `weight` = VALUES(`weight`), `type` = VALUES(`type`), `image` = VALUES(`image`), `unique` = VALUES(`unique`), `useable` = VALUES(`useable`), `shouldClose` = VALUES(`shouldClose`), `description` = VALUES(`description`);

-- Vehicles table
CREATE TABLE IF NOT EXISTS `nucleus_vehicles_data` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `brand` varchar(50) NOT NULL,
    `model` varchar(50) NOT NULL,
    `price` int(11) NOT NULL DEFAULT 0,
    `category` varchar(50) NOT NULL DEFAULT 'car',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default vehicles
INSERT INTO `nucleus_vehicles_data` (`name`, `brand`, `model`, `price`, `category`) VALUES
('adder', 'Truffade', 'adder', 1000000, 'super'),
('zentorno', 'Pegassi', 'zentorno', 725000, 'super')
ON DUPLICATE KEY UPDATE `brand` = VALUES(`brand`), `model` = VALUES(`model`), `price` = VALUES(`price`), `category` = VALUES(`category`);
