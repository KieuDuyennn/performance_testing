# Faculty of Information Technology (FIT) – Ho Chi Minh City University of Science (HCMUS)

## CS423 / CSC13003 – Software Testing (AI-augmented · 2026)

### AI POLICY · TEMPLATES — 2026 v1.0

# AI Audit Report — Seminar (Team Edition)

*Mandatory appendix for the Seminar deliverable, Topic T05 — Performance Testing.*

*Adapted from Med Kharbach, PhD (2026) — AI Use Policy Templates for Higher Education. CC BY-NC-SA 4.0. This adaptation is prepared for FIT@HCMUS – CS423 / CSC15003 Software Testing course. The individual-assignment template has been adapted for a team seminar deliverable, per course guidance that Seminar Track work is audited at the team level.*

---

## 1. Team Information

| Field | Value |
|---|---|
| **Team name / number:** | Team 09 |
| **Seminar topic:** | T05 — Performance Testing |
| **Class / Cohort:** | CS423 / CSC15003 — Software Testing |
| **System Under Test (SUT):** | EShop (Node.js + Express + SQLite) |
| **Assignment ID:** | Seminar (S1–S8) — AI-02 Audit Report |
| **Assignment date:** | July 2026 |
| **AI tool(s) used:** | Claude (Claude Code), ChatGPT, Gemini |
| **AI used in this deliverable:** | [x] Yes  [ ] No |

### Team Members

| Student ID | Full Name |
|---|---|
| 23127006 | Trần Nguyễn Khải Luân |
| 23127128 | Nguyễn Thành Tiến |
| 23127179 | Nguyễn Bảo Duy |
| 23127184 | Lê Phạm Kiều Duyên |

---

## 2. Instructions (read before relying on this report)

- This audit consolidates the team's AI-assisted work into **representative engineering artifacts**, organized by the deliverable each artifact belongs to, not by individual prompt history. Repeated review/revision rounds on the same artifact are merged into a single row.
- Each row cites the technical source used to verify the AI's output where applicable (official documentation, RFC, or the EShop source code itself).

---

## 3. Audit Table — Artifact-Centered Review

