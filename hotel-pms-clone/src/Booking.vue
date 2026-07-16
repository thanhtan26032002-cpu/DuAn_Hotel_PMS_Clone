<template>
  <div class="registration-wrapper">
    <div class="reg-header-bar">
      <div class="tabs-container">
        <div
          v-for="tab in bookingTabs"
          :key="tab.id"
          :class="['booking-tab', { active: activeTabId === tab.id }]"
          style="position: relative"
          @click="handleTabClick(tab)"
          @mouseenter="hoveredTabId = tab.id"
          @mouseleave="hoveredTabId = null"
        >
          <span class="tab-title">{{ tab.title }}</span>
          <button
            v-if="bookingTabs.length > 1"
            class="btn-close-tab"
            @click.stop="removeTab(tab.id)"
          >
            <svg
              width="12"
              height="12"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="M18 6L6 18M6 6l12 12"></path>
            </svg>
          </button>
        </div>
        <a class="btn-add-booking" @click="showCreateBookingModal = true">
          <svg width="20" height="20" viewBox="0 0 24 24">
            <path
              d="M12 5v14M5 12h14"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
            />
          </svg>
        </a>
      </div>
      <div class="header-actions">
        <button class="btn-action btn-info">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <circle cx="12" cy="12" r="10" fill="none" stroke="currentColor" stroke-width="2" />
            <path
              d="M12 16v-4m0-4h.01"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
            />
          </svg>
          Thông tin đăng ký
        </button>
        <button class="btn-action btn-edit">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <path
              d="M12 20h9M16.5 3.5a2.121 2.121 0 013 3L7 19l-4 1 1-4L16.5 3.5z"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Sửa
        </button>
        <button class="btn-action btn-save">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <path
              d="M19 21H5a2 2 0 01-2-2V5a2 2 0 012-2h11l5 5v11a2 2 0 01-2 2zM17 21v-8H7v8M7 3v5h8"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Lưu
        </button>
        <button class="btn-action btn-duplicate">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <rect
              x="9"
              y="9"
              width="11"
              height="11"
              rx="2"
              ry="2"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
            />
            <path
              d="M5 15H4a2 2 0 01-2-2V4a2 2 0 012-2h9a2 2 0 012 2v1"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Nhân bản
        </button>
        <button class="btn-action btn-delete">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <path
              d="M3 6h18M19 6v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6m3 0V4a2 2 0 012-2h4a2 2 0 012 2v2"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Xoá
        </button>
        <button class="btn-action btn-print">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <path
              d="M6 9V2h12v7M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2M6 14h12v8H6z"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linejoin="round"
            />
          </svg>
          In ⋮
        </button>
        <button class="btn-action btn-notify">
          <svg class="icon-svg" viewBox="0 0 24 24">
            <path
              d="M18 8A6 6 0 006 8c0 7-3 9-3 9h18s-3-2-3-9M13.73 21a2 2 0 01-3.46 0"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Thông báo
        </button>
        <div class="search-box">
          <svg class="icon-search-small" viewBox="0 0 24 24">
            <path
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              fill="none"
              stroke="#666"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          <input type="text" placeholder="Tìm kiếm" />
          <svg class="icon-filter-small" viewBox="0 0 24 24">
            <path
              d="M22 3H2l8 9.46V19l4 2v-8.54L22 3z"
              fill="none"
              stroke="#666"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
        </div>
      </div>
    </div>

    <div
      class="reg-meta-info-wrapper"
      @mouseenter="metaHovered = true"
      @mouseleave="metaHovered = false"
      @mousemove="handleMouseMove"
      @click="openModalWithData"
      style="cursor: pointer; position: relative;"
    >
      <div v-if="metaHovered" class="custom-tooltip" :style="{ left: mouseX + 'px', top: mouseY + 'px' }">
        Xem chi tiết
      </div>
      <div class="reg-meta-info" v-if="bookingData && !bookingData.isNew">
        <span class="meta-item"
          >Tên đăng ký: <strong>{{ bookingData.guest_name }}</strong></span
        >
        <span class="meta-item"
          >Trạng thái:
          <strong :style="{ color: bookingData.booking_color || '#16a34a' }">
            {{ bookingData.status?.status_name || 'N/A' }}
          </strong>
        </span>
        <span class="meta-item"
          >Ngày đến: <strong>{{ formatDate(bookingData.check_in) }}</strong></span
        >
        <span class="meta-item"
          >Ngày đi: <strong>{{ formatDate(bookingData.check_out) }}</strong></span
        >
        <span class="meta-item"
          >Đặt cọc: <strong>{{ formatCurrency(bookingData.deposit) }}</strong></span
        >
        <span class="meta-item"
          >Công ty: <strong>{{ bookingData.company?.name || '' }}</strong></span
        >
        <span class="meta-item"
          >Xác nhận: <strong>{{ formatDate(bookingData.confirmed_date) }}</strong></span
        >
      </div>
      <div class="reg-meta-info" v-else-if="bookingData && bookingData.isNew">
        <span class="meta-item">Tên đăng ký: <strong></strong></span>
        <span class="meta-item">Trạng thái: <strong></strong></span>
        <span class="meta-item"
          >Ngày đến: <strong>{{ formatDate(bookingData.check_in) }}</strong></span
        >
        <span class="meta-item"
          >Ngày đi: <strong>{{ formatDate(bookingData.check_out) }}</strong></span
        >
        <span class="meta-item">Đặt cọc: <strong>0</strong></span>
        <span class="meta-item">Công ty: <strong></strong></span>
        <span class="meta-item"
          >Xác nhận: <strong>{{ formatDate(bookingData.confirmed_date) }}</strong></span
        >
      </div>
      <div class="reg-meta-info" v-else>
        <span>Đang tải dữ liệu...</span>
      </div>
    </div>

    <div class="table-toolbar">
      <div class="toolbar-left">
        <div class="toolbar-search">
          <input type="text" />
          <button class="btn-search-blue">
            <svg class="icon-svg-sm" viewBox="0 0 24 24">
              <path
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
          </button>
        </div>
      </div>
      <div class="toolbar-right">
        <button class="btn-func">Chức năng</button>
        <select class="select-action">
          <option>Chọn: 0</option>
        </select>
        <button class="btn-icon-setting">
          <svg class="icon-svg-settings" viewBox="0 0 24 24">
            <path
              d="M12 15a3 3 0 100-6 3 3 0 000 6z"
              fill="none"
              stroke="#666"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
            <path
              d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 010 2.83 2 2 0 01-2.83 0l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 01-2 2 2 2 0 01-2-2v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 01-2.83 0 2 2 0 010-2.83l.06-.06a1.65 1.65 0 00.33-1.82 1.65 1.65 0 00-1.51-1H3a2 2 0 01-2-2 2 2 0 012-2h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 010-2.83 2 2 0 012.83 0l.06.06a1.65 1.65 0 001.82.33H9a1.65 1.65 0 001-1.51V3a2 2 0 012-2 2 2 0 012 2v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 012.83 0 2 2 0 010 2.83l-.06.06a1.65 1.65 0 00-.33 1.82V9a1.65 1.65 0 001.51 1H21a2 2 0 012 2 2 2 0 01-2 2h-.09a1.65 1.65 0 00-1.51 1z"
              fill="none"
              stroke="#666"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
        </button>
        <button class="btn-invoice">
          <svg class="icon-svg-sm" viewBox="0 0 24 24">
            <path
              d="M12 1v22M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            />
          </svg>
          Hoá đơn
        </button>
      </div>
    </div>

    <div class="table-responsive">
      <table class="pms-data-table">
        <thead>
          <tr>
            <th class="col-icon"></th>
            <th class="col-check"></th>
            <th>STT</th>
            <th>Loại phòng</th>
            <th>Dạng phòng</th>
            <th>Số phòng</th>
            <th>Ngày đến</th>
            <th>Ngày đi</th>
            <th>Đêm</th>
            <th>Giá</th>
            <th>Mã giá phòng</th>
            <th>Giảm/tăng giá</th>
            <th>Tên khách</th>
            <th>N.Lớn</th>
            <th>Em bé</th>
            <th>Trẻ em</th>
            <th>Chi tiết ăn sáng trẻ</th>
            <th>Ăn sáng</th>
            <th>Thêm giường</th>
            <th>Giá thêm giường</th>
            <th>Ở theo giờ</th>
            <th>Yêu cầu đặc biệt</th>
            <th>Giờ đến</th>
            <th>Giờ đi</th>
            <th>Đặt trước</th>
            <th>LP Khởi tạo</th>
            <th>Phòng chuyển</th>
            <th>Trạng thái phòng</th>
            <th>Mã ALM</th>
            <th>Mã phòng</th>
            <th class="sticky-col-right">Tổng cộng</th>
          </tr>
        </thead>
        <tbody>
          <template v-if="groupedRooms && Object.keys(groupedRooms).length > 0">
            <tr class="group-row" style="background-color: #d9edf7">
              <td class="text-center">
                <button class="btn-collapse" @click="toggleMainGroup">
                  {{ isMainGroupExpanded ? '-' : '+' }}
                </button>
              </td>
              <td></td>
              <td colspan="28">
                <div class="group-title" style="display: flex; align-items: center">
                  <strong
                    >Tình trạng:
                    {{
                      bookingData.status?.status_name === 'Guaranteed'
                        ? 'Phòng ở'
                        : bookingData.status?.status_name || 'Đăng ký'
                    }}
                    ({{ totalRooms }})</strong
                  >
                  <input
                    type="range"
                    min="0"
                    max="100"
                    value="0"
                    class="custom-slider ml-2"
                    style="width: 150px; pointer-events: none"
                  />
                </div>
              </td>
              <td class="sticky-col-right" style="background-color: #d9edf7"></td>
            </tr>

            <template v-if="isMainGroupExpanded">
              <template v-for="(rooms, groupName) in groupedRooms" :key="groupName">
                <tr class="sub-group-row">
                  <td class="text-center">
                    <button class="btn-collapse" @click="toggleSubGroup(groupName)">
                      {{ expandedGroups[groupName] ? '-' : '+' }}
                    </button>
                  </td>
                  <td><input type="checkbox" /></td>
                  <td colspan="28">
                    <strong>{{ groupName }} ({{ rooms.length }})</strong>
                  </td>
                  <td class="sticky-col-right bg-sub-group"></td>
                </tr>
                <template v-if="expandedGroups[groupName]">
                  <tr v-for="(room, index) in rooms" :key="room.id" class="data-row">
                    <td class="text-center"><button class="btn-expand">+</button></td>
                    <td><input type="checkbox" /></td>
                    <td class="text-center">{{ index + 1 }}</td>
                    <td>{{ room.room_type?.type_name || 'N/A' }}</td>
                    <td>{{ room.room_form?.form_name || 'N/A' }}</td>
                    <td class="text-bold">
                      {{ room.room?.room_number || room.room_code || 'Chưa gán' }}
                    </td>
                    <td>{{ formatDate(room.check_in) }}</td>
                    <td>{{ formatDate(room.check_out) }}</td>
                    <td class="text-center">{{ room.nights }}</td>
                    <td class="text-right">{{ formatCurrency(room.price) }}</td>
                    <td>
                      <input
                        type="text"
                        class="input-table"
                        :value="room.rate_plan_code"
                        placeholder="Mã giá"
                      />
                    </td>
                    <td class="text-right">{{ formatCurrency(room.discount) }}</td>
                    <td>{{ room.guest_name || bookingData.guest_name }}</td>
                    <td class="text-center">{{ room.adults }}</td>
                    <td class="text-center">{{ room.infants }}</td>
                    <td class="text-center">{{ room.children }}</td>
                    <td class="text-center">
                      <button class="btn-detail" v-if="room.child_breakfast_price > 0">
                        Chi tiết
                      </button>
                    </td>
                    <td class="text-center">
                      <label class="ios-switch">
                        <input type="checkbox" :checked="room.includes_breakfast" disabled />
                        <span class="slider"></span>
                      </label>
                    </td>
                    <td class="text-center">
                      <span class="mr-1">{{ room.extra_bed ? 1 : 0 }}</span>
                      <button class="btn-detail" v-if="room.extra_bed">Chi tiết</button>
                    </td>
                    <td class="text-center">{{ formatCurrency(room.extra_bed_price) }}</td>
                    <td class="text-center">
                      <label class="ios-switch">
                        <input type="checkbox" :checked="room.hourly_rental" disabled />
                        <span class="slider"></span>
                      </label>
                    </td>
                    <td class="text-center">
                      <button class="btn-detail" v-if="room.special_requests">Yêu cầu</button>
                    </td>
                    <td class="text-center">{{ formatTime(room.arrival_time) }}</td>
                    <td class="text-center">{{ formatTime(room.departure_time) }}</td>
                    <td class="text-center">
                      <input type="checkbox" :checked="room.reserved" disabled />
                    </td>
                    <td>{{ room.created_by }}</td>
                    <td>{{ room.transfer_room }}</td>
                    <td>{{ room.room_status }}</td>
                    <td>{{ room.alm_code }}</td>
                    <td>{{ room.room_code }}</td>
                    <td class="text-right text-bold sticky-col-right bg-white">
                      {{ formatCurrency(room.total_amount) }}
                    </td>
                  </tr>
                </template>
              </template>
            </template>
          </template>
          <tr v-else-if="bookingData?.isNew">
            <td colspan="31" class="no-rooms-container">
              <div class="no-rooms-box">No Rooms</div>
            </td>
          </tr>
          <tr v-else>
            <td colspan="31" class="text-center">Không có dữ liệu phòng</td>
          </tr>
        </tbody>
        <tfoot>
          <tr class="footer-row">
            <td colspan="9" class="text-bold">Tổng: {{ totalRooms }}</td>
            <td class="text-right text-bold">{{ formatCurrency(totalPrice) }}</td>
            <td colspan="3"></td>
            <td class="text-center text-bold">{{ totalAdults }}</td>
            <td class="text-center text-bold">{{ totalInfants }}</td>
            <td class="text-center text-bold">{{ totalChildren }}</td>
            <td colspan="14"></td>
            <td class="text-right text-bold total-highlight sticky-col-right">
              {{ formatCurrency(grandTotal) }}
            </td>
          </tr>
        </tfoot>
      </table>
    </div>
    <CreateBookingModal
      :is-open="showCreateBookingModal"
      @close="handleCreateModalClose"
    />
    <RegistrationInfoModal
      :is-open="showRegistrationInfoModal"
      :initial-data="modalInitialData"
      @close="handleRegistrationModalClose"
    />
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed, watch } from 'vue'
import CreateBookingModal from './CreateBookingModal.vue'
import RegistrationInfoModal from './RegistrationInfoModal.vue'

