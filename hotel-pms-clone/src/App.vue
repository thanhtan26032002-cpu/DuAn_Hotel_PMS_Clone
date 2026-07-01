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

// 1. Khai báo component mặc định khi vừa vào app
const currentView = shallowRef(RoomMap)

// 2. Hàm xử lý chuyển đổi
const changeView = (viewName) => {
  if (viewName === 'RoomMap') currentView.value = RoomMap
  if (viewName == 'RoomAvailability') currentView.value = RoomAvailability
  if (viewName == 'Booking') currentView.value = Booking
  if (viewName == 'Company') currentView.value = Company
  if (viewName == 'GuestSearch') currentView.value = GuestSearch
  if (viewName == 'HistoryLog') currentView.value = HistoryLog
  if (viewName == 'ManageRoom') currentView.value = ManageRoom
  if (viewName == 'RoomLock') currentView.value = RoomLock
  if (viewName == 'RoomSchedule') currentView.value = RoomSchedule
  if (viewName == 'WorkingList') currentView.value = WorkingList
  if (viewName == 'Report') currentView.value = Report
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
