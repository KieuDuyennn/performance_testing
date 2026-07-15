# Team Log (S3)

Track milestone progress for M1-M5.

## Milestone Checklist

- [x] M1: Scope alignment and role assignment
- [x] M2: Environment setup and SUT sanity checks
- [x] M3: Baseline + spike script draft and dry run
- [x] M4: AI-generated scenario audit and corrections
- [x] M5: Reporting, slides, and rehearsal

## Worklog

Every member individually completed the personal study path GD1-GD7 defined in
`requirments/plan-study.md` (rows 1-7 of each table), then took on specific team
deliverables (rows 8-9). Some tasks were done in pairs.

### Lê Phạm Kiều Duyên

| # | Date | Task | Output | Status |
|---|---|---|---|---|
| 1 | 2026-07-14 | GD1: k6 test lifecycle (init/setup/default/teardown) + 1-VU smoke test against `/api/products` | personal sandbox script | Done |
| 2 | 2026-07-14 | GD2: HAR capture + JWT correlation in k6, `SharedArray` keyword parameterization | `load-tests/k6/baseline.js`, `docs/logs/search_keywords.json` | Done |
| 3 | 2026-07-14 | GD3: full user journey (login, search, product detail, cart) in k6 and JMeter | `load-tests/k6/baseline.js`, `load-tests/jmeter/eshop-perf.jmx` | Done |
| 4 | 2026-07-14 | GD4: failure-mode isolation (auth-fail lockout, DB write-lock stress) against EShop's real traps | trap list in `docs/00_Seminar_Master_Brief.md` section 7 | Done |
| 5 | 2026-07-14 | GD5: JMeter GUI vs non-GUI (`-n -e -o`) comparison | personal sandbox run | Done |
| 6 | 2026-07-14 | GD6: reviewed the AI-generated "realistic shopping" script for correctness before use | `load-tests/k6/realistic-shopping.ai.js` | Done |
| 7 | 2026-07-15 | GD7: real-scale measurement, 50 VU baseline + 50 to 500 VU spike with `LOADTEST=1` | `report/S1_Tool_Survey_and_SLO_Extract.md` Part B | Done |
| 8 | 2026-07-14 | Set up the project repo (S1-S8 structure, k6/JMeter folders), integrated the EShop source, hardened it against XSS/SQL injection, and added the `LOADTEST=1` rate-limiter bypass | repo scaffold, `eshop/backend/server.js` | Done |
| 9 | 2026-07-14 | Wrote the study roadmap (`requirments/plan-study.md`), the sandbox spec, and the master brief consolidating all instructor requirements | `docs/00_Seminar_Master_Brief.md` | Done |

### Trần Nguyễn Khải Luân

| # | Date | Task | Output | Status |
|---|---|---|---|---|
| 1 | 2026-07-14 | GD1: k6 test lifecycle + 1-VU smoke test against `/api/products` | personal sandbox script | Done |
| 2 | 2026-07-14 | GD2: HAR capture + JWT correlation, keyword parameterization | personal sandbox exercise | Done |
| 3 | 2026-07-14 | GD3: full user journey (login, search, product detail, cart) in k6 and JMeter | personal sandbox exercise | Done |
| 4 | 2026-07-14 | GD4: failure-mode isolation against EShop's real traps | contributed observations to the trap list | Done |
| 5 | 2026-07-14 | GD5: JMeter GUI vs non-GUI comparison | personal sandbox run | Done |
| 6 | 2026-07-15 | GD6: reviewed the AI-generated script draft | review notes fed into the audit | Done |
| 7 | 2026-07-15 | GD7: real-scale measurement, 50 VU baseline + 50 to 500 VU spike | `report/S1_Tool_Survey_and_SLO_Extract.md` Part B | Done |
| 8 | 2026-07-15 | Validated the JMeter test plan end-to-end for the Live Demo (paired with Lê Phạm Kiều Duyên) | `load-tests/jmeter/eshop-perf.jmx` | Done |
| 9 | 2026-07-15 | Double-checked and updated the report (paired with Nguyễn Bảo Duy): added the environment setup note (5.3), rewrote the bottleneck hypothesis (11.3), and added the Coordinated Omission failure mode with its open-model mitigation (12.4) | `report/report.md` sections 5.3, 11.3, 12.4 | Done |

