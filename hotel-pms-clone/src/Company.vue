<template>
  <div class="app-container">
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

    <div v-if="currentTab === 'CÔNG TY'" class="tab-content">
      <div class="toolbar">
        <div class="left-actions">
          <button class="btn btn-cyan">
            <svg
              class="icon"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2.5"
              stroke-linecap="round"
              stroke-linejoin="round"
              style="width: 10px; height: 10px; margin-right: 4px"
            >
              <line x1="12" y1="5" x2="12" y2="19"></line>
              <line x1="5" y1="12" x2="19" y2="12"></line>
            </svg>
            Thêm
          </button>
          <button class="btn btn-cyan">Đồng bộ</button>
          <button class="btn btn-blue">
            <svg
              class="btn-icon"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
              <polyline points="14 2 14 8 20 8"></polyline>
              <line x1="8" y1="13" x2="16" y2="13"></line>
              <line x1="8" y1="17" x2="16" y2="17"></line>
              <polyline points="10 9 9 9 8 9"></polyline>
            </svg>
            Xuất excel
          </button>
          <button class="btn btn-blue">
            <svg
              class="btn-icon"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
              <polyline points="14 2 14 8 20 8"></polyline>
              <line x1="12" y1="12" x2="12" y2="18"></line>
              <polyline points="9 15 12 18 15 15"></polyline>
            </svg>
            Nhập excel
          </button>
        </div>
        <div class="right-actions">
          <button class="icon-btn">
            <svg
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
            </svg>
          </button>
          <button class="icon-btn btn-help">
            <svg
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <circle cx="12" cy="12" r="10"></circle>
              <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
              <line x1="12" y1="17" x2="12.01" y2="17"></line>
            </svg>
          </button>
        </div>
      </div>

      <div class="table-wrapper company-table-wrapper">
        <table>
          <thead>
            <tr>
              <th class="col-ma">Mã <span class="sort-icon">↕</span></th>
              <th class="col-ten">
                Tên
                <svg
                  class="search-icon"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#999"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
              </th>
              <th class="col-tengd">Tên giao dịch <span class="sort-icon">↕</span></th>
              <th class="col-diachi">Địa chỉ</th>
              <th>Tax</th>
              <th>Số điện thoại</th>
              <th>Email</th>
              <th>
                Nguồn khách
                <svg class="filter-icon" viewBox="0 0 24 24" fill="#ccc">
                  <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                </svg>
              </th>
              <th>
                Thị trường
                <svg class="filter-icon" viewBox="0 0 24 24" fill="#ccc">
                  <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                </svg>
              </th>
              <th>
                Loại
                <svg class="filter-icon" viewBox="0 0 24 24" fill="#ccc">
                  <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                </svg>
              </th>
              <th class="text-center">Đồng bộ ACC</th>
              <th>Công nợ tối đa</th>
              <th>Tài khoản ngân hàng</th>
              <th>
                Người đặt phòng
                <svg class="filter-icon" viewBox="0 0 24 24" fill="#ccc">
                  <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                </svg>
              </th>
              <th>Mã giá phòng</th>
              <th>Lĩnh vực KD</th>
              <th>
                Chi nhánh
                <svg class="filter-icon" viewBox="0 0 24 24" fill="#ccc">
                  <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                </svg>
              </th>
              <th class="text-center">Xóa</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in companyData" :key="index">
              <td>{{ item.ma }}</td>
              <td>{{ item.ten }}</td>
              <td>{{ item.tenGiaoDich }}</td>
              <td>{{ item.diaChi }}</td>
              <td>{{ item.tax }}</td>
              <td>{{ item.sdt }}</td>
              <td>{{ item.email }}</td>
              <td>
                <div v-for="nk in item.nguonKhach" :key="nk">{{ nk }}</div>
              </td>
              <td>
                <div v-for="tt in item.thiTruong" :key="tt">{{ tt }}</div>
              </td>
              <td>{{ item.loai }}</td>
              <td class="text-center">
                <label class="switch">
                  <input type="checkbox" v-model="item.dongBoACC" />
                  <span class="slider round"></span>
                </label>
              </td>
              <td>{{ item.congNoToiDa }}</td>
              <td>{{ item.tkNganHang }}</td>
              <td>{{ item.nguoiDatPhong }}</td>
              <td>{{ item.maGiaPhong }}</td>
              <td>{{ item.linhVucKD }}</td>
              <td>{{ item.chiNhanh }}</td>
              <td class="text-center">
                <button class="btn-delete" title="Xóa">
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <polyline points="3 6 5 6 21 6"></polyline>
                    <path
                      d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                    ></path>
                    <line x1="10" y1="11" x2="10" y2="17"></line>
                    <line x1="14" y1="11" x2="14" y2="17"></line>
                  </svg>
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination-section">
        <div class="pagination">
          <span class="page-arrow disabled">&lt;</span>
          <span class="page-number active">1</span>
          <span class="page-number">2</span>
          <span class="page-number">3</span>
          <span class="page-arrow">&gt;</span>
          <select class="page-size" v-model="pageSize">
            <option value="100">100 / page</option>
            <option value="50">50 / page</option>
            <option value="20">20 / page</option>
          </select>
        </div>
      </div>
    </div>

    <div v-else-if="currentTab === 'THỊ TRƯỜNG'" class="tab-content narrow-content">
      <div class="toolbar">
        <div class="left-actions">
          <button class="btn btn-cyan">
            <svg
              class="icon"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2.5"
              stroke-linecap="round"
              stroke-linejoin="round"
              style="width: 10px; height: 10px; margin-right: 4px"
            >
              <line x1="12" y1="5" x2="12" y2="19"></line>
              <line x1="5" y1="12" x2="19" y2="12"></line>
            </svg>
            Thêm
          </button>
        </div>
        <div class="right-actions">
          <button class="icon-btn btn-help">
            <svg
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <circle cx="12" cy="12" r="10"></circle>
              <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
              <line x1="12" y1="17" x2="12.01" y2="17"></line>
            </svg>
          </button>
        </div>
      </div>

      <div class="narrow-table-container">
        <div class="table-wrapper narrow-table-wrapper">
          <table>
            <thead>
              <tr>
                <th class="col-id">
                  Mã<svg
                    class="search-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="#ccc"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                  </svg>
                </th>
                <th class="col-code">
                  Mã<svg
                    class="search-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="#ccc"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                  </svg>
                </th>
                <th class="col-name">
                  Tên<svg
                    class="search-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="#ccc"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                  </svg>
                </th>
                <th class="col-action">Hành động</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in thiTruongData" :key="index">
                <td>{{ item.id }}</td>
                <td>{{ item.ma }}</td>
                <td>{{ item.ten }}</td>
                <td>
                  <button class="btn-delete" title="Xóa">
                    <svg
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    >
                      <polyline points="3 6 5 6 21 6"></polyline>
                      <path
                        d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                      ></path>
                      <line x1="10" y1="11" x2="10" y2="17"></line>
                      <line x1="14" y1="11" x2="14" y2="17"></line>
                    </svg>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="narrow-pagination-section">
          <div class="pagination">
            <span class="page-arrow disabled">&lt;</span>
            <span class="page-number active">1</span>
            <span class="page-arrow disabled">&gt;</span>
          </div>
        </div>
      </div>
    </div>

    <div v-else-if="currentTab === 'NGUỒN KHÁCH'" class="tab-content narrow-content">
      <div class="toolbar">
        <div class="left-actions">
          <button class="btn btn-cyan">
            <svg
              class="icon"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2.5"
              stroke-linecap="round"
              stroke-linejoin="round"
              style="width: 10px; height: 10px; margin-right: 4px"
            >
              <line x1="12" y1="5" x2="12" y2="19"></line>
              <line x1="5" y1="12" x2="19" y2="12"></line>
            </svg>
            Thêm
          </button>
        </div>
      </div>

      <div class="narrow-table-container">
        <div class="table-wrapper narrow-table-wrapper">
          <table>
            <thead>
              <tr>
                <th class="col-id">
                  Mã<svg
                    class="search-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="#ccc"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                  </svg>
                </th>
                <th class="col-code">
                  Mã<svg
                    class="search-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="#ccc"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                  </svg>
                </th>
                <th class="col-name">
                  Tên<svg
                    class="search-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="#ccc"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                  </svg>
                </th>
                <th class="col-action">Hành động</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in nguonKhachData" :key="index">
                <td>{{ item.id }}</td>
                <td>{{ item.ma }}</td>
                <td>{{ item.ten }}</td>
                <td>
                  <button class="btn-delete" title="Xóa">
                    <svg
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    >
                      <polyline points="3 6 5 6 21 6"></polyline>
                      <path
                        d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                      ></path>
                      <line x1="10" y1="11" x2="10" y2="17"></line>
                      <line x1="14" y1="11" x2="14" y2="17"></line>
                    </svg>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="narrow-pagination-section">
          <div class="pagination">
            <span class="page-arrow disabled">&lt;</span>
            <span class="page-number active">1</span>
            <span class="page-arrow disabled">&gt;</span>
          </div>
        </div>
      </div>
    </div>

    <div v-else-if="currentTab === 'CHI NHÁNH'" class="tab-content narrow-content">
      <div class="toolbar">
        <div class="left-actions">
          <button class="btn btn-cyan">
            <svg
              class="icon"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2.5"
              stroke-linecap="round"
              stroke-linejoin="round"
              style="width: 10px; height: 10px; margin-right: 4px"
            >
              <line x1="12" y1="5" x2="12" y2="19"></line>
              <line x1="5" y1="12" x2="19" y2="12"></line>
            </svg>
            Thêm
          </button>
        </div>
      </div>

      <div class="narrow-table-container">
        <div class="table-wrapper narrow-table-wrapper">
          <table>
            <thead>
              <tr>
                <th class="col-id-cn">
                  Mã<svg
                    class="search-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="#ccc"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                  </svg>
                </th>
                <th class="col-name-cn">
                  Tên<svg
                    class="search-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="#ccc"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                  </svg>
                </th>
                <th class="col-action">Hành động</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in chiNhanhData" :key="index">
                <td>{{ item.id }}</td>
                <td>{{ item.ten }}</td>
                <td>
                  <button class="btn-delete" title="Xóa">
                    <svg
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    >
                      <polyline points="3 6 5 6 21 6"></polyline>
                      <path
                        d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                      ></path>
                      <line x1="10" y1="11" x2="10" y2="17"></line>
                      <line x1="14" y1="11" x2="14" y2="17"></line>
                    </svg>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="narrow-pagination-section">
          <div class="pagination">
            <span class="page-arrow disabled">&lt;</span>
            <span class="page-number active">1</span>
            <span class="page-number">2</span>
            <span class="page-arrow">&gt;</span>
          </div>
        </div>
      </div>
    </div>

    <div v-else-if="currentTab === 'NGƯỜI ĐẶT PHÒNG'" class="tab-content">
      <div class="toolbar">
        <div class="left-actions">
          <button class="btn btn-cyan">
            <svg
              class="icon"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2.5"
              stroke-linecap="round"
              stroke-linejoin="round"
              style="width: 10px; height: 10px; margin-right: 4px"
            >
              <line x1="12" y1="5" x2="12" y2="19"></line>
              <line x1="5" y1="12" x2="19" y2="12"></line>
            </svg>
            Thêm
          </button>
        </div>
      </div>

      <div class="table-wrapper fit-content-table">
        <table>
          <thead>
            <tr>
              <th class="col-15">
                Mã người đặt phòng
                <svg
                  class="search-icon"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#ccc"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
              </th>
              <th class="col-25">
                Tên người đặt phòng
                <svg
                  class="search-icon"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#ccc"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
              </th>
              <th class="col-15">Email</th>
              <th class="col-15">Số Điện thoại</th>
              <th class="col-15">Địa chỉ</th>
              <th class="col-15">Ghi chú</th>
              <th class="col-15 text-center">Hành động</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in nguoiDatPhongData" :key="index">
              <td>{{ item.ma }}</td>
              <td>{{ item.ten }}</td>
              <td>{{ item.email }}</td>
              <td>{{ item.sdt }}</td>
              <td>{{ item.diaChi }}</td>
              <td>{{ item.mst }}</td>
              <td class="text-center">
                <button class="btn-delete" title="Xóa">
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <polyline points="3 6 5 6 21 6"></polyline>
                    <path
                      d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                    ></path>
                    <line x1="10" y1="11" x2="10" y2="17"></line>
                    <line x1="14" y1="11" x2="14" y2="17"></line>
                  </svg>
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination-section">
        <div class="pagination">
          <span class="page-arrow disabled">&lt;</span>
          <span class="page-number active">1</span>
          <span class="page-arrow disabled">&gt;</span>
        </div>
      </div>
    </div>

    <div v-else-if="currentTab === 'CÔNG TY THÀNH VIÊN'" class="tab-content">
      <div class="toolbar">
        <div class="left-actions">
          <button class="btn btn-cyan">
            <svg
              class="icon"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2.5"
              stroke-linecap="round"
              stroke-linejoin="round"
              style="width: 10px; height: 10px; margin-right: 4px"
            >
              <line x1="12" y1="5" x2="12" y2="19"></line>
              <line x1="5" y1="12" x2="19" y2="12"></line>
            </svg>
            Thêm
          </button>
        </div>
      </div>

      <div class="table-wrapper cong-ty-tv-table-wrapper fit-content-table">
        <table>
          <thead>
            <tr>
              <th class="col-10">
                Id
                <svg
                  class="search-icon"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#999"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
              </th>
              <th class="col-40">
                Tên công ty thành viên
                <svg
                  class="search-icon"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#999"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
              </th>
              <th class="col-30">
                Ghi chú
                <svg
                  class="search-icon"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#999"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
              </th>
              <th class="col-10 text-center">Sử dụng</th>
              <th class="col-10 text-center">Hành động</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in congTyThanhVienData" :key="index">
              <td>{{ item.id }}</td>
              <td>{{ item.ten }}</td>
              <td>{{ item.ghiChu }}</td>
              <td class="text-center">
                <label class="switch"
                  ><input type="checkbox" v-model="item.suDung" /><span class="slider round"></span
                ></label>
              </td>
              <td class="text-center">
                <button class="btn-delete">
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <polyline points="3 6 5 6 21 6"></polyline>
                    <path
                      d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                    ></path>
                  </svg>
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination-section">
        <div class="pagination">
          <span class="page-arrow disabled">&lt;</span>
          <span class="page-number active">1</span>
          <span class="page-arrow disabled">&gt;</span>
        </div>
      </div>
    </div>

    <div v-else-if="currentTab === 'PHÒNG BAN QUẢN LÝ'" class="tab-content">
      <div class="toolbar">
        <div class="left-actions">
          <button class="btn btn-cyan">
            <svg
              class="icon"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2.5"
              stroke-linecap="round"
              stroke-linejoin="round"
              style="width: 10px; height: 10px; margin-right: 4px"
            >
              <line x1="12" y1="5" x2="12" y2="19"></line>
              <line x1="5" y1="12" x2="19" y2="12"></line>
            </svg>
            Thêm
          </button>
        </div>
      </div>
      <div class="table-wrapper cong-ty-tv-table-wrapper fit-content-table">
        <table>
          <thead>
            <tr>
              <th class="col-pbql-id">
                Id
                <svg
                  class="search-icon"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#999"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
              </th>
              <th class="col-pbql-ma">
                Mã phòng ban quản lý
                <svg
                  class="search-icon"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#999"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
              </th>
              <th class="col-pbql-ten">
                Tên phòng ban quản lý
                <svg
                  class="search-icon"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="#999"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <circle cx="11" cy="11" r="8"></circle>
                  <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
              </th>
              <th class="col-pbql-sudung text-center">Sử dụng</th>
              <th class="col-pbql-action text-center">Hành động</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in phongBanQuanLyData" :key="index">
              <td>{{ item.id }}</td>
              <td>{{ item.ma }}</td>
              <td>{{ item.ten }}</td>
              <td class="text-center">
                <label class="switch">
                  <input type="checkbox" v-model="item.suDung" />
                  <span class="slider round"></span>
                </label>
              </td>
              <td class="text-center">
                <button class="btn-delete" title="Xóa">
                  <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <polyline points="3 6 5 6 21 6"></polyline>
                    <path
                      d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                    ></path>
                    <line x1="10" y1="11" x2="10" y2="17"></line>
                    <line x1="14" y1="11" x2="14" y2="17"></line>
                  </svg>
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination-section">
        <div class="pagination">
          <span class="page-arrow disabled">&lt;</span>
          <span class="page-number active">1</span>
          <span class="page-arrow disabled">&gt;</span>
        </div>
      </div>
    </div>
    <div v-else class="tab-content empty-tab">
      <p>Giao diện "{{ currentTab }}" đang được phát triển...</p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const tabs = ref([
  'CÔNG TY',
  'THỊ TRƯỜNG',
  'NGUỒN KHÁCH',
  'CHI NHÁNH',
  'NGƯỜI ĐẶT PHÒNG',
  'CÔNG TY THÀNH VIÊN',
  'PHÒNG BAN QUẢN LÝ',
])

