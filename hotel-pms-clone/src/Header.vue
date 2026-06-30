<script setup>
import { ref } from 'vue'

// 1. Khai báo sự kiện để gửi lên App.vue
const emit = defineEmits(['on-change-view'])

// 2. Biến lưu trạng thái Tab đang được chọn (Mặc định là Sơ Đồ Phòng)
const activeTab = ref('RoomMap')

// 3. Hàm xử lý khi click vào từng Tab
const selectTab = (tabName) => {
  activeTab.value = tabName
  emit('on-change-view', tabName) // Báo cho App.vue biết user vừa chọn tab nào
}
</script>

<template>
  <header class="header-container">
    <div class="top-bar">
      <div class="logo-section">
        <img src="./logo/logo_hkt.png" alt="Logo HKT" class="logo-main" />
      </div>

      <nav class="main-menu">
        <a href="#" class="menu-item">ĐĂNG KÝ</a>
        <a href="#" class="menu-item">KIỂM TRA PHÒNG TRỐNG</a>
        <a href="#" class="menu-item">BÁO CÁO</a>
        <a href="#" class="menu-item">CHANNEL MANAGER</a>
      </nav>

      <div class="user-utilities">
        <button class="icon-btn">
          <img src="./logo/search.svg" alt="Search" class="icon-svg" />
        </button>

        <button class="icon-btn">
          <img src="./logo/help.svg" alt="Help" class="icon-svg" />
        </button>

        <div class="dropdown-user font-bold">
          <span>HKT 1</span>
          <img src="./logo/drop.svg" alt="arrow" class="arrow-svg" />
        </div>

        <button class="icon-btn">
          <img src="./logo/bell.svg" alt="Notification" class="icon-svg" />
        </button>

        <div class="dropdown-user">
          <img src="./logo/user.svg" alt="User Avatar" class="avatar-svg" />
          <span>Demo</span>
          <img src="./logo/drop.svg" alt="arrow" class="arrow-svg" />
        </div>

        <div class="shift-info">Ca: 2</div>

        <div class="date-time">16/06/2026 &nbsp;&nbsp; 2:29 CH</div>

        <div class="flag-box">
          <img src="./logo/vietnam.svg" alt="Vietnam Flag" class="flag-img" />
        </div>
      </div>
    </div>

    <div class="bottom-wrapper">
      <div class="bottom-bar">
        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'RoomMap' }"
          @click.prevent="selectTab('RoomMap')"
        >
          <img
            src="./logo/roomMap.svg"
            alt="Home"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'RoomMap' }"
          />
          Sơ Đồ Phòng
        </a>

        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'RoomAvailability' }"
          @click.prevent="selectTab('RoomAvailability')"
        >
          <img
            src="./logo/roomAvalabilitySVG.svg"
            alt="Bed"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'RoomAvailability' }"
          />
          Phòng Trống
        </a>

        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'RoomSchedule' }"
          @click.prevent="selectTab('RoomSchedule')"
        >
          <img
            src="./logo/booking2.svg"
            alt="Calendar"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'RoomSchedule' }"
          />
          Kế Hoạch Phòng
        </a>

        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'Booking' }"
          @click.prevent="selectTab('Booking')"
        >
          <img
            src="./logo/booking3.svg"
            alt="Edit"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'Booking' }"
          />
          Tạo Đăng Ký
        </a>

        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'ManageRoom' }"
          @click.prevent="selectTab('ManageRoom')"
        >
          <img
            src="./logo/manageroom.svg"
            alt="Manage"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'ManageRoom' }"
          />
          Quản Lý Phòng
        </a>

        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'RoomLock' }"
          @click.prevent="selectTab('RoomLock')"
        >
          <img
            src="./logo/booking5.svg"
            alt="Lock"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'RoomLock' }"
          />
          Khóa Phòng
        </a>

        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'WorkingList' }"
          @click.prevent="selectTab('WorkingList')"
        >
          <img
            src="./logo/working_list.svg"
            alt="Task"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'WorkingList' }"
          />
          D.S Công Việc
        </a>

        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'Company' }"
          @click.prevent="selectTab('Company')"
        >
          <img
            src="./logo/company.svg"
            alt="Company"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'Company' }"
          />
          Công Ty
        </a>

        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'Report' }"
          @click.prevent="selectTab('Report')"
        >
          <img
            src="./logo/booking8.svg"
            alt="Report"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'Report' }"
          />
          Báo Cáo
        </a>

        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'HistoryLog' }"
          @click.prevent="selectTab('HistoryLog')"
        >
          <img
            src="./logo/history.svg"
            alt="History"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'HistoryLog' }"
          />
          Lịch Sử Thao Tác
        </a>

        <a
          href="#"
          class="sub-tab"
          :class="{ active: activeTab === 'GuestSearch' }"
          @click.prevent="selectTab('GuestSearch')"
        >
          <img
            src="./logo/guestsearch.svg"
            alt="Search"
            class="sub-icon-img"
            :class="{ 'active-icon': activeTab === 'GuestSearch' }"
          />
          Tìm Kiếm Chung
        </a>
      </div>
    </div>
  </header>
