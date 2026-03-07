import http from "k6/http";
import { check } from "k6";
import { Rate, Trend } from "k6/metrics";

const BASE_URL = __ENV.BASE_URL || "http://127.0.0.1:8080";

const USERS = [
  { email: "user1@gmail.com", password: "12345678" },
  { email: "user2@gmail.com", password: "12345678" },
  { email: "user3@gmail.com", password: "12345678" },
  { email: "user4@gmail.com", password: "12345678" },
  { email: "user5@gmail.com", password: "12345678" },
  { email: "user6@gmail.com", password: "12345678" },
  { email: "user7@gmail.com", password: "12345678" },
  { email: "user8@gmail.com", password: "12345678" },
  { email: "user9@gmail.com", password: "12345678" },
  { email: "user10@gmail.com", password: "12345678" },
];

const loginFailRate = new Rate("login_fail_rate");
const createFailRate = new Rate("create_fail_rate");

const loginDuration = new Trend("login_duration_custom");
const createDuration = new Trend("create_duration_custom");

export const options = {
  scenarios: {
    create_load: {
      executor: "constant-arrival-rate",
      rate: Number(__ENV.RATE || 5),   // প্রতি second এ কত create request যাবে
      timeUnit: "1s",
      duration: __ENV.DURATION || "1m",
      preAllocatedVUs: Number(__ENV.PRE_VUS || 20),
      maxVUs: Number(__ENV.MAX_VUS || 100),
    },
  },
  thresholds: {
    http_req_failed: ["rate<0.05"],
    http_req_duration: ["p(95)<1500"],

    login_fail_rate: ["rate==0"],
    create_fail_rate: ["rate<0.05"],

    login_duration_custom: ["p(95)<1000"],
    create_duration_custom: ["p(95)<1500"],
  },
  summaryTrendStats: ["avg", "min", "med", "max", "p(90)", "p(95)", "p(99)"],
};

function jsonHeaders(token = "") {
  const h = {
    Accept: "application/json",
    "Content-Type": "application/json",
  };

  if (token) {
    h.Authorization = `Bearer ${token}`;
  }

  return h;
}

function debugResponse(name, res, okStatuses = []) {
  if (!okStatuses.includes(res.status)) {
    console.log(
      `[${name}] status=${res.status} body=${String(res.body).slice(0, 400)}`
    );
  }
}

function extractToken(res) {
  try {
    const body = res.json();
    return (
      body?.token ||
      body?.access_token ||
      body?.data?.token ||
      body?.data?.access_token ||
      null
    );
  } catch (_) {
    return null;
  }
}

export function setup() {
  const tokens = [];

  for (const user of USERS) {
    const loginRes = http.post(
      `${BASE_URL}/api/login`,
      JSON.stringify({
        email: user.email,
        password: user.password,
      }),
      {
        headers: jsonHeaders(),
        tags: { endpoint: "login" },
      }
    );

    loginDuration.add(loginRes.timings.duration);

    const ok = loginRes.status === 200;
    loginFailRate.add(!ok);

    if (!ok) {
      console.log(
        `[LOGIN FAILED] email=${user.email} status=${loginRes.status} body=${String(loginRes.body).slice(0, 250)}`
      );
      continue;
    }

    const token = extractToken(loginRes);
    if (!token) {
      loginFailRate.add(true);
      console.log(`[TOKEN MISSING] email=${user.email}`);
      continue;
    }

    tokens.push(token);
  }

  if (!tokens.length) {
    throw new Error("No valid tokens generated from login.");
  }

  return { tokens };
}

function getToken(tokens) {
  return tokens[(__ITER + __VU - 1) % tokens.length];
}

function randomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function pick(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

function buildPayload() {
  return {
    title: `Load Test Complaint ${Date.now()}-${Math.random().toString(36).slice(2, 8)}`,
    description: "This is a complaint create performance test from k6.",
    category_id: 1,
    sub_category_id: 1,
    priority: pick(["low", "medium", "high"]),
    division_id: 1,
    district_id: 1,
    upazila_id: 1,
    police_station_id: 1,
    ward_no: String(randomInt(1, 12)),
    address_line: "Test address line from k6",
    landmark: "Test landmark",
    latitude: "23.8103000",
    longitude: "90.4125000",
    visibility_mode: pick(["public", "anonymous"]),
    source: "web",
  };
}

export default function (data) {
  const token = getToken(data.tokens);

  const payload = buildPayload();

  const res = http.post(
    `${BASE_URL}/api/create`,
    JSON.stringify(payload),
    {
      headers: jsonHeaders(token),
      tags: { endpoint: "create_complaint" },
    }
  );

  createDuration.add(res.timings.duration);

  const ok = [200, 201].includes(res.status);
  createFailRate.add(!ok);

  debugResponse("CREATE_COMPLAINT", res, [200, 201, 422, 429]);

  check(res, {
    "create complaint success": (r) => [200, 201].includes(r.status),
  });
}


// BASE_URL="http://127.0.0.1:8080" RATE=5 DURATION="1m" PRE_VUS=20 MAX_VUS=100 k6 run create_complaint_test.js
// BASE_URL="http://127.0.0.1:8080" RATE=10 DURATION="1m" PRE_VUS=30 MAX_VUS=120 k6 run create_complaint_test.js
// BASE_URL="http://127.0.0.1:8080" RATE=15 DURATION="1m" PRE_VUS=40 MAX_VUS=150 k6 run create_complaint_test.js
// BASE_URL="http://127.0.0.1:8080" RATE=20 DURATION="1m" PRE_VUS=50 MAX_VUS=200 k6 run create_complaint_test.js
// BASE_URL="http://127.0.0.1:8080" RATE=25 DURATION="1m" PRE_VUS=60 MAX_VUS=220 k6 run create_complaint_test.js