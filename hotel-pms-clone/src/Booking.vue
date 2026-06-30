<template>
  <div class="registration-wrapper">
    <div class="reg-header-bar">
      <div class="header-title">
        <span class="title-text">Booking GAL4947</span>
        <a class="btn-add-booking">
          <svg width="20" height="20" viewBox="0 0 24 24">
            <path
              d="M12 5v14M5 12h14"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
            />
          </svg>
        </a>
      </div>
      <div class="header-actions">
        <button class="btn-action btn-info">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <circle cx="12" cy="12" r="10" fill="none" stroke="currentColor" stroke-width="2" />
            <path
              d="M12 16v-4m0-4h.01"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
            />
          </svg>
          Thông tin đăng ký
        </button>
        <button class="btn-action btn-edit">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <path
              d="M12 20h9M16.5 3.5a2.121 2.121 0 013 3L7 19l-4 1 1-4L16.5 3.5z"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Sửa
        </button>
        <button class="btn-action btn-save">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <path
              d="M19 21H5a2 2 0 01-2-2V5a2 2 0 012-2h11l5 5v11a2 2 0 01-2 2zM17 21v-8H7v8M7 3v5h8"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Lưu
        </button>
        <button class="btn-action btn-duplicate">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <rect
              x="9"
              y="9"
              width="11"
              height="11"
              rx="2"
              ry="2"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
            />
            <path
              d="M5 15H4a2 2 0 01-2-2V4a2 2 0 012-2h9a2 2 0 012 2v1"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Nhân bản
        </button>
        <button class="btn-action btn-delete">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <path
              d="M3 6h18M19 6v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6m3 0V4a2 2 0 012-2h4a2 2 0 012 2v2"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Xoá
        </button>
        <button class="btn-action btn-print">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <path
              d="M6 9V2h12v7M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2M6 14h12v8H6z"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linejoin="round"
            />
          </svg>
          In ⋮
        </button>
        <button class="btn-action btn-notify">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <path
              d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9M13.73 21a2 2 0 01-3.46 0"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Thông báo
        </button>
        <div class="search-box">
          <svg class="icon-search-small" viewBox="0 0 24 24">
            <path
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              fill="none"
              stroke="#666"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          <input type="text" placeholder="Tìm kiếm" />
          <svg class="icon-filter-small" viewBox="0 0 24 24">
            <path
              d="M22 3H2l8 9.46V19l4 2v-8.54L22 3z"
              fill="none"
              stroke="#666"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
        </div>
      </div>
    </div>

    <div class="reg-meta-info">
      <span class="meta-item">Tên đăng ký: <strong>LOCK CHO ANH KHÁNH TCO</strong></span>
      <span class="meta-item">Trạng thái: <strong class="text-green">Guaranteed</strong></span>
      <span class="meta-item">Ngày đến: <strong>24/06/2026</strong></span>
      <span class="meta-item">Ngày đi: <strong>27/06/2026</strong></span>
      <span class="meta-item">Đặt cọc: <strong>0</strong></span>
      <span class="meta-item">Công ty: <strong>TA GM</strong></span>
      <span class="meta-item">Xác nhận: <strong>08/05/2026</strong></span>
    </div>

    <div class="table-toolbar">
      <div class="toolbar-left">
        <div class="toolbar-search">
          <input type="text" />
          <button class="btn-search-blue">
            <svg class="icon-svg-sm" viewBox="0 0 24 24">
              <path
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
          </button>
        </div>
      </div>
      <div class="toolbar-right">
        <button class="btn-func">Chức năng</button>
        <select class="select-action">
          <option>Chọn: 0</option>
        </select>
        <button class="btn-icon-setting">
          <svg class="icon-svg-settings" viewBox="0 0 24 24">
            <path
              d="M12 15a3 3 0 100-6 3 3 0 000 6z"
              fill="none"
              stroke="#666"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
            <path
              d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-2 2 2 2 0 01-2-2v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83 0 2 2 0 010-2.83l.06-.06a1.65 1.65 0 00.33-1.82 1.65 1.65 0 00-1.51-1H3a2 2 0 01-2-2 2 2 0 012-2h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 010-2.83 2 2 0 012.83 0l.06.06a1.65 1.65 0 001.82.33H9a1.65 1.65 0 001-1.51V3a2 2 0 012-2 2 2 0 012 2v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 0 2 2 0 010 2.83l-.06.06a1.65 1.65 0 00-.33 1.82V9a1.65 1.65 0 001.51 1H21a2 2 0 012 2 2 2 0 01-2 2h-.09a1.65 1.65 0 00-1.51 1z"
              fill="none"
              stroke="#666"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
        </button>
        <button class="btn-invoice">
          <svg class="icon-svg-sm" viewBox="0 0 24 24">
            <path
              d="M12 1v22M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Hoá đơn
        </button>
      </div>
    </div>

    <div class="table-responsive">
      <table class="pms-data-table">
        <thead>
          <tr>
            <th class="col-icon"></th>
            <th class="col-check"></th>
            <th>STT</th>
            <th>Loại phòng</th>
            <th>Dạng phòng</th>
            <th>Số phòng</th>
            <th>Ngày đến</th>
            <th>Ngày đi</th>
            <th>Đêm</th>
            <th>Giá</th>
            <th>Mã giá phòng</th>
            <th>Giảm/tăng giá</th>
            <th>Tên khách</th>
            <th>N.Lớn</th>
            <th>Em bé</th>
            <th>Trẻ em</th>
            <th>Chi tiết ăn sáng trẻ</th>
            <th>Ăn sáng</th>
            <th>Thêm giường</th>
            <th>Giá thêm giường</th>
            <th>Ở theo giờ</th>
            <th>Yêu cầu đặc biệt</th>
            <th>Giờ đến</th>
            <th>Giờ đi</th>
            <th>Đặt trước</th>
            <th>LP Khởi tạo</th>
            <th>Phòng chuyển</th>
            <th>Trạng thái phòng</th>
            <th>Mã ALM</th>
            <th>Mã phòng</th>
            <th class="sticky-col-right">Tổng cộng</th>
          </tr>
        </thead>
        <tbody>
          <tr class="group-row">
            <td class="text-center"><button class="btn-collapse">-</button></td>
            <td><input type="checkbox" /></td>
            <td colspan="28">
              <div class="group-title">
                <strong>Tình trạng:Đăng ký (3)</strong>
                <input type="range" min="0" max="100" value="0" class="custom-slider ml-2" />
              </div>
            </td>
            <td class="sticky-col-right bg-group"></td>
          </tr>

          <tr class="sub-group-row">
            <td class="text-center"><button class="btn-collapse">-</button></td>
            <td><input type="checkbox" /></td>
            <td colspan="28"><strong>Deluxe Twin City View (2)</strong></td>
            <td class="sticky-col-right bg-sub-group"></td>
          </tr>

          <tr v-for="(room, index) in tableData.deluxeTwin" :key="'dt-' + index" class="data-row">
            <td class="text-center"><button class="btn-expand">+</button></td>
            <td><input type="checkbox" /></td>
            <td class="text-center">{{ index + 1 }}</td>
            <td>Deluxe Twin City View</td>
            <td>Twin</td>
            <td class="text-bold">{{ room.roomNo }}</td>
            <td>24/06/2026</td>
            <td>27/06/2026</td>
            <td class="text-center">3</td>
            <td class="text-right">600,000</td>
            <td><input type="text" class="input-table" placeholder="Vui lòng chọn giá phòng" /></td>
            <td></td>
            <td>Guest 1</td>
            <td class="text-center">2</td>
            <td class="text-center">0</td>
            <td class="text-center">0</td>
            <td class="text-center"><button class="btn-detail">Chi tiết</button></td>
            <td class="text-center">
              <label class="ios-switch"
                ><input type="checkbox" checked /><span class="slider"></span
              ></label>
            </td>
            <td class="text-center">
              <span class="mr-1">0</span> <button class="btn-detail">Chi tiết</button>
            </td>
            <td class="text-center">0</td>
            <td class="text-center">
              <label class="ios-switch"
                ><input type="checkbox" /><span class="slider"></span
              ></label>
            </td>
            <td class="text-center"><button class="btn-detail">Yêu cầu đặc biệt</button></td>
            <td class="text-center">14:00</td>
            <td class="text-center">12:00</td>
            <td></td>
            <td>{{ room.initType }}</td>
            <td></td>
            <td>{{ room.status }}</td>
            <td></td>
            <td>{{ room.roomCode }}</td>
            <td class="text-right text-bold sticky-col-right bg-white">1,800,000</td>
          </tr>

          <tr class="sub-group-row">
            <td class="text-center"><button class="btn-collapse">-</button></td>
            <td><input type="checkbox" /></td>
            <td colspan="28"><strong>Deluxe Twin with Balcony (1)</strong></td>
            <td class="sticky-col-right bg-sub-group"></td>
          </tr>

          <tr
            v-for="(room, index) in tableData.deluxeBalcony"
            :key="'db-' + index"
            class="data-row"
          >
            <td class="text-center"><button class="btn-expand">+</button></td>
            <td><input type="checkbox" /></td>
            <td class="text-center">3</td>
            <td>Deluxe Twin with Balcony</td>
            <td>Twin</td>
            <td class="text-bold">{{ room.roomNo }}</td>
            <td>24/06/2026</td>
            <td>27/06/2026</td>
            <td class="text-center">3</td>
            <td class="text-right">720,000</td>
            <td><input type="text" class="input-table" placeholder="Vui lòng chọn giá phòng" /></td>
            <td></td>
            <td>Guest 1</td>
            <td class="text-center">3</td>
            <td class="text-center">0</td>
            <td class="text-center">0</td>
            <td class="text-center"><button class="btn-detail">Chi tiết</button></td>
            <td class="text-center">
              <label class="ios-switch"
                ><input type="checkbox" checked /><span class="slider"></span
              ></label>
            </td>
            <td class="text-center">
              <span class="mr-1">0</span> <button class="btn-detail">Chi tiết</button>
            </td>
            <td class="text-center">0</td>
            <td class="text-center">
              <label class="ios-switch"
                ><input type="checkbox" /><span class="slider"></span
              ></label>
            </td>
            <td class="text-center"><button class="btn-detail">Yêu cầu đặc biệt</button></td>
            <td class="text-center">14:00</td>
            <td class="text-center">12:00</td>
            <td></td>
            <td></td>
            <td></td>
            <td>{{ room.status }}</td>
            <td></td>
            <td>{{ room.roomCode }}</td>
            <td class="text-right text-bold sticky-col-right bg-white">2,160,000</td>
          </tr>
        </tbody>
        <tfoot>
          <tr class="footer-row">
            <td colspan="9" class="text-bold">Tổng: 3</td>
            <td class="text-right text-bold">5,760,000</td>
            <td colspan="3"></td>
            <td class="text-center text-bold">7</td>
            <td class="text-center text-bold">0</td>
            <td class="text-center text-bold">0</td>
            <td colspan="14"></td>
            <td class="text-right text-bold total-highlight sticky-col-right">5,760,000</td>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'

