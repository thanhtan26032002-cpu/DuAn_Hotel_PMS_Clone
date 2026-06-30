<script setup>
import { ref } from 'vue'

// Sub-headers ĐÚNG CHUẨN ảnh mới
const subCols = ['AV', 'ALM', 'OOO', 'OOS', 'EB', 'SOFAB']

const dates = ref([
  { day: 'T5', date: '18/06', isWeekend: false },
  { day: 'T6', date: '19/06', isWeekend: false },
  { day: 'T7', date: '20/06', isWeekend: true },
  { day: 'CN', date: '21/06', isWeekend: true },
  { day: 'T2', date: '22/06', isWeekend: false },
  { day: 'T3', date: '23/06', isWeekend: false },
  { day: 'T4', date: '24/06', isWeekend: false },
  { day: 'T5', date: '25/06', isWeekend: false },
  { day: 'T6', date: '26/06', isWeekend: false },
  { day: 'T7', date: '27/06', isWeekend: true },
  { day: 'CN', date: '28/06', isWeekend: true },
  { day: 'T2', date: '29/06', isWeekend: false },
  { day: 'T3', date: '30/06', isWeekend: false },
  { day: 'T4', date: '01/07', isWeekend: false },
  { day: 'T5', date: '02/07', isWeekend: false },
  { day: 'T6', date: '03/07', isWeekend: false },
  { day: 'T7', date: '04/07', isWeekend: true },
  { day: 'CN', date: '05/07', isWeekend: true },
])

const roomTypes = ref([
  { code: 'SUPD', name: 'Superior Double', total: 6, max: 0 },
  { code: 'SUPT', name: 'Superior Twin', total: 18, max: 0 },
  { code: 'SUPTR', name: 'Superior Triple', total: 30, max: 0 },
  { code: 'DLXD', name: 'Deluxe Double City view', total: 10, max: 0 },
  { code: 'DLXT', name: 'Deluxe Twin City View', total: 12, max: 0 },
  { code: 'DLXDB', name: 'Deluxe Double with Balco...', total: 22, max: 0 },
  { code: 'DLXTB', name: 'Deluxe Twin with Balcony', total: 21, max: 0 },
  { code: 'FAM', name: 'Family City View', total: 11, max: 0 },
  { code: 'JST', name: 'Suite', total: 1, max: 0 },
])

const statistics = ref([
  { label: 'Tổng', totalValue: '3930', isRed: false },
  { label: 'OOO', totalValue: '0', isRed: false },
  { label: 'OOS', totalValue: '2', isRed: false },
  { label: 'Tổng số phòng có thể bán', totalValue: '3928', isRed: true },
  { label: 'Series', totalValue: '0', isRed: false },
  { label: 'Allotment', totalValue: '47', isRed: false },
  { label: 'Đặt phòng đảm bảo', totalValue: '1968', isRed: true },
  { label: 'Đặt phòng không đảm bảo', totalValue: '16', isRed: true },
  { label: 'Tổng số phòng chiếm dụng', totalValue: '2031 (51.71%)', isRed: true },
  { label: 'Phòng trống', totalValue: '1897', isRed: true },
  { label: 'Phòng nội bộ', totalValue: '0', isRed: false },
  { label: 'Phòng miễn phí', totalValue: '0', isRed: false },
  { label: 'Tổng khách', totalValue: '4355', isRed: false },
  { label: 'Khách lẻ (Rm/Pax)', totalValue: '95/207', isRed: false },
  { label: 'Khách đoàn (Rm/Pax)', totalValue: '223/508', isRed: false },
  { label: 'Thêm Giường', totalValue: '0', isRed: false },
  { label: 'Phòng hủy', totalValue: '0', isRed: false },
  { label: 'Phòng không đến', totalValue: '7', isRed: false },
])

// Giả lập random data để có ô AV=0 hiện đỏ như hình
const generateMockData = (col) => {
  if (col === 'AV') return Math.floor(Math.random() * 5) // Tỉ lệ ra 0 cao hơn
  return 0
}
</script>