const showCreateBookingModal = ref(false)
const showRegistrationInfoModal = ref(false)

const props = defineProps({
  bookingCode: {
    type: String,
    default: 'GAL1', // Mặc định lấy GAL1 nếu không có mã nào truyền sang
  },
})

const bookingTabs = ref([
  {
    id: 'initial',
    title: props.bookingCode === 'GAL1' ? 'Booking GAL6124' : `Booking ${props.bookingCode}`,
  },
])
const activeTabId = ref('initial')
const hoveredTabId = ref(null)

const metaHovered = ref(false)
const mouseX = ref(0)
const mouseY = ref(0)

const handleMouseMove = (event) => {
  // Get coordinates relative to reg-meta-info-wrapper
  const rect = event.currentTarget.getBoundingClientRect()
  mouseX.value = event.clientX - rect.left + 15
  mouseY.value = event.clientY - rect.top + 15
}

const modalInitialData = ref(null)

const openModalWithData = () => {
  modalInitialData.value = bookingData.value
  showRegistrationInfoModal.value = true
}

const handleTabClick = (tab) => {
  activeTabId.value = tab.id
  if (tab.id === 'initial' && bookingDataMap.value['initial']) {
    openModalWithData()
  }
}

const handleCreateModalClose = () => {
  showCreateBookingModal.value = false
  const newId = `NEW_${Date.now()}`
  bookingTabs.value.push({
    id: newId,
    title: 'New Booking',
  })
  bookingDataMap.value[newId] = { isNew: true }
  activeTabId.value = newId
}

