# JMeter Track (Equivalent Scenario Guidance)

## Goal

Create a `.jmx` plan that approximates the k6 baseline/spike workload and endpoint mix.

## Suggested Test Plan Structure

1. Thread Group(s) for baseline and spike
2. HTTP Request Defaults (`BASE_URL` host/port)
3. CSV Data Set Config (optional for parameterized inputs)
4. HTTP Samplers for browse/search/cart/checkout
5. Timers for think-time (1–3 seconds)
6. Assertions (status code and response checks)
7. Summary Report / Aggregate Report listeners

## Headless Run Command

```bash
jmeter -n -t path/to/eshop-perf.jmx -l load-tests/reports/results/jmeter-results.jtl -e -o load-tests/reports/results/jmeter-html
```

## Notes

- Keep endpoint paths aligned with the validated SUT routes.
- Store raw `.jtl` outputs under `load-tests/reports/results/` (ignored by Git).
