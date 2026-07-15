# Red Team Audit - Performance Testing (T05)

Dưới góc nhìn của một Performance Test Architect thuộc top 0.1% trong ngành, cách tiếp cận hiện tại của báo cáo này đang mắc phải một sai lầm chết người mà giới chuyên gia gọi là: **"Đi tìm sự hoàn hảo trong một phương pháp luận sai lệch" (Garbage In, Garbage Out).**

## 1. Góc nhìn của Top 0.1% Architect về báo cáo này

**Thứ nhất: Các con số của bạn hoàn toàn vô nghĩa (Meaningless Metrics)**
Trong mục 13.1 (Limitations), báo cáo thừa nhận: *"The tests were run on a single local machine, with the load generator and the EShop backend sharing the same host"*. 
Chuyên gia sẽ cười vào điều này. Khi bạn chạy k6/JMeter, Node.js Backend, và SQLite trên **cùng một máy**, chúng đang cắn xé lẫn nhau để tranh giành CPU, RAM và Thread của OS. Khi Latency tăng từ 210ms lên 1.45s ở mức 500 VUs, làm sao bạn chứng minh được đó là do hệ thống EShop bị nghẽn, hay do **chính máy bơm tải (k6/JMeter) của bạn bị hết CPU và bị OS bắt đợi (Context Switching)**? Bạn đang "Load Test hệ điều hành của bạn" chứ không phải Load Test hệ thống EShop!

**Thứ hai: Bạn đang "Đoán mò" điểm nghẽn chứ không hề Đo lường (Guessing vs. Profiling)**
Trong mục 11.3 (Result Analysis), nhóm bạn kết luận rất hùng hồn: *"Primary bottleneck: Write contention on SQLite's single database connection"* chỉ dựa trên logic là "Error rate thấp, Latency cao, kiến trúc có 1 kết nối ghi nên chắc chắn là nó". 
Đối với dân Pro, đây là kết luận vô căn cứ. Không có một biểu đồ CPU Utilization nào. Không có số liệu về Event Loop Lag của Node.js. Chuyện gì xảy ra nếu điểm nghẽn thực sự nằm ở hàm băm mật khẩu `bcrypt` lúc Login chặn đứng Event Loop (đặc trưng của Node.js)? Bạn không có số liệu Throughput (RPS), không có Resource Metrics, mọi kết luận về Bottleneck chỉ là "chém gió kỹ thuật".

**Thứ ba: Hiểu sai hoàn toàn về "Bẫy của công cụ" (Failure Modes of Load Testing Tools)**
Giảng viên yêu cầu tìm "Bẫy" của công cụ (ví dụ: công cụ có thể đánh lừa người dùng thế nào). Mục 12 (Tool Evaluation) của bạn lại đi so sánh... GUI của JMeter và k6 viết bằng Code. Đây là so sánh UI/UX, không phải Bẫy! 
Bẫy thực sự (Failure mode) của JMeter và k6 mà top 0.1% quan tâm là hiện tượng **Coordinated Omission (Bỏ sót phối hợp)**: Khi server phản hồi chậm, k6/JMeter sẽ tự động gửi request chậm lại (vì các virtual user bị kẹt lại chờ response). Kết quả là báo cáo sẽ cho ra một con số Latency rất đẹp và Throughput thấp đi, che giấu sự thật rằng hàng ngàn user thực tế bên ngoài đã bị timeout. Báo cáo của bạn hoàn toàn trắng tay ở phần này.

---

## 2. Các câu hỏi làm rõ (Đến khi tôi tự tin 95% có thể Audit xuất sắc)

Trước khi tôi bắt đầu viết danh sách các lỗi chi tiết (Bullet points) để mổ xẻ báo cáo này theo yêu cầu Red Team của bạn, tôi cần bạn trả lời thẳng thắn 4 câu hỏi cốt lõi sau để khoanh vùng "sự thật" của đồ án:

### Câu 1: Bản chất của các con số trong `report.md`
Trong file `Report_Update_Guide.md` có ghi chú: *"report.md currently contains a golden sample... invented experimental results."* 
Vậy các con số `p95 = 210ms`, `spike = 1.45s` đang nằm trong báo cáo hiện tại **là số chạy thật (Real data) hay chỉ là số tự bịa ra để giữ chỗ (Dummy data)?** Nếu là số tự bịa, việc tôi dùng định luật Little (Little's Law) để bóc phốt mâu thuẫn giữa VU, RPS và Latency sẽ trở nên vô nghĩa vì ngay từ đầu số đã được gõ bằng tay.

> **Trả lời Câu 1 của bạn:**
> 
> [Điền câu trả lời của bạn vào đây...]


### Câu 2: Cờ `LOADTEST=1` và Rate Limiter
Trong file `00_Seminar_Master_Brief.md` của giảng viên có cảnh báo cực mạnh về bẫy **Rate Limiter (200 req/15min)**. Nếu không bypass nó, 500 VUs sẽ tạo ra một biển lỗi HTTP 429. 
Tuy nhiên, báo cáo `report.md` của bạn ghi nhận Spike 500 VUs mà Error Rate chỉ có **0.6%**. Bạn đã thực sự tắt Rate Limiter khi chạy test chưa? Tại sao trong báo cáo chính không hề có một dòng nào nhắc đến việc hệ thống đã bị chỉnh sửa (bypass Rate Limiter) để phục vụ việc test? Đây là một lỗi Academic Integrity cực lớn.

> **Trả lời Câu 2 của bạn:**
> 
> [Điền câu trả lời của bạn vào đây...]


### Câu 3: Mức độ "chém gió" được cho phép
Đối với lỗi "Kết luận SQLite write-lock mà không có bằng chứng giám sát tài nguyên (CPU/RAM/Disk IO)", bạn muốn tôi:
- *Option A:* Hướng dẫn cách "viết lách" lại để nghe có vẻ hợp lý và logic hơn (chấp nhận đây là đồ án môn học, không có server xịn để monitor).
- *Option B:* Yêu cầu bắt buộc bổ sung số liệu giám sát (ví dụ cài `pm2` hoặc `clinic.js` để bắt Event Loop Lag) vào báo cáo?

> **Trả lời Câu 3 của bạn:**
> 
> [Điền câu trả lời của bạn vào đây...]


### Câu 4: Về dấu vết của AI (Traceability)
Trong file `[AI-02]` có nói AI từng nhầm lẫn về **Cookie vs JWT** và **hành vi của SQLite**. Bạn muốn tôi chỉ rà soát file `report.md` hiện tại xem còn sót chữ "Cookie" nào không, hay tôi phải đọc cả source code script của k6 (nếu có) để xem các bạn có thực sự parse token JWT từ response body và bỏ vào header `Authorization: Bearer <token>` đúng cách chưa?

> **Trả lời Câu 4 của bạn:**
> 
> [Điền câu trả lời của bạn vào đây...]


---
*Sau khi bạn điền xong các câu trả lời trên, hãy lưu file lại và báo cho tôi biết để tôi tiến hành Red Team Audit toàn diện nhé!*
