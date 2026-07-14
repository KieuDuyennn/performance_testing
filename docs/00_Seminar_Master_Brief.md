# 📘 SEMINAR MASTER BRIEF — T05 Performance Testing (Team 09)

> **File này để làm gì?** Tổng hợp TẤT CẢ yêu cầu từ 3 tài liệu gốc của giảng viên
> (`Seminar_Guide.docx`, `Seminar_Workflow_Briefing.pdf`, `T05_Performance_Testing.docx`)
> + kiến trúc hệ thống EShop (đã tự đọc source & verify) + flow thực hiện + việc còn phải làm.
> Đọc file này TRƯỚC, rồi mới mở `requirments/plan-study.md` (lộ trình chi tiết từng bước).
>
> **Nguồn:** CS423/CSC15003 Software Testing · FIT@HCMUS · GV: Dr. Lâm Quang Vũ.
> Seminar = **20% điểm môn học** (thành phần PRJ-SM).

---

## 1. BỨC TRANH LỚN — Seminar Track là gì?

Mỗi nhóm trở thành **"chuyên gia của lớp" về đúng 1 công cụ kiểm thử hiện đại**, rồi
**dạy lại** cho các nhóm khác. Tinh thần xuyên suốt (3 từ khóa của giảng viên):

| Nguyên tắc | Ý nghĩa |
|---|---|
| **Self-directed** | Nhóm tự chọn công cụ. Giảng viên chỉ duyệt *phạm vi*, không chấm *lựa chọn đúng/sai*. |
| **Hands-on** | Demo chạy thật trên EShop. **Slide KHÔNG phải trung tâm** — hoạt động cho khán giả mới là trung tâm. |
| **AI-augmented** | **Bắt buộc** ghép 1 công cụ truyền thống + 1 hướng AI trong MỌI demo. |
| **Peer-taught** | Nhóm phải điều phối 1 hoạt động ~20 phút cho các bạn cùng lớp làm thử. |

**Nhóm mình:** Topic **T05 — Performance Testing**. SUT = **EShop** (Node.js + SQLite).
Công cụ: **k6** (chính) + **Apache JMeter** (phụ). Hướng AI: **dùng LLM sinh kịch bản
load test "realistic shopping" từ HTTP log, rồi audit & tinh chỉnh**.

---

## 2. QUY TRÌNH 8 GIAI ĐOẠN (S1 → S8)

Đây là "khung thời gian" của cả môn. (Nhóm mình đang ở khoảng S3–S4.)

| Stage | Tên | Ai làm | Output chính | Deadline (theo Week) |
|---|---|---|---|---|
| **S1** | Topic claim & Tool Survey | Cả nhóm | `Tool_Survey_Proposal.md` (≤ 1 trang) | W6, Sáng thứ 7 23:59 |
| **S2** | Instructor/TA review | GV | Verdict: APPROVED / MINOR-CHANGE / RECLAIM | W6 giữa tuần (≤ 2 ngày làm việc) |
| **S3** | Deep study & hands-on | Cả nhóm | Cài đặt chạy được + test E2E trên EShop + team log | W6–W10 |
| **S4** | User Guide + Screencast | Cả nhóm | `User_Guide.md` (≥ 6–7 mục) + `Demo.mp4` (5–8 phút) | W6–W10 |
| **S5** | Pre-share (≥ 3 ngày trước) | Cả nhóm | Đẩy Guide + Screencast + `Activity_Worksheet.md` + Slides lên Moodle | ≥ 3 ngày trước buổi seminar |
| **S6** | Live seminar (45 phút) | Nhóm + khán giả | Pitch 10' + Demo 10' + Activity 20' + Q&A 5' | W7–W11 (GV xếp lịch) |
| **S7** | Audience feedback | Các nhóm khác | Minute-paper (1 phút/nhóm) | Ngay trong buổi |
| **S8** | AI Audit + Reflection | Cả nhóm | [AI-02] Audit, [AI-03] Disclosure, [AI-04] Reflection | ≤ 5 ngày làm việc sau seminar |

### 2.1. Chi tiết từng stage cần lưu ý

