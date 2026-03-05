-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 05, 2026 at 09:45 AM
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
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `bn_name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `bn_name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Road & Transport', 'রাস্তা ও পরিবহন', 'road-transport', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(2, 'Water Supply', 'পানি সরবরাহ', 'water-supply', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(3, 'Electricity', 'বিদ্যুৎ', 'electricity', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(4, 'Drainage & Sewerage', 'ড্রেনেজ ও পয়ঃনিষ্কাশন', 'drainage-sewerage', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(5, 'Waste Management', 'বর্জ্য ব্যবস্থাপনা', 'waste-management', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(6, 'Street Light', 'স্ট্রিট লাইট', 'street-light', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(7, 'Environment', 'পরিবেশ', 'environment', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(8, 'Illegal Construction', 'অবৈধ নির্মাণ', 'illegal-construction', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(9, 'Market & Business', 'বাজার ও ব্যবসা', 'market-business', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(10, 'Public Safety', 'জননিরাপত্তা', 'public-safety', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(11, 'Health & Sanitation', 'স্বাস্থ্য ও স্যানিটেশন', 'health-sanitation', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(12, 'Others', 'অন্যান্য', 'others', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00');

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
  `complainant_phone` varchar(20) DEFAULT NULL,
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
(1, 'CMP-20260303-KG0KDM', 1, 1, 2, 'Road Trasnport Broken', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'medium', 'pending', 1, 11, 98, 104, '5', 'House Road', 'Market', 22.4741356, 92.0726395, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 11:27:23', '2026-03-02 11:27:23', NULL),
(2, 'CMP-20260303-AWYBK2', 1, 2, 10, 'Water Supply Problem', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'medium', 'in_review', 2, 14, 123, 283, '9', 'House Road', 'Market', 24.4693381, 88.9621353, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 11:28:13', '2026-03-02 11:28:13', NULL),
(3, 'CMP-20260303-2MYABP', 1, 3, 15, 'Electricity Requent Load SHedding', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'high', 'assigned', 3, 24, 193, 183, '21', 'House Road', 'Bazar', 22.7905443, 89.4839859, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 11:29:32', '2026-03-02 11:29:32', NULL),
(4, 'CMP-20260303-ESEFRF', 1, 4, 16, 'Drainage & Sewerage Blocked Drain', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'urgent', 'in_progress', 4, 35, 266, 248, '12', 'House Road', 'Near School', 22.7039094, 90.3697157, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 11:31:57', '2026-03-02 11:31:57', NULL),
(5, 'CMP-20260303-ZMTRIN', 1, 6, 27, 'Street Light Borken Pole Light', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'low', 'on_hold', 5, 38, 299, NULL, '11', 'House Road', 'Near Station', 24.3897852, 91.4135885, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 11:32:57', '2026-03-02 11:32:57', NULL),
(6, 'CMP-20260303-RR6UHX', 1, 7, 33, 'Environment Tree Cutting', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'urgent', 'resolved', 6, 41, 318, NULL, '12', 'House Road', 'Near Bazar Road', 24.0741298, 90.2105856, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 11:33:51', '2026-03-02 11:33:51', NULL),
(7, 'CMP-20260303-DZU6UC', 1, 8, 35, 'Illegal Contruction Unauthorized Building', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'high', 'rejected', 7, 60, 456, 361, '21', 'House Road', 'Near Masjid', 24.8425542, 89.3485880, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 11:34:57', '2026-03-02 11:34:57', NULL),
(8, 'CMP-20260303-MIIHUK', 1, 10, 48, 'Public Safety Dangerus Building', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'high', 'closed', 8, 63, 481, NULL, '2', 'House Road', 'Near Mondir', 24.9096757, 89.9495745, 'SAMIM-HosseN', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 11:36:00', '2026-03-02 11:36:00', NULL),
(9, 'CMP-20260303-TZNQ1C', 1, 2, 10, 'Water Supply', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc', 'medium', 'pending', 4, 34, 260, NULL, '2', 'House Road', 'Bazar', 23.8795592, 90.3731918, 'Samim Hossain', '01762164746', 'xyz@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'web', '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Linux', 'Firefox', 0, 0, 0, 0, '2026-03-02 18:12:54', '2026-03-02 18:12:54', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `complaint_activity_logs`
--

CREATE TABLE `complaint_activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `complaint_id` bigint(20) UNSIGNED NOT NULL,
  `actor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `activity_type` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complaint_attachments`
--

CREATE TABLE `complaint_attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `complaint_id` bigint(20) UNSIGNED NOT NULL,
  `uploaded_by` bigint(20) UNSIGNED DEFAULT NULL,
  `context_type` varchar(30) NOT NULL DEFAULT 'complaint',
  `context_id` bigint(20) UNSIGNED DEFAULT NULL,
  `original_name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_disk` varchar(30) NOT NULL DEFAULT 'public',
  `mime_type` varchar(100) NOT NULL,
  `file_extension` varchar(20) DEFAULT NULL,
  `file_size` bigint(20) UNSIGNED NOT NULL,
  `file_hash` varchar(64) DEFAULT NULL,
  `is_image` tinyint(1) NOT NULL DEFAULT 0,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `uploaded_ip` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complaint_comments`
--

CREATE TABLE `complaint_comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `complaint_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `comment` text NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `is_internal` tinyint(1) NOT NULL DEFAULT 0,
  `is_edited` tinyint(1) NOT NULL DEFAULT 0,
  `edited_at` timestamp NULL DEFAULT NULL,
  `edited_by` bigint(20) UNSIGNED DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `delete_reason` varchar(255) DEFAULT NULL,
  `comment_ip` varchar(45) DEFAULT NULL,
  `comment_user_agent` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `complaint_comments`
--

INSERT INTO `complaint_comments` (`id`, `complaint_id`, `user_id`, `parent_id`, `comment`, `is_admin`, `is_internal`, `is_edited`, `edited_at`, `edited_by`, `is_deleted`, `deleted_at`, `deleted_by`, `delete_reason`, `comment_ip`, `comment_user_agent`, `created_at`, `updated_at`) VALUES
(44, 9, 1, NULL, 'hi', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:14:56', '2026-03-05 08:14:56'),
(45, 8, 1, NULL, 'dsefe', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:15:04', '2026-03-05 08:15:04'),
(46, 8, 1, NULL, 'fthfdt', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:15:06', '2026-03-05 08:15:06'),
(47, 8, 1, NULL, 'sderfsef', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:15:07', '2026-03-05 08:15:07'),
(48, 8, 1, NULL, 'sefasef', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:15:08', '2026-03-05 08:15:08'),
(49, 8, 1, NULL, 'asfsefs', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:15:09', '2026-03-05 08:15:09'),
(50, 6, 1, NULL, 'Nice', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:15:43', '2026-03-05 08:15:43'),
(51, 9, 2, NULL, 'Hello', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:17:53', '2026-03-05 08:17:53'),
(52, 8, 2, NULL, 'Hello', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:17:57', '2026-03-05 08:17:57'),
(53, 8, 2, NULL, 'de', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:18:13', '2026-03-05 08:18:13'),
(54, 7, 2, NULL, 'Na na', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:18:22', '2026-03-05 08:18:22'),
(55, 7, 2, NULL, 'nana', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:18:23', '2026-03-05 08:18:23'),
(56, 9, 1, NULL, 'Development Project', 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0', '2026-03-05 08:24:13', '2026-03-05 08:24:13');

-- --------------------------------------------------------

--
-- Table structure for table `complaint_comment_reactions`
--

CREATE TABLE `complaint_comment_reactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reaction_type` enum('like','dislike','helpful','support','resolved') NOT NULL DEFAULT 'like',
  `reacted_ip` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complaint_edit_logs`
--

CREATE TABLE `complaint_edit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `complaint_id` bigint(20) UNSIGNED NOT NULL,
  `edited_by` bigint(20) UNSIGNED DEFAULT NULL,
  `field_name` varchar(100) NOT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `edit_reason` varchar(255) DEFAULT NULL,
  `edited_ip` varchar(45) DEFAULT NULL,
  `edited_user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complaint_reactions`
--

CREATE TABLE `complaint_reactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `complaint_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('like','dislike') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `complaint_reactions`
--

INSERT INTO `complaint_reactions` (`id`, `complaint_id`, `user_id`, `type`, `created_at`, `updated_at`) VALUES
(22, 6, 1, 'dislike', '2026-03-03 07:39:06', '2026-03-03 07:48:25'),
(24, 4, 1, 'like', '2026-03-03 07:39:10', '2026-03-03 07:48:08'),
(37, 5, 1, 'dislike', '2026-03-03 07:48:06', '2026-03-03 07:48:23'),
(40, 3, 1, 'like', '2026-03-03 07:48:14', '2026-03-03 07:48:14'),
(46, 7, 2, 'like', '2026-03-03 07:49:24', '2026-03-03 08:27:29'),
(53, 8, 1, 'dislike', '2026-03-03 08:24:05', '2026-03-05 04:55:43'),
(57, 2, 2, 'like', '2026-03-03 08:25:51', '2026-03-03 08:25:51'),
(58, 1, 2, 'like', '2026-03-03 08:25:56', '2026-03-03 08:25:56'),
(60, 3, 2, 'dislike', '2026-03-03 08:26:03', '2026-03-03 08:26:03'),
(62, 8, 2, 'dislike', '2026-03-03 08:26:49', '2026-03-03 08:27:26'),
(63, 5, 2, 'like', '2026-03-03 08:26:53', '2026-03-03 08:26:53'),
(66, 9, 2, 'like', '2026-03-03 08:27:24', '2026-03-03 08:27:24'),
(67, 6, 2, 'like', '2026-03-03 08:27:32', '2026-03-03 08:27:32'),
(68, 4, 2, 'dislike', '2026-03-03 08:27:35', '2026-03-03 08:27:35'),
(70, 1, 1, 'dislike', '2026-03-03 08:27:51', '2026-03-03 08:27:51'),
(72, 7, 1, 'like', '2026-03-03 08:32:50', '2026-03-03 08:32:51'),
(82, 2, 1, 'dislike', '2026-03-03 08:34:33', '2026-03-03 08:34:33'),
(92, 9, 1, 'like', '2026-03-05 08:23:03', '2026-03-05 08:23:03');

-- --------------------------------------------------------

--
-- Table structure for table `complaint_status_logs`
--

CREATE TABLE `complaint_status_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `complaint_id` bigint(20) UNSIGNED NOT NULL,
  `old_status` varchar(30) DEFAULT NULL,
  `new_status` varchar(30) NOT NULL,
  `changed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `changed_ip` varchar(45) DEFAULT NULL,
  `changed_user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `districts`
--

CREATE TABLE `districts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `division_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `bn_name` varchar(255) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  `lon` decimal(10,7) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `districts`
--

INSERT INTO `districts` (`id`, `division_id`, `name`, `bn_name`, `lat`, `lon`, `url`, `created_at`, `updated_at`) VALUES
(1, 1, 'Comilla', 'কুমিল্লা', 23.4682747, 91.1788135, 'www.comilla.gov.bd', '2026-03-03 06:31:53', '2026-03-03 06:31:53'),
(2, 1, 'Feni', 'ফেনী', 23.0232310, 91.3840844, 'www.feni.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(3, 1, 'Brahmanbaria', 'ব্রাহ্মণবাড়িয়া', 23.9570904, 91.1119286, 'www.brahmanbaria.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(4, 1, 'Rangamati', 'রাঙ্গামাটি', 22.6556102, 92.1754112, 'www.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(5, 1, 'Noakhali', 'নোয়াখালী', 22.8695630, 91.0993980, 'www.noakhali.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(6, 1, 'Chandpur', 'চাঁদপুর', 23.2332585, 90.6712912, 'www.chandpur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(7, 1, 'Lakshmipur', 'লক্ষ্মীপুর', 22.9424770, 90.8411840, 'www.lakshmipur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(8, 1, 'Chattogram', 'চট্টগ্রাম', 22.3351090, 91.8340730, 'www.chittagong.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(9, 1, 'Coxsbazar', 'কক্সবাজার', 21.4431575, 91.9738174, 'www.coxsbazar.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(10, 1, 'Khagrachhari', 'খাগড়াছড়ি', 23.1192850, 91.9846630, 'www.khagrachhari.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(11, 1, 'Bandarban', 'বান্দরবান', 22.1953275, 92.2183773, 'www.bandarban.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(12, 2, 'Sirajganj', 'সিরাজগঞ্জ', 24.4533978, 89.7006815, 'www.sirajganj.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(13, 2, 'Pabna', 'পাবনা', 23.9985240, 89.2336450, 'www.pabna.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(14, 2, 'Bogura', 'বগুড়া', 24.8465228, 89.3777550, 'www.bogra.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(15, 2, 'Rajshahi', 'রাজশাহী', 24.3723030, 88.5630762, 'www.rajshahi.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(16, 2, 'Natore', 'নাটোর', 24.4205560, 89.0002820, 'www.natore.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(17, 2, 'Joypurhat', 'জয়পুরহাট', 25.0963688, 89.0400428, 'www.joypurhat.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(18, 2, 'Chapainawabganj', 'চাঁপাইনবাবগঞ্জ', 24.5965034, 88.2775122, 'www.chapainawabganj.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(19, 2, 'Naogaon', 'নওগাঁ', 24.8325619, 88.9248521, 'www.naogaon.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(20, 3, 'Jashore', 'যশোর', 23.1664300, 89.2081126, 'www.jessore.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(21, 3, 'Satkhira', 'সাতক্ষীরা', 22.7180905, 89.0687033, 'www.satkhira.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(22, 3, 'Meherpur', 'মেহেরপুর', 23.7622130, 88.6318210, 'www.meherpur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(23, 3, 'Narail', 'নড়াইল', 23.1725340, 89.5126720, 'www.narail.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(24, 3, 'Chuadanga', 'চুয়াডাঙ্গা', 23.6401961, 88.8418410, 'www.chuadanga.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(25, 3, 'Kushtia', 'কুষ্টিয়া', 23.9012580, 89.1204820, 'www.kushtia.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(26, 3, 'Magura', 'মাগুরা', 23.4873370, 89.4199560, 'www.magura.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(27, 3, 'Khulna', 'খুলনা', 22.8157740, 89.5686790, 'www.khulna.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(28, 3, 'Bagerhat', 'বাগেরহাট', 22.6515680, 89.7859380, 'www.bagerhat.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(29, 3, 'Jhenaidah', 'ঝিনাইদহ', 23.5448176, 89.1539213, 'www.jhenaidah.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(30, 4, 'Jhalakathi', 'ঝালকাঠি', 22.6422689, 90.2003932, 'www.jhalakathi.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(31, 4, 'Patuakhali', 'পটুয়াখালী', 22.3596316, 90.3298712, 'www.patuakhali.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(32, 4, 'Pirojpur', 'পিরোজপুর', 22.5781398, 89.9983909, 'www.pirojpur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(33, 4, 'Barisal', 'বরিশাল', 22.7004179, 90.3731568, 'www.barisal.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(34, 4, 'Bhola', 'ভোলা', 22.6859230, 90.6481790, 'www.bhola.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(35, 4, 'Barguna', 'বরগুনা', 22.1591820, 90.1255810, 'www.barguna.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(36, 5, 'Sylhet', 'সিলেট', 24.8897956, 91.8697894, 'www.sylhet.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(37, 5, 'Moulvibazar', 'মৌলভীবাজার', 24.4829340, 91.7774170, 'www.moulvibazar.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(38, 5, 'Habiganj', 'হবিগঞ্জ', 24.3749450, 91.4155300, 'www.habiganj.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(39, 5, 'Sunamganj', 'সুনামগঞ্জ', 25.0658042, 91.3950115, 'www.sunamganj.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(40, 6, 'Narsingdi', 'নরসিংদী', 23.9322330, 90.7154100, 'www.narsingdi.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(41, 6, 'Gazipur', 'গাজীপুর', 24.0022858, 90.4264283, 'www.gazipur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(42, 6, 'Shariatpur', 'শরীয়তপুর', 23.2060195, 90.3477725, 'www.shariatpur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(43, 6, 'Narayanganj', 'নারায়ণগঞ্জ', 23.6336600, 90.4964820, 'www.narayanganj.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(44, 6, 'Tangail', 'টাঙ্গাইল', 24.2641450, 89.9180290, 'www.tangail.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(45, 6, 'Kishoreganj', 'কিশোরগঞ্জ', 24.4449370, 90.7765750, 'www.kishoreganj.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(46, 6, 'Manikganj', 'মানিকগঞ্জ', 23.8602262, 90.0018293, 'www.manikganj.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(47, 6, 'Dhaka', 'ঢাকা', 23.7115253, 90.4111451, 'www.dhaka.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(48, 6, 'Munshiganj', 'মুন্সিগঞ্জ', 23.5435742, 90.5354327, 'www.munshiganj.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(49, 6, 'Rajbari', 'রাজবাড়ী', 23.7574305, 89.6444665, 'www.rajbari.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(50, 6, 'Madaripur', 'মাদারীপুর', 23.1641020, 90.1896805, 'www.madaripur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(51, 6, 'Gopalganj', 'গোপালগঞ্জ', 23.0050857, 89.8266059, 'www.gopalganj.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(52, 6, 'Faridpur', 'ফরিদপুর', 23.6070822, 89.8429406, 'www.faridpur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(53, 7, 'Panchagarh', 'পঞ্চগড়', 26.3411000, 88.5541606, 'www.panchagarh.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(54, 7, 'Dinajpur', 'দিনাজপুর', 25.6217061, 88.6354504, 'www.dinajpur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(55, 7, 'Lalmonirhat', 'লালমনিরহাট', 25.9165451, 89.4532409, 'www.lalmonirhat.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(56, 7, 'Nilphamari', 'নীলফামারী', 25.9317940, 88.8560060, 'www.nilphamari.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(57, 7, 'Gaibandha', 'গাইবান্ধা', 25.3287510, 89.5280880, 'www.gaibandha.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(58, 7, 'Thakurgaon', 'ঠাকুরগাঁও', 26.0336945, 88.4616834, 'www.thakurgaon.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(59, 7, 'Rangpur', 'রংপুর', 25.7558096, 89.2444620, 'www.rangpur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(60, 7, 'Kurigram', 'কুড়িগ্রাম', 25.8054450, 89.6361740, 'www.kurigram.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(61, 8, 'Sherpur', 'শেরপুর', 25.0204933, 90.0152966, 'www.sherpur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(62, 8, 'Mymensingh', 'ময়মনসিংহ', 24.7465670, 90.4072093, 'www.mymensingh.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(63, 8, 'Jamalpur', 'জামালপুর', 24.9375330, 89.9377750, 'www.jamalpur.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(64, 8, 'Netrokona', 'নেত্রকোণা', 24.8709550, 90.7278870, 'www.netrokona.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54');

-- --------------------------------------------------------

--
-- Table structure for table `divisions`
--

CREATE TABLE `divisions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `bn_name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `divisions`
--

INSERT INTO `divisions` (`id`, `name`, `bn_name`, `url`, `created_at`, `updated_at`) VALUES
(1, 'Chattagram', 'চট্টগ্রাম', 'www.chittagongdiv.gov.bd', '2026-03-03 06:31:53', '2026-03-03 06:31:53'),
(2, 'Rajshahi', 'রাজশাহী', 'www.rajshahidiv.gov.bd', '2026-03-03 06:31:53', '2026-03-03 06:31:53'),
(3, 'Khulna', 'খুলনা', 'www.khulnadiv.gov.bd', '2026-03-03 06:31:53', '2026-03-03 06:31:53'),
(4, 'Barisal', 'বরিশাল', 'www.barisaldiv.gov.bd', '2026-03-03 06:31:53', '2026-03-03 06:31:53'),
(5, 'Sylhet', 'সিলেট', 'www.sylhetdiv.gov.bd', '2026-03-03 06:31:53', '2026-03-03 06:31:53'),
(6, 'Dhaka', 'ঢাকা', 'www.dhakadiv.gov.bd', '2026-03-03 06:31:53', '2026-03-03 06:31:53'),
(7, 'Rangpur', 'রংপুর', 'www.rangpurdiv.gov.bd', '2026-03-03 06:31:53', '2026-03-03 06:31:53'),
(8, 'Mymensingh', 'ময়মনসিংহ', 'www.mymensinghdiv.gov.bd', '2026-03-03 06:31:53', '2026-03-03 06:31:53');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2026_02_24_121610_create_divisions_table', 1),
(6, '2026_02_24_121611_create_districts_table', 1),
(7, '2026_02_24_121611_create_upazilas_table', 1),
(8, '2026_02_24_121612_create_police_stations_table', 1),
(9, '2026_02_25_122711_create_categories_table', 1),
(10, '2026_02_25_122720_create_subcategories_table', 1),
(11, '2026_02_25_125331_create_complaints_table', 1),
(12, '2026_02_25_125332_create_complaint_reactions_table', 1),
(13, '2026_02_25_125526_create_complaint_status_logs_table', 1),
(14, '2026_02_25_125624_create_complaint_comments_table', 1),
(15, '2026_02_25_125719_create_complaint_comment_reactions_table', 1),
(16, '2026_02_25_125800_create_complaint_attachments_table', 1),
(17, '2026_02_25_125908_create_complaint_edit_logs_table', 1),
(18, '2026_02_25_125942_create_complaint_activity_logs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(10, 'App\\Models\\User', 1, 'web', '6f288a7f5dfa3a8f33f91c1c6b85ec057509e8aaf2fe34ed7866c9358a5bd6cc', '[\"*\"]', '2026-03-05 08:44:53', NULL, '2026-03-05 08:18:32', '2026-03-05 08:44:53');

-- --------------------------------------------------------

--
-- Table structure for table `police_stations`
--

CREATE TABLE `police_stations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `division_id` bigint(20) UNSIGNED DEFAULT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `upazila_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `bn_name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `police_stations`
--

INSERT INTO `police_stations` (`id`, `division_id`, `district_id`, `upazila_id`, `name`, `bn_name`, `url`, `created_at`, `updated_at`) VALUES
(1, 6, 47, NULL, 'Demra', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(2, 6, 47, NULL, 'Dhaka Cantt.', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(3, 6, 47, 366, 'Dhamrai', 'ধামরাই', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(4, 6, 47, NULL, 'Dhanmondi', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(5, 6, 47, NULL, 'Gulshan', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(6, 6, 47, NULL, 'Jatrabari', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(7, 6, 47, NULL, 'Joypara', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(8, 6, 47, 367, 'Keraniganj', 'কেরাণীগঞ্জ', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(9, 6, 47, NULL, 'Khilgaon', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(10, 6, 47, NULL, 'Khilkhet', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(11, 6, 47, NULL, 'Lalbag', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(12, 6, 47, NULL, 'Mirpur', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(13, 6, 47, NULL, 'Mohammadpur', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(14, 6, 47, NULL, 'Motijheel', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(15, 6, 47, 368, 'Nawabganj', 'নবাবগঞ্জ', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(16, 6, 47, NULL, 'New market', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(17, 6, 47, NULL, 'Palton', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(18, 6, 47, NULL, 'Ramna', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(19, 6, 47, NULL, 'Sabujbag', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(20, 6, 47, 365, 'Savar', 'সাভার', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(21, 6, 47, NULL, 'Sutrapur', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(22, 6, 47, NULL, 'Tejgaon', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(23, 6, 47, NULL, 'Tejgaon Industrial Area', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(24, 6, 47, NULL, 'Uttara', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(25, 6, 52, 391, 'Alfadanga', 'আলফাডাঙ্গা', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(26, 6, 52, 395, 'Bhanga', 'ভাঙ্গা', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(27, 6, 52, 392, 'Boalmari', 'বোয়ালমারী', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(28, 6, 52, 396, 'Charbhadrasan', 'চরভদ্রাসন', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(29, 6, 52, 390, 'Faridpur Sadar', 'ফরিদপুর সদর', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(30, 6, 52, NULL, 'Madukhali', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(31, 6, 52, 394, 'Nagarkanda', 'নগরকান্দা', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(32, 6, 52, 393, 'Sadarpur', 'সদরপুর', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(33, 6, 52, NULL, 'Shriangan', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(34, 6, 41, 320, 'Gazipur Sadar', 'গাজীপুর সদর', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(35, 6, 41, NULL, 'Kaliakaar', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(36, 6, 41, 317, 'Kaliganj', 'কালীগঞ্জ', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(37, 6, 41, NULL, 'Kapashia', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(38, 6, 41, NULL, 'Monnunagar', NULL, NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(39, 6, 41, 321, 'Sreepur', 'শ্রীপুর', NULL, '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(40, 6, 41, NULL, 'Sripur', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(41, 6, 51, 385, 'Gopalganj Sadar', 'গোপালগঞ্জ সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(42, 6, 51, 386, 'Kashiani', 'কাশিয়ানী', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(43, 6, 51, 388, 'Kotalipara', 'কোটালীপাড়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(44, 6, 51, NULL, 'Maksudpur', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(45, 6, 51, 387, 'Tungipara', 'টুংগীপাড়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(46, 6, 45, 354, 'Bajitpur', 'বাজিতপুর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(47, 6, 45, NULL, 'Bhairob', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(48, 6, 45, NULL, 'Hossenpur', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(49, 6, 45, 345, 'Itna', 'ইটনা', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(50, 6, 45, NULL, 'Karimganj', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(51, 6, 45, 346, 'Katiadi', 'কটিয়াদী', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(52, 6, 45, 352, 'Kishoreganj Sadar', 'কিশোরগঞ্জ সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(53, 6, 45, 351, 'Kuliarchar', 'কুলিয়ারচর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(54, 6, 45, 356, 'Mithamoin', 'মিঠামইন', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(55, 6, 45, 357, 'Nikli', 'নিকলী', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(56, 6, 45, NULL, 'Ostagram', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(57, 6, 45, 350, 'Pakundia', 'পাকুন্দিয়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(58, 6, 45, NULL, 'Tarial', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(59, 6, 50, NULL, 'Barhamganj', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(60, 6, 50, 383, 'kalkini', 'কালকিনি', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(61, 6, 50, 381, 'Madaripur Sadar', 'মাদারীপুর সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(62, 6, 50, 384, 'Rajoir', 'রাজৈর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(63, 6, 46, 363, 'Doulatpur', 'দৌলতপুর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(64, 6, 46, NULL, 'Gheor', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(65, 6, 46, NULL, 'Lechhraganj', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(66, 6, 46, 360, 'Manikganj Sadar', 'মানিকগঞ্জ সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(67, 6, 46, 359, 'Saturia', 'সাটুরিয়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(68, 6, 46, NULL, 'Shibloya', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(69, 6, 46, NULL, 'Singari', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(70, 6, 48, 374, 'Gajaria', 'গজারিয়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(71, 6, 48, NULL, 'Lohajong', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(72, 6, 48, 370, 'Munshiganj Sadar', 'মুন্সিগঞ্জ সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(73, 6, 48, 372, 'Sirajdikhan', 'সিরাজদিখান', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(74, 6, 48, NULL, 'Srinagar', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(75, 6, 48, NULL, 'Tangibari', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(76, 6, 43, 328, 'Araihazar', 'আড়াইহাজার', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(77, 6, 43, NULL, 'Baidder Bazar', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(78, 6, 43, 329, 'Bandar', 'বন্দর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(79, 6, 43, NULL, 'Fatullah', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(80, 6, 43, 330, 'Narayanganj Sadar', 'নারায়নগঞ্জ সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(81, 6, 43, 331, 'Rupganj', 'রূপগঞ্জ', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(82, 6, 43, NULL, 'Siddirganj', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(83, 6, 49, 379, 'Baliakandi', 'বালিয়াকান্দি', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(84, 6, 49, NULL, 'Pangsha', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(85, 6, 49, 376, 'Rajbari Sadar', 'রাজবাড়ী সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(86, 6, 42, NULL, 'Bhedorganj', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(87, 6, 42, NULL, 'Damudhya', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(88, 6, 42, 325, 'Gosairhat', 'গোসাইরহাট', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(89, 6, 42, NULL, 'Jajira', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(90, 6, 42, 323, 'Naria', 'নড়িয়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(91, 6, 42, 322, 'Shariatpur Sadar', 'শরিয়তপুর সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(92, 6, 44, 333, 'Basail', 'বাসাইল', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(93, 6, 44, 334, 'Bhuapur', 'ভুয়াপুর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(94, 6, 44, 335, 'Delduar', 'দেলদুয়ার', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(95, 6, 44, 336, 'Ghatail', 'ঘাটাইল', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(96, 6, 44, 337, 'Gopalpur', 'গোপালপুর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(97, 6, 44, 343, 'Kalihati', 'কালিহাতী', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(98, 6, 44, NULL, 'Kashkaolia', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(99, 6, 44, 338, 'Madhupur', 'মধুপুর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(100, 6, 44, 339, 'Mirzapur', 'মির্জাপুর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(101, 6, 44, 340, 'Nagarpur', 'নাগরপুর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(102, 6, 44, 341, 'Sakhipur', 'সখিপুর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(103, 6, 44, 342, 'Tangail Sadar', 'টাঙ্গাইল সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(104, 1, 11, 98, 'Alikadam', 'আলীকদম', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(105, 1, 11, 97, 'Bandarban Sadar', 'বান্দরবান সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(106, 1, 11, 99, 'Naikhong', 'নাইক্ষ্যংছড়ি', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(107, 1, 11, NULL, 'Roanchhari', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(108, 1, 11, 102, 'Ruma', 'রুমা', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(109, 1, 11, 103, 'Thanchi', 'থানচি', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(110, 1, 3, 29, 'Akhaura', 'আখাউড়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(111, 1, 3, NULL, 'Banchharampur', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(112, 1, 3, NULL, 'Brahamanbaria Sadar', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(113, 1, 3, 25, 'Kasba', 'কসবা', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(114, 1, 3, 30, 'Nabinagar', 'নবীনগর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(115, 1, 3, 26, 'Nasirnagar', 'নাসিরনগর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(116, 1, 3, 27, 'Sarail', 'সরাইল', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(117, 1, 6, 55, 'Chandpur Sadar', 'চাঁদপুর সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(118, 1, 6, NULL, 'Faridganj', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(119, 1, 6, 57, 'Hajiganj', 'হাজীগঞ্জ', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(120, 1, 6, NULL, 'Hayemchar', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(121, 1, 6, 53, 'Kachua', 'কচুয়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(122, 1, 6, NULL, 'Matlobganj', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(123, 1, 6, 54, 'Shahrasti', 'শাহরাস্তি	', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(124, 1, 8, NULL, 'Anawara', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(125, 1, 8, 71, 'Boalkhali', 'বোয়ালখালী', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(126, 1, 8, NULL, 'Chittagong Sadar', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(127, 1, 8, NULL, 'East Joara', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(128, 1, 8, 77, 'Fatikchhari', 'ফটিকছড়ি', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(129, 1, 8, 76, 'Hathazari', 'হাটহাজারী', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(130, 1, 8, NULL, 'Jaldi', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(131, 1, 8, 75, 'Lohagara', 'লোহাগাড়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(132, 1, 8, 67, 'Mirsharai', 'মীরসরাই', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(133, 1, 8, NULL, 'Patia Head Office', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(134, 1, 8, 65, 'Rangunia', 'রাঙ্গুনিয়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(135, 1, 8, NULL, 'Rouzan', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(136, 1, 8, 69, 'Sandwip', 'সন্দ্বীপ', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(137, 1, 8, 74, 'Satkania', 'সাতকানিয়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(138, 1, 8, 66, 'Sitakunda', 'সীতাকুন্ড', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(139, 1, 1, 2, 'Barura', 'বরুড়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(140, 1, 1, 3, 'Brahmanpara', 'ব্রাহ্মণপাড়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(141, 1, 1, 16, 'Burichang', 'বুড়িচং', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(142, 1, 1, 4, 'Chandina', 'চান্দিনা', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(143, 1, 1, NULL, 'Chouddagram', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(144, 1, 1, 11, 'Comilla Sadar', 'কুমিল্লা সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(145, 1, 1, 6, 'Daudkandi', 'দাউদকান্দি', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(146, 1, 1, NULL, 'Davidhar', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(147, 1, 1, 7, 'Homna', 'হোমনা', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(148, 1, 1, 8, 'Laksam', 'লাকসাম', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(149, 1, 1, NULL, 'Langalkot', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(150, 1, 1, 9, 'Muradnagar', 'মুরাদনগর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(151, 1, 9, NULL, 'Chiringga', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(152, 1, 9, 80, 'Coxs Bazar Sadar', 'কক্সবাজার সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(153, 1, 9, NULL, 'Gorakghat', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(154, 1, 9, 82, 'Kutubdia', 'কুতুবদিয়া', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(155, 1, 9, 86, 'Ramu', 'রামু', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(156, 1, 9, 87, 'Teknaf', 'টেকনাফ', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(157, 1, 9, NULL, 'Ukhia', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(158, 1, 2, NULL, 'Chhagalnaia', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(159, 1, 2, NULL, 'Dagonbhuia', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(160, 1, 2, 19, 'Feni Sadar', 'ফেনী সদর', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(161, 1, 2, NULL, 'Pashurampur', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(162, 1, 2, 20, 'Sonagazi', 'সোনাগাজী', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(163, 1, 7, NULL, 'Char Alexgander', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(164, 1, 7, NULL, 'Lakshimpur Sadar', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(165, 1, 7, 64, 'Ramganj', 'রামগঞ্জ', NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(166, 1, 7, NULL, 'Raypur', NULL, NULL, '2026-03-03 06:31:58', '2026-03-03 06:31:58'),
(167, 1, 5, NULL, 'Basurhat', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(168, 1, 5, 45, 'Begumganj', 'বেগমগঞ্জ', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(169, 1, 5, 50, 'Chatkhil', 'চাটখিল', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(170, 1, 5, NULL, 'Hatiya', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(171, 1, 5, 43, 'Noakhali Sadar', 'নোয়াখালী সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(172, 1, 5, NULL, 'Senbag', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(173, 1, 4, NULL, 'Barakal', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(174, 1, 4, NULL, 'Bilaichhari', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(175, 1, 4, NULL, 'Jarachhari', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(176, 1, 4, NULL, 'Kalampati', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(177, 1, 4, 34, 'kaptai', 'কাপ্তাই', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(178, 1, 4, NULL, 'Longachh', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(179, 1, 4, NULL, 'Marishya', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(180, 1, 4, NULL, 'Naniachhar', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(181, 1, 4, NULL, 'Rajsthali', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(182, 1, 4, 33, 'Rangamati Sadar', 'রাঙ্গামাটি সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(183, 3, 24, 193, 'Alamdanga', 'আলমডাঙ্গা', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(184, 3, 24, 192, 'Chuadanga Sadar', 'চুয়াডাঙ্গা সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(185, 3, 24, 194, 'Damurhuda', 'দামুড়হুদা', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(186, 3, 24, NULL, 'Doulatganj', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(187, 3, 20, NULL, 'Bagharpara', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(188, 3, 20, NULL, 'Chaugachha', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(189, 3, 20, 177, 'Jessore Sadar', 'যশোর সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(190, 3, 20, NULL, 'Jhikargachha', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(191, 3, 20, 176, 'Keshabpur', 'কেশবপুর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(192, 3, 20, NULL, 'Monirampur', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(193, 3, 20, NULL, 'Noapara', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(194, 3, 20, NULL, 'Sarsa', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(195, 3, 27, NULL, 'Alaipur', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(196, 3, 27, NULL, 'Batiaghat', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(197, 3, 27, NULL, 'Chalna Bazar', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(198, 3, 27, NULL, 'Digalia', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(199, 3, 27, NULL, 'Khulna Sadar', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(200, 3, 27, NULL, 'Madinabad', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(201, 3, 27, NULL, 'Paikgachha', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(202, 3, 27, NULL, 'Phultala', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(203, 3, 27, NULL, 'Sajiara', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(204, 3, 27, NULL, 'Terakhada', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(205, 3, 26, NULL, 'Arpara', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(206, 3, 26, 204, 'Magura Sadar', 'মাগুরা সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(207, 3, 26, 205, 'Mohammadpur', 'মহম্মদপুর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(208, 3, 26, NULL, 'Shripur', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(209, 3, 22, 188, 'Gangni', 'গাংনী', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(210, 3, 22, 187, 'Meherpur Sadar', 'মেহেরপুর সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(211, 3, 23, 191, 'Kalia', 'কালিয়া', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(212, 3, 23, NULL, 'Laxmipasha', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(213, 3, 23, NULL, 'Mohajan', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(214, 3, 23, 189, 'Narail Sadar', 'নড়াইল সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(215, 3, 21, NULL, 'Ashashuni', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(216, 3, 21, NULL, 'Debbhata', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(217, 3, 21, 181, 'kalaroa', 'কলারোয়া', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(218, 3, 21, 185, 'Kaliganj UPO', 'কালিগঞ্জ', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(219, 3, 21, NULL, 'Nakipur', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(220, 3, 21, 182, 'Satkhira Sadar', 'সাতক্ষীরা সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(221, 3, 21, NULL, 'Taala', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(222, 5, 37, NULL, 'Baralekha', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(223, 5, 37, NULL, 'Kamalganj', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(224, 5, 37, 287, 'Kulaura', 'কুলাউড়া', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(225, 5, 37, 288, 'Moulvibazar Sadar', 'মৌলভীবাজার সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(226, 5, 37, 289, 'Rajnagar', 'রাজনগর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(227, 5, 37, NULL, 'Srimangal', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(228, 5, 39, NULL, 'Bishamsarpur', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(229, 5, 39, 303, 'Chhatak', 'ছাতক', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(230, 5, 39, NULL, 'Dhirai Chandpur', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(231, 5, 39, NULL, 'Duara bazar', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(232, 5, 39, NULL, 'Ghungiar', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(233, 5, 39, NULL, 'Jagnnathpur', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(234, 5, 39, NULL, 'Sachna', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(235, 5, 39, 300, 'Sunamganj Sadar', 'সুনামগঞ্জ সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(236, 5, 39, 306, 'Tahirpur', 'তাহিরপুর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(237, 5, 36, 272, 'Balaganj', 'বালাগঞ্জ', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(238, 5, 36, NULL, 'Bianibazar', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(239, 5, 36, 274, 'Bishwanath', 'বিশ্বনাথ', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(240, 5, 36, 276, 'Fenchuganj', 'ফেঞ্চুগঞ্জ', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(241, 5, 36, NULL, 'Goainhat', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(242, 5, 36, NULL, 'Gopalganj', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(243, 5, 36, NULL, 'Jaintapur', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(244, 5, 36, NULL, 'Jakiganj', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(245, 5, 36, 280, 'Kanaighat', 'কানাইঘাট', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(246, 5, 36, NULL, 'Kompanyganj', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(247, 5, 36, 281, 'Sylhet Sadar', 'সিলেট সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(248, 4, 35, 266, 'Amtali', 'আমতলী', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(249, 4, 35, 269, 'Bamna', 'বামনা', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(250, 4, 35, 267, 'Barguna Sadar', 'বরগুনা সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(251, 4, 35, 268, 'Betagi', 'বেতাগী', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(252, 4, 35, NULL, 'Patharghata', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(253, 4, 33, NULL, 'Agailzhara', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(254, 4, 33, 251, 'Babuganj', 'বাবুগঞ্জ', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(255, 4, 33, NULL, 'Barajalia', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(256, 4, 33, 249, 'Barishal Sadar', 'বরিশাল সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(257, 4, 33, NULL, 'Gouranadi', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(258, 4, 33, NULL, 'Mahendiganj', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(259, 4, 33, 257, 'Muladi', 'মুলাদী', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(260, 4, 33, NULL, 'Sahebganj', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(261, 4, 33, NULL, 'Uzirpur', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(262, 4, 34, 259, 'Bhola Sadar', 'ভোলা সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(263, 4, 34, NULL, 'Borhanuddin UPO', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(264, 4, 34, NULL, 'Charfashion', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(265, 4, 34, 262, 'Doulatkhan', 'দৌলতখান', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(266, 4, 34, NULL, 'Hajirhat', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(267, 4, 34, NULL, 'Hatshoshiganj', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(268, 4, 34, 265, 'Lalmohan UPO', 'লালমোহন', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(269, 4, 31, 234, 'Bauphal', 'বাউফল', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(270, 4, 31, 237, 'Dashmina', 'দশমিনা', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(271, 4, 31, 240, 'Galachipa', 'গলাচিপা', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(272, 4, 31, NULL, 'Khepupara', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(273, 4, 31, 235, 'Patuakhali Sadar', 'পটুয়াখালী সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(274, 4, 31, NULL, 'Subidkhali', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(275, 4, 32, NULL, 'Banaripara', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(276, 4, 32, 246, 'Bhandaria', 'ভান্ডারিয়া', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(277, 4, 32, NULL, 'kaukhali', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(278, 4, 32, 247, 'Mathbaria', 'মঠবাড়ীয়া', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(279, 4, 32, 243, 'Nazirpur', 'নাজিরপুর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(280, 4, 32, 242, 'Pirojpur Sadar', 'পিরোজপুর সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(281, 4, 32, NULL, 'Swarupkathi', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(282, 2, 14, NULL, 'Alamdighi', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(283, 2, 14, 123, 'Bogra Sadar', 'বগুড়া সদর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(284, 2, 14, NULL, 'Dhunat', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(285, 2, 14, NULL, 'Dupchachia', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(286, 2, 14, NULL, 'Gabtoli', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(287, 2, 14, NULL, 'Kahalu', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(288, 2, 14, NULL, 'Nandigram', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(289, 2, 14, NULL, 'Sariakandi', NULL, NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(290, 2, 14, 132, 'Sherpur', 'শেরপুর', NULL, '2026-03-03 06:31:59', '2026-03-03 06:31:59'),
(291, 2, 14, 133, 'Shibganj', 'শিবগঞ্জ', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(292, 2, 14, NULL, 'Sonatola', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(293, 2, 17, 150, 'Akkelpur', 'আক্কেলপুর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(294, 2, 17, 154, 'Joypurhat Sadar', 'জয়পুরহাট সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(295, 2, 17, 151, 'kalai', 'কালাই', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(296, 2, 17, 152, 'Khetlal', 'ক্ষেতলাল', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(297, 2, 17, 153, 'panchbibi', 'পাঁচবিবি', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(298, 2, 19, NULL, 'Ahsanganj', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(299, 2, 19, NULL, 'Badalgachhi', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(300, 2, 19, NULL, 'Dhamuirhat', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(301, 2, 19, NULL, 'Mahadebpur', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(302, 2, 19, 168, 'Naogaon Sadar', 'নওগাঁ সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(303, 2, 19, 164, 'Niamatpur', 'নিয়ামতপুর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(304, 2, 19, NULL, 'Nitpur', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(305, 2, 19, 162, 'Patnitala', 'পত্নিতলা', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(306, 2, 19, NULL, 'Prasadpur', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(307, 2, 19, 167, 'Raninagar', 'রাণীনগর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(308, 2, 19, 170, 'Sapahar', 'সাপাহার', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(309, 2, 16, NULL, 'Gopalpur UPO', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(310, 2, 16, NULL, 'Harua', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(311, 2, 16, 148, 'Hatgurudaspur', 'গুরুদাসপুর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(312, 2, 16, NULL, 'Laxman', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(313, 2, 16, 143, 'Natore Sadar', 'নাটোর সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(314, 2, 16, 144, 'Singra', 'সিংড়া', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(315, 2, 13, NULL, 'Banwarinagar', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(316, 2, 13, 117, 'Bera', 'বেড়া', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(317, 2, 13, 115, 'Bhangura', 'ভাঙ্গুড়া', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(318, 2, 13, 119, 'Chatmohar', 'চাটমোহর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(319, 2, 13, NULL, 'Debottar', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(320, 2, 13, NULL, 'Ishwardi', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(321, 2, 13, 116, 'Pabna Sadar', 'পাবনা সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(322, 2, 13, NULL, 'Sathia', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(323, 2, 13, 113, 'Sujanagar', 'সুজানগর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(324, 2, 15, 139, 'Bagha', 'বাঘা', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(325, 2, 15, NULL, 'Bhabaniganj', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(326, 2, 15, 137, 'Charghat', 'চারঘাট', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(327, 2, 15, 135, 'Durgapur', 'দুর্গাপুর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(328, 2, 15, 140, 'Godagari', 'গোদাগাড়ী', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(329, 2, 15, NULL, 'Khod Mohanpur', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(330, 2, 15, NULL, 'Lalitganj', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(331, 2, 15, NULL, 'Putia', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(332, 2, 15, NULL, 'Rajshahi Sadar', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(333, 2, 15, 141, 'Tanor', 'তানোর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(334, 2, 12, NULL, 'Baiddya Jam Toil', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(335, 2, 12, 104, 'Belkuchi', 'বেলকুচি', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(336, 7, 54, NULL, 'Bangla Hili', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(337, 7, 54, NULL, 'Biral', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(338, 7, 54, 407, 'Birampur', 'বিরামপুর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(339, 7, 54, 405, 'Birganj', 'বীরগঞ্জ', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(340, 7, 54, NULL, 'Chrirbandar', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(341, 7, 54, 412, 'Dinajpur Sadar', 'দিনাজপুর সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(342, 7, 54, 414, 'Khansama', 'খানসামা', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(343, 7, 54, NULL, 'Maharajganj', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(344, 7, 54, NULL, 'Nababganj', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(345, 7, 54, NULL, 'Osmanpur', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(346, 7, 54, 408, 'Parbatipur', 'পার্বতীপুর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(347, 7, 54, NULL, 'Phulbari', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(348, 7, 54, NULL, 'Setabganj', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(349, 7, 57, NULL, 'Bonarpara', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(350, 7, 57, 429, 'Gaibandha Sadar', 'গাইবান্ধা সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(351, 7, 57, 432, 'Gobindaganj', 'গোবিন্দগঞ্জ', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(352, 7, 57, 430, 'Palashbari', 'পলাশবাড়ী', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(353, 7, 57, NULL, 'Phulchhari', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(354, 7, 57, NULL, 'Saadullapur', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(355, 7, 57, 433, 'Sundarganj', 'সুন্দরগঞ্জ', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(356, 7, 60, 450, 'Bhurungamari', 'ভুরুঙ্গামারী', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(357, 7, 60, 454, 'Chilmari', 'চিলমারী', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(358, 7, 60, 448, 'Kurigram Sadar', 'কুড়িগ্রাম সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(359, 7, 60, 449, 'Nageshwar', 'নাগেশ্বরী', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(360, 7, 60, 452, 'Rajarhat', 'রাজারহাট', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(361, 7, 60, 456, 'Rajibpur', 'চর রাজিবপুর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(362, 7, 60, NULL, 'Roumari', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(363, 7, 60, 453, 'Ulipur', 'উলিপুর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(364, 7, 55, 421, 'Aditmari', 'আদিতমারী', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(365, 7, 55, 419, 'Hatibandha', 'হাতীবান্ধা', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(366, 7, 55, 417, 'Lalmonirhat Sadar', 'লালমনিরহাট সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(367, 7, 55, 420, 'Patgram', 'পাটগ্রাম', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(368, 7, 55, NULL, 'Tushbhandar', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(369, 7, 56, 424, 'Dimla', 'ডিমলা', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(370, 7, 56, 423, 'Domar', 'ডোমার', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(371, 7, 56, 425, 'Jaldhaka', 'জলঢাকা', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(372, 7, 56, NULL, 'Kishoriganj', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(373, 7, 56, 427, 'Nilphamari Sadar', 'নীলফামারী সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(374, 7, 56, 422, 'Syedpur', 'সৈয়দপুর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(375, 7, 53, 401, 'Boda', 'বোদা', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(376, 7, 53, NULL, 'Chotto Dab', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(377, 7, 53, NULL, 'Dabiganj', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(378, 7, 53, NULL, 'Panchagra Sadar', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(379, 7, 53, 403, 'Tetulia', 'তেতুলিয়া', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(380, 7, 59, NULL, 'Badarganj', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(381, 7, 59, 441, 'Gangachara', 'গংগাচড়া', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(382, 7, 59, 446, 'Kaunia', 'কাউনিয়া', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(383, 7, 59, 444, 'Mithapukur', 'মিঠাপুকুর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(384, 7, 59, NULL, 'Pirgachha', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(385, 7, 59, 440, 'Rangpur Sadar', 'রংপুর সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(386, 7, 59, NULL, 'Taraganj', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(387, 7, 58, 439, 'Baliadangi', 'বালিয়াডাঙ্গী', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(388, 7, 58, NULL, 'Jibanpur', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(389, 7, 58, 436, 'Pirganj', 'পীরগঞ্জ', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(390, 7, 58, NULL, 'Rani Sankail', NULL, NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(391, 7, 58, 435, 'Thakurgaon Sadar', 'ঠাকুরগাঁও সদর', NULL, '2026-03-03 06:32:00', '2026-03-03 06:32:00');

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `bn_name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`id`, `category_id`, `name`, `bn_name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Pothole', 'গর্ত', 'pothole', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(2, 1, 'Broken Road', 'ভাঙা রাস্তা', 'broken-road', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(3, 1, 'Road Blocked', 'রাস্তা বন্ধ', 'road-blocked', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(4, 1, 'Traffic Congestion', 'যানজট', 'traffic-congestion', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(5, 1, 'Damaged Bridge/Culvert', 'ভাঙা সেতু/কালভার্ট', 'damaged-bridgeculvert', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(6, 2, 'No Water Supply', 'পানি নেই', 'no-water-supply', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(7, 2, 'Low Water Pressure', 'কম পানির চাপ', 'low-water-pressure', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(8, 2, 'Water Leakage', 'পানির লিকেজ', 'water-leakage', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(9, 2, 'Dirty/Contaminated Water', 'দূষিত পানি', 'dirtycontaminated-water', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(10, 2, 'Broken Water Line', 'পানির লাইন নষ্ট', 'broken-water-line', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(11, 3, 'Power Outage', 'বিদ্যুৎ নেই', 'power-outage', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(12, 3, 'Loose Electric Wire', 'ঝুলন্ত বৈদ্যুতিক তার', 'loose-electric-wire', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(13, 3, 'Transformer Problem', 'ট্রান্সফরমার সমস্যা', 'transformer-problem', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(14, 3, 'Electric Pole Damage', 'বৈদ্যুতিক খুঁটি ক্ষতিগ্রস্ত', 'electric-pole-damage', 1, '2026-03-03 06:32:00', '2026-03-03 06:32:00'),
(15, 3, 'Frequent Load Shedding', 'ঘন ঘন লোডশেডিং', 'frequent-load-shedding', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(16, 4, 'Blocked Drain', 'ড্রেন বন্ধ', 'blocked-drain', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(17, 4, 'Sewer Overflow', 'পয়ঃনিষ্কাশন উপচে পড়া', 'sewer-overflow', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(18, 4, 'Water Logging', 'জলাবদ্ধতা', 'water-logging', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(19, 4, 'Drain Cover Broken', 'ড্রেনের ঢাকনা ভাঙা', 'drain-cover-broken', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(20, 4, 'Bad Smell from Drain', 'ড্রেন থেকে দুর্গন্ধ', 'bad-smell-from-drain', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(21, 5, 'Garbage Not Collected', 'ময়লা অপসারণ হয়নি', 'garbage-not-collected', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(22, 5, 'Overflowing Dustbin', 'ডাস্টবিন উপচে পড়ছে', 'overflowing-dustbin', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(23, 5, 'Illegal Dumping', 'অবৈধভাবে ময়লা ফেলা', 'illegal-dumping', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(24, 5, 'Dead Animal Removal', 'মরা প্রাণী অপসারণ', 'dead-animal-removal', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(25, 5, 'Medical Waste', 'মেডিকেল বর্জ্য', 'medical-waste', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(26, 6, 'Light Not Working', 'লাইট কাজ করছে না', 'light-not-working', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(27, 6, 'Broken Pole Light', 'খুঁটির লাইট নষ্ট', 'broken-pole-light', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(28, 6, 'Daytime Light On', 'দিনে লাইট জ্বলছে', 'daytime-light-on', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(29, 6, 'New Street Light Request', 'নতুন স্ট্রিট লাইটের আবেদন', 'new-street-light-request', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(30, 7, 'Air Pollution', 'বায়ু দূষণ', 'air-pollution', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(31, 7, 'Noise Pollution', 'শব্দ দূষণ', 'noise-pollution', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(32, 7, 'Water Pollution', 'পানি দূষণ', 'water-pollution', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(33, 7, 'Tree Cutting', 'গাছ কাটা', 'tree-cutting', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(34, 7, 'Smoke from Factory', 'কারখানার ধোঁয়া', 'smoke-from-factory', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(35, 8, 'Unauthorized Building', 'অননুমোদিত ভবন', 'unauthorized-building', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(36, 8, 'Footpath Occupation', 'ফুটপাত দখল', 'footpath-occupation', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(37, 8, 'Road Encroachment', 'রাস্তা দখল', 'road-encroachment', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(38, 8, 'Unsafe Construction Work', 'অসুরক্ষিত নির্মাণকাজ', 'unsafe-construction-work', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(39, 9, 'Overpricing', 'অতিরিক্ত দাম', 'overpricing', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(40, 9, 'Adulterated Products', 'ভেজাল পণ্য', 'adulterated-products', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(41, 9, 'Expired Products', 'মেয়াদোত্তীর্ণ পণ্য', 'expired-products', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(42, 9, 'Illegal Shop Occupation', 'অবৈধ দোকান দখল', 'illegal-shop-occupation', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(43, 9, 'No Price List', 'মূল্য তালিকা নেই', 'no-price-list', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(44, 10, 'Open Manhole', 'খোলা ম্যানহোল', 'open-manhole', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(45, 10, 'Broken Footpath', 'ভাঙা ফুটপাত', 'broken-footpath', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(46, 10, 'Stray Animals', 'ভাসমান/আবাসহীন প্রাণী', 'stray-animals', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(47, 10, 'Fire Hazard', 'অগ্নিঝুঁকি', 'fire-hazard', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(48, 10, 'Dangerous Building', 'ঝুঁকিপূর্ণ ভবন', 'dangerous-building', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(49, 11, 'Mosquito Breeding', 'মশার প্রজননস্থল', 'mosquito-breeding', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(50, 11, 'Unclean Public Toilet', 'অপরিচ্ছন্ন পাবলিক টয়লেট', 'unclean-public-toilet', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(51, 11, 'Food Hygiene Issue', 'খাদ্য স্বাস্থ্যবিধি সমস্যা', 'food-hygiene-issue', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(52, 11, 'Stagnant Water', 'স্থির পানি', 'stagnant-water', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(53, 11, 'Open Wastewater', 'খোলা নোংরা পানি', 'open-wastewater', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(54, 12, 'General Complaint', 'সাধারণ অভিযোগ', 'general-complaint', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(55, 12, 'Service Delay', 'সেবায় বিলম্ব', 'service-delay', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(56, 12, 'Staff Misbehavior', 'কর্মচারীর অসদাচরণ', 'staff-misbehavior', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01'),
(57, 12, 'Suggestion', 'পরামর্শ', 'suggestion', 1, '2026-03-03 06:32:01', '2026-03-03 06:32:01');

-- --------------------------------------------------------

--
-- Table structure for table `upazilas`
--

CREATE TABLE `upazilas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `division_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `upazila_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `bn_name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `upazilas`
--

INSERT INTO `upazilas` (`id`, `division_id`, `district_id`, `upazila_id`, `name`, `bn_name`, `url`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 'Debidwar', 'দেবিদ্বার', 'debidwar.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(2, 1, 1, NULL, 'Barura', 'বরুড়া', 'barura.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(3, 1, 1, NULL, 'Brahmanpara', 'ব্রাহ্মণপাড়া', 'brahmanpara.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(4, 1, 1, NULL, 'Chandina', 'চান্দিনা', 'chandina.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(5, 1, 1, NULL, 'Chauddagram', 'চৌদ্দগ্রাম', 'chauddagram.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(6, 1, 1, NULL, 'Daudkandi', 'দাউদকান্দি', 'daudkandi.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(7, 1, 1, NULL, 'Homna', 'হোমনা', 'homna.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(8, 1, 1, NULL, 'Laksam', 'লাকসাম', 'laksam.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(9, 1, 1, NULL, 'Muradnagar', 'মুরাদনগর', 'muradnagar.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(10, 1, 1, NULL, 'Nangalkot', 'নাঙ্গলকোট', 'nangalkot.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(11, 1, 1, NULL, 'Comilla Sadar', 'কুমিল্লা সদর', 'comillasadar.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(12, 1, 1, NULL, 'Meghna', 'মেঘনা', 'meghna.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(13, 1, 1, NULL, 'Monohargonj', 'মনোহরগঞ্জ', 'monohargonj.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(14, 1, 1, NULL, 'Sadarsouth', 'সদর দক্ষিণ', 'sadarsouth.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(15, 1, 1, NULL, 'Titas', 'তিতাস', 'titas.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(16, 1, 1, NULL, 'Burichang', 'বুড়িচং', 'burichang.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(17, 1, 1, NULL, 'Lalmai', 'লালমাই', 'lalmai.comilla.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(18, 1, 2, NULL, 'Chhagalnaiya', 'ছাগলনাইয়া', 'chhagalnaiya.feni.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(19, 1, 2, NULL, 'Feni Sadar', 'ফেনী সদর', 'sadar.feni.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(20, 1, 2, NULL, 'Sonagazi', 'সোনাগাজী', 'sonagazi.feni.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(21, 1, 2, NULL, 'Fulgazi', 'ফুলগাজী', 'fulgazi.feni.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(22, 1, 2, NULL, 'Parshuram', 'পরশুরাম', 'parshuram.feni.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(23, 1, 2, NULL, 'Daganbhuiyan', 'দাগনভূঞা', 'daganbhuiyan.feni.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(24, 1, 3, NULL, 'Brahmanbaria Sadar', 'ব্রাহ্মণবাড়িয়া সদর', 'sadar.brahmanbaria.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(25, 1, 3, NULL, 'Kasba', 'কসবা', 'kasba.brahmanbaria.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(26, 1, 3, NULL, 'Nasirnagar', 'নাসিরনগর', 'nasirnagar.brahmanbaria.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(27, 1, 3, NULL, 'Sarail', 'সরাইল', 'sarail.brahmanbaria.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(28, 1, 3, NULL, 'Ashuganj', 'আশুগঞ্জ', 'ashuganj.brahmanbaria.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(29, 1, 3, NULL, 'Akhaura', 'আখাউড়া', 'akhaura.brahmanbaria.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(30, 1, 3, NULL, 'Nabinagar', 'নবীনগর', 'nabinagar.brahmanbaria.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(31, 1, 3, NULL, 'Bancharampur', 'বাঞ্ছারামপুর', 'bancharampur.brahmanbaria.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(32, 1, 3, NULL, 'Bijoynagar', 'বিজয়নগর', 'bijoynagar.brahmanbaria.gov.bd    ', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(33, 1, 4, NULL, 'Rangamati Sadar', 'রাঙ্গামাটি সদর', 'sadar.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(34, 1, 4, NULL, 'Kaptai', 'কাপ্তাই', 'kaptai.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(35, 1, 4, NULL, 'Kawkhali', 'কাউখালী', 'kawkhali.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(36, 1, 4, NULL, 'Baghaichari', 'বাঘাইছড়ি', 'baghaichari.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(37, 1, 4, NULL, 'Barkal', 'বরকল', 'barkal.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(38, 1, 4, NULL, 'Langadu', 'লংগদু', 'langadu.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(39, 1, 4, NULL, 'Rajasthali', 'রাজস্থলী', 'rajasthali.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(40, 1, 4, NULL, 'Belaichari', 'বিলাইছড়ি', 'belaichari.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(41, 1, 4, NULL, 'Juraichari', 'জুরাছড়ি', 'juraichari.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(42, 1, 4, NULL, 'Naniarchar', 'নানিয়ারচর', 'naniarchar.rangamati.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(43, 1, 5, NULL, 'Noakhali Sadar', 'নোয়াখালী সদর', 'sadar.noakhali.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(44, 1, 5, NULL, 'Companiganj', 'কোম্পানীগঞ্জ', 'companiganj.noakhali.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(45, 1, 5, NULL, 'Begumganj', 'বেগমগঞ্জ', 'begumganj.noakhali.gov.bd', '2026-03-03 06:31:54', '2026-03-03 06:31:54'),
(46, 1, 5, NULL, 'Hatia', 'হাতিয়া', 'hatia.noakhali.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(47, 1, 5, NULL, 'Subarnachar', 'সুবর্ণচর', 'subarnachar.noakhali.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(48, 1, 5, NULL, 'Kabirhat', 'কবিরহাট', 'kabirhat.noakhali.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(49, 1, 5, NULL, 'Senbug', 'সেনবাগ', 'senbug.noakhali.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(50, 1, 5, NULL, 'Chatkhil', 'চাটখিল', 'chatkhil.noakhali.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(51, 1, 5, NULL, 'Sonaimori', 'সোনাইমুড়ী', 'sonaimori.noakhali.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(52, 1, 6, NULL, 'Haimchar', 'হাইমচর', 'haimchar.chandpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(53, 1, 6, NULL, 'Kachua', 'কচুয়া', 'kachua.chandpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(54, 1, 6, NULL, 'Shahrasti', 'শাহরাস্তি	', 'shahrasti.chandpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(55, 1, 6, NULL, 'Chandpur Sadar', 'চাঁদপুর সদর', 'sadar.chandpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(56, 1, 6, NULL, 'Matlab South', 'মতলব দক্ষিণ', 'matlabsouth.chandpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(57, 1, 6, NULL, 'Hajiganj', 'হাজীগঞ্জ', 'hajiganj.chandpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(58, 1, 6, NULL, 'Matlab North', 'মতলব উত্তর', 'matlabnorth.chandpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(59, 1, 6, NULL, 'Faridgonj', 'ফরিদগঞ্জ', 'faridgonj.chandpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(60, 1, 7, NULL, 'Lakshmipur Sadar', 'লক্ষ্মীপুর সদর', 'sadar.lakshmipur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(61, 1, 7, NULL, 'Kamalnagar', 'কমলনগর', 'kamalnagar.lakshmipur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(62, 1, 7, NULL, 'Raipur', 'রায়পুর', 'raipur.lakshmipur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(63, 1, 7, NULL, 'Ramgati', 'রামগতি', 'ramgati.lakshmipur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(64, 1, 7, NULL, 'Ramganj', 'রামগঞ্জ', 'ramganj.lakshmipur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(65, 1, 8, NULL, 'Rangunia', 'রাঙ্গুনিয়া', 'rangunia.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(66, 1, 8, NULL, 'Sitakunda', 'সীতাকুন্ড', 'sitakunda.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(67, 1, 8, NULL, 'Mirsharai', 'মীরসরাই', 'mirsharai.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(68, 1, 8, NULL, 'Patiya', 'পটিয়া', 'patiya.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(69, 1, 8, NULL, 'Sandwip', 'সন্দ্বীপ', 'sandwip.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(70, 1, 8, NULL, 'Banshkhali', 'বাঁশখালী', 'banshkhali.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(71, 1, 8, NULL, 'Boalkhali', 'বোয়ালখালী', 'boalkhali.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(72, 1, 8, NULL, 'Anwara', 'আনোয়ারা', 'anwara.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(73, 1, 8, NULL, 'Chandanaish', 'চন্দনাইশ', 'chandanaish.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(74, 1, 8, NULL, 'Satkania', 'সাতকানিয়া', 'satkania.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(75, 1, 8, NULL, 'Lohagara', 'লোহাগাড়া', 'lohagara.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(76, 1, 8, NULL, 'Hathazari', 'হাটহাজারী', 'hathazari.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(77, 1, 8, NULL, 'Fatikchhari', 'ফটিকছড়ি', 'fatikchhari.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(78, 1, 8, NULL, 'Raozan', 'রাউজান', 'raozan.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(79, 1, 8, NULL, 'Karnafuli', 'কর্ণফুলী', 'karnafuli.chittagong.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(80, 1, 9, NULL, 'Coxsbazar Sadar', 'কক্সবাজার সদর', 'sadar.coxsbazar.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(81, 1, 9, NULL, 'Chakaria', 'চকরিয়া', 'chakaria.coxsbazar.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(82, 1, 9, NULL, 'Kutubdia', 'কুতুবদিয়া', 'kutubdia.coxsbazar.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(83, 1, 9, NULL, 'Ukhiya', 'উখিয়া', 'ukhiya.coxsbazar.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(84, 1, 9, NULL, 'Moheshkhali', 'মহেশখালী', 'moheshkhali.coxsbazar.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(85, 1, 9, NULL, 'Pekua', 'পেকুয়া', 'pekua.coxsbazar.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(86, 1, 9, NULL, 'Ramu', 'রামু', 'ramu.coxsbazar.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(87, 1, 9, NULL, 'Teknaf', 'টেকনাফ', 'teknaf.coxsbazar.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(88, 1, 10, NULL, 'Khagrachhari Sadar', 'খাগড়াছড়ি সদর', 'sadar.khagrachhari.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(89, 1, 10, NULL, 'Dighinala', 'দিঘীনালা', 'dighinala.khagrachhari.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(90, 1, 10, NULL, 'Panchari', 'পানছড়ি', 'panchari.khagrachhari.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(91, 1, 10, NULL, 'Laxmichhari', 'লক্ষীছড়ি', 'laxmichhari.khagrachhari.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(92, 1, 10, NULL, 'Mohalchari', 'মহালছড়ি', 'mohalchari.khagrachhari.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(93, 1, 10, NULL, 'Manikchari', 'মানিকছড়ি', 'manikchari.khagrachhari.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(94, 1, 10, NULL, 'Ramgarh', 'রামগড়', 'ramgarh.khagrachhari.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(95, 1, 10, NULL, 'Matiranga', 'মাটিরাঙ্গা', 'matiranga.khagrachhari.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(96, 1, 10, NULL, 'Guimara', 'গুইমারা', 'guimara.khagrachhari.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(97, 1, 11, NULL, 'Bandarban Sadar', 'বান্দরবান সদর', 'sadar.bandarban.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(98, 1, 11, NULL, 'Alikadam', 'আলীকদম', 'alikadam.bandarban.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(99, 1, 11, NULL, 'Naikhongchhari', 'নাইক্ষ্যংছড়ি', 'naikhongchhari.bandarban.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(100, 1, 11, NULL, 'Rowangchhari', 'রোয়াংছড়ি', 'rowangchhari.bandarban.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(101, 1, 11, NULL, 'Lama', 'লামা', 'lama.bandarban.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(102, 1, 11, NULL, 'Ruma', 'রুমা', 'ruma.bandarban.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(103, 1, 11, NULL, 'Thanchi', 'থানচি', 'thanchi.bandarban.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(104, 2, 12, NULL, 'Belkuchi', 'বেলকুচি', 'belkuchi.sirajganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(105, 2, 12, NULL, 'Chauhali', 'চৌহালি', 'chauhali.sirajganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(106, 2, 12, NULL, 'Kamarkhand', 'কামারখন্দ', 'kamarkhand.sirajganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(107, 2, 12, NULL, 'Kazipur', 'কাজীপুর', 'kazipur.sirajganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(108, 2, 12, NULL, 'Raigonj', 'রায়গঞ্জ', 'raigonj.sirajganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(109, 2, 12, NULL, 'Shahjadpur', 'শাহজাদপুর', 'shahjadpur.sirajganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(110, 2, 12, NULL, 'Sirajganj Sadar', 'সিরাজগঞ্জ সদর', 'sirajganjsadar.sirajganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(111, 2, 12, NULL, 'Tarash', 'তাড়াশ', 'tarash.sirajganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(112, 2, 12, NULL, 'Ullapara', 'উল্লাপাড়া', 'ullapara.sirajganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(113, 2, 13, NULL, 'Sujanagar', 'সুজানগর', 'sujanagar.pabna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(114, 2, 13, NULL, 'Ishurdi', 'ঈশ্বরদী', 'ishurdi.pabna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(115, 2, 13, NULL, 'Bhangura', 'ভাঙ্গুড়া', 'bhangura.pabna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(116, 2, 13, NULL, 'Pabna Sadar', 'পাবনা সদর', 'pabnasadar.pabna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(117, 2, 13, NULL, 'Bera', 'বেড়া', 'bera.pabna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(118, 2, 13, NULL, 'Atghoria', 'আটঘরিয়া', 'atghoria.pabna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(119, 2, 13, NULL, 'Chatmohar', 'চাটমোহর', 'chatmohar.pabna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(120, 2, 13, NULL, 'Santhia', 'সাঁথিয়া', 'santhia.pabna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(121, 2, 13, NULL, 'Faridpur', 'ফরিদপুর', 'faridpur.pabna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(122, 2, 14, NULL, 'Kahaloo', 'কাহালু', 'kahaloo.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(123, 2, 14, NULL, 'Bogra Sadar', 'বগুড়া সদর', 'sadar.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(124, 2, 14, NULL, 'Shariakandi', 'সারিয়াকান্দি', 'shariakandi.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(125, 2, 14, NULL, 'Shajahanpur', 'শাজাহানপুর', 'shajahanpur.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(126, 2, 14, NULL, 'Dupchanchia', 'দুপচাচিঁয়া', 'dupchanchia.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(127, 2, 14, NULL, 'Adamdighi', 'আদমদিঘি', 'adamdighi.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(128, 2, 14, NULL, 'Nondigram', 'নন্দিগ্রাম', 'nondigram.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(129, 2, 14, NULL, 'Sonatala', 'সোনাতলা', 'sonatala.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(130, 2, 14, NULL, 'Dhunot', 'ধুনট', 'dhunot.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(131, 2, 14, NULL, 'Gabtali', 'গাবতলী', 'gabtali.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(132, 2, 14, NULL, 'Sherpur', 'শেরপুর', 'sherpur.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(133, 2, 14, NULL, 'Shibganj', 'শিবগঞ্জ', 'shibganj.bogra.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(134, 2, 15, NULL, 'Paba', 'পবা', 'paba.rajshahi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(135, 2, 15, NULL, 'Durgapur', 'দুর্গাপুর', 'durgapur.rajshahi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(136, 2, 15, NULL, 'Mohonpur', 'মোহনপুর', 'mohonpur.rajshahi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(137, 2, 15, NULL, 'Charghat', 'চারঘাট', 'charghat.rajshahi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(138, 2, 15, NULL, 'Puthia', 'পুঠিয়া', 'puthia.rajshahi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(139, 2, 15, NULL, 'Bagha', 'বাঘা', 'bagha.rajshahi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(140, 2, 15, NULL, 'Godagari', 'গোদাগাড়ী', 'godagari.rajshahi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(141, 2, 15, NULL, 'Tanore', 'তানোর', 'tanore.rajshahi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(142, 2, 15, NULL, 'Bagmara', 'বাগমারা', 'bagmara.rajshahi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(143, 2, 16, NULL, 'Natore Sadar', 'নাটোর সদর', 'natoresadar.natore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(144, 2, 16, NULL, 'Singra', 'সিংড়া', 'singra.natore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(145, 2, 16, NULL, 'Baraigram', 'বড়াইগ্রাম', 'baraigram.natore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(146, 2, 16, NULL, 'Bagatipara', 'বাগাতিপাড়া', 'bagatipara.natore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(147, 2, 16, NULL, 'Lalpur', 'লালপুর', 'lalpur.natore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(148, 2, 16, NULL, 'Gurudaspur', 'গুরুদাসপুর', 'gurudaspur.natore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(149, 2, 16, NULL, 'Naldanga', 'নলডাঙ্গা', 'naldanga.natore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(150, 2, 17, NULL, 'Akkelpur', 'আক্কেলপুর', 'akkelpur.joypurhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(151, 2, 17, NULL, 'Kalai', 'কালাই', 'kalai.joypurhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(152, 2, 17, NULL, 'Khetlal', 'ক্ষেতলাল', 'khetlal.joypurhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(153, 2, 17, NULL, 'Panchbibi', 'পাঁচবিবি', 'panchbibi.joypurhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(154, 2, 17, NULL, 'Joypurhat Sadar', 'জয়পুরহাট সদর', 'joypurhatsadar.joypurhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(155, 2, 18, NULL, 'Chapainawabganj Sadar', 'চাঁপাইনবাবগঞ্জ সদর', 'chapainawabganjsadar.chapainawabganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(156, 2, 18, NULL, 'Gomostapur', 'গোমস্তাপুর', 'gomostapur.chapainawabganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(157, 2, 18, NULL, 'Nachol', 'নাচোল', 'nachol.chapainawabganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(158, 2, 18, NULL, 'Bholahat', 'ভোলাহাট', 'bholahat.chapainawabganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(159, 2, 18, NULL, 'Shibganj', 'শিবগঞ্জ', 'shibganj.chapainawabganj.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(160, 2, 19, NULL, 'Mohadevpur', 'মহাদেবপুর', 'mohadevpur.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(161, 2, 19, NULL, 'Badalgachi', 'বদলগাছী', 'badalgachi.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(162, 2, 19, NULL, 'Patnitala', 'পত্নিতলা', 'patnitala.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(163, 2, 19, NULL, 'Dhamoirhat', 'ধামইরহাট', 'dhamoirhat.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(164, 2, 19, NULL, 'Niamatpur', 'নিয়ামতপুর', 'niamatpur.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(165, 2, 19, NULL, 'Manda', 'মান্দা', 'manda.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(166, 2, 19, NULL, 'Atrai', 'আত্রাই', 'atrai.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(167, 2, 19, NULL, 'Raninagar', 'রাণীনগর', 'raninagar.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(168, 2, 19, NULL, 'Naogaon Sadar', 'নওগাঁ সদর', 'naogaonsadar.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(169, 2, 19, NULL, 'Porsha', 'পোরশা', 'porsha.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(170, 2, 19, NULL, 'Sapahar', 'সাপাহার', 'sapahar.naogaon.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(171, 3, 20, NULL, 'Manirampur', 'মণিরামপুর', 'manirampur.jessore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(172, 3, 20, NULL, 'Abhaynagar', 'অভয়নগর', 'abhaynagar.jessore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(173, 3, 20, NULL, 'Bagherpara', 'বাঘারপাড়া', 'bagherpara.jessore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(174, 3, 20, NULL, 'Chougachha', 'চৌগাছা', 'chougachha.jessore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(175, 3, 20, NULL, 'Jhikargacha', 'ঝিকরগাছা', 'jhikargacha.jessore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(176, 3, 20, NULL, 'Keshabpur', 'কেশবপুর', 'keshabpur.jessore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(177, 3, 20, NULL, 'Jessore Sadar', 'যশোর সদর', 'sadar.jessore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(178, 3, 20, NULL, 'Sharsha', 'শার্শা', 'sharsha.jessore.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(179, 3, 21, NULL, 'Assasuni', 'আশাশুনি', 'assasuni.satkhira.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(180, 3, 21, NULL, 'Debhata', 'দেবহাটা', 'debhata.satkhira.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(181, 3, 21, NULL, 'Kalaroa', 'কলারোয়া', 'kalaroa.satkhira.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(182, 3, 21, NULL, 'Satkhira Sadar', 'সাতক্ষীরা সদর', 'satkhirasadar.satkhira.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(183, 3, 21, NULL, 'Shyamnagar', 'শ্যামনগর', 'shyamnagar.satkhira.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(184, 3, 21, NULL, 'Tala', 'তালা', 'tala.satkhira.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(185, 3, 21, NULL, 'Kaliganj', 'কালিগঞ্জ', 'kaliganj.satkhira.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(186, 3, 22, NULL, 'Mujibnagar', 'মুজিবনগর', 'mujibnagar.meherpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(187, 3, 22, NULL, 'Meherpur Sadar', 'মেহেরপুর সদর', 'meherpursadar.meherpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(188, 3, 22, NULL, 'Gangni', 'গাংনী', 'gangni.meherpur.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(189, 3, 23, NULL, 'Narail Sadar', 'নড়াইল সদর', 'narailsadar.narail.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(190, 3, 23, NULL, 'Lohagara', 'লোহাগড়া', 'lohagara.narail.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(191, 3, 23, NULL, 'Kalia', 'কালিয়া', 'kalia.narail.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(192, 3, 24, NULL, 'Chuadanga Sadar', 'চুয়াডাঙ্গা সদর', 'chuadangasadar.chuadanga.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(193, 3, 24, NULL, 'Alamdanga', 'আলমডাঙ্গা', 'alamdanga.chuadanga.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(194, 3, 24, NULL, 'Damurhuda', 'দামুড়হুদা', 'damurhuda.chuadanga.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(195, 3, 24, NULL, 'Jibannagar', 'জীবননগর', 'jibannagar.chuadanga.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(196, 3, 25, NULL, 'Kushtia Sadar', 'কুষ্টিয়া সদর', 'kushtiasadar.kushtia.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(197, 3, 25, NULL, 'Kumarkhali', 'কুমারখালী', 'kumarkhali.kushtia.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(198, 3, 25, NULL, 'Khoksa', 'খোকসা', 'khoksa.kushtia.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(199, 3, 25, NULL, 'Mirpur', 'মিরপুর', 'mirpurkushtia.kushtia.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(200, 3, 25, NULL, 'Daulatpur', 'দৌলতপুর', 'daulatpur.kushtia.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(201, 3, 25, NULL, 'Bheramara', 'ভেড়ামারা', 'bheramara.kushtia.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(202, 3, 26, NULL, 'Shalikha', 'শালিখা', 'shalikha.magura.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(203, 3, 26, NULL, 'Sreepur', 'শ্রীপুর', 'sreepur.magura.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(204, 3, 26, NULL, 'Magura Sadar', 'মাগুরা সদর', 'magurasadar.magura.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(205, 3, 26, NULL, 'Mohammadpur', 'মহম্মদপুর', 'mohammadpur.magura.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(206, 3, 27, NULL, 'Paikgasa', 'পাইকগাছা', 'paikgasa.khulna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(207, 3, 27, NULL, 'Fultola', 'ফুলতলা', 'fultola.khulna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(208, 3, 27, NULL, 'Digholia', 'দিঘলিয়া', 'digholia.khulna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(209, 3, 27, NULL, 'Rupsha', 'রূপসা', 'rupsha.khulna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(210, 3, 27, NULL, 'Terokhada', 'তেরখাদা', 'terokhada.khulna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(211, 3, 27, NULL, 'Dumuria', 'ডুমুরিয়া', 'dumuria.khulna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(212, 3, 27, NULL, 'Botiaghata', 'বটিয়াঘাটা', 'botiaghata.khulna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(213, 3, 27, NULL, 'Dakop', 'দাকোপ', 'dakop.khulna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(214, 3, 27, NULL, 'Koyra', 'কয়রা', 'koyra.khulna.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(215, 3, 28, NULL, 'Fakirhat', 'ফকিরহাট', 'fakirhat.bagerhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(216, 3, 28, NULL, 'Bagerhat Sadar', 'বাগেরহাট সদর', 'sadar.bagerhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(217, 3, 28, NULL, 'Mollahat', 'মোল্লাহাট', 'mollahat.bagerhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(218, 3, 28, NULL, 'Sarankhola', 'শরণখোলা', 'sarankhola.bagerhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(219, 3, 28, NULL, 'Rampal', 'রামপাল', 'rampal.bagerhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(220, 3, 28, NULL, 'Morrelganj', 'মোড়েলগঞ্জ', 'morrelganj.bagerhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(221, 3, 28, NULL, 'Kachua', 'কচুয়া', 'kachua.bagerhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(222, 3, 28, NULL, 'Mongla', 'মোংলা', 'mongla.bagerhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(223, 3, 28, NULL, 'Chitalmari', 'চিতলমারী', 'chitalmari.bagerhat.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(224, 3, 29, NULL, 'Jhenaidah Sadar', 'ঝিনাইদহ সদর', 'sadar.jhenaidah.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(225, 3, 29, NULL, 'Shailkupa', 'শৈলকুপা', 'shailkupa.jhenaidah.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(226, 3, 29, NULL, 'Harinakundu', 'হরিণাকুন্ডু', 'harinakundu.jhenaidah.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(227, 3, 29, NULL, 'Kaliganj', 'কালীগঞ্জ', 'kaliganj.jhenaidah.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(228, 3, 29, NULL, 'Kotchandpur', 'কোটচাঁদপুর', 'kotchandpur.jhenaidah.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(229, 3, 29, NULL, 'Moheshpur', 'মহেশপুর', 'moheshpur.jhenaidah.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(230, 4, 30, NULL, 'Jhalakathi Sadar', 'ঝালকাঠি সদর', 'sadar.jhalakathi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(231, 4, 30, NULL, 'Kathalia', 'কাঠালিয়া', 'kathalia.jhalakathi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(232, 4, 30, NULL, 'Nalchity', 'নলছিটি', 'nalchity.jhalakathi.gov.bd', '2026-03-03 06:31:55', '2026-03-03 06:31:55'),
(233, 4, 30, NULL, 'Rajapur', 'রাজাপুর', 'rajapur.jhalakathi.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(234, 4, 31, NULL, 'Bauphal', 'বাউফল', 'bauphal.patuakhali.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(235, 4, 31, NULL, 'Patuakhali Sadar', 'পটুয়াখালী সদর', 'sadar.patuakhali.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(236, 4, 31, NULL, 'Dumki', 'দুমকি', 'dumki.patuakhali.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(237, 4, 31, NULL, 'Dashmina', 'দশমিনা', 'dashmina.patuakhali.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(238, 4, 31, NULL, 'Kalapara', 'কলাপাড়া', 'kalapara.patuakhali.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(239, 4, 31, NULL, 'Mirzaganj', 'মির্জাগঞ্জ', 'mirzaganj.patuakhali.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(240, 4, 31, NULL, 'Galachipa', 'গলাচিপা', 'galachipa.patuakhali.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(241, 4, 31, NULL, 'Rangabali', 'রাঙ্গাবালী', 'rangabali.patuakhali.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(242, 4, 32, NULL, 'Pirojpur Sadar', 'পিরোজপুর সদর', 'sadar.pirojpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(243, 4, 32, NULL, 'Nazirpur', 'নাজিরপুর', 'nazirpur.pirojpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(244, 4, 32, NULL, 'Kawkhali', 'কাউখালী', 'kawkhali.pirojpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(245, 4, 32, NULL, 'Zianagar', 'জিয়ানগর', 'zianagar.pirojpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(246, 4, 32, NULL, 'Bhandaria', 'ভান্ডারিয়া', 'bhandaria.pirojpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(247, 4, 32, NULL, 'Mathbaria', 'মঠবাড়ীয়া', 'mathbaria.pirojpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(248, 4, 32, NULL, 'Nesarabad', 'নেছারাবাদ', 'nesarabad.pirojpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(249, 4, 33, NULL, 'Barisal Sadar', 'বরিশাল সদর', 'barisalsadar.barisal.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(250, 4, 33, NULL, 'Bakerganj', 'বাকেরগঞ্জ', 'bakerganj.barisal.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(251, 4, 33, NULL, 'Babuganj', 'বাবুগঞ্জ', 'babuganj.barisal.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(252, 4, 33, NULL, 'Wazirpur', 'উজিরপুর', 'wazirpur.barisal.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(253, 4, 33, NULL, 'Banaripara', 'বানারীপাড়া', 'banaripara.barisal.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(254, 4, 33, NULL, 'Gournadi', 'গৌরনদী', 'gournadi.barisal.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(255, 4, 33, NULL, 'Agailjhara', 'আগৈলঝাড়া', 'agailjhara.barisal.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(256, 4, 33, NULL, 'Mehendiganj', 'মেহেন্দিগঞ্জ', 'mehendiganj.barisal.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(257, 4, 33, NULL, 'Muladi', 'মুলাদী', 'muladi.barisal.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(258, 4, 33, NULL, 'Hizla', 'হিজলা', 'hizla.barisal.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(259, 4, 34, NULL, 'Bhola Sadar', 'ভোলা সদর', 'sadar.bhola.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(260, 4, 34, NULL, 'Borhan Sddin', 'বোরহান উদ্দিন', 'borhanuddin.bhola.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(261, 4, 34, NULL, 'Charfesson', 'চরফ্যাশন', 'charfesson.bhola.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(262, 4, 34, NULL, 'Doulatkhan', 'দৌলতখান', 'doulatkhan.bhola.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(263, 4, 34, NULL, 'Monpura', 'মনপুরা', 'monpura.bhola.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(264, 4, 34, NULL, 'Tazumuddin', 'তজুমদ্দিন', 'tazumuddin.bhola.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(265, 4, 34, NULL, 'Lalmohan', 'লালমোহন', 'lalmohan.bhola.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(266, 4, 35, NULL, 'Amtali', 'আমতলী', 'amtali.barguna.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(267, 4, 35, NULL, 'Barguna Sadar', 'বরগুনা সদর', 'sadar.barguna.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(268, 4, 35, NULL, 'Betagi', 'বেতাগী', 'betagi.barguna.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(269, 4, 35, NULL, 'Bamna', 'বামনা', 'bamna.barguna.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(270, 4, 35, NULL, 'Pathorghata', 'পাথরঘাটা', 'pathorghata.barguna.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(271, 4, 35, NULL, 'Taltali', 'তালতলি', 'taltali.barguna.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(272, 5, 36, NULL, 'Balaganj', 'বালাগঞ্জ', 'balaganj.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(273, 5, 36, NULL, 'Beanibazar', 'বিয়ানীবাজার', 'beanibazar.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(274, 5, 36, NULL, 'Bishwanath', 'বিশ্বনাথ', 'bishwanath.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(275, 5, 36, NULL, 'Companiganj', 'কোম্পানীগঞ্জ', 'companiganj.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(276, 5, 36, NULL, 'Fenchuganj', 'ফেঞ্চুগঞ্জ', 'fenchuganj.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(277, 5, 36, NULL, 'Golapganj', 'গোলাপগঞ্জ', 'golapganj.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(278, 5, 36, NULL, 'Gowainghat', 'গোয়াইনঘাট', 'gowainghat.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(279, 5, 36, NULL, 'Jaintiapur', 'জৈন্তাপুর', 'jaintiapur.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(280, 5, 36, NULL, 'Kanaighat', 'কানাইঘাট', 'kanaighat.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(281, 5, 36, NULL, 'Sylhet Sadar', 'সিলেট সদর', 'sylhetsadar.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(282, 5, 36, NULL, 'Zakiganj', 'জকিগঞ্জ', 'zakiganj.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(283, 5, 36, NULL, 'Dakshinsurma', 'দক্ষিণ সুরমা', 'dakshinsurma.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(284, 5, 36, NULL, 'Osmaninagar', 'ওসমানী নগর', 'osmaninagar.sylhet.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(285, 5, 37, NULL, 'Barlekha', 'বড়লেখা', 'barlekha.moulvibazar.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(286, 5, 37, NULL, 'Kamolganj', 'কমলগঞ্জ', 'kamolganj.moulvibazar.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(287, 5, 37, NULL, 'Kulaura', 'কুলাউড়া', 'kulaura.moulvibazar.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(288, 5, 37, NULL, 'Moulvibazar Sadar', 'মৌলভীবাজার সদর', 'moulvibazarsadar.moulvibazar.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(289, 5, 37, NULL, 'Rajnagar', 'রাজনগর', 'rajnagar.moulvibazar.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(290, 5, 37, NULL, 'Sreemangal', 'শ্রীমঙ্গল', 'sreemangal.moulvibazar.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(291, 5, 37, NULL, 'Juri', 'জুড়ী', 'juri.moulvibazar.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(292, 5, 38, NULL, 'Nabiganj', 'নবীগঞ্জ', 'nabiganj.habiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(293, 5, 38, NULL, 'Bahubal', 'বাহুবল', 'bahubal.habiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(294, 5, 38, NULL, 'Ajmiriganj', 'আজমিরীগঞ্জ', 'ajmiriganj.habiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(295, 5, 38, NULL, 'Baniachong', 'বানিয়াচং', 'baniachong.habiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(296, 5, 38, NULL, 'Lakhai', 'লাখাই', 'lakhai.habiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(297, 5, 38, NULL, 'Chunarughat', 'চুনারুঘাট', 'chunarughat.habiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(298, 5, 38, NULL, 'Habiganj Sadar', 'হবিগঞ্জ সদর', 'habiganjsadar.habiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(299, 5, 38, NULL, 'Madhabpur', 'মাধবপুর', 'madhabpur.habiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(300, 5, 39, NULL, 'Sunamganj Sadar', 'সুনামগঞ্জ সদর', 'sadar.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(301, 5, 39, NULL, 'South Sunamganj', 'দক্ষিণ সুনামগঞ্জ', 'southsunamganj.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(302, 5, 39, NULL, 'Bishwambarpur', 'বিশ্বম্ভরপুর', 'bishwambarpur.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(303, 5, 39, NULL, 'Chhatak', 'ছাতক', 'chhatak.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(304, 5, 39, NULL, 'Jagannathpur', 'জগন্নাথপুর', 'jagannathpur.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(305, 5, 39, NULL, 'Dowarabazar', 'দোয়ারাবাজার', 'dowarabazar.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(306, 5, 39, NULL, 'Tahirpur', 'তাহিরপুর', 'tahirpur.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(307, 5, 39, NULL, 'Dharmapasha', 'ধর্মপাশা', 'dharmapasha.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(308, 5, 39, NULL, 'Jamalganj', 'জামালগঞ্জ', 'jamalganj.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(309, 5, 39, NULL, 'Shalla', 'শাল্লা', 'shalla.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(310, 5, 39, NULL, 'Derai', 'দিরাই', 'derai.sunamganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(311, 6, 40, NULL, 'Belabo', 'বেলাবো', 'belabo.narsingdi.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(312, 6, 40, NULL, 'Monohardi', 'মনোহরদী', 'monohardi.narsingdi.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(313, 6, 40, NULL, 'Narsingdi Sadar', 'নরসিংদী সদর', 'narsingdisadar.narsingdi.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(314, 6, 40, NULL, 'Palash', 'পলাশ', 'palash.narsingdi.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(315, 6, 40, NULL, 'Raipura', 'রায়পুরা', 'raipura.narsingdi.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(316, 6, 40, NULL, 'Shibpur', 'শিবপুর', 'shibpur.narsingdi.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(317, 6, 41, NULL, 'Kaliganj', 'কালীগঞ্জ', 'kaliganj.gazipur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(318, 6, 41, NULL, 'Kaliakair', 'কালিয়াকৈর', 'kaliakair.gazipur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(319, 6, 41, NULL, 'Kapasia', 'কাপাসিয়া', 'kapasia.gazipur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(320, 6, 41, NULL, 'Gazipur Sadar', 'গাজীপুর সদর', 'sadar.gazipur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(321, 6, 41, NULL, 'Sreepur', 'শ্রীপুর', 'sreepur.gazipur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(322, 6, 42, NULL, 'Shariatpur Sadar', 'শরিয়তপুর সদর', 'sadar.shariatpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(323, 6, 42, NULL, 'Naria', 'নড়িয়া', 'naria.shariatpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(324, 6, 42, NULL, 'Zajira', 'জাজিরা', 'zajira.shariatpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(325, 6, 42, NULL, 'Gosairhat', 'গোসাইরহাট', 'gosairhat.shariatpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(326, 6, 42, NULL, 'Bhedarganj', 'ভেদরগঞ্জ', 'bhedarganj.shariatpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(327, 6, 42, NULL, 'Damudya', 'ডামুড্যা', 'damudya.shariatpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(328, 6, 43, NULL, 'Araihazar', 'আড়াইহাজার', 'araihazar.narayanganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(329, 6, 43, NULL, 'Bandar', 'বন্দর', 'bandar.narayanganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(330, 6, 43, NULL, 'Narayanganj Sadar', 'নারায়নগঞ্জ সদর', 'narayanganjsadar.narayanganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(331, 6, 43, NULL, 'Rupganj', 'রূপগঞ্জ', 'rupganj.narayanganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(332, 6, 43, NULL, 'Sonargaon', 'সোনারগাঁ', 'sonargaon.narayanganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(333, 6, 44, NULL, 'Basail', 'বাসাইল', 'basail.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(334, 6, 44, NULL, 'Bhuapur', 'ভুয়াপুর', 'bhuapur.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(335, 6, 44, NULL, 'Delduar', 'দেলদুয়ার', 'delduar.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(336, 6, 44, NULL, 'Ghatail', 'ঘাটাইল', 'ghatail.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(337, 6, 44, NULL, 'Gopalpur', 'গোপালপুর', 'gopalpur.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(338, 6, 44, NULL, 'Madhupur', 'মধুপুর', 'madhupur.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(339, 6, 44, NULL, 'Mirzapur', 'মির্জাপুর', 'mirzapur.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(340, 6, 44, NULL, 'Nagarpur', 'নাগরপুর', 'nagarpur.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(341, 6, 44, NULL, 'Sakhipur', 'সখিপুর', 'sakhipur.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(342, 6, 44, NULL, 'Tangail Sadar', 'টাঙ্গাইল সদর', 'tangailsadar.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(343, 6, 44, NULL, 'Kalihati', 'কালিহাতী', 'kalihati.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(344, 6, 44, NULL, 'Dhanbari', 'ধনবাড়ী', 'dhanbari.tangail.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(345, 6, 45, NULL, 'Itna', 'ইটনা', 'itna.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(346, 6, 45, NULL, 'Katiadi', 'কটিয়াদী', 'katiadi.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(347, 6, 45, NULL, 'Bhairab', 'ভৈরব', 'bhairab.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(348, 6, 45, NULL, 'Tarail', 'তাড়াইল', 'tarail.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(349, 6, 45, NULL, 'Hossainpur', 'হোসেনপুর', 'hossainpur.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(350, 6, 45, NULL, 'Pakundia', 'পাকুন্দিয়া', 'pakundia.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(351, 6, 45, NULL, 'Kuliarchar', 'কুলিয়ারচর', 'kuliarchar.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(352, 6, 45, NULL, 'Kishoreganj Sadar', 'কিশোরগঞ্জ সদর', 'kishoreganjsadar.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(353, 6, 45, NULL, 'Karimgonj', 'করিমগঞ্জ', 'karimgonj.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(354, 6, 45, NULL, 'Bajitpur', 'বাজিতপুর', 'bajitpur.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(355, 6, 45, NULL, 'Austagram', 'অষ্টগ্রাম', 'austagram.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(356, 6, 45, NULL, 'Mithamoin', 'মিঠামইন', 'mithamoin.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(357, 6, 45, NULL, 'Nikli', 'নিকলী', 'nikli.kishoreganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(358, 6, 46, NULL, 'Harirampur', 'হরিরামপুর', 'harirampur.manikganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(359, 6, 46, NULL, 'Saturia', 'সাটুরিয়া', 'saturia.manikganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(360, 6, 46, NULL, 'Manikganj Sadar', 'মানিকগঞ্জ সদর', 'sadar.manikganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(361, 6, 46, NULL, 'Gior', 'ঘিওর', 'gior.manikganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(362, 6, 46, NULL, 'Shibaloy', 'শিবালয়', 'shibaloy.manikganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(363, 6, 46, NULL, 'Doulatpur', 'দৌলতপুর', 'doulatpur.manikganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(364, 6, 46, NULL, 'Singiar', 'সিংগাইর', 'singiar.manikganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(365, 6, 47, NULL, 'Savar', 'সাভার', 'savar.dhaka.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(366, 6, 47, NULL, 'Dhamrai', 'ধামরাই', 'dhamrai.dhaka.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(367, 6, 47, NULL, 'Keraniganj', 'কেরাণীগঞ্জ', 'keraniganj.dhaka.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(368, 6, 47, NULL, 'Nawabganj', 'নবাবগঞ্জ', 'nawabganj.dhaka.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(369, 6, 47, NULL, 'Dohar', 'দোহার', 'dohar.dhaka.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(370, 6, 48, NULL, 'Munshiganj Sadar', 'মুন্সিগঞ্জ সদর', 'sadar.munshiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(371, 6, 48, NULL, 'Sreenagar', 'শ্রীনগর', 'sreenagar.munshiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(372, 6, 48, NULL, 'Sirajdikhan', 'সিরাজদিখান', 'sirajdikhan.munshiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(373, 6, 48, NULL, 'Louhajanj', 'লৌহজং', 'louhajanj.munshiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(374, 6, 48, NULL, 'Gajaria', 'গজারিয়া', 'gajaria.munshiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(375, 6, 48, NULL, 'Tongibari', 'টংগীবাড়ি', 'tongibari.munshiganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(376, 6, 49, NULL, 'Rajbari Sadar', 'রাজবাড়ী সদর', 'sadar.rajbari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(377, 6, 49, NULL, 'Goalanda', 'গোয়ালন্দ', 'goalanda.rajbari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(378, 6, 49, NULL, 'Pangsa', 'পাংশা', 'pangsa.rajbari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(379, 6, 49, NULL, 'Baliakandi', 'বালিয়াকান্দি', 'baliakandi.rajbari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(380, 6, 49, NULL, 'Kalukhali', 'কালুখালী', 'kalukhali.rajbari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(381, 6, 50, NULL, 'Madaripur Sadar', 'মাদারীপুর সদর', 'sadar.madaripur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(382, 6, 50, NULL, 'Shibchar', 'শিবচর', 'shibchar.madaripur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(383, 6, 50, NULL, 'Kalkini', 'কালকিনি', 'kalkini.madaripur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(384, 6, 50, NULL, 'Rajoir', 'রাজৈর', 'rajoir.madaripur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(385, 6, 51, NULL, 'Gopalganj Sadar', 'গোপালগঞ্জ সদর', 'sadar.gopalganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(386, 6, 51, NULL, 'Kashiani', 'কাশিয়ানী', 'kashiani.gopalganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(387, 6, 51, NULL, 'Tungipara', 'টুংগীপাড়া', 'tungipara.gopalganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(388, 6, 51, NULL, 'Kotalipara', 'কোটালীপাড়া', 'kotalipara.gopalganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(389, 6, 51, NULL, 'Muksudpur', 'মুকসুদপুর', 'muksudpur.gopalganj.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(390, 6, 52, NULL, 'Faridpur Sadar', 'ফরিদপুর সদর', 'sadar.faridpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(391, 6, 52, NULL, 'Alfadanga', 'আলফাডাঙ্গা', 'alfadanga.faridpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(392, 6, 52, NULL, 'Boalmari', 'বোয়ালমারী', 'boalmari.faridpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(393, 6, 52, NULL, 'Sadarpur', 'সদরপুর', 'sadarpur.faridpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(394, 6, 52, NULL, 'Nagarkanda', 'নগরকান্দা', 'nagarkanda.faridpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(395, 6, 52, NULL, 'Bhanga', 'ভাঙ্গা', 'bhanga.faridpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(396, 6, 52, NULL, 'Charbhadrasan', 'চরভদ্রাসন', 'charbhadrasan.faridpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(397, 6, 52, NULL, 'Madhukhali', 'মধুখালী', 'madhukhali.faridpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(398, 6, 52, NULL, 'Saltha', 'সালথা', 'saltha.faridpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(399, 7, 53, NULL, 'Panchagarh Sadar', 'পঞ্চগড় সদর', 'panchagarhsadar.panchagarh.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(400, 7, 53, NULL, 'Debiganj', 'দেবীগঞ্জ', 'debiganj.panchagarh.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(401, 7, 53, NULL, 'Boda', 'বোদা', 'boda.panchagarh.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(402, 7, 53, NULL, 'Atwari', 'আটোয়ারী', 'atwari.panchagarh.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(403, 7, 53, NULL, 'Tetulia', 'তেতুলিয়া', 'tetulia.panchagarh.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(404, 7, 54, NULL, 'Nawabganj', 'নবাবগঞ্জ', 'nawabganj.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(405, 7, 54, NULL, 'Birganj', 'বীরগঞ্জ', 'birganj.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(406, 7, 54, NULL, 'Ghoraghat', 'ঘোড়াঘাট', 'ghoraghat.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(407, 7, 54, NULL, 'Birampur', 'বিরামপুর', 'birampur.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(408, 7, 54, NULL, 'Parbatipur', 'পার্বতীপুর', 'parbatipur.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(409, 7, 54, NULL, 'Bochaganj', 'বোচাগঞ্জ', 'bochaganj.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(410, 7, 54, NULL, 'Kaharol', 'কাহারোল', 'kaharol.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(411, 7, 54, NULL, 'Fulbari', 'ফুলবাড়ী', 'fulbari.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(412, 7, 54, NULL, 'Dinajpur Sadar', 'দিনাজপুর সদর', 'dinajpursadar.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(413, 7, 54, NULL, 'Hakimpur', 'হাকিমপুর', 'hakimpur.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(414, 7, 54, NULL, 'Khansama', 'খানসামা', 'khansama.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(415, 7, 54, NULL, 'Birol', 'বিরল', 'birol.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(416, 7, 54, NULL, 'Chirirbandar', 'চিরিরবন্দর', 'chirirbandar.dinajpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(417, 7, 55, NULL, 'Lalmonirhat Sadar', 'লালমনিরহাট সদর', 'sadar.lalmonirhat.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(418, 7, 55, NULL, 'Kaliganj', 'কালীগঞ্জ', 'kaliganj.lalmonirhat.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(419, 7, 55, NULL, 'Hatibandha', 'হাতীবান্ধা', 'hatibandha.lalmonirhat.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(420, 7, 55, NULL, 'Patgram', 'পাটগ্রাম', 'patgram.lalmonirhat.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(421, 7, 55, NULL, 'Aditmari', 'আদিতমারী', 'aditmari.lalmonirhat.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(422, 7, 56, NULL, 'Syedpur', 'সৈয়দপুর', 'syedpur.nilphamari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(423, 7, 56, NULL, 'Domar', 'ডোমার', 'domar.nilphamari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(424, 7, 56, NULL, 'Dimla', 'ডিমলা', 'dimla.nilphamari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(425, 7, 56, NULL, 'Jaldhaka', 'জলঢাকা', 'jaldhaka.nilphamari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(426, 7, 56, NULL, 'Kishorganj', 'কিশোরগঞ্জ', 'kishorganj.nilphamari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56');
INSERT INTO `upazilas` (`id`, `division_id`, `district_id`, `upazila_id`, `name`, `bn_name`, `url`, `created_at`, `updated_at`) VALUES
(427, 7, 56, NULL, 'Nilphamari Sadar', 'নীলফামারী সদর', 'nilphamarisadar.nilphamari.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(428, 7, 57, NULL, 'Sadullapur', 'সাদুল্লাপুর', 'sadullapur.gaibandha.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(429, 7, 57, NULL, 'Gaibandha Sadar', 'গাইবান্ধা সদর', 'gaibandhasadar.gaibandha.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(430, 7, 57, NULL, 'Palashbari', 'পলাশবাড়ী', 'palashbari.gaibandha.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(431, 7, 57, NULL, 'Saghata', 'সাঘাটা', 'saghata.gaibandha.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(432, 7, 57, NULL, 'Gobindaganj', 'গোবিন্দগঞ্জ', 'gobindaganj.gaibandha.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(433, 7, 57, NULL, 'Sundarganj', 'সুন্দরগঞ্জ', 'sundarganj.gaibandha.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(434, 7, 57, NULL, 'Phulchari', 'ফুলছড়ি', 'phulchari.gaibandha.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(435, 7, 58, NULL, 'Thakurgaon Sadar', 'ঠাকুরগাঁও সদর', 'thakurgaonsadar.thakurgaon.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(436, 7, 58, NULL, 'Pirganj', 'পীরগঞ্জ', 'pirganj.thakurgaon.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(437, 7, 58, NULL, 'Ranisankail', 'রাণীশংকৈল', 'ranisankail.thakurgaon.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(438, 7, 58, NULL, 'Haripur', 'হরিপুর', 'haripur.thakurgaon.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(439, 7, 58, NULL, 'Baliadangi', 'বালিয়াডাঙ্গী', 'baliadangi.thakurgaon.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(440, 7, 59, NULL, 'Rangpur Sadar', 'রংপুর সদর', 'rangpursadar.rangpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(441, 7, 59, NULL, 'Gangachara', 'গংগাচড়া', 'gangachara.rangpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(442, 7, 59, NULL, 'Taragonj', 'তারাগঞ্জ', 'taragonj.rangpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(443, 7, 59, NULL, 'Badargonj', 'বদরগঞ্জ', 'badargonj.rangpur.gov.bd', '2026-03-03 06:31:56', '2026-03-03 06:31:56'),
(444, 7, 59, NULL, 'Mithapukur', 'মিঠাপুকুর', 'mithapukur.rangpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(445, 7, 59, NULL, 'Pirgonj', 'পীরগঞ্জ', 'pirgonj.rangpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(446, 7, 59, NULL, 'Kaunia', 'কাউনিয়া', 'kaunia.rangpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(447, 7, 59, NULL, 'Pirgacha', 'পীরগাছা', 'pirgacha.rangpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(448, 7, 60, NULL, 'Kurigram Sadar', 'কুড়িগ্রাম সদর', 'kurigramsadar.kurigram.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(449, 7, 60, NULL, 'Nageshwari', 'নাগেশ্বরী', 'nageshwari.kurigram.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(450, 7, 60, NULL, 'Bhurungamari', 'ভুরুঙ্গামারী', 'bhurungamari.kurigram.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(451, 7, 60, NULL, 'Phulbari', 'ফুলবাড়ী', 'phulbari.kurigram.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(452, 7, 60, NULL, 'Rajarhat', 'রাজারহাট', 'rajarhat.kurigram.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(453, 7, 60, NULL, 'Ulipur', 'উলিপুর', 'ulipur.kurigram.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(454, 7, 60, NULL, 'Chilmari', 'চিলমারী', 'chilmari.kurigram.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(455, 7, 60, NULL, 'Rowmari', 'রৌমারী', 'rowmari.kurigram.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(456, 7, 60, NULL, 'Charrajibpur', 'চর রাজিবপুর', 'charrajibpur.kurigram.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(457, 8, 61, NULL, 'Sherpur Sadar', 'শেরপুর সদর', 'sherpursadar.sherpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(458, 8, 61, NULL, 'Nalitabari', 'নালিতাবাড়ী', 'nalitabari.sherpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(459, 8, 61, NULL, 'Sreebordi', 'শ্রীবরদী', 'sreebordi.sherpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(460, 8, 61, NULL, 'Nokla', 'নকলা', 'nokla.sherpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(461, 8, 61, NULL, 'Jhenaigati', 'ঝিনাইগাতী', 'jhenaigati.sherpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(462, 8, 62, NULL, 'Fulbaria', 'ফুলবাড়ীয়া', 'fulbaria.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(463, 8, 62, NULL, 'Trishal', 'ত্রিশাল', 'trishal.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(464, 8, 62, NULL, 'Bhaluka', 'ভালুকা', 'bhaluka.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(465, 8, 62, NULL, 'Muktagacha', 'মুক্তাগাছা', 'muktagacha.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(466, 8, 62, NULL, 'Mymensingh Sadar', 'ময়মনসিংহ সদর', 'mymensinghsadar.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(467, 8, 62, NULL, 'Dhobaura', 'ধোবাউড়া', 'dhobaura.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(468, 8, 62, NULL, 'Phulpur', 'ফুলপুর', 'phulpur.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(469, 8, 62, NULL, 'Haluaghat', 'হালুয়াঘাট', 'haluaghat.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(470, 8, 62, NULL, 'Gouripur', 'গৌরীপুর', 'gouripur.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(471, 8, 62, NULL, 'Gafargaon', 'গফরগাঁও', 'gafargaon.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(472, 8, 62, NULL, 'Iswarganj', 'ঈশ্বরগঞ্জ', 'iswarganj.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(473, 8, 62, NULL, 'Nandail', 'নান্দাইল', 'nandail.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(474, 8, 62, NULL, 'Tarakanda', 'তারাকান্দা', 'tarakanda.mymensingh.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(475, 8, 63, NULL, 'Jamalpur Sadar', 'জামালপুর সদর', 'jamalpursadar.jamalpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(476, 8, 63, NULL, 'Melandah', 'মেলান্দহ', 'melandah.jamalpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(477, 8, 63, NULL, 'Islampur', 'ইসলামপুর', 'islampur.jamalpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(478, 8, 63, NULL, 'Dewangonj', 'দেওয়ানগঞ্জ', 'dewangonj.jamalpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(479, 8, 63, NULL, 'Sarishabari', 'সরিষাবাড়ী', 'sarishabari.jamalpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(480, 8, 63, NULL, 'Madarganj', 'মাদারগঞ্জ', 'madarganj.jamalpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(481, 8, 63, NULL, 'Bokshiganj', 'বকশীগঞ্জ', 'bokshiganj.jamalpur.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(482, 8, 64, NULL, 'Barhatta', 'বারহাট্টা', 'barhatta.netrokona.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(483, 8, 64, NULL, 'Durgapur', 'দুর্গাপুর', 'durgapur.netrokona.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(484, 8, 64, NULL, 'Kendua', 'কেন্দুয়া', 'kendua.netrokona.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(485, 8, 64, NULL, 'Atpara', 'আটপাড়া', 'atpara.netrokona.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(486, 8, 64, NULL, 'Madan', 'মদন', 'madan.netrokona.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(487, 8, 64, NULL, 'Khaliajuri', 'খালিয়াজুরী', 'khaliajuri.netrokona.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(488, 8, 64, NULL, 'Kalmakanda', 'কলমাকান্দা', 'kalmakanda.netrokona.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(489, 8, 64, NULL, 'Mohongonj', 'মোহনগঞ্জ', 'mohongonj.netrokona.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(490, 8, 64, NULL, 'Purbadhala', 'পূর্বধলা', 'purbadhala.netrokona.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(491, 8, 64, NULL, 'Netrokona Sadar', 'নেত্রকোণা সদর', 'netrokonasadar.netrokona.gov.bd', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(492, 1, 9, NULL, 'Eidgaon', 'ঈদগাঁও', 'null', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(493, 5, 39, NULL, 'Madhyanagar', 'মধ্যনগর', 'null', '2026-03-03 06:31:57', '2026-03-03 06:31:57'),
(494, 6, 50, NULL, 'Dasar', 'ডাসার', 'null', '2026-03-03 06:31:57', '2026-03-03 06:31:57');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `blood_group` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `present_address` text DEFAULT NULL,
  `parmanent_address` text DEFAULT NULL,
  `national_id` varchar(50) DEFAULT NULL,
  `religion` varchar(50) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user','staff') NOT NULL DEFAULT 'user',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `photo` varchar(255) DEFAULT NULL,
  `tokens` varchar(255) DEFAULT NULL,
  `otp` varchar(10) DEFAULT NULL,
  `otp_expires_at` timestamp NULL DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `phone_verified_at` timestamp NULL DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `last_login_ip` varchar(45) DEFAULT NULL,
  `is_profile_completed` tinyint(1) NOT NULL DEFAULT 0,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `dob`, `gender`, `blood_group`, `present_address`, `parmanent_address`, `national_id`, `religion`, `password`, `role`, `is_active`, `photo`, `tokens`, `otp`, `otp_expires_at`, `email_verified_at`, `phone_verified_at`, `last_login_at`, `last_login_ip`, `is_profile_completed`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Samim Hossain', 'xyz@gmail.com', '01762164746', '2001-12-31', 'Male', 'A+', 'Dhaka', 'Dhaka', '321654987', 'Islam', '$2y$12$R2PWNwASDaKHWuCroCkjoOZliVnrH/VF0/hvYtYr2UpOejv7OTPq2', 'user', 1, 'users/POEHUcIHWUppHSqu0E2QW0rHz4xjU8JAQgtUjAoW.jpg', NULL, NULL, NULL, '2026-03-03 00:20:33', NULL, '2026-03-05 08:18:32', '127.0.0.1', 1, NULL, '2026-03-03 00:16:21', '2026-03-05 08:18:32'),
(2, 'Sumon', 'xyz1@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$12$se2bSCaEN5nJ0MHpnsbeaOkH8IZRhP.e8fXrqoz1qGl4tDNZGXBYO', 'user', 1, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-05 08:17:45', '127.0.0.1', 0, NULL, '2026-03-03 07:35:19', '2026-03-05 08:17:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`);

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
-- Indexes for table `complaint_activity_logs`
--
ALTER TABLE `complaint_activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaint_activity_logs_actor_id_foreign` (`actor_id`),
  ADD KEY `complaint_activity_logs_complaint_id_created_at_index` (`complaint_id`,`created_at`),
  ADD KEY `complaint_activity_logs_activity_type_index` (`activity_type`);

--
-- Indexes for table `complaint_attachments`
--
ALTER TABLE `complaint_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaint_attachments_uploaded_by_foreign` (`uploaded_by`),
  ADD KEY `complaint_attachments_complaint_id_context_type_context_id_index` (`complaint_id`,`context_type`,`context_id`),
  ADD KEY `complaint_attachments_file_hash_index` (`file_hash`);

--
-- Indexes for table `complaint_comments`
--
ALTER TABLE `complaint_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaint_comments_user_id_foreign` (`user_id`),
  ADD KEY `complaint_comments_edited_by_foreign` (`edited_by`),
  ADD KEY `complaint_comments_deleted_by_foreign` (`deleted_by`),
  ADD KEY `complaint_comments_complaint_id_created_at_index` (`complaint_id`,`created_at`),
  ADD KEY `complaint_comments_parent_id_index` (`parent_id`);

--
-- Indexes for table `complaint_comment_reactions`
--
ALTER TABLE `complaint_comment_reactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `comment_user_reaction_unique` (`comment_id`,`user_id`,`reaction_type`),
  ADD KEY `complaint_comment_reactions_user_id_foreign` (`user_id`),
  ADD KEY `complaint_comment_reactions_comment_id_reaction_type_index` (`comment_id`,`reaction_type`);

--
-- Indexes for table `complaint_edit_logs`
--
ALTER TABLE `complaint_edit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaint_edit_logs_edited_by_foreign` (`edited_by`),
  ADD KEY `complaint_edit_logs_complaint_id_created_at_index` (`complaint_id`,`created_at`);

--
-- Indexes for table `complaint_reactions`
--
ALTER TABLE `complaint_reactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `complaint_reactions_complaint_id_user_id_unique` (`complaint_id`,`user_id`),
  ADD KEY `complaint_reactions_user_id_foreign` (`user_id`);

--
-- Indexes for table `complaint_status_logs`
--
ALTER TABLE `complaint_status_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaint_status_logs_changed_by_foreign` (`changed_by`),
  ADD KEY `complaint_status_logs_complaint_id_created_at_index` (`complaint_id`,`created_at`);

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `districts_division_id_name_unique` (`division_id`,`name`);

--
-- Indexes for table `divisions`
--
ALTER TABLE `divisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `divisions_name_unique` (`name`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `police_stations`
--
ALTER TABLE `police_stations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `police_stations_district_id_name_unique` (`district_id`,`name`),
  ADD KEY `police_stations_division_id_foreign` (`division_id`),
  ADD KEY `police_stations_upazila_id_foreign` (`upazila_id`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subcategories_category_id_name_unique` (`category_id`,`name`);

--
-- Indexes for table `upazilas`
--
ALTER TABLE `upazilas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `upazilas_district_id_name_unique` (`district_id`,`name`),
  ADD KEY `upazilas_division_id_foreign` (`division_id`),
  ADD KEY `upazilas_upazila_id_foreign` (`upazila_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `complaint_activity_logs`
--
ALTER TABLE `complaint_activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `complaint_attachments`
--
ALTER TABLE `complaint_attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `complaint_comments`
--
ALTER TABLE `complaint_comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `complaint_comment_reactions`
--
ALTER TABLE `complaint_comment_reactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `complaint_edit_logs`
--
ALTER TABLE `complaint_edit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `complaint_reactions`
--
ALTER TABLE `complaint_reactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `complaint_status_logs`
--
ALTER TABLE `complaint_status_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `districts`
--
ALTER TABLE `districts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `divisions`
--
ALTER TABLE `divisions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `police_stations`
--
ALTER TABLE `police_stations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=392;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `upazilas`
--
ALTER TABLE `upazilas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=495;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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

--
-- Constraints for table `complaint_activity_logs`
--
ALTER TABLE `complaint_activity_logs`
  ADD CONSTRAINT `complaint_activity_logs_actor_id_foreign` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `complaint_activity_logs_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `complaint_attachments`
--
ALTER TABLE `complaint_attachments`
  ADD CONSTRAINT `complaint_attachments_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaint_attachments_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `complaint_comments`
--
ALTER TABLE `complaint_comments`
  ADD CONSTRAINT `complaint_comments_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaint_comments_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `complaint_comments_edited_by_foreign` FOREIGN KEY (`edited_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `complaint_comments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `complaint_comments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `complaint_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `complaint_comment_reactions`
--
ALTER TABLE `complaint_comment_reactions`
  ADD CONSTRAINT `complaint_comment_reactions_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `complaint_comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaint_comment_reactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `complaint_edit_logs`
--
ALTER TABLE `complaint_edit_logs`
  ADD CONSTRAINT `complaint_edit_logs_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaint_edit_logs_edited_by_foreign` FOREIGN KEY (`edited_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `complaint_reactions`
--
ALTER TABLE `complaint_reactions`
  ADD CONSTRAINT `complaint_reactions_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaint_reactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `complaint_status_logs`
--
ALTER TABLE `complaint_status_logs`
  ADD CONSTRAINT `complaint_status_logs_changed_by_foreign` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `complaint_status_logs_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `districts`
--
ALTER TABLE `districts`
  ADD CONSTRAINT `districts_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `police_stations`
--
ALTER TABLE `police_stations`
  ADD CONSTRAINT `police_stations_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `police_stations_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `police_stations_upazila_id_foreign` FOREIGN KEY (`upazila_id`) REFERENCES `upazilas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `upazilas`
--
ALTER TABLE `upazilas`
  ADD CONSTRAINT `upazilas_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `upazilas_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `upazilas_upazila_id_foreign` FOREIGN KEY (`upazila_id`) REFERENCES `upazilas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
