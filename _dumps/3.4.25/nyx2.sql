/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `__EFMigrationsHistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

CREATE TABLE `apartments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `citizenid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `bank_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `account_balance` int(11) NOT NULL DEFAULT 0,
  `account_type` enum('shared','job','gang') NOT NULL,
  `users` longtext DEFAULT '[]',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `account_name` (`account_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `bank_statements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) DEFAULT NULL,
  `account_name` varchar(50) DEFAULT 'checking',
  `amount` int(11) DEFAULT NULL,
  `reason` varchar(50) DEFAULT NULL,
  `statement_type` enum('deposit','withdraw') DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer',
  PRIMARY KEY (`id`),
  KEY `license` (`license`),
  KEY `discord` (`discord`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `casino_cache` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_slovak_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `casino_players` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(128) NOT NULL,
  `properties` longtext NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `cdev_chat_channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `icon` varchar(50) NOT NULL DEFAULT '0',
  `bgColor` varchar(50) NOT NULL DEFAULT '0',
  `allowMention` tinyint(4) NOT NULL DEFAULT 0,
  `restrictions` longtext NOT NULL,
  `range` int(11) NOT NULL DEFAULT 0,
  `enabled` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `cdev_dynamic_settings` (
  `name` varchar(100) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `crm_announcements` (
  `crm_id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_charid` varchar(255) NOT NULL,
  `crm_owner` varchar(255) NOT NULL DEFAULT '',
  `crm_owner_img` varchar(255) NOT NULL DEFAULT '',
  `crm_title` varchar(255) NOT NULL DEFAULT '',
  `crm_image` varchar(255) NOT NULL DEFAULT '',
  `crm_content` text NOT NULL,
  `crm_date` varchar(50) NOT NULL,
  PRIMARY KEY (`crm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `crm_bank_accounts` (
  `crm_id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_iban` varchar(255) NOT NULL,
  `crm_balance` int(11) NOT NULL,
  `crm_owner` varchar(255) NOT NULL,
  `crm_name` varchar(255) NOT NULL,
  `crm_type` varchar(55) NOT NULL,
  `crm_frozen` int(11) NOT NULL DEFAULT 0,
  `crm_members` text NOT NULL,
  `crm_score` int(11) NOT NULL DEFAULT 0,
  `crm_creation` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`crm_id`),
  UNIQUE KEY `crm_iban` (`crm_iban`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `crm_bank_cards` (
  `crm_id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_owner` varchar(255) NOT NULL,
  `crm_number` varchar(16) NOT NULL,
  `crm_pin` varchar(4) NOT NULL,
  `crm_holder` varchar(255) NOT NULL,
  `crm_type` varchar(55) NOT NULL,
  `crm_cvv` varchar(3) NOT NULL,
  `crm_status` int(11) NOT NULL DEFAULT 0,
  `crm_expire` varchar(5) NOT NULL,
  PRIMARY KEY (`crm_id`),
  UNIQUE KEY `crm_number` (`crm_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `crm_bank_loans` (
  `crm_id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_iban` varchar(255) NOT NULL,
  `crm_amount` int(11) NOT NULL,
  `crm_interest` float NOT NULL,
  `crm_status` int(11) NOT NULL,
  `crm_payments` int(11) NOT NULL,
  `crm_remaining` int(11) NOT NULL,
  `crm_recurring` float NOT NULL,
  `crm_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`crm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `crm_bank_recipients` (
  `crm_id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_owner` varchar(255) NOT NULL,
  `crm_recipients` text NOT NULL,
  PRIMARY KEY (`crm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `crm_bank_transactions` (
  `crm_id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_sender` varchar(255) NOT NULL,
  `crm_receiver` varchar(255) DEFAULT NULL,
  `crm_status` varchar(55) NOT NULL,
  `crm_amount` decimal(10,2) NOT NULL,
  `crm_type` varchar(55) NOT NULL,
  `crm_by` varchar(255) NOT NULL,
  `crm_description` text DEFAULT NULL,
  `crm_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`crm_id`),
  KEY `crm_sender` (`crm_sender`),
  KEY `crm_receiver` (`crm_receiver`),
  CONSTRAINT `crm_bank_transactions_ibfk_1` FOREIGN KEY (`crm_sender`) REFERENCES `crm_bank_accounts` (`crm_iban`) ON DELETE CASCADE,
  CONSTRAINT `crm_bank_transactions_ibfk_2` FOREIGN KEY (`crm_receiver`) REFERENCES `crm_bank_accounts` (`crm_iban`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `crm_marketplace` (
  `crm_id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_charid` varchar(255) NOT NULL,
  `crm_owner` varchar(255) NOT NULL,
  `crm_price` int(11) NOT NULL,
  `crm_phone` varchar(255) NOT NULL,
  `crm_image` varchar(255) NOT NULL,
  `crm_title` varchar(255) NOT NULL,
  `crm_description` varchar(255) NOT NULL,
  `crm_date` varchar(50) NOT NULL,
  PRIMARY KEY (`crm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `crm_outfits` (
  `crm_id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_owner` varchar(255) NOT NULL,
  `crm_name` varchar(50) NOT NULL,
  `crm_share` varchar(50) NOT NULL DEFAULT '',
  `crm_model` varchar(50) NOT NULL,
  `crm_clothing` varchar(1500) NOT NULL,
  `crm_accessories` varchar(1500) NOT NULL,
  PRIMARY KEY (`crm_id`),
  KEY `crm_owner` (`crm_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `crm_outfits_job` (
  `crm_id` int(11) NOT NULL AUTO_INCREMENT,
  `crm_owner` varchar(255) NOT NULL,
  `crm_name` varchar(50) NOT NULL,
  `crm_grades` varchar(255) NOT NULL DEFAULT '',
  `crm_model` varchar(50) NOT NULL,
  `crm_clothing` varchar(1500) NOT NULL,
  `crm_accessories` varchar(1500) NOT NULL,
  PRIMARY KEY (`crm_id`),
  KEY `crm_owner` (`crm_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `crypto` (
  `crypto` varchar(50) NOT NULL DEFAULT 'btc',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL,
  PRIMARY KEY (`crypto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `crypto_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `worth` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `crypto_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `citizenid` (`citizenid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `darkchat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(46) DEFAULT NULL,
  `name` varchar(50) DEFAULT '',
  `messages` text DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `dealers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `time` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `dealership_data` (
  `name` varchar(100) NOT NULL,
  `label` varchar(255) NOT NULL,
  `balance` float NOT NULL DEFAULT 0,
  `owner_id` varchar(255) DEFAULT NULL,
  `owner_name` varchar(255) DEFAULT NULL,
  `employee_commission` int(11) DEFAULT 10,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `dealership_dispveh` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dealership` varchar(100) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `color` varchar(100) NOT NULL,
  `coords` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dispveh_dealership` (`dealership`),
  KEY `fk_dispveh_vehicle` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `dealership_employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `dealership` varchar(255) NOT NULL,
  `role` varchar(100) NOT NULL,
  `joined` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_employees_dealership` (`dealership`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `dealership_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(100) NOT NULL,
  `dealership` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `cost` float NOT NULL DEFAULT 0,
  `delivery_time` int(11) NOT NULL,
  `order_created` datetime NOT NULL DEFAULT current_timestamp(),
  `fulfilled` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `orders_vehicle_fk` (`vehicle`),
  KEY `orders_dealership_fk` (`dealership`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `dealership_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dealership` varchar(255) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `plate` varchar(255) NOT NULL,
  `player` varchar(255) NOT NULL,
  `seller` varchar(255) DEFAULT NULL,
  `purchase_type` varchar(50) NOT NULL,
  `paid` float NOT NULL DEFAULT 0,
  `owed` float NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_sales_vehicle` (`vehicle`),
  KEY `fk_sales_dealership` (`dealership`),
  KEY `fk_sales_player` (`player`),
  KEY `fk_sales_plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `dealership_stock` (
  `dealership` varchar(100) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `price` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`dealership`,`vehicle`),
  KEY `vehicle_fk` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `dealership_vehicles` (
  `spawn_code` varchar(100) NOT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `hashkey` varchar(100) DEFAULT NULL,
  `category` varchar(100) NOT NULL,
  `price` float NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`spawn_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `discord_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(80) NOT NULL DEFAULT '0',
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `username` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `electus_gangs` (
  `owner` varchar(46) DEFAULT NULL,
  `gang_id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) DEFAULT 1,
  `xp` int(11) DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `cash` int(11) DEFAULT 0,
  `dirty_cash` int(11) DEFAULT 0,
  `color` varchar(50) DEFAULT '#0096FF',
  `safe_house_zone` int(11) DEFAULT NULL,
  `gang_rep` int(11) DEFAULT 0,
  PRIMARY KEY (`gang_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_base_tasks` (
  `gang_id` int(11) NOT NULL,
  `task_stage` int(11) DEFAULT NULL,
  `progress` int(11) DEFAULT NULL,
  PRIMARY KEY (`gang_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_capturable_zones` (
  `zone_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activated` datetime DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_current_weekly_task` (
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_doors` (
  `gang_id` int(11) DEFAULT NULL,
  `door_id` varchar(50) DEFAULT NULL,
  `password` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_logs` (
  `gang_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` varchar(50) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `date_stamp` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`,`gang_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_members` (
  `gang_id` int(11) NOT NULL,
  `identifier` varchar(46) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `joined` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`gang_id`,`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_money_laundering` (
  `zone_id` int(11) NOT NULL,
  `load` int(11) unsigned DEFAULT 0,
  `washed` int(11) unsigned DEFAULT 0,
  PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_roles` (
  `gang_id` int(11) unsigned NOT NULL,
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `grade` int(11) DEFAULT NULL,
  `role_data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`,`gang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_stats` (
  `gang_id` int(11) NOT NULL,
  `date_stamp` datetime NOT NULL DEFAULT current_timestamp(),
  `cash` int(11) DEFAULT NULL,
  `dirty_cash` int(11) DEFAULT NULL,
  `members` int(11) DEFAULT NULL,
  `gang_rep` int(11) DEFAULT NULL,
  `zones` int(11) DEFAULT NULL,
  PRIMARY KEY (`gang_id`,`date_stamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_transactions` (
  `gang_id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `handled_by` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` int(11) DEFAULT 0,
  `date_stamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`gang_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_upgrades` (
  `gang_id` int(11) NOT NULL,
  `upgrades` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_vehicles` (
  `gang_id` int(11) DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `gang_id` (`gang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_weed_drying` (
  `gang_id` int(11) NOT NULL,
  `rack_id` int(11) NOT NULL,
  `start_time` datetime DEFAULT current_timestamp(),
  `weed_index` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_weed_plants` (
  `zone_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` mediumtext DEFAULT NULL,
  `growth` int(11) DEFAULT 0,
  `health` int(11) DEFAULT 100,
  `water` int(11) DEFAULT 0,
  `fertilizer` int(11) DEFAULT 0,
  PRIMARY KEY (`id`,`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_weekly_tasks` (
  `gang_id` int(11) NOT NULL,
  `progress` int(11) DEFAULT NULL,
  PRIMARY KEY (`gang_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_zones` (
  `controlling_gang_id` int(11) DEFAULT NULL,
  `zone_id` int(11) NOT NULL,
  `captured` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `electus_gangs_zones_data` (
  `id` int(11) NOT NULL,
  `points` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `types` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `capture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `gang_menu` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `laundering_menu` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `capture_time` int(11) DEFAULT 15,
  `laundering_capacity` int(11) DEFAULT 0,
  `max_plants` int(11) DEFAULT 0,
  `max_recruits` int(11) DEFAULT 0,
  `ipl_id` varchar(255) DEFAULT NULL,
  `ipl_marker` longtext DEFAULT NULL,
  `garage` longtext DEFAULT NULL,
  `warehouse` longtext DEFAULT NULL,
  `weed_processing` longtext DEFAULT NULL,
  `vehicle_spawn_pos` longtext DEFAULT NULL,
  `max_cash` int(11) DEFAULT 0,
  `min_cash` int(11) DEFAULT 0,
  `max_npc` int(11) DEFAULT 0,
  `min_npc` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `facetime_call_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caller` varchar(50) NOT NULL DEFAULT '0',
  `calledId` varchar(50) DEFAULT NULL,
  `time` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `house_objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) NOT NULL DEFAULT '0',
  `coords` text NOT NULL,
  `house` varchar(80) DEFAULT NULL,
  `construction` varchar(50) DEFAULT NULL,
  `created` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `house_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `building` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT 'stage-a',
  `sort` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `health` int(11) DEFAULT 100,
  `progress` int(11) DEFAULT 0,
  `coords` text DEFAULT NULL,
  `plantid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `building` (`building`),
  KEY `plantid` (`plantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `house_rents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) NOT NULL DEFAULT '',
  `identifier` varchar(80) NOT NULL DEFAULT '',
  `payed` int(11) NOT NULL DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `houselocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(2) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `defaultPrice` int(11) DEFAULT NULL,
  `tier` tinyint(2) DEFAULT NULL,
  `garage` text DEFAULT NULL,
  `garageShell` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `mlo` text DEFAULT NULL,
  `ipl` text DEFAULT NULL,
  `console` int(11) DEFAULT NULL,
  `board` text DEFAULT NULL,
  `for_sale` int(11) DEFAULT 1,
  `extra_imgs` text DEFAULT NULL,
  `description` text NOT NULL DEFAULT '',
  `creatorJob` varchar(50) DEFAULT NULL,
  `blip` text DEFAULT NULL,
  `upgrades` text DEFAULT NULL,
  `apartmentCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `instagram_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `owner` varchar(120) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  `avatar` text DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `verified` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `phone` (`phone`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `instagram_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `follower` int(11) NOT NULL DEFAULT 0,
  `following` int(11) NOT NULL DEFAULT 0,
  `updatedDate` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `instagram_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` int(11) NOT NULL DEFAULT 0,
  `receiver` int(11) NOT NULL DEFAULT 0,
  `time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `messages` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `instagram_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL DEFAULT 0,
  `targetId` int(11) NOT NULL DEFAULT 0,
  `type` varchar(50) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `content` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `instagram_post_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `postId` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `postId` (`postId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `instagram_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `userId` int(11) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `content` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `type` tinytext DEFAULT NULL,
  `likes` text DEFAULT NULL,
  `filter` tinytext DEFAULT NULL,
  `commentCount` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `instagram_stories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL DEFAULT 0,
  `updatedDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `data` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

CREATE TABLE `inventories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`items`)),
  PRIMARY KEY (`identifier`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `inventory_clothes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `items` text DEFAULT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `inventory_glovebox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `inventory_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `inventory_stash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stash` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`stash`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `inventory_trunk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`plate`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `kub_truckingcontracts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` text NOT NULL,
  `playerid` int(11) DEFAULT NULL,
  `company` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `destinationcompany` text DEFAULT NULL,
  `vehiclemodel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `goodstype` text DEFAULT NULL,
  `startlocationname` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `startcoords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `destinationcoords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `payout` int(11) DEFAULT NULL,
  `deposit` int(11) DEFAULT NULL,
  `xppayout` int(11) DEFAULT NULL,
  `logo` text DEFAULT NULL,
  `destinationlocationname` longtext DEFAULT NULL,
  `distance` text DEFAULT NULL,
  `status` enum('Not Started','Started','Vehicle Spawned','Goods picked up','Goods delivered','Completed','Canceled','Expired') DEFAULT 'Not Started',
  `expirydate` text DEFAULT NULL,
  `donedate` text DEFAULT NULL,
  `adrlvl` tinyint(4) DEFAULT 0,
  `longdistancelvl` tinyint(4) DEFAULT 0,
  `fragilelvl` tinyint(4) DEFAULT 0,
  `highvaluelvl` tinyint(4) DEFAULT 0,
  `jitlvl` tinyint(4) DEFAULT 0,
  `jobtype` enum('Quick','Freight','Convoy') DEFAULT NULL,
  `convoyName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `citizenID` (`citizenid`(1024)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `kub_truckingplayervehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` text NOT NULL,
  `vehicleid` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `model` tinytext DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `citizenid` (`citizenid`(1024)) USING BTREE,
  KEY `vehicleid` (`vehicleid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `kub_truckingprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` text NOT NULL,
  `accountname` text DEFAULT NULL,
  `xp` int(11) DEFAULT 0,
  `nextlevelxp` int(11) DEFAULT NULL,
  `previouslevelxp` int(11) DEFAULT 0,
  `level` int(2) DEFAULT 1,
  `skillpoints` tinyint(3) unsigned DEFAULT 0,
  `rank` tinytext DEFAULT NULL,
  `totalpayout` int(11) DEFAULT 0,
  `totaldistance` decimal(20,2) DEFAULT 0.00,
  `profileurl` text DEFAULT '',
  `adrlvl` int(1) DEFAULT 0,
  `longdistancelvl` int(1) DEFAULT 0,
  `highvaluelvl` int(1) DEFAULT 0,
  `fragilelvl` int(1) DEFAULT 0,
  `jitlvl` int(1) DEFAULT 0,
  `availablexp` int(1) DEFAULT 0,
  `jobscompleted` int(1) DEFAULT 0,
  `lastupdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `citizenID` (`citizenid`(1024)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `kub_truckingvehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text DEFAULT NULL,
  `model` tinytext NOT NULL,
  `vehiclecondition` tinyint(4) DEFAULT 0,
  `price` int(11) NOT NULL,
  `power` tinytext DEFAULT NULL,
  `engine` text DEFAULT NULL,
  `jobscompleted` int(11) NOT NULL,
  `image` text DEFAULT NULL,
  `isdeleted` tinyint(1) unsigned zerofill NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `lapraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `mail_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT '0',
  `mail` varchar(50) DEFAULT '0',
  `name` varchar(50) DEFAULT '0',
  `password` varchar(50) DEFAULT '',
  `phone` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `market_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) NOT NULL DEFAULT '',
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `phone` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `avatar` text NOT NULL,
  `password` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `market_markets` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `job` text NOT NULL DEFAULT '[]',
  `ratings` text NOT NULL DEFAULT '[]',
  `coords` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `market_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `messages` text NOT NULL,
  `isMarket` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `mechanic_data` (
  `name` varchar(100) NOT NULL,
  `label` varchar(255) NOT NULL,
  `balance` float NOT NULL DEFAULT 0,
  `owner_id` varchar(255) DEFAULT NULL,
  `owner_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `mechanic_employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `mechanic` varchar(255) NOT NULL,
  `role` varchar(100) NOT NULL,
  `joined` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `mechanic_invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `mechanic` varchar(255) NOT NULL,
  `total` float NOT NULL,
  `data` text NOT NULL,
  `paid` tinyint(1) DEFAULT 0,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `mechanic_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `mechanic` varchar(255) NOT NULL,
  `plate` varchar(10) NOT NULL,
  `amount_paid` float NOT NULL DEFAULT 0,
  `cart` text NOT NULL,
  `props_to_apply` text NOT NULL,
  `installation_progress` text DEFAULT NULL,
  `fulfilled` tinyint(1) DEFAULT 0,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `mechanic_servicing_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `mechanic` varchar(255) NOT NULL,
  `plate` varchar(10) NOT NULL,
  `serviced_part` varchar(10) NOT NULL,
  `mileage_km` float NOT NULL DEFAULT 0,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `mechanic_settings` (
  `identifier` varchar(255) NOT NULL,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `mechanic_vehicledata` (
  `plate` varchar(10) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `nyx_crafting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(20) NOT NULL,
  `points` int(11) NOT NULL,
  `skills` text NOT NULL,
  `total_crafted` int(11) NOT NULL,
  `total_points` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `nyx_queue_payments` (
  `tebex_transaction_id` text NOT NULL,
  `discord_id` text NOT NULL,
  `points_to_add` int(11) NOT NULL,
  `add_slot` tinyint(1) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `nyx_queue_priority` (
  `discord` text NOT NULL,
  `priority_points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `nyx_queue_slots` (
  `discord` text NOT NULL,
  `redeemed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `nyx2_rewards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(20) NOT NULL,
  `month` int(11) NOT NULL,
  `streak` text NOT NULL,
  `last_claimed` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_app_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application` varchar(50) DEFAULT '0',
  `ratings` text DEFAULT '[]',
  `downloads` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_backups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  `owner` varchar(120) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `phone_bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` int(11) NOT NULL DEFAULT 0,
  `identifier` varchar(46) NOT NULL DEFAULT '',
  `timestamp` timestamp NULL DEFAULT current_timestamp(),
  `sender` varchar(50) NOT NULL DEFAULT '',
  `label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_blocked_phones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniqueId` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `phone_chatroom_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int(10) unsigned DEFAULT NULL,
  `member_id` varchar(20) DEFAULT NULL,
  `member_name` varchar(50) DEFAULT NULL,
  `message` text NOT NULL,
  `is_pinned` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_chatrooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_code` varchar(10) NOT NULL,
  `room_name` varchar(15) NOT NULL,
  `room_owner_id` int(11) DEFAULT NULL,
  `room_owner_name` varchar(50) DEFAULT NULL,
  `room_members` text DEFAULT '{}',
  `room_pin` varchar(50) DEFAULT NULL,
  `unpaid_balance` decimal(10,2) DEFAULT 0.00,
  `is_masked` tinyint(1) DEFAULT 0,
  `is_pinned` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `room_code` (`room_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_favorite_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `content` text NOT NULL,
  `type` varchar(15) NOT NULL DEFAULT '',
  `data` longtext NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `filter` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type` (`type`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  `candecline` int(1) NOT NULL DEFAULT 1,
  `reason` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL DEFAULT '',
  `number` varchar(50) DEFAULT NULL,
  `messages` longtext DEFAULT NULL,
  `created` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `unreaded` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_metadata` (
  `identifier` varchar(90) NOT NULL DEFAULT '',
  `metadata` longtext DEFAULT NULL,
  `phoneNumber` varchar(50) DEFAULT '',
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `phone_notifies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) DEFAULT NULL,
  `msg_content` text DEFAULT NULL,
  `msg_head` varchar(50) NOT NULL DEFAULT '',
  `app_name` text DEFAULT NULL,
  `msg_time` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_recipes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(50) NOT NULL DEFAULT '',
  `data` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `firstName` varchar(25) DEFAULT NULL,
  `lastName` varchar(25) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `url` text DEFAULT NULL,
  `picture` text DEFAULT './img/default.png',
  `tweetId` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `phone_yellowpages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` text DEFAULT NULL,
  `price` int(11) DEFAULT 0,
  `created` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0',
  `display` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `pp` text DEFAULT NULL,
  `isBlocked` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `player_houses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `house` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL,
  `decorateStash` text DEFAULT NULL,
  `charge` text DEFAULT NULL,
  `credit` varchar(50) DEFAULT NULL,
  `creditPrice` varchar(50) DEFAULT NULL,
  `console` text DEFAULT NULL,
  `decorateCoords` text DEFAULT NULL,
  `rented` int(11) DEFAULT NULL,
  `rentPrice` int(11) DEFAULT NULL,
  `rentable` int(11) DEFAULT NULL,
  `purchasable` int(11) DEFAULT NULL,
  `vaultCodes` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `house` (`house`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE,
  KEY `citizenid` (`citizenid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taker` varchar(46) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `read` tinyint(4) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  `medias` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`taker`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `skin` text DEFAULT NULL,
  `outfitId` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `outfitId` (`outfitId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `player_priv_garages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owners` longtext DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `h` float DEFAULT NULL,
  `distance` int(11) DEFAULT 10,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `player_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  `balance` int(11) NOT NULL DEFAULT 0,
  `paymentamount` int(11) NOT NULL DEFAULT 0,
  `paymentsleft` int(11) NOT NULL DEFAULT 0,
  `financetime` int(11) NOT NULL DEFAULT 0,
  `financed` tinyint(1) NOT NULL DEFAULT 0,
  `finance_data` longtext DEFAULT NULL,
  `damage` longtext DEFAULT '',
  `in_garage` tinyint(1) DEFAULT 1,
  `garage_id` varchar(255) DEFAULT 'Legion Square',
  `job_vehicle` tinyint(1) DEFAULT 0,
  `job_vehicle_rank` int(10) DEFAULT 0,
  `gang_vehicle` tinyint(1) DEFAULT 0,
  `gang_vehicle_rank` int(10) DEFAULT 0,
  `impound` int(10) DEFAULT 0,
  `impound_retrievable` int(10) DEFAULT 0,
  `impound_data` longtext DEFAULT '',
  `nickname` varchar(255) DEFAULT '',
  `mileage` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_playervehicles_plate` (`plate`),
  KEY `plate` (`plate`),
  KEY `citizenid` (`citizenid`),
  KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charinfo` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `phone_number` varchar(20) DEFAULT NULL,
  `crm_slot` int(11) NOT NULL DEFAULT -1,
  `crm_avatar_id` int(11) NOT NULL DEFAULT 1,
  `crm_favorite` int(11) NOT NULL DEFAULT 0,
  `crm_is_premium` varchar(50) NOT NULL DEFAULT '0',
  `crm_tattoos` text NOT NULL DEFAULT '',
  `cryptocurrency` longtext NOT NULL DEFAULT '',
  `crypto_wallet_id` text DEFAULT NULL,
  `inside` varchar(50) DEFAULT '',
  `crm_ck` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`citizenid`),
  KEY `id` (`id`),
  KEY `last_updated` (`last_updated`),
  KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(2) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE `race_tracks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `metadata` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creatorid` varchar(50) DEFAULT NULL,
  `creatorname` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL,
  `access` text DEFAULT NULL,
  `curated` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `raceid` (`raceid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `racer_names` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` text NOT NULL,
  `racername` text NOT NULL,
  `lasttouched` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `races` int(11) NOT NULL DEFAULT 0,
  `wins` int(11) NOT NULL DEFAULT 0,
  `tracks` int(11) NOT NULL DEFAULT 0,
  `auth` varchar(50) DEFAULT 'racer',
  `crew` varchar(50) DEFAULT NULL,
  `createdby` varchar(50) DEFAULT NULL,
  `revoked` tinyint(4) DEFAULT 0,
  `ranking` int(11) DEFAULT 0,
  `active` int(11) NOT NULL DEFAULT 0,
  `crypto` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `racing_crews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crew_name` text DEFAULT NULL,
  `members` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `wins` int(11) DEFAULT NULL,
  `races` int(11) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `founder_name` text DEFAULT NULL,
  `founder_citizenid` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

CREATE TABLE `radiocar_music` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(64) NOT NULL,
  `url` varchar(256) NOT NULL,
  `plate` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `radiocar_owned` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spz` varchar(32) NOT NULL,
  `style` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `radiocar_playlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `playlist` text NOT NULL,
  `plate` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE `stickers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `vehicle_hash` varchar(50) NOT NULL,
  `vehicle_plate` varchar(50) NOT NULL,
  `scale` float NOT NULL,
  `rotation` float NOT NULL,
  `ray_from_x` float NOT NULL,
  `ray_from_y` float NOT NULL,
  `ray_from_z` float NOT NULL,
  `ray_to_x` float NOT NULL,
  `ray_to_y` float NOT NULL,
  `ray_to_z` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tiktok_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) DEFAULT NULL,
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `pp` text DEFAULT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `bio` text NOT NULL DEFAULT '',
  `birthday` varchar(50) NOT NULL DEFAULT '0',
  `videos` text NOT NULL DEFAULT '{}',
  `followers` text NOT NULL,
  `following` text NOT NULL,
  `liked` text NOT NULL,
  `verified` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tiktok_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tinder_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '0',
  `owner` varchar(70) NOT NULL DEFAULT '0',
  `photos` text DEFAULT NULL,
  `dob` varchar(50) DEFAULT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `interested` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tinder_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unread` int(11) NOT NULL DEFAULT 0,
  `sender` int(11) NOT NULL DEFAULT 0,
  `receiver` int(11) NOT NULL DEFAULT 0,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `messages` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tinder_swipers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL DEFAULT 0,
  `targetId` int(11) NOT NULL DEFAULT 0,
  `liked` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(46) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `phone` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `verified` int(11) DEFAULT NULL,
  `background` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `twitter_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `follower` int(11) DEFAULT NULL,
  `following` int(11) DEFAULT NULL,
  `updatedDate` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `twitter_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `messages` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `twitter_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL DEFAULT 0,
  `targetUserId` int(11) NOT NULL DEFAULT 0,
  `type` varchar(50) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `twitter_retweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL DEFAULT 0,
  `tweetId` int(11) NOT NULL DEFAULT 0,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `text` text DEFAULT NULL,
  `media` text DEFAULT NULL,
  `likes` text DEFAULT '[]',
  `mentions` text DEFAULT '[]',
  `comments` text DEFAULT '[]',
  `retweets` text DEFAULT '[]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `uber_rider_last_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `target` varchar(80) DEFAULT NULL,
  `targetName` varchar(50) DEFAULT NULL,
  `plate` varchar(80) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `weazel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(46) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `image` text DEFAULT NULL,
  `created` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `whatsapp_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '0',
  `avatar` text NOT NULL DEFAULT '',
  `bio` varchar(50) NOT NULL DEFAULT '',
  `group_creator` int(11) DEFAULT NULL,
  `created` timestamp NULL DEFAULT current_timestamp(),
  `hide_receipts` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `whatsapp_call_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caller` int(11) NOT NULL DEFAULT 0,
  `calledId` int(11) DEFAULT NULL,
  `time` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `whatsapp_call_history_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL DEFAULT 0,
  `callId` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `whatsapp_chats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` int(11) NOT NULL DEFAULT 0,
  `receiver` int(11) NOT NULL DEFAULT 0,
  `wallpaper` text DEFAULT NULL,
  `isGroup` varchar(50) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `messages` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `whatsapp_group_admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL DEFAULT 0,
  `groupId` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `whatsapp_group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL DEFAULT 0,
  `groupId` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `whatsapp_status` (
  `userId` int(11) NOT NULL DEFAULT 0,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;











INSERT INTO `casino_cache` (`ID`, `Settings`) VALUES
(1, '{\"PodiumPriceProps\":{\"modTransmission\":2,\"modSmokeEnabled\":1,\"modArmor\":4,\"modTurbo\":1,\"engineHealth\":1,\"modLivery\":1,\"modDashboard\":-1,\"modTrunk\":-1,\"bodyHealth\":1,\"modSpoilers\":3,\"podiumName\":\"SHEAVA\",\"modFender\":-1,\"model\":819197656,\"color2\":111,\"modFrontWheels\":-1,\"extras\":{\"1\":false},\"modStruts\":-1,\"modSuspension\":-1,\"neonEnabled\":[false,false,false,false],\"modShifterLeavers\":-1,\"modGrille\":-1,\"modWindows\":-1,\"modArchCover\":-1,\"modAPlate\":-1,\"modFrontBumper\":1,\"wheelColor\":111,\"modRoof\":2,\"modDoorSpeaker\":-1,\"wheels\":5,\"modSpeakers\":-1,\"modExhaust\":0,\"modBackWheels\":-1,\"modHood\":0,\"modFrame\":-1,\"dirtLevel\":1,\"modRearBumper\":0,\"pearlescentColor\":111,\"xenonColor\":12,\"modAerials\":-1,\"windowTint\":6,\"plateIndex\":0,\"tyreSmokeColor\":[1,1,1],\"modTrimA\":-1,\"modSideSkirt\":-1,\"modVanityPlate\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1,\"tankHealth\":1,\"modEngineBlock\":-1,\"modTrimB\":-1,\"modEngine\":3,\"modHydrolic\":-1,\"modHorns\":57,\"modRightFender\":-1,\"modAirFilter\":-1,\"fuelLevel\":1,\"modBrakes\":2,\"modPlateHolder\":-1,\"color1\":111,\"modXenon\":1,\"modSeats\":-1,\"modTank\":-1}}');










INSERT INTO `crm_bank_accounts` (`crm_id`, `crm_iban`, `crm_balance`, `crm_owner`, `crm_name`, `crm_type`, `crm_frozen`, `crm_members`, `crm_score`, `crm_creation`) VALUES
(1, 'USA53SO316383318432', 10000, 'police', 'Police Department', 'crm-society', 0, '[]', 0, '2025-02-08 21:18:13');
INSERT INTO `crm_bank_accounts` (`crm_id`, `crm_iban`, `crm_balance`, `crm_owner`, `crm_name`, `crm_type`, `crm_frozen`, `crm_members`, `crm_score`, `crm_creation`) VALUES
(2, 'USA67SO373146780209', 10000, 'ambulance', 'EMS', 'crm-society', 0, '[]', 0, '2025-02-08 21:18:13');
















INSERT INTO `crypto` (`crypto`, `worth`, `history`) VALUES
('btc', 5000, '[{\"PreviousWorth\":97552.15,\"NewWorth\":5000},{\"PreviousWorth\":97552.15,\"NewWorth\":5000},{\"PreviousWorth\":97552.15,\"NewWorth\":5000},{\"NewWorth\":5000,\"PreviousWorth\":97553.74}]');
INSERT INTO `crypto` (`crypto`, `worth`, `history`) VALUES
('qbit', 1143, '[{\"PreviousWorth\":1147,\"NewWorth\":1139},{\"PreviousWorth\":1147,\"NewWorth\":1139},{\"PreviousWorth\":1147,\"NewWorth\":1139},{\"PreviousWorth\":1139,\"NewWorth\":1143}]');


INSERT INTO `crypto_history` (`id`, `worth`, `name`, `date`) VALUES
(1, 96633, 'btc', '2025-02-09 15:42:15');
INSERT INTO `crypto_history` (`id`, `worth`, `name`, `date`) VALUES
(2, 96599, 'btc', '2025-02-09 15:44:15');
INSERT INTO `crypto_history` (`id`, `worth`, `name`, `date`) VALUES
(3, 96593, 'btc', '2025-02-09 15:46:16');
INSERT INTO `crypto_history` (`id`, `worth`, `name`, `date`) VALUES
(4, 96558, 'btc', '2025-02-09 15:48:51'),
(5, 96566, 'btc', '2025-02-09 15:50:52'),
(6, 96587, 'btc', '2025-02-09 15:52:52'),
(7, 96558, 'btc', '2025-02-09 15:54:52'),
(8, 96521, 'btc', '2025-02-09 15:56:52'),
(9, 96505, 'btc', '2025-02-09 15:58:53'),
(10, 96517, 'btc', '2025-02-09 16:00:53'),
(11, 96426, 'btc', '2025-02-09 16:02:54'),
(12, 96422, 'btc', '2025-02-09 16:04:54'),
(13, 96497, 'btc', '2025-02-09 16:06:54'),
(14, 96473, 'btc', '2025-02-09 16:08:54'),
(15, 96484, 'btc', '2025-02-09 16:10:54'),
(16, 96484, 'btc', '2025-02-09 16:12:55'),
(17, 96548, 'btc', '2025-02-09 16:14:55'),
(18, 96434, 'btc', '2025-02-09 16:16:55'),
(19, 96474, 'btc', '2025-02-09 16:18:56'),
(20, 96504, 'btc', '2025-02-09 16:20:56'),
(21, 96498, 'btc', '2025-02-09 16:22:57'),
(22, 96506, 'btc', '2025-02-09 16:24:57'),
(23, 96509, 'btc', '2025-02-09 16:26:57'),
(24, 96513, 'btc', '2025-02-09 16:28:57'),
(25, 96451, 'btc', '2025-02-09 16:30:58'),
(26, 96375, 'btc', '2025-02-09 16:32:59'),
(27, 96494, 'btc', '2025-02-09 16:34:59'),
(28, 96415, 'btc', '2025-02-09 16:37:00'),
(29, 96442, 'btc', '2025-02-09 16:39:00'),
(30, 96490, 'btc', '2025-02-09 16:41:00'),
(31, 96479, 'btc', '2025-02-09 16:43:00'),
(32, 96465, 'btc', '2025-02-09 16:45:01'),
(33, 96501, 'btc', '2025-02-09 16:47:01'),
(34, 96470, 'btc', '2025-02-09 16:49:02'),
(35, 96506, 'btc', '2025-02-09 16:51:02'),
(36, 96521, 'btc', '2025-02-09 16:53:06'),
(37, 96510, 'btc', '2025-02-09 16:55:06'),
(38, 96502, 'btc', '2025-02-09 16:57:06'),
(39, 96514, 'btc', '2025-02-09 16:59:07'),
(40, 96471, 'btc', '2025-02-09 17:01:08'),
(41, 96558, 'btc', '2025-02-09 17:03:08'),
(42, 96540, 'btc', '2025-02-09 17:05:08'),
(43, 96552, 'btc', '2025-02-09 17:07:09'),
(44, 96546, 'btc', '2025-02-09 17:09:09'),
(45, 96515, 'btc', '2025-02-09 17:11:09'),
(46, 96490, 'btc', '2025-02-09 17:13:09'),
(47, 96430, 'btc', '2025-02-09 17:15:11'),
(48, 96381, 'btc', '2025-02-09 17:17:12'),
(49, 96287, 'btc', '2025-02-09 17:19:12'),
(50, 96301, 'btc', '2025-02-09 17:21:12'),
(51, 96316, 'btc', '2025-02-09 17:23:13'),
(52, 96239, 'btc', '2025-02-09 17:25:13'),
(53, 96277, 'btc', '2025-02-09 17:27:14'),
(54, 96264, 'btc', '2025-02-09 17:29:15'),
(55, 96143, 'btc', '2025-02-09 17:31:16'),
(56, 96095, 'btc', '2025-02-09 17:33:16'),
(57, 95985, 'btc', '2025-02-09 17:35:16'),
(58, 96081, 'btc', '2025-02-09 17:37:17'),
(59, 96066, 'btc', '2025-02-09 17:39:18'),
(60, 96093, 'btc', '2025-02-09 17:41:18'),
(61, 96128, 'btc', '2025-02-09 17:43:18'),
(62, 96075, 'btc', '2025-02-09 17:45:21'),
(63, 96014, 'btc', '2025-02-09 17:47:21'),
(64, 96143, 'btc', '2025-02-09 17:49:22'),
(65, 96186, 'btc', '2025-02-09 17:51:22'),
(66, 96212, 'btc', '2025-02-09 17:53:22'),
(67, 96226, 'btc', '2025-02-09 17:55:23'),
(68, 96213, 'btc', '2025-02-09 17:57:24'),
(69, 96213, 'btc', '2025-02-09 17:59:29'),
(70, 96121, 'btc', '2025-02-09 18:01:29'),
(71, 96130, 'btc', '2025-02-09 18:03:31'),
(72, 96117, 'btc', '2025-02-09 18:05:31'),
(73, 96145, 'btc', '2025-02-09 18:07:32'),
(74, 96123, 'btc', '2025-02-09 18:09:32'),
(75, 96067, 'btc', '2025-02-09 18:11:32'),
(76, 96083, 'btc', '2025-02-09 18:13:32'),
(77, 96044, 'btc', '2025-02-09 18:15:33'),
(78, 96090, 'btc', '2025-02-09 18:17:33'),
(79, 96133, 'btc', '2025-02-09 18:19:33'),
(80, 96143, 'btc', '2025-02-09 18:21:34'),
(81, 96072, 'btc', '2025-02-09 18:23:34'),
(82, 96067, 'btc', '2025-02-09 18:25:34'),
(83, 96115, 'btc', '2025-02-09 18:27:34'),
(84, 96093, 'btc', '2025-02-09 18:29:35'),
(85, 96113, 'btc', '2025-02-09 18:31:35'),
(86, 96104, 'btc', '2025-02-09 18:33:35'),
(87, 96130, 'btc', '2025-02-09 18:35:35'),
(88, 96157, 'btc', '2025-02-09 18:37:36'),
(89, 96201, 'btc', '2025-02-09 18:39:36'),
(90, 96192, 'btc', '2025-02-09 18:41:36'),
(91, 96279, 'btc', '2025-02-09 18:43:37'),
(92, 96233, 'btc', '2025-02-09 18:45:41'),
(93, 96187, 'btc', '2025-02-09 18:47:41'),
(94, 96170, 'btc', '2025-02-09 18:49:43'),
(95, 96205, 'btc', '2025-02-09 18:51:43'),
(96, 96257, 'btc', '2025-02-09 18:53:43'),
(97, 96200, 'btc', '2025-02-09 18:55:50'),
(98, 96206, 'btc', '2025-02-09 18:57:51'),
(99, 96233, 'btc', '2025-02-09 18:59:59'),
(100, 96160, 'btc', '2025-02-09 19:02:00'),
(101, 96224, 'btc', '2025-02-09 19:04:00'),
(102, 96269, 'btc', '2025-02-09 19:06:00'),
(103, 96266, 'btc', '2025-02-09 19:08:00'),
(104, 96283, 'btc', '2025-02-09 19:10:02'),
(105, 96252, 'btc', '2025-02-09 19:12:02'),
(106, 96260, 'btc', '2025-02-09 19:14:03'),
(107, 96211, 'btc', '2025-02-09 19:16:08'),
(108, 96180, 'btc', '2025-02-09 19:18:09'),
(109, 96148, 'btc', '2025-02-09 19:20:09'),
(110, 96114, 'btc', '2025-02-09 19:22:09'),
(111, 96062, 'btc', '2025-02-09 19:24:10'),
(112, 96075, 'btc', '2025-02-09 19:26:10'),
(113, 96049, 'btc', '2025-02-09 19:28:10'),
(114, 96069, 'btc', '2025-02-09 19:30:11'),
(115, 96083, 'btc', '2025-02-09 19:32:11'),
(116, 95987, 'btc', '2025-02-09 19:34:11'),
(117, 96021, 'btc', '2025-02-09 19:36:12'),
(118, 95947, 'btc', '2025-02-09 19:38:12'),
(119, 95982, 'btc', '2025-02-09 19:40:12'),
(120, 95936, 'btc', '2025-02-09 19:42:13'),
(121, 96001, 'btc', '2025-02-09 19:44:15'),
(122, 95947, 'btc', '2025-02-09 19:46:15'),
(123, 96008, 'btc', '2025-02-09 19:48:16'),
(124, 96056, 'btc', '2025-02-09 19:50:17'),
(125, 96045, 'btc', '2025-02-09 19:52:17'),
(126, 96029, 'btc', '2025-02-09 19:54:18'),
(127, 96058, 'btc', '2025-02-09 19:56:18'),
(128, 96073, 'btc', '2025-02-09 19:58:18'),
(129, 96086, 'btc', '2025-02-09 20:00:21'),
(130, 96128, 'btc', '2025-02-09 20:02:21'),
(131, 96117, 'btc', '2025-02-09 20:04:23'),
(132, 96161, 'btc', '2025-02-09 20:06:26'),
(133, 96209, 'btc', '2025-02-09 20:08:26'),
(134, 96198, 'btc', '2025-02-09 20:10:26'),
(135, 96197, 'btc', '2025-02-09 20:12:27'),
(136, 96227, 'btc', '2025-02-09 20:14:28'),
(137, 96260, 'btc', '2025-02-09 20:16:28'),
(138, 96193, 'btc', '2025-02-09 20:18:28'),
(139, 96201, 'btc', '2025-02-09 20:20:28'),
(140, 96268, 'btc', '2025-02-09 20:22:33'),
(141, 96300, 'btc', '2025-02-09 20:24:33'),
(142, 96334, 'btc', '2025-02-09 20:26:33'),
(143, 96385, 'btc', '2025-02-09 20:28:33'),
(144, 96469, 'btc', '2025-02-09 20:30:34'),
(145, 96486, 'btc', '2025-02-09 20:32:34'),
(146, 96453, 'btc', '2025-02-09 20:34:34'),
(147, 96698, 'btc', '2025-02-09 20:36:35'),
(148, 96531, 'btc', '2025-02-09 20:38:36'),
(149, 96566, 'btc', '2025-02-09 20:40:36'),
(150, 96530, 'btc', '2025-02-09 20:42:36'),
(151, 96503, 'btc', '2025-02-09 20:44:37'),
(152, 96436, 'btc', '2025-02-09 20:46:37'),
(153, 96423, 'btc', '2025-02-09 20:48:37'),
(154, 96353, 'btc', '2025-02-09 20:50:37'),
(155, 96307, 'btc', '2025-02-09 20:52:38'),
(156, 96259, 'btc', '2025-02-09 20:54:38'),
(157, 96270, 'btc', '2025-02-09 20:56:38'),
(158, 96282, 'btc', '2025-02-09 20:58:38'),
(159, 96298, 'btc', '2025-02-09 21:00:41'),
(160, 96256, 'btc', '2025-02-09 21:02:43'),
(161, 96253, 'btc', '2025-02-09 21:04:44'),
(162, 96279, 'btc', '2025-02-09 21:06:46'),
(163, 96322, 'btc', '2025-02-09 21:08:46'),
(164, 96299, 'btc', '2025-02-09 21:10:46'),
(165, 96291, 'btc', '2025-02-09 21:12:47'),
(166, 96269, 'btc', '2025-02-09 21:14:47'),
(167, 96276, 'btc', '2025-02-09 21:16:47'),
(168, 96118, 'btc', '2025-02-09 21:18:48'),
(169, 96091, 'btc', '2025-02-09 21:20:49'),
(170, 96018, 'btc', '2025-02-09 21:22:50'),
(171, 96058, 'btc', '2025-02-09 21:24:50'),
(172, 96009, 'btc', '2025-02-09 21:26:50'),
(173, 95988, 'btc', '2025-02-09 21:28:51'),
(174, 95940, 'btc', '2025-02-09 21:30:52'),
(175, 95932, 'btc', '2025-02-09 21:32:52'),
(176, 95871, 'btc', '2025-02-09 21:34:53'),
(177, 95880, 'btc', '2025-02-09 21:36:53'),
(178, 95558, 'btc', '2025-02-09 21:38:53'),
(179, 95400, 'btc', '2025-02-09 21:40:53'),
(180, 95364, 'btc', '2025-02-09 21:42:54'),
(181, 95048, 'btc', '2025-02-09 21:44:54'),
(182, 95032, 'btc', '2025-02-09 21:46:54'),
(183, 95064, 'btc', '2025-02-09 21:48:54'),
(184, 94942, 'btc', '2025-02-09 21:50:55'),
(185, 94816, 'btc', '2025-02-09 21:52:55'),
(186, 94910, 'btc', '2025-02-09 21:54:55'),
(187, 94945, 'btc', '2025-02-09 21:56:55'),
(188, 95294, 'btc', '2025-02-09 21:58:56'),
(189, 94987, 'btc', '2025-02-09 22:00:56'),
(190, 95141, 'btc', '2025-02-09 22:02:56'),
(191, 95062, 'btc', '2025-02-09 22:04:56'),
(192, 95050, 'btc', '2025-02-09 22:06:58'),
(193, 95161, 'btc', '2025-02-09 22:08:59'),
(194, 95262, 'btc', '2025-02-09 22:10:59'),
(195, 95307, 'btc', '2025-02-09 22:13:01'),
(196, 95456, 'btc', '2025-02-09 22:15:01'),
(197, 95416, 'btc', '2025-02-09 22:17:01'),
(198, 95516, 'btc', '2025-02-09 22:19:03'),
(199, 96922, 'btc', '2025-02-11 14:12:00'),
(200, 96902, 'btc', '2025-02-11 14:14:00'),
(201, 96897, 'btc', '2025-02-11 14:16:00'),
(202, 96900, 'btc', '2025-02-11 14:18:02'),
(203, 97020, 'btc', '2025-02-11 14:20:03'),
(204, 96946, 'btc', '2025-02-11 14:22:03'),
(205, 96904, 'btc', '2025-02-11 14:24:04'),
(206, 96849, 'btc', '2025-02-11 14:26:05'),
(207, 96887, 'btc', '2025-02-11 14:28:05'),
(208, 96912, 'btc', '2025-02-11 14:30:06'),
(209, 96874, 'btc', '2025-02-11 14:32:06'),
(210, 96815, 'btc', '2025-02-11 14:34:08'),
(211, 96938, 'btc', '2025-02-11 14:36:08'),
(212, 96978, 'btc', '2025-02-11 14:38:08'),
(213, 96974, 'btc', '2025-02-11 14:40:09'),
(214, 97022, 'btc', '2025-02-11 14:42:09'),
(215, 97163, 'btc', '2025-02-11 14:44:10'),
(216, 97218, 'btc', '2025-02-11 14:46:10'),
(217, 97147, 'btc', '2025-02-11 14:48:12'),
(218, 97096, 'btc', '2025-02-11 14:50:12'),
(219, 97078, 'btc', '2025-02-11 14:52:13'),
(220, 97115, 'btc', '2025-02-11 14:54:13'),
(221, 97076, 'btc', '2025-02-11 14:56:13'),
(222, 97014, 'btc', '2025-02-11 14:58:14'),
(223, 96974, 'btc', '2025-02-11 15:00:15'),
(224, 97147, 'btc', '2025-02-11 15:02:16'),
(225, 97240, 'btc', '2025-02-11 15:04:16'),
(226, 97007, 'btc', '2025-02-11 15:06:16'),
(227, 96774, 'btc', '2025-02-11 15:08:17'),
(228, 96828, 'btc', '2025-02-11 15:10:17'),
(229, 96834, 'btc', '2025-02-11 15:12:17'),
(230, 96887, 'btc', '2025-02-11 15:14:17'),
(231, 97012, 'btc', '2025-02-11 15:16:18'),
(232, 97174, 'btc', '2025-02-11 15:18:18'),
(233, 97131, 'btc', '2025-02-11 15:20:18'),
(234, 96991, 'btc', '2025-02-11 15:22:18'),
(235, 96938, 'btc', '2025-02-11 15:24:19'),
(236, 96945, 'btc', '2025-02-11 15:26:19'),
(237, 96911, 'btc', '2025-02-11 15:28:19'),
(238, 96956, 'btc', '2025-02-11 15:30:20'),
(239, 97056, 'btc', '2025-02-11 15:32:21'),
(240, 97021, 'btc', '2025-02-11 15:34:21'),
(241, 96973, 'btc', '2025-02-11 15:36:23'),
(242, 96930, 'btc', '2025-02-11 15:38:23'),
(243, 96919, 'btc', '2025-02-11 15:40:23'),
(244, 96869, 'btc', '2025-02-11 15:42:25'),
(245, 96864, 'btc', '2025-02-11 15:44:25'),
(246, 96946, 'btc', '2025-02-11 15:46:26'),
(247, 96997, 'btc', '2025-02-11 15:48:26'),
(248, 97041, 'btc', '2025-02-11 15:50:26'),
(249, 97013, 'btc', '2025-02-11 15:52:27'),
(250, 97065, 'btc', '2025-02-11 15:54:27'),
(251, 97088, 'btc', '2025-02-11 15:56:28'),
(252, 97041, 'btc', '2025-02-11 15:58:28'),
(253, 97032, 'btc', '2025-02-11 16:00:29'),
(254, 96958, 'btc', '2025-02-11 16:02:35'),
(255, 96912, 'btc', '2025-02-11 16:04:39'),
(256, 96863, 'btc', '2025-02-11 16:06:43'),
(257, 96837, 'btc', '2025-02-11 16:08:44'),
(258, 96988, 'btc', '2025-02-11 16:10:44'),
(259, 97042, 'btc', '2025-02-11 16:12:44'),
(260, 97018, 'btc', '2025-02-11 16:14:44'),
(261, 96985, 'btc', '2025-02-11 16:16:45'),
(262, 96976, 'btc', '2025-02-11 16:18:45'),
(263, 97024, 'btc', '2025-02-11 16:20:45'),
(264, 96997, 'btc', '2025-02-11 16:22:46'),
(265, 96916, 'btc', '2025-02-11 16:24:49'),
(266, 96682, 'btc', '2025-02-11 16:26:49'),
(267, 96678, 'btc', '2025-02-11 16:28:50'),
(268, 96656, 'btc', '2025-02-11 16:30:50'),
(269, 96553, 'btc', '2025-02-11 16:32:50'),
(270, 96506, 'btc', '2025-02-11 16:34:50'),
(271, 96497, 'btc', '2025-02-11 16:36:51'),
(272, 96546, 'btc', '2025-02-11 16:38:55'),
(273, 96529, 'btc', '2025-02-11 16:41:06'),
(274, 96562, 'btc', '2025-02-11 16:43:06'),
(275, 96525, 'btc', '2025-02-11 16:45:07'),
(276, 96459, 'btc', '2025-02-11 16:47:07'),
(277, 96456, 'btc', '2025-02-11 16:49:07'),
(278, 96415, 'btc', '2025-02-11 16:51:08'),
(279, 96346, 'btc', '2025-02-11 16:53:08'),
(280, 96378, 'btc', '2025-02-11 16:55:08'),
(281, 96369, 'btc', '2025-02-11 16:57:09'),
(282, 96312, 'btc', '2025-02-11 16:59:10'),
(283, 96365, 'btc', '2025-02-11 17:01:10'),
(284, 96279, 'btc', '2025-02-11 17:03:10'),
(285, 96230, 'btc', '2025-02-11 17:05:11'),
(286, 96176, 'btc', '2025-02-11 17:07:11'),
(287, 96104, 'btc', '2025-02-11 17:09:12'),
(288, 96127, 'btc', '2025-02-11 17:11:12'),
(289, 96123, 'btc', '2025-02-11 17:13:12'),
(290, 96073, 'btc', '2025-02-11 17:15:13'),
(291, 96212, 'btc', '2025-02-11 17:17:13'),
(292, 96300, 'btc', '2025-02-11 17:19:14'),
(293, 96337, 'btc', '2025-02-11 17:21:15');
INSERT INTO `crypto_history` (`id`, `worth`, `name`, `date`) VALUES
(294, 96313, 'btc', '2025-02-11 17:23:17'),
(295, 96350, 'btc', '2025-02-11 17:25:17'),
(296, 96220, 'btc', '2025-02-11 17:27:18'),
(297, 96207, 'btc', '2025-02-11 17:29:18'),
(298, 96247, 'btc', '2025-02-11 17:31:19'),
(299, 96212, 'btc', '2025-02-11 17:33:20'),
(300, 96211, 'btc', '2025-02-11 17:35:20'),
(301, 96265, 'btc', '2025-02-11 17:37:20'),
(302, 96209, 'btc', '2025-02-11 17:39:21'),
(303, 96180, 'btc', '2025-02-11 17:41:21'),
(304, 96180, 'btc', '2025-02-11 17:43:22'),
(305, 96145, 'btc', '2025-02-11 17:45:23'),
(306, 96114, 'btc', '2025-02-11 17:47:23'),
(307, 96092, 'btc', '2025-02-11 17:49:23'),
(308, 96109, 'btc', '2025-02-11 17:51:24'),
(309, 96046, 'btc', '2025-02-11 17:53:24'),
(310, 96033, 'btc', '2025-02-11 17:55:25'),
(311, 96065, 'btc', '2025-02-11 17:57:25'),
(312, 96134, 'btc', '2025-02-11 17:59:27'),
(313, 96076, 'btc', '2025-02-11 18:01:27'),
(314, 96008, 'btc', '2025-02-11 18:03:28'),
(315, 95980, 'btc', '2025-02-11 18:05:29'),
(316, 95917, 'btc', '2025-02-11 18:07:29'),
(317, 95861, 'btc', '2025-02-11 18:09:30'),
(318, 95866, 'btc', '2025-02-11 18:11:30'),
(319, 95912, 'btc', '2025-02-11 18:13:31'),
(320, 95840, 'btc', '2025-02-11 18:15:31'),
(321, 95826, 'btc', '2025-02-11 18:17:31'),
(322, 95816, 'btc', '2025-02-11 18:19:31'),
(323, 95770, 'btc', '2025-02-11 18:21:31'),
(324, 95710, 'btc', '2025-02-11 18:23:32'),
(325, 95644, 'btc', '2025-02-11 18:25:32'),
(326, 95632, 'btc', '2025-02-11 18:27:32'),
(327, 95673, 'btc', '2025-02-11 18:29:32'),
(328, 95705, 'btc', '2025-02-11 18:31:33'),
(329, 95763, 'btc', '2025-02-11 18:33:33'),
(330, 95787, 'btc', '2025-02-11 18:35:34'),
(331, 95921, 'btc', '2025-02-11 18:37:35'),
(332, 96022, 'btc', '2025-02-11 18:39:35'),
(333, 95877, 'btc', '2025-02-11 18:41:36'),
(334, 95733, 'btc', '2025-02-11 18:43:36'),
(335, 95696, 'btc', '2025-02-11 18:45:36'),
(336, 95600, 'btc', '2025-02-11 18:47:36'),
(337, 95498, 'btc', '2025-02-11 18:49:37'),
(338, 95416, 'btc', '2025-02-11 18:51:37'),
(339, 95565, 'btc', '2025-02-11 18:53:38'),
(340, 95432, 'btc', '2025-02-11 18:55:38'),
(341, 95513, 'btc', '2025-02-11 18:57:38'),
(342, 95420, 'btc', '2025-02-11 18:59:39'),
(343, 95555, 'btc', '2025-02-11 19:01:40'),
(344, 95496, 'btc', '2025-02-11 19:03:40'),
(345, 95538, 'btc', '2025-02-11 19:05:40'),
(346, 95632, 'btc', '2025-02-11 19:07:43'),
(347, 95571, 'btc', '2025-02-11 19:09:44'),
(348, 95407, 'btc', '2025-02-11 19:11:44'),
(349, 95405, 'btc', '2025-02-11 19:13:45'),
(350, 95397, 'btc', '2025-02-11 19:15:45'),
(351, 95166, 'btc', '2025-02-11 19:17:45'),
(352, 95225, 'btc', '2025-02-11 19:19:45'),
(353, 95114, 'btc', '2025-02-11 19:21:46'),
(354, 95164, 'btc', '2025-02-11 19:23:46'),
(355, 95042, 'btc', '2025-02-11 19:25:47'),
(356, 95079, 'btc', '2025-02-11 19:27:47'),
(357, 95071, 'btc', '2025-02-11 19:29:48'),
(358, 95153, 'btc', '2025-02-11 19:31:48'),
(359, 95064, 'btc', '2025-02-11 19:33:48'),
(360, 94921, 'btc', '2025-02-11 19:35:48'),
(361, 94920, 'btc', '2025-02-11 19:37:49'),
(362, 94920, 'btc', '2025-02-11 19:39:51'),
(363, 94883, 'btc', '2025-02-11 19:41:51'),
(364, 94998, 'btc', '2025-02-11 19:43:51'),
(365, 95068, 'btc', '2025-02-11 19:45:51'),
(366, 94938, 'btc', '2025-02-11 19:47:52'),
(367, 95063, 'btc', '2025-02-11 19:49:52'),
(368, 95156, 'btc', '2025-02-11 19:51:52'),
(369, 95177, 'btc', '2025-02-11 19:53:52'),
(370, 95056, 'btc', '2025-02-11 19:55:53'),
(371, 95082, 'btc', '2025-02-11 19:57:53'),
(372, 95045, 'btc', '2025-02-11 19:59:53'),
(373, 95104, 'btc', '2025-02-11 20:01:53'),
(374, 95104, 'btc', '2025-02-11 20:03:54'),
(375, 95130, 'btc', '2025-02-11 20:05:55'),
(376, 95214, 'btc', '2025-02-11 20:07:55'),
(377, 95257, 'btc', '2025-02-11 20:09:55'),
(378, 95203, 'btc', '2025-02-11 20:11:55'),
(379, 95141, 'btc', '2025-02-11 20:13:56'),
(380, 95071, 'btc', '2025-02-11 20:15:56'),
(381, 95101, 'btc', '2025-02-11 20:17:56'),
(382, 95083, 'btc', '2025-02-11 20:19:57'),
(383, 95117, 'btc', '2025-02-11 20:21:57'),
(384, 95175, 'btc', '2025-02-11 20:23:57'),
(385, 95080, 'btc', '2025-02-11 20:25:57'),
(386, 95130, 'btc', '2025-02-11 20:28:04'),
(387, 95273, 'btc', '2025-02-11 20:30:05'),
(388, 95346, 'btc', '2025-02-11 20:32:05'),
(389, 95399, 'btc', '2025-02-11 20:34:05'),
(390, 95336, 'btc', '2025-02-11 20:36:06'),
(391, 95257, 'btc', '2025-02-11 20:38:06'),
(392, 95205, 'btc', '2025-02-11 20:40:06'),
(393, 95143, 'btc', '2025-02-11 20:42:06'),
(394, 95081, 'btc', '2025-02-11 20:44:07'),
(395, 95051, 'btc', '2025-02-11 20:46:07'),
(396, 94988, 'btc', '2025-02-11 20:48:07'),
(397, 95094, 'btc', '2025-02-11 20:50:08'),
(398, 95145, 'btc', '2025-02-11 20:52:08'),
(399, 95099, 'btc', '2025-02-11 20:54:08'),
(400, 95198, 'btc', '2025-02-11 20:56:08'),
(401, 95256, 'btc', '2025-02-11 20:58:09'),
(402, 95271, 'btc', '2025-02-11 21:00:11'),
(403, 95452, 'btc', '2025-02-11 21:02:12'),
(404, 95387, 'btc', '2025-02-11 21:04:12'),
(405, 95318, 'btc', '2025-02-11 21:06:12'),
(406, 95315, 'btc', '2025-02-11 21:08:13'),
(407, 95315, 'btc', '2025-02-11 21:10:13'),
(408, 95422, 'btc', '2025-02-11 21:12:13'),
(409, 95488, 'btc', '2025-02-11 21:14:13'),
(410, 95433, 'btc', '2025-02-11 21:16:14'),
(411, 95472, 'btc', '2025-02-11 21:18:14'),
(412, 95610, 'btc', '2025-02-11 21:20:15'),
(413, 96233, 'btc', '2025-02-11 22:17:40'),
(414, 96275, 'btc', '2025-02-11 22:19:41'),
(415, 96300, 'btc', '2025-02-11 22:21:41'),
(416, 96315, 'btc', '2025-02-11 22:23:41'),
(417, 96401, 'btc', '2025-02-11 22:25:41'),
(418, 96274, 'btc', '2025-02-11 22:27:41'),
(419, 96243, 'btc', '2025-02-11 22:29:42'),
(420, 96172, 'btc', '2025-02-11 22:31:42'),
(421, 96169, 'btc', '2025-02-11 22:33:42'),
(422, 95763, 'btc', '2025-02-11 22:35:42'),
(423, 96034, 'btc', '2025-02-11 22:37:43'),
(424, 96033, 'btc', '2025-02-11 22:39:43'),
(425, 96013, 'btc', '2025-02-11 22:41:43'),
(426, 95921, 'btc', '2025-02-11 22:43:43'),
(427, 95848, 'btc', '2025-02-11 22:45:44'),
(428, 96007, 'btc', '2025-02-11 22:47:44'),
(429, 95975, 'btc', '2025-02-11 22:49:44'),
(430, 95975, 'btc', '2025-02-11 22:51:44'),
(431, 95914, 'btc', '2025-02-11 22:53:45'),
(432, 95721, 'btc', '2025-02-11 22:55:46'),
(433, 95659, 'btc', '2025-02-11 22:57:46'),
(434, 95481, 'btc', '2025-02-11 22:59:47'),
(435, 95722, 'btc', '2025-02-11 23:01:47'),
(436, 95633, 'btc', '2025-02-11 23:03:47'),
(437, 95567, 'btc', '2025-02-11 23:05:47'),
(438, 95625, 'btc', '2025-02-11 23:07:48'),
(439, 95707, 'btc', '2025-02-11 23:09:48'),
(440, 95692, 'btc', '2025-02-11 23:11:48'),
(441, 95781, 'btc', '2025-02-11 23:13:48'),
(442, 95752, 'btc', '2025-02-11 23:15:49'),
(443, 95778, 'btc', '2025-02-11 23:17:53'),
(444, 95778, 'btc', '2025-02-11 23:19:53'),
(445, 95824, 'btc', '2025-02-11 23:21:54'),
(446, 95919, 'btc', '2025-02-11 23:23:54'),
(447, 95904, 'btc', '2025-02-11 23:25:55'),
(448, 95917, 'btc', '2025-02-11 23:27:55'),
(449, 95933, 'btc', '2025-02-11 23:29:55'),
(450, 95920, 'btc', '2025-02-11 23:31:56'),
(451, 95868, 'btc', '2025-02-11 23:33:56'),
(452, 95928, 'btc', '2025-02-11 23:35:56'),
(453, 95920, 'btc', '2025-02-11 23:37:56'),
(454, 95849, 'btc', '2025-02-11 23:39:57'),
(455, 95911, 'btc', '2025-02-11 23:41:58'),
(456, 95752, 'btc', '2025-02-11 23:43:58'),
(457, 95774, 'btc', '2025-02-11 23:45:58'),
(458, 95812, 'btc', '2025-02-11 23:47:58'),
(459, 95802, 'btc', '2025-02-11 23:49:58'),
(460, 95823, 'btc', '2025-02-11 23:51:59'),
(461, 95798, 'btc', '2025-02-11 23:53:59'),
(462, 95763, 'btc', '2025-02-11 23:55:59'),
(463, 95754, 'btc', '2025-02-11 23:57:59'),
(464, 95780, 'btc', '2025-02-12 00:00:00'),
(465, 95738, 'btc', '2025-02-12 00:02:02'),
(466, 95868, 'btc', '2025-02-12 00:04:05'),
(467, 95959, 'btc', '2025-02-12 00:06:05'),
(468, 95957, 'btc', '2025-02-12 00:08:05'),
(469, 95916, 'btc', '2025-02-12 00:10:05'),
(470, 95918, 'btc', '2025-02-12 00:12:06'),
(471, 95950, 'btc', '2025-02-12 00:14:09'),
(472, 95942, 'btc', '2025-02-12 00:16:10'),
(473, 95883, 'btc', '2025-02-12 00:18:10'),
(474, 95829, 'btc', '2025-02-12 00:20:10'),
(475, 95683, 'btc', '2025-02-12 00:22:10'),
(476, 95794, 'btc', '2025-02-12 00:24:11'),
(477, 95863, 'btc', '2025-02-12 00:26:15'),
(478, 95885, 'btc', '2025-02-12 00:28:15'),
(479, 95899, 'btc', '2025-02-12 00:30:15'),
(480, 95917, 'btc', '2025-02-12 00:32:20'),
(481, 95972, 'btc', '2025-02-12 00:34:20'),
(482, 95943, 'btc', '2025-02-12 00:36:21'),
(483, 95934, 'btc', '2025-02-12 00:38:22'),
(484, 95767, 'btc', '2025-02-12 00:40:22'),
(485, 95884, 'btc', '2025-02-12 00:42:22'),
(486, 95892, 'btc', '2025-02-12 00:44:23'),
(487, 95366, 'btc', '2025-02-12 14:40:26'),
(488, 95587, 'btc', '2025-02-12 14:42:26'),
(489, 95586, 'btc', '2025-02-12 14:44:27'),
(490, 95465, 'btc', '2025-02-12 14:46:27'),
(491, 95487, 'btc', '2025-02-12 14:48:32'),
(492, 95317, 'btc', '2025-02-12 14:50:32'),
(493, 95480, 'btc', '2025-02-12 14:52:32'),
(494, 95383, 'btc', '2025-02-12 14:54:36'),
(495, 95512, 'btc', '2025-02-12 14:56:36'),
(496, 95637, 'btc', '2025-02-12 14:58:37'),
(497, 95565, 'btc', '2025-02-12 15:00:37'),
(498, 95334, 'btc', '2025-02-12 15:02:38'),
(499, 95124, 'btc', '2025-02-12 15:04:38'),
(500, 94992, 'btc', '2025-02-12 15:06:38'),
(501, 95065, 'btc', '2025-02-12 15:08:38'),
(502, 94956, 'btc', '2025-02-12 15:10:40'),
(503, 94804, 'btc', '2025-02-12 15:12:46'),
(504, 94959, 'btc', '2025-02-12 15:14:47'),
(505, 95073, 'btc', '2025-02-12 15:16:48'),
(506, 95224, 'btc', '2025-02-12 15:18:48'),
(507, 95354, 'btc', '2025-02-12 15:20:48'),
(508, 95557, 'btc', '2025-02-12 15:22:48'),
(509, 95806, 'btc', '2025-02-12 15:24:49'),
(510, 95751, 'btc', '2025-02-12 15:26:49'),
(511, 95718, 'btc', '2025-02-12 15:28:49'),
(512, 95676, 'btc', '2025-02-12 15:30:49'),
(513, 95796, 'btc', '2025-02-12 15:32:50'),
(514, 95738, 'btc', '2025-02-12 15:34:51'),
(515, 95718, 'btc', '2025-02-12 15:36:52'),
(516, 95782, 'btc', '2025-02-12 15:38:52'),
(517, 95746, 'btc', '2025-02-12 15:40:52'),
(518, 95660, 'btc', '2025-02-12 15:42:52'),
(519, 95622, 'btc', '2025-02-12 15:44:53'),
(520, 95521, 'btc', '2025-02-12 15:46:53'),
(521, 95646, 'btc', '2025-02-12 15:48:53'),
(522, 95712, 'btc', '2025-02-12 15:50:58'),
(523, 95745, 'btc', '2025-02-12 15:52:58'),
(524, 95849, 'btc', '2025-02-12 15:54:59'),
(525, 95772, 'btc', '2025-02-12 15:57:00'),
(526, 95782, 'btc', '2025-02-12 15:59:02'),
(527, 95699, 'btc', '2025-02-12 16:01:02'),
(528, 95806, 'btc', '2025-02-12 16:03:02'),
(529, 95801, 'btc', '2025-02-12 16:05:03'),
(530, 95730, 'btc', '2025-02-12 16:07:03'),
(531, 95486, 'btc', '2025-02-12 16:09:03'),
(532, 95418, 'btc', '2025-02-12 16:11:03'),
(533, 95295, 'btc', '2025-02-12 16:13:05'),
(534, 95373, 'btc', '2025-02-12 16:15:06'),
(535, 95530, 'btc', '2025-02-12 16:17:06'),
(536, 95500, 'btc', '2025-02-12 16:19:06'),
(537, 95574, 'btc', '2025-02-12 16:21:06'),
(538, 95546, 'btc', '2025-02-12 16:23:07'),
(539, 95502, 'btc', '2025-02-12 16:25:07'),
(540, 95207, 'btc', '2025-02-12 16:27:09'),
(541, 95280, 'btc', '2025-02-12 16:29:09'),
(542, 95526, 'btc', '2025-02-12 16:31:10'),
(543, 95586, 'btc', '2025-02-12 16:33:10'),
(544, 95512, 'btc', '2025-02-12 16:35:10'),
(545, 95726, 'btc', '2025-02-12 16:37:10'),
(546, 95717, 'btc', '2025-02-12 16:39:13'),
(547, 95748, 'btc', '2025-02-12 16:41:13'),
(548, 95861, 'btc', '2025-02-12 16:43:14'),
(549, 95964, 'btc', '2025-02-12 16:45:14'),
(550, 95840, 'btc', '2025-02-12 16:47:14'),
(551, 95968, 'btc', '2025-02-12 16:49:15'),
(552, 96099, 'btc', '2025-02-12 16:51:15'),
(553, 96188, 'btc', '2025-02-12 16:53:15'),
(554, 96581, 'btc', '2025-02-12 16:55:15'),
(555, 97028, 'btc', '2025-02-12 16:57:16'),
(556, 97016, 'btc', '2025-02-12 16:59:16'),
(557, 97179, 'btc', '2025-02-12 17:01:18'),
(558, 97089, 'btc', '2025-02-12 17:03:19'),
(559, 97123, 'btc', '2025-02-12 17:05:20'),
(560, 97001, 'btc', '2025-02-12 17:07:21'),
(561, 96828, 'btc', '2025-02-12 17:09:21'),
(562, 97024, 'btc', '2025-02-12 17:11:21'),
(563, 97018, 'btc', '2025-02-12 17:13:21'),
(564, 97102, 'btc', '2025-02-12 17:15:22'),
(565, 96897, 'btc', '2025-02-12 17:17:22'),
(566, 97006, 'btc', '2025-02-12 17:19:25'),
(567, 96990, 'btc', '2025-02-12 17:21:25'),
(568, 97098, 'btc', '2025-02-12 17:23:25'),
(569, 97145, 'btc', '2025-02-12 17:25:26'),
(570, 97209, 'btc', '2025-02-12 17:27:26'),
(571, 97499, 'btc', '2025-02-12 17:29:27'),
(572, 97662, 'btc', '2025-02-12 17:31:28'),
(573, 97546, 'btc', '2025-02-12 17:33:28'),
(574, 97410, 'btc', '2025-02-12 17:35:29'),
(575, 97415, 'btc', '2025-02-12 17:37:29'),
(576, 97263, 'btc', '2025-02-12 17:39:29'),
(577, 97324, 'btc', '2025-02-12 17:41:30'),
(578, 97280, 'btc', '2025-02-12 17:43:30'),
(579, 97244, 'btc', '2025-02-12 17:45:30'),
(580, 97444, 'btc', '2025-02-12 17:47:30'),
(581, 97507, 'btc', '2025-02-12 17:49:30'),
(582, 97464, 'btc', '2025-02-12 17:51:34'),
(583, 97332, 'btc', '2025-02-12 17:53:36'),
(584, 97350, 'btc', '2025-02-12 17:55:36'),
(585, 97265, 'btc', '2025-02-12 17:57:36'),
(586, 97395, 'btc', '2025-02-12 17:59:36'),
(587, 97299, 'btc', '2025-02-12 18:01:37'),
(588, 97105, 'btc', '2025-02-12 18:03:37'),
(589, 97126, 'btc', '2025-02-12 18:05:37'),
(590, 96888, 'btc', '2025-02-12 18:07:39'),
(591, 96961, 'btc', '2025-02-12 18:09:39'),
(592, 97025, 'btc', '2025-02-12 18:11:39'),
(593, 97015, 'btc', '2025-02-12 18:13:39'),
(594, 97065, 'btc', '2025-02-12 18:15:40'),
(595, 97018, 'btc', '2025-02-12 18:17:40'),
(596, 96980, 'btc', '2025-02-12 18:19:40'),
(597, 96897, 'btc', '2025-02-12 18:21:40'),
(598, 96882, 'btc', '2025-02-12 18:23:41'),
(599, 96894, 'btc', '2025-02-12 18:25:42'),
(600, 96825, 'btc', '2025-02-12 18:27:42'),
(601, 96840, 'btc', '2025-02-12 18:29:42'),
(602, 96698, 'btc', '2025-02-12 18:31:44'),
(603, 96690, 'btc', '2025-02-12 18:33:44'),
(604, 96717, 'btc', '2025-02-12 18:35:45'),
(605, 96853, 'btc', '2025-02-12 18:37:45'),
(606, 96937, 'btc', '2025-02-12 18:39:45'),
(607, 96919, 'btc', '2025-02-12 18:41:45'),
(608, 96777, 'btc', '2025-02-12 18:43:46'),
(609, 96821, 'btc', '2025-02-12 18:45:46'),
(610, 96872, 'btc', '2025-02-12 18:47:46'),
(611, 96920, 'btc', '2025-02-12 18:49:46'),
(612, 96979, 'btc', '2025-02-12 18:51:48'),
(613, 97053, 'btc', '2025-02-12 18:53:48'),
(614, 97011, 'btc', '2025-02-12 18:55:48'),
(615, 97017, 'btc', '2025-02-12 18:57:49'),
(616, 96954, 'btc', '2025-02-12 18:59:49'),
(617, 96931, 'btc', '2025-02-12 19:01:49'),
(618, 96884, 'btc', '2025-02-12 19:03:53');
INSERT INTO `crypto_history` (`id`, `worth`, `name`, `date`) VALUES
(619, 96691, 'btc', '2025-02-12 19:05:53'),
(620, 96724, 'btc', '2025-02-12 19:08:00'),
(621, 96618, 'btc', '2025-02-12 19:10:00'),
(622, 96519, 'btc', '2025-02-12 19:12:00'),
(623, 96460, 'btc', '2025-02-12 19:14:00'),
(624, 96575, 'btc', '2025-02-12 19:16:01'),
(625, 96614, 'btc', '2025-02-12 19:18:01'),
(626, 96615, 'btc', '2025-02-12 19:20:01'),
(627, 96738, 'btc', '2025-02-12 19:22:02'),
(628, 96799, 'btc', '2025-02-12 19:24:03'),
(629, 96682, 'btc', '2025-02-12 19:26:03'),
(630, 96782, 'btc', '2025-02-12 19:28:03'),
(631, 96762, 'btc', '2025-02-12 19:30:03'),
(632, 96800, 'btc', '2025-02-12 19:32:03'),
(633, 96803, 'btc', '2025-02-12 19:34:09'),
(634, 96899, 'btc', '2025-02-12 19:36:10'),
(635, 96881, 'btc', '2025-02-12 19:38:10'),
(636, 96922, 'btc', '2025-02-12 19:40:11'),
(637, 96851, 'btc', '2025-02-12 19:42:11'),
(638, 96866, 'btc', '2025-02-12 19:44:11'),
(639, 97000, 'btc', '2025-02-12 19:46:13'),
(640, 97106, 'btc', '2025-02-12 19:48:13'),
(641, 97226, 'btc', '2025-02-12 19:50:13'),
(642, 97138, 'btc', '2025-02-12 19:52:13'),
(643, 97172, 'btc', '2025-02-12 19:54:14'),
(644, 97212, 'btc', '2025-02-12 19:56:14'),
(645, 97275, 'btc', '2025-02-12 19:58:14'),
(646, 97231, 'btc', '2025-02-12 20:00:16'),
(647, 97070, 'btc', '2025-02-12 20:02:16'),
(648, 97010, 'btc', '2025-02-12 20:04:17'),
(649, 97048, 'btc', '2025-02-12 20:06:17'),
(650, 97104, 'btc', '2025-02-12 20:08:17'),
(651, 97124, 'btc', '2025-02-12 20:10:18'),
(652, 97320, 'btc', '2025-02-12 20:12:18'),
(653, 97450, 'btc', '2025-02-12 20:14:18'),
(654, 97314, 'btc', '2025-02-12 20:16:18'),
(655, 97443, 'btc', '2025-02-12 20:18:19'),
(656, 97500, 'btc', '2025-02-12 20:20:20'),
(657, 97482, 'btc', '2025-02-12 20:22:20'),
(658, 97521, 'btc', '2025-02-12 20:24:20'),
(659, 97584, 'btc', '2025-02-12 20:26:21'),
(660, 97623, 'btc', '2025-02-12 20:28:21'),
(661, 97403, 'btc', '2025-02-12 20:30:21'),
(662, 97306, 'btc', '2025-02-12 20:32:22'),
(663, 97306, 'btc', '2025-02-12 20:34:22'),
(664, 97249, 'btc', '2025-02-12 20:36:22'),
(665, 97160, 'btc', '2025-02-12 20:38:22'),
(666, 97194, 'btc', '2025-02-12 20:40:25'),
(667, 97121, 'btc', '2025-02-12 20:42:25'),
(668, 97091, 'btc', '2025-02-12 20:44:27'),
(669, 97122, 'btc', '2025-02-12 20:46:27'),
(670, 97094, 'btc', '2025-02-12 20:48:27'),
(671, 97080, 'btc', '2025-02-12 20:50:29'),
(672, 97071, 'btc', '2025-02-12 20:52:30'),
(673, 97045, 'btc', '2025-02-12 20:54:30'),
(674, 97026, 'btc', '2025-02-12 20:56:31'),
(675, 97020, 'btc', '2025-02-12 20:58:31'),
(676, 97037, 'btc', '2025-02-12 21:00:31'),
(677, 96905, 'btc', '2025-02-12 21:02:31'),
(678, 96886, 'btc', '2025-02-12 21:04:32'),
(679, 96957, 'btc', '2025-02-12 21:06:33'),
(680, 97024, 'btc', '2025-02-12 21:08:33'),
(681, 97121, 'btc', '2025-02-12 21:10:34'),
(682, 97307, 'btc', '2025-02-12 21:12:34'),
(683, 95611, 'btc', '2025-02-13 15:08:07'),
(684, 95675, 'btc', '2025-02-13 15:10:07'),
(685, 95604, 'btc', '2025-02-13 15:12:08'),
(686, 95829, 'btc', '2025-02-13 15:14:08'),
(687, 96023, 'btc', '2025-02-13 15:16:08'),
(688, 96295, 'btc', '2025-02-13 15:18:09'),
(689, 96204, 'btc', '2025-02-13 15:20:09'),
(690, 96377, 'btc', '2025-02-13 15:22:10'),
(691, 96352, 'btc', '2025-02-13 15:24:10'),
(692, 96168, 'btc', '2025-02-13 15:26:10'),
(693, 96003, 'btc', '2025-02-13 15:28:10'),
(694, 95970, 'btc', '2025-02-13 15:30:11'),
(695, 95997, 'btc', '2025-02-13 15:32:12'),
(696, 96010, 'btc', '2025-02-13 15:34:20'),
(697, 95979, 'btc', '2025-02-13 15:36:21'),
(698, 96007, 'btc', '2025-02-13 15:38:22'),
(699, 96208, 'btc', '2025-02-13 15:40:22'),
(700, 96194, 'btc', '2025-02-13 15:42:23'),
(701, 96302, 'btc', '2025-02-13 15:44:23'),
(702, 96382, 'btc', '2025-02-13 15:46:23'),
(703, 96254, 'btc', '2025-02-13 15:48:26'),
(704, 96378, 'btc', '2025-02-13 15:50:26'),
(705, 96221, 'btc', '2025-02-13 15:52:27'),
(706, 95935, 'btc', '2025-02-13 15:54:27'),
(707, 95835, 'btc', '2025-02-13 15:56:27'),
(708, 95939, 'btc', '2025-02-13 15:58:28'),
(709, 95967, 'btc', '2025-02-13 16:00:28'),
(710, 95886, 'btc', '2025-02-13 16:02:30'),
(711, 95766, 'btc', '2025-02-13 16:04:31'),
(712, 95814, 'btc', '2025-02-13 16:06:36'),
(713, 95739, 'btc', '2025-02-13 16:08:36'),
(714, 95729, 'btc', '2025-02-13 16:10:37'),
(715, 95885, 'btc', '2025-02-13 16:12:37'),
(716, 95813, 'btc', '2025-02-13 16:14:37'),
(717, 95721, 'btc', '2025-02-13 16:16:38'),
(718, 95694, 'btc', '2025-02-13 16:18:38'),
(719, 95727, 'btc', '2025-02-13 16:20:38'),
(720, 95591, 'btc', '2025-02-13 16:22:39'),
(721, 95591, 'btc', '2025-02-13 16:24:40'),
(722, 95453, 'btc', '2025-02-13 16:26:40'),
(723, 95467, 'btc', '2025-02-13 16:28:40'),
(724, 95373, 'btc', '2025-02-13 16:30:41'),
(725, 95392, 'btc', '2025-02-13 16:32:41'),
(726, 95565, 'btc', '2025-02-13 16:34:42'),
(727, 95545, 'btc', '2025-02-13 16:36:42'),
(728, 95459, 'btc', '2025-02-13 16:38:42'),
(729, 95433, 'btc', '2025-02-13 16:40:42'),
(730, 95459, 'btc', '2025-02-13 16:42:43'),
(731, 95462, 'btc', '2025-02-13 16:44:43'),
(732, 95549, 'btc', '2025-02-13 16:46:43'),
(733, 95483, 'btc', '2025-02-13 16:48:44'),
(734, 95574, 'btc', '2025-02-13 16:50:44'),
(735, 95505, 'btc', '2025-02-13 16:52:44'),
(736, 95468, 'btc', '2025-02-13 16:54:45'),
(737, 95325, 'btc', '2025-02-13 16:56:45'),
(738, 95281, 'btc', '2025-02-13 16:58:45'),
(739, 95407, 'btc', '2025-02-13 17:00:45'),
(740, 95479, 'btc', '2025-02-13 17:02:46'),
(741, 95562, 'btc', '2025-02-13 17:04:46'),
(742, 95592, 'btc', '2025-02-13 17:06:49'),
(743, 95615, 'btc', '2025-02-13 17:08:49'),
(744, 95685, 'btc', '2025-02-13 17:10:50'),
(745, 95687, 'btc', '2025-02-13 17:12:51'),
(746, 95705, 'btc', '2025-02-13 17:14:53'),
(747, 95698, 'btc', '2025-02-13 17:16:54'),
(748, 95631, 'btc', '2025-02-13 17:18:57'),
(749, 95541, 'btc', '2025-02-13 17:20:57'),
(750, 95548, 'btc', '2025-02-13 17:22:59'),
(751, 95604, 'btc', '2025-02-13 17:25:01'),
(752, 95748, 'btc', '2025-02-13 17:27:02'),
(753, 95806, 'btc', '2025-02-13 17:29:03'),
(754, 95745, 'btc', '2025-02-13 17:31:03'),
(755, 95745, 'btc', '2025-02-13 17:33:03'),
(756, 95834, 'btc', '2025-02-13 17:35:05'),
(757, 95863, 'btc', '2025-02-13 17:37:07'),
(758, 95849, 'btc', '2025-02-13 17:39:08'),
(759, 95871, 'btc', '2025-02-13 17:41:08'),
(760, 95886, 'btc', '2025-02-13 17:43:08'),
(761, 95928, 'btc', '2025-02-13 17:45:12'),
(762, 96003, 'btc', '2025-02-13 17:47:12'),
(763, 95958, 'btc', '2025-02-13 17:49:13'),
(764, 95959, 'btc', '2025-02-13 17:51:13'),
(765, 95896, 'btc', '2025-02-13 17:53:13'),
(766, 95864, 'btc', '2025-02-13 17:55:13'),
(767, 95825, 'btc', '2025-02-13 17:57:14'),
(768, 95718, 'btc', '2025-02-13 17:59:14'),
(769, 95721, 'btc', '2025-02-13 18:01:15'),
(770, 95707, 'btc', '2025-02-13 18:03:24'),
(771, 95603, 'btc', '2025-02-13 18:05:27'),
(772, 95527, 'btc', '2025-02-13 18:07:27'),
(773, 95574, 'btc', '2025-02-13 18:09:27'),
(774, 95580, 'btc', '2025-02-13 18:11:27'),
(775, 95573, 'btc', '2025-02-13 18:13:28'),
(776, 95580, 'btc', '2025-02-13 18:15:28'),
(777, 95600, 'btc', '2025-02-13 18:17:28'),
(778, 95386, 'btc', '2025-02-13 18:19:28'),
(779, 95592, 'btc', '2025-02-13 18:21:29'),
(780, 95553, 'btc', '2025-02-13 18:23:33'),
(781, 95697, 'btc', '2025-02-13 18:25:34'),
(782, 95716, 'btc', '2025-02-13 18:27:35'),
(783, 95712, 'btc', '2025-02-13 18:29:35'),
(784, 95664, 'btc', '2025-02-13 18:31:35'),
(785, 95747, 'btc', '2025-02-13 18:33:36'),
(786, 95767, 'btc', '2025-02-13 18:35:36'),
(787, 95782, 'btc', '2025-02-13 18:37:36'),
(788, 95833, 'btc', '2025-02-13 18:39:36'),
(789, 95640, 'btc', '2025-02-13 18:41:37'),
(790, 95541, 'btc', '2025-02-13 18:43:37'),
(791, 95690, 'btc', '2025-02-13 18:45:37'),
(792, 95811, 'btc', '2025-02-13 18:47:37'),
(793, 95871, 'btc', '2025-02-13 18:49:37'),
(794, 95790, 'btc', '2025-02-13 18:51:37'),
(795, 95778, 'btc', '2025-02-13 18:53:38'),
(796, 95804, 'btc', '2025-02-13 18:55:38'),
(797, 95939, 'btc', '2025-02-13 18:57:45'),
(798, 95989, 'btc', '2025-02-13 18:59:45'),
(799, 95974, 'btc', '2025-02-13 19:01:46'),
(800, 96074, 'btc', '2025-02-13 19:03:46'),
(801, 96244, 'btc', '2025-02-13 19:05:46'),
(802, 96215, 'btc', '2025-02-13 19:07:46'),
(803, 96332, 'btc', '2025-02-13 19:09:48'),
(804, 96361, 'btc', '2025-02-13 19:11:48'),
(805, 96332, 'btc', '2025-02-13 19:13:49'),
(806, 96345, 'btc', '2025-02-13 19:15:49'),
(807, 96284, 'btc', '2025-02-13 19:17:49'),
(808, 96212, 'btc', '2025-02-13 19:19:50'),
(809, 96119, 'btc', '2025-02-13 19:21:50'),
(810, 96078, 'btc', '2025-02-13 19:23:50'),
(811, 96101, 'btc', '2025-02-13 19:25:50'),
(812, 95947, 'btc', '2025-02-13 19:27:50'),
(813, 95890, 'btc', '2025-02-13 19:29:51'),
(814, 95803, 'btc', '2025-02-13 19:31:52'),
(815, 95724, 'btc', '2025-02-13 19:33:52'),
(816, 95758, 'btc', '2025-02-13 19:35:52'),
(817, 95761, 'btc', '2025-02-13 19:37:53'),
(818, 95689, 'btc', '2025-02-13 19:39:53'),
(819, 95655, 'btc', '2025-02-13 19:41:53'),
(820, 95650, 'btc', '2025-02-13 19:43:53'),
(821, 95724, 'btc', '2025-02-13 19:45:54'),
(822, 95645, 'btc', '2025-02-13 19:47:54'),
(823, 95673, 'btc', '2025-02-13 19:49:54'),
(824, 95611, 'btc', '2025-02-13 19:51:54'),
(825, 95604, 'btc', '2025-02-13 19:53:55'),
(826, 95673, 'btc', '2025-02-13 19:55:55'),
(827, 95694, 'btc', '2025-02-13 19:57:55'),
(828, 95633, 'btc', '2025-02-13 19:59:55'),
(829, 95744, 'btc', '2025-02-13 20:01:57'),
(830, 95723, 'btc', '2025-02-13 20:03:58'),
(831, 95902, 'btc', '2025-02-13 20:05:58'),
(832, 95859, 'btc', '2025-02-13 20:07:59'),
(833, 95893, 'btc', '2025-02-13 20:10:01'),
(834, 95903, 'btc', '2025-02-13 20:12:01'),
(835, 95941, 'btc', '2025-02-13 20:14:01'),
(836, 96037, 'btc', '2025-02-13 20:16:01'),
(837, 96131, 'btc', '2025-02-13 20:18:03'),
(838, 96219, 'btc', '2025-02-13 20:20:03'),
(839, 96079, 'btc', '2025-02-13 20:22:04'),
(840, 96087, 'btc', '2025-02-13 20:24:04'),
(841, 96154, 'btc', '2025-02-13 20:26:04'),
(842, 96129, 'btc', '2025-02-13 20:28:04'),
(843, 96160, 'btc', '2025-02-13 20:30:06'),
(844, 96201, 'btc', '2025-02-13 20:32:06'),
(845, 96234, 'btc', '2025-02-13 20:34:06'),
(846, 96143, 'btc', '2025-02-13 20:36:07'),
(847, 96055, 'btc', '2025-02-13 20:38:08'),
(848, 96155, 'btc', '2025-02-13 20:40:08'),
(849, 96169, 'btc', '2025-02-13 20:42:08'),
(850, 96164, 'btc', '2025-02-13 20:44:08'),
(851, 96201, 'btc', '2025-02-13 20:46:09'),
(852, 96285, 'btc', '2025-02-13 20:48:10'),
(853, 96214, 'btc', '2025-02-13 20:50:10'),
(854, 96194, 'btc', '2025-02-13 20:52:10'),
(855, 96164, 'btc', '2025-02-13 20:54:11'),
(856, 96196, 'btc', '2025-02-13 20:56:11'),
(857, 96222, 'btc', '2025-02-13 20:58:11'),
(858, 96293, 'btc', '2025-02-13 21:00:12'),
(859, 96354, 'btc', '2025-02-13 21:02:12'),
(860, 96365, 'btc', '2025-02-13 21:04:12'),
(861, 96372, 'btc', '2025-02-13 21:06:13'),
(862, 96439, 'btc', '2025-02-13 21:08:13'),
(863, 96521, 'btc', '2025-02-13 21:10:13'),
(864, 96466, 'btc', '2025-02-13 21:12:16'),
(865, 96509, 'btc', '2025-02-13 21:14:16'),
(866, 96387, 'btc', '2025-02-13 21:16:16'),
(867, 96379, 'btc', '2025-02-13 21:18:17'),
(868, 96757, 'btc', '2025-02-14 12:09:20'),
(869, 96761, 'btc', '2025-02-14 12:11:21'),
(870, 96763, 'btc', '2025-02-14 12:13:22'),
(871, 96711, 'btc', '2025-02-14 12:15:23'),
(872, 96685, 'btc', '2025-02-14 12:17:23'),
(873, 96653, 'btc', '2025-02-14 12:19:23'),
(874, 96729, 'btc', '2025-02-14 12:21:23'),
(875, 96756, 'btc', '2025-02-14 12:23:26'),
(876, 96758, 'btc', '2025-02-14 12:25:26'),
(877, 96729, 'btc', '2025-02-14 12:27:26'),
(878, 96749, 'btc', '2025-02-14 12:29:26'),
(879, 96771, 'btc', '2025-02-14 12:31:27');
INSERT INTO `crypto_history` (`id`, `worth`, `name`, `date`) VALUES
(880, 96793, 'btc', '2025-02-14 12:33:28'),
(881, 96775, 'btc', '2025-02-14 12:35:30'),
(882, 96744, 'btc', '2025-02-14 12:37:31'),
(883, 96674, 'btc', '2025-02-14 12:39:31'),
(884, 96694, 'btc', '2025-02-14 12:41:31'),
(885, 96642, 'btc', '2025-02-14 12:43:32'),
(886, 96607, 'btc', '2025-02-14 12:45:32'),
(887, 96650, 'btc', '2025-02-14 12:47:32'),
(888, 96615, 'btc', '2025-02-14 12:49:33'),
(889, 96633, 'btc', '2025-02-14 12:51:34'),
(890, 96674, 'btc', '2025-02-14 12:53:34'),
(891, 96649, 'btc', '2025-02-14 12:55:34'),
(892, 96654, 'btc', '2025-02-14 12:57:34'),
(893, 96669, 'btc', '2025-02-14 12:59:35'),
(894, 96665, 'btc', '2025-02-14 13:01:35'),
(895, 96640, 'btc', '2025-02-14 13:03:35'),
(896, 96674, 'btc', '2025-02-14 13:05:35'),
(897, 96663, 'btc', '2025-02-14 13:07:36'),
(898, 96593, 'btc', '2025-02-14 13:09:36'),
(899, 96593, 'btc', '2025-02-14 13:11:37'),
(900, 96612, 'btc', '2025-02-14 13:13:37'),
(901, 96618, 'btc', '2025-02-14 13:15:38'),
(902, 96579, 'btc', '2025-02-14 13:17:39'),
(903, 96589, 'btc', '2025-02-14 13:19:40'),
(904, 96600, 'btc', '2025-02-14 13:21:40'),
(905, 96583, 'btc', '2025-02-14 13:23:40'),
(906, 96511, 'btc', '2025-02-14 13:25:40'),
(907, 96483, 'btc', '2025-02-14 13:27:40'),
(908, 96520, 'btc', '2025-02-14 13:29:41'),
(909, 96671, 'btc', '2025-02-14 13:31:41'),
(910, 96939, 'btc', '2025-02-14 13:33:42'),
(911, 96876, 'btc', '2025-02-14 13:35:42'),
(912, 96862, 'btc', '2025-02-14 13:37:42'),
(913, 96872, 'btc', '2025-02-14 13:39:43'),
(914, 96811, 'btc', '2025-02-14 13:41:43'),
(915, 96817, 'btc', '2025-02-14 13:43:44'),
(916, 96751, 'btc', '2025-02-14 13:45:44'),
(917, 96847, 'btc', '2025-02-14 13:47:45'),
(918, 96872, 'btc', '2025-02-14 13:49:46'),
(919, 96887, 'btc', '2025-02-14 13:51:47'),
(920, 96852, 'btc', '2025-02-14 13:53:48'),
(921, 96854, 'btc', '2025-02-14 13:55:48'),
(922, 96849, 'btc', '2025-02-14 13:57:48'),
(923, 96823, 'btc', '2025-02-14 13:59:48'),
(924, 96829, 'btc', '2025-02-14 14:01:49'),
(925, 96856, 'btc', '2025-02-14 14:03:49'),
(926, 96897, 'btc', '2025-02-14 14:05:49'),
(927, 96905, 'btc', '2025-02-14 14:07:51'),
(928, 96798, 'btc', '2025-02-14 14:09:51'),
(929, 96798, 'btc', '2025-02-14 14:11:51'),
(930, 96790, 'btc', '2025-02-14 14:13:51'),
(931, 96785, 'btc', '2025-02-14 14:15:52'),
(932, 96795, 'btc', '2025-02-14 14:17:52'),
(933, 96817, 'btc', '2025-02-14 14:19:53'),
(934, 96710, 'btc', '2025-02-14 14:21:53'),
(935, 96704, 'btc', '2025-02-14 14:23:54'),
(936, 96685, 'btc', '2025-02-14 14:25:54'),
(937, 96657, 'btc', '2025-02-14 14:27:54'),
(938, 96633, 'btc', '2025-02-14 14:29:55'),
(939, 96639, 'btc', '2025-02-14 14:32:05'),
(940, 96800, 'btc', '2025-02-14 14:34:05'),
(941, 96973, 'btc', '2025-02-14 14:36:06'),
(942, 97049, 'btc', '2025-02-14 14:38:06'),
(943, 97208, 'btc', '2025-02-14 14:40:06'),
(944, 97061, 'btc', '2025-02-14 14:42:07'),
(945, 97214, 'btc', '2025-02-14 14:44:07'),
(946, 97263, 'btc', '2025-02-14 14:46:07'),
(947, 97413, 'btc', '2025-02-14 14:48:07'),
(948, 97417, 'btc', '2025-02-14 14:50:07'),
(949, 97435, 'btc', '2025-02-14 14:52:08'),
(950, 97578, 'btc', '2025-02-14 14:54:08'),
(951, 97429, 'btc', '2025-02-14 14:56:08'),
(952, 97312, 'btc', '2025-02-14 14:58:08'),
(953, 97346, 'btc', '2025-02-14 15:00:13'),
(954, 97158, 'btc', '2025-02-14 15:02:14'),
(955, 97172, 'btc', '2025-02-14 15:04:15'),
(956, 97079, 'btc', '2025-02-14 15:06:15'),
(957, 97140, 'btc', '2025-02-14 15:08:16'),
(958, 97013, 'btc', '2025-02-14 15:10:16'),
(959, 96921, 'btc', '2025-02-14 15:12:16'),
(960, 96687, 'btc', '2025-02-14 15:14:16'),
(961, 96411, 'btc', '2025-02-14 15:16:17'),
(962, 96497, 'btc', '2025-02-14 15:18:17'),
(963, 96378, 'btc', '2025-02-14 15:20:18'),
(964, 96369, 'btc', '2025-02-14 15:22:18'),
(965, 96593, 'btc', '2025-02-14 15:24:18'),
(966, 96581, 'btc', '2025-02-14 15:26:20'),
(967, 96526, 'btc', '2025-02-14 15:28:20'),
(968, 96456, 'btc', '2025-02-14 15:30:20'),
(969, 96498, 'btc', '2025-02-14 15:32:21'),
(970, 96554, 'btc', '2025-02-14 15:34:22'),
(971, 96588, 'btc', '2025-02-14 15:36:25'),
(972, 96693, 'btc', '2025-02-14 15:38:25'),
(973, 96765, 'btc', '2025-02-14 15:40:26'),
(974, 96701, 'btc', '2025-02-14 15:42:27'),
(975, 96765, 'btc', '2025-02-14 15:44:27'),
(976, 96784, 'btc', '2025-02-14 15:46:28'),
(977, 96651, 'btc', '2025-02-14 15:48:28'),
(978, 96702, 'btc', '2025-02-14 15:50:28'),
(979, 96795, 'btc', '2025-02-14 15:52:28'),
(980, 96992, 'btc', '2025-02-14 15:54:28'),
(981, 96987, 'btc', '2025-02-14 15:56:29'),
(982, 97001, 'btc', '2025-02-14 15:58:30'),
(983, 96916, 'btc', '2025-02-14 16:00:30'),
(984, 96923, 'btc', '2025-02-14 16:02:30'),
(985, 96930, 'btc', '2025-02-14 16:04:31'),
(986, 96896, 'btc', '2025-02-14 16:06:31'),
(987, 96933, 'btc', '2025-02-14 16:08:31'),
(988, 96849, 'btc', '2025-02-14 16:10:32'),
(989, 96772, 'btc', '2025-02-14 16:12:32'),
(990, 96812, 'btc', '2025-02-14 16:14:32'),
(991, 96701, 'btc', '2025-02-14 16:16:32'),
(992, 96666, 'btc', '2025-02-14 16:18:33'),
(993, 96631, 'btc', '2025-02-14 16:20:33'),
(994, 96638, 'btc', '2025-02-14 16:22:33'),
(995, 96692, 'btc', '2025-02-14 16:24:33'),
(996, 96756, 'btc', '2025-02-14 16:26:34'),
(997, 96852, 'btc', '2025-02-14 16:28:34'),
(998, 96819, 'btc', '2025-02-14 16:30:34'),
(999, 96816, 'btc', '2025-02-14 16:32:34'),
(1000, 96745, 'btc', '2025-02-14 16:34:35'),
(1001, 96684, 'btc', '2025-02-14 16:36:35'),
(1002, 96706, 'btc', '2025-02-14 16:38:36'),
(1003, 96770, 'btc', '2025-02-14 16:40:36'),
(1004, 96782, 'btc', '2025-02-14 16:42:06'),
(1005, 96760, 'btc', '2025-02-14 16:44:07'),
(1006, 96826, 'btc', '2025-02-14 16:46:07'),
(1007, 96687, 'btc', '2025-02-14 16:48:07'),
(1008, 96724, 'btc', '2025-02-14 16:50:07'),
(1009, 96764, 'btc', '2025-02-14 16:52:09'),
(1010, 96811, 'btc', '2025-02-14 16:54:09'),
(1011, 97179, 'btc', '2025-02-14 16:56:09'),
(1012, 97355, 'btc', '2025-02-14 16:58:10'),
(1013, 97669, 'btc', '2025-02-14 17:00:12'),
(1014, 97457, 'btc', '2025-02-14 17:02:12'),
(1015, 97606, 'btc', '2025-02-14 17:04:13'),
(1016, 97433, 'btc', '2025-02-14 17:06:14'),
(1017, 97506, 'btc', '2025-02-14 17:08:14'),
(1018, 97483, 'btc', '2025-02-14 17:10:15'),
(1019, 97347, 'btc', '2025-02-14 17:12:19'),
(1020, 97175, 'btc', '2025-02-14 17:14:19'),
(1021, 97282, 'btc', '2025-02-14 17:16:19'),
(1022, 97373, 'btc', '2025-02-14 17:18:25'),
(1023, 97367, 'btc', '2025-02-14 17:20:25'),
(1024, 97469, 'btc', '2025-02-14 17:22:26'),
(1025, 97531, 'btc', '2025-02-14 17:24:26'),
(1026, 97483, 'btc', '2025-02-14 17:26:27'),
(1027, 97512, 'btc', '2025-02-14 17:28:28'),
(1028, 97383, 'btc', '2025-02-14 17:30:28'),
(1029, 97508, 'btc', '2025-02-14 17:32:30'),
(1030, 97592, 'btc', '2025-02-14 17:34:31'),
(1031, 97691, 'btc', '2025-02-14 17:36:31'),
(1032, 97770, 'btc', '2025-02-14 17:38:36'),
(1033, 97875, 'btc', '2025-02-14 17:40:37'),
(1034, 97947, 'btc', '2025-02-14 17:42:40'),
(1035, 98010, 'btc', '2025-02-14 17:44:40'),
(1036, 98051, 'btc', '2025-02-14 17:45:52'),
(1037, 98258, 'btc', '2025-02-14 17:47:52'),
(1038, 98389, 'btc', '2025-02-14 17:49:52'),
(1039, 98604, 'btc', '2025-02-14 17:51:52'),
(1040, 98524, 'btc', '2025-02-14 17:53:52'),
(1041, 98711, 'btc', '2025-02-14 17:55:55'),
(1042, 98865, 'btc', '2025-02-14 17:57:56'),
(1043, 98565, 'btc', '2025-02-14 17:59:56'),
(1044, 98759, 'btc', '2025-02-14 18:01:36'),
(1045, 98695, 'btc', '2025-02-14 18:03:44'),
(1046, 98630, 'btc', '2025-02-14 18:05:46'),
(1047, 98503, 'btc', '2025-02-14 18:07:46'),
(1048, 98509, 'btc', '2025-02-14 18:09:46'),
(1049, 98679, 'btc', '2025-02-14 18:11:47'),
(1050, 98667, 'btc', '2025-02-14 18:13:47'),
(1051, 98569, 'btc', '2025-02-14 18:15:48'),
(1052, 98487, 'btc', '2025-02-14 18:17:48'),
(1053, 98231, 'btc', '2025-02-14 18:19:49'),
(1054, 98373, 'btc', '2025-02-14 18:21:49'),
(1055, 98361, 'btc', '2025-02-14 18:23:50'),
(1056, 98415, 'btc', '2025-02-14 18:25:50'),
(1057, 98275, 'btc', '2025-02-14 18:27:51'),
(1058, 98355, 'btc', '2025-02-14 18:29:53'),
(1059, 98409, 'btc', '2025-02-14 18:31:53'),
(1060, 98445, 'btc', '2025-02-14 18:33:53'),
(1061, 98471, 'btc', '2025-02-14 18:35:53'),
(1062, 98493, 'btc', '2025-02-14 18:37:56'),
(1063, 98293, 'btc', '2025-02-14 18:39:56'),
(1064, 98306, 'btc', '2025-02-14 18:41:56'),
(1065, 98361, 'btc', '2025-02-14 18:43:57'),
(1066, 98365, 'btc', '2025-02-14 18:45:57'),
(1067, 98398, 'btc', '2025-02-14 18:47:57'),
(1068, 98385, 'btc', '2025-02-14 18:49:57'),
(1069, 98517, 'btc', '2025-02-14 18:51:58'),
(1070, 98395, 'btc', '2025-02-14 18:54:00'),
(1071, 98379, 'btc', '2025-02-14 18:56:01'),
(1072, 98342, 'btc', '2025-02-14 18:58:01'),
(1073, 98229, 'btc', '2025-02-14 19:00:03'),
(1074, 98341, 'btc', '2025-02-14 19:02:04'),
(1075, 98441, 'btc', '2025-02-14 19:04:04'),
(1076, 98465, 'btc', '2025-02-14 19:06:04'),
(1077, 98376, 'btc', '2025-02-14 19:08:04'),
(1078, 98382, 'btc', '2025-02-14 19:10:06'),
(1079, 98440, 'btc', '2025-02-14 19:12:06'),
(1080, 98414, 'btc', '2025-02-14 19:14:07'),
(1081, 98427, 'btc', '2025-02-14 19:16:10'),
(1082, 98449, 'btc', '2025-02-14 19:18:10'),
(1083, 98454, 'btc', '2025-02-14 19:20:11'),
(1084, 98398, 'btc', '2025-02-14 19:22:12'),
(1085, 98399, 'btc', '2025-02-14 19:24:12'),
(1086, 98349, 'btc', '2025-02-14 19:26:12'),
(1087, 98274, 'btc', '2025-02-14 19:28:12'),
(1088, 98224, 'btc', '2025-02-14 19:30:13'),
(1089, 98003, 'btc', '2025-02-14 19:32:15'),
(1090, 97915, 'btc', '2025-02-14 19:34:15'),
(1091, 97928, 'btc', '2025-02-14 19:36:16'),
(1092, 97988, 'btc', '2025-02-14 19:38:16'),
(1093, 98081, 'btc', '2025-02-14 19:40:16'),
(1094, 98163, 'btc', '2025-02-14 19:42:23'),
(1095, 98306, 'btc', '2025-02-14 19:44:23'),
(1096, 98253, 'btc', '2025-02-14 19:46:26'),
(1097, 98136, 'btc', '2025-02-14 19:48:26'),
(1098, 98148, 'btc', '2025-02-14 19:50:27'),
(1099, 97946, 'btc', '2025-02-14 19:52:27'),
(1100, 97783, 'btc', '2025-02-14 19:54:27'),
(1101, 97857, 'btc', '2025-02-14 19:56:29'),
(1102, 97964, 'btc', '2025-02-14 19:58:30'),
(1103, 97984, 'btc', '2025-02-14 20:00:30'),
(1104, 98064, 'btc', '2025-02-14 20:02:32'),
(1105, 97988, 'btc', '2025-02-14 20:04:32'),
(1106, 97914, 'btc', '2025-02-14 20:06:32'),
(1107, 97975, 'btc', '2025-02-14 20:08:32'),
(1108, 98033, 'btc', '2025-02-14 20:10:33'),
(1109, 98009, 'btc', '2025-02-14 20:12:33'),
(1110, 98125, 'btc', '2025-02-14 20:14:33'),
(1111, 98191, 'btc', '2025-02-14 20:16:33'),
(1112, 98288, 'btc', '2025-02-14 20:18:34'),
(1113, 98176, 'btc', '2025-02-14 20:20:35'),
(1114, 98042, 'btc', '2025-02-14 20:22:35'),
(1115, 98002, 'btc', '2025-02-14 20:24:35'),
(1116, 97979, 'btc', '2025-02-14 20:26:36'),
(1117, 97982, 'btc', '2025-02-14 20:28:36'),
(1118, 98009, 'btc', '2025-02-14 20:30:36'),
(1119, 98016, 'btc', '2025-02-14 20:32:36'),
(1120, 97932, 'btc', '2025-02-14 20:34:37'),
(1121, 97978, 'btc', '2025-02-14 20:36:37'),
(1122, 98018, 'btc', '2025-02-14 20:38:37'),
(1123, 97974, 'btc', '2025-02-14 20:40:37'),
(1124, 97880, 'btc', '2025-02-14 20:42:38'),
(1125, 97876, 'btc', '2025-02-14 20:44:38'),
(1126, 97783, 'btc', '2025-02-14 20:46:38'),
(1127, 97646, 'btc', '2025-02-14 20:48:39'),
(1128, 97595, 'btc', '2025-02-14 20:50:40'),
(1129, 97758, 'btc', '2025-02-15 13:07:32'),
(1130, 97743, 'btc', '2025-02-15 13:09:32'),
(1131, 97710, 'btc', '2025-02-15 13:11:32'),
(1132, 97723, 'btc', '2025-02-15 13:13:33'),
(1133, 97719, 'btc', '2025-02-15 13:15:33'),
(1134, 97727, 'btc', '2025-02-15 13:17:33'),
(1135, 97762, 'btc', '2025-02-15 13:19:33'),
(1136, 97794, 'btc', '2025-02-15 13:21:34'),
(1137, 97804, 'btc', '2025-02-15 13:23:35'),
(1138, 97787, 'btc', '2025-02-15 13:25:35'),
(1139, 97765, 'btc', '2025-02-15 13:27:36'),
(1140, 97809, 'btc', '2025-02-15 13:29:36'),
(1141, 97835, 'btc', '2025-02-15 13:31:36'),
(1142, 97808, 'btc', '2025-02-15 13:33:37'),
(1143, 97899, 'btc', '2025-02-15 13:35:37'),
(1144, 97872, 'btc', '2025-02-15 13:37:39'),
(1145, 97820, 'btc', '2025-02-15 13:39:39'),
(1146, 97807, 'btc', '2025-02-15 13:41:40'),
(1147, 97758, 'btc', '2025-02-15 13:43:41'),
(1148, 97761, 'btc', '2025-02-15 13:45:41'),
(1149, 97718, 'btc', '2025-02-15 13:47:41'),
(1150, 97851, 'btc', '2025-02-15 13:49:41'),
(1151, 97759, 'btc', '2025-02-15 13:51:42'),
(1152, 97740, 'btc', '2025-02-15 13:53:42'),
(1153, 97702, 'btc', '2025-02-15 13:55:42'),
(1154, 97797, 'btc', '2025-02-15 13:57:42'),
(1155, 97739, 'btc', '2025-02-15 13:59:44'),
(1156, 97700, 'btc', '2025-02-15 14:01:44'),
(1157, 97654, 'btc', '2025-02-15 14:03:45'),
(1158, 97641, 'btc', '2025-02-15 14:05:46'),
(1159, 97670, 'btc', '2025-02-15 14:07:46'),
(1160, 97763, 'btc', '2025-02-15 14:09:46'),
(1161, 97709, 'btc', '2025-02-15 14:11:47'),
(1162, 97718, 'btc', '2025-02-15 14:13:47'),
(1163, 97753, 'btc', '2025-02-15 14:15:48'),
(1164, 97665, 'btc', '2025-02-15 14:17:49'),
(1165, 97641, 'btc', '2025-02-15 14:19:49'),
(1166, 97635, 'btc', '2025-02-15 14:21:49'),
(1167, 97592, 'btc', '2025-02-15 14:23:50'),
(1168, 97597, 'btc', '2025-02-15 14:25:50'),
(1169, 97581, 'btc', '2025-02-15 14:27:51'),
(1170, 97581, 'btc', '2025-02-15 14:29:52'),
(1171, 97540, 'btc', '2025-02-15 14:31:53'),
(1172, 97587, 'btc', '2025-02-15 14:33:53'),
(1173, 97552, 'btc', '2025-02-15 14:35:54'),
(1174, 97501, 'btc', '2025-02-15 14:37:54'),
(1175, 97506, 'btc', '2025-02-15 14:39:55'),
(1176, 97486, 'btc', '2025-02-15 14:41:56'),
(1177, 97540, 'btc', '2025-02-15 14:43:56'),
(1178, 97554, 'btc', '2025-02-15 14:45:56'),
(1179, 97575, 'btc', '2025-02-15 14:47:56'),
(1180, 97600, 'btc', '2025-02-15 14:49:58');







INSERT INTO `dealership_data` (`name`, `label`, `balance`, `owner_id`, `owner_name`, `employee_commission`) VALUES
('air', '', 0, NULL, NULL, 10);
INSERT INTO `dealership_data` (`name`, `label`, `balance`, `owner_id`, `owner_name`, `employee_commission`) VALUES
('boats', '', 0, NULL, NULL, 10);
INSERT INTO `dealership_data` (`name`, `label`, `balance`, `owner_id`, `owner_name`, `employee_commission`) VALUES
('luxury', '', 0, NULL, NULL, 10);
INSERT INTO `dealership_data` (`name`, `label`, `balance`, `owner_id`, `owner_name`, `employee_commission`) VALUES
('pdm', '', 0, NULL, NULL, 10),
('truck', '', 0, NULL, NULL, 10);

















INSERT INTO `electus_gangs` (`owner`, `gang_id`, `level`, `xp`, `name`, `cash`, `dirty_cash`, `color`, `safe_house_zone`, `gang_rep`) VALUES
('IHL05518', 1, 1, 0, 'test', 5000, 0, '#00c4d6', 1, 15);


INSERT INTO `electus_gangs_base_tasks` (`gang_id`, `task_stage`, `progress`) VALUES
(1, 1, 0);




INSERT INTO `electus_gangs_current_weekly_task` (`task_id`) VALUES
(1);


INSERT INTO `electus_gangs_doors` (`gang_id`, `door_id`, `password`) VALUES
(1, 'warehouse', '$2a$11$h2UBCz9QcOlgPSUHQ3sYZOOYMW9V6hUECZQFsId.M.4GP5DeLYBZe');
INSERT INTO `electus_gangs_doors` (`gang_id`, `door_id`, `password`) VALUES
(1, 'weed_processing', '$2a$11$SeNcRUC9jQg8FBrghnkEzupiZosWYJHRACYGQFScPvEARoAqHVrXC');
INSERT INTO `electus_gangs_doors` (`gang_id`, `door_id`, `password`) VALUES
(1, 'money_laundering', '$2a$11$x9W/Xw66S6uRrdTj9lmMQ.wpxTUvvGBU6Du5BJf1gL4QgBL/OchZa');

INSERT INTO `electus_gangs_logs` (`gang_id`, `id`, `event`, `description`, `date_stamp`) VALUES
(1, 1, 'Looted boat crate', 'Successfully looted a boat crate', '2025-02-09 16:47:53');
INSERT INTO `electus_gangs_logs` (`gang_id`, `id`, `event`, `description`, `date_stamp`) VALUES
(1, 2, 'Looted boat crate', 'Successfully looted a boat crate', '2025-02-09 16:48:28');
INSERT INTO `electus_gangs_logs` (`gang_id`, `id`, `event`, `description`, `date_stamp`) VALUES
(1, 3, 'Looted boat crate', 'Successfully looted a boat crate', '2025-02-09 16:59:14');







INSERT INTO `electus_gangs_stats` (`gang_id`, `date_stamp`, `cash`, `dirty_cash`, `members`, `gang_rep`, `zones`) VALUES
(1, '2025-02-09 16:00:00', 0, 0, 1, 0, 0);
INSERT INTO `electus_gangs_stats` (`gang_id`, `date_stamp`, `cash`, `dirty_cash`, `members`, `gang_rep`, `zones`) VALUES
(1, '2025-02-09 17:00:00', 5000, 0, 1, 15, 0);
INSERT INTO `electus_gangs_stats` (`gang_id`, `date_stamp`, `cash`, `dirty_cash`, `members`, `gang_rep`, `zones`) VALUES
(1, '2025-02-09 18:00:00', 5000, 0, 1, 15, 0);
INSERT INTO `electus_gangs_stats` (`gang_id`, `date_stamp`, `cash`, `dirty_cash`, `members`, `gang_rep`, `zones`) VALUES
(1, '2025-02-09 19:00:00', 5000, 0, 1, 15, 0),
(1, '2025-02-09 20:00:00', 5000, 0, 1, 15, 0),
(1, '2025-02-09 21:00:00', 5000, 0, 1, 15, 0),
(1, '2025-02-09 22:00:00', 5000, 0, 1, 15, 0);

INSERT INTO `electus_gangs_transactions` (`gang_id`, `type`, `handled_by`, `id`, `amount`, `date_stamp`) VALUES
(1, 'deposit', 'IHL05518', 1, 500, '2025-02-09 16:18:05');
INSERT INTO `electus_gangs_transactions` (`gang_id`, `type`, `handled_by`, `id`, `amount`, `date_stamp`) VALUES
(1, 'deposit', 'IHL05518', 2, 5000, '2025-02-09 16:41:09');




INSERT INTO `electus_gangs_vehicles` (`gang_id`, `plate`, `vehicle`) VALUES
(1, '3MH194VS', '{\"model\":\"moonbeam2\",\"plate\":\"3MH194VS\"}');










INSERT INTO `electus_gangs_zones_data` (`id`, `points`, `types`, `capture`, `gang_menu`, `laundering_menu`, `capture_time`, `laundering_capacity`, `max_plants`, `max_recruits`, `ipl_id`, `ipl_marker`, `garage`, `warehouse`, `weed_processing`, `vehicle_spawn_pos`, `max_cash`, `min_cash`, `max_npc`, `min_npc`) VALUES
(1, '[[-2838.563789441747,378.37763068552507],[-2832.4958282766986,754.6804137036003],[-3357.3744690533978,718.2640153470115],[-3493.9035952669898,381.4123305485747]]', '[\"safeHouse\"]', NULL, '{\"z\":5.17005681991577,\"y\":-3149.994140625,\"x\":487.8533630371094}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"z\":5.17005634307861,\"y\":-3135.69970703125,\"x\":479.9974060058594}', '{\"z\":5.17005634307861,\"y\":-3155.5625,\"x\":482.711181640625}', '{\"z\":5.17005634307861,\"y\":-3149.139892578125,\"x\":475.66400146484377}', '{\"z\":5.07005643844604,\"y\":-3148.392822265625,\"x\":486.063720703125,\"w\":0}', NULL, NULL, NULL, NULL);


































INSERT INTO `inventory_stash` (`id`, `stash`, `items`) VALUES
(1, '1:1', '[]');


















INSERT INTO `market_markets` (`id`, `name`, `description`, `job`, `ratings`, `coords`) VALUES
(1, 'Los Santos Police Department', 'The city police, always willing to help you, let us know if you have any problems in Los Santos.', '[\"police\",\"sheriff\"]', '[]', '{\"x\":452.1199951171875,\"y\":-980.5499877929688,\"z\":30.69000053405761}');
INSERT INTO `market_markets` (`id`, `name`, `description`, `job`, `ratings`, `coords`) VALUES
(2, 'Pillbox Medical Center', 'If you need a doctor, contact the Los Santos Emergency Center!', '[\"ambulance\"]', '[]', '{\"x\":335.1199951171875,\"y\":-584.5499877929688,\"z\":43.68999862670898}');
INSERT INTO `market_markets` (`id`, `name`, `description`, `job`, `ratings`, `coords`) VALUES
(3, 'Bean Machine', 'The best coffee shop in the city now with home delivery, order your coffee, cappuccino, with milk, or whatever you want, call us now!', '[\"beanmachine\",\"deliver\"]', '[]', '{\"x\":280.79998779296877,\"y\":-963.982421875,\"z\":29.4146728515625}');
INSERT INTO `market_markets` (`id`, `name`, `description`, `job`, `ratings`, `coords`) VALUES
(4, 'Jamaican Roast', 'Home delivery, in-store sales, try the best cappuccino in all of Los Santos, Toasts, Meals, Grill, come or order your order!', '[\"jamaican\",\"deliver\"]', '[]', '{\"x\":273.4681396484375,\"y\":-832.971435546875,\"z\":29.3978271484375}'),
(5, 'Pizza This', 'The best pizzeria in Los Santos, since 1988 we have brought the best Italian pizza to your palate, choose your flavor and contact us!', '[\"pizzajob\",\"deliver\"]', '[]', '{\"x\":287.73626708984377,\"y\":-963.96923828125,\"z\":29.4146728515625}'),
(6, 'Bennys Original Motor Works', 'The best mechanic company in the city allows you to request home orders or direct contact through Marketplace, get in touch if you need a repair, we are here!', '[\"mechanic\"]', '[]', '{\"x\":-206.00439453125,\"y\":-1310.2813720703126,\"z\":31.2850341796875}'),
(7, 'Premium Deluxe Motorsport', 'Order your new car, ask for prices and even vehicle delivery, what are you waiting for to receive your new sports carNULL', '[\"dealership\"]', '[]', '{\"x\":-45.36263656616211,\"y\":-1107.3099365234376,\"z\":26.4322509765625}'),
(8, 'Vanilla Unicorn', 'Come have a beer, a drink or even enjoy the best women/men in the entire city, place your alcohol order or reserve your favorite woman/man!', '[\"unicornjob\"]', '[]', '{\"x\":128.7956085205078,\"y\":-1297.265869140625,\"z\":29.14501953125}');



INSERT INTO `mechanic_data` (`name`, `label`, `balance`, `owner_id`, `owner_name`) VALUES
('bennys', '', 0, NULL, NULL);
INSERT INTO `mechanic_data` (`name`, `label`, `balance`, `owner_id`, `owner_name`) VALUES
('lscustoms', '', 0, NULL, NULL);














INSERT INTO `nyx_crafting` (`id`, `citizenid`, `points`, `skills`, `total_crafted`, `total_points`) VALUES
(1, 'IHL05518', 99999984, '[\"water_bottle\",\"weapon_hammer\",\"weapon_golfclub\",\"weapon_bottle\",\"weapon_wrench\",\"weapon_poolcue\",\"weapon_knuckle\",\"weapon_battleaxe\",\"weapon_machete\",\"weapon_knife\",\"weapon_hatchet\",\"weapon_switchblade\",\"weapon_snspistol\"]', 0, 33);


















































INSERT INTO `player_vehicles` (`id`, `license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `fakeplate`, `garage`, `fuel`, `engine`, `body`, `state`, `depotprice`, `drivingdistance`, `status`, `balance`, `paymentamount`, `paymentsleft`, `financetime`, `financed`, `finance_data`, `damage`, `in_garage`, `garage_id`, `job_vehicle`, `job_vehicle_rank`, `gang_vehicle`, `gang_vehicle_rank`, `impound`, `impound_retrievable`, `impound_data`, `nickname`, `mileage`) VALUES
(1, 'license:947f9cbd9a50936b100d7c91442681273e0b7332', 'IHL05518', 'adder', '-1216765807', '[]', 'NGYDHWGK', NULL, '0', 100, 1000, 1000, 1, 0, 0, '0', 0, 0, 0, 0, 0, '', '0', 0, '0', 0, 0, 0, 0, 0, 0, '', '', 0);


INSERT INTO `players` (`id`, `citizenid`, `cid`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`, `phone_number`, `crm_slot`, `crm_avatar_id`, `crm_favorite`, `crm_is_premium`, `crm_tattoos`, `cryptocurrency`, `crypto_wallet_id`, `inside`, `crm_ck`) VALUES
(319, 'GJY14460', 1, 'license:418e21e56aaedfd2c30574ff6be8ce62e6051b2b', 'Spinster97', '{\"cash\":500,\"crypto\":0,\"bank\":5000}', '{\"phone\":\"1145989682\",\"nationality\":\"uk\",\"lastname\":\"king\",\"gender\":0,\"account\":\"US08QBCore5427926934\",\"cid\":1,\"birthdate\":\"1933-1-1\",\"firstname\":\"ben\"}', '{\"onduty\":false,\"name\":\"unemployed\",\"grade\":{\"name\":\"Freelancer\",\"level\":0},\"label\":\"Civilian\",\"isboss\":false,\"type\":\"none\",\"payment\":10}', '{\"label\":\"No Gang Affiliation\",\"name\":\"none\",\"isboss\":false,\"grade\":{\"name\":\"none\",\"level\":0}}', '{\"x\":103.96484375,\"y\":-510.5670166015625,\"z\":43.4674072265625}', '{\"inlaststand\":false,\"injail\":0,\"stress\":0,\"jailitems\":[],\"phonedata\":{\"SerialNumber\":21960408,\"InstalledApps\":[]},\"rep\":[],\"thirst\":97.2,\"hunger\":96.8,\"fingerprint\":\"ha887z04QVA7144\",\"licences\":{\"driver\":true,\"business\":false,\"weapon\":false},\"inside\":{\"apartment\":[]},\"ishandcuffed\":false,\"bloodtype\":\"AB-\",\"phone\":[],\"isdead\":false,\"status\":[],\"armor\":0,\"tracker\":false,\"criminalrecord\":{\"hasRecord\":false},\"walletid\":\"QB-66394469\",\"callsign\":\"NO CALLSIGN\"}', '[{\"type\":\"item\",\"count\":1,\"created\":1739552120,\"name\":\"phone\",\"slot\":1,\"info\":{\"quality\":100},\"amount\":1},{\"type\":\"item\",\"count\":1,\"created\":1739552120,\"name\":\"id_card\",\"slot\":2,\"info\":{\"nationality\":\"uk\",\"quality\":100,\"lastname\":\"king\",\"firstname\":\"johnny\",\"gender\":\"Male\",\"birthdate\":\"1933-1-1\",\"citizenid\":\"GJY14460\"},\"amount\":1},{\"type\":\"item\",\"count\":1,\"created\":1739552120,\"name\":\"driver_license\",\"slot\":3,\"info\":{\"type\":\"Class C Driver License\",\"lastname\":\"king\",\"firstname\":\"johnny\",\"birthdate\":\"1933-1-1\",\"quality\":100},\"amount\":1},{\"type\":\"item\",\"count\":500,\"created\":1739552122,\"name\":\"cash\",\"slot\":4,\"info\":{\"quality\":100},\"amount\":500}]', '2025-02-16 19:37:06', '1145989682', 1, 6, 0, '0', '', '', 'inx5NEWU', '', 0);
INSERT INTO `players` (`id`, `citizenid`, `cid`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`, `phone_number`, `crm_slot`, `crm_avatar_id`, `crm_favorite`, `crm_is_premium`, `crm_tattoos`, `cryptocurrency`, `crypto_wallet_id`, `inside`, `crm_ck`) VALUES
(1, 'IHL05518', 1, 'license:947f9cbd9a50936b100d7c91442681273e0b7332', 'jxmessc0tt', '{\"crypto\":0,\"bank\":14450,\"cash\":0}', '{\"cid\":1,\"birthdate\":\"1933-1-11\",\"lastname\":\"sc0tt\",\"nationality\":\"ENG\",\"firstname\":\"jxmes\",\"phone\":\"5119234114\",\"gender\":0,\"account\":\"US03QBCore2572854176\"}', '{\"isboss\":true,\"name\":\"police\",\"type\":\"leo\",\"grade\":{\"isboss\":true,\"name\":\"Chief\",\"payment\":150,\"level\":4},\"payment\":150,\"onduty\":true,\"label\":\"Law Enforcement\"}', '{\"grade\":{\"isboss\":false,\"name\":\"Unaffiliated\",\"level\":0},\"name\":\"none\",\"isboss\":false,\"label\":\"No Gang\"}', '{\"x\":22.4439582824707,\"y\":-1736.769287109375,\"z\":29.2967529296875}', '{\"phonedata\":{\"SerialNumber\":78720205,\"InstalledApps\":[]},\"playtime\":1690,\"hunger\":80.79999999999999,\"tracker\":false,\"stress\":0,\"rep\":[],\"fingerprint\":\"Mn129B45EAC9123\",\"thirst\":83.20000000000002,\"phone\":[],\"inside\":{\"apartment\":[]},\"licences\":{\"weapon\":false,\"business\":false,\"driver\":true},\"status\":[],\"ishandcuffed\":false,\"criminalrecord\":{\"hasRecord\":false},\"callsign\":\"NO CALLSIGN\",\"walletid\":\"QB-24486951\",\"jailitems\":[],\"inlaststand\":false,\"armor\":0,\"injail\":0,\"isdead\":false,\"bloodtype\":\"B+\",\"vehicleKeys\":{\"07GSW647\":true,\"43ZPI819\":true,\"21YTF236\":true,\"80KTT232\":true,\"05RUK077\":true}}', '[{\"amount\":1,\"info\":{\"ammo\":0,\"serie\":\"gaj14udU92\",\"quality\":100},\"created\":1739479980,\"count\":1,\"name\":\"weapon_pistol\",\"type\":\"weapon\",\"slot\":1}]', '2025-02-15 14:49:47', '5119234114', 1, 9, 0, '0', '', '', '8dmgjH00', '', 0);
INSERT INTO `players` (`id`, `citizenid`, `cid`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`, `phone_number`, `crm_slot`, `crm_avatar_id`, `crm_favorite`, `crm_is_premium`, `crm_tattoos`, `cryptocurrency`, `crypto_wallet_id`, `inside`, `crm_ck`) VALUES
(325, 'QCC38898', 1, 'license:56e7feae06f78b2c751f637e49b189bc574a1144', '0Ma113y', '{\"cash\":500,\"crypto\":0,\"bank\":5000}', '{\"phone\":\"3542684707\",\"nationality\":\"MERICA\",\"lastname\":\"SMITH\",\"gender\":0,\"account\":\"US05QBCore5819641996\",\"cid\":1,\"birthdate\":\"1990-7-16\",\"firstname\":\"jon \"}', '{\"onduty\":false,\"name\":\"unemployed\",\"grade\":{\"name\":\"Freelancer\",\"level\":0},\"label\":\"Civilian\",\"isboss\":false,\"type\":\"none\",\"payment\":10}', '{\"label\":\"No Gang Affiliation\",\"name\":\"none\",\"isboss\":false,\"grade\":{\"name\":\"none\",\"level\":0}}', '{\"x\":17.89450645446777,\"y\":-415.79339599609377,\"z\":39.3223876953125}', '{\"inlaststand\":false,\"injail\":0,\"stress\":0,\"jailitems\":[],\"phonedata\":{\"SerialNumber\":35696747,\"InstalledApps\":[]},\"rep\":[],\"thirst\":97.2,\"hunger\":96.8,\"fingerprint\":\"vi981Z50fAH1529\",\"licences\":{\"driver\":true,\"business\":false,\"weapon\":false},\"inside\":{\"apartment\":[]},\"ishandcuffed\":false,\"playtime\":5,\"bloodtype\":\"A-\",\"phone\":[],\"isdead\":false,\"status\":[],\"armor\":0,\"tracker\":false,\"criminalrecord\":{\"hasRecord\":false},\"walletid\":\"QB-67779710\",\"callsign\":\"NO CALLSIGN\"}', '[{\"type\":\"item\",\"count\":1,\"created\":1739552930,\"name\":\"phone\",\"slot\":1,\"info\":{\"owneridentifier\":\"QCC38898\",\"phoneNumber\":\"909114843\",\"uniqueId\":425183389,\"charinfo\":{\"firstname\":\"jon \",\"phone\":\"909114843\",\"lastname\":\"SMITH\"},\"metadata\":{\"lockscreen\":true,\"steps\":26,\"apps\":[{\"app\":\"phone\",\"hideInSettingsNotifications\":true,\"job\":false,\"image\":\"img/apps/phone.png\",\"notificationSound\":\"\",\"slot\":\"0:0\",\"category\":\"Social\",\"blockedJobs\":[],\"label\":\"Phone\"},{\"image\":\"img/apps/messages.png\",\"job\":false,\"label\":\"Messages\",\"slot\":\"0:1\",\"app\":\"messages\",\"blockedJobs\":[],\"category\":\"Social\"},{\"image\":\"img/apps/settings.png\",\"job\":false,\"category\":\"Utilities\",\"label\":\"Settings\",\"slot\":\"0:2\",\"app\":\"settings\",\"blockedJobs\":[],\"blockBadge\":true},{\"image\":\"img/apps/camera.png\",\"job\":false,\"label\":\"Camera\",\"slot\":\"0:3\",\"app\":\"camera\",\"blockedJobs\":[],\"category\":\"Creativity\"},{\"image\":\"img/apps/contacts.png\",\"job\":false,\"label\":\"Contacts\",\"slot\":\"1:0\",\"app\":\"contacts\",\"blockedJobs\":[],\"category\":\"Social\"},{\"image\":\"img/apps/mail.png\",\"job\":false,\"label\":\"Mail\",\"slot\":\"1:1\",\"app\":\"mail\",\"blockedJobs\":[],\"category\":\"Productivity & Finance\"},{\"image\":\"img/apps/weather.png\",\"job\":false,\"label\":\"Weather\",\"slot\":\"1:2\",\"app\":\"weather\",\"blockedJobs\":[],\"category\":\"Information & Reading\"},{\"image\":\"img/apps/calendar.png\",\"job\":false,\"label\":\"Calendar\",\"slot\":\"1:3\",\"app\":\"calendar\",\"blockedJobs\":[],\"category\":\"Productivity & Finance\"},{\"image\":\"img/apps/reminders.png\",\"job\":false,\"label\":\"Reminders\",\"slot\":\"1:4\",\"app\":\"reminder\",\"blockedJobs\":[],\"category\":\"Productivity & Finance\"},{\"image\":\"img/apps/gallery.png\",\"job\":false,\"label\":\"Gallery\",\"slot\":\"1:5\",\"app\":\"gallery\",\"blockedJobs\":[],\"category\":\"Creativity\"},{\"image\":\"img/apps/health.png\",\"job\":false,\"label\":\"Health\",\"slot\":\"1:6\",\"app\":\"health\",\"blockedJobs\":[],\"category\":\"Creativity\"},{\"image\":\"img/apps/notes.png\",\"job\":false,\"hideInSettingsNotifications\":true,\"label\":\"Notes\",\"slot\":\"1:7\",\"app\":\"notes\",\"blockedJobs\":[],\"category\":\"Productivity & Finance\"},{\"image\":\"img/apps/calculator.png\",\"job\":false,\"hideInSettingsNotifications\":true,\"label\":\"Calculator\",\"slot\":\"1:8\",\"app\":\"calculator\",\"blockedJobs\":[],\"category\":\"Utilities\"},{\"image\":\"img/apps/store.png\",\"job\":false,\"label\":\"App Store\",\"slot\":\"1:9\",\"app\":\"store\",\"blockedJobs\":[],\"category\":\"Utilities\"},{\"image\":\"img/apps/stock.png\",\"job\":false,\"label\":\"Stock\",\"slot\":\"1:10\",\"app\":\"crypto\",\"blockedJobs\":[],\"category\":\"Productivity & Finance\"},{\"image\":\"img/apps/clock.png\",\"job\":false,\"label\":\"Clock\",\"slot\":\"1:11\",\"app\":\"clock\",\"blockedJobs\":[],\"category\":\"Utilities\"},{\"image\":\"img/apps/houses.png\",\"job\":false,\"label\":\"Home\",\"slot\":\"1:12\",\"app\":\"houses\",\"blockedJobs\":[],\"category\":\"Utilities\"},{\"image\":\"img/apps/news.png\",\"job\":false,\"label\":\"News\",\"slot\":\"1:13\",\"app\":\"weazel\",\"blockedJobs\":[],\"category\":\"Other\"},{\"image\":\"img/apps/maps.png\",\"app\":\"map\",\"slot\":\"1:14\",\"label\":\"Maps\",\"blockedJobs\":[],\"category\":\"Utilities\"},{\"image\":\"img/apps/safari.png\",\"app\":\"safari\",\"label\":\"Safari\",\"slot\":\"1:15\",\"game\":{\"name\":\"safari\",\"rotate\":false,\"iframe\":\"https://yep.com\",\"css\":{\"position\":\"absolute\",\"height\":\"100%\",\"top\":\"0\",\"border\":\"none\",\"width\":\"100%\"}},\"blockedJobs\":[],\"category\":\"Utilities\"},{\"image\":\"img/apps/facetime.png\",\"job\":false,\"label\":\"FaceTime\",\"slot\":\"1:16\",\"app\":\"facetime\",\"blockedJobs\":[],\"category\":\"Social\"}],\"blur_disabled\":true,\"battery\":99.99799999999999}},\"amount\":1},{\"type\":\"item\",\"count\":1,\"created\":1739552930,\"name\":\"id_card\",\"slot\":2,\"info\":{\"nationality\":\"MERICA\",\"firstname\":\"jon \",\"lastname\":\"SMITH\",\"citizenid\":\"QCC38898\",\"gender\":\"Male\",\"quality\":100,\"birthdate\":\"1990-7-16\"},\"amount\":1},{\"type\":\"item\",\"count\":1,\"created\":1739552930,\"name\":\"driver_license\",\"slot\":3,\"info\":{\"quality\":100,\"lastname\":\"SMITH\",\"firstname\":\"jon \",\"birthdate\":\"1990-7-16\",\"type\":\"Class C Driver License\"},\"amount\":1},{\"type\":\"item\",\"count\":500,\"created\":1739552933,\"name\":\"cash\",\"slot\":4,\"info\":{\"quality\":100},\"amount\":500}]', '2025-02-14 17:12:30', '3542684707', 1, 10, 0, '0', '', '', 'MULW7AGA', '', 0);
INSERT INTO `players` (`id`, `citizenid`, `cid`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`, `inventory`, `last_updated`, `phone_number`, `crm_slot`, `crm_avatar_id`, `crm_favorite`, `crm_is_premium`, `crm_tattoos`, `cryptocurrency`, `crypto_wallet_id`, `inside`, `crm_ck`) VALUES
(181, 'UPV75767', 2, 'license:947f9cbd9a50936b100d7c91442681273e0b7332', 'jamessc0tt', '{\"cash\":500,\"bank\":5000,\"crypto\":0}', '{\"gender\":0,\"firstname\":\"jxmes\",\"cid\":2,\"birthdate\":\"1933-1-12\",\"account\":\"US01QBCore5791399642\",\"phone\":\"6765291970\",\"lastname\":\"sc1tt\",\"nationality\":\"ENG\"}', '{\"isboss\":false,\"onduty\":false,\"label\":\"Civilian\",\"name\":\"unemployed\",\"type\":\"none\",\"grade\":{\"name\":\"Freelancer\",\"level\":0,\"isboss\":false},\"payment\":10}', '{\"name\":\"none\",\"grade\":{\"name\":\"Unaffiliated\",\"level\":0,\"isboss\":false},\"isboss\":false,\"label\":\"No Gang\"}', '{\"x\":-417.5208740234375,\"y\":6376.15380859375,\"z\":13.76123046875}', '{\"criminalrecord\":{\"hasRecord\":false},\"inlaststand\":false,\"callsign\":\"NO CALLSIGN\",\"fingerprint\":\"Hh038k73XfL3562\",\"armor\":0,\"jailitems\":[],\"thirst\":69.20000000000003,\"ishandcuffed\":false,\"licences\":{\"business\":false,\"weapon\":false,\"driver\":true},\"stress\":0,\"walletid\":\"QB-33098760\",\"hunger\":64.79999999999997,\"isdead\":false,\"injail\":0,\"bloodtype\":\"AB+\",\"inside\":{\"apartment\":[]},\"playtime\":45,\"rep\":[],\"status\":[],\"phonedata\":{\"InstalledApps\":[],\"SerialNumber\":67412923},\"tracker\":false,\"phone\":[]}', '[{\"amount\":1,\"created\":1739459409,\"slot\":2,\"type\":\"item\",\"count\":1,\"info\":{\"gender\":\"Male\",\"firstname\":\"jxmes\",\"nationality\":\"ENG\",\"citizenid\":\"UPV75767\",\"lastname\":\"sc1tt\",\"quality\":100,\"birthdate\":\"1933-1-12\"},\"name\":\"id_card\"},{\"amount\":1,\"created\":1739459409,\"slot\":3,\"type\":\"item\",\"count\":1,\"info\":{\"type\":\"Class C Driver License\",\"firstname\":\"jxmes\",\"lastname\":\"sc1tt\",\"quality\":100,\"birthdate\":\"1933-1-12\"},\"name\":\"driver_license\"},{\"amount\":500,\"created\":1739465754,\"slot\":4,\"type\":\"item\",\"count\":500,\"info\":{\"quality\":100},\"name\":\"cash\"}]', '2025-02-13 17:42:40', '6765291970', 2, 1, 0, '0', '', '', 'wTRRWSDm', '', 0);

INSERT INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
(2, 'IHL05518', 'mp_m_freemode_01', '{\"crm_makeup\":{\"crm_lipstick\":{\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0,\"crm_index\":0},\"crm_blush\":{\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0,\"crm_index\":0},\"crm_makeup\":{\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0,\"crm_index\":0}},\"crm_face\":{\"crm_eye_color\":0,\"crm_no_height\":0.0,\"crm_ch_length\":0.0,\"crm_ja_size\":0.0,\"crm_ey_depth\":0.0,\"crm_em_lip_thickness\":0.0,\"crm_ja_width\":0.0,\"crm_no_width\":0.0,\"crm_ey_height\":0.0,\"crm_em_eyes_opening\":0.0,\"crm_ch_bone_height\":0.0,\"crm_ne_thickness\":0.0,\"crm_no_peak_height\":0.0,\"crm_no_bone_twist\":0.0,\"crm_ch_lowering\":0.0,\"crm_ch_width\":0.0,\"crm_ch_hole_size\":0.0,\"crm_ch_size\":0.0,\"crm_no_bone_height\":0.0,\"crm_no_size\":0.0,\"crm_ch_bone_width\":0.0},\"crm_skin\":{\"crm_ageing\":{\"crm_opacity\":0,\"crm_index\":0},\"crm_blemishes\":{\"crm_opacity\":0,\"crm_index\":0},\"crm_moles_freckles\":{\"crm_opacity\":0,\"crm_index\":0},\"crm_complexion\":{\"crm_opacity\":0,\"crm_index\":0},\"crm_sun_damage\":{\"crm_opacity\":0,\"crm_index\":0},\"crm_body_blemishes\":{\"crm_opacity\":0,\"crm_index\":0}},\"crm_accessories\":[{\"crm_style\":-1,\"crm_texture\":-1,\"crm_id\":0},{\"crm_style\":-1,\"crm_texture\":-1,\"crm_id\":1},{\"crm_style\":-1,\"crm_texture\":-1,\"crm_id\":2},{\"crm_style\":-1,\"crm_texture\":-1,\"crm_id\":6},{\"crm_style\":-1,\"crm_texture\":-1,\"crm_id\":7}],\"crm_clothing\":[{\"crm_style\":0,\"crm_texture\":0},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":0},{\"crm_style\":68,\"crm_texture\":2,\"crm_id\":1},{\"crm_style\":17,\"crm_texture\":0,\"crm_id\":3},{\"crm_style\":129,\"crm_texture\":3,\"crm_id\":4},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":5},{\"crm_style\":82,\"crm_texture\":0,\"crm_id\":6},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":7},{\"crm_style\":15,\"crm_texture\":0,\"crm_id\":8},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":9},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":10},{\"crm_style\":171,\"crm_texture\":0,\"crm_id\":11}],\"crm_hair\":{\"crm_facial_hair\":{\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0,\"crm_index\":0},\"crm_hair\":{\"crm_texture\":0,\"crm_color\":0,\"crm_secondary_color\":0,\"crm_index\":0},\"crm_eyebrows\":{\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0,\"crm_index\":0},\"crm_chest_hair\":{\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0,\"crm_index\":0}},\"crm_model\":\"mp_m_freemode_01\",\"crm_inheritance\":{\"crm_mix_race\":0.0,\"crm_father_face\":0,\"crm_mother_skin\":0,\"crm_mother_race\":0,\"crm_mix_skin\":0.0,\"crm_father_race\":0,\"crm_father_skin\":0,\"crm_mix_face\":0.0,\"crm_mother_face\":0}}', 1);
INSERT INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
(3, 'UPV75767', 'mp_m_freemode_01', '{\"crm_face\":{\"crm_ey_height\":0.0,\"crm_ch_hole_size\":0.0,\"crm_no_bone_twist\":0.0,\"crm_em_lip_thickness\":0.0,\"crm_ja_width\":0.0,\"crm_no_bone_height\":0.0,\"crm_ja_size\":0.0,\"crm_em_eyes_opening\":0.0,\"crm_ch_bone_width\":0.0,\"crm_ne_thickness\":0.0,\"crm_ch_bone_height\":0.0,\"crm_eye_color\":0,\"crm_no_size\":0.0,\"crm_ch_length\":0.0,\"crm_ch_lowering\":0.0,\"crm_no_width\":0.0,\"crm_no_height\":0.0,\"crm_ch_size\":0.0,\"crm_ch_width\":0.0,\"crm_ey_depth\":0.0,\"crm_no_peak_height\":0.0},\"crm_makeup\":{\"crm_lipstick\":{\"crm_index\":0,\"crm_color\":0,\"crm_secondary_color\":0,\"crm_opacity\":0},\"crm_blush\":{\"crm_index\":0,\"crm_color\":0,\"crm_secondary_color\":0,\"crm_opacity\":0},\"crm_makeup\":{\"crm_index\":0,\"crm_color\":0,\"crm_secondary_color\":0,\"crm_opacity\":0}},\"crm_accessories\":[{\"crm_style\":-1,\"crm_texture\":-1,\"crm_id\":0},{\"crm_style\":-1,\"crm_texture\":-1,\"crm_id\":1},{\"crm_style\":-1,\"crm_texture\":-1,\"crm_id\":2},{\"crm_style\":-1,\"crm_texture\":-1,\"crm_id\":6},{\"crm_style\":-1,\"crm_texture\":-1,\"crm_id\":7}],\"crm_inheritance\":{\"crm_mix_face\":0.0,\"crm_mother_face\":0,\"crm_mother_skin\":0,\"crm_father_face\":0,\"crm_father_skin\":0,\"crm_mix_race\":0.0,\"crm_mother_race\":0,\"crm_mix_skin\":0.0,\"crm_father_race\":0},\"crm_clothing\":[{\"crm_style\":0,\"crm_texture\":0},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":0},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":1},{\"crm_style\":15,\"crm_texture\":0,\"crm_id\":3},{\"crm_style\":18,\"crm_texture\":0,\"crm_id\":4},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":5},{\"crm_style\":34,\"crm_texture\":0,\"crm_id\":6},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":7},{\"crm_style\":15,\"crm_texture\":0,\"crm_id\":8},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":9},{\"crm_style\":0,\"crm_texture\":0,\"crm_id\":10},{\"crm_style\":15,\"crm_texture\":0,\"crm_id\":11}],\"crm_model\":\"mp_m_freemode_01\",\"crm_hair\":{\"crm_eyebrows\":{\"crm_index\":0,\"crm_color\":0,\"crm_secondary_color\":0,\"crm_opacity\":0},\"crm_facial_hair\":{\"crm_index\":0,\"crm_color\":0,\"crm_secondary_color\":0,\"crm_opacity\":0},\"crm_chest_hair\":{\"crm_index\":0,\"crm_color\":0,\"crm_secondary_color\":0,\"crm_opacity\":0},\"crm_hair\":{\"crm_index\":0,\"crm_texture\":0,\"crm_secondary_color\":0,\"crm_color\":0}},\"crm_skin\":{\"crm_blemishes\":{\"crm_index\":0,\"crm_opacity\":0},\"crm_complexion\":{\"crm_index\":0,\"crm_opacity\":0},\"crm_moles_freckles\":{\"crm_index\":0,\"crm_opacity\":0},\"crm_ageing\":{\"crm_index\":0,\"crm_opacity\":0},\"crm_body_blemishes\":{\"crm_index\":0,\"crm_opacity\":0},\"crm_sun_damage\":{\"crm_index\":0,\"crm_opacity\":0}}}', 1);
INSERT INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
(4, 'GJY14460', 'mp_m_freemode_01', '{\"crm_face\":{\"crm_ch_length\":0.0,\"crm_no_width\":0.0,\"crm_em_eyes_opening\":0.0,\"crm_ey_height\":0.0,\"crm_ja_width\":0.0,\"crm_no_peak_height\":0.0,\"crm_ch_bone_height\":0.0,\"crm_em_lip_thickness\":0.0,\"crm_no_bone_twist\":0.0,\"crm_no_bone_height\":0.0,\"crm_ch_hole_size\":0.0,\"crm_no_height\":0.0,\"crm_ey_depth\":0.0,\"crm_ch_size\":0.0,\"crm_ne_thickness\":0.0,\"crm_ch_width\":0.0,\"crm_eye_color\":0,\"crm_ja_size\":0.0,\"crm_no_size\":0.0,\"crm_ch_lowering\":0.0,\"crm_ch_bone_width\":0.0},\"crm_clothing\":[{\"crm_style\":0,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":0,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":1,\"crm_texture\":0},{\"crm_style\":15,\"crm_id\":3,\"crm_texture\":0},{\"crm_style\":18,\"crm_id\":4,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":5,\"crm_texture\":0},{\"crm_style\":34,\"crm_id\":6,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":7,\"crm_texture\":0},{\"crm_style\":15,\"crm_id\":8,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":9,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":10,\"crm_texture\":0},{\"crm_style\":15,\"crm_id\":11,\"crm_texture\":0}],\"crm_model\":\"mp_m_freemode_01\",\"crm_hair\":{\"crm_hair\":{\"crm_index\":0,\"crm_color\":0,\"crm_secondary_color\":0,\"crm_texture\":0},\"crm_facial_hair\":{\"crm_index\":0,\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0},\"crm_eyebrows\":{\"crm_index\":0,\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0},\"crm_chest_hair\":{\"crm_index\":0,\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0}},\"crm_makeup\":{\"crm_blush\":{\"crm_index\":0,\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0},\"crm_lipstick\":{\"crm_index\":0,\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0},\"crm_makeup\":{\"crm_index\":0,\"crm_color\":0,\"crm_opacity\":0,\"crm_secondary_color\":0}},\"crm_skin\":{\"crm_body_blemishes\":{\"crm_opacity\":0,\"crm_index\":0},\"crm_moles_freckles\":{\"crm_opacity\":0,\"crm_index\":0},\"crm_blemishes\":{\"crm_opacity\":0,\"crm_index\":0},\"crm_ageing\":{\"crm_opacity\":0,\"crm_index\":0},\"crm_complexion\":{\"crm_opacity\":0,\"crm_index\":0},\"crm_sun_damage\":{\"crm_opacity\":0,\"crm_index\":0}},\"crm_accessories\":[{\"crm_style\":-1,\"crm_id\":0,\"crm_texture\":-1},{\"crm_style\":-1,\"crm_id\":1,\"crm_texture\":-1},{\"crm_style\":-1,\"crm_id\":2,\"crm_texture\":-1},{\"crm_style\":-1,\"crm_id\":6,\"crm_texture\":-1},{\"crm_style\":-1,\"crm_id\":7,\"crm_texture\":-1}],\"crm_inheritance\":{\"crm_mix_race\":0.0,\"crm_father_face\":0,\"crm_mother_face\":0,\"crm_father_skin\":0,\"crm_mix_skin\":0.0,\"crm_mix_face\":0.0,\"crm_mother_race\":0,\"crm_mother_skin\":0,\"crm_father_race\":0}}', 1);
INSERT INTO `playerskins` (`id`, `citizenid`, `model`, `skin`, `active`) VALUES
(5, 'QCC38898', 'mp_m_freemode_01', '{\"crm_face\":{\"crm_ch_length\":0.0,\"crm_no_width\":0.0,\"crm_em_eyes_opening\":0.0,\"crm_ey_height\":0.0,\"crm_ja_width\":0.0,\"crm_no_peak_height\":0.0,\"crm_ch_bone_height\":0.0,\"crm_ch_bone_width\":0.0,\"crm_no_bone_twist\":0.0,\"crm_ey_depth\":0.0,\"crm_no_bone_height\":0.0,\"crm_ch_width\":0.0,\"crm_no_height\":0.0,\"crm_ch_size\":0.0,\"crm_ne_thickness\":0.0,\"crm_ch_hole_size\":0.0,\"crm_eye_color\":0,\"crm_ja_size\":0.0,\"crm_no_size\":0.0,\"crm_ch_lowering\":0.0,\"crm_em_lip_thickness\":0.0},\"crm_clothing\":[{\"crm_style\":0,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":0,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":1,\"crm_texture\":0},{\"crm_style\":15,\"crm_id\":3,\"crm_texture\":0},{\"crm_style\":19,\"crm_id\":4,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":5,\"crm_texture\":0},{\"crm_style\":34,\"crm_id\":6,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":7,\"crm_texture\":0},{\"crm_style\":15,\"crm_id\":8,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":9,\"crm_texture\":0},{\"crm_style\":0,\"crm_id\":10,\"crm_texture\":0},{\"crm_style\":18,\"crm_id\":11,\"crm_texture\":0}],\"crm_model\":\"mp_m_freemode_01\",\"crm_makeup\":{\"crm_blush\":{\"crm_opacity\":0,\"crm_color\":0,\"crm_index\":0,\"crm_secondary_color\":0},\"crm_lipstick\":{\"crm_opacity\":0,\"crm_color\":0,\"crm_index\":0,\"crm_secondary_color\":0},\"crm_makeup\":{\"crm_opacity\":0,\"crm_color\":0,\"crm_index\":0,\"crm_secondary_color\":0}},\"crm_hair\":{\"crm_hair\":{\"crm_index\":3,\"crm_color\":0,\"crm_secondary_color\":0,\"crm_texture\":0},\"crm_facial_hair\":{\"crm_opacity\":0,\"crm_color\":0,\"crm_index\":0,\"crm_secondary_color\":0},\"crm_eyebrows\":{\"crm_opacity\":0,\"crm_color\":0,\"crm_index\":0,\"crm_secondary_color\":0},\"crm_chest_hair\":{\"crm_opacity\":0,\"crm_color\":0,\"crm_index\":0,\"crm_secondary_color\":0}},\"crm_inheritance\":{\"crm_mix_race\":0.0,\"crm_father_face\":0,\"crm_mother_face\":0,\"crm_father_skin\":0,\"crm_mix_skin\":0.0,\"crm_mix_face\":0.0,\"crm_mother_race\":0,\"crm_mother_skin\":0,\"crm_father_race\":0},\"crm_skin\":{\"crm_body_blemishes\":{\"crm_index\":0,\"crm_opacity\":0},\"crm_complexion\":{\"crm_index\":0,\"crm_opacity\":0},\"crm_blemishes\":{\"crm_index\":0,\"crm_opacity\":0},\"crm_moles_freckles\":{\"crm_index\":0,\"crm_opacity\":0},\"crm_ageing\":{\"crm_index\":0,\"crm_opacity\":0},\"crm_sun_damage\":{\"crm_index\":0,\"crm_opacity\":0}},\"crm_accessories\":[{\"crm_style\":-1,\"crm_id\":0,\"crm_texture\":-1},{\"crm_style\":-1,\"crm_id\":1,\"crm_texture\":-1},{\"crm_style\":-1,\"crm_id\":2,\"crm_texture\":-1},{\"crm_style\":-1,\"crm_id\":6,\"crm_texture\":-1},{\"crm_style\":-1,\"crm_id\":7,\"crm_texture\":-1}]}', 1);
























































/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;