- **S1 — Proposal (≤ 1 trang) phải có:** (a) mã + tên topic; (b) ≥ 3 công cụ ứng viên
  (1 truyền thống + 1 AI + 1 dự phòng); (c) **ma trận so sánh 5 tiêu chí**: *chi phí bản
  quyền, độ khó học, mức hợp với EShop, năng lực AI, cộng đồng*; (d) lựa chọn + 3 gạch
  đầu dòng lý do; (e) **AI Disclosure**: dùng AI nào, đã cross-check gì.
- **S2 — 3 kết quả có thể:** APPROVED (khóa scope, làm tiếp) · MINOR-CHANGE (sửa ≤ 24h,
  khỏi review lại) · RECLAIM (lệch scope, đổi hướng). Được lặp tối đa 2 lần.
- **S3 — 5 milestone nội bộ (M1–M5):** M1 cài + chạy "hello world"; M2 chạy 1 kịch bản
  E2E trên EShop; M3 **ghi 3 failure mode thật quan sát được**; M4 tái hiện kịch bản đó
  bằng biến thể AI; M5 đo metric (thời gian setup, thời gian chạy, tỉ lệ flaky).
- **S6 — cấu trúc 45 phút:** `0:00–0:10` Pitch (vì sao công cụ này, ai dùng, khi nào nó
  *sai*) → `0:10–0:20` Demo thật trên terminal/IDE (KHÔNG slide) → `0:20–0:40` Khán giả
  làm hoạt động → `0:40–0:45` Debrief + Q&A. **Slide ≤ 15.** Phân vai: 1 presenter,
  1 demoer, 1 facilitator, 1 timekeeper. Chuẩn bị bản ghi hình dự phòng nếu mạng chết.
- **S8 — AI Audit pack:** [AI-02] ≥ 600 từ / 5 mục · [AI-03] PDF ký tên từng thành viên
  · [AI-04] 300 từ tiếng Anh.

---

## 3. DELIVERABLES — DANH SÁCH NỘP (bảng đối chiếu file trong repo)

| Deliverable | Yêu cầu | File trong repo | Trạng thái |
|---|---|---|---|
| Tool_Survey_Proposal | ≤ 1 trang, ma trận 5 tiêu chí | `docs/S1_Tool_Survey_Proposal.md` | 🟡 khung, còn TODO |
| User_Guide | ≥ 6–7 mục, tiếng Anh, có **Failure Modes** | `docs/S4_User_Guide.md` | 🟡 khung, còn TODO |
| Demo_Screencast | MP4, 5–8 phút, 1080p, ≤ 100MB, English, **không nhạc nền**, terminal thật | `media/` + link ngoài | 🔴 chưa có |
| Activity_Worksheet | "Workload Model Bake-off", làm được trong ≤ 25 phút, **có answer key** | `docs/S5_Activity_Worksheet.md` | 🟡 khung, còn TODO |
| Seminar_Slides | ≤ 15 slide | `slides/Seminar_Slides.pptx` | 🔴 chưa có |
| Audience_Feedback_Aggregated | Nhóm facilitator tổng hợp minute-paper | `docs/S7_Audience_Feedback_Aggregated.md` | 🟡 khung |
| [AI-02] Audit Report | 5 mục, ≥ 600 từ | `ai/AI-02_Audit_Report.md` | 🟡 khung, còn TODO |
| [AI-03] Disclosure | PDF ký tên/người | `ai/AI-03_Disclosure/` | 🔴 chưa có |
| [AI-04] Reflective | 300 từ English | `ai/AI-04_Reflective_Statement.md` | 🟡 khung |
| Final_Reflection | 300 từ English | `docs/S8_Final_Reflection.md` | 🟡 khung |
| **SLO Report** | p50/p95/p99 + error rate, baseline + spike | `load-tests/reports/SLO_Report.md` | 🔴 chưa có số thật |
| Peer_Review (2 nhóm bạn) | ≥ 3 điểm mạnh, ≥ 3 góp ý, 1 câu hỏi | (chưa có file) | 🔴 chưa có |

---

## 4. RUBRIC — CÁCH CHẤM (100% của thành phần Seminar)

