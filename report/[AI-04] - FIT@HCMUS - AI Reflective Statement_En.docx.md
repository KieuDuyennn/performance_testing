# Faculty of Information Technology (FIT) – Ho Chi Minh City University of Science (HCMUS)

## CS423 / CSC13003 – Software Testing (AI-augmented · 2026)

### AI POLICY · TEMPLATES — 2026 v1.0

# Reflective AI Use Statement — Seminar (Team Edition)

*For major Seminars. Required when submitting at AI Category 4 or 5. Consistent with the AI Audit Report ([AI-02]) and the AI Use Disclosure Form ([AI-03]).*

*Adapted from Med Kharbach, PhD (2026) — AI Use Policy Templates for Higher Education. CC BY-NC-SA 4.0. This adaptation is prepared for FIT@HCMUS – CS423 / CSC15003 Software Testing course. The individual-assignment template has been adapted for a team seminar reflection, per course guidance that Seminar Track work is reflected on at the team level.*

---

## 1. Project & Team Info

| Field | Value |
|---|---|
| **Course:** | CS423 / CSC13003 – Software Testing |
| **Project / Seminar title:** | T05 — Performance Testing |
| **Team:** | Team 09 |
| **Submission date:** | 2026-07-15 |

### Team Members

| Student ID | Full Name |
|---|---|
| 23127006 | Trần Nguyễn Khải Luân |
| 23127128 | Nguyễn Thành Tiến |
| 23127179 | Nguyễn Bảo Duy |
| 23127184 | Lê Phạm Kiều Duyên |

---

## 2. Reflection Questions

### 1. How did AI support the team's work?

Throughout the seminar, the team used AI most heavily at the points where a large document had to move from a blank page to a structured first draft: the seminar report's overall structure, the comparison behind the k6/JMeter tool selection, the reference list, and several User Guide sections (system introduction, first end-to-end test walkthrough, advanced tool configuration, failure-mode analysis). In each case, AI produced a usable starting structure quickly, which let the team spend its own time on checking and refining content rather than staring at an empty document. AI also assisted in designing and refining the Live Demo script for the fixed seminar time slot, and in working through configuration steps for JMeter and k6 (such as how each tool should handle authentication and workload staging). AI did not generate any experimental measurement; those came from actual tool execution, and AI's role there was limited to helping the team review and phrase the interpretation of results already obtained.

---

### 2. What did the team accept, reject, or revise from AI outputs?

The team accepted the overall report structure, the tool-comparison rationale, and the reference list largely as drafted, since these did not depend on claims about the specific system under test. Several User Guide sections required revision: the explanation of the database's concurrency behavior was rewritten after the team checked it against the actual project configuration, the first test walkthrough was rebuilt around the system's real authentication mechanism after an initial draft assumed the wrong one, and the advanced configuration section needed corrected terminology for how each tool's extension mechanism actually works. One proposed failure-mode explanation was rejected outright — it attributed a performance symptom to the wrong underlying cause — and was replaced with an explanation the team could confirm directly. The Live Demo script's first timeline was also revised after the team noticed it did not fit inside the fixed time slot.

---

### 3. What errors, biases, or limitations did the team notice in the AI outputs?

The most consistent pattern was that AI tended to answer confidently even when a claim was specific to the system under test and had not actually been checked — for example, describing how the database would behave under concurrent load, or which authentication mechanism the backend used, before that behavior had been confirmed against the real implementation. AI also occasionally treated two different tools as more interchangeable than they are, describing one tool's extension mechanism in terms that only applied to the other. In one case, AI proposed a plausible explanation for a performance symptom, but the team found a different explanation after checking the implementation. None of these were reasoning failures in an obvious sense — the explanations were fluent and plausible — which is exactly why they needed to be checked rather than trusted at face value.

---

### 4. How did the team verify information, sources, or claims provided by AI?

Every AI-drafted technical claim about the system under test was checked against the project's actual implementation before it was written into a deliverable. Claims about tool behavior or configuration were checked against official documentation for that tool, and claims about scope or requirements were checked against the seminar brief. For at least one deliverable, the team used a second AI tool as an independent reviewer before finalizing the content, rather than relying on a single tool's output unquestioned. No AI-generated technical content was included in a submitted deliverable without team review and revision.

---

### 5. What did the team learn through this project that could not have been learned by simply accepting AI output?

The main lesson was that a fluent, well-structured answer is not the same as a correct one, particularly for anything specific to the team's own system rather than general knowledge about a tool or a testing concept. AI was reliable for structure, comparison, and first drafts, and far less reliable the moment a claim depended on details of the actual implementation. Working through the corrections in Sections 2 and 3 above — rather than accepting the first plausible-sounding answer — is what actually built the team's understanding of the system's behavior under load. The principle the team intends to carry forward is simple: treat any AI-generated claim about a specific system as unverified until it has been checked against that system's real implementation, no matter how confident or complete the explanation sounds.

---

## 3. AI Categories Used

Mark all that applied at any stage of the project:

- [ ] Cat. 1 – No AI
- [ ] Cat. 2 – AI for preparation only
- [ ] Cat. 3 – AI for feedback / revision
- [ ] Cat. 4 – AI-assisted production
- [x] Cat. 5 – AI-integrated work

---

## 4. Team Signature

*By signing below, each team member confirms that this reflective statement is honest and accurately represents how AI was used in this project. The team takes full intellectual responsibility for the final submission.*

### Signatures

| Student ID | Full Name | Signature | Date |
|---|---|---|---|
| 23127006 | Trần Nguyễn Khải Luân | | |
| 23127128 | Nguyễn Thành Tiến | | |
| 23127179 | Nguyễn Bảo Duy | | |
| 23127184 | Lê Phạm Kiều Duyên | | |

| Field | Value |
|---|---|
| **Course:** | CS423 / CSC13003 – Software Testing |
| **Instructor:** | Dr. Lâm Quang Vũ, MSc. Trương Phước Lộc |
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
