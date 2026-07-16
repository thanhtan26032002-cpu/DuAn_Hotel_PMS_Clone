<template>
  <div class="modal-overlay" v-if="isOpen" @click.self="closeModal">
    <div class="modal-wrapper">
      <div class="modal-header">
        <h3 class="modal-title">Tạo đăng ký</h3>
        <button class="btn-close" @click="closeModal">
          <svg width="24" height="24" viewBox="0 0 24 24">
            <path d="M18 6L6 18M6 6l12 12" stroke="white" stroke-width="2" stroke-linecap="round" />
          </svg>
        </button>
      </div>

      <div class="modal-body">
        <!-- Top Section -->
        <div class="top-section">
          <div class="top-actions">
            <label class="toggle-switch">
              <span class="toggle-label">GIT</span>
              <input type="checkbox" v-model="formIsGit" />
              <span class="slider"></span>
            </label>
            <label class="toggle-switch">
              <span class="toggle-label">VAT</span>
              <input type="checkbox" v-model="formIsVat" />
              <span class="slider"></span>
            </label>
            <button class="btn-icon bg-light-blue">
              <svg viewBox="0 0 24 24" class="icon-svg">
                <path
                  d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
            </button>
            <button class="btn-icon bg-light-blue">
              <svg viewBox="0 0 24 24" class="icon-svg">
                <path
                  d="M6 9V2h12v7M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2M6 14h12v8H6z"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linejoin="round"
                />
              </svg>
            </button>
            <button class="btn-icon bg-light-blue">
              <svg viewBox="0 0 24 24" class="icon-svg">
                <path
                  d="M12 12h.01M12 6h.01M12 18h.01"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="3"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                />
              </svg>
            </button>
          </div>

          <div class="form-row">
            <div class="form-group" style="flex: 1">
              <label>Mã đăng ký</label>
              <input type="text" class="form-control bg-gray" disabled :value="formBookingCode" />
            </div>
            <div class="form-group" style="flex: 2">
              <label>Tên đăng ký</label>
              <div style="display: flex; gap: 8px; height: 100%">
                <input
                  type="text"
                  class="form-control bg-yellow"
                  style="flex: 1"
                  v-model="formGuestName"
                />
                <div style="position: relative; height: 100%">
                  <button
                    class="color-box"
                    :style="{
                      backgroundColor: selectedColor === 'none' ? '#63c2de' : selectedColor,
                    }"
                    @click.stop="toggleColorPicker"
                  ></button>
                  <div class="color-picker-dropdown" v-if="showColorPicker" @click.stop>
                    <div class="color-option text-option" @click="selectColor('none')">none</div>
                    <div
                      v-for="color in colors"
                      :key="color"
                      class="color-option"
                      :style="{ backgroundColor: color }"
                      @click="selectColor(color)"
                    ></div>
                  </div>
                </div>
              </div>
            </div>
            <div class="form-group" style="flex: 2">
              <label>Ngày đến - Ngày đi</label>
              <div class="date-range-input">
                <input type="text" class="form-control text-center" v-model="formCheckIn" />
                <span>~</span>
                <input type="text" class="form-control text-center" v-model="formCheckOut" />
                <svg viewBox="0 0 24 24" class="icon-calendar">
                  <path
                    d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                    fill="none"
                    stroke="#999"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
              </div>
            </div>
            <div class="form-group" style="flex: 1">
              <label>Đêm</label>
              <div class="input-with-icon bg-yellow">
                <input type="number" class="form-control bg-yellow" v-model="formNights" />
                <svg viewBox="0 0 24 24" class="icon-moon">
                  <path
                    d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"
                    fill="none"
                    stroke="#5bc0de"
                    stroke-width="2"
                    stroke-linejoin="round"
                  />
                </svg>
              </div>
            </div>
            <div class="form-group" style="flex: 2">
              <label>Trạng thái</label>
              <div class="select-wrapper bg-yellow">
                <div class="status-dot"></div>
                <select class="form-control bg-yellow pl-24" v-model="formStatusId">
                  <option value="">-- Chọn trạng thái --</option>
                  <option
                    v-for="status in bookingOptions.reservation_statuses"
                    :key="status.id"
                    :value="status.id"
                  >
                    {{ status.name }}
                  </option>
                </select>
              </div>
            </div>
            <div class="form-group" style="flex: 1.5">
              <label>Xác nhận</label>
              <div class="input-with-icon">
                <input type="text" class="form-control" v-model="formConfirmedDate" />
                <svg viewBox="0 0 24 24" class="icon-calendar ml-1">
                  <path
                    d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                    fill="none"
                    stroke="#999"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
                <svg viewBox="0 0 24 24" class="icon-document ml-1">
                  <path
                    d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"
                    fill="none"
                    stroke="#999"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
              </div>
            </div>
          </div>

          <div class="form-row mt-3">
            <div class="form-group" style="flex: 3">
              <label>CÔNG TY</label>
              <div class="input-with-icon bg-yellow">
                <select class="form-control bg-yellow border-0" v-model="formCompanyCode">
                  <option value="">Công ty</option>
                  <option
                    v-for="company in bookingOptions.companies"
                    :key="company.company_code"
                    :value="company.company_code"
                  >
                    {{ company.name }}
                  </option>
                </select>
                <button class="icon-btn-circle">+</button>
              </div>
            </div>
            <div class="form-group" style="flex: 2.5">
              <label>Phương thức thanh toán</label>
              <select class="form-control" v-model="formPaymentMethod">
                <option value="">Phương thức thanh toán</option>
                <option
                  v-for="pm in bookingOptions.payment_methods"
                  :key="pm.payment_code"
                  :value="pm.payment_code"
                >
                  {{ pm.payment_name }}
                </option>
              </select>
            </div>
            <div class="form-group" style="flex: 1.5">
              <label>Mã tham chiếu</label>
              <input type="text" class="form-control" placeholder="Mã tham chiếu" v-model="formReferenceCode" />
            </div>
            <div class="form-group" style="flex: 1.5">
              <label>Đặt cọc</label>
              <div class="input-with-icon bg-gray-light">
                <input type="text" class="form-control bg-transparent" v-model="formDeposit" />
                <button class="icon-btn bg-blue-gray">
                  <svg
                    viewBox="0 0 24 24"
                    class="icon-svg text-white"
                    style="width: 14px; height: 14px"
                  >
                    <path
                      d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
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
            <div class="form-group" style="flex: 1.5">
              <label>Người bán</label>
              <select class="form-control" v-model="formSeller">
                <option value="">-- Chọn nhân viên --</option>
                <option
                  v-for="employee in bookingOptions.employees"
                  :key="employee.employee_code"
                  :value="employee.employee_code"
                >
                  {{ employee.fullname }}
                </option>
              </select>
            </div>
          </div>
        </div>

        <!-- Tabs -->
        <div class="tabs-container">
          <div class="tabs-header">
            <button
              :class="['tab-btn', { active: currentTab === 'general' }]"
              @click="currentTab = 'general'"
            >
              Thông tin chung
            </button>
            <button
              :class="['tab-btn', { active: currentTab === 'transfer' }]"
              @click="currentTab = 'transfer'"
            >
              Thông tin đưa đón
            </button>
            <button
              :class="['tab-btn', { active: currentTab === 'room' }]"
              @click="currentTab = 'room'"
            >
              Lấy phòng
            </button>
          </div>

          <div class="tab-content">
            <!-- Thông tin chung -->
            <div v-show="currentTab === 'general'" class="tab-pane general-tab">
              <div class="general-grid">
                <div class="fieldset">
                  <legend>Đối tượng</legend>
                  <div class="form-group">
                    <label>Thị trường</label>
                    <select class="form-control bg-yellow" v-model="formMarketSegment">
                      <option value="">Online Travel A...</option>
                      <option
                        v-for="segment in bookingOptions.market_segments"
                        :key="segment.code"
                        :value="segment.code"
                      >
                        {{ segment.name }}
                      </option>
                    </select>
                  </div>
                  <div class="form-group mt-3">
                    <label>Nguồn khách</label>
                    <select class="form-control bg-yellow" v-model="formBookingSource">
                      <option value="">Source code</option>
                      <option
                        v-for="source in bookingOptions.booking_sources"
                        :key="source.code"
                        :value="source.code"
                      >
                        {{ source.name }}
                      </option>
                    </select>
                  </div>
                </div>

                <div class="fieldset">
                  <legend>Liên hệ</legend>
                  <div class="form-group">
                    <label>Người đặt phòng</label>
                    <div class="input-with-icon">
                      <select class="form-control border-0" v-model="selectedBookerId">
                        <option value="">Người đặt phòng</option>
                        <option
                          v-for="booker in bookingOptions.bookers"
                          :key="booker.id"
                          :value="booker.id"
                        >
                          {{ booker.name }}
                        </option>
                      </select>
                      <button class="icon-btn text-blue bg-transparent">
                        <svg viewBox="0 0 24 24" width="16" height="16">
                          <path
                            d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"
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
                  <div class="flex-row gap-3 mt-3">
                    <div class="form-group flex-1">
                      <label>Liên hệ</label>
                      <input
                        type="text"
                        class="form-control"
                        placeholder="Liên hệ"
                        v-model="contactPhone"
                      />
                    </div>
                    <div class="form-group flex-1">
                      <label>Email</label>
                      <input
                        type="text"
                        class="form-control"
                        placeholder="Email"
                        v-model="contactEmail"
                      />
                    </div>
                  </div>
                </div>

                <div class="form-group" style="grid-column: 3">
                  <label>Ghi chú</label>
                  <textarea
                    class="form-control textarea"
                    placeholder="Ghi chú"
                    v-model="bookingNotes"
                  ></textarea>
                </div>

                <div class="form-group" style="grid-column: 4">
                  <label>Yêu cầu đặc biệt (BK Confirm)</label>
                  <textarea
                    class="form-control textarea"
                    placeholder="Yêu cầu đặc biệt (BK Confirm)"
                  ></textarea>
                </div>
              </div>
              <div class="tab-footer">
                <button class="btn-save">
                  <svg viewBox="0 0 24 24" class="icon-svg mr-1">
                    <path
                      d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    />
                  </svg>
                  Lưu
                </button>
              </div>
            </div>

            <!-- Thông tin đưa đón -->
            <div v-show="currentTab === 'transfer'" class="tab-pane transfer-tab">
              <table class="data-table">
                <thead>
                  <tr>
                    <th>Đón/Đưa</th>
                    <th>Phương tiện</th>
                    <th>Mã</th>
                    <th>Ngày</th>
                    <th>Giờ</th>
                    <th>Hiện giá</th>
                    <th>Địa điểm</th>
                    <th>Ghi chú</th>
                    <th>Xóa</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td colspan="9">
                      <button class="btn-add-row">
                        <svg viewBox="0 0 24 24" width="16" height="16">
                          <path
                            d="M12 4v16m8-8H4"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                          />
                        </svg>
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
              <div class="tab-footer">
                <button class="btn-save">
                  <svg viewBox="0 0 24 24" class="icon-svg mr-1">
                    <path
                      d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    />
                  </svg>
                  Lưu
                </button>
              </div>
            </div>

            <!-- Lấy phòng -->
            <div v-show="currentTab === 'room'" class="tab-pane room-tab">
              <div class="table-container">
                <table class="data-table">
                  <thead>
                    <tr>
                      <th>Loại/Dạng</th>
                      <th>Ngày đến -> Ngày đi</th>
                      <th>Chiếm dụng</th>
                      <th>Phòng trống</th>
                      <th>Số lượng</th>
                      <th>Giá phòng</th>
                      <th>Mã giá phòng/Gói</th>
                      <th>Tăng/Giảm giá</th>
                      <th>Nâng hạng phòng</th>
                      <th>Người lớn</th>
                      <th>Em bé</th>
                      <th>Trẻ em</th>
                      <th>Giá ăn sáng trẻ em</th>
                      <th>Ăn sáng</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr
                      v-for="rt in bookingOptions.room_types"
                      :key="rt.id"
                    >
                      <td>{{ rt.type_short_name }}</td>
                      <td>
                        <div class="date-range-small">
                          09 / 07 / 2026 ~ 11 / 07 / 2026
                          <svg viewBox="0 0 24 24" class="icon-calendar-sm ml-1">
                            <path
                              d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                              fill="none"
                              stroke="#28a745"
                              stroke-width="2"
                              stroke-linecap="round"
                              stroke-linejoin="round"
                            />
                          </svg>
                        </div>
                      </td>
                      <td>{{ roomData[rt.id]?.occupied || 0 }}</td>
                      <td>{{ roomData[rt.id]?.available || 0 }}</td>
                      <td>
                        <div class="number-input-group">
                          <input type="number" v-model="roomData[rt.id].quantity" />
                          <div class="spinners">
                            <button class="spinner-up" @click.prevent="updateRoomData(rt.id, 'quantity', 1)">▲</button>
                            <button class="spinner-down" @click.prevent="updateRoomData(rt.id, 'quantity', -1)">▼</button>
                          </div>
                        </div>
                      </td>
                      <td>
                        <div class="number-input-group" style="width: 80px">
                          <input type="number" v-model="roomData[rt.id].price" />
                          <div class="spinners">
                            <button class="spinner-up" @click.prevent="updateRoomData(rt.id, 'price', 10000)">▲</button>
                            <button class="spinner-down" @click.prevent="updateRoomData(rt.id, 'price', -10000)">▼</button>
                          </div>
                        </div>
                      </td>
                      <td>Vui lòng chọn giá phòng</td>
                      <td>Tăng/Giảm giá</td>
                      <td>
                        <select class="select-sm">
                          <option>Select Value</option>
                        </select>
                      </td>
                      <td>
                        <div class="number-input-group">
                          <input type="number" v-model="roomData[rt.id].adults" />
                          <div class="spinners">
                            <button class="spinner-up" @click.prevent="updateRoomData(rt.id, 'adults', 1)">▲</button>
                            <button class="spinner-down" @click.prevent="updateRoomData(rt.id, 'adults', -1)">▼</button>
                          </div>
                        </div>
                      </td>
                      <td>
                        <div class="number-input-group">
                          <input type="number" v-model="roomData[rt.id].infants" />
                          <div class="spinners">
                            <button class="spinner-up" @click.prevent="updateRoomData(rt.id, 'infants', 1)">▲</button>
                            <button class="spinner-down" @click.prevent="updateRoomData(rt.id, 'infants', -1)">▼</button>
                          </div>
                        </div>
                      </td>
                      <td>
                        <div class="number-input-group">
                          <input type="number" v-model="roomData[rt.id].children" />
                          <div class="spinners">
                            <button class="spinner-up" @click.prevent="updateRoomData(rt.id, 'children', 1)">▲</button>
                            <button class="spinner-down" @click.prevent="updateRoomData(rt.id, 'children', -1)">▼</button>
                          </div>
                        </div>
                      </td>
                      <td>90,000</td>
                      <td class="text-center">
                        <input type="checkbox" checked class="checkbox-custom" />
                      </td>
                    </tr>
                    <!-- Footer summary row -->
                    <tr class="footer-row-data">
                      <td colspan="2" class="text-left text-bold">Tổng: {{ bookingOptions.room_types.length }}</td>
                      <td class="text-bold">{{ totalOccupied }}</td>
                      <td class="text-bold">{{ totalAvailable }}</td>
                      <td class="text-bold">{{ totalQuantity }}</td>
                      <td colspan="4"></td>
                      <td class="text-bold">{{ totalAdults }}</td>
                      <td class="text-bold">{{ totalInfants }}</td>
                      <td class="text-bold">{{ totalChildren }}</td>
                      <td colspan="2"></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="tab-footer mt-2">
                <button class="btn-save">
                  <svg viewBox="0 0 24 24" class="icon-svg mr-1">
                    <path
                      d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    />
                  </svg>
                  Lưu
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch, computed } from 'vue'

