<script setup>
import { ref, onMounted, onBeforeUnmount, computed, watch, nextTick } from 'vue'
import axios from 'axios'

// 1. Biến lưu dữ liệu gốc từ API Laravel
const rawRoomsData = ref([])
const isGridMode = ref(true)
const isFutureMode = ref(false)
const currentDateTime = ref(new Date())
const selectedFutureDate = ref('')
const calendarOpen = ref(false)
const calendarYear = ref(new Date().getFullYear())
const calendarMonth = ref(new Date().getMonth())
const dateTriggerRef = ref(null)
const overlayStyle = ref({ top: '0px', left: '0px', width: '240px' })

const padNumber = (value) => String(value).padStart(2, '0')
const currentDateTimeLabel = computed(() => {
  const date = currentDateTime.value
  return `${padNumber(date.getDate())}/${padNumber(date.getMonth() + 1)}/${date.getFullYear()}`
})

const minFutureDate = computed(() => {
  const date = new Date()
  date.setDate(date.getDate() + 1)
  return `${date.getFullYear()}-${padNumber(date.getMonth() + 1)}-${padNumber(date.getDate())}`
})

const weekDays = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7']

const calendarMonthLabel = computed(() => {
  const monthNames = ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12']
  return `${monthNames[calendarMonth.value]} ${calendarYear.value}`
})

const currentDate = computed(() => new Date())

const calendarDays = computed(() => {
  const year = calendarYear.value
  const month = calendarMonth.value
  const firstDay = new Date(year, month, 1)
  const firstWeekday = firstDay.getDay()
  const daysInMonth = new Date(year, month + 1, 0).getDate()
  const days = []

  for (let i = 0; i < firstWeekday; i += 1) {
    days.push({ key: `blank-${month}-${i}`, date: null, disabled: true })
  }

  for (let day = 1; day <= daysInMonth; day += 1) {
    const fullDate = new Date(year, month, day)
    const isoDate = `${year}-${padNumber(month + 1)}-${padNumber(day)}`
    const disabled = fullDate <= new Date(currentDate.value.getFullYear(), currentDate.value.getMonth(), currentDate.value.getDate())
    days.push({ key: `day-${isoDate}`, date: isoDate, disabled })
  }

  return days
})

const futureDateLabel = computed(() => {
  if (!selectedFutureDate.value) {
    return 'Chọn ngày'
  }
  const date = new Date(selectedFutureDate.value)
  return `${padNumber(date.getDate())}/${padNumber(date.getMonth() + 1)}/${date.getFullYear()}`
})

const displayValue = (value) => {
  if (value === null || value === undefined || value === '') {
    return 'N/A'
  }
  return value
}

const openFutureCalendar = async () => {
  if (!isFutureMode.value) {
    isFutureMode.value = true
  }
  calendarOpen.value = true
  await nextTick()
  updateOverlayPosition()
}

const toggleCalendar = async () => {
  if (!isFutureMode.value) {
    isFutureMode.value = true
    calendarOpen.value = true
    await nextTick()
    updateOverlayPosition()
    return
  }
  calendarOpen.value = !calendarOpen.value
  if (calendarOpen.value) {
    await nextTick()
    updateOverlayPosition()
  }
}

const closeCalendar = () => {
  calendarOpen.value = false
}

const updateOverlayPosition = () => {
  const triggerEl = dateTriggerRef.value
  if (!triggerEl) return
  const rect = triggerEl.getBoundingClientRect()
  overlayStyle.value = {
    top: `${rect.bottom + window.scrollY + 6}px`,
    left: `${rect.left + window.scrollX}px`,
    width: `${rect.width}px`,
  }
}

const handleDocumentClick = (event) => {
  const overlayEl = document.querySelector('.future-calendar-overlay')
  const triggerEl = dateTriggerRef.value
  if (!overlayEl || !triggerEl) return
  if (!overlayEl.contains(event.target) && !triggerEl.contains(event.target)) {
    closeCalendar()
  }
}

const goToPrevMonth = () => {
  if (calendarMonth.value === 0) {
    calendarMonth.value = 11
    calendarYear.value -= 1
  } else {
    calendarMonth.value -= 1
  }
}

