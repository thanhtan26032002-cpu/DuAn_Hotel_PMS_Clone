<template>
  <div class="booking-container">
    <div class="tabs">
      <div
        v-for="(tab, index) in tabs"
        :key="index"
        class="tab-item"
        :class="{ active: currentTab === tab }"
        @click="currentTab = tab"
      >
        {{ tab }}
      </div>
    </div>

    <div class="filter-section">
      <div class="date-picker-group">
        <div class="date-input">
          <input type="text" v-model="fromDate" />
          <svg
            class="icon-calendar"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          >
            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
            <line x1="16" y1="2" x2="16" y2="6"></line>
            <line x1="8" y1="2" x2="8" y2="6"></line>
            <line x1="3" y1="10" x2="21" y2="10"></line>
          </svg>
        </div>

        <template v-if="currentTab !== 'Phòng đến' && currentTab !== 'Phòng đi'">
          <span class="separator">~</span>
          <div class="date-input">
            <input type="text" v-model="toDate" />
            <svg
              class="icon-calendar"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
              <line x1="16" y1="2" x2="16" y2="6"></line>
              <line x1="8" y1="2" x2="8" y2="6"></line>
              <line x1="3" y1="10" x2="21" y2="10"></line>
            </svg>
          </div>
        </template>
      </div>

      <div v-if="currentTab === 'Phòng không đến (Noshow)'" class="radio-group">
        <label class="radio-label">
          <input type="radio" value="all" v-model="noshowFilter" />
          Tất cả
        </label>
        <label class="radio-label">
          <input type="radio" value="fee" v-model="noshowFilter" />
          Tính phí
        </label>
        <label class="radio-label">
          <input type="radio" value="nofee" v-model="noshowFilter" />
          Không tính phí
        </label>
      </div>

      <button class="btn-search">Tìm kiếm</button>
    </div>

    <div class="table-wrapper">
      <table v-if="currentTab === 'Phòng đến'" class="table-phong-den">
        <thead>
          <tr>
            <th class="col-stt"></th>
            <th>Mã đăng ký</th>
            <th>Tên đăng ký</th>
            <th>Tình trạng đăng ký</th>
            <th>Phòng</th>
            <th>Ngày đến</th>
            <th>Ngày đi</th>
            <th>Đêm phòng</th>
            <th>Giá Phòng</th>
            <th>Mã giá phòng</th>
            <th>Tổng phòng</th>
            <th>Công ty</th>
          </tr>
        </thead>
        <tbody v-for="(group, gIndex) in phongDenData" :key="group.id">
          <tr class="group-header-blue" @click="togglePhongDenGroup(gIndex)">
            <td class="col-stt val-top">
              <span class="toggle-icon">
                <span v-if="group.isCollapsed" class="icon-plus"></span>
                <span v-else class="icon-minus"></span>
              </span>
            </td>
            <td colspan="7" class="details-cell val-top">
              <strong class="title">{{ group.bookingTitle }}</strong>
              <div class="note-line" v-for="(note, nIndex) in group.notes" :key="'note-' + nIndex">
                {{ note }}
              </div>
            </td>
            <td colspan="2" class="val-top text-left">
              <strong>Đặt cọc : {{ group.datCoc }}</strong>
            </td>
            <td colspan="2" class="val-top text-left">
              <strong>Tổng tiền : {{ group.tongTien }}</strong>
            </td>
          </tr>
          <tr
            v-show="!group.isCollapsed"
            v-for="item in group.items"
            :key="item.phong"
            class="data-row row-white"
          >
            <td class="col-stt"></td>
            <td>{{ item.maDangKy }}</td>
            <td>{{ item.tenDangKy }}</td>
            <td>{{ item.tinhTrang }}</td>
            <td>{{ item.phong }}</td>
            <td>{{ item.ngayDen }}</td>
            <td>{{ item.ngayDi }}</td>
            <td>{{ item.demPhong }}</td>
            <td>{{ item.giaPhong }}</td>
            <td>{{ item.maGiaPhong }}</td>
            <td>{{ item.tongPhong }}</td>
            <td>{{ item.congTy }}</td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="12" class="total-row">
              <strong
                >Tổng đăng ký: {{ phongDenData.length }} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Phòng:
                {{ totalPhongDenRooms }}</strong
              >
            </td>
          </tr>
        </tfoot>
      </table>

      <table v-if="currentTab === 'Phòng đi'" class="table-phong-di">
        <thead>
          <tr>
            <th class="col-stt"></th>
            <th>Mã đăng ký</th>
            <th>Tên đăng ký</th>
            <th>Tình trạng đăng ký</th>
            <th>Phòng</th>
            <th>Ngày đến</th>
            <th>Ngày đi</th>
            <th>Đêm phòng</th>
            <th>Giá Phòng</th>
            <th>Mã giá phòng</th>
            <th>Công ty</th>
            <th>Tổng dịch vụ</th>
            <th>Tổng thanh toán</th>
          </tr>
        </thead>
        <tbody v-for="(group, gIndex) in phongDiData" :key="group.id">
          <tr class="group-header-complex" @click="togglePhongDiGroup(gIndex)">
            <td class="col-stt val-top">
              <span class="toggle-icon">
                <span v-if="group.isCollapsed" class="icon-plus"></span>
                <span v-else class="icon-minus"></span>
              </span>
            </td>
            <td colspan="9" class="details-cell val-top">
              <strong class="title">{{ group.bookingTitle }}</strong>
              <div class="note-line" v-for="(note, nIndex) in group.notes" :key="'note-' + nIndex">
                {{ note }}
              </div>
              <div class="guest-title">TÊN KHÁCH :</div>
              <div
                class="guest-line"
                v-for="(guest, guestIdx) in group.guests"
                :key="'g-' + guestIdx"
              >
                {{ guest }}
              </div>
            </td>
            <td colspan="2" class="val-top text-left">
              <strong>Tiền dịch vụ: {{ group.tienDichVu }}</strong>
            </td>
            <td class="val-top text-left">
              <strong>Tiền đã thanh toán: {{ group.tienDaThanhToan }}</strong>
            </td>
          </tr>
          <tr
            v-show="!group.isCollapsed"
            v-for="item in group.items"
            :key="item.phong"
            class="data-row row-blue"
          >
            <td class="col-stt"></td>
            <td>{{ item.maDangKy }}</td>
            <td>{{ item.tenDangKy }}</td>
            <td>{{ item.tinhTrang }}</td>
            <td>{{ item.phong }}</td>
            <td>{{ item.ngayDen }}</td>
            <td>{{ item.ngayDi }}</td>
            <td>{{ item.demPhong }}</td>
            <td>{{ item.giaPhong }}</td>
            <td>{{ item.maGiaPhong }}</td>
            <td>{{ item.congTy }}</td>
            <td>{{ item.tongDichVu }}</td>
            <td>{{ item.tongThanhToan }}</td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="13" class="total-row">
              <strong
                >Tổng đăng ký: {{ phongDiData.length }} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Phòng:
                {{ totalPhongDiRooms }}</strong
              >
            </td>
          </tr>
        </tfoot>
      </table>

      <table v-else-if="currentTab === 'Đăng ký chờ xác nhận'">
        <thead>
          <tr>
            <th class="col-stt"></th>
            <th>Mã đăng ký</th>
            <th>Tên đăng ký</th>
            <th>Tình trạng đăng ký</th>
            <th>Công ty</th>
            <th>Đăng ký chờ xác nhận</th>
            <th>Ngày đến</th>
            <th>Ngày đi</th>
            <th>Đêm phòng</th>
            <th>Đặt cọc</th>
            <th>Phòng</th>
            <th>Liên hệ</th>
            <th class="col-note">Ghi chú</th>
          </tr>
        </thead>
        <tbody v-for="(group, gIndex) in dangKyData" :key="gIndex">
          <tr class="group-header" @click="toggleDangKyGroup(gIndex)">
            <td colspan="13">
              <span class="toggle-icon">
                <span v-if="group.isCollapsed" class="icon-plus"></span>
                <span v-else class="icon-minus"></span>
              </span>
              <strong>{{ group.date }}</strong>
            </td>
          </tr>
          <tr
            v-show="!group.isCollapsed"
            v-for="item in group.items"
            :key="item.id"
            class="data-row-gray"
          >
            <td class="col-stt">{{ item.id }}</td>
            <td>{{ item.maDangKy }}</td>
            <td>{{ item.tenDangKy }}</td>
            <td>{{ item.tinhTrang }}</td>
            <td>{{ item.congTy }}</td>
            <td>{{ item.ngayChoXacNhan }}</td>
            <td>{{ item.ngayDen }}</td>
            <td>{{ item.ngayDi }}</td>
            <td>{{ item.demPhong }}</td>
            <td>{{ item.datCoc }}</td>
            <td>{{ item.phong }}</td>
            <td>{{ item.lienHe }}</td>
            <td class="col-note">
              <div class="note-action">
                <!-- Ô nhập ghi chú -->
                <input type="text" placeholder="Ghi chú" v-model="item.ghiChu" class="note-input" />

                <!-- Icon Lưu (Save) -->
                <button class="btn-icon btn-save" title="Lưu ghi chú">
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <path
                      d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"
                    ></path>
                    <polyline points="17 21 17 13 7 13 7 21"></polyline>
                    <polyline points="7 3 7 8 15 8"></polyline>
                  </svg>
                </button>

                <!-- Icon Sửa (Hình cây bút) -->
                <button class="btn-icon btn-edit" title="Sửa">
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                    <path d="M18.5 2.5a2.121 2.121 0 1 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                  </svg>
                </button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>

      <table v-else-if="currentTab === 'Đón tiễn khách'">
        <thead>
          <tr>
            <th class="col-stt"></th>
            <th>Mã đăng ký</th>
            <th>Đến bằng/ Đi bằng phương tiện</th>
            <th>Mã số chuyến bay</th>
            <th>Ngày</th>
            <th>Thời gian đón/ tiễn</th>
            <th>Giá Phòng</th>
            <th>Đưa/ tiễn bằng phương tiện</th>
            <th>Ghi chú</th>
          </tr>
        </thead>
        <tbody>
          <tr v-if="donTienData.length === 0">
            <td colspan="9" class="empty-state">
              <div class="empty-content">
                <svg
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#ccc"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <path d="M21 8l-9 4-9-4 9-4 9 4z"></path>
                  <path d="M3 8v8l9 4 9-4V8"></path>
                  <path d="M12 12v10"></path>
                  <path d="M3 8l5-3"></path>
                  <path d="M21 8l-5-3"></path>
                  <path d="M12 12l3-1.5"></path>
                </svg>
                <p>No Data</p>
              </div>
            </td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="2" class="total-row">
              <strong>Tổng: {{ donTienData.length }}</strong>
            </td>
            <td colspan="7"></td>
          </tr>
        </tfoot>
      </table>

      <table v-else-if="currentTab === 'Phòng không đến (Noshow)'">
        <thead>
          <tr>
            <th class="col-stt"></th>
            <th>Phòng</th>
            <th>Mã BK</th>
            <th>Tên nhóm</th>
            <th>Ngày XN</th>
            <th>Ngày đến</th>
            <th>Số Đêm</th>
            <th>Ngày Vắng</th>
            <th>Giờ</th>
            <th>Giá Phòng</th>
            <th>Người Dùng</th>
            <th>Ca</th>
            <th>Lý Do</th>
          </tr>
        </thead>
        <tbody>
          <tr v-if="noshowData.length === 0">
            <td colspan="13" class="empty-state">
              <div class="empty-content">
                <svg
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#ccc"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <path d="M21 8l-9 4-9-4 9-4 9 4z"></path>
                  <path d="M3 8v8l9 4 9-4V8"></path>
                  <path d="M12 12v10"></path>
                  <path d="M3 8l5-3"></path>
                  <path d="M21 8l-5-3"></path>
                  <path d="M12 12l3-1.5"></path>
                </svg>
                <p>No Data</p>
              </div>
            </td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="2" class="total-row">
              <strong>Tổng: {{ noshowData.length }}</strong>
            </td>
            <td colspan="11"></td>
          </tr>
        </tfoot>
      </table>

      <table v-else-if="currentTab === 'Sinh nhật khách'">
        <thead>
          <tr>
            <th class="col-stt"></th>
            <th>Mã đăng ký</th>
            <th>Phòng</th>
            <th>Tên khách</th>
            <th>Sinh nhật</th>
            <th>Loại giấy tờ</th>
            <th>Hộ chiếu</th>
            <th>Email</th>
            <th>Số điện thoại</th>
            <th>Quốc tịch</th>
            <th>Ngày đến</th>
            <th>Ngày đi</th>
            <th>Đêm ở</th>
            <th>Giá Phòng</th>
            <th>Mã giá phòng</th>
            <th>Công ty DL</th>
          </tr>
        </thead>
        <tbody>
          <tr v-if="sinhNhatData.length === 0">
            <td colspan="16" class="empty-state">
              <div class="empty-content">
                <svg
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#ccc"
                  stroke-width="1.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <path d="M21 8l-9 4-9-4 9-4 9 4z"></path>
                  <path d="M3 8v8l9 4 9-4V8"></path>
                  <path d="M12 12v10"></path>
                  <path d="M3 8l5-3"></path>
                  <path d="M21 8l-5-3"></path>
                  <path d="M12 12l3-1.5"></path>
                </svg>
                <p>No Data</p>
              </div>
            </td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="2" class="total-row">
              <strong>Tổng: {{ sinhNhatData.length }}</strong>
            </td>
            <td colspan="14"></td>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const tabs = ref([
  'Phòng đến',
  'Phòng đi',
  'Đăng ký chờ xác nhận',
  'Đón tiễn khách',
  'Phòng không đến (Noshow)',
  'Sinh nhật khách',
])
const currentTab = ref('Đăng ký chờ xác nhận') // Đặt mặc định mở tab Phòng đến lên trước
const fromDate = ref('24 / 06 / 2026')
const toDate = ref('27 / 06 / 2026')
const noshowFilter = ref('all')