| # | Artifact | Representative AI Request (Tool) | AI Output | Verdict | Verification & Human Revision |
|---|---|---|---|---|---|
| 1 | Seminar Report — Report Structure | Draft the seminar report structure using the approved project artifacts and course brief, leaving unmeasured results clearly marked. (Claude Code) | A complete section-by-section draft citing verified system facts (rate-limiter behavior, workload configuration, tool references) and marking unmeasured values explicitly rather than inventing them. | VALID | Matches the seminar's rule against inventing metrics; accepted as the report's starting structure. |
| 2 | Seminar Report — Tool Selection | Compare the candidate performance-testing tools listed in the seminar brief and justify the final tool selection. (Claude Code) | A comparison covering all brief-listed candidates, with a selection rationale for k6 (primary) and JMeter (secondary) that avoids claiming either tool is universally superior. | VALID | Matches the brief's requirement for a multi-candidate comparison; tool choice is not graded as "correct/incorrect" per course guidance. |
| 3 | Seminar Report — Scope & Self-Containment | Revise the report so it reads as a self-contained document consistent with the separately-submitted Tool Survey Proposal and User Guide. (Claude Code) | A revised report describing system behavior and design decisions in plain language, with content already owned by the Tool Survey Proposal summarized rather than repeated. | INCOMPLETE → corrected | An earlier pass depended on internal project structure that a reader outside the project could not follow. Rewritten so each section stands on its own. |
| 4 | Seminar Report — Demo Script | Design the Live Demo script for the fixed 10-minute seminar time slot. (ChatGPT for review, Claude Code for implementation) | A Live Demo timeline and script. | INCOMPLETE → corrected | The initial timeline exceeded the available seminar duration and was revised to fit the fixed time slot, with the longer-running scenario started in advance and narrated live. |
| 5 | Seminar Report — References | Compile a working reference list covering the tools, technologies, and testing concepts used in the seminar. (Claude Code) | Approximately 10 IEEE-style references (core performance-testing literature, official JMeter/k6/SQLite/Node/Express documentation, the HAR specification, and the seminar brief). | VALID | All cited sources are real, authoritative, and topically relevant; noted as a working list to be refined before final submission. |
| 6 | User Guide — Introduction (SQLite Concurrency) | Explain the concurrency behavior of the SQLite database used by the system under test. (Gemini for prompt drafting, Claude Code for verification) | AI initially provided a simplified explanation of SQLite concurrency behavior. The team refined it after reviewing the project implementation. | INCOMPLETE → corrected | Verified directly against the project's database configuration and dependency manifest before writing the final explanation. |
| 7 | User Guide — First Test Walkthrough (Authentication) | Design the first end-to-end test walkthrough covering login and authenticated actions. (Gemini for prompt drafting, Claude Code for design and re-verification) | An initial walkthrough assumed cookie-based session management; re-verification against the actual authentication middleware showed the system uses JWT Bearer tokens exclusively. | INVALID → corrected | Reworked both tool walkthroughs to extract and forward the JWT via the appropriate mechanism in each tool, replacing all cookie-based guidance. |
| 8 | User Guide — Advanced Usage (Tooling & Workload Design) | Design the advanced configuration guidance covering workload modeling, tool extensions, and parallel execution for both tools. (Gemini for prompt drafting, Claude Code for design and self-review) | A first draft conflated the two tools' extension mechanisms and omitted a required configuration step for one tool's load-shape support. Self-review also surfaced a data-model issue: reusing one shared test account across many virtual users could have produced inconsistent results. | INCOMPLETE → corrected | Corrected the tool-specific terminology and added the missing configuration step; a pooled-account pattern was designed to avoid the shared-account issue. |
| 9 | User Guide — Failure Modes | Identify realistic failure modes for the system under test, to be documented in the User Guide. (Gemini for prompt drafting, Claude Code for verification) | Of the initially proposed failure modes, most were confirmed against source code and found more specific than first assumed; one proposed mode (attributing a slowdown to the runtime's event loop blocking) was a misdiagnosis of the underlying cause. An additional, previously unproposed mode was found during verification. | INCOMPLETE → corrected | Rewrote all entries to match verified source behavior; the misdiagnosed explanation was discarded rather than published. |

---

## 4. Summary of AI Accuracy

| Metric | Count | Percentage |
|---|---|---|
| **Total AI-generated artifacts audited** | 9 | 100% |
| **VALID (correct, accepted as-is)** | 3 | 33% |
| **INVALID (wrong; rejected before use)** | 1 | 11% |
| **INCOMPLETE (acceptable after edits)** | 5 | 56% |

---

## 5. Conclusion — When should AI be used (or not)?

AI accelerated structural and drafting work well: report scaffolding, tool comparisons, and a working bibliography needed little correction. It was less reliable when asked to state a technical fact about the system under test without first checking the implementation — database concurrency behavior, the authentication mechanism, and specific tool capabilities were each described with more confidence than the evidence supported, and were only caught because the team checked the claim against the actual implementation or official documentation before using it. Recommendation: use AI for scaffolding and first drafts, but verify any claim about the system under test against the real implementation before it goes into a deliverable.

---

## 6. Mandatory Disclosure (paste verbatim)

> "The seminar report and User Guide were initially drafted with AI assistance (Claude / Claude Code, ChatGPT, Gemini); the team reviewed and verified AI-generated technical claims about the system under test against the project implementation and relevant official documentation where applicable, as documented in Section 3 above. Experimental results reported in the final submission reflect real measurements only. The detailed AI Audit Report is attached as [AI-02]. We confirm we did not use AI to generate any artifact listed in the prohibited category."

### Signatures

| Student ID | Full Name | Signature | Date |
|---|---|---|---|
| 23127006 | Trần Nguyễn Khải Luân | Trần Nguyễn Khải Luân_đã ký | 2026-07-15 |
| 23127128 | Nguyễn Thành Tiến | Nguyễn Thành Tiến_đã ký | 2026-07-15 |
| 23127179 | Nguyễn Bảo Duy | Nguyễn Bảo Duy_đã ký | 2026-07-15 |
| 23127184 | Lê Phạm Kiều Duyên | Lê Phạm Kiều Duyên_đã ký | 2026-07-15 |

| Field | Value |
|---|---|
| **Course:** | CS423 / CSC13003 – Software Testing |
| **Instructor:** | Dr. Lâm Quang Vũ,  MSc. Trương Phước Lộc |
| **Seminar:** | T05 — Performance Testing (Team 09) |
| **Date:** | 2026-07-15 |

---

## References

- Kharbach, M. (2026). *AI Use Policy Templates for Higher Education.* CC BY-NC-SA 4.0.
- ISTQB Foundation Level Syllabus (latest version).
- Hardman, P. (2025). *A Post-AI Learning Taxonomy.*
- Fuster Rabella, M. (2025). OECD Education Working Paper No. 338.
- Perkins, M., Roe, J., & Furze, L. (2025). *AI Assessment Scale.*
- Anthropic (2025). *Building reliable AI test agents* — engineering blog.
- DeepEval & Promptfoo documentation — testing frameworks for LLM systems.