const goToNextMonth = () => {
  if (calendarMonth.value === 11) {
    calendarMonth.value = 0
    calendarYear.value += 1
  } else {
    calendarMonth.value += 1
  }
}

const selectFutureDate = (isoDate) => {
  selectedFutureDate.value = isoDate
  closeCalendar()
}

watch(isFutureMode, (enabled) => {
  if (!enabled) {
    closeCalendar()
  }
})

const displayNumberOrNA = (value) => {
  if (value === null || value === undefined) {
    return 'N/A'
  }
  return value
}

const totalRooms = computed(() => rawRoomsData.value.length)
const arrivalCount = computed(() => rawRoomsData.value.filter((room) => room.is_arrival).length)
const departureCount = computed(() => rawRoomsData.value.filter((room) => room.is_departure).length)
const occupiedCount = computed(() => rawRoomsData.value.filter((room) => room.is_occupied).length)
const occupancyRate = computed(() => {
  if (!totalRooms.value) return 0
  return Math.round((occupiedCount.value / totalRooms.value) * 100)
})

const tableRows = computed(() => {
  return rawRoomsData.value
    .map((room) => ({
      roomName: room.room_number,
      roomForm: displayValue(room.room_form?.form_name || room.room_form_name || room.room_form),
      roomType: displayValue(room.room_type?.type_short_name || room.room_type?.type_name || room.room_type?.name),
      clientNumber: displayNumberOrNA(room.max_guests),
      extraBeds: displayNumberOrNA(room.extra_beds),
      linkedRoomNumber: displayValue(room.linked_room_number),
      guestName: displayValue(room.guest_name || room.guest_full_name || room.customer_name),
      registrationCode: displayValue(room.registration_code || room.booking_code || room.code),
      arrivalDate: displayValue(room.arrival_date || room.check_in_date || room.date_arrival),
      departureDate: displayValue(room.departure_date || room.check_out_date || room.date_departure),
      company: displayValue(room.company_name || room.company || room.agent),
      floor: displayValue(room.floor),
      note: displayValue(room.note || room.notes),
      isLocked: room.is_locked || false,
      isDirty: room.clean_status === 'Dirty',
      isOccupied: room.is_occupied || false,
      dotColor: room.is_departure ? 'red' : room.is_arrival ? 'green' : null,
      isNameRed: !!room.is_departure,
      isArrival: !!room.is_arrival,
      isDeparture: !!room.is_departure,
      statusText: room.is_departure
        ? 'Đã đi'
        : room.is_arrival
        ? 'Đã đến'
        : room.is_occupied
        ? 'Đang ở'
        : 'Trống',
    }))
    .sort((a, b) =>
      String(a.roomName).localeCompare(String(b.roomName), undefined, {
        numeric: true,
      })
    )
    .map((row, index) => ({
      ...row,
      order: index + 1,
    }))
})

// 2. Gọi API để lấy danh sách từ Database
const fetchRooms = async () => {
  try {
    const response = await axios.get('http://127.0.0.1:8000/api/rooms')
    rawRoomsData.value = response.data
  } catch (error) {
    console.error('Lỗi API Laravel:', error)
  }
}

let dateTimer = null
const startClock = () => {
  currentDateTime.value = new Date()
  dateTimer = setInterval(() => {
    currentDateTime.value = new Date()
  }, 1000)
}

const stopClock = () => {
  if (dateTimer) {
    clearInterval(dateTimer)
    dateTimer = null
  }
}

