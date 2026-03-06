import http from "k6/http";
import { check, sleep } from "k6";
import { Rate, Counter, Trend } from "k6/metrics";

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

const COMPLAINT_IDS = (__ENV.COMPLAINT_IDS || "")
  .split(",")
  .map((v) => Number(v.trim()))
  .filter((v) => Number.isInteger(v) && v > 0);

const loginFailRate = new Rate("login_fail_rate");
const feedFailRate = new Rate("feed_fail_rate");
const likeFailRate = new Rate("like_fail_rate");
const commentFailRate = new Rate("comment_fail_rate");

const like429Count = new Counter("like_429_count");
const comment429Count = new Counter("comment_429_count");

const loginDuration = new Trend("login_duration_custom");
const feedDuration = new Trend("feed_duration_custom");
const likeDuration = new Trend("like_duration_custom");
const commentDuration = new Trend("comment_duration_custom");

export const options = {
  stages: [
    { duration: "20s", target: 5 },
    { duration: "40s", target: 20 },
    { duration: "40s", target: 50 },
    { duration: "40s", target: 100 },
    { duration: "20s", target: 0 },
  ],
  thresholds: {
    http_req_failed: ["rate<0.05"],
    http_req_duration: ["p(95)<1500"],

    login_fail_rate: ["rate==0"],
    feed_fail_rate: ["rate<0.02"],
    like_fail_rate: ["rate<0.10"],
    comment_fail_rate: ["rate<0.10"],

    login_duration_custom: ["p(95)<1000"],
    feed_duration_custom: ["p(95)<800"],
    like_duration_custom: ["p(95)<1200"],
    comment_duration_custom: ["p(95)<1200"],
  },
  summaryTrendStats: ["avg", "min", "med", "max", "p(90)", "p(95)"],
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

function debugResponse(name, res, okStatuses) {
  if (!okStatuses.includes(res.status)) {
    console.log(
      `[${name}] status=${res.status} body=${String(res.body).slice(0, 250)}`
    );
  }
}

function randomItem(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
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

function extractComplaintIds(feedRes) {
  try {
    const body = feedRes.json();
    const items = body?.data?.data || body?.data || [];

    if (!Array.isArray(items)) return [];

    return items
      .map((item) => Number(item?.id))
      .filter((id) => Number.isInteger(id) && id > 0);
  } catch (_) {
    return [];
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

    const loginOk = loginRes.status === 200;
    loginFailRate.add(!loginOk);

    if (!loginOk) {
      console.log(
        `[LOGIN FAILED] email=${user.email} status=${loginRes.status} body=${String(loginRes.body).slice(0, 250)}`
      );
      continue;
    }

    const token = extractToken(loginRes);

    if (!token) {
      loginFailRate.add(true);
      console.log(
        `[TOKEN MISSING] email=${user.email} status=${loginRes.status} body=${String(loginRes.body).slice(0, 250)}`
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
  return tokens[(__VU - 1) % tokens.length];
}

function getComplaintId(token) {
  if (COMPLAINT_IDS.length) {
    return randomItem(COMPLAINT_IDS);
  }

  const feedRes = http.get(`${BASE_URL}/api/complaints`, {
    headers: apiHeaders(token),
    tags: { endpoint: "feed" },
  });

  feedDuration.add(feedRes.timings.duration);

  const feedOk = feedRes.status === 200;
  feedFailRate.add(!feedOk);

  debugResponse("FEED", feedRes, [200]);

  if (!feedOk) return null;

  const ids = extractComplaintIds(feedRes);
  if (!ids.length) return null;

  return randomItem(ids);
}

export default function (data) {
  const token = getToken(data.tokens);

  const feedRes = http.get(`${BASE_URL}/api/complaints`, {
    headers: apiHeaders(token),
    tags: { endpoint: "feed" },
  });

  feedDuration.add(feedRes.timings.duration);

  const feedOk = feedRes.status === 200;
  feedFailRate.add(!feedOk);

  debugResponse("FEED", feedRes, [200]);

  check(feedRes, {
    "feed success": (r) => r.status === 200,
  });

  let complaintId = null;

  if (COMPLAINT_IDS.length) {
    complaintId = randomItem(COMPLAINT_IDS);
  } else {
    const ids = extractComplaintIds(feedRes);
    if (ids.length) complaintId = randomItem(ids);
  }

  if (!complaintId) {
    sleep(1);
    return;
  }

  const likeRes = http.post(
    `${BASE_URL}/api/complaints/like/${complaintId}`,
    null,
    {
      headers: apiHeaders(token),
      tags: { endpoint: "like" },
    }
  );

  likeDuration.add(likeRes.timings.duration);

  const likeOk = [200, 201, 204].includes(likeRes.status);
  likeFailRate.add(!likeOk);

  if (likeRes.status === 429) {
    like429Count.add(1);
  }

  debugResponse("LIKE", likeRes, [200, 201, 204, 429]);

  check(likeRes, {
    "like success": (r) => [200, 201, 204].includes(r.status),
  });

  const commentRes = http.post(
    `${BASE_URL}/api/complaints/comment`,
    JSON.stringify({
      complain_id: complaintId,
      comment: `load-test vu-${__VU} iter-${__ITER} ts-${Date.now()}`,
      parent_id: null,
      is_internal: false,
    }),
    {
      headers: apiHeaders(token),
      tags: { endpoint: "comment" },
    }
  );

  commentDuration.add(commentRes.timings.duration);

  const commentOk = [200, 201].includes(commentRes.status);
  commentFailRate.add(!commentOk);

  if (commentRes.status === 429) {
    comment429Count.add(1);
  }

  debugResponse("COMMENT", commentRes, [200, 201, 429, 422]);

  check(commentRes, {
    "comment success": (r) => [200, 201].includes(r.status),
  });

  sleep(1);
}

// BASE_URL="http://127.0.0.1:8080" k6 run write_test.js