const handleRegistrationModalClose = () => {
  showRegistrationInfoModal.value = false
}

const removeTab = (id) => {
  if (bookingTabs.value.length > 1) {
    const index = bookingTabs.value.findIndex((t) => t.id === id)
    if (index !== -1) {
      bookingTabs.value.splice(index, 1)
      if (activeTabId.value === id) {
        activeTabId.value = bookingTabs.value[0].id
      }
    }
  }
}

const bookingDataMap = ref({})

const bookingData = computed(() => {
  if (activeTabId.value === 'initial') {
    return bookingDataMap.value['initial'] || null
  }
  const d = new Date()
  const today = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`
  return {
    isNew: true,
    guest_name: '',
    status: { status_name: '' },
    booking_color: 'inherit',
    check_in: today,
    check_out: today,
    deposit: 0,
    company: { name: '' },
    confirmed_date: today,
    booking_rooms: [],
  }
})

const fetchBookingData = async () => {
  try {
    const res = await fetch(`http://127.0.0.1:8000/api/bookings/${props.bookingCode}`)
    const result = await res.json()
    if (result.success) {
      bookingDataMap.value['initial'] = result.data
    }
  } catch (error) {
    console.error('Lỗi khi fetch booking:', error)
  }
}

// Hàm format ngày
const formatDate = (dateStr) => {
  if (!dateStr) return ''
  const d = new Date(dateStr)
  return d.toLocaleDateString('vi-VN')
}

