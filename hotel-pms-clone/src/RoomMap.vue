<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
// Khai báo kết nối dữ liệu mẩu từ cấu trúc thư mục của bạn
import { mockData } from './mockData.js'
// 1. Lấy dữ liệu từ bên back-end (Laravel) thông qua API
const roomsData = ref([])
// 2. Viết hàm dùng Axios để kết nối sang Laravel
const fetchRooms = async () => {
  try {
    const response = await axios.get('http://127.0.0.1:8000/api/rooms');
    roomsData.value = response.data; // Đổ dữ liệu JSON từ Laravel trả về vào biến rooms
  } catch (error) {
    console.error("Lỗi khi kết nối API Laravel:", error);
  }
};
// 3. Ép giao diện chạy hàm lấy dữ liệu này ngay khi màn hình vừa tải xong (Render)
onMounted(() => {
  fetchRooms();
});
</script>

<template>
  <div class="hotel-pms-container">
    <aside class="pms-sidebar">
      <div class="sidebar-date-box">16 / 06 / 2026</div>

      <div class="sidebar-toggle-group">
        <label class="switch-sidebar">
          <input type="checkbox" />
          <span class="slider-sidebar slider-time"></span>
        </label>
      </div>

      <div class="pms-stat-item">
        <span class="stat-title">Đã đến</span>
        <span class="stat-value">1 / 14</span>
      </div>

      <div class="pms-stat-item">
        <span class="stat-title">Đã đi</span>
        <span class="stat-value">1 / 12</span>
      </div>

      <div class="pms-stat-item">
        <span class="stat-title">Đang ở</span>
        <span class="stat-value">88 / 90</span>
      </div>

      <div class="pms-stat-item stat-percent">
        <span class="stat-title">Thống kê</span>
        <span class="stat-value">68.70%</span>
      </div>

      <div class="sidebar-action-grid">
        <button class="action-btn">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10" />
            <path d="M12 8v8M8 12h8" />
          </svg>
        </button>
        <button class="action-btn">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
            <polyline points="14 2 14 8 20 8" />
          </svg>
        </button>
        <button class="action-btn">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10" />
            <line x1="12" y1="16" x2="12" y2="12" />
            <line x1="12" y1="8" x2="12.01" y2="8" />
          </svg>
        </button>
        <button class="action-btn">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <rect x="3" y="3" width="18" height="18" rx="2" ry="2" />
            <line x1="3" y1="9" x2="21" y2="9" />
            <line x1="9" y1="21" x2="9" y2="9" />
          </svg>
        </button>
        <button class="action-btn" style="background-color: #87ceeb">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
            <circle cx="11" cy="11" r="8" />
            <line x1="21" y1="21" x2="16.65" y2="16.65" />
          </svg>
        </button>
        <button class="action-btn" style="background-color: #87ceeb">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10" />
            <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3" />
            <line x1="12" y1="17" x2="12.01" y2="17" />
          </svg>
        </button>
      </div>

      <div class="sidebar-toggle-group bottom-toggle">
        <label class="switch-sidebar">
          <input type="checkbox" checked />
          <span class="slider-sidebar slider-view"></span>
        </label>
      </div>

      <div class="sidebar-setting">
        <a href="#">
          <img src="./logo/setting.svg" alt="Setting" class="icon-setting" />
        </a>
      </div>
    </aside>

    <main class="pms-main-viewport">
      <div class="pms-scrollable-canvas">
        <div v-for="(floor, fIndex) in mockData" :key="fIndex" class="pms-floor-row">
          <div class="pms-floor-sticky-header">
            <div class="floor-badge-icon">{{ floor.floorName }}</div>
          </div>

          <div class="pms-rooms-horizontal-list">
            <div
              v-for="(room, rIndex) in floor.rooms"
              :key="rIndex"
              :class="['pms-room-card', room.isOccupied ? 'state-occupied' : 'state-vacant']"
            >
              <div v-if="room.dotColor" :class="['card-status-dot', room.dotColor]"></div>

              <div class="card-info-box">
                <span :class="['room-number-title', { 'color-alert-red': room.isNameRed }]">
                  {{ room.roomName }}
                </span>
                <span class="room-type-sub">
                  {{ room.roomType }}
                  <template v-if="room.clientNumber > 0">
                    - SL khách: {{ room.clientNumber }}</template
                  >
                </span>
              </div>

              <div v-if="room.isLocked" class="card-bottom-icon-left">
                <svg
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                  <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                </svg>
              </div>

              <div class="card-bottom-icon-right">
                <svg v-if="room.isClean" viewBox="0 0 24 24" fill="currentColor">
                  <path
                    d="M19 8l-1.5-3.5L14 3l3.5-1.5L19 0l1.5 3.5L24 5l-3.5 1.5L19 8zm-7 2.5L8.5 4 5 10.5 1.5 4 5 4 8.5 0 12 10.5zm6 13.5l-1.5-3.5L13 17l3.5-1.5L18 12l1.5 3.5L23 17l-3.5 1.5L18 24z"
                  />
                </svg>
                <svg
                  v-else
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="1.8"
                >
                  <path
                    d="M12.5 18.5L20 11c1.5-1.5 1.5-4 0-5.5s-4-1.5-5.5 0l-7.5 7.5c-.8.8-1 2.2-.5 3.2l2.5 2.5c1 .5 2.4.3 3.5-.7z"
                    fill="#cbd5e1"
                  />
                  <path d="M5 19l4-4M3 21l3-3M7 15l4-4" stroke-linecap="round" />
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<style scoped>
/* KHUNG CHỨA TOÀN BỘ ỨNG DỤNG */
.hotel-pms-container {
  display: flex;
  width: 100%;
  height: 100vh; /* Cố định chiều cao toàn màn hình */
  background-color: #f1f5f9;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;

  /* 🌟 QUAN TRỌNG: Chặn tuyệt đối cuộn ở đây để không lộ thanh cuộn thừa */
  overflow: hidden !important;
}

