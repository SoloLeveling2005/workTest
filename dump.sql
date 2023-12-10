-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 10, 2023 at 12:59 PM
-- Server version: 8.0.24
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `news`
--
CREATE DATABASE IF NOT EXISTS `news` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `news`;

-- --------------------------------------------------------

--
-- Table structure for table `assessments`
--

CREATE TABLE `assessments` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `news_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assessments`
--

INSERT INTO `assessments` (`id`, `user_id`, `news_id`, `created_at`, `updated_at`) VALUES
(10, 2, 1, '2023-12-10 03:05:23', '2023-12-10 03:05:23');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `news_id` bigint UNSIGNED NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `news_id`, `text`, `created_at`, `updated_at`) VALUES
(10, 1, 1, 'Привет', '2023-12-10 02:38:19', '2023-12-10 02:38:19');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_12_07_062137_create_news_table', 1),
(6, '2023_12_07_062147_create_comments_table', 1),
(7, '2023_12_07_062154_create_assessments_table', 1),
(8, '2023_12_07_062158_create_wakes_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `user_id`, `title`, `img_url`, `text`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'title', 'images/6575598bacdb1.jpg', 'description', '2023-12-10 00:24:11', '2023-12-10 00:24:11', NULL),
(2, 1, 'title', 'images/65758195979be.png', 'title title title title title title title title title title title title title title title title title title', '2023-12-10 03:15:01', '2023-12-10 03:47:37', '2023-12-10 03:47:37'),
(3, 1, 'title 121', 'images/657581a9611da.jpg', 'title title title title title title title title title title title title title title title title title title', '2023-12-10 03:15:21', '2023-12-10 03:47:21', '2023-12-10 03:47:21'),
(4, 1, 'title qeqwe', 'images/657581b847906.jpg', 'title title title title title title title title title title title title title title title title title title', '2023-12-10 03:15:36', '2023-12-10 03:47:29', '2023-12-10 03:47:29'),
(5, 1, 'новая', 'images/6575897cca67d.jpeg', 'новость', '2023-12-10 03:48:44', '2023-12-10 03:56:11', '2023-12-10 03:56:11'),
(6, 1, '123', 'images/65758b584d8bb.jpg', '123', '2023-12-10 03:56:40', '2023-12-10 03:56:51', '2023-12-10 03:56:51');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'user', 'a6b1672c74e5ceaddad9d3b0e4c0b612698a8a2d5f6088b94ae20b38b9fce9c5', '[\"*\"]', '2023-12-10 02:38:19', NULL, '2023-12-10 00:23:55', '2023-12-10 02:38:19'),
(2, 'App\\Models\\User', 2, 'user 1', 'd696a00b224bd3cba6a566438d173da35d05a395ba00438ad80fb9fe215626fa', '[\"*\"]', '2023-12-10 03:05:23', NULL, '2023-12-10 02:40:00', '2023-12-10 03:05:23'),
(3, 'App\\Models\\User', 1, 'user', 'cf176d48a616663330c656c7f1c65de25324a487fd1a909b27fcf958de0592d7', '[\"*\"]', '2023-12-10 03:49:00', NULL, '2023-12-10 03:07:17', '2023-12-10 03:49:00'),
(4, 'App\\Models\\User', 1, 'user', '6a55f73a5a8936e3cfba17931dbfa56384c5daaebf7db5c13ed2a3052fd7ec2f', '[\"*\"]', '2023-12-10 03:58:31', NULL, '2023-12-10 03:50:28', '2023-12-10 03:58:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `login` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `created_at`, `updated_at`) VALUES
(1, 'user', '$2y$10$ZNxeGPoCmh0eHOq4R.bnDeOx0xQOrdncUWFPXQP.dIT51e7nX0RNO', '2023-12-10 00:23:54', '2023-12-10 00:23:54'),
(2, 'user 1', '$2y$10$Lkjsu.qMBAeuVUQFWF.g3eJqXcG21KUjXtP9Xqp0U/XoytjMioLwe', '2023-12-10 02:40:00', '2023-12-10 02:40:00');

-- --------------------------------------------------------

--
-- Table structure for table `wakes`
--

CREATE TABLE `wakes` (
  `id` bigint UNSIGNED NOT NULL,
  `news_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wakes`
--

INSERT INTO `wakes` (`id`, `news_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-12-10 00:24:17', '2023-12-10 00:24:17'),
(2, 1, '2023-12-10 00:24:57', '2023-12-10 00:24:57'),
(3, 1, '2023-12-10 00:25:06', '2023-12-10 00:25:06'),
(4, 1, '2023-12-10 00:25:11', '2023-12-10 00:25:11'),
(5, 1, '2023-12-10 00:26:58', '2023-12-10 00:26:58'),
(6, 1, '2023-12-10 01:45:29', '2023-12-10 01:45:29'),
(7, 1, '2023-12-10 01:46:06', '2023-12-10 01:46:06'),
(8, 1, '2023-12-10 01:46:35', '2023-12-10 01:46:35'),
(9, 1, '2023-12-10 01:47:57', '2023-12-10 01:47:57'),
(10, 1, '2023-12-10 01:48:19', '2023-12-10 01:48:19'),
(11, 1, '2023-12-10 01:49:19', '2023-12-10 01:49:19'),
(12, 1, '2023-12-10 01:49:21', '2023-12-10 01:49:21'),
(13, 1, '2023-12-10 01:53:06', '2023-12-10 01:53:06'),
(14, 1, '2023-12-10 01:53:49', '2023-12-10 01:53:49'),
(15, 1, '2023-12-10 01:55:13', '2023-12-10 01:55:13'),
(16, 1, '2023-12-10 01:56:34', '2023-12-10 01:56:34'),
(17, 1, '2023-12-10 01:56:35', '2023-12-10 01:56:35'),
(18, 1, '2023-12-10 01:57:09', '2023-12-10 01:57:09'),
(19, 1, '2023-12-10 01:57:25', '2023-12-10 01:57:25'),
(20, 1, '2023-12-10 01:57:54', '2023-12-10 01:57:54'),
(21, 1, '2023-12-10 02:00:11', '2023-12-10 02:00:11'),
(22, 1, '2023-12-10 02:00:56', '2023-12-10 02:00:56'),
(23, 1, '2023-12-10 02:01:40', '2023-12-10 02:01:40'),
(24, 1, '2023-12-10 02:02:11', '2023-12-10 02:02:11'),
(25, 1, '2023-12-10 02:02:24', '2023-12-10 02:02:24'),
(26, 1, '2023-12-10 02:03:59', '2023-12-10 02:03:59'),
(27, 1, '2023-12-10 02:04:26', '2023-12-10 02:04:26'),
(28, 1, '2023-12-10 02:05:03', '2023-12-10 02:05:03'),
(29, 1, '2023-12-10 02:05:05', '2023-12-10 02:05:05'),
(30, 1, '2023-12-10 02:05:29', '2023-12-10 02:05:29'),
(31, 1, '2023-12-10 02:06:20', '2023-12-10 02:06:20'),
(32, 1, '2023-12-10 02:07:07', '2023-12-10 02:07:07'),
(33, 1, '2023-12-10 02:08:01', '2023-12-10 02:08:01'),
(34, 1, '2023-12-10 02:08:26', '2023-12-10 02:08:26'),
(35, 1, '2023-12-10 02:37:59', '2023-12-10 02:37:59'),
(36, 1, '2023-12-10 02:38:37', '2023-12-10 02:38:37'),
(37, 1, '2023-12-10 02:38:45', '2023-12-10 02:38:45'),
(38, 1, '2023-12-10 02:40:06', '2023-12-10 02:40:06'),
(39, 1, '2023-12-10 02:51:17', '2023-12-10 02:51:17'),
(40, 1, '2023-12-10 02:52:34', '2023-12-10 02:52:34'),
(41, 1, '2023-12-10 02:53:07', '2023-12-10 02:53:07'),
(42, 1, '2023-12-10 02:56:29', '2023-12-10 02:56:29'),
(43, 1, '2023-12-10 02:57:10', '2023-12-10 02:57:10'),
(44, 1, '2023-12-10 02:57:14', '2023-12-10 02:57:14'),
(45, 1, '2023-12-10 02:57:20', '2023-12-10 02:57:20'),
(46, 1, '2023-12-10 02:57:42', '2023-12-10 02:57:42'),
(47, 1, '2023-12-10 02:58:20', '2023-12-10 02:58:20'),
(48, 1, '2023-12-10 02:59:03', '2023-12-10 02:59:03'),
(49, 1, '2023-12-10 03:00:31', '2023-12-10 03:00:31'),
(50, 1, '2023-12-10 03:01:13', '2023-12-10 03:01:13'),
(51, 1, '2023-12-10 03:01:22', '2023-12-10 03:01:22'),
(52, 1, '2023-12-10 03:02:01', '2023-12-10 03:02:01'),
(53, 1, '2023-12-10 03:03:48', '2023-12-10 03:03:48'),
(54, 1, '2023-12-10 03:05:53', '2023-12-10 03:05:53'),
(55, 1, '2023-12-10 03:06:35', '2023-12-10 03:06:35'),
(56, 1, '2023-12-10 03:07:08', '2023-12-10 03:07:08'),
(57, 1, '2023-12-10 03:07:19', '2023-12-10 03:07:19'),
(58, 1, '2023-12-10 03:07:38', '2023-12-10 03:07:38'),
(59, 1, '2023-12-10 03:08:10', '2023-12-10 03:08:10'),
(60, 1, '2023-12-10 03:08:58', '2023-12-10 03:08:58'),
(61, 1, '2023-12-10 03:09:03', '2023-12-10 03:09:03'),
(62, 1, '2023-12-10 03:10:19', '2023-12-10 03:10:19'),
(63, 1, '2023-12-10 03:12:32', '2023-12-10 03:12:32'),
(64, 5, '2023-12-10 03:48:59', '2023-12-10 03:48:59'),
(65, 5, '2023-12-10 03:50:06', '2023-12-10 03:50:06'),
(66, 5, '2023-12-10 03:50:11', '2023-12-10 03:50:11'),
(67, 5, '2023-12-10 03:50:18', '2023-12-10 03:50:18'),
(68, 5, '2023-12-10 03:50:19', '2023-12-10 03:50:19'),
(69, 1, '2023-12-10 03:58:27', '2023-12-10 03:58:27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessments`
--
ALTER TABLE `assessments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessments_user_id_foreign` (`user_id`),
  ADD KEY `assessments_news_id_foreign` (`news_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_foreign` (`user_id`),
  ADD KEY `comments_news_id_foreign` (`news_id`);

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
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_user_id_foreign` (`user_id`);

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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_login_unique` (`login`);

--
-- Indexes for table `wakes`
--
ALTER TABLE `wakes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wakes_news_id_foreign` (`news_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assessments`
--
ALTER TABLE `assessments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `wakes`
--
ALTER TABLE `wakes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assessments`
--
ALTER TABLE `assessments`
  ADD CONSTRAINT `assessments_news_id_foreign` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `assessments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_news_id_foreign` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `wakes`
--
ALTER TABLE `wakes`
  ADD CONSTRAINT `wakes_news_id_foreign` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