// Hàm format tiền
const formatCurrency = (amount) => {
  if (!amount) return '0'
  return parseFloat(amount).toLocaleString('en-US')
}

// Hàm format giờ
const formatTime = (timeStr) => {
  if (!timeStr) return ''
  // timeStr có dạng "14:00:00"
  return timeStr.substring(0, 5)
}

// Nhóm các phòng theo Loại phòng (Room Type)
const groupedRooms = computed(() => {
  if (!bookingData.value || !bookingData.value.booking_rooms) return {}
  return bookingData.value.booking_rooms.reduce((acc, room) => {
    const typeName = room.room_type?.type_name || 'Khác'
    if (!acc[typeName]) acc[typeName] = []
    acc[typeName].push(room)
    return acc
  }, {})
})

const isMainGroupExpanded = ref(true)
const expandedGroups = reactive({})

watch(
  groupedRooms,
  (newGroups) => {
    if (newGroups) {
      Object.keys(newGroups).forEach((groupName) => {
        if (expandedGroups[groupName] === undefined) {
          expandedGroups[groupName] = true
        }
      })
    }
  },
  { immediate: true },
)

const toggleMainGroup = () => {
  isMainGroupExpanded.value = !isMainGroupExpanded.value
}

const toggleSubGroup = (groupName) => {
  expandedGroups[groupName] = !expandedGroups[groupName]
}

