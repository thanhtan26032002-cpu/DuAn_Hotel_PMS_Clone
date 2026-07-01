<template>
  <div class="booking-container">
    <div class="tabs-header">
      <div class="tab" :class="{ active: activeTab === 'Đăng Ký' }" @click="activeTab = 'Đăng Ký'">
        Đăng Ký
      </div>
      <div class="tab" :class="{ active: activeTab === 'Phòng' }" @click="activeTab = 'Phòng'">
        Phòng
      </div>
      <div class="tab" :class="{ active: activeTab === 'Khách' }" @click="activeTab = 'Khách'">
        Khách
      </div>
    </div>

    <div class="main-content">
      <div class="filter-bar">
        <div class="filter-left">
          <div class="toggle-group">
            <label class="toggle-switch">
              <input type="checkbox" />
              <span class="slider"></span>
            </label>
          </div>

          <div class="date-picker-group">
            <input
              type="text"
              class="input-date"
              value="24 / 06 / 2026 ~ 24 / 06 / 2026"
              readonly
            />
            <span class="calendar-icon">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="18"
                height="18"
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
            </span>
          </div>

          <select class="input-select w-120">
            <option>Total</option>
          </select>
        </div>

        <div class="filter-right">
          <div class="action-buttons">
            <button v-if="activeTab === 'Đăng Ký'" class="btn btn-disabled" disabled>
              Nhân bản
            </button>
            <button class="btn btn-primary">Tìm kiếm</button>
            <button class="btn btn-primary">Thao tác</button>
          </div>
          <div class="sub-filter">
            <select class="input-select w-100">
              <option>Tìm theo: 0</option>
            </select>
            <span class="filter-icon">
              <svg
                viewBox="0 0 24 24"
                width="16"
                height="16"
                stroke="currentColor"
                fill="none"
                stroke-width="2"
              >
                <path d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            </span>
          </div>
        </div>
      </div>

      <div v-if="activeTab === 'Đăng Ký'" class="table-responsive">
        <table class="data-table">
          <thead>
            <tr>
              <th class="w-40 center"><input type="checkbox" /></th>
              <th class="w-100">
                Mã BK
                <span class="sort-icon active">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="14"
                    height="14"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <path d="M6 9l6 6 6-6" />
                  </svg>
                </span>
              </th>
              <th class="w-120">Mã Tham Chiếu</th>
              <th class="w-200">Tên Đăng Ký</th>
              <th class="w-150">Công Ty</th>
              <th class="w-150">Thị Trường</th>
              <th class="w-100">Ngày Đến <span class="sort-icon">⇅</span></th>
              <th class="w-100">Ngày Đi <span class="sort-icon">⇅</span></th>
              <th class="w-60 center">Đêm <span class="sort-icon">⇅</span></th>
              <th class="w-200">LP Khởi Tạo</th>
              <th class="w-250">LP Thực Tế</th>
              <th class="w-100">Tổng</th>
              <th class="w-100">Đặt Cọc</th>
              <th class="w-140 center">Bảo đảm lưu trú</th>
              <th class="w-140 center">Trạng thái lưu trú</th>
              <th class="w-120">Liên hệ</th>
              <th class="w-250">Ghi Chú</th>
              <th class="w-120">Ngày Đăng Ký</th>
              <th class="w-100">Người Bán</th>
              <th class="w-100">Người Tạo</th>
            </tr>
          </thead>

          <tbody v-for="(row, index) in dangKyData" :key="'dk-' + index">
            <tr>
              <td class="center">
                <div class="td-flex">
                  <span
                    v-if="row.hasChildren"
                    class="expand-icon"
                    @click="row.isExpanded = !row.isExpanded"
                  >
                    {{ row.isExpanded ? '−' : '+' }}
                  </span>
                  <span v-else class="empty-icon"></span>

                  <input type="checkbox" />
                </div>
              </td>
              <td class="font-bold">{{ row.maBK }}</td>
              <td>{{ row.maThamChieu }}</td>
              <td>{{ row.tenDangKy }}</td>
              <td>{{ row.congTy }}</td>
              <td>{{ row.thiTruong }}</td>
              <td>{{ row.ngayDen }}</td>
              <td>{{ row.ngayDi }}</td>
              <td class="center">{{ row.dem }}</td>
              <td>{{ row.lpKhoiTao }}</td>
              <td>{{ row.lpThucTe }}</td>
              <td class="font-bold">{{ row.tong }}</td>
              <td>{{ row.datCoc }}</td>
              <td :class="getBaoDamClass(row.baoDam)">{{ row.baoDam }}</td>
              <td :class="getTrangThaiClass(row.trangThai)">{{ row.trangThai }}</td>
              <td>{{ row.lienHe }}</td>
              <td class="text-ellipsis" :title="row.ghiChu">{{ row.ghiChu }}</td>
              <td>{{ row.ngayDK }}</td>
              <td>{{ row.nguoiBan }}</td>
              <td>{{ row.nguoiTao }}</td>
            </tr>

            <tr v-if="row.isExpanded" class="expanded-row">
              <td colspan="20">
                <div class="sub-table-wrapper">
                  <table class="sub-table">
                    <thead>
                      <tr>
                        <th>Loại Phòng</th>
                        <th>#Phòng</th>
                        <th>#N.Lớn</th>
                        <th>#T.Em</th>
                        <th>Ngày Đến</th>
                        <th>Ngày Đi</th>
                        <th>Mã Giá Phòng</th>
                        <th>Giá Phòng</th>
                        <th>Tổng</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="(subRow, subIndex) in row.subData" :key="subIndex">
                        <td>{{ subRow.loaiPhong }}</td>
                        <td>{{ subRow.soPhong }}</td>
                        <td>{{ subRow.nguoiLon }}</td>
                        <td>{{ subRow.treEm }}</td>
                        <td>{{ subRow.ngayDen }}</td>
                        <td>{{ subRow.ngayDi }}</td>
                        <td>{{ subRow.maGiaPhong }}</td>
                        <td>{{ subRow.giaPhong }}</td>
                        <td>{{ subRow.tong }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </td>
            </tr>
          </tbody>

          <tbody>
            <tr class="footer-row">
              <td></td>
              <td colspan="19"><strong>Tổng: 5502</strong></td>
            </tr>
          </tbody>
        </table>
      </div>

      <div v-if="activeTab === 'Phòng'" class="table-responsive">
        <table class="data-table">
          <thead>
            <tr>
              <th class="w-40 center"><input type="checkbox" /></th>
              <th class="w-100">Phòng</th>
              <th class="w-150">Tình trạng phòng</th>
              <th class="w-120">Tên Khách</th>
              <th class="w-100">Ngày Đến</th>
              <th class="w-100">Ngày Đi</th>
              <th class="w-80 center">Số Đêm</th>
              <th class="w-100">Giá phòng</th>
              <th class="w-100">Mã Giá Phòng</th>
              <th class="w-100">Thêm Giường</th>
              <th class="w-100">Giá TG</th>
              <th class="w-80 center">Người Lớn</th>
              <th class="w-80 center">Trẻ Em</th>
              <th class="w-250">Ghi Chú</th>
              <th class="w-120">Tổng dịch Vụ</th>
              <th class="w-120">Thanh Toán</th>
              <th class="w-100">Giờ Đến</th>
              <th class="w-100">Giờ Đi</th>
              <th class="w-120">Ngày Đăng Ký</th>
            </tr>
          </thead>

          <tbody v-for="(group, index) in phongData" :key="'p-' + index">
            <tr class="group-header">
              <td class="center"><input type="checkbox" /></td>
              <td colspan="12">
                <div class="group-title-cell">
                  <span class="expand-icon" @click="group.isExpanded = !group.isExpanded">
                    {{ group.isExpanded ? '−' : '+' }}
                  </span>
                  <div class="group-info">
                    <div class="font-bold">{{ group.title }}</div>
                    <div class="text-note">{{ group.note }}</div>
                  </div>
                </div>
              </td>
              <td colspan="2" class="font-bold group-summary">
                Tiền dịch vụ: {{ group.tienDichVu }}
              </td>
              <td colspan="4" class="font-bold group-summary">
                Tiền đã thanh toán: {{ group.tienThanhToan }}
              </td>
            </tr>

            <template v-if="group.isExpanded">
              <tr v-for="(room, rIndex) in group.rooms" :key="rIndex" :class="room.rowClass">
                <td class="center"><input type="checkbox" v-model="room.selected" /></td>
                <td>{{ room.soPhong }}</td>
                <td>{{ room.tinhTrang }}</td>
                <td>{{ room.tenKhach }}</td>
                <td>{{ room.ngayDen }}</td>
                <td>{{ room.ngayDi }}</td>
                <td class="center">{{ room.soDem }}</td>
                <td>{{ room.giaPhong }}</td>
                <td>{{ room.maGiaPhong }}</td>
                <td class="center">{{ room.themGiuong }}</td>
                <td class="center">{{ room.giaTG }}</td>
                <td class="center">{{ room.nguoiLon }}</td>
                <td class="center">{{ room.treEm }}</td>
                <td class="white-space-normal">{{ room.ghiChu }}</td>
                <td>{{ room.tongDV }}</td>
                <td>{{ room.thanhToan }}</td>
                <td>{{ room.gioDen }}</td>
                <td>{{ room.gioDi }}</td>
                <td>{{ room.ngayDK }}</td>
              </tr>
            </template>
          </tbody>
          <tbody>
            <tr class="footer-row">
              <td></td>
              <td colspan="18"><strong>Tổng: 18934</strong></td>
            </tr>
          </tbody>
        </table>
      </div>

      <div v-if="activeTab === 'Khách'" class="table-responsive">
        <table class="data-table">
          <thead>
            <tr>
              <th class="w-40 center"><input type="checkbox" /></th>
              <th class="w-80">Đăng Ký</th>
              <th class="w-80">Phòng</th>
              <th class="w-150">Tên Khách</th>
              <th class="w-100">Ngày Đến</th>
              <th class="w-100">Ngày Đi</th>
              <th class="w-80 center">Số Đêm</th>
              <th class="w-100">Giá phòng</th>
              <th class="w-100">Mã Giá Phòng</th>
              <th class="w-150">Công Ty DL</th>
              <th class="w-120">Loại giấy tờ</th>
              <th class="w-120">Số Giấy Tờ</th>
              <th class="w-150">Email</th>
              <th class="w-120">SĐT</th>
              <th class="w-100">Ngày Sinh</th>
              <th class="w-80">Quốc Tịch</th>
              <th class="w-120">Tỉnh thành</th>
              <th class="w-150">Địa chỉ</th>
              <th class="w-100">Visa</th>
              <th class="w-120">Ngày Hết Hạn</th>
              <th class="w-120">Ngày Nhập Cảnh</th>
              <th class="w-120">Cửa Khẩu</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(guest, index) in khachData" :key="'k-' + index" class="guest-row">
              <td class="center"><input type="checkbox" /></td>
              <td>{{ guest.dangKy }}</td>
              <td>{{ guest.phong }}</td>
              <td>{{ guest.tenKhach }}</td>
              <td>{{ guest.ngayDen }}</td>
              <td>{{ guest.ngayDi }}</td>
              <td class="center">{{ guest.soDem }}</td>
              <td>{{ guest.giaPhong }}</td>
              <td>{{ guest.maGiaPhong }}</td>
              <td>{{ guest.congTyDL }}</td>
              <td>{{ guest.loaiGiayTo }}</td>
              <td>{{ guest.soGiayTo }}</td>
              <td>{{ guest.email }}</td>
              <td>{{ guest.sdt }}</td>
              <td>{{ guest.ngaySinh }}</td>
              <td>{{ guest.quocTich }}</td>
              <td>{{ guest.tinhThanh }}</td>
              <td>{{ guest.diaChi }}</td>
              <td>{{ guest.visa }}</td>
              <td>{{ guest.ngayHetHan }}</td>
              <td>{{ guest.ngayNhapCanh }}</td>
              <td>{{ guest.cuaKhau }}</td>
            </tr>
          </tbody>
          <tbody>
            <tr class="footer-row">
              <td></td>
              <td colspan="21"><strong>Tổng: 23214</strong></td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination-wrapper">
        <div class="pagination">
          <button class="page-btn disabled">&lt;</button>
          <button class="page-btn active">1</button>
          <button class="page-btn">2</button>
          <button class="page-btn">3</button>
          <button class="page-btn">4</button>
          <button class="page-btn">5</button>
          <span class="page-dots">...</span>
          <button class="page-btn" v-if="activeTab === 'Đăng Ký'">28</button>
          <button class="page-btn" v-else-if="activeTab === 'Phòng'">379</button>
          <button class="page-btn" v-else>465</button>
          <button class="page-btn">&gt;</button>
        </div>
        <select class="input-select page-size">
          <option v-if="activeTab === 'Đăng Ký'">200 / page</option>
          <option v-else>50 / page</option>
        </select>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

// Tab hiện tại mặc định khi tải trang
const activeTab = ref('Đăng Ký')

// --- HÀM ĐỔ MÀU CLASS CHO Ô TRẠNG THÁI (TAB ĐĂNG KÝ) ---
const getBaoDamClass = (val) => {
  if (val === 'None Guaranteed') return 'cell-none-guaranteed'
  if (val === 'Guaranteed') return 'cell-guaranteed'
  return ''
}

const getTrangThaiClass = (val) => {
  if (val === 'Checked in') return 'cell-checked-in'
  if (val === 'Reservation') return 'cell-reservation'
  if (val === 'Checked out') return 'cell-checked-out'
  if (val === 'Cancelled') return 'cell-cancelled'
  return ''
}

// --- DỮ LIỆU ĐẦY ĐỦ CHO TAB ĐĂNG KÝ (GAL1 -> GAL9) ---
const dangKyData = ref([
  {
    hasChildren: true,
    isExpanded: true,
    maBK: 'GAL1',
    maThamChieu: '',
    tenDangKy: 'Walkin Guest',
    congTy: 'KHÁCH LẺ',
    thiTruong: 'Free Individual Traveler',
    ngayDen: '04/04/2025',
    ngayDi: '04/04/2025',
    dem: 0,
    lpKhoiTao: 'DLXD (1)',
    lpThucTe: 'DLXD (1)',
    tong: '0',
    datCoc: '0',
    baoDam: 'None Guaranteed',
    trangThai: 'Checked in',
    lienHe: '',
    ghiChu: '',
    ngayDK: '04/04/2025',
    nguoiBan: 'Admin',
    nguoiTao: 'Admin',
    subData: [
      {
        loaiPhong: 'DLXD',
        soPhong: 1,
        nguoiLon: 2,
        treEm: 0,
        ngayDen: '04/04/2025',
        ngayDi: '04/04/2025',
        maGiaPhong: '',
        giaPhong: '0',
        tong: '0',
      },
    ],
  },
  {
    hasChildren: true,
    isExpanded: false,
    maBK: 'GAL2',
    maThamChieu: '',
    tenDangKy: 'Anh Kha',
    congTy: 'KHÁCH LẺ',
    thiTruong: 'Free Individual Traveler',
    ngayDen: '15/04/2025',
    ngayDi: '19/04/2025',
    dem: 4,
    lpKhoiTao: '',
    lpThucTe: '',
    tong: '0',
    datCoc: '0',
    baoDam: 'Guaranteed',
    trangThai: 'Reservation',
    lienHe: '',
    ghiChu: '(Cancel reason / Lý do hủy: .)',
    ngayDK: '15/04/2025',
    nguoiBan: 'Thảo Lê',
    nguoiTao: 'Thảo Lê',
    subData: [
      {
        loaiPhong: 'DLXD',
        soPhong: 0,
        nguoiLon: 0,
        treEm: 0,
        ngayDen: '04/04/2025',
        ngayDi: '04/04/2025',
        maGiaPhong: '',
        giaPhong: '0',
        tong: '0',
      },
    ],
  },
  {
    hasChildren: true,
    isExpanded: false,
    maBK: 'GAL3',
    maThamChieu: '',
    tenDangKy: 'NỘI BỘ CTY',
    congTy: 'KHÁCH LẺ',
    thiTruong: 'Free Individual Traveler',
    ngayDen: '15/04/2025',
    ngayDi: '19/04/2025',
    dem: 4,
    lpKhoiTao: 'DLXD (3), DLXDB (2)',
    lpThucTe: '(1), SUPT (1), DLXD (2), FAM (1)',
    tong: '0',
    datCoc: '0',
    baoDam: 'Guaranteed',
    trangThai: 'Checked in',
    lienHe: '',
    ghiChu: 'Khách khó tính',
    ngayDK: '15/04/2025',
    nguoiBan: 'Thảo Lê',
    nguoiTao: 'Thảo Lê',
    subData: [
      {
        loaiPhong: 'DLXD',
        soPhong: 0,
        nguoiLon: 0,
        treEm: 0,
        ngayDen: '04/04/2025',
        ngayDi: '04/04/2025',
        maGiaPhong: '',
        giaPhong: '0',
        tong: '0',
      },
    ],
  },
  {
    hasChildren: true,
    isExpanded: false,
    maBK: 'GAL4',
    maThamChieu: '',
    tenDangKy: 'nội bộ công ty',
    congTy: 'KHÁCH LẺ',
    thiTruong: 'Free Individual Traveler',
    ngayDen: '17/04/2025',
    ngayDi: '19/04/2025',
    dem: 2,
    lpKhoiTao: '(3), DLXD (21), DLXDB (11), FAM (1), JST (1)',
    lpThucTe: '(3), DLXD (21), DLXDB (11), FAM (1), JST (1)',
    tong: '0',
    datCoc: '0',
    baoDam: 'Guaranteed',
    trangThai: 'Checked in',
    lienHe: '',
    ghiChu: '',
    ngayDK: '17/04/2025',
    nguoiBan: 'Admin1',
    nguoiTao: 'Admin1',
    subData: [
      {
        loaiPhong: 'DLXD',
        soPhong: 0,
        nguoiLon: 0,
        treEm: 0,
        ngayDen: '04/04/2025',
        ngayDi: '04/04/2025',
        maGiaPhong: '',
        giaPhong: '0',
        tong: '0',
      },
    ],
  },
  {
    hasChildren: true,
    isExpanded: false,
    maBK: 'GAL5',
    maThamChieu: '',
    tenDangKy: 'nội bộ kĩ thuật - anh AN',
    congTy: 'KHÁCH LẺ',
    thiTruong: 'Free Individual Traveler',
    ngayDen: '17/04/2025',
    ngayDi: '19/04/2025',
    dem: 2,
    lpKhoiTao: '(1)',
    lpThucTe: '(1)',
    tong: '0',
    datCoc: '0',
    baoDam: 'Guaranteed',
    trangThai: 'Checked in',
    lienHe: '',
    ghiChu: '',
    ngayDK: '17/04/2025',
    nguoiBan: 'Admin1',
    nguoiTao: 'Admin1',
    subData: [
      {
        loaiPhong: 'DLXD',
        soPhong: 0,
        nguoiLon: 0,
        treEm: 0,
        ngayDen: '04/04/2025',
        ngayDi: '04/04/2025',
        maGiaPhong: '',
        giaPhong: '0',
        tong: '0',
      },
    ],
  },
  {
    hasChildren: true,
    isExpanded: false,
    maBK: 'GAL6',
    maThamChieu: '',
    tenDangKy: 'Nguyễn Văn Sơn',
    congTy: 'KHÁCH LẺ',
    thiTruong: 'Free Individual Traveler',
    ngayDen: '18/04/2025',
    ngayDi: '20/04/2025',
    dem: 2,
    lpKhoiTao: 'DLXDB (2)',
    lpThucTe: 'DLXDB (2)',
    tong: '2,600,000',
    datCoc: '0',
    baoDam: 'Guaranteed',
    trangThai: 'Checked in',
    lienHe: '0984839883',
    ghiChu: '',
    ngayDK: '18/04/2025',
    nguoiBan: 'Admin1',
    nguoiTao: 'Admin1',
    subData: [
      {
        loaiPhong: 'DLXD',
        soPhong: 0,
        nguoiLon: 0,
        treEm: 0,
        ngayDen: '04/04/2025',
        ngayDi: '04/04/2025',
        maGiaPhong: '',
        giaPhong: '0',
        tong: '0',
      },
    ],
  },
  {
    hasChildren: true,
    isExpanded: false,
    maBK: 'GAL7',
    maThamChieu: '',
    tenDangKy: 'DU LỊCH HẢI YẾN - HÀ NỘI',
    congTy: 'DU LỊCH HẢI YẾN HN',
    thiTruong: 'Travel Agent',
    ngayDen: '29/04/2025',
    ngayDi: '03/05/2025',
    dem: 4,
    lpKhoiTao: '(1), DLXD (1), DLXT (1), DLXDB (3)',
    lpThucTe: '(1), DLXD (1), DLXT (1), DLXDB (3)',
    tong: '12,300,000',
    datCoc: '3,500,000',
    baoDam: 'Guaranteed',
    trangThai: 'Checked in',
    lienHe: '0915768835',
    ghiChu: '',
    ngayDK: '18/04/2025',
    nguoiBan: 'NB0007',
    nguoiTao: 'Thảo Lê',
    subData: [
      {
        loaiPhong: 'DLXD',
        soPhong: 0,
        nguoiLon: 0,
        treEm: 0,
        ngayDen: '04/04/2025',
        ngayDi: '04/04/2025',
        maGiaPhong: '',
        giaPhong: '0',
        tong: '0',
      },
    ],
  },
  {
    hasChildren: true,
    isExpanded: false,
    maBK: 'GAL8',
    maThamChieu: '',
    tenDangKy: 'MAI THỊ XUÂN HƯƠNG',
    congTy: 'KHÁCH LẺ',
    thiTruong: 'Free Individual Traveler',
    ngayDen: '19/04/2025',
    ngayDi: '20/04/2025',
    dem: 1,
    lpKhoiTao: 'DLXD (1)',
    lpThucTe: 'DLXD (1)',
    tong: '495,000',
    datCoc: '0',
    baoDam: 'Guaranteed',
    trangThai: 'Checked out',
    lienHe: '',
    ghiChu: '',
    ngayDK: '19/04/2025',
    nguoiBan: 'Admin1',
    nguoiTao: 'Admin1',
    subData: [
      {
        loaiPhong: 'DLXD',
        soPhong: 0,
        nguoiLon: 0,
        treEm: 0,
        ngayDen: '04/04/2025',
        ngayDi: '04/04/2025',
        maGiaPhong: '',
        giaPhong: '0',
        tong: '0',
      },
    ],
  },
  {
    hasChildren: true,
    isExpanded: false,
    maBK: 'GAL9',
    maThamChieu: '',
    tenDangKy: 'nội bộ công ty ( a THẮNG )',
    congTy: 'KHÁCH LẺ',
    thiTruong: 'Free Individual Traveler',
    ngayDen: '19/04/2025',
    ngayDi: '20/04/2025',
    dem: 1,
    lpKhoiTao: '',
    lpThucTe: '',
    tong: '0',
    datCoc: '0',
    baoDam: 'Guaranteed',
    trangThai: 'Cancelled',
    lienHe: '',
    ghiChu: '(Cancel reason / Lý do hủy: .)',
    ngayDK: '19/04/2025',
    nguoiBan: 'Admin1',
    nguoiTao: 'Admin1',
    subData: [
      {
        loaiPhong: 'DLXD',
        soPhong: 0,
        nguoiLon: 0,
        treEm: 0,
        ngayDen: '04/04/2025',
        ngayDi: '04/04/2025',
        maGiaPhong: '',
        giaPhong: '0',
        tong: '0',
      },
    ],
  },
])

// --- DỮ LIỆU ĐẦY ĐỦ CHO TAB PHÒNG (CÁC KHỐI BOOKING GỘP) ---
const phongData = ref([
  {
    isExpanded: true,
    title:
      'Booking GAL1934: LOCK TẠM GIỮ PHÒNG CHO ANH KHÔI _ 01/01/2026~06/01/2026 _ Room Night: 5',
    note: 'Ghi chú: GIỮ PHÒNG 100 PHÒNG (ROH), THÔNG TIN CẬP NHẬT SAU (Cancel reason / Lý do hủy: HUYR)',
    tienDichVu: '0',
    tienThanhToan: '0',
    rooms: [
      {
        selected: true,
        soPhong: '',
        tinhTrang: 'Phòng hủy',
        tenKhach: 'Guest 1',
        ngayDen: '01/01/2026',
        ngayDi: '06/01/2026',
        soDem: 5,
        giaPhong: '0',
        maGiaPhong: '',
        themGiuong: '0',
        giaTG: '0',
        nguoiLon: 2,
        treEm: 0,
        ghiChu: 'Tiền dịch vụ: 0',
        tongDV: '0',
        thanhToan: '0',
        gioDen: '14:00',
        gioDi: '12:00',
        ngayDK: '02/12/2025',
        rowClass: 'bg-canceled',
      },
    ],
  },
  {
    isExpanded: true,
    title: 'Booking GAL667: NEST & LEE TRAVEL / MS GIANG _ 07/08/2025~08/08/2025 _ Room Night: 1',
    note: 'Ghi chú: TÊN ĐOÀN : NHA TRANG SUN / ĐOÀN ANH VŨ Cơ cấu : 5p2 (3 king + 2 twin) + 2p3 + 4p4 + 1 phòng nội bộ)) 5P2 * 500k/r/n - thu hộ 520k 2p3 * 700k/r/n - thu hộ 770k 4p4 * 900k/r/n - thu hộ 1.000k 1P2 NỘI BỘ * 350K/R/N THU TỪ MR VŨ 4,450K, CÒN LẠI 3,400K MS GIANG/ NEST & LEE thanh toán',
    tienDichVu: '7,500,000',
    tienThanhToan: '7,500,000',
    rooms: [
      {
        selected: false,
        soPhong: '509',
        tinhTrang: 'Phòng đã trả',
        tenKhach: 'Guest 1',
        ngayDen: '07/08/2025',
        ngayDi: '08/08/2025',
        soDem: 1,
        giaPhong: '900,000',
        maGiaPhong: '',
        themGiuong: '0',
        giaTG: '0',
        nguoiLon: 4,
        treEm: 0,
        ghiChu: 'Tiền dịch vụ: 7,500,000',
        tongDV: '0',
        thanhToan: '0',
        gioDen: '13:17',
        gioDi: '10:08',
        ngayDK: '09/07/2025',
        rowClass: 'bg-checkout',
      },
    ],
  },
  {
    isExpanded: true,
    title:
      'Booking GAL1133: Ngân Nguyễn thị / Booking.com - 6684707409 _ 16/08/2025~17/08/2025 _ Room Night: 1',
    note: 'Ghi chú: This guest would like the rooms in this booking to be close together if possible. Phòng Superior 3 Người - General - Breakfast included: 2 adults and 2 children (age 0) Phòng Superior 3 Người - General - Breakfast included: 2 adults and 1 child (age 0) Superior Triple Room - BAR',
    tienDichVu: '1,480,000',
    tienThanhToan: '1,480,000',
    rooms: [
      {
        selected: false,
        soPhong: '410',
        tinhTrang: 'Phòng đã trả',
        tenKhach: 'Guest 1',
        ngayDen: '16/08/2025',
        ngayDi: '17/08/2025',
        soDem: 1,
        giaPhong: '740,000',
        maGiaPhong: 'ST',
        themGiuong: '0',
        giaTG: '0',
        nguoiLon: 2,
        treEm: 2,
        ghiChu: 'Tiền dịch vụ: 1,480,000',
        tongDV: '0',
        thanhToan: '0',
        gioDen: '21:59',
        gioDi: '10:50',
        ngayDK: '16/08/2025',
        rowClass: 'bg-checkout',
      },
    ],
  },
  {
    isExpanded: false,
    title: 'Booking GAL695: DL QUỐC TẾ VĨNH LONG/ MR PHONG _ 17/07/2025~18/07/2025 _ Room Night: 1',
    note: 'Ghi chú: Đơn đặt hàng từ công ty đối tác du lịch lữ hành.',
    tienDichVu: '0',
    tienThanhToan: '0',
    rooms: [],
  },
])

// --- DỮ LIỆU TAB KHÁCH (GIỮ NGUYÊN HOÀN CHỈNH) ---
const khachData = ref([
  {
    dangKy: 'GAL1',
    phong: '401',
    tenKhach: 'Mr. Guest 1',
    ngayDen: '04/04/2025',
    ngayDi: '04/04/2025',
    soDem: 0,
    giaPhong: '0',
    maGiaPhong: '',
    congTyDL: 'KHÁCH LẺ',
    loaiGiayTo: '',
    soGiayTo: '',
    email: '',
    sdt: '',
    ngaySinh: '',
    quocTich: 'VNM',
    tinhThanh: '',
    diaChi: '',
    visa: '',
    ngayHetHan: '',
    ngayNhapCanh: '',
    cuaKhau: '',
  },
  {
    dangKy: 'GAL1',
    phong: '401',
    tenKhach: 'Mr. Guest 2',
    ngayDen: '04/04/2025',
    ngayDi: '04/04/2025',
    soDem: 0,
    giaPhong: '0',
    maGiaPhong: '',
    congTyDL: 'KHÁCH LẺ',
    loaiGiayTo: '',
    soGiayTo: '',
    email: '',
    sdt: '',
    ngaySinh: '',
    quocTich: 'VNM',
    tinhThanh: '',
    diaChi: '',
    visa: '',
    ngayHetHan: '',
    ngayNhapCanh: '',
    cuaKhau: '',
  },
  {
    dangKy: 'GAL3',
    phong: '1411',
    tenKhach: 'Mr. Guest 1',
    ngayDen: '15/04/2025',
    ngayDi: '19/04/2025',
    soDem: 4,
    giaPhong: '0',
    maGiaPhong: 'FOC',
    congTyDL: 'KHÁCH LẺ',
    loaiGiayTo: '',
    soGiayTo: '',
    email: '',
    sdt: '',
    ngaySinh: '',
    quocTich: 'VNM',
    tinhThanh: '',
    diaChi: '',
    visa: '',
    ngayHetHan: '',
    ngayNhapCanh: '',
    cuaKhau: '',
  },
  {
    dangKy: 'GAL3',
    phong: '1411',
    tenKhach: 'Mr. Guest 2',
    ngayDen: '15/04/2025',
    ngayDi: '19/04/2025',
    soDem: 4,
    giaPhong: '0',
    maGiaPhong: 'FOC',
    congTyDL: 'KHÁCH LẺ',
    loaiGiayTo: '',
    soGiayTo: '',
    email: '',
    sdt: '',
    ngaySinh: '',
    quocTich: 'VNM',
    tinhThanh: '',
    diaChi: '',
    visa: '',
    ngayHetHan: '',
    ngayNhapCanh: '',
    cuaKhau: '',
  },
  {
    dangKy: 'GAL3',
    phong: '701',
    tenKhach: 'Mr. Guest 1',
    ngayDen: '15/04/2025',
    ngayDi: '17/04/2025',
    soDem: 2,
    giaPhong: '0',
    maGiaPhong: '',
    congTyDL: 'KHÁCH LẺ',
    loaiGiayTo: '',
    soGiayTo: '',
    email: '',
    sdt: '',
    ngaySinh: '',
    quocTich: 'VNM',
    tinhThanh: '',
    diaChi: '',
    visa: '',
    ngayHetHan: '',
    ngayNhapCanh: '',
    cuaKhau: '',
  },
])
</script>

<style scoped>
/* --- Khung Cơ Bản --- */
.booking-container {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  font-size: 13px;
  color: #333;
  background: #fff;
  min-height: 100vh;
}

/* --- Tabs Switching --- */
.tabs-header {
  display: flex;
  padding: 0 16px;
  border-bottom: 2px solid #e0f2fe;
  background: #fff;
}
.tab {
  padding: 12px 24px;
  cursor: pointer;
  font-weight: 500;
  color: #555;
  position: relative;
}
.tab.active {
  color: #38bdf8;
  font-weight: bold;
}
.tab.active::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 100%;
  height: 2px;
  background-color: #38bdf8;
}

