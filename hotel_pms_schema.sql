CREATE DATABASE IF NOT EXISTS hotel_pms;
USE hotel_pms;

-- =====================================================================
-- BẢNG TỪ ĐIỂN & DANH MỤC CƠ BẢN
-- =====================================================================

-- 1. Tạo bảng lưu trữ thông tin loại phòng (Room Types)
CREATE TABLE IF NOT EXISTS room_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(255) NOT NULL COMMENT 'Tên loại phòng',
    type_short_name VARCHAR(50) COMMENT 'Tên viết tắt',
    type_color VARCHAR(20) DEFAULT '#ffffff' COMMENT 'Màu sắc',
    is_active BOOLEAN DEFAULT TRUE COMMENT 'Có sử dụng',
    group_name VARCHAR(255) DEFAULT NULL COMMENT 'Nhóm loại phòng',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO room_types (type_name, type_short_name, type_color, is_active, group_name) VALUES
('Superior Double', 'SUPD', '#ffffff', TRUE, 'hotel'),
('Superior Twin', 'SUPT', '#ffffff', TRUE, 'hotel'),
('Superior Triple', 'SUPTR', '#ffffff', TRUE, 'hotel'),
('Deluxe Double City view', 'DLXD', '#ffffff', TRUE, 'hotel'),
('Deluxe Twin City View', 'DLXT', '#ffffff', TRUE, 'hotel'),
('Deluxe Double with Balcony', 'DLXDB', '#ffffff', TRUE, 'hotel'),
('Deluxe Twin with Balcony', 'DLXTB', '#ffffff', TRUE, 'hotel'),
('Family City View', 'FAM', '#ffffff', TRUE, 'hotel'),
('Suite', 'JST', '#ffffff', TRUE, 'hotel');


-- 2. Tạo bảng lưu trữ thông tin dạng phòng (Room Forms)
CREATE TABLE IF NOT EXISTS room_forms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    form_name VARCHAR(255) NOT NULL COMMENT 'Dạng phòng',
    adult_capacity INT DEFAULT 0 COMMENT 'Người lớn',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO room_forms (form_name, adult_capacity) VALUES
('Double', 2),
('Twin', 2),
('Triple', 3),
('Family', 4),
('King', 2);


-- 3. Tạo bảng bộ phận dịch vụ (Service Departments)
CREATE TABLE IF NOT EXISTS service_departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL UNIQUE COMMENT 'Tên bộ phận',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO service_departments (department_name) VALUES
('Restaurant/Nhà Hàng'),
('Reception/ Lễ Tân'),
('House Keeping/Buồng Phòng'),
('Spa'),
('Accounting/ Kế Toán');


