import axios from "axios";
import router from "../router";

/*
|--------------------------------------------------------------------------
| Base URLs (auto from env)
|--------------------------------------------------------------------------
*/

export const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || "http://localhost:8080/api";

/*
|--------------------------------------------------------------------------
| Axios Instance
|--------------------------------------------------------------------------
*/

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: { Accept: "application/json" },
  withCredentials: false,
});

/*
|--------------------------------------------------------------------------
| Token Interceptor
|--------------------------------------------------------------------------
*/

api.interceptors.request.use((config) => {
  const token = localStorage.getItem("token");
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

/*
|--------------------------------------------------------------------------
| Global 401 handler // token invalid holei login route a redirect korbe
|--------------------------------------------------------------------------
*/

api.interceptors.response.use(
  (res) => res,
  (err) => {
    if (err?.response?.status === 401) {
      localStorage.removeItem("token");
      localStorage.removeItem("user");
      router.push("/login");
    }
    return Promise.reject(err);
  }
);

/*
|--------------------------------------------------------------------------
| Image URL Helper (GLOBAL)
|--------------------------------------------------------------------------
| Example:
| makeImg("products/a.jpg")
| → http://localhost:8080/storage/products/a.jpg
|--------------------------------------------------------------------------
*/

export const makeImg = (path) => {
  if (!path) return "";

  if (/^https?:\/\//i.test(path)) return path;

  const root = API_BASE_URL.replace(/\/api\/?$/, "");

  return `${root}/storage/${path}`;
};

export default api;
