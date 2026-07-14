const BASE_URL = __ENV.BASE_URL || 'http://localhost:3000';

const SLO_THRESHOLDS = {
  http_req_duration: ['p(95)<500'],
  http_req_failed: ['rate<0.01'],
};

const WORKLOAD_MIX = [
  { action: 'browse', weight: 0.4 },
  { action: 'search', weight: 0.35 },
  { action: 'cart', weight: 0.2 },
  { action: 'checkout', weight: 0.05 },
];

function pickAction() {
  const randomValue = Math.random();
  let cumulative = 0;

  for (const item of WORKLOAD_MIX) {
    cumulative += item.weight;
    if (randomValue <= cumulative) {
      return item.action;
    }
  }

  return WORKLOAD_MIX[WORKLOAD_MIX.length - 1].action;
}

function randomThinkTimeSeconds() {
  return 1 + Math.random() * 2;
}

export { BASE_URL, SLO_THRESHOLDS, WORKLOAD_MIX, pickAction, randomThinkTimeSeconds };