<template>
  <div class="availability-wrapper">
    <div class="toolbar">
      <div class="toolbar-left">
        <div class="date-picker-box">
          18/06/2026 - 17/07/2026
          <svg
            class="calendar-icon"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
          >
            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
            <line x1="16" y1="2" x2="16" y2="6"></line>
            <line x1="8" y1="2" x2="8" y2="6"></line>
            <line x1="3" y1="10" x2="21" y2="10"></line>
          </svg>
        </div>

        <button class="btn btn-cyan">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
            <circle cx="11" cy="11" r="8"></circle>
            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
          </svg>
          Xem
        </button>

        <button class="btn btn-cyan outline">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
            <polyline points="14 2 14 8 20 8"></polyline>
            <line x1="8" y1="13" x2="16" y2="13"></line>
            <line x1="8" y1="17" x2="16" y2="17"></line>
            <polyline points="10 9 9 9 8 9"></polyline>
          </svg>
          Xuất excel
        </button>
      </div>

      <div class="toolbar-right">
        <div class="legend-badges">
          <span class="badge bg-av">AV</span>
          <span class="badge bg-occ">OCC</span>
          <span class="badge bg-ooo">OOO</span>
          <span class="badge bg-oos">OOS</span>
          <span class="badge bg-eb">EB</span>
          <span class="badge bg-sofab">SOFAB</span>
        </div>
        <label class="check-occ">OCC <input type="checkbox" /></label>
        <button class="btn-filter">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
          </svg>
        </button>
      </div>
    </div>

    <div class="table-container">
      <table class="matrix-table">
        <thead>
          <tr>
            <th rowspan="2" class="sticky-col col-0 z-top"></th>
            <th rowspan="2" class="sticky-col col-1 z-top text-center">Mã Loại</th>
            <th rowspan="2" class="sticky-col col-2 z-top text-left">Loại phòng</th>
            <th rowspan="2" class="sticky-col col-3 z-top text-center">Tổng</th>
            <th rowspan="2" class="sticky-col col-4 z-top text-center border-right-heavy">
              SL Phòng<br />Tối Đa
            </th>

            <th
              v-for="(date, idx) in dates"
              :key="'h1-' + idx"
              :colspan="subCols.length"
              class="date-header text-center"
              :class="{
                'bg-saturday': date.day === 'T7',
                'bg-sunday': date.day === 'CN',
              }"
            >
              {{ date.day }} <br />
              <span class="font-normal">{{ date.date }}</span>
            </th>
          </tr>
          <tr>
            <template v-for="(date, dIdx) in dates" :key="'h2-' + dIdx">
              <th
                v-for="col in subCols"
                :key="col"
                class="sub-header text-center"
                :class="{
                  'bg-saturday': date.day === 'T7',
                  'bg-sunday': date.day === 'CN',
                }"
              >
                {{ col }}
              </th>
            </template>
          </tr>
        </thead>

        <tbody>
          <tr v-for="(room, rIdx) in roomTypes" :key="rIdx">
            <td class="sticky-col col-0 text-center">
              <button class="expand-btn">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3">
                  <line x1="12" y1="5" x2="12" y2="19"></line>
                  <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>
              </button>
            </td>
            <td class="sticky-col col-1 text-center font-bold">{{ room.code }}</td>
            <td class="sticky-col col-2 text-left">{{ room.name }}</td>
            <td class="sticky-col col-3 text-center font-bold">{{ room.total }}</td>
            <td class="sticky-col col-4 text-center border-right-heavy font-bold text-red-override">
              {{ room.max }}
            </td>

            <template v-for="(date, dIdx) in dates" :key="'data-' + rIdx + '-' + dIdx">
              <td
                v-for="col in subCols"
                :key="col"
                class="data-cell text-center"
                :class="{
                  'bg-saturday': date.day === 'T7',
                  'bg-sunday': date.day === 'CN',
                  'text-red': col === 'AV' && generateMockData(col) === 0,
                }"
              >
                {{ generateMockData(col) }}
              </td>
            </template>
          </tr>

          <tr class="row-total">
            <td class="sticky-col sticky-span-0-2 text-center font-bold" colspan="3">TỔNG</td>
            <td class="sticky-col col-3 text-center font-bold">131</td>
            <td class="sticky-col col-4 text-center font-bold border-right-heavy text-red-override">
              0
            </td>

            <template v-for="(date, dIdx) in dates" :key="'total-' + dIdx">
              <td
                v-for="col in subCols"
                :key="col"
                class="data-cell text-center font-bold"
                :class="{
                  'bg-saturday': date.day === 'T7',
                  'bg-sunday': date.day === 'CN',
                }"
              >
                {{ col === 'AV' ? '31' : '0' }}
              </td>
            </template>
          </tr>
        </tbody>

        <tbody class="stats-body">
          <tr class="stats-title-row">
            <td
              class="sticky-col sticky-span-0-4 border-right-heavy title-left-cell"
              colspan="5"
            ></td>

            <td :colspan="dates.length * subCols.length" class="bg-gray-title">
              <div class="sticky-text-center">THỐNG KÊ</div>
            </td>
          </tr>

          <tr v-for="(stat, sIdx) in statistics" :key="'stat-' + sIdx">
            <td
              class="sticky-col sticky-span-0-2 text-left stat-label"
              colspan="3"
              :class="{ 'text-red font-bold': stat.isRed }"
            >
              {{ stat.label }}
            </td>
            <td
              class="sticky-col sticky-span-3-4 text-center font-bold border-right-heavy"
              colspan="2"
              :class="{ 'text-red': stat.isRed }"
            >
              {{ stat.totalValue }}
            </td>
            <td
              v-for="(date, dIdx) in dates"
              :key="'stat-val-' + sIdx + '-' + dIdx"
              :colspan="subCols.length"
              class="text-center font-bold"
              :class="{
                'bg-saturday': date.day === 'T7',
                'bg-sunday': date.day === 'CN',
                'text-red': stat.isRed,
              }"
            >
              {{ stat.isRed ? '131' : '0' }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<style scoped>
* {
  box-sizing: border-box;
}
.availability-wrapper {
  display: flex;
  flex-direction: column;
  height: 100vh;
  width: 100%;
  background-color: #ffffff;
  font-family: Arial, Helvetica, sans-serif;
  overflow: hidden;
}

/* TOOLBAR */
.toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 15px;
  background-color: #ffffff;
  border-bottom: 1px solid #d1d5db;
  flex-shrink: 0;
}
.toolbar-left,
.toolbar-right {
  display: flex;
  align-items: center;
  gap: 12px;
}
.date-picker-box {
  display: flex;
  align-items: center;
  gap: 10px;
  border: 1px solid #cbd5e1;
  border-radius: 4px;
  padding: 6px 10px;
  font-size: 13.5px;
  color: #334155;
}
.calendar-icon {
  width: 16px;
  height: 16px;
  color: #7dd3fc;
}
.btn {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 6px 16px;
  border-radius: 4px;
  border: none;
  font-size: 13.5px;
  font-weight: bold;
  cursor: pointer;
  transition: 0.2s;
}
.btn svg {
  width: 16px;
  height: 16px;
}
.btn-cyan {
  background-color: #7dd3fc;
  color: #ffffff;
}
.btn-cyan:hover {
  background-color: #38bdf8;
}
.legend-badges {
  display: flex;
  gap: 4px;
}
.badge {
  font-size: 12px;
  padding: 4px 8px;
  border: 1px solid #e2e8f0;
  background-color: #ffffff;
  color: #1e293b;
}
.bg-av {
  background-color: #ffffff;
}
.bg-occ {
  background-color: #fce7f3;
}
.bg-ooo {
  background-color: #f1f5f9;
}
.bg-oos {
  background-color: #e2e8f0;
}
.bg-eb {
  background-color: #fee2e2;
}
.bg-sofab {
  background-color: #ffedd5;
}
.check-occ {
  font-size: 13px;
  display: flex;
  align-items: center;
  gap: 4px;
  font-weight: bold;
}
.btn-filter {
  background: none;
  border: 1px solid #cbd5e1;
  padding: 4px 6px;
  border-radius: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
}
.btn-filter svg {
  width: 16px;
  height: 16px;
  color: #475569;
}