// ----------------------------------------
// DỮ LIỆU TAB: PHÒNG ĐẾN (Mới thêm theo ảnh)
// ----------------------------------------
const phongDenData = ref([
  {
    id: 'pdn1',
    isCollapsed: false,
    bookingTitle:
      'Booking GAL4947: LOCK CHO ANH KHÁNH TCO _ 24/06/2026~27/06/2026 _ Room Night: 3_Phòng :3',
    notes: [
      'Ghi chú: dlx city view: 1.200.000/n',
      'dlx triple: 1.440.000/n',
      'tổng cộng: 3.840.000, giá giảm 50 %',
      'GIA ĐÌNH EM TRAI SẾP SƠN, BK CỦA ANH KHÔI',
      'KHÔNG THU TIỀN KHÁCH, CHECK LẠI THÔNG TIN VỚI ANH KHÔI TRƯỚC KHI KHÁCH NHẬN PHÒNG',
      'SETUP TRÁI CÂY 3 PHÒNG',
    ],
    datCoc: '0',
    tongTien: '5,760,000',
    items: [
      {
        maDangKy: 'GAL4947',
        tenDangKy: 'LOCK CHO ANH KHÁNH TCO',
        tinhTrang: 'Guaranteed',
        phong: '1410',
        ngayDen: '24/06/2026',
        ngayDi: '27/06/2026',
        demPhong: 3,
        giaPhong: '600,000',
        maGiaPhong: '',
        tongPhong: '1,800,000',
        congTy: 'TA GM',
      },
      {
        maDangKy: 'GAL4947',
        tenDangKy: 'LOCK CHO ANH KHÁNH TCO',
        tinhTrang: 'Guaranteed',
        phong: '1406',
        ngayDen: '24/06/2026',
        ngayDi: '27/06/2026',
        demPhong: 3,
        giaPhong: '600,000',
        maGiaPhong: '',
        tongPhong: '1,800,000',
        congTy: 'TA GM',
      },
      {
        maDangKy: 'GAL4947',
        tenDangKy: 'LOCK CHO ANH KHÁNH TCO',
        tinhTrang: 'Guaranteed',
        phong: '802',
        ngayDen: '24/06/2026',
        ngayDi: '27/06/2026',
        demPhong: 3,
        giaPhong: '720,000',
        maGiaPhong: '',
        tongPhong: '2,160,000',
        congTy: 'TA GM',
      },
    ],
  },
])