const props = defineProps({
  isOpen: {
    type: Boolean,
    default: false,
  },
  initialData: {
    type: Object,
    default: null,
  },
})

const emit = defineEmits(['close'])

const currentTab = ref('general')

const bookingOptions = ref({
  reservation_statuses: [],
  companies: [],
  payment_methods: [],
  employees: [],
  market_segments: [],
  booking_sources: [],
  bookers: [],
  room_types: [],
})

const roomData = ref({})

watch(
  () => bookingOptions.value.room_types,
  (types) => {
    types.forEach((rt) => {
      if (!roomData.value[rt.id]) {
        let defaultAdults = 2
        if (rt.type_short_name === 'SUPTR') defaultAdults = 3
        if (rt.type_short_name === 'DLXDB' || rt.type_short_name === 'FAM') defaultAdults = 4

        roomData.value[rt.id] = {
          occupied: 0,
          available: rt.total_rooms || 0,
          quantity: 0,
          price: 0,
          adults: defaultAdults,
          infants: 0,
          children: 0,
        }
      }
    })
  },
  { immediate: true, deep: true }
)

const updateRoomData = (id, field, delta) => {
  if (roomData.value[id]) {
    const current = roomData.value[id][field]
    if (current + delta >= 0) {
      roomData.value[id][field] = current + delta
    }
  }
}