/* --- Main content --- */
.main-content {
  padding: 16px;
  background-color: #fafbfc;
}

/* --- Thanh Lọc Filter Bar --- */
.filter-bar {
  display: flex;
  justify-content: space-between;
  background: #fff;
  padding: 12px;
  border: 1px solid #e2e8f0;
  border-radius: 6px;
  margin-bottom: 16px;
}
.filter-left {
  display: flex;
  align-items: center;
  gap: 16px;
}
/* --- CẤU TRÚC THANH TOGGLE TÌM THEO NGÀY --- */
.toggle-group {
  display: flex;
  align-items: center;
}

.toggle-switch {
  position: relative;
  display: inline-block;
  width: 125px; /* Chiều rộng tối ưu để chứa vừa chữ "Tìm theo ngày" */
  height: 26px;
}

/* Ẩn check-box mặc định */
.toggle-switch input {
  opacity: 0;
  width: 0;
  height: 0;
}

/* Rãnh trượt của nút */
.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  transition: 0.4s;
  border-radius: 26px;
}

/* Cục tròn di chuyển */
.slider:before {
  position: absolute;
  content: '';
  height: 20px;
  width: 20px;
  left: 3px;
  bottom: 3px;
  background-color: white;
  border-radius: 50%;
  transition: 0.4s;
  z-index: 2;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
}

