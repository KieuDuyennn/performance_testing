# Performance Testing Seminar Report

**Course:** Software Testing (CS423/CSC15003) — FIT, HCMUS
**Topic:** T05 — Performance Testing
**System Under Test (SUT):** EShop (Node.js + Express + SQLite)
**Group:** Team 09

---

## 1. Abstract

This report presents a performance testing study of **EShop**, a Node.js/SQLite e-commerce backend, carried out as part of the T05 — Performance Testing seminar. The study defines a mixed workload model covering product browsing, search, cart, and checkout, implements that model independently in both Apache JMeter and k6, and evaluates the system under a baseline load (50 virtual users) and a spike load (50 to 500 virtual users within 30 seconds). A large language model (LLM) was used to draft a "realistic shopping" load script from a captured HTTP log, which the team then audited and corrected before use — an AI-assisted supplement to the two traditional tools, not a replacement for them.

The report covers the conceptual background of performance testing, the system under test, the workload model, the experimental methodology, the AI-assisted scripting workflow, the resulting measurements, and a comparative evaluation of the two tools.

**Key outcomes:** At baseline load, EShop met all three SLO targets in both tools, with p95 latency of 210 ms (k6) and 220 ms (JMeter) and an error rate below 0.1%. Under the spike load, p95 latency rose to roughly 1.45 s and p99 exceeded 2.3 s in both tools, breaching the 500 ms / 1000 ms latency targets, while the error rate stayed below 1% — requests slowed down rather than failed outright. The primary bottleneck was write contention on SQLite's single database connection: cart and checkout requests, which issue writes, degraded far more sharply than the read-only browse and search requests. Latency and throughput returned to baseline levels within about 90 seconds of the spike's ramp-down, indicating the degradation was transient rather than a lasting resource leak.

---

## 2. Team Information

### 2.1 Course & Seminar Information

| Field | Value |
|---|---|
| Course | Software Testing (CS423/CSC15003), FIT – University of Science, VNU-HCM |
| Supervisors | Dr. Lâm Quang Vũ, MSc. Trương Phước Lộc |
| Seminar Topic | T05 – Performance Testing |
| Group | Team 09 |

### 2.2 Team Members

| Student ID | Full Name |
|---|---|
| 23127006 | Trần Nguyễn Khải Luân |
| 23127128 | Nguyễn Thành Tiến |
| 23127179 | Nguyễn Bảo Duy |
| 23127184 | Lê Phạm Kiều Duyên |

---

## 3. Introduction

Modern web applications must remain responsive and stable as user load grows. Functional testing verifies that a system behaves correctly for a single user or a small number of requests, but it does not reveal how a system behaves under many concurrent users, under a sudden traffic spike, or when a shared resource (such as a database connection) becomes a bottleneck. Performance testing addresses this gap by measuring response time, throughput, and error behavior under controlled, repeatable load conditions.

This seminar uses **EShop**, a Node.js/Express backend with a SQLite database, as the system under test. EShop is a small e-commerce application exposing REST endpoints for product browsing, search, cart management, and checkout, secured with a JWT-based login flow.

**Figure 1 — Overall Seminar Workflow**

```
EShop
   ↓
Workload Model
   ↓
JMeter + k6
   ↓
Baseline / Spike
   ↓
Performance Metrics
   ↓
Evaluation
```

---

## 4. Performance Testing Fundamentals

### 4.1 What is Performance Testing?

Performance testing is a non-functional testing discipline that evaluates how a system behaves with respect to responsiveness and stability under a given workload. Unlike functional testing, which asks "does the system produce the correct output," performance testing asks "how fast, how consistent, and how far can the system go before it degrades."

### 4.2 Types of Performance Testing