const totalOccupied = computed(() => Object.values(roomData.value).reduce((sum, item) => sum + item.occupied, 0))
const totalAvailable = computed(() => Object.values(roomData.value).reduce((sum, item) => sum + item.available, 0))
const totalQuantity = computed(() => Object.values(roomData.value).reduce((sum, item) => sum + item.quantity, 0))
const totalAdults = computed(() => Object.values(roomData.value).reduce((sum, item) => sum + item.adults, 0))
const totalInfants = computed(() => Object.values(roomData.value).reduce((sum, item) => sum + item.infants, 0))
const totalChildren = computed(() => Object.values(roomData.value).reduce((sum, item) => sum + item.children, 0))

const fetchOptions = async () => {
  try {
    const response = await fetch('http://127.0.0.1:8000/api/booking-options')
    if (response.ok) {
      bookingOptions.value = await response.json()
    }
  } catch (error) {
    console.error('Failed to fetch booking options', error)
  }
}

const formBookingCode = ref('')
const formGuestName = ref('')
const formCheckIn = ref('')
const formCheckOut = ref('')
const formStatusId = ref('')
const formCompanyCode = ref('')
const formDeposit = ref('0')
const formMarketSegment = ref('')
const formBookingSource = ref('')
const formConfirmedDate = ref('')
const formPaymentMethod = ref('')
const formReferenceCode = ref('')
const formSeller = ref('')
const formIsGit = ref(false)
const formIsVat = ref(false)
const formNights = ref(0)