/* Hiển thị chữ "Tìm theo ngày" bên trong lòng nút gạt */
.slider:after {
  content: 'Tìm theo ngày';
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  color: black;
  font-size: 11px;
  font-weight: bold;
  z-index: 1;
  transition: 0.4s;

  /* Trạng thái TẮT: Cục tròn ở TRÁI -> Chữ dồn sang PHẢI */
  right: 12px;
}

/* --- TRẠNG THÁI BẬT (CHECKED) --- */

/* 1. Nền chuyển sang màu xanh dương công nghệ */
.toggle-switch input:checked + .slider {
  background-color: #7dd3fc;
}

/* 2. Đẩy cục tròn di chuyển sang bên phải cực mượt */
.toggle-switch input:checked + .slider:before {
  transform: translateX(99px); /* Khoảng cách trượt: 125px (tổng) - 20px (cục tròn) - 6px (lề) */
}

/* 3. Đẩy chữ "Tìm theo ngày" né sang lề bên trái */
.toggle-switch input:checked + .slider:after {
  right: auto;
  left: 12px;
  color: white;
}
.date-picker-group {
  position: relative;
  display: flex;
  align-items: center;
}
.input-date {
  border: 1px solid #cbd5e1;
  border-radius: 4px;
  padding: 6px 30px 6px 12px;
  width: 220px;
  color: #64748b;
  outline: none;
}
.calendar-icon {
  position: absolute;
  right: 10px;
  opacity: 0.5;
}
.input-select {
  border: 1px solid #cbd5e1;
  border-radius: 4px;
  padding: 6px 12px;
  outline: none;
  background-color: #fff;
}

