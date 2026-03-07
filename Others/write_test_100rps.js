import http from "k6/http";
import { check } from "k6";
import { Rate, Trend, Counter } from "k6/metrics";

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

const writeFailRate = new Rate("write_fail_rate");
const likeDuration = new Trend("like_duration_custom");
const commentDuration = new Trend("comment_duration_custom");
const like429Count = new Counter("like_429_count");
const comment429Count = new Counter("comment_429_count");

export const options = {
  scenarios: {
    write_load: {
      executor: "constant-arrival-rate",
      rate: 100,          // 100 iteration প্রতি second
      timeUnit: "1s",
      duration: "1m",
      preAllocatedVUs: 120,
      maxVUs: 300,
    },
  },
  thresholds: {
    http_req_failed: ["rate<0.10"],
    http_req_duration: ["p(95)<1500"],

    write_fail_rate: ["rate<0.10"],
    like_duration_custom: ["p(95)<1200"],
    comment_duration_custom: ["p(95)<1200"],
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

function debugResponse(name, res, okStatuses) {
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

function randomItem(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
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

    if (loginRes.status !== 200) {
      console.log(
        `[LOGIN FAILED] email=${user.email} status=${loginRes.status} body=${String(loginRes.body).slice(0, 250)}`
      );
      continue;
    }

    const token = extractToken(loginRes);

    if (!token) {
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
  return tokens[(__VU - 1) % tokens.length];
}

function getComplaintId(token) {
  if (COMPLAINT_IDS.length) {
    return randomItem(COMPLAINT_IDS);
  }

  const feedRes = http.get(`${BASE_URL}/api/complaints`, {
    headers: apiHeaders(token),
    tags: { endpoint: "feed_for_write" },
  });

  debugResponse("FEED_FOR_WRITE", feedRes, [200]);

  if (feedRes.status !== 200) return null;

  const ids = extractComplaintIds(feedRes);
  if (!ids.length) return null;

  return randomItem(ids);
}

export default function (data) {
  const token = getToken(data.tokens);
  const complaintId = getComplaintId(token);

  if (!complaintId) {
    writeFailRate.add(true);
    return;
  }

  // LIKE
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
  if (likeRes.status === 429) like429Count.add(1);

  debugResponse("LIKE", likeRes, [200, 201, 204, 429]);

  check(likeRes, {
    "like success": (r) => [200, 201, 204].includes(r.status),
  });

  // COMMENT
  const commentRes = http.post(
    `${BASE_URL}/api/complaints/comment`,
    JSON.stringify({
      complain_id: complaintId,
      comment: `k6 write test vu-${__VU} iter-${__ITER} time-${Date.now()}`,
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
  if (commentRes.status === 429) comment429Count.add(1);

  debugResponse("COMMENT", commentRes, [200, 201, 422, 429]);

  check(commentRes, {
    "comment success": (r) => [200, 201].includes(r.status),
  });

  writeFailRate.add(!(likeOk && commentOk));
}

// BASE_URL="http://127.0.0.1:8080" k6 run write_test_100rps.js