// 3. XỬ LÝ DỮ LIỆU: Gom nhóm theo Tầng và ánh xạ các icon trạng thái theo hình
const roomsDataGrouped = computed(() => {
  const floorMap = {}

  rawRoomsData.value.forEach((room) => {
    const floorKey = room.floor || 'Khác'

    if (!floorMap[floorKey]) {
      floorMap[floorKey] = []
    }

    // Ánh xạ dữ liệu cột MySQL -> Thuộc tính hiển thị trên giao diện Vue
    floorMap[floorKey].push({
      roomName: room.room_number,
      roomForm: room.room_form?.form_name || room.room_form_name || room.room_form || 'N/A',
      roomType: room.room_type?.type_short_name || room.room_type?.type_name || 'N/A',
      clientNumber: room.max_guests || 0,
      isLocked: room.is_locked || false,
      isDirty: room.clean_status === 'Dirty',
      isOccupied: room.is_occupied || false,
      dotColor: room.is_departure ? 'red' : room.is_arrival ? 'green' : null,
      isNameRed: room.is_departure ? true : false,
    })
  })

  return Object.keys(floorMap)
    .sort((a, b) => Number(a) - Number(b))
    .map((key) => {
      const sortedRooms = floorMap[key].sort((roomA, roomB) => {
        return String(roomA.roomName).localeCompare(String(roomB.roomName), undefined, {
          numeric: true,
        })
      })

      return {
        floorName: `${key}`,
        rooms: sortedRooms,
      }
    })
})

const roomRowClass = (room) => {
  if (room.isDeparture) return 'table-row-departure'
  if (room.isArrival) return 'table-row-arrival'
  if (room.isOccupied) return 'table-row-occupied'
  return 'table-row-vacant'
}

// 4. Chạy hàm lấy dữ liệu khi vừa mở trang
onMounted(() => {
  fetchRooms()
  startClock()
  document.addEventListener('click', handleDocumentClick)
})

onBeforeUnmount(() => {
  stopClock()
  document.removeEventListener('click', handleDocumentClick)
})
</script>

