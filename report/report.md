# Performance Testing Seminar Report

**Course:** Software Testing (CS423/CSC15003) — FIT, HCMUS
**Topic:** T05 — Performance Testing
**System Under Test (SUT):** EShop (Node.js + Express + SQLite)
**Traditional tools:** k6 (primary), Apache JMeter (secondary)
**AI direction:** LLM-assisted generation of a "realistic shopping" load script from an HTTP log, followed by human audit

---

## 1. Abstract

This report presents a performance testing study of **EShop**, a Node.js/SQLite e-commerce backend, carried out as part of the T05 — Performance Testing seminar. The study defines a mixed workload model covering product browsing, search, cart, and checkout, implements that model independently in both Apache JMeter and k6, and evaluates the system under a baseline load (50 virtual users) and a spike load (50 to 500 virtual users within 30 seconds). A large language model (LLM) was used to draft a "realistic shopping" load script from a captured HTTP log, which the team then audited and corrected before use — an AI-assisted supplement to the two traditional tools, not a replacement for them.

The report covers the conceptual background of performance testing, the system under test, the workload model, the experimental methodology, the AI-assisted scripting workflow, the resulting measurements, and a comparative evaluation of the two tools. Tool implementation details such as installation, configuration, and execution steps are outside the scope of this report.

**Key outcomes:** [Add a summary of the baseline/spike SLO outcome and the main observed bottleneck.]

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
| CPU | [Add] |
| RAM | [Add] |
| Operating System | [Add] |
| Node.js | [Add] |
| Apache JMeter | [Add] |
| k6 | [Add] |

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

## 9. Demo Scenario

> The live demonstration follows a fixed script rather than a slide deck, showing both traditional tools and the AI-assisted workflow in action.

1. **Introduce the objective** — state what the demo will show: a mixed workload tested with two tools, plus an AI-assisted script.
2. **Explain the workload model** — briefly show the action mix and think time from Section 7.
3. **Demonstrate the baseline test** — run the 50 VU baseline live in k6 and narrate the summary output as it completes.
4. **Demonstrate the spike test** — run the 50 → 500 VU spike live in k6, pointing out the ramp and any threshold breaches.
5. **Demonstrate the AI-assisted workflow** — show the AI-drafted script and at least one concrete correction the team made to it (Section 10).
6. **Compare the results** — present the baseline and spike outcomes for k6 and JMeter side by side.
7. **Wrap up** — summarize the key finding and open the floor for questions.

[Add expected outputs once the demonstration has been rehearsed.]

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

Every AI-generated script was reviewed against the real system before use. The endpoint and authentication fixes above were verified and applied directly. [Add remaining review evidence once finalized.]

---

## 11. Experimental Results & Analysis

> Metrics are measured against the thresholds defined in Section 7.6 and Section 8.4.

### 11.1 Baseline Results

| Metric | k6 | JMeter |
|---|---|---|
| p50 latency | — | — |
| p95 latency | — | — |
| p99 latency | — | — |
| Throughput (req/s) | — | — |
| Error rate | — | — |
| SLO pass/fail | — | — |

### 11.2 Spike Results

| Metric | k6 | JMeter |
|---|---|---|
| p50 latency | — | — |
| p95 latency | — | — |
| p99 latency | — | — |
| Throughput (req/s) | — | — |
| Error rate | — | — |
| SLO pass/fail | — | — |

### 11.3 Result Analysis

[Add analysis covering response time and throughput trends between baseline and spike, error rate and any threshold breaches, the observed bottleneck (e.g., database contention under concurrent writes), whether the system recovered after the spike, and any other notable observations.]

---

## 12. Tool Evaluation

### 12.1 Apache JMeter

**Observed Strengths:** [Add strengths observed during the JMeter runs, e.g., ease of visualizing the test plan, output clarity.]

**Observed Limitations:** [Add limitations observed, e.g., resource usage, setup effort.]

### 12.2 k6

**Observed Strengths:** [Add strengths observed during the k6 runs, e.g., scripting speed, CI-friendliness.]

**Observed Limitations:** [Add limitations observed, e.g., lack of a GUI for non-technical viewers.]

### 12.3 Overall Comparison

[Summarize the comparison — ease of use, implementation effort, and suitability for this seminar — and give an overall recommendation grounded in the Section 11 results.] Neither tool is assumed superior; each served a different role in this seminar.

---

## 13. Discussion

### 13.1 Failure Modes

The following failure modes describe ways the tool/system combination can mislead a tester, verified directly against the system's behavior rather than assumed:

1. **Rate limiter masking real capacity.** The application-level rate limiter, if left enabled, is reached long before the system's real capacity at 50 or 500 virtual users, producing a wall of rejected requests and an artificially capped result. *Detection:* a sharp, early rise in rejected requests. *Mitigation:* disable the limiter for the duration of measurement (Section 5.2).
2. **False-positive success on invalid lookups.** A request for a non-existent product returns a successful response with an empty body rather than an error status. *Detection:* assertions must inspect response content, not status code alone. *Mitigation:* add content-based checks for product-detail requests.
3. **Silent search misroute.** An incorrectly formed search request can silently fall through to an unrelated route and return an empty, successful response, so a misconfigured script can report full success while testing nothing. *Detection:* verify non-trivial result counts in search responses. *Mitigation:* validate the endpoint pattern and assert on result content.
4. **Non-expiring session tokens.** Authentication tokens do not expire once issued, so a script relying on mid-test token expiry will not observe it, and a long-running test may reuse the same token indefinitely — unrealistic compared to typical session behavior. *Detection:* inspect issued tokens for the absence of an expiry claim. *Mitigation:* treat token lifetime as an explicit test parameter rather than an inherited assumption.

[Add AI-specific limitations and common mistakes, building on Section 10.3.]

### 13.2 Limitations

Testing is performed on a local, single-machine setup rather than a representative production deployment (no load balancing, connection pooling, or multi-instance clustering). The database's single-writer-connection model is a known architectural constraint (Section 5.2) that may dominate results in a way that would not generalize to a system built on a different database. The product catalog is small and fixed, and the traffic sample used for the AI-assisted scripting workflow (Section 10) is limited in size and partly synthetic rather than fully representative of real user behavior.

This study also covers load and spike testing only (Section 4.2); soak/endurance testing, stress-to-failure testing, and scalability testing across multiple configurations are out of scope. Resource utilization monitoring may not be captured, which limits root-cause analysis to latency and error-rate evidence alone.

### 13.3 Threats to Validity

- Running the load generator on the same host as the system under test can inflate measured latency due to shared CPU and network resources.
- The workload mix (Section 7.1) is a reasoned assumption rather than a fully validated observation of real traffic.
- [State whether baseline and spike were each run more than once; a single run per scenario does not account for run-to-run variance.]

---

## 14. Conclusion & Recommendations

### 14.1 Summary

[Add the SLO outcome summary for baseline and spike.]

### 14.2 Lessons Learned

[Add lessons learned, building on the rate limiter's effect on measurement, the value of content-based assertions, and the AI-script corrections in Section 10.]

### 14.3 Recommendations

[Add recommendations for extending this work, grounded in the Section 11 findings.]

### 14.4 Future Work

[Add future work, e.g., soak testing, multi-instance backend testing, or extending the AI-assisted workflow to the JMeter implementation.]

---

## 15. References

### Books

[Add]

### Papers

[Add]

### Official Documentation

- [Add k6 official documentation — URL and access date]
- [Add Apache JMeter official documentation — URL and access date]

### Websites

[Add]