/* BẢNG MA TRẬN */
.table-container {
  flex: 1;
  overflow: auto;
  background-color: #fff;
  position: relative;
}
.matrix-table {
  width: max-content;
  border-collapse: separate !important;
  border-spacing: 0 !important;
  font-size: 13px;
}
th,
td {
  border-right: 1px solid #d1d5db;
  border-bottom: 1px solid #d1d5db;
  padding: 8px 10px;
  white-space: nowrap;
  color: #111827;
}
.expand-btn {
  background-color: #7dd3fc;
  color: white;
  border: none;
  width: 16px;
  height: 16px;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  padding: 2px;
}

/* HEADER BÊN TRÊN */
thead th {
  background-color: #e5e5e5;
  font-weight: bold;
  position: sticky !important;
  top: 0;
  z-index: 10;
}
thead tr:nth-child(2) th {
  top: 48px;
}

/* CÁC LỚP CĂN CHỈNH */
.text-left {
  text-align: left !important;
}
.text-center {
  text-align: center !important;
}
.font-bold {
  font-weight: bold;
}
.font-normal {
  font-weight: normal;
  font-size: 12px;
  color: #374151;
}

/* TỌA ĐỘ VÀ KÍCH THƯỚC CỘT TRÁI */
.sticky-col {
  position: sticky !important;
  background-color: #ffffff;
  z-index: 5;
}
.col-0 {
  left: 0 !important;
  width: 35px;
  min-width: 35px;
}
.col-1 {
  left: 35px !important;
  width: 80px;
  min-width: 80px;
}
.col-2 {
  left: 115px !important;
  width: 220px;
  min-width: 220px;
}
.col-3 {
  left: 335px !important;
  width: 60px;
  min-width: 60px;
}
.col-4 {
  left: 395px !important;
  width: 80px;
  min-width: 80px;
}
.sticky-span-0-2 {
  left: 0 !important;
  min-width: 335px;
  background-color: #ffffff;
  position: sticky !important;
  z-index: 5 !important;
}
.sticky-span-3-4 {
  left: 335px !important;
  min-width: 140px;
  background-color: #ffffff;
  position: sticky !important;
  z-index: 5 !important;
}

