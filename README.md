# EShop Performance Seminar T05

Seminar project scaffold for **Software Testing (CS423/CSC15003, FIT HCMUS)**.

- Topic: **T05 — Performance Testing**
- SUT: **EShop backend (Node.js + SQLite)**
- Traditional tools: **k6 (primary)** and **Apache JMeter (secondary)**
- AI direction: Use an LLM to draft realistic k6 shopping scenarios from HTTP logs, then audit and refine the script

## Team

| Member | Student ID | Role |
|---|---|---|
| TODO | TODO | Coordinator |
| TODO | TODO | Test Engineer |
| TODO | TODO | Data & Reporting |

## SLO Targets

- **p95 latency < 500 ms**
- **error rate < 1%**

## Deliverables (S1–S8)

| Deliverable | File | Status |
|---|---|---|
| S1 — Tool Survey & Proposal | `/docs/S1_Tool_Survey_Proposal.md` | TODO |
| S2 — Demo Screencast | `/media/README.md` + external link | TODO |
| S3 — Team Activity Log | `/docs/team_log.md` | TODO |
| S4 — User Guide | `/docs/S4_User_Guide.md` | TODO |
| S5 — Activity Worksheet | `/docs/S5_Activity_Worksheet.md` | TODO |
| S6 — Seminar Slides | `/slides/.gitkeep` + `Seminar_Slides.pptx` | TODO |
| S7 — Audience Feedback | `/docs/S7_Audience_Feedback_Aggregated.md` | TODO |
| S8 — Final Reflection | `/docs/S8_Final_Reflection.md` | TODO |

## Quick Start

```bash
# baseline
BASE_URL=http://localhost:3000 ./scripts/run-baseline.sh

# spike
BASE_URL=http://localhost:3000 ./scripts/run-spike.sh
```

## Repository Layout

Key directories:

- `/load-tests/k6`: k6 scripts and shared config
- `/load-tests/jmeter`: JMeter equivalent guidance
- `/load-tests/data`: input artifacts for AI-assisted scenario generation
- `/load-tests/reports`: result templates and exported summaries
- `/ai`: AI audit/disclosure artifacts
- `/docs`: seminar deliverable documents