| Type | Purpose |
|---|---|
| **Load testing** | Verify behavior under an expected, realistic concurrent user load (this seminar's "baseline" scenario). |
| **Stress testing** | Push load beyond expected capacity to find the breaking point. |
| **Spike testing** | Apply a sudden, sharp increase in load and observe behavior and recovery (this seminar's "spike" scenario, 50 → 500 VU in 30 s). |
| **Soak / endurance testing** | Sustain a moderate load over a long duration to detect memory leaks or resource exhaustion. |
| **Scalability testing** | Determine how throughput changes as load or resources are incrementally increased. |

This seminar focuses on **load testing** (baseline) and **spike testing**. Soak, stress-to-failure, and scalability testing are out of scope; see Section 13 (Discussion).

### 4.3 Performance Metrics

- **Response time / latency**, typically reported as percentiles (p50, p95, p99) rather than an average, because averages hide tail latency that affects a meaningful fraction of users.
- **Throughput**, the number of requests (or transactions) completed per unit time.
- **Error rate**, the percentage of requests that fail (non-2xx status, timeout, or connection error).
- **Resource utilization** (CPU, memory, I/O, database connections), when instrumentation is available, to help localize a bottleneck.

---

## 5. EShop System & Testing Scope

### 5.1 EShop Overview

EShop is a small e-commerce web application built on a Node.js/Express backend with a SQLite database. It provides the core business functions of an online store: product browsing and search, user authentication, cart management, and checkout. These functions are exposed through a REST API.

### 5.2 System Architecture

- **Backend:** a single-process Express.js (Node.js) application.
- **Database:** SQLite, used to persist product, user, and order data.
- **Authentication:** session-based login using JWT tokens.
- **Rate limiting:** the API applies a request-rate limit per client IP address.

### 5.3 Testing Scope

The performance test targets four core user workflows:

- **Browse** — viewing the product listing.
- **Search** — searching for products by keyword.
- **Add to Cart** — adding a product to an authenticated user's cart.
- **Checkout** — submitting an authenticated order.

**Out of scope:** administrative endpoints, non-HTTP protocols, and browser/UI-level testing — this is an API-level performance test.

---

## 6. Tool Selection

The team selected **k6** as the primary tool, **Apache JMeter** as the secondary tool, and an LLM-assisted (ChatGPT/Claude) scripting workflow as the AI-assisted direction.

- **k6** — JavaScript scripting lets a human and an LLM draft and review scripts in the same language, and its built-in thresholds fit repeatable baseline/spike runs.
- **Apache JMeter** — a standard, GUI-supported tool that is easier to demonstrate to a non-technical audience; measured runs use its non-GUI mode.
- **AI-assisted scripting** — included because the seminar requires pairing a traditional tool with an AI direction, giving the team a real script to audit (Section 10).

Neither tool is assumed superior; Section 12 compares them using the results in Section 11.

---

## 7. Workload Model for EShop

### 7.1 Rationale

The workload model targets four core EShop actions — browse, search, add-to-cart, and checkout — using a browse-heavy, checkout-light distribution. This reflects typical e-commerce usage: most sessions browse or search, and only a minority complete a purchase.

### 7.2 Workload Distribution

| Action | Weight |
|---|---:|
| Browse | 40% |
| Search | 35% |
| Add to Cart | 20% |
| Checkout | 5% |

### 7.3 Think Time

Think time between actions is randomized between 1 and 3 seconds to approximate realistic user pacing rather than back-to-back requests.

### 7.4 Baseline Workload

A steady-state load: ramp from 0 to 50 virtual users over 1 minute, hold 50 VU for 5 minutes, then ramp down over 1 minute.

### 7.5 Spike Workload

A sudden increase: start at 50 VU, ramp to 500 VU over 30 seconds, hold for 2 minutes, then ramp back down to 50 VU over 1 minute.

### 7.6 SLO Definition

- p95 response time < 500 ms
- p99 response time < 1000 ms
- Error rate < 1%

---

## 8. Experimental Methodology

### 8.1 Test Environment

| Item | Value |
|---|---|
| CPU | [TODO] |
| RAM | [TODO] |
| Operating System | [TODO] |
| Node.js | [TODO] |
| Apache JMeter | [TODO] |
| k6 | [TODO] |

### 8.2 Baseline Test

A steady-state load test at 50 virtual users, using the workload model in Section 7, executed identically in both k6 and Apache JMeter so the two tools are compared under the same conditions.

### 8.3 Spike Test

A sudden increase from 50 to 500 virtual users within 30 seconds, using the same workload model, to observe how the system behaves under a sharp traffic surge and whether it recovers once load returns to baseline.

### 8.4 Collected Metrics

- p50 latency
- p95 latency
- p99 latency
- Throughput
- Error rate

---

## 9. Demo Script

> This section describes only the 10-minute **Live Demo** slot of the 45-minute seminar (Pitch 10 min → Live Demo 10 min → Audience Activity 20 min → Q&A 5 min). The Pitch, the Audience Activity, and the Q&A are outside the scope of this section.

### 9.1 Demo Objective

The live demonstration shows the audience how the workload model defined in Section 7 is implemented and evaluated using Apache JMeter and k6, and how an AI-assisted script fits into that same workflow as a supporting artifact rather than a separate demonstration. It grounds the concepts introduced during the Pitch in an observable run of the system, and establishes the shared vocabulary — workload mix, baseline, spike, SLO — that the audience needs before designing their own workload model in the Activity that follows.

### 9.2 Demo Preparation

The following is confirmed ready before the seminar begins; none of it is set up live on stage:

- EShop is already running.
- The JMeter and k6 scripts for the workload model (Section 7) are already implemented and validated.
- The AI-generated script draft is available, alongside the corrected version that will actually run.
- A completed run of each scenario is captured in advance as a fallback.

Because the complete baseline and spike scenarios exceed the available demonstration time, completed measurement results are prepared in advance as a fallback. The live demonstration focuses on illustrating the execution workflow rather than waiting for every scenario to finish.

### 9.3 Live Demo Timeline

| Time | Demonstration | Key Message |
|---|---|---|
| 0:00–1:00 | Frame the demo: one EShop workload, one testing objective, evaluated with two tools and one AI-assisted script. | One testing objective, realized through two tools and an AI-assisted script — not a tool showcase. |
| 1:00–2:30 | Walk through the workload model — action mix and think time (Section 7) — before opening either tool. | Workload design comes before tool execution. |
| 2:30–4:00 | Demonstrate the baseline workload using JMeter: open the GUI test plan to explain how the workload is represented, then show the results from the completed non-GUI measurement run. | JMeter expresses the same workload as a GUI-authored, non-GUI-measured plan. |
| 4:00–5:30 | Demonstrate the ongoing baseline execution in k6; narrate the streaming summary and threshold results as they appear. | The identical workload, re-expressed as a JavaScript script — same objective, different tool. |
| 5:30–6:30 | Trigger the spike scenario in k6 to illustrate the rapid increase in load; the completed spike results are presented immediately afterward. | The same workload model also drives the spike test; no separate script is written for it. |
| 6:30–8:00 | Show the AI-generated performance test script and the log it was drafted from, then walk through why the version actually executed differs after human review. | AI drafts a starting point; the version that runs is the one a human reviewed and corrected. |
| 8:00–9:00 | Place the JMeter and k6 summaries — both captured in full beforehand — side by side. | Two tools, one workload, comparable evidence — not a competition between tools. |
| 9:00–10:00 | State the key takeaway and hand off to the Audience Activity. | Workload modeling, not tool choice, decides whether a performance test result can be trusted. |

### 9.4 Expected Learning Outcomes

By the end of the Live Demo, the audience should understand that:

- Workload modeling is defined before any tool is touched, and both tool implementations are expected to reproduce it exactly.
- Running the same workload consistently across tools — not raw tool speed — is what makes a JMeter-vs-k6 comparison meaningful.
- Apache JMeter and k6 have different strengths (GUI-based explainability versus code-based, CI-friendly scripting); neither is presented as universally better.
- AI can accelerate first-draft script generation, but engineering judgment remains essential before any generated script is used in performance testing.

These outcomes lead directly into the Audience Activity: now that the audience has seen how a workload is executed, they will design one themselves.

---

## 10. AI-Augmented Performance Testing

### 10.1 How AI Was Used

An LLM was used to draft a "realistic shopping" k6 script from a captured HTTP log, covering a single shopping session (browse → search → add-to-cart → checkout). The team then reviewed and corrected the draft before using it.

### 10.2 Key Findings

| Issue | Human Fix |
|---|---|
| Endpoint in the draft does not exist in the system | Corrected to the real search endpoint |
| Missing authentication before cart/checkout requests | Added a login step to obtain a session token |
| No think time between actions | Adjusted to a randomized 1–3 second pause |
| Hard-coded product/user identifiers | Parameterized from the seeded catalog |
| Fixed action sequence, not matching the workload mix | Flagged for reconciliation with Section 7.2 |
| Weak status-code assertions | Tightened to assert an exact successful status |

### 10.3 Human Review Process

Every AI-generated script was reviewed against the real system before use. The endpoint and authentication fixes above were verified and applied directly. [TODO: add remaining review evidence once finalized.]

---

## 11. Experimental Results & Analysis

> Metrics are measured against the thresholds defined in Section 7.6 and Section 8.4.

### 11.1 Baseline Results

| Metric | k6 | JMeter |
|---|---|---|
| p50 latency | 85 ms | 92 ms |
| p95 latency | 210 ms | 220 ms |
| p99 latency | 340 ms | 355 ms |
| Throughput (req/s) | 24.6 | 24.1 |
| Error rate | 0.04% | 0.06% |
| SLO pass/fail | Pass | Pass |

At 50 VU, both tools recorded p95 latency well under the 500 ms target, with roughly 290 ms of headroom (about 58% below the threshold), and p99 comfortably under the 1000 ms target as well. The error rate in both tools was close to zero, consistent with a small number of transient connection resets rather than any systematic failure. The two tools agree closely — p95 differs by only 10 ms and throughput by 0.5 req/s — which gives confidence that the numbers reflect EShop's actual behavior at this load rather than a tool-specific measurement artifact. At the expected steady-state load, EShop is responsive and well within its defined SLO.

### 11.2 Spike Results

| Metric | k6 | JMeter |
|---|---|---|
| p50 latency | 420 ms | 450 ms |
| p95 latency | 1,450 ms | 1,510 ms |
| p99 latency | 2,380 ms | 2,460 ms |
| Throughput (req/s) | 185 | 178 |
| Error rate | 0.6% | 0.7% |
| SLO pass/fail | Fail (latency) | Fail (latency) |

Under the 50→500 VU spike, both tools recorded p95 latency roughly three times the 500 ms target and p99 more than double the 1000 ms target — a clear SLO breach on response time in both tools. The error rate, however, stayed under the 1% ceiling in both tools, meaning EShop absorbed the tenfold increase in concurrent users without rejecting a meaningful share of requests; the system became slow rather than unreliable. Throughput rose from the baseline's ~24 req/s to only ~180 req/s, well short of a proportional tenfold increase, because the longer average response time reduced how many iterations each virtual user could complete per minute — a sign that the system, not the load generator, was the limiting factor.

**Recovery.** Once the spike's one-minute ramp-down back to 50 VU began, p95 latency returned to approximately 240 ms — close to the original baseline figure — within about 90 seconds, and the error rate returned to baseline levels over the same window. The system did not show any lingering elevated latency or continued errors after load subsided, indicating momentary saturation rather than a persistent resource leak or a state that required a restart to clear.

### 11.3 Result Analysis

Response time and throughput moved together from baseline to spike: p95 latency rose from roughly 210 ms to roughly 1,450 ms (about 7×) while throughput rose only from roughly 24.6 req/s to roughly 185 req/s (about 7.5×) against a 10× increase in virtual users — both figures point to the same conclusion, that the system reached a hard capacity limit rather than degrading gracefully in proportion to load. The error rate remained low throughout (under 0.7% at worst), so the degradation is a latency story, not an availability story.

**Identifying the bottleneck.** Breaking the spike results down by request type shows a clear asymmetry: browse and search requests (read-only) reached a p95 of only about 340 ms during the spike — a modest increase from their baseline figure — while add-to-cart and checkout requests (which issue writes) reached a p95 of roughly 2,150 ms, an order of magnitude worse. This pattern is consistent with EShop's single SQLite writer connection (Section 5.2): as concurrent write requests queue behind one another, their latency grows sharply while read requests, which do not contend for the same connection, remain comparatively fast. The rate limiter is not a plausible explanation, since it was disabled for the duration of the test and the observed errors were connection timeouts rather than HTTP 429 responses. CPU on the single Node.js process approached full utilization of one core during the hold phase of the spike, consistent with a single-threaded process waiting on serialized database writes rather than being starved of CPU across multiple cores. Taken together, the evidence points to **SQLite write contention on the checkout and cart paths** as the primary bottleneck.

**Other observations.** The two tools' spike numbers track each other within about 5% (p95 differs by 60 ms, error rate by 0.1 percentage points), reinforcing that the degradation reflects EShop's behavior rather than a quirk of either load generator. No unexpected status codes were observed outside the expected 200/401 range, and repeating the checkout-only subset of requests in isolation produced the same pattern, ruling out a transient, one-off anomaly.

**Transition.** These findings are used in Section 12 to compare k6 and JMeter on evidence rather than reputation, and in Section 14 to state the overall SLO outcome and the primary bottleneck.

---

## 12. Tool Evaluation

### 12.1 Apache JMeter

**Observed Strengths:** The GUI test plan made it straightforward to show how the workload model (Section 7) mapped onto thread groups and samplers, which is what made it useful for the live demo (Section 9). Its built-in aggregate report generated clear percentile and throughput figures directly from the raw sample log, with no extra processing needed to read off the numbers in Section 11.

**Observed Limitations:** At 500 threads, JMeter's JVM-based, thread-per-virtual-user model used noticeably more memory than k6 needed to reach the same 500 VU on the same host, and configuring the same parameterization (rotating search keywords, attaching the auth token to cart/checkout requests) took more manual GUI steps than the equivalent lines in the k6 script.

### 12.2 k6

**Observed Strengths:** Expressing the workload as a single JavaScript file kept the action mix, think time, and SLO thresholds (Section 7) in one readable place, and the built-in threshold checks turned the SLO pass/fail decision into an explicit flag in the run summary rather than a manual comparison against Section 7.6 after the fact.

**Observed Limitations:** k6 has no built-in graphical interface, so the live demo (Section 9) still relied on JMeter's GUI to show the workload structure visually to a non-technical audience. k6's own command-line summary was also less immediately readable than JMeter's dashboard for a quick side-by-side comparison, and had to be read alongside the exported JSON to double-check individual percentile values.

### 12.3 Overall Comparison

k6 and JMeter produced closely matching results at both baseline (p95 within 10 ms) and spike (p95 within 60 ms, error rate within 0.1 percentage points), which is the more important finding than any difference in the tools themselves — it confirms the measurements describe EShop's actual behavior rather than an artifact of either tool. JMeter's GUI made it the better fit for explaining the workload to an audience that had not seen it before; k6's code-based script made it faster to author, review, and pair with the AI-assisted workflow in Section 10. For this seminar, k6 was the more efficient primary tool given the team's scripting-first workflow, while JMeter remained valuable specifically for the parts of the seminar that needed a visual, GUI-based explanation. Neither tool is judged superior in general; each served a different, complementary role in this seminar.

---

## 13. Discussion

### 13.1 Limitations

- The tests were run on a single local machine, with the load generator and the EShop backend sharing the same host, rather than on a dedicated, production-like environment.
- SQLite is an embedded, single-connection database; the results may not directly apply to a system built on a production-scale database such as PostgreSQL.
- Only load (baseline) and spike testing were performed; soak/endurance testing and scalability testing across multiple configurations were not covered.
- The workload model (Section 7) is a reasonable approximation of typical e-commerce usage rather than a validated sample of real EShop traffic.

### 13.2 Future Improvements

- Running the baseline and spike tests on a dedicated host, separate from the load generator, and repeating each scenario a few times would give more stable and representative results.
- Testing a multi-instance or load-balanced deployment of EShop would show whether the bottleneck found in this single-instance setup still applies once the system can scale horizontally.
- If real EShop usage data becomes available, comparing it against the workload model in Section 7 would confirm how closely the assumed browse-heavy, checkout-light mix matches actual customer behavior.

---

## 14. Conclusion & Recommendations

### 14.1 Summary

**Overall SLO outcome:** EShop satisfied all three SLO targets under the baseline load (50 VU) in both k6 and JMeter, with p95 latency roughly 290 ms below the 500 ms target and an error rate near zero. Under the spike load (50→500 VU), the system breached the latency SLO by a wide margin (p95 approximately 1.45 s against a 500 ms target) while the error-rate SLO was still met (below 1% in both tools). The overall verdict for this study is therefore a **partial SLO failure**: EShop is fit for its expected steady-state load but not yet fit for a sudden tenfold traffic surge.

**Primary bottleneck:** Write contention on SQLite's single database connection, concentrated on the cart and checkout paths. Read-only requests (browse, search) remained comparatively fast during the spike, while write requests (add-to-cart, checkout) accounted for most of the latency increase, consistent with the single-writer-connection constraint noted in Section 5.2.

### 14.2 Lessons Learned

The workload model (Section 7.1) held up as designed: browse and search dominate ordinary traffic, but the experiment showed that even a 5% checkout weight is enough to expose a write-path bottleneck once concurrency rises, confirming that a browse-heavy mix does not imply a browse-heavy risk profile. On tool usage, k6 and JMeter produced results close enough to each other (Section 12.3) that the choice of tool did not change the engineering conclusion, which supports treating the workload model — not the tool — as the primary driver of a trustworthy result. On AI-assisted scripting, the corrections applied in Section 10.2 (the fabricated endpoint and the missing authentication step, in particular) would have produced a script that silently tested the wrong behavior if left unreviewed, which reinforces that human review is a required step in this workflow rather than an optional safeguard.

### 14.3 Recommendations

Address the identified bottleneck directly: move checkout and cart writes off a single blocking SQLite connection, for example by enabling write-ahead logging (WAL) mode or by introducing a bounded write queue so that concurrent checkout requests are serialized predictably instead of blocking the connection outright. Because the degradation was latency-based rather than error-based, consider whether a slightly relaxed p95 target under spike conditions specifically (as distinct from the steady-state SLO) would better reflect an acceptable, temporary degradation versus a hard failure. Re-run the spike scenario after any database-layer change to confirm the p95/p99 improvement before considering the issue resolved.

### 14.4 Future Work

Run a soak test at a moderate, sustained load (e.g., 100 VU for one hour) to check whether write contention accumulates gradually under prolonged load the way it appeared instantaneously under the spike. Repeat the spike test against a pooled, multi-connection database (e.g., PostgreSQL) to confirm that the bottleneck is specific to SQLite's single-writer model rather than to the application logic itself. Finally, extend the AI-assisted scripting workflow demonstrated for k6 (Section 10) to JMeter, to check whether the same categories of AI-generated mistakes recur in a different tool's script format.

---

## 15. References

[TODO: list references in numbered IEEE or APA format.]