/* --- Buttons --- */
.filter-right {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 8px;
}
.action-buttons {
  display: flex;
  gap: 8px;
}
.btn {
  border: none;
  border-radius: 4px;
  padding: 6px 16px;
  font-weight: 500;
  cursor: pointer;
  color: #fff;
}
.btn-primary {
  background-color: #7dd3fc;
}
.btn-disabled {
  background-color: #cbd5e1;
  cursor: not-allowed;
}
.sub-filter {
  display: flex;
  align-items: center;
  gap: 8px;
}

/* --- Table Grid (Hỗ trợ cuộn ngang mượt mà) --- */
.table-responsive {
  width: 100%;
  overflow-x: auto;
  border: 1px solid #e2e8f0;
  border-radius: 4px;
  background: #fff;
}
.table-responsive::-webkit-scrollbar {
  height: 10px;
}
.table-responsive::-webkit-scrollbar-track {
  background: #f1f5f9;
}
.table-responsive::-webkit-scrollbar-thumb {
  background-color: #cbd5e1;
  border-radius: 6px;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  white-space: nowrap;
}
.data-table th,
.data-table td {
  padding: 8px 12px;
  border-bottom: 1px solid #e2e8f0;
  border-right: 1px solid #e2e8f0;
  text-align: left;
}
.data-table th {
  background-color: #f8fafc;
  font-weight: 600;
  color: #334155;
}

