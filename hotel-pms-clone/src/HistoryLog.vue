<template>
  <div class="page-container">
    <div class="panel-container">
      <div class="toolbar">
        <div class="filters">
          <div class="input-wrapper date-picker">
            <input type="text" value="29 / 06 / 2026 - 29 / 06 / 2026" readonly />
            <svg
              class="icon-calendar"
              viewBox="64 64 896 896"
              width="14"
              height="14"
              fill="currentColor"
            >
              <path
                d="M880 184H712v-64c0-4.4-3.6-8-8-8h-56c-4.4 0-8 3.6-8 8v64H384v-64c0-4.4-3.6-8-8-8h-56c-4.4 0-8 3.6-8 8v64H144c-17.7 0-32 14.3-32 32v664c0 17.7 14.3 32 32 32h736c17.7 0 32-14.3 32-32V216c0-17.7-14.3-32-32-32zm-40 656H184V460h656v380zM184 392V256h128v48c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8v-48h256v48c0 4.4 3.6 8 8 8h56c4.4 0 8-3.6 8-8v-48h128v136H184z"
              />
            </svg>
          </div>

          <input type="text" placeholder="Mã đăng ký" class="input-box" />
          <input type="text" placeholder="Mã phòng" class="input-box" />
          <input type="text" placeholder="Người dùng" class="input-box" />

          <div class="input-wrapper select-wrapper">
            <select class="input-box select-box">
              <option value="Test">Test</option>
            </select>
            <svg
              class="icon-arrow"
              viewBox="64 64 896 896"
              width="12"
              height="12"
              fill="currentColor"
            >
              <path
                d="M840.4 300H183.6c-19.7 0-30.7 20.8-18.5 35l328.4 380.8c9.4 10.9 27.5 10.9 37 0L858.9 335c12.2-14.2 1.2-35-18.5-35z"
              />
            </svg>
          </div>

          <input type="text" placeholder="Màn hình" class="input-box" />
        </div>

        <div class="actions">
          <button class="btn btn-search">Tìm kiếm</button>
          <button class="btn btn-export">
            <svg viewBox="64 64 896 896" width="14" height="14" fill="currentColor">
              <path
                d="M854.6 288.7c6 6 9.4 14.1 9.4 22.6V928c0 17.7-14.3 32-32 32H192c-17.7 0-32-14.3-32-32V96c0-17.7 14.3-32 32-32h424.7c8.5 0 16.7 3.4 22.7 9.4l215.2 215.3zM790.2 326L602 137.8V326h188.2zM516 673.3h-75.1l-50.5-163.6-50.5 163.6H264.8l82-243.6-77-227.6h75.1l45.4 150.2 45.4-150.2H511l-77 227.6 82 243.6z"
              />
            </svg>
            Xuất
          </button>
        </div>
      </div>

      <div class="table-wrapper">
        <table class="data-table">
          <thead>
            <tr>
              <th style="width: 50px">ID</th>
              <th style="width: 130px">Thời gian</th>
              <th style="width: 140px">
                <div class="th-content">
                  Trình duyệt <span class="filter-icon"><FilterSvg /></span>
                </div>
              </th>
              <th style="width: 140px">
                <div class="th-content">
                  Màn hình <span class="filter-icon"><FilterSvg /></span>
                </div>
              </th>
              <th style="width: 140px">
                <div class="th-content">
                  Người dùng <span class="filter-icon"><FilterSvg /></span>
                </div>
              </th>
              <th style="width: 120px">Ngày</th>
              <th style="width: 140px">
                <div class="th-content">
                  Hành động <span class="filter-icon"><FilterSvg /></span>
                </div>
              </th>
              <th style="width: 140px">
                <div class="th-content">
                  Mã đăng ký <span class="search-icon"><SearchSvg /></span>
                </div>
              </th>
              <th style="width: 140px">
                <div class="th-content">
                  Mã phòng <span class="search-icon"><SearchSvg /></span>
                </div>
              </th>
              <th style="width: auto">Mô tả</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td colspan="10" class="no-data-cell">
                <div class="empty-state">
                  <svg class="empty-icon" viewBox="0 0 64 64" width="64" height="64">
                    <path
                      fill="#f0f0f0"
                      d="M54.7,21.8L43.4,7.4C42.8,6.5,41.7,6,40.6,6H23.4c-1.1,0-2.2,0.5-2.8,1.4L9.3,21.8C8.5,22.8,8,24,8,25.3V54c0,2.2,1.8,4,4,4h40c2.2,0,4-1.8,4-4V25.3C56,24,55.5,22.8,54.7,21.8z"
                    />
                    <path
                      fill="#e0e0e0"
                      d="M11.6,23h40.8l-8.9-11.4c-0.3-0.4-0.8-0.6-1.3-0.6H21.8c-0.5,0-1,0.2-1.3,0.6L11.6,23z"
                    />
                    <path
                      fill="#ffffff"
                      d="M38,29c0,3.3-2.7,6-6,6s-6-2.7-6-6H8v25c0,2.2,1.8,4,4,4h40c2.2,0,4-1.8,4-4V29H38z"
                    />
                  </svg>
                  <span class="empty-text">No data</span>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { h } from 'vue'

// Component con để render Icon chung cho Table Header giúp code gọn gàng hơn
const FilterSvg = () =>
  h('svg', { viewBox: '64 64 896 896', width: '12', height: '12', fill: 'currentColor' }, [
    h('path', {
      d: 'M880.1 154H143.9c-24.5 0-39.8 26.7-27.5 48L349 597.4V838c0 17.7 14.2 32 31.8 32h262.4c17.6 0 31.8-14.3 31.8-32V597.4L907.7 202c12.2-21.3-3.1-48-27.6-48z',
    }),
  ])