### Nguyễn Thành Tiến

| # | Date | Task | Output | Status |
|---|---|---|---|---|
| 1 | 2026-07-14 | GD1: k6 test lifecycle + 1-VU smoke test against `/api/products` | personal sandbox script | Done |
| 2 | 2026-07-14 | GD2: HAR capture + JWT correlation, keyword parameterization | personal sandbox exercise | Done |
| 3 | 2026-07-14 | GD3: full user journey (login, search, product detail, cart) in k6 and JMeter | personal sandbox exercise | Done |
| 4 | 2026-07-14 | GD4: failure-mode isolation against EShop's real traps | Failure Modes section of the User Guide | Done |
| 5 | 2026-07-14 | GD5: JMeter GUI vs non-GUI comparison | personal sandbox run | Done |
| 6 | 2026-07-15 | GD6: reviewed the AI-generated script draft and logged the prompts used across the team | `ai/prompts/prompts_log.md` | Done |
| 7 | 2026-07-15 | GD7: real-scale measurement, 50 VU baseline + 50 to 500 VU spike | `report/S1_Tool_Survey_and_SLO_Extract.md` Part B | Done |
| 8 | 2026-07-15 | Wrote and exported the User Guide (Markdown + PDF, 7 sections including Failure Modes) | `docs/User_Guide.md`, `docs/User_Guide.pdf` | Done |
| 9 | 2026-07-15 | Compiled the AI Audit prompt records used to build the audit table in [AI-02] | `ai/prompts/prompts_log.md` | Done |

### Nguyễn Bảo Duy

| # | Date | Task | Output | Status |
|---|---|---|---|---|
| 1 | 2026-07-14 | GD1: k6 test lifecycle + 1-VU smoke test against `/api/products` | personal sandbox script | Done |
| 2 | 2026-07-14 | GD2: HAR capture + JWT correlation, keyword parameterization | personal sandbox exercise | Done |
| 3 | 2026-07-14 | GD3: full user journey (login, search, product detail, cart) in k6 and JMeter | personal sandbox exercise | Done |
| 4 | 2026-07-14 | GD4: failure-mode isolation against EShop's real traps | contributed observations to the trap list | Done |
| 5 | 2026-07-14 | GD5: JMeter GUI vs non-GUI comparison | personal sandbox run | Done |
| 6 | 2026-07-15 | GD6: reviewed the AI-generated script draft and wrote up the audit findings | `report/[AI-02] - FIT@HCMUS - AI Audit Report_En.docx.md` | Done |
| 7 | 2026-07-15 | GD7: real-scale measurement, 50 VU baseline + 50 to 500 VU spike | `report/report.md` section 11 | Done |
| 8 | 2026-07-15 | Wrote the 15-section seminar report | `report/report.md` | Done |
| 9 | 2026-07-15 | Wrote the official FIT@HCMUS AI-02/AI-03/AI-04 declaration forms and the reference list | `report/[AI-02]/[AI-03]/[AI-04] ...docx.md` | Done |

### Shared team tasks

| Date | Task | Output | Status |
|---|---|---|---|
| 2026-07-15 | Baseline and spike measurements (k6 + JMeter) consolidated into the report | `report/report.md` section 11, `report/S1_Tool_Survey_and_SLO_Extract.md` Part B | Done |
| 2026-07-15 | `Demo_Screencast.mp4` (5-8 min, English, real terminal) | `media/` + external link | Done |
| 2026-07-15 | Built the seminar slide deck | `submission/02_Slides/Performance_Testing.pptx` | Done |
| Before the seminar | Rehearse the 45-minute seminar flow (pitch, live demo, activity, Q&A) with assigned roles | | Planned |