const togglePhongDenGroup = (index) => {
  phongDenData.value[index].isCollapsed = !phongDenData.value[index].isCollapsed
}

const totalPhongDenRooms = computed(() => {
  return phongDenData.value.reduce((total, group) => total + group.items.length, 0)
})

// ----------------------------------------
// DỮ LIỆU TAB: PHÒNG ĐI
// ----------------------------------------
const phongDiData = ref([
  {
    id: 'pd1',
    isCollapsed: false,
    bookingTitle:
      'Booking GAL3860: GREEN TRAVEL GROUP - 374555 _ 07/06/2026~24/06/2026 _ Room Night: 17_Phòng: 1',
    notes: [
      'Ghi chú: 1 DELUXE CITY VIEW - DBL * 630,000 VND/R/N',
      'FOC 2 ĐÊM CUỐI',
      'CTY TT + VAT',
    ],
    guests: ['Mrs ZAMARAEVA SVETLANA RU 20.08.2000', 'Mr KSENZOV ALEKSEI RU 07.10.1992'],
    tienDichVu: '9,450,000',
    tienDaThanhToan: '0',
    items: [
      {
        maDangKy: 'GAL3860',
        tenDangKy: 'GREEN TRAVEL GROUP - 374555',
        tinhTrang: 'Guaranteed',
        phong: '811',
        ngayDen: '07/06/2026',
        ngayDi: '24/06/2026',
        demPhong: 17,
        giaPhong: '630,000',
        maGiaPhong: '',
        congTy: 'GREEN TRAVEL GROUP',
        tongDichVu: '0',
        tongThanhToan: '0',
      },
    ],
  },
  {
    id: 'pd2',
    isCollapsed: false,
    bookingTitle:
      'Booking GAL4470: ODEON TOURS - 4460586 _ 13/06/2026~24/06/2026 _ Room Night: 11_Phòng: 1',
    notes: [
      'Ghi chú: 1 DELUXE CITY VIEW WITH BALCONY * 890,000 VND/R/N',
      'FOC 1 ĐÊM CUỐI',
      'CTY TT , NO VAT',
    ],
    guests: [
      '1 POTEKHINA/MARINA Adult-Mrs. 25.12.1983 - 42',
      '2 POTEKHIN/VLADIMIR Adult-Mr. 09.07.1985 - 40',
    ],
    tienDichVu: '8,900,000',
    tienDaThanhToan: '0',
    items: [
      {
        maDangKy: 'GAL4470',
        tenDangKy: 'ODEON TOURS - 4460586',
        tinhTrang: 'Guaranteed',
        phong: '612',
        ngayDen: '13/06/2026',
        ngayDi: '24/06/2026',
        demPhong: 11,
        giaPhong: '890,000',
        maGiaPhong: '',
        congTy: 'ODEON TOURS',
        tongDichVu: '0',
        tongThanhToan: '0',
      },
    ],
  },
])

