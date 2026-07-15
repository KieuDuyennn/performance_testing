# Prompts Log

Audit trail of the AI sessions used across the seminar deliverables. Full raw
transcripts are kept in the `prompts/` folder at the repo root (one subfolder per
member); this table is the index. Artifact-level verdicts and corrections for each of
these sessions are consolidated in `report/[AI-02] - FIT@HCMUS - AI Audit Report_En.docx.md`.

| Date | Purpose | Prompt (summary) | Model | Output Summary | Human Action | Full transcript |
|---|---|---|---|---|---|---|
| 2026-07-08 | Seminar study plan | Provided the instructor's briefing PDFs and the approved S1 proposal, asked for a step-by-step plan to learn and execute the T05 workflow before splitting work among members | Gemini | A staged learning plan for the T05 workflow (tooling setup, scripting, measurement) | Reviewed, restructured into `requirments/plan-study.md`, and re-scoped the stages around EShop's real constraints (rate limiter, SQLite) | `prompts/tien/[TESTING]-Seminar.md` |
| 2026-07-10 | User Guide drafting | Asked for section drafts of the User Guide (installation, first test, advanced usage, failure modes) for k6 + JMeter on EShop | Gemini | Section drafts covering setup, walkthroughs, and candidate failure modes | Every technical claim checked against the EShop source before inclusion; the auth walkthrough was rebuilt around JWT after the draft assumed cookies (see [AI-02] rows 6-9) | `prompts/tien/[TESTING]-User-Guide.md` |
| 2026-07-15 | Seminar report writing | Asked to draft and iteratively revise the 15-section seminar report from the approved project artifacts, leaving unmeasured values explicitly marked | Claude (Claude Code) | A structured report draft citing verified system facts, plus revision passes for self-containment and the demo timeline | Reviewed section by section; the demo timeline was cut down to fit the 10-minute slot and the scope was made self-contained (see [AI-02] rows 1-5) | `prompts/duy/prompt.txt` |
| 2026-07-15 | AI-generated k6 script ("realistic shopping") | Provided `load-tests/data/fake-server.log` and asked for a k6 script reproducing a realistic shopping session | ChatGPT | A first-draft k6 script with a browse/search/cart/checkout flow | Audited against the real API: fixed a non-existent search endpoint, added the missing login/JWT step, added think time, parameterized hard-coded IDs, tightened status assertions (see report.md Section 10.2) | audited result in `load-tests/k6/realistic-shopping.ai.js` |
