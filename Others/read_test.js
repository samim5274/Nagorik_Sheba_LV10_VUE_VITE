import http from "k6/http";
import { check, sleep } from "k6";

// 12|Oe5xcB4bv5v4KDmU9FMgfjDaMb5WgO20dD5hvSjK43681ebf

export const options = {
  stages: [
    { duration: "20s", target: 5 },
    { duration: "40s", target: 20 },
    { duration: "40s", target: 50 },
    { duration: "40s", target: 100 },
    { duration: "40s", target: 200 },
    { duration: "20s", target: 0 },
  ],
  thresholds: {
    http_req_failed: ["rate<0.01"],
    http_req_duration: ["p(95)<1000"],
  },
};

const BASE_URL = __ENV.BASE_URL || "http://127.0.0.1:8080";
const TOKEN = __ENV.TOKEN || "";

function headers() {
  const h = { Accept: "application/json" };
  if (TOKEN) h.Authorization = `Bearer ${TOKEN}`;
  return h;
}

function dbg(name, res) {
  if (res.status !== 200) {
    console.log(name, "STATUS:", res.status, "BODY:", String(res.body).slice(0, 140));
  }
}

export default function () {
  // 1) Feed
  const feed = http.get(`${BASE_URL}/api/complaints`, { headers: headers() });
  dbg("FEED", feed);
  check(feed, { "feed 200": (r) => r.status === 200 });

  // 2) Extract id
  let id = 1;
  try {
    const data = feed.json();
    id = data?.data?.data?.[0]?.id || data?.data?.[0]?.id || 1;
  } catch (_) {}

  // 3) Details
  const details = http.get(`${BASE_URL}/api/complaints/${id}`, { headers: headers() });
  dbg("DETAILS", details);
  check(details, { "details 200": (r) => r.status === 200 });

  // sleep(1);
}

// BASE_URL="http://127.0.0.1:8080" TOKEN="12|Oe5xcB4bv5v4KDmU9FMgfjDaMb5WgO20dD5hvSjK43681ebf" k6 run --vus 100 --duration 30s read_test.js