/* --- CSS ĐỔ MÀU NỀN Ô ĐẶC THÙ (THEO HÌNH ẢNH MẪU) --- */
.cell-none-guaranteed {
  background-color: #263238 !important;
  color: #ffffff !important;
  text-align: center;
}
.cell-guaranteed {
  background-color: #4ade80 !important;
  color: #000000 !important;
  text-align: center;
  font-weight: 500;
}
.cell-checked-in {
  background-color: #4ade80 !important;
  color: #000000 !important;
  text-align: center;
  font-weight: 500;
}
.cell-reservation {
  background-color: #ffffff !important;
  color: #333333 !important;
  text-align: center;
}
.cell-checked-out {
  background-color: #cbd5e1 !important;
  color: #333333 !important;
  text-align: center;
}
.cell-cancelled {
  background-color: #fca5a5 !important;
  color: #7f1d1d !important;
  text-align: center;
}

/* Trạng thái phòng lồng nhau tab phòng */
.bg-canceled {
  background-color: #e5a5a5 !important;
}
.bg-checkout {
  background-color: #d1d5db !important;
}

/* Style hàng phẳng Tab Khách */
.guest-row td {
  background-color: #e5e7eb;
  color: #333;
}

/* --- Cấu Trúc Khác --- */
.td-flex {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
.expand-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 16px;
  height: 16px;
  background-color: #7dd3fc;
  color: white;
  font-weight: bold;
  font-size: 14px;
  cursor: pointer;
  border-radius: 2px;
}
.empty-icon {
  width: 16px;
  height: 16px;
}
.sub-table-wrapper {
  padding: 12px 0 12px 120px;
  background-color: #f8fafc;
}
.sub-table {
  border-collapse: collapse;
  border: 1px solid #e2e8f0;
  background: #fff;
}
.sub-table th,
.sub-table td {
  padding: 6px 12px;
  border: 1px solid #e2e8f0;
}