// Mở mặc định tab CÔNG TY THÀNH VIÊN để dễ kiểm tra
const currentTab = ref('CÔNG TY')
const pageSize = ref('100')

// 1. Dữ liệu Tab Công Ty
const companyData = ref([
  {
    ma: 'CTY001',
    ten: 'Công ty cổ phần truyền thông A F One',
    tenGiaoDich: 'A F ONE',
    diaChi: '',
    tax: '',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY002',
    ten: 'Công ty TNHH AFG Việt Nam',
    tenGiaoDich: 'AFG VIET NAM',
    diaChi: '32 Võ Văn Tần, Phường 6, Quận 3, TP.HCM',
    tax: '0302821210',
    sdt: '',
    email: '',
    nguonKhach: ['Corporate'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'TP HCM',
  },
  {
    ma: 'CTY003',
    ten: 'CÔNG TY TNHH AGODA',
    tenGiaoDich: 'AGODA',
    diaChi: '',
    tax: '',
    sdt: '',
    email: '',
    nguonKhach: ['OTA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'TP HCM',
  },
  {
    ma: 'CTY004',
    ten: 'CÔNG TY CỔ PHẦN PHÁT TRIỂN A&H VIỆT NAM',
    tenGiaoDich: 'AH',
    diaChi: 'SN 29, Ngõ 45 Cự Lộc, Thượng Đình, Thanh Xuân, Hà Nội',
    tax: '0108343160',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY005',
    ten: 'CÔNG TY TNHH ASIA LION',
    tenGiaoDich: 'ASIA LION',
    diaChi: '',
    tax: '',
    sdt: '',
    email: '',
    nguonKhach: ['Corporate'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY006',
    ten: 'Công ty TNHH Dịch Vụ Du Lịch & Khách Sạn Alo',
    tenGiaoDich: 'ALO BOOKING',
    diaChi: 'Số 7A, Ngõ 360/22, Đường Đê La Thành, Ô Chợ Dừa, Đống Đa, Hà Nội',
    tax: '0105374408',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY007',
    ten: 'ALPHA CORPORATION CO., LTD',
    tenGiaoDich: 'ALPHA CORP',
    diaChi: '2F, NO.4, LANE 3, CHUNG - CHENG E. ROAD, TAMSUI DISTRICT, NEW TAIPEI CITY, TAIWAN',
    tax: '',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Others',
  },
  {
    ma: 'CTY008',
    ten: 'CÔNG TY CỔ PHẦN ALPHANAM E&C',
    tenGiaoDich: 'ALPHANAM',
    diaChi: 'Số 47 Vũ Trọng Phụng, Thanh Xuân Trung, Thanh Xuân, Hà Nội',
    tax: '',
    sdt: '',
    email: '',
    nguonKhach: ['Corporate'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY009',
    ten: 'VĂN PHÒNG ĐẠI DIỆN AMARITA TẠI HÀ NỘI',
    tenGiaoDich: 'AMARITA',
    diaChi: 'Tòa nhà Geleximco, 36 Hoàng Cầu, Ô Chợ Dừa, Đống Đa, Hà Nội',
    tax: '0106198642',
    sdt: '',
    email: '',
    nguonKhach: ['Corporate'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY010',
    ten: 'CÔNG TY TNHH MỘT THÀNH VIÊN THƯƠNG MẠI VÀ DỊCH VỤ DU LỊCH AMA',
    tenGiaoDich: 'AMA TOUR',
    diaChi: 'Lô B8, Khu đấu giá 3ha, Phường Phúc Diễn, Bắc Từ Liêm, Hà Nội',
    tax: '0108375837',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY011',
    ten: 'CÔNG TY CỔ PHẦN THƯƠNG MẠI VÀ DU LỊCH AMICA',
    tenGiaoDich: 'AMICA',
    diaChi:
      'Tầng 3, Toà nhà Nikko, Số 27, Phố Nguyễn Trường Tộ, Nguyễn Trung Trực, Ba Đình, Hà Nội',
    tax: '0102148154',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY012',
    ten: 'CÔNG TY TNHH THƯƠNG MẠI & DU LỊCH AN AN',
    tenGiaoDich: 'AN AN',
    diaChi: '',
    tax: '',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY013',
    ten: 'AN AN BY NATURE',
    tenGiaoDich: 'ANABY',
    diaChi: '',
    tax: '',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'TP HCM',
  },
  {
    ma: 'CTY014',
    ten: 'CÔNG TY CỔ PHẦN TƯ VẤN QUẢN LÝ VÀ ĐẦU TƯ ANDI VIỆT NAM',
    tenGiaoDich: 'ANDI VIET NAM',
    diaChi: 'Tầng 6, Toà nhà 33 Thái Hà, Trung Liệt, Đống Đa, Hà Nội',
    tax: '0104675549',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY015',
    ten: 'Công ty TNHH một thành viên xây dựng và cung cấp lắp đặt thiết bị điện An Đông',
    tenGiaoDich: 'CTY AN ĐÔNG',
    diaChi: 'P302 Tòa nhà CT1 536A Minh Khai, Hai Bà Trưng, HN',
    tax: '0107297079',
    sdt: '',
    email: '',
    nguonKhach: ['Corporate'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY016',
    ten: 'Công ty TNHH thương mại và dịch vụ tổng hợp Anh Phát',
    tenGiaoDich: 'CTY ANH PHÁT',
    diaChi: 'Số 134, Đường Bùi Thị Xuân, Phường Phường Đúc, Huế',
    tax: '3301072674',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Huế',
  },
  {
    ma: 'CTY017',
    ten: 'Công ty Cổ phần Thương mại & Công nghệ ANK',
    tenGiaoDich: 'ANK',
    diaChi: '55A/13/218 Đội Cấn, Quận Ba Đình, Hà Nội',
    tax: '0101968565',
    sdt: '',
    email: '',
    nguonKhach: ['Corporate'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY018',
    ten: 'Công ty Cổ Phần Quảng Cáo & Truyền Thông An Phong',
    tenGiaoDich: 'AP MEDIA',
    diaChi: '19/6 Phạm Ngọc Thạch - Phường 6 - Quận 3 - TP.Hồ Chí Minh',
    tax: '0309995572',
    sdt: '',
    email: '',
    nguonKhach: ['Corporate'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'TP HCM',
  },
  {
    ma: 'CTY019',
    ten: 'CÔNG TY TNHH HỆ THỐNG VÀ GIẢI PHÁP APAC',
    tenGiaoDich: 'APAC',
    diaChi: 'Số 174 đường Trần Vỹ, Phường Mai Dịch, Cầu Giấy, Hà Nội',
    tax: '0105315585',
    sdt: '',
    email: '',
    nguonKhach: ['Corporate'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY020',
    ten: 'CÔNG TY TNHH PHÂN PHỐI THIẾT BỊ BẢO AN',
    tenGiaoDich: 'BẢO AN',
    diaChi: 'P704 Số 106 Tôn Đức Thắng, Quốc Tử Giám, Đống Đa, Hà Nội',
    tax: '0106263599',
    sdt: '',
    email: '',
    nguonKhach: ['Corporate'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY021',
    ten: 'CÔNG TY TNHH QUỐC TẾ APPLE',
    tenGiaoDich: 'APPLE',
    diaChi: 'Số 1, Ngõ 46 Phố Trung Hòa, Trung Hoà, Cầu Giấy, Hà Nội',
    tax: '0102606550',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY022',
    ten: 'Công ty CP Đầu tư & Du lịch APQ Việt Nam',
    tenGiaoDich: 'APQ',
    diaChi: '',
    tax: '',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY023',
    ten: 'CÔNG TY CP AQUA LIFE TRAVEL',
    tenGiaoDich: 'AQua Life Travel',
    diaChi: 'Số 17/90 Tổ 25A, Phường Quan Hoa, Cầu Giấy, Hà Nội',
    tax: '0106422730',
    sdt: '',
    email: '',
    nguonKhach: ['TA'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
  {
    ma: 'CTY024',
    ten: 'Công ty cổ phần giải pháp công nghệ ARITO',
    tenGiaoDich: 'ARITO',
    diaChi: '146 Đường S, Tổ 58, Khu Tái định cư Lô H, Phường Mỹ Đình 1, Nam Từ Liêm, Hà Nội',
    tax: '0106680227',
    sdt: '',
    email: '',
    nguonKhach: ['Corporate'],
    thiTruong: ['Nội địa'],
    loai: 'Đối tác',
    dongBoACC: false,
    congNoToiDa: 0,
    tkNganHang: '',
    nguoiDatPhong: '',
    maGiaPhong: '',
    linhVucKD: '',
    chiNhanh: 'Hà Nội',
  },
])

// 2. Dữ liệu Tab Thị Trường
const thiTruongData = ref([
  { id: 2, ma: 'OTA', ten: 'Online Travel Agent' },
  { id: 3, ma: 'FIT', ten: 'Free Individual Traveler' },
  { id: 5, ma: 'GIT', ten: 'Group Individual Traveler' },
  { id: 6, ma: 'FOC', ten: 'FOC' },
  { id: 7, ma: 'WK', ten: 'Walk-In' },
  { id: 8, ma: 'TA', ten: 'Travel Agent' },
])

// 3. Dữ liệu Tab Nguồn Khách
const nguonKhachData = ref([
  { id: 12, ma: 'OTA', ten: 'Online Travel Agent' },
  { id: 14, ma: 'FOC', ten: 'FOC' },
  { id: 15, ma: 'GIT', ten: 'Group Individual Traveler' },
  { id: 16, ma: 'FIT', ten: 'Free Individual Traveler' },
])

// 4. Dữ liệu Tab Chi Nhánh
const chiNhanhData = ref([
  { id: 0, ten: 'Đà Nẵng' },
  { id: 3, ten: 'Hà Nội' },
  { id: 6, ten: 'Others' },
  { id: 7, ten: 'TP HCM' },
  { id: 9, ten: 'Huế' },
  { id: 10, ten: 'Đà Lạt' },
])

// 5. Dữ liệu Tab Loại
const loaiData = ref([
  { id: 1, ten: 'Trong Nước' },
  { id: 2, ten: 'Nước Ngoài' },
  { id: 3, ten: 'Châu Á' },
  { id: 4, ten: 'Châu Âu' },
  { id: 5, ten: 'Châu Mỹ' },
  { id: 6, ten: 'Châu Phi' },
])

// 6. Dữ liệu Tab Lĩnh Vực Hoạt Động (Dạng cây)
const linhVucHoatDongData = ref([
  {
    ten: 'NÔNG NGHIỆP, LÂM NGHIỆP VÀ THUỶ SẢN',
    expanded: true,
    children: [
      { ten: 'Nông nghiệp và hoạt động dịch vụ có liên quan' },
      { ten: 'Lâm nghiệp và hoạt động dịch vụ có liên quan' },
      { ten: 'Khai thác, nuôi trồng thuỷ sản' },
    ],
  },
  {
    ten: 'KHAI KHOÁNG',
    expanded: false,
    children: [
      { ten: 'Khai thác than cứng và than non' },
      { ten: 'Khai thác dầu thô và khí đốt tự nhiên' },
      { ten: 'Khai thác quặng kim loại' },
      { ten: 'Khai khoáng khác' },
    ],
  },
  {
    ten: 'CÔNG NGHIỆP CHẾ BIẾN, CHẾ TẠO',
    expanded: false,
    children: [
      { ten: 'Sản xuất chế biến thực phẩm & đồ uống' },
      { ten: 'Sản xuất trang phục, giày dép, dệt may' },
      { ten: 'Sản xuất sản phẩm từ hóa chất, cao su, nhựa' },
      { ten: 'Sản xuất sản phẩm điện tử, máy vi tính và thiết bị quang học' },
      { ten: 'Sản xuất máy móc, thiết bị cơ khí chuyên dụng' },
    ],
  },
  {
    ten: 'SẢN XUẤT VÀ PHÂN PHỐI ĐIỆN, KHÍ ĐỐT, NƯỚC NÓNG, HƠI NƯỚC VÀ ĐIỀU HOÀ KHÔNG KHÍ',
    expanded: false,
    children: [
      { ten: 'Sản xuất, truyền tải và phân phối điện (Điện gió, điện mặt trời, thủy điện...)' },
      { ten: 'Sản xuất và phân phối nhiên liệu khí bằng đường ống' },
    ],
  },
  {
    ten: 'CUNG CẤP NƯỚC; HOẠT ĐỘNG QUẢN LÝ VÀ XỬ LÝ RÁC THẢI, NƯỚC THẢI',
    expanded: false,
    children: [
      { ten: 'Khai thác, xử lý và cung cấp nước sạch' },
      { ten: 'Hoạt động thoát nước và xử lý nước thải' },
      { ten: 'Thu gom, xử lý và tiêu hủy rác thải; tái chế phế liệu' },
    ],
  },
  {
    ten: 'XÂY DỰNG',
    expanded: false,
    children: [
      { ten: 'Xây dựng nhà các loại (Nhà ở, chung cư, văn phòng...)' },
      { ten: 'Xây dựng công trình kỹ thuật dân dụng (Đường bộ, đường sắt, cầu cảng...)' },
      { ten: 'Hoạt động hoàn thiện công trình và xây dựng chuyên dụng' },
    ],
  },
  {
    ten: 'BÁN BUÔN VÀ BÁN LẺ; SỬA CHỮA Ô TÔ, MÔ TÔ, XE MÁY VÀ XE CÓ ĐỘNG CƠ KHÁC',
    expanded: false,
    children: [
      { ten: 'Bán buôn, bán lẻ, bảo dưỡng và sửa chữa ô tô, mô tô, xe máy' },
      { ten: 'Bán buôn hàng nông, lâm sản nguyên liệu và động vật sống' },
      { ten: 'Bán buôn đồ dùng cho gia đình, thiết bị máy móc văn phòng' },
      { ten: 'Bán lẻ trong các cửa hàng kinh doanh tổng hợp (Siêu thị, trung tâm thương mại...)' },
      { ten: 'Bán lẻ hàng hóa khác trong các cửa hàng chuyên doanh' },
    ],
  },
  {
    ten: 'VẬN TẢI KHO BÃI',
    expanded: false,
    children: [
      { ten: 'Vận tải đường bộ, đường sắt và vận tải bằng đường ống' },
      { ten: 'Vận tải đường thủy (Đường biển, đường sông)' },
      { ten: 'Vận tải hàng không (Hành khách và hàng hóa)' },
      { ten: 'Kho bãi và các hoạt động hỗ trợ trực tiếp cho vận tải' },
    ],
  },
  {
    ten: 'DỊCH VỤ LƯU TRÚ VÀ ĂN UỐNG',
    expanded: false,
    children: [
      { ten: 'Dịch vụ lưu trú ngắn ngày (Khách sạn, resort, biệt thự du lịch, homestay...)' },
      { ten: 'Dịch vụ nhà hàng, quán ăn, quầy bar và dịch vụ ăn uống cung cấp theo hợp đồng' },
    ],
  },
  {
    ten: 'THÔNG TIN VÀ TRUYỀN THÔNG',
    expanded: false,
    children: [
      { ten: 'Hoạt động xuất bản (Sách, báo, phần mềm đóng gói...)' },
      { ten: 'Hoạt động điện ảnh, sản xuất chương trình truyền hình và âm thanh' },
      { ten: 'Hoạt động phát thanh, truyền hình và viễn thông' },
      { ten: 'Lập trình máy vi tính, dịch vụ CNTT, tư vấn và quản trị hệ thống' },
      { ten: 'Hoạt động cổng thông tin, xử lý dữ liệu và các dịch vụ thông tin khác' },
    ],
  },
  {
    ten: 'HOẠT ĐỘNG TÀI CHÍNH, NGÂN HÀNG VÀ BẢO HIỂM',
    expanded: false,
    children: [
      { ten: 'Hoạt động dịch vụ trung gian tài chính (Ngân hàng, tín dụng, công ty tài chính)' },
      { ten: 'Bảo hiểm, tái bảo hiểm, bảo hiểm xã hội (Trừ bảo đảm xã hội bắt buộc)' },
      { ten: 'Hoạt động dịch vụ tài chính khác (Chứng khoán, quỹ đầu tư, môi giới tài chính)' },
    ],
  },
  {
    ten: 'HOẠT ĐỘNG KINH DOANH BẤT ĐỘNG SẢN',
    expanded: false,
    children: [
      { ten: 'Kinh doanh bất động sản, quyền sử dụng đất thuộc chủ sở hữu hoặc đi thuê' },
      { ten: 'Dịch vụ tư vấn, quản lý, sàn giao dịch và môi giới bất động sản' },
    ],
  },
  {
    ten: 'HOẠT ĐỘNG CHUYÊN MÔN, KHOA HỌC VÀ CÔNG NGHỆ',
    expanded: false,
    children: [
      { ten: 'Hoạt động pháp luật, kế toán, kiểm toán và tư vấn quản trị' },
      { ten: 'Hoạt động kiến trúc, khảo sát địa chất, kiểm tra và phân tích kỹ thuật' },
      { ten: 'Nghiên cứu khoa học và phát triển công nghệ tự nhiên, xã hội' },
      { ten: 'Quảng cáo, nghiên cứu thị trường, nhiếp ảnh, dịch thuật công chứng' },
    ],
  },
  {
    ten: 'HOẠT ĐỘNG HÀNH CHÍNH VÀ DỊCH VỤ HỖ TRỢ',
    expanded: false,
    children: [
      { ten: 'Cho thuê máy móc, thiết bị, ô tô và đồ dùng hữu hình khác' },
      { ten: 'Hoạt động dịch vụ lao động, việc làm và cung ứng nhân sự' },
      { ten: 'Đại lý du lịch, điều hành tua du lịch và dịch vụ hỗ trợ liên quan' },
      { ten: 'Dịch vụ bảo vệ tư nhân, dịch vụ vệ sinh công nghiệp nhà cửa' },
    ],
  },
  {
    ten: 'GIÁO DỤC VÀ ĐÀO TẠO',
    expanded: false,
    children: [
      { ten: 'Giáo dục mầm non, tiểu học, trung học cơ sở và trung học phổ thông' },
      { ten: 'Đào tạo đại học, cao đẳng, trung cấp và sau đại học' },
      { ten: 'Giáo dục nghề nghiệp, trung tâm ngoại ngữ, tin học, kỹ năng sống' },
    ],
  },
  {
    ten: 'Y TẾ VÀ HOẠT ĐỘNG TRỢ GIÚP XÃ HỘI',
    expanded: false,
    children: [
      { ten: 'Hoạt động của các bệnh viện, phòng khám đa khoa và chuyên khoa' },
      { ten: 'Hoạt động trợ giúp xã hội tập trung (Nhà dưỡng lão, trại trẻ mồ côi...)' },
    ],
  },
  {
    ten: 'NGHỆ THUẬT, VUI CHƠI VÀ GIẢI TRÍ',
    expanded: false,
    children: [
      { ten: 'Hoạt động sáng tác, nghệ thuật, biểu diễn sân khấu và giải trí' },
      { ten: 'Hoạt động của các bảo tàng, bảo tồn lịch sử, vườn bách thảo' },
      { ten: 'Hoạt động thể thao cá nhân/tập thể, khu vui chơi, công viên giải trí' },
    ],
  },
  {
    ten: 'HOẠT ĐỘNG DỊCH VỤ KHÁC',
    expanded: false,
    children: [
      { ten: 'Hoạt động của các hiệp hội, tổ chức ngành nghề, tôn giáo' },
      { ten: 'Sửa chữa máy vi tính, thiết bị liên lạc, đồ dùng gia đình' },
      { ten: 'Dịch vụ phục vụ cá nhân khác (Giặt là, làm đẹp, spa, cắt tóc...)' },
    ],
  },
])

// 7. Dữ liệu Tab Người Đặt Phòng
const nguoiDatPhongData = ref([
  { ma: '1', ten: 'MR. BÌNH', email: '', sdt: '0195768835', diaChi: '', ghiChu: '' },
  { ma: '2', ten: 'MR TRƯỜNG', email: '', sdt: '0973751814', diaChi: '', ghiChu: '' },
  { ma: '3', ten: 'ms Lien', email: '', sdt: '0984030395', diaChi: '', ghiChu: '' },
  { ma: '4', ten: 'Ms. Thom', email: '', sdt: '', diaChi: '', ghiChu: '' },
  {
    ma: '5',
    ten: 'Nguyễn Thị Hà Sơn',
    email: 'Hasonnguyen7486@gmail.com',
    sdt: '0978912075',
    diaChi: '',
    ghiChu: '',
  },
  { ma: '6', ten: 'MS LIỄU', email: '', sdt: '0908722336', diaChi: '', ghiChu: '' },
])

// 8. Dữ liệu Tab Công Ty Thành Viên
const congTyThanhVienData = ref([
  { id: 1, ten: 'CNTT', ghiChu: '', suDung: true },
  { id: 2, ten: 'HT', ghiChu: '', suDung: false },
  { id: 3, ten: 'XNCG', ghiChu: '', suDung: true },
])

// 9. Dữ liệu Tab Phòng Ban Quản Lý
const phongBanQuanLyData = ref([{ id: 1, ma: 'PND', ten: 'PND', suDung: false }])
</script>

<style scoped>
/* --- CSS DÙNG CHUNG HỆ THỐNG --- */
.app-container {
  font-family: Arial, sans-serif;
  font-size: 13px;
  color: #333;
  background-color: #fff;
  display: flex;
  flex-direction: column;
  height: 100vh;
}

.tabs {
  display: flex;
  overflow-x: auto;
  overflow-y: hidden !important;
  border-bottom: 2px solid #f0f0f0;
  padding: 0 10px;
  background-color: #fff;
  align-items: flex-end;
  padding-bottom: 5px;
}

.tab-item {
  padding: 12px 16px;
  cursor: pointer;
  white-space: nowrap;
  color: #555;
  text-transform: uppercase;
  font-size: 12px;
  font-weight: 500;
  margin-bottom: -2px;
  border-bottom: 5px solid transparent;
}
.tab-item.active {
  color: #85c8ea;
  border-bottom-color: #85c8ea;
  font-weight: bold;
}

.tab-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  height: auto !important;
}

.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 15px;
  background: #fff;
}
.left-actions {
  display: flex;
  gap: 8px;
}
.right-actions {
  display: flex;
  gap: 5px;
}

.btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  padding: 6px 14px;
  border: none;
  border-radius: 4px;
  color: white;
  cursor: pointer;
  font-size: 13px;
}
.btn-cyan {
  background-color: #85c8ea;
}
.btn-cyan:hover {
  background-color: #4aa7ce;
}
.btn-blue {
  background-color: #85c8ea;
}
.btn-blue:hover {
  background-color: #4aa7ce;
}
.btn-icon {
  width: 14px;
  height: 14px;
}
.icon {
  border: 1px solid white;
  background-color: white;
  color: #85c8ea;
}

.icon-btn {
  background: none;
  border: none;
  cursor: pointer;
  padding: 4px;
  display: flex;
  align-items: center;
}
.icon-btn svg {
  width: 20px;
  height: 20px;
  color: #666;
}
.btn-help svg {
  color: #85c8ea;
}

.table-wrapper {
  flex: none !important;
  max-height: calc(100vh - 220px);
  overflow-y: auto;
  overflow-x: auto;
  border: 1px solid #e0e0e0;
  margin: 0 15px;
}
table {
  width: 100%;
  border-collapse: collapse;
}
thead th {
  background-color: #f4f6f8;
  padding: 12px 28px 12px 10px;
  text-align: left;
  border: 1px solid #e0e0e0;
  font-weight: bold;
  position: relative;
  word-wrap: break-word;
}
tbody td {
  padding: 12px 10px;
  border: 1px solid #e0e0e0;
  vertical-align: middle;
  color: #444;
}
.col-tengd {
  white-space: nowrap;
}
.text-center {
  text-align: center;
}
.sort-icon {
  font-size: 10px;
  color: #999;
  margin-left: 4px;
}
.search-icon,
.filter-icon {
  width: 12px;
  height: 12px;
  position: absolute;
  right: 8px;
  top: 50%;
  transform: translateY(-50%);
}

.btn-delete {
  background-color: #9cd6f0;
  border: none;
  border-radius: 4px;
  width: 32px;
  height: 32px;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: white;
}
.btn-delete svg {
  width: 16px;
  height: 16px;
}
.btn-delete:hover {
  background-color: #85c8ea;
}

.switch {
  position: relative;
  display: inline-block;
  width: 40px;
  height: 22px;
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
  background-color: #ccc;
  transition: 0.3s;
}
.slider:before {
  position: absolute;
  content: '';
  height: 16px;
  width: 16px;
  left: 3px;
  bottom: 3px;
  background-color: white;
  transition: 0.3s;
}
input:checked + .slider {
  background-color: #85c8ea;
}
input:checked + .slider:before {
  transform: translateX(18px);
}
.slider.round {
  border-radius: 22px;
}
.slider.round:before {
  border-radius: 50%;
}

.pagination-section {
  padding: 10px 15px;
  background: #fff;
}

.pagination-section,
.narrow-pagination-section {
  display: flex;
  justify-content: flex-end;
  padding: 15px 15px 10px 15px;
  width: 100%;
  box-sizing: border-box;
}

.pagination {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 5px;
}
.page-number,
.page-arrow {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 26px;
  padding: 0 10px;
  cursor: pointer;
  border: 1px solid #e0e0e0;
  background: #fff;
  border-radius: 4px;
}
.page-number.active {
  border-color: #85c8ea;
  color: #000;
  font-weight: bold;
}
.page-arrow.disabled {
  color: #ccc;
  cursor: not-allowed;
}
.page-size {
  height: 28px;
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  padding: 0 5px;
}

/* --- CÔNG TY --- */
.company-table-wrapper {
  flex: 1;
  margin: 0 15px;
}

/* --- CẤU TRÚC RIÊNG: BẢNG THU HẸP (THỊ TRƯỜNG, NGUỒN KHÁCH, CHI NHÁNH, LOẠI) --- */
.narrow-content {
  padding: 0 15px;
}
.narrow-table-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: flex-start; /* Ép bảng nằm sát lề trái */
}
.narrow-table-wrapper {
  width: 60%;
  min-width: 600px;
  flex: none !important;
  max-height: calc(100vh - 220px);
  overflow-y: auto;
  overflow-x: auto;
  border: 1px solid #e0e0e0;
  margin: 0 !important;
}
.narrow-table-wrapper tbody td {
  padding: 15px 10px;
}

/* Class mới: Xử lý phân trang nằm ngoài bảng và góc phải */
.narrow-pagination-section {
  width: 60%;
  min-width: 600px;
  padding: 15px 0 10px 0;
}

.col-id {
  width: 15%;
}
.col-code {
  width: 25%;
}
.col-name {
  width: 45%;
}
.col-action {
  width: 15%;
}

/* --- LĨNH VỰC HOẠT ĐỘNG (DẠNG CÂY) --- */
.tree-content {
  background-color: #fafafa;
  padding: 15px;
}
.tree-table-container {
  width: 60%;
  min-width: 600px;
  flex: none !important;
  max-height: calc(100vh - 220px);
  overflow-y: auto;
  overflow-x: hidden;
  border: 1px solid #e0e0e0;
}
.tree-table {
  border: 1px solid #e0e0e0;
  background-color: #fff;
  width: 100%;
}
.tree-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #f4f6f8;
  padding: 12px 15px;
  font-weight: bold;
  color: #333;
  border-bottom: 1px solid #e0e0e0;
}
.tree-search-icon {
  width: 14px;
  height: 14px;
  color: #ccc;
}
.tree-row {
  display: flex;
  align-items: center;
  padding: 14px 15px;
  border-bottom: 1px solid #f0f0f0;
}
.tree-row:last-child {
  border-bottom: none;
}
.parent-row {
  cursor: pointer;
  background-color: #fff;
}
.parent-row:hover {
  background-color: #fafafa;
}
.child-row {
  padding-left: 55px;
  color: #555;
  background-color: #fff;
}
.child-row:hover {
  background-color: #fcfcfc;
}
.toggle-box {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 16px;
  height: 16px;
  background-color: #85c8ea;
  color: white;
  font-weight: bold;
  font-size: 14px;
  line-height: 1;
  margin-right: 12px;
  border-radius: 2px;
}
.parent-text {
  text-transform: uppercase;
  color: #444;
}
.tree-pagination-section {
  display: flex;
  justify-content: flex-end;
  padding-top: 15px;
}

/* --- NGƯỜI ĐẶT PHÒNG --- */
.nguoi-dat-phong-table-wrapper {
  flex: 1;
  margin: 0 15px;
}
.col-ndp-ma {
  width: 8%;
}
.col-ndp-ten {
  width: 20%;
}

/* --- CÔNG TY THÀNH VIÊN --- */
.cong-ty-tv-table-wrapper {
  flex: 1;
  margin: 0 15px;
}
.col-cty-id {
  width: 10%;
}
.col-cty-ten {
  width: 40%;
}
.col-cty-ghichu {
  width: 30%;
}
.col-cty-sudung {
  width: 10%;
  text-align: center;
}
.col-cty-action {
  width: 10%;
  text-align: center;
}

.empty-tab {
  padding: 40px;
  text-align: center;
  color: #aaa;
  font-style: italic;
}
</style>