const togglePhongDiGroup = (index) => {
  phongDiData.value[index].isCollapsed = !phongDiData.value[index].isCollapsed
}

const totalPhongDiRooms = computed(() => {
  return phongDiData.value.reduce((total, group) => total + group.items.length, 0)
})

// ----------------------------------------
// DỮ LIỆU TAB: ĐĂNG KÝ CHỜ XÁC NHẬN
// ----------------------------------------
const dangKyData = ref([
  {
    date: '23/06/2026',
    isCollapsed: false,
    items: [
      {
        id: 1,
        maDangKy: 'GAL5488',
        tenDangKy: 'TEST ALM CUỐI KÌ',
        tinhTrang: 'Allotment',
        congTy: 'Travel Concierge',
        ngayChoXacNhan: '23/06/2026',
        ngayDen: '28/06/2026',
        ngayDi: '03/07/2026',
        demPhong: 5,
        datCoc: 0,
        phong: '',
        lienHe: '',
        ghiChu: '',
      },
    ],
  },
  {
    date: '16/06/2026',
    isCollapsed: false,
    items: [
      {
        id: 2,
        maDangKy: 'GAL5499',
        tenDangKy: 'Walkin Guest',
        tinhTrang: 'None Guaranteed',
        congTy: 'KHÁCH LẺ',
        ngayChoXacNhan: '16/06/2026',
        ngayDen: '28/06/2026',
        ngayDi: '01/07/2026',
        demPhong: 3,
        datCoc: 0,
        phong: '',
        lienHe: '',
        ghiChu: '',
      },
    ],
  },
  {
    date: '15/06/2026',
    isCollapsed: false,
    items: [
      {
        id: 3,
        maDangKy: 'GAL5411',
        tenDangKy: 'NGUYỄN VĂN A',
        tinhTrang: 'None Guaranteed',
        congTy: 'KHÁCH LẺ',
        ngayChoXacNhan: '15/06/2026',
        ngayDen: '21/06/2026',
        ngayDi: '23/06/2026',
        demPhong: 2,
        datCoc: 0,
        phong: '',
        lienHe: '0901234567',
        ghiChu: 'Khách chọn phòng tầng cao',
      },
      {
        id: 4,
        maDangKy: 'GAL5422',
        tenDangKy: 'TRẦN THỊ B',
        tinhTrang: 'None Guaranteed',
        congTy: 'KHÁCH LẺ',
        ngayChoXacNhan: '15/06/2026',
        ngayDen: '18/06/2026',
        ngayDi: '21/06/2026',
        demPhong: 3,
        datCoc: 0,
        phong: '',
        lienHe: '0938888999',
        ghiChu: 'Yêu cầu 1 giường lớn',
      },
    ],
  },
  {
    date: '05/06/2026',
    isCollapsed: false,
    items: [
      {
        id: 5,
        maDangKy: 'GAL5300',
        tenDangKy: 'BOOKING TRIP.COM',
        tinhTrang: 'Noshow with Penalty',
        congTy: 'TRIP.COM',
        ngayChoXacNhan: '05/06/2026',
        ngayDen: '06/06/2026',
        ngayDi: '07/06/2026',
        demPhong: 1,
        datCoc: 500000,
        phong: '102',
        lienHe: 'Hotline Trip.com',
        ghiChu: 'Tính phí noshow 1 đêm',
      },
    ],
  },
])