const tableData = reactive({
  deluxeTwin: [
    { roomNo: '1410', initType: 'DLXT', status: 'Vacant Clean', roomCode: 'G0018258' },
    { roomNo: '1406', initType: 'DLXDB', status: 'Vacant Dirty', roomCode: 'G0018259' },
  ],
  deluxeBalcony: [{ roomNo: '802', initType: '', status: 'Vacant Dirty', roomCode: 'G0018260' }],
})
</script>

<style scoped>
/* Tổng quan */
.registration-wrapper {
  font-family: Arial, sans-serif;
  font-size: 13px;
  color: #333;
  background-color: #fff;
  border: 1px solid #ddd;
  display: flex;
  flex-direction: column;
  height: 100%;
}

/* --- Header Bar --- */
.reg-header-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  background-color: #e9ecef;
  border-bottom: 1px solid #ddd;
}
.header-title {
  display: flex;
  align-items: center;
  gap: 10px;
}
.title-text {
  font-size: 15px;
  font-weight: bold;
  color: #5bc0de;
  border: 1px solid white;
  border-radius: 10px;
  background-color: white;
  padding: 5px;
}
.btn-add-booking {
  background: transparent;
  color: #5bc0de;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.header-actions {
  display: flex;
  gap: 6px;
  align-items: center;
}
.btn-action {
  padding: 5px 10px;
  border: none;
  border-radius: 4px;
  color: #fff;
  cursor: pointer;
  font-size: 13px;
  display: flex;
  align-items: center;
  gap: 5px;
}
.icon-svg {
  width: 14px;
  height: 14px;
}
.btn-info,
.btn-print,
.btn-notify,
.btn-edit,
.btn-duplicate,
.btn-delete {
  background-color: #5bc0de;
}
.btn-save {
  background-color: #5bc0de;
}