/* GỘP 5 CỘT TRÁI CỦA DÒNG THỐNG KÊ */
.sticky-span-0-4 {
  left: 0 !important;
  min-width: 475px;
  background-color: #e2e8f0 !important;
  position: sticky !important;
}
.border-right-heavy {
  border-right: 2px solid #9ca3af !important;
}
.z-top {
  z-index: 15 !important;
  background-color: #e5e5e5;
}

/* MÀU SẮC ĐẶC BIỆT CỦA BẢNG */
.bg-saturday {
  background-color: #ffff99 !important;
}
.bg-sunday {
  background-color: #ffe4e6 !important;
}
.text-red {
  color: #dc2626 !important;
}
.text-red-override {
  color: #dc2626 !important;
}
.row-total td {
  background-color: #f1f5f9;
  border-top: 2px solid #9ca3af;
  border-bottom: 2px solid #9ca3af;
}

/* ========================================== */
/*  XỬ LÝ GHIM DÒNG THỐNG KÊ (QUAN TRỌNG) */
/* ========================================== */
.stats-title-row td {
  background-color: #e2e8f0 !important;
  color: #0f172a;
  border-top: 2px solid #9ca3af;
  border-bottom: 2px solid #9ca3af;

  /* Ghim cứng chiều dọc: Khi cuộn lên xuống, nó dính sát mí dải Header */
  position: sticky !important;
  top: 77px;
  bottom: 0;
  z-index: 25 !important;
}

/* Đảm bảo góc giao nhau bên trái không bị các ô dữ liệu chạy đè lên */
.title-left-cell {
  z-index: 35 !important;
}

/*  Kỹ thuật đỉnh cao: Ghim cứng chiều ngang chữ THỐNG KÊ  */
.sticky-text-center {
  position: sticky;
  /* Dùng công thức toán học: Canh giữa tự động dựa trên khoảng trống còn lại bên phải */
  /* (50% của màn hình + bù trừ độ rộng 475px của các cột cố định) */
  left: calc(50% + 237px);
  transform: translateX(-50%);
  display: inline-block;
  font-weight: bold;
  color: #0f172a;
}
.bg-gray-title {
  background-color: #e2e8f0 !important;
}

/* CSS cho nội dung thống kê */
.stats-body td {
  padding: 5px 10px;
}
.stat-label {
  font-size: 13px;
  color: #1f2937;
}

/* CUSTOM SCROLLBAR */
.table-container::-webkit-scrollbar {
  width: 12px;
  height: 12px;
}
.table-container::-webkit-scrollbar-track {
  background: #f1f5f9;
}
.table-container::-webkit-scrollbar-thumb {
  background: #cbd5e1;
  border-radius: 6px;
  border: 2px solid #f1f5f9;
}
.table-container::-webkit-scrollbar-thumb:hover {
  background: #94a3b8;
}
</style>
