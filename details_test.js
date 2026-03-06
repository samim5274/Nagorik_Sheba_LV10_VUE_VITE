import http from "k6/http";
import { check, sleep } from "k6";

export const options = {
  stages: [
    { duration: "20s", target: 5 },
    { duration: "40s", target: 20 },
    { duration: "40s", target: 50 },
    { duration: "40s", target: 100 },
    { duration: "20s", target: 0 },
  ],
  thresholds: {
    http_req_failed: ["rate<0.01"],
    http_req_duration: ["p(95)<1000"],
  },
};

const BASE_URL = __ENV.BASE_URL || "http://127.0.0.1:8080";
const TOKEN = __ENV.TOKEN || "";
const COMPLAINT_ID = __ENV.COMPLAINT_ID || "1";

function headers() {
  const h = {
    Accept: "application/json",
  };

  if (TOKEN) {
    h.Authorization = `Bearer ${TOKEN}`;
  }

  return h;
}

function dbg(name, res) {
  if (res.status !== 200) {
    console.log(`${name} STATUS: ${res.status} BODY: ${String(res.body).slice(0, 200)}`);
  }
}

export default function () {
  const res = http.get(`${BASE_URL}/api/complaints/${COMPLAINT_ID}`, {
    headers: headers(),
  });

  dbg("DETAILS", res);

  check(res, {
    "details status is 200": (r) => r.status === 200,
  });

  sleep(1);
}

// BASE_URL="http://127.0.0.1:8080" TOKEN="12|Oe5xcB4bv5v4KDmU9FMgfjDaMb5WgO20dD5hvSjK43681ebf" COMPLAINT_ID="1" k6 run --vus 200 --duration 1m details_test.js