// Tính tổng footer
const totalRooms = computed(() => bookingData.value?.booking_rooms?.length || 0)
const totalPrice = computed(() => {
  return (
    bookingData.value?.booking_rooms?.reduce((sum, room) => sum + parseFloat(room.price || 0), 0) ||
    0
  )
})
const totalAdults = computed(() => {
  return (
    bookingData.value?.booking_rooms?.reduce((sum, room) => sum + parseInt(room.adults || 0), 0) ||
    0
  )
})
const totalInfants = computed(() => {
  return (
    bookingData.value?.booking_rooms?.reduce((sum, room) => sum + parseInt(room.infants || 0), 0) ||
    0
  )
})
const totalChildren = computed(() => {
  return (
    bookingData.value?.booking_rooms?.reduce(
      (sum, room) => sum + parseInt(room.children || 0),
      0,
    ) || 0
  )
})
const grandTotal = computed(() => {
  return (
    bookingData.value?.booking_rooms?.reduce(
      (sum, room) => sum + parseFloat(room.total_amount || 0),
      0,
    ) || 0
  )
})

onMounted(() => {
  fetchBookingData()
})
</script>

<style scoped>
/* Tổng quan */
.registration-wrapper {
  font-family: Arial, sans-serif;
  font-size: 13px;
  color: #333;
  background-color: #fff;
  border: 1px solid #ddd;
  display: flex;
  flex-direction: column;
  height: 100%;
}

