# T05 Performance Testing, Team 09: Submission Package

**Course:** Software Testing (CS423/CSC15003), FIT, HCMUS
**Topic:** T05 Performance Testing
**SUT:** EShop (Node.js + Express + SQLite)

| Student ID | Full Name |
|---|---|
| 23127006 | Trần Nguyễn Khải Luân |
| 23127128 | Nguyễn Thành Tiến |
| 23127179 | Nguyễn Bảo Duy |
| 23127184 | Lê Phạm Kiều Duyên |

## Package Contents

| Folder | Contents |
|---|---|
| `01_Report/` | `Report.md` (15-section seminar report), `User_Guide.md` + `User_Guide.pdf` (7 sections including Failure Modes), `S1_Tool_Survey_and_SLO_Extract.md` (tool survey with 5-criteria comparison matrix, and the SLO report) |
| `02_Slides/` | `Performance_Testing.pptx` + `.pdf` (seminar slide deck) |
| `03_Demo_Video/` | Demo screencast (external link in `README_demo_video.md`) |
| `04_Source_Code/` | `eshop/` (the system under test; `npm install` inside `eshop/backend` to run), `load-tests/` (k6 scripts and the JMeter test plan), `scripts/` (baseline/spike runners) |
| `05_AI_Audit_Pack/` | `[AI-02]` AI Audit Report, `[AI-03]` AI Disclosure Form, `[AI-04]` Reflective Statement (markdown + signed PDF for each), and `prompts/` (prompts log with raw session transcripts) |
| `06_Activity_And_Feedback/` | `S5_Activity_Worksheet.md` (in-class "Workload Model Bake-off" with answer key), `S7_Audience_Feedback_Aggregated.md` (minute-paper form), `S8_Final_Reflection.md`, `team_log.md` (S3 study log) |

## Running the Load Tests

```bash
# Terminal 1: start the backend with the rate limiter bypassed
# (without LOADTEST=1 the 200 req/15min limiter turns any 50+ VU run into HTTP 429s)
cd 04_Source_Code/eshop/backend && npm install && LOADTEST=1 node server.js

# Terminal 2: run the scenarios (k6 required)
cd 04_Source_Code
BASE_URL=http://localhost:3000 ./scripts/run-baseline.sh   # 50 VU baseline
BASE_URL=http://localhost:3000 ./scripts/run-spike.sh      # 50 -> 500 VU spike
```

The k6 scripts authenticate in `setup()` with the seed account `test@eshop.com` /
`Test1234!` and reuse the token across VUs.

## Reading Order

1. `01_Report/Report.md` for the full study: fundamentals, workload model, methodology, results, tool evaluation.
2. `01_Report/User_Guide.md` for the reproducible k6/JMeter walkthroughs on EShop.
3. `05_AI_Audit_Pack/` for how AI was used, audited, and disclosed.
4. `06_Activity_And_Feedback/S5_Activity_Worksheet.md` for the in-class activity.
