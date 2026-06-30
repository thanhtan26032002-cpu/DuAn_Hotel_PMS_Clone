<template>
  <div class="statistics-wrapper">
    <div class="toolbar">
      <label class="custom-toggle">
        <input type="checkbox" checked />
        <span class="slider round"></span>
        <span class="toggle-label">Thống kê phòng</span>
      </label>

      <div class="date-picker-box">
        <span class="date-text">24 / 06 / 2026 ~ 24 / 06 / 2026</span>
        <svg class="icon-calendar" viewBox="0 0 24 24">
          <path
            d="M19 4h-1V2h-2v2H8V2H6v2H5c-1.11 0-1.99.9-1.99 2L3 20a2 2 0 002 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 16H5V10h14v10zm0-12H5V6h14v2zm-7 5h5v5h-5z"
            fill="#28a745"
          />
        </svg>
      </div>

      <label class="custom-checkbox disabled">
        <input type="checkbox" disabled />
        <span class="checkmark"></span>
        <span class="checkbox-label">DT không gồm thuế</span>
      </label>

      <button class="btn btn-view">
        <svg class="icon-btn" viewBox="0 0 24 24">
          <path
            d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0016 9.5 6.5 6.5 0 109.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"
            fill="#fff"
          />
        </svg>
        Xem
      </button>
      <button class="btn btn-export">
        <svg class="icon-btn" viewBox="0 0 24 24">
          <path
            d="M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6zm2 14h-3v3h-2v-3H8v-2h3v-3h2v3h3v2zm-3-7V3.5L18.5 9H13z"
            fill="#fff"
          />
        </svg>
        Xuất file
      </button>
    </div>

    <div class="table-container">
      <table class="stat-table">
        <thead>
          <tr>
            <th class="col-metric"></th>
            <th class="col-day">T4<br />24/06</th>
            <th class="col-total">Tổng cộng</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(row, index) in tableData"
            :key="index"
            :class="{ 'bg-highlight': row.highlight }"
          >
            <td :class="[{ 'text-bold': row.boldLabel, 'text-red': row.redText }]">
              {{ row.label }}
            </td>
            <td :class="[{ 'text-bold': row.boldValue, 'text-red': row.redText }]">
              {{ row.dayVal }}
            </td>
            <td :class="[{ 'text-bold': row.boldValue, 'text-red': row.redText }]">
              {{ row.totalVal }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const tableData = ref([
  { label: 'Tổng Phòng', dayVal: '131', totalVal: '131', boldLabel: true },
  { label: 'Phòng Khóa Hư Hỏng', dayVal: '0', totalVal: '0' },
  { label: 'Phòng Khóa Dịch Vụ', dayVal: '0', totalVal: '0' },
  { label: 'Tổng Phòng Có Thể Bán', dayVal: '131', totalVal: '131', boldLabel: true },
  { label: 'Đặt Phòng Đảm Bảo', dayVal: '83', totalVal: '83' },
  { label: 'Đặt Phòng Chưa Đảm Bảo', dayVal: '0', totalVal: '0' },
  { label: 'Đăng ký series', dayVal: '0', totalVal: '0' },
  { label: 'Allotment', dayVal: '3', totalVal: '3' },
  // Đã sửa dùng chung cờ redText cho cả label và value
  {
    label: 'Phòng Ở',
    dayVal: '86',
    totalVal: '86',
    boldLabel: true,
    boldValue: true,
    redText: true,
  },
  { label: 'Phòng Ở (Không Gồm Nội Bộ)', dayVal: '86', totalVal: '86' },
  { label: 'Phòng Ở (Không Gồm Nội Bộ, MP)', dayVal: '84', totalVal: '84' },
  { label: 'Phòng Miễn Phí', dayVal: '2', totalVal: '2' },
  { label: 'Phòng Nội Bộ', dayVal: '0', totalVal: '0' },
  { label: 'Công Suất Phòng', dayVal: '65.65%', totalVal: '65.65%' },
  { label: 'Công Suất (Không Gồm Nội Bộ)', dayVal: '65.65%', totalVal: '65.65%' },
  { label: 'Giá Phòng Trung Bình (Không Gồm Nội Bộ)', dayVal: '684,884', totalVal: '684,884' },
  { label: 'Giá Phòng Trung Bình (Không Gồm Nội Bộ,MP)', dayVal: '701,190', totalVal: '701,190' },
  { label: 'Khách Ở', dayVal: '179', totalVal: '179' },
  // Cờ highlight áp dụng cho cả hàng Phòng Đến
  {
    label: 'Phòng Đến',
    dayVal: '3',
    totalVal: '3',
    boldLabel: true,
    boldValue: true,
    redText: true,
    highlight: true,
  },
  { label: 'Khách Đến', dayVal: '7', totalVal: '7' },
  {
    label: 'Phòng Đi',
    dayVal: '7',
    totalVal: '7',
    boldLabel: true,
    boldValue: true,
    redText: true,
  },
  { label: 'Khách Đi', dayVal: '16', totalVal: '16' },
  {
    label: 'Doanh Thu Tiền Phòng (Gồm Ăn Sáng)',
    dayVal: '58,900,000',
    totalVal: '58,900,000',
    boldLabel: true,
  },
  { label: 'Thêm Giường', dayVal: '0', totalVal: '0' },
  { label: 'Phòng Khách Đi-Đến Liên Tục', dayVal: '1', totalVal: '1' },
  { label: 'Phòng Nghỉ Giờ', dayVal: '0', totalVal: '' },
  { label: 'Phòng Trả Sớm', dayVal: '0', totalVal: '0' },
  { label: 'Phòng Khách Không Đến', dayVal: '0', totalVal: '0' },
  { label: 'Phòng Hủy', dayVal: '0', totalVal: '0' },
  { label: 'Khách Đến Không Đặt Phòng Trước', dayVal: '0', totalVal: '0' },
  {
    label: 'Phòng Còn Trống',
    dayVal: '45',
    totalVal: '45',
    boldLabel: true,
    boldValue: true,
    redText: true,
  },
])
</script>

<style scoped>
.statistics-wrapper {
  font-family: Arial, sans-serif;
  font-size: 13px;
  color: #333;
  background-color: #fff;
  padding: 15px;
}

/* --- TOOLBAR --- */
.toolbar {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 20px;
}

/* Toggle Switch */
.custom-toggle {
  display: flex;
  align-items: center;
  cursor: pointer;
}
.custom-toggle input {
  display: none;
}
.slider {
  position: relative;
  width: 34px;
  height: 18px;
  background-color: #ccc;
  transition: 0.4s;
  border-radius: 18px;
  margin-right: 8px;
}
.slider:before {
  position: absolute;
  content: '';
  height: 14px;
  width: 14px;
  left: 2px;
  bottom: 2px;
  background-color: white;
  transition: 0.4s;
  border-radius: 50%;
}
.custom-toggle input:checked + .slider {
  background-color: #c0c0c0;
}
.custom-toggle input:checked + .slider:before {
  transform: translateX(16px);
}
.toggle-label {
  font-weight: normal;
}

/* Date Picker Box */
.date-picker-box {
  display: flex;
  align-items: center;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 4px 10px;
  background-color: #fff;
  gap: 10px;
}
.date-text {
  color: #555;
}
.icon-calendar {
  width: 16px;
  height: 16px;
  cursor: pointer;
}

/* Checkbox */
.custom-checkbox {
  display: flex;
  align-items: center;
  gap: 6px;
  color: #999;
  cursor: not-allowed;
}
.custom-checkbox input {
  margin: 0;
}
.checkbox-label {
  font-size: 13px;
}

/* Buttons */
.btn {
  display: flex;
  align-items: center;
  gap: 6px;
  border: none;
  border-radius: 4px;
  padding: 6px 15px;
  color: #fff;
  cursor: pointer;
  font-size: 13px;
}
.icon-btn {
  width: 16px;
  height: 16px;
}
.btn-view {
  background-color: #5bc0de;
}
.btn-export {
  background-color: #5bc0de;
}

/* --- DATA TABLE --- */
.table-container {
  overflow-x: auto;
}
.stat-table {
  border-collapse: collapse;
  width: max-content;
  min-width: 500px;
}
.stat-table th,
.stat-table td {
  border: 1px solid #e0e0e0;
  padding: 8px 12px;
  text-align: left;
}
.stat-table th {
  background-color: #f4f4f4;
  font-weight: bold;
  text-align: center;
  color: #333;
}
.col-metric {
  width: 300px;
}
.col-day,
.col-total {
  width: 100px;
}

/* Utilities */
.text-bold {
  font-weight: bold;
}
.text-red {
  color: red !important;
}

.stat-table tr:first-child th {
  border-top: none;
}
.stat-table tr th:first-child,
.stat-table tr td:first-child {
  border-left: none;
}
</style>