/* ==================== SỬA ĐỔI THANH SIDEBAR BÊN TRÁI ==================== */
.pms-sidebar {
  width: 90px;
  height: 100%;
  background-color: #ffffff;
  border-right: 1px solid #e2e8f0;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 10px 10px;
  flex-shrink: 0;
  margin-top: 10px;
  overflow-y: auto; /* Nếu sidebar dài thì tự nó cuộn thôi */
}

.sidebar-date-box {
  font-size: 11px;
  font-weight: 600;
  color: #475569;
  border: 1px solid #cbd5e1;
  padding: 4px;
  border-radius: 4px;
  margin-bottom: 14px;
  width: 100%;
  text-align: center;
  background-color: #f8fafc;
}

/* ==================== GIAO DIỆN CÔNG TẮC SIDEBAR (DÙNG CHUNG CHUNG) ==================== */
.sidebar-toggle-group {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}
.sidebar-toggle-group.bottom-toggle {
  margin-top: 10px;
  margin-bottom: auto;
}

/* Ẩn ô checkbox mặc định */
.switch-sidebar input {
  opacity: 0;
  width: 0;
  height: 0;
}

/* Kích thước khung công tắc */
.switch-sidebar {
  position: relative;
  display: inline-block;
  width: 100px;
  height: 28px;
}

/* Rãnh trượt khi TẮT (Màu xám) */
.slider-sidebar {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  border-radius: 30px;
  transition: 0.4s;
}

/* Cục tròn trượt */
.slider-sidebar::before {
  position: absolute;
  content: '';
  height: 22px;
  width: 22px;
  left: 3px;
  bottom: 3px;
  background-color: white;
  border-radius: 50%;
  transition: 0.4s;
  z-index: 2;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
}

/* Định dạng chung cho chữ nằm trong nút */
.slider-sidebar::after {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  color: black;
  font-size: 12px;
  font-weight: bold;
  z-index: 1;
  transition: 0.4s;
}

