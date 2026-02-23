<template>
  <section class="min-h-screen bg-[#111827] text-white flex items-center justify-center px-4 py-10">
    <Message
        :successMsg="successMsg"
        :errorMsg="errorMsg"
        @update:successMsg="successMsg = $event"
        @update:errorMsg="errorMsg = $event"
    />
    <div class="w-full max-w-4xl grid md:grid-cols-2 gap-6">
      <!-- Left: Intro -->
      <div class="hidden md:flex flex-col justify-center rounded-2xl p-8 border border-[#111a3e] bg-[#0f172a]">
        <h2 class="text-4xl font-bold leading-tight">
          Welcome back<span class="text-transparent bg-clip-text bg-gradient-to-r from-[#A3D921] to-[#046425]">.</span>
        </h2>
        <p class="text-gray-300 mt-4">
          Sign in to continue. Secure access, fast login, and modern UI.
        </p>

        <div class="mt-8 space-y-3 text-sm text-gray-300">
          <div class="flex items-center gap-3">
            <span class="w-2 h-2 rounded-full bg-[#A3D921]"></span>
            <span>Clean & responsive design</span>
          </div>
          <div class="flex items-center gap-3">
            <span class="w-2 h-2 rounded-full bg-[#A3D921]"></span>
            <span>Social sign-in options</span>
          </div>
          <div class="flex items-center gap-3">
            <span class="w-2 h-2 rounded-full bg-[#A3D921]"></span>
            <span>Remember me & password reset</span>
          </div>
        </div>
      </div>

      <!-- Right: Form -->
      <div class="rounded-2xl border border-[#111a3e] bg-[#111a3e]/80 backdrop-blur p-6 sm:p-8">
        <div class="flex items-center justify-between">
          <h3 class="text-2xl font-bold">Login</h3>
          <span class="text-xs text-gray-300">Secure</span>
        </div>

        <!-- Social Login -->
        <div class="mt-6 grid grid-cols-1 sm:grid-cols-3 gap-3">
          <button
            type="button"
            class="flex items-center justify-center gap-2 rounded-xl px-4 py-2.5 bg-[#0b1220] border border-[#1d2a4a] hover:border-[#A3D921] transition"
            @click="socialLogin('google')"
          >
            <i class="fa-brands fa-google"></i>
            <span class="text-sm">Google</span>
          </button>

          <button
            type="button"
            class="flex items-center justify-center gap-2 rounded-xl px-4 py-2.5 bg-[#0b1220] border border-[#1d2a4a] hover:border-[#A3D921] transition"
            @click="socialLogin('github')"
          >
            <i class="fa-brands fa-github"></i>
            <span class="text-sm">GitHub</span>
          </button>

          <button
            type="button"
            class="flex items-center justify-center gap-2 rounded-xl px-4 py-2.5 bg-[#0b1220] border border-[#1d2a4a] hover:border-[#A3D921] transition"
            @click="socialLogin('facebook')"
          >
            <i class="fa-brands fa-facebook"></i>
            <span class="text-sm">Facebook</span>
          </button>
        </div>

        <div class="flex items-center gap-3 my-6">
          <div class="h-px w-full bg-[#26314a]"></div>
          <span class="text-xs text-gray-400">OR</span>
          <div class="h-px w-full bg-[#26314a]"></div>
        </div>

        <!-- Login Form -->
        <form @submit.prevent="login" class="space-y-5">
          <!-- Email -->
          <div>
            <label for="email" class="block mb-2 text-sm font-medium">Email</label>
            <input
              v-model.trim="email"
              type="email"
              id="email"
              autocomplete="email"
              class="bg-[#111827] placeholder:text-[#9CA2A9] text-gray-100 text-sm rounded-lg block w-full p-2.5
                     focus:outline-none focus:ring-2 focus:ring-[#046425] border border-[#1d2a4a]"
              placeholder="you@example.com"
            />
            <p v-if="errors.email" class="text-xs text-red-400 mt-1">{{ errors.email[0] }}</p>
          </div>

          <!-- Password -->
          <div>
            <div class="flex items-center justify-between">
              <label for="password" class="block mb-2 text-sm font-medium">Password</label>
              <a href="#" class="text-xs text-gray-300 hover:text-[#A3D921]">Forgot password?</a>
            </div>

            <div class="relative">
              <input
                v-model="password"
                :type="showPassword ? 'text' : 'password'"
                id="password"
                autocomplete="current-password"
                class="bg-[#111827] placeholder:text-[#9CA2A9] text-gray-100 text-sm rounded-lg block w-full p-2.5 pr-10
                       focus:outline-none focus:ring-2 focus:ring-[#046425] border border-[#1d2a4a]"
                placeholder="Enter your password"
              />
              <button
                type="button"
                class="absolute inset-y-0 right-0 px-3 text-gray-300 hover:text-white"
                @click="showPassword = !showPassword"
                aria-label="Toggle password visibility"
              >
                <i :class="showPassword ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye'"></i>
              </button>
              <p v-if="errors.password" class="text-xs text-red-400 mt-1">{{ errors.password[0] }}</p>
            </div>
          </div>

          <!-- Remember + Terms -->
          <div class="flex items-center justify-between">
            <label class="flex items-center gap-2 text-sm text-gray-300 select-none">
              <input v-model="remember" type="checkbox" class="accent-[#A3D921]" />
              Remember me
            </label>
            <span class="text-xs text-gray-400">v1.0</span>
          </div>

          <!-- Submit -->
          <button
            type="submit"
            :disabled="loading"
            class="w-full px-6 py-3 rounded-full flex justify-center items-center font-semibold
                   text-white bg-[#046425] border-2 border-transparent
                   hover:bg-transparent hover:border-[#A3D921] hover:text-[#A3D921]
                   transition disabled:opacity-60 disabled:cursor-not-allowed"
          >
            {{ loading ? "Signing in..." : "Login" }}
          </button>

          <!-- Signup -->
          <p class="text-sm text-gray-300 text-center">
            Don’t have an account?
            <router-link to="/register" class="text-white hover:text-[#A3D921] underline">Create one</router-link>
          </p>
        </form>
      </div>
    </div>
  </section>
</template>

<script setup>
import { reactive, ref } from 'vue';
import { useRouter } from 'vue-router';
import api from '../../services/api';
import Message from '../Message/message.vue'

const router = useRouter();

const showPassword = ref(false);

const loading = ref(false);
const generalError = ref("");
const errors = reactive({});

const successMsg = ref("");
const errorMsg = ref("");

const email = ref("");
const password = ref("");
const remember = ref(false);

function resetErrors() {
  generalError.value = "";
  Object.keys(errors).forEach((k) => delete errors[k]);
}

function resetForm() {
  email.value = "";
  password.value = "";
  remember.value = false;
}

async function login() {
  resetErrors();
  loading.value = true;
  successMsg.value = "";
  errorMsg.value = "";

  // simple empty check
  if (!email.value || !password.value) {
    errorMsg.value = "Please insert email and password.";
    loading.value = false;
    return;
  }

  try{

    const res = await api.post("/login", {
      email: email.value,
      password: password.value,
      device_name: "web",
      remember: remember.value,
    });

    if (!res?.data?.token) {
      errorMsg.value = res?.data?.message || "Login failed!";
      return;
    }

    // save token
    localStorage.setItem("token", res.data.token);
    localStorage.setItem("user", JSON.stringify(res.data.user));

    successMsg.value = "Login successful";
    resetForm(); 
    setTimeout(() => router.push("/dashboard"), 400);
  } catch (err){
    const status = err?.response?.status;
    const data = err?.response?.data;

    if (status === 422) {
      Object.assign(errors, data?.errors || {});
      generalError.value = data?.message || "Validation error";
      errorMsg.value = "Please fix the highlighted errors.";
    } else {
      generalError.value = data?.message || "Something went wrong..!";
      errorMsg.value = generalError.value;
    }
  } finally {
    loading.value = false;
  }
}

function socialLogin(provider) {
    // TODO: Redirect to backend social auth route
    // window.location.href = `${import.meta.env.VITE_API_BASE_URL}/auth/${provider}/redirect`;
    // errorMsg.value = `🔗 Social login clicked: ${provider} (connect backend route)`;
    console.log("Social Login working in progress...");
}
</script>