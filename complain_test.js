import http from "k6/http";
import { check, sleep } from "k6";

export const options = {
    stages: [
        { duration: "20s", target: 5 },
        { duration: "40s", target: 20 },
        { duration: "40s", target: 50 },
        { duration: "20s", target: 0 },
    ],
    thresholds: {
        http_req_failed: ["rate<0.01"],
        http_req_duration: ["p(95)<800"],
    },
};

const BASE_URL = __ENV.BASE_URL || "http://127.0.0.1:8080";

// যদি আপনার API token লাগে তাহলে env থেকে নিন
const TOKEN = __ENV.TOKEN || "";

function authHeaders() {
    const h = { "Content-Type": "application/json" };
    if (TOKEN) h["Authorization"] = `Bearer ${TOKEN}`;
    return h;
}

function dbg(name, res) {
    // ok statuses: GET=200, POST=200/201/204, validation=422, throttle=429
    if (![200, 201, 204, 422].includes(res.status)) {
        console.log(name, "STATUS:", res.status, "BODY:", String(res.body).slice(0, 140));
    }
}
// 12|Oe5xcB4bv5v4KDmU9FMgfjDaMb5WgO20dD5hvSjK43681ebf
export default function () {
    // 1) Feed
    const feed = http.get(`${BASE_URL}/api/complaints`, { headers: authHeaders() });
    dbg("FEED", feed);
    check(feed, { "feed 200": (r) => r.status === 200 });

    // (optional) response থেকে একটা id বের করা (আপনার JSON structure ভিন্ন হতে পারে)
    let id = 1;
    try {
        const data = feed.json();
        id = data?.data?.data?.[0]?.id || data?.data?.[0]?.id || 1;
    } catch (e) {}

    // 2) Details
    const details = http.get(`${BASE_URL}/api/complaints/${id}`, { headers: authHeaders() });
    dbg("DETAILS", details);
    check(details, { "details 200": (r) => r.status === 200 });

    // 3) Reaction (এটা যদি guest allow না হয়, TOKEN লাগবে)
    const like = http.post(`${BASE_URL}/api/complaints/like/${id}`, null, { headers: authHeaders() });
    dbg("LIKE", like);
    check(like, { "like ok": (r) => [200, 201, 204].includes(r.status) });

    // 4) Comment (আপনার endpoint/fields ঠিকমতো দিন)
    const payload = JSON.stringify({
        complain_id: id,
        comment: `load test comment ${Math.random()}`,
        parent_id: null,
        is_internal: false,
    });
    const comment = http.post(`${BASE_URL}/api/complaints/comment`, payload, { headers: authHeaders() });
    dbg("COMMENT", comment);
    check(comment, { "comment ok": (r) => [200, 201, 422].includes(r.status) });

    // throttle avoid (simulate real user)
    sleep(1);
}