<template>
  <div class="hotel-pms-container">
    <aside class="pms-sidebar">
      <div
        ref="dateTriggerRef"
        class="sidebar-date-box future-date-trigger"
        :class="{ 'future-selected': isFutureMode }"
        @click="openFutureCalendar"
      >
        <span v-if="!isFutureMode">{{ currentDateTimeLabel }}</span>
        <span v-else>{{ futureDateLabel }}</span>
      </div>

      <teleport to="body">
        <div
          v-if="isFutureMode && calendarOpen"
          class="future-calendar-overlay"
          :style="overlayStyle"
        >
          <div class="calendar-header">
            <button type="button" class="calendar-nav" @click.stop="goToPrevMonth">‹</button>
            <span class="calendar-title">{{ calendarMonthLabel }}</span>
            <button type="button" class="calendar-nav" @click.stop="goToNextMonth">›</button>
          </div>
          <div class="calendar-grid-weekdays">
            <span v-for="day in weekDays" :key="day" class="calendar-weekday">{{ day }}</span>
          </div>
          <div class="calendar-grid-days">
            <button
              v-for="day in calendarDays"
              :key="day.key"
              type="button"
              :class="[
                'calendar-day',
                { disabled: day.disabled, selected: day.date === selectedFutureDate }
              ]"
              :disabled="day.disabled"
              @click="selectFutureDate(day.date)"
            >
              {{ day.date ? day.date.split('-')[2] : '' }}
            </button>
          </div>
        </div>
      </teleport>

      <div class="sidebar-toggle-group">
        <label class="switch-sidebar">
          <input type="checkbox" v-model="isFutureMode" />
          <span class="slider-sidebar slider-time"></span>
        </label>
      </div>

      <div class="pms-stat-item">
        <span class="stat-title">Đã đến</span>
        <span class="stat-value">{{ arrivalCount }} / {{ totalRooms }}</span>
      </div>

      <div class="pms-stat-item">
        <span class="stat-title">Đã đi</span>
        <span class="stat-value">{{ departureCount }} / {{ totalRooms }}</span>
      </div>

      <div class="pms-stat-item">
        <span class="stat-title">Đang ở</span>
        <span class="stat-value">{{ occupiedCount }} / {{ totalRooms }}</span>
      </div>

      <div class="pms-stat-item stat-percent">
        <span class="stat-title">Thống kê</span>
        <span class="stat-value">{{ occupancyRate }}%</span>
      </div>

      <div class="sidebar-action-grid">

        <button class="action-btn" title="Hóa đơn">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M16 2H8a2 2 0 0 0-2 2v16l2-1 2 1 2-1 2 1 2-1 2 1V4a2 2 0 0 0-2-2z"></path>
            <line x1="9" y1="8" x2="15" y2="8"></line>
            <line x1="9" y1="12" x2="15" y2="12"></line>
          </svg>
        </button>

        <button class="action-btn" title="Nhóm hóa đơn">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M17 2h2a2 2 0 0 1 2 2v11l-2-1-2 1" opacity="0.65"></path>
            <path d="M13 6H5a2 2 0 0 0-2 2v14l2-1 2 1 2-1 2 1 2-1 2 1V8a2 2 0 0 0-2-2z"></path>
            <line x1="6" y1="11" x2="10" y2="11"></line>
            <line x1="6" y1="15" x2="10" y2="15"></line>
          </svg>
        </button>


        <button class="action-btn" title="Thêm mới">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"></circle>
            <line x1="12" y1="8" x2="12" y2="16"></line>
            <line x1="8" y1="12" x2="16" y2="12"></line>
          </svg>
        </button>

        <button class="action-btn" title="Thông tin">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"></circle>
            <line x1="12" y1="16" x2="12" y2="12"></line>
            <line x1="12" y1="8" x2="12.01" y2="8"></line>
          </svg>
        </button>


        <button class="action-btn-blue" title="Tìm kiếm">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"></circle>
            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
          </svg>
        </button>

        <button class="action-btn-blue" title="Biểu tượng">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"></circle>
            <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
            <line x1="12" y1="17" x2="12.01" y2="17"></line>
          </svg>
        </button>

      </div>

      <div class="sidebar-toggle-group bottom-toggle">
        <label class="switch-sidebar">
          <input type="checkbox" v-model="isGridMode" />
          <span class="slider-sidebar slider-view"></span>
        </label>
      </div>

      <div class="sidebar-setting">
        <svg
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
          class="icon-setting"
        >
          <circle cx="12" cy="12" r="3"></circle>
          <path
            d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"
          ></path>
        </svg>
      </div>
    </aside>

    <main class="pms-main-viewport">
      <div class="pms-scrollable-canvas">
        <template v-if="isGridMode">
          <div class="board-view-header">
            <div class="board-title">Sơ đồ phòng</div>
            <div class="board-count">Tổng phòng: {{ rawRoomsData.length }}</div>
          </div>
          <div v-for="(floor, fIndex) in roomsDataGrouped" :key="fIndex" class="pms-floor-row">
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

                <div class="card-top-row">
                  <div class="card-info-box">
                    <span :class="['room-number-title', { 'color-alert-red': room.isNameRed }]">
                      {{ room.roomName }}
                    </span>
                    <span class="room-type-sub">{{ room.roomType }}</span>
                  </div>
                  <span class="room-capacity-pill">
                    SL: {{ room.clientNumber }}
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

                <div v-if="room.isDirty" class="card-bottom-icon-right">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
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
        </template>

        <template v-else>
          <div class="table-view-header">
            <div class="table-title">Danh sách phòng</div>
            <div class="table-count">Tổng bản ghi: {{ tableRows.length }}</div>
          </div>
          <div class="table-wrap">
            <table class="data-table">
              <thead>
                <tr>
                  <th>STT</th>
                  <th>Phòng</th>
                  <th>Dạng phòng</th>
                  <th>Loại</th>
                  <th>SL khách</th>
                  <th>Giường phụ</th>
                  <th>Liên phòng</th>
                  <th>Khách</th>
                  <th>Mã ĐK</th>
                  <th>Ngày đến</th>
                  <th>Ngày đi</th>
                  <th>Công ty</th>
                  <th>Tầng</th>
                  <th>Trạng thái</th>
                  <th>Ghi chú</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(row, index) in tableRows" :key="index" :class="roomRowClass(row)">
                  <td>{{ row.order }}</td>
                  <td>
                    <span :class="['room-number-title', { 'color-alert-red': row.isNameRed }]">
                      {{ row.roomName }}
                    </span>
                  </td>
                  <td>{{ row.roomForm }}</td>
                  <td>{{ row.roomType }}</td>
                  <td>{{ row.clientNumber }}</td>
                  <td>{{ row.extraBeds }}</td>
                  <td>{{ row.linkedRoomNumber }}</td>
                  <td>{{ row.guestName }}</td>
                  <td>{{ row.registrationCode }}</td>
                  <td>{{ row.arrivalDate }}</td>
                  <td>{{ row.departureDate }}</td>
                  <td>{{ row.company }}</td>
                  <td>{{ row.floor }}</td>
                  <td>
                    <span class="status-chip">{{ row.statusText }}</span>
                  </td>
                  <td>{{ row.note }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </template>
      </div>
    </main>
  </div>
</template>

<style scoped>
/* KHUNG CHỨA TOÀN BỘ ỨNG DỤNG */
.hotel-pms-container {
  display: flex;
  width: 100%;
  height: 100vh;
  background-color: #f1f5f9;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  overflow: hidden !important;
}

/* THANH SIDEBAR BÊN TRÁI */
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
  overflow-y: auto;
  overflow-x: visible;
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

.sidebar-date-box.future-selected {
  background-color: #fff7ed;
  border-color: #fbbf24;
}

.future-date-panel {
  width: 100%;
  margin-bottom: 10px;
  position: relative;
}

.future-date-trigger {
  cursor: pointer;
  position: relative;
}

.future-date-button {
  width: 100%;
  padding: 8px 10px;
  border: 1px solid #cbd5e1;
  border-radius: 10px;
  background: #ffffff;
  color: #0f172a;
  text-align: left;
  font-size: 12px;
  cursor: pointer;
}

.future-calendar-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 300px;
  padding: 14px;
  background: #ffffff;
  border: 1px solid #cbd5e1;
  border-radius: 16px;
  box-shadow: 0 16px 36px rgba(15, 23, 42, 0.16);
  z-index: 9999;
}