/* --- HIỆU ỨNG KHI BẬT (DÙNG CHUNG) --- */
.switch-sidebar input:checked + .slider-sidebar {
  background-color: #7dd3fc; /* Nền đổi màu xanh */
}
.switch-sidebar input:checked + .slider-sidebar::before {
  transform: translateX(72px); /* Cục tròn trượt qua phải */
}

/* ==================== CHỮ RIÊNG CHO TỪNG NÚT ==================== */

/* 1. NÚT TRÊN (slider-time) */
.slider-time::after {
  content: 'Hiện tại';
  right: 12px; /* Tắt -> Cục tròn bên trái -> Chữ nằm bên phải */
}
.switch-sidebar input:checked + .slider-time::after {
  content: 'Tương lai';
  right: auto;
  left: 10px; /* Bật -> Cục tròn bên phải -> Chữ nhảy sang trái */
  color: white;
}

/* 2. NÚT DƯỚI (slider-view) */
.slider-view::after {
  content: 'Lưới';
  right: 18px; /* Tắt -> Chữ Lưới nằm phải (Căn lề sâu hơn 1 chút cho chữ ngắn) */
}
.switch-sidebar input:checked + .slider-view::after {
  content: 'Bảng';
  right: auto;
  left: 15px; /* Bật -> Chữ Bảng nhảy sang trái */
  color: white;
}

.icon-setting {
  height: 30px;
  width: 30px;
  margin-bottom: 20px;
}

.toggle-label {
  white-space: nowrap;
}

/* CSS Tùy biến nút Switch */
.switch {
  position: relative;
  display: inline-block;
  width: 28px;
  height: 16px;
}
.switch input {
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
  background-color: #cbd5e1;
  transition: 0.2s;
}
.slider:before {
  position: absolute;
  content: '';
  height: 12px;
  width: 12px;
  left: 2px;
  bottom: 2px;
  background-color: white;
  transition: 0.2s;
}
input:checked + .slider {
  background-color: #3b82f6;
}
input:checked + .slider:before {
  transform: translateX(12px);
}
.slider.round {
  border-radius: 16px;
}
.slider.round:before {
  border-radius: 50%;
}

/* Khối thống kê ô xanh nước biển nhạt */
.pms-stat-item {
  width: 100%;
  background-color: #bae6fd; /* Màu nền xanh da trời nhạt nguyên bản */
  border-radius: 8px;
  padding: 5px 2px;
  text-align: center;
  margin-bottom: 6px;
  color: #0f172a;
}
.pms-stat-item .stat-title {
  display: block;
  font-size: 10px;
  margin-bottom: 1px;
  color: #1e293b;
}
.pms-stat-item .stat-value {
  display: block;
  font-size: 12px;
  font-weight: 800;
}
.stat-percent {
  background-color: #e2e8f0; /* Riêng mục thống kê cuối có thể có màu nền khác biệt */
}

/* Lưới chứa các nút tính năng */
.sidebar-action-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 6px;
  width: 100%;
  margin-top: 8px;
}

.action-btn {
  aspect-ratio: 1;
  width: 100%;
  border-radius: 6px;
  background-color: #f1f5f9;
  border: 1px solid #e2e8f0;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #475569;
  cursor: pointer;
  padding: 0;
  transition: all 0.15s;
}
.action-btn svg {
  width: 16px;
  height: 16px;
}
.action-btn:hover {
  background-color: #e2e8f0;
}
.action-btn.active {
  background-color: #2563eb;
  color: #ffffff;
  border-color: #2563eb;
}

/* ==================== KHU VỰC HIỂN THỊ SƠ ĐỒ PHÒNG CHÍNH ==================== */
.pms-main-viewport {
  flex: 1;
  padding: 12px;
  overflow: hidden;
}

.pms-scrollable-canvas {
  width: 100%;
  height: 100%;
  overflow-x: auto; /* Kéo trượt ngang ở cạnh đáy màn hình */
  overflow-y: auto; /* Kéo trượt dọc khi danh sách tầng vượt quá chiều cao */
}

