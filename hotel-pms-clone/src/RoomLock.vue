<template>
  <div class="room-lock-container">
    <h2 class="page-title">Phòng</h2>

    <div class="toolbar">
      <div class="toolbar-left">
        <button class="btn btn-sky-blue">
          <svg class="btn-icon" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zM9 6c0-1.66 1.34-3 3-3s3 1.34 3 3v2H9V6zm9 14H6V10h12v10zm-6-3c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2z"
            />
          </svg>
          Phòng OOO
        </button>
        <button class="btn btn-sky-blue">
          <svg class="btn-icon" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zM9 6c0-1.66 1.34-3 3-3s3 1.34 3 3v2H9V6zm9 14H6V10h12v10zm-6-3c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2z"
            />
          </svg>
          Phòng OOS
        </button>
        <button class="btn btn-disabled-gray" disabled>
          <svg class="btn-icon" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6h2c0-1.66 1.34-3 3-3s3 1.34 3 3v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm0 12H6V10h12v10zm-6-3c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2z"
            />
          </svg>
          Mở khóa
        </button>

        <div class="segment-filter">
          <button class="segment-item active">Tất cả</button>
          <button class="segment-item">Chưa khóa</button>
          <button class="segment-item">Khóa</button>
        </div>
      </div>

      <div class="toolbar-right">
        <button class="btn btn-sky-blue">
          <svg class="btn-icon" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"
            />
          </svg>
          Sửa
        </button>
        <button class="btn btn-disabled-blue" disabled>
          <svg class="btn-icon" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M17 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V7l-4-4zm-5 16c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm3-10H5V5h10v4z"
            />
          </svg>
          Lưu
        </button>
      </div>
    </div>

    <div class="table-scroller">
      <table class="lock-grid-table">
        <thead>
          <tr>
            <th class="w-checkbox"><input type="checkbox" /></th>
            <th class="w-stt">STT</th>
            <th class="w-room">
              <div class="header-cell-inner">Phòng <SearchIcon /></div>
            </th>
            <th class="w-type">Dạng phòng</th>
            <th class="w-category">Loại phòng</th>
            <th class="w-date">
              <div class="header-cell-inner">Ngày bắt đầu <SearchIcon /></div>
            </th>
            <th class="w-date">
              <div class="header-cell-inner">Ngày kết thúc <SearchIcon /></div>
            </th>
            <th class="w-desc">Mô tả khóa</th>
            <th class="w-maintain">Bảo trì (%)</th>
            <th class="w-status">Trạng thái</th>
            <th class="w-user">Người dùng</th>
            <th class="w-locktype">Loại khóa</th>
            <th class="w-history">Lịch sử</th>
          </tr>
        </thead>

        <tbody v-for="group in floorGroups" :key="group.floorId">
          <tr class="group-header-row">
            <td><input type="checkbox" /></td>
            <td class="text-center">
              <button class="btn-toggle-expand" @click="toggleGroup(group)">
                {{ group.expanded ? '-' : '+' }}
              </button>
            </td>
            <td class="floor-number-cell">{{ group.floorId }}</td>
            <td colspan="10"></td>
          </tr>

          <tr
            v-show="group.expanded"
            v-for="room in group.rooms"
            :key="room.roomNumber"
            class="room-data-row"
          >
            <td><input type="checkbox" /></td>
            <td class="text-center color-muted">{{ room.stt }}</td>
            <td class="text-center font-semibold">{{ room.roomNumber }}</td>
            <td class="text-center">{{ room.roomType }}</td>
            <td class="text-left cell-wrap">{{ room.roomCategory }}</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class="text-center">
              <button
                class="btn-history-row"
                @click="showRoomHistory(room)"
                title="Xem lịch sử khóa"
              >
                <svg class="icon-history" viewBox="0 0 24 24">
                  <path
                    fill="currentColor"
                    d="M20 6h-4V4c0-1.11-.89-2-2-2h-4c-1.11 0-2 .89-2 2v2H4c-1.11 0-1.99.89-1.99 2L2 19c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V8c0-1.11-.89-2-2-2zm-6 0h-4V4h4v2zm-2 11c-2.21 0-4-1.79-4-4s1.79-4 4-4 4 1.79 4 4-1.79 4-4 4zm1-6h-1.5v3l2.25 1.35.75-1.23-1.5-.89V11z"
                  />
                </svg>
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="pagination-container">
      <button class="pager-btn">&lt;</button>
      <button class="pager-btn active">1</button>
      <button class="pager-btn">2</button>
      <button class="pager-btn">&gt;</button>
    </div>

    <div class="bottom-tabs-bar">
      <div class="tab-tab-item active">Lịch sử khóa <HistoryIcon class="tab-icon-accent" /></div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