.future-calendar-overlay::before {
  content: '';
  position: absolute;
  top: -8px;
  left: 28px;
  width: 16px;
  height: 16px;
  background: #ffffff;
  transform: rotate(45deg);
  border-left: 1px solid #cbd5e1;
  border-top: 1px solid #cbd5e1;
}

.calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.calendar-title {
  font-size: 14px;
  font-weight: 800;
  color: #0f172a;
}

.calendar-nav {
  border: none;
  background: transparent;
  color: #0f172a;
  font-size: 20px;
  cursor: pointer;
  padding: 6px 10px;
}

.calendar-grid-weekdays,
.calendar-grid-days {
  display: grid;
  grid-template-columns: repeat(7, minmax(0, 1fr));
  gap: 6px;
}

.calendar-weekday {
  font-size: 12px;
  font-weight: 700;
  text-align: center;
  color: #475569;
}

.calendar-day {
  width: 36px;
  height: 36px;
  border: none;
  border-radius: 10px;
  background: #f8fafc;
  color: #0f172a;
  cursor: pointer;
  font-size: 14px;
  font-weight: 700;
}

.calendar-day.selected {
  background: #38bdf8;
  color: white;
}

.calendar-day.disabled {
  background: #f1f5f9;
  color: #94a3b8;
  cursor: not-allowed;
}

.sidebar-toggle-group {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}
.sidebar-toggle-group.bottom-toggle {
  margin-top: 10px;
  margin-bottom: auto;
}

.switch-sidebar input {
  opacity: 0;
  width: 0;
  height: 0;
}

.switch-sidebar {
  position: relative;
  display: inline-block;
  width: 100px;
  height: 28px;
}

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

.switch-sidebar input:checked + .slider-sidebar {
  background-color: #7dd3fc;
}
.switch-sidebar input:checked + .slider-sidebar::before {
  transform: translateX(72px);
}

.slider-time::after {
  content: 'Hiện tại';
  right: 12px;
}
.switch-sidebar input:checked + .slider-time::after {
  content: 'Tương lai';
  right: auto;
  left: 10px;
  color: white;
}

.slider-view::after {
  content: 'Lưới';
  right: 18px;
}
.switch-sidebar input:checked + .slider-view::after {
  content: 'Bảng';
  right: auto;
  left: 15px;
  color: white;
}

.icon-setting {
  height: 30px;
  width: 30px;
  margin-bottom: 20px;
}

/* Khối thống kê ô xanh nước biển nhạt */
.pms-stat-item {
  width: 100%;
  background-color: #bae6fd;
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
  background-color: #e2e8f0;
}

/* Lưới chứa các nút tính năng */
.sidebar-action-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 6px;
  width: 100%;
  margin-top: 8px;
}