| Tiêu chí | Trọng số | Chấm cái gì |
|---|---:|---|
| Tool survey + proposal | **10%** | Chất lượng so sánh; lý do chọn hướng AI; ý thức về chi phí/bản quyền |
| **Depth of study** | **15%** | **Hiểu kiến trúc; dùng đúng thuật ngữ; bao phủ edge case & giới hạn** ← chỗ giảng viên nhấn "càng sâu càng tốt" |
| **User-guide document** | **20%** | Markdown rõ; bước tái lập được; troubleshooting; references; AI-disclosure |
| Live demo trên EShop | **15%** | Chạy E2E không cần "phao"; kịch bản thực tế; **có show add-on AI** |
| **In-class activity** | **20%** | Hoạt động khả thi trong 15–25 phút; khán giả tái lập được; có rubric cho peer |
| Q&A + facilitation | **10%** | Trả lời chính xác; khiêm tốn; biết lái câu hỏi lạc đề |
| AI Audit + Disclosure + Reflection | **10%** | [AI-02] đủ 5 mục; [AI-03] ký; [AI-04] 300 từ |

> **Điểm danh khán giả:** nhóm phải dự ≥ 8/10 buổi seminar và nộp minute-paper mỗi buổi.
> Vắng > 2 buổi → điểm thành phần Seminar bị **trần 70%**.

### 4.1. ⚠️ 6 LỖI BỊ TRỪ ĐIỂM TỰ ĐỘNG (auto-penalty) — TRÁNH BẰNG MỌI GIÁ

1. Copy-paste output AI vào User Guide mà **không chỉnh sửa**.
2. Demo **chỉ** công cụ truyền thống HOẶC **chỉ** AI — bắt buộc **cả hai**.
3. **Bỏ mục "Failure Modes"** trong User Guide.
4. **Quay sẵn** demo rồi giả vờ "live" (TA kiểm tra).
5. Activity worksheet **không hoàn thành nổi trong 25 phút**.
6. Thiếu AI Disclosure hoặc [AI-02] để trống.

---

## 5. RIÊNG TOPIC T05 — PERFORMANCE TESTING (yêu cầu chuyên môn)

### 5.1. Mục tiêu học tập — mỗi thành viên phải làm được
1. **Thiết kế workload model:** tỉ lệ % search vs cart-add vs checkout / mỗi user-phút.
2. Cài đặt model đó bằng **CẢ JMeter (.jmx) VÀ k6 (JavaScript)**.
3. Chạy **baseline 50 VU** + **spike 50→500 VU trong 30s**.
4. Đo **p50/p95/p99 latency + error rate**; ra **báo cáo 1 trang**.
5. Dùng AI **soạn kịch bản "realistic shopping" từ 1 fake server log** — audit & tinh chỉnh.

### 5.2. Công cụ
- **Truyền thống (chọn 1 làm chính):** Apache JMeter (GUI+CLI, nhiều plugin, script XML) ·
  **k6** (script JS, cloud-friendly, report hiện đại) · Locust (Python thuần).
- **AI (chọn ≥ 1):** **ChatGPT/Claude sinh script k6** từ HAR/log rồi audit ·
  Grafana k6 AI (gợi ý correlation/threshold) · Akamas (tối ưu tham số bằng ML — *chỉ bàn,
  không cần chạy*).

### 5.3. Study Milestones nội bộ (S3 checklist của T05)
1. Bắt 1 **HAR** từ phiên EShop thủ công.
2. Chuyển thành **k6 baseline** script; xác nhận tái hiện đúng luồng.
3. Chạy **baseline 50 VU trong 5 phút** trên backend local *(cẩn thận: SQLite + 1 kết nối)*.
4. Sinh biến thể **"realistic shopping" bằng AI**; audit & tinh chỉnh.
5. Ra **SLO report**: p95 < 500 ms, error rate < 1%, ...

### 5.4. Yêu cầu chấm riêng của T05 (bổ sung vào rubric chung)
- Demo **bắt buộc** show ≥ 1 feature công cụ truyền thống **AND** ≥ 1 feature AI.
- User Guide **bắt buộc** có mục **"Failure Modes"** liệt kê **3 cách công cụ có thể đánh
  lừa người dùng**.
