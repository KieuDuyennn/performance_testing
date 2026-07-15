# S5: Activity Worksheet

## Activity Title

**Workload Model Bake-off**

## Duration

**25 minutes total**

- 5 min: briefing and context
- 12 min: group design and parameter choices
- 5 min: compare candidate workload models
- 3 min: debrief and answer review

## Instructions

Given the EShop API behavior summary, each group proposes a workload model with:

- Action mix (browse/search/cart/checkout)
- Arrival pattern or VU stages
- Think-time assumptions
- Success metrics and SLO checks

## Worksheet Template

> Left blank on purpose. Each audience group fills in their own row live during the
> 25-minute activity; do not pre-fill this table.

| Group | Workload Mix | Peak Load Plan | Think-time Assumption | Risks |
|---|---|---|---|---|
| A | | | | |
| B | | | | |

## Answer Key (Reference Solution)

- **Suggested realistic mix:** Browse 40%, Search 35%, Add to Cart 20%, Checkout 5% per
  user session, based on the workload model the team validated for EShop (see
  `report/report.md` Section 7.2). For the Black Friday framing of this activity, a
  reasonable variant shifts a few points from Browse toward Add to Cart and Checkout
  (shoppers arrive with more purchase intent during a sale event), while keeping
  Checkout a clear minority of actions, since even during a sale most sessions still
  browse or abandon before completing an order.

- **Why this mix is plausible:** It mirrors a typical e-commerce funnel where most
  traffic is read-heavy (browse and search) and only a small share of sessions convert
  to a purchase. Randomized think time of 1 to 3 seconds between actions (Section 7.3)
  approximates human pacing instead of back-to-back machine-speed requests, which keeps
  the load shape realistic rather than artificially bursty.

- **Common mistakes to avoid** (drawn from the EShop traps documented in
  `docs/00_Seminar_Master_Brief.md` Section 7 and the team's own study notes):
  - Picking a raw VU number (for example, "500 users") without first defining an action
    mix. The core message of this activity is that the workload model, not the VU count,
    determines whether a result is trustworthy.
  - Forgetting the `/api` rate limiter (200 requests per 15 minutes per IP). A group that
    designs a search-heavy mix without accounting for it will see a wall of HTTP 429s
    that look like a real failure but are actually a measurement artifact, unless the
    `LOADTEST=1` bypass is deliberately used for the measurement run.
  - Reusing a single shared login/token across every virtual user for cart and checkout
    actions. EShop locks an account after 2 wrong-password attempts, and its cart state
    is kept in server memory per user, so a shared account can produce contention or
    lockouts that a per-user account pool would not.
  - Assuming an AI-generated load script already encodes a realistic business mix. AI
    can produce a syntactically correct script quickly, but it cannot judge whether the
    action ratios inside it reflect how EShop's real users actually behave; that
    judgment has to come from the group.

- **Minimum SLO checks:** p95 latency, error rate, and endpoint-level outliers (already
  present above, kept as originally written).
