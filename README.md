# EShop Performance Seminar T05

Seminar project scaffold for **Software Testing (CS423/CSC15003, FIT HCMUS)**.

- Topic: **T05: Performance Testing**
- SUT: **EShop backend (Node.js + SQLite)**
- Traditional tools: **k6 (primary)** and **Apache JMeter (secondary)**
- AI direction: Use an LLM to draft realistic k6 shopping scenarios from HTTP logs, then audit and refine the script

## Team

| Member | Student ID | Role |
|---|---|---|
| Lê Phạm Kiều Duyên | 23127184 | Coordinator |
| Trần Nguyễn Khải Luân | 23127006 | Test Engineer |
| Nguyễn Thành Tiến | 23127128 | Documentation Lead |
| Nguyễn Bảo Duy | 23127179 | Data & Reporting |

## SLO Targets

- **p95 latency < 500 ms**
- **error rate < 1%**

## Deliverables (S1-S8)

Stage numbers and file paths match `docs/00_Seminar_Master_Brief.md` section 3, the
authoritative deliverables table synthesized from the instructor's own documents.

| Deliverable | File | Status |
|---|---|---|
| S1: Tool Survey & Proposal | `report/S1_Tool_Survey_and_SLO_Extract.md` (Part A) | Done |
| S3: Team Study Log | `docs/team_log.md` | Done |
| S4: User Guide | `docs/User_Guide.md` (+ `.pdf`) | Done |
| S4: Demo Screencast | `media/README.md` + external link | Done |
| S5: Activity Worksheet | `docs/S5_Activity_Worksheet.md` | Done |
| S6: Seminar Slides | `submission/02_Slides/Performance_Testing.pptx` | Done |
| S7: Audience Feedback | `docs/S7_Audience_Feedback_Aggregated.md` | Done (form ready; aggregation filled after the live seminar) |
| S8: AI Audit / Disclosure / Reflection | `report/[AI-02]/[AI-03]/[AI-04] - FIT@HCMUS ...docx.md` | Done |
| S8: Final Reflection | `docs/S8_Final_Reflection.md` | Done |
| SLO Report (baseline/spike numbers) | `report/report.md` section 11 + `report/S1_Tool_Survey_and_SLO_Extract.md` Part B | Done |

## Quick Start

```bash
# 1) Start the backend WITH the rate limiter bypassed (required for load tests).
#    Without LOADTEST=1, the /api limiter (200 req/15min) turns any 50+ VU run
#    into a wall of HTTP 429s and every SLO number becomes meaningless.
cd eshop/backend && npm install && LOADTEST=1 node server.js

# 2) In another terminal, run the scenarios (k6 must be installed):
# baseline (50 VU, 5 min)
BASE_URL=http://localhost:3000 ./scripts/run-baseline.sh

# spike (50 -> 500 VU in 30s)
BASE_URL=http://localhost:3000 ./scripts/run-spike.sh
```

> The k6 scripts authenticate in `setup()` using the seed account
> `test@eshop.com` / `Test1234!` and reuse the token across VUs. Override with
> `-e TEST_EMAIL=... -e TEST_PASSWORD=...` if you change the seed.

## Repository Layout

Key directories:

- `/load-tests/k6`: k6 scripts and shared config
- `/load-tests/jmeter`: JMeter equivalent guidance
- `/load-tests/data`: input artifacts for AI-assisted scenario generation
- `/load-tests/reports`: result templates and exported summaries
- `/ai`: AI audit/disclosure artifacts
- `/docs`: seminar deliverable documents