-- 4. Tạo bảng danh mục đơn vị tính (Units of Measurement)
CREATE TABLE IF NOT EXISTS units (
    unit_code VARCHAR(50) PRIMARY KEY COMMENT 'Mã đơn vị tính',
    unit_name VARCHAR(255) NOT NULL COMMENT 'Tên đơn vị tính',
    unit_symbol VARCHAR(50) DEFAULT NULL COMMENT 'Ký hiệu (Symbol)',
    is_inactive BOOLEAN DEFAULT FALSE COMMENT 'Không sử dụng',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bổ sung thêm các đơn vị: Người, Dịch Vụ, Đêm để gán khóa ngoại cho hotel_services
INSERT INTO units (unit_code, unit_name, unit_symbol, is_inactive) VALUES
('001', 'Bịch', 'Bịch', FALSE),
('00153', 'glass 6', 'glass 6', FALSE),
('00158', 'Jug', 'Jug', FALSE),
('002', 'Bộ', 'Bộ', FALSE),
('003', 'Cái', 'Cái', FALSE),
('004', 'Cây', 'Cây', FALSE),
('NG', 'Người', 'Người', FALSE),
('DV', 'Dịch Vụ', 'Dịch Vụ', FALSE),
('DEM', 'Đêm', 'Đêm', FALSE);


-- 5. Tạo bảng cấu hình tiền tệ (Currencies)
CREATE TABLE IF NOT EXISTS currencies (
    currency_code VARCHAR(10) PRIMARY KEY COMMENT 'Mã tiền tệ (VD: VND, USD)',
    image_url VARCHAR(255) DEFAULT NULL COMMENT 'Hình ảnh đại diện',
    currency_name VARCHAR(255) NOT NULL COMMENT 'Tên loại tiền tệ',
    country VARCHAR(255) DEFAULT NULL COMMENT 'Quốc gia',
    is_primary BOOLEAN DEFAULT FALSE COMMENT 'Là tiền tệ chính (Base currency)',
    is_active BOOLEAN DEFAULT TRUE COMMENT 'Trạng thái sử dụng',
    decimal_places INT DEFAULT 0 COMMENT 'Làm tròn chữ số thập phân',
    exchange_rate DECIMAL(15, 6) DEFAULT 1.000000 COMMENT 'Tỉ giá quy đổi',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO currencies (currency_code, image_url, currency_name, country, is_primary, is_active, decimal_places, exchange_rate) VALUES
('VND', NULL, 'Viet Nam Dong', 'Vietnam', TRUE, TRUE, 0, 1.000000);




-- 7. Tạo bảng tình trạng đăng ký (Reservation Statuses)
CREATE TABLE IF NOT EXISTS reservation_statuses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(255) NOT NULL COMMENT 'Tên tình trạng',
    status_color VARCHAR(20) DEFAULT '#ffffff' COMMENT 'Màu sắc',
    is_hidden BOOLEAN DEFAULT FALSE COMMENT 'Bị ẩn',
    confirmation_days INT DEFAULT 0 COMMENT 'Ngày xác nhận',
    status_description VARCHAR(255) DEFAULT NULL COMMENT 'Mô tả',
    is_availability BOOLEAN DEFAULT FALSE COMMENT 'Is Availability (Tính khả dụng phòng)',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO reservation_statuses (status_name, status_color, is_hidden, confirmation_days, status_description, is_availability) VALUES
('Guaranteed', '#4ce410', FALSE, 0, 'Guaranteed', TRUE),
('None Guaranteed', '#2c4b5a', FALSE, 0, 'None Guaranteed', TRUE),
('Cancelled with Penalty', '#f76b15', TRUE, 0, 'Cancelled', FALSE),
('Noshow with Penalty', '#5c189e', TRUE, 0, 'Noshow with Penalty', FALSE),
('Cancelled without Penalty', '#4086F7', TRUE, 0, 'Hủy phòng không tính phí', FALSE),
('Allotment', '#f77940', FALSE, 5, NULL, TRUE),
('Cancelled', '#f74043', FALSE, 0, NULL, FALSE),
('Waiting', '#f74b40', FALSE, 5, NULL, FALSE);


-- 8. Tạo bảng hình thức thanh toán (Payment Methods)
CREATE TABLE IF NOT EXISTS payment_methods (
    payment_code VARCHAR(50) PRIMARY KEY COMMENT 'Mã hình thức thanh toán',
    payment_name VARCHAR(255) NOT NULL COMMENT 'Tên hình thức',
    account_number VARCHAR(100) DEFAULT NULL COMMENT 'Tài khoản',
    account_name VARCHAR(255) DEFAULT NULL COMMENT 'Tên tài khoản',
    bank_name VARCHAR(255) DEFAULT NULL COMMENT 'Tên ngân hàng',
    payment_service_fee DECIMAL(5, 2) DEFAULT 0 COMMENT 'Phí phục vụ (%)',
    is_complimentary BOOLEAN DEFAULT FALSE COMMENT 'HT Miễn Phí (Hình thức miễn phí)',
    is_inactive BOOLEAN DEFAULT FALSE COMMENT 'Không sử dụng',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO payment_methods (payment_code, payment_name, account_number, account_name, bank_name, payment_service_fee, is_complimentary, is_inactive) VALUES
('CL', 'Complimentary', '', '', 'Complimentary', 0, TRUE, TRUE),
('CA', 'Cash', '', '', 'Cash', 0, FALSE, FALSE),
('AC', 'City ledger', '', '', 'City ledger', 0, FALSE, FALSE),
('BT', 'Bank transfer', '', '', 'Bank transfer', 0, FALSE, FALSE),
('VO', 'Voucher', '', '', 'Voucher', 0, FALSE, FALSE);


-- =====================================================================
-- BẢNG HOẠT ĐỘNG / KẾT HỢP
-- =====================================================================

-- 9. Tạo bảng cấu hình giá phòng chuẩn (Standard Room Rates)
CREATE TABLE IF NOT EXISTS standard_room_rates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_type_id INT COMMENT 'Khóa ngoại liên kết tới bảng room_types',
    room_form_id INT COMMENT 'Khóa ngoại liên kết tới bảng room_forms',
    room_rate DECIMAL(15, 2) DEFAULT 0 COMMENT 'Giá phòng',
    extra_bed_rate DECIMAL(15, 2) DEFAULT 0 COMMENT 'Giá thêm giường',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_std_rate (room_type_id, room_form_id),
    FOREIGN KEY (room_type_id) REFERENCES room_types(id) ON DELETE CASCADE,
    FOREIGN KEY (room_form_id) REFERENCES room_forms(id) ON DELETE CASCADE
);

INSERT INTO standard_room_rates (room_type_id, room_form_id, room_rate, extra_bed_rate) VALUES
((SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 0, 0),
((SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 0, 0),
((SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 0, 0),
((SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 0, 0),
((SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 0, 0),
((SELECT id FROM room_types WHERE type_name = 'Suite' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'King' LIMIT 1), 0, 0),
((SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 0, 0),
((SELECT id FROM room_types WHERE type_name = 'Superior Double' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 0, 0),
((SELECT id FROM room_types WHERE type_name = 'Deluxe Twin with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 0, 0);


-- 10. Tạo bảng quản lý danh sách phòng vật lý (Rooms)
CREATE TABLE IF NOT EXISTS rooms (
    id INT AUTO_INCREMENT UNIQUE,
    room_code VARCHAR(50) PRIMARY KEY COMMENT 'Mã phòng (Tạo tự động G + id)',
    room_number VARCHAR(50) NOT NULL UNIQUE COMMENT 'Số/Tên phòng',
    room_type_id INT COMMENT 'Khóa ngoại đến Loại phòng',
    room_form_id INT COMMENT 'Khóa ngoại đến Dạng phòng',
    max_guests INT DEFAULT 0 COMMENT 'Khách hàng (Số lượng khách tối đa)',
    extra_beds INT DEFAULT 0 COMMENT 'Số giường thêm tối đa',
    area VARCHAR(100) COMMENT 'Khu vực (VD: A, B, C...)',
    floor VARCHAR(50) COMMENT 'Tầng',
    grid_row INT DEFAULT 0 COMMENT 'Hàng (Dùng cho sơ đồ grid)',
    grid_col INT DEFAULT 0 COMMENT 'Cột (Dùng cho sơ đồ grid)',
    linked_room_number VARCHAR(50) DEFAULT NULL COMMENT 'Phòng liên kết (Connecting room)',
    is_internal BOOLEAN DEFAULT FALSE COMMENT 'Phòng nội bộ',
    is_owner_room BOOLEAN DEFAULT FALSE COMMENT 'Phòng chủ sở hữu',
    note TEXT COMMENT 'Ghi chú',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (room_type_id) REFERENCES room_types(id) ON DELETE SET NULL,
    FOREIGN KEY (room_form_id) REFERENCES room_forms(id) ON DELETE SET NULL
);

-- Tạo Trigger tự động sinh room_code (G + id)
DELIMITER //
CREATE TRIGGER trg_rooms_before_insert
BEFORE INSERT ON rooms
FOR EACH ROW
BEGIN
    IF @next_room_id IS NULL THEN
        SELECT AUTO_INCREMENT INTO @next_room_id
        FROM information_schema.tables
        WHERE table_name = 'rooms' AND table_schema = DATABASE();
    END IF;
    
    IF NEW.room_code IS NULL OR NEW.room_code = '' THEN
        SET NEW.room_code = CONCAT('G', @next_room_id);
        SET @next_room_id = @next_room_id + 1;
    END IF;
END //
DELIMITER ;


INSERT INTO rooms (room_number, room_type_id, room_form_id, max_guests, extra_beds, area, floor, grid_row, grid_col, is_internal) VALUES
-- Nhóm: Suite (Dạng phòng: King)
('1501', (SELECT id FROM room_types WHERE type_name = 'Suite' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'King' LIMIT 1), 2, 1, 'A', '15', 11, 1, FALSE),

-- Nhóm: Deluxe Double City view (Dạng phòng: Double)
('1001', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '10', 7, 1, FALSE),
('1101', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '11', 8, 1, FALSE),
('1201', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '12', 9, 1, FALSE),
('1401', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '14', 10, 1, FALSE),
('401', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '4', 1, 1, FALSE),
('501', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '5', 2, 1, FALSE),
('601', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '6', 3, 1, FALSE),

-- Nhóm: Deluxe Twin with Balcony (Tương đương Deluxe Twin City View trong DB - Dạng phòng: Twin)
('1002', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '10', 7, 2, FALSE),
('1003', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '10', 7, 3, FALSE),
('1102', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '11', 8, 2, FALSE),
('1103', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '11', 8, 3, FALSE),
('1202', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '12', 9, 2, FALSE),
('1203', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '12', 9, 3, FALSE),
('1402', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '14', 10, 2, FALSE),
('1403', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '14', 10, 3, FALSE),
('1502', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '15', 11, 2, FALSE),
('402', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '4', 1, 2, FALSE),
('403', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '4', 1, 3, FALSE),
('502', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '5', 2, 2, FALSE),
('503', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '5', 2, 3, FALSE),
('602', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '6', 3, 2, FALSE),
('603', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '6', 3, 3, FALSE),

-- Nhóm: Superior Triple (Dạng phòng: Triple)
('1004', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '10', 7, 4, FALSE),
('1006', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 2, 0, 'A', '10', 7, 6, FALSE),
('1007', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '10', 7, 7, FALSE),
('1008', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 2, 0, 'A', '10', 7, 8, FALSE),
('1009', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '10', 7, 9, FALSE),
('1010', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '10', 7, 10, FALSE),
('1104', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '11', 8, 4, FALSE),
('1106', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 2, 0, 'A', '11', 8, 6, FALSE),
('1107', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '11', 8, 7, FALSE),
('1108', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 2, 0, 'A', '11', 8, 8, FALSE),
('1109', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '11', 8, 9, FALSE),
('1110', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '11', 8, 10, FALSE),
('1207', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '12', 9, 7, FALSE),
('1209', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '12', 9, 9, FALSE),
('1407', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '14', 10, 7, FALSE),
('1409', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '14', 10, 9, FALSE),
('1507', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '15', 11, 7, FALSE),
('1509', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 4, 0, 'A', '15', 11, 9, FALSE),
('407', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '4', 1, 7, FALSE),
('409', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '4', 1, 9, FALSE),
('507', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '5', 2, 7, FALSE),
('509', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '5', 2, 9, FALSE),
('607', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '6', 3, 7, FALSE),

-- Nhóm: Family City View (Dạng phòng: Family)
('1005', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 4, 0, 'A', '10', 7, 5, FALSE),
('1105', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 4, 0, 'A', '11', 8, 5, FALSE),
('1205', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 4, 0, 'A', '12', 9, 5, FALSE),
('1405', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 4, 0, 'A', '14', 10, 5, FALSE),
('1503', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 4, 0, 'A', '15', 11, 3, FALSE),
('1505', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 4, 0, 'A', '15', 11, 5, FALSE),
('405', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 3, 0, 'A', '4', 1, 5, FALSE),
('505', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 3, 0, 'A', '5', 2, 5, FALSE),
('605', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 3, 0, 'A', '6', 3, 5, FALSE),

-- Nhóm: Deluxe Double with Balcony (Dạng phòng: Double)
('1011', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '10', 7, 11, FALSE),
('1012', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '10', 7, 12, FALSE),
('1111', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '11', 8, 11, FALSE),
('1112', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '11', 8, 12, FALSE),
('1211', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '12', 9, 11, FALSE),
('1212', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '12', 9, 12, FALSE),
('1411', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '14', 10, 11, FALSE),
('1412', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '14', 10, 12, FALSE),
('1511', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '15', 11, 11, FALSE),
('1512', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '15', 11, 12, FALSE),
('411', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '4', 1, 11, FALSE),
('412', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '4', 1, 12, FALSE),
('511', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '5', 2, 11, FALSE),
('512', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '5', 2, 12, FALSE),

-- Nhóm: Deluxe Twin City View (tiếp tục)
('1204', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '12', 9, 4, FALSE),
('1206', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '12', 9, 6, FALSE),
('1208', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '12', 9, 8, FALSE),
('1210', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 4, 0, 'A', '12', 9, 10, FALSE),
('1404', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '14', 10, 4, FALSE),
('1406', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '14', 10, 6, FALSE),
('1408', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '14', 10, 8, FALSE),
('1410', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 4, 0, 'A', '14', 10, 10, FALSE),
('1504', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '15', 11, 4, FALSE),
('1506', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '15', 11, 6, FALSE),
('1508', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '15', 11, 8, FALSE),
('1510', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 4, 0, 'A', '15', 11, 10, FALSE),

-- Nhóm: DỰ PHÒNG (Sử dụng Standard Double No View - Dạng phòng: Double)
('302', (SELECT id FROM room_types WHERE type_name = 'Superior Double' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '4', 1, 13, FALSE),
('303', (SELECT id FROM room_types WHERE type_name = 'Superior Double' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 0, 0, 'A', '4', 1, 14, FALSE),
('305', (SELECT id FROM room_types WHERE type_name = 'Superior Double' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '4', 1, 15, FALSE),

-- Nhóm: Superior Twin (Dạng phòng: Twin)
('404', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '4', 1, 4, FALSE),
('406', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '4', 1, 6, FALSE),
('410', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '4', 1, 10, FALSE),
('504', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '5', 2, 4, FALSE),
('506', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '5', 2, 6, FALSE),
('510', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '5', 2, 10, FALSE),
('604', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '6', 3, 4, FALSE),
('606', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '6', 3, 6, FALSE),
('610', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '6', 3, 10, FALSE),

-- Nhóm: Superior Double With Window (Dạng phòng: Double)
('408', (SELECT id FROM room_types WHERE type_name = 'Superior Double' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '4', 1, 8, FALSE),
('508', (SELECT id FROM room_types WHERE type_name = 'Superior Double' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '5', 2, 8, FALSE),
('608', (SELECT id FROM room_types WHERE type_name = 'Superior Double' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '6', 3, 8, FALSE),
('708', (SELECT id FROM room_types WHERE type_name = 'Superior Double' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '7', 4, 8, FALSE),
('808', (SELECT id FROM room_types WHERE type_name = 'Superior Double' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '8', 5, 8, FALSE),
('908', (SELECT id FROM room_types WHERE type_name = 'Superior Double' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '9', 6, 8, FALSE),

-- Nhóm: Superior Triple (tiếp tục)
('609', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '6', 3, 9, FALSE),
('707', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '7', 4, 7, FALSE),
('709', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '7', 4, 9, FALSE),
('807', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '8', 5, 7, FALSE),
('809', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '8', 5, 9, FALSE),
('907', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '9', 6, 7, FALSE),
('909', (SELECT id FROM room_types WHERE type_name = 'Superior Triple' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 3, 0, 'A', '9', 6, 9, FALSE),

-- Nhóm: Superior Twin (tiếp tục - tầng 7-9)
('704', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '7', 4, 4, FALSE),
('706', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '7', 4, 6, FALSE),
('710', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '7', 4, 10, FALSE),
('804', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '8', 5, 4, FALSE),
('806', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '8', 5, 6, FALSE),
('810', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '8', 5, 10, FALSE),
('904', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 2, 0, 'A', '9', 6, 4, FALSE),
('906', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '9', 6, 6, FALSE),
('910', (SELECT id FROM room_types WHERE type_name = 'Superior Twin' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '9', 6, 10, FALSE),

-- Nhóm: Deluxe Double with Balcony (tiếp tục - tầng 6-9)
('611', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '6', 3, 11, FALSE),
('612', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '6', 3, 12, FALSE),
('711', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '7', 4, 11, FALSE),
('712', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '7', 4, 12, FALSE),
('811', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '8', 5, 11, FALSE),
('812', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '8', 5, 12, FALSE),
('911', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '9', 6, 11, FALSE),
('912', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double with Balcony' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '9', 6, 12, FALSE),

-- Nhóm: Deluxe Double City view (tiếp tục - tầng 7-9)
('701', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '7', 4, 1, FALSE),
('801', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '8', 5, 1, FALSE),
('901', (SELECT id FROM room_types WHERE type_name = 'Deluxe Double City view' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 2, 0, 'A', '9', 6, 1, FALSE),

-- Nhóm: Deluxe Twin with Balcony (Tương đương Deluxe Twin City View - Dạng phòng: Twin)
('702', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '7', 4, 2, FALSE),
('703', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '7', 4, 3, FALSE),
('802', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '8', 5, 2, FALSE),
('803', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '8', 5, 3, FALSE),
('902', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '9', 6, 2, FALSE),
('903', (SELECT id FROM room_types WHERE type_name = 'Deluxe Twin City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 3, 0, 'A', '9', 6, 3, FALSE),

-- Nhóm: Family City View (tiếp tục - tầng 7-9)
('705', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 4, 0, 'A', '7', 4, 5, FALSE),
('805', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 4, 0, 'A', '8', 5, 5, FALSE),
('905', (SELECT id FROM room_types WHERE type_name = 'Family City View' LIMIT 1), (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1), 4, 0, 'A', '9', 6, 5, FALSE);


-- 11. Tạo bảng dịch vụ khách sạn (Hotel Services)
CREATE TABLE IF NOT EXISTS hotel_services (
    code VARCHAR(50) PRIMARY KEY COMMENT 'Mã dịch vụ',
    department_id INT COMMENT 'Khóa ngoại tới Bộ phận dịch vụ',
    full_name VARCHAR(255) NOT NULL COMMENT 'Tên dịch vụ đầy đủ',
    short_name VARCHAR(100) COMMENT 'Tên ngắn',
    description TEXT COMMENT 'Mô tả chi tiết',
    service_fee_percent DECIMAL(5, 2) DEFAULT 0 COMMENT 'Phí phục vụ (%)',
    tax_percent DECIMAL(5, 2) DEFAULT 0 COMMENT 'Thuế (%)',
    special_tax_percent DECIMAL(5, 2) DEFAULT 0 COMMENT 'Thuế đặc biệt (%)',
    includes_service_fee BOOLEAN DEFAULT FALSE COMMENT 'Bao gồm phí dịch vụ',
    includes_tax BOOLEAN DEFAULT FALSE COMMENT 'Bao gồm thuế',
    includes_special_tax BOOLEAN DEFAULT FALSE COMMENT 'Bao gồm thuế đặc biệt',
    folio INT DEFAULT 1 COMMENT 'Folio',
    unit_code VARCHAR(50) COMMENT 'Khóa ngoại tới bảng đơn vị tính',
    price DECIMAL(15, 2) DEFAULT 0 COMMENT 'Giá',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES service_departments(id) ON DELETE SET NULL,
    FOREIGN KEY (unit_code) REFERENCES units(unit_code) ON DELETE SET NULL
);

INSERT INTO hotel_services (code, department_id, full_name, short_name, description, service_fee_percent, tax_percent, special_tax_percent, includes_service_fee, includes_tax, includes_special_tax, folio, unit_code, price) VALUES
('BC', (SELECT id FROM service_departments WHERE department_name = 'Restaurant/Nhà Hàng' LIMIT 1), 'Ăn sáng buffet trẻ em', 'Ăn sáng trẻ em', NULL, 5, 8, 0, TRUE, TRUE, FALSE, 1, 'NG', 100000),
('BD', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Breakfast Child/Ăn Sáng Trẻ Em', 'Breakfast Child', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'NG', 0),
('BF', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Ăn sáng buffet người lớn', 'Ăn sáng buffet', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'NG', 180000),
('BK', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Broken / Đổ vỡ', 'Broken / Đổ vỡ', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('BR', (SELECT id FROM service_departments WHERE department_name = 'House Keeping/Buồng Phòng' LIMIT 1), 'Broken/Phí Hư Hỏng', 'Broken', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('DN', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Dinner / Ăn tối', 'Dinner / Ăn tối', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'NG', 0),
('DO', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Drop off to the airport/ Tiễn sân bay', 'Drop off', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('EB', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Extrabed/Thêm Giường', 'Extrabed', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('EI', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Early Checkin/Phụ Thu Nhận Phòng Sớm', 'Early Checkin', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('EP', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Extra Person/ Phụ Thu Thêm Người', 'Extra Person', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('ER', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Extra RoomCharge / Phụ thu tiền phòng', 'Extra RoomCharge', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('FB', (SELECT id FROM service_departments WHERE department_name = 'Restaurant/Nhà Hàng' LIMIT 1), 'Food and Beverage/ Dịch Vụ Ăn Uống', 'FB', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('GN', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Gala dinner / Tiệc họp mặt', 'Tiệc họp mặt', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('HN', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Tuần trăng mật', 'Tuần trăng mật', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('HT', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Refund/ Hoàn trả khách', 'Hoàn trả khách', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('KC', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Key card / Mất thẻ phòng', 'Key card', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('KI', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Kid Surcharge', 'Kid Surcharge', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('LA', (SELECT id FROM service_departments WHERE department_name = 'House Keeping/Buồng Phòng' LIMIT 1), 'Laundry/Giặt Ủi', 'Laundry/Giặt Ủi', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('LH', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Lunch / Ăn trưa', 'Lunch / Ăn trưa', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'NG', 0),
('LO', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Late Checkout/Phụ Thu Trả Phòng Trễ', 'Late Checkout', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('MB', (SELECT id FROM service_departments WHERE department_name = 'House Keeping/Buồng Phòng' LIMIT 1), 'Minibar/Phí Minibar', 'Minibar', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('MR', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Meeting / Phòng họp', 'Meeting / Phòng họp', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('MS', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Other/Dịch Vụ Khác', 'Other', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('NB', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Giường Nội Bộ', 'Giường Nội Bộ', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('OT', (SELECT id FROM service_departments WHERE department_name = 'Restaurant/Nhà Hàng' LIMIT 1), 'Dịch Vụ Khác (FB)', 'Dịch Vụ Khác NH', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('PU', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Pick up from the airport/ Đưa đón sân bay', 'Đưa đón sân bay', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('RB', (SELECT id FROM service_departments WHERE department_name = 'Restaurant/Nhà Hàng' LIMIT 1), 'Beverage/ Thức uống', 'Beverage/ Thức uống', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('RF', (SELECT id FROM service_departments WHERE department_name = 'Restaurant/Nhà Hàng' LIMIT 1), 'Food/ Thức ăn', 'Food/ Thức ăn', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('RM', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Dịch vụ phòng nghỉ', 'Dịch vụ phòng nghỉ', NULL, 5, 8, 0, TRUE, TRUE, FALSE, 1, 'DEM', 0),
('TB', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Dịch vụ charge phòng nghỉ', 'Dịch vụ phòng nghỉ', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('TK', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Vé ăn sáng 90k', 'Vé ăn sáng 90k', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 90000),
('TO', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Tour/ Tham quan', 'Tour/ Tham quan', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('TW', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Charge tiền khăn biển', 'Khăn biển', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 250000),
('UP', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Upgrade/ Phí nâng hạng phòng', 'Phí nâng hạng phòng', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('VV', (SELECT id FROM service_departments WHERE department_name = 'Accounting/ Kế Toán' LIMIT 1), 'VV', 'VV', NULL, 5, 10, 0, TRUE, TRUE, TRUE, 1, NULL, 0),
('WS', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Dịch vụ đám cưới', 'Dịch vụ đám cưới', NULL, 5, 8, 0, TRUE, TRUE, TRUE, 1, 'DV', 0),
('XM', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1), 'Thuê xe', 'Thuê xe', NULL, 5, 10, 0, TRUE, TRUE, TRUE, 1, 'DV', 0);


-- 12. Tạo bảng liên kết giữa Hình thức thanh toán và Bộ phận (Payment Method Departments)
CREATE TABLE IF NOT EXISTS payment_method_departments (
    payment_method_code VARCHAR(50) COMMENT 'Khóa ngoại tới Payment Methods',
    department_id INT COMMENT 'Khóa ngoại tới Service Departments',
    PRIMARY KEY (payment_method_code, department_id),
    FOREIGN KEY (payment_method_code) REFERENCES payment_methods(payment_code) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES service_departments(id) ON DELETE CASCADE
);

INSERT INTO payment_method_departments (payment_method_code, department_id) VALUES
('BT', (SELECT id FROM service_departments WHERE department_name = 'Reception/ Lễ Tân' LIMIT 1)),
('BT', (SELECT id FROM service_departments WHERE department_name = 'Restaurant/Nhà Hàng' LIMIT 1));


-- 13. Tạo bảng cấu hình mã giá phòng (Rate Plans)
CREATE TABLE IF NOT EXISTS rate_plans (
    plan_code VARCHAR(50) PRIMARY KEY COMMENT 'Mã giá (VD: B2B, FOC, ST)',
    plan_description VARCHAR(255) DEFAULT NULL COMMENT 'Mô tả',
    currency_code VARCHAR(10) DEFAULT 'VND' COMMENT 'Khóa ngoại Tiền tệ',
    date_from DATE NOT NULL COMMENT 'Ngày bắt đầu áp dụng',
    date_to DATE NOT NULL COMMENT 'Ngày kết thúc áp dụng',
    is_daily_rate BOOLEAN DEFAULT TRUE COMMENT 'Giá theo ngày',
    is_inactive BOOLEAN DEFAULT FALSE COMMENT 'Không sử dụng',
    allow_rate_input BOOLEAN DEFAULT TRUE COMMENT 'Cho phép nhập giá',
    push_channel_manager BOOLEAN DEFAULT FALSE COMMENT 'Đẩy lên Channel Manager',
    includes_breakfast BOOLEAN DEFAULT FALSE COMMENT 'Bao gồm ăn sáng',
    apply_days VARCHAR(50) DEFAULT 'T2,T3,T4,T5,T6,T7,CN' COMMENT 'Các ngày trong tuần được áp dụng',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (currency_code) REFERENCES currencies(currency_code) ON DELETE SET NULL
);

INSERT INTO rate_plans (plan_code, plan_description, currency_code, date_from, date_to, is_daily_rate, is_inactive, allow_rate_input, push_channel_manager, includes_breakfast) VALUES
('B2B',   'B2B',    'VND', '2025-05-20', '2026-12-31', TRUE, FALSE, TRUE, FALSE, FALSE),
('FOC',   'FOC',    'VND', '2025-02-06', '2026-02-01', TRUE, FALSE, TRUE, FALSE, FALSE),
('ROB2B', 'RO-B2B', 'VND', '2026-01-02', '2026-12-31', TRUE, FALSE, TRUE, FALSE, FALSE),
('ROBAR', 'RO-BAR', 'VND', '2026-01-02', '2026-12-31', TRUE, FALSE, TRUE, FALSE, FALSE),
('ST',    'BAR',    'VND', '2025-01-01', '2026-12-31', TRUE, FALSE, TRUE, FALSE, FALSE),
('TEST',  'TEST',   'VND', '2026-06-24', '2026-08-31', TRUE, FALSE, TRUE, FALSE, FALSE);


-- 14. Tạo bảng mùa/kỳ giá (Rate Seasons)
CREATE TABLE IF NOT EXISTS rate_seasons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    season_code VARCHAR(50) NOT NULL COMMENT 'Mã mùa/kỳ giá (VD: BB1, BB2, BB3)',
    rate_plan_code VARCHAR(50) NOT NULL COMMENT 'Khóa ngoại tới bảng rate_plans',
    season_description VARCHAR(255) DEFAULT NULL COMMENT 'Mô tả mùa/kỳ (VD: Cao điểm, Thấp điểm)',
    date_from DATE NOT NULL COMMENT 'Ngày bắt đầu mùa/kỳ',
    date_to DATE NOT NULL COMMENT 'Ngày kết thúc mùa/kỳ',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_rate_season (rate_plan_code, season_code),
    FOREIGN KEY (rate_plan_code) REFERENCES rate_plans(plan_code) ON DELETE CASCADE
);

INSERT INTO rate_seasons (season_code, rate_plan_code, season_description, date_from, date_to) VALUES
('BB-PH3', 'B2B', '31/12/2025',           '2025-12-31', '2025-12-31'),
('BB1',    'B2B', 'KM 1/1 - 28/4',        '2026-01-01', '2026-12-31'),
('BB1N',   'B2B', 'KM 8/1 - 15/2',        '2025-05-20', '2025-12-31'),
('BB2',    'B2B', '1/6 - 31/12/2025',      '2025-06-01', '2025-12-31'),
('BB3',    'B2B', 'Cao điểm',              '2026-01-01', '2026-12-31'),
('BB4',    'B2B', 'PH KM 1/1-28/4/2026',  '2026-01-01', '2026-12-31'),
('BB5',    'B2B', 'Thấp điểm',             '2026-01-01', '2026-12-31'),
('BB6',    'B2B', 'PH Thấp điểm',          '2026-01-01', '2026-12-31'),
('BB7',    'B2B', 'Pricing_Feb',           '2026-01-01', '2026-12-31'),
('BBUS',   'B2B', 'BB UPSELL',             '2026-01-01', '2026-12-31');


-- 15. Tạo bảng giá phòng theo mùa/kỳ (Rate Season Prices)
CREATE TABLE IF NOT EXISTS rate_season_prices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rate_season_id INT NOT NULL COMMENT 'Khóa ngoại tới bảng rate_seasons',
    room_type_id INT NOT NULL COMMENT 'Khóa ngoại tới bảng room_types',
    room_form_id INT NOT NULL COMMENT 'Khóa ngoại tới bảng room_forms',
    price DECIMAL(15, 2) DEFAULT 0 COMMENT 'Giá phòng',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_season_room (rate_season_id, room_type_id, room_form_id),
    FOREIGN KEY (rate_season_id) REFERENCES rate_seasons(id) ON DELETE CASCADE,
    FOREIGN KEY (room_type_id) REFERENCES room_types(id) ON DELETE CASCADE,
    FOREIGN KEY (room_form_id) REFERENCES room_forms(id) ON DELETE CASCADE
);

-- Thêm dữ liệu mẫu: Giá phòng cho mùa BBUS của mã giá B2B
INSERT INTO rate_season_prices (rate_season_id, room_type_id, room_form_id, price) VALUES
(
    (SELECT id FROM rate_seasons WHERE season_code = 'BBUS' LIMIT 1), 
    (SELECT id FROM room_types WHERE type_short_name = 'SUPD' LIMIT 1), 
    (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 
    890000
),
(
    (SELECT id FROM rate_seasons WHERE season_code = 'BBUS' LIMIT 1), 
    (SELECT id FROM room_types WHERE type_short_name = 'SUPT' LIMIT 1), 
    (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 
    890000
),
(
    (SELECT id FROM rate_seasons WHERE season_code = 'BBUS' LIMIT 1), 
    (SELECT id FROM room_types WHERE type_short_name = 'SUPTR' LIMIT 1), 
    (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 
    1060000
),
(
    (SELECT id FROM rate_seasons WHERE season_code = 'BBUS' LIMIT 1), 
    (SELECT id FROM room_types WHERE type_short_name = 'DLXD' LIMIT 1), 
    (SELECT id FROM room_forms WHERE form_name = 'Double' LIMIT 1), 
    1000000
),
(
    (SELECT id FROM rate_seasons WHERE season_code = 'BBUS' LIMIT 1), 
    (SELECT id FROM room_types WHERE type_short_name = 'DLXT' LIMIT 1), 
    (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1), 
    1000000
),
(
    (SELECT id FROM rate_seasons WHERE season_code = 'BBUS' LIMIT 1), 
    (SELECT id FROM room_types WHERE type_short_name = 'DLXDB' LIMIT 1), 
    (SELECT id FROM room_forms WHERE form_name = 'Triple' LIMIT 1), 
    1320000
);


-- =====================================================================
-- BẢNG DANH MỤC CHO MODULE ĐĂNG KÝ (BOOKING)
-- =====================================================================

-- 16. Tạo bảng Thị trường (Market Segments)
CREATE TABLE IF NOT EXISTS market_segments (
    code VARCHAR(50) PRIMARY KEY COMMENT 'Mã thị trường',
    name VARCHAR(255) NOT NULL COMMENT 'Tên thị trường',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO market_segments (code, name) VALUES
('OTA', 'Online Travel Agent'),
('FIT', 'Free Individual Traveler'),
('GIT', 'Group Individual Traveler'),
('FOC', 'FOC'),
('WK', 'Walk-In'),
('TA', 'Travel Agent'),
('CORP', 'Corporate'),
('BAT', 'Barter'),
('DAY', 'Day Use'),
('HU', 'House Use'),
('FB', 'Fanpage'),
('VC', 'Voucher');


-- 17. Tạo bảng Nguồn khách (Booking Sources)
CREATE TABLE IF NOT EXISTS booking_sources (
    code VARCHAR(50) PRIMARY KEY COMMENT 'Mã nguồn khách',
    name VARCHAR(255) NOT NULL COMMENT 'Tên nguồn khách',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO booking_sources (code, name) VALUES
('OTA', 'Online Travel Agent'),
('FOC', 'FOC'),
('GIT', 'Group Individual Traveler'),
('FIT', 'Free Individual Traveler'),
('WK', 'Walk-In'),
('TA', 'Travel Agent'),
('CORP', 'Corporate'),
('BAT', 'Barter'),
('DAY', 'Day Use'),
('HU', 'House Use'),
('FB', 'Fanpage'),
('VC', 'Voucher');


-- 18. Tạo bảng Chi nhánh (Branches)
CREATE TABLE IF NOT EXISTS branches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL COMMENT 'Tên chi nhánh',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO branches (name) VALUES
('Vĩnh Long'),
('Hải Dương'),
('Phú Thọ'),
('Đắk Nông'),
('Nghệ An'),
('Ninh Thuận'),
('TP.Hồ Chí Minh'),
('Hà Nội'),
('Đà Nẵng'),
('Cần Thơ'),
('Hải Phòng'),
('Bà Rịa - Vũng Tàu'),
('Lâm Đồng');


-- 19. Tạo bảng Công ty (Companies)
CREATE TABLE IF NOT EXISTS companies (
    company_code VARCHAR(50) PRIMARY KEY COMMENT 'Mã công ty',
    name VARCHAR(255) NOT NULL COMMENT 'Tên công ty',
    transaction_name VARCHAR(255) DEFAULT NULL COMMENT 'Tên giao dịch',
    address VARCHAR(255) DEFAULT NULL COMMENT 'Địa chỉ',
    tax_code VARCHAR(50) DEFAULT NULL COMMENT 'Mã số thuế',
    phone VARCHAR(50) DEFAULT NULL COMMENT 'Số điện thoại',
    email VARCHAR(255) DEFAULT NULL COMMENT 'Email',
    booking_source_code VARCHAR(50) DEFAULT NULL COMMENT 'Mã Nguồn khách',
    market_segment_code VARCHAR(50) DEFAULT NULL COMMENT 'Mã Thị trường',
    type VARCHAR(100) DEFAULT NULL COMMENT 'Loại công ty',
    is_acc_synced BOOLEAN DEFAULT FALSE COMMENT 'Đồng bộ ACC',
    max_debt DECIMAL(15, 2) DEFAULT 0 COMMENT 'Công nợ tối đa',
    bank_account VARCHAR(100) DEFAULT NULL COMMENT 'Tài khoản ngân hàng',
    booker_name VARCHAR(255) DEFAULT NULL COMMENT 'Người đặt phòng',
    rate_plan_code VARCHAR(50) DEFAULT NULL COMMENT 'Mã giá phòng',
    business_field VARCHAR(255) DEFAULT NULL COMMENT 'Lĩnh vực hoạt động',
    branch_id INT DEFAULT NULL COMMENT 'Chi nhánh',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_source_code) REFERENCES booking_sources(code) ON DELETE SET NULL,
    FOREIGN KEY (market_segment_code) REFERENCES market_segments(code) ON DELETE SET NULL,
    FOREIGN KEY (rate_plan_code) REFERENCES rate_plans(plan_code) ON DELETE SET NULL,
    FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE SET NULL
);

INSERT INTO companies (company_code, name, transaction_name, address, booking_source_code, market_segment_code, is_acc_synced, phone) VALUES
('CTY0001', 'KHÁCH LẺ', 'KHÁCH LẺ', 'Khách hàng không lấy hoá đơn', 'FIT', 'FIT', TRUE, NULL),
('CTY0002', 'AGODA', 'AGODA', NULL, 'OTA', 'OTA', FALSE, NULL),
('CTY0003', 'BOOKING.COM', 'BOOKING.COM', NULL, 'OTA', 'OTA', FALSE, NULL),
('CTY0004', 'TRIP.COM', 'TRIP.COM', NULL, 'OTA', 'OTA', FALSE, NULL),
('CTY0005', 'EXPEDIA', 'EXPEDIA', NULL, 'OTA', 'OTA', FALSE, NULL),
('CTY0006', 'TRAVELOKA', 'TRAVELOKA', NULL, 'OTA', 'OTA', FALSE, NULL),
('CTY0007', 'HOTELBEDS', 'HOTELBEDS', NULL, 'OTA', 'OTA', FALSE, NULL),
('CTY0008', 'OHMYHOTEL', 'CÔNG TY TNHH OHMYHOTEL&CO VN', 'Khu F7-BCD, Tầng 7, Toà nhà Mach, 127 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.Hồ Chí Minh', 'OTA', 'OTA', FALSE, '0314937097');


-- 20. Tạo bảng Người đặt phòng (Bookers)
CREATE TABLE IF NOT EXISTS bookers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL COMMENT 'Tên người đặt',
    email VARCHAR(255) DEFAULT NULL COMMENT 'Email',
    phone VARCHAR(50) DEFAULT NULL COMMENT 'Số điện thoại',
    address VARCHAR(255) DEFAULT NULL COMMENT 'Địa chỉ',
    notes TEXT COMMENT 'Ghi chú',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO bookers (name, phone, email) VALUES
('MR. BÌNH', '0915768835', NULL),
('MR TRƯỜNG', '0973751814', NULL),
('ms Lien', '0984030395', NULL),
('Ms. Thom', NULL, NULL),
('Nguyễn Thị Hà Sơn', '0978912075', 'Hasonnguyen7486@gmail.com'),
('MS LIỄU', '0908722336', NULL);


-- 21. Tạo bảng Công ty thành viên (Member Companies)
CREATE TABLE IF NOT EXISTS member_companies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL COMMENT 'Tên công ty thành viên',
    notes TEXT COMMENT 'Ghi chú',
    is_active BOOLEAN DEFAULT TRUE COMMENT 'Sử dụng',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO member_companies (name, is_active) VALUES
('CNTT', TRUE),
('HT', FALSE),
('XNCG', TRUE);


-- 22. Tạo bảng Phòng ban quản lý (Management Departments)
CREATE TABLE IF NOT EXISTS management_departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE COMMENT 'Mã phòng ban',
    name VARCHAR(255) NOT NULL COMMENT 'Tên phòng ban',
    is_active BOOLEAN DEFAULT TRUE COMMENT 'Sử dụng',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO management_departments (code, name, is_active) VALUES
('PND', 'PND', FALSE);


-- =====================================================================
-- BẢNG DỮ LIỆU ĐĂNG KÝ (TRANSACTIONAL)
-- =====================================================================

-- 23. Tạo bảng Đăng ký chung (Bookings)
CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT UNIQUE,
    booking_code VARCHAR(50) PRIMARY KEY COMMENT 'Mã đăng ký (Tạo tự động GAL + id)',
    guest_name VARCHAR(255) NOT NULL COMMENT 'Tên đăng ký',
    check_in DATE NOT NULL COMMENT 'Ngày đến',
    check_out DATE NOT NULL COMMENT 'Ngày đi',
    nights INT DEFAULT 0 COMMENT 'Số đêm',
    status_id INT COMMENT 'Khóa ngoại tới Trạng thái',
    confirmed_date DATE DEFAULT NULL COMMENT 'Ngày xác nhận',
    company_code VARCHAR(50) DEFAULT NULL COMMENT 'Khóa ngoại tới Công ty',
    member_company_id INT DEFAULT NULL COMMENT 'Khóa ngoại tới Công ty thành viên',
    management_department_code VARCHAR(50) DEFAULT NULL COMMENT 'Mã Phòng ban quản lý',
    payment_method_code VARCHAR(50) DEFAULT NULL COMMENT 'Phương thức thanh toán',
    reference_code VARCHAR(100) DEFAULT NULL COMMENT 'Mã tham chiếu',
    deposit DECIMAL(15, 2) DEFAULT 0 COMMENT 'Đặt cọc',
    seller VARCHAR(255) DEFAULT NULL COMMENT 'Người bán',
    remaining_debt DECIMAL(15, 2) DEFAULT 0 COMMENT 'Công nợ còn lại',
    market_segment_code VARCHAR(50) DEFAULT NULL COMMENT 'Thị trường',
    booking_source_code VARCHAR(50) DEFAULT NULL COMMENT 'Nguồn khách',
    booker_id INT DEFAULT NULL COMMENT 'Người đặt phòng',
    notes TEXT COMMENT 'Ghi chú',
    special_requests TEXT COMMENT 'Yêu cầu đặc biệt (BK Confirm)',
    is_git BOOLEAN DEFAULT FALSE COMMENT 'GIT toggle',
    is_vat BOOLEAN DEFAULT FALSE COMMENT 'VAT toggle',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (status_id) REFERENCES reservation_statuses(id) ON DELETE SET NULL,
    FOREIGN KEY (company_code) REFERENCES companies(company_code) ON DELETE SET NULL,
    FOREIGN KEY (member_company_id) REFERENCES member_companies(id) ON DELETE SET NULL,
    FOREIGN KEY (management_department_code) REFERENCES management_departments(code) ON DELETE SET NULL,
    FOREIGN KEY (payment_method_code) REFERENCES payment_methods(payment_code) ON DELETE SET NULL,
    FOREIGN KEY (market_segment_code) REFERENCES market_segments(code) ON DELETE SET NULL,
    FOREIGN KEY (booking_source_code) REFERENCES booking_sources(code) ON DELETE SET NULL,
    FOREIGN KEY (booker_id) REFERENCES bookers(id) ON DELETE SET NULL
);

-- Tạo Trigger tự động sinh booking_code (GAL + id)
DELIMITER //
CREATE TRIGGER trg_bookings_before_insert
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
    IF @next_booking_id IS NULL THEN
        SELECT AUTO_INCREMENT INTO @next_booking_id
        FROM information_schema.tables
        WHERE table_name = 'bookings' AND table_schema = DATABASE();
    END IF;
    
    IF NEW.booking_code IS NULL OR NEW.booking_code = '' THEN
        SET NEW.booking_code = CONCAT('GAL', @next_booking_id);
        SET @next_booking_id = @next_booking_id + 1;
    END IF;
END //
DELIMITER ;

-- 24. Tạo bảng Chi tiết Phòng Đăng Ký (Booking Rooms)
CREATE TABLE IF NOT EXISTS booking_rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_code VARCHAR(50) NOT NULL COMMENT 'Khóa ngoại tới Bookings',
    room_type_id INT COMMENT 'Khóa ngoại tới Room Types',
    room_form_id INT COMMENT 'Khóa ngoại tới Room Forms',
    room_code VARCHAR(50) COMMENT 'Khóa ngoại tới Rooms (Mã phòng)',
    check_in DATE NOT NULL COMMENT 'Ngày đến của phòng',
    check_out DATE NOT NULL COMMENT 'Ngày đi của phòng',
    nights INT DEFAULT 0 COMMENT 'Đêm',
    price DECIMAL(15, 2) DEFAULT 0 COMMENT 'Giá phòng',
    rate_plan_code VARCHAR(50) DEFAULT NULL COMMENT 'Mã giá phòng',
    discount DECIMAL(15, 2) DEFAULT 0 COMMENT 'Giảm/tăng giá',
    guest_name VARCHAR(255) DEFAULT NULL COMMENT 'Tên khách',
    adults INT DEFAULT 0 COMMENT 'N.Lớn',
    children INT DEFAULT 0 COMMENT 'Trẻ em',
    infants INT DEFAULT 0 COMMENT 'Em bé',
    child_breakfast_price DECIMAL(15, 2) DEFAULT 0 COMMENT 'Giá ăn sáng trẻ em',
    includes_breakfast BOOLEAN DEFAULT FALSE COMMENT 'Ăn sáng',
    extra_bed BOOLEAN DEFAULT FALSE COMMENT 'Thêm giường',
    extra_bed_price DECIMAL(15, 2) DEFAULT 0 COMMENT 'Giá thêm giường',
    hourly_rental BOOLEAN DEFAULT FALSE COMMENT 'Ở theo giờ',
    special_requests TEXT COMMENT 'Yêu cầu đặc biệt',
    arrival_time TIME DEFAULT NULL COMMENT 'Giờ đến',
    departure_time TIME DEFAULT NULL COMMENT 'Giờ đi',
    reserved BOOLEAN DEFAULT FALSE COMMENT 'Đặt trước',
    created_by VARCHAR(255) DEFAULT NULL COMMENT 'LP Khởi tạo',
    transfer_room VARCHAR(255) DEFAULT NULL COMMENT 'Phòng chuyển',
    room_status VARCHAR(100) DEFAULT NULL COMMENT 'Trạng thái phòng',
    alm_code VARCHAR(100) DEFAULT NULL COMMENT 'Mã ALM',
    total_amount DECIMAL(15, 2) DEFAULT 0 COMMENT 'Tổng cộng',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_code) REFERENCES bookings(booking_code) ON DELETE CASCADE,
    FOREIGN KEY (room_type_id) REFERENCES room_types(id) ON DELETE SET NULL,
    FOREIGN KEY (room_form_id) REFERENCES room_forms(id) ON DELETE SET NULL,
    FOREIGN KEY (room_code) REFERENCES rooms(room_code) ON DELETE SET NULL,
    FOREIGN KEY (rate_plan_code) REFERENCES rate_plans(plan_code) ON DELETE SET NULL
);

-- Insert dữ liệu mẫu từ ảnh
INSERT INTO bookings (
    booking_code, guest_name, check_in, check_out, nights, status_id, confirmed_date, company_code, 
    payment_method_code, reference_code, deposit, seller, market_segment_code, booking_source_code, booker_id
) VALUES (
    '', 'Nguyễn Văn A', '2026-06-24', '2026-06-29', 5, 
    (SELECT id FROM reservation_statuses WHERE status_name = 'Guaranteed' LIMIT 1), '2026-06-24', 
    'CTY0001', 'CA', '24110011', 0, 'Demo', 'FIT', 'FIT',
    (SELECT id FROM bookers WHERE name = 'MR TRƯỜNG' LIMIT 1)
);

INSERT INTO booking_rooms (
    booking_code, room_type_id, room_form_id, room_code, check_in, check_out, nights, price, rate_plan_code, 
    guest_name, adults, children, infants, child_breakfast_price, includes_breakfast, extra_bed, 
    extra_bed_price, hourly_rental, arrival_time, departure_time, room_status, alm_code, total_amount
) VALUES 
(
    (SELECT booking_code FROM bookings WHERE guest_name = 'Nguyễn Văn A' LIMIT 1),
    (SELECT id FROM room_types WHERE type_short_name = 'SUPT' LIMIT 1), 
    (SELECT id FROM room_forms WHERE form_name = 'Twin' LIMIT 1),
    (SELECT room_code FROM rooms WHERE room_number = '904' LIMIT 1),
    '2026-06-24', '2026-06-29', 5, 670000, 'B2B', 'Guest 1', 2, 0, 0, 90000, TRUE, TRUE, 300000, FALSE, '14:00:00', '12:00:00', 'Vacant Dirty', 'G0019233', 4850000
),
(
    (SELECT booking_code FROM bookings WHERE guest_name = 'Nguyễn Văn A' LIMIT 1),
    (SELECT id FROM room_types WHERE type_short_name = 'FAM' LIMIT 1), 
    (SELECT id FROM room_forms WHERE form_name = 'Family' LIMIT 1),
    (SELECT room_code FROM rooms WHERE room_number = '1205' LIMIT 1),
    '2026-06-24', '2026-06-29', 5, 1330000, 'B2B', 'Guest 1', 2, 2, 0, 90000, TRUE, FALSE, 0, FALSE, '14:00:00', '12:00:00', 'Vacant Ready', 'G0019232', 6650000
);


-- =====================================================================
-- BẢNG DANH MỤC BỔ SUNG
-- =====================================================================

-- 25. Tạo bảng Yêu cầu đặc biệt (Special Requests)
CREATE TABLE IF NOT EXISTS special_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    request_name VARCHAR(255) NOT NULL COMMENT 'Tên yêu cầu đặc biệt',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO special_requests (request_name) VALUES
('Honeymoon'),
('High Floor'),
('Low Floor'),
('Same Floor'),
('Room Near By'),
('Quite Room'),
('Window required');


-- =====================================================================
-- BẢNG KHÓA PHÒNG (ROOM LOCKS)
-- =====================================================================

-- 26. Tạo bảng Khóa phòng (Room Locks)
CREATE TABLE IF NOT EXISTS room_locks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_code VARCHAR(50) NOT NULL COMMENT 'Khóa ngoại tới Rooms',
    lock_type VARCHAR(50) DEFAULT 'OOS' COMMENT 'Loại khóa (OOO / OOS)',
    start_date DATE NOT NULL COMMENT 'Ngày bắt đầu',
    end_date DATE DEFAULT NULL COMMENT 'Ngày kết thúc',
    lock_description TEXT COMMENT 'Mô tả khóa',
    maintenance_percent DECIMAL(5, 2) DEFAULT 0 COMMENT 'Bảo trì (%)',
    status VARCHAR(100) DEFAULT 'New' COMMENT 'Trạng thái',
    locked_by VARCHAR(255) DEFAULT NULL COMMENT 'Người dùng (Người khóa)',
    notes TEXT COMMENT 'Ghi chú',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (room_code) REFERENCES rooms(room_code) ON DELETE CASCADE
);

-- Insert dữ liệu mẫu từ ảnh (Lịch sử khóa phòng 401)
INSERT INTO room_locks (room_code, lock_type, start_date, end_date, lock_description, maintenance_percent, status, locked_by) VALUES
(
    (SELECT room_code FROM rooms WHERE room_number = '401' LIMIT 1),
    'OOS', '2025-05-08', '2025-05-13', 'tháo rèm giặt', 0, 'New', 'NB0016'
);