- Activity worksheet **peer team làm được trong ≤ 25 phút** mà không cần mình trợ giúp.

### 5.5. Hoạt động trong lớp — "Workload Model Bake-off" (25 phút)
Khán giả thiết kế phân bố workload cho EShop dịp **Black Friday**. Timeline:
`0–3'` facilitator giới thiệu site map + 22 FR → `3–12'` các nhóm phác % mix / user-phút →
`12–17'` mỗi nhóm dán mix lên bảng → `17–22'` facilitator chạy k6 dry-run mix của nhóm
thắng → `22–25'` mỗi nhóm ghi 1 giả định họ sẽ đổi.
**Thông điệp:** *model workload thực tế quan trọng hơn số VU thô; AI giúp tạo kịch bản
nhưng KHÔNG kiểm chứng được tính thực tế nghiệp vụ — con người phải làm.*

---

## 6. CHÍNH SÁCH AI (bắt buộc tuân thủ)

Seminar Track thuộc **AI Use Category 5 — AI-Integrated Work**. Được dùng bất kỳ AI nào
(ChatGPT/Claude/Gemini/Copilot/Cursor). Quy tắc:
- Mọi sản phẩm AI **phải được người review & sửa** trước khi nộp (copy-paste = vi phạm).
- Mọi phát biểu công khai (slide, screencast, câu trả lời) **phải kiểm chứng được** — trích
  nguồn gốc, **không trích AI**.
- Ghi rõ *tool + tóm tắt prompt + kết quả* vào [AI-02]. **Không** dán private key / MSSV /
  nội dung mật vào AI. **Không** dùng AI bịa feedback hay điểm danh.

### 6.1. 4 mẫu prompt giảng viên gợi ý (thay `[...]`, LUÔN audit output)
1. **Ma trận so sánh công cụ** (5 trục, trích nguồn từng dòng, gắn cờ nếu <90% chắc chắn).
2. **Failure Modes cho User Guide** (5 mode: trigger / triệu chứng / cách phát hiện / cách
   giảm thiểu — chỉ liệt kê mode có trong docs/GH issue/paper, không bịa).
3. **Worksheet 25 phút cho hoạt động khán giả** (bước có timebox + answer key, chạy được
   không cần internet sau setup).
4. **Audit 1 artefact do AI tạo** (bắt: sai sự thật / thiếu edge case / giả định ngầm / phát
   biểu quá tự tin — chỉ audit, không viết lại hộ).

---

## 7. KIẾN TRÚC EShop SUT & CÁC "BẪY" (đã tự đọc source + verify chạy thật)

> Đây là phần **"Depth of study" (15%)** ăn điểm nặng nhất và là kho "Failure Modes" cho
> User Guide. Tất cả điểm dưới đây đã được kiểm chứng trực tiếp trên code, KHÔNG phải suy đoán.

**Stack:** Express (Node.js) + SQLite (`database.sqlite`), cổng **3000**. Tài khoản seed:
`test@eshop.com` / `Test1234!` (user), `admin@eshop.com` / `Admin123!` (admin). 5 sản phẩm
id 1–5 (iPhone, Samsung, MacBook, AirPods, Keychron — **tên tiếng Việt**).

