import http from 'k6/http';
import { check, sleep } from 'k6';
import { BASE_URL, SLO_THRESHOLDS, randomThinkTimeSeconds } from './lib/config.js';

/*
AUDIT CHECKLIST (Review every AI-generated revision)
1) Fabricated endpoints: verify all routes exist in the SUT.
2) Unrealistic action ratios: compare mix with observed logs and business context.
3) Missing/incorrect think-time: keep user pacing realistic (1–3s unless justified).
4) Hard-coded IDs: avoid brittle product/user/cart IDs without data strategy.
5) Missing error checks/retries: ensure explicit assertions and failure handling policy.
*/

export const options = {
  scenarios: {
    realistic_shopping_ai: {
      executor: 'ramping-vus',
      startVUs: 0,
      stages: [
        { duration: '1m', target: 20 },
        { duration: '3m', target: 100 },
        { duration: '1m', target: 0 },
      ],
      gracefulRampDown: '30s',
    },
  },
  thresholds: SLO_THRESHOLDS,
};

export default function () {
  const browse = http.get(`${BASE_URL}/api/products?page=1&limit=20`);
  check(browse, { 'browse status is < 500': (r) => r.status < 500 });
  sleep(randomThinkTimeSeconds());

  const search = http.get(`${BASE_URL}/api/products/search?q=laptop`);
  check(search, { 'search status is < 500': (r) => r.status < 500 });
  sleep(randomThinkTimeSeconds());

  const addCart = http.post(
    `${BASE_URL}/api/cart`,
    JSON.stringify({ productId: 3003, quantity: 1 }),
    { headers: { 'Content-Type': 'application/json' } }
  );
  check(addCart, { 'cart status is < 500': (r) => r.status < 500 });
  sleep(randomThinkTimeSeconds());

  const checkout = http.post(
    `${BASE_URL}/api/checkout`,
    JSON.stringify({ paymentMethod: 'cod' }),
    { headers: { 'Content-Type': 'application/json' } }
  );
  check(checkout, { 'checkout status is < 500': (r) => r.status < 500 });
  sleep(randomThinkTimeSeconds());
}