/* Hàng ngang đại diện cho 1 tầng */
.pms-floor-row {
  display: flex;
  margin-bottom: 6px;
  width: max-content; /* Ngăn chặn rớt dòng, ép các thành phần trải dài vô tận ra bên phải */
}

/* THUỘC TÍNH STICKY: Cố định cột số tầng luôn ở biên trái */
.pms-floor-sticky-header {
  width: 48px;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  position: sticky;
  left: 0;
  z-index: 5;
  background-color: #f1f5f9; /* Màu nền mờ đè che khuất các ô phòng khi kéo qua lại */
  padding-right: 6px;
}

.floor-badge-icon {
  width: 32px;
  height: 26px;
  background-color: #bae6fd;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 800;
  font-size: 13px;
  color: #0f172a;
}

/* Danh sách các phòng liên tiếp */
.pms-rooms-horizontal-list {
  display: flex;
  gap: 5px; /* Khoảng cách khít sát nhau theo giao diện gốc */
}

/* CẤU TRÚC CHI TIẾT THẺ PHÒNG (ROOM CARD) */
.pms-room-card {
  width: 140px;
  height: 72px;
  border-radius: 6px;
  padding: 6px 8px;
  box-sizing: border-box;
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border: 1px solid #cbd5e1;
  flex-shrink: 0; /* Giữ nguyên kích thước hình học khi co giãn màn hình */
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.02);
}

/* Trạng thái phòng có khách (Màu xanh nước biển nhạt) */
.pms-room-card.state-occupied {
  background-color: #bae6fd;
  border-color: #bae6fd;
}

/* Trạng thái phòng trống (Màu trắng tinh khôi) */
.pms-room-card.state-vacant {
  background-color: #ffffff;
}

/* Tiêu đề chữ và mô tả bên trong phòng */
.card-info-box {
  display: flex;
  flex-direction: column;
}

.room-number-title {
  font-weight: 800;
  font-size: 15px;
  color: #0f172a;
  line-height: 1.2;
}

/* Đổi màu đỏ cho số phòng đặc biệt */
.room-number-title.color-alert-red {
  color: #dc2626;
}

.room-type-sub {
  font-size: 12px;
  color: #000000;
  font-weight: 500;
  margin-top: 1px;
}

/* Chấm tròn báo hiệu góc trên bên phải */
.card-status-dot {
  position: absolute;
  top: 6px;
  right: 6px;
  width: 9px;
  height: 9px;
  border-radius: 50%;
}
.card-status-dot.red {
  background-color: #ef4444;
}
.card-status-dot.green {
  background-color: #22c55e;
}

/* Định vị biểu tượng ổ khóa (Góc trái bên dưới) */
.card-bottom-icon-left {
  position: absolute;
  bottom: 5px;
  left: 8px;
  width: 14px;
  height: 14px;
  color: #16a34a; /* Màu xanh lá chỉ báo an toàn */
}
.card-bottom-icon-left svg {
  width: 100%;
  height: 100%;
}

/* Định vị biểu tượng dọn dẹp vệ sinh (Góc phải bên dưới) */
.card-bottom-icon-right {
  position: absolute;
  bottom: 5px;
  right: 8px;
  width: 15px;
  height: 15px;
  color: #334155;
}
.card-bottom-icon-right svg {
  width: 100%;
  height: 100%;
  display: block;
}

/* TÙY BIẾN THANH KÉO (SCROLLBAR) Ở ĐÁY MÀN HÌNH THEO PHONG CÁCH HIỆN ĐẠI MẢNH */
.pms-scrollable-canvas::-webkit-scrollbar {
  height: 8px;
  width: 8px;
}
.pms-scrollable-canvas::-webkit-scrollbar-track {
  background: #f1f5f9;
}
.pms-scrollable-canvas::-webkit-scrollbar-thumb {
  background: #cbd5e1;
  border-radius: 4px;
}
.pms-scrollable-canvas::-webkit-scrollbar-thumb:hover {
  background: #94a3b8;
}
</style>