const fillFromData = (data) => {
  if (!data || data.isNew) {
    formBookingCode.value = ''
    formGuestName.value = ''
    formCheckIn.value = ''
    formCheckOut.value = ''
    formStatusId.value = ''
    formCompanyCode.value = ''
    formDeposit.value = '0'
    formMarketSegment.value = ''
    formBookingSource.value = ''
    formConfirmedDate.value = ''
    formPaymentMethod.value = ''
    formReferenceCode.value = ''
    formSeller.value = ''
    formIsGit.value = false
    formIsVat.value = false
    formNights.value = 0
    selectedBookerId.value = ''
    bookingNotes.value = ''
    return
  }
  formBookingCode.value = data.booking_code || ''
  formGuestName.value = data.guest_name || ''
  const fmt = (d) => {
    if (!d) return ''
    const dt = new Date(d)
    return `${String(dt.getDate()).padStart(2, '0')}/${String(dt.getMonth() + 1).padStart(2, '0')}/${dt.getFullYear()}`
  }
  formCheckIn.value = fmt(data.check_in)
  formCheckOut.value = fmt(data.check_out)
  formStatusId.value = data.status?.id || ''
  formCompanyCode.value = data.company?.company_code || ''
  formDeposit.value = data.deposit || '0'
  formMarketSegment.value = data.market_segment_code || ''
  formBookingSource.value = data.booking_source_code || ''
  formConfirmedDate.value = fmt(data.confirmed_date)
  formPaymentMethod.value = data.payment_method_code || ''
  formReferenceCode.value = data.reference_code || ''
  formSeller.value = data.employee_code || ''
  formIsGit.value = Boolean(data.is_git)
  formIsVat.value = Boolean(data.is_vat)
  formNights.value = data.nights || 0
  selectedBookerId.value = data.booker_id || ''
  
  // Update notes after the watcher handles booker selection
  setTimeout(() => {
    if (data.notes !== null && data.notes !== undefined) {
      bookingNotes.value = data.notes
    }
  }, 10)
}

