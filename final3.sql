-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 07, 2025 at 04:28 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `final3`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `address` longtext NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '1',
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `address`, `status`, `name`, `phone`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'hwhueyeje', '1', NULL, NULL, 4, '2024-11-18 16:07:44', '2024-11-18 16:07:44'),
(2, 'yyy', '1', NULL, NULL, 4, '2024-12-05 03:40:33', '2024-12-05 03:40:33'),
(3, 'gtgtvhbu', '1', NULL, NULL, 112, '2025-01-07 13:10:01', '2025-01-07 13:10:01');

-- --------------------------------------------------------

--
-- Table structure for table `bidding`
--

CREATE TABLE `bidding` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `intial_amt` double(8,2) NOT NULL,
  `min_amt` double(8,2) NOT NULL,
  `status` varchar(255) NOT NULL,
  `winner_id` bigint(20) UNSIGNED DEFAULT NULL,
  `highest_amt` double(8,2) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `plant_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bidding_detail`
--

CREATE TABLE `bidding_detail` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bidding_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `amount` double(8,2) NOT NULL,
  `refund_status` varchar(255) NOT NULL,
  `payment_way` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double(8,2) NOT NULL,
  `date_added` date NOT NULL,
  `is_purchase` varchar(255) NOT NULL DEFAULT 'false',
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `plant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bidding_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `type`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Lotus', 'Plant', '1', NULL, '2024-11-28 06:42:49'),
(2, 'Desert Rose', 'Plant', '1', NULL, '2024-11-28 06:43:00'),
(3, 'Cactus', 'Plant', '1', NULL, '2024-11-28 06:43:09'),
(4, 'Hydrangeas', 'Plant', '1', NULL, '2024-11-28 06:43:19'),
(5, 'Soil', 'Product', '1', NULL, '2024-11-28 06:43:55'),
(6, 'Pot', 'Product', '1', NULL, NULL),
(7, 'Shovel', 'Product', '1', NULL, NULL),
(8, 'Lotus', 'Plant', '1', NULL, NULL),
(9, 'Desert Rose', 'Plant', '1', NULL, NULL),
(10, 'Cactus', 'Plant', '1', NULL, NULL),
(11, 'Hydrangeas', 'Plant', '1', NULL, NULL),
(12, 'Soil', 'Product', '1', NULL, NULL),
(13, 'Pot', 'Product', '1', NULL, NULL),
(14, 'Shovel', 'Product', '1', NULL, NULL),
(15, 'Wiring', 'Product', '1', '2024-11-28 07:25:19', '2024-11-28 07:25:19'),
(16, 'Piping', 'Product', '1', '2024-11-28 07:25:34', '2024-11-28 07:25:34'),
(17, 'Gardening', 'Product', '1', '2024-11-28 07:25:47', '2024-11-28 07:25:47'),
(18, 'Runner', 'Product', '1', '2024-11-28 07:25:58', '2024-11-28 07:25:58');

-- --------------------------------------------------------

--
-- Table structure for table `custom`
--

CREATE TABLE `custom` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `video` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom`
--

INSERT INTO `custom` (`id`, `name`, `image`, `video`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Style 1', 'pinkred.jpg', 'pinkredlotus_video.mp4', '1', NULL, NULL),
(2, 'Style 2', 'pink_white.jpg', 'pinkwhitelotus_video.mp4', '1', NULL, NULL),
(3, 'Style 3', 'red.jpg', 'redlotus_video.mp4', '1', NULL, NULL),
(4, 'Style 1', 'pinkred.jpg', 'pinkredlotus_video.mp4', '1', NULL, NULL),
(5, 'Style 2', 'pink_white.jpg', 'pinkwhitelotus_video.mp4', '1', NULL, NULL),
(6, 'Style 3', 'red.jpg', 'redlotus_video.mp4', '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tracking_number` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `prv_img` varchar(255) DEFAULT NULL,
  `expected_date` date DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`id`, `tracking_number`, `method`, `status`, `details`, `prv_img`, `expected_date`, `user_id`, `order_id`, `vendor_id`, `created_at`, `updated_at`) VALUES
(1, '1222222222222', 'ss', 'Completed', NULL, '1735463823.jpg', '2025-12-30', 4, 9, NULL, '2024-11-29 09:35:26', '2024-12-29 09:17:03'),
(2, '22222', 'ddede', 'confirm', NULL, '1735463823.jpg', '2025-11-02', 4, 58, NULL, '2024-12-29 09:18:01', '2024-12-29 09:18:01'),
(4, 'cdcs', 'dcscsd', 'prepare', NULL, NULL, '2024-12-05', 4, 126, NULL, '2025-01-01 10:01:03', '2025-01-01 10:01:03'),
(5, 'gg', 'gg', 'Completed', NULL, '1735741921.jpg', '2024-11-14', 4, 124, NULL, '2025-01-01 10:03:43', '2025-01-01 14:32:01'),
(6, 'bgfb', 'fbgb', 'prepare', NULL, NULL, '2014-12-05', 4, 123, NULL, '2025-01-01 10:11:53', '2025-01-01 10:11:53'),
(7, 'gfgfgfg', 'fgfgf', 'prepare', NULL, NULL, '2014-12-05', 4, 118, NULL, '2025-01-01 13:12:22', '2025-01-01 13:12:22'),
(8, 'sdd', 'ssxsx', 'Completed', NULL, '1735746353.jpg', NULL, 4, 127, NULL, '2025-01-01 15:45:12', '2025-01-01 15:45:53'),
(9, 'dfds', 'fdffdf', 'Completed', NULL, '1735746471.jpg', NULL, 4, 125, NULL, '2025-01-01 15:46:57', '2025-01-01 15:47:51'),
(10, 'ee', '2', 'Completed', NULL, '1735747777.jpg', NULL, 4, 128, NULL, '2025-01-01 16:00:30', '2025-01-01 16:09:37'),
(11, 'dcd', 'dcd', 'prepare', NULL, NULL, NULL, 4, 128, NULL, '2025-01-01 16:05:31', '2025-01-01 16:05:31'),
(12, 'wwwq', 'qwsw', 'prepare', NULL, NULL, NULL, 4, 128, NULL, '2025-01-01 16:09:22', '2025-01-01 16:09:22'),
(13, 'ded', 'eede', 'prepare', NULL, NULL, NULL, 4, 129, NULL, '2025-01-01 16:13:20', '2025-01-01 16:13:20'),
(14, 'd', 'mk', 'prepare', NULL, NULL, NULL, 4, 130, NULL, '2025-01-01 16:32:29', '2025-01-01 16:32:29'),
(15, 'd', 'cdd', 'prepare', NULL, NULL, NULL, 4, 132, NULL, '2025-01-01 16:38:34', '2025-01-01 16:38:34'),
(16, 'fvfv', 'fvfv', 'confirm', NULL, NULL, NULL, 4, 133, NULL, '2025-01-01 17:16:02', '2025-01-01 17:16:02'),
(17, 'z', 'zz', 'Completed', NULL, '1735780287.jpg', NULL, 4, 134, NULL, '2025-01-01 17:19:35', '2025-01-02 01:11:27'),
(18, '0123456789', 'Elite Home Services', 'Completed', NULL, '1736258076.png', NULL, 112, 136, 9, '2025-01-07 13:44:13', '2025-01-07 13:54:36'),
(19, '0123456789', 'HandyPro Solutions', 'confirm', NULL, NULL, NULL, 112, 143, 12, '2025-01-07 13:54:23', '2025-01-07 13:54:23');

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
-- Table structure for table `gardening_details`
--

CREATE TABLE `gardening_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `area` varchar(255) NOT NULL,
  `types_property` varchar(255) NOT NULL,
  `app_date` date NOT NULL,
  `preferred_time` varchar(255) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `budget` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gardening_details`
--

INSERT INTO `gardening_details` (`id`, `type`, `area`, `types_property`, `app_date`, `preferred_time`, `details`, `photo`, `budget`, `created_at`, `updated_at`) VALUES
(1, 'Flower Planting', 'Below 500 sqr ft', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-10', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-08 16:43:08', '2024-12-08 16:43:08'),
(2, 'Flower Planting', '500 - 1000 sqr ft', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-18', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM100000 - RM199999', '2024-12-18 08:31:53', '2024-12-18 08:31:53'),
(3, 'Flower Planting', '500 - 1000 sqr ft', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-18', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM100000 - RM199999', '2024-12-18 08:31:54', '2024-12-18 08:31:54'),
(4, 'Flower Planting', '500 - 1000 sqr ft', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-18', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM100000 - RM199999', '2024-12-18 08:31:54', '2024-12-18 08:31:54'),
(5, 'Flower Planting', 'Below 500 sqr ft', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-28', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM5000 - RM9999', '2024-12-27 16:14:35', '2024-12-27 16:14:35'),
(6, 'Flower Planting', 'Above 1000 sqr ft', 'Commercial (e.g. factory, shopping centre)', '2024-12-29', 'Lunch Time (11 AM - 1 PM)', NULL, '[]', 'RM5000 - RM9999', '2024-12-28 17:58:03', '2024-12-28 17:58:03'),
(7, 'Flower Planting', 'Above 1000 sqr ft', 'High-rise (e.g. condo, apartment)', '2024-12-29', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-28 18:05:56', '2024-12-28 18:05:56'),
(8, 'Flower Planting', '500 - 1000 sqr ft', 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Lunch Time (11 AM - 1 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM20000 - RM49999', '2024-12-31 02:45:56', '2024-12-31 02:45:56'),
(9, 'Flower Planting', 'Above 1000 sqr ft', 'High-rise (e.g. condo, apartment)', '2025-01-07', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070302.jpg', 'RM50000 - RM99999', '2025-01-07 13:11:59', '2025-01-07 13:11:59');

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
(3, '2014_10_12_100000_create_password_resets_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2023_08_11_073151_create_category_table', 1),
(7, '2023_08_11_074032_create_address_table', 1),
(8, '2023_08_11_082534_create_product_table', 1),
(9, '2023_08_11_085452_create_plant_table', 1),
(10, '2023_08_11_100801_create_bidding_table', 1),
(11, '2023_08_11_104120_create_cart_table', 1),
(12, '2023_08_11_110540_create_order_table', 1),
(13, '2023_08_11_112144_create_delivery_table', 1),
(14, '2023_08_11_112816_create_payment_table', 1),
(15, '2023_08_11_113455_create_order_detail_table', 1),
(16, '2023_12_07_073241_create_bidding_detail_table', 1),
(17, '2023_12_09_052757_create_custom_table', 1),
(19, '2024_11_08_213252_create_sessions_table', 2),
(40, '2024_12_03_224127_create_wiring_details_table', 3),
(41, '2024_12_03_225207_create_piping_details_table', 3),
(42, '2024_12_03_225449_create_gardening_details_table', 3),
(43, '2024_12_03_225457_create_runner_details_table', 3),
(44, '2024_12_03_230200_update_order_details_table', 3),
(45, '2024_12_07_004227_update_order_table', 3),
(46, '2024_12_25_170318_create_vendors_table', 4),
(47, '2024_12_25_170408_create_vendor_ratings_table', 5),
(48, '2024_12_26_124854_add_status_and_image_to_vendors_table', 6),
(51, '2024_12_27_223627_add_description_to_vendors_table', 7),
(54, '2024_12_30_234113_update_photo_column_in_wiring_piping_gardening_runner', 8),
(55, '2025_01_02_100414_add_user_id_to_vendors_table', 9),
(56, '2025_01_02_213704_add_vendor_id_to_delivery_table', 9),
(57, '2025_01_03_015722_add_ssm_to_vendor_table', 9),
(58, '2025_01_04_010659_add_category_to_vendor_table', 9),
(59, '2025_01_07_224619_add_comment_to_vendors_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `total_amount` double(8,2) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `address` varchar(255) NOT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `is_separate` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `price` double(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `status`, `date`, `total_amount`, `user_id`, `address`, `receiver_name`, `note`, `is_separate`, `created_at`, `updated_at`, `price`) VALUES
(1, 'cancel', '2024-11-19', 15.32, 4, 'hwhueyeje', NULL, NULL, NULL, '2024-11-18 16:08:30', '2024-11-29 04:38:25', 0.00),
(2, 'cancel', '2024-11-19', 15.32, 4, 'hwhueyeje', NULL, NULL, NULL, '2024-11-18 16:08:30', '2024-11-29 04:38:28', 0.00),
(3, 'cancel', '2024-11-19', 15.32, 4, 'hwhueyeje', NULL, NULL, NULL, '2024-11-18 16:08:54', '2024-11-29 04:38:21', 0.00),
(4, 'cancel', '2024-11-28', 100.00, 4, 'hwhueyeje', NULL, 'Custom order with Style 1', NULL, '2024-11-28 07:40:49', '2024-11-29 04:38:16', 0.00),
(5, 'pay', '2024-11-29', 8.95, 4, 'hwhueyeje', NULL, NULL, NULL, '2024-11-29 05:12:41', '2024-11-29 05:12:41', 0.00),
(6, 'pay', '2024-11-29', 15.32, 4, 'hwhueyeje', NULL, NULL, NULL, '2024-11-29 05:44:30', '2024-11-29 05:44:30', 0.00),
(7, 'pay', '2024-11-29', 15.32, 4, 'hwhueyeje', NULL, NULL, NULL, '2024-11-29 09:14:15', '2024-11-29 09:14:15', 0.00),
(8, 'pay', '2024-11-29', 8.95, 4, 'hwhueyeje', NULL, NULL, NULL, '2024-11-29 09:16:58', '2024-11-29 09:16:58', 0.00),
(9, 'completed', '2024-11-29', 8.95, 4, 'hwhueyeje', NULL, NULL, NULL, '2024-11-29 09:32:55', '2024-12-29 09:17:03', 0.00),
(10, 'pay', '2024-12-05', 8.95, 4, 'hwhueyeje', NULL, NULL, NULL, '2024-12-05 02:57:41', '2024-12-05 02:57:41', 0.00),
(11, 'ship', '2024-12-05', 8.95, 4, 'hwhueyeje', NULL, NULL, NULL, '2024-12-05 06:50:37', '2024-12-05 06:50:53', 0.00),
(12, 'pay', '2024-12-08', 50.00, 4, 'kk', NULL, NULL, NULL, '2024-12-08 14:11:54', '2024-12-08 14:11:54', 0.00),
(13, 'pay', '2024-12-08', 50.00, 4, 'j', NULL, NULL, NULL, '2024-12-08 15:01:57', '2024-12-08 15:01:57', 50.00),
(14, 'pay', '2024-12-08', 50.00, 4, 'k', NULL, NULL, NULL, '2024-12-08 15:59:11', '2024-12-08 15:59:11', 50.00),
(15, 'pay', '2024-12-09', 50.00, 4, 'k', NULL, NULL, NULL, '2024-12-08 16:08:07', '2024-12-08 16:08:07', 50.00),
(16, 'pay', '2024-12-09', 50.00, 4, 'k', NULL, NULL, NULL, '2024-12-08 16:10:30', '2024-12-08 16:10:30', 50.00),
(17, 'pay', '2024-12-09', 50.00, 4, 'jj', NULL, NULL, NULL, '2024-12-08 16:43:08', '2024-12-08 16:43:08', 50.00),
(18, 'pay', '2024-12-09', 50.00, 4, 'g', NULL, NULL, NULL, '2024-12-09 03:02:41', '2024-12-09 03:02:41', 50.00),
(19, 'pay', '2024-12-18', 50.00, 4, 'hh', NULL, NULL, NULL, '2024-12-18 08:31:53', '2024-12-18 08:31:53', 50.00),
(20, 'pay', '2024-12-18', 50.00, 4, 'hh', NULL, NULL, NULL, '2024-12-18 08:31:54', '2024-12-18 08:31:54', 50.00),
(21, 'pay', '2024-12-18', 50.00, 4, 'hh', NULL, NULL, NULL, '2024-12-18 08:31:54', '2024-12-18 08:31:54', 50.00),
(22, 'ship', '2024-12-19', 50.00, 4, 'dd', NULL, NULL, NULL, '2024-12-19 06:09:01', '2024-12-19 06:09:20', 50.00),
(23, 'ship', '2024-12-19', 50.00, 4, 'ch', NULL, NULL, NULL, '2024-12-19 07:26:15', '2024-12-19 07:26:31', 50.00),
(24, 'pay', '2024-12-19', 50.00, 4, 'gg', NULL, NULL, NULL, '2024-12-19 08:01:23', '2024-12-19 08:01:23', 50.00),
(25, 'ship', '2024-12-19', 50.00, 4, 'hhhjvghhh', NULL, NULL, NULL, '2024-12-19 08:05:11', '2024-12-19 08:05:28', 50.00),
(26, 'pay', '2024-12-20', 50.00, 4, 'ggh', NULL, NULL, NULL, '2024-12-20 15:56:43', '2024-12-20 15:56:43', 50.00),
(27, 'pay', '2024-12-21', 50.00, 4, 'hh', NULL, NULL, NULL, '2024-12-20 16:05:11', '2024-12-20 16:05:11', 50.00),
(28, 'pay', '2024-12-21', 50.00, 4, 'ghhh', NULL, NULL, NULL, '2024-12-20 16:06:41', '2024-12-20 16:06:41', 50.00),
(29, 'pay', '2024-12-21', 50.00, 4, 'ghfhfhfhdhdgdgd', NULL, NULL, NULL, '2024-12-21 09:04:44', '2024-12-21 09:04:44', 50.00),
(30, 'pay', '2024-12-22', 50.00, 4, 'dd', NULL, NULL, NULL, '2024-12-22 09:17:15', '2024-12-22 09:17:15', 50.00),
(31, 'pay', '2024-12-23', 50.00, 4, 'yu', NULL, NULL, NULL, '2024-12-23 13:03:40', '2024-12-23 13:03:40', 50.00),
(32, 'pay', '2024-12-24', 50.00, 4, 'huhu', NULL, NULL, NULL, '2024-12-24 01:33:34', '2024-12-24 01:33:34', 50.00),
(33, 'pay', '2024-12-24', 50.00, 4, 'jkaka', NULL, NULL, NULL, '2024-12-24 01:34:25', '2024-12-24 01:34:25', 50.00),
(34, 'pay', '2024-12-24', 50.00, 4, 'hhhh', NULL, NULL, NULL, '2024-12-24 01:39:12', '2024-12-24 01:39:12', 50.00),
(35, 'pay', '2024-12-24', 50.00, 4, 'hhhh', NULL, NULL, NULL, '2024-12-24 01:39:13', '2024-12-24 01:39:13', 50.00),
(36, 'pay', '2024-12-24', 50.00, 4, 'hhhh', NULL, NULL, NULL, '2024-12-24 01:39:13', '2024-12-24 01:39:13', 50.00),
(37, 'pay', '2024-12-24', 50.00, 4, 'hu', NULL, NULL, NULL, '2024-12-24 01:39:44', '2024-12-24 01:39:45', 50.00),
(38, 'pay', '2024-12-24', 50.00, 4, 'hj', NULL, NULL, NULL, '2024-12-24 01:49:54', '2024-12-24 01:49:54', 50.00),
(39, 'pay', '2024-12-24', 50.00, 4, 'huhh', NULL, NULL, NULL, '2024-12-24 01:57:40', '2024-12-24 01:57:40', 50.00),
(40, 'pay', '2024-12-24', 50.00, 4, 'koko', NULL, NULL, NULL, '2024-12-24 01:58:49', '2024-12-24 01:58:49', 50.00),
(41, 'pay', '2024-12-24', 50.00, 4, 'ghhh', NULL, NULL, NULL, '2024-12-24 02:00:12', '2024-12-24 02:00:12', 50.00),
(42, 'pay', '2024-12-24', 50.00, 4, 'jij', NULL, NULL, NULL, '2024-12-24 02:05:38', '2024-12-24 02:05:38', 50.00),
(43, 'pay', '2024-12-26', 50.00, 4, 'jffh', NULL, NULL, NULL, '2024-12-26 07:51:23', '2024-12-26 07:51:23', 50.00),
(44, 'pay', '2024-12-27', 50.00, 4, 'h', NULL, NULL, NULL, '2024-12-27 15:56:21', '2024-12-27 15:56:21', 50.00),
(45, 'pay', '2024-12-28', 50.00, 4, 'hhj', NULL, NULL, NULL, '2024-12-27 16:14:21', '2024-12-27 16:14:21', 50.00),
(46, 'pay', '2024-12-28', 50.00, 4, 'hh', NULL, NULL, NULL, '2024-12-27 16:14:35', '2024-12-27 16:14:35', 50.00),
(47, 'pay', '2024-12-28', 50.00, 4, 'hh', NULL, NULL, NULL, '2024-12-27 16:14:48', '2024-12-27 16:14:48', 50.00),
(48, 'pay', '2024-12-28', 50.00, 4, 'hh', NULL, NULL, NULL, '2024-12-28 07:14:17', '2024-12-28 07:14:17', 50.00),
(49, 'pay', '2024-12-28', 50.00, 4, 'gh', NULL, NULL, NULL, '2024-12-28 07:17:08', '2024-12-28 07:17:08', 50.00),
(50, 'pay', '2024-12-28', 50.00, 4, 'nj', NULL, NULL, NULL, '2024-12-28 07:44:14', '2024-12-28 07:44:14', 50.00),
(51, 'pay', '2024-12-29', 50.00, 4, 'bhh', NULL, NULL, NULL, '2024-12-28 17:06:38', '2024-12-28 17:06:38', 50.00),
(52, 'pay', '2024-12-29', 50.00, 4, 'vbb', NULL, NULL, NULL, '2024-12-28 17:15:58', '2024-12-28 17:15:58', 50.00),
(53, 'pay', '2024-12-29', 50.00, 4, 'gh', NULL, NULL, NULL, '2024-12-28 17:56:47', '2024-12-28 17:56:47', 50.00),
(54, 'pay', '2024-12-29', 50.00, 4, 'gh', NULL, NULL, NULL, '2024-12-28 17:58:03', '2024-12-28 17:58:03', 50.00),
(55, 'prepare', '2024-12-29', 50.00, 4, 'ty g', NULL, NULL, NULL, '2024-12-28 17:58:42', '2024-12-29 15:17:05', 50.00),
(56, 'prepare', '2024-12-29', 50.00, 4, 'ff', NULL, NULL, NULL, '2024-12-28 18:05:43', '2024-12-29 14:48:50', 50.00),
(57, 'cancel', '2024-12-29', 50.00, 4, 'ff', NULL, NULL, NULL, '2024-12-28 18:05:56', '2024-12-29 14:14:50', 50.00),
(58, 'confirm', '2024-12-29', 50.00, 4, 'd', NULL, NULL, NULL, '2024-12-28 18:06:08', '2024-12-29 09:18:01', 50.00),
(59, 'pay', '2024-12-30', 50.00, 4, 'tt', NULL, NULL, NULL, '2024-12-30 09:19:48', '2024-12-30 09:19:48', 50.00),
(60, 'pay', '2024-12-30', 50.00, 4, 'fggg', NULL, NULL, NULL, '2024-12-30 13:45:21', '2024-12-30 13:45:21', 50.00),
(61, 'pay', '2024-12-30', 50.00, 4, 'th', NULL, NULL, NULL, '2024-12-30 13:53:35', '2024-12-30 13:53:35', 50.00),
(62, 'pay', '2024-12-30', 50.00, 4, 'th', NULL, NULL, NULL, '2024-12-30 13:55:27', '2024-12-30 13:55:27', 50.00),
(63, 'pay', '2024-12-30', 50.00, 4, 'th', NULL, NULL, NULL, '2024-12-30 13:55:33', '2024-12-30 13:55:33', 50.00),
(64, 'pay', '2024-12-30', 50.00, 4, 'rhrhr', NULL, NULL, NULL, '2024-12-30 14:36:02', '2024-12-30 14:36:02', 50.00),
(65, 'pay', '2024-12-30', 50.00, 4, 'grgrvr', NULL, NULL, NULL, '2024-12-30 14:47:09', '2024-12-30 14:47:09', 50.00),
(66, 'pay', '2024-12-30', 50.00, 4, 'drg', NULL, NULL, NULL, '2024-12-30 14:52:45', '2024-12-30 14:52:46', 50.00),
(67, 'pay', '2024-12-30', 50.00, 4, 'hh', NULL, NULL, NULL, '2024-12-30 15:17:46', '2024-12-30 15:17:46', 50.00),
(68, 'pay', '2024-12-30', 50.00, 4, 'uh', NULL, NULL, NULL, '2024-12-30 15:23:35', '2024-12-30 15:23:35', 50.00),
(69, 'pay', '2024-12-30', 50.00, 4, 'tt', NULL, NULL, NULL, '2024-12-30 15:24:52', '2024-12-30 15:24:52', 50.00),
(70, 'pay', '2024-12-30', 50.00, 4, 'geveg', NULL, NULL, NULL, '2024-12-30 15:37:35', '2024-12-30 15:37:35', 50.00),
(71, 'pay', '2024-12-31', 50.00, 4, 'dd', NULL, NULL, NULL, '2024-12-30 16:02:13', '2024-12-30 16:02:13', 50.00),
(72, 'pay', '2024-12-31', 50.00, 4, 'rfrg', NULL, NULL, NULL, '2024-12-30 16:06:29', '2024-12-30 16:06:29', 50.00),
(73, 'pay', '2024-12-31', 50.00, 4, 'grfrfe', NULL, NULL, NULL, '2024-12-30 16:08:07', '2024-12-30 16:08:07', 50.00),
(74, 'pay', '2024-12-31', 50.00, 4, 'thr', NULL, NULL, NULL, '2024-12-30 16:15:02', '2024-12-30 16:15:02', 50.00),
(75, 'pay', '2024-12-31', 50.00, 4, 'tut', NULL, NULL, NULL, '2024-12-30 16:17:14', '2024-12-30 16:17:14', 50.00),
(76, 'pay', '2024-12-31', 50.00, 4, 'vdv', NULL, NULL, NULL, '2024-12-30 16:21:31', '2024-12-30 16:21:31', 50.00),
(77, 'pay', '2024-12-31', 50.00, 4, 'tit', NULL, NULL, NULL, '2024-12-30 16:24:00', '2024-12-30 16:24:00', 50.00),
(78, 'pay', '2024-12-31', 50.00, 4, 'tefe', NULL, NULL, NULL, '2024-12-30 16:26:08', '2024-12-30 16:26:08', 50.00),
(79, 'pay', '2024-12-31', 50.00, 4, 'tefe', NULL, NULL, NULL, '2024-12-30 16:26:14', '2024-12-30 16:26:14', 50.00),
(80, 'pay', '2024-12-31', 50.00, 4, 'tefe', NULL, NULL, NULL, '2024-12-30 16:26:30', '2024-12-30 16:26:30', 50.00),
(81, 'pay', '2024-12-31', 50.00, 4, 'gege', NULL, NULL, NULL, '2024-12-30 16:39:04', '2024-12-30 16:39:04', 50.00),
(82, 'pay', '2024-12-31', 50.00, 4, 'grg', NULL, NULL, NULL, '2024-12-30 16:40:20', '2024-12-30 16:40:20', 50.00),
(83, 'pay', '2024-12-31', 50.00, 4, 'vrg', NULL, NULL, NULL, '2024-12-30 16:40:35', '2024-12-30 16:40:35', 50.00),
(84, 'pay', '2024-12-31', 50.00, 4, 'grrg', NULL, NULL, NULL, '2024-12-30 16:43:51', '2024-12-30 16:43:51', 50.00),
(85, 'pay', '2024-12-31', 50.00, 4, 'grr', NULL, NULL, NULL, '2024-12-30 16:46:23', '2024-12-30 16:46:23', 50.00),
(86, 'pay', '2024-12-31', 50.00, 4, 'fefe', NULL, NULL, NULL, '2024-12-30 16:47:35', '2024-12-30 16:47:35', 50.00),
(87, 'pay', '2024-12-31', 50.00, 4, 'vdvd', NULL, NULL, NULL, '2024-12-30 16:49:20', '2024-12-30 16:49:20', 50.00),
(88, 'pay', '2024-12-31', 50.00, 4, 'fecd', NULL, NULL, NULL, '2024-12-30 16:50:52', '2024-12-30 16:50:52', 50.00),
(89, 'pay', '2024-12-31', 50.00, 4, 'vdv', NULL, NULL, NULL, '2024-12-30 16:53:42', '2024-12-30 16:53:42', 50.00),
(90, 'pay', '2024-12-31', 50.00, 4, 'dc', NULL, NULL, NULL, '2024-12-30 16:57:34', '2024-12-30 16:57:34', 50.00),
(91, 'pay', '2024-12-31', 50.00, 4, 'hrfgh', NULL, NULL, NULL, '2024-12-30 16:59:03', '2024-12-30 16:59:03', 50.00),
(92, 'pay', '2024-12-31', 50.00, 4, 'kh', NULL, NULL, NULL, '2024-12-30 17:07:31', '2024-12-30 17:07:31', 50.00),
(93, 'pay', '2024-12-31', 50.00, 4, 'grg', NULL, NULL, NULL, '2024-12-30 17:10:38', '2024-12-30 17:10:38', 50.00),
(94, 'pay', '2024-12-31', 50.00, 4, 'yigug', NULL, NULL, NULL, '2024-12-30 17:11:13', '2024-12-30 17:11:13', 50.00),
(95, 'pay', '2024-12-31', 50.00, 4, 'cvg', NULL, NULL, NULL, '2024-12-30 17:21:55', '2024-12-30 17:21:55', 50.00),
(96, 'pay', '2024-12-31', 50.00, 4, 'hhh', NULL, NULL, NULL, '2024-12-30 17:22:48', '2024-12-30 17:22:48', 50.00),
(97, 'pay', '2024-12-31', 50.00, 4, 'bfhfhf', NULL, NULL, NULL, '2024-12-30 17:28:21', '2024-12-30 17:28:21', 50.00),
(98, 'pay', '2024-12-31', 50.00, 4, 'jfhfj', NULL, NULL, NULL, '2024-12-30 17:33:10', '2024-12-30 17:33:10', 50.00),
(99, 'pay', '2024-12-31', 50.00, 4, 'ncn', NULL, NULL, NULL, '2024-12-30 17:33:43', '2024-12-30 17:33:43', 50.00),
(100, 'pay', '2024-12-31', 50.00, 4, 'fjf', NULL, NULL, NULL, '2024-12-30 17:37:33', '2024-12-30 17:37:33', 50.00),
(101, 'pay', '2024-12-31', 50.00, 4, 'gh', NULL, NULL, NULL, '2024-12-30 17:41:22', '2024-12-30 17:41:22', 50.00),
(102, 'pay', '2024-12-31', 50.00, 4, 'tg', NULL, NULL, NULL, '2024-12-30 17:43:36', '2024-12-30 17:43:36', 50.00),
(103, 'pay', '2024-12-31', 50.00, 4, 'rte', NULL, NULL, NULL, '2024-12-30 17:57:31', '2024-12-30 17:57:31', 50.00),
(104, 'pay', '2024-12-31', 50.00, 4, 'hdhd', NULL, NULL, NULL, '2024-12-30 17:57:49', '2024-12-30 17:57:49', 50.00),
(105, 'pay', '2024-12-31', 50.00, 4, 'ege', NULL, NULL, NULL, '2024-12-31 01:11:33', '2024-12-31 01:11:33', 50.00),
(106, 'pay', '2024-12-31', 50.00, 4, 'vdvd', NULL, NULL, NULL, '2024-12-31 01:17:13', '2024-12-31 01:17:13', 50.00),
(107, 'pay', '2024-12-31', 50.00, 4, 'gfv', NULL, NULL, NULL, '2024-12-31 01:19:14', '2024-12-31 01:19:14', 50.00),
(108, 'pay', '2024-12-31', 50.00, 4, 'grgrvr', NULL, NULL, NULL, '2024-12-31 01:26:31', '2024-12-31 01:26:31', 50.00),
(109, 'pay', '2024-12-31', 50.00, 4, 'grge', NULL, NULL, NULL, '2024-12-31 01:28:43', '2024-12-31 01:28:43', 50.00),
(110, 'pay', '2024-12-31', 50.00, 4, 'fbf', NULL, NULL, NULL, '2024-12-31 01:32:14', '2024-12-31 01:32:14', 50.00),
(111, 'pay', '2024-12-31', 50.00, 4, 'vdvd', NULL, NULL, NULL, '2024-12-31 01:36:12', '2024-12-31 01:36:12', 50.00),
(112, 'pay', '2024-12-31', 50.00, 4, 'vdvdgegrtht', NULL, NULL, NULL, '2024-12-31 01:39:51', '2024-12-31 01:39:51', 50.00),
(113, 'pay', '2024-12-31', 50.00, 4, 'bhf', NULL, NULL, NULL, '2024-12-31 01:49:12', '2024-12-31 01:49:12', 50.00),
(114, 'pay', '2024-12-31', 50.00, 4, 'grgrgrr', NULL, NULL, NULL, '2024-12-31 01:54:21', '2024-12-31 01:54:21', 50.00),
(115, 'pay', '2024-12-31', 50.00, 4, 'vdvd', NULL, NULL, NULL, '2024-12-31 01:56:17', '2024-12-31 01:56:17', 50.00),
(116, 'pay', '2024-12-31', 50.00, 4, 'hhfd', NULL, NULL, NULL, '2024-12-31 02:01:37', '2024-12-31 02:01:37', 50.00),
(117, 'prepare', '2024-12-31', 50.00, 4, 'grgg', NULL, NULL, NULL, '2024-12-31 02:10:10', '2024-12-31 02:19:15', 50.00),
(118, 'confirm', '2024-12-31', 50.00, 4, 'bdb', NULL, NULL, '1', '2024-12-31 02:11:07', '2025-01-01 13:12:22', 50.00),
(119, 'pay', '2024-12-31', 50.00, 4, 'gegsfs', NULL, NULL, NULL, '2024-12-31 02:32:49', '2024-12-31 02:32:49', 50.00),
(120, 'pay', '2024-12-31', 50.00, 4, 'dgd', NULL, NULL, NULL, '2024-12-31 02:35:15', '2024-12-31 02:35:15', 50.00),
(121, 'pay', '2024-12-31', 50.00, 4, 'yrgrg', NULL, NULL, NULL, '2024-12-31 02:42:15', '2024-12-31 02:42:15', 50.00),
(122, 'pay', '2024-12-31', 50.00, 4, 'gdh', NULL, NULL, NULL, '2024-12-31 02:44:20', '2024-12-31 02:44:20', 50.00),
(123, 'confirm', '2024-12-31', 50.00, 4, 'gdvd', NULL, NULL, NULL, '2024-12-31 02:45:56', '2025-01-01 10:11:53', 50.00),
(124, 'confirm', '2024-12-31', 50.00, 4, 'gdg', NULL, NULL, NULL, '2024-12-31 02:46:10', '2025-01-01 10:03:43', 50.00),
(125, 'confirm', '2024-12-31', 50.00, 4, 'gdge', NULL, NULL, NULL, '2024-12-31 02:46:27', '2025-01-01 15:46:57', 50.00),
(126, 'partial', '2024-12-31', 50.00, 4, 'utu', NULL, NULL, '1', '2024-12-31 03:39:12', '2025-01-01 10:01:03', 50.00),
(127, 'confirm', '2024-12-31', 50.00, 4, 'hg', NULL, NULL, NULL, '2024-12-31 03:41:20', '2025-01-01 15:45:12', 50.00),
(128, 'confirm', '2025-01-01', 50.00, 4, 'dhfhf', NULL, NULL, NULL, '2025-01-01 15:59:39', '2025-01-01 16:09:22', 50.00),
(129, 'confirm', '2025-01-02', 50.00, 4, 'gfg', NULL, NULL, NULL, '2025-01-01 16:12:45', '2025-01-01 16:13:20', 50.00),
(130, 'confirm', '2025-01-02', 50.00, 4, 'vdvd', NULL, NULL, NULL, '2025-01-01 16:31:54', '2025-01-01 16:32:29', 50.00),
(131, 'pay', '2025-01-02', 50.00, 4, 'gefe', NULL, NULL, NULL, '2025-01-01 16:37:19', '2025-01-01 16:37:19', 50.00),
(132, 'confirm', '2025-01-02', 50.00, 4, 'gefe', NULL, NULL, NULL, '2025-01-01 16:37:35', '2025-01-01 16:38:34', 50.00),
(133, 'prepare', '2025-01-02', 50.00, 4, 'gugj', NULL, NULL, NULL, '2025-01-01 17:15:34', '2025-01-01 17:15:48', 50.00),
(134, 'completed', '2025-01-02', 50.00, 4, 'yvyg', NULL, NULL, NULL, '2025-01-01 17:18:57', '2025-01-02 01:11:27', 50.00),
(135, 'pay', '2025-01-07', 50.00, 112, 'gubjbuh', NULL, NULL, NULL, '2025-01-07 13:09:44', '2025-01-07 13:09:44', 50.00),
(136, 'completed', '2025-01-07', 50.00, 112, 'vhh', NULL, NULL, NULL, '2025-01-07 13:11:11', '2025-01-07 13:54:36', 50.00),
(137, 'pay', '2025-01-07', 50.00, 112, 'ggh', NULL, NULL, NULL, '2025-01-07 13:11:59', '2025-01-07 13:11:59', 50.00),
(138, 'pay', '2025-01-07', 50.00, 112, 'ghhj', NULL, NULL, NULL, '2025-01-07 13:14:06', '2025-01-07 13:14:06', 50.00),
(139, 'pay', '2025-01-07', 50.00, 112, 'hh jj', NULL, NULL, NULL, '2025-01-07 13:20:21', '2025-01-07 13:20:21', 50.00),
(140, 'pay', '2025-01-07', 50.00, 112, 'ghh', NULL, NULL, NULL, '2025-01-07 13:27:37', '2025-01-07 13:27:37', 50.00),
(141, 'pay', '2025-01-07', 50.00, 112, 'ghh', NULL, NULL, NULL, '2025-01-07 13:29:26', '2025-01-07 13:29:26', 50.00),
(142, 'prepare', '2025-01-07', 50.00, 112, 'hh', NULL, NULL, NULL, '2025-01-07 13:30:45', '2025-01-07 13:54:03', 50.00),
(143, 'confirm', '2025-01-07', 50.00, 112, 'hh', NULL, NULL, NULL, '2025-01-07 13:30:55', '2025-01-07 13:54:23', 50.00),
(144, 'pay', '2025-01-07', 50.00, 112, 'jianain', NULL, NULL, NULL, '2025-01-07 13:57:49', '2025-01-07 13:57:49', 50.00),
(145, 'pay', '2025-01-07', 50.00, 112, 'gjj', NULL, NULL, NULL, '2025-01-07 13:59:43', '2025-01-07 13:59:43', 50.00),
(146, 'pay', '2025-01-07', 50.00, 112, 'hhj', NULL, NULL, NULL, '2025-01-07 14:01:55', '2025-01-07 14:01:55', 50.00);

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double(8,2) NOT NULL,
  `amount` double(8,2) NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `plant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `delivery_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bidding_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `wiring_id` bigint(20) UNSIGNED DEFAULT NULL,
  `piping_id` bigint(20) UNSIGNED DEFAULT NULL,
  `gardening_id` bigint(20) UNSIGNED DEFAULT NULL,
  `runner_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_detail`
--

INSERT INTO `order_detail` (`id`, `quantity`, `price`, `amount`, `order_id`, `remark`, `product_id`, `plant_id`, `delivery_id`, `bidding_id`, `created_at`, `updated_at`, `wiring_id`, `piping_id`, `gardening_id`, `runner_id`) VALUES
(26, 1, 50.00, 50.00, 26, NULL, NULL, NULL, NULL, NULL, '2024-12-20 15:56:43', '2024-12-20 15:56:43', 6, NULL, NULL, NULL),
(27, 1, 50.00, 50.00, 27, NULL, NULL, NULL, NULL, NULL, '2024-12-20 16:05:11', '2024-12-20 16:05:11', 7, NULL, NULL, NULL),
(28, 1, 50.00, 50.00, 28, NULL, NULL, NULL, NULL, NULL, '2024-12-20 16:06:41', '2024-12-20 16:06:41', 8, NULL, NULL, NULL),
(29, 1, 50.00, 50.00, 29, NULL, 2, NULL, NULL, NULL, '2024-12-21 09:04:44', '2024-12-21 09:04:44', 9, NULL, NULL, NULL),
(30, 1, 50.00, 50.00, 30, NULL, 2, NULL, NULL, NULL, '2024-12-22 09:17:15', '2024-12-22 09:17:15', 10, NULL, NULL, NULL),
(31, 1, 50.00, 50.00, 31, NULL, 2, NULL, NULL, NULL, '2024-12-23 13:03:40', '2024-12-23 13:03:40', 11, NULL, NULL, NULL),
(32, 1, 50.00, 50.00, 32, NULL, 2, NULL, NULL, NULL, '2024-12-24 01:33:34', '2024-12-24 01:33:34', 12, NULL, NULL, NULL),
(33, 1, 50.00, 50.00, 33, NULL, 2, NULL, NULL, NULL, '2024-12-24 01:34:25', '2024-12-24 01:34:25', 13, NULL, NULL, NULL),
(34, 1, 50.00, 50.00, 34, NULL, 2, NULL, NULL, NULL, '2024-12-24 01:39:12', '2024-12-24 01:39:12', 14, NULL, NULL, NULL),
(35, 1, 50.00, 50.00, 35, NULL, 2, NULL, NULL, NULL, '2024-12-24 01:39:13', '2024-12-24 01:39:13', 15, NULL, NULL, NULL),
(36, 1, 50.00, 50.00, 36, NULL, 2, NULL, NULL, NULL, '2024-12-24 01:39:13', '2024-12-24 01:39:13', 16, NULL, NULL, NULL),
(37, 1, 50.00, 50.00, 37, NULL, 2, NULL, NULL, NULL, '2024-12-24 01:39:44', '2024-12-24 01:39:44', 17, NULL, NULL, NULL),
(38, 1, 50.00, 50.00, 38, NULL, 2, NULL, NULL, NULL, '2024-12-24 01:49:54', '2024-12-24 01:49:54', 18, NULL, NULL, NULL),
(39, 1, 50.00, 50.00, 39, NULL, 2, NULL, NULL, NULL, '2024-12-24 01:57:40', '2024-12-24 01:57:40', 19, NULL, NULL, NULL),
(40, 1, 50.00, 50.00, 40, NULL, 2, NULL, NULL, NULL, '2024-12-24 01:58:49', '2024-12-24 01:58:49', 20, NULL, NULL, NULL),
(41, 1, 50.00, 50.00, 41, NULL, 2, NULL, NULL, NULL, '2024-12-24 02:00:12', '2024-12-24 02:00:12', 21, NULL, NULL, NULL),
(42, 1, 50.00, 50.00, 42, NULL, 2, NULL, NULL, NULL, '2024-12-24 02:05:38', '2024-12-24 02:05:38', 22, NULL, NULL, NULL),
(43, 1, 50.00, 50.00, 43, NULL, 2, NULL, NULL, NULL, '2024-12-26 07:51:23', '2024-12-26 07:51:23', 23, NULL, NULL, NULL),
(44, 1, 50.00, 50.00, 44, NULL, NULL, NULL, NULL, NULL, '2024-12-27 15:56:21', '2024-12-27 15:56:21', NULL, 2, NULL, NULL),
(45, 1, 50.00, 50.00, 45, NULL, NULL, NULL, NULL, NULL, '2024-12-27 16:14:21', '2024-12-27 16:14:21', NULL, 3, NULL, NULL),
(46, 1, 50.00, 50.00, 46, NULL, NULL, NULL, NULL, NULL, '2024-12-27 16:14:35', '2024-12-27 16:14:35', NULL, NULL, 5, NULL),
(47, 1, 50.00, 50.00, 47, NULL, NULL, NULL, NULL, NULL, '2024-12-27 16:14:48', '2024-12-27 16:14:48', NULL, NULL, NULL, 2),
(48, 1, 50.00, 50.00, 48, NULL, 2, NULL, NULL, NULL, '2024-12-28 07:14:17', '2024-12-28 07:14:17', 24, NULL, NULL, NULL),
(49, 1, 50.00, 50.00, 49, NULL, 2, NULL, NULL, NULL, '2024-12-28 07:17:08', '2024-12-28 07:17:08', 25, NULL, NULL, NULL),
(50, 1, 50.00, 50.00, 50, NULL, 2, NULL, NULL, NULL, '2024-12-28 07:44:14', '2024-12-28 07:44:14', 26, NULL, NULL, NULL),
(51, 1, 50.00, 50.00, 51, NULL, 2, NULL, NULL, NULL, '2024-12-28 17:06:38', '2024-12-28 17:06:38', 27, NULL, NULL, NULL),
(52, 1, 50.00, 50.00, 52, NULL, 2, NULL, NULL, NULL, '2024-12-28 17:15:58', '2024-12-28 17:15:58', 28, NULL, NULL, NULL),
(53, 1, 50.00, 50.00, 53, NULL, NULL, NULL, NULL, NULL, '2024-12-28 17:56:47', '2024-12-28 17:56:47', NULL, 4, NULL, NULL),
(54, 1, 50.00, 50.00, 54, NULL, NULL, NULL, NULL, NULL, '2024-12-28 17:58:03', '2024-12-28 17:58:03', NULL, NULL, 6, NULL),
(55, 1, 50.00, 50.00, 55, NULL, NULL, NULL, NULL, NULL, '2024-12-28 17:58:42', '2024-12-28 17:58:42', NULL, NULL, NULL, 3),
(56, 1, 50.00, 50.00, 56, NULL, 3, NULL, NULL, NULL, '2024-12-28 18:05:43', '2024-12-28 18:05:43', NULL, 5, NULL, NULL),
(57, 1, 50.00, 50.00, 57, NULL, 4, NULL, NULL, NULL, '2024-12-28 18:05:56', '2024-12-28 18:05:56', NULL, NULL, 7, NULL),
(58, 1, 50.00, 50.00, 58, '1', 5, NULL, 2, NULL, '2024-12-28 18:06:08', '2024-12-29 09:18:01', NULL, NULL, NULL, 4),
(59, 1, 50.00, 50.00, 59, NULL, 2, NULL, NULL, NULL, '2024-12-30 09:19:48', '2024-12-30 09:19:48', 29, NULL, NULL, NULL),
(60, 1, 50.00, 50.00, 60, NULL, 2, NULL, NULL, NULL, '2024-12-30 13:45:21', '2024-12-30 13:45:21', 30, NULL, NULL, NULL),
(61, 1, 50.00, 50.00, 64, NULL, 2, NULL, NULL, NULL, '2024-12-30 14:36:02', '2024-12-30 14:36:02', 31, NULL, NULL, NULL),
(62, 1, 50.00, 50.00, 65, NULL, 2, NULL, NULL, NULL, '2024-12-30 14:47:09', '2024-12-30 14:47:09', 32, NULL, NULL, NULL),
(63, 1, 50.00, 50.00, 66, NULL, 2, NULL, NULL, NULL, '2024-12-30 14:52:46', '2024-12-30 14:52:46', 33, NULL, NULL, NULL),
(64, 1, 50.00, 50.00, 67, NULL, 2, NULL, NULL, NULL, '2024-12-30 15:17:46', '2024-12-30 15:17:46', 34, NULL, NULL, NULL),
(65, 1, 50.00, 50.00, 68, NULL, 2, NULL, NULL, NULL, '2024-12-30 15:23:35', '2024-12-30 15:23:35', 35, NULL, NULL, NULL),
(66, 1, 50.00, 50.00, 69, NULL, 2, NULL, NULL, NULL, '2024-12-30 15:24:52', '2024-12-30 15:24:52', 36, NULL, NULL, NULL),
(67, 1, 50.00, 50.00, 71, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:02:13', '2024-12-30 16:02:13', 37, NULL, NULL, NULL),
(68, 1, 50.00, 50.00, 72, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:06:29', '2024-12-30 16:06:29', 38, NULL, NULL, NULL),
(69, 1, 50.00, 50.00, 73, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:08:07', '2024-12-30 16:08:07', 39, NULL, NULL, NULL),
(70, 1, 50.00, 50.00, 74, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:15:02', '2024-12-30 16:15:02', 40, NULL, NULL, NULL),
(71, 1, 50.00, 50.00, 76, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:21:31', '2024-12-30 16:21:31', 41, NULL, NULL, NULL),
(72, 1, 50.00, 50.00, 78, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:26:08', '2024-12-30 16:26:08', 42, NULL, NULL, NULL),
(73, 1, 50.00, 50.00, 79, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:26:14', '2024-12-30 16:26:14', 43, NULL, NULL, NULL),
(74, 1, 50.00, 50.00, 80, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:26:30', '2024-12-30 16:26:30', 44, NULL, NULL, NULL),
(75, 1, 50.00, 50.00, 81, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:39:04', '2024-12-30 16:39:04', 45, NULL, NULL, NULL),
(76, 1, 50.00, 50.00, 82, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:40:20', '2024-12-30 16:40:20', 46, NULL, NULL, NULL),
(77, 1, 50.00, 50.00, 83, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:40:35', '2024-12-30 16:40:35', 47, NULL, NULL, NULL),
(78, 1, 50.00, 50.00, 84, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:43:51', '2024-12-30 16:43:51', 48, NULL, NULL, NULL),
(79, 1, 50.00, 50.00, 85, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:46:23', '2024-12-30 16:46:23', 49, NULL, NULL, NULL),
(80, 1, 50.00, 50.00, 86, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:47:35', '2024-12-30 16:47:35', 50, NULL, NULL, NULL),
(81, 1, 50.00, 50.00, 87, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:49:20', '2024-12-30 16:49:20', 51, NULL, NULL, NULL),
(82, 1, 50.00, 50.00, 88, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:50:52', '2024-12-30 16:50:52', 52, NULL, NULL, NULL),
(83, 1, 50.00, 50.00, 89, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:53:42', '2024-12-30 16:53:42', 53, NULL, NULL, NULL),
(84, 1, 50.00, 50.00, 90, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:57:34', '2024-12-30 16:57:34', 54, NULL, NULL, NULL),
(85, 1, 50.00, 50.00, 91, NULL, 2, NULL, NULL, NULL, '2024-12-30 16:59:03', '2024-12-30 16:59:03', 55, NULL, NULL, NULL),
(86, 1, 50.00, 50.00, 92, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:07:31', '2024-12-30 17:07:31', 56, NULL, NULL, NULL),
(87, 1, 50.00, 50.00, 93, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:10:38', '2024-12-30 17:10:38', 57, NULL, NULL, NULL),
(88, 1, 50.00, 50.00, 94, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:11:13', '2024-12-30 17:11:13', 58, NULL, NULL, NULL),
(89, 1, 50.00, 50.00, 95, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:21:55', '2024-12-30 17:21:55', 59, NULL, NULL, NULL),
(90, 1, 50.00, 50.00, 96, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:22:48', '2024-12-30 17:22:48', 60, NULL, NULL, NULL),
(91, 1, 50.00, 50.00, 97, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:28:21', '2024-12-30 17:28:21', 61, NULL, NULL, NULL),
(92, 1, 50.00, 50.00, 98, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:33:10', '2024-12-30 17:33:10', 62, NULL, NULL, NULL),
(93, 1, 50.00, 50.00, 99, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:33:43', '2024-12-30 17:33:43', 63, NULL, NULL, NULL),
(94, 1, 50.00, 50.00, 100, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:37:33', '2024-12-30 17:37:33', 64, NULL, NULL, NULL),
(95, 1, 50.00, 50.00, 101, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:41:22', '2024-12-30 17:41:22', 65, NULL, NULL, NULL),
(96, 1, 50.00, 50.00, 102, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:43:36', '2024-12-30 17:43:36', 66, NULL, NULL, NULL),
(97, 1, 50.00, 50.00, 103, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:57:31', '2024-12-30 17:57:31', 67, NULL, NULL, NULL),
(98, 1, 50.00, 50.00, 104, NULL, 2, NULL, NULL, NULL, '2024-12-30 17:57:49', '2024-12-30 17:57:49', 68, NULL, NULL, NULL),
(99, 1, 50.00, 50.00, 105, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:11:33', '2024-12-31 01:11:33', 69, NULL, NULL, NULL),
(100, 1, 50.00, 50.00, 106, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:17:13', '2024-12-31 01:17:13', 70, NULL, NULL, NULL),
(101, 1, 50.00, 50.00, 107, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:19:14', '2024-12-31 01:19:14', 71, NULL, NULL, NULL),
(102, 1, 50.00, 50.00, 108, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:26:31', '2024-12-31 01:26:31', 72, NULL, NULL, NULL),
(103, 1, 50.00, 50.00, 109, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:28:43', '2024-12-31 01:28:43', 73, NULL, NULL, NULL),
(104, 1, 50.00, 50.00, 110, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:32:14', '2024-12-31 01:32:14', 74, NULL, NULL, NULL),
(105, 1, 50.00, 50.00, 111, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:36:12', '2024-12-31 01:36:12', 75, NULL, NULL, NULL),
(106, 1, 50.00, 50.00, 112, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:39:51', '2024-12-31 01:39:51', 76, NULL, NULL, NULL),
(107, 1, 50.00, 50.00, 113, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:49:12', '2024-12-31 01:49:12', 77, NULL, NULL, NULL),
(108, 1, 50.00, 50.00, 114, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:54:21', '2024-12-31 01:54:21', 78, NULL, NULL, NULL),
(109, 1, 50.00, 50.00, 115, NULL, 2, NULL, NULL, NULL, '2024-12-31 01:56:17', '2024-12-31 01:56:17', 79, NULL, NULL, NULL),
(110, 1, 50.00, 50.00, 116, NULL, 2, NULL, NULL, NULL, '2024-12-31 02:01:37', '2024-12-31 02:01:37', 80, NULL, NULL, NULL),
(111, 1, 50.00, 50.00, 117, NULL, 2, NULL, NULL, NULL, '2024-12-31 02:10:10', '2024-12-31 02:10:10', 81, NULL, NULL, NULL),
(112, 1, 50.00, 50.00, 118, NULL, 2, NULL, NULL, NULL, '2024-12-31 02:11:07', '2024-12-31 02:11:07', 82, NULL, NULL, NULL),
(113, 1, 50.00, 50.00, 119, NULL, 2, NULL, NULL, NULL, '2024-12-31 02:32:49', '2024-12-31 02:32:49', 83, NULL, NULL, NULL),
(114, 1, 50.00, 50.00, 120, NULL, 2, NULL, NULL, NULL, '2024-12-31 02:35:15', '2024-12-31 02:35:15', 84, NULL, NULL, NULL),
(115, 1, 50.00, 50.00, 121, NULL, 3, NULL, NULL, NULL, '2024-12-31 02:42:15', '2024-12-31 02:42:15', NULL, 6, NULL, NULL),
(116, 1, 50.00, 50.00, 122, NULL, 3, NULL, NULL, NULL, '2024-12-31 02:44:20', '2024-12-31 02:44:20', NULL, 7, NULL, NULL),
(117, 1, 50.00, 50.00, 123, NULL, 4, NULL, NULL, NULL, '2024-12-31 02:45:56', '2024-12-31 02:45:56', NULL, NULL, 8, NULL),
(118, 1, 50.00, 50.00, 124, NULL, 5, NULL, NULL, NULL, '2024-12-31 02:46:10', '2024-12-31 02:46:10', NULL, NULL, NULL, 5),
(119, 1, 50.00, 50.00, 125, NULL, 2, NULL, NULL, NULL, '2024-12-31 02:46:27', '2024-12-31 02:46:27', 85, NULL, NULL, NULL),
(120, 1, 50.00, 50.00, 126, NULL, 3, NULL, NULL, NULL, '2024-12-31 03:39:12', '2024-12-31 03:39:12', NULL, 8, NULL, NULL),
(121, 1, 50.00, 50.00, 127, NULL, 3, NULL, NULL, NULL, '2024-12-31 03:41:20', '2024-12-31 03:41:20', NULL, 9, NULL, NULL),
(122, 1, 50.00, 50.00, 128, '1', 2, NULL, 12, NULL, '2025-01-01 15:59:39', '2025-01-01 16:09:22', 86, NULL, NULL, NULL),
(123, 1, 50.00, 50.00, 129, '1', 2, NULL, 13, NULL, '2025-01-01 16:12:45', '2025-01-01 16:13:20', 87, NULL, NULL, NULL),
(124, 1, 50.00, 50.00, 130, '1', 2, NULL, 14, NULL, '2025-01-01 16:31:54', '2025-01-01 16:32:29', 88, NULL, NULL, NULL),
(125, 1, 50.00, 50.00, 131, NULL, 2, NULL, NULL, NULL, '2025-01-01 16:37:19', '2025-01-01 16:37:19', 89, NULL, NULL, NULL),
(126, 1, 50.00, 50.00, 132, '1', 2, NULL, 15, NULL, '2025-01-01 16:37:35', '2025-01-01 16:38:34', 90, NULL, NULL, NULL),
(127, 1, 50.00, 50.00, 133, '1', 2, NULL, 16, NULL, '2025-01-01 17:15:34', '2025-01-01 17:16:02', 91, NULL, NULL, NULL),
(128, 1, 50.00, 50.00, 134, '1', 2, NULL, 17, NULL, '2025-01-01 17:18:57', '2025-01-01 17:19:35', 92, NULL, NULL, NULL),
(129, 1, 50.00, 50.00, 135, NULL, 2, NULL, NULL, NULL, '2025-01-07 13:09:44', '2025-01-07 13:09:44', 93, NULL, NULL, NULL),
(130, 1, 50.00, 50.00, 136, '1', 3, NULL, 18, NULL, '2025-01-07 13:11:11', '2025-01-07 13:44:13', NULL, 10, NULL, NULL),
(131, 1, 50.00, 50.00, 137, NULL, 4, NULL, NULL, NULL, '2025-01-07 13:11:59', '2025-01-07 13:11:59', NULL, NULL, 9, NULL),
(132, 1, 50.00, 50.00, 138, NULL, 5, NULL, NULL, NULL, '2025-01-07 13:14:06', '2025-01-07 13:14:06', NULL, NULL, NULL, 6),
(133, 1, 50.00, 50.00, 139, NULL, 5, NULL, NULL, NULL, '2025-01-07 13:20:21', '2025-01-07 13:20:21', NULL, NULL, NULL, 7),
(134, 1, 50.00, 50.00, 140, NULL, 2, NULL, NULL, NULL, '2025-01-07 13:27:37', '2025-01-07 13:27:37', 94, NULL, NULL, NULL),
(135, 1, 50.00, 50.00, 141, NULL, 2, NULL, NULL, NULL, '2025-01-07 13:29:26', '2025-01-07 13:29:26', 95, NULL, NULL, NULL),
(136, 1, 50.00, 50.00, 142, NULL, 2, NULL, NULL, NULL, '2025-01-07 13:30:45', '2025-01-07 13:30:45', 96, NULL, NULL, NULL),
(137, 1, 50.00, 50.00, 143, '1', 2, NULL, 19, NULL, '2025-01-07 13:30:55', '2025-01-07 13:54:23', 97, NULL, NULL, NULL),
(138, 1, 50.00, 50.00, 144, NULL, 2, NULL, NULL, NULL, '2025-01-07 13:57:49', '2025-01-07 13:57:49', 98, NULL, NULL, NULL),
(139, 1, 50.00, 50.00, 145, NULL, 2, NULL, NULL, NULL, '2025-01-07 13:59:43', '2025-01-07 13:59:43', 99, NULL, NULL, NULL),
(140, 1, 50.00, 50.00, 146, NULL, 2, NULL, NULL, NULL, '2025-01-07 14:01:55', '2025-01-07 14:01:55', 100, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL,
  `amount` double(8,2) NOT NULL,
  `details` varchar(255) NOT NULL,
  `method` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bidding_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id`, `status`, `amount`, `details`, `method`, `date`, `order_id`, `bidding_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'pending', 15.32, 'pi_3QMXV7HH9VySX7IE11yFFH8C_secret_PT40EdNUeS27BBDWzASr7QQyM', 'Card', '2024-11-19', 1, NULL, 4, '2024-11-18 16:08:41', '2024-11-18 16:08:41'),
(2, 'pending', 15.32, 'pi_3QMXVGHH9VySX7IE0BrMiTM7_secret_9FLW86jZDVxdHyjCLXw0Cnhzo', 'Card', '2024-11-19', 2, NULL, 4, '2024-11-18 16:08:42', '2024-11-18 16:08:42'),
(3, 'pending', 15.32, 'pi_3QMXVUHH9VySX7IE0AGgCL7D_secret_WYyKnTgZh8KXIww7nSdgjGzue', 'Card', '2024-11-19', 3, NULL, 4, '2024-11-18 16:08:56', '2024-11-18 16:08:56'),
(4, 'pending', 100.00, 'pi_3QQ2LGHH9VySX7IE1Xmx2pKj_secret_ujVxXzBuxnaNyPJN8EV4Mgvft', 'Card', '2024-11-28', 4, NULL, 4, '2024-11-28 07:40:50', '2024-11-28 07:40:50'),
(5, 'pending', 8.95, 'pi_3QQMVSHH9VySX7IE0TpfHAQE_secret_EFNLZ0YVWS6j2QRicFUD1Xj1O', 'Card', '2024-11-29', 5, NULL, 4, '2024-11-29 05:12:43', '2024-11-29 05:12:43'),
(6, 'pending', 15.32, 'pi_3QQN0FHH9VySX7IE0wXPMdza_secret_QxQIi2IUSqQMtMChvYXwN6PNz', 'Card', '2024-11-29', 6, NULL, 4, '2024-11-29 05:44:32', '2024-11-29 05:44:32'),
(7, 'pending', 15.32, 'pi_3QQQHEHH9VySX7IE1jP6aQ7c_secret_w3ixKzxaKGd4cDOa1lfiY1i8X', 'Card', '2024-11-29', 7, NULL, 4, '2024-11-29 09:14:17', '2024-11-29 09:14:17'),
(8, 'pending', 8.95, 'pi_3QQQJrHH9VySX7IE0EZaLGzI_secret_ZJ2nPBJ7Ti6vRriEL9VsJhbQJ', 'Card', '2024-11-29', 8, NULL, 4, '2024-11-29 09:17:00', '2024-11-29 09:17:00'),
(9, 'success', 8.95, 'pi_3QQQZIHH9VySX7IE1zVyMMfB_secret_wQgffC3KhAwz2OxXRNapUJJrP', 'Card', '2024-11-29', 9, NULL, 4, '2024-11-29 09:32:56', '2024-11-29 09:33:24'),
(10, 'pending', 8.95, 'pi_3QSVG6HH9VySX7IE1m9P8r3F_secret_760vBDxImMbIbXBFF9rRC7kZY', 'Card', '2024-12-05', 10, NULL, 4, '2024-12-05 02:57:42', '2024-12-05 02:57:42'),
(11, 'success', 8.95, 'pi_3QSYtXHH9VySX7IE07YY1sQs_secret_UkIIKEMCFx7XINEITMySvDyEa', 'Card', '2024-12-05', 11, NULL, 4, '2024-12-05 06:50:39', '2024-12-05 06:50:53'),
(12, 'success', 50.00, 'pi_3QXcuxHH9VySX7IE1N8eaH1O_secret_MWg5lIsRndqtX3OMWjvBQ7Esl', 'Card', '2024-12-19', 22, NULL, 4, '2024-12-19 06:09:03', '2024-12-19 06:09:20'),
(13, 'pending', 50.00, 'pi_3QXd48HH9VySX7IE01LRo9nw_secret_xqjudA31l8Er5OrQm0zvMVz7J', 'Card', '2024-12-19', 18, NULL, 4, '2024-12-19 06:18:32', '2024-12-19 06:18:32'),
(14, 'success', 50.00, 'pi_3QXe7gHH9VySX7IE0xyIm2Nv_secret_SrUAsvKBFYZZHcv8TbnhAuunn', 'Card', '2024-12-19', 23, NULL, 4, '2024-12-19 07:26:18', '2024-12-19 07:26:31'),
(15, 'pending', 50.00, 'pi_3QXefgHH9VySX7IE1VikQm5p_secret_jXkt7qf46xNI9QkRFqz6Z4L5O', 'Card', '2024-12-19', 24, NULL, 4, '2024-12-19 08:01:24', '2024-12-19 08:01:24'),
(16, 'success', 50.00, 'pi_3QXejMHH9VySX7IE1XKyqcYN_secret_SZRv4POlon6Yl1qPPeg3g6Cgo', 'Card', '2024-12-19', 25, NULL, 4, '2024-12-19 08:05:12', '2024-12-19 08:05:28'),
(17, 'success', 50.00, 'pi_3QbIb9HH9VySX7IE01CCs19S_secret_4VSxCLBKBh0AHLbT3vLWuLNaN', 'Card', '2024-12-29', 58, NULL, 4, '2024-12-29 09:15:46', '2024-12-29 09:15:58'),
(18, 'success', 50.00, 'pi_3QbNn4HH9VySX7IE0RQssBhd_secret_Ohm9feZKzkyQPIG9LsiZGnpUM', 'Card', '2024-12-29', 56, NULL, 4, '2024-12-29 14:48:25', '2024-12-29 14:48:50'),
(19, 'success', 50.00, 'pi_3QbOEeHH9VySX7IE0R7HWnOp_secret_ZGVULSoyG7sH7I7mYaL0y8JmC', 'Card', '2024-12-29', 55, NULL, 4, '2024-12-29 15:16:55', '2024-12-29 15:17:05'),
(20, 'pending', 50.00, 'pi_3QbfHsHH9VySX7IE0JSiIqi2_secret_8GtQ7P0br8TEwLrkYDE7HcJ7F', 'Card', '2024-12-30', 59, NULL, 4, '2024-12-30 09:29:22', '2024-12-30 09:29:22'),
(21, 'success', 50.00, 'pi_3Qbv2HHH9VySX7IE191ZB5Ti_secret_TJUSYQ6AIelXlKludACP8vjcO', 'Card', '2024-12-31', 118, NULL, 4, '2024-12-31 02:18:21', '2024-12-31 02:18:34'),
(22, 'success', 50.00, 'pi_3Qbv2zHH9VySX7IE03bnjrSB_secret_i6sTgA8zyrpXnGk6b8WhuvG6y', 'Card', '2024-12-31', 117, NULL, 4, '2024-12-31 02:19:05', '2024-12-31 02:19:15'),
(23, 'success', 50.00, 'pi_3QcOV7HH9VySX7IE1oSXEGL6_secret_31vsIYZyEmBc34HruL80ydM6d', 'Card', '2025-01-01', 127, NULL, 4, '2025-01-01 09:46:05', '2025-01-01 15:44:46'),
(24, 'success', 50.00, 'pi_3QcOZiHH9VySX7IE1rjKjlN1_secret_0aWbWYeRFq3vZb6pYlyBTfI9W', 'Card', '2025-01-01', 126, NULL, 4, '2025-01-01 09:50:50', '2025-01-01 09:51:41'),
(25, 'success', 50.00, 'pi_3QcOb7HH9VySX7IE1Go72NAt_secret_Vo8YOFU0ClrOebGl1VrcWeTlO', 'Card', '2025-01-01', 124, NULL, 4, '2025-01-01 09:52:17', '2025-01-01 09:52:27'),
(26, 'success', 50.00, 'pi_3QcObRHH9VySX7IE0tk8XqRH_secret_jQvJnWbSouKh4OSRLmKONy8Og', 'Card', '2025-01-01', 123, NULL, 4, '2025-01-01 09:52:37', '2025-01-01 09:53:03'),
(27, 'success', 50.00, 'pi_3QcU7tHH9VySX7IE070UjCMT_secret_U1KQsBqoGdLOEPVOx8zACXDS2', 'Card', '2025-01-01', 125, NULL, 4, '2025-01-01 15:46:29', '2025-01-01 15:46:43'),
(28, 'success', 50.00, 'pi_3QcUKzHH9VySX7IE1UnDONAz_secret_lKCRUL2bC8QS4ZmR4LaVfvKNU', 'Card', '2025-01-02', 128, NULL, 4, '2025-01-01 16:00:01', '2025-01-01 16:00:14'),
(29, 'success', 50.00, 'pi_3QcUXQHH9VySX7IE0dk2aizS_secret_h0CtpFJUZEFRjJ8Bm5DPDfJs0', 'Card', '2025-01-02', 129, NULL, 4, '2025-01-01 16:12:52', '2025-01-01 16:13:04'),
(30, 'success', 50.00, 'pi_3QcUq0HH9VySX7IE0ytx0TGC_secret_4Qv14X8t7mUIIC3TelYm9RHgJ', 'Card', '2025-01-02', 130, NULL, 4, '2025-01-01 16:32:04', '2025-01-01 16:32:17'),
(31, 'success', 50.00, 'pi_3QcUvPHH9VySX7IE1MvKar2f_secret_p14BxmcidWsHX8rbaNq7o0DYG', 'Card', '2025-01-02', 132, NULL, 4, '2025-01-01 16:37:39', '2025-01-01 16:37:59'),
(32, 'success', 50.00, 'pi_3QcVW9HH9VySX7IE1sF4eLs9_secret_JoVmHrS1Q0ptIy570DrB5TwjN', 'Card', '2025-01-02', 133, NULL, 4, '2025-01-01 17:15:37', '2025-01-01 17:15:48'),
(33, 'success', 50.00, 'pi_3QcVZQHH9VySX7IE0XBdONES_secret_TjDG9pz78lb0asHXhqXtCgoIU', 'Card', '2025-01-02', 134, NULL, 4, '2025-01-01 17:19:00', '2025-01-01 17:19:22'),
(34, 'success', 50.00, 'pi_3QecYyHH9VySX7IE0OnxkuVl_secret_P8rGmhfvZTYS8d7k3jqn1ABpW', 'Card', '2025-01-07', 136, NULL, 112, '2025-01-07 13:11:17', '2025-01-07 13:11:26'),
(35, 'success', 50.00, 'pi_3QedDuHH9VySX7IE042j9Ard_secret_avkyNJ4HLsSuABTQ8j7eSE07B', 'Card', '2025-01-07', 143, NULL, 112, '2025-01-07 13:53:34', '2025-01-07 13:53:46'),
(36, 'success', 50.00, 'pi_3QedEBHH9VySX7IE02mdR5SZ_secret_L9vHw6T5mDQJfE5mX0fzrhbxP', 'Card', '2025-01-07', 142, NULL, 112, '2025-01-07 13:53:51', '2025-01-07 13:54:03'),
(37, 'pending', 50.00, 'pi_3QedMCHH9VySX7IE1aaFiltG_secret_cQpnrUVOYLksFFZTcmyKEC8KG', 'Card', '2025-01-07', 146, NULL, 112, '2025-01-07 14:02:09', '2025-01-07 14:02:09');

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
(1, 'App\\Models\\User', 4, 'auth_token', '57f3cd6da9be9ed2f98e948cc275822a7971716e9f6663d46b0ae511e17a8885', '[\"*\"]', '2024-11-18 16:08:55', NULL, '2024-11-18 16:07:07', '2024-11-18 16:08:55'),
(3, 'App\\Models\\User', 4, 'auth_token', '3a87d8b6cc66c71f9f0143052d8dfad5c0116eee05ac154971301e48bd0dcca8', '[\"*\"]', '2024-11-22 09:02:50', NULL, '2024-11-22 08:19:41', '2024-11-22 09:02:50'),
(4, 'App\\Models\\User', 4, 'auth_token', '61f9b9f355bb846db66d7c635c52f658e429f057b475c0240971c7348f39baf5', '[\"*\"]', NULL, NULL, '2024-11-22 16:34:56', '2024-11-22 16:34:56'),
(6, 'App\\Models\\User', 4, 'auth_token', '85e9a04d6353e7ffae15146e993694cd794d39797e42eef82a5ebcdd2276b4b1', '[\"*\"]', '2024-11-29 16:08:53', NULL, '2024-11-23 09:09:44', '2024-11-29 16:08:53'),
(7, 'App\\Models\\User', 4, 'auth_token', '4e3545c6cc61626e975ec0359b6acce5b7b6204d69a7498dc1a088459ab98706', '[\"*\"]', '2024-12-05 06:57:08', NULL, '2024-11-30 16:44:09', '2024-12-05 06:57:08'),
(8, 'App\\Models\\User', 4, 'auth_token', '8fc3c77e6180c1fc6a1f94e9f78dbbdcb303427d7c570531b9182595103ee700', '[\"*\"]', '2024-12-09 03:02:40', NULL, '2024-12-08 07:34:37', '2024-12-09 03:02:40'),
(10, 'App\\Models\\User', 4, 'auth_token', '6fcc6c0b2fe8b567dfc2b817095ac487852ad957743cd609e847a50344741891', '[\"*\"]', '2024-12-26 07:16:49', NULL, '2024-12-19 07:21:30', '2024-12-26 07:16:49'),
(11, 'App\\Models\\User', 4, 'auth_token', 'e9f865542a2557a370b5dcea9d03662d3b233ed2fc637c490d73e13a7185e9ea', '[\"*\"]', '2024-12-29 16:30:08', NULL, '2024-12-26 07:35:54', '2024-12-29 16:30:08'),
(12, 'App\\Models\\User', 4, 'auth_token', 'e35d101903de7b7eb801d721bfc95a509d86ac7c94b4089822b55dda6a4ce0f2', '[\"*\"]', '2024-12-29 16:30:22', NULL, '2024-12-29 16:30:18', '2024-12-29 16:30:22'),
(13, 'App\\Models\\User', 4, 'auth_token', '8001d39b5cd182d060f13835fd63c86159d3e0773a631cb4771e6f1eef977c2b', '[\"*\"]', '2024-12-30 10:02:45', NULL, '2024-12-29 16:31:08', '2024-12-30 10:02:45'),
(14, 'App\\Models\\User', 4, 'auth_token', 'c2b38f8aebb1a41a490acc9abf48e881375c8d555329cfad3470987a6f583e32', '[\"*\"]', '2024-12-30 10:03:09', NULL, '2024-12-30 10:03:08', '2024-12-30 10:03:09'),
(15, 'App\\Models\\User', 4, 'auth_token', 'b3d766123b5647a00490fba93a7b2e8aadd5cdb047c72129db91160e2cd752be', '[\"*\"]', '2024-12-30 10:04:07', NULL, '2024-12-30 10:03:57', '2024-12-30 10:04:07'),
(16, 'App\\Models\\User', 4, 'auth_token', 'fc9935f18fe33a5b369bdd4487b0085447719cddd790a03e91d38974bd7071ba', '[\"*\"]', '2024-12-30 10:04:30', NULL, '2024-12-30 10:04:29', '2024-12-30 10:04:30'),
(17, 'App\\Models\\User', 4, 'auth_token', '2646b3cd1f0c83c37bfc5e6d45729687e8a94dfcb1a68334de618a40c66db70d', '[\"*\"]', '2025-01-02 00:59:04', NULL, '2024-12-30 10:05:29', '2025-01-02 00:59:04'),
(18, 'App\\Models\\User', 112, 'auth_token', '7dc80cde37abc9515916dc4c1f13c41b75fe279e058e5099dbc4c1ac1e2bbe74', '[\"*\"]', NULL, NULL, '2025-01-07 13:09:23', '2025-01-07 13:09:23'),
(19, 'App\\Models\\User', 112, 'auth_token', 'ad44d227ad59e6c40a3b73329344d040c003aee156fea84f0a2cd381f63057d4', '[\"*\"]', '2025-01-07 14:34:23', NULL, '2025-01-07 13:09:24', '2025-01-07 14:34:23');

-- --------------------------------------------------------

--
-- Table structure for table `piping_details`
--

CREATE TABLE `piping_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `fixitem` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`fixitem`)),
  `problem` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`problem`)),
  `types_property` varchar(255) NOT NULL,
  `app_date` date NOT NULL,
  `preferred_time` varchar(255) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `budget` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `piping_details`
--

INSERT INTO `piping_details` (`id`, `type`, `fixitem`, `problem`, `types_property`, `app_date`, `preferred_time`, `details`, `photo`, `budget`, `created_at`, `updated_at`) VALUES
(1, 'Repair', '[\"Shower\"]', '[\"No problem. Install\\/replace only.\"]', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-12', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM20000 - RM49999', '2024-12-08 16:10:30', '2024-12-08 16:10:30'),
(2, 'Repair', '[\"Shower\",\"Pipe\\/drain\"]', '[\"No problem. Install\\/replace only.\"]', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-27', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-27 15:56:21', '2024-12-27 15:56:21'),
(3, 'Dismantle', '[\"Shower\",\"Pipe\\/drain\"]', '[\"No problem. Install\\/replace only.\",\"Leak\\/drip\"]', 'High-rise (e.g. condo, apartment)', '2024-12-28', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM50000 - RM99999', '2024-12-27 16:14:21', '2024-12-27 16:14:21'),
(4, 'Repair', '[\"Pipe\\/drain\",\"Shower\"]', '[\"No problem. Install\\/replace only.\",\"Noisy\\/Vibration\"]', 'Commercial (e.g. factory, shopping centre)', '2024-12-29', 'Morning (9 AM - 11 PM)', NULL, '[]', 'RM5000 - RM9999', '2024-12-28 17:56:47', '2024-12-28 17:56:47'),
(5, 'Replacement', '[\"Toilet\\/WC\",\"Pipe\\/drain\"]', '[\"No problem. Install\\/replace only.\",\"Clogged\\/Stuck\"]', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-28 18:05:43', '2024-12-28 18:05:43'),
(6, 'Replacement', '[\"Pipe\\/drain\"]', '[\"No problem. Install\\/replace only.\",\"Clogged\\/Stuck\"]', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM200000 - Above', '2024-12-31 02:42:15', '2024-12-31 02:42:15'),
(7, 'Repair', '[\"Bathtub\"]', '[\"Noisy\\/Vibration\",\"Other (Explain in Additional Details)\"]', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM20000 - RM49999', '2024-12-31 02:44:20', '2024-12-31 02:44:20'),
(8, 'Dismantle', '[\"Pipe\\/drain\",\"Shower\"]', '[\"No problem. Install\\/replace only.\",\"Leak\\/drip\"]', 'High-rise (e.g. condo, apartment)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM5000 - RM9999', '2024-12-31 03:39:12', '2024-12-31 03:39:12'),
(9, 'Dismantle', '[\"Pipe\\/drain\",\"Shower\"]', '[\"No problem. Install\\/replace only.\",\"Leak\\/drip\"]', 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 03:41:20', '2024-12-31 03:41:20'),
(10, 'Replacement', '[\"Pipe\\/drain\",\"Shower\"]', '[\"No problem. Install\\/replace only.\",\"Leak\\/drip\"]', 'Commercial (e.g. factory, shopping centre)', '2025-01-07', 'Lunch Time (11 AM - 1 PM)', 'vbbj', 'no_service.png', 'RM50000 - RM99999', '2025-01-07 13:11:11', '2025-01-07 13:11:11');

-- --------------------------------------------------------

--
-- Table structure for table `plant`
--

CREATE TABLE `plant` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `sales_amount` int(11) DEFAULT NULL,
  `price` double(8,2) NOT NULL,
  `description` longtext NOT NULL,
  `quantity` int(11) NOT NULL,
  `sunlight_need` varchar(255) NOT NULL,
  `water_need` varchar(255) NOT NULL,
  `mature_height` varchar(255) NOT NULL,
  `origin` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '1',
  `image` varchar(255) NOT NULL,
  `cat_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plant`
--

INSERT INTO `plant` (`id`, `name`, `sales_amount`, `price`, `description`, `quantity`, `sunlight_need`, `water_need`, `mature_height`, `origin`, `status`, `image`, `cat_id`, `created_at`, `updated_at`) VALUES
(1, 'Lotus1', NULL, 32.36, 'Voluptatem culpa est consectetur reprehenderit aut et magnam. Dicta accusantium ut modi non cumque quia ea consequatur. Illo similique distinctio autem molestiae.Rerum similique omnis error. Nisi enim dolore dicta quia voluptas. Voluptatem saepe voluptatum ex laboriosam voluptatem fuga odio. Asperiores totam voluptatem totam explicabo unde nostrum officia.Consequuntur minus ullam odio. Eum saepe sit vitae voluptate non est.', 468, 'Full', 'Moderate', '6.17', 'Bosnia and Herzegovina', '1', 'Lotus1.png', 1, NULL, NULL),
(2, 'Cactus1', NULL, 46.93, 'Possimus est nobis quia et rerum dolores asperiores. Rerum exercitationem quia voluptatem eligendi qui laudantium. Maxime possimus doloribus dolore. Deleniti distinctio numquam eius doloribus.Velit sit quis dolores ducimus. Aut et veniam officiis inventore. Quia consequuntur reiciendis quam beatae et tempora unde eius.Quis dignissimos commodi neque soluta quia distinctio quod. Et aliquid repellat iusto dolores. Veniam provident quia voluptatem explicabo asperiores eum. Voluptas voluptates consequatur dolorem consequuntur.', 833, 'Full', 'Low', '2.68', 'Dominica', '1', 'cactus2.png', 3, NULL, NULL),
(3, 'Desert Rose1', NULL, 58.07, 'Nulla eveniet est quia hic. Qui odio culpa non labore praesentium nulla.Est eos non consequatur voluptatem eligendi odio ea. Consectetur et aut qui nostrum. Velit a dolorum ut cupiditate. Sit explicabo labore eos voluptas commodi.Odit voluptatem ut porro consequuntur voluptatem et soluta. Tempora ut ipsum aspernatur velit quia et. Voluptate excepturi totam aliquam autem et voluptas ab.', 825, 'Shade', 'Low', '3.39', 'Estonia', '1', 'DRose3.png', 2, NULL, NULL),
(4, 'Hydrangeas1', NULL, 30.49, 'Laborum nihil quas voluptatem non. Beatae eos at vel harum nobis repellat. Nostrum possimus rerum similique voluptas facilis magnam.Et nihil quo itaque ut et. Ipsa odio molestias quod cum non.Et at omnis inventore impedit in. Pariatur provident consequatur est sapiente sunt. Qui aut ut nihil sed quibusdam quaerat autem.', 735, 'Shade', 'High', '4.8', 'Micronesia', '1', 'Hydran3.png', 4, NULL, NULL),
(5, 'Lotus2', NULL, 61.15, 'Inventore illo quo reiciendis rem id ullam libero. Provident officiis ut odio inventore est in. Quisquam ad aliquam rem et vel. Velit et ratione id voluptas eius rerum.Magnam totam cumque vel repudiandae sed et sunt. Totam voluptatem qui dolor dignissimos. Odit velit excepturi delectus maxime repellendus id. Quo ipsum nam id omnis.Et quisquam rem quasi optio. Perferendis in vero repellendus dolorum et. Repellat odit neque harum sint maxime est numquam.', 548, 'Partial', 'Moderate', '3.84', 'Greenland', '1', 'Lotus4.png', 1, NULL, NULL),
(6, 'Cactus2', NULL, 99.57, 'Nisi itaque iste pariatur quidem dolor dicta. Quaerat dolore esse maiores omnis. Dolor rerum quae doloribus est amet. Molestiae est praesentium soluta ut eos.Nulla distinctio doloribus est aliquid ratione explicabo ipsa non. Earum aperiam molestiae atque aperiam laboriosam consectetur eum.Et et in reiciendis enim blanditiis. Autem enim delectus expedita ipsum dolor aspernatur a. Alias omnis aut officia quos velit aut at.', 110, 'Full', 'Moderate', '4.03', 'Malawi', '1', 'cactus1.png', 3, NULL, NULL),
(7, 'Desert Rose2', NULL, 59.88, 'Pariatur consectetur non et aut atque eos et. Labore corporis ex est doloremque animi. Velit consectetur dignissimos quas voluptatibus.Doloribus eum ducimus porro unde quia. Id reiciendis debitis quisquam eligendi aliquam nesciunt. Aliquam reprehenderit omnis tempore numquam. Molestias vitae rerum laboriosam numquam sunt dicta itaque.Fugiat adipisci voluptas molestiae id pariatur dolore velit. Voluptas earum dolorem rerum quam fugit quia dolorem. Voluptates atque repudiandae ab iusto eveniet. Vitae perferendis debitis natus adipisci.', 408, 'Full', 'High', '3.93', 'Iran', '1', 'DRose3.png', 2, NULL, NULL),
(8, 'Hydrangeas2', NULL, 22.02, 'Culpa aut suscipit voluptas adipisci quo dolorem voluptatem. Ut nemo eius ipsa voluptatem. Voluptates et earum delectus nobis nostrum laboriosam.Praesentium doloribus aut cum sint et. Et facilis doloribus ad vero eum nemo eius quaerat. Et qui placeat vitae ut est ut voluptas. Molestiae vero optio amet ut aut.Repellat aut assumenda illum delectus in. Provident perspiciatis autem est similique. Impedit ipsa laborum minima adipisci minus impedit optio pariatur. Quibusdam commodi cupiditate eum.', 396, 'Partial', 'High', '9.54', 'Belize', '1', 'Hydran3.png', 4, NULL, NULL),
(9, 'Lotus3', NULL, 24.22, 'Soluta molestiae assumenda iste. Repellendus veritatis tenetur iusto voluptatem culpa eius. Officiis nobis commodi vel sit explicabo saepe beatae. At eveniet veniam molestiae soluta ea earum.Ea possimus voluptates omnis aut. Omnis vel magni officia magni eos fugit. Tempora quae sequi optio est aut nobis tempore. Doloribus assumenda soluta fugiat possimus ea veritatis.Error omnis id dolor qui adipisci autem. Delectus autem quisquam in delectus. Earum provident quaerat ut cupiditate. Eligendi quaerat quo ut itaque laudantium.', 572, 'Partial', 'High', '2.16', 'Denmark', '1', 'Lotus4.png', 1, NULL, NULL),
(10, 'Cactus3', NULL, 39.05, 'Minus iure quasi deserunt sunt et similique. Dolore et repellendus velit enim et. Qui aut dolor sit repellat. Voluptatem rem quaerat quisquam sint impedit dolorem maiores laboriosam. Iure excepturi expedita maxime enim.Ea natus et aut impedit et et. Ullam esse aut nihil voluptatem quaerat laudantium reiciendis. Voluptatem quasi excepturi laboriosam nam alias necessitatibus. Sapiente tempora quaerat aut dolores.Voluptas numquam doloremque ratione blanditiis blanditiis. Aut qui tempore mollitia vel suscipit sint illo. Dignissimos consequatur consequatur adipisci quia soluta fugit ratione.', 329, 'Full', 'Low', '4.71', 'Cameroon', '1', 'cactus2.png', 3, NULL, NULL),
(11, 'Desert Rose3', NULL, 72.31, 'Adipisci cumque ut aut dicta nisi deleniti. Doloribus praesentium dolorem suscipit consequuntur natus sit eius. Est eligendi et laudantium.Exercitationem voluptates qui labore nobis similique quasi. Quasi cumque fugit ut ratione harum esse quis. Nesciunt odit et id neque fuga. Voluptatibus nihil aut esse repudiandae omnis molestiae aliquid.Facilis blanditiis aut libero consequuntur at. Qui sint nisi natus ipsam vel excepturi tenetur provident. Beatae et odit tempora totam. Ullam ipsa harum eum doloremque blanditiis.', 834, 'Shade', 'Moderate', '8.99', 'Botswana', '1', 'DRose2.png', 2, NULL, NULL),
(12, 'Hydrangeas3', NULL, 58.91, 'Facere officiis voluptates esse nisi molestiae rerum cupiditate. Impedit aut voluptatibus neque saepe assumenda. Ducimus exercitationem numquam possimus recusandae. Veritatis aliquam iure sit maiores dolorem.Magnam consequuntur vel deleniti. Enim non voluptatum molestiae pariatur non quia est. Blanditiis cupiditate laudantium est aut.Consequatur sint corrupti reprehenderit dicta perspiciatis. Doloribus quia assumenda aut et. Molestiae accusantium omnis quia veniam voluptas repudiandae.', 975, 'Full', 'Low', '4.08', 'Reunion', '1', 'Hydran3.png', 4, NULL, NULL),
(13, 'Lotus4', NULL, 91.66, 'Velit perferendis quam deleniti a repellendus quia. Molestiae quis voluptas illum non sit esse est. Sit quas voluptatem aut laborum consequuntur. Quia explicabo ullam dolorem et. Earum et est officia et.Consequatur illo qui quos beatae cupiditate officiis libero. Facilis maiores et aperiam autem dolores voluptatem explicabo. Modi quia vel ut nihil recusandae. Odit sapiente ex laborum odio est.Quia quibusdam maiores soluta atque reprehenderit laborum. Odio culpa et nam ducimus dolor quia. Saepe aut rerum sed odio. Voluptatem aut possimus nihil qui architecto et.', 499, 'Shade', 'Moderate', '2.76', 'Vanuatu', '1', 'Lotus4.png', 1, NULL, NULL),
(14, 'Cactus4', NULL, 32.87, 'Cum qui sed sit voluptas vel voluptas non. Aut doloribus quis sequi porro. Ipsum ea impedit illum nulla quis odit. Facilis dolor et voluptas ex.Sed accusamus consequuntur hic optio ipsum sapiente. Non incidunt deleniti quidem et autem est aut. Hic nostrum ipsa est sit quas qui.Ipsum et error voluptates delectus dolorem necessitatibus mollitia. Rerum rerum rerum rerum vel non modi consequatur ut. Quibusdam illum quo blanditiis libero quis.', 468, 'Partial', 'Moderate', '3.61', 'Pakistan', '1', 'cactus2.png', 3, NULL, NULL),
(15, 'Desert Rose4', NULL, 14.23, 'Officia iste rerum id. Doloremque ex nostrum officiis et totam aut libero. Ea officia ut facilis nihil odio.Consequatur aliquam reiciendis quas distinctio qui corrupti officia pariatur. Delectus suscipit et vitae vitae. Sunt ipsum sint enim provident et ut.Molestias voluptatem sunt ducimus corrupti dignissimos aut est. Harum voluptatum blanditiis est. Necessitatibus voluptates id sint qui voluptas molestiae.', 34, 'Partial', 'Moderate', '8.68', 'Serbia', '1', 'DRose2.png', 2, NULL, NULL),
(16, 'Hydrangeas4', NULL, 74.74, 'Harum et non mollitia repudiandae vitae sint est. Fugiat sed qui molestias velit porro eum. Sed porro est eum deleniti veniam aut natus. Et velit sed mollitia enim non voluptatem quod. Id enim sapiente sint ad odit commodi.Rerum nemo aut qui aut. Debitis et consequatur fugit possimus. Sed inventore voluptates magnam.Impedit rerum fugit illo commodi a. Molestiae velit est et sequi eaque. Qui iusto suscipit explicabo enim. Et nulla vel quis quo.', 831, 'Shade', 'Moderate', '1.96', 'Vietnam', '1', 'Hydran3.png', 4, NULL, NULL),
(17, 'Lotus5', NULL, 47.87, 'Velit sequi et sed minima. Dolores sint possimus ut. Non excepturi et amet voluptas accusantium voluptatem dolorem quia. Eius perferendis officia quaerat et.Non ut non non doloribus. Tempora est rerum natus fuga delectus. Iure qui vitae possimus non voluptatem et. Odit quasi eum consectetur consequatur.Consequuntur ut sed eum commodi at qui. Harum dolore consequuntur in doloribus molestiae aut. Ut consectetur dicta et.', 238, 'Full', 'Low', '1.75', 'Cape Verde', '1', 'Lotus6.png', 1, NULL, NULL),
(18, 'Cactus5', NULL, 44.69, 'Ab omnis voluptas eaque inventore et repellat. Eaque qui assumenda explicabo consequatur ea voluptas. Eos atque qui distinctio ipsa ratione ea architecto.Et odio libero voluptas rerum velit. Facere sequi culpa placeat laudantium laudantium possimus aperiam fuga. Sed possimus nihil ex saepe eaque. Quisquam eaque architecto qui.Soluta quisquam ullam vel dolor veritatis corporis dolorum. Ducimus reprehenderit corporis velit officiis. Id aut qui dicta. Dolores ullam a tempore.', 785, 'Full', 'Low', '7.8', 'Anguilla', '1', 'cactus2.png', 3, NULL, NULL),
(19, 'Desert Rose5', NULL, 12.57, 'Nemo aliquid culpa laudantium sit expedita harum recusandae. Quas omnis sit eveniet et perferendis facilis voluptate. Facilis assumenda ex aspernatur eligendi qui tenetur. Vero laborum dolores error amet numquam. Quis delectus alias odit ea ad omnis dolor.Incidunt porro sed in dolorum. Doloremque porro aut iure voluptas autem dolor quo. Et eos id eveniet nisi dignissimos iusto nemo dignissimos. Molestiae dignissimos tenetur aliquam velit dicta.Tempora ipsam quaerat omnis at. Quia magnam sit deserunt non.', 521, 'Full', 'High', '6.08', 'Afghanistan', '1', 'DRose3.png', 2, NULL, NULL),
(20, 'Hydrangeas5', NULL, 96.49, 'Nobis dicta illum nihil quia et et. Dolorem adipisci inventore tenetur necessitatibus facere. Ea omnis voluptatem occaecati. Repudiandae voluptatibus et voluptas reprehenderit.Nihil laboriosam laudantium fuga aut cupiditate debitis aliquam voluptas. Nulla quia et facilis et est. Ipsam qui aspernatur quis illum delectus dolorem odit quia. Alias explicabo voluptatem sed deserunt beatae ut error.Quia libero ipsam in tenetur qui ea. Nam sapiente necessitatibus ea et dolores voluptatem qui. Quo amet voluptatum officiis voluptatibus inventore. Maxime porro consequatur voluptates.', 742, 'Partial', 'High', '9.53', 'Russian Federation', '1', 'Hydran2.png', 4, NULL, NULL),
(21, 'Lotus6', NULL, 9.65, 'Exercitationem possimus debitis eum sint. Provident placeat autem occaecati necessitatibus tempora commodi.Sit labore iure illum est aspernatur. Similique magni quibusdam fuga maiores. Facilis minus voluptatem amet illo.Animi corporis corrupti occaecati iure vel reiciendis. Voluptas nisi rem nemo asperiores quisquam. Nihil dolore veniam voluptatem.', 621, 'Shade', 'Low', '3.74', 'Montenegro', '1', 'Lotus2.png', 1, NULL, NULL),
(22, 'Cactus6', NULL, 30.45, 'Temporibus omnis cupiditate facere maxime. Modi at eum blanditiis autem rerum. Incidunt nobis et earum. Omnis deleniti rem vel dolorum nobis.Ad sequi dignissimos mollitia dolore. Tempore in inventore quasi voluptatem voluptatem dolor. Qui temporibus neque dolore ab qui.Quisquam accusamus totam molestiae. Et nam ut qui est. Qui in quod architecto consequuntur. Aut nulla enim aperiam molestiae.', 253, 'Full', 'High', '3.11', 'Nepal', '1', 'cactus1.png', 3, NULL, NULL),
(23, 'Desert Rose6', NULL, 23.84, 'Excepturi ut facilis atque impedit. Eligendi repudiandae sed omnis. Voluptatem enim soluta consequatur ut similique eum.Aliquid et earum eveniet in eos aliquid. Omnis omnis beatae aperiam aut blanditiis sit. Eum et distinctio sunt unde blanditiis omnis ipsam dicta.Dolorem tempora porro reprehenderit est fuga dolores molestiae officia. Et assumenda omnis enim magni. Eveniet at impedit dicta nisi.', 509, 'Shade', 'Low', '4.19', 'Belarus', '1', 'DRose4.png', 2, NULL, NULL),
(24, 'Hydrangeas6', NULL, 90.58, 'Voluptas corporis eos dolorem nisi consectetur unde eum sunt. Harum omnis eligendi et blanditiis sed magnam commodi. Unde officia rerum exercitationem quos tempore.Cum in dolorum rem numquam minima quia. Exercitationem quia molestiae fuga sequi.Consequatur et velit assumenda consequuntur velit voluptatem. Magnam consequatur qui non id. Blanditiis ducimus quod consequuntur fugit ut enim est. Odio quisquam possimus ea facere repellendus aut omnis tenetur.', 472, 'Partial', 'Moderate', '6.11', 'Angola', '1', 'Hydran1.png', 4, NULL, NULL),
(25, 'Lotus7', NULL, 96.46, 'Libero iste sunt odio ut fugiat aspernatur. Aliquam aut cumque laudantium voluptatem mollitia eveniet minima. Rerum hic dolorum error.Occaecati ex suscipit doloremque voluptate. Quia assumenda quae sed distinctio facilis. Quidem dolores omnis ea ut eum tempore. Id eum voluptas sapiente in et nobis facere.Nam eos fugiat delectus perspiciatis. Ea quia cupiditate veritatis blanditiis est repudiandae. Quisquam hic ducimus eius non dolor unde.', 625, 'Full', 'High', '3.13', 'Ethiopia', '1', 'Lotus2.png', 1, NULL, NULL),
(26, 'Cactus7', NULL, 75.00, 'Repudiandae voluptate veniam aut quisquam quas. Fuga iste saepe excepturi ea ea sed voluptatibus.Et qui voluptatum ab omnis incidunt iusto quo earum. Eaque molestiae et sunt id. Itaque possimus ea fugit rem deserunt.Sint minima et ea ut ut ipsam quia. Aliquam ut quidem tenetur in aspernatur illo illo. Debitis ut illum eligendi in est consequuntur sapiente beatae.', 841, 'Shade', 'Low', '7.72', 'Guyana', '1', 'cactus2.png', 3, NULL, NULL),
(27, 'Desert Rose7', NULL, 29.14, 'Qui perspiciatis veniam iusto rerum nobis et quia corrupti. Omnis repudiandae odit iste. Vel aperiam perspiciatis voluptas facere.Maiores quasi qui dolor officiis quis consectetur. Tenetur et perferendis nihil quod. Esse nihil fugit officiis suscipit quos doloremque. Earum voluptas placeat dolorem aliquid veritatis minima.Laudantium vero et neque consequatur cum sunt. Exercitationem numquam iste deleniti officiis non qui. Saepe deserunt nostrum est ut aspernatur et. Doloremque ad corrupti id porro.', 236, 'Partial', 'High', '3.64', 'Libyan Arab Jamahiriya', '1', 'DRose1.png', 2, NULL, NULL),
(28, 'Hydrangeas7', NULL, 89.20, 'Suscipit nulla et optio dicta sunt. Sunt et sint ea distinctio tenetur et. Dolorem quos odit pariatur temporibus voluptas sit incidunt. Ad ut voluptas dolorum quod.Suscipit nam repellat fuga distinctio praesentium porro. Autem quas quis qui doloremque mollitia. Repellendus qui quia omnis eveniet.Iste et modi illo aut doloremque velit nemo. Error id molestias quos. Enim alias asperiores voluptatem assumenda omnis consectetur. Occaecati reprehenderit nostrum ratione at odio vel.', 770, 'Shade', 'Moderate', '6.89', 'Niger', '1', 'Hydran2.png', 4, NULL, NULL),
(29, 'Lotus8', NULL, 26.14, 'Odit sit quis molestiae aut explicabo. Quod excepturi non eum voluptas.Nesciunt qui ut aspernatur cupiditate praesentium id. Molestias qui sint sed recusandae. Rerum nostrum est aut suscipit. Voluptatem veniam sequi rerum dolores et.Reiciendis et possimus sit accusantium et. Est quidem consectetur enim odit ratione minus autem. Mollitia eum officiis saepe eius cumque. Doloribus iure aspernatur et a nesciunt.', 118, 'Partial', 'High', '4.38', 'Saudi Arabia', '1', 'Lotus2.png', 1, NULL, NULL),
(30, 'Cactus8', NULL, 45.00, 'Dignissimos tempora quisquam tempora quia ex nihil. Quia veniam est ratione corrupti vero et. Vitae et mollitia rem deleniti qui laborum sed.Labore ea cupiditate consectetur. Dolore adipisci quo omnis sed qui et expedita debitis. Maiores dignissimos dignissimos facere aut atque natus voluptas.Eum enim quidem voluptas. Quia ea laborum consequuntur aut qui assumenda qui. Est dolores qui ipsa repudiandae.', 40, 'Full', 'High', '4.33', 'Korea', '1', 'cactus2.png', 3, NULL, NULL),
(31, 'Desert Rose8', NULL, 50.19, 'Ea et aut eos quidem necessitatibus amet modi. Deleniti in quia minus voluptatem. Blanditiis facere qui suscipit.Voluptatibus possimus soluta et aut quis possimus error. Quam sequi illum et necessitatibus repellat eos odio. Cumque autem ipsum nobis unde quo in voluptatem.Facilis ex odio ut ipsa. Rerum pariatur ducimus fugit. Aut nesciunt occaecati velit quo corporis. Unde eum quaerat delectus blanditiis dolor laboriosam architecto.', 241, 'Shade', 'Moderate', '6.85', 'Slovakia (Slovak Republic)', '1', 'DRose2.png', 2, NULL, NULL),
(32, 'Hydrangeas8', NULL, 54.72, 'Aut saepe dolorem magni et quia perferendis. Ut aut dolore odio porro. Dolor ad rerum velit in.Et optio ducimus quia. Quo optio est reprehenderit qui aliquid voluptatum. Aut saepe exercitationem omnis sint nulla iure est.Iste dolores autem sapiente soluta facere hic eius neque. Molestiae labore soluta saepe eius.', 308, 'Shade', 'Low', '3.06', 'Dominican Republic', '1', 'Hydran2.png', 4, NULL, NULL),
(33, 'Lotus9', NULL, 51.35, 'Mollitia et ipsum voluptates aut consequuntur. Odit voluptas eaque excepturi deserunt eos. Enim aut consequatur aut vitae ullam. Itaque et voluptatem unde rerum quo qui itaque.Harum ut corrupti rerum voluptatem doloribus. Saepe hic et odio. Quia voluptas dolorem debitis tempora minima. Praesentium minima sit tenetur molestiae eaque quis officia consequuntur. Iusto quia expedita vel facere est voluptate voluptatibus.Nihil sed illo rem est. Modi maxime sed corrupti quam quos maxime. Dolore fuga et assumenda qui qui fugiat magni.', 852, 'Full', 'Low', '5.92', 'Haiti', '1', 'Lotus1.png', 1, NULL, NULL),
(34, 'Cactus9', NULL, 29.78, 'Ea laboriosam nostrum corrupti eos. Ut qui veritatis nesciunt dignissimos est. Ipsam rerum magni et voluptatem. Error est quidem adipisci optio maiores necessitatibus. Id harum vel autem doloribus atque voluptates animi.Laudantium quis est qui consequatur recusandae veritatis maxime ex. Libero possimus ducimus cumque quia. Et aut mollitia possimus quidem nisi optio.Laborum inventore assumenda consequatur totam. Quas quidem amet non illo. Deleniti illo maxime saepe reprehenderit perspiciatis ut et dolor. Fuga tenetur asperiores totam veritatis qui veniam repudiandae. Quod molestiae esse enim eligendi aut.', 382, 'Partial', 'High', '2.02', 'Brunei Darussalam', '1', 'cactus2.png', 3, NULL, NULL),
(35, 'Desert Rose9', NULL, 56.66, 'Repellat natus voluptates voluptatum ipsa provident provident harum. Qui fugit vel mollitia aut consequuntur asperiores nemo. Quod perspiciatis magnam qui in aut. In veniam necessitatibus voluptatem iste non est facere.Quod ut ea corrupti illum eligendi. Ullam cum et molestiae dicta modi. Repellendus quia veniam temporibus soluta cupiditate rem perspiciatis.Perferendis beatae enim omnis distinctio asperiores maiores. Omnis voluptatem quidem facere. Natus optio quia iure cumque et omnis aut.', 77, 'Shade', 'Low', '3.99', 'Dominican Republic', '1', 'DRose1.png', 2, NULL, NULL),
(36, 'Hydrangeas9', NULL, 79.59, 'Eaque quia aut delectus facilis voluptas. In inventore consequuntur voluptatem ut quis aut. Non et esse laborum eos dolorem dolores voluptas. Itaque quaerat eius perspiciatis totam assumenda.Labore ipsum dolore omnis est eos nihil. Dolorem temporibus consequatur nemo laudantium iusto et. Perspiciatis corporis ea optio nesciunt tempore saepe tempora.Consectetur mollitia numquam autem vel possimus consequatur. Consequatur corrupti optio explicabo et impedit explicabo. Ut repellat accusantium non totam. Consequuntur consequatur voluptate eos et laudantium.', 781, 'Partial', 'Moderate', '1.29', 'Holy See (Vatican City State)', '1', 'Hydran1.png', 4, NULL, NULL),
(37, 'Lotus10', NULL, 32.12, 'Porro ut enim sit. Eum et similique ut dolore. Quasi et ullam sed harum. Architecto minus natus ratione hic.Delectus cum eligendi magnam qui. Quis qui voluptas et eius molestiae. Distinctio quasi aut doloribus iure. Error quia quae eveniet perferendis. Similique officia debitis enim corrupti voluptatem rerum aut.Et laboriosam praesentium et corrupti amet dolor commodi vel. Quis distinctio quo illum dolore similique. Consectetur voluptatem non impedit et consequatur quod.', 937, 'Shade', 'Moderate', '2.76', 'Azerbaijan', '1', 'Lotus2.png', 1, NULL, NULL),
(38, 'Cactus10', NULL, 28.67, 'Totam quae blanditiis est. Ut magni quaerat cum officiis sint. Qui similique culpa deleniti repellat et assumenda optio. Modi ipsam harum harum consequatur sed veniam.Vero ut laudantium aut occaecati sed sapiente. Rem quia architecto quibusdam corporis cupiditate voluptatibus. Ipsum illo voluptatum tempore accusamus et exercitationem accusamus. Odit quas aliquam dolorem molestias est.Sunt molestiae dolorum vitae. Repellat assumenda dolores debitis ducimus. Placeat adipisci corrupti eum et aut qui.', 809, 'Full', 'Moderate', '6.52', 'Oman', '1', 'cactus2.png', 3, NULL, NULL),
(39, 'Desert Rose10', NULL, 61.41, 'Sit aut accusantium sed tempora aspernatur. Aut aut doloribus voluptatem occaecati ut deserunt. Eos aut ad dolor provident.Assumenda assumenda repudiandae animi aspernatur qui molestiae alias. Tenetur sunt ipsum qui ut doloremque. Sint assumenda deleniti quia debitis repellendus incidunt iste.Magni porro ea eveniet distinctio sed. Quidem culpa totam eos id. Saepe itaque at ut voluptatem voluptas.', 970, 'Full', 'High', '6.89', 'Papua New Guinea', '1', 'DRose3.png', 2, NULL, NULL),
(40, 'Hydrangeas10', NULL, 9.29, 'Rem voluptatem porro rerum. Quia deserunt voluptas non. Enim velit iusto porro voluptates eligendi sed ut incidunt.Animi sint optio rerum exercitationem. Est pariatur ex fuga ipsum nobis est similique. Quia aut soluta et unde corporis illo vel.Sit sit dolorem exercitationem. Saepe minima recusandae et. Expedita et nemo soluta ullam ipsam harum rerum impedit. Ut vel quibusdam quidem nesciunt vel qui.', 731, 'Full', 'High', '1.7', 'Benin', '1', 'Hydran1.png', 4, NULL, NULL),
(41, 'Lotus11', NULL, 43.04, 'In blanditiis quisquam maxime nulla quia perferendis nemo. Molestias est ducimus asperiores ipsa earum amet deserunt. Quia dolorem non veritatis explicabo minima libero.Repudiandae distinctio perferendis molestiae qui esse quo. Voluptatibus omnis fuga et. Eius corrupti dolor quam itaque sunt possimus.In dolores totam nobis incidunt nisi illo ut. Ea possimus voluptatem recusandae nostrum voluptate occaecati. Reprehenderit porro aut dolorem quis nihil hic quod. Exercitationem officia nostrum ab tempore eos et cumque.', 346, 'Partial', 'Moderate', '7.62', 'Luxembourg', '1', 'Lotus1.png', 1, NULL, NULL),
(42, 'Cactus11', NULL, 82.18, 'Ipsam eveniet eos nam vel. Consequuntur cum ad ipsum optio. Minus enim quis numquam maiores soluta.Voluptatem officia qui expedita ullam. Possimus minima voluptatem sit. Quia numquam odit rerum qui iste est. Placeat et placeat occaecati. Distinctio rem nesciunt beatae.Porro cumque reprehenderit et sed. Assumenda laudantium alias nihil doloribus voluptas quas. Praesentium quod perspiciatis explicabo rem. Quia reiciendis aut et vel molestias dolores.', 841, 'Partial', 'Moderate', '3.13', 'French Polynesia', '1', 'cactus1.png', 3, NULL, NULL),
(43, 'Desert Rose11', NULL, 10.33, 'Quia assumenda necessitatibus non dolore perferendis. Autem nihil et perspiciatis nihil omnis. Consequatur suscipit quod voluptates molestiae tempore non doloribus.Maxime magnam in sunt autem dignissimos. Maxime debitis sed odio sunt. Aut voluptate in fugiat blanditiis eligendi voluptatem accusantium. Minus eos molestias nemo ut impedit.Excepturi et velit sit optio est. Ea eum et aperiam excepturi eos voluptatem explicabo alias. Necessitatibus eum iste pariatur similique quidem sunt expedita.', 224, 'Partial', 'High', '1.95', 'Brazil', '1', 'DRose3.png', 2, NULL, NULL),
(44, 'Hydrangeas11', NULL, 69.65, 'Voluptatum recusandae laboriosam voluptas. Quas aut et doloremque aspernatur alias sunt. Accusamus dicta et tempora quia.Quasi odit voluptas placeat deleniti dolor. Qui maiores autem ea recusandae dolorem rerum. Dolorem sit numquam mollitia consequatur provident consectetur. Illum magnam ea impedit assumenda ex amet.Vero consectetur repellat eum. Quam sequi laudantium nihil nostrum. Quia qui non autem blanditiis eum suscipit. Quaerat debitis deleniti itaque ad quisquam nisi nesciunt.', 317, 'Full', 'High', '8.31', 'Saint Pierre and Miquelon', '1', 'Hydran1.png', 4, NULL, NULL),
(45, 'Lotus12', NULL, 48.52, 'Nostrum in nemo dignissimos impedit sapiente incidunt ut cum. Magnam qui veritatis amet ratione cumque aut quisquam. Voluptatem neque eveniet non neque iste nisi voluptatem.Repellat ut numquam placeat dicta dolore voluptate. Et quibusdam neque sit unde. Iusto dicta id nostrum voluptatibus laboriosam qui temporibus. Quaerat maxime amet quod animi velit.Hic sunt magnam ad qui quia voluptatem. Similique quaerat mollitia quibusdam impedit in.', 344, 'Full', 'Low', '9.1', 'Ghana', '1', 'Lotus3.png', 1, NULL, NULL),
(46, 'Cactus12', NULL, 51.18, 'Unde id et fugiat sunt eius consequuntur eligendi. Dolorem aut voluptate non necessitatibus et perferendis.Rerum voluptatibus quam ducimus et consectetur magni blanditiis. Nisi assumenda atque corporis at.Rerum natus sed numquam facere fuga et aliquam. Ad tempora occaecati nesciunt quis. Quod consequatur in dolore omnis impedit sunt. Minus ullam est qui hic fugiat.', 554, 'Full', 'High', '8.35', 'Togo', '1', 'cactus2.png', 3, NULL, NULL),
(47, 'Desert Rose12', NULL, 99.51, 'Eius velit molestias ratione amet aut aut. Qui quisquam voluptas dolorum asperiores ut sint. Quia laudantium reprehenderit et consequatur ut est et.Tempore minus explicabo numquam consequatur in. Dolores magni repellendus odit quia quam praesentium.Numquam itaque ullam ea voluptatibus. Rerum eveniet unde beatae rem possimus et. Magni natus non aut quo ex. Et accusamus omnis est ut.', 270, 'Partial', 'High', '8.62', 'Somalia', '1', 'DRose2.png', 2, NULL, NULL),
(48, 'Hydrangeas12', NULL, 47.81, 'Temporibus fuga cumque sit. Et suscipit ea aut. Animi saepe veniam laudantium aspernatur quos.Quibusdam animi eos officia. Voluptatum consectetur numquam reiciendis et sit recusandae. Maxime nostrum architecto voluptas similique doloribus ut excepturi. Voluptatem labore ut accusantium ut dolores veritatis.Minus ex eveniet saepe facilis repudiandae rerum. Asperiores eos totam cum non qui. Quo quae facere voluptate porro a molestiae. Aliquam ut commodi aut consectetur et laboriosam ullam.', 964, 'Shade', 'Low', '1.5', 'Korea', '1', 'Hydran1.png', 4, NULL, NULL),
(49, 'Lotus13', NULL, 47.45, 'Laborum quos aliquam minus eos cum pariatur doloremque. Corporis unde vero unde perferendis quae. Ducimus laudantium nemo veniam non perspiciatis accusantium nemo.Et ut et et impedit. Eveniet sint ex possimus.Sit eos exercitationem maiores omnis. Eaque amet tempore recusandae aut. Est maxime assumenda velit molestiae facere dolore voluptate.', 534, 'Full', 'Low', '1.43', 'Papua New Guinea', '1', 'Lotus2.png', 1, NULL, NULL),
(50, 'Cactus13', NULL, 47.18, 'Saepe perspiciatis error commodi sequi dolor voluptatem. Et ipsam eveniet quaerat dolores. Aut vitae ab quod esse dolorem. Explicabo dolor porro voluptatem expedita ut facere voluptatem.Vero voluptatum itaque ut corrupti ratione sint molestiae. Eaque distinctio rem eum quas fugiat iusto. Magnam quo consequatur ipsa. Minima et ut earum sed voluptatem sit.Quas consequatur nemo odit nihil sequi explicabo. Dolorem voluptas non qui repellendus. Dolores quis quos recusandae sunt perferendis voluptatibus quidem nulla. Nobis odio nostrum voluptatibus saepe maxime pariatur.', 445, 'Partial', 'Low', '3.24', 'Panama', '1', 'cactus2.png', 3, NULL, NULL),
(51, 'Desert Rose13', NULL, 23.51, 'Quas et ut repellat quia aut. Labore praesentium et corrupti distinctio consequuntur. Delectus itaque omnis est et omnis. Consectetur sequi accusantium laudantium doloremque quaerat. Sit veritatis nihil aliquid quasi.Consectetur blanditiis iure ipsa commodi adipisci. Dolorem aut enim quibusdam et dolores ut. Veniam rerum aperiam consequatur reiciendis.Tempora accusantium nihil enim error est libero saepe. Error odit eius quos dolores eos molestiae deleniti. Aspernatur sapiente omnis sint repellendus repellat est. Libero recusandae eius tempore eum dolores.', 682, 'Full', 'High', '8.08', 'Faroe Islands', '1', 'DRose2.png', 2, NULL, NULL),
(52, 'Hydrangeas13', NULL, 84.04, 'Consectetur explicabo aliquam maxime quisquam quas id. Dolor alias animi quibusdam aut eligendi magnam. Enim optio ea cumque voluptas labore aperiam eos aspernatur.Sed deserunt ut voluptatem. Quam sunt molestiae vel consequatur odio quis. Aliquam sed enim temporibus dignissimos corrupti non cumque.Labore iste suscipit nostrum quas nobis voluptatem qui. Consequatur tempore ut est qui iure repellat hic doloremque. Libero quo harum et sed praesentium.', 184, 'Full', 'High', '7.64', 'Bolivia', '1', 'Hydran3.png', 4, NULL, NULL),
(53, 'Lotus14', NULL, 81.72, 'Reiciendis consequatur repudiandae earum sit aut aperiam. Sint reprehenderit et exercitationem ea. Commodi eaque est iure asperiores.Deserunt vel quis rerum qui dolores dolor doloribus. Consequuntur quos dolorum non at ipsum qui molestiae. Mollitia veritatis atque quasi voluptate ducimus reiciendis voluptatum deserunt. Harum minima et et illum et velit.Aut esse incidunt dignissimos porro dolorem nesciunt. Expedita optio at molestiae amet voluptas sed. Vel harum impedit ab dolorum.', 697, 'Full', 'Moderate', '5.61', 'Rwanda', '1', 'Lotus1.png', 1, NULL, NULL),
(54, 'Cactus14', NULL, 28.02, 'Unde ut temporibus eos iste similique. Fuga eum et perspiciatis quas temporibus. Voluptas accusantium minima iste.Perferendis ut voluptatem libero error nesciunt iure at. Error quia vel voluptatum eum dicta. Eum voluptatem laudantium ipsam ea dolores voluptatem alias iure.Aspernatur vel dolorem dolore illum sed quae magnam. Et qui eos repudiandae sed dicta numquam corrupti aut. Fugiat accusamus provident at et.', 632, 'Full', 'Low', '4.69', 'Isle of Man', '1', 'cactus1.png', 3, NULL, NULL),
(55, 'Desert Rose14', NULL, 79.45, 'Accusantium enim voluptate eligendi est nesciunt ut. Maiores sunt ipsum est inventore incidunt assumenda. Repellat maxime expedita alias numquam iusto. Itaque nesciunt enim quod.Quia ut facere aut blanditiis eos. Natus et eligendi qui quidem sit et voluptatibus voluptas. Placeat ea ratione qui officiis animi et quia.Illo maiores qui illo enim vitae tempora optio. Cumque beatae accusantium enim voluptatem vitae voluptas. Labore vel necessitatibus id provident tenetur reprehenderit. Exercitationem aut ut ad.', 822, 'Partial', 'Low', '2.44', 'British Virgin Islands', '1', 'DRose2.png', 2, NULL, NULL),
(56, 'Hydrangeas14', NULL, 13.31, 'Beatae dolorum non aperiam laborum. Nostrum illum dolorum blanditiis sit. Delectus eius cumque et facere qui aut. Veniam nihil unde illo beatae magnam vel.Laudantium dignissimos et consequuntur deleniti tenetur deserunt consectetur. Qui tempore doloribus illo. Et aspernatur aut et doloremque unde numquam officiis. Necessitatibus mollitia vitae nesciunt unde harum qui consequatur animi.Eos tempore distinctio qui eos. Rerum fugit quasi perferendis doloribus. Consequatur labore molestiae est et cumque. Sint illo modi sit culpa autem nobis aut.', 461, 'Full', 'Low', '7.51', 'Andorra', '1', 'Hydran1.png', 4, NULL, NULL),
(57, 'Lotus15', NULL, 79.21, 'Nobis quis quia ut reprehenderit. Quidem sit unde voluptatem quidem commodi iusto quo. Labore dicta quia illum alias voluptas tempora.Hic quisquam tempora porro eius. Eaque voluptatem corrupti commodi quia non. Sunt voluptate et veritatis voluptas necessitatibus fuga. Possimus est modi asperiores unde.Quas ut excepturi voluptatibus illum autem repudiandae ad magnam. Iusto est dolorum nesciunt rerum. Ut incidunt expedita quibusdam porro ducimus asperiores voluptas. Consectetur similique est commodi ipsa.', 997, 'Full', 'High', '9.97', 'Uzbekistan', '1', 'Lotus4.png', 1, NULL, NULL),
(58, 'Cactus15', NULL, 19.67, 'Nobis reiciendis nobis suscipit aut adipisci inventore. Nisi cupiditate aut vero ipsa quia et officiis sit. Veritatis nesciunt magni sapiente fuga. Illo qui dolorem est officiis.Nihil rerum sed ipsam et quaerat. Sint enim suscipit eum aspernatur vel doloribus praesentium corporis. Aut ut aliquam sed ad in atque. Ipsum enim alias porro modi occaecati.Repellendus fuga quis sequi non repudiandae explicabo quae. Velit maiores eum ipsam. Quo neque ea quam voluptas soluta qui molestias.', 921, 'Partial', 'Low', '1.67', 'Holy See (Vatican City State)', '1', 'cactus2.png', 3, NULL, NULL),
(59, 'Desert Rose15', NULL, 18.57, 'Nulla molestias cupiditate ut soluta iure. Dolor nesciunt eum voluptas nihil omnis. Quia voluptatem ratione qui culpa.Quia consequatur est est aut iusto. Incidunt et est voluptas quam sed. Harum voluptas ducimus vero et quo. Blanditiis autem nam sed accusantium.Nihil ab nostrum quia deserunt. Minus iure aut unde omnis debitis et. Qui fugiat optio dolorem numquam.', 428, 'Full', 'Moderate', '9.61', 'Gibraltar', '1', 'DRose1.png', 2, NULL, NULL),
(60, 'Hydrangeas15', NULL, 71.49, 'Eveniet ipsum reiciendis blanditiis voluptas. Iusto asperiores voluptas fugiat explicabo. Libero debitis laborum omnis dolor eveniet quia aut magnam. Ullam ut itaque quasi quaerat provident repellendus.Sint est est itaque expedita. Debitis omnis omnis et non repellendus earum aut veritatis.Non accusamus fuga aspernatur fuga et cumque. Ut id voluptas quisquam nisi nihil et. Sit sint tempora minus molestiae adipisci.', 87, 'Shade', 'Moderate', '7.98', 'Gabon', '1', 'Hydran2.png', 4, NULL, NULL),
(61, 'Lotus16', NULL, 32.14, 'Sit delectus aperiam et nobis non sed saepe deleniti. Illo dolorum rerum odit unde. Numquam ducimus accusantium facilis error exercitationem est quia.Maiores voluptatem quisquam sint repellendus. Recusandae ut provident nostrum ipsa consequatur. Quia amet sint natus excepturi nemo enim.Qui quo deserunt dolorem quo placeat modi accusamus. Voluptas a voluptas sunt dicta et. Cum fugiat sed amet libero. Accusamus quia autem temporibus quia doloribus enim quia.', 322, 'Full', 'Moderate', '7.23', 'Palau', '1', 'Lotus5.png', 1, NULL, NULL),
(62, 'Cactus16', NULL, 84.95, 'Velit quasi odit est non. Accusantium reprehenderit et quibusdam laborum earum qui. Praesentium iure repellendus et incidunt.Sunt provident aut itaque nemo. Vitae quis non qui dolores. Commodi nam optio nihil enim qui.Amet aut eveniet ipsa quia sapiente iure quis. Exercitationem dolore nisi totam autem dolores. Minus ratione voluptate quo amet maxime magnam.', 135, 'Full', 'Low', '8.57', 'Tokelau', '1', 'cactus2.png', 3, NULL, NULL),
(63, 'Desert Rose16', NULL, 46.00, 'Ex repellat dignissimos veritatis aspernatur necessitatibus ad ea. Dolorem sit illum error voluptatem itaque qui esse. Cupiditate consequatur laboriosam eos a. Et sit doloremque reprehenderit nesciunt et expedita autem. Consequatur velit sit non dignissimos nisi consequatur iste.Voluptatibus architecto qui sint. Impedit adipisci nesciunt accusamus quia quos id. Eveniet aut consequatur sint. Recusandae non et quas expedita aut rem quas.Rerum enim et corporis quos exercitationem. Molestiae id commodi reiciendis.', 198, 'Partial', 'Moderate', '8.71', 'Grenada', '1', 'DRose1.png', 2, NULL, NULL),
(64, 'Hydrangeas16', NULL, 62.44, 'Et et dicta et modi. Dignissimos ipsa voluptatibus tempore harum ab. Ut aspernatur veritatis molestiae nemo reprehenderit repudiandae. Repudiandae nihil eum est et dolorem. Culpa dolores perferendis nostrum delectus expedita eveniet nihil.Exercitationem eius nulla provident et earum vel culpa. Aspernatur accusamus sunt exercitationem quas tenetur qui. Quo quia et id sapiente at deleniti omnis.Est quam provident aut sed recusandae quidem eos. Dolore voluptatibus dolor voluptatem itaque distinctio. Illo ipsam nesciunt vero aperiam. Dolores non ut nesciunt animi aut illo est. Sed quidem maxime sapiente aliquam quia illum aut quaerat.', 347, 'Full', 'High', '1.6', 'Albania', '1', 'Hydran3.png', 4, NULL, NULL),
(65, 'Lotus17', NULL, 91.47, 'Officiis quidem error facere et. Perspiciatis soluta cumque odit. Doloribus facilis omnis mollitia fugiat exercitationem.Repellat pariatur neque omnis quo est. Distinctio unde qui ab rerum sapiente magni. Ducimus et doloribus et et inventore necessitatibus quam. Nihil dicta id saepe.Laboriosam voluptatem at enim. Magni quibusdam neque vel non hic. Laudantium quis rerum et repellendus provident rem. Eum consequuntur alias blanditiis esse autem.', 245, 'Full', 'Low', '8.98', 'Puerto Rico', '1', 'Lotus1.png', 1, NULL, NULL),
(66, 'Cactus17', NULL, 24.07, 'Consectetur sapiente dicta placeat autem et ea aut molestiae. Reprehenderit dicta numquam non distinctio.Iure sed non sit id. Aut repellat qui exercitationem odit culpa. Quos facere ut repellat autem. Corporis quis error odio et eos.Nisi sit adipisci et voluptatem. Quia id sunt eius consectetur magnam omnis in aliquam. Consequatur id dolores illum quia laborum.', 67, 'Full', 'High', '9.97', 'Hong Kong', '1', 'cactus2.png', 3, NULL, NULL),
(67, 'Desert Rose17', NULL, 39.80, 'Quidem nesciunt vel qui nihil eos aut. Iusto quidem repellat hic repudiandae iusto maiores doloribus. Itaque dolor laboriosam nostrum illum dolor id sunt error. Quia vitae ipsum necessitatibus quaerat quos accusantium.Sit et magnam mollitia. Non illum ut est illo quidem repellat at. Consectetur sequi adipisci eligendi iusto minima beatae quia ipsum. Qui incidunt enim voluptatibus inventore. Provident fuga deleniti quia rem ab eligendi sequi.Impedit repudiandae voluptas ut delectus odit earum repellat. Ipsam officia ratione aut deserunt. Vitae rerum consequatur suscipit voluptatem. Quo cupiditate placeat dolor temporibus repellat.', 436, 'Partial', 'Low', '3.2', 'Poland', '1', 'DRose4.png', 2, NULL, NULL),
(68, 'Hydrangeas17', NULL, 96.49, 'Mollitia omnis iusto ut dolorem blanditiis magni quaerat. Quia iusto iste atque voluptatum dolorum magnam quis. Molestias est ut natus deserunt totam. Aliquid nam maxime quis nihil sed ut esse. Libero voluptatem est quo similique et.Totam ut pariatur expedita velit alias ea consequuntur ducimus. Ipsam voluptas qui eligendi quae. Rerum et rerum rerum repellendus maxime saepe laudantium. Vel voluptatem cumque ipsum fuga vel.Repellendus iusto inventore eum et. Asperiores id voluptatibus nulla quasi commodi laborum et molestiae. Hic qui exercitationem ut labore. Repudiandae harum odit et qui voluptatibus voluptas et.', 457, 'Full', 'Moderate', '5.64', 'Niger', '1', 'Hydran3.png', 4, NULL, NULL),
(69, 'Lotus18', NULL, 30.50, 'Fugit in rerum doloremque assumenda. Consequatur amet aliquam alias facilis repellat vel laboriosam. Dolores mollitia qui quas. Neque voluptatem voluptas veritatis perferendis labore.Vel quos sunt veritatis quisquam saepe. Et unde qui est enim. Adipisci veniam dolorum aut rerum aut. Consequatur iusto quo rerum quo.Repellendus et rem sit aut. Molestiae eos commodi rerum. Non nam velit quo tenetur. Id soluta id dolor exercitationem iste aliquid.', 955, 'Partial', 'Low', '2.95', 'Papua New Guinea', '1', 'Lotus3.png', 1, NULL, NULL),
(70, 'Cactus18', NULL, 34.01, 'Illum ipsum rerum fugiat debitis ipsa. Harum consequuntur beatae tenetur quod sed. Debitis nobis eveniet excepturi.Provident quia omnis necessitatibus minima ducimus eum. Facere alias sit totam consectetur. Nihil aliquid amet placeat aut.Molestiae asperiores nulla facilis beatae error qui architecto sed. Laudantium non velit recusandae voluptatibus et fuga. Ut vel voluptate nemo voluptatem suscipit mollitia animi consectetur. Quae temporibus optio aut.', 223, 'Partial', 'Low', '5.56', 'Northern Mariana Islands', '1', 'cactus1.png', 3, NULL, NULL),
(71, 'Desert Rose18', NULL, 64.43, 'Accusamus quia facere voluptatem tempore. Non eveniet vero voluptatibus temporibus eos eaque molestiae. Officiis consequatur cupiditate voluptatem vel totam. Nisi cumque quam repellat molestias.Quod et voluptatum autem similique voluptas fugiat aut. Eaque assumenda dolor cumque molestiae perferendis eos ut.Doloribus ea quam animi deleniti aut. Rerum optio temporibus voluptatem. Modi enim qui eos quasi illo soluta sequi quia. Quia omnis labore voluptates sint neque quia. Qui sint optio id qui voluptatem recusandae assumenda.', 455, 'Full', 'Low', '8.85', 'Guyana', '1', 'DRose1.png', 2, NULL, NULL),
(72, 'Hydrangeas18', NULL, 51.55, 'Quam accusamus fugiat eum. Minus quisquam in error officia ex aut. Omnis omnis autem ipsa mollitia. Quam voluptatem molestiae asperiores dolor nemo adipisci ut.Autem et sit omnis tempore assumenda sunt quo. Maiores molestiae laboriosam iure ut sit reprehenderit aut.Enim voluptatem esse culpa occaecati enim quibusdam itaque. Quasi neque aut ullam consequatur reiciendis. Aspernatur distinctio praesentium enim omnis quo et. Exercitationem ut cupiditate ut voluptas consequatur cumque.', 136, 'Shade', 'Low', '5.37', 'Canada', '1', 'Hydran1.png', 4, NULL, NULL),
(73, 'Lotus19', NULL, 82.11, 'Et et maxime dolore sit molestias occaecati. Repudiandae animi veniam minus error. Occaecati maxime sunt quis.Enim aut voluptatum ratione quibusdam consequuntur natus impedit. Assumenda accusamus amet incidunt qui ab id et. Ipsam optio sunt non id molestiae.Consequatur praesentium quos distinctio ex commodi. Quia hic tempora ipsa eligendi est saepe. Quas eius itaque exercitationem aliquam consequatur et.', 86, 'Partial', 'High', '4.79', 'Bosnia and Herzegovina', '1', 'Lotus6.png', 1, NULL, NULL),
(74, 'Cactus19', NULL, 11.95, 'Soluta rerum culpa a molestiae et delectus accusamus. Ducimus iusto accusamus deleniti et. Eaque eveniet inventore quasi ea.Eius id ex et maiores exercitationem. Provident dolor nihil ullam magnam. Iure placeat autem et quos quaerat dolor unde magnam. Et modi quidem consequuntur et aperiam deleniti ex.Fugiat aut ipsam impedit. Harum voluptatem illo eos quis nobis. Consequatur dolorem quis magni aut error aliquam ipsum repudiandae. Rerum ipsum similique laudantium aliquam totam voluptate ut.', 159, 'Partial', 'Low', '4.83', 'Togo', '1', 'cactus1.png', 3, NULL, NULL),
(75, 'Desert Rose19', NULL, 84.90, 'Sunt voluptate molestiae eum sed at. Omnis sit quo qui quo modi cumque assumenda.Dolores voluptatem dolores minima magnam qui asperiores magni. Neque non sit atque eos aut. Sunt iure cum ducimus hic. Voluptatem incidunt atque et laudantium quia in.Nihil non ea aut et necessitatibus consequuntur. Perferendis minima sint dolorum amet quia.', 938, 'Full', 'Moderate', '2.43', 'Svalbard & Jan Mayen Islands', '1', 'DRose3.png', 2, NULL, NULL),
(76, 'Hydrangeas19', NULL, 61.58, 'Sunt aspernatur odit neque sit. Vel aut beatae tempora incidunt alias. Doloribus dignissimos sint dolorum alias. Quibusdam sunt nisi ad consequatur.Nostrum autem animi est voluptatem. Sunt consequatur tenetur nisi distinctio consequatur doloribus rerum enim. Odio totam tenetur sunt voluptatem voluptate est suscipit. Numquam aperiam minima provident quidem sint.Sunt enim pariatur non beatae veniam. Dolorem error consectetur illo ut odio pariatur rerum. Dignissimos ut et magni vel. Incidunt quis consequatur ut occaecati dolores.', 101, 'Full', 'High', '6.15', 'Montenegro', '1', 'Hydran3.png', 4, NULL, NULL),
(77, 'Lotus20', NULL, 98.36, 'Dolores quam beatae quia quos in atque aut. Voluptates mollitia consequatur optio officia rerum. Magni quidem fugiat officia fuga quo ut quidem.Velit nisi quo dolorem animi beatae ducimus. Ex cumque animi quia ut sit aut et. Eos aut debitis odit quos molestias ab.Rerum exercitationem dolorem tempora pariatur corrupti. Repudiandae nobis commodi error porro nulla ex accusamus eum. Architecto eius sint recusandae ut tempora. Neque impedit non vel quos illum illum quae earum.', 775, 'Shade', 'High', '3.3', 'Kuwait', '1', 'Lotus4.png', 1, NULL, NULL),
(78, 'Cactus20', NULL, 85.23, 'Beatae cupiditate dolore sunt quam ut qui et. Distinctio consequatur dolorum autem nam aut. Ut sit aut est nesciunt perferendis. Quia qui aut officiis aspernatur.Eos exercitationem laborum qui. Nesciunt itaque ea sit modi itaque eveniet et. Facere voluptatum aperiam omnis autem natus commodi. Consectetur quo ex non repellat aut quisquam atque.Sapiente explicabo quia quos qui rerum est officiis dolorem. Reprehenderit impedit est sunt molestias accusamus similique. Aut molestiae et itaque pariatur.', 840, 'Full', 'Moderate', '5.01', 'Brazil', '1', 'cactus1.png', 3, NULL, NULL),
(79, 'Desert Rose20', NULL, 47.86, 'Atque fuga rem nemo sed ipsum qui. Commodi dolores vitae ut non enim corrupti. Ratione nihil illum voluptatibus commodi impedit debitis dolorem odit.Quaerat vel amet ut consequatur doloribus possimus impedit. Inventore ut omnis sunt ipsa ipsa sunt aut neque. Mollitia vero explicabo sit qui quis perspiciatis nihil soluta. Ut numquam ullam quisquam reprehenderit aut.Saepe non enim rerum aperiam consequatur quia qui nihil. Voluptas rerum praesentium ullam officiis quasi occaecati aut quas. Aut et voluptates quisquam et. Commodi ea est illum.', 727, 'Full', 'Moderate', '8.52', 'El Salvador', '1', 'DRose4.png', 2, NULL, NULL),
(80, 'Hydrangeas20', NULL, 29.17, 'Id quibusdam sunt sunt sit laudantium laboriosam minus voluptatem. Iste iure delectus nemo non. Iusto dicta cumque molestias voluptas perspiciatis.Natus saepe fuga nemo cum. Accusamus consequatur autem explicabo modi et quisquam nostrum. Qui ut quo aliquid quia vel consequuntur magnam.Dolorem et quia excepturi quia recusandae ratione. Amet autem maiores eligendi optio autem. Dignissimos sequi quisquam et aut eum autem. Quia nobis expedita ex odit nisi expedita.', 483, 'Full', 'Moderate', '9.92', 'Congo', '1', 'Hydran3.png', 4, NULL, NULL),
(81, 'Lotus21', NULL, 56.08, 'Delectus facilis iusto fuga ut quia iste delectus repudiandae. Aut et dolorem corrupti exercitationem. Qui id quia distinctio ea perferendis.Sapiente delectus ut deserunt voluptatem. Iste neque natus nobis mollitia omnis. Cumque aperiam earum dolorem aspernatur. Sunt delectus inventore ea voluptatum quia repudiandae.Quo vitae est qui id. Nulla debitis qui vero rerum molestiae blanditiis quia. Id rerum temporibus id quis exercitationem corrupti. Eos pariatur qui autem sunt.', 136, 'Full', 'High', '9.57', 'Bulgaria', '1', 'Lotus2.png', 1, NULL, NULL),
(82, 'Cactus21', NULL, 69.87, 'Sint eos nesciunt sunt. Sunt minima vel recusandae repudiandae ducimus sit. Magnam accusamus ut consequatur repellendus voluptates consequatur blanditiis minima.Quidem et officia rerum doloribus ipsum cumque. Et consectetur magni nihil fugiat. Totam eius nesciunt neque eos aperiam. Velit ut blanditiis magni ut voluptatum.Dicta consequatur voluptas adipisci earum. Quas dolorem et dolor similique. Quidem quo quo voluptates illum minima et. Explicabo et et voluptatem maxime voluptas est.', 420, 'Full', 'Low', '5.22', 'Russian Federation', '1', 'cactus2.png', 3, NULL, NULL),
(83, 'Desert Rose21', NULL, 52.91, 'Quasi pariatur ut earum repellat dicta voluptas cumque. Qui eos qui saepe vitae cumque rerum.Veniam voluptatibus non labore sed. Nesciunt minima dolores dolorum ex nam. Asperiores sit quia nihil enim nobis. Deserunt et doloribus rerum rerum et quam.Possimus consequuntur cupiditate officiis repudiandae est corrupti voluptates. Atque ab dolores fuga est qui. Maiores labore repellendus tempore illum.', 395, 'Full', 'Moderate', '1.43', 'Lebanon', '1', 'DRose2.png', 2, NULL, NULL),
(84, 'Hydrangeas21', NULL, 56.01, 'Dolorem laboriosam quo quibusdam distinctio neque nostrum. Aspernatur qui doloribus libero voluptas. Perferendis eum vero delectus similique ut sit praesentium. Impedit dolore explicabo reprehenderit.Similique error sapiente est. Deleniti qui provident libero consequatur maxime cupiditate numquam. Repudiandae dolores quasi et odit neque odit quam. Quas sint ipsa ratione ut quaerat et.Placeat est debitis consectetur laborum quo dolorum. Culpa et nostrum incidunt autem. Nemo explicabo harum est suscipit veritatis sit deleniti aut.', 721, 'Partial', 'Moderate', '3.74', 'Samoa', '1', 'Hydran3.png', 4, NULL, NULL),
(85, 'Lotus22', NULL, 5.74, 'Dicta distinctio explicabo reprehenderit. Quibusdam rerum repellat unde in qui doloremque ab. Provident velit quis enim. Necessitatibus autem iusto doloremque nam soluta quam.Minima numquam impedit consectetur ex est eos sunt corrupti. Sint praesentium perferendis fugiat dicta.Quis modi et voluptatem deserunt ut et. Dignissimos cumque eum molestias tempore quae omnis sunt voluptatem. Ullam eum praesentium molestiae quidem.', 517, 'Full', 'Moderate', '6.69', 'Peru', '1', 'Lotus4.png', 1, NULL, NULL);
INSERT INTO `plant` (`id`, `name`, `sales_amount`, `price`, `description`, `quantity`, `sunlight_need`, `water_need`, `mature_height`, `origin`, `status`, `image`, `cat_id`, `created_at`, `updated_at`) VALUES
(86, 'Cactus22', NULL, 48.01, 'Soluta eos impedit porro quos. Reprehenderit et tenetur dolore ipsam saepe ratione occaecati ex. Quasi iste voluptas qui et.Hic iure architecto itaque at fugit voluptatum aut est. Quod ab placeat laboriosam ducimus aliquid alias impedit. Dolores recusandae adipisci esse nisi tenetur quia et.Voluptas est laboriosam voluptas reiciendis. Cumque in voluptate ut mollitia itaque ut dignissimos exercitationem. Quis ut et facere explicabo at et illum.', 353, 'Full', 'Low', '1.49', 'Palau', '1', 'cactus2.png', 3, NULL, NULL),
(87, 'Desert Rose22', NULL, 82.23, 'Quia quos cumque ad dicta aut numquam sunt. Voluptatibus ut nesciunt distinctio. Qui odio cupiditate ea dolores est praesentium atque. Aut delectus dignissimos minus voluptatem quia qui.Tenetur dolores accusamus omnis explicabo qui. Vero id neque quos. Possimus sunt dolorum reprehenderit laboriosam. Ut quas nulla ut fuga occaecati.Maiores nam quae animi. Iste doloribus quam velit nulla. Quia rerum sed voluptatem maxime. Blanditiis excepturi est iusto aut.', 152, 'Partial', 'Moderate', '2.33', 'Mexico', '1', 'DRose1.png', 2, NULL, NULL),
(88, 'Hydrangeas22', NULL, 93.00, 'Qui cum repellat id doloribus odio harum. Harum voluptatem fuga et atque ullam omnis officiis.Sed eligendi corrupti est eligendi adipisci cum ab. Pariatur distinctio facilis sapiente voluptatem. Sunt suscipit libero labore rerum quia in. Ad corrupti ullam ipsa ipsum dolorem.Architecto earum dolorem sint autem. Quibusdam accusantium ea sunt voluptas corporis. Nobis eos omnis quo natus placeat fuga est.', 819, 'Shade', 'Moderate', '8.53', 'Central African Republic', '1', 'Hydran1.png', 4, NULL, NULL),
(89, 'Lotus23', NULL, 71.60, 'Dolor dolorem dolores consequuntur eum et. Autem reprehenderit exercitationem quos sit. Ea quibusdam atque cum aut sit vel rerum. Dolorum expedita dolorem excepturi sed ullam.Illo et debitis officia et rem doloribus. A voluptas assumenda enim ea minima. Aut minus expedita provident illum modi. Possimus fugit quis quia quidem dolorem nesciunt qui.Est nesciunt voluptas sed nulla quaerat autem. Dolorem minima dolor porro atque ab. Ut in numquam libero et at quibusdam. Molestiae ut aliquam enim deleniti.', 583, 'Shade', 'Low', '8.85', 'Nepal', '1', 'Lotus6.png', 1, NULL, NULL),
(90, 'Cactus23', NULL, 64.09, 'Accusantium et sit suscipit. Aut iure quia harum debitis aperiam voluptates tempora. Deserunt qui occaecati aut rem.Aut tempora at veritatis ut. Odio hic nulla dolorum nam. Consequatur qui veritatis adipisci. Repellat non et natus numquam quae ducimus laboriosam.Quae quia consequatur aut praesentium commodi. Quisquam itaque sed quia.', 814, 'Full', 'Low', '8.98', 'Colombia', '1', 'cactus1.png', 3, NULL, NULL),
(91, 'Desert Rose23', NULL, 89.36, 'Ut tenetur totam eos nemo consequatur. Cum sint ipsa illum voluptas natus voluptas.Cum rem eius porro veniam quia est tempore sint. Non est porro earum et. Qui eaque laboriosam modi autem temporibus blanditiis.Consequatur quo dolorem culpa quidem nihil aperiam. Alias provident eos repellat quos ullam autem dolore quos. Asperiores voluptatibus est unde ducimus eum doloribus qui optio. Qui delectus nulla pariatur. Sint iusto molestiae cumque numquam.', 392, 'Shade', 'Moderate', '8.23', 'Albania', '1', 'DRose1.png', 2, NULL, NULL),
(92, 'Hydrangeas23', NULL, 24.75, 'Ut sed laboriosam eum. Nisi tenetur voluptate in veritatis illo. Beatae a error voluptate porro hic ipsum soluta.Placeat maiores pariatur et accusamus architecto quia qui. Error minima repudiandae neque dolorem. Enim qui sunt sed. Quis veniam repudiandae sint. Alias sequi officiis cum iusto nisi ipsum.Molestias tenetur ut qui numquam. Tempore odit dolore nobis. Ut assumenda sed quaerat ut. Maiores porro qui aut necessitatibus beatae. Deleniti qui et quidem et at nihil.', 459, 'Shade', 'Moderate', '9.9', 'Malawi', '1', 'Hydran1.png', 4, NULL, NULL),
(93, 'Lotus24', NULL, 50.02, 'Velit et magnam dignissimos voluptatibus. Praesentium nisi perspiciatis assumenda nihil. Possimus blanditiis molestiae reprehenderit aliquid perferendis atque.Rerum aut nulla non repellendus ullam sint. Corporis ducimus dicta aut eveniet. Est quos consequatur dolorem voluptas voluptatem. Corporis blanditiis deleniti qui rerum.Rerum quia ut dolorem quos expedita. Nobis vitae praesentium vero numquam. Quo omnis eveniet ipsa nihil sit earum. Occaecati autem reprehenderit autem aut voluptas excepturi.', 777, 'Full', 'Moderate', '5.86', 'Colombia', '1', 'Lotus2.png', 1, NULL, NULL),
(94, 'Cactus24', NULL, 46.37, 'Nisi doloremque eos dignissimos earum. Amet non dolores dolores vitae est minima cumque. Aut recusandae ut praesentium adipisci omnis ea exercitationem.Dolores et explicabo illo qui. Minus qui ea asperiores tenetur autem. Dolorum aliquam ipsum numquam impedit. Expedita maiores voluptate aperiam omnis dolorum soluta.Voluptas explicabo est aspernatur architecto dolorum. Consequatur eum ex ut temporibus alias. Odio aliquam natus aspernatur eos corporis omnis. Dolores explicabo corrupti velit.', 242, 'Partial', 'High', '2.28', 'France', '1', 'cactus1.png', 3, NULL, NULL),
(95, 'Desert Rose24', NULL, 71.77, 'Eum laborum ullam ut dolor ab autem id ad. Consectetur reprehenderit recusandae dolore animi facere numquam.Sit repellendus voluptatem aut saepe. Fuga unde reiciendis aut qui ducimus. Voluptate porro porro veniam dolorem.Et voluptate sapiente eum quia blanditiis dolor. Non nam sequi perspiciatis. Voluptas id beatae voluptatum eveniet. Vel laboriosam ipsum ipsam debitis esse molestiae.', 722, 'Full', 'Low', '7.42', 'Ethiopia', '1', 'DRose1.png', 2, NULL, NULL),
(96, 'Hydrangeas24', NULL, 38.08, 'Est non quis repellat ullam nostrum atque. Tenetur similique qui dolorem cumque sed atque dolores repellat.Ut et quidem dolor mollitia aut. Ut corrupti delectus doloribus blanditiis vero ut voluptatem. Aut dicta aliquid recusandae dolorem laboriosam.Fugit autem architecto autem velit assumenda labore sunt. Vero eaque aperiam rerum dolore rerum expedita. Quidem corporis sed ducimus sint eum adipisci unde sunt.', 146, 'Shade', 'Moderate', '1.09', 'Slovenia', '1', 'Hydran1.png', 4, NULL, NULL),
(97, 'Lotus25', NULL, 68.88, 'Ut nam totam reprehenderit magnam. Dolorum sunt eum amet velit. Optio aut laudantium quo accusamus.Quos cum at ut nobis nesciunt porro. Tempore quia quam odit totam eveniet et. Occaecati aliquid eius libero unde iste eveniet iusto. Quia qui excepturi officia sunt repellendus et.Error reiciendis ducimus soluta rem dicta expedita nam. Voluptas eum qui modi ut. Quam assumenda et sunt ab optio.', 580, 'Full', 'Moderate', '2.47', 'Greenland', '1', 'Lotus3.png', 1, NULL, NULL),
(98, 'Cactus25', NULL, 73.35, 'Reiciendis necessitatibus laboriosam et ipsum non ut consequatur delectus. Deserunt iste occaecati dolore. Ipsam officiis consequuntur sunt facere dolore iure.Magni nihil aut enim sunt similique dolorem. Molestias hic enim minus veniam. Velit ex eum voluptate eos hic.Sed eum eligendi omnis. Non enim explicabo odio quos. Consequuntur aut impedit possimus dolorum.', 862, 'Partial', 'Moderate', '4.31', 'Georgia', '1', 'cactus2.png', 3, NULL, NULL),
(99, 'Desert Rose25', NULL, 42.58, 'Aut quia repudiandae rerum. Omnis sit a iusto maxime harum culpa est. Vitae dicta eveniet inventore non.Et consequatur debitis dolorem aspernatur atque quod provident. Ut asperiores mollitia officia ut repellat consequuntur corrupti. Perspiciatis qui magni voluptate et.Qui cupiditate eligendi et impedit ut maxime velit. Tempora qui et voluptatum facilis. Libero necessitatibus illum quo et et. Rerum commodi qui inventore fugit aliquid quisquam. Eius soluta consequatur tempora atque sit.', 371, 'Shade', 'Moderate', '7.16', 'Antigua and Barbuda', '1', 'DRose4.png', 2, NULL, NULL),
(100, 'Hydrangeas25', NULL, 10.77, 'Cumque possimus voluptas ipsam qui quis. Quo et ut reiciendis reiciendis nostrum accusamus. Quia veniam vel hic. Aut et temporibus nisi reprehenderit culpa id.Quisquam ipsa cum laboriosam quis laudantium quo. Dolor nisi sed aut. Sit laborum nulla veritatis magnam quisquam dolor voluptatum.Nobis omnis ad dignissimos ipsa unde assumenda. Occaecati quos ullam et voluptas amet sint est dolorem. Doloremque in illo necessitatibus rerum quia qui. Et culpa iusto iste maxime et.', 256, 'Full', 'Low', '1.37', 'Benin', '1', 'Hydran1.png', 4, NULL, NULL),
(101, 'Lotus26', NULL, 37.19, 'Ducimus accusantium architecto illo ducimus aliquid. Vel architecto itaque molestiae in non. Numquam in non quod repellendus ipsam est.Est autem quisquam voluptas illo est et eaque. Et odio minus ipsum quia unde sapiente. Aperiam dignissimos et et a. Voluptatem ut quia fuga.Saepe optio velit labore dolorem maiores. Sed consequatur ab qui modi. Veniam laboriosam eius cupiditate et itaque doloribus ut.', 639, 'Shade', 'High', '7.83', 'Greece', '1', 'Lotus4.png', 1, NULL, NULL),
(102, 'Cactus26', NULL, 23.00, 'Natus sit sit mollitia est est atque. Maxime et sit voluptatibus nulla et aut et vel. Voluptatibus delectus neque ad quia voluptatibus. Perspiciatis dolorem quasi velit dolore illum molestias aut.Illo voluptatibus omnis sunt ipsam consectetur dolorem. Qui cupiditate asperiores voluptate voluptatibus. Repellat et earum ducimus ut est placeat et.Et hic repudiandae est inventore. Atque voluptates dolor ut adipisci aperiam accusamus. Vel et hic vero in quia. Adipisci vitae nihil quia quisquam voluptas incidunt nostrum.', 415, 'Partial', 'High', '9.29', 'Christmas Island', '1', 'cactus1.png', 3, NULL, NULL),
(103, 'Desert Rose26', NULL, 4.20, 'Veniam eligendi explicabo cupiditate animi laboriosam provident dolores sapiente. Aut esse et ut qui similique. Dignissimos omnis sit similique omnis molestiae. Eius eos eos quaerat nihil quia qui.Praesentium aspernatur corporis laudantium voluptatem aut placeat commodi. Id quia ut iste quis numquam earum quibusdam.Ex qui ut minus autem repudiandae. Cum aut mollitia maiores voluptas deleniti cupiditate. Alias molestias placeat nostrum tenetur velit aliquid.', 422, 'Partial', 'High', '6.01', 'Latvia', '1', 'DRose4.png', 2, NULL, NULL),
(104, 'Hydrangeas26', NULL, 25.22, 'Iste quia atque tempora ut quia. Quam iste suscipit laboriosam fugit doloribus sapiente rerum perspiciatis. Sequi eum quia impedit cumque vero.Sit eaque nihil nostrum consectetur corporis. Assumenda rerum quae dolores atque sunt. Quidem dolore qui voluptatem vero temporibus omnis architecto repudiandae. Ex quia debitis reiciendis voluptatum ut.Neque rerum atque ex. Nobis eveniet consequatur aut sint corporis. Inventore at asperiores nemo. Fugiat et error cumque.', 116, 'Full', 'Low', '9.49', 'Iraq', '1', 'Hydran2.png', 4, NULL, NULL),
(105, 'Lotus27', NULL, 50.16, 'Exercitationem consectetur aut sint iure. Optio ut molestias laboriosam. Qui non itaque reiciendis maxime sit sunt eos.Dolorem illum ea ipsa modi quis distinctio. Officia error eum ea voluptatem aliquid numquam in. Et eum est quo est.Earum et minima nulla eaque magni provident incidunt. Est qui reiciendis ea ipsam in quos voluptatem ab. Molestiae quia nulla atque fugit.', 444, 'Full', 'Moderate', '6.46', 'Iraq', '1', 'Lotus4.png', 1, NULL, NULL),
(106, 'Cactus27', NULL, 80.26, 'Natus alias pariatur error maiores ratione. Commodi ut accusamus qui quidem atque. Beatae corrupti voluptas eius ut aliquid.Ipsa in qui iste ut tempora. Nisi dolorem consectetur nesciunt dolorem ex et. Deleniti natus quisquam est eaque voluptate.Quaerat voluptatem laborum qui beatae minima dicta sit. Vitae non autem ut aut ut. Error aliquid molestias libero voluptas et. Labore occaecati aspernatur nam suscipit harum qui ut.', 861, 'Partial', 'High', '6.54', 'Ireland', '1', 'cactus2.png', 3, NULL, NULL),
(107, 'Desert Rose27', NULL, 45.16, 'Deserunt consequuntur sequi mollitia eum alias. Commodi facere qui enim quae. Nam voluptatem dicta quia dolores aperiam beatae inventore illo.Laboriosam placeat quae facilis exercitationem. Nostrum voluptatum tenetur a quos. Nulla tenetur saepe reprehenderit autem. Quisquam occaecati aliquam impedit sed sunt rerum rerum.Nemo voluptatem vel optio similique numquam commodi laborum. Doloribus similique vel aut vel. Sed et laudantium ipsam consequatur quae ipsum vitae.', 617, 'Full', 'Low', '3.96', 'Niue', '1', 'DRose4.png', 2, NULL, NULL),
(108, 'Hydrangeas27', NULL, 88.86, 'Iusto veniam qui rem sit pariatur. Molestiae enim iusto aut fugit. Ut laudantium beatae quo omnis odit animi unde.Omnis dicta soluta et et maiores veniam. Vel inventore autem nulla reprehenderit quia beatae id. Repellat eum est praesentium nemo aut velit eveniet. Ut animi ex iste odio ut odio eaque aliquid.Ipsa recusandae aut ipsa sed voluptatem voluptates. Architecto esse excepturi aut. Aut cupiditate ut nostrum sint et deserunt laborum.', 714, 'Shade', 'Low', '4.1', 'United Arab Emirates', '1', 'Hydran1.png', 4, NULL, NULL),
(109, 'Lotus28', NULL, 57.42, 'Tempore quis voluptates autem. Nihil deleniti dicta ut explicabo enim est enim. Magni minima qui vitae quidem id aut.Qui quisquam iure quaerat doloribus iste unde maiores. Voluptas magnam quis cupiditate a delectus atque nihil voluptas. Dicta mollitia id odit rerum voluptatem est. Praesentium minima nihil accusantium nihil nihil.Architecto asperiores ut aut. Nostrum vero commodi maxime aspernatur. Eum quia ut ab mollitia qui.', 633, 'Partial', 'High', '2.64', 'Latvia', '1', 'Lotus2.png', 1, NULL, NULL),
(110, 'Cactus28', NULL, 30.26, 'Iste commodi occaecati sint consequuntur reiciendis quia non. Voluptatibus dolor fugit nemo eligendi nihil quis at. Quo velit voluptas impedit vel similique.Culpa iusto molestias alias et. Quia possimus ullam sint iure. Magnam facere beatae saepe porro. Ab ipsam odio omnis.Expedita et sed exercitationem repudiandae quae voluptatem corporis. Pariatur eos quibusdam assumenda consequatur voluptatem. Et in quia praesentium minus omnis quis animi. Distinctio qui accusantium dignissimos veniam sed quae dicta cumque. Voluptatem labore eum dolor reiciendis eveniet nulla.', 748, 'Full', 'Low', '9.11', 'Iraq', '1', 'cactus2.png', 3, NULL, NULL),
(111, 'Desert Rose28', NULL, 10.32, 'Recusandae molestiae ut provident aperiam dolorum praesentium. Laboriosam odio voluptatibus reprehenderit est tenetur porro. Facere possimus nemo assumenda odio excepturi. Error eos et sunt dolorem magni et eos.Nobis ratione id laborum eum dolorem quo voluptas minima. Et amet tenetur facilis soluta. Nostrum quas et voluptas quia.Est odit maiores voluptatem. Laborum nemo cumque quidem molestias impedit enim deleniti. Iste voluptates cumque eveniet fugit fugit quidem eum. Voluptatum dolorem molestiae et nihil non. Cumque laudantium esse expedita et ab.', 249, 'Full', 'Moderate', '3.61', 'Czech Republic', '1', 'DRose1.png', 2, NULL, NULL),
(112, 'Hydrangeas28', NULL, 96.86, 'Omnis alias quam aspernatur sed. Ab placeat et sint. Inventore aut recusandae aliquam. Delectus dignissimos quo est architecto.Quo amet commodi omnis dolor quia illum aliquid. Dolorem provident est iusto deleniti voluptatem facilis. Quibusdam modi voluptatum id explicabo nesciunt ipsum et animi. Molestiae cupiditate error qui nemo id sequi consequatur.Aspernatur aperiam assumenda culpa aut recusandae assumenda nesciunt. Quia temporibus dignissimos aperiam iusto autem. Consequatur iure sed a quo. Quis eligendi qui qui.', 311, 'Full', 'Moderate', '1.65', 'Kuwait', '1', 'Hydran2.png', 4, NULL, NULL),
(113, 'Lotus29', NULL, 20.02, 'Aut minima et sint optio dignissimos. Ad aut aut quae natus rerum sapiente.Optio nobis excepturi necessitatibus sequi. Assumenda sint reiciendis vel rerum nihil minus voluptatem. Qui quas ut sint iure deleniti autem quos. Iure asperiores aliquid adipisci.Doloribus eaque totam quaerat velit sit autem doloremque. Iste quisquam sint cumque voluptatem aut. Saepe iure sunt mollitia illum accusantium dolor atque. Voluptatibus quaerat porro ex officia.', 543, 'Full', 'Moderate', '5.22', 'Jordan', '1', 'Lotus4.png', 1, NULL, NULL),
(114, 'Cactus29', NULL, 23.15, 'Perferendis enim et ea ipsum. Adipisci praesentium omnis accusantium molestias est. Commodi sed dolorum molestiae. Vitae enim voluptatem eaque neque qui praesentium.Non omnis doloribus minus fugit esse. Dolores eveniet commodi alias nostrum impedit et nulla. Eos aliquam dolorem eius voluptatibus est.Neque qui suscipit earum et qui fugit laborum odio. Qui eligendi corporis sint praesentium dicta. Ut enim ducimus vel.', 237, 'Full', 'High', '5.5', 'Bhutan', '1', 'cactus1.png', 3, NULL, NULL),
(115, 'Desert Rose29', NULL, 46.63, 'Consequuntur omnis nostrum at. Tempora doloremque beatae ducimus iusto ex quam. Ad neque architecto a sit.Dolore ea consequuntur voluptatibus rerum beatae sed non. Temporibus labore aliquid et et beatae harum autem ratione. Numquam non repellat amet quis beatae mollitia consequatur quis. Aut sed dignissimos tempore voluptatum.Omnis dolorem id omnis recusandae ipsum consequuntur. Suscipit totam ut magnam quidem aperiam. Ut temporibus eius aspernatur voluptates quaerat aspernatur.', 687, 'Shade', 'Moderate', '7.16', 'Azerbaijan', '1', 'DRose4.png', 2, NULL, NULL),
(116, 'Hydrangeas29', NULL, 33.53, 'Deserunt debitis et sed voluptatibus. Beatae rerum ut cupiditate omnis. Consequatur et atque aut et non laboriosam. Occaecati autem quis qui et maxime. Et adipisci qui reiciendis consectetur itaque sunt tempore.Omnis est sit earum voluptas ea voluptatibus. Est perferendis voluptatem aut eius. Quia ad vel sit est repellendus illum. Soluta animi sint ducimus totam dicta molestias.Aut exercitationem inventore assumenda eaque aliquam quia. Rem nihil qui porro sapiente. Qui quisquam ut qui necessitatibus deleniti et.', 956, 'Partial', 'High', '6.66', 'Marshall Islands', '1', 'Hydran3.png', 4, NULL, NULL),
(117, 'Desert Rose Pink Red', NULL, 20.00, 'Ea nobis molestiae quia officia omnis eum dolorem ea. Ut et reprehenderit corrupti molestiae minus qui ipsum in. Natus iusto non porro quibusdam pariatur.In quo vero ea est provident inventore. Maiores veritatis quod consequatur minus minus. Sequi sunt inventore ex accusantium. Repellendus aliquam nulla doloremque et quasi enim.Numquam quia veniam tempore architecto quisquam. Expedita porro odio pariatur dolorem soluta assumenda impedit. Occaecati molestiae minima qui dolores. Qui dolores sequi consequuntur perspiciatis ad.', 10000, 'Partial', 'Moderate', '1.2', 'Malaysia', 'custom', 'DesertRosePinkRed.jpg', 2, NULL, NULL),
(118, 'Desert Rose Red', NULL, 20.00, 'Necessitatibus expedita nesciunt iusto non. Est voluptas inventore omnis est quidem iste et eveniet. Temporibus dolorem sed similique.Et molestiae est sed deleniti quo dolore ipsum. Dicta et hic ea quo delectus. Quis ea qui repudiandae sapiente.Debitis ducimus ea fugiat dignissimos vel esse. Iure dolorum illum iste est nihil dolores. Accusamus quia sunt molestiae voluptatem qui unde.', 10000, 'Partial', 'Moderate', '1.2', 'Malaysia', 'custom', 'DesertRoseRed.jpg', 2, NULL, NULL),
(119, 'Desert Rose Pink White', NULL, 50.00, 'Non sed repellendus et ratione et qui laborum. Voluptatem quasi incidunt nam explicabo excepturi aliquid. Assumenda consectetur facilis quas hic consequatur similique veritatis. Dolore corporis qui rerum deleniti ut aperiam expedita.Aut rem enim consectetur porro perferendis quia corporis. Quas natus excepturi voluptatem dolores quia. Alias aspernatur quam suscipit quia veritatis quos aut. Et numquam neque quo est.Dignissimos eaque aliquam quibusdam aut et architecto. Debitis quia dolor et velit ipsa fugiat. Sit ad ea consequatur cum.', 10000, 'Partial', 'Moderate', '1.2', 'Malaysia', 'custom', 'DesertRosePinkWhite.jpg', 2, NULL, NULL),
(120, 'Lotus1', NULL, 70.48, 'Nesciunt doloremque ut et et porro natus doloribus deserunt. Provident voluptas provident blanditiis numquam. Nostrum omnis velit eligendi quod repellendus.Nostrum incidunt quisquam at aut libero nemo aut. Et laborum ut quia officiis recusandae sed consequuntur. Blanditiis ut id qui explicabo reiciendis nulla. Consequatur quam ex officiis fuga sunt quia voluptatem.Magnam velit accusantium aut non rerum similique. Voluptates nisi non similique molestias nam accusantium amet. Ea sunt et odit molestiae architecto modi distinctio.', 619, 'Partial', 'High', '5.55', 'Belgium', '1', 'Lotus6.png', 1, NULL, NULL),
(121, 'Cactus1', NULL, 68.77, 'Exercitationem doloribus sed aut in. Ea aut perspiciatis et sit. Eius id ut ipsa inventore.Omnis voluptatem vel dignissimos velit in consectetur eveniet sed. In non in molestiae officia suscipit voluptatibus est. Voluptatem consequatur non ab deleniti voluptates sint reiciendis quis. Numquam saepe totam accusantium voluptatibus voluptatem.Eum eos expedita in. Optio quidem veniam qui unde qui. Dolorem earum corporis ex consequatur sit temporibus blanditiis corporis.', 55, 'Partial', 'Low', '4.77', 'Pitcairn Islands', '1', 'cactus1.png', 3, NULL, NULL),
(122, 'Desert Rose1', NULL, 5.76, 'Voluptas consequuntur dolores sequi repellat blanditiis ullam. Laboriosam quis suscipit molestiae quia labore.Enim facilis sequi hic architecto accusantium et. Molestias dolorum qui expedita quae eum. Natus similique rerum inventore et ipsum et repudiandae.Iusto enim nihil necessitatibus. Qui illum alias blanditiis repudiandae. Quia et ullam molestiae sed. Quam possimus maxime magnam sit accusantium mollitia harum consequuntur.', 395, 'Full', 'High', '2.96', 'Bermuda', '1', 'DRose4.png', 2, NULL, NULL),
(123, 'Hydrangeas1', NULL, 30.35, 'Quidem et fugit rerum quibusdam nesciunt aut sit. Tempore illo temporibus ab rerum. Sapiente eos expedita rem error.Consequatur enim ut ut deleniti aut quia tempore. Cupiditate similique laudantium blanditiis dicta quidem. Magni quibusdam voluptatem non est amet repudiandae temporibus. Esse autem qui cupiditate ut cum tempora maiores.Voluptas nihil et modi voluptas rerum eaque ipsa provident. Repellat optio labore voluptatem iure eveniet. Saepe harum provident est est aspernatur omnis. Dicta et unde eveniet.', 135, 'Full', 'Low', '7.85', 'Saint Barthelemy', '1', 'Hydran2.png', 4, NULL, NULL),
(124, 'Lotus2', NULL, 41.12, 'Consequatur qui aut repellendus. Similique dolorum repudiandae est unde. Nam quo culpa rerum quisquam eos. Sit fugit voluptates sed.Soluta et sit laborum ipsa labore tempora. Aperiam occaecati eius est sit. Non similique voluptatem laborum vitae earum illum ut.Doloribus totam nihil aspernatur iste quaerat vel. Aspernatur exercitationem et quia saepe tenetur.', 510, 'Full', 'Moderate', '9.97', 'Botswana', '1', 'Lotus2.png', 1, NULL, NULL),
(125, 'Cactus2', NULL, 57.52, 'Qui sed maxime harum commodi. Culpa deleniti enim assumenda id. Quae aut magni corrupti quasi iure consequuntur. Quia quos optio et doloremque porro libero minima.Laudantium illum facere et ut exercitationem aliquid nihil. Autem velit expedita ut incidunt aspernatur id corrupti porro. Similique ut commodi incidunt molestiae itaque dolores. Dolores sapiente voluptatem perspiciatis ea.Eos quaerat et quae dolorum quia temporibus. Placeat alias animi eum id animi. Nesciunt est autem molestias qui illo ut occaecati. Molestiae ipsam quaerat eligendi excepturi qui autem. Debitis quaerat sint quas non esse.', 451, 'Shade', 'Low', '2.43', 'Kiribati', '1', 'cactus2.png', 3, NULL, NULL),
(126, 'Desert Rose2', NULL, 5.59, 'Harum illo ipsum qui rerum. Nihil soluta rerum tenetur sequi architecto. Fugiat consequatur sed vitae.Aut dolores laudantium sed non qui. Iure blanditiis id aliquid nulla. Magnam et asperiores aspernatur dolorem ut consequuntur dolore. Eveniet in sit dolorem minus iure sunt. Voluptates laboriosam dignissimos quia impedit.Ea ab nostrum maxime necessitatibus architecto minima. Neque vero quasi ipsam reiciendis laborum. Accusamus voluptatem in recusandae sit placeat.', 498, 'Full', 'High', '2.2', 'Samoa', '1', 'DRose1.png', 2, NULL, NULL),
(127, 'Hydrangeas2', NULL, 2.47, 'Id blanditiis laborum placeat nihil. Voluptate animi ea qui nesciunt.Culpa laboriosam sed expedita ut sed corporis odio. Vero perspiciatis vel explicabo dolorum eligendi ex.Veniam quis ut similique nihil vel fuga minus. Quasi ut accusantium rerum possimus. Ea aut laboriosam quam perferendis perspiciatis. Facere qui cupiditate ex consequatur mollitia qui id sit.', 193, 'Full', 'Moderate', '4.84', 'Denmark', '1', 'Hydran2.png', 4, NULL, NULL),
(128, 'Lotus3', NULL, 78.96, 'Molestiae assumenda consequatur consequuntur voluptatem. Illo neque voluptas et velit non esse deleniti. Perferendis sunt recusandae nostrum fugiat voluptatem id.Rerum animi blanditiis occaecati nesciunt velit in et. Reprehenderit aut harum voluptate qui eius incidunt. Illum sit cum sed. Tempora ratione quis est qui.Animi aut sequi recusandae rerum ut consequatur. Aliquam omnis velit quia laborum iusto sint aut perspiciatis. Sapiente et et tenetur ipsum. Dolore fugit qui et dolorem eveniet velit.', 94, 'Partial', 'Moderate', '1.77', 'Reunion', '1', 'Lotus2.png', 1, NULL, NULL),
(129, 'Cactus3', NULL, 54.03, 'Unde sint quia eos sunt. Consequatur et aut consequatur. Ut sed doloribus quasi sunt nesciunt. Iste aperiam ut perferendis laborum.Recusandae ab quia et fuga dicta. Cumque iste soluta voluptatibus est voluptatem non et. Qui voluptas modi blanditiis et commodi ipsa.Adipisci qui at enim culpa velit sint blanditiis. Quibusdam voluptatem debitis nulla omnis corporis rerum cupiditate dolore. Magnam vitae aliquam quis ut nam ut voluptatem. Consequuntur ut unde omnis sed aliquid.', 164, 'Partial', 'High', '2.03', 'Mozambique', '1', 'cactus1.png', 3, NULL, NULL),
(130, 'Desert Rose3', NULL, 3.45, 'Quo et consectetur dolorem ut. Et quis excepturi officia ipsam.Nihil id sint perspiciatis aut omnis quibusdam. Nihil placeat laboriosam rerum exercitationem repudiandae quibusdam et. Voluptatum esse sed itaque tempora. Et quia asperiores commodi atque consequatur.Magnam natus nemo magni velit necessitatibus. Voluptas nisi et velit sit accusantium in ullam. Inventore autem et magnam suscipit delectus. Culpa id nesciunt accusantium molestias rerum temporibus.', 723, 'Shade', 'Low', '7.29', 'Slovenia', '1', 'DRose1.png', 2, NULL, NULL),
(131, 'Hydrangeas3', NULL, 67.96, 'Libero qui temporibus omnis dolor velit. Quia animi dolore est ipsam quod rerum maxime. Magni dicta veniam sed consequatur qui sed dolor porro.Expedita ab et voluptatem vitae quo esse fugiat laborum. Libero rerum minima eius omnis praesentium sint iste omnis. Fuga nihil et velit asperiores. Tenetur velit blanditiis eos provident amet exercitationem.Suscipit voluptatum id repellat nam numquam dolorum. Nisi ab animi voluptatum eligendi veritatis. Architecto vel molestiae sint alias nihil maxime. Mollitia et laborum facere rerum fugiat rerum nihil quaerat.', 638, 'Partial', 'Moderate', '4.09', 'Guam', '1', 'Hydran1.png', 4, NULL, NULL),
(132, 'Lotus4', NULL, 8.76, 'Ex voluptatem reprehenderit esse repudiandae adipisci. Animi quasi sed labore possimus eaque. Rerum quia sint aliquam voluptate omnis ut vero consectetur.Vel tenetur quo tenetur laboriosam. Illum fugiat aut ut labore iusto praesentium illo enim. Repellat quis commodi sed nam. Tenetur exercitationem pariatur enim et ipsa.Aperiam aut odit enim at quisquam. Asperiores blanditiis exercitationem et magnam id nobis. Quia rem odit voluptas nihil adipisci.', 648, 'Partial', 'Moderate', '8.68', 'Macedonia', '1', 'Lotus4.png', 1, NULL, NULL),
(133, 'Cactus4', NULL, 63.47, 'In saepe rerum velit possimus eum. Voluptatem ut et optio enim illo. Quae eos doloribus unde aperiam. Qui iusto cum aut pariatur nihil ratione.Ad eos iste fugit. Explicabo iure quo dolores sequi. Error qui voluptatem odit dolorem.Non omnis inventore sed ullam et sed ut. Natus hic et eveniet id sequi nulla sed ut. Nobis et qui non ut voluptas.', 546, 'Full', 'Low', '9.78', 'Cyprus', '1', 'cactus2.png', 3, NULL, NULL),
(134, 'Desert Rose4', NULL, 32.44, 'Magni id occaecati laboriosam sunt incidunt. Ea soluta sunt iste repellendus suscipit.Voluptas eaque eligendi atque omnis ut corrupti recusandae. Facilis inventore voluptatem ut odio. Nesciunt consequuntur delectus pariatur quod qui voluptatem excepturi. Modi et numquam est et voluptate nobis.Dolor qui quisquam architecto est inventore. Non deserunt quibusdam id. Non eveniet quisquam quaerat consequatur earum aut.', 495, 'Partial', 'High', '4.57', 'Algeria', '1', 'DRose3.png', 2, NULL, NULL),
(135, 'Hydrangeas4', NULL, 60.06, 'Aspernatur quis iure dolorem quod autem aut iusto. Odit doloribus voluptas architecto quasi deleniti voluptatem corporis ut. Cumque eligendi voluptatem suscipit asperiores.Ducimus est aut exercitationem minima est aliquid pariatur. Deserunt eos delectus provident culpa cum. Aliquam natus dicta voluptas voluptatum odio maiores. Blanditiis temporibus nemo nam deleniti nostrum eum possimus. Id sunt labore sit iusto ipsa aliquam.Amet aperiam enim neque. Sed perspiciatis ullam reprehenderit at ullam quo. In non voluptatem expedita ut occaecati. Error illo quasi reprehenderit autem sed aut.', 315, 'Shade', 'Moderate', '7.75', 'Guernsey', '1', 'Hydran1.png', 4, NULL, NULL),
(136, 'Lotus5', NULL, 92.91, 'Beatae aut dolorem ut ut accusantium et quod. Atque sunt sapiente cupiditate mollitia ipsam unde. Sit ut dolorum eveniet aspernatur facere voluptas. Explicabo id sunt sit aut aut similique.Illum ad saepe pariatur adipisci ut et sed et. Voluptate harum amet culpa saepe cumque voluptatibus. Illo officiis aspernatur aut veritatis id.Sit neque tempore incidunt illo quia suscipit. Molestiae nulla aliquid corrupti. Illo architecto ipsum non nobis aut. Qui non quo commodi sequi nam vel ipsam.', 497, 'Shade', 'High', '6.68', 'Burundi', '1', 'Lotus1.png', 1, NULL, NULL),
(137, 'Cactus5', NULL, 36.38, 'Dicta qui dignissimos iste. Est nesciunt culpa eos at laboriosam natus. Tenetur magnam enim quos ea suscipit quidem dolores. Eligendi fuga et quam quod enim voluptatum laboriosam.Rerum sapiente atque cumque delectus. Aut minus quia sit optio sit in. Iste repudiandae dicta est repellendus minima qui cumque. Quo omnis et odio quo ex.Id voluptatem facere perferendis eius. Nam voluptates iste sunt aperiam. Eum aspernatur sequi omnis. Mollitia commodi autem voluptas in odit.', 557, 'Full', 'Moderate', '6.73', 'Bolivia', '1', 'cactus2.png', 3, NULL, NULL),
(138, 'Desert Rose5', NULL, 75.04, 'Voluptas quis quod nesciunt voluptas sequi. Qui repellendus beatae aspernatur quaerat voluptate et laboriosam. Maxime voluptas recusandae dolores dolorem soluta necessitatibus pariatur.Corporis quis ut excepturi soluta. Et cum eligendi porro eius. Corrupti reiciendis voluptas voluptatum animi dolorem omnis officiis rerum. Est inventore magni voluptatem.Illum ad voluptatum in ut consequatur sequi sit autem. Error saepe consequatur doloremque autem. Earum consequatur dolor est. Error distinctio error laborum incidunt sit.', 736, 'Shade', 'High', '4.26', 'India', '1', 'DRose1.png', 2, NULL, NULL),
(139, 'Hydrangeas5', NULL, 5.79, 'Et dolor ut repellendus consectetur esse dolor et. Mollitia magnam rem quis quia repellendus.Aut architecto alias laboriosam autem quidem quo consequatur. Maxime incidunt est exercitationem autem exercitationem enim maiores. Porro sit cumque temporibus maxime. Rerum ducimus voluptate consequatur.Et sed qui est illum id consequatur. Qui odit et animi adipisci maiores ut reiciendis.', 251, 'Full', 'High', '4.62', 'Saudi Arabia', '1', 'Hydran3.png', 4, NULL, NULL),
(140, 'Lotus6', NULL, 12.10, 'Dolor facilis eveniet deleniti quibusdam sed. Doloribus vel occaecati laborum minus consequatur. Officiis exercitationem mollitia quod inventore quasi eos aut. Excepturi perspiciatis totam eos ea et ut quia.Sed quia inventore maiores. Et omnis dicta corrupti voluptates. Quia nam dolorem impedit ipsum. Odit omnis nulla autem dignissimos soluta repellendus officia.Minus labore consequatur dolor maxime voluptates explicabo. Ut enim modi enim omnis. Rerum id odit et vel est dolores laudantium sunt. Debitis voluptatem sequi repudiandae repudiandae est.', 632, 'Partial', 'Moderate', '6.58', 'Andorra', '1', 'Lotus3.png', 1, NULL, NULL),
(141, 'Cactus6', NULL, 38.10, 'Quis nisi sapiente dolore pariatur. Sit occaecati reiciendis eos adipisci esse sit temporibus. Est ut temporibus id et non excepturi dolorem rerum.Velit omnis voluptatem qui et quas. Provident nemo laudantium ea in eum. Culpa sunt ut reiciendis blanditiis voluptatum autem aut minima.Perspiciatis possimus enim itaque ipsa deserunt architecto sed. Ut dolor minus aut voluptatem. Officia totam quibusdam iure similique deleniti autem.', 649, 'Partial', 'High', '1.49', 'El Salvador', '1', 'cactus2.png', 3, NULL, NULL),
(142, 'Desert Rose6', NULL, 51.67, 'Voluptatibus ea placeat rerum at. Provident fuga incidunt tempora odit deleniti laudantium. Totam rerum vel voluptatem non repudiandae qui. Rem sit ducimus quaerat itaque dolorem laborum et. Quia eius consectetur at quisquam nam aut eos.Velit autem qui eligendi qui repellendus minus provident. Laboriosam a ipsam cumque atque enim quia optio.Laudantium rerum qui rerum hic est exercitationem. Consectetur iure et odio vel at natus. Beatae perspiciatis doloribus repellat.', 888, 'Shade', 'High', '9.22', 'Albania', '1', 'DRose3.png', 2, NULL, NULL),
(143, 'Hydrangeas6', NULL, 51.40, 'Qui perferendis ut autem rerum rerum aperiam adipisci sunt. Sit distinctio commodi dolor quod inventore vitae sed. Sed quaerat eius nemo maiores dolorem.Quaerat sed aliquam molestiae iusto aut ut. Aliquam unde porro vero quam et repudiandae corporis. Voluptatibus et quo et similique deleniti dolor nihil eveniet.Quod voluptas nesciunt modi fugit labore. Quaerat molestias nulla nihil assumenda ratione impedit excepturi cumque. Non ex rerum deserunt deserunt ea unde. Ut consequuntur blanditiis et inventore.', 413, 'Partial', 'Low', '2.86', 'Aruba', '1', 'Hydran2.png', 4, NULL, NULL),
(144, 'Lotus7', NULL, 95.57, 'Officiis rerum amet expedita ut eaque eaque. Dolor nihil in laboriosam et.Quo autem dolores ex. Sed consequatur dolores deserunt sunt molestiae et sint. Tempora excepturi sed nulla libero. Iste voluptatem amet aut vel. Iste ratione sed a eaque non aut.Illo cum cumque fugiat exercitationem possimus porro. Amet et officia rem vel ex ex illum. Quo quidem assumenda qui iusto. Commodi quos rem et vitae enim aut architecto.', 161, 'Shade', 'Low', '6.96', 'Luxembourg', '1', 'Lotus5.png', 1, NULL, NULL),
(145, 'Cactus7', NULL, 3.51, 'Est reprehenderit magnam unde molestias aut. Et quidem consectetur libero consequatur ullam unde. Quia mollitia explicabo esse voluptatem.Omnis sed nulla explicabo quia. Vero provident voluptatum voluptas ut quae eos. Qui quos asperiores dolorem accusamus ut ex.Voluptatem non aut iusto in maxime non. Consectetur est in voluptas qui dolores animi. Assumenda beatae qui qui quaerat corporis. Enim dolores eveniet eum similique et.', 315, 'Partial', 'Moderate', '7.12', 'Saint Vincent and the Grenadines', '1', 'cactus2.png', 3, NULL, NULL),
(146, 'Desert Rose7', NULL, 87.19, 'Consequatur minima et illo laboriosam odio. Tempore autem repellat sint. Incidunt vel laborum voluptatem et. Unde vero nobis minima voluptatem expedita.Aut iusto aspernatur libero tenetur eos. Ut earum rerum excepturi voluptas. Repellat pariatur vel enim aperiam et. Sit a optio harum aliquam eius.Error excepturi qui nobis earum. Et molestiae reiciendis ut autem incidunt. Eveniet voluptas cupiditate iusto et. Eligendi recusandae temporibus neque hic inventore.', 478, 'Full', 'High', '6.1', 'Kuwait', '1', 'DRose4.png', 2, NULL, NULL),
(147, 'Hydrangeas7', NULL, 82.73, 'Ipsam a praesentium dolorem. Quam libero consequatur blanditiis aliquam ipsum laborum recusandae sint. Ut natus quae facere ut aliquam reprehenderit.Iusto magnam dolore voluptatem ea doloribus mollitia ea. Aperiam ut accusamus quisquam molestiae. Exercitationem quas culpa nemo est omnis est sapiente. Blanditiis in voluptas earum qui.Vel numquam ut ut. Doloremque aut repudiandae est aut est. Debitis adipisci quo officia accusantium corporis porro nihil. Suscipit est quis modi delectus.', 714, 'Full', 'Low', '7.28', 'Puerto Rico', '1', 'Hydran1.png', 4, NULL, NULL),
(148, 'Lotus8', NULL, 79.38, 'Quis quo ab minus vel sit at. Et quisquam dolor aliquid consequuntur delectus sunt. Molestiae iusto est vel harum. Neque mollitia culpa blanditiis possimus modi molestiae nesciunt.Debitis esse harum consectetur non dignissimos. Quis harum amet repellendus aperiam ea. Deserunt eos consectetur optio et vero. Ullam incidunt culpa laborum repellat reprehenderit necessitatibus inventore.Voluptatem voluptas ut quae alias autem quo quo. Labore ipsam doloremque quia eos laboriosam. Enim et eaque ut cumque dolor.', 419, 'Shade', 'High', '3.86', 'Israel', '1', 'Lotus3.png', 1, NULL, NULL),
(149, 'Cactus8', NULL, 65.17, 'Esse possimus praesentium tenetur nam autem. Sint quis aut minima culpa recusandae. Omnis eum sapiente veniam incidunt nisi. Accusantium dignissimos accusantium harum possimus sunt quidem voluptas.Itaque ut nobis et fuga numquam et. Pariatur est quo eos dolor inventore molestias. Veniam autem deserunt accusantium adipisci et.Rem voluptas quia deserunt optio dolore in velit ipsam. Sit reprehenderit voluptas aut tenetur qui facilis.', 244, 'Full', 'High', '1.92', 'Cook Islands', '1', 'cactus2.png', 3, NULL, NULL),
(150, 'Desert Rose8', NULL, 44.74, 'Et maiores porro est nostrum. Fugit provident aliquid eius et molestiae. Dignissimos vel illum laborum et. Ea ex non soluta porro dolores excepturi eos.Quia voluptatem ut provident quasi laudantium ab alias. Aut voluptatem consequatur ipsum. Mollitia est unde sapiente voluptate. Enim non voluptate ut. Facilis laudantium eius molestiae atque consequatur qui sunt.Animi culpa temporibus et quibusdam aut. Nulla amet ipsa officia. Ea eveniet sed perspiciatis est rerum.', 498, 'Full', 'Low', '6.04', 'Kazakhstan', '1', 'DRose2.png', 2, NULL, NULL),
(151, 'Hydrangeas8', NULL, 92.36, 'Expedita tenetur maxime delectus qui minus est minus. Occaecati mollitia omnis odio quos ut hic.Aut omnis fuga et dolores. Unde laborum labore quas velit. Mollitia voluptas vero quibusdam repellat deserunt cum. Eum aspernatur suscipit nihil in.Asperiores suscipit qui dolores optio est tempore debitis. Et omnis ipsam earum veritatis sint exercitationem. Natus corrupti reprehenderit quam et. Consequatur labore sed ut vitae est delectus. Sit amet nostrum commodi sequi inventore iusto mollitia.', 66, 'Shade', 'Low', '4.78', 'Togo', '1', 'Hydran1.png', 4, NULL, NULL),
(152, 'Lotus9', NULL, 58.38, 'Enim et id quas dicta vel. Doloribus eius voluptate consequatur dolorum omnis quis. Doloremque nesciunt totam odio repellendus quis saepe dolorem consequatur.Est dolorem molestias est placeat. Sequi architecto rerum cum nulla. Et fuga quibusdam mollitia officia. Autem impedit cumque doloribus assumenda rerum.Ut perspiciatis et animi delectus omnis. Velit alias qui vitae adipisci. Nobis dolor quod praesentium in voluptas fuga.', 608, 'Partial', 'High', '5.76', 'Mayotte', '1', 'Lotus3.png', 1, NULL, NULL),
(153, 'Cactus9', NULL, 23.39, 'Reiciendis atque ut impedit fuga sapiente. Dolor voluptas voluptatibus et repellendus similique qui pariatur. Molestias voluptatibus iste totam aspernatur repellendus ipsum laboriosam. Fugit et est repellat nihil libero. Eaque dolor in eos modi.Recusandae magnam eum earum dolor consequatur perspiciatis recusandae. Et nemo voluptatibus atque ut officia natus. Nesciunt qui consequatur vel eos amet enim omnis.Quam nostrum qui autem. Autem dolorem pariatur unde aut a eum animi veritatis. Sit eligendi et necessitatibus et sint dolore ex. Eum consequatur doloremque nobis praesentium exercitationem numquam id.', 71, 'Partial', 'Moderate', '3.99', 'Papua New Guinea', '1', 'cactus1.png', 3, NULL, NULL),
(154, 'Desert Rose9', NULL, 2.93, 'Praesentium enim dolore et voluptates neque excepturi. Temporibus quidem officia enim dolor. Maxime omnis non inventore odit optio dolorem quia.Voluptatem doloremque minus ratione nisi est. Ex et consectetur doloremque aut maiores architecto. Cum sit repellendus ab quas sed. Consequatur dignissimos est eaque laudantium.Saepe quidem odio voluptatem quia tempore beatae ea. Consequatur at consectetur sint nulla odio sit. Qui quidem voluptate expedita. Qui distinctio voluptatum nobis qui quo sit vero.', 28, 'Shade', 'Moderate', '9.12', 'Grenada', '1', 'DRose4.png', 2, NULL, NULL),
(155, 'Hydrangeas9', NULL, 72.52, 'Doloremque cumque voluptate repellendus beatae facere sit reiciendis. Et quaerat earum est. Eius quaerat a voluptatem quas in reprehenderit reprehenderit. Quas non inventore est a voluptates.Quidem iure tempore facilis dicta in. Quia eos blanditiis et voluptas. Ipsam inventore quam delectus dolorem placeat aliquid et.Eum ipsa molestiae quae et consequatur. Modi reprehenderit vel eum et est tempora. Ratione id est tempore vero molestias.', 646, 'Shade', 'High', '6.43', 'Malta', '1', 'Hydran2.png', 4, NULL, NULL),
(156, 'Lotus10', NULL, 39.05, 'Consequatur provident veniam vitae omnis quia asperiores placeat voluptatum. Possimus dicta quos illo non facilis laborum in et. Sit ratione dicta voluptatum.Et corporis sit voluptate consequatur. Nihil dolores consequuntur quisquam occaecati possimus pariatur et. Accusamus culpa possimus sequi cumque aut impedit expedita necessitatibus.Eum est et odio commodi. Recusandae deserunt exercitationem quo assumenda in ipsum quo sunt. Voluptatibus sunt maiores dolorem a. A dolores vel alias.', 701, 'Full', 'High', '9.53', 'Tokelau', '1', 'Lotus5.png', 1, NULL, NULL),
(157, 'Cactus10', NULL, 64.47, 'Voluptatem velit cum iusto autem. Consequatur aspernatur exercitationem quia perferendis officiis soluta. Blanditiis sit tempora nihil eos. Earum rerum soluta quae fugiat ea.Impedit dolore assumenda qui iusto quia. Doloribus quia fugiat impedit mollitia voluptas vitae suscipit consequuntur. Consequuntur illum distinctio ab quos debitis fugiat eos eos. Voluptas natus delectus illo in quis facilis omnis.Animi nihil delectus rem enim. Dolore sint non velit dolorem. Esse tempore dolorum rerum aperiam autem. Consequatur commodi et eos et sunt et consectetur.', 440, 'Shade', 'Moderate', '1.78', 'Cuba', '1', 'cactus2.png', 3, NULL, NULL),
(158, 'Desert Rose10', NULL, 79.34, 'Porro incidunt sapiente quis explicabo rerum aut ut. Soluta similique est laboriosam quia incidunt recusandae. Dicta numquam ut vel. Rem dolorem unde est excepturi. Eos repellat perferendis optio asperiores velit accusamus dolorem.Ipsum exercitationem dolor tenetur eius earum. Impedit qui cumque aliquid perferendis. Fuga saepe quisquam vero in non consectetur quo. Omnis quasi optio ut temporibus. Rerum sint vero dolores quam harum.Eveniet perspiciatis autem quisquam harum omnis quos. Officiis molestiae iusto laboriosam repellat repellendus corrupti harum ullam. Voluptatem est quia ad quae libero dignissimos.', 838, 'Full', 'Moderate', '4.99', 'Liechtenstein', '1', 'DRose2.png', 2, NULL, NULL),
(159, 'Hydrangeas10', NULL, 11.14, 'Natus voluptas adipisci et omnis cum in. Eos et sit et totam eius dicta. At vel sunt aut. Incidunt dolorem nihil debitis odit ipsam blanditiis.Quod tempora voluptatem error pariatur error mollitia assumenda. Qui officiis eos dolor ut cumque aut adipisci nihil. Ducimus occaecati exercitationem labore magni consequuntur dolore sed non.Iure quos quos et dicta incidunt vitae atque. Veniam non nostrum repellat alias veniam et. Perferendis quo ipsa sint ab magnam mollitia. Id deserunt id nesciunt numquam nihil quidem.', 137, 'Shade', 'Moderate', '2.71', 'Belarus', '1', 'Hydran1.png', 4, NULL, NULL),
(160, 'Lotus11', NULL, 49.72, 'Consequuntur asperiores porro voluptates non. Optio dignissimos fugiat nam ad est magni voluptatum.Pariatur ab quia et veritatis est laborum. Vel voluptas aut nemo. Voluptas fuga sit dignissimos sed ut assumenda quaerat. Ut consequuntur sapiente quibusdam.Et amet quas aut libero veniam eveniet. Temporibus asperiores iusto ea blanditiis laborum soluta. Eius quo quam quia iusto. Ipsam laborum tempora ratione. Voluptatem excepturi itaque modi aut et iure aperiam.', 731, 'Shade', 'Low', '8.75', 'Guam', '1', 'Lotus6.png', 1, NULL, NULL),
(161, 'Cactus11', NULL, 55.60, 'Distinctio rerum quae et facilis autem. Rerum eligendi ea nobis tenetur voluptatem unde. Et ut voluptatibus et non velit quis delectus.Natus tempora voluptatem qui vel nisi. A sint consequuntur expedita veniam dolore rerum atque.Dolorum voluptatem nemo non maxime ducimus. Porro voluptate iure accusantium commodi. Commodi alias ut recusandae cumque. Mollitia voluptatem repellendus omnis esse. Occaecati dolores quisquam illum delectus odio.', 769, 'Shade', 'High', '2.13', 'Bosnia and Herzegovina', '1', 'cactus1.png', 3, NULL, NULL),
(162, 'Desert Rose11', NULL, 86.57, 'Sapiente ullam enim enim nihil aut illum sed. Exercitationem amet natus sed inventore. Eaque eaque unde iusto est aut. Totam quia voluptas nostrum cupiditate.Eum officiis officia consequuntur est et aut. Quia quia ut corrupti delectus. Omnis dicta natus consectetur consequuntur. Voluptas aliquid quasi accusantium accusamus.Nostrum dolor tempora et vel vel et mollitia reprehenderit. Atque quibusdam nam qui. Officia nihil est numquam et qui. Voluptatem eos iusto eum necessitatibus voluptas ipsum quo.', 353, 'Partial', 'High', '3.42', 'Palau', '1', 'DRose3.png', 2, NULL, NULL),
(163, 'Hydrangeas11', NULL, 62.86, 'Deleniti eos id reprehenderit quisquam eos debitis ut. Provident labore dolorem voluptatibus itaque sit praesentium laboriosam eum. Nisi quia voluptas recusandae et asperiores eum modi nihil.Quibusdam quo quo quisquam iusto eveniet aliquam quis. Porro aut voluptate quis dicta eos. Animi est quo delectus dicta. Occaecati quas voluptatem quis.Molestiae quam qui asperiores aspernatur. Est veniam accusantium earum ipsam ullam. Minus ut omnis dolore facere numquam incidunt et voluptatem.', 525, 'Full', 'Low', '7.68', 'Japan', '1', 'Hydran3.png', 4, NULL, NULL),
(164, 'Lotus12', NULL, 59.51, 'Unde consequatur temporibus architecto illum. In quia doloribus quis recusandae distinctio voluptatem aut quia. Pariatur iusto est laborum rerum. Voluptas facere eos maxime fugiat quis est saepe.Aspernatur unde nam repellat et sint saepe. Quidem laboriosam accusantium eos officiis. Nihil ut omnis ipsam ipsa dolorem. Non non laboriosam recusandae maiores modi ipsam.Consequuntur velit numquam mollitia. Delectus ea magnam et nam. Reiciendis odio aut necessitatibus. Repellendus sapiente natus at dignissimos.', 297, 'Full', 'High', '8.35', 'Puerto Rico', '1', 'Lotus4.png', 1, NULL, NULL),
(165, 'Cactus12', NULL, 71.54, 'In qui exercitationem officia placeat dolor. Quae placeat et rerum. Ea ratione a recusandae sit. Perferendis ad expedita ut modi earum.Accusantium atque veritatis consequatur ad cumque est distinctio aut. Sunt recusandae consequatur delectus maxime dolorem placeat. Qui quaerat cupiditate dignissimos vitae a qui quae.Corporis aspernatur assumenda est sunt neque tempora. Unde temporibus minus optio sequi molestiae debitis qui autem. Sit optio autem ipsum eveniet veritatis doloremque. Impedit provident quas sunt tempora sunt itaque.', 660, 'Shade', 'High', '4.53', 'Kenya', '1', 'cactus1.png', 3, NULL, NULL),
(166, 'Desert Rose12', NULL, 41.99, 'Numquam illum veniam dolores porro. Laborum eaque velit quibusdam non exercitationem est reiciendis non. Sequi et quaerat quod exercitationem deleniti enim. Ut repellat dolorum et et optio repudiandae.Quaerat possimus repellendus nemo veniam consequatur quaerat fugit ad. Fuga quia esse necessitatibus qui blanditiis quia accusamus.Dignissimos nulla voluptas mollitia est vero culpa voluptatem molestiae. Odit enim quis eligendi illum. Maxime rerum laborum minus est aut exercitationem. Neque tenetur dolor inventore earum tempora quasi in.', 237, 'Partial', 'Moderate', '1.99', 'Afghanistan', '1', 'DRose3.png', 2, NULL, NULL),
(167, 'Hydrangeas12', NULL, 74.52, 'Quibusdam et accusamus voluptatem ut consequatur inventore laboriosam. Optio voluptas unde explicabo ab porro nihil. Sapiente fuga eum sapiente officiis quisquam quasi et. Nemo quasi qui et.Quia molestiae est et. Eaque recusandae voluptas quas voluptatem. Officia vitae molestiae sint omnis sapiente placeat. Reiciendis et voluptatem sunt et ut.Maiores ipsam alias qui inventore. Aperiam eveniet a suscipit qui ab aut. Odio dolorem quae animi molestiae. Est architecto facere impedit distinctio porro voluptatibus.', 898, 'Full', 'High', '2.97', 'Bhutan', '1', 'Hydran1.png', 4, NULL, NULL),
(168, 'Lotus13', NULL, 14.40, 'Labore voluptas quis in quia aut. Autem est consectetur porro eligendi corrupti sint consequatur. Consequuntur optio id architecto non incidunt. Ut distinctio tempora quis.Qui sunt dignissimos natus possimus rerum quidem. Et nobis veniam eum sint. Debitis dolores reprehenderit et et. Velit magnam qui amet reiciendis asperiores.Nam iure dolor ut voluptatum. Eaque ut est soluta ut nemo. Qui nam excepturi aut aut cupiditate. Ex aliquam sed expedita recusandae libero possimus. Corporis fugit hic soluta totam officiis voluptate.', 70, 'Shade', 'High', '4.36', 'Cayman Islands', '1', 'Lotus3.png', 1, NULL, NULL),
(169, 'Cactus13', NULL, 83.13, 'Vitae dolorem quam quae voluptatem occaecati. Nisi ab et alias aut porro. Ratione repudiandae inventore et debitis quia quia libero. Et eum velit nihil qui.Ratione esse aspernatur et et aut sequi. Occaecati ad quas minima eum. Eum saepe ut et.Et non explicabo libero dignissimos. Culpa libero corrupti voluptates consequatur. Ipsa eum error aut et qui vero quas.', 358, 'Full', 'High', '2.96', 'Andorra', '1', 'cactus2.png', 3, NULL, NULL);
INSERT INTO `plant` (`id`, `name`, `sales_amount`, `price`, `description`, `quantity`, `sunlight_need`, `water_need`, `mature_height`, `origin`, `status`, `image`, `cat_id`, `created_at`, `updated_at`) VALUES
(170, 'Desert Rose13', NULL, 28.13, 'Ab aliquam ratione sequi consequuntur ex velit sit aspernatur. Ut consequatur nisi aut pariatur aut. Quia odio nesciunt provident fugiat distinctio sunt.Nesciunt temporibus commodi illum cupiditate laborum. Cupiditate sint aliquid similique sunt deleniti qui. Dignissimos voluptates mollitia expedita incidunt maiores. Veritatis a ex et hic.Perferendis nihil molestias eius suscipit quibusdam. Mollitia et corporis ut non. Quisquam laboriosam explicabo nihil omnis. Qui ut dolorum impedit aperiam aut.', 924, 'Partial', 'Moderate', '9.4', 'Mozambique', '1', 'DRose2.png', 2, NULL, NULL),
(171, 'Hydrangeas13', NULL, 15.33, 'Consectetur quae nobis magnam quo nobis voluptas occaecati. Est eum sed dolores. Sunt minima tenetur odio qui vitae quo. Quo eum voluptatem alias quasi magni quod ea.Ab qui et accusamus vel. Aperiam consequatur laboriosam provident amet dolorem fugiat ea. Autem sed natus sunt quo nemo et. Id nobis et cumque velit.Delectus iure nobis harum dolore aut. Tempore in est sit earum voluptatem autem hic. Et fugit est omnis ea harum alias ut.', 999, 'Shade', 'Low', '1.84', 'Uruguay', '1', 'Hydran3.png', 4, NULL, NULL),
(172, 'Lotus14', NULL, 60.00, 'Voluptatem nihil inventore officia ut. Quia ipsam culpa perspiciatis voluptatem dolorem. Quam ipsum minima cupiditate aut quasi ducimus.Nam maiores distinctio voluptatum perferendis error. Provident enim suscipit hic amet rerum iusto vitae. Libero provident consequatur tenetur praesentium ut. Dignissimos eveniet praesentium praesentium totam consequatur.Dolorem ut sed ratione eos nisi et consequuntur. Soluta id rerum quos quos. Voluptatem ea ut suscipit sit id dolorem et.', 816, 'Partial', 'High', '5.63', 'Western Sahara', '1', 'Lotus5.png', 1, NULL, NULL),
(173, 'Cactus14', NULL, 10.36, 'Voluptatum ut quia quia sapiente esse excepturi. Rerum sint aut itaque omnis. Sunt architecto mollitia est et quia repudiandae. Amet dolorem nihil ea.Sequi aut aut sed. Voluptas ea est veritatis quod quis sit laborum. Vel eos non eum occaecati earum.Quisquam tempora impedit in autem. Fugit sequi nobis ducimus ut qui quia. Reiciendis quae tempora libero.', 20, 'Full', 'Low', '9.46', 'Seychelles', '1', 'cactus1.png', 3, NULL, NULL),
(174, 'Desert Rose14', NULL, 36.65, 'Est ea earum ullam. Doloremque a ullam harum aspernatur voluptatem recusandae. Quia aut facilis illo nemo natus tempora assumenda.Modi vero eaque molestiae cumque nam. Nisi minima minima veniam enim voluptatem laborum mollitia. Aut distinctio odit et asperiores debitis. Nihil rem maiores rerum quidem nihil et harum.Qui laboriosam quis dignissimos cum libero corporis. Natus fugit qui in culpa. Deleniti illo quis reiciendis numquam ea voluptas in.', 790, 'Full', 'High', '9.7', 'Svalbard & Jan Mayen Islands', '1', 'DRose1.png', 2, NULL, NULL),
(175, 'Hydrangeas14', NULL, 61.19, 'Quisquam debitis earum veniam sed reiciendis. Id voluptate molestiae ab quam. Et explicabo et voluptas soluta. Iste sit praesentium sed quod nemo impedit occaecati.Tenetur expedita unde sit assumenda consequatur optio modi. Labore quo asperiores quos quo.Sed ut accusantium quaerat dolor. In quos laboriosam reprehenderit numquam occaecati dolorem neque. Omnis quos error nam enim voluptas ipsam sit optio.', 648, 'Partial', 'High', '4.77', 'Rwanda', '1', 'Hydran1.png', 4, NULL, NULL),
(176, 'Lotus15', NULL, 73.67, 'Aut et corrupti illum optio. Beatae voluptatem quas repellendus deserunt beatae veniam. Reiciendis possimus magnam fugit impedit reiciendis ullam. Sed quo enim quia suscipit dolore et hic adipisci.Porro sunt harum quia est. Iure qui id nesciunt error nulla et soluta. Magni fugiat et aut aut asperiores deleniti magni. Quod ut molestiae alias excepturi eos sunt.Officiis laudantium quas nesciunt sit ut illum ut. Suscipit est unde debitis rerum nobis. Repellendus voluptatem beatae ratione omnis eligendi at.', 383, 'Shade', 'High', '8.39', 'Brunei Darussalam', '1', 'Lotus5.png', 1, NULL, NULL),
(177, 'Cactus15', NULL, 12.78, 'Ut assumenda aspernatur minima. Ratione corrupti omnis rerum cum aut. Quia ipsam qui consequatur praesentium dolor.Eius at nulla molestiae qui. Aperiam consectetur expedita dolore animi magni.Omnis voluptatem modi dignissimos exercitationem aut et et. Beatae temporibus vitae quibusdam cum. Rerum et architecto praesentium quia eligendi eum. Qui cumque consequatur ut aut.', 639, 'Shade', 'Moderate', '4.08', 'Tunisia', '1', 'cactus2.png', 3, NULL, NULL),
(178, 'Desert Rose15', NULL, 28.06, 'Et sint reiciendis praesentium sint fugiat occaecati. Saepe voluptatem itaque eum. Assumenda laboriosam expedita officiis rerum eius. Quae non veritatis labore tempore corporis minima sed.Ratione voluptate explicabo voluptatum. Ipsa est suscipit quo qui cupiditate delectus iste. Nostrum laboriosam explicabo neque adipisci. Accusantium accusantium suscipit officia quaerat ipsa. Et vel dolorum maiores quos ipsum architecto.Sed voluptas quos quisquam. Suscipit quia deleniti vero quos dolore repellendus. Dicta ea vitae rerum quas et perspiciatis.', 620, 'Partial', 'Moderate', '2.53', 'Mayotte', '1', 'DRose4.png', 2, NULL, NULL),
(179, 'Hydrangeas15', NULL, 7.57, 'Fugiat non neque magni ut distinctio asperiores. Occaecati et aut nostrum aut. Dolores optio vel odio est et esse. Blanditiis adipisci accusamus iste vel nesciunt.Non est accusamus architecto cum est. Ea voluptatum eos enim. Cupiditate ut placeat voluptas a modi voluptas debitis.Aliquid illum est consequuntur asperiores asperiores dicta. Magni et perferendis dolorem odio at.', 229, 'Partial', 'High', '9.58', 'Estonia', '1', 'Hydran3.png', 4, NULL, NULL),
(180, 'Lotus16', NULL, 3.17, 'Rerum maiores iure velit aliquid ut dolores asperiores. Quam qui quo veniam enim nemo aliquid est. Deserunt commodi ex aut molestiae error est voluptas. Tempora ab et quas vitae.Rerum fugit facilis iure quis iste cumque explicabo. Saepe aut dolor doloremque nobis molestiae et. Laborum laborum est officiis amet nihil quia.Repellendus eius nostrum quia vel. Magnam et error nihil cupiditate odio non. Delectus autem consequatur sequi sed est.', 884, 'Partial', 'Low', '5.4', 'Sudan', '1', 'Lotus6.png', 1, NULL, NULL),
(181, 'Cactus16', NULL, 54.58, 'Minima enim nisi nisi et quasi nisi. Nulla aliquam consectetur facere molestiae fugiat quam quae nihil.Sint et labore pariatur molestiae eius. Dolorem qui qui excepturi nemo corrupti rerum fugiat molestiae. Odit et hic rerum ipsa expedita quia. Necessitatibus officiis laborum vel tempora maxime qui et.Dolore qui et asperiores qui laboriosam. Magnam magnam consequatur quis quo. Adipisci culpa asperiores porro enim voluptas perferendis.', 675, 'Partial', 'Low', '9.19', 'Hungary', '1', 'cactus2.png', 3, NULL, NULL),
(182, 'Desert Rose16', NULL, 43.03, 'Est ut error rem. Voluptatem inventore aut voluptas iste. Reprehenderit at et debitis.Ab nam soluta optio repellendus ipsam nobis. Numquam id placeat sit deleniti. Magni quasi cum minus officia dolores sit culpa. Excepturi voluptas in et.Illum earum quaerat eaque voluptatum vero optio voluptatum. Temporibus optio modi ullam reiciendis. Et assumenda maxime tempora.', 790, 'Partial', 'Moderate', '9.31', 'Slovakia (Slovak Republic)', '1', 'DRose2.png', 2, NULL, NULL),
(183, 'Hydrangeas16', NULL, 90.78, 'Mollitia optio ut quidem placeat qui consectetur. Quia veniam pariatur odit itaque ipsam esse. Nemo sit necessitatibus perspiciatis sed dolorem.Ullam hic et dolores dolore laborum repellendus doloribus. Eligendi ut optio dolorem. Pariatur aspernatur et commodi sit provident illo.Tenetur aut laborum fugiat assumenda inventore quia praesentium illo. Saepe qui blanditiis cum alias sint corrupti. Commodi id eligendi et est nihil.', 750, 'Partial', 'High', '3.68', 'Kuwait', '1', 'Hydran1.png', 4, NULL, NULL),
(184, 'Lotus17', NULL, 96.38, 'Ducimus enim error fugit rerum. Nesciunt esse modi incidunt voluptate quia. Qui perferendis ut ea quasi vero autem qui nulla. Ipsam vel molestiae ad odit omnis iusto vel quas.Et quidem consequatur suscipit voluptas labore unde. Corporis quisquam delectus eos minus non voluptas.Reiciendis assumenda ab occaecati ea numquam veniam. Dolor est cum eligendi non suscipit dolorem. Sunt ad perspiciatis ad dolor ab.', 523, 'Partial', 'Low', '4.14', 'Bouvet Island (Bouvetoya)', '1', 'Lotus6.png', 1, NULL, NULL),
(185, 'Cactus17', NULL, 58.26, 'A accusantium eum consequatur velit. Ut sit minus vero nihil dignissimos unde magni. Ut quaerat quisquam aut qui aut. Maxime doloremque modi ut neque.Exercitationem nisi fugit blanditiis blanditiis debitis. Ipsum dolore necessitatibus dolores soluta voluptatibus et sed autem. Dolorem quis accusamus et eum. Qui debitis consectetur voluptatem quisquam dolorem.Nostrum sed facilis exercitationem iure voluptatum. Occaecati vel exercitationem voluptatem. Neque neque sint architecto labore magni asperiores veritatis.', 969, 'Partial', 'Low', '8.29', 'Turkey', '1', 'cactus1.png', 3, NULL, NULL),
(186, 'Desert Rose17', NULL, 34.10, 'Sed optio delectus praesentium officiis quo. Corporis eos quaerat temporibus magnam molestiae sequi. Quia rerum provident officiis qui nostrum et ducimus.Iusto rerum dolorum sint dolor totam commodi voluptatem. Enim iusto consequatur et sint. Repellat excepturi ut magnam non omnis fugiat sed sunt.Adipisci ab voluptatem hic atque eum eos. Et assumenda recusandae excepturi deleniti est aliquid et. In laborum voluptate magni enim iste ipsam. Dignissimos beatae minima et.', 804, 'Partial', 'Moderate', '4.31', 'Northern Mariana Islands', '1', 'DRose2.png', 2, NULL, NULL),
(187, 'Hydrangeas17', NULL, 63.17, 'Ut qui cupiditate corporis corrupti. Odio alias voluptas magni. Debitis rem ut et animi nulla.Dolores voluptatem dolore quibusdam qui aperiam amet. Aut culpa nihil sed. Nesciunt voluptates unde doloribus. Et aut iusto mollitia sapiente vel quia quasi provident.Vel et distinctio architecto et omnis velit magni. Laboriosam consequatur sunt error magni deleniti consequatur odit soluta. Ipsam laboriosam quos odit ut id velit eveniet. Perferendis et consequatur dolorum quod corrupti aspernatur.', 105, 'Shade', 'Low', '1.26', 'Costa Rica', '1', 'Hydran3.png', 4, NULL, NULL),
(188, 'Lotus18', NULL, 81.63, 'Accusamus itaque consequatur ea expedita. Blanditiis deleniti quidem fuga ipsam excepturi. Odit alias et dolores aut suscipit nesciunt. Eos rerum minima quia autem fugit similique voluptate beatae.Non magni soluta nihil ut. Fugit repudiandae fugit autem temporibus nam. Delectus beatae sed incidunt corrupti voluptatem. Neque aliquid cum error voluptatem dolore.Ea tempora dolores eaque corporis quia rerum. Nobis et nihil adipisci. Veritatis laborum iusto atque maiores alias est. Velit atque occaecati architecto quam a ex repellat.', 301, 'Partial', 'Moderate', '1.91', 'Iraq', '1', 'Lotus5.png', 1, NULL, NULL),
(189, 'Cactus18', NULL, 54.94, 'Iusto quo blanditiis quasi aut sapiente. Repellendus velit temporibus quisquam dolorum ut reprehenderit dignissimos.Et sit et quo aliquam. Et cupiditate voluptatem repudiandae iusto repudiandae beatae. Qui qui et modi debitis quidem.Veniam porro mollitia alias beatae. Assumenda ipsam porro debitis placeat. Vitae libero fuga necessitatibus ipsa placeat sit.', 602, 'Shade', 'Low', '3.75', 'Nepal', '1', 'cactus2.png', 3, NULL, NULL),
(190, 'Desert Rose18', NULL, 6.50, 'Deserunt delectus quis ut est exercitationem iste fugiat culpa. Tempora quam architecto est aliquid in praesentium aut cumque. Cum et quos laboriosam qui.Nam voluptatem vitae doloremque quis eius et et inventore. Quibusdam odit laboriosam cumque rerum saepe. Voluptatem autem iure sit cum sed fuga ex. Vitae quas at maiores iure voluptatem in quod natus.Quo quos aut sapiente. Quasi ad dignissimos quia magnam rerum dolore eius. Doloremque dolor consequatur qui similique iusto.', 715, 'Partial', 'High', '3.04', 'Seychelles', '1', 'DRose4.png', 2, NULL, NULL),
(191, 'Hydrangeas18', NULL, 97.95, 'Autem expedita fugiat maxime reprehenderit optio hic voluptatem. Sed illum iure vel repudiandae atque. Nihil maxime voluptas voluptatem ratione quia odio.Beatae culpa laboriosam aut esse facilis. Aut voluptas amet dolores nihil sed dolor. Inventore quibusdam voluptas inventore libero pariatur autem aut.Doloremque error deserunt dignissimos libero aut nemo est. Autem eligendi in dolores nesciunt. Et ut nihil necessitatibus dolore.', 379, 'Partial', 'High', '6.28', 'Samoa', '1', 'Hydran3.png', 4, NULL, NULL),
(192, 'Lotus19', NULL, 7.32, 'Harum praesentium veritatis quia. Est rem nam rerum sit molestiae est dolorum.Vero temporibus ipsa laboriosam fuga modi quas enim ratione. Consequuntur odio harum labore accusamus provident. Doloribus et itaque eveniet autem animi veniam eveniet.Nesciunt enim exercitationem excepturi. Accusantium rerum quibusdam facilis odio. Fugiat ut qui natus reprehenderit eaque omnis quo. Hic corporis cupiditate dolor est dolorem. Est doloremque et eum nihil deserunt.', 585, 'Full', 'Moderate', '4.15', 'Gambia', '1', 'Lotus1.png', 1, NULL, NULL),
(193, 'Cactus19', NULL, 42.54, 'Est exercitationem at temporibus. Suscipit beatae facilis non architecto esse. Eius necessitatibus iste fugiat necessitatibus amet iste aut consequatur.Corporis dignissimos corporis assumenda eius id expedita asperiores. Odit maxime nostrum nemo nemo autem eligendi. Mollitia consequatur voluptatibus modi libero adipisci quia est.Rerum excepturi saepe voluptatem quasi molestias. Ut sed voluptatem iusto sed eaque ducimus. Reprehenderit maxime et ut corporis at. Repudiandae magnam enim quaerat quia consequatur.', 241, 'Shade', 'Moderate', '8.27', 'Chile', '1', 'cactus1.png', 3, NULL, NULL),
(194, 'Desert Rose19', NULL, 26.17, 'Iste repellat quam dolores quas repudiandae. Ex ducimus in est in. Et eos quod laboriosam atque quos velit porro. Sint necessitatibus sit iure et suscipit inventore repellendus.Excepturi odit aut architecto et. Minus inventore provident itaque fugit. Deserunt quo nihil nobis ad provident occaecati totam. Rerum illo vel modi illo non perspiciatis sed quidem.Hic rerum aut ducimus atque. Rerum sunt maxime perferendis. Dolores qui voluptatem qui quisquam quasi. Molestiae ut doloribus nisi in culpa et libero.', 478, 'Shade', 'High', '4.09', 'Madagascar', '1', 'DRose2.png', 2, NULL, NULL),
(195, 'Hydrangeas19', NULL, 81.57, 'Eos deleniti fugit nemo veniam mollitia consequatur architecto. Asperiores explicabo et possimus dolores et laboriosam. Provident iusto repellendus id commodi. Ullam ea laboriosam voluptatibus. Nobis est aspernatur eligendi iure quod architecto et.Ut et repellendus deserunt ratione ratione voluptas aspernatur. Ut accusantium nihil nemo soluta aliquam. Et qui tenetur sint nemo vel iure quasi qui. Veritatis labore doloribus quidem ea placeat tempora fuga.Ab ipsum vero placeat doloribus ut voluptatem tempora. Ipsa repudiandae reprehenderit dolorum in. Rerum maiores perspiciatis nesciunt ratione officia.', 744, 'Partial', 'Moderate', '3.35', 'Botswana', '1', 'Hydran2.png', 4, NULL, NULL),
(196, 'Lotus20', NULL, 33.47, 'Eaque odit consectetur architecto assumenda labore consequatur. Quis accusantium eveniet quis harum dolores commodi asperiores. Quia asperiores et eum dolore corrupti nisi. Enim est officia blanditiis eius ut in. Consequuntur natus temporibus recusandae dolores.Rerum amet sunt sunt itaque. Nam ea possimus autem mollitia eveniet. Deleniti pariatur aut in explicabo. Unde sit vel pariatur.Esse eligendi aut enim quia labore. Commodi saepe tempora sit odit quia. Dolores explicabo occaecati quia voluptatem. Eum eaque natus quia commodi.', 109, 'Partial', 'Moderate', '7.52', 'Algeria', '1', 'Lotus6.png', 1, NULL, NULL),
(197, 'Cactus20', NULL, 57.74, 'Unde est accusamus voluptas fuga. Est impedit et voluptatum molestiae quod enim. Nulla aut autem ut non eligendi sit. Et neque iste vel a dolor voluptas error molestiae.Hic saepe velit harum autem quo in. Ratione inventore voluptas sunt qui est est rem. Et id asperiores beatae iusto. Molestias id quae voluptatem eum exercitationem.Et quae accusamus ex tempora nihil quia sit. Neque non quibusdam explicabo eveniet ab rem. Qui sed odio odit vel explicabo voluptatem quo. Et rem esse nam beatae hic aliquid sed.', 531, 'Shade', 'High', '9.55', 'Croatia', '1', 'cactus1.png', 3, NULL, NULL),
(198, 'Desert Rose20', NULL, 38.34, 'Magni deserunt rerum voluptas vel fugit similique. Perspiciatis quia ad excepturi autem esse saepe rerum. Tenetur ullam expedita natus atque est. Est labore voluptatem fugit.Cumque deleniti est voluptatem inventore. Nihil dolorum sequi quidem atque deleniti animi. Aperiam sint ex tempore repellendus saepe architecto. Odit impedit consequuntur corporis.Labore quidem porro qui temporibus rerum voluptatem nobis consequatur. Sed doloremque dicta explicabo et in impedit. Quibusdam aliquid inventore inventore sed voluptatibus eligendi dolorem molestias. Qui optio est nemo voluptatum qui dolor ut. Molestiae et quia unde alias aut ab officiis.', 40, 'Full', 'Moderate', '6.25', 'Faroe Islands', '1', 'DRose4.png', 2, NULL, NULL),
(199, 'Hydrangeas20', NULL, 56.62, 'Nihil et ea nostrum repudiandae voluptatum. Est harum in sapiente. Non adipisci est quia dolorem eos.Natus id alias qui cupiditate asperiores. Velit repudiandae debitis autem in quos rerum. Voluptatem est dignissimos est aut. Distinctio unde dolorem autem nulla in.Earum exercitationem optio sunt quis. Atque aliquam commodi animi molestiae earum quaerat. Voluptas vel est dolor consectetur quia rerum.', 672, 'Partial', 'Low', '9.96', 'Saint Martin', '1', 'Hydran1.png', 4, NULL, NULL),
(200, 'Lotus21', NULL, 31.75, 'Impedit ex et architecto minima voluptates rerum omnis. Molestias labore similique sunt qui. At tenetur aut modi praesentium sit.Commodi esse maiores placeat excepturi mollitia debitis. Architecto id sed tenetur. Consequuntur ut consequuntur consequatur quis pariatur nulla. Non quo incidunt ad iure est saepe earum rerum. Nesciunt magni ea amet sed ut laboriosam molestiae.Dolor cumque ut et saepe reiciendis hic recusandae. Qui sunt distinctio aut saepe. Dolorem aperiam facere quidem dolore.', 950, 'Full', 'High', '7.19', 'Saint Kitts and Nevis', '1', 'Lotus5.png', 1, NULL, NULL),
(201, 'Cactus21', NULL, 55.36, 'Sit velit inventore dolor eius. In voluptas sapiente dolor omnis est voluptatem aut dolorem. Est vel nobis non aut accusamus. Cupiditate qui consequatur error ipsam beatae voluptas. Ratione reiciendis et earum eaque.Ducimus perferendis assumenda aut dolor aspernatur ratione. Sequi doloribus sed illum dolore mollitia. Magni dolor laboriosam dolores est voluptatem doloremque ut.Aut dignissimos molestias praesentium et ut. Quod ut sint sunt odio amet. Cupiditate sit non doloribus iure laborum eaque itaque. Qui earum veniam ea sed dicta quidem.', 116, 'Shade', 'Moderate', '1.17', 'Sierra Leone', '1', 'cactus2.png', 3, NULL, NULL),
(202, 'Desert Rose21', NULL, 37.55, 'Similique voluptas enim sed eius sunt. Sed dolores molestiae quia sit incidunt ipsum. Impedit vitae eius quo consequatur provident cum.Corporis ullam earum ullam quia ipsa. Aut perferendis et omnis omnis. Aspernatur et eos illum minima. Consequatur vel non eos sit.Beatae est exercitationem vero ut eius. A et magnam eius consectetur fugit quis non. Quo aliquid nobis veniam aut. Est itaque perspiciatis dolor quo.', 824, 'Partial', 'High', '6.87', 'Luxembourg', '1', 'DRose1.png', 2, NULL, NULL),
(203, 'Hydrangeas21', NULL, 52.23, 'Non voluptatem eligendi est at voluptates. Porro et quae exercitationem necessitatibus temporibus rerum. Sunt exercitationem vel dolorem excepturi.Vel et suscipit consectetur provident ut provident. Repellendus quibusdam autem minus et voluptatem quia eius. Id et qui id pariatur.Adipisci eveniet voluptatum aut provident eum iure qui. Pariatur mollitia qui consectetur optio dolorum vel est. Aut in vitae inventore possimus. Unde inventore fuga consequatur vitae quae.', 692, 'Full', 'High', '7.16', 'Guernsey', '1', 'Hydran3.png', 4, NULL, NULL),
(204, 'Lotus22', NULL, 26.07, 'Amet at ea aut. Quo perspiciatis perferendis commodi minima fuga ratione corporis. Facere voluptas velit aut odio omnis.Sunt consectetur error qui aut. Odit laudantium delectus accusantium eum porro. Sint ut magnam ipsam et sit.Quaerat et quod ut omnis. Velit accusamus et voluptatibus blanditiis dolorem voluptate dolores.', 184, 'Full', 'High', '2.96', 'Wallis and Futuna', '1', 'Lotus6.png', 1, NULL, NULL),
(205, 'Cactus22', NULL, 33.63, 'Saepe nihil magni cum et. Eum voluptas eos voluptate earum soluta saepe. Cumque aspernatur et consequatur a incidunt itaque aliquam. Ab nemo sequi est ipsa.Aspernatur molestias non rem labore est vel. Nisi ut qui fugiat quae. Autem iste earum voluptatem cum deleniti est ipsum numquam.Corrupti occaecati assumenda ut fugiat quia. Animi dignissimos aut minima ipsam. Rerum dolor ex delectus consectetur. Beatae quia hic est recusandae alias blanditiis.', 364, 'Full', 'Moderate', '6.3', 'Bangladesh', '1', 'cactus1.png', 3, NULL, NULL),
(206, 'Desert Rose22', NULL, 58.00, 'At praesentium molestiae aut id dignissimos omnis molestiae in. Ut incidunt et excepturi praesentium quod quidem. Ullam atque vel consequuntur numquam.Omnis quo autem provident nulla magni earum sunt. Ullam dolores placeat aut corrupti rerum. Nesciunt sint maiores iusto sed corporis optio ullam. Doloribus quibusdam aspernatur praesentium aliquid voluptatem.Quia expedita et voluptas molestiae non reprehenderit. Dicta repellat assumenda unde et dolore. Quod nesciunt expedita quam est. Molestiae delectus quis in ut assumenda vel.', 691, 'Shade', 'Moderate', '7.35', 'Madagascar', '1', 'DRose4.png', 2, NULL, NULL),
(207, 'Hydrangeas22', NULL, 11.83, 'Labore aut accusamus rem dignissimos quisquam aspernatur fugit. Ut qui tempora sit nesciunt temporibus architecto. Odit quis maxime provident qui. Ut enim aut commodi quisquam illum.Quibusdam magnam sit modi magnam natus ea. Deleniti totam rerum sed quisquam ratione aut expedita. Id quidem ut sit in. Quod atque doloribus nostrum dolore error sequi ut.Eos est ea non ea. Voluptates sed nihil vel nemo et omnis. Voluptatibus magnam aperiam est vel et et non. Distinctio incidunt ut sed nulla quae.', 300, 'Partial', 'Low', '9.56', 'Morocco', '1', 'Hydran3.png', 4, NULL, NULL),
(208, 'Lotus23', NULL, 26.26, 'Quia maxime nulla ut a laborum consequuntur vitae. Quia doloremque ab vel architecto quia quia a. Sunt sint sint repellendus adipisci ipsa.Eum ut quas accusamus iure labore et ea. Occaecati vel sed beatae iste molestias. Est fugiat in vel asperiores quis.Aut vitae autem sequi in. Earum ratione necessitatibus necessitatibus ut aut alias. Est adipisci porro et libero.', 299, 'Full', 'Low', '7.7', 'Peru', '1', 'Lotus1.png', 1, NULL, NULL),
(209, 'Cactus23', NULL, 5.73, 'Aliquid maiores nesciunt ad est. Aut qui sit qui. Necessitatibus molestias vel et placeat incidunt ut mollitia. Id et similique ipsam aut.Quia aliquam ut blanditiis occaecati quisquam neque eum. Odio debitis id voluptatum ducimus quae soluta distinctio. Est voluptatibus qui iusto enim dolorum. Corrupti impedit accusamus pariatur autem sequi voluptas.Nam impedit non cum sunt. Et quasi eligendi officia id. Illum officia qui dicta sit dolore. Consequatur harum facere earum necessitatibus fuga eum.', 161, 'Full', 'Low', '1.74', 'United States Virgin Islands', '1', 'cactus2.png', 3, NULL, NULL),
(210, 'Desert Rose23', NULL, 26.00, 'Numquam voluptatem reprehenderit odit libero est. Necessitatibus voluptate ut qui. Architecto quo voluptatem doloremque sint. Eum ratione laudantium sint.Non sed animi debitis voluptas. Provident ab porro deserunt ut maiores error. Vero eum praesentium maiores rem.Ut dicta voluptas ut non illo. Eaque neque porro distinctio similique amet dolorem. Perferendis unde ipsa impedit numquam fugit iure placeat.', 988, 'Shade', 'High', '7.06', 'Bahrain', '1', 'DRose2.png', 2, NULL, NULL),
(211, 'Hydrangeas23', NULL, 52.26, 'Ut id non itaque ea ducimus. Aut voluptatum amet ea et vero. Ut dolores vel et. Sit necessitatibus voluptatibus facilis voluptatem voluptatem est ducimus.Molestias dolores et voluptates qui. Ipsam sed ut est atque fugiat dicta cum. Minima optio ut eius aperiam sit. Qui consequatur in quam optio voluptatem nostrum.Omnis expedita mollitia omnis. Quia architecto et in ullam expedita exercitationem. Autem ea velit eum qui id nobis eos. Exercitationem sequi natus illum nulla possimus.', 183, 'Partial', 'Moderate', '1.85', 'Cuba', '1', 'Hydran2.png', 4, NULL, NULL),
(212, 'Lotus24', NULL, 45.86, 'Corrupti et voluptas unde. Aut at quia a est. At saepe deserunt dolorum laudantium vitae in veniam voluptas.Accusamus ex quia sed voluptate voluptatum quidem. Aperiam eius assumenda ipsam sunt consequatur.Et veniam sed ut porro. Atque amet enim accusantium. Eaque non quidem harum libero quam aperiam accusantium omnis.', 721, 'Partial', 'Low', '6.43', 'Moldova', '1', 'Lotus1.png', 1, NULL, NULL),
(213, 'Cactus24', NULL, 44.35, 'Tempora fugit aut eos commodi magni illo. Delectus debitis modi dolore nihil amet ut porro ea. Minus nostrum rerum corrupti. Praesentium laboriosam sunt nesciunt quia illo est.Sunt et quis id ab iure. Nostrum accusantium ut quis impedit reiciendis. Blanditiis incidunt dignissimos vitae quos sunt.Libero commodi dolore distinctio quo inventore et. Quibusdam officia eveniet nihil fugiat autem quisquam accusantium ipsa. Fuga adipisci veritatis maxime suscipit id et omnis. Est ratione dolore quia sit quae veritatis dolores odio.', 376, 'Shade', 'Moderate', '1.28', 'Slovakia (Slovak Republic)', '1', 'cactus1.png', 3, NULL, NULL),
(214, 'Desert Rose24', NULL, 33.76, 'Nihil sit vitae excepturi est. Maxime in hic tenetur explicabo enim qui magni. Beatae est eum non ut.Deleniti odit voluptatem occaecati et. Eligendi alias labore itaque voluptatem aut fugit aut. Eveniet ad blanditiis et tempore.Repudiandae sed et esse at exercitationem atque doloremque. Occaecati beatae doloribus recusandae nesciunt saepe asperiores. Hic ab illo est ut ratione ipsam sit excepturi. Aliquam cupiditate rerum delectus repudiandae quasi.', 134, 'Partial', 'Moderate', '4.12', 'French Southern Territories', '1', 'DRose4.png', 2, NULL, NULL),
(215, 'Hydrangeas24', NULL, 15.23, 'Soluta eum iusto dolor minus sequi. Nisi animi id dolor. Iure vel inventore voluptatem est unde.Rem sunt dolor vel dolorem dolore dolorum. Recusandae consectetur et fugiat. Voluptas in temporibus cupiditate modi eveniet. Optio consequatur ut ut aperiam ex enim. Quod illum dolore eos est.Omnis itaque ullam aut repellendus. Ut omnis reprehenderit quo et id. Voluptas at labore quidem omnis amet aut.', 655, 'Shade', 'Moderate', '5.57', 'Uruguay', '1', 'Hydran1.png', 4, NULL, NULL),
(216, 'Lotus25', NULL, 43.62, 'Aliquam numquam in sed asperiores. Quis nihil magnam perspiciatis sequi quia est qui laboriosam. Voluptatum labore neque sed eos soluta nihil cum.Molestias perspiciatis natus unde. Nobis assumenda inventore qui cum velit. Quidem aut quia reprehenderit impedit sint quaerat ea.Ut id velit et harum. Aliquam est dolores et tempora velit voluptas harum explicabo. Quia voluptates harum consequatur occaecati. Sed eaque laboriosam repudiandae sunt sit commodi et.', 118, 'Partial', 'High', '6.67', 'Algeria', '1', 'Lotus3.png', 1, NULL, NULL),
(217, 'Cactus25', NULL, 2.98, 'Rerum amet fuga maxime error. Voluptas non quam architecto adipisci quo maxime voluptatem saepe. Molestias doloribus quisquam ut tenetur corrupti aperiam minus. Perferendis consequuntur ratione nihil voluptatibus eos.Quia commodi voluptatibus ut voluptatem quibusdam. Illo voluptatem consequatur iste fugiat. Delectus eum eos reiciendis illum.Adipisci facere sapiente ea repellendus. Et praesentium rem eum qui maxime iste. Quam fugit ipsum id magnam incidunt eos.', 319, 'Partial', 'Moderate', '6.14', 'Tonga', '1', 'cactus2.png', 3, NULL, NULL),
(218, 'Desert Rose25', NULL, 86.98, 'Eius ut ipsam omnis explicabo. Fugiat in est minima autem. Quas quisquam quasi et impedit.Aut inventore dolore nam rerum itaque. Et enim dolorem dolores consequatur et id. Sunt tempore nulla nisi dicta dolor. Itaque dolor vitae sed cum. Sit fugiat possimus eos rerum sit voluptatem.Quod rerum ratione fuga praesentium explicabo. Fugiat rem minima praesentium. Necessitatibus numquam id commodi totam ut et accusantium. Qui qui est nulla et ad impedit minima quo.', 333, 'Shade', 'Low', '6.43', 'Sao Tome and Principe', '1', 'DRose1.png', 2, NULL, NULL),
(219, 'Hydrangeas25', NULL, 61.45, 'Assumenda assumenda inventore vitae consectetur consequatur. Amet non odio id qui deserunt id. Sit eaque est eum voluptas et soluta et. Nihil aut sed quae optio.Aperiam quos recusandae et et. Nulla nisi quas laudantium est ut unde. Nemo aut aut aperiam quas.In id illum porro incidunt quam. Fuga modi exercitationem iure quo velit. Voluptates quo ut totam quidem ea at. Accusantium in et natus aut vitae et necessitatibus.', 318, 'Full', 'Low', '7.37', 'Puerto Rico', '1', 'Hydran2.png', 4, NULL, NULL),
(220, 'Lotus26', NULL, 55.78, 'Similique ut fugit delectus ex nemo rerum. In magni ut mollitia ut sunt. Ut veniam corrupti nesciunt.Dolorem facere et enim minus dolor corrupti. Quo consequatur esse quasi. Tempora sed asperiores quod qui debitis et nihil.Iste fugiat adipisci laudantium voluptate. Quo quasi et ea qui laudantium eum tempora. At deleniti et dignissimos unde ut facilis.', 512, 'Full', 'Low', '7.88', 'Denmark', '1', 'Lotus5.png', 1, NULL, NULL),
(221, 'Cactus26', NULL, 52.37, 'Placeat sint inventore dolor eum. Sunt repellat praesentium eum sint necessitatibus sit. Occaecati voluptas odit nobis similique eos et inventore.Eos et tempora fuga et. Sed laboriosam eum quia fugiat. Sit voluptates reiciendis quo sint nesciunt est quae voluptates. Est expedita laborum itaque debitis omnis.Labore quia est fugiat quo veniam tenetur. Est eveniet laudantium mollitia est amet est.', 466, 'Full', 'High', '8.82', 'Netherlands', '1', 'cactus2.png', 3, NULL, NULL),
(222, 'Desert Rose26', NULL, 17.09, 'Odit et eum quia rem. Velit sed labore explicabo est.Ipsum ut eligendi alias ut omnis. Sunt delectus dolorum explicabo autem adipisci nihil. Provident nostrum quia minus eum aperiam sed.Et autem aut perferendis accusamus deleniti quidem molestiae. Sunt aut aperiam praesentium voluptas ipsa sit. Itaque labore vel quas ullam. Similique minus veniam corrupti voluptatum rerum rerum. Amet ad voluptatem quos similique et adipisci et.', 775, 'Shade', 'Low', '5.72', 'Equatorial Guinea', '1', 'DRose1.png', 2, NULL, NULL),
(223, 'Hydrangeas26', NULL, 18.01, 'Eum sequi ducimus dolores. Iste eos officiis et aliquid et atque voluptatum sit. Mollitia laborum praesentium enim. Ut laboriosam amet ut corrupti reprehenderit.Soluta quis sequi et debitis temporibus eum quibusdam occaecati. Dolorem velit omnis tenetur repellendus quos illo qui. Voluptas quo totam earum modi sint expedita.Ab est nihil at explicabo. Officiis quis et quas eligendi et eius excepturi ut. Omnis ipsa mollitia ea ab eligendi velit. Modi hic quaerat atque magni ipsa fugit.', 115, 'Partial', 'Moderate', '3.7', 'Palestinian Territories', '1', 'Hydran3.png', 4, NULL, NULL),
(224, 'Lotus27', NULL, 37.32, 'Doloremque nihil doloremque ut. Ea eligendi ipsam libero et. Exercitationem quaerat qui molestiae quos ut sed. Excepturi quia quo quia omnis.Ut atque consequatur qui aut assumenda. Corporis a corporis sed ipsam vero distinctio exercitationem voluptatem. Et totam qui labore ut explicabo tenetur qui. Quis veniam dicta atque quia.Quis earum odit et natus voluptatem. Magni ab illo qui asperiores fugiat dolorum. Asperiores provident est autem exercitationem.', 713, 'Full', 'Low', '4.77', 'Somalia', '1', 'Lotus6.png', 1, NULL, NULL),
(225, 'Cactus27', NULL, 78.67, 'Commodi officia suscipit esse recusandae. Nemo eos error recusandae aut. Corporis aut consequatur magnam officiis quisquam.Sapiente atque numquam illum sint. Repellat tempore ea voluptates dolor est. Iure voluptatem consequuntur voluptatem animi facere.Et voluptas similique voluptas laborum ad optio. Libero sequi ratione ratione excepturi et. Voluptatem asperiores et ut nihil fugiat. Expedita nam assumenda nobis eius aut inventore.', 931, 'Full', 'Moderate', '6.56', 'Kuwait', '1', 'cactus2.png', 3, NULL, NULL),
(226, 'Desert Rose27', NULL, 66.34, 'Ut quasi ut accusamus enim in natus. Tenetur velit aut cupiditate adipisci. Vel deserunt nihil tenetur corporis. Similique perspiciatis velit et explicabo maxime dolorem ea.Iste quibusdam quam iure culpa enim dolorum. Ipsa ab odit ab odio sed cumque rem. At natus natus est. Voluptatem quaerat vitae reiciendis sed pariatur.Quidem itaque est consequatur fuga harum quibusdam praesentium. Accusantium accusantium ut facilis placeat fuga reiciendis. Natus necessitatibus et sapiente quas est.', 917, 'Partial', 'High', '6.3', 'Tanzania', '1', 'DRose1.png', 2, NULL, NULL),
(227, 'Hydrangeas27', NULL, 83.68, 'Illo nihil vel sunt molestias reprehenderit. Molestias voluptate est sed ducimus omnis. Quo ipsum ut eum aut.Iure voluptatem aut aliquam voluptatum totam ea ut. Quia est voluptatem consequatur. Ut vel doloremque quidem deserunt laborum. Eum consequatur dolorem cumque.Libero commodi consectetur enim omnis aliquam ea illo dolor. Nam ullam assumenda assumenda ducimus rerum dolores enim ut. Facilis et odit sed sunt voluptas officiis quas. Ut inventore quo animi ea magnam.', 564, 'Shade', 'Moderate', '1.32', 'Spain', '1', 'Hydran2.png', 4, NULL, NULL),
(228, 'Lotus28', NULL, 6.61, 'Aliquid recusandae magni esse dolores beatae. Cum nostrum rerum ea nobis et eaque id nemo. Ipsum officia nobis alias repudiandae aspernatur accusamus dolor. Dolorem deleniti qui quis dolorum nemo dolores.Quia qui quibusdam nihil. Tempore in provident laboriosam eius est odio. Velit error quidem deserunt velit. Esse et veritatis aut.Sit iusto ducimus qui quaerat corporis dicta nulla. Ipsum velit maiores aut ut. Exercitationem totam quia accusantium cupiditate et voluptas.', 485, 'Full', 'Low', '6.17', 'Greenland', '1', 'Lotus3.png', 1, NULL, NULL),
(229, 'Cactus28', NULL, 16.48, 'Aut deserunt quasi doloribus voluptatum illo. Atque sit dolore molestias a est libero aspernatur. Facilis maiores magni laboriosam quia est.Officiis eligendi dolor velit mollitia. In ad modi quaerat sint aspernatur inventore exercitationem pariatur. Similique nulla accusantium tenetur incidunt non et. Ea et eum tempora.Eius aperiam eligendi nulla et et. Neque odio voluptate ut. Atque est similique aut aut mollitia illum consectetur.', 696, 'Partial', 'High', '2.74', 'Finland', '1', 'cactus2.png', 3, NULL, NULL),
(230, 'Desert Rose28', NULL, 15.77, 'Molestias sed ea consectetur cupiditate qui quia aut. Nihil non id reprehenderit non omnis minima totam. Quis nulla culpa officia est et quia voluptatem.Commodi ut a assumenda sit rem reprehenderit. Illo et commodi omnis fuga unde est. Id quaerat debitis possimus facere. Sequi quisquam quas ratione et dolorem.Pariatur voluptas sit adipisci. Adipisci sint illum rerum hic maxime itaque.', 649, 'Full', 'High', '5.32', 'Myanmar', '1', 'DRose1.png', 2, NULL, NULL),
(231, 'Hydrangeas28', NULL, 6.41, 'Sit porro adipisci saepe ut. A harum sit sed deserunt. Laboriosam at libero perspiciatis quia et quia dolores.Molestias incidunt illo rem doloribus dicta aut. Iste sit itaque quia impedit. Dolores dolor ratione dolor alias illum quia minima possimus. Illo tenetur fuga alias vitae architecto doloribus.At nihil ut aut esse omnis quas. Provident consequatur commodi tenetur aperiam. Eum consequatur nemo ad esse laboriosam dignissimos. Ex voluptatem autem facere omnis culpa.', 268, 'Full', 'Low', '6.91', 'Solomon Islands', '1', 'Hydran3.png', 4, NULL, NULL),
(232, 'Lotus29', NULL, 92.15, 'Nobis ut voluptas voluptatibus. Pariatur accusamus earum cumque eum. Odit sunt deleniti occaecati ex modi exercitationem et.Nisi sequi repellat impedit magnam. Magni laboriosam quia ut non quia. Commodi facere est asperiores qui adipisci. Fugiat expedita est atque. Ducimus est et earum qui error eos.Adipisci et dolorum corporis nesciunt accusantium quas aut. Velit dolorem doloremque non dolores. Sequi nostrum perspiciatis similique optio voluptate. Autem praesentium mollitia sed occaecati debitis iste.', 113, 'Partial', 'Moderate', '9.42', 'Tajikistan', '1', 'Lotus3.png', 1, NULL, NULL),
(233, 'Cactus29', NULL, 54.24, 'Nihil aut cupiditate dolorem est consectetur itaque deleniti. Minima aut quo repellendus nesciunt rerum. Quod exercitationem beatae quasi ullam alias repellendus nesciunt.Consectetur dolorem at temporibus consequatur est quod in provident. Autem id culpa nisi magni esse voluptatem. Asperiores blanditiis et ipsam et et.Blanditiis laudantium libero aliquid ab. Minima non impedit sint molestias voluptatem quis. Nostrum commodi occaecati dolorem suscipit soluta.', 915, 'Full', 'Low', '4.48', 'Vietnam', '1', 'cactus1.png', 3, NULL, NULL),
(234, 'Desert Rose29', NULL, 40.78, 'Officia nobis aperiam labore. Ipsam ea voluptatem dolor sapiente fugiat nobis. Dolore voluptate aut velit labore.Corporis in laborum inventore id ut nam esse et. Rerum aperiam aut harum ipsam. Accusamus ex ducimus molestias animi at.Aliquam adipisci cumque quia aut quam minima. Et temporibus officiis rerum assumenda sed aut velit. Deleniti et temporibus impedit tempore et. Rerum veniam in qui sapiente. Sit quod esse veniam iste neque dolor aut asperiores.', 315, 'Full', 'High', '1.33', 'Kiribati', '1', 'DRose4.png', 2, NULL, NULL),
(235, 'Hydrangeas29', NULL, 76.20, 'Dicta aspernatur et pariatur sunt a occaecati itaque hic. Ipsa eveniet cum sunt aut. Eveniet accusantium eligendi cupiditate non aut qui. Dolorum hic aut deleniti qui.Molestias tempore eaque omnis. Voluptatum error veniam occaecati occaecati a quibusdam maxime similique. Enim quod qui doloremque error aut id ipsam facere. Consequatur delectus qui placeat voluptatibus earum.Adipisci nihil fugit iure quis possimus optio. Eligendi distinctio repellendus magnam quia et. Nihil ex quidem quasi ut voluptas deserunt ut.', 745, 'Partial', 'High', '4.89', 'Uganda', '1', 'Hydran3.png', 4, NULL, NULL),
(236, 'Desert Rose Pink Red', NULL, 20.00, 'Blanditiis repudiandae sed enim perspiciatis. Accusamus libero at aut omnis est illum est. Quia vel nemo perspiciatis aut distinctio dolores.Occaecati adipisci adipisci fugiat autem dignissimos nemo ut sit. Iste velit et impedit a quis cumque. Et architecto est corrupti odit beatae.Eligendi consequatur labore perferendis optio quis. Aperiam natus voluptatem excepturi ut cum qui. Molestias est nulla odit libero earum quibusdam.', 10000, 'Partial', 'Moderate', '1.2', 'Malaysia', 'custom', 'DesertRosePinkRed.jpg', 2, NULL, NULL),
(237, 'Desert Rose Red', NULL, 20.00, 'Et quos architecto ut. Quidem commodi reprehenderit explicabo incidunt et. Sit qui veniam ipsa ea aut non.Sunt assumenda libero sed sit. A eveniet error occaecati est cumque ex. Animi ut quidem debitis eum est dolorum.Quas unde ad est. Facilis non quo quaerat reprehenderit. Iure ea dolor nisi officia. Vel ullam quo corrupti sunt culpa eveniet quod voluptatem. Veniam sit ut commodi.', 10000, 'Partial', 'Moderate', '1.2', 'Malaysia', 'custom', 'DesertRoseRed.jpg', 2, NULL, NULL),
(238, 'Desert Rose Pink White', 1, 50.00, 'Quos similique dolor sed sequi voluptate nam. Sit porro magni cupiditate laboriosam temporibus voluptate ut et. Magnam aperiam voluptas pariatur deserunt dignissimos officia dolorum. Ipsum omnis quis a quod quia.Quibusdam repellat corporis ducimus sit quia et. Dolor rerum at doloribus.Totam rerum unde molestiae dolorem dolorum harum occaecati. Alias neque maxime alias dolor dignissimos soluta et. Dignissimos consequuntur optio a tempora magnam.', 9999, 'Partial', 'Moderate', '1.2', 'Malaysia', 'custom', 'DesertRosePinkWhite.jpg', 2, NULL, '2024-11-28 07:40:49');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `sales_amount` int(11) DEFAULT NULL,
  `price` double(8,2) NOT NULL,
  `description` longtext NOT NULL,
  `quantity` int(11) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '1',
  `image` varchar(255) NOT NULL,
  `cat_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `sales_amount`, `price`, `description`, `quantity`, `status`, `image`, `cat_id`, `created_at`, `updated_at`) VALUES
(2, 'Electrical Wiring Service', 5, 50.00, 'Eos cumque et numquam distinctio voluptates. Earum aut totam et ut iste. Explicabo suscipit ratione nisi adipisci quod qui doloremque.Qui accusantium quo assumenda. Aliquam fuga hic nisi debitis. Saepe mollitia maiores accusamus doloribus est necessitatibus qui.Enim et ea id voluptatibus et eaque. Mollitia id eius mollitia repellendus. Non aperiam possimus illum qui saepe ipsa maxime. Dolorum doloribus dolorem incidunt rem quidem odit ad. Sit voluptate explicabo corrupti eaque odio.', 10000000, '1', '1735189234.jpg', 15, NULL, '2025-01-02 01:25:54'),
(3, 'Plumber Service', NULL, 50.00, 'Numquam illo nobis soluta repudiandae. Omnis necessitatibus ducimus magnam quia alias omnis molestiae. Molestiae fuga at esse possimus cum.Autem minima maxime atque sint ab iure. Ipsum perspiciatis doloribus id occaecati dolorum a fugit. Delectus error similique qui in non.Dicta velit quisquam et velit veritatis enim. Dolore sint minus aut eum culpa placeat. Fugit exercitationem eum sint fugit. Qui vel quia vero esse fuga veniam.', 729, '1', '1735189281.jpg', 16, NULL, '2025-01-02 01:25:05'),
(4, 'Gardening Service', NULL, 50.00, 'Perferendis sit ab qui aspernatur. Et quo ipsa tempore quia est voluptates neque. Voluptate a modi delectus laborum aperiam qui quo.Soluta nihil est amet odit. Excepturi iusto veniam dolor id provident. Velit magnam cupiditate molestiae sed cupiditate. Facere consequuntur qui iusto sit maiores.Ad provident ut voluptatem. In consequuntur eligendi quam error voluptatibus quo. Id quis neque omnis velit labore delectus aliquid et. Vel ut sit deserunt.', 766, '1', '1735189334.jpg', 17, NULL, '2025-01-02 01:25:31'),
(5, 'Runner Service', NULL, 50.00, 'Dignissimos quisquam numquam ipsa ea repellendus neque nihil. Omnis omnis expedita itaque eius blanditiis dolore. Dolorem aut est qui.Perspiciatis laborum eos distinctio quae tempore ab sed. Alias voluptate vel quia voluptatem esse laborum accusamus. Facilis ut quia ipsum consequatur et esse. Quo illo qui praesentium ut. Totam doloremque voluptatum quis sed commodi omnis ipsa.Cumque nostrum mollitia sapiente vitae. Autem dolorem deserunt qui qui. Delectus nulla aliquid odit quam sint quas eligendi.', 906, '1', '1735189523.jpg', 18, NULL, '2025-01-02 01:25:42');

-- --------------------------------------------------------

--
-- Table structure for table `runner_details`
--

CREATE TABLE `runner_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `area` varchar(255) NOT NULL,
  `app_date` date NOT NULL,
  `preferred_time` varchar(255) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `budget` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `runner_details`
--

INSERT INTO `runner_details` (`id`, `type`, `area`, `app_date`, `preferred_time`, `details`, `photo`, `budget`, `created_at`, `updated_at`) VALUES
(1, 'Delivery', 'Kota Johor', '2024-12-10', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM100000 - RM199999', '2024-12-09 03:02:41', '2024-12-09 03:02:41'),
(2, 'Delivery', 'Kota Muar', '2024-12-28', 'Lunch Time (11 AM - 1 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-27 16:14:48', '2024-12-27 16:14:48'),
(3, 'Delivery', 'Kota Iskandar', '2024-12-29', 'Anytime', NULL, '[]', 'RM10000 - RM19999', '2024-12-28 17:58:42', '2024-12-28 17:58:42'),
(4, 'Other (Explain in Additional Details)', 'Kota Tinggi', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM50000 - RM99999', '2024-12-28 18:06:08', '2024-12-28 18:06:08'),
(5, 'Other (Explain in Additional Details)', 'Kota Pontian', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 02:46:10', '2024-12-31 02:46:10'),
(6, 'Delivery', 'Kota Muar', '2025-01-07', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070299.jpg', 'RM20000 - RM49999', '2025-01-07 13:14:06', '2025-01-07 13:14:06'),
(7, 'Delivery', 'Kota Muar', '2025-01-07', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070299.jpg', 'RM20000 - RM49999', '2025-01-07 13:20:21', '2025-01-07 13:20:21');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0o237quUH1SNtEjZtPfzk1uXqTDr8sqeJ9QkC6Hj', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicmxpTmJ1SHRvalZSQU1PUWZPV0dzQ09tSnk3blFEaXNXR2l4MGhTeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1736258386),
('E3vP8hTMW17bgICVPoAjqKGr9he1YhqWGAJI1Lua', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidDd4SnNCaTBoSVJmVnVHMlJOQk5DcTRISHp5azl3cjJZZGc5dVd0cCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1736256569),
('eJBadqb2y4VsuJ2vFZgMKxOxv7hwdhrQgwpap5tj', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiemJ2MUN1S3FYUTBxQms5ZkRiaGpscWI0S0ZjWnNEMDBQT1VKNHVFZCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2OToiaHR0cDovL2YzZTEtMjAwMS1lNjgtNTQzMy1jYTQ1LWJjZTEtZjljZC00Y2I4LWViOS5uZ3Jvay1mcmVlLmFwcC9ob21lIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njk6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1736258271),
('EK0KSexCrlCip13JrfbqusNlIiN3STVkmdiO773M', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidDZsNkdhWFp3OGpLbFJOdFZRTzJraXNzeDAySkNGcTBvbTV5a0t3QyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2OToiaHR0cDovL2YzZTEtMjAwMS1lNjgtNTQzMy1jYTQ1LWJjZTEtZjljZC00Y2I4LWViOS5uZ3Jvay1mcmVlLmFwcC9ob21lIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njk6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1736256569),
('EOptZL67rriwKkpG2LLOFtYdTaC0xquBMPN48RJx', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMTZlWGNHT2ozN2Rvd21MMTQ4Y2ZPSnp2bGFJTlFLbVVzZDBHdVVtYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1736256460),
('goXDBPIOcsl919qW71jMR58aiDTaAo9wC3jHKHLP', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiWWZwTXhQWUVSb2pNMWNyVUlja2lBdFZyMUtLOFZSd0FObnJjUFlyMSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTE0OiJodHRwOi8vZWVmZC0yMDAxLWU2OC01NDMzLWNhNDUtYmNlMS1mOWNkLTRjYjgtZWI5Lm5ncm9rLWZyZWUuYXBwL2Fzc2V0cy92ZW5kb3IvbGlicy9hcGV4LWNoYXJ0cy9hcGV4Y2hhcnRzLmpzL2hvbWUiO31zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1736263684),
('gUUfPVSHWJ07ULi0S29rS69yP5f7mJ20D0LUTIaa', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoickhJbkM0Rm1oOUhQNW5oY21IMUhtZEl2d2hod3RDcXdYeGlqRDMzTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1736256569),
('Hr1pJQxCQeCYbeEiZcU67BxA4LDcoa3i6MFovvDg', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidjlhd3NYMGhtQjFHQVBVaU9oZkUzTEYwZTRmYU5aalZZVFNMbWhlRiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2OToiaHR0cDovL2YzZTEtMjAwMS1lNjgtNTQzMy1jYTQ1LWJjZTEtZjljZC00Y2I4LWViOS5uZ3Jvay1mcmVlLmFwcC9ob21lIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njk6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1736256569),
('hx7Ffoa3aOBYHfeHHxs3gbXzpHsz69FriXHBHfVd', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiR3JNNXpnMVd0bkdubFh5Tk9kczlhTGthU3lTcWd6U3YyVmhGeVJhZSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTE1OiJodHRwOi8vZjNlMS0yMDAxLWU2OC01NDMzLWNhNDUtYmNlMS1mOWNkLTRjYjgtZWI5Lm5ncm9rLWZyZWUuYXBwL2Fzc2V0cy92ZW5kb3IvbGlicy9hcGV4LWNoYXJ0cy9hcGV4Y2hhcnRzLmpzL2xvZ2luIjt9czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxMTQ6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvYXNzZXRzL3ZlbmRvci9saWJzL2FwZXgtY2hhcnRzL2FwZXhjaGFydHMuanMvaG9tZSI7fX0=', 1736260203),
('JksaY5sboHVpEFRSMRqhMCib3y34iuIaX8liwlfN', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicnlGSmtGMUdsWWd3NG13NDBqUHBUa0UyaXpwalVwMnFpS05KU2tQQSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2OToiaHR0cDovL2YzZTEtMjAwMS1lNjgtNTQzMy1jYTQ1LWJjZTEtZjljZC00Y2I4LWViOS5uZ3Jvay1mcmVlLmFwcC9ob21lIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njk6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1736258385),
('KMVmlbLTeb2QCo3ArvZMQxCxrkVmlQoTOvs7mj6o', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUE5udXdrMFJEb3F2TVZrSGhhWkR2dEpPMWtScHhiVURlNnV1U1JoMyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2OToiaHR0cDovL2YzZTEtMjAwMS1lNjgtNTQzMy1jYTQ1LWJjZTEtZjljZC00Y2I4LWViOS5uZ3Jvay1mcmVlLmFwcC9ob21lIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njk6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1736256460),
('KshiizNRCxg75eNMOzvG0UB0vwR9wNa1vM580DFG', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYTBZeUVLdTk2emJydnRyVTl1bjRWdmJ3M1I2cklmYk9mVVlrblFJOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1736256460),
('ovHlzuwg7OhwgvwIXhjyDO0lKNAHzFsKgdhGQFpX', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUWRickt5azJsMDFNM3VKc2Y4UVliZzRlOFhHalZVYnI0aW1tNmJZbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NzA6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1736258271),
('qKfLK7AHTfsLuLwflnYDAhFba5ZGmBmCxjo3hEsI', NULL, '127.0.0.1', 'Dart/3.6 (dart:io)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoid0RQbUpEZGlhUzkyMzhTeWJBSWE1TVdnZU13bGJzTUxHenVLek03RSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2OToiaHR0cDovL2YzZTEtMjAwMS1lNjgtNTQzMy1jYTQ1LWJjZTEtZjljZC00Y2I4LWViOS5uZ3Jvay1mcmVlLmFwcC9ob21lIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njk6Imh0dHA6Ly9mM2UxLTIwMDEtZTY4LTU0MzMtY2E0NS1iY2UxLWY5Y2QtNGNiOC1lYjkubmdyb2stZnJlZS5hcHAvaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1736256459);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `vip` varchar(255) NOT NULL DEFAULT '0',
  `contact_number` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'user',
  `status` varchar(255) NOT NULL DEFAULT '1',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `address`, `birth_date`, `gender`, `vip`, `contact_number`, `image`, `type`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'sadmin', 'sadmin@gmail.com', NULL, '$2y$10$kG9GWZ/oK.ysSftRw1jhCOWLJxtVXBP4i5thjBkz.ul5zpnMRbHxa', NULL, NULL, NULL, '0', NULL, NULL, 'sadmin', '1', NULL, NULL, NULL),
(3, 'admin', 'admin@gmail.com', NULL, '$2y$10$Bju6SCDrj8odD0skw.6aJ.MWSrjPNNZgT/sUJIpVMtUxw3m0gSgEG', NULL, NULL, NULL, '0', NULL, NULL, 'admin', '1', NULL, NULL, NULL),
(4, 'user', 'user@gmail.com', NULL, '$2y$10$sENXxpl99//ebqThGgxGEOHfNVNXk0VkzYEtVMsNYY/MfcaaNKtrW', NULL, NULL, 'Male', '0', NULL, '1732985265.jpg', 'user', '1', NULL, NULL, '2024-11-30 16:47:47'),
(5, 'user1', 'user1@gmail.com', NULL, '$2y$10$deZ8nRPaMFghL0zlbtwn4.XGkLOGfsJqAVr/VmUYJrgFMLXSUpEA.', NULL, NULL, NULL, '0', NULL, NULL, 'user', '1', NULL, NULL, NULL),
(6, 'vendor1', 'vendor@gmail.com', NULL, '$2y$10$E4TU2vANYKQwSfbfAxLkiex/ObzKRz5wlAFpe1Q.Elw7Na0ATl/V6', NULL, NULL, NULL, '0', NULL, NULL, 'user', '1', NULL, NULL, NULL),
(7, 'vendor2', 'vendor2@gmail.com', '2024-11-18 12:24:27', '$2y$10$yZVHrb7aqsnRjETrdGKMXea0576ftDdu3JPdGa17vrjlU5ovmFMBy', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(8, 'Theresia Daugherty III', 'wiegand.sheldon@example.com', '2024-11-18 12:24:27', '$2y$10$PE8eJB1pTCzs/2viPfrt3.tjHzY40aq/zRQbfE9Gwb77ADf0S3jZW', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(9, 'Nikki Hartmann', 'dulce09@example.org', '2024-11-18 12:24:27', '$2y$10$ltFjNYmcAhs9n75SpkwZduXSCRtYg7Gbl1AyxCWKVeP9NcurCx.vO', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(10, 'Trenton Douglas III', 'abbie.quigley@example.net', '2024-11-18 12:24:27', '$2y$10$NP3ngn7RMOPGvquD6k1ED.rcX6MnbcSKz0yLEMWeewz5/UEIaoQZS', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(11, 'Dr. Ari Buckridge', 'aliya.kuphal@example.net', '2024-11-18 12:24:27', '$2y$10$wM31weU8q.YJcEuuIJ2uPuhjM43MKVZZSFdZbtOdqMKbvY17cmFJS', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(12, 'Mr. Jerome Lemke Sr.', 'hkoch@example.net', '2024-11-18 12:24:27', '$2y$10$2cIlu4nVw7N.j/sMybxmO.xAF37mdAJNP1n9NYFyrq/e3D43AH2z6', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(13, 'Sonya Bode', 'zachariah.hand@example.org', '2024-11-18 12:24:27', '$2y$10$QgZmAXmosAFHCCzFgeWEb.GX5YPWO8H7vuVuGo61UbYj/V3bfpqsC', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(14, 'Antone Tremblay', 'ewell04@example.com', '2024-11-18 12:24:27', '$2y$10$Ub6Esv3KpK4sIqt4LFAvleIt7G8aJr6pciQYLhPP8kDUa/w38rtmy', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(15, 'Casimir Prosacco', 'laurianne82@example.org', '2024-11-18 12:24:27', '$2y$10$2uQ/L82/6GbeEO5DvYgZAO/C.nvLd.weyuAt7dKb2P1tqjP3E4H96', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(16, 'Dr. Alycia Kunze', 'retha.kovacek@example.net', '2024-11-18 12:24:27', '$2y$10$WRjb/2KHGwRSda4iX26e.uGYvTCeqLoJlQaWL9Fi3Bv/5fB/r/2DO', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(17, 'Mr. Corbin Rice DDS', 'bernier.wilburn@example.com', '2024-11-18 12:24:27', '$2y$10$jiNtRwZWwGEE1kNsuJag6.iGHHOY7XOGvBxDZqhD4vdZbsyC1CUI.', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(18, 'Aric Grant', 'dkovacek@example.net', '2024-11-18 12:24:28', '$2y$10$eHZNOCMBMEJcvHmidjc27.GAH6A2ul7W7qhUYyNpARjCg5siz3m7u', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(19, 'Prof. Hayley Pagac', 'ahmed19@example.com', '2024-11-18 12:24:28', '$2y$10$Paea2QtS8cUjgC.OXfC3dOJwPCAHSD/fG8DEZJp.k8OtugtwE.Tpa', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(20, 'Alek Ondricka II', 'kaylin.bogisich@example.org', '2024-11-18 12:24:28', '$2y$10$DHJL5piJNbbIc9yK05u98.H5jKi2I5Dg2l6EXVggRJm1GwjmxyEzS', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(21, 'Dortha Rempel', 'zemlak.reinhold@example.net', '2024-11-18 12:24:28', '$2y$10$BQFMAjcNuX6kqKlyeOw8aectKmKkRVI6MUpkInc/RUOiPZaPv1JxO', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(22, 'Aiyana Hagenes', 'gwunsch@example.com', '2024-11-18 12:24:28', '$2y$10$mn8f97M9nqcKXzi2lN0rMOBthZmWnVA9twL3pUZjaIrPlQAeUnAfa', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(23, 'Dr. Kelvin Tillman IV', 'arnoldo.hagenes@example.com', '2024-11-18 12:24:28', '$2y$10$PJimkSIyJb0GfH06DH7.rOxDXfN2vOSh0oUB1P6rQs4XkoJgAbOgm', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(24, 'Mr. Douglas Leffler III', 'jaime93@example.org', '2024-11-18 12:24:28', '$2y$10$ghY7DfGDsxabVvUclfRiNOS18avAtH.9h/lQgb9MOl6vc.bxk4pqK', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(25, 'Sherwood Watsica Sr.', 'rkunze@example.org', '2024-11-18 12:24:28', '$2y$10$553BlakDb.Q3driKnbc.4.zTH3MQghtJ0IROpL1C5/aXnuEpVl7hq', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(26, 'Callie Little', 'waldo68@example.com', '2024-11-18 12:24:28', '$2y$10$oiUOPuTgX0XJ.Jr860uEF.UwINvW33wzyoN36CALoBFOnySf5g9ZW', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(27, 'Rebeka Zulauf', 'rossie.howell@example.com', '2024-11-18 12:24:28', '$2y$10$7Qb8oX0Jf.IeH7HwDdYBYeBt3IB1NNliJEs3UZvTpGs3hDVqibbLe', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(28, 'Ena Boyer', 'swaniawski.arlie@example.org', '2024-11-18 12:24:28', '$2y$10$j7XFMemhGF0q7d8yPiY9QeEWKgmJCQY3rgFrc2.20cS6nbkbjz2Ri', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(29, 'Lindsey Koss', 'bgraham@example.org', '2024-11-18 12:24:28', '$2y$10$zJo5ok.9V16CjgesAmtb7u83p7vLy31PnzyRCP8nsIepXvH8KKT7e', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(30, 'Ana Schultz', 'dubuque.aubree@example.com', '2024-11-18 12:24:28', '$2y$10$RDKTfZzOwkJJRYw7.6GLXubFxNeYZGZu5Cbzch2Ow0NezPyGNTUzm', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(31, 'Prof. Heber Ruecker V', 'candida39@example.com', '2024-11-18 12:24:28', '$2y$10$DTQGchf3PR19GiQcPAwdKuba1EHbcIwKpzfBVEtVz4tmjcLtXK6OG', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(32, 'Ms. Destinee Wintheiser I', 'trudie67@example.net', '2024-11-18 12:24:29', '$2y$10$2l143wqZ2hvWYd8QUEP6rOKHv9IDVt45cyd/2uTgXYPKQ1xpqS2Mi', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(33, 'Lavina Walsh', 'ewiza@example.org', '2024-11-18 12:24:29', '$2y$10$bHvDCaAt4ZQqEcXi.bzG1em0IgnGJVZRmDYZU4aoqJxgRp9Z4yt4C', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(34, 'Dr. Jenifer Boyer MD', 'milton54@example.com', '2024-11-18 12:24:29', '$2y$10$K88y4oRlpqLoyzwc.vUQ/OefobntUEugWBx0C12VdnUR3UbcDaw5e', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(35, 'Nedra Parker', 'ehills@example.org', '2024-11-18 12:24:29', '$2y$10$cWyC8QfxozXnauxZhZTZSOKR0RDxSx0zm9RkTChE5yDCOs7pe6WOy', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(36, 'Miss Kimberly Graham', 'alison29@example.net', '2024-11-18 12:24:29', '$2y$10$41g2bqej1GS1cp47gqnEVOquoLJ8cQKtrG5ooilZejp5z.EYBbS..', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(37, 'Ms. April Lehner V', 'jakubowski.ressie@example.com', '2024-11-18 12:24:29', '$2y$10$HQ8UAFf0XrWGqvMaDxkSH.aI7iGQevuEGgbplYwfftil5GwAqWOiO', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(38, 'Diamond Osinski', 'hadley.mante@example.com', '2024-11-18 12:24:29', '$2y$10$mVtbfZL9quCmyJd5429VVeGGAkzjmWUOPH139vraCEAE.tumBB/GO', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(39, 'Mr. Hassan Heaney', 'imcglynn@example.com', '2024-11-18 12:24:29', '$2y$10$MkD8tc16ZB2eXB9e/rggkes3sGsTDRm6bgU2dGmFYaGRY8DMu6PCi', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(40, 'Prof. Viva Ankunding', 'amani.runolfsson@example.net', '2024-11-18 12:24:29', '$2y$10$6xv9aFbC/lB8JcvoULK4COe3ZIGT/8EtVNpQOvznv7DWz6X5edMEa', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(41, 'Prof. Keara Mayer', 'bwill@example.com', '2024-11-18 12:24:29', '$2y$10$V4WWmdrowHZN2uqh6uh5leJ41zSqBA./NPGeI9eL/Fpp.bq3K6zNK', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(42, 'Dr. Keyshawn West', 'teffertz@example.net', '2024-11-18 12:24:29', '$2y$10$C4.AFFDrJG2eDpF6Qn8h6ucI2uECsT.uN7GMurNi9RVo.AweADu1K', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(43, 'Raoul Yost', 'richmond.jenkins@example.org', '2024-11-18 12:24:29', '$2y$10$ROtqhXCIHjvxV7DuGwWQ.uTQm5whO23ff0d0Rom.wVBHRDxeGTT9C', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(44, 'Angel Murazik II', 'pollich.lulu@example.com', '2024-11-18 12:24:29', '$2y$10$kipW4xVZvz5.3lN9te34z.8JIpW0QsSF6XMGJwVupG53CMh9laPr2', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(45, 'Jordi Rau', 'maryjane.bosco@example.net', '2024-11-18 12:24:29', '$2y$10$xCRi9ES7LmeVrudrSOm1n.5vBCmrDHCaW/kSkorR6vgjV57mE5cJS', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(46, 'Cassie Adams V', 'gunnar.donnelly@example.net', '2024-11-18 12:24:30', '$2y$10$EE8SVJz4OD/hSwJHUucZwed/mQwt8SGreD1XuCtOLJBUn9sC5SOmG', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(47, 'Prof. Izaiah Herman', 'kertzmann.king@example.org', '2024-11-18 12:24:30', '$2y$10$1PH9wXtSKutpq6VbfGVw2OaXpfPTqfrVNw01uSkYmdXtbvnOPAnyO', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(48, 'Toby Yundt IV', 'botsford.cleo@example.org', '2024-11-18 12:24:30', '$2y$10$u8dkMudcLZiyh13jN8uDxeXehFFAO.sUZvrRoIUJ4/ZsSRmSGepVC', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(49, 'Colt Welch', 'laurence31@example.net', '2024-11-18 12:24:30', '$2y$10$1bSpCMWujjuULj9Y/hEpQeWCJYRCzuQPrmBaGh2kq15QJU3etWBc.', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(50, 'Ms. Faye Bartoletti PhD', 'ibraun@example.org', '2024-11-18 12:24:30', '$2y$10$1TqSmu0wWvkgMIWKW6R8B.FOR3NoKy7yzgUtSdPd6aq6B68widUB.', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(51, 'Charity Lang', 'mayer.vicente@example.net', '2024-11-18 12:24:30', '$2y$10$k8NZN27a6CF0F.s4FZaO3uUUeXEEGP3DAZFh5loslFJiIk7jgiCZS', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(52, 'Jodie Turner I', 'rohan.margie@example.org', '2024-11-18 12:24:30', '$2y$10$bW7vEZnqO/FsdNxfA4HFUuuD14.8RwK4welb6sjA0S3gnS.Dsluwy', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(53, 'Mrs. Albina Zieme III', 'lboyer@example.net', '2024-11-18 12:24:30', '$2y$10$Sy.a48K/Bps1khlyr90weO7TTXM3Mf1bdGszjVu0mc7V6UFeMn9uS', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(54, 'Jason Howe', 'marie.wiza@example.com', '2024-11-18 12:24:30', '$2y$10$givzV3anJY/omXgO7rz2guQmIP03I5U3mixjNLw/yYV6iUzb.ftdi', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(55, 'Dr. Clark Larkin DDS', 'parker64@example.com', '2024-11-18 12:24:30', '$2y$10$TM0C6GY0WoshD5dlLb/oa.Jq32oOyhWfFC4OkL.1Ul71h9PDTDc52', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(56, 'Fiona Stamm', 'tremblay.alvah@example.net', '2024-11-18 12:24:30', '$2y$10$K0hAxP6VkjUYKmD7aA7Ii.D6FVjFWiml2w7SCFdPn2J3tt57Hv9Qe', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:24:31', '2024-11-18 12:24:31'),
(62, 'Ms. Aurelie Hansen V', 'aniyah.shields@example.com', '2024-11-18 12:25:50', '$2y$10$FFXlMTGG96u6ANV8/UAAf.kolFet5I15EWIVarDt65zk3eL.K6kye', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(63, 'Stefanie Corwin', 'isanford@example.org', '2024-11-18 12:25:50', '$2y$10$Ew6dorT2fUxeup.OtjYRe.NRrOF44WTc.EHa5lEv45oUcPS0isjUW', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(64, 'Charlene Schimmel', 'otilia96@example.net', '2024-11-18 12:25:50', '$2y$10$FRpVTJVc/eJXlu86ZoSw2umHfWWR3eKgUok2BTuyCc0iW9GZ0vpS.', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(65, 'Hortense Leannon', 'rbeahan@example.org', '2024-11-18 12:25:51', '$2y$10$BJwSuBICUAb1YjxSvCttDODx2Gn.SuFgkCQPwV2WbH.oqa4DxHvoO', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(66, 'Bud Dach', 'aiyana.rippin@example.net', '2024-11-18 12:25:51', '$2y$10$zwkD4ABnflOepIwRAqtVTOdCTYsGDAY6IoV7fy3PCNiS1RklV1BZa', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(67, 'Arielle McLaughlin', 'mlockman@example.org', '2024-11-18 12:25:51', '$2y$10$Hte4TrmMq3m/1EVtjzfSpuOOY0bTtxZAAIu9Mt0..OccHm.2yXYdK', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(68, 'Caterina Lubowitz', 'milo86@example.net', '2024-11-18 12:25:51', '$2y$10$pyREYY0vewO6AFLPb23JOOVxZv/dCAl8I3ZOFJxABObS0TaS0TvD6', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(69, 'Barney Murazik', 'breitenberg.reina@example.com', '2024-11-18 12:25:51', '$2y$10$1xgVpBOecjLtAWbc5xx2C.B1GgGh/QJfqv70E1o357lwkfnRBgLcS', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(70, 'Dennis Hansen', 'verda.windler@example.com', '2024-11-18 12:25:51', '$2y$10$THSgsHOXziaSoYZqHdpvPudVL5TVOAIUiAGOoZ6XaRJOZmqcJoXzG', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(71, 'Dr. Amina Stamm', 'jane.bradtke@example.com', '2024-11-18 12:25:51', '$2y$10$JZm2/1TZ4PMtC79lx200QOg/1WdRp6qMpiiJx9il1iaxXcAC8iQse', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(72, 'Dr. Laurel Kuhic', 'amani.morar@example.com', '2024-11-18 12:25:51', '$2y$10$34JzMU0W9VT22L6pxhdzpeFh1SnpplTUZlfDj8XYtyRnvoSNUSQ.S', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(73, 'Landen Wisozk', 'auer.eleonore@example.org', '2024-11-18 12:25:51', '$2y$10$MdcKEdijfEYdrYgeFGNbu.7yJGCBcJMBMdoh/.6JkifaDH.yhnYNa', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(74, 'Earline Rutherford II', 'liliana.lowe@example.com', '2024-11-18 12:25:51', '$2y$10$EO8VLvko8RC8cUTyJV4lqeFdNd0Nd1VDqWtgGEpyEqQr8793/7ieG', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(75, 'Mrs. Izabella Ward', 'rgorczany@example.com', '2024-11-18 12:25:51', '$2y$10$CfwVkkO5wojrZwn0v8xkm.bV.XTUTAIL9IwAge7N1GstgVgo9E8F.', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(76, 'Mr. Wilbert Larson DDS', 'aboehm@example.org', '2024-11-18 12:25:51', '$2y$10$f6QmZwS/46mw1ziLA3.TbeEbZ2Fq1iamDuXUiHybXsGo2SagrE29S', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(77, 'Vernice Nicolas', 'lawson10@example.com', '2024-11-18 12:25:51', '$2y$10$POLz7LfBjGq0mzQMIUT3a.x8SpJU/xsftaCpIRjupkLgFcr6cyQUq', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(78, 'Mrs. Angelina Morar', 'nstamm@example.org', '2024-11-18 12:25:51', '$2y$10$MqrOGZ5zVXHyHMSq4x05L.1OPcJU5zz1P4MM4COVIne6332V34KU2', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(79, 'Claire Walsh', 'brittany69@example.com', '2024-11-18 12:25:52', '$2y$10$FLU4nblGySrjn1fRffaYSOopTC5GDWiLdFiyvlb5iXJbNhuUpVNQC', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(80, 'Rhianna Wunsch', 'madaline14@example.com', '2024-11-18 12:25:52', '$2y$10$UbURvc76b4o3OCqY1VfNK.fuxsOOErnL.k3dPHh/V97uTSBuirGW6', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(81, 'Prof. Lucius Stokes', 'claudie84@example.com', '2024-11-18 12:25:52', '$2y$10$lMxVVoq834NMBEcV8OtiLeXScMan2aG/D2sQpND4V8P7wc7PTlx8C', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(82, 'Adaline Ritchie', 'nquitzon@example.org', '2024-11-18 12:25:52', '$2y$10$ALZaN/KBOk/rrbg8ADvXmuRLU1l3Lz0/3/ZwyuoAh0TAeBmmGtC1S', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(83, 'Marianne Douglas DVM', 'lmorissette@example.com', '2024-11-18 12:25:52', '$2y$10$M9nEDkGlCm4rcllB3iWgOurD.FHJm1hc5ey8EhdkqbbqB.Ydh0a1S', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(84, 'Mr. Art Leffler', 'wiza.fae@example.com', '2024-11-18 12:25:52', '$2y$10$VuNXHMeOvSGuFddzhz4p4.tR.8IBkPxeDt.ty2auFJGms1U.HpRCe', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(85, 'Elouise Langosh DDS', 'mertz.eloisa@example.org', '2024-11-18 12:25:52', '$2y$10$B7qdCD6xwy574dl8cy923u54QbVC.HViIysFvDB6UlMVgDpFfKJvm', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(86, 'Torey Klocko', 'corwin.declan@example.net', '2024-11-18 12:25:52', '$2y$10$x4bjtMMWP7hi7729iEDQmuwdXBn1NHvpLpnL1fOy9vKndi7HSnYbK', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(87, 'Jude Smitham', 'acorwin@example.org', '2024-11-18 12:25:52', '$2y$10$e3OAvXPlZ/cZplm9lv/Oy.aViJGt0q6sBQ3ITPaaGLXAGuurX0eT6', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(88, 'Archibald Pfeffer', 'felix31@example.net', '2024-11-18 12:25:52', '$2y$10$5i7VsAuOz16BIx68bww4peYmhBMqVIGsoHWOdk9VqY2pXXlbJRShy', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(89, 'Prof. Daron Stiedemann IV', 'josefina.corkery@example.net', '2024-11-18 12:25:52', '$2y$10$i41J3BAJ3nJN3sAkfBSEFeDEKJ9GGq37jI.ta5qthEIE0F53aAsX6', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(90, 'Harry McLaughlin', 'noemi.emmerich@example.net', '2024-11-18 12:25:52', '$2y$10$fbuDn11zMdX4oS6wa4qpCOa2yNjuem.nhxxd2etmBRljUERl44USC', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(91, 'Laila Lakin', 'hessel.jamir@example.org', '2024-11-18 12:25:52', '$2y$10$CJyTP8XkG5Hho5rlLRF9OOCBIRQXdEuWVJrrr1W1ZV7jjhzqiLTuu', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(92, 'Ulices Kshlerin', 'okon.paula@example.org', '2024-11-18 12:25:52', '$2y$10$XmEsr3sV.eaUZeUxBvPx9.vJvAHzKN1GQ1otFvodSQVfPBTR41jJi', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(93, 'Rosendo Wintheiser', 'rahul69@example.com', '2024-11-18 12:25:53', '$2y$10$Em9zbpYHdypF/HigPrSczOz5WowG5XqCIQQ/A2HmL73yexlF4qphy', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(94, 'Kiera Baumbach', 'emmie41@example.net', '2024-11-18 12:25:53', '$2y$10$P04K/BtSbQCmle3hKmJTD.jeSkrIRUYIIlU/LQ.C33EdJ6/8chQre', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(95, 'Theodore Luettgen', 'neal.casper@example.net', '2024-11-18 12:25:53', '$2y$10$j2L6oNfwq6EQIRWyTmQ3m.q5s1P/Crh/NcBb6LWJaxU16Fj5TC0RK', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(96, 'Kaleb King', 'cynthia.prohaska@example.org', '2024-11-18 12:25:53', '$2y$10$eIShInS7m4POPzpQUqvjP.LWXk9ZRFSaqAAIFYCaw22tgU9HQJjlK', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(97, 'Madge Rodriguez', 'rwalsh@example.com', '2024-11-18 12:25:53', '$2y$10$ya/U8Bj3HAWBjgwNRhh2kOjkdfvlHRorY6ta1TeA4VmQILo13wZAC', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(98, 'Isom Boyle', 'jayson52@example.net', '2024-11-18 12:25:53', '$2y$10$ZBlrtoSj.eG4goyrHoAhL.F3hUfJS0g/jJEGHORibiDgz3OT2Sb2K', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(99, 'Mr. Wilfredo Crona', 'brandy.schuster@example.org', '2024-11-18 12:25:53', '$2y$10$49twQS20aU1cM8aej0CYJ.J7QvSXCL9iBhX/WAQwqKlsuH3NbVX/6', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(100, 'Prof. Grayson Bailey', 'iquigley@example.org', '2024-11-18 12:25:53', '$2y$10$GkmjI36IPSPJho0TappVn.EkEbbXfwuGas.4VGFr292PLcasVa7oO', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(101, 'Laisha Leuschke I', 'freeman07@example.org', '2024-11-18 12:25:53', '$2y$10$GAxRR8t60/GmO/5PKSZ16.Y1eMj/gyXvnLK0pzJQNMycuI6.Jl.xG', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(102, 'Scarlett Kiehn', 'ritchie.brandy@example.com', '2024-11-18 12:25:53', '$2y$10$UQS7.SZ65GfJuX7gIwZ/tOOHbXXDXMFswRQyn4NWJjlof1OymQvuq', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(103, 'Cicero Weber III', 'theresa67@example.net', '2024-11-18 12:25:53', '$2y$10$TBI2paXKq7VJs0SUySwQkO6DUxcsUvljDPyNlpzh2bQUMb1xNCCYm', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(104, 'Rosalee Kunde', 'icruickshank@example.org', '2024-11-18 12:25:53', '$2y$10$/G.l32VSC4XjIobKrw37pusBWBjLxk5zU1UFKAtOEYuJ13Z7PUkyS', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(105, 'Ms. Beulah Boyle PhD', 'nschmitt@example.org', '2024-11-18 12:25:53', '$2y$10$eqcUfbtkCAKwNl8gDlejY.aR1To7WlOiPqYPufzKwgy5GvrMDew22', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(106, 'Dudley Howell', 'bednar.tyree@example.com', '2024-11-18 12:25:53', '$2y$10$i.osquxL28inHQS/4NGNdOa3Jw9mSd4SjvIrw8DTxw6ZGv4LgNafO', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(107, 'Lonny Zemlak', 'marjory76@example.net', '2024-11-18 12:25:54', '$2y$10$Moj1wcwUkeO4d9lepVSLhe3XtzVtZuIYKpwYZGyIoe4lTb/hozy0m', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(108, 'Zackery Homenick', 'mschuster@example.net', '2024-11-18 12:25:54', '$2y$10$40gm54PrycyEwu4x0SXL9utkgdQUxwnjw/5G2Nt53wwZTfg0BCZSO', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(109, 'Shaina Kshlerin', 'jammie70@example.com', '2024-11-18 12:25:54', '$2y$10$3DjYb04ob.fGTwaPivbbceol5BwT83HElj9nDlaEZB9c9ok6YZ15G', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(110, 'Miguel Waelchi', 'kshlerin.elissa@example.org', '2024-11-18 12:25:54', '$2y$10$FQqoi0rEY1so/SzAqLByau0oCYAyl9/R2Wjt6tXa0bOeuMYpXIQz.', NULL, NULL, 'Female', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(111, 'Tanya Hirthe MD', 'lula.nikolaus@example.net', '2024-11-18 12:25:54', '$2y$10$iNpVQHTzsOXYkoWrf2zpu.Ym0yKDUHJfi9G/uoPbPXQ2Po5BfuPXK', NULL, NULL, 'Male', '0', NULL, NULL, 'user', '1', NULL, '2024-11-18 12:25:54', '2024-11-18 12:25:54'),
(112, 'user7', 'user7@gmail.com', NULL, '$2y$10$3ptKfddjAFMLOhNRTYiCQunugChNQMro4t8qtaYjQ8n5WTJeshCZ2', NULL, NULL, NULL, '0', NULL, NULL, 'user', '1', NULL, '2025-01-07 13:09:23', '2025-01-07 13:09:23'),
(113, 'Elite Home Services', 'vendor3@gmail.com', NULL, '$2y$10$i34OJfPctF7Ben/psFlJUOcRElNlQXzEPSar/q5d2agMOfm3QBiAa', 'Southern University College, PTD 64888, Jalan Selatan Utama, KM 15, Off, Skudai Lbh, 81300 Skudai, Johor Darul Ta\'zim', NULL, NULL, '0', '0123456789', '1736256323.png', 'vendor', '1', NULL, '2025-01-07 13:22:15', '2025-01-07 13:25:23'),
(114, 'Green Thumb Experts', 'vendor4@gmail.com', NULL, '$2y$10$Uz.7nejXpC.AehWeghq9ie0xfyBxP5sOHmPgQpY5eHEj43yl6HxKW', 'Southern University College, PTD 64888, Jalan Selatan Utama, KM 15, Off, Skudai Lbh, 81300 Skudai, Johor Darul Ta\'zim', NULL, NULL, '0', '0123456789', '1736257676.jpg', 'vendor', '1', NULL, '2025-01-07 13:45:22', '2025-01-07 13:47:56'),
(115, 'QuickFix Runners', 'vendor5@gmail.com', NULL, '$2y$10$AUyfCCjLbnIp2wQPvOUO/eJvbg2A0.2eXH.shmI7NxV.5oA2VPbDW', 'Southern University College, PTD 64888, Jalan Selatan Utama, KM 15, Off, Skudai Lbh, 81300 Skudai, Johor Darul Ta\'zim', NULL, NULL, '0', '0123456789', '1736257964.png', 'vendor', '1', NULL, '2025-01-07 13:48:24', '2025-01-07 13:52:44'),
(116, 'HandyPro Solutions', 'vendor6@gmail.com', NULL, '$2y$10$fbllUSqGEO3BM0TUtpPWfujo9HGwRgjet/Gesa29M4dpCO1dtH8/u', 'Southern University College, PTD 64888, Jalan Selatan Utama, KM 15, Off, Skudai Lbh, 81300 Skudai, Johor Darul Ta\'zim', NULL, NULL, '0', '0123456789', '1736257840.jpg', 'vendor', '1', NULL, '2025-01-07 13:49:51', '2025-01-07 13:50:40'),
(117, 'Urban Maintenance Co.', 'vendor7@gmail.com', NULL, '$2y$10$swtNiZH4oypakefXNeJV/eQQd9WGBttnfQS6Wz3t.5NqjUozCIJEW', 'Southern University College, PTD 64888, Jalan Selatan Utama, KM 15, Off, Skudai Lbh, 81300 Skudai, Johor Darul Ta\'zim', NULL, NULL, '0', '0123456789', '1736260564.jpg', 'vendor', '1', NULL, '2025-01-07 14:35:18', '2025-01-07 14:36:04'),
(118, 'Swift Hands Services', 'vendor8@gmail.com', NULL, '$2y$10$ZdkgFEcxDsmh4cxjjPDH6uZtEPdRcleY7P4lOPnfZEhKrPJ8GVOTy', 'Southern University College, PTD 64888, Jalan Selatan Utama, KM 15, Off, Skudai Lbh, 81300 Skudai, Johor Darul Ta\'zim', NULL, NULL, '0', '0123456789', '1736260642.jpg', 'vendor', '1', NULL, '2025-01-07 14:36:32', '2025-01-07 14:37:22');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rating` decimal(3,2) NOT NULL DEFAULT 0.00,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT '1',
  `description` longtext DEFAULT NULL,
  `ssm_path` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `rating`, `user_id`, `created_at`, `updated_at`, `status`, `description`, `ssm_path`, `category`, `comment`) VALUES
(1, 2.90, 6, '2024-12-25 15:29:14', '2024-12-25 15:29:14', '0', NULL, NULL, NULL, NULL),
(2, 3.30, 7, '2024-12-25 15:29:14', '2024-12-25 15:29:14', '0', NULL, NULL, NULL, NULL),
(3, 2.50, NULL, '2024-12-25 15:29:14', '2024-12-25 15:29:14', '0', NULL, NULL, NULL, NULL),
(4, 2.00, NULL, '2024-12-25 15:29:14', '2024-12-25 15:29:14', '0', NULL, NULL, NULL, NULL),
(5, 1.10, NULL, '2024-12-25 15:29:14', '2024-12-25 15:29:14', '0', NULL, NULL, NULL, NULL),
(6, 2.80, NULL, '2024-12-25 15:29:14', '2024-12-25 15:29:14', '0', NULL, NULL, NULL, NULL),
(7, 1.80, NULL, '2024-12-25 15:29:14', '2024-12-25 15:29:14', '0', NULL, NULL, NULL, NULL),
(8, 3.40, NULL, '2024-12-25 15:29:14', '2024-12-25 15:29:14', '0', NULL, NULL, NULL, NULL),
(9, 3.50, 113, '2025-01-07 13:22:15', '2025-01-07 13:26:03', '1', 'Elite Home Services specializes in residential and commercial electrical wiring and plumbing solutions. With over 10 years of experience, they provide high-quality installations, repairs, and maintenance with a focus on safety and efficiency', '1736256323_SSM.pdf', 'wiring,piping', NULL),
(10, 4.30, 114, '2025-01-07 13:45:22', '2025-01-07 13:51:15', '1', 'Green Thumb Experts offers professional gardening services, including landscaping, plant care, and garden design. They are known for their sustainable practices and personalized garden setups for homes and businesses.', '1736257676_SSM.pdf', 'gardening', NULL),
(11, 4.80, 115, '2025-01-07 13:48:24', '2025-01-07 13:53:27', '1', 'QuickFix Runners provides on-demand errand-running services along with basic plumbing repairs. Their team is trained to handle small-scale tasks quickly and efficiently, catering to both residential and corporate clients.', '1736257964_SSM.pdf', 'piping,runner', NULL),
(12, 5.00, 116, '2025-01-07 13:49:51', '2025-01-07 13:51:25', '1', 'HandyPro Solutions is a multi-service vendor specializing in electrical wiring, gardening, and running errands. They are well-regarded for their versatility and prompt customer service.', '1736257840_SSM.pdf', 'wiring,gardening,runner', NULL),
(13, 0.00, 117, '2025-01-07 14:35:18', '2025-01-07 15:27:58', '2', 'Urban Maintenance Co. offers professional plumbing services and expert gardening solutions for urban spaces. They focus on eco-friendly techniques and reliable repairs for both home and commercial projects. up', '1736260564_SSM.pdf', 'piping,gardening', 'Description not clear'),
(14, 0.00, 118, '2025-01-07 14:36:32', '2025-01-07 14:37:22', '0', 'Swift Hands Services excels in errand-running and electrical wiring tasks. Their team is known for its quick response times, precise workmanship, and customer-first approach, making them a go-to for diverse needs.', '1736260642_SSM.pdf', 'wiring,runner', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendor_ratings`
--

CREATE TABLE `vendor_ratings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `rating` decimal(2,1) NOT NULL,
  `review` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_ratings`
--

INSERT INTO `vendor_ratings` (`id`, `vendor_id`, `user_id`, `rating`, `review`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 5.0, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(2, 1, 4, 3.9, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(3, 1, 4, 1.6, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(4, 2, 4, 4.6, 'Review for vendor Electric Solutions', '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(5, 2, 4, 2.5, 'Review for vendor Electric Solutions', '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(6, 2, 4, 4.3, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(7, 3, 4, 4.5, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(8, 3, 4, 3.1, 'Review for vendor Piping Pro', '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(9, 3, 4, 1.2, 'Review for vendor Piping Pro', '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(10, 4, 4, 1.1, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(11, 4, 4, 2.3, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(12, 4, 18, 1.5, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(13, 5, 5, 3.9, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(14, 5, 4, 1.8, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(15, 5, 4, 4.9, 'Review for vendor Green Thumb Gardening', '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(16, 6, 4, 2.7, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(17, 6, 4, 2.3, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(18, 6, 7, 4.3, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(19, 7, 7, 1.6, 'Review for vendor Quick Runners', '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(20, 7, 4, 1.0, 'Review for vendor Quick Runners', '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(21, 7, 4, 3.1, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(22, 8, 4, 5.0, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(23, 8, 4, 4.4, 'Review for vendor Speedy Couriers', '2024-12-25 15:31:28', '2024-12-25 15:31:28'),
(24, 8, 4, 4.3, NULL, '2024-12-25 15:31:28', '2024-12-25 15:31:28');

-- --------------------------------------------------------

--
-- Table structure for table `wiring_details`
--

CREATE TABLE `wiring_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `fixitem` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`fixitem`)),
  `ishavepart` tinyint(1) NOT NULL,
  `types_property` varchar(255) NOT NULL,
  `app_date` date NOT NULL,
  `preferred_time` varchar(255) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `budget` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wiring_details`
--

INSERT INTO `wiring_details` (`id`, `type`, `fixitem`, `ishavepart`, `types_property`, `app_date`, `preferred_time`, `details`, `photo`, `budget`, `created_at`, `updated_at`) VALUES
(1, 'Maintenance', '[\"Fuse Box\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2024-12-17', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM2000 - RM4999', '2024-12-08 15:01:57', '2024-12-08 15:01:57'),
(2, 'Maintenance', '[\"Fuse Box\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2024-12-19', 'Lunch Time (11 AM - 1 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-19 06:09:01', '2024-12-19 06:09:01'),
(3, 'Repair', '[\"Wiring\",\"Fuse Box\",\"Other (Explain in Additional Details)\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-19', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM2000 - RM4999', '2024-12-19 07:26:15', '2024-12-19 07:26:15'),
(4, 'Repair', '[\"Outlets\"]', 0, 'High-rise (e.g. condo, apartment)', '2024-12-19', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM200000 - Above', '2024-12-19 08:01:23', '2024-12-19 08:01:23'),
(5, 'Maintenance', '[\"Ceiling Fan\",\"Fuse Box\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2024-12-19', 'Lunch Time (11 AM - 1 PM)', NULL, '[]', 'RM200000 - Above', '2024-12-19 08:05:11', '2024-12-19 08:05:11'),
(6, 'Repair', '[\"Wiring\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-20', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM100000 - RM199999', '2024-12-20 15:56:43', '2024-12-20 15:56:43'),
(7, 'Maintenance', '[\"Fuse Box\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-21', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM50000 - RM99999', '2024-12-20 16:05:11', '2024-12-20 16:05:11'),
(8, 'Repair', '[\"Light Bulb\",\"Switches\"]', 1, 'High-rise (e.g. condo, apartment)', '2024-12-21', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-20 16:06:41', '2024-12-20 16:06:41'),
(9, 'Repair', '[\"Light Bulb\",\"Outlets\"]', 1, 'High-rise (e.g. condo, apartment)', '2024-12-21', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-21 09:04:44', '2024-12-21 09:04:44'),
(10, 'Repair', '[\"Outlets\"]', 1, 'High-rise (e.g. condo, apartment)', '2024-12-22', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-22 09:17:15', '2024-12-22 09:17:15'),
(11, 'Maintenance', '[\"Wiring\",\"Fuse Box\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-23', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-23 13:03:40', '2024-12-23 13:03:40'),
(12, 'Maintenance', '[\"Ceiling Fan\",\"Light Bulb\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2024-12-24', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-24 01:33:34', '2024-12-24 01:33:34'),
(13, 'Repair', '[\"Light Bulb\",\"Fuse Box\"]', 1, 'High-rise (e.g. condo, apartment)', '2024-12-24', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-24 01:34:25', '2024-12-24 01:34:25'),
(14, 'Repair', '[\"Fuse Box\",\"Wiring\"]', 0, 'High-rise (e.g. condo, apartment)', '2024-12-24', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-24 01:39:12', '2024-12-24 01:39:12'),
(15, 'Repair', '[\"Fuse Box\",\"Wiring\"]', 0, 'High-rise (e.g. condo, apartment)', '2024-12-24', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-24 01:39:13', '2024-12-24 01:39:13'),
(16, 'Repair', '[\"Fuse Box\",\"Wiring\"]', 0, 'High-rise (e.g. condo, apartment)', '2024-12-24', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-24 01:39:13', '2024-12-24 01:39:13'),
(17, 'Maintenance', '[\"Light Bulb\",\"Fuse Box\"]', 0, 'High-rise (e.g. condo, apartment)', '2024-12-24', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM2000 - RM4999', '2024-12-24 01:39:44', '2024-12-24 01:39:44'),
(18, 'Maintenance', '[\"Fuse Box\",\"Wiring\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2024-12-24', 'Lunch Time (11 AM - 1 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-24 01:49:54', '2024-12-24 01:49:54'),
(19, 'Maintenance', '[\"Wiring\",\"Fuse Box\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2024-12-24', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-24 01:57:40', '2024-12-24 01:57:40'),
(20, 'Maintenance', '[\"Wiring\",\"Fuse Box\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2024-12-24', 'Late Afternoon (3 PM - 5 PM)', 'jiji', '[]', 'RM20000 - RM49999', '2024-12-24 01:58:49', '2024-12-24 01:58:49'),
(21, 'Repair', '[\"Wiring\",\"Ceiling Fan\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-24', 'Lunch Time (11 AM - 1 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-24 02:00:12', '2024-12-24 02:00:12'),
(22, 'Repair', '[\"Fuse Box\",\"Wiring\"]', 0, 'High-rise (e.g. condo, apartment)', '2024-12-24', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-24 02:05:38', '2024-12-24 02:05:38'),
(23, 'Repair', '[\"Fuse Box\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-26', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM100000 - RM199999', '2024-12-26 07:51:23', '2024-12-26 07:51:23'),
(24, 'Inspection', '[\"Ceiling Fan\",\"Switches\"]', 0, 'High-rise (e.g. condo, apartment)', '2024-12-28', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM5000 - RM9999', '2024-12-28 07:14:17', '2024-12-28 07:14:17'),
(25, 'Maintenance', '[\"Ceiling Fan\",\"Fuse Box\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2024-12-28', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM100000 - RM199999', '2024-12-28 07:17:08', '2024-12-28 07:17:08'),
(26, 'Maintenance', '[\"Other (Explain in Additional Details)\",\"Ceiling Fan\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-28', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-28 07:44:14', '2024-12-28 07:44:14'),
(27, 'Repair', '[\"Wiring\",\"Fuse Box\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-29', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-28 17:06:38', '2024-12-28 17:06:38'),
(28, 'Repair', '[\"Wiring\",\"Ceiling Fan\"]', 0, 'High-rise (e.g. condo, apartment)', '2024-12-29', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-28 17:15:58', '2024-12-28 17:15:58'),
(29, 'Maintenance', '[\"Wiring\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM5000 - RM9999', '2024-12-30 09:19:48', '2024-12-30 09:19:48'),
(30, 'Repair', '[\"Outlets\",\"Switches\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-30 13:45:21', '2024-12-30 13:45:21'),
(31, 'Repair', '[\"Wiring\",\"Light Bulb\",\"Other (Explain in Additional Details)\"]', 0, 'High-rise (e.g. condo, apartment)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '[]', 'RM10000 - RM19999', '2024-12-30 14:36:02', '2024-12-30 14:36:02'),
(32, 'Repair', '[\"Outlets\",\"Switches\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Lunch Time (11 AM - 1 PM)', NULL, '[]', 'RM20000 - RM49999', '2024-12-30 14:47:09', '2024-12-30 14:47:09'),
(33, 'Repair', '[\"Wiring\",\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM20000 - RM49999', '2024-12-30 14:52:46', '2024-12-30 14:52:46'),
(34, 'Repair', '[\"Light Bulb\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '[]', 'RM5000 - RM9999', '2024-12-30 15:17:46', '2024-12-30 15:17:46'),
(35, 'Maintenance', '[\"Fuse Box\",\"Wiring\",\"Other (Explain in Additional Details)\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '[\"no_service.png\"]', 'RM10000 - RM19999', '2024-12-30 15:23:35', '2024-12-30 15:23:36'),
(36, 'Repair', '[\"Light Bulb\",\"Outlets\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-30', 'Early Afternoon (1 PM - 3 PM)', NULL, '[\"no_service.png\"]', 'RM100000 - RM199999', '2024-12-30 15:24:52', '2024-12-30 15:24:54'),
(37, 'Inspection', '[\"Switches\",\"Outlets\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-01', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070269.jpg,1000070252.jpg', 'RM20000 - RM49999', '2024-12-30 16:02:13', '2024-12-30 16:02:13'),
(38, 'Inspection', '[\"Outlets\",\"Switches\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2025-01-01', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070269.jpg,1000070252.jpg', 'RM20000 - RM49999', '2024-12-30 16:06:29', '2024-12-30 16:06:29'),
(39, 'Inspection', '[\"Switches\",\"Outlets\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-01', 'Anytime', NULL, '1000070269.jpg,1000070252.jpg', 'RM50000 - RM99999', '2024-12-30 16:08:07', '2024-12-30 16:08:07'),
(40, 'Repair', '[\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070269.jpg,1000070252.jpg', 'RM50000 - RM99999', '2024-12-30 16:15:02', '2024-12-30 16:15:02'),
(41, 'Repair', '[\"Light Bulb\",\"Outlets\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070269.jpg,1000070252.jpg', 'RM20000 - RM49999', '2024-12-30 16:21:31', '2024-12-30 16:21:31'),
(42, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Lunch Time (11 AM - 1 PM)', NULL, NULL, 'RM20000 - RM49999', '2024-12-30 16:26:08', '2024-12-30 16:26:08'),
(43, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Lunch Time (11 AM - 1 PM)', NULL, NULL, 'RM20000 - RM49999', '2024-12-30 16:26:14', '2024-12-30 16:26:14'),
(44, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Lunch Time (11 AM - 1 PM)', NULL, NULL, 'RM20000 - RM49999', '2024-12-30 16:26:30', '2024-12-30 16:26:30'),
(45, 'Repair', '[\"Wiring\",\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, NULL, 'RM10000 - RM19999', '2024-12-30 16:39:04', '2024-12-30 16:39:04'),
(46, 'Repair', '[\"Wiring\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Anytime', NULL, NULL, 'RM10000 - RM19999', '2024-12-30 16:40:20', '2024-12-30 16:40:20'),
(47, 'Repair', '[\"Outlets\",\"Light Bulb\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070269.jpg,1000070252.jpg', 'RM20000 - RM49999', '2024-12-30 16:40:35', '2024-12-30 16:40:35'),
(48, 'Repair', '[\"Wiring\",\"Light Bulb\",\"Other (Explain in Additional Details)\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Lunch Time (11 AM - 1 PM)', NULL, '1000070269.jpg', 'RM20000 - RM49999', '2024-12-30 16:43:51', '2024-12-30 16:43:51'),
(49, 'Repair', '[\"Wiring\",\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070269.jpg', 'RM20000 - RM49999', '2024-12-30 16:46:23', '2024-12-30 16:46:23'),
(50, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070269.jpg', 'RM20000 - RM49999', '2024-12-30 16:47:35', '2024-12-30 16:47:35'),
(51, 'Inspection', '[\"Wiring\",\"Light Bulb\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070269.jpg', 'RM20000 - RM49999', '2024-12-30 16:49:20', '2024-12-30 16:49:20'),
(52, 'Inspection', '[\"Outlets\",\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070269.jpg', 'RM20000 - RM49999', '2024-12-30 16:50:52', '2024-12-30 16:50:52'),
(53, 'Repair', '[\"Wiring\",\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070269.jpg', 'RM200000 - Above', '2024-12-30 16:53:42', '2024-12-30 16:53:42'),
(54, 'Repair', '[\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070269.jpg', 'RM20000 - RM49999', '2024-12-30 16:57:34', '2024-12-30 16:57:34'),
(55, 'Repair', '[\"Outlets\",\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070270.jpg', 'RM50000 - RM99999', '2024-12-30 16:59:03', '2024-12-30 16:59:03'),
(56, 'Repair', '[\"Outlets\",\"Ceiling Fan\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070270.jpg', 'RM10000 - RM19999', '2024-12-30 17:07:31', '2024-12-30 17:07:31'),
(57, 'Repair', '[\"Light Bulb\",\"Other (Explain in Additional Details)\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070270.jpg', 'RM20000 - RM49999', '2024-12-30 17:10:38', '2024-12-30 17:10:38'),
(58, 'Inspection', '[\"Outlets\",\"Ceiling Fan\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070270.jpg,1000070269.jpg', 'RM10000 - RM19999', '2024-12-30 17:11:13', '2024-12-30 17:11:13'),
(59, 'Repair', '[\"Wiring\",\"Outlets\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070270.jpg,1000070269.jpg,1000070252.jpg', 'RM10000 - RM19999', '2024-12-30 17:21:55', '2024-12-30 17:21:55'),
(60, 'Repair', '[\"Fuse Box\",\"Wiring\"]', 0, 'High-rise (e.g. condo, apartment)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070273.jpg,1000070272.jpg,1000070271.jpg', 'RM10000 - RM19999', '2024-12-30 17:22:48', '2024-12-30 17:22:48'),
(61, 'Repair', '[\"Outlets\",\"Light Bulb\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg,1000070275.jpg,1000070274.jpg', 'RM100000 - RM199999', '2024-12-30 17:28:21', '2024-12-30 17:28:21'),
(62, 'Repair', '[\"Wiring\",\"Outlets\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg', 'RM20000 - RM49999', '2024-12-30 17:33:10', '2024-12-30 17:33:10'),
(63, 'Repair', '[\"Wiring\",\"Outlets\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070274.jpg,1000070275.jpg,1000070273.jpg', 'RM20000 - RM49999', '2024-12-30 17:33:43', '2024-12-30 17:33:43'),
(64, 'Repair', '[\"Outlets\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg,1000070275.jpg,1000070274.jpg', 'RM20000 - RM49999', '2024-12-30 17:37:33', '2024-12-30 17:37:33'),
(65, 'Repair', '[\"Wiring\",\"Outlets\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM10000 - RM19999', '2024-12-30 17:41:22', '2024-12-30 17:41:22'),
(66, 'Repair', '[\"Wiring\",\"Outlets\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Anytime', NULL, 'no_service.png', 'RM10000 - RM19999', '2024-12-30 17:43:36', '2024-12-30 17:43:36'),
(67, 'Maintenance', '[\"Light Bulb\",\"Wiring\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg', 'RM20000 - RM49999', '2024-12-30 17:57:31', '2024-12-30 17:57:31'),
(68, 'Repair', '[\"Wiring\",\"Outlets\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM20000 - RM49999', '2024-12-30 17:57:49', '2024-12-30 17:57:49'),
(69, 'Repair', '[\"Wiring\",\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 01:11:33', '2024-12-31 01:11:33'),
(70, 'Repair', '[\"Wiring\",\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Morning (9 AM - 11 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 01:17:13', '2024-12-31 01:17:13'),
(71, 'Inspection', '[\"Wiring\",\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Anytime', NULL, '1000070272.jpg,1000070273.jpg', 'RM50000 - RM99999', '2024-12-31 01:19:14', '2024-12-31 01:19:14'),
(72, 'Repair', '[\"Outlets\",\"Light Bulb\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Anytime', NULL, '1000070273.jpg,1000070272.jpg', 'RM50000 - RM99999', '2024-12-31 01:26:31', '2024-12-31 01:26:31'),
(73, 'Inspection', '[\"Wiring\",\"Light Bulb\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Anytime', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 01:28:43', '2024-12-31 01:28:43'),
(74, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 01:32:14', '2024-12-31 01:32:14'),
(75, 'Repair', '[\"Light Bulb\",\"Outlets\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Anytime', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 01:36:12', '2024-12-31 01:36:12'),
(76, 'Repair', '[\"Light Bulb\",\"Outlets\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 01:39:51', '2024-12-31 01:39:51'),
(77, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 01:49:12', '2024-12-31 01:49:12'),
(78, 'Inspection', '[\"Wiring\",\"Light Bulb\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM100000 - RM199999', '2024-12-31 01:54:21', '2024-12-31 01:54:21'),
(79, 'Inspection', '[\"Light Bulb\",\"Wiring\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg,1000070274.jpg', 'RM200000 - Above', '2024-12-31 01:56:17', '2024-12-31 01:56:17'),
(80, 'Repair', '[\"Light Bulb\",\"Generator\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070273.jpg,1000070272.jpg', 'RM50000 - RM99999', '2024-12-31 02:01:37', '2024-12-31 02:01:37'),
(81, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 02:10:10', '2024-12-31 02:10:10'),
(82, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Commercial (e.g. factory, shopping centre)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 02:11:07', '2024-12-31 02:11:07'),
(83, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070275.jpg,1000070276.jpg', 'RM50000 - RM99999', '2024-12-31 02:32:49', '2024-12-31 02:32:49'),
(84, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Late Afternoon (3 PM - 5 PM)', NULL, 'no_service.png', 'RM20000 - RM49999', '2024-12-31 02:35:15', '2024-12-31 02:35:15'),
(85, 'Repair', '[\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2024-12-31', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2024-12-31 02:46:27', '2024-12-31 02:46:27'),
(86, 'Repair', '[\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-01', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2025-01-01 15:59:39', '2025-01-01 15:59:39'),
(87, 'Repair', '[\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-02', 'Lunch Time (11 AM - 1 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM100000 - RM199999', '2025-01-01 16:12:45', '2025-01-01 16:12:45'),
(88, 'Repair', '[\"Light Bulb\"]', 1, 'High-rise (e.g. condo, apartment)', '2025-01-02', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM50000 - RM99999', '2025-01-01 16:31:54', '2025-01-01 16:31:54'),
(89, 'Repair', '[\"Outlets\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-02', 'Anytime', NULL, '1000070276.jpg,1000070275.jpg', 'RM20000 - RM49999', '2025-01-01 16:37:19', '2025-01-01 16:37:19'),
(90, 'Repair', '[\"Outlets\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-02', 'Anytime', NULL, '1000070276.jpg,1000070275.jpg', 'RM20000 - RM49999', '2025-01-01 16:37:35', '2025-01-01 16:37:35'),
(91, 'Repair', '[\"Fuse Box\",\"Ceiling Fan\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-02', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070276.jpg,1000070275.jpg', 'RM10000 - RM19999', '2025-01-01 17:15:34', '2025-01-01 17:15:34'),
(92, 'Repair', '[\"Wiring\",\"Outlets\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2025-01-02', 'Lunch Time (11 AM - 1 PM)', NULL, '1000070275.jpg,1000070276.jpg', 'RM20000 - RM49999', '2025-01-01 17:18:57', '2025-01-01 17:18:57'),
(93, 'Repair', '[\"Light Bulb\",\"Wiring\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-07', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070303.jpg', 'RM20000 - RM49999', '2025-01-07 13:09:44', '2025-01-07 13:09:44'),
(94, 'Maintenance', '[\"Fuse Box\",\"Ceiling Fan\"]', 0, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-07', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070303.jpg,1000070302.jpg', 'RM20000 - RM49999', '2025-01-07 13:27:37', '2025-01-07 13:27:37'),
(95, 'Repair', '[\"Fuse Box\",\"Ceiling Fan\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2025-01-07', 'Early Afternoon (1 PM - 3 PM)', 'tvthy', '1000070299.jpg,1000070300.jpg', 'RM50000 - RM99999', '2025-01-07 13:29:26', '2025-01-07 13:29:26'),
(96, 'Repair', '[\"Fuse Box\",\"Ceiling Fan\"]', 0, 'High-rise (e.g. condo, apartment)', '2025-01-07', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070302.jpg,1000070303.jpg', 'RM100000 - RM199999', '2025-01-07 13:30:45', '2025-01-07 13:30:45'),
(97, 'Repair', '[\"Fuse Box\",\"Ceiling Fan\"]', 0, 'High-rise (e.g. condo, apartment)', '2025-01-07', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070302.jpg,1000070303.jpg', 'RM100000 - RM199999', '2025-01-07 13:30:55', '2025-01-07 13:30:55'),
(98, 'Repair', '[\"Fuse Box\",\"Wiring\"]', 0, 'Commercial (e.g. factory, shopping centre)', '2025-01-07', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070303.jpg', 'RM5000 - RM9999', '2025-01-07 13:57:49', '2025-01-07 13:57:49'),
(99, 'Repair', '[\"Fuse Box\",\"Light Bulb\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-07', 'Early Afternoon (1 PM - 3 PM)', NULL, '1000070303.jpg', 'RM20000 - RM49999', '2025-01-07 13:59:43', '2025-01-07 13:59:43'),
(100, 'Repair', '[\"Wiring\",\"Ceiling Fan\"]', 1, 'Light Commercial (e.g. office, shop, cafe)', '2025-01-07', 'Late Afternoon (3 PM - 5 PM)', NULL, '1000070299.jpg', 'RM20000 - RM49999', '2025-01-07 14:01:55', '2025-01-07 14:01:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `address_user_id_foreign` (`user_id`);

--
-- Indexes for table `bidding`
--
ALTER TABLE `bidding`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bidding_winner_id_foreign` (`winner_id`),
  ADD KEY `bidding_plant_id_foreign` (`plant_id`);

--
-- Indexes for table `bidding_detail`
--
ALTER TABLE `bidding_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bidding_detail_bidding_id_foreign` (`bidding_id`),
  ADD KEY `bidding_detail_user_id_foreign` (`user_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_product_id_foreign` (`product_id`),
  ADD KEY `cart_plant_id_foreign` (`plant_id`),
  ADD KEY `cart_bidding_id_foreign` (`bidding_id`),
  ADD KEY `cart_user_id_foreign` (`user_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom`
--
ALTER TABLE `custom`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_user_id_foreign` (`user_id`),
  ADD KEY `delivery_order_id_foreign` (`order_id`),
  ADD KEY `delivery_vendor_id_foreign` (`vendor_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `gardening_details`
--
ALTER TABLE `gardening_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_detail_order_id_foreign` (`order_id`),
  ADD KEY `order_detail_product_id_foreign` (`product_id`),
  ADD KEY `order_detail_plant_id_foreign` (`plant_id`),
  ADD KEY `order_detail_delivery_id_foreign` (`delivery_id`),
  ADD KEY `order_detail_bidding_id_foreign` (`bidding_id`),
  ADD KEY `order_detail_wiring_id_foreign` (`wiring_id`),
  ADD KEY `order_detail_piping_id_foreign` (`piping_id`),
  ADD KEY `order_detail_gardening_id_foreign` (`gardening_id`),
  ADD KEY `order_detail_runner_id_foreign` (`runner_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_order_id_foreign` (`order_id`),
  ADD KEY `payment_bidding_id_foreign` (`bidding_id`),
  ADD KEY `payment_user_id_foreign` (`user_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `piping_details`
--
ALTER TABLE `piping_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `plant`
--
ALTER TABLE `plant`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plant_cat_id_foreign` (`cat_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_cat_id_foreign` (`cat_id`);

--
-- Indexes for table `runner_details`
--
ALTER TABLE `runner_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendors_user_id_foreign` (`user_id`);

--
-- Indexes for table `vendor_ratings`
--
ALTER TABLE `vendor_ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_ratings_vendor_id_foreign` (`vendor_id`),
  ADD KEY `vendor_ratings_user_id_foreign` (`user_id`);

--
-- Indexes for table `wiring_details`
--
ALTER TABLE `wiring_details`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bidding`
--
ALTER TABLE `bidding`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bidding_detail`
--
ALTER TABLE `bidding_detail`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `custom`
--
ALTER TABLE `custom`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gardening_details`
--
ALTER TABLE `gardening_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `piping_details`
--
ALTER TABLE `piping_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `plant`
--
ALTER TABLE `plant`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=239;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `runner_details`
--
ALTER TABLE `runner_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `vendor_ratings`
--
ALTER TABLE `vendor_ratings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `wiring_details`
--
ALTER TABLE `wiring_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `bidding`
--
ALTER TABLE `bidding`
  ADD CONSTRAINT `bidding_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plant` (`id`),
  ADD CONSTRAINT `bidding_winner_id_foreign` FOREIGN KEY (`winner_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `bidding_detail`
--
ALTER TABLE `bidding_detail`
  ADD CONSTRAINT `bidding_detail_bidding_id_foreign` FOREIGN KEY (`bidding_id`) REFERENCES `bidding` (`id`),
  ADD CONSTRAINT `bidding_detail_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_bidding_id_foreign` FOREIGN KEY (`bidding_id`) REFERENCES `bidding` (`id`),
  ADD CONSTRAINT `cart_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plant` (`id`),
  ADD CONSTRAINT `cart_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `cart_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `delivery_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `delivery_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `delivery_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_bidding_id_foreign` FOREIGN KEY (`bidding_id`) REFERENCES `bidding` (`id`),
  ADD CONSTRAINT `order_detail_delivery_id_foreign` FOREIGN KEY (`delivery_id`) REFERENCES `delivery` (`id`),
  ADD CONSTRAINT `order_detail_gardening_id_foreign` FOREIGN KEY (`gardening_id`) REFERENCES `gardening_details` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_detail_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `order_detail_piping_id_foreign` FOREIGN KEY (`piping_id`) REFERENCES `piping_details` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_detail_plant_id_foreign` FOREIGN KEY (`plant_id`) REFERENCES `plant` (`id`),
  ADD CONSTRAINT `order_detail_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `order_detail_runner_id_foreign` FOREIGN KEY (`runner_id`) REFERENCES `runner_details` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_detail_wiring_id_foreign` FOREIGN KEY (`wiring_id`) REFERENCES `wiring_details` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_bidding_id_foreign` FOREIGN KEY (`bidding_id`) REFERENCES `bidding` (`id`),
  ADD CONSTRAINT `payment_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `payment_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `plant`
--
ALTER TABLE `plant`
  ADD CONSTRAINT `plant_cat_id_foreign` FOREIGN KEY (`cat_id`) REFERENCES `category` (`id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_cat_id_foreign` FOREIGN KEY (`cat_id`) REFERENCES `category` (`id`);

--
-- Constraints for table `vendors`
--
ALTER TABLE `vendors`
  ADD CONSTRAINT `vendors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_ratings`
--
ALTER TABLE `vendor_ratings`
  ADD CONSTRAINT `vendor_ratings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_ratings_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