const SearchSvg = () =>
  h('svg', { viewBox: '64 64 896 896', width: '12', height: '12', fill: 'currentColor' }, [
    h('path', {
      d: 'M909.6 854.5L649.9 594.8C690.2 542.7 712 479 712 412c0-80.2-31.3-155.4-87.9-212.1C567.4 143.3 492.2 112 412 112c-80.2 0-155.4 31.3-212.1 87.9C143.3 256.6 112 331.8 112 412c0 80.2 31.3 155.4 87.9 212.1C256.6 680.7 331.8 712 412 712c67 0 130.6-21.8 182.7-62l259.7 259.6a8.2 8.2 0 0 0 11.6 0l43.6-43.5a8.2 8.2 0 0 0 0-11.6zM570.4 570.4C528 612.7 471.8 636 412 636s-116-23.3-158.4-65.6C211.3 528 188 471.8 188 412s23.3-116 65.6-158.4C296 211.3 352.2 188 412 188s116 23.3 158.4 65.6S636 352.2 636 412s-23.3 116-65.6 158.4z',
    }),
  ])
</script>

<style scoped>
/* Reset cơ bản và Font chữ */
.page-container {
  font-family:
    -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  padding: 16px;
  background-color: #f0f2f5;
  min-height: 100vh;
  box-sizing: border-box;
}

.panel-container {
  background-color: #ffffff;
  border-radius: 4px;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  padding: 12px 16px;
}

/* --- Thanh công cụ (Bộ lọc) --- */
.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
  flex-wrap: wrap;
  gap: 12px;
}

.filters {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  flex: 1;
}

/* Các ô Input và Select */
.input-box {
  height: 32px;
  border: 1px solid #d9d9d9;
  border-radius: 4px;
  padding: 4px 11px;
  font-size: 13px;
  color: #333;
  outline: none;
  transition: all 0.3s;
  width: 140px;
  box-sizing: border-box;
}

.input-box:focus {
  border-color: #78b7da;
  box-shadow: 0 0 0 2px rgba(120, 183, 218, 0.2);
}

.input-box::placeholder {
  color: #bfbfbf;
}

.input-wrapper {
  position: relative;
  display: inline-block;
}

/* Ô Date Picker */
.date-picker {
  width: 220px;
}

.date-picker input {
  width: 100%;
  padding-right: 30px;
  cursor: pointer;
  height: 32px;
  border: 1px solid #d9d9d9;
  border-radius: 4px;
  padding-left: 11px;
  font-size: 13px;
  color: #333;
  box-sizing: border-box;
}

.icon-calendar {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  color: #bfbfbf;
  pointer-events: none;
}

/* Ô Select Box */
.select-wrapper {
  width: 100px;
}

.select-box {
  width: 100%;
  appearance: none;
  cursor: pointer;
  padding-right: 28px;
}

.icon-arrow {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  color: #bfbfbf;
  pointer-events: none;
}

/* Các Nút Bấm */
.actions {
  display: flex;
  gap: 8px;
}

.btn {
  height: 32px;
  padding: 4px 15px;
  font-size: 13px;
  border-radius: 4px;
  border: 1px solid transparent;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  font-weight: 400;
  transition: all 0.3s;
  color: #fff;
  background-color: #6bb0d6; /* Màu xanh giống hình */
}

.btn:hover {
  background-color: #5aa1c7;
}

/* --- Bảng Dữ Liệu --- */
.table-wrapper {
  width: 100%;
  overflow-x: auto;
  border: 1px solid #f0f0f0;
  border-radius: 4px 4px 0 0;
}

/* Style cho thanh cuộn ngang (Giống thanh xám trong hình) */
.table-wrapper::-webkit-scrollbar {
  height: 10px;
}
.table-wrapper::-webkit-scrollbar-track {
  background: #fff;
  padding: 2px;
}
.table-wrapper::-webkit-scrollbar-thumb {
  background-color: #999; /* Thanh cuộn màu xám đậm */
  border-radius: 10px;
  border: 2px solid #fff; /* Tạo khoảng hở mỏng */
}
.table-wrapper::-webkit-scrollbar-thumb:hover {
  background-color: #777;
}

.data-table {
  width: 100%;
  min-width: 1200px; /* Đảm bảo đủ rộng để thanh cuộn hiện ra */
  border-collapse: collapse;
  text-align: left;
  font-size: 13px;
}

/* Header Bảng */
.data-table th {
  background-color: #fafafa;
  color: #333;
  font-weight: 500;
  padding: 12px 16px;
  border-bottom: 1px solid #f0f0f0;
  border-right: 1px solid #f0f0f0;
  white-space: nowrap;
}

.data-table th:last-child {
  border-right: none;
}

.th-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

/* Icon trên Header Bảng */
.filter-icon,
.search-icon {
  color: #bfbfbf;
  cursor: pointer;
  display: flex;
  align-items: center;
  transition: color 0.3s;
}

.filter-icon:hover,
.search-icon:hover {
  color: #888;
}

/* --- Trạng thái Trống (No Data) --- */
.data-table td {
  border-bottom: 1px solid #f0f0f0;
}

.no-data-cell {
  padding: 48px 16px !important;
  text-align: center;
  background-color: #ffffff;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.empty-icon {
  margin-bottom: 8px;
  opacity: 0.8;
}

.empty-text {
  color: #bfbfbf;
  font-size: 13px;
}
</style>
