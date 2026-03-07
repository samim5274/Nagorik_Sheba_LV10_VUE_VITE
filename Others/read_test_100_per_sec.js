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

const readFailRate = new Rate("read_fail_rate");
const loginFailRate = new Rate("login_fail_rate");

const loginDuration = new Trend("login_duration_custom");
const feedDuration = new Trend("feed_duration_custom");
const detailsDuration = new Trend("details_duration_custom");

export const options = {
  scenarios: {
    read_100_per_sec: {
      executor: "constant-arrival-rate",
      rate: 100,              // প্রতি second এ 100 iteration
      timeUnit: "1s",
      duration: "1m",         // 1 minute test
      preAllocatedVUs: 120,   // শুরুতে allocate
      maxVUs: 300,            // দরকার হলে বাড়বে
    },
  },
  thresholds: {
    http_req_failed: ["rate<0.05"],
    http_req_duration: ["p(95)<1000"],

    login_fail_rate: ["rate==0"],
    read_fail_rate: ["rate<0.05"],

    login_duration_custom: ["p(95)<1000"],
    feed_duration_custom: ["p(95)<800"],
    details_duration_custom: ["p(95)<800"],
  },
  summaryTrendStats: ["avg", "min", "med", "max", "p(90)", "p(95)", "p(99)"],
};

function apiHeaders(token = "") {
  const h = {
    Accept: "application/json",
    "Content-Type": "application/json",
  };

  if (token) {
    h.Authorization = `Bearer ${token}`;
  }

  return h;
}

function debugResponse(name, res, okStatuses = [200]) {
  if (!okStatuses.includes(res.status)) {
    console.log(
      `[${name}] status=${res.status} body=${String(res.body).slice(0, 250)}`
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

function extractComplaintId(feedRes) {
  try {
    const body = feedRes.json();
    const items = body?.data?.data || body?.data || [];

    if (!Array.isArray(items) || !items.length) return 1;

    const id = Number(items[0]?.id);
    return Number.isInteger(id) && id > 0 ? id : 1;
  } catch (_) {
    return 1;
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
        headers: apiHeaders(),
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
      console.log(
        `[TOKEN MISSING] email=${user.email} body=${String(loginRes.body).slice(0, 250)}`
      );
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

export default function (data) {
  const token = getToken(data.tokens);

  // 1) Feed
  const feedRes = http.get(`${BASE_URL}/api/complaints`, {
    headers: apiHeaders(token),
    tags: { endpoint: "feed" },
  });

  feedDuration.add(feedRes.timings.duration);
  debugResponse("FEED", feedRes, [200]);

  const feedOk = feedRes.status === 200;

  check(feedRes, {
    "feed status 200": (r) => r.status === 200,
  });

  const complaintId = extractComplaintId(feedRes);

  // 2) Details
  const detailsRes = http.get(`${BASE_URL}/api/complaints/${complaintId}`, {
    headers: apiHeaders(token),
    tags: { endpoint: "details" },
  });

  detailsDuration.add(detailsRes.timings.duration);
  debugResponse("DETAILS", detailsRes, [200]);

  const detailsOk = detailsRes.status === 200;

  check(detailsRes, {
    "details status 200": (r) => r.status === 200,
  });

  readFailRate.add(!(feedOk && detailsOk));
}


// BASE_URL="http://127.0.0.1:8080" k6 run read_test_100_per_sec.js