/* --- Header Bar --- */
.reg-header-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  background-color: #e9ecef;
  border-bottom: 1px solid #ddd;
}
.tabs-container {
  display: flex;
  align-items: center;
  gap: 8px;
}
.booking-tab {
  display: flex;
  align-items: center;
  gap: 6px;
  cursor: pointer;
  padding: 6px 16px;
  border-radius: 20px;
  color: #5bc0de;
  font-weight: 500;
  font-size: 14px;
}
.booking-tab.active {
  background-color: white;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}
.btn-close-tab {
  background: none;
  border: none;
  cursor: pointer;
  color: #5bc0de;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0.7;
}
.btn-close-tab:hover {
  opacity: 1;
  color: #ff4d4f;
}
.no-rooms-container {
  padding: 10px;
}
.no-rooms-box {
  background-color: #e9ecef;
  color: #6c757d;
  font-weight: bold;
  font-size: 16px;
  height: 150px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 4px;
}
.reg-meta-info-wrapper {
  position: relative;
}
.btn-xem-chi-tiet {
  position: absolute;
  right: 12px;
  top: 50%;
  transform: translateY(-50%);
  background-color: #5bc0de;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 4px 12px;
  font-size: 13px;
  cursor: pointer;
  white-space: nowrap;
  transition: background 0.2s;
}
.custom-tooltip {
  position: absolute;
  background-color: #5bc0de;
  color: white;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  pointer-events: none;
  z-index: 100;
  white-space: nowrap;
}
.btn-xem-chi-tiet:hover {
  background-color: #31b0d5;
}
.btn-add-booking {
  background: transparent;
  color: #5bc0de;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.header-actions {
  display: flex;
  gap: 6px;
  align-items: center;
}
.btn-action {
  background: transparent;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 4px 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
  color: #333;
}
.tab-hover-tooltip {
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  margin-top: 8px;
  background-color: #333;
  color: #fff;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  white-space: nowrap;
  z-index: 10;
  pointer-events: none;
}
.tab-hover-tooltip::before {
  content: '';
  position: absolute;
  top: -4px;
  left: 50%;
  transform: translateX(-50%);
  border-width: 0 4px 4px 4px;
  border-style: solid;
  border-color: transparent transparent #333 transparent;
}
.tab-tooltip-enter-active,
.tab-tooltip-leave-active {
  transition: opacity 0.2s;
}
.tab-tooltip-enter-from,
.tab-tooltip-leave-to {
  opacity: 0;
}
.icon-svg {
  width: 14px;
  height: 14px;
}
.btn-info,
.btn-print,
.btn-notify,
.btn-edit,
.btn-duplicate,
.btn-delete {
  background-color: #5bc0de;
}
.btn-save {
  background-color: #5bc0de;
}

.search-box {
  display: flex;
  align-items: center;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 4px 8px;
  background: #fff;
  gap: 5px;
}
.search-box input {
  border: none;
  outline: none;
  width: 130px;
  font-size: 12px;
}
.icon-search-small,
.icon-filter-small {
  width: 14px;
  height: 14px;
}

/* --- Meta Info --- */
.reg-meta-info {
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
  padding: 10px;
  border-bottom: 1px solid #ddd;
}
.meta-item {
  font-size: 13px;
}
.text-green {
  color: #28a745;
}

/* --- Table Toolbar --- */
.table-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 10px;
  background: #fff;
}
.toolbar-left,
.toolbar-right {
  display: flex;
  align-items: center;
  gap: 8px;
}
.toolbar-search {
  display: flex;
  border: 1px solid #ccc;
  border-radius: 3px;
  overflow: hidden;
}
.toolbar-search input {
  border: none;
  padding: 4px;
  width: 120px;
  outline: none;
}
.btn-search-blue {
  background: #5bc0de;
  border: none;
  color: #fff;
  padding: 4px 8px;
  cursor: pointer;
  display: flex;
}
.btn-func {
  background: #5bc0de;
  color: #fff;
  border: none;
  padding: 5px 15px;
  border-radius: 3px;
  cursor: pointer;
}
.select-action {
  padding: 4px;
  border: 1px solid #ccc;
  border-radius: 3px;
  outline: none;
}
.btn-icon-setting {
  background: none;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  padding: 0;
}
.icon-svg-settings {
  width: 18px;
  height: 18px;
}
.icon-svg-sm {
  width: 14px;
  height: 14px;
}
.btn-invoice {
  background: #5bc0de;
  color: #fff;
  border: none;
  padding: 5px 10px;
  border-radius: 3px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}