| # | Bẫy / Đặc điểm | Vị trí | Vì sao quan trọng cho performance testing |
|---|---|---|---|
| 1 | **Rate limiter 200 req/15min/IP** trên toàn `/api` | `server.js:~14-27` | **Quan trọng nhất.** 50 VU/5' hay 500 VU sẽ 429 sau ~200 req → SLO ảo. Đã thêm cờ `LOADTEST=1` để bypass khi đo. |
| 2 | **Search dùng query THAM SỐ HÓA** (`LIKE ?`) — **KHÔNG có SQLi** | `server.js:154` | Đính chính so với tin đồn: đây là ví dụ code *an toàn*. Đừng đi "chứng minh SQLi" không tồn tại. |
| 3 | Search thật là `GET /api/products?search=kw`, KHÔNG phải `/api/products/search` | `server.js:151-165` | `/api/products/search` rơi vào route `:id` → trả `{}` 200 → test rỗng mà vẫn "xanh". |
| 4 | `/api/cart`, `/api/checkout` **cần** `Authorization: Bearer` | `server.js:298,305` | Không login → 401. Script phải `login()` lấy JWT trước. |
| 5 | Mật khẩu lưu **plaintext**, so sánh `user.password === password` | `server.js:56` | Failure mode bảo mật thật. |
| 6 | `jwt.sign()` **không có `expiresIn`** → token **vĩnh viễn** | `server.js:61` | Failure mode thật; ảnh hưởng thiết kế test session. |
| 7 | Sai mật khẩu → `login_attempts += 2` (không phải 1); khóa khi `≥ 3` → **khóa sau 2 lần sai**, 3 phút | `server.js:64-67` | Bẫy: dùng tài khoản riêng khi test auth-fail, kẻo khóa nhầm luồng khác. |
| 8 | Product không tồn tại → trả **200 `{}`** (không phải 404) | `server.js:169` | Bẫy assertion: check `status===200` chưa đủ, phải check body. |
| 9 | Product **id chẵn** → `price` trả về dạng **string**, id lẻ → number | `server.js:170` | Bẫy kiểu dữ liệu; AI sinh script dễ bỏ sót. |
| 10 | `/api/checkout` **tin tuyệt đối** `total_amount` client gửi (không tính lại) | `server.js:305-316` | Business-logic flaw: số "doanh thu" trong load test là rác nếu tin nó. |
| 11 | Giỏ hàng `userCarts` lưu **trong RAM** tiến trình, không ghi SQLite | `server.js:24,298-302` | Mất sạch khi restart; phình vô hạn khi test lặp (memory leak tiềm ẩn). |
| 12 | `initDatabase()` chạy **vô điều kiện** mỗi lần khởi động → DROP + seed lại | `database.js:~117` | "Clean baseline" miễn phí: restart = reset data. Restart trước mỗi vòng đo. |
| 13 | SQLite **1 kết nối ghi** + Node **event loop** tuần tự | kiến trúc | Nút thắt checkout khi tải cao là ở **tầng DB (write-lock)**, không phải tầng nhận request. |

---

## 8. FLOW THỰC HIỆN — Lộ trình 7 giai đoạn (đối chiếu plan-study ↔ stage ↔ deliverable)

Lộ trình chi tiết ở `requirments/plan-study.md`. Ánh xạ nhanh:

| Giai đoạn (plan-study) | Học/làm gì | Gắn vào Stage | Sinh ra deliverable nào |
|---|---|---|---|
| **GĐ1** Smoke test 1 VU | Vòng đời k6, threshold, check | S3 / M1 | Nền cho User Guide "First Test" |
| **GĐ2** Tham số hóa & Correlation | JWT correlation, `SharedArray`, JMeter JSON Extractor, HAR | S3 / M2 | HAR, `search_keywords.json` |
| **GĐ3** User Journey trọn vẹn | login→search→detail→cart (chuỗi 4 request) | S3 | k6 journey + `.jmx` |
| **GĐ4** Cô lập lỗi & failure mode | auth-fail, DB-lock stress, các bẫy source | S3 / M3 | **Mục "Failure Modes" của User Guide** |
| **GĐ5** Đối chứng công cụ (GUI vs CLI) | vì sao cấm GUI đo hiệu năng; k6 vs JMeter | S3 / M5 | So sánh tài nguyên công cụ |
| **GĐ6** 🤖 Sinh kịch bản bằng AI + Audit | prompt LLM từ `fake-server.log` → audit bắt lỗi | S3 / M4 | **[AI-02] Audit Report**, `prompts_log.md` |
| **GĐ7** 📊 Đo scale thật 50/500 VU | baseline 50 VU + spike 500 VU, `LOADTEST=1` | S3 / M5 | **`SLO_Report.md`** (p50/p95/p99) |

