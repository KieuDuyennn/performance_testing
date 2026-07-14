# Report Update Guide

> Internal working document for Team 09. Not a seminar deliverable — not referenced by `report/report.md` itself.

## 1. Purpose

- `report/report.md` currently contains a **golden sample**: complete, internally consistent, but invented experimental results. It exists to fix the report's structure, writing style, and reasoning pattern before real data is available.
- Once the real baseline/spike experiments are run, the report must be rewritten with real numbers while keeping that same structure and reasoning. Doing this by hand risks missing a cross-reference (e.g., updating Section 11 but forgetting the Abstract still quotes the old numbers).
- Using AI with a fixed prompt and a fixed data template makes the update repeatable and consistent, regardless of which team member runs it.
- Anyone on the team should be able to follow this guide without further explanation.

---

## 2. Required Inputs

Collect the following after running the baseline and spike tests in both JMeter and k6.

### 2.1 Test Environment
- CPU
- RAM
- Operating System
- Node.js version
- Apache JMeter version
- k6 version

### 2.2 Baseline Results (50 VU)
For **both** JMeter and k6:
- p50
- p95
- p99
- Error rate

### 2.3 Spike Results (50→500 VU)
For **both** JMeter and k6:
- p50
- p95
- p99
- Error rate

### 2.4 Optional Engineering Notes
Include only what was actually observed — do not guess:
- Observed bottleneck (if one was identified)
- Recovery behavior after the spike
- Unexpected observations during testing
- Notable differences between JMeter and k6 results

---

## 3. Report Sections That Must Be Updated

| Section | Update |
|---|---|
| **1. Abstract** | "Key outcomes" paragraph only — SLO summary for baseline/spike, primary bottleneck, recovery statement |
| **8. Experimental Methodology** | 8.1 Test Environment table only |
| **11. Experimental Results & Analysis** | Full section — metric tables (11.1, 11.2), recovery discussion, bottleneck analysis (11.3) |
| **12. Tool Evaluation** | Full section — Observed Strengths/Limitations per tool, Overall Comparison |
| **14. Conclusion & Recommendations** | Full section — SLO outcome, primary bottleneck, lessons learned, recommendations, future work |

### Do NOT change

Sections 2, 3, 4, 5, 6, 7, 9, 10, and 15 do not depend on experimental results:

- **2 (Team Information), 3 (Introduction), 4 (Fundamentals), 5 (EShop System), 6 (Tool Selection), 7 (Workload Model)** — describe design and background, not outcomes.
- **9 (Demo Script)** — describes the planned live demo flow, not specific measured values.
- **10 (AI-Augmented Performance Testing)** — describes the AI scripting workflow; update only if the team's actual audit findings differ from the sample.
- **15 (References)** — unrelated to results.

**13 (Discussion)** is usually unaffected — its content (local-machine setup, SQLite as an embedded database, load/spike-only scope, workload model as an approximation) holds regardless of the actual numbers. Re-check it only if the real test setup differs from what is described (e.g., a dedicated host was used instead of a shared one).

---

## 4. Update Workflow

**Step 1 — Run the experiments.**
Execute the baseline and spike tests in both JMeter and k6, per Section 8.

**Step 2 — Duplicate the template.**
Copy `report/resources/Experiment_Data_Template.md` to `report/resources/Actual_Experiment_Data.md`.

**Step 3 — Fill in `Actual_Experiment_Data.md`.**
Use the collected measurements (Section 2 of this guide) to fill every field.

- Do not invent values.
- Leave the Engineering Notes blank if something was not actually observed.
- Do not modify the template's structure (field names, section order, or headings).

**Step 4 — Run the Claude prompt.**
Use the prompt in Section 5 to update `report/report.md`.

---

## 5. Standard Claude Prompt

```
Read:
- @report/report.md
- @report/resources/Actual_Experiment_Data.md

Section 11 of report.md currently contains a placeholder ("golden sample") set of experimental results, and Sections 1, 8, 12, and 14 build on it. Replace the golden sample with the real experimental data in Actual_Experiment_Data.md.

Update ONLY:
- Section 1 (Abstract): the "Key outcomes" paragraph
- Section 8.1 (Test Environment table)
- Section 11 (Experimental Results & Analysis): both metric tables and all analysis prose
- Section 12 (Tool Evaluation): strengths, limitations, and overall comparison
- Section 14 (Conclusion & Recommendations): all four subsections

Do NOT:
- change any other section
- change the report's structure, headings, or section numbers
- change the writing style or level of formality
- invent any measurement, observation, or conclusion that is not in Actual_Experiment_Data.md or directly derivable from it
- leave any old sample numbers anywhere in the report

Preserve:
- report structure
- writing style
- reasoning style (e.g., comparing measured values against the SLO in Section 7.6, identifying a bottleneck from the pattern in the data, cross-referencing sections the way the current report does)
- internal consistency — every number and claim in Sections 1, 11, 12, and 14 must agree with each other and with Actual_Experiment_Data.md

If the Engineering Notes in Actual_Experiment_Data.md are blank or incomplete, do not invent a bottleneck, recovery behavior, or tool comparison — describe only what the data supports, or state that a particular observation was not made.
```

---

## 6. Verification Checklist

After Claude finishes, check:

- [ ] Test environment table (8.1) filled in, no `[TODO]` left
- [ ] Baseline table (11.1) matches the collected data
- [ ] Spike table (11.2) matches the collected data
- [ ] Abstract "Key outcomes" matches Section 11's conclusions
- [ ] Section 12 tool evaluation reflects the same numbers as Section 11
- [ ] Section 14 conclusion is consistent with Sections 11 and 12
- [ ] No leftover sample numbers anywhere (e.g. `85 ms`, `210 ms`, `1,450 ms`, `24.6`, `0.6%`)
- [ ] Sections 2–7, 9, 10, 13, 15 unchanged
- [ ] Report structure (all 15 section numbers and headings) unchanged
