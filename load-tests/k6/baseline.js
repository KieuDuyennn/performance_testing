import http from 'k6/http';
import { check, sleep } from 'k6';
import { BASE_URL, SLO_THRESHOLDS, pickAction, randomThinkTimeSeconds } from './lib/config.js';

export const options = {
  scenarios: {
    baseline_load: {
      executor: 'ramping-vus',
      startVUs: 0,
      stages: [
        { duration: '1m', target: 50 },
        { duration: '5m', target: 50 },
        { duration: '1m', target: 0 },
      ],
      gracefulRampDown: '30s',
    },
  },
  thresholds: SLO_THRESHOLDS,
};

function sendAction(action) {
  let response;

  switch (action) {
    case 'search':
      response = http.get(`${BASE_URL}/api/products/search?q=headphones`);
      break;
    case 'cart':
      response = http.post(`${BASE_URL}/api/cart`, JSON.stringify({ productId: 1001, quantity: 1 }), {
        headers: { 'Content-Type': 'application/json' },
      });
      break;
    case 'checkout':
      response = http.post(`${BASE_URL}/api/checkout`, JSON.stringify({ paymentMethod: 'cod' }), {
        headers: { 'Content-Type': 'application/json' },
      });
      break;
    case 'browse':
    default:
      response = http.get(`${BASE_URL}/api/products?page=1&limit=20`);
      break;
  }

  check(response, {
    'status is < 500': (r) => r.status < 500,
  });
}

export default function () {
  const action = pickAction();
  sendAction(action);
  sleep(randomThinkTimeSeconds());
}
