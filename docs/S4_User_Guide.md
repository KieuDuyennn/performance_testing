# S4 — User Guide

## 1. Introduction

Describe the goal, scope, and intended audience of this performance testing package.

## 2. Installation

- Install k6
- Install Apache JMeter (optional track)
- Prepare EShop backend and database
- Configure environment variables

## 3. First Test (Quick Walkthrough)

1. Start EShop backend
2. Run baseline script
3. Read summary output and SLO checks

## 4. Advanced Usage

- Scenario customization
- Custom thresholds
- Data-driven request parameterization
- Exporting and comparing multiple runs

## 5. Troubleshooting

| Symptom | Possible Cause | Fix |
|---|---|---|
| TODO | TODO | TODO |

## 6. Failure Modes (at least 3)

1. **Backend saturation under checkout peak** — TODO detection and mitigation
2. **Database lock/contention in SQLite** — TODO detection and mitigation
3. **Connection exhaustion or timeout spikes** — TODO detection and mitigation

## 7. References

- k6 docs: https://k6.io/docs/
- Apache JMeter docs: https://jmeter.apache.org/
- Course/project references: TODO
