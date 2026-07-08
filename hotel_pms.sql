-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th7 08, 2026 lúc 07:08 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `hotel_pms`
--
CREATE DATABASE IF NOT EXISTS `hotel_pms` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hotel_pms`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bookers`
--

CREATE TABLE `bookers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Tên người đặt',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `phone` varchar(50) DEFAULT NULL COMMENT 'Số điện thoại',
  `address` varchar(255) DEFAULT NULL COMMENT 'Địa chỉ',
  `notes` text DEFAULT NULL COMMENT 'Ghi chú',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `bookers`
--

INSERT INTO `bookers` (`id`, `name`, `email`, `phone`, `address`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'MR. BÌNH', NULL, '0915768835', NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(2, 'MR TRƯỜNG', NULL, '0973751814', NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(3, 'MS Liên', NULL, '0984030395', NULL, NULL, '2026-07-02 06:04:23', '2026-07-08 03:08:44'),
(4, 'MS Thơm', NULL, NULL, NULL, NULL, '2026-07-02 06:04:23', '2026-07-08 03:09:05'),
(5, 'Nguyễn Thị Hà Sơn', 'Hasonnguyen7486@gmail.com', '0978912075', NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(6, 'MS LIỄU', NULL, '0908722336', NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `booking_code` varchar(50) NOT NULL COMMENT 'Mã đăng ký (Tạo tự động GAL + id)',
  `guest_name` varchar(255) NOT NULL COMMENT 'Tên đăng ký',
  `check_in` date NOT NULL COMMENT 'Ngày đến',
  `check_out` date NOT NULL COMMENT 'Ngày đi',
  `nights` int(11) DEFAULT 0 COMMENT 'Số đêm',
  `status_id` int(11) DEFAULT NULL COMMENT 'Khóa ngoại tới Trạng thái',
  `confirmed_date` date DEFAULT NULL COMMENT 'Ngày xác nhận',
  `company_code` varchar(50) DEFAULT NULL COMMENT 'Khóa ngoại tới Công ty',
  `member_company_id` int(11) DEFAULT NULL COMMENT 'Khóa ngoại tới Công ty thành viên',
  `management_department_code` varchar(50) DEFAULT NULL COMMENT 'Mã Phòng ban quản lý',
  `payment_method_code` varchar(50) DEFAULT NULL COMMENT 'Phương thức thanh toán',
  `reference_code` varchar(100) DEFAULT NULL COMMENT 'Mã tham chiếu',
  `deposit` decimal(15,2) DEFAULT 0.00 COMMENT 'Đặt cọc',
  `seller` varchar(255) DEFAULT NULL COMMENT 'Người bán',
  `remaining_debt` decimal(15,2) DEFAULT 0.00 COMMENT 'Công nợ còn lại',
  `market_segment_code` varchar(50) DEFAULT NULL COMMENT 'Thị trường',
  `booking_source_code` varchar(50) DEFAULT NULL COMMENT 'Nguồn khách',
  `booker_id` int(11) DEFAULT NULL COMMENT 'Người đặt phòng',
  `notes` text DEFAULT NULL COMMENT 'Ghi chú',
  `special_requests` text DEFAULT NULL COMMENT 'Yêu cầu đặc biệt (BK Confirm)',
  `is_git` tinyint(1) DEFAULT 0 COMMENT 'GIT toggle',
  `is_vat` tinyint(1) DEFAULT 0 COMMENT 'VAT toggle',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `booking_color` varchar(20) DEFAULT '#60a5fa' COMMENT 'Màu sắc hiển thị của booking trên Room Map'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `bookings`
--

INSERT INTO `bookings` (`id`, `booking_code`, `guest_name`, `check_in`, `check_out`, `nights`, `status_id`, `confirmed_date`, `company_code`, `member_company_id`, `management_department_code`, `payment_method_code`, `reference_code`, `deposit`, `seller`, `remaining_debt`, `market_segment_code`, `booking_source_code`, `booker_id`, `notes`, `special_requests`, `is_git`, `is_vat`, `created_at`, `updated_at`, `booking_color`) VALUES
(1, 'GAL1', 'Nguyễn Văn A', '2026-06-24', '2026-06-29', 5, 1, '2026-06-24', 'CTY0001', NULL, NULL, 'CA', '24110011', 0.00, 'Demo', 0.00, 'FIT', 'FIT', 2, NULL, NULL, 0, 0, '2026-07-02 06:04:23', '2026-07-02 06:04:23', '#60a5fa');

--
-- Bẫy `bookings`
--
DELIMITER $$
CREATE TRIGGER `trg_bookings_before_insert` BEFORE INSERT ON `bookings` FOR EACH ROW BEGIN
    IF @next_booking_id IS NULL THEN
        SELECT AUTO_INCREMENT INTO @next_booking_id
        FROM information_schema.tables
        WHERE table_name = 'bookings' AND table_schema = DATABASE();
    END IF;
    
    IF NEW.booking_code IS NULL OR NEW.booking_code = '' THEN
        SET NEW.booking_code = CONCAT('GAL', @next_booking_id);
        SET @next_booking_id = @next_booking_id + 1;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `booking_rooms`
--

CREATE TABLE `booking_rooms` (
  `id` int(11) NOT NULL,
  `booking_code` varchar(50) NOT NULL COMMENT 'Khóa ngoại tới Bookings',
  `room_type_id` int(11) DEFAULT NULL COMMENT 'Khóa ngoại tới Room Types',
  `room_form_id` int(11) DEFAULT NULL COMMENT 'Khóa ngoại tới Room Forms',
  `room_code` varchar(50) DEFAULT NULL COMMENT 'Khóa ngoại tới Rooms (Mã phòng)',
  `check_in` date NOT NULL COMMENT 'Ngày đến của phòng',
  `check_out` date NOT NULL COMMENT 'Ngày đi của phòng',
  `nights` int(11) DEFAULT 0 COMMENT 'Đêm',
  `price` decimal(15,2) DEFAULT 0.00 COMMENT 'Giá phòng',
  `rate_plan_code` varchar(50) DEFAULT NULL COMMENT 'Mã giá phòng',
  `discount` decimal(15,2) DEFAULT 0.00 COMMENT 'Giảm/tăng giá',
  `guest_name` varchar(255) DEFAULT NULL COMMENT 'Tên khách',
  `adults` int(11) DEFAULT 0 COMMENT 'N.Lớn',
  `children` int(11) DEFAULT 0 COMMENT 'Trẻ em',
  `infants` int(11) DEFAULT 0 COMMENT 'Em bé',
  `child_breakfast_price` decimal(15,2) DEFAULT 0.00 COMMENT 'Giá ăn sáng trẻ em',
  `includes_breakfast` tinyint(1) DEFAULT 0 COMMENT 'Ăn sáng',
  `extra_bed` tinyint(1) DEFAULT 0 COMMENT 'Thêm giường',
  `extra_bed_price` decimal(15,2) DEFAULT 0.00 COMMENT 'Giá thêm giường',
  `hourly_rental` tinyint(1) DEFAULT 0 COMMENT 'Ở theo giờ',
  `special_requests` text DEFAULT NULL COMMENT 'Yêu cầu đặc biệt',
  `arrival_time` time DEFAULT NULL COMMENT 'Giờ đến',
  `departure_time` time DEFAULT NULL COMMENT 'Giờ đi',
  `reserved` tinyint(1) DEFAULT 0 COMMENT 'Đặt trước',
  `is_priority` tinyint(1) DEFAULT 0 COMMENT 'Ưu tiên (Icon cờ đỏ)',
  `is_priority_charge` tinyint(1) DEFAULT 0 COMMENT 'Ưu tiên tính phí (Icon ghim đen)',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'LP Khởi tạo',
  `transfer_room` varchar(255) DEFAULT NULL COMMENT 'Phòng chuyển',
  `room_status` varchar(100) DEFAULT NULL COMMENT 'Trạng thái phòng',
  `alm_code` varchar(100) DEFAULT NULL COMMENT 'Mã ALM',
  `total_amount` decimal(15,2) DEFAULT 0.00 COMMENT 'Tổng cộng',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `booking_rooms`
--

INSERT INTO `booking_rooms` (`id`, `booking_code`, `room_type_id`, `room_form_id`, `room_code`, `check_in`, `check_out`, `nights`, `price`, `rate_plan_code`, `discount`, `guest_name`, `adults`, `children`, `infants`, `child_breakfast_price`, `includes_breakfast`, `extra_bed`, `extra_bed_price`, `hourly_rental`, `special_requests`, `arrival_time`, `departure_time`, `reserved`, `is_priority`, `is_priority_charge`, `created_by`, `transfer_room`, `room_status`, `alm_code`, `total_amount`, `created_at`, `updated_at`) VALUES
(1, 'GAL1', 2, 2, 'G110', '2026-06-24', '2026-06-29', 5, 670000.00, 'B2B', 0.00, 'Guest 1', 2, 0, 0, 90000.00, 1, 1, 300000.00, 0, NULL, '14:00:00', '12:00:00', 0, 0, 0, NULL, NULL, 'Vacant Dirty', 'G0019233', 4850000.00, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(2, 'GAL1', 8, 4, 'G49', '2026-06-24', '2026-06-29', 5, 1330000.00, 'B2B', 0.00, 'Guest 1', 2, 2, 0, 90000.00, 1, 0, 0.00, 0, NULL, '14:00:00', '12:00:00', 0, 0, 0, NULL, NULL, 'Vacant Ready', 'G0019232', 6650000.00, '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `booking_room_special_requests`
--

CREATE TABLE `booking_room_special_requests` (
  `id` int(11) NOT NULL,
  `booking_room_id` int(11) NOT NULL COMMENT 'Khóa ngoại tới Booking Rooms',
  `special_request_id` int(11) NOT NULL COMMENT 'Khóa ngoại tới Special Requests',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `booking_sources`
--

CREATE TABLE `booking_sources` (
  `code` varchar(50) NOT NULL COMMENT 'Mã nguồn khách',
  `name` varchar(255) NOT NULL COMMENT 'Tên nguồn khách',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `booking_sources`
--

INSERT INTO `booking_sources` (`code`, `name`, `created_at`, `updated_at`) VALUES
('BAT', 'Barter', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('CORP', 'Corporate', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('DAY', 'Day Use', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('FB', 'Fanpage', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('FIT', 'Free Individual Traveler', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('FOC', 'FOC', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('GIT', 'Group Individual Traveler', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('HU', 'House Use', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('OTA', 'Online Travel Agent', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('TA', 'Travel Agent', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('VC', 'Voucher', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('WK', 'Walk-In', '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `branches`
--

CREATE TABLE `branches` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Tên chi nhánh',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `branches`
--

INSERT INTO `branches` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Vĩnh Long', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(2, 'Hải Dương', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(3, 'Phú Thọ', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(4, 'Đắk Nông', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(5, 'Nghệ An', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(6, 'Ninh Thuận', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(7, 'TP.Hồ Chí Minh', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(8, 'Hà Nội', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(9, 'Đà Nẵng', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(10, 'Cần Thơ', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(11, 'Hải Phòng', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(12, 'Bà Rịa - Vũng Tàu', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(13, 'Lâm Đồng', '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `companies`
--

CREATE TABLE `companies` (
  `company_code` varchar(50) NOT NULL COMMENT 'Mã công ty',
  `name` varchar(255) NOT NULL COMMENT 'Tên công ty',
  `transaction_name` varchar(255) DEFAULT NULL COMMENT 'Tên giao dịch',
  `address` varchar(255) DEFAULT NULL COMMENT 'Địa chỉ',
  `tax_code` varchar(50) DEFAULT NULL COMMENT 'Mã số thuế',
  `phone` varchar(50) DEFAULT NULL COMMENT 'Số điện thoại',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `booking_source_code` varchar(50) DEFAULT NULL COMMENT 'Mã Nguồn khách',
  `market_segment_code` varchar(50) DEFAULT NULL COMMENT 'Mã Thị trường',
  `type` varchar(100) DEFAULT NULL COMMENT 'Loại công ty',
  `is_acc_synced` tinyint(1) DEFAULT 0 COMMENT 'Đồng bộ ACC',
  `max_debt` decimal(15,2) DEFAULT 0.00 COMMENT 'Công nợ tối đa',
  `bank_account` varchar(100) DEFAULT NULL COMMENT 'Tài khoản ngân hàng',
  `booker_name` varchar(255) DEFAULT NULL COMMENT 'Người đặt phòng',
  `rate_plan_code` varchar(50) DEFAULT NULL COMMENT 'Mã giá phòng',
  `business_field` varchar(255) DEFAULT NULL COMMENT 'Lĩnh vực hoạt động',
  `branch_id` int(11) DEFAULT NULL COMMENT 'Chi nhánh',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `companies`
--

INSERT INTO `companies` (`company_code`, `name`, `transaction_name`, `address`, `tax_code`, `phone`, `email`, `booking_source_code`, `market_segment_code`, `type`, `is_acc_synced`, `max_debt`, `bank_account`, `booker_name`, `rate_plan_code`, `business_field`, `branch_id`, `created_at`, `updated_at`) VALUES
('CTY0001', 'KHÁCH LẺ', 'KHÁCH LẺ', 'Khách hàng không lấy hoá đơn', NULL, NULL, NULL, 'FIT', 'FIT', NULL, 1, 0.00, NULL, NULL, NULL, NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('CTY0002', 'AGODA', 'AGODA', NULL, NULL, NULL, NULL, 'OTA', 'OTA', NULL, 0, 0.00, NULL, NULL, NULL, NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('CTY0003', 'BOOKING.COM', 'BOOKING.COM', NULL, NULL, NULL, NULL, 'OTA', 'OTA', NULL, 0, 0.00, NULL, NULL, NULL, NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('CTY0004', 'TRIP.COM', 'TRIP.COM', NULL, NULL, NULL, NULL, 'OTA', 'OTA', NULL, 0, 0.00, NULL, NULL, NULL, NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('CTY0005', 'EXPEDIA', 'EXPEDIA', NULL, NULL, NULL, NULL, 'OTA', 'OTA', NULL, 0, 0.00, NULL, NULL, NULL, NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('CTY0006', 'TRAVELOKA', 'TRAVELOKA', NULL, NULL, NULL, NULL, 'OTA', 'OTA', NULL, 0, 0.00, NULL, NULL, NULL, NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('CTY0007', 'HOTELBEDS', 'HOTELBEDS', NULL, NULL, NULL, NULL, 'OTA', 'OTA', NULL, 0, 0.00, NULL, NULL, NULL, NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('CTY0008', 'OHMYHOTEL', 'CÔNG TY TNHH OHMYHOTEL&CO VN', 'Khu F7-BCD, Tầng 7, Toà nhà Mach, 127 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.Hồ Chí Minh', NULL, '0314937097', NULL, 'OTA', 'OTA', NULL, 0, 0.00, NULL, NULL, NULL, NULL, NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `currencies`
--

CREATE TABLE `currencies` (
  `currency_code` varchar(10) NOT NULL COMMENT 'Mã tiền tệ (VD: VND, USD)',
  `image_url` varchar(255) DEFAULT NULL COMMENT 'Hình ảnh đại diện',
  `currency_name` varchar(255) NOT NULL COMMENT 'Tên loại tiền tệ',
  `country` varchar(255) DEFAULT NULL COMMENT 'Quốc gia',
  `is_primary` tinyint(1) DEFAULT 0 COMMENT 'Là tiền tệ chính (Base currency)',
  `is_active` tinyint(1) DEFAULT 1 COMMENT 'Trạng thái sử dụng',
  `decimal_places` int(11) DEFAULT 0 COMMENT 'Làm tròn chữ số thập phân',
  `exchange_rate` decimal(15,6) DEFAULT 1.000000 COMMENT 'Tỉ giá quy đổi',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `currencies`
--

INSERT INTO `currencies` (`currency_code`, `image_url`, `currency_name`, `country`, `is_primary`, `is_active`, `decimal_places`, `exchange_rate`, `created_at`, `updated_at`) VALUES
('VND', NULL, 'Viet Nam Dong', 'Vietnam', 1, 1, 0, 1.000000, '2026-07-02 06:04:22', '2026-07-02 06:04:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hotel_services`
--