.group-header {
  background-color: #fff;
}
.group-title-cell {
  display: flex;
  align-items: flex-start;
  gap: 12px;
}
.group-info {
  white-space: normal;
  line-height: 1.5;
}
.text-note {
  color: #475569;
  font-size: 12px;
  margin-top: 4px;
}
.group-summary {
  vertical-align: top;
  padding-top: 12px !important;
  color: #000;
}
.footer-row td {
  background-color: #f8fafc;
  border-top: 2px solid #cbd5e1;
  padding: 12px;
}

/* --- Phân Trang --- */
.pagination-wrapper {
  display: flex;
  justify-content: flex-end;
  align-items: center;
  gap: 16px;
  margin-top: 16px;
}
.pagination {
  display: flex;
  gap: 4px;
}
.page-btn {
  background: #fff;
  border: 1px solid #cbd5e1;
  border-radius: 4px;
  min-width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}
.page-btn.active {
  border-color: #333;
  font-weight: bold;
  background: #f1f5f9;
}
.page-btn.disabled {
  color: #cbd5e1;
  cursor: not-allowed;
}
.page-dots {
  padding: 0 4px;
  display: flex;
  align-items: center;
}

/* Trợ giúp định dạng văn bản quá dài */
.text-ellipsis {
  max-width: 180px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.white-space-normal {
  white-space: normal !important;
}

/* Kích Thước Cột */
.w-40 {
  min-width: 40px;
}
.w-60 {
  min-width: 60px;
}
.w-80 {
  min-width: 80px;
}
.w-100 {
  min-width: 100px;
}
.w-120 {
  min-width: 120px;
}
.w-140 {
  min-width: 140px;
}
.w-150 {
  min-width: 150px;
}
.w-200 {
  min-width: 200px;
}
.w-250 {
  min-width: 250px;
}
.center {
  text-align: center;
}
.font-bold {
  font-weight: bold;
}
</style>
