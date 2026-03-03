-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 03, 2026 at 06:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nagorik_sheba_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `complaint_no` varchar(30) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `priority` enum('low','medium','high','urgent') NOT NULL DEFAULT 'medium',
  `status` enum('pending','in_review','assigned','in_progress','on_hold','resolved','rejected','closed') NOT NULL DEFAULT 'pending',
  `division_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `upazila_id` bigint(20) UNSIGNED DEFAULT NULL,
  `police_station_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ward_no` varchar(20) DEFAULT NULL,
  `address_line` varchar(255) DEFAULT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `complainant_name` varchar(120) NOT NULL,
  `complainant_phone` varchar(20) NOT NULL,
  `complainant_email` varchar(255) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `assigned_to` bigint(20) UNSIGNED DEFAULT NULL,
  `assigned_at` timestamp NULL DEFAULT NULL,
  `admin_remark` text DEFAULT NULL,
  `action_taken` text DEFAULT NULL,
  `rejected_reason` text DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `closed_at` timestamp NULL DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `is_anonymous` tinyint(1) NOT NULL DEFAULT 0,
  `source` varchar(20) NOT NULL DEFAULT 'web',
  `submitted_ip` varchar(45) DEFAULT NULL,
  `submitted_user_agent` text DEFAULT NULL,
  `submitted_device` varchar(255) DEFAULT NULL,
  `submitted_platform` varchar(255) DEFAULT NULL,
  `submitted_browser` varchar(255) DEFAULT NULL,
  `is_edited` tinyint(1) NOT NULL DEFAULT 0,
  `is_deleted_by_user` tinyint(1) NOT NULL DEFAULT 0,
  `is_spam` tinyint(1) NOT NULL DEFAULT 0,
  `is_duplicate` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `complaint_no`, `user_id`, `category_id`, `sub_category_id`, `title`, `description`, `priority`, `status`, `division_id`, `district_id`, `upazila_id`, `police_station_id`, `ward_no`, `address_line`, `landmark`, `latitude`, `longitude`, `complainant_name`, `complainant_phone`, `complainant_email`, `attachment`, `attachments`, `assigned_to`, `assigned_at`, `admin_remark`, `action_taken`, `rejected_reason`, `resolved_at`, `closed_at`, `is_public`, `is_anonymous`, `source`, `submitted_ip`, `submitted_user_agent`, `submitted_device`, `submitted_platform`, `submitted_browser`, `is_edited`, `is_deleted_by_user`, `is_spam`, `is_duplicate`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'CMP-20260303-KG0KDM', 1, 1, 2, 'Road Trasnport Broken', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'medium', 'pending', 1, 11, 98, 104, '5', 'House Road', 'Market', 22.4741356, 92.0726395, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-03 05:27:23', '2026-03-03 05:27:23', NULL),
(2, 'CMP-20260303-AWYBK2', 1, 2, 10, 'Water Supply Problem', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'medium', 'in_review', 2, 14, 123, 283, '9', 'House Road', 'Market', 24.4693381, 88.9621353, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-03 05:28:13', '2026-03-03 05:28:13', NULL),
(3, 'CMP-20260303-2MYABP', 1, 3, 15, 'Electricity Requent Load SHedding', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'high', 'assigned', 3, 24, 193, 183, '21', 'House Road', 'Bazar', 22.7905443, 89.4839859, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-03 05:29:32', '2026-03-03 05:29:32', NULL),
(4, 'CMP-20260303-ESEFRF', 1, 4, 16, 'Drainage & Sewerage Blocked Drain', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'urgent', 'in_progress', 4, 35, 266, 248, '12', 'House Road', 'Near School', 22.7039094, 90.3697157, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-03 05:31:57', '2026-03-03 05:31:57', NULL),
(5, 'CMP-20260303-ZMTRIN', 1, 6, 27, 'Street Light Borken Pole Light', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'low', 'on_hold', 5, 38, 299, NULL, '11', 'House Road', 'Near Station', 24.3897852, 91.4135885, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-03 05:32:57', '2026-03-03 05:32:57', NULL),
(6, 'CMP-20260303-RR6UHX', 1, 7, 33, 'Environment Tree Cutting', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'urgent', 'resolved', 6, 41, 318, NULL, '12', 'House Road', 'Near Bazar Road', 24.0741298, 90.2105856, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-03 05:33:51', '2026-03-03 05:33:51', NULL),
(7, 'CMP-20260303-DZU6UC', 1, 8, 35, 'Illegal Contruction Unauthorized Building', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'high', 'rejected', 7, 60, 456, 361, '21', 'House Road', 'Near Masjid', 24.8425542, 89.3485880, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-03 05:34:57', '2026-03-03 05:34:57', NULL),
(8, 'CMP-20260303-MIIHUK', 1, 10, 48, 'Public Safety Dangerus Building', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'high', 'closed', 8, 63, 481, NULL, '2', 'House Road', 'Near Mondir', 24.9096757, 89.9495745, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-03 05:36:00', '2026-03-03 05:36:00', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `complaints_complaint_no_unique` (`complaint_no`),
  ADD KEY `complaints_user_id_foreign` (`user_id`),
  ADD KEY `complaints_category_id_foreign` (`category_id`),
  ADD KEY `complaints_sub_category_id_foreign` (`sub_category_id`),
  ADD KEY `complaints_district_id_foreign` (`district_id`),
  ADD KEY `complaints_upazila_id_foreign` (`upazila_id`),
  ADD KEY `complaints_police_station_id_foreign` (`police_station_id`),
  ADD KEY `complaints_status_priority_index` (`status`,`priority`),
  ADD KEY `complaints_division_id_district_id_index` (`division_id`,`district_id`),
  ADD KEY `complaints_assigned_to_status_index` (`assigned_to`,`status`),
  ADD KEY `complaints_created_at_index` (`created_at`),
  ADD KEY `complaints_complainant_phone_index` (`complainant_phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `complaints_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `complaints_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaints_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaints_police_station_id_foreign` FOREIGN KEY (`police_station_id`) REFERENCES `police_stations` (`id`),
  ADD CONSTRAINT `complaints_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `subcategories` (`id`),
  ADD CONSTRAINT `complaints_upazila_id_foreign` FOREIGN KEY (`upazila_id`) REFERENCES `upazilas` (`id`),
  ADD CONSTRAINT `complaints_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