/* Định dạng chung cho nút chức năng */
.action-btn,
.action-btn-blue {
  aspect-ratio: 1;
  width: 100%;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  padding: 0;
  transition: all 0.15s ease;
}

/* Nút xám mặc định */
.action-btn {
  background-color: #f1f5f9;
  border: 1px solid #e2e8f0;
  color: #475569;
}
.action-btn:hover {
  background-color: #e2e8f0;
  color: #1e293b;
}

/* Nút xanh tìm kiếm / trợ giúp */
.action-btn-blue {
  background-color: #e0f2fe;
  border: 1px solid #bae6fd;
  color: #0369a1;
}
.action-btn-blue:hover {
  background-color: #bae6fd;
  color: #0c4a6e;
}

/* Ép kích thước SVG bằng nhau chuẩn chỉ */
.action-btn svg,
.action-btn-blue svg {
  width: 18px;
  height: 18px;
  display: block;
}

/* Icon cài đặt dưới cùng */
.sidebar-setting {
  margin-top: 10px;
  margin-bottom: 15px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.icon-setting {
  height: 24px;
  width: 24px;
  color: #64748b;
  transition: all 0.25s ease;
}
.sidebar-setting:hover .icon-setting {
  transform: rotate(45deg);
  color: #334155;
}

/* CSS cho icon Bánh răng cài đặt dưới đáy */
.sidebar-setting {
  margin-bottom: 15px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.icon-setting {
  height: 24px;
  width: 24px;
  color: #64748b;
  transition: transform 0.3s ease;
}
.sidebar-setting:hover .icon-setting {
  transform: rotate(45deg); /* Hiệu ứng xoay nhẹ khi di chuột vào bánh răng cho sinh động */
  color: #334155;
}

/* KHU VỰC HIỂN THỊ SƠ ĐỒ PHÒNG CHÍNH */
.pms-main-viewport {
  flex: 1;
  padding: 14px 14px 12px;
  overflow: hidden;
  background-color: #f8fbff;
}

.pms-scrollable-canvas {
  width: 100%;
  height: calc(100vh - 38px);
  overflow-x: auto;
  overflow-y: auto;
  padding: 10px 0 10px 10px;
}

.pms-floor-row {
  display: flex;
  align-items: flex-start;
  gap: 8px;
  margin-bottom: 10px;
  width: max-content;
}

.pms-floor-sticky-header {
  width: 64px;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  position: sticky;
  left: 0;
  z-index: 5;
  background-color: #f8fbff;
  padding-right: 10px;
}

.floor-badge-icon {
  width: 42px;
  height: 42px;
  background-color: #dbeafe;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 800;
  font-size: 14px;
  color: #0f172a;
  box-shadow: inset 0 0 0 1px rgba(59, 130, 246, 0.2);
}

.pms-rooms-horizontal-list {
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: minmax(148px, 148px);
  gap: 10px;
  overflow-x: auto;
  padding-bottom: 4px;
  align-items: start;
}

/* CẤU TRÚC CHI TIẾT THẺ PHÒNG (ROOM CARD) */
.pms-room-card {
  width: 148px;
  min-width: 148px;
  height: 90px;
  border-radius: 18px;
  padding: 10px;
  box-sizing: border-box;
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border: 1px solid transparent;
  flex-shrink: 0;
  background-color: #ffffff;
  box-shadow: 0 2px 10px rgba(15, 23, 42, 0.08);
}

/* Các trạng thái màu nền phòng */
.pms-room-card.state-occupied {
  background-color: #eff6ff;
  border-color: #93c5fd;
  box-shadow: 0 2px 10px rgba(59, 130, 246, 0.14);
}
.pms-room-card.state-vacant {
  background-color: #ffffff;
  border-color: #e2e8f0;
}

.card-top-row {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 8px;
}

.card-info-box {
  display: flex;
  flex-direction: column;
}

.room-number-title {
  font-weight: 800;
  font-size: 16px;
  color: #0f172a;
  line-height: 1.1;
}

.room-number-title.color-alert-red {
  color: #dc2626;
}

.room-type-sub {
  font-size: 12px;
  color: #475569;
  font-weight: 600;
  margin-top: 8px;
  line-height: 1.2;
}

.room-capacity-pill {
  background: #eff6ff;
  color: #0369a1;
  font-size: 11px;
  font-weight: 700;
  border-radius: 999px;
  padding: 4px 8px;
  align-self: flex-start;
}

/* Chấm trạng thái góc trên bên phải */
.card-status-dot {
  position: absolute;
  top: 8px;
  right: 8px;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  border: 2px solid rgba(255, 255, 255, 0.9);
}
.card-status-dot.red {
  background-color: #ef4444; /* Phòng đi */
}
.card-status-dot.green {
  background-color: #22c55e; /* Phòng đến */
}

.board-view-header,
.table-view-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 14px;
  gap: 12px;
}

.grid-cards-wrap,
.grid-room-card,
.grid-card-top,
.grid-room-type,
.grid-room-meta,
.grid-room-footer,
.table-dot,
.table-dot.red,
.table-dot.green {
  display: none;
}
.board-title,
.table-title {
  font-size: 16px;
  font-weight: 700;
  color: #0f172a;
}
.board-count,
.table-count {
  color: #475569;
  font-size: 13px;
}

.table-wrap {
  width: 100%;
  overflow-x: auto;
  background: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  min-width: 1200px;
}

.data-table th,
.data-table td {
  padding: 12px 14px;
  border-bottom: 1px solid #e2e8f0;
  font-size: 13px;
  color: #334155;
  text-align: left;
}

.data-table thead th {
  background: #f8fafc;
  color: #0f172a;
  font-weight: 700;
}

.data-table tbody tr:hover {
  background: #e2f2ff;
}

.data-table tbody tr.table-row-departure {
  background: rgba(254, 226, 226, 0.7);
}
.data-table tbody tr.table-row-arrival {
  background: rgba(220, 252, 231, 0.7);
}
.data-table tbody tr.table-row-occupied {
  background: rgba(219, 234, 254, 0.7);
}
.data-table tbody tr.table-row-vacant {
  background: #ffffff;
}

.data-table tbody tr td {
  vertical-align: middle;
}

.grid-cards-wrap {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
  gap: 12px;
  width: 100%;
}

.grid-room-card {
  min-height: 96px;
  background: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  padding: 12px;
  box-shadow: 0 1px 3px rgba(15, 23, 42, 0.06);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  position: relative;
}

.grid-room-card.state-occupied {
  background: #eff6ff;
}

.grid-card-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.grid-room-type {
  margin-top: 8px;
  font-size: 12px;
  color: #475569;
}

.grid-room-meta {
  display: flex;
  justify-content: space-between;
  gap: 8px;
  margin-top: 10px;
  color: #64748b;
  font-size: 12px;
}

.grid-room-footer {
  margin-top: 10px;
}

.table-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  display: inline-block;
}