/* --- Data Table --- */
.table-responsive {
  width: 100%;
  overflow-x: auto;
  border-top: 1px solid #ddd;
  position: relative;
}
.pms-data-table {
  width: max-content;
  border-collapse: collapse;
  min-width: 100%;
}
.pms-data-table th,
.pms-data-table td {
  border: 1px solid #e0e0e0;
  padding: 6px 8px;
  vertical-align: middle;
  white-space: nowrap;
}
.pms-data-table th {
  background-color: #e9ecef;
  font-weight: bold;
  text-align: center;
  color: #333;
}
.col-icon,
.col-check {
  width: 30px;
}

/* Group & Subgroup */
.group-row {
  background-color: #fafafa;
}
.sub-group-row {
  background-color: #fff;
}
.group-title {
  display: flex;
  align-items: center;
}

/* CSS MỚI CHO THANH KÉO (SLIDER) */
.custom-slider {
  -webkit-appearance: none;
  appearance: none;
  width: 120px;
  height: 2px; /* Đường track mảnh */
  background: #e0e0e0;
  outline: none;
  border-radius: 2px;
}
.custom-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 32px; /* Hình dáng viên thuốc */
  height: 12px;
  border-radius: 6px;
  background: #90d4e8; /* Xanh lợt như trong hình */
  cursor: pointer;
}
.custom-slider::-moz-range-thumb {
  width: 32px;
  height: 12px;
  border-radius: 6px;
  background: #90d4e8;
  cursor: pointer;
  border: none;
}

/* Expand/Collapse Buttons */
.btn-collapse,
.btn-expand {
  width: 18px;
  height: 18px;
  border: none;
  color: #fff;
  font-size: 14px;
  line-height: 0;
  font-weight: bold;
  cursor: pointer;
  border-radius: 3px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}
.btn-collapse,
.btn-expand {
  background-color: #5bc0de;
}

/* Data Rows */
.data-row:hover td:not(.sticky-col-right) {
  background-color: #f9f9f9;
}
.data-row:hover .bg-white {
  background-color: #f9f9f9;
}
.input-table {
  border: 1px solid #ccc;
  padding: 4px;
  border-radius: 2px;
  width: 140px;
  outline: none;
}
.btn-detail {
  background-color: #5bc0de;
  color: #fff;
  border: none;
  border-radius: 3px;
  padding: 4px 8px;
  cursor: pointer;
  font-size: 12px;
}

/* FOOTER */
tfoot .footer-row {
  background-color: #e9ecef;
}
.total-highlight {
  background-color: #d8d8d8;
}

/* STICKY COLUMN RIGHT */
.sticky-col-right {
  position: sticky;
  right: 0;
  z-index: 2;
  box-shadow: -2px 0 5px rgba(0, 0, 0, 0.06);
}
th.sticky-col-right {
  background-color: #e9ecef;
  z-index: 3;
}
.bg-group {
  background-color: #fafafa;
}
.bg-sub-group {
  background-color: #fff;
}
.bg-white {
  background-color: #fff;
}
tfoot .sticky-col-right {
  background-color: #d8d8d8;
}

/* Utilities */
.text-center {
  text-align: center;
}
.text-right {
  text-align: right;
}
.text-bold {
  font-weight: bold;
}
.ml-2 {
  margin-left: 8px;
}
.mr-1 {
  margin-right: 4px;
}

/* CÔNG TẮC BẬT TẮT (Cho các cột bên dưới) */
.ios-switch {
  position: relative;
  display: inline-block;
  width: 34px;
  height: 18px;
  vertical-align: middle;
}
.ios-switch input {
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
  background-color: #ccc;
  transition: 0.2s;
  border-radius: 18px;
}
.slider:before {
  position: absolute;
  content: '';
  height: 14px;
  width: 14px;
  left: 2px;
  bottom: 2px;
  background-color: white;
  transition: 0.2s;
  border-radius: 50%;
}
input:checked + .slider {
  background-color: #90d4e8;
}
input:checked + .slider:before {
  transform: translateX(16px);
}
</style>