> **Cách chạy đo thật (GĐ7):**
> ```bash
> # Terminal 1 — backend, PHẢI có LOADTEST=1
> cd eshop/backend && npm install && LOADTEST=1 node server.js
> # Terminal 2 — chạy k6 (cần cài k6 trước)
> BASE_URL=http://localhost:3000 ./scripts/run-baseline.sh
> BASE_URL=http://localhost:3000 ./scripts/run-spike.sh
> ```

---

## 9. CÒN PHẢI LÀM GÌ / CẢI THIỆN THÊM (gap analysis)

### 🔴 Bắt buộc (ăn/mất điểm trực tiếp)
1. **Cài k6** (máy hiện chưa có) → chạy GĐ7 → điền số thật vào `SLO_Report.md`
   (baseline + spike, đủ p50/p95/p99 + error rate).
2. **Thực hiện GĐ6 (trụ cột AI):** prompt LLM sinh script từ `fake-server.log`, lưu vào
   `ai/prompts/prompts_log.md`, rồi viết **[AI-02]** với ≥ 4 phát hiện audit thật (đối chiếu
   checklist trong `load-tests/k6/realistic-shopping.ai.js`).
3. **Viết đầy `User_Guide.md`** (20% điểm — cao nhất) — đặc biệt **mục Failure Modes** (lấy
   từ Mục 7 file này: rate limiter, plaintext pw, JWT no-expiry là 3 mode chắc ăn).
4. **Hoàn thiện Activity Worksheet "Workload Model Bake-off"** + **answer key**, test thử
   để chắc chắn ≤ 25 phút.
5. **Quay screencast** 5–8 phút (terminal thật, English, không nhạc nền, ≤ 100MB).
6. **Slide ≤ 15** + phân vai (presenter/demoer/facilitator/timekeeper).
7. **[AI-03] Disclosure** ký tên PDF từng người + **[AI-04]** reflection 300 từ.

### 🟡 Nên làm để "wow"
- Chạy thử `.jmx` trong JMeter GUI 1 lần → rồi chạy headless `-n -e -o` → **bảng so sánh
  k6 vs JMeter** (latency + tài nguyên) cho GĐ5.
- Vẽ biểu đồ latency theo thời gian ở spike (điểm gãy) — trực quan hóa cho slide.
- Chuẩn bị sẵn **câu hỏi Q&A khó** + câu trả lời (ví dụ: "vì sao SQLite là nút thắt?",
  "AI sinh script sai ở đâu và làm sao phát hiện?").
- Điền thông tin team + MSSV vào `README.md`.

### ⚪ Ghi chú quản trị
- 3 file brief gốc (`.docx/.pdf`) trong `requirments/` hiện **chưa commit** (mình để bạn tự
  quyết vì là tài liệu của giảng viên). `plan-study.md` và `sandbox_spec.md` đã được track.
- `database.sqlite` đang được git track — cân nhắc thêm vào `.gitignore` vì nó là dữ liệu
  runtime (mỗi lần chạy sẽ đổi), tránh commit nhầm dữ liệu test.

---

## 10. "DEFINITION OF DONE" — Checklist trước khi lên seminar

- [ ] Cả 4 thành viên tự chạy được k6 + JMeter trên EShop mà **không cần trợ giúp**.
- [ ] `SLO_Report.md` có số baseline + spike thật (p50/p95/p99 + error rate).
- [ ] User Guide đủ 7 mục, **có Failure Modes ≥ 3**, tiếng Anh, bước tái lập được.
- [ ] Demo E2E chạy thật + có **cả feature truyền thống lẫn AI**.
- [ ] Activity worksheet test thực tế xong trong ≤ 25 phút, có answer key.
- [ ] Screencast đúng spec (5–8', 1080p, ≤100MB, English, no music).
- [ ] Slide ≤ 15, đã phân vai, có bản demo dự phòng.
- [ ] [AI-02] ≥ 600 từ/5 mục · [AI-03] ký PDF · [AI-04] 300 từ · `prompts_log.md` đầy đủ.
- [ ] Đã cross-check chéo toàn nhóm (bảng cuối `plan-study.md`).

---

*Cập nhật lần cuối: 2026-07-14. Khi số liệu/route EShop thay đổi, verify lại Mục 7 trước khi trích dẫn.*