.table-dot.red {
  background-color: #ef4444;
}
.table-dot.green {
  background-color: #22c55e;
}

.table-row-departure {
  background: rgba(254, 226, 226, 0.7);
}
.table-row-arrival {
  background: rgba(220, 252, 231, 0.7);
}
.table-row-occupied {
  background: rgba(219, 234, 254, 0.7);
}
.table-row-vacant {
  background: #ffffff;
}

.status-chip {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: #e2e8f0;
  color: #0f172a;
  border-radius: 999px;
  padding: 4px 9px;
  font-size: 12px;
  font-weight: 700;
}

/* Định vị biểu tượng ổ khóa (Góc trái dưới) */
.card-bottom-icon-left {
  position: absolute;
  bottom: 6px;
  left: 8px;
  width: 14px;
  height: 14px;
  color: #ef4444;
}
.card-bottom-icon-left svg {
  width: 100%;
  height: 100%;
}

/* Định vị biểu tượng cây chổi dọn dẹp (Góc phải dưới) */
.card-bottom-icon-right {
  position: absolute;
  bottom: 6px;
  right: 8px;
  width: 14px;
  height: 14px;
  color: #475569;
}
.card-bottom-icon-right svg {
  width: 100%;
  height: 100%;
  display: block;
}

/* THANH KÉO (SCROLLBAR) MẢNH */
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
