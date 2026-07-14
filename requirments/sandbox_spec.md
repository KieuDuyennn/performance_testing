# Sandbox Spec — Giới hạn môi trường học tập (Giai đoạn 1–6)

Tài liệu này định nghĩa "hộp cát" an toàn để mỗi thành viên tự học kiến trúc mà
không làm treo máy cá nhân. Các con số ở đây áp dụng cho **Giai đoạn 1–6** của
`plan-study.md`. Việc đo ở quy mô thật (50 / 500 VU) chỉ thực hiện ở **Giai đoạn 7**
theo đúng requirement T05.

## 1. Trần tải khi học (sandbox)

| Tham số | Giá trị | Lý do |
|---|---|---|
| VUs tối đa | **1–5 VU** | Đủ để quan sát hành vi, không bão hòa máy cá nhân |
| Iterations | 1 khi smoke test | Tập trung đọc hiểu từng request |
| Think-time | `sleep(1–3s)` giữa các bước | Mô phỏng người dùng thật |

> ⚠️ **KHÔNG** chạy 500 VU trên máy sandbox để "kiểm chứng" điểm gãy (xem Bước 4.5).
> Spike 500 VU chỉ chạy ở Giai đoạn 7 trên môi trường đã chuẩn hóa.

## 2. Ngưỡng SLO bắt buộc (mọi giai đoạn)

- `http_req_duration`: **p95 < 500 ms** (và p99 < 1000 ms — xem `lib/config.js`)
- `http_req_failed`: **rate < 1%**

## 3. Rate limiter — bắt buộc biết

`eshop/backend/server.js` giới hạn **200 request / 15 phút / IP** trên toàn `/api`.

- Khi **học** (1–5 VU): nếu chạy lặp nhiều lần chạm trần → gặp HTTP 429. Restart
  backend để reset cửa sổ đếm, hoặc bật `LOADTEST=1`.
- Khi **đo hiệu năng thật** (Giai đoạn 7): **bắt buộc** khởi động backend bằng
  `LOADTEST=1 node server.js` để bypass limiter, nếu không mọi số đo đều sai.

## 4. Tài khoản & dữ liệu seed (tham chiếu nhanh)

- Test user: `test@eshop.com` / `Test1234!` (role `user`)
- Admin user: `admin@eshop.com` / `Admin123!` (role `admin`)
- Products seed: id **1–5** (iPhone 15 Pro Max, Samsung Galaxy S24 Ultra,
  MacBook Pro M3, Tai nghe AirPods Pro 2, Bàn phím cơ Keychron Q1)
- DB reset: mỗi lần restart `node server.js`, `initDatabase()` chạy vô điều kiện →
  DROP + seed lại (xem Bước 4.0).
