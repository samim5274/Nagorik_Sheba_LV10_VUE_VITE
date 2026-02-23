<template>
  <div class="min-h-screen bg-[#111827] text-white flex items-center justify-center p-6">
    <Message
        :successMsg="successMsg"
        :errorMsg="errorMsg"
        @update:successMsg="successMsg = $event"
        @update:errorMsg="errorMsg = $event"
    />
    <div class="w-full max-w-md bg-[#111939] rounded-2xl shadow-2xl p-8">

      <!-- Title -->
      <h2 class="text-2xl font-bold text-slate-100 text-center">
        User Registration
      </h2>

      <div v-if="generalError" class="mt-4 rounded-xl bg-red-50 text-red-700 px-4 py-3 text-sm">
        {{ generalError }}
      </div>

      <form @submit.prevent="submitRegister" class="mt-6 space-y-5">

        <!-- Name -->
        <div class="space-y-1">
          <label class="text-sm font-medium text-slate-200">Full Name</label>
          <div class="relative">
            <input
              type="text"
              v-model.trim="form.name"
              required
              class="w-full rounded-xl border border-slate-700 bg-[#0b1220] px-4 py-3 text-slate-100 placeholder:text-slate-500 outline-none transition
                    focus:border-indigo-500 focus:ring-4 focus:ring-indigo-500/20"
              placeholder="Enter your name"
            />
            <span class="pointer-events-none absolute inset-y-0 right-4 flex items-center text-slate-600">
              <i class="fa-regular fa-user"></i>
            </span>
          </div>
          <p v-if="errors.name" class="text-xs text-red-400">
            {{ errors.name[0] }}
          </p>
        </div>

        <!-- Email -->
        <div class="space-y-1">
          <label class="text-sm font-medium text-slate-200">Email</label>
          <div class="relative">
            <input
              type="email"
              v-model.trim="form.email"
              required
              class="w-full rounded-xl border border-slate-700 bg-[#0b1220] px-4 py-3 text-slate-100 placeholder:text-slate-500 outline-none transition
                    focus:border-indigo-500 focus:ring-4 focus:ring-indigo-500/20"
              placeholder="example@mail.com"
            />
            <span class="pointer-events-none absolute inset-y-0 right-4 flex items-center text-slate-600">
              <i class="fa-regular fa-envelope"></i>
            </span>
          </div>

          <p v-if="errors.email" class="text-xs text-red-400">
            {{ errors.email[0] }}
          </p>
        </div>

        <!-- Password -->
        <div class="space-y-1">
          <label class="text-sm font-medium text-slate-200">Password</label>

          <div class="relative">
            <input
              :type="showPassword ? 'text' : 'password'"
              v-model="form.password"
              required
              class="w-full rounded-xl border border-slate-700 bg-[#0b1220] px-4 py-3 pr-12 text-slate-100 placeholder:text-slate-500 outline-none transition
                    focus:border-indigo-500 focus:ring-4 focus:ring-indigo-500/20"
              placeholder="********"
            />

            <!-- Eye -->
            <button
              type="button"
              @click="showPassword = !showPassword"
              class="absolute inset-y-0 right-3 my-auto h-10 w-10 rounded-lg grid place-items-center text-slate-400 transition
                    hover:bg-white/5 hover:text-indigo-300 focus:outline-none focus:ring-2 focus:ring-indigo-500/30"
              :aria-label="showPassword ? 'Hide password' : 'Show password'"
            >
              <i :class="showPassword ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye'"></i>
            </button>
          </div>

          <p v-if="errors.password" class="text-xs text-red-400">
            {{ errors.password[0] }}
          </p>

          <!-- Optional helper text -->
          <p class="text-xs text-slate-500">
            Use 8+ characters with letters & numbers.
          </p>
        </div>

        <!-- Confirm Password -->
        <div class="space-y-1">
          <label class="text-sm font-medium text-slate-200">Confirm Password</label>

          <div class="relative">
            <input
              :type="showConfirmPassword ? 'text' : 'password'"
              v-model="form.password_confirmation"
              required
              class="w-full rounded-xl border border-slate-700 bg-[#0b1220] px-4 py-3 pr-12 text-slate-100 placeholder:text-slate-500 outline-none transition
                    focus:border-indigo-500 focus:ring-4 focus:ring-indigo-500/20"
              placeholder="********"
            />

            <button
              type="button"
              @click="showConfirmPassword = !showConfirmPassword"
              class="absolute inset-y-0 right-3 my-auto h-10 w-10 rounded-lg grid place-items-center text-slate-400 transition
                    hover:bg-white/5 hover:text-indigo-300 focus:outline-none focus:ring-2 focus:ring-indigo-500/30"
              :aria-label="showConfirmPassword ? 'Hide confirm password' : 'Show confirm password'"
            >
              <i :class="showConfirmPassword ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye'"></i>
            </button>
          </div>

          <p v-if="errors.password_confirmation" class="text-xs text-red-400">
            {{ errors.password_confirmation[0] }}
          </p>
        </div>

        <!-- Button -->
        <button
          type="submit"
          :disabled="loading"
          class="w-full rounded-xl bg-indigo-600 py-3 font-semibold text-white transition
                hover:bg-indigo-700 focus:outline-none focus:ring-4 focus:ring-indigo-500/30
                disabled:cursor-not-allowed disabled:opacity-60"
        >
          <span v-if="!loading">Register</span>
          <span v-else class="inline-flex items-center gap-2">
            <span class="h-4 w-4 animate-spin rounded-full border-2 border-white/40 border-t-white"></span>
            Creating...
          </span>
        </button>

        <!-- Login Link -->
        <p class="text-center text-sm text-slate-300">
          Already have an account?
          <router-link
            to="/login"
            class="font-semibold text-indigo-300 hover:text-indigo-200 hover:underline"
          >
            Login
          </router-link>
        </p>

      </form>

    <div class="flex items-center gap-3 my-6">
      <div class="h-px w-full bg-[#26314a]"></div>
      <span class="text-xs text-gray-400">OR</span>
      <div class="h-px w-full bg-[#26314a]"></div>
    </div>

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

    </div>
  </div>