const toggleDangKyGroup = (index) => {
  dangKyData.value[index].isCollapsed = !dangKyData.value[index].isCollapsed
}

// ----------------------------------------
// DỮ LIỆU CÁC TAB EMPTY STATE (No Data)
// ----------------------------------------
const donTienData = ref([])
const noshowData = ref([])
const sinhNhatData = ref([])
</script>

<style scoped>
/* Toàn bộ CSS khung và Tabs */
.booking-container {
  font-family: Arial, sans-serif;
  color: #333;
  font-size: 13px;
  background-color: #f9f9f9;
  padding: 10px;
}
.tabs {
  display: flex;
  border-bottom: 2px solid #e0e0e0;
  margin-bottom: 15px;
  background: #fff;
}
.tab-item {
  padding: 10px 15px;
  cursor: pointer;
  font-weight: bold;
  color: #000;
  border-bottom: 2px solid transparent;
  margin-bottom: -2px;
}
.tab-item.active {
  color: #85c8ea;
  border-bottom: 2px solid #85c8ea;
}
.filter-section {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
  background: #fff;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
}
.date-picker-group {
  display: flex;
  align-items: center;
  margin-right: 15px;
}
.date-input {
  display: flex;
  align-items: center;
  border: 1px solid #ccc;
  padding: 4px 8px;
  border-radius: 4px;
  background: #fff;
}
.date-input input {
  border: none;
  outline: none;
  width: 90px;
  font-size: 13px;
}
.icon-calendar {
  width: 15px;
  height: 15px;
  stroke: #4caf50;
  margin-left: 8px;
  cursor: pointer;
}
.separator {
  margin: 0 10px;
}
.radio-group {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-right: 15px;
  font-size: 13px;
}
.radio-label {
  display: flex;
  align-items: center;
  cursor: pointer;
}
.radio-label input[type='radio'] {
  margin-right: 5px;
  cursor: pointer;
  accent-color: #85c8ea;
}
.btn-search {
  background-color: #85c8ea;
  color: white;
  border: none;
  padding: 6px 15px;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

/* Bảng dữ liệu chính */
.table-wrapper {
  overflow-x: auto;
  background: #fff;
  border: 1px solid #ddd;
  min-height: 200px;
}
table {
  width: 100%;
  border-collapse: collapse;
  white-space: nowrap;
}
thead th {
  background-color: #f0f0f0;
  padding: 10px;
  text-align: left;
  border-bottom: 1px solid #ddd;
  border-right: 1px solid #ddd;
  font-weight: bold;
}
tbody td {
  padding: 8px 10px;
  border-bottom: 1px solid #ddd;
  border-right: 1px solid #ddd;
}
tfoot td {
  padding: 10px;
  border-bottom: 1px solid #ddd;
  border-right: 1px solid #ddd;
  background-color: #fff;
}

.col-stt {
  width: 30px;
  text-align: center;
}
.col-note {
  min-width: 200px;
}
.val-top {
  vertical-align: top;
  padding-top: 15px;
}
.text-left {
  text-align: left;
}

/* Các hàng Tiêu đề Nhóm (Gom cụm Booking) */
.group-header {
  background-color: #f9f9f9;
  cursor: pointer;
  user-select: none;
}
.group-header td {
  font-weight: bold;
}
.group-header-complex {
  background-color: #fff;
  cursor: pointer;
  user-select: none;
  border-bottom: 1px solid #eee;
}

/* Đổ màu cho Header Group của tab PHÒNG ĐẾN */
.group-header-blue {
  background-color: white;
  cursor: pointer;
  user-select: none;
  border-bottom: 1px solid #b3e5fc;
}

/* Nút Icon đóng/mở cụm (+ / -) */
.toggle-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background-color: #85c8ea;
  width: 14px;
  height: 14px;
  margin-right: 8px;
  border-radius: 2px;
}
.icon-minus,
.icon-plus {
  background-color: white;
  display: block;
}
.icon-minus {
  width: 8px;
  height: 2px;
}
.icon-plus {
  width: 8px;
  height: 8px;
  background:
    linear-gradient(white, white) no-repeat center/2px 100%,
    linear-gradient(white, white) no-repeat center/100% 2px;
}

