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
the team study roadmap (rows 1-7 of each table), then took on specific team
deliverables (rows 8-9). Some tasks were done in pairs.

### Lê Phạm Kiều Duyên

| # | Date | Task | Output | Status |
|---|---|---|---|---|
| 1 | 2026-07-14 | GD1: k6 test lifecycle (init/setup/default/teardown) + 1-VU smoke test against `/api/products` | personal sandbox script | Done |
| 2 | 2026-07-14 | GD2: HAR capture + JWT correlation in k6, `SharedArray` keyword parameterization | `04_Source_Code/load-tests/k6/baseline.js`, keyword data file | Done |
| 3 | 2026-07-14 | GD3: full user journey (login, search, product detail, cart) in k6 and JMeter | `04_Source_Code/load-tests/k6/baseline.js`, `04_Source_Code/load-tests/jmeter/eshop-perf.jmx` | Done |
| 4 | 2026-07-14 | GD4: failure-mode isolation (auth-fail lockout, DB write-lock stress) against EShop's real traps | failure-mode trap list (documented in the User Guide Failure Modes section) | Done |
| 5 | 2026-07-14 | GD5: JMeter GUI vs non-GUI (`-n -e -o`) comparison | personal sandbox run | Done |
| 6 | 2026-07-14 | GD6: reviewed the AI-generated "realistic shopping" script for correctness before use | `04_Source_Code/load-tests/k6/realistic-shopping.ai.js` | Done |
| 7 | 2026-07-15 | GD7: real-scale measurement, 50 VU baseline + 50 to 500 VU spike with `LOADTEST=1` | `01_Report/S1_Tool_Survey_and_SLO_Extract.md` Part B | Done |
| 8 | 2026-07-14 | Set up the project repo (S1-S8 structure, k6/JMeter folders), integrated the EShop source, hardened it against XSS/SQL injection, and added the `LOADTEST=1` rate-limiter bypass | project scaffold, `04_Source_Code/eshop/backend/server.js` | Done |
| 9 | 2026-07-14 | Wrote the team study roadmap, the sandbox spec, and the master requirements brief consolidating all instructor requirements | team planning documents | Done |

### Trần Nguyễn Khải Luân

| # | Date | Task | Output | Status |
|---|---|---|---|---|
| 1 | 2026-07-14 | GD1: k6 test lifecycle + 1-VU smoke test against `/api/products` | personal sandbox script | Done |
| 2 | 2026-07-14 | GD2: HAR capture + JWT correlation, keyword parameterization | personal sandbox exercise | Done |
| 3 | 2026-07-14 | GD3: full user journey (login, search, product detail, cart) in k6 and JMeter | personal sandbox exercise | Done |
| 4 | 2026-07-14 | GD4: failure-mode isolation against EShop's real traps | contributed observations to the trap list | Done |
| 5 | 2026-07-14 | GD5: JMeter GUI vs non-GUI comparison | personal sandbox run | Done |
| 6 | 2026-07-15 | GD6: reviewed the AI-generated script draft | review notes fed into the audit | Done |
| 7 | 2026-07-15 | GD7: real-scale measurement, 50 VU baseline + 50 to 500 VU spike | `01_Report/S1_Tool_Survey_and_SLO_Extract.md` Part B | Done |
| 8 | 2026-07-15 | Validated the JMeter test plan end-to-end for the Live Demo (paired with Lê Phạm Kiều Duyên) | `04_Source_Code/load-tests/jmeter/eshop-perf.jmx` | Done |
| 9 | 2026-07-15 | Double-checked and updated the report (paired with Nguyễn Bảo Duy): added the environment setup note (5.3), rewrote the bottleneck hypothesis (11.3), and added the Coordinated Omission failure mode with its open-model mitigation (12.4) | `01_Report/Report.md` sections 5.3, 11.3, 12.4 | Done |

### Nguyễn Thành Tiến

| # | Date | Task | Output | Status |
|---|---|---|---|---|
| 1 | 2026-07-14 | GD1: k6 test lifecycle + 1-VU smoke test against `/api/products` | personal sandbox script | Done |
| 2 | 2026-07-14 | GD2: HAR capture + JWT correlation, keyword parameterization | personal sandbox exercise | Done |
| 3 | 2026-07-14 | GD3: full user journey (login, search, product detail, cart) in k6 and JMeter | personal sandbox exercise | Done |
| 4 | 2026-07-14 | GD4: failure-mode isolation against EShop's real traps | Failure Modes section of the User Guide | Done |
| 5 | 2026-07-14 | GD5: JMeter GUI vs non-GUI comparison | personal sandbox run | Done |
| 6 | 2026-07-15 | GD6: reviewed the AI-generated script draft and logged the prompts used across the team | `05_AI_Audit_Pack/prompts/prompts_log.md` | Done |
| 7 | 2026-07-15 | GD7: real-scale measurement, 50 VU baseline + 50 to 500 VU spike | `01_Report/S1_Tool_Survey_and_SLO_Extract.md` Part B | Done |
| 8 | 2026-07-15 | Wrote and exported the User Guide (Markdown + PDF, 7 sections including Failure Modes) | `01_Report/User_Guide.md`, `01_Report/User_Guide.pdf` | Done |
| 9 | 2026-07-15 | Compiled the AI Audit prompt records used to build the audit table in [AI-02] | `05_AI_Audit_Pack/prompts/prompts_log.md` | Done |

### Nguyễn Bảo Duy

| # | Date | Task | Output | Status |
|---|---|---|---|---|
| 1 | 2026-07-14 | GD1: k6 test lifecycle + 1-VU smoke test against `/api/products` | personal sandbox script | Done |
| 2 | 2026-07-14 | GD2: HAR capture + JWT correlation, keyword parameterization | personal sandbox exercise | Done |
| 3 | 2026-07-14 | GD3: full user journey (login, search, product detail, cart) in k6 and JMeter | personal sandbox exercise | Done |
| 4 | 2026-07-14 | GD4: failure-mode isolation against EShop's real traps | contributed observations to the trap list | Done |
| 5 | 2026-07-14 | GD5: JMeter GUI vs non-GUI comparison | personal sandbox run | Done |
| 6 | 2026-07-15 | GD6: reviewed the AI-generated script draft and wrote up the audit findings | `05_AI_Audit_Pack/[AI-02] - FIT@HCMUS - AI Audit Report_En.docx.md` | Done |
| 7 | 2026-07-15 | GD7: real-scale measurement, 50 VU baseline + 50 to 500 VU spike | `01_Report/Report.md` section 11 | Done |
| 8 | 2026-07-15 | Wrote the 15-section seminar report | `01_Report/Report.md` | Done |
| 9 | 2026-07-15 | Wrote the official FIT@HCMUS AI-02/AI-03/AI-04 declaration forms and the reference list | `05_AI_Audit_Pack/[AI-02]/[AI-03]/[AI-04] ...docx.md` | Done |

### Shared team tasks

| Date | Task | Output | Status |
|---|---|---|---|
| 2026-07-15 | Baseline and spike measurements (k6 + JMeter) consolidated into the report | `01_Report/Report.md` section 11, `01_Report/S1_Tool_Survey_and_SLO_Extract.md` Part B | Done |
| 2026-07-15 | `Demo_Screencast.mp4` (5-8 min, English, real terminal) | external link in `03_Demo_Video/` | Done |
| 2026-07-15 | Built the seminar slide deck | `02_Slides/Performance_Testing.pptx` | Done |
| Before the seminar | Rehearse the 45-minute seminar flow (pitch, live demo, activity, Q&A) with assigned roles | | Planned |