watch(
  () => props.isOpen,
  (newVal) => {
    if (newVal) {
      selectedColor.value = 'none'
      showColorPicker.value = false
      currentTab.value = 'general'
      selectedBookerId.value = ''
      contactPhone.value = ''
      contactEmail.value = ''
      bookingNotes.value = ''
      fillFromData(props.initialData)
    }
  },
)

const showColorPicker = ref(false)
const selectedColor = ref('none')

const selectedBookerId = ref('')
const contactPhone = ref('')
const contactEmail = ref('')
const bookingNotes = ref('')

watch(selectedBookerId, (newId) => {
  const booker = bookingOptions.value.bookers.find((b) => String(b.id) === String(newId))
  if (booker) {
    contactPhone.value = booker.phone || ''
    contactEmail.value = booker.email || ''
    bookingNotes.value = booker.notes || ''
  } else {
    contactPhone.value = ''
    contactEmail.value = ''
    bookingNotes.value = ''
  }
})

const colors = [
  '#8d6e63',
  '#78909c',
  '#ba68c8',
  '#80cbc4',
  '#aed581',
  '#bdbdbd',
  '#e57373',
  '#f06292',
  '#dce775',
  '#ffb74d',
]

const toggleColorPicker = () => {
  showColorPicker.value = !showColorPicker.value
}