// Cấu trúc dữ liệu phân tầng động theo các ảnh mẫu (Tầng 4, Tầng 5, Tầng 6)
const floorGroups = ref([
  {
    floorId: '4',
    expanded: true, // Tầng 4 đang được mở rộng (Dấu -)
    rooms: [
      { stt: 1, roomNumber: '401', roomType: 'Double', roomCategory: 'Deluxe Double City view' },
      { stt: 2, roomNumber: '402', roomType: 'Twin', roomCategory: 'Deluxe Twin with Balcony' },
      { stt: 3, roomNumber: '403', roomType: 'Twin', roomCategory: 'Deluxe Twin with Balcony' },
      { stt: 4, roomNumber: '404', roomType: 'Twin', roomCategory: 'Superior Twin' },
    ],
  },
  {
    floorId: '5',
    expanded: false, // Tầng 5 đang thu gọn (Dấu +)
    rooms: [
      { stt: 1, roomNumber: '501', roomType: 'Twin', roomCategory: 'Superior Twin' },
      { stt: 2, roomNumber: '502', roomType: 'Double', roomCategory: 'Deluxe Double with Balcony' },
      { stt: 3, roomNumber: '503', roomType: 'Double', roomCategory: 'Deluxe Double with Balcony' },
    ],
  },
  {
    floorId: '6',
    expanded: false, // Tầng 6 đang thu gọn (Dấu +)
    rooms: [
      { stt: 1, roomNumber: '601', roomType: 'Double', roomCategory: 'Deluxe Double City view' },
      { stt: 2, roomNumber: '602', roomType: 'Twin', roomCategory: 'Deluxe Twin with Balcony' },
      { stt: 3, roomNumber: '603', roomType: 'Twin', roomCategory: 'Deluxe Twin with Balcony' },
    ],
  },
])

// Hàm xử lý đảo ngược trạng thái Đóng / Mở khi bấm nút + hoặc -
const toggleGroup = (group) => {
  group.expanded = !group.expanded
}

// Icon Kính lúp tìm kiếm nhỏ ở Header column
const SearchIcon = {
  template: `
    <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="#bbb" stroke-width="3" style="margin-left: 4px; display: inline-block; vertical-align: middle;">
      <circle cx="11" cy="11" r="8"></circle>
      <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
    </svg>
  `,
}

// Icon Lịch sử (Cái cặp xách tích hợp đồng hồ) chuẩn xác theo UI gốc
const HistoryIcon = {
  template: `
    <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor" style="display: inline-block; vertical-align: middle;">
      <path d="M20 6h-4V4c0-1.11-.89-2-2-2h-4c-1.11 0-2 .89-2 2v2H4c-1.11 0-1.99.89-1.99 2L2 19c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V8c0-1.11-.89-2-2-2zm-6 0h-4V4h4v2zm-2 11c-2.21 0-4-1.79-4-4s1.79-4 4-4 4 1.79 4 4-1.79 4-4 4zm1-6h-1.5v3l2.25 1.35.75-1.23-1.5-.89V11z"/>
    </svg>
  `,
}
</script>

<style scoped>
/* --- PHONG CÁCH TỔNG THỂ --- */
.room-lock-container {
  font-family: Arial, Helvetica, sans-serif;
  font-size: 13px;
  color: #333;
  background-color: #fff;
  padding: 10px 20px;
}

.page-title {
  font-size: 15px;
  font-weight: bold;
  margin-top: 5px;
  margin-bottom: 15px;
  color: #111;
}

/* --- THANH CÔNG CỤ (TOOLBAR) --- */
.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}
.toolbar-left,
.toolbar-right {
  display: flex;
  gap: 8px;
  align-items: center;
}

/* Nút bấm chuẩn thiết kế phẳng gốc */
.btn {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 14px;
  border: none;
  border-radius: 4px;
  font-size: 13px;
  cursor: pointer;
  color: #fff;
}
.btn-icon {
  width: 14px;
  height: 14px;
}
.btn-sky-blue {
  background-color: #5bc0de;
}
.btn-sky-blue:hover {
  background-color: #46b8da;
}
.btn-disabled-gray {
  background-color: #b3b3b3;
  cursor: not-allowed;
}
.btn-disabled-blue {
  background-color: #9acada;
  cursor: not-allowed;
}

/* Bộ chọn phân đoạn (Segment Filter) */
.segment-filter {
  display: flex;
  border: 1px solid #ccc;
  border-radius: 4px;
  overflow: hidden;
  background-color: #fff;
}
.segment-item {
  border: none;
  background: none;
  padding: 6px 14px;
  font-size: 13px;
  color: #333;
  cursor: pointer;
  border-right: 1px solid #ccc;
}
.segment-item:last-child {
  border-right: none;
}
.segment-item.active {
  background-color: #5bc0de;
  color: #fff;
}

