<script setup>
import { shallowRef } from 'vue'
import Header from './Header.vue'
import RoomMap from './RoomMap.vue'
import RoomAvailability from './RoomAvailability.vue'
import Booking from './Booking.vue'
import Company from './Company.vue'
import GuestSearch from './GuestSearch.vue'
import HistoryLog from './HistoryLog.vue'
import ManageRoom from './ManageRoom.vue'
import RoomLock from './RoomLock.vue'
import RoomSchedule from './RoomSchedule.vue'
import WorkingList from './WorkingList.vue'
import Report from './Report.vue'

// 1. Gom tất cả component vào một Object để dễ quản lý
const viewComponents = {
  RoomMap, RoomAvailability, Booking, Company, GuestSearch,
  HistoryLog, ManageRoom, RoomLock, RoomSchedule, WorkingList, Report
}

// 2. Khai báo component mặc định
const currentView = shallowRef(viewComponents['RoomMap'])

// 3. Hàm xử lý chuyển đổi cực kỳ ngắn gọn
const changeView = (viewName) => {
  // Nếu viewName có tồn tại trong danh sách thì mới chuyển
  if (viewComponents[viewName]) {
    currentView.value = viewComponents[viewName]
  }
}
</script>

<template>
  <div class="flex flex-col h-screen overflow-hidden">
    <header class="shrink-0">
      <Header @on-change-view="changeView" />
    </header>

    <div class="flex flex-1 overflow-hidden">
      <main class="flex-1 bg-gray-100 overflow-auto">
        <component :is="currentView" />
      </main>
    </div>
  </div>
</template>

<style scoped></style>