</template>



<script setup>
import { reactive, ref } from "vue";
import { useRouter } from "vue-router";
import api from "../../services/api";
import Message from '../Message/message.vue'

const router = useRouter();

const loading = ref(false);
const generalError = ref("");
const errors = reactive({});

const successMsg = ref("");
const errorMsg = ref("");

const showPassword = ref(false);
const showConfirmPassword = ref(false);

const form = reactive({
  name: "",
  email: "",
  password: "",
  password_confirmation: "",
});

// message clear
function resetErrors(){
  generalError.value = "";
  Object.keys(errors).forEach((k) => delete errors[k]);
}

// form submit
async function submitRegister(){
  resetErrors();
  loading.value = true;
  errors.value = {};
  successMsg.value = "";
  errorMsg.value = "";

  try{
    // data send backend
    await api.post("/register", {
      name: form.name,
      email: form.email,
      password: form.password,
      password_confirmation: form.password_confirmation,
    });
    successMsg.value = "Account created successfully.";
    resetForm(); // clear inputs
    resetErrors(); // optional: old validation error remove
    //router.push("/login");
  } catch (err){
    console.log(err?.response?.data);
    if(err?.response?.status === 422){
      const v = err.response.data.errors || {};
      Object.assign(errors, v);
      generalError.value = err.response.data.message | "Validation error";
    } else {
      generalError.value = err?.response?.data?.message | "Somethins went wrong..!";
    }
  } finally {
    loading.value = false;
  }
}

// reset form
function resetForm(){
  form.name = "";
  form.email = "";
  form.password = "";
  form.password_confirmation = "";
}
</script>



<style>

</style>