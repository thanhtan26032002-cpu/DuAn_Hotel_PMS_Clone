<template>
  <div class="pms-wrapper">
    <div class="topbar-pms">
      <div class="topbar-left-group">
        <div class="date-range-picker">
          <input type="text" value="24 / 06 / 2026   ~   03 / 08 / 2026" readonly />
          <span class="calendar-icon-right">
            <svg
              width="14"
              height="14"
              viewBox="0 0 24 24"
              fill="none"
              stroke="#28a745"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
              <line x1="16" y1="2" x2="16" y2="6"></line>
              <line x1="8" y1="2" x2="8" y2="6"></line>
              <line x1="3" y1="10" x2="21" y2="10"></line>
            </svg>
          </span>
        </div>

        <button class="btn-pms-view">View</button>

        <button class="btn-pms-setting">
          <svg
            width="16"
            height="16"
            viewBox="0 0 24 24"
            fill="none"
            stroke="#555"
            stroke-width="2"
          >
            <circle cx="12" cy="12" r="3"></circle>
            <path
              d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"
            ></path>
          </svg>
        </button>

        <div class="select-pms-container">
          <select>
            <option>Loại phòng: 0</option>
          </select>
        </div>

        <div class="pms-switch-group">
          <div class="toggle-item-inner" @click="uiState.viewNight = !uiState.viewNight">
            <div class="toggle-track-inner" :class="{ active: uiState.viewNight }">
              <span class="toggle-text-inside">
                {{ uiState.viewNight ? 'Xem ngày' : 'Xem đêm' }}
              </span>
              <div class="toggle-knob-inner"></div>
            </div>
          </div>

          <div class="toggle-item-inner" @click="uiState.viewNotes = !uiState.viewNotes">
            <div class="toggle-track-inner" :class="{ active: uiState.viewNotes }">
              <span class="toggle-text-inside">
                {{ uiState.viewNotes ? 'Ghi chú' : 'Ghi chú' }}
              </span>
              <div class="toggle-knob-inner"></div>
            </div>
          </div>
        </div>

        <div class="pms-search-group">
          <input type="text" placeholder="Nhập tên khách mã book..." />
          <button class="pms-search-btn">
            <svg
              width="12"
              height="12"
              viewBox="0 0 24 24"
              fill="none"
              stroke="white"
              stroke-width="3"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <circle cx="11" cy="11" r="8"></circle>
              <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
          </button>
        </div>
      </div>

      <div class="topbar-right-legends">
        <div class="legend-block ooo-pattern">OOO</div>
        <div class="legend-block oos-pattern">OOS</div>
        <div class="legend-block status-inhouse">InHouse</div>
        <div class="legend-block status-reservation">Reservation</div>
        <div class="legend-block status-late">Late Check...</div>
      </div>
    </div>

    <div class="pms-matrix-viewport">
      <div class="pms-matrix-table">
        <div class="matrix-row header-row">
          <div class="sticky-side-column corner-blank-cell"></div>
          <div class="timeline-cells-strip">
            <div
              v-for="(day, idx) in timelineDays"
              :key="'day-' + idx"
              class="matrix-cell header-cell day-cell"
              :class="{ 'weekend-blue': day.isWeekend, 'current-day': idx === 0 }"
            >
              {{ day.dayName }}
            </div>
          </div>
        </div>

        <div class="matrix-row header-row border-double-bottom">
          <div class="sticky-side-column corner-blank-cell"></div>
          <div class="timeline-cells-strip">
            <div
              v-for="(day, idx) in timelineDays"
              :key="'date-' + idx"
              class="matrix-cell header-cell date-cell"
              :class="{ 'weekend-blue': day.isWeekend, 'current-day': idx === 0 }"
            >
              {{ day.dateStr }}
            </div>
          </div>
        </div>

        <div v-for="room in roomsData" :key="room.id" class="matrix-row data-room-row">
          <div class="sticky-side-column room-info-cell">
            <span class="room-number-txt">{{ room.number }}</span>
            <div class="room-type-stack">
              <span>{{ room.type.split(' ')[0] }}</span>
              <span>{{ room.type.split(' ')[1] }}</span>
            </div>
            <span class="room-clean-brush-wrapper">
              <svg
                width="15"
                height="15"
                viewBox="0 0 24 24"
                fill="currentColor"
                style="color: #666"
              >
                <path
                  d="M19.36,2.72L20.78,4.14L15.06,9.85C16.13,11.39 16.28,13.24 15.38,14.44L9.06,20.76C8.5,21.32 7.72,21.5 6.94,21.39L6.5,21.83L3.67,19L4.11,18.55C4,17.77 4.18,17 4.74,16.44L11.06,10.12C12.26,9.22 14.11,9.37 15.65,10.44L21.36,4.72M8.94,18.82C9.46,18.3 9.77,17.58 9.87,16.81L7.19,14.13C6.42,14.23 5.7,14.54 5.18,15.06L4.74,15.5L8.5,19.26L8.94,18.82M14.07,11.37L10.58,14.86C11.55,15.63 12.87,15.84 14.03,15.3L15.3,14.03C15.84,12.87 15.63,11.55 14.86,10.58L14.07,11.37Z"
                />
              </svg>
            </span>
          </div>

          <div class="timeline-cells-strip relative-container">
            <div
              v-for="(day, idx) in timelineDays"
              :key="'grid-cell-' + idx"
              class="matrix-cell timeline-empty-cell"
            ></div>

            <div
              v-for="booking in getBookingsByRoom(room.number)"
              :key="booking.id"
              class="pms-booking-bar"
              :class="booking.theme"
              :style="calcBookingPosition(booking)"
            >
              <span class="booking-title-content">{{ booking.text }}</span>
              <span v-if="booking.hasCashIcon" class="cash-icon-tag"> -0- </span>
            </div>
          </div>
        </div>

        <div class="matrix-row footer-summary-row row-occ">
          <div class="sticky-side-column footer-heading label-occ">
            <span>OCC</span>
            <span>1344 (48.85%)</span>
          </div>
          <div class="timeline-cells-strip">
            <div
              v-for="(day, idx) in timelineDays"
              :key="'foot-occ-' + idx"
              class="matrix-cell footer-data-cell text-bold"
            >
              {{ day.occ }}<br /><span class="percentage-sub">({{ day.occRatio }})</span>
            </div>
          </div>
        </div>

        <!-- Phần footer -->

        <div class="matrix-row footer-summary-row row-av">
          <div class="sticky-side-column footer-heading label-av">
            <span>AV</span>
            <span>1407</span>
          </div>
          <div class="timeline-cells-strip">
            <div
              v-for="(day, idx) in timelineDays"
              :key="'foot-av-' + idx"
              class="matrix-cell footer-data-cell text-bold"
            >
              {{ day.av }}
            </div>
          </div>
        </div>

        <div class="matrix-row footer-summary-row row-ooo">
          <div class="sticky-side-column footer-heading label-ooo">
            <span>OOO</span>
            <span>0</span>
          </div>
          <div class="timeline-cells-strip">
            <div
              v-for="(day, idx) in timelineDays"
              :key="'foot-ooo-' + idx"
              class="matrix-cell footer-data-cell text-bold"
            >
              {{ day.ooo }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'

const uiState = reactive({
  viewNight: false,
  viewNotes: true,
})

const COLUMN_WIDTH = 72

const timelineDays = ref([
  {
    dayName: 'T4',
    dateStr: '24/06',
    isWeekend: false,
    occ: 86,
    occRatio: '65.65%',
    av: 45,
    ooo: 0,
  },
  {
    dayName: 'T5',
    dateStr: '25/06',
    isWeekend: false,
    occ: 57,
    occRatio: '43.51%',
    av: 74,
    ooo: 0,
  },
  {
    dayName: 'T6',
    dateStr: '26/06',
    isWeekend: false,
    occ: 72,
    occRatio: '54.96%',
    av: 59,
    ooo: 0,
  },
  { dayName: 'T7', dateStr: '27/06', isWeekend: true, occ: 65, occRatio: '49.62%', av: 66, ooo: 0 },
  { dayName: 'CN', dateStr: '28/06', isWeekend: true, occ: 42, occRatio: '32.06%', av: 89, ooo: 0 },
  {
    dayName: 'T2',
    dateStr: '29/06',
    isWeekend: false,
    occ: 54,
    occRatio: '41.22%',
    av: 77,
    ooo: 0,
  },
  {
    dayName: 'T3',
    dateStr: '30/06',
    isWeekend: false,
    occ: 36,
    occRatio: '27.48%',
    av: 95,
    ooo: 0,
  },
  {
    dayName: 'T4',
    dateStr: '01/07',
    isWeekend: false,
    occ: 61,
    occRatio: '46.56%',
    av: 70,
    ooo: 0,
  },
  {
    dayName: 'T5',
    dateStr: '02/07',
    isWeekend: false,
    occ: 57,
    occRatio: '43.51%',
    av: 74,
    ooo: 0,
  },
  {
    dayName: 'T6',
    dateStr: '03/07',
    isWeekend: false,
    occ: 54,
    occRatio: '41.22%',
    av: 77,
    ooo: 0,
  },
  { dayName: 'T7', dateStr: '04/07', isWeekend: true, occ: 56, occRatio: '42.75%', av: 75, ooo: 0 },
  { dayName: 'CN', dateStr: '05/07', isWeekend: true, occ: 56, occRatio: '42.75%', av: 75, ooo: 0 },
  {
    dayName: 'T2',
    dateStr: '06/07',
    isWeekend: false,
    occ: 56,
    occRatio: '42.75%',
    av: 75,
    ooo: 0,
  },
  {
    dayName: 'T3',
    dateStr: '07/07',
    isWeekend: false,
    occ: 57,
    occRatio: '43.51%',
    av: 74,
    ooo: 0,
  },
  {
    dayName: 'T4',
    dateStr: '08/07',
    isWeekend: false,
    occ: 57,
    occRatio: '43.51%',
    av: 74,
    ooo: 0,
  },
  {
    dayName: 'T5',
    dateStr: '09/07',
    isWeekend: false,
    occ: 52,
    occRatio: '39.69%',
    av: 79,
    ooo: 0,
  },
  { dayName: 'T6', dateStr: '10/07', isWeekend: false, occ: 131, occRatio: '100%', av: 0, ooo: 0 },
])

const roomsData = ref([
  { id: 1, number: '401', type: 'DLXD Double' },
  { id: 2, number: '402', type: 'DLXTB Twin' },
  { id: 3, number: '403', type: 'DLXTB Twin' },
  { id: 4, number: '404', type: 'SUPT Twin' },
  { id: 5, number: '405', type: 'FAM Family' },
  { id: 6, number: '406', type: 'SUPT Twin' },
  { id: 7, number: '407', type: 'SUPTR Triple' },
  { id: 8, number: '408', type: 'SUPD Double' },
  { id: 9, number: '409', type: 'SUPTR Triple' },
  { id: 10, number: '410', type: 'SUPT Twin' },
  { id: 11, number: '411', type: 'DLXDB Double' },
])

const bookingsData = ref([
  { id: 101, roomNum: '401', text: 'VIETRAVEL...', theme: 'theme-cyan', startIdx: 1, duration: 4 },
  {
    id: 102,
    roomNum: '401',
    text: 'GAL 4031 - T...',
    theme: 'theme-green',
    startIdx: 17,
    duration: 1,
  },
  { id: 103, roomNum: '402', text: 'VIETRAVEL...', theme: 'theme-cyan', startIdx: 1, duration: 3 },
  {
    id: 104,
    roomNum: '402',
    text: 'GAL 4737 - ODEON TOUR - 4472796 - ODEON TOURS - 890,000đ',
    theme: 'theme-green',
    startIdx: 4,
    duration: 11,
  },
  { id: 105, roomNum: '403', text: 'VIETRAV...', theme: 'theme-cyan', startIdx: 1, duration: 1 },
  {
    id: 106,
    roomNum: '403',
    text: 'GAL 4927 - GREEN TRAVEL GROUP - 401513 - GRE...',
    theme: 'theme-green',
    startIdx: 14,
    duration: 4,
  },
  {
    id: 107,
    roomNum: '404',
    text: 'VIETRAVEL LÂM ĐỒN...',
    theme: 'theme-cyan',
    startIdx: 1,
    duration: 2,
  },
  {
    id: 108,
    roomNum: '404',
    text: 'GAL 4966 - THÁI Đ...',
    theme: 'theme-green',
    startIdx: 3,
    duration: 2,
    hasCashIcon: true,
  },
  {
    id: 109,
    roomNum: '404',
    text: 'GAL 4967 - THÁI ĐẠ...',
    theme: 'theme-green',
    startIdx: 6,
    duration: 3,
  },
  {
    id: 110,
    roomNum: '404',
    text: 'GAL 4031 - T...',
    theme: 'theme-green',
    startIdx: 17,
    duration: 1,
  },
  { id: 111, roomNum: '405', text: 'VIETRA...', theme: 'theme-cyan', startIdx: 1, duration: 1 },
  {
    id: 112,
    roomNum: '405',
    text: 'GAL 4031 - T...',
    theme: 'theme-green',
    startIdx: 17,
    duration: 1,
  },
  { id: 113, roomNum: '406', text: 'VIETRA...', theme: 'theme-cyan', startIdx: 1, duration: 1 },
  {
    id: 114,
    roomNum: '406',
    text: 'GAL 4966 - THÁI...',
    theme: 'theme-green',
    startIdx: 3,
    duration: 2,
    hasCashIcon: true,
  },
  {
    id: 115,
    roomNum: '406',
    text: 'GAL 5328 - PEGAS - 10686477 - PEGAS - 540,000đ',
    theme: 'theme-green',
    startIdx: 6,
    duration: 11,
  },
  {
    id: 116,
    roomNum: '406',
    text: 'GAL 4031 - T...',
    theme: 'theme-green',
    startIdx: 17,
    duration: 1,
  },
  { id: 117, roomNum: '407', text: 'VIETRA...', theme: 'theme-cyan', startIdx: 1, duration: 1 },
  { id: 118, roomNum: '407', text: 'GAL 49...', theme: 'theme-green', startIdx: 15, duration: 1 },
  {
    id: 119,
    roomNum: '407',
    text: 'GAL 4031 - T...',
    theme: 'theme-green',
    startIdx: 17,
    duration: 1,
  },
  {
    id: 120,
    roomNum: '408',
    text: 'VIETRAVEL LÂM ĐỒN...',
    theme: 'theme-cyan',
    startIdx: 1,
    duration: 2,
  },
  {
    id: 121,
    roomNum: '408',
    text: 'GAL 5499 - Walkin Guest - KHÁCH...',
    theme: 'theme-charcoal',
    startIdx: 5,
    duration: 4,
  },
  {
    id: 122,
    roomNum: '408',
    text: 'GAL 4031 - T...',
    theme: 'theme-green',
    startIdx: 17,
    duration: 1,
  },
  { id: 123, roomNum: '410', text: 'VIETRA...', theme: 'theme-cyan', startIdx: 1, duration: 1 },
  {
    id: 124,
    roomNum: '410',
    text: 'GAL 4966 - THÁI ...',
    theme: 'theme-green',
    startIdx: 3,
    duration: 2,
    hasCashIcon: true,
  },
  {
    id: 125,
    roomNum: '410',
    text: 'GAL 4031 - T...',
    theme: 'theme-green',
    startIdx: 17,
    duration: 1,
  },
  { id: 126, roomNum: '411', text: 'VIETRA...', theme: 'theme-cyan', startIdx: 1, duration: 1 },
  {
    id: 127,
    roomNum: '411',
    text: 'GAL 4031 - T...',
    theme: 'theme-green',
    startIdx: 17,
    duration: 1,
  },
])

const getBookingsByRoom = (roomNum) => {
  return bookingsData.value.filter((b) => b.roomNum === roomNum)
}

const calcBookingPosition = (booking) => {
  const leftDistance = (booking.startIdx - 1) * COLUMN_WIDTH + 2
  const blockWidth = booking.duration * COLUMN_WIDTH - 4
  return {
    left: `${leftDistance}px`,
    width: `${blockWidth}px`,
  }
}
</script>

<style scoped>
/* --- THIẾT KẾ ĐỒNG BỘ HỆ THỐNG PMS --- */
.pms-wrapper {
  --sidebar-width: 155px;
  --column-width: 72px;
  --border-color: #dfdfdf;

  font-family: Arial, Helvetica, sans-serif;
  color: #333;
  font-size: 13px;
  background-color: #fff;
}

/* --- 1. KIỂU DÁNG THANH CÔNG CỤ TOPBAR --- */
.topbar-pms {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 6px 10px;
  background-color: #f1f3f5;
  border-bottom: 1px solid var(--border-color);
  gap: 10px;
}

.topbar-left-group {
  display: flex;
  align-items: center;
  gap: 8px;
}

.date-range-picker {
  display: flex;
  align-items: center;
  background: #fff;
  border: 1px solid #c8c8c8;
  border-radius: 3px;
  padding: 3px 8px;
  gap: 6px;
}
.date-range-picker input {
  border: none;
  font-size: 12px;
  width: 180px;
  outline: none;
  font-weight: bold;
  color: #222;
}
.calendar-icon-right {
  display: flex;
  align-items: center;
}

.btn-pms-view {
  background-color: #8bd3fe;
  color: white;
  border: 1px solid #8bd3fe;
  padding: 4px 16px;
  border-radius: 3px;
  font-weight: bold;
  cursor: pointer;
}
.btn-pms-view:hover {
  background-color: #5bbffc;
}

.btn-pms-setting {
  background: #fff;
  border: 1px solid #c8c8c8;
  padding: 3px 6px;
  border-radius: 3px;
  cursor: pointer;
  display: flex;
  align-items: center;
}

.select-pms-container select {
  padding: 4px 8px;
  border: 1px solid #c8c8c8;
  border-radius: 3px;
  background-color: #fff;
  font-size: 13px;
}

/* --- Giao diện Toggle Switch có chữ bên trong --- */
.pms-switch-group {
  display: flex;
  align-items: center;
  gap: 15px;
}

.toggle-item-inner {
  cursor: pointer;
  user-select: none;
}

/* 1. Tăng chiều dài nút ra một chút (85px) để đủ chỗ chứa chữ */
.toggle-track-inner {
  width: 85px;
  height: 24px;
  background-color: #ccc; /* Màu khi tắt */
  border-radius: 20px;
  position: relative;
  transition: all 0.3s ease;
}

/* Màu nền khi bật */
.toggle-track-inner.active {
  background-color: #8bd3fe;
}

/* 2. Căn chỉnh chữ */
.toggle-text-inside {
  font-size: 11px;
  font-weight: bold;
  color: #fff;
  position: absolute;
  top: 50%;
  transform: translateY(-50%); /* Căn chữ chuẩn giữa theo chiều dọc */
  transition: all 0.3s ease;

  /* TRẠNG THÁI TẮT (Cục tròn ở bên TRÁI): Ép chữ nằm sát bên PHẢI */
  right: 10px;
  left: auto;
}

/* TRẠNG THÁI BẬT (Cục tròn ở bên PHẢI): Ép chữ chuyển sang sát bên TRÁI */
.toggle-track-inner.active .toggle-text-inside {
  left: 10px;
  right: auto;
}

/* 3. Cục tròn gạt */
.toggle-knob-inner {
  width: 18px;
  height: 18px;
  background-color: white;
  border-radius: 50%;
  position: absolute;
  top: 3px;
  left: 3px; /* Vị trí mặc định ở sát mép trái */
  transition: all 0.3s ease;
  box-shadow: 0 1px 3px rgba(0,0,0,0.3);
}

/* Khi bật: Cục tròn trượt sang sát mép phải */
.toggle-track-inner.active .toggle-knob-inner {
  /* 100% chiều dài trừ đi 18px độ rộng cục tròn và 3px lề */
  left: calc(100% - 21px);
}

.pms-search-group {
  display: flex;
  align-items: center;
}

.pms-search-btn {
  background-color: #8bd3fe;
  border: 1px solid #8bd3fe;
  padding: 4px 8px;
  border-top-right-radius: 3px;
  border-bottom-right-radius: 3px;
  cursor: pointer;
  display: flex;
  align-items: center;
}

.topbar-right-legends {
  display: flex;
  gap: 4px;
}
.legend-block {
  padding: 2px 12px;
  border-radius: 2px;
  font-size: 11px;
  font-weight: bold;
}
.ooo-pattern {
  background: repeating-linear-gradient(45deg, #2d89ff, #2d89ff 4px, #ffffff 4px, #ffffff 8px);
  color: #000;
  border: 1px solid #1a6bdd;
}
.oos-pattern {
  background: repeating-linear-gradient(45deg, #a0a0a0, #a0a0a0 4px, #ffffff 4px, #ffffff 8px);
  color: #000;
  border: 1px solid #888;
}
.status-inhouse {
  background-color: #9fd4ff;
  color: #000;
  border: 1px solid #73bfff;
}
.status-reservation {
  background-color: #e5eec1;
  color: #000;
  border: 1px solid #d4dfa6;
}
.status-late {
  background-color: #fbf082;
  color: #000;
  border: 1px solid #e7dc60;
}

/* --- 2. CẤU TRÚC MA TRẬN 1 TRỤC CUỘN DUY NHẤT --- */
.pms-matrix-viewport {
  overflow-x: auto;
  width: 100%;
}
.pms-matrix-table {
  display: flex;
  flex-direction: column;
  width: max-content;
}
.matrix-row {
  display: flex;
  width: 100%;
}

.sticky-side-column {
  position: sticky;
  left: 0;
  width: var(--sidebar-width);
  min-width: var(--sidebar-width);
  background-color: #f8f9fa;
  z-index: 10;
  border-right: 1px solid #ccc;
  box-sizing: border-box;
}

.timeline-cells-strip {
  display: flex;
}
.matrix-cell {
  width: var(--column-width);
  min-width: var(--column-width);
  max-width: var(--column-width);
  border-right: 1px solid var(--border-color);
  border-bottom: 1px solid var(--border-color);
  box-sizing: border-box;
}

.header-cell {
  height: 26px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #eaeaea;
  font-size: 11px;
  font-weight: bold;
}
.weekend-blue {
  background-color: #2d89ff !important;
  color: #fff !important;
}
.current-day {
  background-color: #f2aeb4 !important;
  color: white !important;
}
.border-double-bottom {
  border-bottom: 2px solid #aaa !important;
}
.corner-blank-cell {
  height: 26px;
  background-color: #eaeaea;
}

.data-room-row {
  height: 46px;
}
.room-info-cell {
  padding: 0 10px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid var(--border-color);
}
.room-number-txt {
  font-size: 11px;
  color: #000;
  width: 25px;
}
.room-type-stack {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 10px;
  color: #444;
  line-height: 1.2;
}
.room-clean-brush-wrapper {
  display: flex;
  align-items: center;
}

.relative-container {
  position: relative;
  display: flex;
}
.timeline-empty-cell {
  height: 46px;
}

/* --- 3. KHỐI ĐẶT PHÒNG (BOOKING BARS) VÀ MÀU SẮC VIỀN CHÍNH XÁC --- */
.pms-booking-bar {
  position: absolute;
  top: 4px;
  bottom: 4px;
  border-radius: 2px;
  padding: 0 6px;
  font-size: 11px;
  display: flex;
  align-items: center;
  z-index: 5;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
  box-sizing: border-box;
}
.booking-title-content {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* Thanh Inhouse (Ví dụ: VIETRAVEL) - Màu xanh dương + Viền dưới xanh dương đậm */
.theme-cyan {
  background-color: #9fd4ff;
  color: #000;
  border-bottom: 4px solid #8cc63f;
}
/* Thanh Reservation (Ví dụ: GAL 4737) - Màu xanh lá + Viền dưới xanh lá đậm */
.theme-green {
  background-color: #e5eec1;
  color: #000;
  border-bottom: 4px solid #8cc63f;
}
/* Thanh Walkin (Khách vãng lai) - Màu xám + Viền dưới xám đậm */
.theme-charcoal {
  background-color: #e5eec1;
  color: #000;
  border-bottom: 4px solid #64748b;
}

.cash-icon-tag {
  margin-left: auto;
  background: transparent;
  border: 1px solid #666;
  border-radius: 3px;
  padding: 0 3px;
  font-size: 9px;
  font-weight: bold;
  line-height: 1.2;
  color: #333;
}

/* --- 4. KHU VỰC THỐNG KÊ FOOTER TRỤC ĐÁY --- */
.footer-summary-row {
  height: 36px;
}
.footer-heading {
  font-weight: bold;
  font-size: 11px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 8px;
  border-bottom: 1px solid var(--border-color);
}
.label-occ {
  color: #000;
  background-color: #9fd4ff;
}
.label-av {
  color: #000;
  background-color: #9fd4ff;
}
.label-ooo {
  color: #000;
  background-color: #9fd4ff;
}

.footer-data-cell {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  font-size: 11px;
  height: 36px;
  background-color: #fff;
}
.text-bold {
  font-weight: normal;
  color: #000;
}
.percentage-sub {
  font-size: 9px;
  font-weight: normal;
  color: #555;
}
</style>