/* --- BẢNG DỮ LIỆU --- */
.table-scroller {
  overflow-x: auto;
  border: 1px solid #dcdcdc;
  border-radius: 2px;
  margin-bottom: 12px;
}
.lock-grid-table {
  width: 100%;
  border-collapse: collapse;
  min-width: 1200px;
}

/* Đầu bảng */
.lock-grid-table th {
  background-color: #eaeaea;
  border: 1px solid #d2d2d2;
  color: #222;
  font-weight: bold;
  padding: 8px 6px;
  font-size: 13px;
}
.header-cell-inner {
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

/* Ô dữ liệu thông thường */
.lock-grid-table td {
  border: 1px solid #e2e2e2;
  padding: 7px 8px;
  vertical-align: middle;
  height: 28px;
}

/* Định dạng kích thước cố định các cột theo ảnh gốc */
.w-checkbox {
  width: 35px;
  text-align: center;
}
.w-stt {
  width: 45px;
  text-align: center;
}
.w-room {
  width: 80px;
  text-align: center;
}
.w-type {
  width: 90px;
  text-align: center;
}
.w-category {
  width: 160px;
}
.w-date {
  width: 110px;
  text-align: center;
}
.w-desc {
  width: 200px;
}
.w-maintain {
  width: 85px;
  text-align: center;
}
.w-status {
  width: 90px;
  text-align: center;
}
.w-user {
  width: 100px;
  text-align: center;
}
.w-locktype {
  width: 95px;
  text-align: center;
}

/* Chiều rộng cố định cho cột lịch sử */
.w-history {
  width: 70px;
  text-align: center;
}

/* Nút bấm chứa icon lịch sử trên từng dòng */
.btn-history-row {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 24px;
  background-color: #5bc0de; /* Màu xanh thiên thanh đồng bộ hệ thống */
  color: #ffffff; /* Icon màu trắng */
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

/* Hiệu ứng khi di chuột vào nút */
.btn-history-row:hover {
  background-color: #46b8da;
}

/* Kích thước của icon SVG bên trong nút */
.icon-history {
  width: 15px;
  height: 15px;
}

/* Hàng gom nhóm tầng (Group Row) */
.group-header-row {
  background-color: #fcfcfc;
}
.floor-number-cell {
  text-align: left;
  font-weight: bold;
  font-size: 13px;
  padding-left: 15px !important;
}

/* Nút cộng/trừ thu phóng chuẩn xác */
.btn-toggle-expand {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 16px;
  height: 16px;
  background-color: #5bc0de;
  color: white;
  border: none;
  border-radius: 3px;
  font-weight: bold;
  font-size: 14px;
  line-height: 1;
  cursor: pointer;
}

/* Dòng phòng con */
.room-data-row:hover {
  background-color: #f9f9f9;
}

/* Nút lịch sử cột cuối */
.btn-action-history {
  background-color: #5bc0de;
  color: #fff;
  border: none;
  border-radius: 4px;
  width: 32px;
  height: 24px;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}
.btn-action-history:hover {
  background-color: #46b8da;
}

/* Tiện ích căn lề & định dạng chữ */
.text-center {
  text-align: center;
}
.text-left {
  text-align: left;
}
.font-semibold {
  font-weight: bold;
}
.color-muted {
  color: #666;
}
.cell-wrap {
  white-space: normal;
  word-break: break-word;
  line-height: 1.3;
}

/* --- PHÂN TRANG (PAGINATION) --- */
.pagination-container {
  display: flex;
  justify-content: flex-end;
  gap: 4px;
  margin-top: 10px;
  margin-bottom: 25px;
}
.pager-btn {
  background: #fff;
  border: 1px solid #ccc;
  border-radius: 4px;
  min-width: 26px;
  height: 26px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  cursor: pointer;
  color: #555;
  padding: 0 4px;
}
.pager-btn.active {
  border-color: #5bc0de;
  color: #111;
  font-weight: bold;
}
.pager-btn:hover:not(.active) {
  background-color: #f5f5f5;
}

/* --- TAB LỊCH SỬ DƯỚI ĐÁY --- */
.bottom-tabs-bar {
  border-bottom: 1px solid #dcdcdc;
  display: flex;
  margin-top: 10px;
}
.tab-tab-item {
  padding: 6px 10px;
  font-weight: bold;
  font-size: 13px;
  color: #222;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  cursor: pointer;
  border-bottom: 3px solid #5bc0de;
}
.tab-icon-accent {
  color: #5bc0de;
}
</style>