const selectColor = (color) => {
  selectedColor.value = color
  showColorPicker.value = false
}

const closeColorPicker = () => {
  showColorPicker.value = false
}

onMounted(() => {
  fetchOptions()
  document.addEventListener('click', closeColorPicker)
})

onUnmounted(() => {
  document.removeEventListener('click', closeColorPicker)
})

const closeModal = () => {
  emit('close')
}
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.4);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-wrapper {
  background: white;
  width: 1200px;
  max-width: 95vw;
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.modal-header {
  background-color: #63c2de;
  color: white;
  padding: 12px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.modal-title {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
}

.btn-close {
  background: none;
  border: none;
  cursor: pointer;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-body {
  padding: 15px 20px;
  display: flex;
  flex-direction: column;
  background-color: #fcfcfc;
}

/* Top Section Styles */
.top-section {
  position: relative;
  margin-bottom: 20px;
}

.top-actions {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  align-items: center;
  z-index: 10;
  margin-bottom: 10px;
}

.toggle-switch {
  display: flex;
  align-items: center;
  cursor: pointer;
  background: white;
  border: 1px solid #ddd;
  border-radius: 15px;
  padding: 2px;
}
.toggle-switch input {
  display: none;
}
.toggle-switch .slider {
  width: 30px;
  height: 16px;
  background-color: #ccc;
  border-radius: 16px;
  position: relative;
  transition: 0.4s;
  margin-left: 5px;
}
.toggle-switch .slider:before {
  content: '';
  position: absolute;
  height: 12px;
  width: 12px;
  border-radius: 50%;
  left: 2px;
  bottom: 2px;
  background-color: white;
  transition: 0.4s;
}
.toggle-switch input:checked + .slider {
  background-color: #63c2de;
}
.toggle-switch input:checked + .slider:before {
  transform: translateX(14px);
}
.toggle-label {
  font-size: 12px;
  margin-left: 6px;
  margin-right: 2px;
  color: #666;
  font-weight: bold;
}

.btn-icon {
  width: 26px;
  height: 26px;
  border-radius: 4px;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: white;
}
.bg-light-blue {
  background-color: #63c2de;
}
.bg-blue-gray {
  background-color: #7a92a3;
}
.icon-svg {
  width: 14px;
  height: 14px;
}

.form-row {
  display: flex;
  gap: 15px;
}
.mt-3 {
  margin-top: 12px;
}
.ml-1 {
  margin-left: 4px;
}
.mr-1 {
  margin-right: 4px;
}
.pl-24 {
  padding-left: 24px !important;
}
.text-center {
  text-align: center;
}
.text-left {
  text-align: left !important;
}
.text-bold {
  font-weight: bold;
}
.text-white {
  color: white;
}
.text-blue {
  color: #63c2de;
}
.border-0 {
  border: none !important;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 4px;
}
.form-group label {
  font-size: 12px;
  color: #333;
}
.form-control {
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 6px 10px;
  font-size: 13px;
  width: 100%;
  box-sizing: border-box;
  outline: none;
}
.form-control:focus {
  border-color: #63c2de;
}

.bg-gray {
  background-color: #e9ecef;
}
.bg-gray-light {
  background-color: #f8f9fa;
  border: 1px solid #ccc;
  border-radius: 4px;
}
.bg-yellow {
  background-color: #fdfae2;
}
.bg-transparent {
  background-color: transparent;
  border: none;
}

.input-with-icon {
  display: flex;
  align-items: center;
  position: relative;
  border: 1px solid #ccc;
  border-radius: 4px;
  overflow: hidden;
}
.input-with-icon .form-control {
  border: none;
  border-radius: 0;
}
.input-with-icon .icon-btn {
  width: 28px;
  height: 100%;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}
.color-box {
  width: 28px;
  height: 100%;
  min-height: 28px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  background-color: #63c2de;
}
.color-picker-dropdown {
  position: absolute;
  top: calc(100% + 5px);
  left: 0;
  background: white;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 12px;
  display: grid;
  grid-template-columns: repeat(5, auto);
  gap: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  z-index: 100;
  justify-items: center;
  align-items: center;
}
.color-option {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  cursor: pointer;
}
.text-option {
  width: auto;
  height: auto;
  border-radius: 0;
  font-size: 13px;
  color: #333;
}
.input-with-icon .icon-btn-circle {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  border: none;
  background-color: #63c2de;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  margin-right: 4px;
  font-weight: bold;
}
.icon-moon {
  width: 16px;
  height: 16px;
  margin-right: 6px;
}
.icon-calendar {
  width: 16px;
  height: 16px;
  position: absolute;
  right: 8px;
  top: 50%;
  transform: translateY(-50%);
  pointer-events: none;
}
.icon-calendar-sm {
  width: 14px;
  height: 14px;
}
.icon-document {
  width: 16px;
  height: 16px;
  position: absolute;
  right: 28px;
  top: 50%;
  transform: translateY(-50%);
  pointer-events: none;
}

.select-wrapper {
  position: relative;
  border: 1px solid #ccc;
  border-radius: 4px;
}
.select-wrapper select {
  border: none;
  appearance: none;
}
.status-dot {
  position: absolute;
  left: 8px;
  top: 50%;
  transform: translateY(-50%);
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background-color: #888;
  z-index: 1;
}

.date-range-input {
  display: flex;
  align-items: center;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding-right: 28px;
  position: relative;
  background: white;
}
.date-range-input .form-control {
  border: none;
  width: 50%;
  padding: 6px;
}
.date-range-input span {
  color: #666;
}

/* Tabs */
.tabs-container {
  display: flex;
  flex-direction: column;
}
.tabs-header {
  display: flex;
  border-bottom: 2px solid #e2e8f0;
  margin-bottom: 15px;
}
.tab-btn {
  padding: 10px 20px;
  background: none;
  border: none;
  font-size: 14px;
  color: #64748b;
  cursor: pointer;
  position: relative;
  font-weight: 500;
}
.tab-btn.active {
  color: #63c2de;
}
.tab-btn.active::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 100%;
  height: 2px;
  background-color: #63c2de;
}

.tab-content {
  background: white;
}

.general-grid {
  display: grid;
  grid-template-columns: 1fr 2fr 1.5fr 1.5fr;
  gap: 20px;
}

.fieldset {
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  padding: 10px 15px 15px;
  position: relative;
  margin-top: 10px;
}
.fieldset legend {
  font-size: 13px;
  color: #555;
  padding: 0 5px;
  background: #fcfcfc;
  margin-left: -5px;
  font-weight: 500;
}

.flex-row {
  display: flex;
}
.flex-1 {
  flex: 1;
}
.gap-3 {
  gap: 12px;
}
.textarea {
  resize: none;
  height: 100px;
}

.tab-footer {
  display: flex;
  justify-content: flex-end;
  margin-top: 15px;
}

.btn-save {
  background-color: #63c2de;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 8px 24px;
  font-size: 14px;
  cursor: pointer;
  display: flex;
  align-items: center;
}
.btn-save:hover {
  background-color: #4eb0cc;
}

/* Data Table */
.table-container {
  overflow-x: auto;
  overflow-y: auto;
  max-height: 300px;
  border: 1px solid #e0e0e0;
  border-radius: 4px;
}
.data-table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  font-size: 13px;
}
.data-table th,
.data-table td {
  border-bottom: 1px solid #e0e0e0;
  border-right: 1px solid #e0e0e0;
  padding: 8px 10px;
  text-align: center;
}
.data-table th:first-child,
.data-table td:first-child {
  border-left: 1px solid #e0e0e0;
}
.data-table th {
  background-color: #f8f9fa;
  font-weight: bold;
  color: #333;
  position: sticky;
  top: 0;
  z-index: 10;
  border-top: 1px solid #e0e0e0;
}
.btn-add-row {
  background: none;
  border: 1px solid #ccc;
  border-radius: 50%;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: #333;
}

/* Number Input Spinner */
.number-input-group {
  display: inline-flex;
  border: 1px solid #ccc;
  border-radius: 4px;
  overflow: hidden;
  width: 60px;
  height: 26px;
  background: white;
}
.number-input-group input {
  width: 100%;
  border: none;
  text-align: center;
  outline: none;
  font-size: 13px;
  -moz-appearance: textfield;
}
.number-input-group input::-webkit-outer-spin-button,
.number-input-group input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
.spinners {
  display: flex;
  flex-direction: column;
  border-left: 1px solid #ccc;
  background: #f8f9fa;
}
.spinners button {
  border: none;
  background: none;
  font-size: 8px;
  padding: 0 4px;
  cursor: pointer;
  height: 50%;
  color: #63c2de;
}
.spinners button:first-child {
  border-bottom: 1px solid #ccc;
}

.date-range-small {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
}
.select-sm {
  padding: 4px;
  border: 1px solid #ccc;
  border-radius: 3px;
  outline: none;
  color: #888;
}

.checkbox-custom {
  width: 16px;
  height: 16px;
  accent-color: #63c2de;
}

.footer-row-data td {
  background-color: #f8f9fa;
  font-weight: bold;
}
</style>