/* Chi tiết văn bản bên trong Header Group */
.details-cell {
  line-height: 1.6;
  white-space: normal;
  word-break: break-word;
}
.details-cell .title {
  display: block;
  font-weight: bold;
  margin-bottom: 4px;
}
.details-cell .guest-title {
  font-weight: normal;
  margin-top: 6px;
}

/* Quy tắc màu các hàng dữ liệu con */
.row-blue td {
  background-color: #d1effc;
} /* Dòng con màu xanh của tab Phòng đi */
.row-white td {
  background-color: #ffffff;
} /* Dòng con màu trắng của tab Phòng đến */
.data-row-gray td {
  background-color: #ffffff;
}

/* Ô nhập ghi chú */
.note-action {
  display: flex;
  align-items: center;
  gap: 6px;
}
.note-input {
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 5px 8px;
  flex: 1;
  background-color: #f5f5f5;
  outline: none;
}
.btn-icon {
  background-color: #85c8ea;
  border: none;
  color: white;
  width: 26px;
  height: 26px;
  border-radius: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.btn-icon svg {
  width: 14px;
  height: 14px;
}

/* Trạng thái trống (No Data) */
.empty-state {
  text-align: center;
  padding: 60px 0 !important;
  background-color: #fdfdfd;
}
.empty-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #bbb;
}
.empty-content svg {
  width: 48px;
  height: 48px;
  margin-bottom: 10px;
}
.empty-content p {
  margin: 0;
  font-size: 14px;
}
</style>
