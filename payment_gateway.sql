-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 31 Okt 2021 pada 14.58
-- Versi server: 10.4.8-MariaDB
-- Versi PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `payment_gateway`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2021_10_27_095523_create_users_table', 1),
(2, '2021_10_27_100039_create_transactions_table', 1),
(3, '2021_10_31_064849_create_transaction_details_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `bank` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `va_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_key` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biller_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `merchant_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gross_amount` int(11) NOT NULL,
  `currency` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_time` datetime NOT NULL,
  `transaction_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fraud_status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `others_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `bank`, `va_number`, `bill_key`, `biller_code`, `transaction_id`, `order_id`, `merchant_id`, `gross_amount`, `currency`, `payment_type`, `transaction_time`, `transaction_status`, `fraud_status`, `store`, `payment_code`, `redirect_url`, `others_data`, `created_at`, `updated_at`) VALUES
(1, 1, 'bca', '89901983545', NULL, NULL, 'ac64a485-b3b3-463d-acce-035e19c33fbb', 'order-211031071056', 'G488889901', 35000, 'IDR', 'bank_transfer', '2021-10-31 14:10:55', 'pending', 'accept', NULL, NULL, NULL, NULL, '2021-10-31 07:10:56', '2021-10-31 07:10:56'),
(2, 1, 'mandiri', NULL, '621099155663', '70012', '5a8a1ba3-c9b7-400c-897c-6e739ee74521', 'order-211031071133', 'G488889901', 35000, 'IDR', 'echannel', '2021-10-31 14:11:32', 'pending', 'accept', NULL, NULL, NULL, NULL, '2021-10-31 07:11:34', '2021-10-31 07:11:34'),
(3, 1, 'bni', '9888990154955749', NULL, NULL, '739aef67-a985-4278-b9ec-2eb6005a1630', 'order-211031071153', 'G488889901', 35000, 'IDR', 'bank_transfer', '2021-10-31 14:11:52', 'pending', 'accept', NULL, NULL, NULL, NULL, '2021-10-31 07:11:54', '2021-10-31 07:11:54'),
(4, 1, 'permata', '899005454026755', NULL, NULL, '86e94574-0b59-4709-8445-2dd9b4d485a4', 'order-211031071157', 'G488889901', 35000, 'IDR', 'bank_transfer', '2021-10-31 14:11:56', 'pending', 'accept', NULL, NULL, NULL, NULL, '2021-10-31 07:11:59', '2021-10-31 07:11:59'),
(5, 1, NULL, NULL, NULL, NULL, '90a3a3c9-0a76-40ef-9e18-766df891ad55', 'order-211031072208', 'G488889901', 35000, 'IDR', 'bca_klikpay', '2021-10-31 14:22:10', 'pending', 'accept', NULL, NULL, 'https://api.sandbox.veritrans.co.id/v3/bca/klikpay/redirect/90a3a3c9-0a76-40ef-9e18-766df891ad55', '{\"url\":\"https:\\/\\/simulator.sandbox.midtrans.com\\/bca\\/klikpay\\/index\",\"method\":\"post\",\"params\":{\"klikPayCode\":\"03KHAN488889901\",\"transactionNo\":\"208423\",\"totalAmount\":\"35000\",\"currency\":\"IDR\",\"payType\":\"01\",\"callback\":\"?id=90a3a3c9-0a76-40ef-9e18-766df891ad55\",\"transactionDate\":\"31\\/10\\/2021 14:22:10\",\"descp\":\"Pembelian Barang\",\"miscFee\":\"0.00\",\"signature\":\"814509859\"}}', '2021-10-31 07:22:13', '2021-10-31 07:22:13'),
(6, 1, NULL, NULL, NULL, NULL, 'be8aaa48-af62-44b2-a586-c03cc82a6d2c', 'order-211031072245', 'G488889901', 35000, 'IDR', 'cimb_clicks', '2021-10-31 14:22:44', 'pending', NULL, NULL, NULL, 'https://api.sandbox.veritrans.co.id/cimb-clicks/request?id=be8aaa48-af62-44b2-a586-c03cc82a6d2c', NULL, '2021-10-31 07:22:45', '2021-10-31 07:22:45'),
(7, 1, NULL, NULL, NULL, NULL, 'bd88b533-32ad-4766-a268-708c02942802', 'order-211031072257', 'G488889901', 35000, 'IDR', 'gopay', '2021-10-31 14:22:57', 'pending', 'accept', NULL, NULL, NULL, '[{\"name\":\"generate-qr-code\",\"method\":\"GET\",\"url\":\"https:\\/\\/api.sandbox.veritrans.co.id\\/v2\\/gopay\\/bd88b533-32ad-4766-a268-708c02942802\\/qr-code\"},{\"name\":\"deeplink-redirect\",\"method\":\"GET\",\"url\":\"https:\\/\\/simulator.sandbox.midtrans.com\\/gopay\\/partner\\/app\\/payment-pin?id=59b3b30b-0bee-41d8-8cc6-c694fe3b26b8\"},{\"name\":\"get-status\",\"method\":\"GET\",\"url\":\"https:\\/\\/api.sandbox.veritrans.co.id\\/v2\\/bd88b533-32ad-4766-a268-708c02942802\\/status\"},{\"name\":\"cancel\",\"method\":\"POST\",\"url\":\"https:\\/\\/api.sandbox.veritrans.co.id\\/v2\\/bd88b533-32ad-4766-a268-708c02942802\\/cancel\"}]', '2021-10-31 07:22:59', '2021-10-31 07:22:59'),
(8, 1, NULL, NULL, NULL, NULL, '44eaf2aa-2762-4da9-a953-b749ae81eeac', 'order-211031072300', 'G488889901', 35000, 'IDR', 'danamon_online', '2021-10-31 14:23:02', 'pending', 'accept', NULL, NULL, 'https://api.sandbox.veritrans.co.id/v2/danamon/online/redirect/44eaf2aa-2762-4da9-a953-b749ae81eeac', NULL, '2021-10-31 07:23:04', '2021-10-31 07:23:04'),
(9, 1, NULL, NULL, NULL, NULL, 'c41c9b5d-ce61-4531-9082-3f560138793c', 'order-211031072307', 'G488889901', 35000, 'IDR', 'cstore', '2021-10-31 14:23:07', 'pending', NULL, 'indomaret', '155691977176', NULL, NULL, '2021-10-31 07:23:09', '2021-10-31 07:23:09'),
(10, 1, NULL, NULL, NULL, NULL, '1219a62d-6dcc-45b1-a7c7-c0bd651cd428', 'order-211031072311', 'G488889901', 35000, 'IDR', 'cstore', '2021-10-31 14:23:10', 'pending', 'accept', 'alfamart', '4888594202608303', NULL, NULL, '2021-10-31 07:23:11', '2021-10-31 07:23:11'),
(11, 1, NULL, NULL, NULL, NULL, '45e7f1e8-3c8e-443d-bfdc-22d2f6f0c54b', 'order-211031072317', 'G488889901', 50000, 'IDR', 'akulaku', '2021-10-31 14:23:16', 'pending', 'accept', NULL, NULL, 'https://api.sandbox.midtrans.com/v2/akulaku/redirect/45e7f1e8-3c8e-443d-bfdc-22d2f6f0c54b', NULL, '2021-10-31 07:23:17', '2021-10-31 07:23:17'),
(12, 2, 'bni', '9888990132499642', NULL, NULL, 'c476efef-475d-4dcc-8bce-cc063c7538f3', 'order-211031075742', 'G488889901', 35000, 'IDR', 'bank_transfer', '2021-10-31 14:57:42', 'pending', 'accept', NULL, NULL, NULL, NULL, '2021-10-31 07:57:43', '2021-10-31 07:57:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaction_details`
--

CREATE TABLE `transaction_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_price` int(11) NOT NULL,
  `item_qty` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transaction_details`
--

INSERT INTO `transaction_details` (`id`, `transaction_id`, `item_id`, `item_name`, `item_price`, `item_qty`, `created_at`, `updated_at`) VALUES
(1, 'ac64a485-b3b3-463d-acce-035e19c33fbb', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:10:56', '2021-10-31 07:10:56'),
(2, 'ac64a485-b3b3-463d-acce-035e19c33fbb', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:10:56', '2021-10-31 07:10:56'),
(3, '5a8a1ba3-c9b7-400c-897c-6e739ee74521', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:11:34', '2021-10-31 07:11:34'),
(4, '5a8a1ba3-c9b7-400c-897c-6e739ee74521', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:11:34', '2021-10-31 07:11:34'),
(5, '739aef67-a985-4278-b9ec-2eb6005a1630', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:11:54', '2021-10-31 07:11:54'),
(6, '739aef67-a985-4278-b9ec-2eb6005a1630', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:11:54', '2021-10-31 07:11:54'),
(7, '86e94574-0b59-4709-8445-2dd9b4d485a4', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:11:59', '2021-10-31 07:11:59'),
(8, '86e94574-0b59-4709-8445-2dd9b4d485a4', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:11:59', '2021-10-31 07:11:59'),
(9, '90a3a3c9-0a76-40ef-9e18-766df891ad55', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:22:13', '2021-10-31 07:22:13'),
(10, '90a3a3c9-0a76-40ef-9e18-766df891ad55', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:22:13', '2021-10-31 07:22:13'),
(11, 'be8aaa48-af62-44b2-a586-c03cc82a6d2c', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:22:45', '2021-10-31 07:22:45'),
(12, 'be8aaa48-af62-44b2-a586-c03cc82a6d2c', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:22:45', '2021-10-31 07:22:45'),
(13, 'bd88b533-32ad-4766-a268-708c02942802', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:22:59', '2021-10-31 07:22:59'),
(14, 'bd88b533-32ad-4766-a268-708c02942802', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:22:59', '2021-10-31 07:22:59'),
(15, '44eaf2aa-2762-4da9-a953-b749ae81eeac', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:23:04', '2021-10-31 07:23:04'),
(16, '44eaf2aa-2762-4da9-a953-b749ae81eeac', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:23:04', '2021-10-31 07:23:04'),
(17, 'c41c9b5d-ce61-4531-9082-3f560138793c', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:23:09', '2021-10-31 07:23:09'),
(18, 'c41c9b5d-ce61-4531-9082-3f560138793c', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:23:09', '2021-10-31 07:23:09'),
(19, '1219a62d-6dcc-45b1-a7c7-c0bd651cd428', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:23:11', '2021-10-31 07:23:11'),
(20, '1219a62d-6dcc-45b1-a7c7-c0bd651cd428', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:23:11', '2021-10-31 07:23:11'),
(21, '45e7f1e8-3c8e-443d-bfdc-22d2f6f0c54b', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:23:17', '2021-10-31 07:23:17'),
(22, '45e7f1e8-3c8e-443d-bfdc-22d2f6f0c54b', 'item2', 'Celana Jeans', 15000, 2, '2021-10-31 07:23:17', '2021-10-31 07:23:17'),
(23, 'c476efef-475d-4dcc-8bce-cc063c7538f3', 'item1', 'Kemeja Pria', 10000, 2, '2021-10-31 07:57:43', '2021-10-31 07:57:43'),
(24, 'c476efef-475d-4dcc-8bce-cc063c7538f3', 'item2', 'Celana Jeans', 15000, 1, '2021-10-31 07:57:43', '2021-10-31 07:57:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `password`, `api_token`, `created_at`, `updated_at`) VALUES
(1, 'Nikko', 'Febika', '085691977176', 'admin@gmail.com', '$2y$10$RAMcOVSCl3eULs0EakUCmek9mCoLoDxNzBW8AyVogR1paHCCu54uO', 'VTdvcFdOSlFuRFY2QlNpVzJTNnN6ZDhwb0pZaEJ4TlczaVA1dFZZTw==', '2021-10-31 07:06:28', '2021-10-31 07:06:28'),
(2, 'Agus', 'Wijaya', '081519921100', 'agus@gmail.com', '$2y$10$OuDjugVhMqdPsoFJLqy3g.M6HoGYWEk0sXMG/R3.nQKMrRYzzMUgO', 'b2o4ekFsZlBSZ1FXNm5CSm9HSWp6THIxbWhIcXo3bHBYN21kZVY1WQ==', '2021-10-31 07:55:29', '2021-10-31 07:56:06');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transactions_transaction_id_unique` (`transaction_id`),
  ADD UNIQUE KEY `transactions_order_id_unique` (`order_id`);

--
-- Indeks untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