</template>

<style>
body {
  margin: 0 !important;
  padding: 0 !important;
}
</style>

<style scoped>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}
a {
  text-decoration: none;
  color: inherit;
}
button {
  background: none;
  border: none;
  cursor: pointer;
}

.header-container {
  font-family: Arial, Helvetica, sans-serif;
  width: 100vw; /* Đảm bảo luôn tràn 100% chiều ngang màn hình */
  max-width: 100%;
}

/* --- STYLE HÀNG 1: TOP BAR KÍN VIỀN --- */
.top-bar {
  background-color: #bcebfc;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 15px;
  width: 100%;
}

.logo-main {
  height: 30px;
  display: block;
}
.main-menu {
  display: flex;
  gap: 40px;
}
.menu-item {
  color: #006699;
  font-size: 14.5px;
  font-weight: bold;
}
.user-utilities {
  display: flex;
  align-items: center;
  gap: 15px;
  color: #006699;
  font-size: 14px;
}
.font-bold {
  font-weight: bold;
}
.icon-btn {
  display: flex;
  align-items: center;
  justify-content: center;
}
.icon-svg {
  height: 20px;
  width: 20px;
}
.avatar-svg {
  height: 18px;
  width: 18px;
}
.arrow-svg {
  height: 8px;
  margin-left: 4px;
}
.dropdown-user {
  display: flex;
  align-items: center;
  cursor: pointer;
}
.shift-info,
.date-time {
  white-space: nowrap;
}
.flag-box {
  display: flex;
  align-items: center;
}
.flag-img {
  height: 22px;
  width: auto;
  display: block;
  object-fit: contain;
}

/* --- STYLE HÀNG 2: SUB-MENU BAR THỤT LỀ --- */
.bottom-wrapper {
  background-color: #f0f4f6;
  width: 100%;
  padding: 0 40px;
  box-sizing: border-box;
  display: flex;
}
.bottom-bar {
  background-color: #ffffff;
  display: flex;
  flex: 1;
  align-items: center;
  height: 45px;
  width: 100%;
  box-sizing: border-box;
  overflow-x: auto;
  flex-wrap: nowrap;
}

.bottom-bar::-webkit-scrollbar {
  display: none;
}

.sub-tab {
  display: flex;
  align-items: center;
  flex: 1;
  padding: 0 10px;
  font-size: 10px;
  color: #333333;
  white-space: nowrap;
  height: 100%;
  flex-shrink: 0;
}

.sub-tab:hover {
  background-color: #f5f7f8;
}
.sub-icon-img {
  height: 16px;
  width: 16px;
  object-fit: contain;
}
.sub-tab.active {
  background-color: #64b5f6;
  color: #ffffff;
  font-weight: bold;
}
.active-icon {
  position: relative;
  filter: brightness(0) invert(1);
}
</style>
