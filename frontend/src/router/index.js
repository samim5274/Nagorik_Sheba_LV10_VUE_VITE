import { createRouter, createWebHistory } from 'vue-router'

import Login from '../components/Auth/login.vue'
import Register from '../components/Auth/register.vue'
import dashboard from '../components/Dashboard/dashboard.vue'
import createComplain from '../components/Complain/create-complain.vue'
import complain from '../components/Complain/complain-view.vue'
import complainList from '../components/Complain/complain-list.vue'
import myComplain from '../components/Complain/my-complain.vue'

const routes = [
  { path: '/', redirect: '/login' },
  { path: '/login', component: Login, meta: {title: "Login"} },
  { path: '/register', component: Register, meta: {title: "Register"} },
  { path: '/dashboard', component: dashboard, meta: { requiresAuth: true, title: "Dashboard" } },
  { path: '/create', component: createComplain, meta: { requiresAuth: true, title: "Create" } },
  { path: '/complaints/:id/:code', component: complain, meta: { requiresAuth: true, title: "Complain" } },
  { path: '/complain-list', component: complainList, meta: { requiresAuth: true, title: "Complain-List" } },
  { path: '/my-complain', component: myComplain, meta: { requiresAuth: true, title: "My-Complain" } },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  
  const token = localStorage.getItem("token");

  if(to.meta.requiresAuth && !token){
    next('/login');
  } else {
    next();
  }
})

export default router