.search-box {
  display: flex;
  align-items: center;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 4px 8px;
  background: #fff;
  gap: 5px;
}
.search-box input {
  border: none;
  outline: none;
  width: 130px;
  font-size: 12px;
}
.icon-search-small,
.icon-filter-small {
  width: 14px;
  height: 14px;
}

/* --- Meta Info --- */
.reg-meta-info {
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
  padding: 10px;
  border-bottom: 1px solid #ddd;
}
.meta-item {
  font-size: 13px;
}
.text-green {
  color: #28a745;
}

/* --- Table Toolbar --- */
.table-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 10px;
  background: #fff;
}
.toolbar-left,
.toolbar-right {
  display: flex;
  align-items: center;
  gap: 8px;
}
.toolbar-search {
  display: flex;
  border: 1px solid #ccc;
  border-radius: 3px;
  overflow: hidden;
}
.toolbar-search input {
  border: none;
  padding: 4px;
  width: 120px;
  outline: none;
}
.btn-search-blue {
  background: #5bc0de;
  border: none;
  color: #fff;
  padding: 4px 8px;
  cursor: pointer;
  display: flex;
}
.btn-func {
  background: #5bc0de;
  color: #fff;
  border: none;
  padding: 5px 15px;
  border-radius: 3px;
  cursor: pointer;
}
.select-action {
  padding: 4px;
  border: 1px solid #ccc;
  border-radius: 3px;
  outline: none;
}
.btn-icon-setting {
  background: none;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  padding: 0;
}
.icon-svg-settings {
  width: 18px;
  height: 18px;
}
.icon-svg-sm {
  width: 14px;
  height: 14px;
}
.btn-invoice {
  background: #5bc0de;
  color: #fff;
  border: none;
  padding: 5px 10px;
  border-radius: 3px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}

