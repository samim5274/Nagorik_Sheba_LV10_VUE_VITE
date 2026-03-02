-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 02, 2026 at 10:35 AM
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
(1, 'CMP-20260302-X6W1X5', 2, 1, 2, 'Road Transport', 'asdfasdfasdfasdfasdfasdfasd', 'medium', 'pending', 1, 11, 98, 104, '4', 'Hosue, Road', 'Market', 21.9634249, 92.1093750, 'xyz', '01762164746', 'xyz1@gmail.com', NULL, '[{\"original_name\":\"472768562_1610480719553796_3253961327262953984_n.jpg\",\"file_name\":\"cf3722f6-ab61-4f25-b15c-0be0339d2ba5.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":1160816,\"path\":\"complaints\\/multiple\\/cf3722f6-ab61-4f25-b15c-0be0339d2ba5.jpg\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 06:31:07', '2026-03-02 06:31:07', NULL),
(2, 'CMP-20260302-8FKRKN', 2, 8, 36, 'Illegel Constrcution', 'asdfasdfasdfasdfasdfasdf', 'high', 'assigned', 1, 3, 29, 110, '3', 'Hoad', 'Market', 22.3275689, 91.8389225, 'xyz', '01762164746', 'xyz1@gmail.com', NULL, '[{\"original_name\":\"539126892_1966173547536119_1976713544307312783_n.jpg\",\"file_name\":\"2e1e4870-d7fe-479f-8432-04534f5e6c5f.jpg\",\"mime_type\":\"image\\/jpeg\",\"size\":472192,\"path\":\"complaints\\/multiple\\/2e1e4870-d7fe-479f-8432-04534f5e6c5f.jpg\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 06:55:42', '2026-03-02 06:55:42', NULL),
(3, 'CMP-20260302-EWGL50', 1, 4, 18, 'Draingage & Sewerage', 'asdfasdfasdfasdfasdfasdf', 'urgent', 'in_review', 4, 33, 251, 254, '05', 'House, Road', 'Bridge', 24.6777302, 89.9713862, 'xyz', '01762164747', 'xyz@gmail.com', NULL, '[{\"original_name\":\"avater.png\",\"file_name\":\"d9abe897-a7f8-43d8-b106-0138640002c8.png\",\"mime_type\":\"image\\/png\",\"size\":210038,\"path\":\"complaints\\/multiple\\/d9abe897-a7f8-43d8-b106-0138640002c8.png\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 07:42:53', '2026-03-02 07:42:53', NULL),
(4, 'CMP-20260302-YEINZ0', 1, 11, 53, 'Healt & Sanitation', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 'low', 'in_progress', 4, 34, 261, NULL, '8', 'House, Road', 'Near by School', 23.8814428, 90.3292465, 'xyz', '01762164747', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 08:22:05', '2026-03-02 08:22:05', NULL),
(5, 'CMP-20260302-MD48CG', 1, 10, 48, 'Public Safety', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 'medium', 'on_hold', 6, 48, 371, NULL, '8', 'House, Road', 'Near by Market', 23.8406255, 89.9505615, 'xyz', '01762164747', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 08:22:48', '2026-03-02 08:22:48', NULL),
(6, 'CMP-20260302-8NMPOR', 1, 9, 41, 'market & Bussiness', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 'high', 'resolved', 5, 39, 303, 229, '2', 'House Road', 'Near by Station', 25.0709450, 91.3990831, 'xyz', '01762164747', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 08:23:36', '2026-03-02 08:23:36', NULL),
(7, 'CMP-20260302-KRE844', 1, 7, 33, 'Environment', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 'urgent', 'rejected', 3, 20, 178, NULL, '90', 'House Road', 'Near Bazar', 22.3348335, 89.1348267, 'xyz', '01762164747', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 08:24:51', '2026-03-02 08:24:51', NULL),
(8, 'CMP-20260302-H78STK', 1, 6, 27, 'Street Light', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 'urgent', 'closed', 8, 63, 481, NULL, '3', 'House Road', 'Near Hospital', 24.9163314, 89.7061157, 'xyz', '01762164747', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 08:26:09', '2026-03-02 08:26:09', NULL),
(9, 'CMP-20260302-YPUGLU', 1, 5, 23, 'Waste Management', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 'high', 'pending', 1, 11, 98, 104, '91', 'House Road', 'Near Resort', 22.3712297, 92.2594929, 'xyz', '01762164747', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 08:26:52', '2026-03-02 08:26:52', NULL),
(10, 'CMP-20260302-EJNHOT', 1, 4, 20, 'Drainage & Sweereage', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 'medium', 'pending', 2, 18, 155, NULL, '32', 'House Roat', 'Near Bazar', 24.5963778, 88.2697821, 'xyz', '01762164747', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 08:27:38', '2026-03-02 08:27:38', NULL);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