CREATE TABLE `hotel_services` (
  `code` varchar(50) NOT NULL COMMENT 'Mã dịch vụ',
  `department_id` int(11) DEFAULT NULL COMMENT 'Khóa ngoại tới Bộ phận dịch vụ',
  `full_name` varchar(255) NOT NULL COMMENT 'Tên dịch vụ đầy đủ',
  `short_name` varchar(100) DEFAULT NULL COMMENT 'Tên ngắn',
  `description` text DEFAULT NULL COMMENT 'Mô tả chi tiết',
  `service_fee_percent` decimal(5,2) DEFAULT 0.00 COMMENT 'Phí phục vụ (%)',
  `tax_percent` decimal(5,2) DEFAULT 0.00 COMMENT 'Thuế (%)',
  `special_tax_percent` decimal(5,2) DEFAULT 0.00 COMMENT 'Thuế đặc biệt (%)',
  `includes_service_fee` tinyint(1) DEFAULT 0 COMMENT 'Bao gồm phí dịch vụ',
  `includes_tax` tinyint(1) DEFAULT 0 COMMENT 'Bao gồm thuế',
  `includes_special_tax` tinyint(1) DEFAULT 0 COMMENT 'Bao gồm thuế đặc biệt',
  `folio` int(11) DEFAULT 1 COMMENT 'Folio',
  `unit_code` varchar(50) DEFAULT NULL COMMENT 'Khóa ngoại tới bảng đơn vị tính',
  `price` decimal(15,2) DEFAULT 0.00 COMMENT 'Giá',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `hotel_services`
--

INSERT INTO `hotel_services` (`code`, `department_id`, `full_name`, `short_name`, `description`, `service_fee_percent`, `tax_percent`, `special_tax_percent`, `includes_service_fee`, `includes_tax`, `includes_special_tax`, `folio`, `unit_code`, `price`, `created_at`, `updated_at`) VALUES
('BC', 1, 'Ăn sáng buffet trẻ em', 'Ăn sáng trẻ em', NULL, 5.00, 8.00, 0.00, 1, 1, 0, 1, 'NG', 100000.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('BD', 2, 'Breakfast Child/Ăn Sáng Trẻ Em', 'Breakfast Child', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'NG', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('BF', 2, 'Ăn sáng buffet người lớn', 'Ăn sáng buffet', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'NG', 180000.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('BK', 2, 'Broken / Đổ vỡ', 'Broken / Đổ vỡ', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('BR', 3, 'Broken/Phí Hư Hỏng', 'Broken', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('DN', 2, 'Dinner / Ăn tối', 'Dinner / Ăn tối', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'NG', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('DO', 2, 'Drop off to the airport/ Tiễn sân bay', 'Drop off', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('EB', 2, 'Extrabed/Thêm Giường', 'Extrabed', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('EI', 2, 'Early Checkin/Phụ Thu Nhận Phòng Sớm', 'Early Checkin', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('EP', 2, 'Extra Person/ Phụ Thu Thêm Người', 'Extra Person', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('ER', 2, 'Extra RoomCharge / Phụ thu tiền phòng', 'Extra RoomCharge', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('FB', 1, 'Food and Beverage/ Dịch Vụ Ăn Uống', 'FB', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('GN', 2, 'Gala dinner / Tiệc họp mặt', 'Tiệc họp mặt', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('HN', 2, 'Tuần trăng mật', 'Tuần trăng mật', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('HT', 2, 'Refund/ Hoàn trả khách', 'Hoàn trả khách', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('KC', 2, 'Key card / Mất thẻ phòng', 'Key card', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('KI', 2, 'Kid Surcharge', 'Kid Surcharge', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('LA', 3, 'Laundry/Giặt Ủi', 'Laundry/Giặt Ủi', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('LH', 2, 'Lunch / Ăn trưa', 'Lunch / Ăn trưa', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'NG', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('LO', 2, 'Late Checkout/Phụ Thu Trả Phòng Trễ', 'Late Checkout', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('MB', 3, 'Minibar/Phí Minibar', 'Minibar', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('MR', 2, 'Meeting / Phòng họp', 'Meeting / Phòng họp', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('MS', 2, 'Other/Dịch Vụ Khác', 'Other', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('NB', 2, 'Giường Nội Bộ', 'Giường Nội Bộ', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('OT', 1, 'Dịch Vụ Khác (FB)', 'Dịch Vụ Khác NH', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('PU', 2, 'Pick up from the airport/ Đưa đón sân bay', 'Đưa đón sân bay', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('RB', 1, 'Beverage/ Thức uống', 'Beverage/ Thức uống', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('RF', 1, 'Food/ Thức ăn', 'Food/ Thức ăn', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('RM', 2, 'Dịch vụ phòng nghỉ', 'Dịch vụ phòng nghỉ', NULL, 5.00, 8.00, 0.00, 1, 1, 0, 1, 'DEM', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('TB', 2, 'Dịch vụ charge phòng nghỉ', 'Dịch vụ phòng nghỉ', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('TK', 2, 'Vé ăn sáng 90k', 'Vé ăn sáng 90k', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 90000.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('TO', 2, 'Tour/ Tham quan', 'Tour/ Tham quan', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('TW', 2, 'Charge tiền khăn biển', 'Khăn biển', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 250000.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('UP', 2, 'Upgrade/ Phí nâng hạng phòng', 'Phí nâng hạng phòng', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('VV', 5, 'VV', 'VV', NULL, 5.00, 10.00, 0.00, 1, 1, 1, 1, NULL, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('WS', 2, 'Dịch vụ đám cưới', 'Dịch vụ đám cưới', NULL, 5.00, 8.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('XM', 2, 'Thuê xe', 'Thuê xe', NULL, 5.00, 10.00, 0.00, 1, 1, 1, 1, 'DV', 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `management_departments`
--

CREATE TABLE `management_departments` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL COMMENT 'Mã phòng ban',
  `name` varchar(255) NOT NULL COMMENT 'Tên phòng ban',
  `is_active` tinyint(1) DEFAULT 1 COMMENT 'Sử dụng',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `management_departments`
--

INSERT INTO `management_departments` (`id`, `code`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'PND', 'PND', 0, '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `market_segments`
--

CREATE TABLE `market_segments` (
  `code` varchar(50) NOT NULL COMMENT 'Mã thị trường',
  `name` varchar(255) NOT NULL COMMENT 'Tên thị trường',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `market_segments`
--

INSERT INTO `market_segments` (`code`, `name`, `created_at`, `updated_at`) VALUES
('BAT', 'Barter', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('CORP', 'Corporate', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('DAY', 'Day Use', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('FB', 'Fanpage', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('FIT', 'Free Individual Traveler', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('FOC', 'FOC', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('GIT', 'Group Individual Traveler', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('HU', 'House Use', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('OTA', 'Online Travel Agent', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('TA', 'Travel Agent', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('VC', 'Voucher', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
('WK', 'Walk-In', '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `member_companies`
--

CREATE TABLE `member_companies` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Tên công ty thành viên',
  `notes` text DEFAULT NULL COMMENT 'Ghi chú',
  `is_active` tinyint(1) DEFAULT 1 COMMENT 'Sử dụng',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `member_companies`
--

INSERT INTO `member_companies` (`id`, `name`, `notes`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'CNTT', NULL, 1, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(2, 'HT', NULL, 0, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(3, 'XNCG', NULL, 1, '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_methods`
--

CREATE TABLE `payment_methods` (
  `payment_code` varchar(50) NOT NULL COMMENT 'Mã hình thức thanh toán',
  `payment_name` varchar(255) NOT NULL COMMENT 'Tên hình thức',
  `account_number` varchar(100) DEFAULT NULL COMMENT 'Tài khoản',
  `account_name` varchar(255) DEFAULT NULL COMMENT 'Tên tài khoản',
  `bank_name` varchar(255) DEFAULT NULL COMMENT 'Tên ngân hàng',
  `payment_service_fee` decimal(5,2) DEFAULT 0.00 COMMENT 'Phí phục vụ (%)',
  `is_complimentary` tinyint(1) DEFAULT 0 COMMENT 'HT Miễn Phí (Hình thức miễn phí)',
  `is_inactive` tinyint(1) DEFAULT 0 COMMENT 'Không sử dụng',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `payment_methods`
--

INSERT INTO `payment_methods` (`payment_code`, `payment_name`, `account_number`, `account_name`, `bank_name`, `payment_service_fee`, `is_complimentary`, `is_inactive`, `created_at`, `updated_at`) VALUES
('AC', 'City ledger', '', '', 'City ledger', 0.00, 0, 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('BT', 'Bank transfer', '', '', 'Bank transfer', 0.00, 0, 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('CA', 'Cash', '', '', 'Cash', 0.00, 0, 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('CL', 'Complimentary', '', '', 'Complimentary', 0.00, 1, 1, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('VO', 'Voucher', '', '', 'Voucher', 0.00, 0, 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_method_departments`
--

CREATE TABLE `payment_method_departments` (
  `payment_method_code` varchar(50) NOT NULL COMMENT 'Khóa ngoại tới Payment Methods',
  `department_id` int(11) NOT NULL COMMENT 'Khóa ngoại tới Service Departments'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `payment_method_departments`
--

INSERT INTO `payment_method_departments` (`payment_method_code`, `department_id`) VALUES
('BT', 1),
('BT', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rate_plans`
--

CREATE TABLE `rate_plans` (
  `plan_code` varchar(50) NOT NULL COMMENT 'Mã giá (VD: B2B, FOC, ST)',
  `plan_description` varchar(255) DEFAULT NULL COMMENT 'Mô tả',
  `currency_code` varchar(10) DEFAULT 'VND' COMMENT 'Khóa ngoại Tiền tệ',
  `date_from` date NOT NULL COMMENT 'Ngày bắt đầu áp dụng',
  `date_to` date NOT NULL COMMENT 'Ngày kết thúc áp dụng',
  `is_daily_rate` tinyint(1) DEFAULT 1 COMMENT 'Giá theo ngày',
  `is_inactive` tinyint(1) DEFAULT 0 COMMENT 'Không sử dụng',
  `allow_rate_input` tinyint(1) DEFAULT 1 COMMENT 'Cho phép nhập giá',
  `push_channel_manager` tinyint(1) DEFAULT 0 COMMENT 'Đẩy lên Channel Manager',
  `includes_breakfast` tinyint(1) DEFAULT 0 COMMENT 'Bao gồm ăn sáng',
  `apply_days` varchar(50) DEFAULT 'T2,T3,T4,T5,T6,T7,CN' COMMENT 'Các ngày trong tuần được áp dụng',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `rate_plans`
--

INSERT INTO `rate_plans` (`plan_code`, `plan_description`, `currency_code`, `date_from`, `date_to`, `is_daily_rate`, `is_inactive`, `allow_rate_input`, `push_channel_manager`, `includes_breakfast`, `apply_days`, `created_at`, `updated_at`) VALUES
('B2B', 'B2B', 'VND', '2025-05-20', '2026-12-31', 1, 0, 1, 0, 0, 'T2,T3,T4,T5,T6,T7,CN', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('FOC', 'FOC', 'VND', '2025-02-06', '2026-02-01', 1, 0, 1, 0, 0, 'T2,T3,T4,T5,T6,T7,CN', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('ROB2B', 'RO-B2B', 'VND', '2026-01-02', '2026-12-31', 1, 0, 1, 0, 0, 'T2,T3,T4,T5,T6,T7,CN', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('ROBAR', 'RO-BAR', 'VND', '2026-01-02', '2026-12-31', 1, 0, 1, 0, 0, 'T2,T3,T4,T5,T6,T7,CN', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('ST', 'BAR', 'VND', '2025-01-01', '2026-12-31', 1, 0, 1, 0, 0, 'T2,T3,T4,T5,T6,T7,CN', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('TEST', 'TEST', 'VND', '2026-06-24', '2026-08-31', 1, 0, 1, 0, 0, 'T2,T3,T4,T5,T6,T7,CN', '2026-07-02 06:04:22', '2026-07-02 06:04:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rate_seasons`
--

CREATE TABLE `rate_seasons` (
  `id` int(11) NOT NULL,
  `season_code` varchar(50) NOT NULL COMMENT 'Mã mùa/kỳ giá (VD: BB1, BB2, BB3)',
  `rate_plan_code` varchar(50) NOT NULL COMMENT 'Khóa ngoại tới bảng rate_plans',
  `season_description` varchar(255) DEFAULT NULL COMMENT 'Mô tả mùa/kỳ (VD: Cao điểm, Thấp điểm)',
  `date_from` date NOT NULL COMMENT 'Ngày bắt đầu mùa/kỳ',
  `date_to` date NOT NULL COMMENT 'Ngày kết thúc mùa/kỳ',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `rate_seasons`
--

INSERT INTO `rate_seasons` (`id`, `season_code`, `rate_plan_code`, `season_description`, `date_from`, `date_to`, `created_at`, `updated_at`) VALUES
(1, 'BB-PH3', 'B2B', '31/12/2025', '2025-12-31', '2025-12-31', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(2, 'BB1', 'B2B', 'KM 1/1 - 28/4', '2026-01-01', '2026-12-31', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(3, 'BB1N', 'B2B', 'KM 8/1 - 15/2', '2025-05-20', '2025-12-31', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(4, 'BB2', 'B2B', '1/6 - 31/12/2025', '2025-06-01', '2025-12-31', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(5, 'BB3', 'B2B', 'Cao điểm', '2026-01-01', '2026-12-31', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(6, 'BB4', 'B2B', 'PH KM 1/1-28/4/2026', '2026-01-01', '2026-12-31', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(7, 'BB5', 'B2B', 'Thấp điểm', '2026-01-01', '2026-12-31', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(8, 'BB6', 'B2B', 'PH Thấp điểm', '2026-01-01', '2026-12-31', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(9, 'BB7', 'B2B', 'Pricing_Feb', '2026-01-01', '2026-12-31', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(10, 'BBUS', 'B2B', 'BB UPSELL', '2026-01-01', '2026-12-31', '2026-07-02 06:04:22', '2026-07-02 06:04:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rate_season_prices`
--

CREATE TABLE `rate_season_prices` (
  `id` int(11) NOT NULL,
  `rate_season_id` int(11) NOT NULL COMMENT 'Khóa ngoại tới bảng rate_seasons',
  `room_type_id` int(11) NOT NULL COMMENT 'Khóa ngoại tới bảng room_types',
  `room_form_id` int(11) NOT NULL COMMENT 'Khóa ngoại tới bảng room_forms',
  `price` decimal(15,2) DEFAULT 0.00 COMMENT 'Giá phòng',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `rate_season_prices`
--

INSERT INTO `rate_season_prices` (`id`, `rate_season_id`, `room_type_id`, `room_form_id`, `price`, `created_at`, `updated_at`) VALUES
(1, 10, 1, 1, 890000.00, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(2, 10, 2, 2, 890000.00, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(3, 10, 3, 3, 1060000.00, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(4, 10, 4, 1, 1000000.00, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(5, 10, 5, 2, 1000000.00, '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(6, 10, 6, 3, 1320000.00, '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reservation_statuses`
--

CREATE TABLE `reservation_statuses` (
  `id` int(11) NOT NULL,
  `status_name` varchar(255) NOT NULL COMMENT 'Tên tình trạng',
  `status_color` varchar(20) DEFAULT '#ffffff' COMMENT 'Màu sắc',
  `is_hidden` tinyint(1) DEFAULT 0 COMMENT 'Bị ẩn',
  `confirmation_days` int(11) DEFAULT 0 COMMENT 'Ngày xác nhận',
  `status_description` varchar(255) DEFAULT NULL COMMENT 'Mô tả',
  `is_availability` tinyint(1) DEFAULT 0 COMMENT 'Is Availability (Tính khả dụng phòng)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `reservation_statuses`
--

INSERT INTO `reservation_statuses` (`id`, `status_name`, `status_color`, `is_hidden`, `confirmation_days`, `status_description`, `is_availability`, `created_at`, `updated_at`) VALUES
(1, 'Guaranteed', '#4ce410', 0, 0, 'Guaranteed', 1, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(2, 'None Guaranteed', '#2c4b5a', 0, 0, 'None Guaranteed', 1, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(3, 'Cancelled with Penalty', '#f76b15', 1, 0, 'Cancelled', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(4, 'Noshow with Penalty', '#5c189e', 1, 0, 'Noshow with Penalty', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(5, 'Cancelled without Penalty', '#4086F7', 1, 0, 'Hủy phòng không tính phí', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(6, 'Allotment', '#f77940', 0, 5, NULL, 1, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(7, 'Cancelled', '#f74043', 0, 0, NULL, 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(8, 'Waiting', '#f74b40', 0, 5, NULL, 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_code` varchar(50) NOT NULL COMMENT 'Mã phòng (Tạo tự động G + id)',
  `room_number` varchar(50) NOT NULL COMMENT 'Số/Tên phòng',
  `room_type_id` int(11) DEFAULT NULL COMMENT 'Khóa ngoại đến Loại phòng',
  `room_form_id` int(11) DEFAULT NULL COMMENT 'Khóa ngoại đến Dạng phòng',
  `max_guests` int(11) DEFAULT 0 COMMENT 'Khách hàng (Số lượng khách tối đa)',
  `extra_beds` int(11) DEFAULT 0 COMMENT 'Số giường thêm tối đa',
  `area` varchar(100) DEFAULT NULL COMMENT 'Khu vực (VD: A, B, C...)',
  `floor` varchar(50) DEFAULT NULL COMMENT 'Tầng',
  `grid_row` int(11) DEFAULT 0 COMMENT 'Hàng (Dùng cho sơ đồ grid)',
  `grid_col` int(11) DEFAULT 0 COMMENT 'Cột (Dùng cho sơ đồ grid)',
  `linked_room_number` varchar(50) DEFAULT NULL COMMENT 'Phòng liên kết (Connecting room)',
  `clean_status` enum('Clean','Dirty','Inspected') DEFAULT 'Clean' COMMENT 'Trạng thái dọn phòng (Icon Chổi/Lấp lánh)',
  `is_dnd` tinyint(1) DEFAULT 0 COMMENT 'Không làm phiền (Icon dấu trừ)',
  `is_makeup_room` tinyint(1) DEFAULT 0 COMMENT 'Yêu cầu dọn phòng',
  `is_internal` tinyint(1) DEFAULT 0 COMMENT 'Phòng nội bộ',
  `is_owner_room` tinyint(1) DEFAULT 0 COMMENT 'Phòng chủ sở hữu',
  `note` text DEFAULT NULL COMMENT 'Ghi chú',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `rooms`
--

INSERT INTO `rooms` (`id`, `room_code`, `room_number`, `room_type_id`, `room_form_id`, `max_guests`, `extra_beds`, `area`, `floor`, `grid_row`, `grid_col`, `linked_room_number`, `clean_status`, `is_dnd`, `is_makeup_room`, `is_internal`, `is_owner_room`, `note`, `created_at`, `updated_at`) VALUES
(1, 'G1', '1501', 9, 5, 2, 1, 'A', '15', 11, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(10, 'G10', '1003', 5, 2, 3, 0, 'A', '10', 7, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(100, 'G100', '807', 3, 3, 3, 0, 'A', '8', 5, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(101, 'G101', '809', 3, 3, 3, 0, 'A', '8', 5, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(102, 'G102', '907', 3, 3, 3, 0, 'A', '9', 6, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(103, 'G103', '909', 3, 3, 3, 0, 'A', '9', 6, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(104, 'G104', '704', 2, 2, 2, 0, 'A', '7', 4, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(105, 'G105', '706', 2, 2, 3, 0, 'A', '7', 4, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(106, 'G106', '710', 2, 2, 3, 0, 'A', '7', 4, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(107, 'G107', '804', 2, 2, 2, 0, 'A', '8', 5, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(108, 'G108', '806', 2, 2, 3, 0, 'A', '8', 5, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(109, 'G109', '810', 2, 2, 3, 0, 'A', '8', 5, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(11, 'G11', '1102', 5, 2, 3, 0, 'A', '11', 8, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(110, 'G110', '904', 2, 2, 2, 0, 'A', '9', 6, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(111, 'G111', '906', 2, 2, 3, 0, 'A', '9', 6, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(112, 'G112', '910', 2, 2, 3, 0, 'A', '9', 6, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(113, 'G113', '611', 6, 1, 2, 0, 'A', '6', 3, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(114, 'G114', '612', 6, 1, 2, 0, 'A', '6', 3, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(115, 'G115', '711', 6, 1, 2, 0, 'A', '7', 4, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(116, 'G116', '712', 6, 1, 2, 0, 'A', '7', 4, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(117, 'G117', '811', 6, 1, 2, 0, 'A', '8', 5, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(118, 'G118', '812', 6, 1, 2, 0, 'A', '8', 5, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(119, 'G119', '911', 6, 1, 2, 0, 'A', '9', 6, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(12, 'G12', '1103', 5, 2, 3, 0, 'A', '11', 8, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(120, 'G120', '912', 6, 1, 2, 0, 'A', '9', 6, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(121, 'G121', '701', 4, 1, 2, 0, 'A', '7', 4, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(122, 'G122', '801', 4, 1, 2, 0, 'A', '8', 5, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(123, 'G123', '901', 4, 1, 2, 0, 'A', '9', 6, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(124, 'G124', '702', 5, 2, 3, 0, 'A', '7', 4, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(125, 'G125', '703', 5, 2, 3, 0, 'A', '7', 4, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(126, 'G126', '802', 5, 2, 3, 0, 'A', '8', 5, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(127, 'G127', '803', 5, 2, 3, 0, 'A', '8', 5, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(128, 'G128', '902', 5, 2, 3, 0, 'A', '9', 6, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(129, 'G129', '903', 5, 2, 3, 0, 'A', '9', 6, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(13, 'G13', '1202', 5, 2, 3, 0, 'A', '12', 9, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(130, 'G130', '705', 8, 4, 4, 0, 'A', '7', 4, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(131, 'G131', '805', 8, 4, 4, 0, 'A', '8', 5, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(132, 'G132', '905', 8, 4, 4, 0, 'A', '9', 6, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(14, 'G14', '1203', 5, 2, 3, 0, 'A', '12', 9, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(15, 'G15', '1402', 5, 2, 3, 0, 'A', '14', 10, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(16, 'G16', '1403', 5, 2, 3, 0, 'A', '14', 10, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(17, 'G17', '1502', 5, 2, 3, 0, 'A', '15', 11, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(18, 'G18', '402', 5, 2, 3, 0, 'A', '4', 1, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(19, 'G19', '403', 5, 2, 3, 0, 'A', '4', 1, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(2, 'G2', '1001', 4, 1, 2, 0, 'A', '10', 7, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(20, 'G20', '502', 5, 2, 3, 0, 'A', '5', 2, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(21, 'G21', '503', 5, 2, 3, 0, 'A', '5', 2, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(22, 'G22', '602', 5, 2, 3, 0, 'A', '6', 3, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(23, 'G23', '603', 5, 2, 3, 0, 'A', '6', 3, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(24, 'G24', '1004', 3, 3, 3, 0, 'A', '10', 7, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(25, 'G25', '1006', 3, 3, 2, 0, 'A', '10', 7, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(26, 'G26', '1007', 3, 3, 3, 0, 'A', '10', 7, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(27, 'G27', '1008', 3, 3, 2, 0, 'A', '10', 7, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(28, 'G28', '1009', 3, 3, 3, 0, 'A', '10', 7, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(29, 'G29', '1010', 3, 3, 3, 0, 'A', '10', 7, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(3, 'G3', '1101', 4, 1, 2, 0, 'A', '11', 8, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(30, 'G30', '1104', 3, 3, 3, 0, 'A', '11', 8, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(31, 'G31', '1106', 3, 3, 2, 0, 'A', '11', 8, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(32, 'G32', '1107', 3, 3, 3, 0, 'A', '11', 8, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(33, 'G33', '1108', 3, 3, 2, 0, 'A', '11', 8, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(34, 'G34', '1109', 3, 3, 3, 0, 'A', '11', 8, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(35, 'G35', '1110', 3, 3, 3, 0, 'A', '11', 8, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(36, 'G36', '1207', 3, 3, 3, 0, 'A', '12', 9, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(37, 'G37', '1209', 3, 3, 3, 0, 'A', '12', 9, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(38, 'G38', '1407', 3, 3, 3, 0, 'A', '14', 10, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(39, 'G39', '1409', 3, 3, 3, 0, 'A', '14', 10, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(4, 'G4', '1201', 4, 1, 2, 0, 'A', '12', 9, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(40, 'G40', '1507', 3, 3, 3, 0, 'A', '15', 11, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(41, 'G41', '1509', 3, 3, 4, 0, 'A', '15', 11, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(42, 'G42', '407', 3, 3, 3, 0, 'A', '4', 1, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(43, 'G43', '409', 3, 3, 3, 0, 'A', '4', 1, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(44, 'G44', '507', 3, 3, 3, 0, 'A', '5', 2, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(45, 'G45', '509', 3, 3, 3, 0, 'A', '5', 2, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(46, 'G46', '607', 3, 3, 3, 0, 'A', '6', 3, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(47, 'G47', '1005', 8, 4, 4, 0, 'A', '10', 7, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(48, 'G48', '1105', 8, 4, 4, 0, 'A', '11', 8, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(49, 'G49', '1205', 8, 4, 4, 0, 'A', '12', 9, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(5, 'G5', '1401', 4, 1, 2, 0, 'A', '14', 10, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(50, 'G50', '1405', 8, 4, 4, 0, 'A', '14', 10, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(51, 'G51', '1503', 8, 4, 4, 0, 'A', '15', 11, 3, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(52, 'G52', '1505', 8, 4, 4, 0, 'A', '15', 11, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(53, 'G53', '405', 8, 4, 3, 0, 'A', '4', 1, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(54, 'G54', '505', 8, 4, 3, 0, 'A', '5', 2, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(55, 'G55', '605', 8, 4, 3, 0, 'A', '6', 3, 5, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(56, 'G56', '1011', 6, 1, 2, 0, 'A', '10', 7, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(57, 'G57', '1012', 6, 1, 2, 0, 'A', '10', 7, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(58, 'G58', '1111', 6, 1, 2, 0, 'A', '11', 8, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(59, 'G59', '1112', 6, 1, 2, 0, 'A', '11', 8, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(6, 'G6', '401', 4, 1, 2, 0, 'A', '4', 1, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(60, 'G60', '1211', 6, 1, 2, 0, 'A', '12', 9, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(61, 'G61', '1212', 6, 1, 2, 0, 'A', '12', 9, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(62, 'G62', '1411', 6, 1, 2, 0, 'A', '14', 10, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(63, 'G63', '1412', 6, 1, 2, 0, 'A', '14', 10, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(64, 'G64', '1511', 6, 1, 2, 0, 'A', '15', 11, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(65, 'G65', '1512', 6, 1, 2, 0, 'A', '15', 11, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(66, 'G66', '411', 6, 1, 2, 0, 'A', '4', 1, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(67, 'G67', '412', 6, 1, 2, 0, 'A', '4', 1, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(68, 'G68', '511', 6, 1, 2, 0, 'A', '5', 2, 11, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(69, 'G69', '512', 6, 1, 2, 0, 'A', '5', 2, 12, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(7, 'G7', '501', 4, 1, 2, 0, 'A', '5', 2, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(70, 'G70', '1204', 5, 2, 3, 0, 'A', '12', 9, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(71, 'G71', '1206', 5, 2, 2, 0, 'A', '12', 9, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(72, 'G72', '1208', 5, 2, 2, 0, 'A', '12', 9, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(73, 'G73', '1210', 5, 2, 4, 0, 'A', '12', 9, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(74, 'G74', '1404', 5, 2, 3, 0, 'A', '14', 10, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(75, 'G75', '1406', 5, 2, 2, 0, 'A', '14', 10, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(76, 'G76', '1408', 5, 2, 2, 0, 'A', '14', 10, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(77, 'G77', '1410', 5, 2, 4, 0, 'A', '14', 10, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(78, 'G78', '1504', 5, 2, 3, 0, 'A', '15', 11, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(79, 'G79', '1506', 5, 2, 2, 0, 'A', '15', 11, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(8, 'G8', '601', 4, 1, 2, 0, 'A', '6', 3, 1, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(80, 'G80', '1508', 5, 2, 2, 0, 'A', '15', 11, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(81, 'G81', '1510', 5, 2, 4, 0, 'A', '15', 11, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(82, 'G82', '404', 2, 2, 2, 0, 'A', '4', 1, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(83, 'G83', '406', 2, 2, 3, 0, 'A', '4', 1, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(84, 'G84', '410', 2, 2, 3, 0, 'A', '4', 1, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(85, 'G85', '504', 2, 2, 2, 0, 'A', '5', 2, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(86, 'G86', '506', 2, 2, 3, 0, 'A', '5', 2, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(87, 'G87', '510', 2, 2, 3, 0, 'A', '5', 2, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(88, 'G88', '604', 2, 2, 2, 0, 'A', '6', 3, 4, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(89, 'G89', '606', 2, 2, 3, 0, 'A', '6', 3, 6, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(9, 'G9', '1002', 5, 2, 3, 0, 'A', '10', 7, 2, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(90, 'G90', '610', 2, 2, 3, 0, 'A', '6', 3, 10, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(91, 'G91', '408', 1, 1, 2, 0, 'A', '4', 1, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(92, 'G92', '508', 1, 1, 2, 0, 'A', '5', 2, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(93, 'G93', '608', 1, 1, 2, 0, 'A', '6', 3, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(94, 'G94', '708', 1, 1, 2, 0, 'A', '7', 4, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(95, 'G95', '808', 1, 1, 2, 0, 'A', '8', 5, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(96, 'G96', '908', 1, 1, 2, 0, 'A', '9', 6, 8, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(97, 'G97', '609', 3, 3, 3, 0, 'A', '6', 3, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(98, 'G98', '707', 3, 3, 3, 0, 'A', '7', 4, 7, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(99, 'G99', '709', 3, 3, 3, 0, 'A', '7', 4, 9, NULL, 'Clean', 0, 0, 0, 0, NULL, '2026-07-02 06:04:22', '2026-07-02 06:04:22');

--
-- Bẫy `rooms`
--
DELIMITER $$
CREATE TRIGGER `trg_rooms_before_insert` BEFORE INSERT ON `rooms` FOR EACH ROW BEGIN
    IF @next_room_id IS NULL THEN
        SELECT AUTO_INCREMENT INTO @next_room_id
        FROM information_schema.tables
        WHERE table_name = 'rooms' AND table_schema = DATABASE();
    END IF;
    
    IF NEW.room_code IS NULL OR NEW.room_code = '' THEN
        SET NEW.room_code = CONCAT('G', @next_room_id);
        SET @next_room_id = @next_room_id + 1;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `room_forms`
--

CREATE TABLE `room_forms` (
  `id` int(11) NOT NULL,
  `form_name` varchar(255) NOT NULL COMMENT 'Dạng phòng',
  `adult_capacity` int(11) DEFAULT 0 COMMENT 'Người lớn',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `room_forms`
--

INSERT INTO `room_forms` (`id`, `form_name`, `adult_capacity`, `created_at`, `updated_at`) VALUES
(1, 'Double', 2, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(2, 'Twin', 2, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(3, 'Triple', 3, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(4, 'Family', 4, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(5, 'King', 2, '2026-07-02 06:04:22', '2026-07-02 06:04:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `room_locks`
--

CREATE TABLE `room_locks` (
  `id` int(11) NOT NULL,
  `room_code` varchar(50) NOT NULL COMMENT 'Khóa ngoại tới Rooms',
  `lock_type` varchar(50) DEFAULT 'OOS' COMMENT 'Loại khóa (OOO / OOS)',
  `start_date` date NOT NULL COMMENT 'Ngày bắt đầu',
  `end_date` date DEFAULT NULL COMMENT 'Ngày kết thúc',
  `lock_description` text DEFAULT NULL COMMENT 'Mô tả khóa',
  `maintenance_percent` decimal(5,2) DEFAULT 0.00 COMMENT 'Bảo trì (%)',
  `status` varchar(100) DEFAULT 'New' COMMENT 'Trạng thái',
  `locked_by` varchar(255) DEFAULT NULL COMMENT 'Người dùng (Người khóa)',
  `notes` text DEFAULT NULL COMMENT 'Ghi chú',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `room_locks`
--

INSERT INTO `room_locks` (`id`, `room_code`, `lock_type`, `start_date`, `end_date`, `lock_description`, `maintenance_percent`, `status`, `locked_by`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'G6', 'OOS', '2025-05-08', '2025-05-13', 'tháo rèm giặt', 0.00, 'New', 'NB0016', NULL, '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `room_types`
--

CREATE TABLE `room_types` (
  `id` int(11) NOT NULL,
  `type_name` varchar(255) NOT NULL COMMENT 'Tên loại phòng',
  `type_short_name` varchar(50) DEFAULT NULL COMMENT 'Tên viết tắt',
  `type_color` varchar(20) DEFAULT '#ffffff' COMMENT 'Màu sắc',
  `is_active` tinyint(1) DEFAULT 1 COMMENT 'Có sử dụng',
  `group_name` varchar(255) DEFAULT NULL COMMENT 'Nhóm loại phòng',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `room_types`
--

INSERT INTO `room_types` (`id`, `type_name`, `type_short_name`, `type_color`, `is_active`, `group_name`, `created_at`, `updated_at`) VALUES
(1, 'Superior Double', 'SUPD', '#ffffff', 1, 'hotel', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(2, 'Superior Twin', 'SUPT', '#ffffff', 1, 'hotel', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(3, 'Superior Triple', 'SUPTR', '#ffffff', 1, 'hotel', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(4, 'Deluxe Double City view', 'DLXD', '#ffffff', 1, 'hotel', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(5, 'Deluxe Twin City View', 'DLXT', '#ffffff', 1, 'hotel', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(6, 'Deluxe Double with Balcony', 'DLXDB', '#ffffff', 1, 'hotel', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(7, 'Deluxe Twin with Balcony', 'DLXTB', '#ffffff', 1, 'hotel', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(8, 'Family City View', 'FAM', '#ffffff', 1, 'hotel', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(9, 'Suite', 'JST', '#ffffff', 1, 'hotel', '2026-07-02 06:04:22', '2026-07-02 06:04:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `service_departments`
--

CREATE TABLE `service_departments` (
  `id` int(11) NOT NULL,
  `department_name` varchar(255) NOT NULL COMMENT 'Tên bộ phận',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `service_departments`
--

INSERT INTO `service_departments` (`id`, `department_name`, `created_at`, `updated_at`) VALUES
(1, 'Restaurant/Nhà Hàng', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(2, 'Reception/ Lễ Tân', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(3, 'House Keeping/Buồng Phòng', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(4, 'Spa', '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(5, 'Accounting/ Kế Toán', '2026-07-02 06:04:22', '2026-07-02 06:04:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `special_requests`
--

CREATE TABLE `special_requests` (
  `id` int(11) NOT NULL,
  `request_name` varchar(255) NOT NULL COMMENT 'Tên yêu cầu đặc biệt',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `special_requests`
--

INSERT INTO `special_requests` (`id`, `request_name`, `created_at`, `updated_at`) VALUES
(1, 'Honeymoon', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(2, 'Birthday', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(3, 'High Floor', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(4, 'Low Floor', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(5, 'Same Floor', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(6, 'Room Near By', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(7, 'Quite Room', '2026-07-02 06:04:23', '2026-07-02 06:04:23'),
(8, 'Window required', '2026-07-02 06:04:23', '2026-07-02 06:04:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `standard_room_rates`
--

CREATE TABLE `standard_room_rates` (
  `id` int(11) NOT NULL,
  `room_type_id` int(11) DEFAULT NULL COMMENT 'Khóa ngoại liên kết tới bảng room_types',
  `room_form_id` int(11) DEFAULT NULL COMMENT 'Khóa ngoại liên kết tới bảng room_forms',
  `room_rate` decimal(15,2) DEFAULT 0.00 COMMENT 'Giá phòng',
  `extra_bed_rate` decimal(15,2) DEFAULT 0.00 COMMENT 'Giá thêm giường',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `standard_room_rates`
--

INSERT INTO `standard_room_rates` (`id`, `room_type_id`, `room_form_id`, `room_rate`, `extra_bed_rate`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 0.00, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(2, 4, 1, 0.00, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(3, 5, 2, 0.00, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(4, 6, 1, 0.00, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(5, 8, 4, 0.00, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(6, 9, 5, 0.00, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(7, 3, 3, 0.00, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(8, 1, 1, 0.00, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
(9, 7, 2, 0.00, 0.00, '2026-07-02 06:04:22', '2026-07-02 06:04:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `units`
--

CREATE TABLE `units` (
  `unit_code` varchar(50) NOT NULL COMMENT 'Mã đơn vị tính',
  `unit_name` varchar(255) NOT NULL COMMENT 'Tên đơn vị tính',
  `unit_symbol` varchar(50) DEFAULT NULL COMMENT 'Ký hiệu (Symbol)',
  `is_inactive` tinyint(1) DEFAULT 0 COMMENT 'Không sử dụng',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `units`
--

INSERT INTO `units` (`unit_code`, `unit_name`, `unit_symbol`, `is_inactive`, `created_at`, `updated_at`) VALUES
('001', 'Bịch', 'Bịch', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('00153', 'glass 6', 'glass 6', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('00158', 'Jug', 'Jug', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('002', 'Bộ', 'Bộ', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('003', 'Cái', 'Cái', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('004', 'Cây', 'Cây', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('DEM', 'Đêm', 'Đêm', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('DV', 'Dịch Vụ', 'Dịch Vụ', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22'),
('NG', 'Người', 'Người', 0, '2026-07-02 06:04:22', '2026-07-02 06:04:22');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `bookers`
--
ALTER TABLE `bookers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_code`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `company_code` (`company_code`),
  ADD KEY `member_company_id` (`member_company_id`),
  ADD KEY `management_department_code` (`management_department_code`),
  ADD KEY `payment_method_code` (`payment_method_code`),
  ADD KEY `market_segment_code` (`market_segment_code`),
  ADD KEY `booking_source_code` (`booking_source_code`),
  ADD KEY `booker_id` (`booker_id`);

--
-- Chỉ mục cho bảng `booking_rooms`
--
ALTER TABLE `booking_rooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_code` (`booking_code`),
  ADD KEY `room_type_id` (`room_type_id`),
  ADD KEY `room_form_id` (`room_form_id`),
  ADD KEY `room_code` (`room_code`),
  ADD KEY `rate_plan_code` (`rate_plan_code`);

--
-- Chỉ mục cho bảng `booking_room_special_requests`
--
ALTER TABLE `booking_room_special_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_booking_room_req` (`booking_room_id`,`special_request_id`),
  ADD KEY `special_request_id` (`special_request_id`);

--
-- Chỉ mục cho bảng `booking_sources`
--
ALTER TABLE `booking_sources`
  ADD PRIMARY KEY (`code`);

--
-- Chỉ mục cho bảng `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`company_code`),
  ADD KEY `booking_source_code` (`booking_source_code`),
  ADD KEY `market_segment_code` (`market_segment_code`),
  ADD KEY `rate_plan_code` (`rate_plan_code`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Chỉ mục cho bảng `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`currency_code`);

--
-- Chỉ mục cho bảng `hotel_services`
--
ALTER TABLE `hotel_services`
  ADD PRIMARY KEY (`code`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `unit_code` (`unit_code`);

--
-- Chỉ mục cho bảng `management_departments`
--
ALTER TABLE `management_departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Chỉ mục cho bảng `market_segments`
--
ALTER TABLE `market_segments`
  ADD PRIMARY KEY (`code`);

--
-- Chỉ mục cho bảng `member_companies`
--
ALTER TABLE `member_companies`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`payment_code`);

--
-- Chỉ mục cho bảng `payment_method_departments`
--
ALTER TABLE `payment_method_departments`
  ADD PRIMARY KEY (`payment_method_code`,`department_id`),
  ADD KEY `department_id` (`department_id`);

--
-- Chỉ mục cho bảng `rate_plans`
--
ALTER TABLE `rate_plans`
  ADD PRIMARY KEY (`plan_code`),
  ADD KEY `currency_code` (`currency_code`);

--
-- Chỉ mục cho bảng `rate_seasons`
--
ALTER TABLE `rate_seasons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_rate_season` (`rate_plan_code`,`season_code`);

--
-- Chỉ mục cho bảng `rate_season_prices`
--
ALTER TABLE `rate_season_prices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_season_room` (`rate_season_id`,`room_type_id`,`room_form_id`),
  ADD KEY `room_type_id` (`room_type_id`),
  ADD KEY `room_form_id` (`room_form_id`);

--
-- Chỉ mục cho bảng `reservation_statuses`
--
ALTER TABLE `reservation_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_code`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `room_number` (`room_number`),
  ADD KEY `room_type_id` (`room_type_id`),
  ADD KEY `room_form_id` (`room_form_id`);

--
-- Chỉ mục cho bảng `room_forms`
--
ALTER TABLE `room_forms`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `room_locks`
--
ALTER TABLE `room_locks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_code` (`room_code`);

--
-- Chỉ mục cho bảng `room_types`
--
ALTER TABLE `room_types`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `service_departments`
--
ALTER TABLE `service_departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `department_name` (`department_name`);

--
-- Chỉ mục cho bảng `special_requests`
--
ALTER TABLE `special_requests`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `standard_room_rates`
--
ALTER TABLE `standard_room_rates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_std_rate` (`room_type_id`,`room_form_id`),
  ADD KEY `room_form_id` (`room_form_id`);

--
-- Chỉ mục cho bảng `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unit_code`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `bookers`
--
ALTER TABLE `bookers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `booking_rooms`
--
ALTER TABLE `booking_rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `booking_room_special_requests`
--
ALTER TABLE `booking_room_special_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `management_departments`
--
ALTER TABLE `management_departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `member_companies`
--
ALTER TABLE `member_companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `rate_seasons`
--
ALTER TABLE `rate_seasons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `rate_season_prices`
--
ALTER TABLE `rate_season_prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `reservation_statuses`
--
ALTER TABLE `reservation_statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT cho bảng `room_forms`
--
ALTER TABLE `room_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `room_locks`
--
ALTER TABLE `room_locks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `room_types`
--
ALTER TABLE `room_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `service_departments`
--
ALTER TABLE `service_departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `special_requests`
--
ALTER TABLE `special_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `standard_room_rates`
--
ALTER TABLE `standard_room_rates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `reservation_statuses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`company_code`) REFERENCES `companies` (`company_code`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`member_company_id`) REFERENCES `member_companies` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_ibfk_4` FOREIGN KEY (`management_department_code`) REFERENCES `management_departments` (`code`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_ibfk_5` FOREIGN KEY (`payment_method_code`) REFERENCES `payment_methods` (`payment_code`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_ibfk_6` FOREIGN KEY (`market_segment_code`) REFERENCES `market_segments` (`code`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_ibfk_7` FOREIGN KEY (`booking_source_code`) REFERENCES `booking_sources` (`code`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_ibfk_8` FOREIGN KEY (`booker_id`) REFERENCES `bookers` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `booking_rooms`
--
ALTER TABLE `booking_rooms`
  ADD CONSTRAINT `booking_rooms_ibfk_1` FOREIGN KEY (`booking_code`) REFERENCES `bookings` (`booking_code`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_rooms_ibfk_2` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `booking_rooms_ibfk_3` FOREIGN KEY (`room_form_id`) REFERENCES `room_forms` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `booking_rooms_ibfk_4` FOREIGN KEY (`room_code`) REFERENCES `rooms` (`room_code`) ON DELETE SET NULL,
  ADD CONSTRAINT `booking_rooms_ibfk_5` FOREIGN KEY (`rate_plan_code`) REFERENCES `rate_plans` (`plan_code`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `booking_room_special_requests`
--
ALTER TABLE `booking_room_special_requests`
  ADD CONSTRAINT `booking_room_special_requests_ibfk_1` FOREIGN KEY (`booking_room_id`) REFERENCES `booking_rooms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_room_special_requests_ibfk_2` FOREIGN KEY (`special_request_id`) REFERENCES `special_requests` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `companies_ibfk_1` FOREIGN KEY (`booking_source_code`) REFERENCES `booking_sources` (`code`) ON DELETE SET NULL,
  ADD CONSTRAINT `companies_ibfk_2` FOREIGN KEY (`market_segment_code`) REFERENCES `market_segments` (`code`) ON DELETE SET NULL,
  ADD CONSTRAINT `companies_ibfk_3` FOREIGN KEY (`rate_plan_code`) REFERENCES `rate_plans` (`plan_code`) ON DELETE SET NULL,
  ADD CONSTRAINT `companies_ibfk_4` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `hotel_services`
--
ALTER TABLE `hotel_services`
  ADD CONSTRAINT `hotel_services_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `service_departments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hotel_services_ibfk_2` FOREIGN KEY (`unit_code`) REFERENCES `units` (`unit_code`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `payment_method_departments`
--
ALTER TABLE `payment_method_departments`
  ADD CONSTRAINT `payment_method_departments_ibfk_1` FOREIGN KEY (`payment_method_code`) REFERENCES `payment_methods` (`payment_code`) ON DELETE CASCADE,
  ADD CONSTRAINT `payment_method_departments_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `service_departments` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `rate_plans`
--
ALTER TABLE `rate_plans`
  ADD CONSTRAINT `rate_plans_ibfk_1` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`currency_code`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `rate_seasons`
--
ALTER TABLE `rate_seasons`
  ADD CONSTRAINT `rate_seasons_ibfk_1` FOREIGN KEY (`rate_plan_code`) REFERENCES `rate_plans` (`plan_code`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `rate_season_prices`
--
ALTER TABLE `rate_season_prices`
  ADD CONSTRAINT `rate_season_prices_ibfk_1` FOREIGN KEY (`rate_season_id`) REFERENCES `rate_seasons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rate_season_prices_ibfk_2` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rate_season_prices_ibfk_3` FOREIGN KEY (`room_form_id`) REFERENCES `room_forms` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `rooms_ibfk_2` FOREIGN KEY (`room_form_id`) REFERENCES `room_forms` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `room_locks`
--
ALTER TABLE `room_locks`
  ADD CONSTRAINT `room_locks_ibfk_1` FOREIGN KEY (`room_code`) REFERENCES `rooms` (`room_code`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `standard_room_rates`
--
ALTER TABLE `standard_room_rates`
  ADD CONSTRAINT `standard_room_rates_ibfk_1` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `standard_room_rates_ibfk_2` FOREIGN KEY (`room_form_id`) REFERENCES `room_forms` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