/* --- Data Table --- */
.table-responsive {
  width: 100%;
  overflow-x: auto;
  border-top: 1px solid #ddd;
  position: relative;
}
.pms-data-table {
  width: max-content;
  border-collapse: collapse;
  min-width: 100%;
}
.pms-data-table th,
.pms-data-table td {
  border: 1px solid #e0e0e0;
  padding: 6px 8px;
  vertical-align: middle;
  white-space: nowrap;
}
.pms-data-table th {
  background-color: #e9ecef;
  font-weight: bold;
  text-align: center;
  color: #333;
}
.col-icon,
.col-check {
  width: 30px;
}

/* Group & Subgroup */
.group-row {
  background-color: #fafafa;
}
.sub-group-row {
  background-color: #fff;
}
.group-title {
  display: flex;
  align-items: center;
}

/* CSS MỚI CHO THANH KÉO (SLIDER) */
.custom-slider {
  -webkit-appearance: none;
  appearance: none;
  width: 120px;
  height: 2px; /* Đường track mảnh */
  background: #e0e0e0;
  outline: none;
  border-radius: 2px;
}
.custom-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 32px; /* Hình dáng viên thuốc */
  height: 12px;
  border-radius: 6px;
  background: #90d4e8; /* Xanh lợt như trong hình */
  cursor: pointer;
}
.custom-slider::-moz-range-thumb {
  width: 32px;
  height: 12px;
  border-radius: 6px;
  background: #90d4e8;
  cursor: pointer;
  border: none;
}

/* Expand/Collapse Buttons */
.btn-collapse,
.btn-expand {
  width: 18px;
  height: 18px;
  border: none;
  color: #fff;
  font-size: 14px;
  line-height: 0;
  font-weight: bold;
  cursor: pointer;
  border-radius: 3px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}
.btn-collapse,
.btn-expand {
  background-color: #5bc0de;
}

/* Data Rows */
.data-row:hover td:not(.sticky-col-right) {
  background-color: #f9f9f9;
}
.data-row:hover .bg-white {
  background-color: #f9f9f9;
}
.input-table {
  border: 1px solid #ccc;
  padding: 4px;
  border-radius: 2px;
  width: 140px;
  outline: none;
}
.btn-detail {
  background-color: #5bc0de;
  color: #fff;
  border: none;
  border-radius: 3px;
  padding: 4px 8px;
  cursor: pointer;
  font-size: 12px;
}

/* FOOTER */
tfoot .footer-row {
  background-color: #e9ecef;
}
.total-highlight {
  background-color: #d8d8d8;
}

/* STICKY COLUMN RIGHT */
.sticky-col-right {
  position: sticky;
  right: 0;
  z-index: 2;
  box-shadow: -2px 0 5px rgba(0, 0, 0, 0.06);
}
th.sticky-col-right {
  background-color: #e9ecef;
  z-index: 3;
}
.bg-group {
  background-color: #fafafa;
}
.bg-sub-group {
  background-color: #fff;
}
.bg-white {
  background-color: #fff;
}
tfoot .sticky-col-right {
  background-color: #d8d8d8;
}

/* Utilities */
.text-center {
  text-align: center;
}
.text-right {
  text-align: right;
}
.text-bold {
  font-weight: bold;
}
.ml-2 {
  margin-left: 8px;
}
.mr-1 {
  margin-right: 4px;
}

/* CÔNG TẮC BẬT TẮT (Cho các cột bên dưới) */
.ios-switch {
  position: relative;
  display: inline-block;
  width: 34px;
  height: 18px;
  vertical-align: middle;
}
.ios-switch input {
  opacity: 0;
  width: 0;
  height: 0;
}
.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  transition: 0.2s;
  border-radius: 18px;
}
.slider:before {
  position: absolute;
  content: '';
  height: 14px;
  width: 14px;
  left: 2px;
  bottom: 2px;
  background-color: white;
  transition: 0.2s;
  border-radius: 50%;
}
input:checked + .slider {
  background-color: #90d4e8;
}
input:checked + .slider:before {
  transform: translateX(16px);
}
</style>
